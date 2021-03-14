Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2533A76F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCNSSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233756AbhCNSRt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59C0764EC6;
        Sun, 14 Mar 2021 18:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745868;
        bh=E53hIdKRb8Dd4ROJiBvu6c2aXoH+4ktpcXXI5NAwmZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBEIcToVsfUasA0cbCakdHup7nNvDXAm1OAlRIm8cJJ/HCtv7W/wmWpBYcKFHWrTQ
         /GB8zk6/WPJ8iteX7eUv+x67W4396WbB2r55NEmM5R2jstENw4fxl3VnC+pFV7pR+r
         kTMsl4NztlkZ+VEo6AdgJ83jvDEZGJFeLDVqFzdoajvOE+WbLyZNgyGBIaT5ZfTZQ4
         JOIcskTZlvnkUODb9PM8ywdYn/fNSH9iYynYv2bNChygM7K30Po0b4KPDrB+mmg3xl
         b3HNmtPyRQDc99shOxzycQXK4JOhScsCCiUqxFCF+E12UWkaHPpcGJ4ssYDUH+gLDm
         ZQu95uB0g6hzQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 13/24] staging:iio:cdc:ad7150: More consistent register and field naming
Date:   Sun, 14 Mar 2021 18:15:00 +0000
Message-Id: <20210314181511.531414-14-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add _REG postfix to register addresses to avoid confusion with
fields.  Also add additional field defines and use throughout the
driver in place of magic numbers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-14-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 129 +++++++++++++++----------------
 1 file changed, 61 insertions(+), 68 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 24be97456c03..99125abb889b 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -21,37 +21,38 @@
  * AD7150 registers definition
  */
 
-#define AD7150_STATUS              0
-#define AD7150_STATUS_OUT1         BIT(3)
-#define AD7150_STATUS_OUT2         BIT(5)
-#define AD7150_CH1_DATA_HIGH       1
-#define AD7150_CH2_DATA_HIGH       3
-#define AD7150_CH1_AVG_HIGH        5
-#define AD7150_CH2_AVG_HIGH        7
-#define AD7150_CH1_SENSITIVITY     9
-#define AD7150_CH1_THR_HOLD_H      9
-#define AD7150_CH1_TIMEOUT         10
-#define AD7150_CH1_SETUP           11
-#define AD7150_CH2_SENSITIVITY     12
-#define AD7150_CH2_THR_HOLD_H      12
-#define AD7150_CH2_TIMEOUT         13
-#define AD7150_CH2_SETUP           14
-#define AD7150_CFG                 15
-#define AD7150_CFG_FIX             BIT(7)
-#define AD7150_PD_TIMER            16
-#define AD7150_CH1_CAPDAC          17
-#define AD7150_CH2_CAPDAC          18
-#define AD7150_SN3                 19
-#define AD7150_SN2                 20
-#define AD7150_SN1                 21
-#define AD7150_SN0                 22
-#define AD7150_ID                  23
-
-/* AD7150 masks */
-#define AD7150_THRESHTYPE_MSK			GENMASK(6, 5)
-
-#define AD7150_CH_TIMEOUT_RECEDING		GENMASK(3, 0)
-#define AD7150_CH_TIMEOUT_APPROACHING		GENMASK(7, 4)
+#define AD7150_STATUS_REG		0
+#define   AD7150_STATUS_OUT1		BIT(3)
+#define   AD7150_STATUS_OUT2		BIT(5)
+#define AD7150_CH1_DATA_HIGH_REG	1
+#define AD7150_CH2_DATA_HIGH_REG	3
+#define AD7150_CH1_AVG_HIGH_REG		5
+#define AD7150_CH2_AVG_HIGH_REG		7
+#define AD7150_CH1_SENSITIVITY_REG	9
+#define AD7150_CH1_THR_HOLD_H_REG	9
+#define AD7150_CH1_TIMEOUT_REG		10
+#define   AD7150_CH_TIMEOUT_RECEDING	GENMASK(3, 0)
+#define   AD7150_CH_TIMEOUT_APPROACHING	GENMASK(7, 4)
+#define AD7150_CH1_SETUP_REG		11
+#define AD7150_CH2_SENSITIVITY_REG	12
+#define AD7150_CH2_THR_HOLD_H_REG	12
+#define AD7150_CH2_TIMEOUT_REG		13
+#define AD7150_CH2_SETUP_REG		14
+#define AD7150_CFG_REG			15
+#define   AD7150_CFG_FIX		BIT(7)
+#define   AD7150_CFG_THRESHTYPE_MSK	GENMASK(6, 5)
+#define   AD7150_CFG_TT_NEG		0x0
+#define   AD7150_CFG_TT_POS		0x1
+#define   AD7150_CFG_TT_IN_WINDOW	0x2
+#define   AD7150_CFG_TT_OUT_WINDOW	0x3
+#define AD7150_PD_TIMER_REG		16
+#define AD7150_CH1_CAPDAC_REG		17
+#define AD7150_CH2_CAPDAC_REG		18
+#define AD7150_SN3_REG			19
+#define AD7150_SN2_REG			20
+#define AD7150_SN1_REG			21
+#define AD7150_SN0_REG			22
+#define AD7150_ID_REG			23
 
 enum {
 	AD7150,
@@ -93,12 +94,12 @@ struct ad7150_chip_info {
  */
 
 static const u8 ad7150_addresses[][6] = {
-	{ AD7150_CH1_DATA_HIGH, AD7150_CH1_AVG_HIGH,
-	  AD7150_CH1_SETUP, AD7150_CH1_THR_HOLD_H,
-	  AD7150_CH1_SENSITIVITY, AD7150_CH1_TIMEOUT },
-	{ AD7150_CH2_DATA_HIGH, AD7150_CH2_AVG_HIGH,
-	  AD7150_CH2_SETUP, AD7150_CH2_THR_HOLD_H,
-	  AD7150_CH2_SENSITIVITY, AD7150_CH2_TIMEOUT },
+	{ AD7150_CH1_DATA_HIGH_REG, AD7150_CH1_AVG_HIGH_REG,
+	  AD7150_CH1_SETUP_REG, AD7150_CH1_THR_HOLD_H_REG,
+	  AD7150_CH1_SENSITIVITY_REG, AD7150_CH1_TIMEOUT_REG },
+	{ AD7150_CH2_DATA_HIGH_REG, AD7150_CH2_AVG_HIGH_REG,
+	  AD7150_CH2_SETUP_REG, AD7150_CH2_THR_HOLD_H_REG,
+	  AD7150_CH2_SENSITIVITY_REG, AD7150_CH2_TIMEOUT_REG },
 };
 
 static int ad7150_read_raw(struct iio_dev *indio_dev,
@@ -147,11 +148,11 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	bool thrfixed;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 
-	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
 	if (ret < 0)
 		return ret;
 
-	threshtype = FIELD_GET(AD7150_THRESHTYPE_MSK, ret);
+	threshtype = FIELD_GET(AD7150_CFG_THRESHTYPE_MSK, ret);
 
 	/*check if threshold mode is fixed or adaptive*/
 	thrfixed = FIELD_GET(AD7150_CFG_FIX, ret);
@@ -159,12 +160,12 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	switch (type) {
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		if (dir == IIO_EV_DIR_RISING)
-			return !thrfixed && (threshtype == 0x1);
-		return !thrfixed && (threshtype == 0x0);
+			return !thrfixed && (threshtype == AD7150_CFG_TT_POS);
+		return !thrfixed && (threshtype == AD7150_CFG_TT_NEG);
 	case IIO_EV_TYPE_THRESH:
 		if (dir == IIO_EV_DIR_RISING)
-			return thrfixed && (threshtype == 0x1);
-		return thrfixed && (threshtype == 0x0);
+			return thrfixed && (threshtype == AD7150_CFG_TT_POS);
+		return thrfixed && (threshtype == AD7150_CFG_TT_NEG);
 	default:
 		break;
 	}
@@ -226,7 +227,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir, int state)
 {
-	u8 thresh_type, cfg, adaptive;
+	u8 thresh_type, cfg, fixed;
 	int ret;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	int rising = (dir == IIO_EV_DIR_RISING);
@@ -261,35 +262,27 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 		disable_irq(chip->interrupts[0]);
 		disable_irq(chip->interrupts[1]);
 
-		ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+		ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
 		if (ret < 0)
 			goto error_ret;
 
-		cfg = ret & ~((0x03 << 5) | BIT(7));
+		cfg = ret & ~(AD7150_CFG_THRESHTYPE_MSK | AD7150_CFG_FIX);
 
-		switch (type) {
-		case IIO_EV_TYPE_THRESH_ADAPTIVE:
-			adaptive = 1;
-			if (rising)
-				thresh_type = 0x1;
-			else
-				thresh_type = 0x0;
-			break;
-		case IIO_EV_TYPE_THRESH:
-			adaptive = 0;
-			if (rising)
-				thresh_type = 0x1;
-			else
-				thresh_type = 0x0;
-			break;
-		default:
-			ret = -EINVAL;
-			goto error_ret;
-		}
+		if (type == IIO_EV_TYPE_THRESH_ADAPTIVE)
+			fixed = 0;
+		else
+			fixed = 1;
+
+		if (rising)
+			thresh_type = AD7150_CFG_TT_POS;
+		else
+			thresh_type = AD7150_CFG_TT_NEG;
 
-		cfg |= (!adaptive << 7) | (thresh_type << 5);
+		cfg |= FIELD_PREP(AD7150_CFG_FIX, fixed) |
+			FIELD_PREP(AD7150_CFG_THRESHTYPE_MSK, thresh_type);
 
-		ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
+		ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG_REG,
+						cfg);
 		if (ret < 0)
 			goto error_ret;
 
@@ -480,7 +473,7 @@ static irqreturn_t __ad7150_event_handler(void *private, u8 status_mask,
 	s64 timestamp = iio_get_time_ns(indio_dev);
 	int int_status;
 
-	int_status = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
+	int_status = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS_REG);
 	if (int_status < 0)
 		return IRQ_HANDLED;
 
-- 
2.30.2

