Return-Path: <linux-iio+bounces-20728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01DFADBDDC
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 01:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5C8168D83
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 23:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FA2356C6;
	Mon, 16 Jun 2025 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crisDmmi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C7235067;
	Mon, 16 Jun 2025 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750118008; cv=none; b=ruHTlJ42yrqKb1p+tqdUupxLnTAJNp2V/L0oXHa1l2aajpnHOPJJHRuURZlbWdH9T2Rl0w5L+c2+LlKNUSl09I6UTEw0SOa3kpZwb0ipYjQwZt7s/C75K9Wf0BrUCWYnNzB/4tAi0MHVkk5FWNBa3MkeJxoKzTg1I4nMBFqFdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750118008; c=relaxed/simple;
	bh=4b4dI044v23C1OffMCTZwJ5/8fozf9R9xXvX7QmC3KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWUdr7zWev1DulQHL7YmQOoVvqwg19go0pFAcdkIdEbBufeck87dB2H77ZwW5gHEoRx8AMEX2aOCXn4M2t6mU1j/bxEL3PjuyIb6pL1xZNQ36OF/oYHkHeXCpAtnTCg9LGPgzO4haVojtGlSQIuu62ALAmKbdG593lBOSWctF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crisDmmi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2fc93728b2so4167978a12.0;
        Mon, 16 Jun 2025 16:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750118006; x=1750722806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIm0+OnMBm404I7VIGAcAGqFwKW5IFbBd4J9XuS6Kdo=;
        b=crisDmmiHs21nfWgi6TsW0lCStBtT2kpfD40bn1UQ4EjqYV44NJPQ26V1cXTMuYYl3
         CuhuXwZ5MB+PxSZA3KHpS+mPv4O/6PkNJq6yHYZNn2IkgKqL3FQyHa0VT067/k47opfp
         sj0k3F1vMpMxwE9pMbxUSw6X2Jp3n11cBP0r3n55cPvgS/YkJeaZXAoyL09FoxusJHD3
         gyMocDHUPQGun6CcXaDyNEwPXm3LKrw6Mx/wiirWiK0HM+7jclBkgC4iNOJ8C4Og/wNe
         5mNWUZXbIhNYebHMKV2CvrK2bZS+/2RCpB1le4HyWbfFtfcL5rAoPVqCZfMNoZ/JUPCG
         UP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750118006; x=1750722806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIm0+OnMBm404I7VIGAcAGqFwKW5IFbBd4J9XuS6Kdo=;
        b=Zz9N5AMUurqy+RktfcPpBrWy97zGMUQp/tkfJdJJ9Sis8KE4t6p4M+MoMWyAQM69Mm
         1svBROCP7E48g0zJrEQQZyBOzNbfdyWd6A6EdNyefUVeZi0UiRuPta4CmofBffdu5eFJ
         wXOFh6wwXRkOCDJfYQXh36jMeMbqdG9rWgEn+OQqlFqh8mJkb2h9A/y9dkNViIw1pCNJ
         YlZux8qnVxBpkhCmJC3LpzqPkI4HrBuVhXGpQVjwgi9n3nysbV9sm7NZJhWLp4kA1pvD
         RcdGt9reSiRmy3EEmu2IYiH14jqn1RYTqGs8xDBQr7+EYU5Jg/KEePqLM5ScJcuZYrFH
         2/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX27ErSNSRLFijj0BXeRvX6GLQJEXH2vZ6YSU5smgNfYfYeFjU5KG/1n1RBwDciw8skxpoRCBVEdbTt+2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSeEzPN+ZySoU5fibqWB6mckdhL7UNI8Ywsg/g7gINdKZKwwi
	kzcg/2TRovmCOCPALSXTOE5ELLqnxwXU2Ow1KypU5xeetbOe768v3VAgmGNM8Nvw
X-Gm-Gg: ASbGncu0o9cNec52sckOeznNbHbgjiVQQ9epnmZU2xPmHo+4Mo0XObRup6C4fiE/dvJ
	WuwhQzBT+XMFpvWEfp2sUi46nXsf2C3+TkCqJppJ1vu7ym2fgf1NelyOA0nAg0RLEpvVDtjrKh9
	QS4tWvoyB6uDHuZ/qX/ntTPVQxd+6GmyR0mGI6c7IvF/Sk8Yst4EF8CJsf3vLq3RQqtkbgZMqm1
	BoLkd911sjHO4a3pSeRjFaSf6Hv9DOO5eVwBX7mq+M52Uhf31ThitoH2dcjc8WIXmBmWWyITX1q
	4/05dLUx/D0G8W65TF9S5kpRgHTuFPLSeUOLaBFsnA5+PFgmJSv84TngNdDMS2e7R7BO7ZY=
X-Google-Smtp-Source: AGHT+IHhdfcSX0lvqnTVVA2cCzrcocmRq5MtEyCFLVniRtkwdcNZdXVh+abXolMuulLhG201Crpyyw==
X-Received: by 2002:a17:902:fb90:b0:234:9374:cfae with SMTP id d9443c01a7336-2366afe7d06mr120971255ad.19.1750118005772;
        Mon, 16 Jun 2025 16:53:25 -0700 (PDT)
Received: from [192.168.0.9] ([2804:14d:90a8:477c:13e7:d349:8af8:5d32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782d3sm67515395ad.115.2025.06.16.16.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:53:25 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Mon, 16 Jun 2025 20:53:09 -0300
Subject: [PATCH v3 1/3] iio: imu: bmi270: add channel for step counter
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-bmi270-events-v3-1-16e37588604f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750117999; l=6343;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=4b4dI044v23C1OffMCTZwJ5/8fozf9R9xXvX7QmC3KQ=;
 b=7tV/vHJcIxNIlacI4jg2453NTFsWOijMUFVABc26N61IpbJy7sV/AWaC5/jSg7cL4xIAXH13c
 NGJq+SkchELCUProDjLjrnIOoquDURb7JSpxYgoQF1ZZ31Jcx3aWbS8
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
index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..c3cf65bb05fc2f6699e107110ee98f703aca3da3 100644
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
+	u16 regval;
+	int ret;
+
+	ret = bmi270_read_feature_reg(data, id, &regval);
+	if (ret)
+		return ret;
+
+	regval = (regval & ~mask) | (val & mask);
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


