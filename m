Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160566F76E6
	for <lists+linux-iio@lfdr.de>; Thu,  4 May 2023 22:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjEDUWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 May 2023 16:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjEDUWJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2023 16:22:09 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C61A409BD;
        Thu,  4 May 2023 13:07:53 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D52BC857CD;
        Thu,  4 May 2023 21:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683229698;
        bh=j75cPTZQhymfZ0psuaf5YObzw4x04Tk0BUHL8o3cv9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWF06WANnGb04gN+CWr+kP594ciK41WeuR9LzGYsLUVm/fpm+XyVM+8rZO3Y5aC9P
         CuXiiNl9vqtoQMZBTZdCic6do09ZFcndViGUV9vO9SPooid78vj1gQM1JTksb9qrD0
         z+oCpuoVBg3lOoRqgCVD9G2oXgytYPzydVmScAxXg0+5ez/fhmKBnf4R3uY1VYxWhN
         FH4PYRADZnev3o9tMxX89lXfjzIhzLyfZUHkBNo+9uRycWge+2pm6/HsSMd7aMcAgn
         8fbwZ1N7+ofKqEL/RvflnfddaA6in6uOjb5eLhAfgeBatXz6RdLEHwBbjqfBvz41Eq
         sOwjgV4fyeKkw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] iio: mlx90614: Add MLX90615 support
Date:   Thu,  4 May 2023 21:47:50 +0200
Message-Id: <20230504194750.4489-2-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194750.4489-1-marex@denx.de>
References: <20230504194750.4489-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for MLX90615 Infra Red Thermometer, which seems to be
the predecesor of MLX90614 . There are significant differences in
the register layout compared to MLX90614, but the functionality
of the device is virtually identical.

The following differences have been identified:
- RAM/EEPROM/SLEEP access opcodes are different
- RAM/EEPROM registers are at different offsets
- EEPROM emissivity and configuration registers are at different offsets
- EEPROM configuration register bits are shuffled around
- EEPROM emissivity settings are 14 bit on MLX90615 , 16 bit on MLX90614
- MLX90615 can only ever support one sensor, MLX90614 could support two
- FIR filter is set to fixed settings on MLX90615
- IIR filter coefficients are different

The approach taken here is to extract the differences between the two
devices into chip info structure and then patch the code all over to
cater for the differences.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: The IIR coefficients need to be checked
---
Cc: Crt Mori <cmo@melexis.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/temperature/mlx90614.c | 245 +++++++++++++++++++++--------
 1 file changed, 176 insertions(+), 69 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 909fadb623491..9826680608e5e 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mlx90614.c - Support for Melexis MLX90614 contactless IR temperature sensor
+ * mlx90614.c - Support for Melexis MLX90614/MLX90615 contactless IR temperature sensor
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
  * Copyright (c) 2015 Essensium NV
  * Copyright (c) 2015 Melexis
  *
- * Driver for the Melexis MLX90614 I2C 16-bit IR thermopile sensor
+ * Driver for the Melexis MLX90614/MLX90615 I2C 16-bit IR thermopile sensor
+ *
+ * MLX90614 - 17-bit ADC + MLX90302 DSP
+ * MLX90615 - 16-bit ADC + MLX90325 DSP
  *
  * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
  *
@@ -22,9 +25,11 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/iio/iio.h>
@@ -34,16 +39,27 @@
 #define MLX90614_OP_EEPROM	0x20
 #define MLX90614_OP_SLEEP	0xff
 
+#define MLX90615_OP_EEPROM	0x10
+#define MLX90615_OP_RAM		0x20
+#define MLX90615_OP_SLEEP	0xc6
+
 /* RAM offsets with 16-bit data, MSB first */
-#define MLX90614_RAW1	(MLX90614_OP_RAM | 0x04) /* raw data IR channel 1 */
-#define MLX90614_RAW2	(MLX90614_OP_RAM | 0x05) /* raw data IR channel 2 */
-#define MLX90614_TA	(MLX90614_OP_RAM | 0x06) /* ambient temperature */
-#define MLX90614_TOBJ1	(MLX90614_OP_RAM | 0x07) /* object 1 temperature */
-#define MLX90614_TOBJ2	(MLX90614_OP_RAM | 0x08) /* object 2 temperature */
+/* ambient temperature */
+#define MLX9061X_TA(info)	\
+	((info)->op_ram_access | 0x06)
+/* object 1 temperature */
+#define MLX9061X_TOBJ1(info)	\
+	((info)->op_ram_access | 0x07)
+/* object 2 temperature (MLX90614 only) */
+#define MLX90614_TOBJ2(info)	\
+	((info)->op_ram_access | 0x08)
 
 /* EEPROM offsets with 16-bit data, MSB first */
-#define MLX90614_EMISSIVITY	(MLX90614_OP_EEPROM | 0x04) /* emissivity correction coefficient */
-#define MLX90614_CONFIG		(MLX90614_OP_EEPROM | 0x05) /* configuration register */
+/* emissivity correction coefficient */
+#define MLX9061X_EMISSIVITY(info) \
+	((info)->op_eeprom_access | (info)->eeprom_offset_emissivity)
+#define MLX9061X_CONFIG(info) \
+	((info)->op_eeprom_access | (info)->eeprom_offset_config1)
 
 /* Control bits in configuration register */
 #define MLX90614_CONFIG_IIR_SHIFT 0 /* IIR coefficient */
@@ -52,44 +68,51 @@
 #define MLX90614_CONFIG_DUAL_MASK (1 << MLX90614_CONFIG_DUAL_SHIFT)
 #define MLX90614_CONFIG_FIR_SHIFT 8 /* FIR coefficient */
 #define MLX90614_CONFIG_FIR_MASK (0x7 << MLX90614_CONFIG_FIR_SHIFT)
-#define MLX90614_CONFIG_GAIN_SHIFT 11 /* gain */
-#define MLX90614_CONFIG_GAIN_MASK (0x7 << MLX90614_CONFIG_GAIN_SHIFT)
+
+#define MLX90615_CONFIG_IIR_SHIFT 12 /* IIR coefficient */
+#define MLX90615_CONFIG_IIR_MASK (0x7 << MLX90615_CONFIG_IIR_SHIFT)
 
 /* Timings (in ms) */
 #define MLX90614_TIMING_EEPROM 20 /* time for EEPROM write/erase to complete */
 #define MLX90614_TIMING_WAKEUP 34 /* time to hold SDA low for wake-up */
 #define MLX90614_TIMING_STARTUP 250 /* time before first data after wake-up */
 
+#define MLX90615_TIMING_WAKEUP 22 /* time to hold SCL low for wake-up */
+
 #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
 
 /* Magic constants */
-#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin offset */
-#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
-#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
-#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */
-#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */
+#define MLX9061X_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin offset */
+#define MLX9061X_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
+#define MLX9061X_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
 #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
 
+enum mlx_chip_model {
+	MLX90614,
+	MLX90615,
+};
+
+struct mlx_chip_info {
+	enum mlx_chip_model	model;
+	u8			op_eeprom_access;
+	u8			op_ram_access;
+	u8			op_sleep;
+	u8			eeprom_offset_emissivity;
+	u8			eeprom_offset_config1;
+	u16			emissivity_max;
+	u16			emissivity_res;
+	u16			iir_values[8];
+	int			iir_freqs[8][2];
+};
+
 struct mlx90614_data {
 	struct i2c_client *client;
 	struct mutex lock; /* for EEPROM access only */
 	struct gpio_desc *wakeup_gpio; /* NULL to disable sleep/wake-up */
+	const struct mlx_chip_info *chip_info; /* Chip hardware details */
 	unsigned long ready_timestamp; /* in jiffies */
 };
 
-/* Bandwidth values for IIR filtering */
-static const int mlx90614_iir_values[] = {77, 31, 20, 15, 723, 153, 110, 86};
-static const int mlx90614_freqs[][2] = {
-	{0, 150000},
-	{0, 200000},
-	{0, 310000},
-	{0, 770000},
-	{0, 860000},
-	{1, 100000},
-	{1, 530000},
-	{7, 230000}
-};
-
 /*
  * Erase an address and write word.
  * The mutex must be locked before calling.
@@ -129,21 +152,25 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
 }
 
 /*
- * Find the IIR value inside mlx90614_iir_values array and return its position
+ * Find the IIR value inside iir_values array and return its position
  * which is equivalent to the bit value in sensor register
  */
 static inline s32 mlx90614_iir_search(const struct i2c_client *client,
 				      int value)
 {
-	int i;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	const struct mlx_chip_info *chip_info = data->chip_info;
+	/* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
+	int i = chip_info->model == MLX90615 ? 1 : 0;
 	s32 ret;
 
-	for (i = 0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
-		if (value == mlx90614_iir_values[i])
+	for (; i < ARRAY_SIZE(chip_info->iir_values); ++i) {
+		if (value == chip_info->iir_values[i])
 			break;
 	}
 
-	if (i == ARRAY_SIZE(mlx90614_iir_values))
+	if (i == ARRAY_SIZE(chip_info->iir_values))
 		return -EINVAL;
 
 	/*
@@ -151,17 +178,23 @@ static inline s32 mlx90614_iir_search(const struct i2c_client *client,
 	 * we must read them before we actually write
 	 * changes
 	 */
-	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
+	ret = i2c_smbus_read_word_data(client, MLX9061X_CONFIG(chip_info));
 	if (ret < 0)
 		return ret;
 
-	ret &= ~MLX90614_CONFIG_FIR_MASK;
-	ret |= MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT;
-	ret &= ~MLX90614_CONFIG_IIR_MASK;
-	ret |= i << MLX90614_CONFIG_IIR_SHIFT;
+	if (chip_info->model == MLX90614) {
+		ret &= ~MLX90614_CONFIG_FIR_MASK;
+		ret |= MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT;
+		ret &= ~MLX90614_CONFIG_IIR_MASK;
+		ret |= i << MLX90614_CONFIG_IIR_SHIFT;
+	} else {
+		/* MLX90615 has fixed FIR = 65536 */
+		ret &= ~MLX90615_CONFIG_IIR_MASK;
+		ret |= i << MLX90615_CONFIG_IIR_SHIFT;
+	}
 
 	/* Write changed values */
-	ret = mlx90614_write_word(client, MLX90614_CONFIG, ret);
+	ret = mlx90614_write_word(client, MLX9061X_CONFIG(chip_info), ret);
 	return ret;
 }
 
@@ -221,22 +254,27 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	struct mlx90614_data *data = iio_priv(indio_dev);
-	u8 cmd;
+	const struct mlx_chip_info *chip_info = data->chip_info;
+	u8 cmd, idx;
 	s32 ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: /* 0.02K / LSB */
 		switch (channel->channel2) {
 		case IIO_MOD_TEMP_AMBIENT:
-			cmd = MLX90614_TA;
+			cmd = MLX9061X_TA(chip_info);
 			break;
 		case IIO_MOD_TEMP_OBJECT:
+			/* MLX90615 is always single channel */
+			if (chip_info->model == MLX90615 && channel->channel)
+				return -EINVAL;
+
 			switch (channel->channel) {
 			case 0:
-				cmd = MLX90614_TOBJ1;
+				cmd = MLX9061X_TOBJ1(chip_info);
 				break;
 			case 1:
-				cmd = MLX90614_TOBJ2;
+				cmd = MLX90614_TOBJ2(chip_info);
 				break;
 			default:
 				return -EINVAL;
@@ -262,51 +300,56 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = MLX90614_CONST_OFFSET_DEC;
-		*val2 = MLX90614_CONST_OFFSET_REM;
+		*val = MLX9061X_CONST_OFFSET_DEC;
+		*val2 = MLX9061X_CONST_OFFSET_REM;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SCALE:
-		*val = MLX90614_CONST_SCALE;
+		*val = MLX9061X_CONST_SCALE;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
+	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/emissivity_max / LSB */
 		ret = mlx90614_power_get(data, false);
 		if (ret < 0)
 			return ret;
 
 		mutex_lock(&data->lock);
 		ret = i2c_smbus_read_word_data(data->client,
-					       MLX90614_EMISSIVITY);
+					       MLX9061X_EMISSIVITY(chip_info));
 		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
 		if (ret < 0)
 			return ret;
 
-		if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
+		if (ret == chip_info->emissivity_max) {
 			*val = 1;
 			*val2 = 0;
 		} else {
 			*val = 0;
-			*val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
+			*val2 = ret * chip_info->emissivity_res;
 		}
 		return IIO_VAL_INT_PLUS_NANO;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
-							     FIR = 1024 */
+	/* IIR setting with FIR=1024 (MLX90614) or FIR=65536 (MLX90615) */
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = mlx90614_power_get(data, false);
 		if (ret < 0)
 			return ret;
 
 		mutex_lock(&data->lock);
-		ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
+		ret = i2c_smbus_read_word_data(data->client,
+					       MLX9061X_CONFIG(chip_info));
 		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
 		if (ret < 0)
 			return ret;
 
-		*val = mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK] / 100;
-		*val2 = (mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK] % 100) *
-			10000;
+		if (chip_info->model == MLX90614)
+			idx = FIELD_GET(MLX90614_CONFIG_IIR_MASK, ret);
+		else
+			idx = FIELD_GET(MLX90615_CONFIG_IIR_MASK, ret);
+
+		*val = chip_info->iir_values[idx] / 100;
+		*val2 = (chip_info->iir_values[idx] % 100) * 10000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
@@ -318,22 +361,23 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct mlx90614_data *data = iio_priv(indio_dev);
+	const struct mlx_chip_info *chip_info = data->chip_info;
 	s32 ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
+	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/emissivity_max / LSB */
 		if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 != 0))
 			return -EINVAL;
-		val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
-			val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
+		val = val * chip_info->emissivity_max +
+		      val2 / chip_info->emissivity_res;
 
 		ret = mlx90614_power_get(data, false);
 		if (ret < 0)
 			return ret;
 
 		mutex_lock(&data->lock);
-		ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY,
-					  val);
+		ret = mlx90614_write_word(data->client,
+					  MLX9061X_EMISSIVITY(chip_info), val);
 		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
@@ -377,11 +421,18 @@ static int mlx90614_read_avail(struct iio_dev *indio_dev,
 			       const int **vals, int *type, int *length,
 			       long mask)
 {
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	const struct mlx_chip_info *chip_info = data->chip_info;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		*vals = (int *)mlx90614_freqs;
+		*vals = (int *)chip_info->iir_freqs;
 		*type = IIO_VAL_INT_PLUS_MICRO;
-		*length = 2 * ARRAY_SIZE(mlx90614_freqs);
+		/* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
+		if (chip_info->model == MLX90615)
+			*length = 2 * 7;
+		else
+			*length = 2 * 8;
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -456,6 +507,8 @@ static int mlx90614_sleep(struct mlx90614_data *data)
 
 static int mlx90614_wakeup(struct mlx90614_data *data)
 {
+	const struct mlx_chip_info *chip_info = data->chip_info;
+
 	if (!data->wakeup_gpio) {
 		dev_dbg(&data->client->dev, "Wake-up disabled");
 		return -ENOSYS;
@@ -465,7 +518,8 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
 
 	i2c_lock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
 	gpiod_direction_output(data->wakeup_gpio, 0);
-	msleep(MLX90614_TIMING_WAKEUP);
+	msleep(data->chip_info == MLX90614 ?
+	       MLX90614_TIMING_WAKEUP : MLX90615_TIMING_WAKEUP);
 	gpiod_direction_input(data->wakeup_gpio);
 	i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
 
@@ -478,7 +532,7 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
 	 * If the read fails, the controller will probably be reset so that
 	 * further reads will work.
 	 */
-	i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
+	i2c_smbus_read_word_data(data->client, MLX9061X_CONFIG(chip_info));
 
 	return 0;
 }
@@ -527,9 +581,16 @@ static inline struct gpio_desc *mlx90614_probe_wakeup(struct i2c_client *client)
 /* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
 static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	const struct mlx_chip_info *chip_info = data->chip_info;
 	s32 ret;
 
-	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
+	/* MLX90615 is single-sensor only */
+	if (chip_info->model == MLX90615)
+		return 0;
+
+	ret = i2c_smbus_read_word_data(client, MLX9061X_CONFIG(chip_info));
 
 	if (ret < 0)
 		return ret;
@@ -556,6 +617,7 @@ static int mlx90614_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 	data->wakeup_gpio = mlx90614_probe_wakeup(client);
+	data->chip_info = of_device_get_match_data(&client->dev);
 
 	mlx90614_wakeup(data);
 
@@ -605,14 +667,59 @@ static void mlx90614_remove(struct i2c_client *client)
 	}
 }
 
+static const struct mlx_chip_info mlx90614_chip_info = {
+	.model				= MLX90614,
+	.op_eeprom_access		= MLX90614_OP_EEPROM,
+	.op_ram_access			= MLX90614_OP_RAM,
+	.op_sleep			= MLX90614_OP_SLEEP,
+	.eeprom_offset_emissivity	= 0x04,
+	.eeprom_offset_config1		= 0x05,
+	.emissivity_max			= 65535,
+	.emissivity_res			= 1000000000 / 65535,
+	.iir_values			= { 77, 31, 20, 15, 723, 153, 110, 86 },
+	.iir_freqs			= {
+		{ 0, 150000 },	/* 13% ~= 0.15 Hz */
+		{ 0, 200000 },	/* 17% ~= 0.20 Hz */
+		{ 0, 310000 },	/* 25% ~= 0.31 Hz */
+		{ 0, 770000 },	/* 50% ~= 0.77 Hz */
+		{ 0, 860000 },	/* 57% ~= 0.86 Hz */
+		{ 1, 100000 },	/* 67% ~= 1.10 Hz */
+		{ 1, 530000 },	/* 80% ~= 1.53 Hz */
+		{ 7, 230000 }	/* 100% ~= 7.23 Hz */
+	},
+};
+
+static const struct mlx_chip_info mlx90615_chip_info = {
+	.model				= MLX90615,
+	.op_eeprom_access		= MLX90615_OP_EEPROM,
+	.op_ram_access			= MLX90615_OP_RAM,
+	.op_sleep			= MLX90615_OP_SLEEP,
+	.eeprom_offset_emissivity	= 0x03,
+	.eeprom_offset_config1		= 0x02,
+	.emissivity_max			= 16383,
+	.emissivity_res			= 1000000000 / 16383,
+	.iir_values			= { 0, 723, 77, 42, 31, 28, 20, 18 },
+	.iir_freqs			= {
+		{ 0, 180000 },	/* 14% ~= 0.18 Hz */
+		{ 0, 200000 },	/* 17% ~= 0.20 Hz */
+		{ 0, 280000 },	/* 20% ~= 0.28 Hz */
+		{ 0, 310000 },	/* 25% ~= 0.31 Hz */
+		{ 0, 420000 },	/* 33% ~= 0.42 Hz */
+		{ 0, 770000 },	/* 50% ~= 0.77 Hz */
+		{ 7, 230000 },	/* 100% ~= 7.23 Hz */
+	},
+};
+
 static const struct i2c_device_id mlx90614_id[] = {
-	{ "mlx90614", 0 },
+	{ "mlx90614", .driver_data = (kernel_ulong_t)&mlx90614_chip_info },
+	{ "mlx90615", .driver_data = (kernel_ulong_t)&mlx90615_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mlx90614_id);
 
 static const struct of_device_id mlx90614_of_match[] = {
-	{ .compatible = "melexis,mlx90614" },
+	{ .compatible = "melexis,mlx90614", .data = &mlx90614_chip_info },
+	{ .compatible = "melexis,mlx90615", .data = &mlx90615_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mlx90614_of_match);
-- 
2.39.2

