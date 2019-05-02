Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03DE11FE1
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2019 18:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfEBQOp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 May 2019 12:14:45 -0400
Received: from ch3vs02.rockwellcollins.com ([205.175.226.29]:50354 "EHLO
        ch3vs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfEBQOo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 May 2019 12:14:44 -0400
Received: from ofwch3n02.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.226.14])
  by ch3vs02.rockwellcollins.com with ESMTP; 02 May 2019 11:14:44 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 98F7820079;
        Thu,  2 May 2019 11:14:43 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH v2 5/6] iio: ad7949: Fix SPI interfacing for 14-bit messages
Date:   Thu,  2 May 2019 11:14:31 -0500
Message-Id: <1556813672-49861-5-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD7949 (but not the other two models supported by this driver) uses
samples 14 bits wide. When attempting to communicate through certain SPI
controllers that require power-of-2 word widths, this fails. Adding
logic to pack the 14-bit messages into the most-significant bits of a
16-bit message for communicating over byte-based SPI bus.

Only able to test with AD7949 part, but should support the 16-bit
samples of the AD7682 and AD7689, as well.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
	V2: Add some defines to reduce use of magic numbers.
---
 drivers/iio/adc/ad7949.c | 106 +++++++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 7820e1097787..cba152151908 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -33,6 +33,11 @@
 #define AD7949_CFG_READBACK_DIS            1
 #define AD7949_CFG_READBACK_MASK           GENMASK(0, 0)
 
+#define AD7949_BUFFER_LEN 4
+
+#define AD7949_HI_RESOLUTION 16
+#define AD7949_LO_RESOLUTION 14
+
 enum {
 	ID_AD7949 = 0,
 	ID_AD7682,
@@ -57,9 +62,9 @@ struct ad7949_adc_spec {
 };
 
 static const struct ad7949_adc_spec ad7949_adc_spec[] = {
-	[ID_AD7949] = { .num_channels = 8, .resolution = 14 },
-	[ID_AD7682] = { .num_channels = 4, .resolution = 16 },
-	[ID_AD7689] = { .num_channels = 8, .resolution = 16 },
+	[ID_AD7949] = { .num_channels = 8, .resolution = AD7949_LO_RESOLUTION },
+	[ID_AD7682] = { .num_channels = 4, .resolution = AD7949_HI_RESOLUTION },
+	[ID_AD7689] = { .num_channels = 8, .resolution = AD7949_HI_RESOLUTION },
 };
 
 /**
@@ -85,7 +90,7 @@ struct ad7949_adc_chip {
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
-	u32 buffer ____cacheline_aligned;
+	u8 buffer[AD7949_BUFFER_LEN] ____cacheline_aligned;
 };
 
 static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
@@ -96,41 +101,51 @@ static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
 	return false;
 }
 
-static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
+static int ad7949_message_len(struct ad7949_adc_chip *ad7949_adc)
 {
-	int ret = ad7949_adc->resolution;
+	int tx_len = 2;
 
 	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
-		ret += AD7949_CFG_REG_SIZE_BITS;
+		tx_len += 2;
 
-	return ret;
+	return tx_len;
 }
 
 static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 				u16 mask)
 {
-	int ret;
-	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
-	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
+	int ret = 0;
 	struct spi_message msg;
-	struct spi_transfer tx[] = {
-		{
-			.tx_buf = &ad7949_adc->buffer,
-			.len = 4,
-			.bits_per_word = bits_per_word,
-		},
-	};
-
-	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
-	ad7949_adc->buffer = (ad7949_adc->cfg & AD7949_CFG_MASK_TOTAL) << shift;
-	spi_message_init_with_transfers(&msg, tx, 1);
-	ret = spi_sync(ad7949_adc->spi, &msg);
+	struct spi_transfer tx;
+	u16 tmp_cfg = 0;
+
+	(void)memset(&tx, 0, sizeof(tx));
+	(void)memset(ad7949_adc->buffer, 0, AD7949_BUFFER_LEN);
+
+	tmp_cfg = ((val & mask) | (ad7949_adc->cfg & ~mask)) &
+		AD7949_CFG_MASK_TOTAL;
+
+	if (tmp_cfg != ad7949_adc->cfg) {
+		ad7949_adc->cfg = tmp_cfg;
+
+		/* Pack 14-bit value into 2 bytes, MSB first */
+		ad7949_adc->buffer[0] = ((ad7949_adc->cfg & 0x7f00) >> 6) |
+			((ad7949_adc->cfg & 0xc0) >> 6);
+		ad7949_adc->buffer[1] = (ad7949_adc->cfg & 0x007f) << 2;
+
+		tx.tx_buf = ad7949_adc->buffer;
+		tx.len = ad7949_message_len(ad7949_adc);
+
+		spi_message_init_with_transfers(&msg, &tx, 1);
+		ret = spi_sync(ad7949_adc->spi, &msg);
+
+		/*
+		 * This delay is to avoid a new request before the required
+		 * time to send a new command to the device
+		 */
+		udelay(2);
+	}
 
-	/*
-	 * This delay is to avoid a new request before the required time to
-	 * send a new command to the device
-	 */
-	udelay(2);
 	return ret;
 }
 
@@ -138,16 +153,10 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 				   unsigned int channel)
 {
 	int ret;
-	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
-	int mask = GENMASK(ad7949_adc->resolution, 0);
 	struct spi_message msg;
-	struct spi_transfer tx[] = {
-		{
-			.rx_buf = &ad7949_adc->buffer,
-			.len = 4,
-			.bits_per_word = bits_per_word,
-		},
-	};
+	struct spi_transfer tx;
+
+	ad7949_adc->current_channel = channel;
 
 	ret = ad7949_spi_write_cfg(ad7949_adc,
 				   channel << AD7949_CFG_CHAN_SEL_SHIFT,
@@ -155,24 +164,29 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	if (ret)
 		return ret;
 
-	ad7949_adc->buffer = 0;
-	spi_message_init_with_transfers(&msg, tx, 1);
+	(void)memset(&tx, 0, sizeof(tx));
+	(void)memset(ad7949_adc->buffer, 0, AD7949_BUFFER_LEN);
+
+	tx.rx_buf = ad7949_adc->buffer;
+	tx.len = ad7949_message_len(ad7949_adc);
+
+	spi_message_init_with_transfers(&msg, &tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 	if (ret)
 		return ret;
 
 	/*
-	 * This delay is to avoid a new request before the required time to
-	 * send a new command to the device
+	 * This delay is to avoid a new request before the required time
+	 * to send a new command to the device.
 	 */
 	udelay(2);
 
-	ad7949_adc->current_channel = channel;
+	*val = (ad7949_adc->buffer[0] << 8) | ad7949_adc->buffer[1];
 
-	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
-		*val = (ad7949_adc->buffer >> AD7949_CFG_REG_SIZE_BITS) & mask;
-	else
-		*val = ad7949_adc->buffer & mask;
+	if (ad7949_adc->resolution == AD7949_LO_RESOLUTION) {
+		/* 14-bit value in 16-bit buffer */
+		*val = *val >> 2;
+	}
 
 	return 0;
 }
-- 
1.9.1

