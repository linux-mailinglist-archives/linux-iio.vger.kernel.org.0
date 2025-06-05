Return-Path: <linux-iio+bounces-20253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADBACF97D
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 00:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12916189D283
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 22:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF9280008;
	Thu,  5 Jun 2025 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp4Vi5s/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FE27FD5D;
	Thu,  5 Jun 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161126; cv=none; b=qvY8bwXRniWOEzibSDZqleZTp26MC9WUDhR6yHsVoEUPqRjeEra+S5WgtxSjZNwxvikMSh+znN1w18A6vGFByeXaVJccXfFqIkPXP0fpJp4W1XuodttqbMyGqTMs7vcH33JG51grMhQvzNWIxvRCGu3CBN+8sE0Rn936mid/2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161126; c=relaxed/simple;
	bh=IT6dwHFuI7368Z0g3V3gB+9wMImV7d618u+1LBRTq0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVrd2YVeKVdjC6rwhkm2blw0loGW+jqRYHV74vhHJ5/b5Yh4ldp4aXIDvq6ouDml7BQbbnwsA1wUsBo0xKSF4c8uSB5MJfa5pALe0ZXY2W8xeu3GvwaLuz2qhvqjr5tdQmJSf+nfgxCb5Gy2Uww44H9SA6Mb2XuQS8+LYM/UAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dp4Vi5s/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a43d2d5569so17875981cf.0;
        Thu, 05 Jun 2025 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749161123; x=1749765923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3JRuAOu77h8yxGnW8/2hWnhRLq02MSFWcuiTFCeHa0=;
        b=dp4Vi5s/0gc7CwppfZD7dr/y2ITQylV30NOl3u4DhjZN6EPabDr4K6x5d4hPNP7aMm
         A0mXNgAcsBaZnGB7bWtuo1LJYgkgTf/lLd33OoJ76nZ/YwgP/T40QCaNGP1kpLOfzj8v
         IvaoLX6Z8npifI2+WGRwUy5XS5/pmOei4k2jmB3kZ9LMLdJ9aDWnHL2qwUW5azeURBu0
         vEuopntY2RIXZarBxlD3daA8tGVfnFDAb1iKhspFLdj+7mwjUBYRA65zISjYP3U+mGjI
         xYo76q2q0xkNHbNBDDfefTYBKe2n4Q/7QMY7mUF6l9Rh2eXANW1XW81TMiLM4VnRhoWc
         w7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749161123; x=1749765923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3JRuAOu77h8yxGnW8/2hWnhRLq02MSFWcuiTFCeHa0=;
        b=lurgiSYX2xOPZst0WytfmcuuGdfLoxcQqx1mdokDBQvEy72RD/cRgYhCVq8MQ+7FYA
         0CPMMPTQ1qRL5h/gDBr5C/CQbdQpEvM89oc0dDqYFMsNJ2qIw4ne3AZ3JDU/TYs9t91h
         kl6kSgWDql7SXR2YBaQAG9lcO/bGgSlwEjV/7FXaCJRfLjrnHKAuyhSbU65IND1ByAKM
         N2OD6D2N7lglv7+v+cr3G7bk++Zm28m/l/P2H4Di71wcuq3ZL8X9f8qDeYhbvltoVqMM
         hC4/GuAJM8maLjWDsqehZSNRl3cuy7GG4VaL2ptPn7K9wSY9WNY8mPNkqRocAB6pfgDT
         zGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUslX+jqvWtdtPjNPWTHvwEyQhaYu2gwyQt90oNsyc/Gk3Hk4PL1Ck58+LINfuu1I1X18wDneucDXRHkA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtE3ObLYQrMi3xEDYqiVEPOfBw/rg8ijqVveigs9Ke0FO4Iyy
	aCBOhI1qa/iJrahledL/VomgSkEMMrGD11JLtmsgif7A3ZRcv+upWZU3MHw6CIfF
X-Gm-Gg: ASbGncvrrtVRznfd3NrBxGh17ChyXAUXYi747dAEkoF/1pWH1MPzh1RqAKrRqt1k5p9
	T2rD/z0H++u7+RQhTI5Ra5i+pZ+cci5q07jkw5/dn0r0Ro4heglCOmpEvFkqRgAVypYF6b7FkWy
	37z/0F6XxXeMxo7cSaigL2mVlPzLjDSjFLQ+wRWZ0sq8HnB816FfBuTnV8D+qEzgR4F0TM1PVOq
	dQ1c7ty+G0CbYvud9VZTjeKXb79KN2IQnWZbPq9wxB/HV35A/d4GfeYh+67MsSOt+i25EFlW0kA
	rAVAhczgePJ4GXmY3+o3pWCPdvyKfyqK4cJxKY+udcby28qU8hpDg7jUC5BS
X-Google-Smtp-Source: AGHT+IGuBZYmsFUeECHAGgXMK8z9+vY20aDmHeBNnvS73Z5N0eBr9UteJhZUatP+X29wikNtKnukgg==
X-Received: by 2002:a05:620a:4710:b0:7c5:55f9:4bc1 with SMTP id af79cd13be357-7d2298ec24dmr174428385a.42.1749161122992;
        Thu, 05 Jun 2025 15:05:22 -0700 (PDT)
Received: from [192.168.0.9] ([2804:14d:90a8:477c:13e7:d349:8af8:5d32])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ebd219ec7sm288832241.24.2025.06.05.15.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 15:05:22 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Thu, 05 Jun 2025 19:05:03 -0300
Subject: [PATCH v2 3/3] iio: imu: bmi270: add support for motion events
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-bmi270-events-v2-3-8b2c07d0c213@gmail.com>
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
In-Reply-To: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749161110; l=15232;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=IT6dwHFuI7368Z0g3V3gB+9wMImV7d618u+1LBRTq0M=;
 b=irIq6S5IqYF5ZEIpSbelcKZyG85xMvViV5mPjAJaTye+R8W9EHbnC44afMV1PE5vbk9/r0BHn
 fyvzGUq57j0CRP+QrCXGqod38MyJiXYlYKSY4lCR7hnicKbFKlTH+Sh
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
 drivers/iio/imu/bmi270/bmi270_core.c | 318 ++++++++++++++++++++++++++++++++++-
 1 file changed, 309 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 0798eb1da3ecc3cecaf7d7d47214bb07f4ec294f..eb0cada50087ccecfd5624a531692873e396deb6 100644
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
@@ -443,6 +490,95 @@ static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
 	return 0;
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
@@ -618,6 +754,20 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
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
@@ -831,6 +981,20 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
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
@@ -839,6 +1003,10 @@ static int bmi270_write_event_config(struct iio_dev *indio_dev,
 	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return bmi270_anymotion_event_en(data, chan, state);
+	case IIO_EV_TYPE_ROC:
+		return bmi270_nomotion_event_en(data, state);
 	case IIO_EV_TYPE_CHANGE:
 		return bmi270_step_wtrmrk_en(data, state);
 	default:
@@ -852,21 +1020,58 @@ static int bmi270_read_event_config(struct iio_dev *indio_dev,
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
@@ -881,10 +1086,17 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
 	unsigned int raw;
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
@@ -897,6 +1109,31 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
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
+		return bmi270_update_feature_reg(data, reg,
+					 BMI270_FEAT_MOTION_THRESHOLD_MSK,
+				FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK,
+					raw));
+	case IIO_EV_INFO_PERIOD:
+		if (!in_range(val, 0, BMI270_MOTION_DURAT_MAX + 1))
+			return -EINVAL;
+
+		raw = BMI270_INT_MICRO_TO_RAW(val, val2,
+					BMI270_MOTION_DURAT_SCALE);
+		return bmi270_update_feature_reg(data, reg,
+						BMI270_FEAT_MOTION_DURATION_MSK,
+				FIELD_PREP(BMI270_FEAT_MOTION_DURATION_MSK,
+					raw));
+	default:
+		return -EINVAL;
+	}
 }
 
 static int bmi270_read_event_value(struct iio_dev *indio_dev,
@@ -908,12 +1145,18 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
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
@@ -925,6 +1168,29 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
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
@@ -934,6 +1200,22 @@ static const struct iio_event_spec bmi270_step_wtrmrk_event = {
 			       BIT(IIO_EV_INFO_VALUE),
 };
 
+static const struct iio_event_spec bmi270_anymotion_event = {
+	.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+	.dir = IIO_EV_DIR_RISING,
+	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			       BIT(IIO_EV_INFO_PERIOD),
+};
+
+static const struct iio_event_spec bmi270_nomotion_event = {
+	.type = IIO_EV_TYPE_ROC,
+	.dir = IIO_EV_DIR_RISING,
+	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			       BIT(IIO_EV_INFO_PERIOD),
+};
+
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
 	.write_raw = bmi270_write_raw,
@@ -942,6 +1224,7 @@ static const struct iio_info bmi270_info = {
 	.read_event_config = bmi270_read_event_config,
 	.write_event_value = bmi270_write_event_value,
 	.read_event_value = bmi270_read_event_value,
+	.event_attrs = &bmi270_event_attribute_group,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -961,6 +1244,8 @@ static const struct iio_info bmi270_info = {
 		.storagebits = 16,				\
 		.endianness = IIO_LE,				\
 	},	                                                \
+	.event_spec = &bmi270_anymotion_event,			\
+	.num_event_specs = 1,					\
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -1005,6 +1290,14 @@ static const struct iio_chan_spec bmi270_channels[] = {
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
@@ -1112,6 +1405,13 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
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


