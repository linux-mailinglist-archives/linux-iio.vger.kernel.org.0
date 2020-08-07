Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71E023F533
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHGXWD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 19:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHGXWD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 19:22:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8464C061756
        for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2020 16:22:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so3705999ejc.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2020 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wrY7OtvA4vQwjkv4ps82swJVOsAeuNIYcjDNmbGt4s=;
        b=Vz0B5p8ln4+MXqnYSOVCj1IvlzMlt1mZAwxTO6UCiawdeEAmnloTbXW2zSwF4LVSek
         Eth/kcXqKMtZ9iyXvU0Bmax4jZr5a3FluFh+P6dhydL5GpI/hNlzJwO+L0XZJQ/9RNKM
         Gua5SLXntmcNYnd1WjtCbJR5tn6QDciFpn6AgYWs9PIW+afTgmUPmIhBFd0ce49L3E9M
         Y4dm5Q4DVY1HuE9oN+l26DqhvJ8k2vf2Rvhl5J8jSsNBwjTvfGeeRHGcuV1e41ht5OXr
         +SKaj1Qoky4FzMLQ0hkySn00GF8Pu5KDiYr6C8ui/uU4AcBhuqdp+CynbaN9KGj+7tjH
         QX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wrY7OtvA4vQwjkv4ps82swJVOsAeuNIYcjDNmbGt4s=;
        b=fjPLWtVd3MNubyFETYBcsfHTVcM/Klh3wt/c68MUsfZqAsEvvWToCs18VGU7PAAk72
         6LuKJcfrXR3fYTEBAJoyuwKNxj0TsUDq4NlsZZQHKZu47eqftXmCcQNfD/cZmETVRHw4
         /mg95uiMJdL/TeQJt0jjMSd96POtmSRa6OEkf7JAUbc2fEe7pUPPfKdKS5W32h+qlFsV
         jshUkqfgsD3y8MxpeGJxVG+5gQUiHikRM8paMe+7hY4u2fSBXPzWFq9nLPSNZeiecNmL
         0zsaF/IGzbli0kyo1y+Bg09SFzvKVqo4mCALBnLQNylBbQ+6ZJx9Au7hNsIk8XmBL3tt
         nZjw==
X-Gm-Message-State: AOAM532PzvJBqhq2R7V77OKKtcHBImSR9rkW4lX8Xz7IvFGgDFqNlHX0
        +eqmK5IPp5Z/A0gFtYKrDXpa8Q==
X-Google-Smtp-Source: ABdhPJwan5d6VfZHIYGYX6Awj0QlYDaHx0sjemEeSMHSncaq2fQ/CUJHDV/AA4ZI7uzbgA7HJeRjrQ==
X-Received: by 2002:a17:906:4a07:: with SMTP id w7mr11297950eju.269.1596842521569;
        Fri, 07 Aug 2020 16:22:01 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgywt9p1tstfsdfc.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:b0e6:1cd9:30c1:35f8])
        by smtp.gmail.com with ESMTPSA id y9sm6305574edt.34.2020.08.07.16.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 16:22:00 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 2/2] iio:temperature:mlx90632: Adding extended calibration option
Date:   Sat,  8 Aug 2020 01:21:04 +0200
Message-Id: <20200807232104.1256119-3-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807232104.1256119-1-cmo@melexis.com>
References: <20200807232104.1256119-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For some time the market wants medical grade accuracy in medical range,
while still retaining the declared accuracy outside of the medical range
within the same sensor. That is why we created extended calibration
which is automatically switched to when object temperature is too high.

This patch also introduces the object_ambient_temperature variable which
is needed for more accurate calculation of the object infra-red
footprint as sensor's ambient temperature might be totally different
than what the ambient temperature is at object and that is why we can
have some more errors which can be eliminated. Currently this temperature
is fixed at 25, but the interface to adjust it by user (with external
sensor or just IR measurement of the other object which acts as ambient),
will be introduced in another commit.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 225 ++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 763a148a0095..049c1217a166 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/math64.h>
 #include <linux/of.h>
@@ -58,6 +59,8 @@
 /* Control register address - volatile */
 #define MLX90632_REG_CONTROL	0x3001 /* Control Register address */
 #define   MLX90632_CFG_PWR_MASK		GENMASK(2, 1) /* PowerMode Mask */
+#define   MLX90632_CFG_MTYP_MASK		GENMASK(8, 4) /* Meas select Mask */
+
 /* PowerModes statuses */
 #define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
 #define MLX90632_PWR_STATUS_HALT MLX90632_PWR_STATUS(0) /* hold */
@@ -65,6 +68,18 @@
 #define MLX90632_PWR_STATUS_STEP MLX90632_PWR_STATUS(2) /* step */
 #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
 
+/* Measurement types */
+#define MLX90632_MTYP_MEDICAL 0
+#define MLX90632_MTYP_EXTENDED 17
+
+/* Measurement type select*/
+#define MLX90632_MTYP_STATUS(ctrl_val) (ctrl_val << 4)
+#define MLX90632_MTYP_STATUS_MEDICAL MLX90632_MTYP_STATUS(MLX90632_MTYP_MEDICAL)
+#define MLX90632_MTYP_STATUS_EXTENDED MLX90632_MTYP_STATUS(MLX90632_MTYP_EXTENDED)
+
+/* I2C command register - volatile */
+#define MLX90632_REG_I2C_CMD    0x3005 /* I2C command Register address */
+
 /* Device status register - volatile */
 #define MLX90632_REG_STATUS	0x3fff /* Device status register */
 #define   MLX90632_STAT_BUSY		BIT(10) /* Device busy indicator */
@@ -81,6 +96,8 @@
 /* Magic constants */
 #define MLX90632_ID_MEDICAL	0x0105 /* EEPROM DSPv5 Medical device id */
 #define MLX90632_ID_CONSUMER	0x0205 /* EEPROM DSPv5 Consumer device id */
+#define MLX90632_ID_EXTENDED	0x0505 /* EEPROM DSPv5 Extended range device id */
+#define MLX90632_ID_MASK	GENMASK(14, 0) /* DSP version and device ID in EE_VERSION */
 #define MLX90632_DSP_VERSION	5 /* DSP version */
 #define MLX90632_DSP_MASK	GENMASK(7, 0) /* DSP version in EE_VERSION */
 #define MLX90632_RESET_CMD	0x0006 /* Reset sensor (address or global) */
@@ -88,16 +105,20 @@
 #define MLX90632_REF_3		12LL /**< ResCtrlRef value of Channel 3 */
 #define MLX90632_MAX_MEAS_NUM	31 /**< Maximum measurements in list */
 #define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
+#define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
 
 struct mlx90632_data {
 	struct i2c_client *client;
 	struct mutex lock; /* Multiple reads for single measurement */
 	struct regmap *regmap;
 	u16 emissivity;
+	u8 mtyp; /* measurement type - to enable extended range calculations */
+	u32 object_ambient_temperature;
 };
 
 static const struct regmap_range mlx90632_volatile_reg_range[] = {
 	regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
+	regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
 	regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
 	regmap_reg_range(MLX90632_RAM_1(0),
 			 MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
@@ -113,6 +134,7 @@ static const struct regmap_range mlx90632_read_reg_range[] = {
 	regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
 	regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
 	regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
+	regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
 	regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
 	regmap_reg_range(MLX90632_RAM_1(0),
 			 MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
@@ -199,6 +221,26 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
 	return (reg_status & MLX90632_STAT_CYCLE_POS) >> 2;
 }
 
+static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
+{
+	int ret;
+
+	if ((type != MLX90632_MTYP_MEDICAL) && (type != MLX90632_MTYP_EXTENDED))
+		return -EINVAL;
+
+	ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
+				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
+				 (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
+	if (ret < 0)
+		return ret;
+
+	return mlx90632_pwr_continuous(regmap);
+}
+
 static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
 				       uint8_t *channel_old)
 {
@@ -300,6 +342,106 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
 	return ret;
 }
 
+static int mlx90632_read_ambient_raw_extended(struct regmap *regmap,
+					      s16 *ambient_new_raw, s16 *ambient_old_raw)
+{
+	unsigned int read_tmp;
+	int ret;
+
+	ret = regmap_read(regmap, MLX90632_RAM_3(17), &read_tmp);
+	if (ret < 0)
+		return ret;
+	*ambient_new_raw = (s16)read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_3(18), &read_tmp);
+	if (ret < 0)
+		return ret;
+	*ambient_old_raw = (s16)read_tmp;
+
+	return 0;
+}
+
+static int mlx90632_read_object_raw_extended(struct regmap *regmap, s16 *object_new_raw)
+{
+	unsigned int read_tmp;
+	s32 read;
+	int ret;
+
+	ret = regmap_read(regmap, MLX90632_RAM_1(17), &read_tmp);
+	if (ret < 0)
+		return ret;
+	read = (s16)read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_2(17), &read_tmp);
+	if (ret < 0)
+		return ret;
+	read = read - (s16)read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_1(18), &read_tmp);
+	if (ret < 0)
+		return ret;
+	read = read - (s16)read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_2(18), &read_tmp);
+	if (ret < 0)
+		return ret;
+	read = (read + (s16)read_tmp) / 2;
+
+	ret = regmap_read(regmap, MLX90632_RAM_1(19), &read_tmp);
+	if (ret < 0)
+		return ret;
+	read = read + (s16)read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_2(19), &read_tmp);
+	if (ret < 0)
+		return ret;
+	read = read + (s16)read_tmp;
+
+	if (read > S16_MAX || read < S16_MIN)
+		return -ERANGE;
+
+	*object_new_raw = read;
+
+	return 0;
+}
+
+static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *object_new_raw,
+					      s16 *ambient_new_raw, s16 *ambient_old_raw)
+{
+	int tries = 4;
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_EXTENDED);
+	if (ret < 0)
+		goto read_unlock;
+
+	while (tries-- > 0) {
+		ret = mlx90632_perform_measurement(data);
+		if (ret < 0)
+			goto read_unlock;
+
+		if (ret == 19)
+			break;
+	}
+	if (tries < 0) {
+		ret = -ETIMEDOUT;
+		goto read_unlock;
+	}
+
+	ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
+	if (ret < 0)
+		goto read_unlock;
+
+	ret = mlx90632_read_ambient_raw_extended(data->regmap, ambient_new_raw, ambient_old_raw);
+
+read_unlock:
+	(void) mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_MEDICAL);
+
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
 				     s32 *reg_value)
 {
@@ -354,9 +496,23 @@ static s64 mlx90632_preprocess_temp_obj(s16 object_new_raw, s16 object_old_raw,
 	return div64_s64((tmp << 19ULL), 1000LL);
 }
 
+static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
+						 s16 ambient_old_raw, s16 Ka)
+{
+	s64 VR_IR, kKa, tmp;
+
+	kKa = ((s64)Ka * 1000LL) >> 10ULL;
+	VR_IR = (s64)ambient_old_raw * 1000000LL +
+		kKa * div64_s64((s64)ambient_new_raw * 1000LL,
+				MLX90632_REF_3);
+	tmp = div64_s64(
+			div64_s64((s64) object_new_raw * 1000000000000LL, MLX90632_REF_12),
+			VR_IR);
+	return div64_s64(tmp << 19ULL, 1000LL);
+}
+
 static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
-				      s32 P_T, s32 P_R, s32 P_G, s32 P_O,
-				      s16 Gb)
+				      s32 P_T, s32 P_R, s32 P_G, s32 P_O, s16 Gb)
 {
 	s64 Asub, Bsub, Ablock, Bblock, Cblock, AMB, sum;
 
@@ -398,6 +554,14 @@ static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
 		- 27315 - Hb_customer) * 10;
 }
 
+static s64 mlx90632_calc_ta4(s64 TAdut, s64 scale)
+{
+	return (div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315);
+}
+
 static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
 				     s32 Fa, s32 Fb, s32 Ga, s16 Ha, s16 Hb,
 				     u16 tmp_emi)
@@ -409,10 +573,7 @@ static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
 	kTA = (Ea * 1000LL) >> 16LL;
 	kTA0 = (Eb * 1000LL) >> 8LL;
 	TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
-	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL)  + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315);
+	TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
 
 	/* Iterations of calculation as described in datasheet */
 	for (i = 0; i < 5; ++i) {
@@ -423,6 +584,31 @@ static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
 	return temp;
 }
 
+static s32 mlx90632_calc_temp_object_extended(s64 object, s64 ambient, s64 reflected,
+					      s32 Ea, s32 Eb, s32 Fa, s32 Fb, s32 Ga,
+					      s16 Ha, s16 Hb, u16 tmp_emi)
+{
+	s64 kTA, kTA0, TAdut, TAdut4, Tr4, TaTr4;
+	s64 temp = 25000;
+	s8 i;
+
+	kTA = (Ea * 1000LL) >> 16LL;
+	kTA0 = (Eb * 1000LL) >> 8LL;
+	TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
+	Tr4 = mlx90632_calc_ta4(reflected, 10);
+	TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
+	TaTr4 = Tr4 - div64_s64(Tr4 - TAdut4, tmp_emi) * 1000;
+
+	/* Iterations of calculation as described in datasheet */
+	for (i = 0; i < 5; ++i) {
+		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TaTr4,
+							   Fa / 2, Fb, Ga, Ha, Hb,
+							   tmp_emi);
+	}
+
+	return temp;
+}
+
 static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
 {
 	s32 ret;
@@ -470,6 +656,26 @@ static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
 	if (ret < 0)
 		return ret;
 
+	if (object_new_raw > MLX90632_EXTENDED_LIMIT &&
+	    data->mtyp == MLX90632_MTYP_EXTENDED) {
+		ret = mlx90632_read_all_channel_extended(data, &object_new_raw,
+							 &ambient_new_raw, &ambient_old_raw);
+		if (ret < 0)
+			return ret;
+
+		/* Use extended mode calculations */
+		ambient = mlx90632_preprocess_temp_amb(ambient_new_raw,
+						       ambient_old_raw, Gb);
+		object = mlx90632_preprocess_temp_obj_extended(object_new_raw,
+							       ambient_new_raw,
+							       ambient_old_raw, Ka);
+		*val = mlx90632_calc_temp_object_extended(object, ambient,
+							  data->object_ambient_temperature,
+							  Ea, Eb, Fa, Fb, Ga,
+							  Ha, Hb, data->emissivity);
+		return 0;
+	}
+
 	ambient = mlx90632_preprocess_temp_amb(ambient_new_raw,
 					       ambient_old_raw, Gb);
 	object = mlx90632_preprocess_temp_obj(object_new_raw,
@@ -643,6 +849,7 @@ static int mlx90632_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	mlx90632->client = client;
 	mlx90632->regmap = regmap;
+	mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
 
 	mutex_init(&mlx90632->lock);
 	indio_dev->name = id->name;
@@ -662,12 +869,17 @@ static int mlx90632_probe(struct i2c_client *client,
 		dev_err(&client->dev, "read of version failed: %d\n", ret);
 		return ret;
 	}
+	read = read & MLX90632_ID_MASK;
 	if (read == MLX90632_ID_MEDICAL) {
 		dev_dbg(&client->dev,
 			"Detected Medical EEPROM calibration %x\n", read);
 	} else if (read == MLX90632_ID_CONSUMER) {
 		dev_dbg(&client->dev,
 			"Detected Consumer EEPROM calibration %x\n", read);
+	} else if (read == MLX90632_ID_EXTENDED) {
+		dev_dbg(&client->dev,
+			"Detected Extended range EEPROM calibration %x\n", read);
+		mlx90632->mtyp = MLX90632_MTYP_EXTENDED;
 	} else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
 		dev_dbg(&client->dev,
 			"Detected Unknown EEPROM calibration %x\n", read);	
@@ -679,6 +891,7 @@ static int mlx90632_probe(struct i2c_client *client,
 	}
 
 	mlx90632->emissivity = 1000;
+	mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
 
 	pm_runtime_disable(&client->dev);
 	ret = pm_runtime_set_active(&client->dev);
-- 
2.25.1

