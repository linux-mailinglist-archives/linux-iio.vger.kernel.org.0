Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CCE6FDB95
	for <lists+linux-iio@lfdr.de>; Wed, 10 May 2023 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjEJKXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 May 2023 06:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjEJKXb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2023 06:23:31 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46E5FC1;
        Wed, 10 May 2023 03:23:27 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9431986043;
        Wed, 10 May 2023 12:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683714206;
        bh=GWykuXar2er8iBvXHvU2sxSqGvuEhzynp2PohqhlDzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olPKEJenubyULDq6VEMhZcaoOUqd93JKfTrOzCT5ptTuNdVeD0rpVbNGc8AYrelOE
         FOAkTu+sOAUHr0GanHPTbk3rb43+wWrA/Kzhnk1HA8/nLfc0WodwTUYVk1aT+QImzf
         iaJDqqNccDFOv8AGuMOB+/cHrNoogDxcit7QJIUpeTiGEo37v0zxaYj9tsIOMylYAT
         VXjS3/tdLFPWN+AxHMAUWnTbF0UAE4DUuChcWORAbDnnn/uwUUiB08z4FqFUSZMZjV
         umRj+W8w2sZbYgTMciRsnIYxlE+27nRy3dUZ2G+1WpJ6IPh1fmWAXnDletzQ5xltDH
         o/E8bhwdiKN7A==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 5/6] iio: mlx90614: Factor our register IO and constants into model specific descriptor
Date:   Wed, 10 May 2023 12:22:50 +0200
Message-Id: <20230510102251.10118-5-marex@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510102251.10118-1-marex@denx.de>
References: <20230510102251.10118-1-marex@denx.de>
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

Factor out all the differences between MLX90614 and other similar chips
into a structure which describes the chip and allows abstracting out the
differences from the driver code. No functional change.

This patch moves all the RAM and EEPROM IO opcodes into the descriptor
structure and combines them, instead of combining the opcode and offset
in macros.

Acked-by: Crt Mori <cmo@melexis.com>
Tested-by: Crt Mori <cmo@melexis.com>
Signed-off-by: Marek Vasut <marex@denx.de>
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
V2: New patch
V3: Add AB/TB from Crt
---
 drivers/iio/temperature/mlx90614.c | 181 +++++++++++++++++++----------
 1 file changed, 122 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index ecd27fe0c8666..3aa108a652bb4 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/iio/iio.h>
@@ -34,15 +35,6 @@
 #define MLX90614_OP_EEPROM	0x20
 #define MLX90614_OP_SLEEP	0xff
 
-/* RAM offsets with 16-bit data, MSB first */
-#define MLX90614_TA	(MLX90614_OP_RAM | 0x06) /* ambient temperature */
-#define MLX90614_TOBJ1	(MLX90614_OP_RAM | 0x07) /* object 1 temperature */
-#define MLX90614_TOBJ2	(MLX90614_OP_RAM | 0x08) /* object 2 temperature */
-
-/* EEPROM offsets with 16-bit data, MSB first */
-#define MLX90614_EMISSIVITY	(MLX90614_OP_EEPROM | 0x04) /* emissivity correction coefficient */
-#define MLX90614_CONFIG		(MLX90614_OP_EEPROM | 0x05) /* configuration register */
-
 /* Control bits in configuration register */
 #define MLX90614_CONFIG_IIR_SHIFT 0 /* IIR coefficient */
 #define MLX90614_CONFIG_IIR_MASK (0x7 << MLX90614_CONFIG_IIR_SHIFT)
@@ -62,29 +54,44 @@
 #define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin offset */
 #define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
 #define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
-#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */
 #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
 
+/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
+#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
+
+struct mlx_chip_info {
+	/* EEPROM offsets with 16-bit data, MSB first */
+	/* emissivity correction coefficient */
+	u8			op_eeprom_emissivity;
+	u8			op_eeprom_config1;
+	/* RAM offsets with 16-bit data, MSB first */
+	/* ambient temperature */
+	u8			op_ram_ta;
+	/* object 1 temperature */
+	u8			op_ram_tobj1;
+	/* object 2 temperature */
+	u8			op_ram_tobj2;
+	u8			op_sleep;
+	/* support for two input channels (MLX90614 only) */
+	u8			dual_channel;
+	u8			wakeup_delay_ms;
+	u16			emissivity_max;
+	u16			fir_config_mask;
+	u16			iir_config_mask;
+	int			iir_valid_offset;
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
@@ -124,21 +131,26 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
 }
 
 /*
- * Find the IIR value inside mlx90614_iir_values array and return its position
+ * Find the IIR value inside iir_values array and return its position
  * which is equivalent to the bit value in sensor register
  */
 static inline s32 mlx90614_iir_search(const struct i2c_client *client,
 				      int value)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	const struct mlx_chip_info *chip_info = data->chip_info;
 	int i;
 	s32 ret;
 
-	for (i = 0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
-		if (value == mlx90614_iir_values[i])
+	for (i = chip_info->iir_valid_offset;
+	     i < ARRAY_SIZE(chip_info->iir_values);
+	     i++) {
+		if (value == chip_info->iir_values[i])
 			break;
 	}
 
-	if (i == ARRAY_SIZE(mlx90614_iir_values))
+	if (i == ARRAY_SIZE(chip_info->iir_values))
 		return -EINVAL;
 
 	/*
@@ -146,17 +158,21 @@ static inline s32 mlx90614_iir_search(const struct i2c_client *client,
 	 * we must read them before we actually write
 	 * changes
 	 */
-	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
+	ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
 	if (ret < 0)
 		return ret;
 
-	ret &= ~MLX90614_CONFIG_FIR_MASK;
-	ret |= MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT;
-	ret &= ~MLX90614_CONFIG_IIR_MASK;
-	ret |= i << MLX90614_CONFIG_IIR_SHIFT;
+	/* Modify FIR on parts which have configurable FIR filter */
+	if (chip_info->fir_config_mask) {
+		ret &= ~chip_info->fir_config_mask;
+		ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
+	}
+
+	ret &= ~chip_info->iir_config_mask;
+	ret |= field_prep(chip_info->iir_config_mask, i);
 
 	/* Write changed values */
-	ret = mlx90614_write_word(client, MLX90614_CONFIG, ret);
+	ret = mlx90614_write_word(client, chip_info->op_eeprom_config1, ret);
 	return ret;
 }
 
@@ -216,22 +232,26 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
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
+			cmd = chip_info->op_ram_ta;
 			break;
 		case IIO_MOD_TEMP_OBJECT:
+			if (chip_info->dual_channel && channel->channel)
+				return -EINVAL;
+
 			switch (channel->channel) {
 			case 0:
-				cmd = MLX90614_TOBJ1;
+				cmd = chip_info->op_ram_tobj1;
 				break;
 			case 1:
-				cmd = MLX90614_TOBJ2;
+				cmd = chip_info->op_ram_tobj2;
 				break;
 			default:
 				return -EINVAL;
@@ -263,27 +283,26 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val = MLX90614_CONST_SCALE;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
+	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/emissivity_max / LSB */
 		ret = mlx90614_power_get(data, false);
 		if (ret < 0)
 			return ret;
 
 		mutex_lock(&data->lock);
 		ret = i2c_smbus_read_word_data(data->client,
-					       MLX90614_EMISSIVITY);
+					       chip_info->op_eeprom_emissivity);
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
-			*val2 = ret * NSEC_PER_SEC /
-				MLX90614_CONST_RAW_EMISSIVITY_MAX;
+			*val2 = ret * NSEC_PER_SEC / chip_info->emissivity_max;
 		}
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
@@ -293,16 +312,19 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		mutex_lock(&data->lock);
-		ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
+		ret = i2c_smbus_read_word_data(data->client,
+					       chip_info->op_eeprom_config1);
 		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
 		if (ret < 0)
 			return ret;
 
-		*val = mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK] / 100;
-		*val2 = (mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK] % 100) *
-			10000;
+		idx = field_get(chip_info->iir_config_mask, ret) -
+		      chip_info->iir_valid_offset;
+
+		*val = chip_info->iir_values[idx] / 100;
+		*val2 = (chip_info->iir_values[idx] % 100) * 10000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
@@ -314,22 +336,23 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
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
-		      val2 * MLX90614_CONST_RAW_EMISSIVITY_MAX / NSEC_PER_SEC;
+		val = val * chip_info->emissivity_max +
+		      val2 * chip_info->emissivity_max / NSEC_PER_SEC;
 
 		ret = mlx90614_power_get(data, false);
 		if (ret < 0)
 			return ret;
 
 		mutex_lock(&data->lock);
-		ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY,
-					  val);
+		ret = mlx90614_write_word(data->client,
+					  chip_info->op_eeprom_emissivity, val);
 		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
@@ -373,11 +396,15 @@ static int mlx90614_read_avail(struct iio_dev *indio_dev,
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
+		*length = 2 * (ARRAY_SIZE(chip_info->iir_freqs) -
+			       chip_info->iir_valid_offset);
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
@@ -431,6 +458,7 @@ static const struct iio_info mlx90614_info = {
 #ifdef CONFIG_PM
 static int mlx90614_sleep(struct mlx90614_data *data)
 {
+	const struct mlx_chip_info *chip_info = data->chip_info;
 	s32 ret;
 
 	if (!data->wakeup_gpio) {
@@ -443,7 +471,7 @@ static int mlx90614_sleep(struct mlx90614_data *data)
 	mutex_lock(&data->lock);
 	ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
 			     data->client->flags | I2C_CLIENT_PEC,
-			     I2C_SMBUS_WRITE, MLX90614_OP_SLEEP,
+			     I2C_SMBUS_WRITE, chip_info->op_sleep,
 			     I2C_SMBUS_BYTE, NULL);
 	mutex_unlock(&data->lock);
 
@@ -452,6 +480,8 @@ static int mlx90614_sleep(struct mlx90614_data *data)
 
 static int mlx90614_wakeup(struct mlx90614_data *data)
 {
+	const struct mlx_chip_info *chip_info = data->chip_info;
+
 	if (!data->wakeup_gpio) {
 		dev_dbg(&data->client->dev, "Wake-up disabled");
 		return -ENOSYS;
@@ -461,7 +491,7 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
 
 	i2c_lock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
 	gpiod_direction_output(data->wakeup_gpio, 0);
-	msleep(MLX90614_TIMING_WAKEUP);
+	msleep(chip_info->wakeup_delay_ms);
 	gpiod_direction_input(data->wakeup_gpio);
 	i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
 
@@ -474,7 +504,7 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
 	 * If the read fails, the controller will probably be reset so that
 	 * further reads will work.
 	 */
-	i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
+	i2c_smbus_read_word_data(data->client, chip_info->op_eeprom_config1);
 
 	return 0;
 }
@@ -523,9 +553,15 @@ static inline struct gpio_desc *mlx90614_probe_wakeup(struct i2c_client *client)
 /* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
 static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	const struct mlx_chip_info *chip_info = data->chip_info;
 	s32 ret;
 
-	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
+	if (chip_info->dual_channel)
+		return 0;
+
+	ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
 
 	if (ret < 0)
 		return ret;
@@ -552,6 +588,7 @@ static int mlx90614_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 	data->wakeup_gpio = mlx90614_probe_wakeup(client);
+	data->chip_info = device_get_match_data(&client->dev);
 
 	mlx90614_wakeup(data);
 
@@ -601,14 +638,40 @@ static void mlx90614_remove(struct i2c_client *client)
 	}
 }
 
+static const struct mlx_chip_info mlx90614_chip_info = {
+	.op_eeprom_emissivity		= MLX90614_OP_EEPROM | 0x04,
+	.op_eeprom_config1		= MLX90614_OP_EEPROM | 0x05,
+	.op_ram_ta			= MLX90614_OP_RAM | 0x06,
+	.op_ram_tobj1			= MLX90614_OP_RAM | 0x07,
+	.op_ram_tobj2			= MLX90614_OP_RAM | 0x08,
+	.op_sleep			= MLX90614_OP_SLEEP,
+	.dual_channel			= true,
+	.wakeup_delay_ms		= MLX90614_TIMING_WAKEUP,
+	.emissivity_max			= 65535,
+	.fir_config_mask		= MLX90614_CONFIG_FIR_MASK,
+	.iir_config_mask		= MLX90614_CONFIG_IIR_MASK,
+	.iir_valid_offset		= 0,
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
 static const struct i2c_device_id mlx90614_id[] = {
-	{ "mlx90614", 0 },
+	{ "mlx90614", .driver_data = (kernel_ulong_t)&mlx90614_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mlx90614_id);
 
 static const struct of_device_id mlx90614_of_match[] = {
-	{ .compatible = "melexis,mlx90614" },
+	{ .compatible = "melexis,mlx90614", .data = &mlx90614_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mlx90614_of_match);
-- 
2.39.2

