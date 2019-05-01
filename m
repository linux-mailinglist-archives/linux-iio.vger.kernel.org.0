Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A645F10E75
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2019 23:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfEAVRp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 May 2019 17:17:45 -0400
Received: from secvs01.rockwellcollins.com ([205.175.225.240]:64199 "EHLO
        secvs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfEAVRp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 May 2019 17:17:45 -0400
Received: from ofwgwc03.rockwellcollins.com (HELO crulimr01.rockwellcollins.com) ([205.175.225.12])
  by secvs01.rockwellcollins.com with ESMTP; 01 May 2019 16:17:43 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by crulimr01.rockwellcollins.com (Postfix) with ESMTP id 7B288600D0;
        Wed,  1 May 2019 16:17:43 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH 5/6] iio: ad7949: Fix SPI interfacing for 14-bit messages
Date:   Wed,  1 May 2019 16:17:02 -0500
Message-Id: <1556745423-11368-5-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
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
 drivers/iio/adc/ad7949.c | 97 ++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 1d75fff698d1..dc1ae4c143b0 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -18,6 +18,7 @@
 #define AD7949_OFFSET_CHANNEL_SEL	7
 #define AD7949_CFG_READ_BACK		0x1
 #define AD7949_CFG_REG_SIZE_BITS	14
+#define AD7949_BUFFER_LEN 4
 
 enum {
 	ID_AD7949 = 0,
@@ -71,7 +72,7 @@ struct ad7949_adc_chip {
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
-	u32 buffer ____cacheline_aligned;
+	u8 buffer[AD7949_BUFFER_LEN] ____cacheline_aligned;
 };
 
 static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
@@ -82,41 +83,40 @@ static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
 	return false;
 }
 
-static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
-{
-	int ret = ad7949_adc->resolution;
-
-	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
-		ret += AD7949_CFG_REG_SIZE_BITS;
-
-	return ret;
-}
-
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
-	ad7949_adc->buffer = ad7949_adc->cfg << shift;
-	spi_message_init_with_transfers(&msg, tx, 1);
-	ret = spi_sync(ad7949_adc->spi, &msg);
+	struct spi_transfer tx;
+	u16 tmp_cfg = 0;
+
+	(void)memset(&tx, 0, sizeof(tx));
+	(void)memset(ad7949_adc->buffer, 0, AD7949_BUFFER_LEN);
+
+	tmp_cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
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
+		tx.len = ad7949_spi_cfg_is_read_back(ad7949_adc) ? 4 : 2;
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
 
@@ -124,16 +124,10 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
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
 				   channel << AD7949_OFFSET_CHANNEL_SEL,
@@ -141,24 +135,29 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	if (ret)
 		return ret;
 
-	ad7949_adc->buffer = 0;
-	spi_message_init_with_transfers(&msg, tx, 1);
+	(void)memset(&tx, 0, sizeof(tx));
+	(void)memset(ad7949_adc->buffer, 0, AD7949_BUFFER_LEN);
+
+	tx.rx_buf = ad7949_adc->buffer;
+	tx.len = ad7949_spi_cfg_is_read_back(ad7949_adc) ? 4 : 2;
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
+	if (ad7949_adc->resolution == 14) {
+		/* 14-bit value in 16-bit buffer */
+		*val = *val >> 2;
+	}
 
 	return 0;
 }
-- 
1.9.1

