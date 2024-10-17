Return-Path: <linux-iio+bounces-10702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF19A3168
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 01:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E730E1F22D90
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB67205ACF;
	Thu, 17 Oct 2024 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za/KE9Au"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59600205AA4;
	Thu, 17 Oct 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207840; cv=none; b=uaaP0IK1Oqe1x/HskCgzUn+TdbUsWAqC828Jk5oqgx/1/EM9jgRjCsKhugju2JEWstjw1u//tQP66LnhaMCc4HEdiyqS2qFzVIOYJW4vRSjYX4SxhCQ3/kdIh4MMAAZe4OYRCOwY4KOY2TxVdzCtTGzh72+r7P3bZY2zErvQzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207840; c=relaxed/simple;
	bh=oRb5xpcd/iPuTu6s3Cmyy1HzBwTIfI4MkXZuyr5lwhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVo7zDjKRa1VySZJVCYlJOfA+mJ4A9jT7oIZfqMVLFX9RNyIxN7gIpPjWVOq9fFLddHXcMAgQaQAizpcvsNBNmHrewi4sGUt6CqN+raVMZdQO/7S0Cc+7g8Ca6u+FOxGZJYIyPkqhYyoOEHYykTsQP27oZNDq3ht40cdJJZbrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za/KE9Au; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so1137476f8f.3;
        Thu, 17 Oct 2024 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729207837; x=1729812637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqC4jhkEzX/0PiAUkSZMMW8RBuoLzgshKD/S/9YVKyw=;
        b=Za/KE9AuE0TJ0c7fDBJbOfQgpYjmtuhQRB6E83cvFpEb2f3aoFSAGcS7LLWK7+8LER
         qPTe+CD2Y+uXO6CKawxrg1FBSrMwZFxXmc3YjDppJUDV1Sd51Qja2Vhx1EgW8tlQbs4f
         OjV4La2X2R8bEaLSeRUwILLBkn0KhN0cpF5Yz4BsZBi5s5zQxlavBHtLVc4nbMZLgf82
         6hjSFWIklWiCUjJhugnFkgjbYZpPMwd62Kpj0H93sgBxrZlNnZP0FaSm7LfvO2vef8Ij
         gIEpxPTEhcfkras6rUhFpP2O9DhqPIZ6zXKI3pMAHKZGCRSCRRn4roO4BN8Fur+buT86
         TRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729207837; x=1729812637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqC4jhkEzX/0PiAUkSZMMW8RBuoLzgshKD/S/9YVKyw=;
        b=XwvueOd0lia4EVByH04MWdV4CGjepi8c0qxhICRH4afAArBYmFgT22CN7HO2NkC7lS
         LrJPMunIUKd9QchXZ9bQcL8euxXbiy3+RiIDO/cMC+2LQBvMDcljZVc8SkQznDOQx4w5
         XF31gTa6oALU9RytN9CAy6ZGXjso/AcHjg/ObbeRykSOborBMe1pjL0nJvNawIaAAchy
         fgT8+nxG65y0tV+KTJr1xdf7vAybxCF1YpS/76cMypK4ibNab+IFd63lOOtGFH4zIdfF
         tuVOz8tJ6B2gRurhcESR2GGwdctZZsqrZ4DkcS78MHKGFn4h+digtEe0dKwwv225OZCT
         HGug==
X-Forwarded-Encrypted: i=1; AJvYcCW5cd+MGdgVxUtwyg9rtil8gK0u1IJbMMA1GlcGcxGxOKQqwsxrzHbDejRVYuwZFnXygplkdE5/t42S@vger.kernel.org, AJvYcCWzFrLLfiHM4JQYZpotxKeyZd/QHPNgWZoSMNUg09OLLy8AtBHF+Q5wPWzxreBE1gwiAniz79UEZWbt@vger.kernel.org, AJvYcCXr9H+rYTcJPpUNJvtzRTeCtCZisAgu3IjV99ZJnDO6BgSNeuyHaHDPu0rYw9SPD4KoOFd8AXOkKthGChN6@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMKUlkQxP8mVZhELdGLdxWDgFY17wwKip6PhDayT1PvZRmj6f
	3K9Zqbzr6CL+CvUQ+wHoynRoDZKA7I5MicB8goiyG7/ez3xv6hJo
X-Google-Smtp-Source: AGHT+IHnq7HTC7LLEv0jNTGWSFFP+v2JZL2E6bcxQ0PJN5kxEVb+W9VP/96cHavEVQXp2EvYaMY2qQ==
X-Received: by 2002:adf:a198:0:b0:374:b6f3:728d with SMTP id ffacd0b85a97d-37eb487a528mr286607f8f.46.1729207836354;
        Thu, 17 Oct 2024 16:30:36 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:8661:df0e:b445:43ef])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ecf06d3casm306939f8f.48.2024.10.17.16.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 16:30:35 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	ajarizzo@gmail.com,
	biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/4] iio: pressure: bmp280: Add data ready trigger support
Date: Fri, 18 Oct 2024 01:30:21 +0200
Message-ID: <20241017233022.238250-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017233022.238250-1-vassilisamir@gmail.com>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
a trigger for when there are data ready in the sensor for pick up.

This use case is used along with NORMAL_MODE in the sensor, which allows
the sensor to do consecutive measurements depending on the ODR rate value.

The trigger pin can be configured to be open-drain or push-pull and either
rising or falling edge.

No support is added yet for interrupts for FIFO, WATERMARK and out of range
values.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 197 ++++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280.h      |  21 +++
 2 files changed, 216 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 70abaff08646..a941423a899a 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -42,12 +42,14 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/random.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -1280,6 +1282,63 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
+				  const struct iio_trigger_ops *trigger_ops,
+				  int (*int_pin_config)(struct bmp280_data *data),
+				  irq_handler_t irq_thread_handler)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	struct device *dev = data->dev;
+	u32 irq_type;
+	int ret, irq;
+
+	irq = fwnode_irq_get(dev_fwnode(dev), 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "No interrupt found.\n");
+
+	irq_type = irq_get_trigger_type(irq);
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+		data->trig_active_high = true;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		data->trig_active_high = false;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Invalid interrupt type specified.\n");
+	}
+
+	data->trig_open_drain =
+		fwnode_property_read_bool(dev_fwnode(dev), "int-open-drain");
+
+	ret = int_pin_config(data);
+	if (ret)
+		return ret;
+
+	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
+					    indio_dev->name,
+					    iio_device_id(indio_dev));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = trigger_ops;
+	iio_trigger_set_drvdata(data->trig, data);
+
+	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+					irq_thread_handler, IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "request IRQ failed.\n");
+
+	ret = devm_iio_trigger_register(data->dev, data->trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "iio trigger register failed.\n");
+
+	indio_dev->trig = iio_trigger_get(data->trig);
+
+	return 0;
+}
+
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
 static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
@@ -1774,6 +1833,67 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	return ret;
 }
 
+static int bmp380_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool state)
+{
+	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
+				 BMP380_INT_CTRL_DRDY_EN,
+				 FIELD_PREP(BMP380_INT_CTRL_DRDY_EN, !!state));
+	if (ret)
+		dev_err(data->dev,
+			"Could not %s interrupt.\n", str_enable_disable(state));
+	return ret;
+}
+
+static const struct iio_trigger_ops bmp380_trigger_ops = {
+	.set_trigger_state = &bmp380_data_rdy_trigger_set_state,
+};
+
+static int bmp380_int_pin_config(struct bmp280_data *data)
+{
+	int pin_drive_cfg = FIELD_PREP(BMP380_INT_CTRL_OPEN_DRAIN,
+				       data->trig_open_drain);
+	int pin_level_cfg = FIELD_PREP(BMP380_INT_CTRL_LEVEL,
+				       data->trig_active_high);
+	int ret, int_pin_cfg = pin_drive_cfg | pin_level_cfg;
+
+	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
+				 BMP380_INT_CTRL_SETTINGS_MASK, int_pin_cfg);
+	if (ret)
+		dev_err(data->dev, "Could not set interrupt settings.\n");
+
+	return ret;
+}
+
+static irqreturn_t bmp380_irq_thread_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	unsigned int int_ctrl;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMP380_REG_INT_STATUS, &int_ctrl);
+	if (ret)
+		return IRQ_NONE;
+
+	if (FIELD_GET(BMP380_INT_STATUS_DRDY, int_ctrl))
+		iio_trigger_poll_nested(data->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int bmp380_trigger_probe(struct iio_dev *indio_dev)
+{
+	return __bmp280_trigger_probe(indio_dev, &bmp380_trigger_ops,
+				      bmp380_int_pin_config,
+				      bmp380_irq_thread_handler);
+}
+
 static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -1871,6 +1991,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
+	.trigger_probe = bmp380_trigger_probe,
 	.trigger_handler = bmp380_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
@@ -2413,6 +2534,74 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static int bmp580_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool state)
+{
+	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
+				 BMP580_INT_CONFIG_INT_EN,
+				 FIELD_PREP(BMP580_INT_CONFIG_INT_EN, !!state));
+	if (ret)
+		dev_err(data->dev,
+			"Could not %s interrupt.\n", str_enable_disable(state));
+	return ret;
+}
+
+static const struct iio_trigger_ops bmp580_trigger_ops = {
+	.set_trigger_state = &bmp580_data_rdy_trigger_set_state,
+};
+
+static int bmp580_int_pin_config(struct bmp280_data *data)
+{
+	int pin_drive_cfg = FIELD_PREP(BMP580_INT_CONFIG_OPEN_DRAIN,
+				       data->trig_open_drain);
+	int pin_level_cfg = FIELD_PREP(BMP580_INT_CONFIG_LEVEL,
+				       data->trig_active_high);
+	int ret, int_pin_cfg = pin_drive_cfg | pin_level_cfg;
+
+	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
+				 BMP580_INT_CONFIG_MASK, int_pin_cfg);
+	if (ret) {
+		dev_err(data->dev, "Could not set interrupt settings.\n");
+		return ret;
+	}
+
+	ret = regmap_set_bits(data->regmap, BMP580_REG_INT_SOURCE,
+			      BMP580_INT_SOURCE_DRDY);
+	if (ret)
+		dev_err(data->dev, "Could not set interrupt source.\n");
+
+	return ret;
+}
+
+static irqreturn_t bmp580_irq_thread_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	unsigned int int_ctrl;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &int_ctrl);
+	if (ret)
+		return IRQ_NONE;
+
+	if (FIELD_GET(BMP580_INT_STATUS_DRDY_MASK, int_ctrl))
+		iio_trigger_poll_nested(data->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int bmp580_trigger_probe(struct iio_dev *indio_dev)
+{
+	return __bmp280_trigger_probe(indio_dev, &bmp580_trigger_ops,
+				      bmp580_int_pin_config,
+				      bmp580_irq_thread_handler);
+}
+
 static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -2493,6 +2682,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
+	.trigger_probe = bmp580_trigger_probe,
 	.trigger_handler = bmp580_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
@@ -3041,8 +3231,11 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
-		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
+	if (irq > 0) {
+		if (chip_id == BMP180_CHIP_ID)
+			ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
+		if (data->chip_info->trigger_probe)
+			ret = data->chip_info->trigger_probe(indio_dev);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 3babf90ce73c..12f6e90b3728 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -55,8 +55,17 @@
 #define BMP580_CMD_NVM_WRITE_SEQ_1	0xA0
 #define BMP580_CMD_SOFT_RESET		0xB6
 
+#define BMP580_INT_STATUS_DRDY_MASK	BIT(0)
 #define BMP580_INT_STATUS_POR_MASK	BIT(4)
 
+#define BMP580_INT_SOURCE_DRDY		BIT(0)
+
+#define BMP580_INT_CONFIG_MASK		GENMASK(3, 0)
+#define BMP580_INT_CONFIG_LATCH		BIT(0)
+#define BMP580_INT_CONFIG_LEVEL		BIT(1)
+#define BMP580_INT_CONFIG_OPEN_DRAIN	BIT(2)
+#define BMP580_INT_CONFIG_INT_EN	BIT(3)
+
 #define BMP580_STATUS_CORE_RDY_MASK	BIT(0)
 #define BMP580_STATUS_NVM_RDY_MASK	BIT(1)
 #define BMP580_STATUS_NVM_ERR_MASK	BIT(2)
@@ -175,6 +184,14 @@
 #define BMP380_TEMP_MEAS_OFFSET		163
 #define BMP380_PRESS_MEAS_OFFSET	392
 
+#define BMP380_INT_STATUS_DRDY		BIT(3)
+
+#define BMP380_INT_CTRL_SETTINGS_MASK	GENMASK(2, 0)
+#define BMP380_INT_CTRL_OPEN_DRAIN	BIT(0)
+#define BMP380_INT_CTRL_LEVEL		BIT(1)
+#define BMP380_INT_CTRL_LATCH		BIT(2)
+#define BMP380_INT_CTRL_DRDY_EN		BIT(6)
+
 #define BMP380_MIN_TEMP			-4000
 #define BMP380_MAX_TEMP			8500
 #define BMP380_MIN_PRES			3000000
@@ -407,6 +424,9 @@ struct bmp280_data {
 	struct regmap *regmap;
 	struct completion done;
 	bool use_eoc;
+	bool trig_open_drain;
+	bool trig_active_high;
+	struct iio_trigger *trig;
 	const struct bmp280_chip_info *chip_info;
 	union {
 		struct bmp180_calib bmp180;
@@ -509,6 +529,7 @@ struct bmp280_chip_info {
 	int (*set_mode)(struct bmp280_data *data, enum bmp280_op_mode mode);
 	int (*wait_conv)(struct bmp280_data *data);
 
+	int (*trigger_probe)(struct iio_dev *indio_dev);
 	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
 
-- 
2.43.0


