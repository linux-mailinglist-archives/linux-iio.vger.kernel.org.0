Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E963FF56F
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbhIBVPq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:46 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57241 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346729AbhIBVPm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:42 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6C84E24000B;
        Thu,  2 Sep 2021 21:14:42 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 05/16] iio: adc: max1027: Minimize the number of converted channels
Date:   Thu,  2 Sep 2021 23:14:26 +0200
Message-Id: <20210902211437.503623-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide a list of ->available_scan_masks which match the device's
capabilities. Basically, the devices is able to scan from 0 to N, N
being the highest voltage channel requested by the user. The temperature
can be included or not, but cannot be retrieved alone.

The consequence is, instead of reading and pushing to the IIO buffers
all channels each time, the "minimum" number of channels will be scanned
and pushed based on the ->active_scan_mask.

For example, if the user wants channels 1, 4 and 5, all channels from
0 to 5 will be scanned and pushed to the IIO buffers. The core will then
filter out the unneeded samples based on the ->active_scan_mask that has
been selected and only channels 1, 4 and 5 will be available to the user
in the shared buffer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 46 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 1167d50c1d67..3c41d2c0ed2a 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -172,18 +172,39 @@ static const struct iio_chan_spec max1231_channels[] = {
 	MAX1X31_CHANNELS(12),
 };
 
+#define MAX1X27_SCAN_MASK_TEMP BIT(0)
+
+#define MAX1X27_SCAN_MASKS(temp)					\
+	GENMASK(1, 1 - (temp)), GENMASK(2, 1 - (temp)),			\
+	GENMASK(3, 1 - (temp)), GENMASK(4, 1 - (temp)),			\
+	GENMASK(5, 1 - (temp)), GENMASK(6, 1 - (temp)),			\
+	GENMASK(7, 1 - (temp)), GENMASK(8, 1 - (temp))
+
+#define MAX1X29_SCAN_MASKS(temp)					\
+	MAX1X27_SCAN_MASKS(temp),					\
+	GENMASK(9, 1 - (temp)), GENMASK(10, 1 - (temp)),		\
+	GENMASK(11, 1 - (temp)), GENMASK(12, 1 - (temp))
+
+#define MAX1X31_SCAN_MASKS(temp)					\
+	MAX1X29_SCAN_MASKS(temp),					\
+	GENMASK(13, 1 - (temp)), GENMASK(14, 1 - (temp)),		\
+	GENMASK(15, 1 - (temp)), GENMASK(16, 1 - (temp))
+
 static const unsigned long max1027_available_scan_masks[] = {
-	0x000001ff,
+	MAX1X27_SCAN_MASKS(0),
+	MAX1X27_SCAN_MASKS(1),
 	0x00000000,
 };
 
 static const unsigned long max1029_available_scan_masks[] = {
-	0x00001fff,
+	MAX1X29_SCAN_MASKS(0),
+	MAX1X29_SCAN_MASKS(1),
 	0x00000000,
 };
 
 static const unsigned long max1031_available_scan_masks[] = {
-	0x0001ffff,
+	MAX1X31_SCAN_MASKS(0),
+	MAX1X31_SCAN_MASKS(1),
 	0x00000000,
 };
 
@@ -368,9 +389,15 @@ static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
 		if (ret < 0)
 			return ret;
 
-		/* Scan from 0 to max */
-		st->reg = MAX1027_CONV_REG | MAX1027_CHAN(0) |
-			  MAX1027_SCAN_N_M | MAX1027_TEMP;
+		/*
+		 * Scan from chan 0 to the highest requested channel.
+		 * Include temperature on demand.
+		 */
+		st->reg = MAX1027_CONV_REG | MAX1027_SCAN_0_N;
+		st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);
+		if (*indio_dev->active_scan_mask & MAX1X27_SCAN_MASK_TEMP)
+			st->reg |= MAX1027_TEMP;
+
 		ret = spi_write(st->spi, &st->reg, 1);
 		if (ret < 0)
 			return ret;
@@ -391,9 +418,14 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max1027_state *st = iio_priv(indio_dev);
+	unsigned int scanned_chans;
+
+	scanned_chans = fls(*indio_dev->active_scan_mask) - 1;
+	if (*indio_dev->active_scan_mask & MAX1X27_SCAN_MASK_TEMP)
+		scanned_chans++;
 
 	/* fill buffer with all channel */
-	spi_read(st->spi, st->buffer, indio_dev->masklength * 2);
+	spi_read(st->spi, st->buffer, scanned_chans * 2);
 
 	iio_push_to_buffers(indio_dev, st->buffer);
 
-- 
2.27.0

