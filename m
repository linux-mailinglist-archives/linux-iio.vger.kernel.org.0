Return-Path: <linux-iio+bounces-18612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF9A9BBA8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 02:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A187AF853
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21317996;
	Fri, 25 Apr 2025 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajTuK8AF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1CB65C;
	Fri, 25 Apr 2025 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540106; cv=none; b=MkWtjvSxL+DSHwsbhIbQpfx0ugoCh+8ckuyDaiXfJKuWrBKBhY/FPgDgwzG8Onq9OmnoNPmp0G3cDQ7FuxvPAyXAM/Ks1RKCa0GnPt+xkxjXlf6AHFkJpTrBGJd0PBR2RxOvLDgIR3zsN5qbOeVecmL8rXsvvgXfOS2Fiy8bnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540106; c=relaxed/simple;
	bh=zHH6jhOfgXoH9vf4rnFKZjdOnv/FXwzNXAMAqeGii5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXYj1+bGaTtDPhSe+c6G3ZC2Mw3YntIrd8sjVGDfWUzRGAlCpKnP6Dxrb10v5U/ezcdyC4rYnx0mQC0VwCb/AnE6xP0+BYS6I0jMGXgSNgESzGyhnQXmw+jk811ZDm7FYlQNoBTsEVEPSCJkZm1ksKJ5CII3xO68X3O7XMhLcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajTuK8AF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227d6b530d8so18945915ad.3;
        Thu, 24 Apr 2025 17:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745540104; x=1746144904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+M33bLI0wVVdIT1YDu2HCDwy5r+huY0WGj/fLwU04A=;
        b=ajTuK8AF9go7Eog76crSNSTpuQRI+zCy6uPVDa+xJ214aLxBoq1ptU+cWaKmccxONW
         RFdGf0SzprNSH3de+vZ/uCRqG4BO7gp2fIVXVewJv3ksJpEc2n/fqlKHN/AahEZJatd0
         tg6tLGl344fcL04eDuNG0126gHRVqxSHZy7jeY7uhE3yTytgrbqUzSLblLSsNxhSomgy
         /zHEBu7C5uEoDIG84kiFCJZkFJYISD1SfeVs+I6JydzKuZGo0VQ/Vz+r8p023wU9Iavq
         TMv7W5hW6mCv9CcF7WulT1+7nrq1WV53XUr1CF0GJomXkVs1m4QiX1KAzfYG1u3JkU37
         smDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540104; x=1746144904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+M33bLI0wVVdIT1YDu2HCDwy5r+huY0WGj/fLwU04A=;
        b=Wn6DLAhM5eRGXAFamHWZYKnAziSUdnm5rZmjXfkXmeYYrZDuR+JxqptVAqF1f1suUH
         MmNcN9M7fvW0Ej24cZ3GhN3rjRAmKRUsNpkkIfBIIMs3tFDyFvOLOpXVdUq4hJZB24A0
         u/BSBYr60hcT6dbP6BgZTr5dypc7daXX2thwdEzEpCxrz9PhilyW1a/8KlEzOA5cZs3f
         Ke8rG3sRbmDA2lTjrv6B9JAgoOmFzLAjynaz3UlOJdl966oo2tND3dqptnLDcD6xGNjM
         B1s7t62MrtvnmmjEK4AOmnvFxrQfh0j+l9qEj09NDJ1gzGBVkuCEyVGn5bSXs409U4PH
         QoMw==
X-Forwarded-Encrypted: i=1; AJvYcCUc3yWblOpGfFgA2ITpVE5nS+8vzBOlWHmuFv+HF5mMiuy2nC74XV+jnKnA/LVte1Rsm+PnJPuXxnfvNQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwZ4YTs24GFDi9UXgB769LbNu5opiKqJwbW31GDBsBxlCr9kX
	rNQo1JFeY4fLyUHcEKRM85/3+LLDvYntqxBJ4JGjhRwjUaiqzIoerb6gQ5qY
X-Gm-Gg: ASbGncu1Ax0Z0gKIp05GNT7RiqwV81drF/IePJIOTiqQNOWsPEV/jdrQlmZujXXck9K
	qYh9Cu8x101DK32LzURbnwYWFAQN4p575Y+6Ax7mbxgmk2vt9M/NyHZpm+A2a9woxUKaExLTqt8
	Lg/7gGwH31iAUrPq4io7ssIXIrmERPP79824KTadfhOsFOyaRC/3UTIIHNHrwtNISqGbp1D0/x6
	ERR8eIpHRTXMGV+qsk+r8MreN0H73niHmfu+IHJeFppDoEb/1PQcL6a9FRrTfHcTH/SgbpGcDh2
	LCut3yZ5Z8cuzfmxX79qB0hOy02PrcxWhWlil1Cq1QunXAI4z5CfoUskne5OeA==
X-Google-Smtp-Source: AGHT+IEIXbq1jy/bwqfBna81oPZg0yRJzTUqsUFjc9MRssA+2uMsgJkyJW3XlKOkkLc0krU5mvQWoA==
X-Received: by 2002:a17:903:40c8:b0:224:1579:5e8e with SMTP id d9443c01a7336-22dbf5d9efemr4231775ad.1.1745540103918;
        Thu, 24 Apr 2025 17:15:03 -0700 (PDT)
Received: from [192.168.0.110] ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbdf7bsm20035165ad.87.2025.04.24.17.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 17:15:03 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Thu, 24 Apr 2025 21:14:51 -0300
Subject: [PATCH 2/3] iio: imu: bmi270: add step counter watermark event
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-bmi270-events-v1-2-a6c722673e5f@gmail.com>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
In-Reply-To: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745540093; l=7473;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=zHH6jhOfgXoH9vf4rnFKZjdOnv/FXwzNXAMAqeGii5o=;
 b=a3YmsM5H2UC0rETt39v+8TfSZUx+t6oqJldVV6girXONCFCl6AY+U0EZnNKp+xR5NEuWn/BfO
 rm4Z1wrYq/lCKs+xjQ3JPwV5mPZxv4UEDMwPPONeMWjYpMoV0Gl8JQX
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Add support for generating events when the step counter reaches the
configurable watermark.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 168 ++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index f09d8dead9df63df5ae8550cf473b5573374955b..07a24ed9a4edabeafd98a746ba09469f9e41c38a 100644
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
 
@@ -119,6 +128,7 @@ struct bmi270_data {
 	 /* Protect device's private data from concurrent access */
 	struct mutex mutex;
 	int steps_enabled;
+	unsigned int feature_events;
 
 	/*
 	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
@@ -383,6 +393,42 @@ static int bmi270_read_steps(struct bmi270_data *data, int *val)
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
+	int ret, reg, field_value;
+
+	guard(mutex)(&data->mutex);
+	if (!data->steps_enabled)
+		return -EINVAL;
+
+	reg = bmi270_int_map_reg(data->irq_pin);
+	if (reg < 0)
+		return -EINVAL;
+
+	field_value = FIELD_PREP(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, state);
+	ret = regmap_update_bits(data->regmap, reg,
+				 BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
+				 field_value);
+	if (ret)
+		return ret;
+
+	set_mask_bits(&data->feature_events,
+		      BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, field_value);
+	return 0;
+}
+
 static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 {
 	int i;
@@ -539,19 +585,32 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
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
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
+							     IIO_NO_MOD,
+							     IIO_EV_TYPE_CHANGE,
+							     IIO_EV_DIR_NONE),
+			       timestamp);
+
 	return IRQ_HANDLED;
 }
 
@@ -761,10 +820,111 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
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
+
+	return 0;
+}
+
+static int bmi270_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct bmi270_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+
+	switch (chan->type) {
+	case IIO_STEPS:
+		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
+				 data->feature_events) ? 1 : 0;
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
+		if (!in_range(val, 0, 20461))
+			return -EINVAL;
+
+		raw = val / 20;
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
+	u16 reg_val;
+	int ret;
+
+	guard(mutex)(&data->mutex);
+
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
+		ret = bmi270_read_feature_reg(data, BMI270_SC_26_REG, &reg_val);
+		if (ret)
+			return ret;
+
+		raw = FIELD_GET(BMI270_STEP_SC26_WTRMRK_MSK, reg_val);
+		*val = raw * 20;
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
@@ -824,6 +984,8 @@ static const struct iio_chan_spec bmi270_channels[] = {
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


