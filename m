Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319CC3F024D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhHRLMT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:19 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51527 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhHRLMR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:17 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EEA666000E;
        Wed, 18 Aug 2021 11:11:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 03/16] iio: adc: max1027: Push only the requested samples
Date:   Wed, 18 Aug 2021 13:11:26 +0200
Message-Id: <20210818111139.330636-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When a triggered scan occurs, the identity of the desired channels is
known in indio_dev->active_scan_mask. Instead of reading and pushing to
the IIO buffers all channels each time, scan the minimum amount of
channels (0 to maximum requested chan, to be exact) and only provide the
samples requested by the user.

For example, if the user wants channels 1, 4 and 5, all channels from
0 to 5 will be scanned but only the desired channels will be pushed to
the IIO buffers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index b753658bb41e..8ab660f596b5 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -360,6 +360,9 @@ static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
 	struct max1027_state *st = iio_priv(indio_dev);
 	int ret;
 
+	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
+		return -EINVAL;
+
 	if (state) {
 		/* Start acquisition on cnvst */
 		st->reg = MAX1027_SETUP_REG | MAX1027_CKS_MODE0 |
@@ -368,9 +371,12 @@ static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
 		if (ret < 0)
 			return ret;
 
-		/* Scan from 0 to max */
-		st->reg = MAX1027_CONV_REG | MAX1027_CHAN(0) |
-			  MAX1027_SCAN_N_M | MAX1027_TEMP;
+		/*
+		 * Scan from 0 to the highest requested channel. The temperature
+		 * could be avoided but it simplifies a bit the logic.
+		 */
+		st->reg = MAX1027_CONV_REG | MAX1027_SCAN_0_N | MAX1027_TEMP;
+		st->reg |= MAX1027_CHAN(fls(*indio_dev->active_scan_mask) - 2);
 		ret = spi_write(st->spi, &st->reg, 1);
 		if (ret < 0)
 			return ret;
@@ -391,11 +397,22 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max1027_state *st = iio_priv(indio_dev);
+	unsigned int scanned_chans = fls(*indio_dev->active_scan_mask);
+	u16 *buf = st->buffer;
+	unsigned int bit;
 
 	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq, private);
 
 	/* fill buffer with all channel */
-	spi_read(st->spi, st->buffer, indio_dev->masklength * 2);
+	spi_read(st->spi, st->buffer, scanned_chans * 2);
+
+	/* Only keep the channels selected by the user */
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		if (buf[0] != st->buffer[bit])
+			buf[0] = st->buffer[bit];
+		buf++;
+	}
 
 	iio_push_to_buffers(indio_dev, st->buffer);
 
-- 
2.27.0

