Return-Path: <linux-iio+bounces-20251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2355ACF979
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 00:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244003B01AE
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166E27FD4A;
	Thu,  5 Jun 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhBbv7tt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7652798FF;
	Thu,  5 Jun 2025 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161120; cv=none; b=D5+5isodtnRuOVXrXmoN1EYvwKgr5G+pcEtW1SuewrowUJWjM9G/HlJ8yYKm9ziw28MbzuMjmrT5jKO1Tf55j8u+pRu1XMJm3TOLmgv4gf4z+Dw2syg+gk5jg9ml/BU8tLicJhSBKLrxoCstACjMqmNaqY83T2RfMjVOUu+YiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161120; c=relaxed/simple;
	bh=RxmGj3cLgdbs5Ik4JNJy/VqorzTfaela/azmgcDCe/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNCZ58xZj/JkjCkx3eUKhjSs0xhtO6iE7JG4BAbmN1REDWqfuMhKxIIkyq4a4oQkFXkQl6Yx5xjPkcTUnput81VZxdFylvsZ68+bpImhhIrezzBD+qDI8OzGdCgxGd5nXkxB1NM1ki+36fYCvjYUpdaksT9kT9mhaUXkKXVWoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhBbv7tt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so174801185a.1;
        Thu, 05 Jun 2025 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749161117; x=1749765917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MiMGxV2jWR8/i9184McqnJYXKRSk3rQnXnSKI46+mQ=;
        b=IhBbv7ttPabaJlPEHndlZmYNtWImi4VVy2EDzdgINGnCk0cbH9DLw3WwHfTFDQqAeV
         mZsOV+uwJxU8rFjSiQoDxM/o3sNrDvB2YX1poCPTw1NqrNvolRXmuaa407+y59hX2wrk
         3IWHMF7F1tRnY/Uxj5h8cPGKprKItsbXfWirs3AF3Jq37vA6thODitqO14yt+9uBsXAW
         hlVmQU8V/BB8Vp8aZo/7jXsuSAXGXcPDeSLiICgFQOcXbkbLKxlBRttjf20pqU2RdDPv
         99CRwMQJXY79OBdZWL0b3VKRnFHhL74fQhhfxg4afOkEPf6jwDcudD8f1N/ZQOCGsrLd
         ADug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749161117; x=1749765917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MiMGxV2jWR8/i9184McqnJYXKRSk3rQnXnSKI46+mQ=;
        b=hQg0Dw08aW1iQVI76pQx6oGRe87I8vMpTQMFkjK8IqLU8r48/5kyZ+1dzFuIuhlbW4
         2cPASFLTDvmZn8+PP+pzhUJwuFfUJHufnCOI2O0bwThimnDKMo2hPpKq3FGzvfouCCNs
         i6/WF+CzArmCFFxpDaBkGmvlJyv4SvMnmpqUh280VR9FqvpcBogCafVHws0scNuUNm3q
         N8JkhYHGKpJOwu/Un2EqIl/vBCext/EiWU+H28vPZ3EdK1d5qB7rDjFYyxR+l0FqWlMF
         LqsVKS7ktvHuBiXwkQMuyCM3kdb/tGK2KTSmwnVC2IZjn84mKCXPhi+2GduCOHZRR2zk
         RwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsYyT73dFOdPqG2QhaspaS0yMqTp2Fe6BhrkCpag3MgCWDneEGrnzyynDKjE/6OJfk/qXXo44e0cCv7k4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb34JPvWsnsNv0etZxZ51kjWRDeXozqefcRFHoqrRHgBrC3pWp
	3XYbXu7MYqB1+B389yDzEdg0QRIMgE/Ow5Abt6gbhcHoNrPl0ebOAHtmlyJlrg+L
X-Gm-Gg: ASbGncs0mEU9yG535GJPcpz5Q0Axl2hxlbiVt84Q5HXxLkhbdccnbPx9NDGtRo3gHhD
	bN+PvxVG9Z7p4ovCJmVdu3/VzDN9WDmzhf2L/LmyS9luz/pM01kcLQPHPqGWDPxsmB3ch5Naukz
	sADBZZUXqrEbLSXdO8wK8p0FbP78VTH82y4lfOualQug9jiIA6qYAzZKAf9YCXGd6o8RVwDTyVl
	3zDqLxh3+VDmiW8gjtDk96OlX/boITQQ/095sOY6LIF6BiHOTEAszAqg7MqKXUX4CTH9sS6flmy
	z1HYnAMTA1o1layQzk0m25BTLaW2IQGKo6/x+lVae4CC5B04aaO3jWD0LQhN
X-Google-Smtp-Source: AGHT+IHMOhcB+Qw+21vg5IuCNBUZ0RDSWX/Wg/xZnJJicgzEEEvoc3LtOtXyl1BmtgtJpeXc54uUMg==
X-Received: by 2002:a05:620a:2894:b0:7d0:aa7a:8cdf with SMTP id af79cd13be357-7d2df683915mr42221185a.10.1749161116677;
        Thu, 05 Jun 2025 15:05:16 -0700 (PDT)
Received: from [192.168.0.9] ([2804:14d:90a8:477c:13e7:d349:8af8:5d32])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ebd219ec7sm288832241.24.2025.06.05.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 15:05:16 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Thu, 05 Jun 2025 19:05:01 -0300
Subject: [PATCH v2 1/3] iio: imu: bmi270: add channel for step counter
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-bmi270-events-v2-1-8b2c07d0c213@gmail.com>
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
In-Reply-To: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749161110; l=6340;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=RxmGj3cLgdbs5Ik4JNJy/VqorzTfaela/azmgcDCe/8=;
 b=fOmP44cQNoBnGd6DoXhlyINvuTFJT81f2O38SGMf8soDZz+ACsfZPF0xwS4E7aX7R66ijMrPA
 RiRto5U1GOIDPSSfDlkUAPfPWn9DTgBiZ8TGIaTvzq3wG4XNRMq/To9
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Add a channel for enabling/disabling the step counter, reading the
number of steps and resetting the counter.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 138 +++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..6056f7635c5a6e89b670322adfeae0cb7dc5cd9a 100644
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
+	bool steps_enabled;
 
 	/*
 	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
@@ -120,6 +128,11 @@ struct bmi270_data {
 		__le16 channels[6];
 		aligned_s64 timestamp;
 	} buffer __aligned(IIO_DMA_MINALIGN);
+	/*
+	 * Variable to access feature registers. It can be accessed concurrently
+	 * with the 'buffer' variable
+	 */
+	__le16 regval __aligned(IIO_DMA_MINALIGN);
 };
 
 enum bmi270_scan {
@@ -282,6 +295,107 @@ static const struct  bmi270_odr_item bmi270_odr_table[] = {
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
+	data->regval = cpu_to_le16(val);
+	return regmap_bulk_write(data->regmap, reg->addr, &data->regval,
+				 sizeof(data->regval));
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
+	ret = regmap_bulk_read(data->regmap, reg->addr, &data->regval,
+			       sizeof(data->regval));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(data->regval);
+	return 0;
+}
+
+static int bmi270_update_feature_reg(struct bmi270_data *data,
+				     enum bmi270_feature_reg_id id,
+				     u16 mask, u16 val)
+{
+	u16 regval = 0;
+	int ret;
+
+	ret = bmi270_read_feature_reg(data, id, &regval);
+	if (ret)
+		return ret;
+
+	set_mask_bits(&regval, mask, val);
+
+	return bmi270_write_feature_reg(data, id, regval);
+}
+
+static int bmi270_enable_steps(struct bmi270_data *data, int val)
+{
+	int ret;
+
+	guard(mutex)(&data->mutex);
+	if (data->steps_enabled)
+		return 0;
+
+	ret = bmi270_update_feature_reg(data, BMI270_SC_26_REG,
+					BMI270_STEP_SC26_EN_CNT_MSK,
+					FIELD_PREP(BMI270_STEP_SC26_EN_CNT_MSK,
+						   val ? 1 : 0));
+	if (ret)
+		return ret;
+
+	data->steps_enabled = true;
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
@@ -551,6 +665,8 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		return bmi270_read_steps(data, val);
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
@@ -571,6 +687,9 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = bmi270_get_odr(data, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = data->steps_enabled ? 1 : 0;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -596,6 +715,19 @@ static int bmi270_write_raw(struct iio_dev *indio_dev,
 		ret = bmi270_set_odr(data, chan->type, val, val2);
 		iio_device_release_direct(indio_dev);
 		return ret;
+	case IIO_CHAN_INFO_ENABLE:
+		return bmi270_enable_steps(data, val);
+	case IIO_CHAN_INFO_PROCESSED: {
+		if (val || !data->steps_enabled)
+			return -EINVAL;
+
+		guard(mutex)(&data->mutex);
+		/* Clear step counter value */
+		return bmi270_update_feature_reg(data, BMI270_SC_26_REG,
+						 BMI270_STEP_SC26_RST_CNT_MSK,
+						 FIELD_PREP(BMI270_STEP_SC26_RST_CNT_MSK,
+							    1));
+	}
 	default:
 		return -EINVAL;
 	}
@@ -698,6 +830,12 @@ static const struct iio_chan_spec bmi270_channels[] = {
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


