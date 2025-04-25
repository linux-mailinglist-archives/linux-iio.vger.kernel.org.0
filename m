Return-Path: <linux-iio+bounces-18611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9488CA9BBA5
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 02:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8F89A023C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05563111BF;
	Fri, 25 Apr 2025 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfXuIGvJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EC5680;
	Fri, 25 Apr 2025 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540102; cv=none; b=c8zpNkYpGOImfgA9kDByZPchWJtdo/xd1HEnvoLLQ5h3wANdetinLybR1V1WAaq/yfuvYG7wJ0oFDDB/vWn2DPF0Iwk3Dbd3TOz9+lo49rfhXpE5vfiD8IpVtEOsiM8Hp26heZrN5w9wBCaDClS5rFHaXwtQj3bPq3cOlEw+qgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540102; c=relaxed/simple;
	bh=LEH6DT/wn5jGkvB8nHGjnflhDNjglzGJsnEsmmfeOWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hc7SvcEVMuuTeY8f1bWZjV0rFfCNOSyGkh+4aROi26ELWkHW9oiWjGMQ4z9ZvvDn6rKh7tDtofvoTjLUjn0SDMXWt37DbNBLVAEVI1GNiM+Fr2rTtL/ZEUfWnAYrfFthKOo6gL2bXOGql3P6IW5CMPjHs/bOVATEuDz4GynxS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfXuIGvJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2241053582dso25636175ad.1;
        Thu, 24 Apr 2025 17:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745540100; x=1746144900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MoUJYDZ/SRmAVUICYgMxGdg0xy9MgQEIECVATWiFcY=;
        b=SfXuIGvJ6Cp9sLWr5jMMKRvHkwij7E9Xphs7Ppp8ChYyVYOlB374rNmN4c6LvaAN/i
         4WVbCNvM728QrNNqZ7nbI/oxjp5xxPFauV2WxbMsC5XbfhXV50TKv7db9rt5Ww6C9dEg
         K6nNkPkBTRcXHkG5IUWVp7Ba3IE+CvGSGLKFHzymjlEJDMteFr5sJhcWiosJPWGAkMk3
         seE17dnNi17hikNoLM31RUzd9QXPYihkJfSk7ANghIWwwgEonkbqkFjd03yl/drBiqH9
         KPYPB/fvOqGS++333iQWQN3j7UT702dagEPPpi/i9Yy3kBUaTtOTYYEGC2/FQ4Gumsp0
         1iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540100; x=1746144900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MoUJYDZ/SRmAVUICYgMxGdg0xy9MgQEIECVATWiFcY=;
        b=wIe3lcwpAWN/N0n6u3QgXK3KzkOAw4czcwSwCoXdaCPmp+SsQNcPvC8as6lXyDOiId
         rP+Cc4o1p4oS4+ggxv8XuV3mi6h05CpsG/QTbDNs4sfN7TE3Whdu82xe8sJAVgvEbslt
         3joO/zdMZEXe4BiMUNg6fBcZQcKYoqv/ed2kT/ZiVd4XerQ4zPTtmMWo17Xy1GpNZTXu
         Uszz7EIpgKf+e1y9dk+W+0Jdpc47zuJ0UwblWNXj8B0x+bxrtemz0nrG+uUHlmqoCPow
         CK+JVaOsg9B3QWHW1WknJGNn6KI1kGGAHftzk4nm6120h2jJonAym9WbyajoZGYc8Qu2
         LH0A==
X-Forwarded-Encrypted: i=1; AJvYcCVAAO7raU7klbNKsIu99AR/Kpw9m2AwEUUs+utxV9Tr48KipHzuig/ngr0PDGbavsGFwto0hl6iRcaiav4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+UB8H9dJtFiNcSb9rggsUxWWxKq+EuhZn5NaX8WaJFp2YUue
	xHmxk2ap38YzFIY9Q0Y53SIeFF/XgKZp3UIeGilBkRQNXqoMGH4gCVNNCpGQ
X-Gm-Gg: ASbGnctm3EmmkDfzbLYtpePG0tMsiGpBGsNxBxNZXKYBFWpjEBNQitLrrlDZdUIzD/D
	8XYSey+4jxeh1hXlG3lSKAtsgXtiCNMS0WyUmLBx6XkJuMATsnp0OYmlCs3LHANwJM/5w0ry6PJ
	luDsGWGdPGvfbDZS3VsXxNc7BN3FCvbmNlfC7f2i0Awip/kHL2kR3ajdk2oNp5PSWXw7V4bfFPF
	WN7Ef6yOT0/np9Z6YRuiS1oueL8dsevXYp8d4qFpybQ/dxoCtegPbyrSp+ZccAH97ZhEys/Pg9n
	SqFEw+JvkI76ZPClUdQQ7QKOEoTlYZKzMj4ADgpji/R9lcXRs94=
X-Google-Smtp-Source: AGHT+IGi2/pFYaOAnRZ0D8zuO91uDzurcutU9R2dI6c0ESHw/lSvH7oOdqOqMZE6PT0lOu9u2MjARw==
X-Received: by 2002:a17:902:d501:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22dbf6409eemr4109745ad.43.1745540100170;
        Thu, 24 Apr 2025 17:15:00 -0700 (PDT)
Received: from [192.168.0.110] ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbdf7bsm20035165ad.87.2025.04.24.17.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 17:14:59 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Thu, 24 Apr 2025 21:14:50 -0300
Subject: [PATCH 1/3] iio: imu: bmi270: add channel for step counter
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
In-Reply-To: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745540093; l=5828;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=LEH6DT/wn5jGkvB8nHGjnflhDNjglzGJsnEsmmfeOWc=;
 b=CjzvHNUITCNkbk4YCp6BapasmezvRl49dB64oh8Z303EAK3Lxp+qITpK6VTWYWRFRYcNC6lIM
 4hcVY/M0oBxBoKL63ciltPI+/KAn5e0pY92sCvvYX1YP1Wg6iXUzShS
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Add a channel for enabling/disabling the step counter, reading the
number of steps and resetting the counter.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 127 +++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..f09d8dead9df63df5ae8550cf473b5573374955b 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -31,6 +31,8 @@
 #define BMI270_INT_STATUS_1_REG				0x1d
 #define BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK		GENMASK(7, 6)
 
+#define BMI270_SC_OUT_0_REG				0x1e
+
 #define BMI270_INTERNAL_STATUS_REG			0x21
 #define BMI270_INTERNAL_STATUS_MSG_MSK			GENMASK(3, 0)
 #define BMI270_INTERNAL_STATUS_MSG_INIT_OK		0x01
@@ -39,6 +41,8 @@
 
 #define BMI270_TEMPERATURE_0_REG			0x22
 
+#define BMI270_FEAT_PAGE_REG				0x2f
+
 #define BMI270_ACC_CONF_REG				0x40
 #define BMI270_ACC_CONF_ODR_MSK				GENMASK(3, 0)
 #define BMI270_ACC_CONF_ODR_100HZ			0x08
@@ -90,6 +94,9 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+#define BMI270_STEP_SC26_RST_CNT_MSK			BIT(10)
+#define BMI270_STEP_SC26_EN_CNT_MSK			BIT(12)
+
 /* See datasheet section 4.6.14, Temperature Sensor */
 #define BMI270_TEMP_OFFSET				11776
 #define BMI270_TEMP_SCALE				1953125
@@ -111,6 +118,7 @@ struct bmi270_data {
 	struct iio_trigger *trig;
 	 /* Protect device's private data from concurrent access */
 	struct mutex mutex;
+	int steps_enabled;
 
 	/*
 	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
@@ -282,6 +290,99 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
 	},
 };
 
+enum bmi270_feature_reg_id {
+	BMI270_SC_26_REG,
+};
+
+struct bmi270_feature_reg {
+	u8 page;
+	u8 addr;
+};
+
+static const struct bmi270_feature_reg bmi270_feature_regs[] = {
+	[BMI270_SC_26_REG] = {
+		.page = 6,
+		.addr = 0x32,
+	},
+};
+
+static int bmi270_write_feature_reg(struct bmi270_data *data,
+				    enum bmi270_feature_reg_id id,
+				    u16 val)
+{
+	const struct bmi270_feature_reg *reg = &bmi270_feature_regs[id];
+	int ret;
+
+	ret = regmap_write(data->regmap, BMI270_FEAT_PAGE_REG, reg->page);
+	if (ret)
+		return ret;
+
+	return regmap_bulk_write(data->regmap, reg->addr, &val, sizeof(val));
+}
+
+static int bmi270_read_feature_reg(struct bmi270_data *data,
+				   enum bmi270_feature_reg_id id,
+				   u16 *val)
+{
+	const struct bmi270_feature_reg *reg = &bmi270_feature_regs[id];
+	int ret;
+
+	ret = regmap_write(data->regmap, BMI270_FEAT_PAGE_REG, reg->page);
+	if (ret)
+		return ret;
+
+	return regmap_bulk_read(data->regmap, reg->addr, val, sizeof(*val));
+}
+
+static int bmi270_update_feature_reg(struct bmi270_data *data,
+				     enum bmi270_feature_reg_id id,
+				     u16 mask, u16 val)
+{
+	u16 reg_val;
+	int ret;
+
+	ret = bmi270_read_feature_reg(data, id, &reg_val);
+	if (ret)
+		return ret;
+
+	set_mask_bits(&reg_val, mask, val);
+
+	return bmi270_write_feature_reg(data, id, reg_val);
+}
+
+static int bmi270_enable_steps(struct bmi270_data *data, int val)
+{
+	int ret;
+
+	guard(mutex)(&data->mutex);
+	if (data->steps_enabled == val)
+		return 0;
+
+	ret = bmi270_update_feature_reg(data, BMI270_SC_26_REG,
+					BMI270_STEP_SC26_EN_CNT_MSK,
+					FIELD_PREP(BMI270_STEP_SC26_EN_CNT_MSK,
+						   val ? 1 : 0));
+	if (ret)
+		return ret;
+
+	data->steps_enabled = val;
+	return 0;
+}
+
+static int bmi270_read_steps(struct bmi270_data *data, int *val)
+{
+	__le16 steps_count;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMI270_SC_OUT_0_REG, &steps_count,
+			       sizeof(steps_count));
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(le16_to_cpu(steps_count), 15);
+	return IIO_VAL_INT;
+}
+
 static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 {
 	int i;
@@ -551,6 +652,8 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		return bmi270_read_steps(data, val);
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
@@ -571,6 +674,10 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = bmi270_get_odr(data, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_ENABLE:
+		scoped_guard(mutex, &data->mutex)
+			*val = data->steps_enabled;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -596,6 +703,20 @@ static int bmi270_write_raw(struct iio_dev *indio_dev,
 		ret = bmi270_set_odr(data, chan->type, val, val2);
 		iio_device_release_direct(indio_dev);
 		return ret;
+	case IIO_CHAN_INFO_ENABLE:
+		return bmi270_enable_steps(data, val);
+	case IIO_CHAN_INFO_PROCESSED: {
+		guard(mutex)(&data->mutex);
+
+		if (val || !data->steps_enabled)
+			return -EINVAL;
+
+		/* Clear step counter value */
+		return bmi270_update_feature_reg(data, BMI270_SC_26_REG,
+						 BMI270_STEP_SC26_RST_CNT_MSK,
+						 FIELD_PREP(BMI270_STEP_SC26_RST_CNT_MSK,
+							    1));
+	}
 	default:
 		return -EINVAL;
 	}
@@ -698,6 +819,12 @@ static const struct iio_chan_spec bmi270_channels[] = {
 				      BIT(IIO_CHAN_INFO_OFFSET),
 		.scan_index = -1, /* No buffer support */
 	},
+	{
+		.type = IIO_STEPS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
+				      BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = -1, /* No buffer support */
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 

-- 
2.49.0


