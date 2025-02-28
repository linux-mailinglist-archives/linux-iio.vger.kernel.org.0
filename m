Return-Path: <linux-iio+bounces-16214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D66A4A673
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 00:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185A23B2661
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DC81DF986;
	Fri, 28 Feb 2025 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxRah8Q+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9D1DF96C;
	Fri, 28 Feb 2025 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783848; cv=none; b=NNdO1otwsHuxA2MgSl6ZWRjbsU1DMBjItduEj6aGhAcwe8ZZbg4yQ6w9Mktb/lBVDLEDQiNRDqPmvgeM3Y0QL8h4sCmHN4iw6b3VJSY0LzHoN6NyOMB3Btn9N0gw4rXhcOAjrTLT38OzERTPznfqQTnsKU8ejtfrunqKdljqtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783848; c=relaxed/simple;
	bh=rWhoABnjRIWuNQdC70sbA5ayHjGWEK9aSj/rOgtyOGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMIkJDKL0AwXv1iiNvzWeKT9xstWhYKg/CJJRAKMmi2uyKJbvIvlte6V9fOkorNfNfMszFzR4gxqHGfydU/pgI9xluNrfSON8evp442eDw0Hl+zcVEM0B0/13u+uIkDqiwuZ5min6RJCZWFiVEKtBYebhF7gWYuUTSM86P55fPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxRah8Q+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22334203781so58881445ad.0;
        Fri, 28 Feb 2025 15:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783846; x=1741388646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gX+TVLxUjYh9ZXVQaWkExjl0H0sS3BoVnGkX5XmjCUY=;
        b=jxRah8Q+0CKb37fLL/HS4jTEgf83sK53Ih++0elsRhGRq3O/sQxdU3wQHMqf3324QF
         q+AzqgPP4aUZ1OuRrRHRy+HvTtDdxl+ADoX0cJGdKK3+Z/7ByX2nBu603xP1r5D4pHGy
         7ssG/0tiv6oG5VLWNTGqMVeDBK7AlcTGYpSdfx9ymdrIIg2bz0swGNRSfB+4XJ1Z7MWn
         vnzNb9uVwDfZcYtiicHQQxlO6MiR/GSK2x5Zz2lxOi26UqBOsEDUfDYrUcWy8BvQn6BS
         taJhhYuBmNSkZeG+q0OvnMsqKxa4tAQ1ZX132+CWCp4mlrwaReFP2PZvmxBwhsoSu7Tn
         +afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783846; x=1741388646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gX+TVLxUjYh9ZXVQaWkExjl0H0sS3BoVnGkX5XmjCUY=;
        b=tVVmMe/GLxdVFcEOwLVI1QLlXqLNyzkMMHrbLzUH1TGwocs8y+2ehmz+7Vs5YRUJa5
         dOHVZeSEXEfQT4t1qoxO7yRnukbMX8taLGEYKBaJ+wKWMsenLOYhYSxUa+WaLu3fkeJI
         KLCAWESgeqX8u9GODSJsiRm4KdBTlKpyzRuK+Qb3SGEcpyMtlVuOTv4sXElkBeL27s+9
         YYn3+VR9dC3uWIrN6WDKz9fG2vdXdMrP8AZs542jew7M5lmGVTFwcu7GWroBT/IxXuKJ
         XqvvIP++n7dzeQwHlWeCJD+omxAFPNaJoXRY9RbuQE+qV/FI6UMbtchBsfLo7mvZKD/e
         bh/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZQlVTAYG6mb9qXVY5huyEp9nlKAvWz7/T+r1RsPKBJ2yxbE2qU3Z2bH+ZnCsLFgoD67aN43uR4uFWS78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqtqJCQZXne34tHHrPJQ0NizPPPGzngMjBpSgoAbBWqqHa7Hp
	q1GUyou6PBJsnUlUuguD1L5DmXQwNRIXwOtQv5WgmrPuaBae0r9/
X-Gm-Gg: ASbGncvGLKNc5AGbdvSyJdkkuNZwXhJCHTTc2Zm18JowgIC+JvoPxau4ORe/6RxZG8u
	wsZbIrEXpVoWTQKvn6VSg2576MqxXBZCnhgjeMDyVVp3In7YmNtdKqNM03+qP0DqeoZIuiNjqdx
	TIPXxaASP9pTAJfRhxND45QROn2Oba6QhQ02oDdnF87JzpnDx3mmcPN8ULu/pmbPYgqJPmsktNY
	ZRJJtqRGQ0e6B5DJUgFbxseHwhytMNzYhWWXnQDPDizbSSLr49hShjQCY+a8vkmRRnj7vuUGIwf
	kMWqDNgEziyDt2EZ4vc0nzKRYg93ge0iYenRhg==
X-Google-Smtp-Source: AGHT+IHTxT9CuN87cgCP9q3s6v66hAnqJq5K9QlU4dE7udqDKj7GLv95InfDgqeMjNJClih3Tk7a0w==
X-Received: by 2002:a05:6a20:8407:b0:1f0:e6db:b382 with SMTP id adf61e73a8af0-1f2e3875ba6mr15041684637.8.1740783846265;
        Fri, 28 Feb 2025 15:04:06 -0800 (PST)
Received: from [192.168.0.107] ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf230dsm3974875a12.8.2025.02.28.15.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:04:05 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Fri, 28 Feb 2025 20:03:50 -0300
Subject: [PATCH v2 3/3] iio: imu: bmi270: add support for data ready
 interrupt trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-bmi270-irq-v2-3-3f97a4e8f551@gmail.com>
References: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
In-Reply-To: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740783832; l=11585;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=rWhoABnjRIWuNQdC70sbA5ayHjGWEK9aSj/rOgtyOGI=;
 b=3ak+z9a9AmLSLgaRUGAJnoBpOwYT3RYouZxOeL7SohQCEVdbyx2/0X0hLQ2AXiZfPQ+/q1k7i
 jp/yoSbmayHALrHqHzlHG+1miQAMX/QDlVxKIHTV076mmrjCje+tGOK
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

The BMI270 sensor provides two interrupt pins that can be used for
different interrupt sources, including a data ready signal. Add support
for configuring one the pins as a trigger source.

The interrupt pin can be configured with various options: active high or
low, push-pull or open-drain, and latched or non-latched.

Acked-by: Alex Lanzano <lanzano.alex@gmail.com>
Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 234 +++++++++++++++++++++++++++++++++--
 1 file changed, 227 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 16deda12a5c1aba6d366f7fcb134266c490d3a75..a86be5af5ccb1f010f2282ee31c47f284c1bcc86 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -4,11 +4,13 @@
 #include <linux/firmware.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
@@ -26,6 +28,9 @@
 #define BMI270_ACCEL_X_REG				0x0c
 #define BMI270_ANG_VEL_X_REG				0x12
 
+#define BMI270_INT_STATUS_1_REG				0x1d
+#define BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK		GENMASK(7, 6)
+
 #define BMI270_INTERNAL_STATUS_REG			0x21
 #define BMI270_INTERNAL_STATUS_MSG_MSK			GENMASK(3, 0)
 #define BMI270_INTERNAL_STATUS_MSG_INIT_OK		0x01
@@ -55,6 +60,20 @@
 #define BMI270_GYR_CONF_RANGE_REG			0x43
 #define BMI270_GYR_CONF_RANGE_MSK			GENMASK(2, 0)
 
+#define BMI270_INT1_IO_CTRL_REG				0x53
+#define BMI270_INT2_IO_CTRL_REG				0x54
+#define BMI270_INT_IO_CTRL_LVL_MSK			BIT(1)
+#define BMI270_INT_IO_CTRL_OD_MSK			BIT(2)
+#define BMI270_INT_IO_CTRL_OP_MSK			BIT(3)
+#define BMI270_INT_IO_LVL_OD_OP_MSK			GENMASK(3, 1)
+
+#define BMI270_INT_LATCH_REG				0x55
+#define BMI270_INT_LATCH_REG_MSK			BIT(0)
+
+#define BMI270_INT_MAP_DATA_REG				0x58
+#define BMI270_INT_MAP_DATA_DRDY_INT1_MSK		BIT(2)
+#define BMI270_INT_MAP_DATA_DRDY_INT2_MSK		BIT(6)
+
 #define BMI270_INIT_CTRL_REG				0x59
 #define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
 
@@ -78,10 +97,20 @@
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
+enum bmi270_irq_pin {
+	BMI270_IRQ_DISABLED,
+	BMI270_IRQ_INT1,
+	BMI270_IRQ_INT2,
+};
+
 struct bmi270_data {
 	struct device *dev;
 	struct regmap *regmap;
 	const struct bmi270_chip_info *chip_info;
+	enum bmi270_irq_pin irq_pin;
+	struct iio_trigger *trig;
+	 /* Protect device's private data from concurrent access */
+	struct mutex mutex;
 
 	/*
 	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
@@ -274,6 +303,8 @@ static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 		return -EINVAL;
 	}
 
+	guard(mutex)(&data->mutex);
+
 	for (i = 0; i < bmi270_scale_item.num; i++) {
 		if (bmi270_scale_item.tbl[i].uscale != uscale)
 			continue;
@@ -291,6 +322,8 @@ static int bmi270_get_scale(struct bmi270_data *data, int chan_type, int *scale,
 	unsigned int val;
 	struct bmi270_scale_item bmi270_scale_item;
 
+	guard(mutex)(&data->mutex);
+
 	switch (chan_type) {
 	case IIO_ACCEL:
 		ret = regmap_read(data->regmap, BMI270_ACC_CONF_RANGE_REG, &val);
@@ -346,6 +379,8 @@ static int bmi270_set_odr(struct bmi270_data *data, int chan_type, int odr,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&data->mutex);
+
 	for (i = 0; i < bmi270_odr_item.num; i++) {
 		if (bmi270_odr_item.tbl[i].odr != odr ||
 		    bmi270_odr_item.tbl[i].uodr != uodr)
@@ -364,6 +399,8 @@ static int bmi270_get_odr(struct bmi270_data *data, int chan_type, int *odr,
 	int i, val, ret;
 	struct bmi270_odr_item bmi270_odr_item;
 
+	guard(mutex)(&data->mutex);
+
 	switch (chan_type) {
 	case IIO_ACCEL:
 		ret = regmap_read(data->regmap, BMI270_ACC_CONF_REG, &val);
@@ -397,6 +434,60 @@ static int bmi270_get_odr(struct bmi270_data *data, int chan_type, int *odr,
 	return -EINVAL;
 }
 
+static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bmi270_data *data = iio_priv(indio_dev);
+	unsigned int status;
+	int ret;
+
+	scoped_guard(mutex, &data->mutex) {
+		ret = regmap_read(data->regmap, BMI270_INT_STATUS_1_REG,
+				  &status);
+		if (ret)
+			return IRQ_NONE;
+	}
+
+	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status))
+		iio_trigger_poll_nested(data->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int bmi270_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool state)
+{
+	struct bmi270_data *data = iio_trigger_get_drvdata(trig);
+	unsigned int field_value = 0;
+	unsigned int mask;
+
+	guard(mutex)(&data->mutex);
+
+	switch (data->irq_pin) {
+	case BMI270_IRQ_INT1:
+		mask = BMI270_INT_MAP_DATA_DRDY_INT1_MSK;
+		set_mask_bits(&field_value, BMI270_INT_MAP_DATA_DRDY_INT1_MSK,
+			      FIELD_PREP(BMI270_INT_MAP_DATA_DRDY_INT1_MSK,
+					 state));
+		break;
+	case BMI270_IRQ_INT2:
+		mask = BMI270_INT_MAP_DATA_DRDY_INT2_MSK;
+		set_mask_bits(&field_value, BMI270_INT_MAP_DATA_DRDY_INT2_MSK,
+			      FIELD_PREP(BMI270_INT_MAP_DATA_DRDY_INT2_MSK,
+					 state));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(data->regmap, BMI270_INT_MAP_DATA_REG, mask,
+				  field_value);
+}
+
+static const struct iio_trigger_ops bmi270_trigger_ops = {
+	.set_trigger_state = &bmi270_data_rdy_trigger_set_state,
+};
+
 static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -404,6 +495,8 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	struct bmi270_data *data = iio_priv(indio_dev);
 	int ret;
 
+	guard(mutex)(&data->mutex);
+
 	ret = regmap_bulk_read(data->regmap, BMI270_ACCEL_X_REG,
 			       &data->buffer.channels,
 			       sizeof(data->buffer.channels));
@@ -439,13 +532,15 @@ static int bmi270_get_data(struct bmi270_data *data, int chan_type, int axis,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&data->mutex);
+
 	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(sample));
 	if (ret)
 		return ret;
 
 	*val = sign_extend32(le16_to_cpu(sample), 15);
 
-	return 0;
+	return IIO_VAL_INT;
 }
 
 static int bmi270_read_raw(struct iio_dev *indio_dev,
@@ -457,11 +552,11 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = bmi270_get_data(data, chan->type, chan->channel2, val);
-		if (ret)
-			return ret;
-
-		return IIO_VAL_INT;
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		ret = bmi270_get_scale(data, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
@@ -486,12 +581,21 @@ static int bmi270_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct bmi270_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		return bmi270_set_scale(data, chan->type, val2);
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = bmi270_set_scale(data, chan->type, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return bmi270_set_odr(data, chan->type, val, val2);
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = bmi270_set_odr(data, chan->type, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -597,6 +701,116 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
+static int bmi270_int_pin_config(struct bmi270_data *data,
+				 enum bmi270_irq_pin irq_pin,
+				 bool active_high, bool open_drain, bool latch)
+{
+	unsigned int reg, field_value;
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, BMI270_INT_LATCH_REG,
+				 BMI270_INT_LATCH_REG_MSK,
+				 FIELD_PREP(BMI270_INT_LATCH_REG_MSK, latch));
+	if (ret)
+		return ret;
+
+	switch (irq_pin) {
+	case BMI270_IRQ_INT1:
+		reg = BMI270_INT1_IO_CTRL_REG;
+		break;
+	case BMI270_IRQ_INT2:
+		reg = BMI270_INT2_IO_CTRL_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	field_value = FIELD_PREP(BMI270_INT_IO_CTRL_LVL_MSK, active_high) |
+		      FIELD_PREP(BMI270_INT_IO_CTRL_OD_MSK, open_drain) |
+		      FIELD_PREP(BMI270_INT_IO_CTRL_OP_MSK, 1);
+	return regmap_update_bits(data->regmap, reg,
+				  BMI270_INT_IO_LVL_OD_OP_MSK, field_value);
+}
+
+static int bmi270_trigger_probe(struct bmi270_data *data,
+				struct iio_dev *indio_dev)
+{
+	bool open_drain, active_high, latch;
+	struct fwnode_handle *fwnode;
+	enum bmi270_irq_pin irq_pin;
+	int ret, irq, irq_type;
+
+	fwnode = dev_fwnode(data->dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq > 0) {
+		irq_pin = BMI270_IRQ_INT1;
+	} else {
+		irq = fwnode_irq_get_byname(fwnode, "INT2");
+		if (irq < 0)
+			return 0;
+
+		irq_pin = BMI270_IRQ_INT2;
+	}
+
+	irq_type = irq_get_trigger_type(irq);
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+		latch = false;
+		active_high = true;
+		break;
+	case IRQF_TRIGGER_HIGH:
+		latch = true;
+		active_high = true;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		latch = false;
+		active_high = false;
+		break;
+	case IRQF_TRIGGER_LOW:
+		latch = true;
+		active_high = false;
+		break;
+	default:
+		return dev_err_probe(data->dev, -EINVAL,
+				     "Invalid interrupt type 0x%x specified\n",
+				     irq_type);
+	}
+
+	open_drain = fwnode_property_read_bool(fwnode, "drive-open-drain");
+
+	ret = bmi270_int_pin_config(data, irq_pin, active_high, open_drain,
+				    latch);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Failed to configure irq line\n");
+
+	data->trig = devm_iio_trigger_alloc(data->dev, "%s-trig-%d",
+					    indio_dev->name, irq_pin);
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &bmi270_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, data);
+
+	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+					bmi270_irq_thread_handler,
+					IRQF_ONESHOT, "bmi270-int", indio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Failed to request IRQ\n");
+
+	ret = devm_iio_trigger_register(data->dev, data->trig);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Trigger registration failed\n");
+
+	data->irq_pin = irq_pin;
+
+	return 0;
+}
+
 static int bmi270_validate_chip_id(struct bmi270_data *data)
 {
 	int chip_id;
@@ -757,6 +971,8 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	data->dev = dev;
 	data->regmap = regmap;
 	data->chip_info = chip_info;
+	data->irq_pin = BMI270_IRQ_DISABLED;
+	mutex_init(&data->mutex);
 
 	ret = bmi270_chip_init(data);
 	if (ret)
@@ -769,6 +985,10 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi270_info;
 
+	ret = bmi270_trigger_probe(data, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bmi270_trigger_handler, NULL);

-- 
2.48.1


