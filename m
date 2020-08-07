Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CAF23EA1C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHGJUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgHGJUm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 05:20:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C61EC061574
        for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2020 02:20:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so784906eds.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2020 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=alK2uwXjJAvvcKN2M/uKq75VCc1VISRu/NQMjzV3t8s=;
        b=luBkOvRpFuyyv7GhOjkI4m9GQ4KKMYK7B1dsUd4Pg9rLeuIkbWCe63VSDYpY70MXAM
         v7cPIWDE2G+lsfVF2NcX5Km5bPGsYs7QeN5ko6UjbfTfP/HTLvZPN7agCtF1QaQpB88o
         IbtvMOBaoEKpXmEoMsRPNWXIOCYyERPkPlRVLJC2iRFlIBwBvO0uXzQDLuEsV10ZLGfW
         A03e/sPC/UF85kdTt75uBxp/Nrlgd9FtNAcB4lxMl4lwX4Vt34JL4bdCnw+vwYnapr/+
         iQHA7AKudGIcQ95lQrcutxXky7b3rJbJM5Fv1VlM3pTSy1Cuzf6Hd875Og6pGuBoZ9AX
         t9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=alK2uwXjJAvvcKN2M/uKq75VCc1VISRu/NQMjzV3t8s=;
        b=fX3pk9PxE1WxYl60HMG/7apu8tPA5wvotMS0mgba/cgOmdzTzjtvUlHe3V8sm5cYYc
         7WtSQOPedN8FTeTphj/SYXvkg5Q8b3a5ysnCHniV3+ZWgoK1461YGSRDxExDHMuYVeXV
         j7/HeQEH5SCnurGnMbHyqoL3ncW6Ygb/YNe6JqofpXK4aQCZpXqHZcOXoqf9RmxETnBb
         hbeETFDYt4R4znVP97xrG1o4LNhqFSNycH3NjBFOGjH0WMXD4icXZI5znrAPy5HMCB5H
         TYfhp25bnROu2hPF6zJlNC6vgbV1J8k9lM4c0iurZwRaIhmatgHl0Zh9uQXinbVhD6iV
         jsww==
X-Gm-Message-State: AOAM533r2pmz3U1xnIg3wv3FHNXB+Dh7kJscFMswt3lWbgMiNtxSR3MU
        fbR6Cqgwb14ZgOYpaL/CzEa7mA==
X-Google-Smtp-Source: ABdhPJy+Ki2UcB85M7cmg6N2cXnI6BnYqdoO4MGh1FmXJbjDfu3Kim0yqIJcOlAozyxyyUHzQ+yH5Q==
X-Received: by 2002:aa7:db51:: with SMTP id n17mr6954268edt.222.1596792040872;
        Fri, 07 Aug 2020 02:20:40 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyum9863qf6si3v.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:2092:7f6b:4676:cab])
        by smtp.gmail.com with ESMTPSA id h9sm5592547ejt.50.2020.08.07.02.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:20:40 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 2/2 resend] iio:temperature:mlx90632: Adding extended calibration option
Date:   Fri,  7 Aug 2020 11:20:14 +0200
Message-Id: <20200807092014.967262-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For some time market wants medical grade accuracy in medical range,
while still retaining the declared accuracy outside of the medical range
within the same sensor. That is why we created extended calibration
which is automatically switched to when object temperature is too high.

This patch also introduces the object_ambient_temperature variable which
is needed for more accurate calculation of the object infra-red
footprint as sensor's ambient temperature might be totally different
than what the ambient temperature is at object and that is why we can
have some more error which can be eliminated. Currently this temperature
is fixed at 25, but interface to adjust it by user (with external sensor
or just IR measurement of the another object which acts as ambient),
will be introduced in another commit.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 219 ++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 763a148a0095..bb35a65bb9f0 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -58,6 +58,8 @@
 /* Control register address - volatile */
 #define MLX90632_REG_CONTROL	0x3001 /* Control Register address */
 #define   MLX90632_CFG_PWR_MASK		GENMASK(2, 1) /* PowerMode Mask */
+#define   MLX90632_CFG_MTYP_MASK		GENMASK(8, 4) /* Meas select Mask */
+
 /* PowerModes statuses */
 #define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
 #define MLX90632_PWR_STATUS_HALT MLX90632_PWR_STATUS(0) /* hold */
@@ -65,6 +67,18 @@
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
@@ -81,6 +95,8 @@
 /* Magic constants */
 #define MLX90632_ID_MEDICAL	0x0105 /* EEPROM DSPv5 Medical device id */
 #define MLX90632_ID_CONSUMER	0x0205 /* EEPROM DSPv5 Consumer device id */
+#define MLX90632_ID_EXTENDED	0x0505 /* EEPROM DSPv5 Extended range device id */
+#define MLX90632_ID_MASK	GENMASK(14, 0) /* DSP version and device ID in EE_VERSION */
 #define MLX90632_DSP_VERSION	5 /* DSP version */
 #define MLX90632_DSP_MASK	GENMASK(7, 0) /* DSP version in EE_VERSION */
 #define MLX90632_RESET_CMD	0x0006 /* Reset sensor (address or global) */
@@ -88,16 +104,20 @@
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
@@ -113,6 +133,7 @@ static const struct regmap_range mlx90632_read_reg_range[] = {
 	regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
 	regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
 	regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
+	regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
 	regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
 	regmap_reg_range(MLX90632_RAM_1(0),
 			 MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
@@ -199,6 +220,28 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
 	return (reg_status & MLX90632_STAT_CYCLE_POS) >> 2;
 }
 
+static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
+{
+	int ret;
+
+	if ((type != MLX90632_MTYP_MEDICAL) & (type != MLX90632_MTYP_EXTENDED))
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
+	mlx90632_pwr_continuous(regmap);
+
+	return ret;
+}
+
 static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
 				       uint8_t *channel_old)
 {
@@ -300,6 +343,106 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
 	return ret;
 }
 
+static int mlx90632_read_ambient_raw_extended(struct regmap *regmap,
+					      s16 *ambient_new_raw, s16 *ambient_old_raw)
+{
+	int ret;
+	unsigned int read_tmp;
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
+	return ret;
+}
+
+static int mlx90632_read_object_raw_extended(struct regmap *regmap, s16 *object_new_raw)
+{
+	int ret;
+	unsigned int read_tmp;
+	s32 read;
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
+	if (read > 32767 || read < -32768)
+		return -EINVAL;
+
+	*object_new_raw = (int16_t)read;
+
+	return ret;
+}
+
+static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *object_new_raw,
+					      s16 *ambient_new_raw, s16 *ambient_old_raw)
+{
+	s32 ret;
+	int tries = 4;
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
@@ -354,9 +497,23 @@ static s64 mlx90632_preprocess_temp_obj(s16 object_new_raw, s16 object_old_raw,
 	return div64_s64((tmp << 19ULL), 1000LL);
 }
 
+static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
+						 s16 ambient_old_raw, s16 Ka)
+{
+	s64 VR_IR, kKa, tmp;
+
+	kKa = ((s64)Ka * 1000LL) >> 10ULL;
+	VR_IR = (s64)ambient_old_raw * 1000000LL +
+		kKa * div64_s64(((s64)ambient_new_raw * 1000LL),
+			(MLX90632_REF_3));
+	tmp = div64_s64(
+			div64_s64((((s64)object_new_raw) * 1000000000000LL), MLX90632_REF_12),
+			VR_IR);
+	return div64_s64((tmp << 19ULL), 1000LL);
+}
+
 static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
-				      s32 P_T, s32 P_R, s32 P_G, s32 P_O,
-				      s16 Gb)
+				      s32 P_T, s32 P_R, s32 P_G, s32 P_O, s16 Gb)
 {
 	s64 Asub, Bsub, Ablock, Bblock, Cblock, AMB, sum;
 
@@ -423,6 +580,37 @@ static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
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
+	Tr4 = (div64_long(reflected, 10) + 27315) *
+		(div64_long(reflected, 10) + 27315) *
+		(div64_long(reflected, 10) + 27315) *
+		(div64_long(reflected, 10) + 27315);
+	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
+		(div64_s64(TAdut, 10000LL) + 27315) *
+		(div64_s64(TAdut, 10000LL)  + 27315) *
+		(div64_s64(TAdut, 10000LL) + 27315);
+	TaTr4 = Tr4 - div64_long(Tr4 - TAdut4, tmp_emi) * 1000;
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
@@ -470,6 +658,26 @@ static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
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
@@ -643,6 +851,7 @@ static int mlx90632_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	mlx90632->client = client;
 	mlx90632->regmap = regmap;
+	mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
 
 	mutex_init(&mlx90632->lock);
 	indio_dev->name = id->name;
@@ -662,12 +871,17 @@ static int mlx90632_probe(struct i2c_client *client,
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
@@ -679,6 +893,7 @@ static int mlx90632_probe(struct i2c_client *client,
 	}
 
 	mlx90632->emissivity = 1000;
+	mlx90632->object_ambient_temperature = 25000; /* 25 degrees Celsius */
 
 	pm_runtime_disable(&client->dev);
 	ret = pm_runtime_set_active(&client->dev);
-- 
2.25.1

