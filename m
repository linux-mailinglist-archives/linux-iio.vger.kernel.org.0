Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ACE2F0454
	for <lists+linux-iio@lfdr.de>; Sun, 10 Jan 2021 00:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbhAIXNe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 18:13:34 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48941 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbhAIXNe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2021 18:13:34 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id F151B40008;
        Sat,  9 Jan 2021 23:12:46 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 5/6] iio:common:ms_sensors:ms_sensors_i2c: add support for alternative PROM layout
Date:   Sun, 10 Jan 2021 00:11:47 +0100
Message-Id: <20210109231148.1168104-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
References: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, only the 112bit PROM with 7 words is supported. However the ms58xx
family also have devices with a 128bit PROM on 8 words. See AN520:
C-CODE EXAMPLE FOR MS56XX, MS57XX (EXCEPT ANALOG SENSOR), AND MS58XX SERIES
PRESSURE SENSORS and the various device datasheets.

The difference is that the CRC is the 4 LSBs of word7 instead of being the
4 MSBs of word0.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes in v2:
 - Fix return value documentation for ms_sensors_tp_crc_valid_112 and
   ms_sensors_tp_crc_valid_128

 .../iio/common/ms_sensors/ms_sensors_i2c.c    | 70 ++++++++++++++++---
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 872f90459e2e..16ea697e945c 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -488,21 +488,18 @@ int ms_sensors_ht_read_humidity(struct ms_ht_dev *dev_data,
 EXPORT_SYMBOL(ms_sensors_ht_read_humidity);
 
 /**
- * ms_sensors_tp_crc_valid() - CRC check function for
+ * ms_sensors_tp_crc4() - Calculate PROM CRC for
  *     Temperature and pressure devices.
  *     This function is only used when reading PROM coefficients
  *
  * @prom:	pointer to PROM coefficients array
  *
- * Return: True if CRC is ok.
+ * Return: CRC.
  */
-static bool ms_sensors_tp_crc_valid(u16 *prom)
+static u8 ms_sensors_tp_crc4(u16 *prom)
 {
 	unsigned int cnt, n_bit;
-	u16 n_rem = 0x0000, crc_read = prom[0], crc = (*prom & 0xF000) >> 12;
-
-	prom[MS_SENSORS_TP_PROM_WORDS_NB - 1] = 0;
-	prom[0] &= 0x0FFF;      /* Clear the CRC computation part */
+	u16 n_rem = 0x0000;
 
 	for (cnt = 0; cnt < MS_SENSORS_TP_PROM_WORDS_NB * 2; cnt++) {
 		if (cnt % 2 == 1)
@@ -517,10 +514,55 @@ static bool ms_sensors_tp_crc_valid(u16 *prom)
 				n_rem <<= 1;
 		}
 	}
-	n_rem >>= 12;
-	prom[0] = crc_read;
 
-	return n_rem == crc;
+	return n_rem >> 12;
+}
+
+/**
+ * ms_sensors_tp_crc_valid_112() - CRC check function for
+ *     Temperature and pressure devices for 112bit PROM.
+ *     This function is only used when reading PROM coefficients
+ *
+ * @prom:	pointer to PROM coefficients array
+ *
+ * Return: True if CRC is ok.
+ */
+static bool ms_sensors_tp_crc_valid_112(u16 *prom)
+{
+	u16 w0 = prom[0], crc_read = (w0 & 0xF000) >> 12;
+	u8 crc;
+
+	prom[0] &= 0x0FFF;      /* Clear the CRC computation part */
+	prom[MS_SENSORS_TP_PROM_WORDS_NB - 1] = 0;
+
+	crc = ms_sensors_tp_crc4(prom);
+
+	prom[0] = w0;
+
+	return crc == crc_read;
+}
+
+/**
+ * ms_sensors_tp_crc_valid_128() - CRC check function for
+ *     Temperature and pressure devices for 128bit PROM.
+ *     This function is only used when reading PROM coefficients
+ *
+ * @prom:	pointer to PROM coefficients array
+ *
+ * Return: True if CRC is ok.
+ */
+static bool ms_sensors_tp_crc_valid_128(u16 *prom)
+{
+	u16 w7 = prom[7], crc_read = w7 & 0x000F;
+	u8 crc;
+
+	prom[7] &= 0xFF00;      /* Clear the CRC and LSB part */
+
+	crc = ms_sensors_tp_crc4(prom);
+
+	prom[7] = w7;
+
+	return crc == crc_read;
 }
 
 /**
@@ -535,6 +577,7 @@ static bool ms_sensors_tp_crc_valid(u16 *prom)
 int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 {
 	int i, ret;
+	bool valid;
 
 	for (i = 0; i < dev_data->hw->prom_len; i++) {
 		ret = ms_sensors_read_prom_word(
@@ -546,7 +589,12 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 			return ret;
 	}
 
-	if (!ms_sensors_tp_crc_valid(dev_data->prom)) {
+	if (dev_data->hw->prom_len == 8)
+		valid = ms_sensors_tp_crc_valid_128(dev_data->prom);
+	else
+		valid = ms_sensors_tp_crc_valid_112(dev_data->prom);
+
+	if (!valid) {
 		dev_err(&dev_data->client->dev,
 			"Calibration coefficients crc check error\n");
 		return -ENODEV;
-- 
2.29.2

