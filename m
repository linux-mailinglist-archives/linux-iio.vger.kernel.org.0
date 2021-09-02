Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C423FF575
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbhIBVPt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:49 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:45861 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347021AbhIBVPr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:47 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 51B3B240011;
        Thu,  2 Sep 2021 21:14:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 11/16] iio: adc: max1027: Prevent single channel accesses during buffer reads
Date:   Thu,  2 Sep 2021 23:14:32 +0200
Message-Id: <20210902211437.503623-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When hardware buffers are enabled (the cnvst pin being the trigger), one
should not mess with the device state by requesting a single channel
read.

There is already a iio_buffer_enabled() check in *_read_single_value()
to merely prevent this situation but the check is inconsistent since
buffers can be enabled after the if clause anyway. Instead, use the core
mutex by calling iio_device_claim/release_direct_mode().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index f4cb5c75604b..57f62ea2d7aa 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -296,10 +296,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 	int ret;
 	struct max1027_state *st = iio_priv(indio_dev);
 
-	if (iio_buffer_enabled(indio_dev)) {
-		dev_warn(&indio_dev->dev, "trigger mode already enabled");
-		return -EBUSY;
-	}
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
 	/* Configure conversion register with the requested chan */
 	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
@@ -325,6 +324,8 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
+	iio_device_release_direct_mode(indio_dev);
+
 	*val = be16_to_cpu(st->buffer[0]);
 
 	return IIO_VAL_INT;
-- 
2.27.0

