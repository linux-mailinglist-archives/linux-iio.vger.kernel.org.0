Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE80456CE5E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Jul 2022 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGJJTB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Jul 2022 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJJTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2022 05:19:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7EB7E;
        Sun, 10 Jul 2022 02:18:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z12so3514934wrq.7;
        Sun, 10 Jul 2022 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTUIQLG67q4L37zxmd4J6MTyL080A6Y33cHJDWComPQ=;
        b=l2bBD4BBuPz2950wQ1xfadfC4sTwSA7FbX+DnL7TNwCoSjzJoHb9IXSdRZYOfcBJGj
         zwh3b+b9oq14VKoBQNMWuraVKAbA5UIhmme6/GopYVfgZ8Ze38BeCGd80RaUvkmYm3pF
         oMvhDF2cMqBqMHB9L87kR2Gwe0Yj/ZUqQX8wiMR80bJziETPbm53dPBjyrSkJUwHTE1B
         M78+jqPpeQM5b7yg5PmEvMgbYhdP4Hf+HOqpri9BhhwbTlxDOI+QKZYP+ONPVWPhM/zz
         Xhcbw3q1U1X5t72bgcFoDJmVTEVbXQhziskfdGWaNqY3bM45bRZ7lLqqOKLKJJxP5geK
         vuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTUIQLG67q4L37zxmd4J6MTyL080A6Y33cHJDWComPQ=;
        b=dBZdK9ppQ0hMUVuCu/EXU01uGY3QBEmymSwdNEsxNvve2bxhPsO+0bWDO99WEnv0MD
         DfjLPoZXpz+Ac6rZcFOrhBGcUAp9rseGhPnhRb0JyCqz6lS4ySCcGWnnLrBuwi6NcdoP
         QxP+oJpbhBowN0DcHYJvgw4N56mH5EFjfYQxzxso7Fig0KHR4syp92pweWY4Xe40P4me
         tHv2Wz3OGp3Z6c//RjNgxdTXlhlLieKtPIvdubBzUXXWJRl5AWHH/+BwjIuLQ9aS8Q1T
         U7Tr/JKvFb7jrNUbkD5mtWMqIOgT0KuXpN1H3OAyIDl+aeKejKElHs6jgqOqhFKfLO9+
         7lEA==
X-Gm-Message-State: AJIora92PXpYYdSSVndHZ9wToj2js4NeyGMZzWdpJOEjjhwixKA4Qo0i
        SmoQVE7mu0mMzep3ORiyhUo=
X-Google-Smtp-Source: AGRyM1s8RMqIXFXUT8vFnNBm7zERbDjAmqmWOtRgKzXPzBK2GFCSXLypimIlWEdVVgtG1Xhkip2iaw==
X-Received: by 2002:adf:f3c7:0:b0:21d:9349:7a5 with SMTP id g7-20020adff3c7000000b0021d934907a5mr9420472wrp.23.1657444736364;
        Sun, 10 Jul 2022 02:18:56 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0021d83071683sm3192747wrp.64.2022.07.10.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 02:18:55 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] iio: pressure: bmp280: Add support for BMP380 sensor family
Date:   Sun, 10 Jul 2022 11:18:31 +0200
Message-Id: <20220710091837.16057-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds compatibility with the new generation of this sensor, the BMP380

Includes basic sensor initialization to do pressure and temp
measurements and allows tuning oversampling settings for each channel.

The compensation algorithms are adapted from the device datasheet and
the repository https://github.com/BoschSensortec/BMP3-Sensor-API

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/pressure/bmp280-core.c   | 356 +++++++++++++++++++++++++++
 drivers/iio/pressure/bmp280-i2c.c    |   5 +
 drivers/iio/pressure/bmp280-regmap.c |  55 +++++
 drivers/iio/pressure/bmp280-spi.c    |   5 +
 drivers/iio/pressure/bmp280.h        | 101 ++++++++
 5 files changed, 522 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 59e9c5fb4ab4..5d5d20d97cf6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -12,10 +12,13 @@
  * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
  * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
  * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
+ * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
  */
 
 #define pr_fmt(fmt) "bmp280: " fmt
 
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -29,6 +32,7 @@
 #include <linux/completion.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <asm/unaligned.h>
 
 #include "bmp280.h"
 
@@ -74,6 +78,24 @@ struct bmp280_calib {
 	s8  H6;
 };
 
+/* See datasheet Section 3.11.1. */
+struct bmp380_calib {
+	u16 T1;
+	u16 T2;
+	s8  T3;
+	s16 P1;
+	s16 P2;
+	s8  P3;
+	s8  P4;
+	u16 P5;
+	u16 P6;
+	s8  P7;
+	s8  P8;
+	s16 P9;
+	s8  P10;
+	s8  P11;
+};
+
 static const char *const bmp280_supply_names[] = {
 	"vddd", "vdda"
 };
@@ -90,6 +112,7 @@ struct bmp280_data {
 	union {
 		struct bmp180_calib bmp180;
 		struct bmp280_calib bmp280;
+		struct bmp380_calib bmp380;
 	} calib;
 	struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
 	unsigned int start_up_time; /* in microseconds */
@@ -138,6 +161,25 @@ struct bmp280_chip_info {
 enum { T1, T2, T3 };
 enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
 
+enum {
+	/* Temperature calib indexes */
+	BMP380_T1 = 0,
+	BMP380_T2 = 2,
+	BMP380_T3 = 4,
+	/* Pressure calib indexes */
+	BMP380_P1 = 5,
+	BMP380_P2 = 7,
+	BMP380_P3 = 9,
+	BMP380_P4 = 10,
+	BMP380_P5 = 11,
+	BMP380_P6 = 13,
+	BMP380_P7 = 15,
+	BMP380_P8 = 16,
+	BMP380_P9 = 17,
+	BMP380_P10 = 19,
+	BMP380_P11 = 20
+};
+
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -708,6 +750,310 @@ static const struct bmp280_chip_info bme280_chip_info = {
 	.read_calib = bmp280_read_calib,
 };
 
+/* Send a command to BMP3XX sensors */
+static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
+{
+	int ret;
+	unsigned int reg;
+
+	/* check if device is ready to process a command */
+	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read error register\n");
+		return ret;
+	}
+	if (!(reg & BMP380_STATUS_CMD_RDY_MASK)) {
+		dev_err(data->dev, "device is not ready to accept commands\n");
+		return -EBUSY;
+	}
+
+	/* send command to process */
+	ret = regmap_write(data->regmap, BMP380_REG_CMD, cmd);
+	if (ret) {
+		dev_err(data->dev, "failed to send command to device\n");
+		return ret;
+	}
+	/* wait for 2ms for command to be proccessed */
+	usleep_range(data->start_up_time, data->start_up_time + 100);
+	/* check for command processing error */
+	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
+	if (ret) {
+		dev_err(data->dev, "error reading ERROR reg\n");
+		return ret;
+	}
+	if (reg & BMP380_ERR_CMD_MASK) {
+		dev_err(data->dev, "error processing command 0x%X\n", cmd);
+		return -EINVAL;
+	}
+	dev_dbg(data->dev, "Command 0x%X proccessed successfully\n", cmd);
+
+	return 0;
+}
+
+/*
+ * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
+ * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
+ * value.
+ *
+ * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
+ * https://github.com/BoschSensortec/BMP3-Sensor-API
+ */
+static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+{
+	s64 var1, var2, var3, var4, var5, var6, comp_temp;
+	struct bmp380_calib *calib = &data->calib.bmp380;
+
+	var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
+	var2 = var1 * ((s64) calib->T2);
+	var3 = var1 * var1;
+	var4 = var3 * ((s64) calib->T3);
+	var5 = (var2 << 18) + var4;
+	var6 = var5 >> 32;
+	data->t_fine = (s32) var6;
+	comp_temp = (var6 * 25) >> 14;
+
+	comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
+	return (s32) comp_temp;
+}
+
+/*
+ * Returns pressure in Pa as unsigned 32 bit integer in fractional Pascal.
+ * Output value of "9528709" represents 9528709/100 = 95287.09 Pa = 952.8709 hPa
+ *
+ * Taken from datasheet, Section 9.3. "Pressure compensation" and repository
+ * https://github.com/BoschSensortec/BMP3-Sensor-API
+ */
+static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
+{
+	s64 var1, var2, var3, var4, var5, var6, offset, sensitivity;
+	u64 comp_press;
+	struct bmp380_calib *calib = &data->calib.bmp380;
+
+	var1 = ((s64)data->t_fine) * ((s64)data->t_fine);
+	var2 = var1 >> 6;
+	var3 = (var2 * ((s64) data->t_fine)) >> 8;
+	var4 = (((s64)calib->P8) * var3) >> 5;
+	var5 = (((s64) calib->P7) * var1) << 4;
+	var6 = (((s64) calib->P6) * ((s64)data->t_fine)) << 22;
+	offset = (((s64)calib->P5) << 47) + var4 + var5 + var6;
+	var2 = (((s64)calib->P4) * var3) >> 5;
+	var4 = (((s64) calib->P3) * var1) << 2;
+	var5 = (((s64) calib->P2) - ((s64) 1<<14)) *
+		(((s64)data->t_fine) << 21);
+	sensitivity = ((((s64) calib->P1) - ((s64) 1 << 14)) << 46) +
+			var2 + var4 + var5;
+	var1 = (sensitivity >> 24) * ((s64)adc_press);
+	var2 = ((s64)calib->P10) * ((s64) data->t_fine);
+	var3 = var2 + (((s64) calib->P9) << 16);
+	var4 = (var3 * ((s64)adc_press)) >> 13;
+
+	/*
+	 * Dividing by 10 followed by multiplying by 10 to avoid
+	 * possible overflow caused by (uncomp_data->pressure * partial_data4)
+	 */
+	var5 = (((s64)adc_press) * (var4 / 10)) >> 9;
+	var5 *= 10;
+	var6 = ((s64)adc_press) * ((s64)adc_press);
+	var2 = (((s64)calib->P11) * var6) >> 16;
+	var3 = (var2 * ((s64)adc_press)) >> 7;
+	var4 = (offset >> 2) + var1 + var5 + var3;
+	comp_press = ((u64)var4 * 25) >> 40;
+
+	comp_press = clamp_val(comp_press, BMP380_MIN_PRES, BMP380_MAX_PRES);
+	return (u32)comp_press;
+}
+
+static int bmp380_read_temp(struct bmp280_data *data, int *val)
+{
+	int ret;
+	u8 tmp[3];
+	u32 adc_temp;
+	s32 comp_temp;
+
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB, tmp, 3);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read temperature\n");
+		return ret;
+	}
+
+	adc_temp = get_unaligned_le24(tmp);
+	if (adc_temp == BMP380_TEMP_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+	comp_temp = bmp380_compensate_temp(data, adc_temp);
+
+	/*
+	 * val might be NULL if we're called by the read_press routine,
+	 * who only cares about the carry over t_fine value.
+	 */
+	if (val) {
+		/* IIO reports temperatures in mC */
+		*val = comp_temp * 10;
+		return IIO_VAL_INT;
+	}
+
+	return 0;
+}
+
+static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
+{
+	int ret;
+	u8 tmp[3];
+	u32 adc_press;
+	s32 comp_press;
+
+	/* Read and compensate temperature so we get a reading of t_fine. */
+	ret = bmp380_read_temp(data, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB, tmp, 3);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read pressure\n");
+		return ret;
+	}
+
+	adc_press = get_unaligned_le24(tmp);
+	if (adc_press == BMP380_PRESS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+	comp_press = bmp380_compensate_press(data, adc_press);
+
+	*val = comp_press;
+	/* Compensated pressure is in cPa (centipascals) */
+	*val2 = 100000;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int bmp380_read_calib(struct bmp280_data *data, unsigned int chip)
+{
+	int ret;
+	struct bmp380_calib *calib = &data->calib.bmp380;
+	u8 buf[BMP380_CALIB_REG_COUNT];
+
+	/* Read temperature calibration values. */
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START, buf,
+			       BMP380_CALIB_REG_COUNT);
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to read temperature calibration parameters\n");
+		return ret;
+	}
+
+	/* Toss the temperature calibration data into the entropy pool */
+	add_device_randomness(buf, sizeof(buf));
+
+	/* Parse calibration data */
+	calib->T1 = get_unaligned_le16(&buf[BMP380_T1]);
+	calib->T2 = get_unaligned_le16(&buf[BMP380_T2]);
+	calib->T3 = buf[BMP380_T3];
+	calib->P1 = get_unaligned_le16(&buf[BMP380_P1]);
+	calib->P2 = get_unaligned_le16(&buf[BMP380_P2]);
+	calib->P3 = buf[BMP380_P3];
+	calib->P4 = buf[BMP380_P4];
+	calib->P5 = get_unaligned_le16(&buf[BMP380_P5]);
+	calib->P6 = get_unaligned_le16(&buf[BMP380_P6]);
+	calib->P7 = buf[BMP380_P7];
+	calib->P8 = buf[BMP380_P8];
+	calib->P9 = get_unaligned_le16(&buf[BMP380_P9]);
+	calib->P10 = buf[BMP380_P10];
+	calib->P11 = buf[BMP380_P11];
+
+	return 0;
+}
+
+static int bmp380_chip_config(struct bmp280_data *data)
+{
+	unsigned int tmp;
+	u8 osrs;
+	int ret;
+
+	/* configure power control register */
+	ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+				BMP380_CTRL_SENSORS_MASK | BMP380_MODE_MASK,
+				BMP380_CTRL_SENSORS_PRESS_EN |
+				BMP380_CTRL_SENSORS_TEMP_EN |
+				FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to write operation control register\n");
+		return ret;
+	}
+
+	/* configure oversampling */
+	osrs = FIELD_PREP(BMP380_OSRS_TEMP_MASK, data->oversampling_temp) |
+	       FIELD_PREP(BMP380_OSRS_PRESS_MASK, data->oversampling_press);
+
+	ret = regmap_write_bits(data->regmap, BMP380_REG_OSR,
+				BMP380_OSRS_TEMP_MASK | BMP380_OSRS_PRESS_MASK,
+				osrs);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to write oversampling register\n");
+		return ret;
+	}
+
+	/* configure output data rate */
+	ret = regmap_write_bits(data->regmap, BMP380_REG_ODR,
+				BMP380_ODRS_MASK, BMP380_ODRS_50HZ);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to write ODR selection register\n");
+		return ret;
+	}
+
+	/* set filter data */
+	ret = regmap_update_bits(data->regmap, BMP380_REG_CONFIG,
+				 BMP380_FILTER_MASK,
+				 FIELD_PREP(BMP380_FILTER_MASK, BMP380_FILTER_3X));
+	if (ret < 0) {
+		dev_err(data->dev, "failed to write config register\n");
+		return ret;
+	}
+
+	/* wait startup_time before verifying config changes */
+	usleep_range(data->start_up_time, data->start_up_time + 100);
+
+	/* check config error flag */
+	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to read error register\n");
+		return ret;
+	}
+	if (tmp & BMP380_ERR_CONF_MASK) {
+		dev_warn(data->dev,
+			 "sensor flagged configuration as incompatible\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
+
+static const struct bmp280_chip_info bmp380_chip_info = {
+	.id_reg = BMP380_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 2,
+
+	.oversampling_temp_avail = bmp380_oversampling_avail,
+	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
+	.oversampling_temp_default = ilog2(1),
+
+	.oversampling_press_avail = bmp380_oversampling_avail,
+	.num_oversampling_press_avail = ARRAY_SIZE(bmp380_oversampling_avail),
+	.oversampling_press_default = ilog2(4),
+
+	.chip_config = bmp380_chip_config,
+	.read_temp = bmp380_read_temp,
+	.read_press = bmp380_read_press,
+	.read_calib = bmp380_read_calib,
+};
+
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 {
 	int ret;
@@ -1050,6 +1396,9 @@ int bmp280_common_probe(struct device *dev,
 	case BME280_CHIP_ID:
 		chip_info = &bme280_chip_info;
 		break;
+	case BMP380_CHIP_ID:
+		chip_info = &bmp380_chip_info;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1107,6 +1456,13 @@ int bmp280_common_probe(struct device *dev,
 		return -EINVAL;
 	}
 
+	/* BMP3xx requires soft-reset as part of initialization */
+	if (chip_id == BMP380_CHIP_ID) {
+		ret = bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = data->chip_info->chip_config(data);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 35045bd92846..31a8a0daa39a 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -19,6 +19,9 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 	case BME280_CHIP_ID:
 		regmap_config = &bmp280_regmap_config;
 		break;
+	case BMP380_CHIP_ID:
+		regmap_config = &bmp380_regmap_config;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -37,6 +40,7 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 }
 
 static const struct of_device_id bmp280_of_i2c_match[] = {
+	{ .compatible = "bosch,bmp380", .data = (void *)BMP380_CHIP_ID },
 	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
 	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
 	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
@@ -46,6 +50,7 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
 
 static const struct i2c_device_id bmp280_i2c_id[] = {
+	{"bmp380", BMP380_CHIP_ID },
 	{"bmp280", BMP280_CHIP_ID },
 	{"bmp180", BMP180_CHIP_ID },
 	{"bmp085", BMP180_CHIP_ID },
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index da136dbadc8f..b440fa41bf12 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -72,6 +72,49 @@ static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool bmp380_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP380_REG_CMD:
+	case BMP380_REG_CONFIG:
+	case BMP380_REG_FIFO_CONFIG_1:
+	case BMP380_REG_FIFO_CONFIG_2:
+	case BMP380_REG_FIFO_WATERMARK_LSB:
+	case BMP380_REG_FIFO_WATERMARK_MSB:
+	case BMP380_REG_POWER_CONTROL:
+	case BMP380_REG_INT_CONTROL:
+	case BMP380_REG_IF_CONFIG:
+	case BMP380_REG_ODR:
+	case BMP380_REG_OSR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool bmp380_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP380_REG_TEMP_XLSB:
+	case BMP380_REG_TEMP_LSB:
+	case BMP380_REG_TEMP_MSB:
+	case BMP380_REG_PRESS_XLSB:
+	case BMP380_REG_PRESS_LSB:
+	case BMP380_REG_PRESS_MSB:
+	case BMP380_REG_SENSOR_TIME_XLSB:
+	case BMP380_REG_SENSOR_TIME_LSB:
+	case BMP380_REG_SENSOR_TIME_MSB:
+	case BMP380_REG_INT_STATUS:
+	case BMP380_REG_FIFO_DATA:
+	case BMP380_REG_STATUS:
+	case BMP380_REG_ERROR:
+	case BMP380_REG_EVENT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 const struct regmap_config bmp280_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -83,3 +126,15 @@ const struct regmap_config bmp280_regmap_config = {
 	.volatile_reg = bmp280_is_volatile_reg,
 };
 EXPORT_SYMBOL(bmp280_regmap_config);
+
+const struct regmap_config bmp380_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BMP380_REG_CMD,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = bmp380_is_writeable_reg,
+	.volatile_reg = bmp380_is_volatile_reg,
+};
+EXPORT_SYMBOL(bmp380_regmap_config);
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 41f6cc56d229..303c41130343 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -66,6 +66,9 @@ static int bmp280_spi_probe(struct spi_device *spi)
 	case BME280_CHIP_ID:
 		regmap_config = &bmp280_regmap_config;
 		break;
+	case BMP380_CHIP_ID:
+		regmap_config = &bmp380_regmap_config;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -92,6 +95,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 	{ .compatible = "bosch,bmp181", },
 	{ .compatible = "bosch,bmp280", },
 	{ .compatible = "bosch,bme280", },
+	{ .compatible = "bosch,bmp380", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
@@ -101,6 +105,7 @@ static const struct spi_device_id bmp280_spi_id[] = {
 	{ "bmp181", BMP180_CHIP_ID },
 	{ "bmp280", BMP280_CHIP_ID },
 	{ "bme280", BME280_CHIP_ID },
+	{ "bmp380", BMP380_CHIP_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 57ba0e85db91..fd38906c889c 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -3,6 +3,105 @@
 #include <linux/device.h>
 #include <linux/regmap.h>
 
+/* BMP380 specific registers */
+#define BMP380_REG_CMD			0x7E
+#define BMP380_REG_CONFIG		0x1F
+#define BMP380_REG_ODR			0X1D
+#define BMP380_REG_OSR			0X1C
+#define BMP380_REG_POWER_CONTROL	0X1B
+#define BMP380_REG_IF_CONFIG		0X1A
+#define BMP380_REG_INT_CONTROL		0X19
+#define BMP380_REG_INT_STATUS		0X11
+#define BMP380_REG_EVENT		0X10
+#define BMP380_REG_STATUS		0X03
+#define BMP380_REG_ERROR		0X02
+#define BMP380_REG_ID			0X00
+
+#define BMP380_REG_FIFO_CONFIG_1	0X18
+#define BMP380_REG_FIFO_CONFIG_2	0X17
+#define BMP380_REG_FIFO_WATERMARK_MSB	0X16
+#define BMP380_REG_FIFO_WATERMARK_LSB	0X15
+#define BMP380_REG_FIFO_DATA		0X14
+#define BMP380_REG_FIFO_LENGTH_MSB	0X13
+#define BMP380_REG_FIFO_LENGTH_LSB	0X12
+
+#define BMP380_REG_SENSOR_TIME_MSB	0X0E
+#define BMP380_REG_SENSOR_TIME_LSB	0X0D
+#define BMP380_REG_SENSOR_TIME_XLSB	0X0C
+
+#define BMP380_REG_TEMP_MSB		0X09
+#define BMP380_REG_TEMP_LSB		0X08
+#define BMP380_REG_TEMP_XLSB		0X07
+
+#define BMP380_REG_PRESS_MSB		0X06
+#define BMP380_REG_PRESS_LSB		0X05
+#define BMP380_REG_PRESS_XLSB		0X04
+
+#define BMP380_REG_CALIB_TEMP_START	0x31
+#define BMP380_CALIB_REG_COUNT		21
+
+#define BMP380_FILTER_MASK		GENMASK(3, 1)
+#define BMP380_FILTER_OFF		0
+#define BMP380_FILTER_1X		1
+#define BMP380_FILTER_3X		2
+#define BMP380_FILTER_7X		3
+#define BMP380_FILTER_15X		4
+#define BMP380_FILTER_31X		5
+#define BMP380_FILTER_63X		6
+#define BMP380_FILTER_127X		7
+
+#define BMP380_OSRS_TEMP_MASK		GENMASK(5, 3)
+#define BMP380_OSRS_PRESS_MASK		GENMASK(2, 0)
+
+#define BMP380_ODRS_MASK		GENMASK(4, 0)
+#define BMP380_ODRS_200HZ		0x00
+#define BMP380_ODRS_100HZ		0x01
+#define BMP380_ODRS_50HZ		0x02
+#define BMP380_ODRS_25HZ		0x03
+#define BMP380_ODRS_12_5HZ		0x04
+#define BMP380_ODRS_6_25HZ		0x05
+#define BMP380_ODRS_3_1HZ		0x06
+#define BMP380_ODRS_1_5HZ		0x07
+#define BMP380_ODRS_0_78HZ		0x08
+#define BMP380_ODRS_0_39HZ		0x09
+#define BMP380_ODRS_0_2HZ		0x0A
+#define BMP380_ODRS_0_1HZ		0x0B
+#define BMP380_ODRS_0_05HZ		0x0C
+#define BMP380_ODRS_0_02HZ		0x0D
+#define BMP380_ODRS_0_01HZ		0x0E
+#define BMP380_ODRS_0_006HZ		0x0F
+#define BMP380_ODRS_0_003HZ		0x10
+#define BMP380_ODRS_0_0015HZ		0x11
+
+#define BMP380_CTRL_SENSORS_MASK	GENMASK(1, 0)
+#define BMP380_CTRL_SENSORS_PRESS_EN	BIT(0)
+#define BMP380_CTRL_SENSORS_TEMP_EN	BIT(1)
+#define BMP380_MODE_MASK		GENMASK(5, 4)
+#define BMP380_MODE_SLEEP		0
+#define BMP380_MODE_FORCED		1
+#define BMP380_MODE_NORMAL		3
+
+#define BMP380_MIN_TEMP			-4000
+#define BMP380_MAX_TEMP			8500
+#define BMP380_MIN_PRES			3000000
+#define BMP380_MAX_PRES			12500000
+
+#define BMP380_CMD_NOOP			0X00
+#define BMP380_CMD_EXTMODE_EN_MID	0x34
+#define BMP380_CMD_FIFO_FLUSH		0XB0
+#define BMP380_CMD_SOFT_RESET		0xB6
+
+#define BMP380_STATUS_CMD_RDY_MASK	BIT(4)
+#define BMP380_STATUS_DRDY_PRESS_MASK	BIT(5)
+#define BMP380_STATUS_DRDY_TEMP_MASK	BIT(6)
+
+#define BMP380_ERR_FATAL_MASK		BIT(0)
+#define BMP380_ERR_CMD_MASK		BIT(1)
+#define BMP380_ERR_CONF_MASK		BIT(2)
+
+#define BMP380_TEMP_SKIPPED		0x800000
+#define BMP380_PRESS_SKIPPED		0x800000
+
 /* BMP280 specific registers */
 #define BMP280_REG_HUMIDITY_LSB		0xFE
 #define BMP280_REG_HUMIDITY_MSB		0xFD
@@ -92,6 +191,7 @@
 #define BMP280_REG_RESET		0xE0
 #define BMP280_REG_ID			0xD0
 
+#define BMP380_CHIP_ID			0x50
 #define BMP180_CHIP_ID			0x55
 #define BMP280_CHIP_ID			0x58
 #define BME280_CHIP_ID			0x60
@@ -105,6 +205,7 @@
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
+extern const struct regmap_config bmp380_regmap_config;
 
 /* Probe called from different transports */
 int bmp280_common_probe(struct device *dev,
-- 
2.36.1

