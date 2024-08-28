Return-Path: <linux-iio+bounces-8853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F108963307
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 22:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA3C286810
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12291AED4A;
	Wed, 28 Aug 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2it9TPr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCD1AE85D;
	Wed, 28 Aug 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878306; cv=none; b=ha2ccJr3+F7ZrbnAg0mEOfhCB57pSCtAAognzDyjuxXwKfOEiLXvuo/nQa1Rm59zSQpO7nuNaH57ORT2kALYVO4PH++xsYrwakASQHB507JweWh4mvFoG5vwhJLGRivJ5SwK8Mm+ZQs2CFfq/oiTxYIljYjxtMt82cqV7FV5+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878306; c=relaxed/simple;
	bh=irbEEXLq3KeiYRXNIZnVt42/z9sHufSatG+DsR4OwsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rt1/e9r7ZxMRit+CIlEBub2dEe5G45tXGMVkXI3Q/8PxnxqDkCn2gD5qNenLsH8bLPwNt/+Ik8TjLHkUZeP/vd3jwSuThC4eRDj62aenm8xzALXDsX78o1f9P4fBIRU2EbqMYKJ0eq/0+JfW0e9mjV0caiVNmotdJms8N2w6vko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2it9TPr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371afae614aso3795442f8f.0;
        Wed, 28 Aug 2024 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878303; x=1725483103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPQMiMSnj5TVKRtNl5cJ/OcLpnpbWvPugl5U5PPuG44=;
        b=N2it9TPr4tZw8NkbqcrB31Y6Vi+Hq3QYaBRwLKNTQbzvJGVpJ3adBxq1yNgtKoVlea
         nxaDjz6VL0UZQtyBIU3mMfO8rjGxDnblDP8/WbVXkmlQK7wSM67GSL6YsGXkKJJ7gDAn
         Hh9wYDWm3iEz82XTbOgNSkcl+JN/MODPiWKEPQKP5qsivEpgavGbzw1HRSfz3ufr9riP
         IkCwXbEWo6683NxRbq7YuuImGyftNPLZf6zZu+yw41U6JYhZ270XjFFf10YIkAr0c1tP
         9eKMs1j6CpJ8XF4hdbFI4PT/d2EX3Ye5xQoUMm7fNgEzA7hRw/jHg302Dvgnqi6k5SL7
         TMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878303; x=1725483103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPQMiMSnj5TVKRtNl5cJ/OcLpnpbWvPugl5U5PPuG44=;
        b=kKsau3qS01ft+EgEaEd7Q6lBSpU8b5WXXwWjD/tL7bKHS6qPb85l8j13G76+1XFaV8
         4PYJTvfuB9WjUI1PjXRBSWkoVpUmTnm/CxNsH1PIzjkCAaZe5WB19mYjflgUfzntPj/H
         u506w1NP45o9MbFdzcYwSUfRUZVpONkklqk6OV9kNXKrLPTLOhR4/HfQAMXoScIlFFmw
         jiE47v7Ri2c7VqDpnroE0fD1X/tXXalBdHcA/WXySPoQG3BY1RzZ7nB1zsZaPKLFacos
         wyhHGzG6pOYFXpVk7pJyCvdD4+77cm/x0udC0xXf8uaepAxt/UQhGI/0smIsvY2nn6dj
         v3BA==
X-Forwarded-Encrypted: i=1; AJvYcCV7w3Y0rYvgIp6yHCroFTaMBwHZrUhWN09YLfWlwYMOcNULD5GODhZTuUvFpBhxVAVzbw4/3AK8QWTK@vger.kernel.org, AJvYcCVGDEY5Bs+JaIp/JBkVPNpm9rwLLYnAZdkkEWu5qRmVMrX0sERDYH/+p7bunmZqjwfd7shpNLH/TnrqCDuR@vger.kernel.org, AJvYcCVZA78IZLa61n7JrUECyjXT0pSnFqhutgoIGI95XVRBtpI+o2MmS628XS6fVFljbtpB2OcqIZmeTssB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6iOsJoofgM/t4RQa7KoWd1WzV1tUg3QBtb4EXGWGjc/fOUWv5
	r/WlYvPnmAjF7IFDCP7byiGc8LuAW1dIq3r4s0PzT6qMl79zuD3C
X-Google-Smtp-Source: AGHT+IFTzxz9UqkPDmf37QrOgbo5+Di4bwMKgfIna/vJsLqwu082e6HexxXlMOVrCaVEv82MhaPIvg==
X-Received: by 2002:adf:f410:0:b0:368:4d33:9aac with SMTP id ffacd0b85a97d-3749b54ecd6mr379254f8f.31.1724878302040;
        Wed, 28 Aug 2024 13:51:42 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2f53sm2646566a12.19.2024.08.28.13.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:51:41 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v4 6/7] iio: pressure: bmp280: Add data ready trigger support
Date: Wed, 28 Aug 2024 22:51:26 +0200
Message-Id: <20240828205128.92145-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828205128.92145-1-vassilisamir@gmail.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
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

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 231 ++++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280.h      |  21 +++
 2 files changed, 250 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index e716bcb1dc96..c37c56446183 100644
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
 
@@ -1282,6 +1284,66 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
+				  const struct iio_trigger_ops *trigger_ops,
+				  int (*int_config)(struct bmp280_data *data),
+				  irq_handler_t irq_thread_handler)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	struct fwnode_handle *fwnode;
+	int ret, irq, irq_type;
+	struct irq_data *desc;
+
+	irq = fwnode_irq_get(dev_fwnode(data->dev), 0);
+	if (irq < 0)
+		return dev_err_probe(data->dev, irq, "No interrupt found.\n");
+
+	desc = irq_get_irq_data(irq);
+	irq_type = irqd_get_trigger_type(desc);
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+		data->trig_active_high = true;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		data->trig_active_high = false;
+		break;
+	default:
+		return dev_err_probe(data->dev, -EINVAL,
+				     "Invalid interrupt type specified.\n");
+	}
+
+	data->trig_open_drain =
+		fwnode_property_read_bool(fwnode, "int-open-drain");
+
+	ret = int_config(data);
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
+		return dev_err_probe(data->dev, ret, "request irq failed.\n");
+
+	ret = devm_iio_trigger_register(data->dev, data->trig);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio trigger register failed.\n");
+
+	indio_dev->trig = iio_trigger_get(data->trig);
+
+	return 0;
+}
+
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
 static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
@@ -1785,6 +1847,83 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static void bmp380_trigger_reenable(struct iio_trigger *trig)
+{
+	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
+	unsigned int tmp;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMP380_REG_INT_STATUS, &tmp);
+	if (ret)
+		dev_err(data->dev, "Failed to reset interrupt\n");
+}
+
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
+			"Could not %s interrupt\n", str_enable_disable(state));
+	return ret;
+}
+
+static const struct iio_trigger_ops bmp380_trigger_ops = {
+	.set_trigger_state = &bmp380_data_rdy_trigger_set_state,
+	.reenable = &bmp380_trigger_reenable,
+};
+
+static int bmp380_int_config(struct bmp280_data *data)
+{
+	int pin_drive_cfg = FIELD_PREP(BMP380_INT_CTRL_OPEN_DRAIN,
+				       data->trig_open_drain);
+	int pin_level_cfg = FIELD_PREP(BMP380_INT_CTRL_LEVEL,
+				       data->trig_active_high);
+	int ret, int_cfg = pin_drive_cfg | pin_level_cfg;
+
+	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
+				 BMP380_INT_CTRL_SETTINGS_MASK, int_cfg);
+	if (ret) {
+		dev_err(data->dev, "Could not set interrupt settings\n");
+		return ret;
+	}
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
+	scoped_guard(mutex, &data->lock) {
+		ret = regmap_read(data->regmap, BMP380_REG_INT_STATUS, &int_ctrl);
+		if (ret)
+			return IRQ_NONE;
+	}
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
+				      bmp380_int_config,
+				      bmp380_irq_thread_handler);
+}
+
 static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -1879,6 +2018,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
+	.trigger_probe = bmp380_trigger_probe,
 	.trigger_handler = bmp380_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
@@ -2421,6 +2561,89 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static void bmp580_trigger_reenable(struct iio_trigger *trig)
+{
+	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
+	unsigned int tmp;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &tmp);
+	if (ret)
+		dev_err(data->dev, "Failed to reset interrupt\n");
+}
+
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
+			"Could not %s interrupt\n", str_enable_disable(state));
+	return ret;
+}
+
+static const struct iio_trigger_ops bmp580_trigger_ops = {
+	.set_trigger_state = &bmp580_data_rdy_trigger_set_state,
+	.reenable = &bmp580_trigger_reenable,
+};
+
+static int bmp580_int_config(struct bmp280_data *data)
+{
+	int ret, int_cfg = FIELD_PREP(BMP580_INT_CONFIG_OPEN_DRAIN,
+				      data->trig_open_drain) |
+			   FIELD_PREP(BMP580_INT_CONFIG_LEVEL,
+				      data->trig_active_high);
+
+	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
+				 BMP580_INT_CONFIG_MASK, int_cfg);
+	if (ret) {
+		dev_err(data->dev, "Could not set interrupt settings\n");
+		return ret;
+	}
+
+	ret = regmap_set_bits(data->regmap, BMP580_REG_INT_SOURCE,
+			      BMP580_INT_SOURCE_DRDY);
+	if (ret) {
+		dev_err(data->dev, "Could not set interrupt source\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static irqreturn_t bmp580_irq_thread_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	unsigned int int_ctrl;
+	int ret;
+
+	scoped_guard(mutex, &data->lock) {
+		ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &int_ctrl);
+		if (ret)
+			return IRQ_NONE;
+	}
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
+				      bmp580_int_config,
+				      bmp580_irq_thread_handler);
+}
+
 static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -2497,6 +2720,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
+	.trigger_probe = bmp580_trigger_probe,
 	.trigger_handler = bmp580_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
@@ -3044,8 +3268,11 @@ int bmp280_common_probe(struct device *dev,
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
index c9840b8d58b0..0c32b6430677 100644
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
@@ -406,6 +423,9 @@ struct bmp280_data {
 	struct regmap *regmap;
 	struct completion done;
 	bool use_eoc;
+	bool trig_open_drain;
+	bool trig_active_high;
+	struct iio_trigger *trig;
 	const struct bmp280_chip_info *chip_info;
 	union {
 		struct bmp180_calib bmp180;
@@ -510,6 +530,7 @@ struct bmp280_chip_info {
 	int (*set_mode)(struct bmp280_data *data, enum bmp280_op_mode mode);
 	int (*wait_conv)(struct bmp280_data *data);
 
+	int (*trigger_probe)(struct iio_dev *indio_dev);
 	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
 
-- 
2.25.1


