Return-Path: <linux-iio+bounces-20252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6897DACF97B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 00:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A65C3B01C1
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466027FD56;
	Thu,  5 Jun 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxQ73loR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6D27FD5A;
	Thu,  5 Jun 2025 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161123; cv=none; b=d9bxTz9r1MaSL04dkmWY4UqcF8uD0ZoiRaOptNOBktSGU9JrZtqfC8lbwhcX5/1VJvd2634Xhn5LePJzMn2NmqnnYI4TDUcpf3wCH0YUIypQAWWQVFItfxD/xWrA3ACH08FrlSVq0hrg+nTAgQoO0RhdZbYyksbIaLlkvFSskuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161123; c=relaxed/simple;
	bh=HguUGu/bZDJEa5tPw74JL0xBHaO75/9Cub6FaLQFDyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqcjxZQkBDOYDB1cF3suR5yflGLaeOCVoPEqJgK0Pyw1crkQcXcCLSg2ApGQENus18DCTUu9lxKJvzOFoKUj2+8iBEalWZgg8ZbmaHv/BdkANkW9GS1MZOBj7pyPGfLRbhfJiu94sogQRNTA9f/x9e+RK4Uf+G/GYTYRHW2w+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxQ73loR; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87df3dffe63so422360241.3;
        Thu, 05 Jun 2025 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749161120; x=1749765920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi0TrwmfycS7537Dvc6GM6rPAyKyxOJmosLKT97Xw2w=;
        b=DxQ73loR8LwPaGezMG6Xxa7s71/p4RMqyG3V2XJZytziAcFErmKBp0eM5VQDEvf24H
         LaVSyvoVeoiVY+Kt7nTwg8ooRHm3/SHh4u9bOGpo6KDyMbP9Qa0QTBsBCQkXV92EGshK
         wRxICUzIjfM5ov40TlwpZVlCtYHYT7OcCa+7wT07Hc4U8qR8zbnl7/WoITRJHQ/bgERT
         BMGwnLN5l536FsRjPyUkVBSmzRIlGfVONtLkoY/zX9fPrGyToa06aQ4RyGhUrNYSvlIr
         k48qeDhmkkR7xJswWG0TLNBipbkkrXDMcGKiojuMlTavrDLDKfeFBegzi1F8yTcPGbSz
         r1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749161120; x=1749765920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi0TrwmfycS7537Dvc6GM6rPAyKyxOJmosLKT97Xw2w=;
        b=pMrc8TFiwUXszHlUPrDAwLecyOyNQvyMM0ZFJdnzgGv2b4Db3gF05WykCYh6xpjFKC
         QRaJjrhmZrfmtaueav9xFSyaEMKWgnfwtruXwXDHjesCHocg+kLu2wLWjrT6ToE2PDl0
         dshOBMwlF2CYUgGX8zRNRC2tGZOfbvyGxp7B20FRCYuyORJA2tKu6ORuxiGhDPZ8WjJ7
         RfoihgvtlCrNBYguoRf0bAVzS9OEnpnJEFZ1Z61pO5DaaLcjl7WiqrF0bHKVxlphjiJX
         6lGpzDEgoe0cft4h9Q4CTzpQ8YOW2JKIAjScJjK+iSje6lRSfMjC1uPqEb0m5x+Gfy0v
         JJiw==
X-Forwarded-Encrypted: i=1; AJvYcCVcxhY15syQ7jU5dPaHUUcKyCTXwH5Dqdio04b74JALZHVX7v3OuqL78i9p3oSvlVZsqIYBYJ5y2rWhw8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRmuKrt3Ng88hCfanEpRuwWJKhQLRtEAAZiEyCwuGzVe16/Ryc
	yeHmeTqatmM54al1oYEiHzT4XDfdGAxXxmstweG/A8tCDJ3YcFV5mTaY2bOTdxn4
X-Gm-Gg: ASbGncvqr1+pDi9TNe9/3FQv1YiKJuSgD4zSrjn+onqOsw4B3LnasznuDB6ir9NmSvi
	bPfR5WNRgMK/4srotMA8O8CXQ4tZ0aHMZfOw6+ad8YTfP53RqFrTy1itazWPgqx/9/F67vwUb2y
	sxZCaoSATBXrGwwV9UTJxbS4XEjYwYslFYlskuZbtRok/vvEbYV8pNnTzqE7Qr5YxLkGw7hpOTV
	WnjavitkUO0n+fJdsQQz4q7VdKPa8Icg+8h8tSxVhVFwWwvqq4kUURuouEU0h91YvojI9TQgdUF
	NGu/cuaXxc8tbZVIxBwIcihMQxP/XWLMcX0a2tbwhMtOwxffEjrrRi1dVRkB
X-Google-Smtp-Source: AGHT+IEh7I/0eCgkFvyTkcr7Pe0ymiC8A/gO79NrTWblSGTcBza2q00I1BRRy3QeXkP0nMrFCiEaSg==
X-Received: by 2002:a05:6102:32c6:b0:4e6:edcf:3890 with SMTP id ada2fe7eead31-4e7729ccf20mr1143581137.10.1749161119802;
        Thu, 05 Jun 2025 15:05:19 -0700 (PDT)
Received: from [192.168.0.9] ([2804:14d:90a8:477c:13e7:d349:8af8:5d32])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ebd219ec7sm288832241.24.2025.06.05.15.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 15:05:19 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Thu, 05 Jun 2025 19:05:02 -0300
Subject: [PATCH v2 2/3] iio: imu: bmi270: add step counter watermark event
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-bmi270-events-v2-2-8b2c07d0c213@gmail.com>
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
In-Reply-To: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749161110; l=7709;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=HguUGu/bZDJEa5tPw74JL0xBHaO75/9Cub6FaLQFDyE=;
 b=CTMLaZEOYAYB0RHVi1memO2cWtH/oMSoz8izbmPj1cW7EAxr9l7JoFtGV7yEQuGtYBpjp/TbI
 xG6I+CUNBc8Dk2u5uetD2Z13stDEAQBBSyFR5mGTCtGZNJCo85yTsGB
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Add support for generating events when the step counter reaches the
configurable watermark.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 174 ++++++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 6056f7635c5a6e89b670322adfeae0cb7dc5cd9a..0798eb1da3ecc3cecaf7d7d47214bb07f4ec294f 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -8,6 +8,7 @@
 #include <linux/regmap.h>
 #include <linux/units.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -28,6 +29,9 @@
 #define BMI270_ACCEL_X_REG				0x0c
 #define BMI270_ANG_VEL_X_REG				0x12
 
+#define BMI270_INT_STATUS_0_REG				0x1c
+#define BMI270_INT_STATUS_0_STEP_CNT_MSK		BIT(1)
+
 #define BMI270_INT_STATUS_1_REG				0x1d
 #define BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK		GENMASK(7, 6)
 
@@ -74,6 +78,10 @@
 #define BMI270_INT_LATCH_REG				0x55
 #define BMI270_INT_LATCH_REG_MSK			BIT(0)
 
+#define BMI270_INT1_MAP_FEAT_REG			0x56
+#define BMI270_INT2_MAP_FEAT_REG			0x57
+#define BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK		BIT(1)
+
 #define BMI270_INT_MAP_DATA_REG				0x58
 #define BMI270_INT_MAP_DATA_DRDY_INT1_MSK		BIT(2)
 #define BMI270_INT_MAP_DATA_DRDY_INT2_MSK		BIT(6)
@@ -94,6 +102,7 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+#define BMI270_STEP_SC26_WTRMRK_MSK			GENMASK(9, 0)
 #define BMI270_STEP_SC26_RST_CNT_MSK			BIT(10)
 #define BMI270_STEP_SC26_EN_CNT_MSK			BIT(12)
 
@@ -101,6 +110,10 @@
 #define BMI270_TEMP_OFFSET				11776
 #define BMI270_TEMP_SCALE				1953125
 
+/* See page 90 of datasheet. The step counter "holds implicitly a 20x factor" */
+#define BMI270_STEP_COUNTER_FACTOR			20
+#define BMI270_STEP_COUNTER_MAX				20460
+
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
@@ -396,6 +409,40 @@ static int bmi270_read_steps(struct bmi270_data *data, int *val)
 	return IIO_VAL_INT;
 }
 
+static int bmi270_int_map_reg(enum bmi270_irq_pin pin)
+{
+	switch (pin) {
+	case BMI270_IRQ_INT1:
+		return BMI270_INT1_MAP_FEAT_REG;
+	case BMI270_IRQ_INT2:
+		return BMI270_INT2_MAP_FEAT_REG;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
+{
+	int ret, reg;
+
+	guard(mutex)(&data->mutex);
+	if (!data->steps_enabled)
+		return -EINVAL;
+
+	reg = bmi270_int_map_reg(data->irq_pin);
+	if (reg < 0)
+		return reg;
+
+	ret = regmap_update_bits(data->regmap, reg,
+				 BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
+				 FIELD_PREP(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
+					    state));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 {
 	int i;
@@ -552,19 +599,31 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct bmi270_data *data = iio_priv(indio_dev);
-	unsigned int status;
+	unsigned int status0, status1;
+	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 
 	scoped_guard(mutex, &data->mutex) {
+		ret = regmap_read(data->regmap, BMI270_INT_STATUS_0_REG,
+				  &status0);
+		if (ret)
+			return IRQ_NONE;
+
 		ret = regmap_read(data->regmap, BMI270_INT_STATUS_1_REG,
-				  &status);
+				  &status1);
 		if (ret)
 			return IRQ_NONE;
 	}
 
-	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status))
+	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))
 		iio_trigger_poll_nested(data->trig);
 
+	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))
+		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_STEPS, 0,
+							       IIO_EV_TYPE_CHANGE,
+							       IIO_EV_DIR_NONE),
+			       timestamp);
+
 	return IRQ_HANDLED;
 }
 
@@ -772,10 +831,117 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int bmi270_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, bool state)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
+		return bmi270_step_wtrmrk_en(data, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+	int ret, reg, regval;
+
+	guard(mutex)(&data->mutex);
+
+	switch (chan->type) {
+	case IIO_STEPS:
+		reg = bmi270_int_map_reg(data->irq_pin);
+		if (reg)
+			return reg;
+
+		ret = regmap_read(data->regmap, reg, &regval);
+		if (ret)
+			return ret;
+		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
+				 regval) ? 1 : 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+	unsigned int raw;
+
+	guard(mutex)(&data->mutex);
+
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
+		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))
+			return -EINVAL;
+
+		raw = val / BMI270_STEP_COUNTER_FACTOR;
+		return bmi270_update_feature_reg(data, BMI270_SC_26_REG,
+						 BMI270_STEP_SC26_WTRMRK_MSK,
+						 FIELD_PREP(BMI270_STEP_SC26_WTRMRK_MSK,
+							    raw));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi270_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+	unsigned int raw;
+	u16 regval;
+	int ret;
+
+	guard(mutex)(&data->mutex);
+
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
+		ret = bmi270_read_feature_reg(data, BMI270_SC_26_REG, &regval);
+		if (ret)
+			return ret;
+
+		raw = FIELD_GET(BMI270_STEP_SC26_WTRMRK_MSK, regval);
+		*val = raw * BMI270_STEP_COUNTER_FACTOR;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_event_spec bmi270_step_wtrmrk_event = {
+	.type = IIO_EV_TYPE_CHANGE,
+	.dir = IIO_EV_DIR_NONE,
+	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			       BIT(IIO_EV_INFO_VALUE),
+};
+
 static const struct iio_info bmi270_info = {
 	.read_raw = bmi270_read_raw,
 	.write_raw = bmi270_write_raw,
 	.read_avail = bmi270_read_avail,
+	.write_event_config = bmi270_write_event_config,
+	.read_event_config = bmi270_read_event_config,
+	.write_event_value = bmi270_write_event_value,
+	.read_event_value = bmi270_read_event_value,
 };
 
 #define BMI270_ACCEL_CHANNEL(_axis) {				\
@@ -835,6 +1001,8 @@ static const struct iio_chan_spec bmi270_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
 				      BIT(IIO_CHAN_INFO_PROCESSED),
 		.scan_index = -1, /* No buffer support */
+		.event_spec = &bmi270_step_wtrmrk_event,
+		.num_event_specs = 1,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };

-- 
2.49.0


