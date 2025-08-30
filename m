Return-Path: <linux-iio+bounces-23445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BCAB3CAAB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B316F1BA3419
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FF274B57;
	Sat, 30 Aug 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQtkuK6z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7442727F4;
	Sat, 30 Aug 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756555104; cv=none; b=Xf9FiC/zEsN1xBT79xTpIw8+QU4upPkpOTibyrOJlhJsFmg/Vp4fmKUI+6aZGWuWWuIO/+pmCb+tMpNCpWq+bXMARO4typrSgKmNQxiZLcNT5Am596arCNvSYjpRqQDIRiyUntgJgJRFe00LAW4Ssu23B5+uygbxdN0tBejayqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756555104; c=relaxed/simple;
	bh=7P/4repeLjie9vKlpWA8+U/KncH4lzvmTejFloVn03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXmQKaZIrgl57OeHnyMe+Zf4BPc6aBPzk8Woz4TyYh5w965L9cJGf3XNtjz0MoirU54Wr6EZqxoIQxIAAUCpj8W16IrRbRvupT3lCqdIu/yfrKvI9QDh9Ebn/hCmsRc1REtRE3Ya5T4acV0wdeK8ASXxHBaR3GXjKrg/sSmh4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQtkuK6z; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b476c67c5easo2012987a12.0;
        Sat, 30 Aug 2025 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756555102; x=1757159902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLVZf04EAuzmhyE0U4JEbAzo+37yIc+g3kH0VezyIwU=;
        b=jQtkuK6zdJz7GyaTmV50vHYJ8cWbopf9k3rFNQ4w9aUCzaExR0BWvIIzY02naEnkPC
         pJorqRCoKuWgqPAF0N5M3AOezhL4gjP/lskkVQoBMxfqE/qxkEhwbq9CHcQkwead7vm5
         loWUMGzFYRjBnO/tnTZVNF1p5sk/CeS6IWq5pv87RWmCcZYkIpWCdcWnZsl2IOgHyKWE
         DQK25/zr7rLB4k/v7SmMRh+D5XSFrn2tAepTxZ8IqJTYo6jM5EwSVMknp9uIqPWCmSDU
         EXxDIuNimo83WfKtT26+ho3VeRMrJ8IigjSqYHZP1iQRMSXnPULW0d8HiwwxzjNoOZob
         w/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756555102; x=1757159902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLVZf04EAuzmhyE0U4JEbAzo+37yIc+g3kH0VezyIwU=;
        b=KnadfxgsZ1pxkhPi+e33F5Qw9su4yBgGmhjopjJqbAOif5xU9oNhs1bxt4LkkQS01h
         E+pstv8hxMOCFK/h5rtFng5AcFohvvxxMmTSZa+/uzJs4AE0wCxlaQuUWUksvNJ2bXPC
         0OsYYVp85+5ejyDtqi+xIUq45wm1NqpPCYvlOPIfW8/Y8lNydCsz2nX44zFW+0mLhI/3
         SuOW6JZ+ig292wByKWS7JdDPr4uCykz1zmT0/xdckE1nnH25c6WEBSUnsWEao4rrSfKe
         phdOCWh/7vKU0q0VLMCvywJEWzL9eGmBjzQ4DdHNOo1sNlbXZtecv6KYF3aKzAuUqRP7
         4J+g==
X-Forwarded-Encrypted: i=1; AJvYcCWKsviSyrgkUQbBOz2KYwCYiNmJaqN/yUZcSJqdZqBePJfLsvaZ7X11+K5S/vovOJNhi72cBVRXjkQnr7aq@vger.kernel.org, AJvYcCWYavigHWS7TR0cnsc1oEi6wxbMmyk85/klZabBoLKF+OzsySSf3ZV/RiXeRFy56um5Ot4GTdUiEsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRE0Amta3YDTAh4lh2ILBbAocE4yJXVf/kW6Xz2L56gnoZkiTf
	N2bRyXmOb6sm8Crb7PzirYyJkg4KDpfZGYu+Pm4wt1fFa0ZOsuYeiiBg
X-Gm-Gg: ASbGncsYfM5dUVM9zdKU9M74ofQ2cFwqu/6/ctvGSy6wA4rd23X7NSmvA+AxgcKUajl
	CQRnRCDIkMAog29RdJJVqxRytXU5dO9RIwerucbnZxLp0cuEuGGHNvhKzLWUi2WUwaODXqyC8W0
	FfKl7EcYA07jeVEg0YqkEcMF0E3dUJ2NNHRrbwdgIAx3PSDvf0eY/E37JWqV8Q1x+huSkE7sxrp
	HDXynD7zQhoyiutWy7SAeAbQW0GETebbM+0no9N5HrMtoWJg/PtMNgYdwv1584unDqWEfy2lmeV
	GLWwEw7GeqRzThGStFzu2eB9viz0WTaILxc33SNa1gJTZmbEIAuDXYFk+bg/T/sRgA3Z5E8eZeD
	gyfro95GIBm7X5A19XLZRkQ4rTPK181P1+KPjEw==
X-Google-Smtp-Source: AGHT+IG01W1rSHwb5Ck/w+yq90cqM7BPJPPLhMdgurHdIJZ8mJcm2a6kEtVQQjQINKENLtCGPpmeKg==
X-Received: by 2002:a17:902:f688:b0:248:aa0d:bb22 with SMTP id d9443c01a7336-249446d2aa2mr26808245ad.0.1756555102009;
        Sat, 30 Aug 2025 04:58:22 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498:a747:8dce:6184:1430])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906390b55sm50966595ad.97.2025.08.30.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:58:21 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Gustavo Silva <gustavograzs@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] iio: imu: bmi270: add support for motion events
Date: Sat, 30 Aug 2025 08:58:56 -0300
Message-ID: <20250830115858.21477-2-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250830115858.21477-1-gustavograzs@gmail.com>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any-motion event can be enabled on a per-axis basis and triggers a
combined event when motion is detected on any axis.

No-motion event is triggered if the rate of change on all axes falls
below a specified threshold for a configurable duration. A fake channel
is used to report this event.

Threshold and duration can be configured from userspace.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 384 +++++++++++++++++++++++++--
 1 file changed, 364 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 519f1c9d466d..714754160c2b 100644
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
@@ -106,6 +110,25 @@
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
+#define BMI270_MOTION_THRES_FULL_SCALE			GENMASK(10, 0)
+#define BMI270_MOTION_DURAT_SCALE			50
+#define BMI270_MOTION_DURAT_MAX				162
+
+/* 9.81 * 1000000 m/s^2 */
+#define BMI270_G_MICRO_M_S_2				9810000
+
 /* See datasheet section 4.6.14, Temperature Sensor */
 #define BMI270_TEMP_OFFSET				11776
 #define BMI270_TEMP_SCALE				1953125
@@ -114,6 +137,11 @@
 #define BMI270_STEP_COUNTER_FACTOR			20
 #define BMI270_STEP_COUNTER_MAX				20460
 
+#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
+	((val) * (scale) + ((val2) * (scale)) / MEGA)
+#define BMI270_RAW_TO_MICRO(raw, scale) \
+	((((raw) % (scale)) * MEGA) / scale)
+
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
@@ -309,6 +337,13 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
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
 
@@ -318,6 +353,22 @@ struct bmi270_feature_reg {
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
@@ -439,6 +490,121 @@ static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
 					     state));
 }
 
+static int bmi270_motion_reg(enum iio_event_type type, enum iio_event_info info)
+{
+	switch (info) {
+	case IIO_EV_INFO_PERIOD:
+		switch (type) {
+		case IIO_EV_TYPE_MAG_ADAPTIVE:
+			return BMI270_ANYMO1_REG;
+		case IIO_EV_TYPE_ROC:
+			return BMI270_NOMO1_REG;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_VALUE:
+		switch (type) {
+		case IIO_EV_TYPE_MAG_ADAPTIVE:
+			return BMI270_ANYMO2_REG;
+		case IIO_EV_TYPE_ROC:
+			return BMI270_NOMO2_REG;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
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
@@ -479,8 +645,6 @@ static int bmi270_get_scale(struct bmi270_data *data, int chan_type, int *scale,
 	unsigned int val;
 	struct bmi270_scale_item bmi270_scale_item;
 
-	guard(mutex)(&data->mutex);
-
 	switch (chan_type) {
 	case IIO_ACCEL:
 		ret = regmap_read(data->regmap, BMI270_ACC_CONF_RANGE_REG, &val);
@@ -614,6 +778,20 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
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
@@ -827,6 +1005,40 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t bmi270_show_accel_value_avail(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi270_data *data = iio_priv(indio_dev);
+	int ret, scale, uscale;
+	unsigned int step, max;
+
+	ret = bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);
+	if (ret)
+		return ret;
+
+	max = BMI270_G_MICRO_M_S_2 / uscale;
+	step = max / BMI270_MOTION_THRES_FULL_SCALE;
+
+	return sysfs_emit(buf, "[0 %u %u]\n", step, max);
+}
+
+static IIO_DEVICE_ATTR(in_accel_value_available, 0444,
+		       bmi270_show_accel_value_avail, NULL, 0);
+
+static IIO_CONST_ATTR(in_accel_period_available, "[0.0 0.02 162.0]");
+
+static struct attribute *bmi270_event_attributes[] = {
+	&iio_dev_attr_in_accel_value_available.dev_attr.attr,
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
@@ -835,6 +1047,10 @@ static int bmi270_write_event_config(struct iio_dev *indio_dev,
 	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return bmi270_anymotion_event_en(data, chan, state);
+	case IIO_EV_TYPE_ROC:
+		return bmi270_nomotion_event_en(data, state);
 	case IIO_EV_TYPE_CHANGE:
 		return bmi270_step_wtrmrk_en(data, state);
 	default:
@@ -848,21 +1064,57 @@ static int bmi270_read_event_config(struct iio_dev *indio_dev,
 				    enum iio_event_direction dir)
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
+	bool feat_en, axis_en;
 	int ret, reg, regval;
+	u16 motion_reg;
 
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
+		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, regval) ?
+									1 : 0;
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
 
-		ret = regmap_read(data->regmap, reg, &regval);
-		if (ret)
-			return ret;
-		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
-				 regval) ? 1 : 0;
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
+			return axis_en && feat_en;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -876,20 +1128,50 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 				    int val, int val2)
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
-	unsigned int raw;
+	unsigned int raw, mask, regval;
+	int ret, reg, scale, uscale;
+	u64 tmp;
 
 	guard(mutex)(&data->mutex);
 
-	switch (type) {
-	case IIO_EV_TYPE_CHANGE:
+	if (type == IIO_EV_TYPE_CHANGE) {
 		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))
 			return -EINVAL;
 
 		raw = val / BMI270_STEP_COUNTER_FACTOR;
-		return bmi270_update_feature_reg(data, BMI270_SC_26_REG,
-						 BMI270_STEP_SC26_WTRMRK_MSK,
-						 FIELD_PREP(BMI270_STEP_SC26_WTRMRK_MSK,
-							    raw));
+		mask = BMI270_STEP_SC26_WTRMRK_MSK;
+		regval = FIELD_PREP(BMI270_STEP_SC26_WTRMRK_MSK, raw);
+		return bmi270_update_feature_reg(data, BMI270_SC_26_REG, mask,
+						 regval);
+	}
+
+	reg = bmi270_motion_reg(type, info);
+	if (reg < 0)
+		return reg;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);
+		if (ret)
+			return ret;
+
+		if (!in_range(val, 0, (BMI270_G_MICRO_M_S_2 / uscale) + 1))
+			return -EINVAL;
+
+		tmp = (u64)val * BMI270_MOTION_THRES_FULL_SCALE * uscale;
+		raw = DIV_ROUND_CLOSEST_ULL(tmp, BMI270_G_MICRO_M_S_2);
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
 	default:
 		return -EINVAL;
 	}
@@ -903,14 +1185,14 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
 				   int *val, int *val2)
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
+	int ret, reg, scale, uscale;
 	unsigned int raw;
 	u16 regval;
-	int ret;
+	u64 tmp;
 
 	guard(mutex)(&data->mutex);
 
-	switch (type) {
-	case IIO_EV_TYPE_CHANGE:
+	if (type == IIO_EV_TYPE_CHANGE) {
 		ret = bmi270_read_feature_reg(data, BMI270_SC_26_REG, &regval);
 		if (ret)
 			return ret;
@@ -918,6 +1200,36 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
 		raw = FIELD_GET(BMI270_STEP_SC26_WTRMRK_MSK, regval);
 		*val = raw * BMI270_STEP_COUNTER_FACTOR;
 		return IIO_VAL_INT;
+	}
+
+	reg = bmi270_motion_reg(type, info);
+	if (reg < 0)
+		return reg;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = bmi270_read_feature_reg(data, reg, &regval);
+		if (ret)
+			return ret;
+
+		ret = bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);
+		if (ret)
+			return ret;
+
+		raw = FIELD_GET(BMI270_FEAT_MOTION_THRESHOLD_MSK, regval);
+		tmp = (u64)raw * BMI270_G_MICRO_M_S_2;
+		*val = DIV_ROUND_CLOSEST_ULL(tmp,
+					     BMI270_MOTION_THRES_FULL_SCALE * uscale);
+		return IIO_VAL_INT;
+	case IIO_EV_INFO_PERIOD:
+		ret = bmi270_read_feature_reg(data, reg, &regval);
+		if (ret)
+			return ret;
+
+		raw = FIELD_GET(BMI270_FEAT_MOTION_DURATION_MSK, regval);
+		*val = raw / BMI270_MOTION_DURAT_SCALE;
+		*val2 = BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_DURAT_SCALE);
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -929,6 +1241,20 @@ static const struct iio_event_spec bmi270_step_wtrmrk_event = {
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
@@ -937,6 +1263,7 @@ static const struct iio_info bmi270_info = {
 	.read_event_config = bmi270_read_event_config,
 	.write_event_value = bmi270_write_event_value,
 	.read_event_value = bmi270_read_event_value,
+	.event_attrs = &bmi270_event_attribute_group,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -956,6 +1283,8 @@ static const struct iio_info bmi270_info = {
 		.storagebits = 16,				\
 		.endianness = IIO_LE,				\
 	},	                                                \
+	.event_spec = &bmi270_anymotion_event,			\
+	.num_event_specs = 1,					\
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -1000,6 +1329,14 @@ static const struct iio_chan_spec bmi270_channels[] = {
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
@@ -1107,6 +1444,13 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
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
2.51.0


