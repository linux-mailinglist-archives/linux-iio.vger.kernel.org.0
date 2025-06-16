Return-Path: <linux-iio+bounces-20730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E3ADBDE1
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 01:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BBC18847F5
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 23:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBF238C0B;
	Mon, 16 Jun 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvoLCgA9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6ED136349;
	Mon, 16 Jun 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750118015; cv=none; b=rUpygiXJbAITj5ucg82LQoMzCSRtAfjwALkJcx6iZ+lh8qP69DGIetATX8cV6DThbNR8XBKp7P/yxcXYVNU8fbSebxQvNcHyTkGcv7Zf5TAmdBdq+1KgXQ8+IuTtKfBkgH1FcwmJpYBWnG3N9MK0UmICVXDV0hga+oJxGp5Ijw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750118015; c=relaxed/simple;
	bh=XWLbUKngwqkA525prCGnTIBOUfc/ESDsAa1TANtVX/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hub3RKJenf2EpM13POyU/ziNJCEwiXOIkAzM0rNGRMhHAMqK+GVNm3216if05dSkowO8nrkwVWt7rv9A/nnHYOfui+8yt+9iUnrPqAW4E7YFsBn80Z2mjg3qsl/iZh1IxkttzEczK54ycEFf6XW95SlU1sKy5mRy65MOE130CSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvoLCgA9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2352400344aso46311765ad.2;
        Mon, 16 Jun 2025 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750118012; x=1750722812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pSN9NUQ3la7t/FgqmWvBXqr5/Rl7A1XJVahioNEd/o=;
        b=PvoLCgA9k6aIVH6wcVrSH+wNCrOVy34silQd7xHyo+Zxu/6QsYqrvMysAN8N0YVL5t
         8M3tCTxOAo1TZpW/XMBgYFVJ6iA4/qP3Ke+WEACCJRHequwpDMXu+8HhtIpQrrWj3dIW
         PsCpEk2pa/48+/dfCMO4mKr8xRRX+6p3ReYCLAFiIrIM29GyiCuKbTkozUwk4Gb8i4QK
         gXmZ2wUUEktZ4tLlshT1YwJ5jucXc2VYPqkTfpTmIeubjB1YOo4Z9UbZmzpaAApic3fD
         tWHSSZ3IEigRWJTunnQSx+eAjzpyH4E/52e34kpiBAr4PDjGKgLK0yyY2AmCVH+Uv3fC
         tsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750118012; x=1750722812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pSN9NUQ3la7t/FgqmWvBXqr5/Rl7A1XJVahioNEd/o=;
        b=ZiH5Yr44cwLRdpq87NmzPufr5vhA1J+DkpXPM8342u5oum7jJdXcyB3LFCMkm9eCGt
         03UUa4At75yJU7YsgnlYRGyEbXDZnvL/NYiNZlYdBzuz5leX8wFfyBAmt48XFwTndMS7
         FiLwdygB7aDXXBsPqNe5NLhlZr8FTDEt5vILEDT6JxYc0fKAXvKrYWLM+2y9FabWHiMb
         MoubCql2NJRVhBvmj1iQO8ayC5q9WeUgnrj1MWwxp/A+jo1crVIwVy0zeQuV3bxXK1/n
         axzPIGBh00jciVAE9uY+I+hj7B9dyvLWxZhWiewPaoYNEJqFw7r5G6/0ZsTeQrLNIoqy
         HqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpvTM2uAGRQeBXL4wR//6U+tNEbQpmXojB0S1wl2tiB8U2EdPMy5kFLPWjUPJ/jJNngYfbNcuCrAkwqN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKP5mdnS2gv0T3qhfw01yY9uoLE6SV3uWuVPIOV0oiDWm8KMu
	X/TXR2i4JsJ2CxDhiG8VhEhNRia4env5+Y1BzyMRFJ5X5QZ2ocDzuHdm0qv2x7LB
X-Gm-Gg: ASbGnctEjOgHaRLUGv1LVUwc+RW5E0gLv6xvE/SYsklnb9g4bPTJKacN9jX4zwss1wr
	cQ2o/S3ADVrm/3G/jEJQbx5HYMs4TuNfnSXyqPj8TVUC9I5nWPviaMRG2fjb9Y3MIB4KE0poujf
	3YpcGj6geh/WW8XJrfSAWFUA3XNE66JOCMHJF0QxWIPCHIewawAtF3VmTzdG/If4apBx38FcBkJ
	xU1YX55k2WeBHtO2s2igZUF90NSJovMcPVMSgKgJ+ZZODyn+F8TJvedLG8htfQvusfTes6iyBy6
	FzyhwByMUDXLXUZ2Oxeako7zkaL8QpP9+uNPk1bkDcG8XJyXiHMSNYEHOewC7QWYyPaX3mQ=
X-Google-Smtp-Source: AGHT+IHMX7aAnZ9J/gpjZSMr47K9GOlCQ04YWkOTeJVuE5h/j/XnS6BhAycd6M1SKavj4N/BBVaydg==
X-Received: by 2002:a17:903:1246:b0:235:dd54:bce1 with SMTP id d9443c01a7336-2366afe7d67mr169712255ad.15.1750118012118;
        Mon, 16 Jun 2025 16:53:32 -0700 (PDT)
Received: from [192.168.0.9] ([2804:14d:90a8:477c:13e7:d349:8af8:5d32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782d3sm67515395ad.115.2025.06.16.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:53:31 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Mon, 16 Jun 2025 20:53:11 -0300
Subject: [PATCH v3 3/3] iio: imu: bmi270: add support for motion events
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-bmi270-events-v3-3-16e37588604f@gmail.com>
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
In-Reply-To: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lothar Rubusch <l.rubusch@gmail.com>, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750117999; l=15360;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=XWLbUKngwqkA525prCGnTIBOUfc/ESDsAa1TANtVX/g=;
 b=0+94yqN//yML0YoIjGGxYG8s0wcmZNv5vTNkd3QM/iK/FTwS04EIS6JZ/A4eNlQmE/j3CJfyb
 gC1NuhZKgZLCW7szImd8UiWD9J1GaDjWgFEBQJp1fsmMUAK9wkWOD5y
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Any-motion event can be enabled on a per-axis basis and triggers a
combined event when motion is detected on any axis.

No-motion event is triggered if the rate of change on all axes falls
below a specified threshold for a configurable duration. A fake channel
is used to report this event.

Threshold and duration can be configured from userspace.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 316 +++++++++++++++++++++++++++++++++--
 1 file changed, 306 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 7b632ec5b0108328c216a815535502f0078eb151..e54fb5f7a87f6f88e7eba8f81a15f703e48031b5 100644
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
@@ -106,6 +110,22 @@
 #define BMI270_STEP_SC26_RST_CNT_MSK			BIT(10)
 #define BMI270_STEP_SC26_EN_CNT_MSK			BIT(12)
 
+#define BMI270_FEAT_MOTION_DURATION_MSK			GENMASK(12, 0)
+#define BMI270_FEAT_MOTION_X_EN_MSK			BIT(13)
+#define BMI270_FEAT_MOTION_Y_EN_MSK			BIT(14)
+#define BMI270_FEAT_MOTION_Z_EN_MSK			BIT(15)
+#define BMI270_FEAT_MOTION_XYZ_EN_MSK			GENMASK(15, 13)
+#define BMI270_FEAT_MOTION_THRESHOLD_MSK		GENMASK(10, 0)
+#define BMI270_FEAT_MOTION_OUT_CONF_MSK			GENMASK(14, 11)
+#define BMI270_FEAT_MOTION_ENABLE_MSK			BIT(15)
+
+#define BMI270_MOTION_XYZ_MSK				GENMASK(2, 0)
+
+/* See pages 92 and 93 of the datasheet */
+#define BMI270_MOTION_THRES_SCALE			GENMASK(10, 0)
+#define BMI270_MOTION_DURAT_SCALE			50
+#define BMI270_MOTION_DURAT_MAX				162
+
 /* See datasheet section 4.6.14, Temperature Sensor */
 #define BMI270_TEMP_OFFSET				11776
 #define BMI270_TEMP_SCALE				1953125
@@ -114,6 +134,10 @@
 #define BMI270_STEP_COUNTER_FACTOR			20
 #define BMI270_STEP_COUNTER_MAX				20460
 
+#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) ((val) * (scale) + \
+						  ((val2) * (scale)) / MEGA)
+#define BMI270_RAW_TO_MICRO(raw, scale) ((((raw) % (scale)) * MEGA) / scale)
+
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
@@ -309,6 +333,13 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
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
 
@@ -318,6 +349,22 @@ struct bmi270_feature_reg {
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
@@ -439,6 +486,95 @@ static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
 					     state));
 }
 
+static int bmi270_anymotion_event_en(struct bmi270_data *data,
+				     struct iio_chan_spec const *chan,
+				     bool state)
+{
+	u16 axis_msk, axis_field_val, regval;
+	int ret, irq_reg;
+	bool axis_en;
+
+	irq_reg = bmi270_int_map_reg(data->irq_pin);
+	if (irq_reg < 0)
+		return irq_reg;
+
+	guard(mutex)(&data->mutex);
+
+	ret = bmi270_read_feature_reg(data, BMI270_ANYMO1_REG, &regval);
+	if (ret)
+		return ret;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		axis_msk = BMI270_FEAT_MOTION_X_EN_MSK;
+		axis_field_val = FIELD_PREP(BMI270_FEAT_MOTION_X_EN_MSK, state);
+		axis_en = FIELD_GET(BMI270_FEAT_MOTION_Y_EN_MSK, regval) |
+			  FIELD_GET(BMI270_FEAT_MOTION_Z_EN_MSK, regval);
+		break;
+	case IIO_MOD_Y:
+		axis_msk = BMI270_FEAT_MOTION_Y_EN_MSK;
+		axis_field_val = FIELD_PREP(BMI270_FEAT_MOTION_Y_EN_MSK, state);
+		axis_en = FIELD_GET(BMI270_FEAT_MOTION_X_EN_MSK, regval) |
+			  FIELD_GET(BMI270_FEAT_MOTION_Z_EN_MSK, regval);
+		break;
+	case IIO_MOD_Z:
+		axis_msk = BMI270_FEAT_MOTION_Z_EN_MSK;
+		axis_field_val = FIELD_PREP(BMI270_FEAT_MOTION_Z_EN_MSK, state);
+		axis_en = FIELD_GET(BMI270_FEAT_MOTION_X_EN_MSK, regval) |
+			  FIELD_GET(BMI270_FEAT_MOTION_Y_EN_MSK, regval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = bmi270_update_feature_reg(data, BMI270_ANYMO1_REG, axis_msk,
+					axis_field_val);
+	if (ret)
+		return ret;
+
+	ret = bmi270_update_feature_reg(data, BMI270_ANYMO2_REG,
+					BMI270_FEAT_MOTION_ENABLE_MSK,
+					FIELD_PREP(BMI270_FEAT_MOTION_ENABLE_MSK,
+						   state || axis_en));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, irq_reg,
+				  BMI270_INT_MAP_FEAT_ANYMOTION_MSK,
+				  FIELD_PREP(BMI270_INT_MAP_FEAT_ANYMOTION_MSK,
+					     state || axis_en));
+}
+
+static int bmi270_nomotion_event_en(struct bmi270_data *data, bool state)
+{
+	int ret, irq_reg;
+
+	irq_reg = bmi270_int_map_reg(data->irq_pin);
+	if (irq_reg < 0)
+		return irq_reg;
+
+	guard(mutex)(&data->mutex);
+
+	ret = bmi270_update_feature_reg(data, BMI270_NOMO1_REG,
+					BMI270_FEAT_MOTION_XYZ_EN_MSK,
+					FIELD_PREP(BMI270_FEAT_MOTION_XYZ_EN_MSK,
+						   state ? BMI270_MOTION_XYZ_MSK : 0));
+	if (ret)
+		return ret;
+
+	ret = bmi270_update_feature_reg(data, BMI270_NOMO2_REG,
+					BMI270_FEAT_MOTION_ENABLE_MSK,
+					FIELD_PREP(BMI270_FEAT_MOTION_ENABLE_MSK,
+						   state));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, irq_reg,
+				  BMI270_INT_MAP_FEAT_NOMOTION_MSK,
+				  FIELD_PREP(BMI270_INT_MAP_FEAT_NOMOTION_MSK,
+					     state));
+}
+
 static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 {
 	int i;
@@ -614,6 +750,20 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
 	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))
 		iio_trigger_poll_nested(data->trig);
 
+	if (FIELD_GET(BMI270_INT_STATUS_0_MOTION_MSK, status0))
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							     IIO_MOD_X_OR_Y_OR_Z,
+							     IIO_EV_TYPE_MAG_ADAPTIVE,
+							     IIO_EV_DIR_RISING),
+			       timestamp);
+
+	if (FIELD_GET(BMI270_INT_STATUS_0_NOMOTION_MSK, status0))
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							     IIO_MOD_X_AND_Y_AND_Z,
+							     IIO_EV_TYPE_ROC,
+							     IIO_EV_DIR_RISING),
+			       timestamp);
+
 	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))
 		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_STEPS, 0,
 							       IIO_EV_TYPE_CHANGE,
@@ -827,6 +977,20 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static IIO_CONST_ATTR(in_accel_value_available, "[0.0 0.00049 1.0]");
+
+static IIO_CONST_ATTR(in_accel_period_available, "[0.0 0.02 162.0]");
+
+static struct attribute *bmi270_event_attributes[] = {
+	&iio_const_attr_in_accel_value_available.dev_attr.attr,
+	&iio_const_attr_in_accel_period_available.dev_attr.attr,
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
@@ -835,6 +999,10 @@ static int bmi270_write_event_config(struct iio_dev *indio_dev,
 	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return bmi270_anymotion_event_en(data, chan, state);
+	case IIO_EV_TYPE_ROC:
+		return bmi270_nomotion_event_en(data, state);
 	case IIO_EV_TYPE_CHANGE:
 		return bmi270_step_wtrmrk_en(data, state);
 	default:
@@ -848,21 +1016,58 @@ static int bmi270_read_event_config(struct iio_dev *indio_dev,
 				    enum iio_event_direction dir)
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
-	int ret, reg, regval;
+	bool feat_en, axis_en;
+	unsigned int regval;
+	u16 motion_reg;
+	int ret, reg;
 
 	guard(mutex)(&data->mutex);
 
+	reg = bmi270_int_map_reg(data->irq_pin);
+	if (reg < 0)
+		return reg;
+
+	ret = regmap_read(data->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
 	switch (chan->type) {
 	case IIO_STEPS:
-		reg = bmi270_int_map_reg(data->irq_pin);
-		if (reg)
-			return reg;
-
-		ret = regmap_read(data->regmap, reg, &regval);
-		if (ret)
-			return ret;
 		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
 				 regval) ? 1 : 0;
+	case IIO_ACCEL:
+		switch (type) {
+		case IIO_EV_TYPE_ROC:
+			return FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK,
+					 regval) ? 1 : 0;
+		case IIO_EV_TYPE_MAG_ADAPTIVE:
+			ret = bmi270_read_feature_reg(data, BMI270_ANYMO1_REG,
+						      &motion_reg);
+			if (ret)
+				return ret;
+
+			feat_en = FIELD_GET(BMI270_INT_MAP_FEAT_ANYMOTION_MSK,
+					    regval);
+			switch (chan->channel2) {
+			case IIO_MOD_X:
+				axis_en = FIELD_GET(BMI270_FEAT_MOTION_X_EN_MSK,
+						    motion_reg);
+				break;
+			case IIO_MOD_Y:
+				axis_en = FIELD_GET(BMI270_FEAT_MOTION_Y_EN_MSK,
+						    motion_reg);
+				break;
+			case IIO_MOD_Z:
+				axis_en = FIELD_GET(BMI270_FEAT_MOTION_Z_EN_MSK,
+						    motion_reg);
+				break;
+			default:
+				return -EINVAL;
+			}
+			return (axis_en && feat_en) ? 1 : 0;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -876,11 +1081,18 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 				    int val, int val2)
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
-	unsigned int raw;
+	unsigned int raw, mask, regval;
+	int reg;
 
 	guard(mutex)(&data->mutex);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		reg = BMI270_ANYMO1_REG;
+		break;
+	case IIO_EV_TYPE_ROC:
+		reg = BMI270_NOMO1_REG;
+		break;
 	case IIO_EV_TYPE_CHANGE:
 		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))
 			return -EINVAL;
@@ -893,6 +1105,29 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 	default:
 		return -EINVAL;
 	}
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (!in_range(val, 0, 1))
+			return -EINVAL;
+
+		raw = BMI270_INT_MICRO_TO_RAW(val, val2,
+					      BMI270_MOTION_THRES_SCALE);
+		mask = BMI270_FEAT_MOTION_THRESHOLD_MSK;
+		regval = FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK, raw);
+		return bmi270_update_feature_reg(data, reg, mask, regval);
+	case IIO_EV_INFO_PERIOD:
+		if (!in_range(val, 0, BMI270_MOTION_DURAT_MAX + 1))
+			return -EINVAL;
+
+		raw = BMI270_INT_MICRO_TO_RAW(val, val2,
+					      BMI270_MOTION_DURAT_SCALE);
+		mask = BMI270_FEAT_MOTION_DURATION_MSK;
+		regval = FIELD_PREP(BMI270_FEAT_MOTION_DURATION_MSK, raw);
+		return bmi270_update_feature_reg(data, reg, mask, regval);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int bmi270_read_event_value(struct iio_dev *indio_dev,
@@ -904,12 +1139,18 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
 	unsigned int raw;
+	int ret, reg;
 	u16 regval;
-	int ret;
 
 	guard(mutex)(&data->mutex);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		reg = BMI270_ANYMO1_REG;
+		break;
+	case IIO_EV_TYPE_ROC:
+		reg = BMI270_NOMO1_REG;
+		break;
 	case IIO_EV_TYPE_CHANGE:
 		ret = bmi270_read_feature_reg(data, BMI270_SC_26_REG, &regval);
 		if (ret)
@@ -921,6 +1162,29 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
 	default:
 		return -EINVAL;
 	}
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = bmi270_read_feature_reg(data, reg, &regval);
+		if (ret)
+			return ret;
+
+		raw = FIELD_GET(BMI270_FEAT_MOTION_THRESHOLD_MSK, regval);
+		*val = raw / BMI270_MOTION_THRES_SCALE;
+		*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_THRES_SCALE);
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_EV_INFO_PERIOD:
+		ret = bmi270_read_feature_reg(data, reg, &regval);
+		if (ret)
+			return ret;
+
+		raw = FIELD_GET(BMI270_FEAT_MOTION_DURATION_MSK, regval);
+		*val = raw / BMI270_MOTION_DURAT_SCALE;
+		*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_DURAT_SCALE);
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
 }
 
 static const struct iio_event_spec bmi270_step_wtrmrk_event = {
@@ -929,6 +1193,20 @@ static const struct iio_event_spec bmi270_step_wtrmrk_event = {
 	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
 };
 
+static const struct iio_event_spec bmi270_anymotion_event = {
+	.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+	.dir = IIO_EV_DIR_RISING,
+	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_PERIOD),
+};
+
+static const struct iio_event_spec bmi270_nomotion_event = {
+	.type = IIO_EV_TYPE_ROC,
+	.dir = IIO_EV_DIR_RISING,
+	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_PERIOD),
+};
+
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
 	.write_raw = bmi270_write_raw,
@@ -937,6 +1215,7 @@ static const struct iio_info bmi270_info = {
 	.read_event_config = bmi270_read_event_config,
 	.write_event_value = bmi270_write_event_value,
 	.read_event_value = bmi270_read_event_value,
+	.event_attrs = &bmi270_event_attribute_group,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -956,6 +1235,8 @@ static const struct iio_info bmi270_info = {
 		.storagebits = 16,				\
 		.endianness = IIO_LE,				\
 	},	                                                \
+	.event_spec = &bmi270_anymotion_event,			\
+	.num_event_specs = 1,					\
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -1000,6 +1281,14 @@ static const struct iio_chan_spec bmi270_channels[] = {
 		.num_event_specs = 1,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel */
+		.event_spec = &bmi270_nomotion_event,
+		.num_event_specs = 1,
+	},
 };
 
 static int bmi270_int_pin_config(struct bmi270_data *data,
@@ -1107,6 +1396,13 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
 		return dev_err_probe(data->dev, ret,
 				     "Trigger registration failed\n");
 
+	/* Disable axes for motion events */
+	ret = bmi270_update_feature_reg(data, BMI270_ANYMO1_REG,
+					BMI270_FEAT_MOTION_XYZ_EN_MSK,
+					FIELD_PREP(BMI270_FEAT_MOTION_XYZ_EN_MSK, 0));
+	if (ret)
+		return ret;
+
 	data->irq_pin = irq_pin;
 
 	return 0;

-- 
2.49.0


