Return-Path: <linux-iio+bounces-15820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4241BA3CDF6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 00:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1869B177EE8
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9326463F;
	Wed, 19 Feb 2025 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4c+uybc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1ED264633;
	Wed, 19 Feb 2025 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009314; cv=none; b=lDtnf80GFQaSqMNlgsORpjbEXk+gxfi7c1TOUyuKPACny5EkbeseuRTz1AHCF7+RaJhfvTolXvbSVO/xnVmhvTNVlLEzeUknaNP4LIyB4zuXuSRKts0ln1NVtydUR9q+dAcaC1OL6qCx2Rr8rqIWY+CXFWVHB0oVY0AqvHbPIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009314; c=relaxed/simple;
	bh=ve34TvsoMyyCjQN9059+IZDpFYsqvWYxczdOfTdKZQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPuISi0PRhb+ucWdcp8PXvI32WvjQ/qMB2S/KE0gXVjJfOZJhVuRmvoI+o9Cwu+z0ZN3X4UMBTJd2AagDVIfqMCqtLcj+AFVA6CzNMvEj4moKbhIXYwfkYUZZwsXKfxn9tyTYKgt+DTqGn85ErRczBgS5xOAZf7d7tnOtdraYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4c+uybc; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-727295a84c3so99058a34.3;
        Wed, 19 Feb 2025 15:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740009312; x=1740614112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLobpFvmw9FiScmPPhTfnpE5foXSbsLoHjF7Q05HD6U=;
        b=i4c+uybcWsXbpPvFIZ5sjxrZJOSjiPA3xNJf3aY7i0p50rZ+4H8a7EgScic9CUWbZK
         n65UzbXUkIDMTThApC4Bd06T3iPmx3pIsP88nBEWozleWxCX+z5F+2IH+C9eYtLMYB2O
         aU+jYkfMqRytuOHc8GcW8g5LSPO0Us/YMi9W+ws0LZjUuj5G1cuZPrUSRCr4qQwIDZci
         1d4lXB13YaMqavScv1rdAbKWv1thPo3lMD2jKcJwbPBWdNHrIhmmCX/1gVSTedRK77Ac
         RSairNLFaNpA/8QWxK2+KZhQvj0QuesBkpEYJ3c1b8qrPRu1BTojrNlzGXpIWruzZ19p
         EV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740009312; x=1740614112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLobpFvmw9FiScmPPhTfnpE5foXSbsLoHjF7Q05HD6U=;
        b=dCHzn+x+k4xOdbwsH7KyDs9/mEMkrjUYlkY8hgkZAU6PRbX4Vk6lPLZNBcud6l4hs2
         0Lslm9zZyPn5WKRBdz3oPz4ZO28nJnwo1AV9LF1SNbeBd4mrfzv42paP5kl58rDBgp1B
         26apKqJTOLAdqZOSy6BYbAuMA9ZwItQnR4cIEj2FEEx44W7fg9ZBrxLFDZudF0hX0aFf
         loo8wDsvhmQlFSDetCjRM/FhNwn6EdSw1ObTOrMvpuoGiucB3cq6p3BnpPbOY6jp3voO
         xvto4PFhgA8epoldlPnDnwDyyGtnwiwzcXY459O/uEpmOXV5TMC0DnvKdCZC0LJPpBIc
         OmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNCdZ91Yw+HJiZkZKQUowD4byIj7adlYFeASWSVAU9zNYdnQSx/IYzGlH1xTnMw+Za0tbIiMlUlleXkZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6tZJ4hOLZj2SeRXIjk/7ne7B5E0ojv0pWhYojE6riXfsdAnwA
	4YfDFAS9QL7vTV+Rh1jtMsNWiI7UuYM/dOMw4jhfjV6VfOMS83Nf
X-Gm-Gg: ASbGncsh38sRazGE4QHbdwryy57ih1mDO6cMb2qaq8HQ7xL1t6J8TMwcqE5wu/TAQPn
	oOK+xJudjWU3JVclk2Wu2Cr1JvtGXbqBhh7mUYH7pgla+cpJS+zd/bk05gmtPW8fC+iVZBpfpDP
	CG4m5GkF+XugTbZbtJGmzuc49sIMvZMQI97vrtTKESVwMTQVSPFbXTwFbG8ImDf7Hyg5/RzIK5l
	gN5sSWOuL/6SPpuqMoxFdnRHZFOVnjR4OM/jhDTelLkoq4VEa8kP0IEKXAfZBtOiWANgy7M7PLF
	/HXTmLoI
X-Google-Smtp-Source: AGHT+IEGaja+ctFGtC3sIjY6wymUaNOrZKDajia/6ANe2MSQR7TtxXcGddQ/3eDAzEJvjyk+oHllrg==
X-Received: by 2002:a05:6830:810c:b0:727:23ec:c3ec with SMTP id 46e09a7af769-72723ecc718mr6786918a34.28.1740009311921;
        Wed, 19 Feb 2025 15:55:11 -0800 (PST)
Received: from [192.168.0.107] ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7273a14070esm658173a34.49.2025.02.19.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:55:11 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Wed, 19 Feb 2025 20:54:47 -0300
Subject: [PATCH 3/3] iio: imu: bmi270: add support for data ready interrupt
 trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-bmi270-irq-v1-3-145d02bbca3b@gmail.com>
References: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
In-Reply-To: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740009298; l=11465;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=ve34TvsoMyyCjQN9059+IZDpFYsqvWYxczdOfTdKZQI=;
 b=RwbUceS2zey0tpFsMeTIcCDUabBrXBAtVos+0WKF/5M/5YoREA0csS3JxhVuE1iqF49J3AR06
 Klywnd0p1gKDQc8bDcRYkc6ik8RcYNdADLIg5d7wSIJREZ2BovJ5tU1
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

The BMI270 sensor provides two interrupt pins that can be used for
different interrupt sources, including a data ready signal. Add support
for configuring one the pins as a trigger source.

The interrupt pin can be configured with various options: active high or
low, push-pull or open-drain, and latched or non-latched.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 234 +++++++++++++++++++++++++++++++++--
 1 file changed, 227 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 56ebd887fcec94b684dc23f1b4503b719fb39239..378943dfe69ebdb3937f724a7c57f7556a5c452e 100644
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
@@ -291,6 +322,8 @@ static int bmi270_get_scale(struct bmi270_data *data, int chan_type,
 	unsigned int val;
 	struct bmi270_scale_item bmi270_scale_item;
 
+	guard(mutex)(&data->mutex);
+
 	switch (chan_type) {
 	case IIO_ACCEL:
 		ret = regmap_read(data->regmap,
@@ -348,6 +381,8 @@ static int bmi270_set_odr(struct bmi270_data *data, int chan_type, int odr,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&data->mutex);
+
 	for (i = 0; i < bmi270_odr_item.num; i++) {
 		if (bmi270_odr_item.tbl[i].odr != odr ||
 		    bmi270_odr_item.tbl[i].uodr != uodr)
@@ -366,6 +401,8 @@ static int bmi270_get_odr(struct bmi270_data *data, int chan_type, int *odr,
 	int i, val, ret;
 	struct bmi270_odr_item bmi270_odr_item;
 
+	guard(mutex)(&data->mutex);
+
 	switch (chan_type) {
 	case IIO_ACCEL:
 		ret = regmap_read(data->regmap, BMI270_ACC_CONF_REG, &val);
@@ -399,6 +436,60 @@ static int bmi270_get_odr(struct bmi270_data *data, int chan_type, int *odr,
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
@@ -406,6 +497,8 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	struct bmi270_data *data = iio_priv(indio_dev);
 	int ret;
 
+	guard(mutex)(&data->mutex);
+
 	ret = regmap_bulk_read(data->regmap, BMI270_ACCEL_X_REG,
 			       &data->buffer.channels,
 			       sizeof(data->buffer.channels));
@@ -441,13 +534,15 @@ static int bmi270_get_data(struct bmi270_data *data,
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
@@ -459,11 +554,11 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 
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
@@ -488,12 +583,21 @@ static int bmi270_write_raw(struct iio_dev *indio_dev,
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
@@ -599,6 +703,116 @@ static const struct iio_chan_spec bmi270_channels[] = {
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
@@ -759,6 +973,8 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	data->dev = dev;
 	data->regmap = regmap;
 	data->chip_info = chip_info;
+	data->irq_pin = BMI270_IRQ_DISABLED;
+	mutex_init(&data->mutex);
 
 	ret = bmi270_chip_init(data);
 	if (ret)
@@ -771,6 +987,10 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
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


