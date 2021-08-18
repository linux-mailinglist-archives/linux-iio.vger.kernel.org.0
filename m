Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0103F0255
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhHRLM0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:26 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36135 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhHRLMU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:20 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5C9D760010;
        Wed, 18 Aug 2021 11:11:45 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 08/16] iio: adc: max1027: Explain better how the trigger state gets changed
Date:   Wed, 18 Aug 2021 13:11:31 +0200
Message-Id: <20210818111139.330636-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It may appear strange to configure the trigger to start upon register
write while we want to disable the trigger. Explain why we do this in
the comment.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 59914fcfd320..4a78c9cbc339 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -401,7 +401,12 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 		if (ret < 0)
 			return ret;
 	} else {
-		/* Start acquisition on conversion register write */
+		/*
+		 * Start acquisition on conversion register write, which
+		 * basically disables triggering conversions upon cnvst changes
+		 * and thus has the effect of disabling the external hardware
+		 * trigger.
+		 */
 		ret = max1027_configure_trigger(indio_dev);
 		if (ret)
 			return ret;
-- 
2.27.0

