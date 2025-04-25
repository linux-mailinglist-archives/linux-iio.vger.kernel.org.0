Return-Path: <linux-iio+bounces-18613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44EA9BBA9
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 02:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5541C7AFD02
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAF225D7;
	Fri, 25 Apr 2025 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDnnLBn1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEC1BC3F;
	Fri, 25 Apr 2025 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540110; cv=none; b=q5pkZktjU+BdXUOH+2NgqvC/a1cGlqGbszG2I68Bsd5xDml2trSjJKAP7uysAZZKdZxnjXWqkKa45/+Jjd+bCztNohCVeut4eAUAI00aYMhsOEcimKXZ+R54WspDlze8CK6prAFNpBiTOHCps1/hTtXC/WEkxa4mjmcq2Auu+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540110; c=relaxed/simple;
	bh=GxkfZBL3+JBHmybeeBC04odAus0uhAxbhMV3diS2clc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJqPFKzFHO8RMnkKGX84ErPKsp4qK0EgD3p8400BrcoaQKbA/0VL9Utd8a8JS/ILdAv4qUFWzPcDUgURNG+86uJ9z+jv9SQCaI1vPYGefKPw4RZQF4P8z3h3Uk0m22RLtpDmGSZrRVSOiGnnrUNe/jMQKXImzx5uY6m3DhCVvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDnnLBn1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso20529305ad.2;
        Thu, 24 Apr 2025 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745540107; x=1746144907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXViPwzj2FZuhGbILH1kWVaUulYxZzoaNpxLwhfR7U0=;
        b=hDnnLBn1nU5sXA34ovV7v+hM8yIu60HDL6/JzHG5yHxb0uvSaadPrXRHj6WP7n2m0E
         84uGW9ZCsEaJVigj8NTXZkKQ4sWaTCrueTap8NrEtjWzuCd6aHCtZ9C0o+Uomu+Awl8J
         JuSG+IISU8myp5FrQObXPhjq6pWvYWM8mK6YSd0bSmu7nSkyT5jsQaX1GVebtuoop2Cb
         ElHIDa5a2R0EoNuT95pixClamjbs8FFmnWvU8qc8sTtNWoFqOi9LvwV3amta+74mYxmq
         X/JwkWEv+jeqO/IpOYsv1JrLzWBr5UEJgI1bdR5Ajo2cEMnN2LeO+8Dm2nvn9nW1XnnM
         0qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540107; x=1746144907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXViPwzj2FZuhGbILH1kWVaUulYxZzoaNpxLwhfR7U0=;
        b=BAexamzMjjNqA9L6oGnXRWQ5FuUOpy0XPMudI+H21y8hOtznpPndcfyluOi4vdflc7
         jgXJjv1FHAM3A9qVLrg0yubwBm0zgR2gtI50noxqLtqbB6y++puUgKfqushbsnY4k4rD
         VtDjpk5xKqSkh+KlRoqp6GTqAf6e8WB8sdLy7qRT/oq1RxYmgwunvMdPgjx4h3hI6QKS
         4h06i/H/rG0v9Gk9ifcp1w9lU4E8XXboR6WHo1FZYUed+mj+fRQXxPX2lpQRO2SWBQoS
         sEZxlf6De7AFOHmHXx8d2uCF5DTlXmaU9QycKmCITq1G1myXtB5D/f9zMihk0OygiwcR
         luPg==
X-Forwarded-Encrypted: i=1; AJvYcCWiiA0BXXCCT9pflM9PPAdmOfve3T4jT+o3RSyujBrvcGkqHeoS4U3iPj/ZVdZnxaL7dtJo5o0/rT/LKKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxykms+aU5u91oye49lBlKUnZog4xz0kjnEKEhXqMKts7eHooMN
	rKtnWeOOJ5369r+NWO+ucNf+o0k0480GsKaAXMjuNs8hG6x3X+2JjJzC5DnK
X-Gm-Gg: ASbGncsSmpns4EAafpZnPkvRuyElQuAi413kX3dmHMxGGMvLaqRgtxOhMiSTqBWG9GZ
	yYPOhyz08Ey3x2caUmNL38m9lzLfmj5wVag1cjZeCOZsXmR9JMv1G1+QHqivtP8A7LI/DV1wkuG
	mqAAklwyc28kF9yDXd835kNQs95q1BmRV3wEpipA5Fncf/lXucysKcKWGEamQ/zTgG+dxMCy9oU
	njrnY7BrXMAST0/NsNfD7ZX5Gzffu6OEa8e+BEvvYVp4+GSKKPV4NnI77jAkQJwUCgjDwftxtfk
	iBJGXW/5AD7l/Gd2g5gel51j2hWIPD1k4WjVDdrVFt3zbtfGD4w=
X-Google-Smtp-Source: AGHT+IFOWv3z5EMfUZ9Whk2a4a0qzwE35lPoBasP6pmakoNOZKI5yFrPcoDp4ZSxhlkEX2iZ8k2w9w==
X-Received: by 2002:a17:902:f691:b0:22c:35c5:e30e with SMTP id d9443c01a7336-22dbf5e9defmr3973665ad.13.1745540107479;
        Thu, 24 Apr 2025 17:15:07 -0700 (PDT)
Received: from [192.168.0.110] ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbdf7bsm20035165ad.87.2025.04.24.17.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 17:15:07 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Thu, 24 Apr 2025 21:14:52 -0300
Subject: [PATCH 3/3] iio: imu: bmi270: add support for motion events
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-bmi270-events-v1-3-a6c722673e5f@gmail.com>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
In-Reply-To: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745540093; l=11166;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=GxkfZBL3+JBHmybeeBC04odAus0uhAxbhMV3diS2clc=;
 b=ZU/NwnOWvj//PHgf4Q3otjqoUqQSm+YI1HbVKcIZ13l5JIG+j6nYLntOw4rzDf7eEG9dIZeU8
 mV8E9sg9QFiCqh/T4r41yOCcvLLg+WVqg2GEgOjq943uh000pTeq80g
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Add support for any-motion/no-motion events based on acceleration slope
on each axis. Threshold and duration can be configured from userspace.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 230 ++++++++++++++++++++++++++++++++++-
 1 file changed, 229 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 07a24ed9a4edabeafd98a746ba09469f9e41c38a..57734f9cf5906aa77b7a14dfba793559a817c1e7 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -31,6 +31,8 @@
 
 #define BMI270_INT_STATUS_0_REG				0x1c
 #define BMI270_INT_STATUS_0_STEP_CNT_MSK		BIT(1)
+#define BMI270_INT_STATUS_0_NOMOTION_MSK		BIT(5)
+#define BMI270_INT_STATUS_0_MOTION_MSK			BIT(6)
 
 #define BMI270_INT_STATUS_1_REG				0x1d
 #define BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK		GENMASK(7, 6)
@@ -81,6 +83,8 @@
 #define BMI270_INT1_MAP_FEAT_REG			0x56
 #define BMI270_INT2_MAP_FEAT_REG			0x57
 #define BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK		BIT(1)
+#define BMI270_INT_MAP_FEAT_NOMOTION_MSK		BIT(5)
+#define BMI270_INT_MAP_FEAT_ANYMOTION_MSK		BIT(6)
 
 #define BMI270_INT_MAP_DATA_REG				0x58
 #define BMI270_INT_MAP_DATA_DRDY_INT1_MSK		BIT(2)
@@ -106,10 +110,25 @@
 #define BMI270_STEP_SC26_RST_CNT_MSK			BIT(10)
 #define BMI270_STEP_SC26_EN_CNT_MSK			BIT(12)
 
+#define BMI270_FEAT_MOTION_DURATION_MSK			GENMASK(12, 0)
+#define BMI270_FEAT_MOTION_XYZ_MSK			GENMASK(15, 13)
+#define BMI270_FEAT_MOTION_THRESHOLD_MSK		GENMASK(10, 0)
+#define BMI270_FEAT_MOTION_OUT_CONF_MSK			GENMASK(14, 11)
+#define BMI270_FEAT_MOTION_ENABLE_MSK			BIT(15)
+
+#define BMI270_MOTION_XYZ_MSK				GENMASK(2, 0)
+
+#define BMI270_MOTION_THRES_SCALE			GENMASK(10, 0)
+#define BMI270_MOTION_DURAT_SCALE			50
+
 /* See datasheet section 4.6.14, Temperature Sensor */
 #define BMI270_TEMP_OFFSET				11776
 #define BMI270_TEMP_SCALE				1953125
 
+#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) ((val) * (scale) + \
+						  ((val2) * (scale)) / MEGA)
+#define BMI270_RAW_TO_MICRO(raw, scale) ((((raw) % (scale)) * MEGA) / scale)
+
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
@@ -301,6 +320,13 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
 };
 
 enum bmi270_feature_reg_id {
+	/* Page 1 registers */
+	BMI270_ANYMO1_REG,
+	BMI270_ANYMO2_REG,
+	/* Page 2 registers */
+	BMI270_NOMO1_REG,
+	BMI270_NOMO2_REG,
+	/* Page 6 registers */
 	BMI270_SC_26_REG,
 };
 
@@ -310,6 +336,22 @@ struct bmi270_feature_reg {
 };
 
 static const struct bmi270_feature_reg bmi270_feature_regs[] = {
+	[BMI270_ANYMO1_REG] = {
+		.page = 1,
+		.addr = 0x3c,
+	},
+	[BMI270_ANYMO2_REG] = {
+		.page = 1,
+		.addr = 0x3e,
+	},
+	[BMI270_NOMO1_REG] = {
+		.page = 2,
+		.addr = 0x30,
+	},
+	[BMI270_NOMO2_REG] = {
+		.page = 2,
+		.addr = 0x32,
+	},
 	[BMI270_SC_26_REG] = {
 		.page = 6,
 		.addr = 0x32,
@@ -426,6 +468,72 @@ static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
 
 	set_mask_bits(&data->feature_events,
 		      BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, field_value);
+
+	return 0;
+}
+
+static int bmi270_motion_config_reg(enum iio_event_direction dir)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return BMI270_ANYMO1_REG;
+	case IIO_EV_DIR_FALLING:
+		return BMI270_NOMO1_REG;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_motion_event_en(struct bmi270_data *data,
+				  enum iio_event_direction dir, bool state)
+{
+	int ret, config1, config2, irq_reg;
+	int irq_msk, irq_field_val;
+
+	irq_reg = bmi270_int_map_reg(data->irq_pin);
+	if (irq_reg < 0)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		config1 = BMI270_ANYMO1_REG;
+		config2 = BMI270_ANYMO2_REG;
+		irq_msk = BMI270_INT_MAP_FEAT_ANYMOTION_MSK;
+		irq_field_val = FIELD_PREP(BMI270_INT_MAP_FEAT_ANYMOTION_MSK,
+					   state);
+		break;
+	case IIO_EV_DIR_FALLING:
+		config1 = BMI270_NOMO1_REG;
+		config2 = BMI270_NOMO2_REG;
+		irq_msk = BMI270_INT_MAP_FEAT_NOMOTION_MSK;
+		irq_field_val = FIELD_PREP(BMI270_INT_MAP_FEAT_NOMOTION_MSK,
+					   state);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	guard(mutex)(&data->mutex);
+	ret = bmi270_update_feature_reg(data, config1,
+					BMI270_FEAT_MOTION_XYZ_MSK,
+					FIELD_PREP(BMI270_FEAT_MOTION_XYZ_MSK,
+						   state ? BMI270_MOTION_XYZ_MSK : 0));
+	if (ret)
+		return ret;
+
+	ret = bmi270_update_feature_reg(data, config2,
+					BMI270_FEAT_MOTION_ENABLE_MSK,
+					FIELD_PREP(BMI270_FEAT_MOTION_ENABLE_MSK,
+						   state));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, irq_reg, irq_msk, irq_field_val);
+	if (ret)
+		return ret;
+
+	set_mask_bits(&data->feature_events, irq_msk, irq_field_val);
+
 	return 0;
 }
 
@@ -604,6 +712,20 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
 	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))
 		iio_trigger_poll_nested(data->trig);
 
+	if (FIELD_GET(BMI270_INT_STATUS_0_MOTION_MSK, status0))
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							     IIO_MOD_X_OR_Y_OR_Z,
+							     IIO_EV_TYPE_MAG,
+							     IIO_EV_DIR_RISING),
+			       timestamp);
+
+	if (FIELD_GET(BMI270_INT_STATUS_0_NOMOTION_MSK, status0))
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							     IIO_MOD_X_OR_Y_OR_Z,
+							     IIO_EV_TYPE_MAG,
+							     IIO_EV_DIR_FALLING),
+			       timestamp);
+
 	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))
 		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
 							     IIO_NO_MOD,
@@ -820,6 +942,20 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static IIO_CONST_ATTR(in_accel_mag_value_available, "[0.0 0.00049 1.0]");
+
+static IIO_CONST_ATTR(in_accel_mag_period_available, "[0.0 0.02 162.0]");
+
+static struct attribute *bmi270_event_attributes[] = {
+	&iio_const_attr_in_accel_mag_value_available.dev_attr.attr,
+	&iio_const_attr_in_accel_mag_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bmi270_event_attribute_group = {
+	.attrs = bmi270_event_attributes,
+};
+
 static int bmi270_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -828,6 +964,8 @@ static int bmi270_write_event_config(struct iio_dev *indio_dev,
 	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return bmi270_motion_event_en(data, dir, state);
 	case IIO_EV_TYPE_CHANGE:
 		return bmi270_step_wtrmrk_en(data, state);
 	default:
@@ -847,6 +985,17 @@ static int bmi270_read_event_config(struct iio_dev *indio_dev,
 	guard(mutex)(&data->mutex);
 
 	switch (chan->type) {
+	case IIO_ACCEL:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return FIELD_GET(BMI270_INT_MAP_FEAT_ANYMOTION_MSK,
+					 data->feature_events) ? 1 : 0;
+		case IIO_EV_DIR_FALLING:
+			return FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK,
+					 data->feature_events) ? 1 : 0;
+		default:
+			return -EINVAL;
+		}
 	case IIO_STEPS:
 		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
 				 data->feature_events) ? 1 : 0;
@@ -864,10 +1013,42 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
 	unsigned int raw;
+	int reg;
 
 	guard(mutex)(&data->mutex);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		reg = bmi270_motion_config_reg(dir);
+		if (reg < 0)
+			return -EINVAL;
+
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (!in_range(val, 0, 1))
+				return -EINVAL;
+
+			raw = BMI270_INT_MICRO_TO_RAW(val, val2,
+						      BMI270_MOTION_THRES_SCALE);
+
+			return bmi270_update_feature_reg(data, reg,
+				BMI270_FEAT_MOTION_THRESHOLD_MSK,
+				FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK,
+					   raw));
+		case IIO_EV_INFO_PERIOD:
+			if (!in_range(val, 0, 163))
+				return -EINVAL;
+
+			raw = BMI270_INT_MICRO_TO_RAW(val, val2,
+						      BMI270_MOTION_DURAT_SCALE);
+
+			return bmi270_update_feature_reg(data, reg,
+				BMI270_FEAT_MOTION_DURATION_MSK,
+				FIELD_PREP(BMI270_FEAT_MOTION_DURATION_MSK,
+					   raw));
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_CHANGE:
 		if (!in_range(val, 0, 20461))
 			return -EINVAL;
@@ -891,12 +1072,39 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
 	unsigned int raw;
+	int ret, reg;
 	u16 reg_val;
-	int ret;
 
 	guard(mutex)(&data->mutex);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		reg = bmi270_motion_config_reg(dir);
+		if (reg < 0)
+			return -EINVAL;
+
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = bmi270_read_feature_reg(data, reg, &reg_val);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMI270_FEAT_MOTION_THRESHOLD_MSK, reg_val);
+			*val = raw / BMI270_MOTION_THRES_SCALE;
+			*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_THRES_SCALE);
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_EV_INFO_PERIOD:
+			ret = bmi270_read_feature_reg(data, reg, &reg_val);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMI270_FEAT_MOTION_DURATION_MSK, reg_val);
+			*val = raw / BMI270_MOTION_DURAT_SCALE;
+			*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_DURAT_SCALE);
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_CHANGE:
 		ret = bmi270_read_feature_reg(data, BMI270_SC_26_REG, &reg_val);
 		if (ret)
@@ -917,6 +1125,23 @@ static const struct iio_event_spec bmi270_step_wtrmrk_event = {
 			       BIT(IIO_EV_INFO_VALUE),
 };
 
+static const struct iio_event_spec bmi270_accel_event[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
 	.write_raw = bmi270_write_raw,
@@ -925,6 +1150,7 @@ static const struct iio_info bmi270_info = {
 	.read_event_config = bmi270_read_event_config,
 	.write_event_value = bmi270_write_event_value,
 	.read_event_value = bmi270_read_event_value,
+	.event_attrs = &bmi270_event_attribute_group,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -944,6 +1170,8 @@ static const struct iio_info bmi270_info = {
 		.storagebits = 16,				\
 		.endianness = IIO_LE,				\
 	},	                                                \
+	.event_spec = bmi270_accel_event,			\
+	.num_event_specs = ARRAY_SIZE(bmi270_accel_event),	\
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\

-- 
2.49.0


