Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5D4132F5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 13:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhIUL4A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 07:56:00 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56015 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhIULzp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 07:55:45 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8844A24000F;
        Tue, 21 Sep 2021 11:54:14 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 07/16] iio: adc: max1027: Simplify the _set_trigger_state() helper
Date:   Tue, 21 Sep 2021 13:53:59 +0200
Message-Id: <20210921115408.66711-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210921115408.66711-1-miquel.raynal@bootlin.com>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The call to max1027_enable_trigger() is the same in both cases thanks to
the 'state' variable, so factorize a little bit to simplify the code and
explain why we call this helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index d1a9ffa68c38..b7cc77c2c01d 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -409,11 +409,17 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 	struct max1027_state *st = iio_priv(indio_dev);
 	int ret;
 
+	/*
+	 * In order to disable the convst trigger, start acquisition on
+	 * conversion register write, which basically disables triggering
+	 * conversions upon cnvst changes and thus has the effect of disabling
+	 * the external hardware trigger.
+	 */
+	ret = max1027_enable_trigger(indio_dev, state);
+	if (ret)
+		return ret;
+
 	if (state) {
-		ret = max1027_enable_trigger(indio_dev, state);
-		if (ret)
-			return ret;
-
 		/*
 		 * Scan from chan 0 to the highest requested channel.
 		 * Include temperature on demand.
@@ -426,11 +432,6 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 		ret = spi_write(st->spi, &st->reg, 1);
 		if (ret < 0)
 			return ret;
-	} else {
-		/* Start acquisition on conversion register write */
-		ret = max1027_enable_trigger(indio_dev, state);
-		if (ret)
-			return ret;
 	}
 
 	return 0;
-- 
2.27.0

