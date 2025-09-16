Return-Path: <linux-iio+bounces-24194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD614B7DC7E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D325E1BC82AB
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0F2D8383;
	Tue, 16 Sep 2025 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFissD2j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DC2D3EF8
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065821; cv=none; b=gezyH2QiCV6tv2/inINZAeJT3AsClkGun82nGMRPJsj+CLsCiY4XFdEgGYBRPgZL4qrJQ9bTMITFzXXPYBqLrB+z+3NpzbPcszwyPLvn9PhsFNP6vZt2XeDV4cmAHn5tIHSO2l0AAEBKNxwz4M9E55gMJrE84WbqQlQOwG00gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065821; c=relaxed/simple;
	bh=M1s1m3iq89uxSoc78wmRurFmWQynoYBHcX0VWF9o798=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+tPt7qiSBM5thEjPwOmTbxDKwf7Wvirk1wao+T/fTCDh25JuLjeiKzMM64oTrIRG1b0E69p2V3ESoaooVv3AdLW+QP2uBhQXYhC+9ecrVW3cBugnF4k2qFq0loUp3fgoWmfJGWGbU1SQeHOmucuJ5zhd8T635dSOrdRwqQaIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFissD2j; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-267facf9b58so4403145ad.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065819; x=1758670619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HePRzNs2UbkOt2+sPLTXgLhse/WALYkVHJtElcyX+vk=;
        b=MFissD2jpT+isOARLR02bMnJtRNsD4YPxiTqmG7Ysut4+EIB+Tu8co0SY2w5XfExoh
         Ww1StJdXyymYaCCTdtyCvpUJYJXFMOl0tvtocRbMfXbfXEkgPDg/N3fid6l3YNCEw3Ks
         017eTnt5IvKExghELoy7U1AcSKLwpZqu/3YPEgQBu9Sl2hk6836E3zaTe0UL1Q29RBry
         EHuoPu3hir3lkrWWyfe/nMkiaHviMdvpIwmi9dGabRof0E1N5229MEwsMJwZZjtIi3a/
         5RmIq0faH37yMeizCnaQnNJ/hHjCojXW5lN4GufrcvVO5E2I3V00w5dSo4dBWBw1UkTJ
         YaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065819; x=1758670619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HePRzNs2UbkOt2+sPLTXgLhse/WALYkVHJtElcyX+vk=;
        b=cbJZv0GQ4b+vRjwIFiD43IccXvaGNCdGI7pB77N1tCa2FEUhgib+imXWgtJljUF+NS
         KNxE72E3565PEBTNKVYMR0IQOOE+OtCq+PXPeF8epXRXZB74ySv4A0FiptMJwdym2IB2
         3u5DiqMpoJhEBPJGIlOhbjUFsyAdKCfabO/c3yXLAy8SkB6CQ+8Q3j8LG7JVKNJLLPhV
         qFtenwXpvMABxm76IfQFpINw43l9fwWkNfwMxqTIYSpH3gaD4wMOqxL3G6cktAhv4kSR
         RTV1nd1sUhNU8At1iQQSIbiSwzJtWr6PAS1MZ37Qcq7Cl6nb2tjNz6dUaZ8rMv8xwZO1
         YR2A==
X-Gm-Message-State: AOJu0YzZwh/5tueRYJP7PHWV14L3EoXLBshtUiNqQhLn8b3cc0A+VJrw
	nrUSwU+KvSNED4Z2QC+flxfrgAn1YupiSNvj9IdKIM1unbdOpOTDFpQ7
X-Gm-Gg: ASbGncvRkSCFeILiRvd2HN/lafwM3Xn7xAewFHyWzZEA3YUH+DPpYB84GC7o8w9I0+Q
	latZ3kBTKrfmaikQLMTKUAyURZR+jn8R8wr0RCfEwc/NDjE4JU5W/DUD+zDvxX+S6IBperot7R1
	Vt9d3eLd+V/YPFzhs6OIv3hDJ3zoosgZyJ84Q/y3IQ+F+Owp/RGRahIR+hf+BhfdVvayKURBkhz
	Lk0+OlJmaoSevbqHYWuZzYGoh8S5iK1aTfpth0WNCKy+lhpk0nAV/DyOf+cdyLyKH1aGVYGpnDa
	B9S5+clhYxTQysdf5wRpr0htpeSij21K/+gCJcm6Hm4INQbrpeFZmPeBdGO9zis0BoImHFsbLMv
	efJSNaZK1sHYEahNF8qXAw9ttSQ==
X-Google-Smtp-Source: AGHT+IFHtMRUGXeHJi3OLzDfgW8g8ODU5lFddtb8TBcAEPq4UOVSWpFXpYtCLxUE33vkxFluY3dfxg==
X-Received: by 2002:a17:902:e746:b0:25c:a9a0:ea4c with SMTP id d9443c01a7336-268137ee348mr566205ad.34.1758065818657;
        Tue, 16 Sep 2025 16:36:58 -0700 (PDT)
Received: from [192.168.1.135] ([2804:14d:90a8:4498::371])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b8eb4737sm10108298a12.9.2025.09.16.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:36:58 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Tue, 16 Sep 2025 20:38:23 -0300
Subject: [PATCH v6 1/2] iio: imu: bmi270: add support for motion events
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-bmi270-v6-1-6acd8d26a862@gmail.com>
References: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
In-Reply-To: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758065905; l=17419;
 i=gustavograzs@gmail.com; s=20250915; h=from:subject:message-id;
 bh=M1s1m3iq89uxSoc78wmRurFmWQynoYBHcX0VWF9o798=;
 b=P31oahiP9Aft1LnwCO1UdpWEIr9ls5wFSqV/DLz7nIKN/3/d8vN8hzyiH6REx8t24Ft55Pfsu
 rIVAwYvINbWA8NgfSvN+lrTASeyIV0xuw9uu7GpP8fL1ybeofOr0AZ+
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=kYkFqZEIlab+1AaYMvpqhTQxwPXcJiTXdMaBQbfORrg=

Any-motion event can be enabled on a per-axis basis and triggers a
combined event when motion is detected on any axis.

No-motion event is triggered if the rate of change on all axes falls
below a specified threshold for a configurable duration. A fake channel
is used to report this event.

Threshold and duration can be configured from userspace.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 381 +++++++++++++++++++++++++++++++++--
 1 file changed, 361 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 519f1c9d466dceb301b53efee905f1b8fc4468c0..2ad230788532c5bed1f18a4933b661e0807121f9 100644
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
@@ -827,6 +1005,39 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t in_accel_value_available_show(struct device *dev,
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
+static IIO_DEVICE_ATTR_RO(in_accel_value_available, 0);
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
@@ -835,6 +1046,10 @@ static int bmi270_write_event_config(struct iio_dev *indio_dev,
 	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return bmi270_anymotion_event_en(data, chan, state);
+	case IIO_EV_TYPE_ROC:
+		return bmi270_nomotion_event_en(data, state);
 	case IIO_EV_TYPE_CHANGE:
 		return bmi270_step_wtrmrk_en(data, state);
 	default:
@@ -848,21 +1063,55 @@ static int bmi270_read_event_config(struct iio_dev *indio_dev,
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
+		return !!FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, regval);
+	case IIO_ACCEL:
+		switch (type) {
+		case IIO_EV_TYPE_ROC:
+			return !!FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK, regval);
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
@@ -876,20 +1125,50 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
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
@@ -903,14 +1182,14 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
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
@@ -918,6 +1197,36 @@ static int bmi270_read_event_value(struct iio_dev *indio_dev,
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
@@ -929,6 +1238,20 @@ static const struct iio_event_spec bmi270_step_wtrmrk_event = {
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
@@ -937,6 +1260,7 @@ static const struct iio_info bmi270_info = {
 	.read_event_config = bmi270_read_event_config,
 	.write_event_value = bmi270_write_event_value,
 	.read_event_value = bmi270_read_event_value,
+	.event_attrs = &bmi270_event_attribute_group,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -956,6 +1280,8 @@ static const struct iio_info bmi270_info = {
 		.storagebits = 16,				\
 		.endianness = IIO_LE,				\
 	},	                                                \
+	.event_spec = &bmi270_anymotion_event,			\
+	.num_event_specs = 1,					\
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
@@ -1000,6 +1326,14 @@ static const struct iio_chan_spec bmi270_channels[] = {
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
@@ -1107,6 +1441,13 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
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


