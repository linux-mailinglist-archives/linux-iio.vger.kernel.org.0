Return-Path: <linux-iio+bounces-14481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1559CA1635C
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 18:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B982D3A3795
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D041DFD8D;
	Sun, 19 Jan 2025 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNGBzgKd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7A15350B;
	Sun, 19 Jan 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307926; cv=none; b=iAL7b8GuQLd9Z4M5ms5wGz/XVW4QkHhXVSwZwab7NYC8PBq/g6m8vpb2YvEmW8o1kFyM9Tt/FDtJkg8ZpMToXMLzbvC+CmhTNhj7e1Z/MdyOfK1fQL683G5wMCx9fkJe1TDL9qlNyWXdzx285fLFPnLxws6KgrwXw05PDZP4xFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307926; c=relaxed/simple;
	bh=yUx0jU+a13IvjSM0IqnelCLfCdrYK4uIfAXReGUvlVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRFMq3HerxdwN9dXjyZ4UXmMvDv93D1st0l6d4VulbudLfYKe8dEq4ohGN2NWRekxh2Y9CnNf50zPFgvORY4mb4qQS/mRBhiETGFsTEuaYnJs4Jgay76z7Ezu68VvnnyyLozQhxlD4VBEKuvqTHwCPx5/gD7ZHaI0x5tqLiUwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNGBzgKd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so2891372f8f.1;
        Sun, 19 Jan 2025 09:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737307922; x=1737912722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W96YyxvLefuW5bSwIFKR4DQWdJ/E7oNWc2nAgNmkDnE=;
        b=MNGBzgKd9Qa6dClzV9srzMkiftdePN1dt7PeqO/nC1h9L9FU5sv9zPRNGGvurr/R+E
         cIrPCeQHWWOCzuI+9B/sdQEJ0GlDs+/2qkqHPrs+B2lRSq3sK2ImqDli8r+GWaAjxHtm
         FrTd+1j82Il072Ucnm7T8zOpV+DgyjqmfTpaldTksrBeWCPZi83gLG9tF4LxBs76XhYs
         IlWrTVk02vObfdXsUPiVEeLvD0Pu6dQaEiVoF8HOgOMUiCKWAwYF6JDNpTL9yL0WsqEH
         LKdh57FwzUNaQ26gRdOX64gjfnHT3WV9I0AH/l6RONSOFNI1PwxYmMOc08GoglErYhHL
         t1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737307922; x=1737912722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W96YyxvLefuW5bSwIFKR4DQWdJ/E7oNWc2nAgNmkDnE=;
        b=jEoE5b+yGDRJpmY60F3g/NaIR/iSjqcF9K+v3I5zY0RxgYqkCms/n3itwVn742TCeb
         9ih6i3aLIVSSzcm9y03sCot3ePb2plf+HcLjfK4oFQrfQZ/G4HgnFyanx8EXsylxREWp
         Uln6KCRTNhZU7ECOh45mh6C88v6LX+em4mqC3NgE0BTokL2+dBouena6Eiyk1Ynkw6vE
         vMIGlLDyTZY5AyiOGd9rs7BfKeBVnhIt4Geh0vkL1ElHreEdVzhceEw4gRjQZ0lLWCxO
         q68PycTW5syTdM8UXAy8bTq3Cj+F1OAP4LFDBZQtmX77ReigglJMlmh+4WwfqeB6c3Yg
         Z+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWIJGwU4mNUbxuk0qNPTufK/9KvU/eWruoIDXNdXnN+h6Cx673Z76nrUgCW0TfreqRosyMuhdvKs5ejISw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRyFJ1DlNprp+XDR84T2rzE0+eq+XppcPUlP9L3QAM8sKbb62
	bX2ALpn7lEWtX4qRHfYPiQdjHK+UiWR/VLdeUVNAW7azbxyccjXV
X-Gm-Gg: ASbGnctuHKMZ0d7jJ+Yh4BULVGOUlRNLbVnEF539x1rr0gsj3JeK5ZdYwIWSeduggGp
	F9xM3saA1uGRiA1u6vAnQ81/gman24rMMDMMnZ3Urjr23smrafARlyfjo9VITm9eut/8aEXLGv+
	D9DWVLtPGaYUrj8a397qS++8EFTqa287nhN8KOssLOtspkBfbdW3Ae96WoNVCRv0uVr3vKorSS+
	pjaSECu7AVDnm+W6Umu3Y9Wz50R+c5cvocdqomrP3xs+XfWBBsUxNVG4ThaLZhrwdKcf3uuZO10
	jJwSDuHSZFpinUvyGRHu6bIxgzzA9DBWCFPbsFRBgfN1eGsiZqHbt43GbEvHksGjjmxJKko1SNN
	Ny0wNOvxHXAKcf7vG
X-Google-Smtp-Source: AGHT+IH2Rck6xfQ8abBTFgNB1llsI9ikNLzB/k9stGOcb/JY1yUmqqoD64lCSBIV2hQ3tLAp4F46Kw==
X-Received: by 2002:a5d:47a3:0:b0:385:d852:29ed with SMTP id ffacd0b85a97d-38bf57a9853mr8304933f8f.36.1737307922486;
        Sun, 19 Jan 2025 09:32:02 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-ec17-b16a-8f4c-782f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:ec17:b16a:8f4c:782f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32221e2sm8299423f8f.36.2025.01.19.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 09:32:02 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 19 Jan 2025 18:31:58 +0100
Subject: [PATCH v2 1/4] iio: light: veml6030: extend regmap to support
 regfields
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250119-veml6030-scale-v2-1-6bfc4062a371@gmail.com>
References: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
In-Reply-To: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737307920; l=8598;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=yUx0jU+a13IvjSM0IqnelCLfCdrYK4uIfAXReGUvlVI=;
 b=a/1FIw0VNG2USKo5v2sPnDFvru0evj0KBb3cixDXG+LZda6rNM9xN/RI5QW94k2/CSZ2yWbQH
 4tN0Yk5wer+CBDbkhLW66o+DgQMcmjU8+F76Cf6WMENhgs02CHXARvC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Add support for regfields as well to simplify register operations,
taking into account the different fields for the veml6030/veml7700 and
veml6035.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 95 ++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 9b71825eea9bee2146be17ed2f30f5a8f7ad37e3..8e4eb8b0c19276635567d4eed74f4d402c3205fa 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -59,18 +59,31 @@
 #define VEML6035_INT_CHAN     BIT(3)
 #define VEML6035_CHAN_EN      BIT(2)
 
+/* Regfields */
+#define VEML6030_GAIN_RF      REG_FIELD(VEML6030_REG_ALS_CONF, 11, 12)
+#define VEML6030_IT_RF        REG_FIELD(VEML6030_REG_ALS_CONF, 6, 9)
+
+#define VEML6035_GAIN_RF      REG_FIELD(VEML6030_REG_ALS_CONF, 10, 12)
+
 enum veml6030_scan {
 	VEML6030_SCAN_ALS,
 	VEML6030_SCAN_WH,
 	VEML6030_SCAN_TIMESTAMP,
 };
 
+struct veml6030_rf {
+	struct regmap_field *it;
+	struct regmap_field *gain;
+};
+
 struct veml603x_chip {
 	const char *name;
 	const int(*scale_vals)[][2];
 	const int num_scale_vals;
 	const struct iio_chan_spec *channels;
 	const int num_channels;
+	const struct reg_field gain_rf;
+	const struct reg_field it_rf;
 	int (*hw_init)(struct iio_dev *indio_dev, struct device *dev);
 	int (*set_info)(struct iio_dev *indio_dev);
 	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
@@ -91,6 +104,7 @@ struct veml603x_chip {
 struct veml6030_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
+	struct veml6030_rf rf;
 	int cur_resolution;
 	int cur_gain;
 	int cur_integration_time;
@@ -330,17 +344,17 @@ static const struct regmap_config veml6030_regmap_config = {
 static int veml6030_get_intgrn_tm(struct iio_dev *indio_dev,
 						int *val, int *val2)
 {
-	int ret, reg;
+	int it_idx, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.it, &it_idx);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch ((reg >> 6) & 0xF) {
+	switch (it_idx) {
 	case 0:
 		*val2 = 100000;
 		break;
@@ -405,8 +419,7 @@ static int veml6030_set_intgrn_tm(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-					VEML6030_ALS_IT, new_int_time);
+	ret = regmap_field_write(data->rf.it, new_int_time);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't update als integration time %d\n", ret);
@@ -510,23 +523,22 @@ static int veml6030_set_als_gain(struct iio_dev *indio_dev,
 	struct veml6030_data *data = iio_priv(indio_dev);
 
 	if (val == 0 && val2 == 125000) {
-		new_gain = 0x1000; /* 0x02 << 11 */
+		new_gain = 0x01;
 		gain_idx = 3;
 	} else if (val == 0 && val2 == 250000) {
-		new_gain = 0x1800;
+		new_gain = 0x11;
 		gain_idx = 2;
 	} else if (val == 1 && val2 == 0) {
 		new_gain = 0x00;
 		gain_idx = 1;
 	} else if (val == 2 && val2 == 0) {
-		new_gain = 0x800;
+		new_gain = 0x01;
 		gain_idx = 0;
 	} else {
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-					VEML6030_ALS_GAIN, new_gain);
+	ret = regmap_field_write(data->rf.gain, new_gain);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't set als gain %d\n", ret);
@@ -544,30 +556,31 @@ static int veml6035_set_als_gain(struct iio_dev *indio_dev, int val, int val2)
 	struct veml6030_data *data = iio_priv(indio_dev);
 
 	if (val == 0 && val2 == 125000) {
-		new_gain = VEML6035_SENS;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS);
 		gain_idx = 5;
 	} else if (val == 0 && val2 == 250000) {
-		new_gain = VEML6035_SENS | VEML6035_GAIN;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS |
+				      VEML6035_GAIN);
 		gain_idx = 4;
 	} else if (val == 0 && val2 == 500000) {
-		new_gain = VEML6035_SENS | VEML6035_GAIN |
-			VEML6035_DG;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS |
+				      VEML6035_GAIN | VEML6035_DG);
 		gain_idx = 3;
 	} else if (val == 1 && val2 == 0) {
 		new_gain = 0x0000;
 		gain_idx = 2;
 	} else if (val == 2 && val2 == 0) {
-		new_gain = VEML6035_GAIN;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_GAIN);
 		gain_idx = 1;
 	} else if (val == 4 && val2 == 0) {
-		new_gain = VEML6035_GAIN | VEML6035_DG;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_GAIN |
+				      VEML6035_DG);
 		gain_idx = 0;
 	} else {
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-				 VEML6035_GAIN_M, new_gain);
+	ret = regmap_field_write(data->rf.gain, new_gain);
 	if (ret) {
 		dev_err(&data->client->dev, "can't set als gain %d\n", ret);
 		return ret;
@@ -581,17 +594,17 @@ static int veml6035_set_als_gain(struct iio_dev *indio_dev, int val, int val2)
 static int veml6030_get_als_gain(struct iio_dev *indio_dev,
 						int *val, int *val2)
 {
-	int ret, reg;
+	int gain, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.gain, &gain);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch ((reg >> 11) & 0x03) {
+	switch (gain) {
 	case 0:
 		*val = 1;
 		*val2 = 0;
@@ -617,17 +630,17 @@ static int veml6030_get_als_gain(struct iio_dev *indio_dev,
 
 static int veml6035_get_als_gain(struct iio_dev *indio_dev, int *val, int *val2)
 {
-	int ret, reg;
+	int gain, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.gain, &gain);
 	if (ret) {
 		dev_err(&data->client->dev,
-			"can't read als conf register %d\n", ret);
+				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch (FIELD_GET(VEML6035_GAIN_M, reg)) {
+	switch (gain) {
 	case 0:
 		*val = 1;
 		*val2 = 0;
@@ -990,6 +1003,27 @@ static int veml7700_set_info(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int veml6030_regfield_init(struct iio_dev *indio_dev)
+{
+	struct veml6030_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = &data->client->dev;
+	struct regmap_field *rm_field;
+	struct veml6030_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, data->chip->it_rf);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, data->chip->gain_rf);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->gain = rm_field;
+
+	return 0;
+}
+
 /*
  * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
  * persistence to 1 x integration time and the threshold
@@ -1143,6 +1177,11 @@ static int veml6030_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = veml6030_regfield_init(indio_dev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to init regfields\n");
+
 	ret = data->chip->hw_init(indio_dev, &client->dev);
 	if (ret < 0)
 		return ret;
@@ -1191,6 +1230,8 @@ static const struct veml603x_chip veml6030_chip = {
 	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
 	.channels = veml6030_channels,
 	.num_channels = ARRAY_SIZE(veml6030_channels),
+	.gain_rf = VEML6030_GAIN_RF,
+	.it_rf = VEML6030_IT_RF,
 	.hw_init = veml6030_hw_init,
 	.set_info = veml6030_set_info,
 	.set_als_gain = veml6030_set_als_gain,
@@ -1203,6 +1244,8 @@ static const struct veml603x_chip veml6035_chip = {
 	.num_scale_vals = ARRAY_SIZE(veml6035_scale_vals),
 	.channels = veml6030_channels,
 	.num_channels = ARRAY_SIZE(veml6030_channels),
+	.gain_rf = VEML6035_GAIN_RF,
+	.it_rf = VEML6030_IT_RF,
 	.hw_init = veml6035_hw_init,
 	.set_info = veml6030_set_info,
 	.set_als_gain = veml6035_set_als_gain,
@@ -1215,6 +1258,8 @@ static const struct veml603x_chip veml7700_chip = {
 	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
 	.channels = veml7700_channels,
 	.num_channels = ARRAY_SIZE(veml7700_channels),
+	.gain_rf = VEML6030_GAIN_RF,
+	.it_rf = VEML6030_IT_RF,
 	.hw_init = veml6030_hw_init,
 	.set_info = veml7700_set_info,
 	.set_als_gain = veml6030_set_als_gain,

-- 
2.43.0


