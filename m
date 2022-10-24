Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2AE609ED8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 12:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJXKUG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 06:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJXKUD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 06:20:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADDF1E3D1
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 03:20:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e18so29354038edj.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKIX86tukfZX7SehEOWRcAaz+poDAk3t4N2adIt2U9o=;
        b=GyxpjLnMlbNnY+WAvPlScVqbCM/junzQM76Y2NM5YzuqfXv3/uuue4vxh8d2LEkdyE
         wknULuc4g6tEE06yfeqkBeIIayCr90bIZJfxXhmChlVH+HYvqw2v70f7BhvRqp55/QLz
         mocKmv0zEbbd+a8gHwJEHI5xx2gcA6J4iTynHyeKqmogdMFseg8VzFqIbDFpVSdKpIgb
         2GX0v3162NXxXWi8iPe3woSOSmSxMBeQl3TzQobuqigaA8wcbcZe+Zz+JDePbMJNxTXF
         axBfqZ7UASbJFsZEtb/k+Lq+SrH+Codl1L2aUmgE1G9P4P/EOYQr2qVrJQ/KVSMRealZ
         itxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKIX86tukfZX7SehEOWRcAaz+poDAk3t4N2adIt2U9o=;
        b=H33tiC/2tWTtsnwOvuvKR5eEoa6CkASWPV2/8dCo2CtcNbDhhE932S5gHgLugupM+2
         KRbF24DUzV5TYtYmih7iwX9GayPSbdutotcAHccVKwGQq3d/0j+k+V12Eyw0O2JEl0OA
         Nrmt3ExBlBU1KClRnoDJHhBUM+Y8kqzWNLTJajkRDnLZBfJOk5Nv/pZRg361zB+yCfs9
         6jrxTHp8GJyQcLL58lr6sgx4uq2TAaWXVC9HZ0CuYVyPFU1OS7hEw9BAW+B/al2exCIl
         eCfpXBz43gwwfIkFGM04XhwKH5PjVpL/qRJiN0xYJ2jdvhfz+wmueSU+kw8z2e9YZXGn
         i7+g==
X-Gm-Message-State: ACrzQf1VO5EPv9kLTDztw5DmLjaYL17G1cY2eYuD5AFbs80aA7K/2P72
        ZlkVWTnkfFi5I8LGjgWX2a0D3Q==
X-Google-Smtp-Source: AMsMyM48vazLw2yZDGpPMj8Gjglh0ol6UthGiKHc8wTIUuvI4lFxyS4CIf5ZBL1EK9PagRvTzHL6+A==
X-Received: by 2002:aa7:c792:0:b0:453:98b7:213c with SMTP id n18-20020aa7c792000000b0045398b7213cmr29569790eds.159.1666606799609;
        Mon, 24 Oct 2022 03:19:59 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3w0d7spjutrgwc.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:d731:196c:34e4:734c])
        by smtp.gmail.com with ESMTPSA id da3-20020a056402176300b004615bea1d5bsm4929085edb.35.2022.10.24.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:19:58 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2] iio: temperature: mlx90632 Style alignment for the driver
Date:   Mon, 24 Oct 2022 12:19:44 +0200
Message-Id: <7a9cfcb76d74e2f293c4bb25cb07de7cc6b391d8.1666606700.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changing and aligning the overall style of the driver with the recent
reviews. There is no functional change, only type generalization and
moving to the reverse Christmas tree for variable declarations.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 65 +++++++++++++++++-------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 224db7513baa..a17fe5f4967a 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -219,11 +219,11 @@ static const struct regmap_config mlx90632_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
+static int mlx90632_pwr_set_sleep_step(struct regmap *regmap)
 {
 	struct mlx90632_data *data =
 		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
-	s32 ret;
+	int ret;
 
 	if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
 		return 0;
@@ -234,14 +234,14 @@ static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
 		return ret;
 
 	data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
-	return ret;
+	return 0;
 }
 
-static s32 mlx90632_pwr_continuous(struct regmap *regmap)
+static int mlx90632_pwr_continuous(struct regmap *regmap)
 {
 	struct mlx90632_data *data =
 		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
-	s32 ret;
+	int ret;
 
 	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS)
 		return 0;
@@ -252,7 +252,7 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
 		return ret;
 
 	data->powerstatus = MLX90632_PWR_STATUS_CONTINUOUS;
-	return ret;
+	return 0;
 }
 
 /**
@@ -444,8 +444,8 @@ static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
 static int mlx90632_read_ambient_raw(struct regmap *regmap,
 				     s16 *ambient_new_raw, s16 *ambient_old_raw)
 {
-	int ret;
 	unsigned int read_tmp;
+	int ret;
 
 	ret = regmap_read(regmap, MLX90632_RAM_3(1), &read_tmp);
 	if (ret < 0)
@@ -464,11 +464,11 @@ static int mlx90632_read_object_raw(struct regmap *regmap,
 				    int perform_measurement_ret,
 				    s16 *object_new_raw, s16 *object_old_raw)
 {
-	int ret;
 	unsigned int read_tmp;
-	s16 read;
-	u8 channel = 0;
 	u8 channel_old = 0;
+	u8 channel = 0;
+	s16 read;
+	int ret;
 
 	ret = mlx90632_channel_new_select(perform_measurement_ret, &channel,
 					  &channel_old);
@@ -503,7 +503,8 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
 				     s16 *ambient_new_raw, s16 *ambient_old_raw,
 				     s16 *object_new_raw, s16 *object_old_raw)
 {
-	s32 ret, measurement;
+	s32 measurement;
+	int ret;
 
 	mutex_lock(&data->lock);
 	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
@@ -512,24 +513,24 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
 
 	switch (data->powerstatus) {
 	case MLX90632_PWR_STATUS_CONTINUOUS:
-		measurement = mlx90632_perform_measurement(data);
-		if (measurement < 0) {
-			ret = measurement;
+		ret = mlx90632_perform_measurement(data);
+		if (ret < 0)
 			goto read_unlock;
-		}
+
 		break;
 	case MLX90632_PWR_STATUS_SLEEP_STEP:
-		measurement = mlx90632_perform_measurement_burst(data);
-		if (measurement < 0) {
-			ret = measurement;
+		ret = mlx90632_perform_measurement_burst(data);
+		if (ret < 0)
 			goto read_unlock;
-		}
+
 		break;
 	default:
 		ret = -EOPNOTSUPP;
 		goto read_unlock;
 	}
 
+	measurement = ret; /* If we came here ret holds the measurement position */
+
 	ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
 					ambient_old_raw);
 	if (ret < 0)
@@ -615,15 +616,21 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
 	if (ret < 0)
 		goto read_unlock;
 
-	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
+	switch (data->powerstatus) {
+	case MLX90632_PWR_STATUS_CONTINUOUS:
 		ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
 					50000, 800000, false, data);
 		if (ret)
 			goto read_unlock;
-	} else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
+		break;
+	case MLX90632_PWR_STATUS_SLEEP_STEP:
 		ret = mlx90632_perform_measurement_burst(data);
 		if (ret < 0)
 			goto read_unlock;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto read_unlock;
 	}
 
 	ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
@@ -640,9 +647,9 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
 static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
 				     s32 *reg_value)
 {
-	s32 ret;
 	unsigned int read;
 	u32 value;
+	int ret;
 
 	ret = regmap_read(regmap, reg_lsb, &read);
 	if (ret < 0)
@@ -806,12 +813,12 @@ static s32 mlx90632_calc_temp_object_extended(s64 object, s64 ambient, s64 refle
 
 static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
 {
-	s32 ret;
+	s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
 	s32 Ea, Eb, Fa, Fb, Ga;
 	unsigned int read_tmp;
-	s16 Ha, Hb, Gb, Ka;
-	s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
 	s64 object, ambient;
+	s16 Ha, Hb, Gb, Ka;
+	int ret;
 
 	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Ea, &Ea);
 	if (ret < 0)
@@ -885,11 +892,11 @@ static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
 
 static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
 {
-	s32 ret;
+	s16 ambient_new_raw, ambient_old_raw;
 	unsigned int read_tmp;
 	s32 PT, PR, PG, PO;
+	int ret;
 	s16 Gb;
-	s16 ambient_new_raw, ambient_old_raw;
 
 	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_R, &PR);
 	if (ret < 0)
@@ -1164,11 +1171,11 @@ static int mlx90632_enable_regulator(struct mlx90632_data *data)
 static int mlx90632_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-	struct iio_dev *indio_dev;
 	struct mlx90632_data *mlx90632;
+	struct iio_dev *indio_dev;
 	struct regmap *regmap;
-	int ret;
 	unsigned int read;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90632));
 	if (!indio_dev) {
-- 
2.34.1

