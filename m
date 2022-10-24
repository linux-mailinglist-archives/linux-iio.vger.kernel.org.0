Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E384B609EE1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 12:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJXKWj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 06:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJXKWi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 06:22:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B65057DC4
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 03:22:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a15so7443125ljb.7
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HA6qy786JkRhakLWTf9Vd5z8poyqlUHoYYUsjIZqQ6o=;
        b=Q5B3x7xVG4WfCbUDdBJVsjzxZnXLpnlCY6oXKK6rQph3Z1w/iJArZM4KUGJNzuckRA
         Jp23/aNvgQJvT7FaFaT6dO1z43XZXGPR+ulqVHGNtnz+/OzRmH+PLEEOY0e5+vroRC2V
         QD4g9XpYvBr8+xAWZrHikpIBs0daiYspZh0UGLK17E+1eycg2gYeGoBWaYZED5ZdQ9x5
         VM4fzfyIbCJcwniJkk/byWZLT4N8bnjRlsp2XsEAIi6M/7GpRMItXSKiqKBTApPoyK0D
         8fy3SsepM+jNJ+34XeKvp/VeqHF8H8LqeW3VTCyWzdQcSrgJQWXkn4InSlFnZeOnQJNc
         lNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HA6qy786JkRhakLWTf9Vd5z8poyqlUHoYYUsjIZqQ6o=;
        b=cJbomXB+DdwciPO/xRSJTRuYi5HslQtU7OFm7ApJoOLy9WenwwrWPjyEJ8+nSC/FuQ
         WfnBoa1fhAyZ7k1GlbZTR9e6c9a3in9TYNHp7g9z6gfhu+LAHImr86RYSN1jsusCfGnK
         kuD7SE6hBtq00pepJKMrbAmVwogl10tWYhN31Zdx9XSyy6pYnQ8KUH1aEu9ox6Lzdfca
         qxhhFZSTAB4q6msvgxcS4jPbxKcvwmr+PY+xdSjlJTatW0H0FvyIz5LOReDAbUR8ZrZG
         dhpCpbOH7DyQew5W5vpqZWPNmUpHCMsqbBooVGdA9FUR2l+7655QnzL7v6qV7PQYNG+p
         kK9g==
X-Gm-Message-State: ACrzQf1As9iPUf3OCpAxx0Vo0uzjNNrIPbl28XOWTwDo2eBlVVHOOgxw
        3SVgX3ECHqkZHrczEYv7ZCFqxjN7ziJ8BNKr
X-Google-Smtp-Source: AMsMyM4d3vuFf5OWtsoSGTIfWThj6gZsYQRMGIlmm8kp00Zvx4WJBH4lkN+auWB+7ZjbbT3gGJZZhw==
X-Received: by 2002:a17:906:c08c:b0:78d:b8ce:c28f with SMTP id f12-20020a170906c08c00b0078db8cec28fmr26295343ejz.437.1666606944871;
        Mon, 24 Oct 2022 03:22:24 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3w0d7spjutrgwc.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:d731:196c:34e4:734c])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b0078ddb518a90sm15207695ejt.223.2022.10.24.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:22:24 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3] iio: temperature: mlx90632 Style alignment for the driver
Date:   Mon, 24 Oct 2022 12:22:05 +0200
Message-Id: <d59aad00891c1a64e044a0f5bc7d40e42d47e9c7.1666606912.git.cmo@melexis.com>
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

