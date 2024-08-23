Return-Path: <linux-iio+bounces-8725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC26795D531
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A7B1F216DB
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753B193425;
	Fri, 23 Aug 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igZaUU7R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB80193064;
	Fri, 23 Aug 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437049; cv=none; b=OmKqxKLerCdX4PCeLOfT41TKnBjpvXLCuol1YhaOkcOlsYASGZ3Cp6zuCgUlcwEA7UdN5Iwhjfk8mwENIF22h+H6DkfXX44nIV8fR4t9bJ9JfQm7vx7cKzj18rDnj1k1+fx5M45AZVu2FWKdM2/tcBr+t6C7N8g/0jfL61BFTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437049; c=relaxed/simple;
	bh=Y89p6DX8N6ueQTeusfzloJW6JIV2Rz2X9y/aLL7X28A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmLQR1qgYf/hKgKzm6u51enocoS+XbKRyd4wW6wkvjfr3t7O8CeqkgnDRNxmyFfIIX/bd1xDohqlG9if8o2hNiilgzCrcpInwROFFCZWLO9cEbhjJuETfaTsForn4EGayZbTKjf1TZy/8lMmXCjVRLSWbX3JKB2EGSD/bUPcU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igZaUU7R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso18503385e9.1;
        Fri, 23 Aug 2024 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437046; x=1725041846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvt/FNpAYtEaAShVFEEPm8RnUqdU6ni6d6jREI6w6aA=;
        b=igZaUU7Rw/BZVQL2Zvg1HOyFf+p5WzarxOowST2N/dvUsngOwH0096lP5bgaw4GGAZ
         SzRlHdUxjsdnATmpXHrniDi4rBvn701lHxeGP4C6LhNl0sYpRLC9zM2K4+KL4Uf5jN6t
         WN4vNdtiy+4WxXMBHvrgIVdU7sf2/9O8YSxZFZg42ZOIMhNVvTljUokjL+vpIqFprFEb
         sjZ6jM1vnQnr4YkTkzZVrkTi06lrJxCmS9dT062Sv6q03vWnD9zA4hL8VHwnGWCwwUst
         /S93QlnDkEStYXEUmwBqNZHLFcE0UKcnbbSBcUJfxOZ9PkF0RP4u0jOzDtxpriAFfWuZ
         yTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437046; x=1725041846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvt/FNpAYtEaAShVFEEPm8RnUqdU6ni6d6jREI6w6aA=;
        b=PgYbZrkppah+9VYogq4zF+ba9788c+m0fPGI3bYIqEoUAo6nXYk1PwphqTavA4GIQZ
         aGO3U/HE6V4sCatECBgOWZkZy+0XJbtda4AHJKWtfPhcnJSDv5DwN2tEaWWwZcvyhHe5
         FNhx7US63upPmsis595dWw9qN/BsysX88B/elEw6/+sZ1P038aL4sOUmGIMc1zutsWEo
         MwgkovGAksw+u7Pdip7wAIMaSbPcdtulwkNyA9jPic6HB6+J5DwPSAFWj7aKE2V2/brS
         TdbbcdHv9Hizv7bC5Jq84hL6+Qn9HN6xQyxylOASCGIEgPgfTgIQgeBNv43oYCTUExwx
         qicA==
X-Forwarded-Encrypted: i=1; AJvYcCVpJpMr9kS0StrAow0hBTfQ8bBNm/tApK5d/s5HwLvTmU4WHB5hmB4rZpjJSCl0x1DSSNIUeQ8PsZ/r@vger.kernel.org, AJvYcCWU9nb3XkgTfpfolnQGx5sDdFKbGpakUXVYkOzzdMpe3GlIBh5GI65zTzOrsVGEdksjJKwq+d19y/Hpwm8D@vger.kernel.org, AJvYcCWlVcOvBC87DyMshqRZHeJAaegM0HG69fXdirQt3Oduy/LdOLId6g1+nnKlM4wNhU0ejJSt1sMIHRI5@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4kvtZdGkEv8pA5o9h98EQAiUCwyh8+Pf8+Py0sKSPOCRUUWX
	v9Xw8Ri3VBpI452h4oV+lC4a2/59Z6euGeBUiDzRVifXmWkPT3qM
X-Google-Smtp-Source: AGHT+IFht4GCmA2FH2vNSh2pKJ6oWtzpmhrnSk1tpdhrVa4t6+hdDXBOiNPAJ6BjzxIEnLwq8Owqeg==
X-Received: by 2002:a05:6000:e52:b0:367:9d05:cf2a with SMTP id ffacd0b85a97d-373118d2295mr2015799f8f.42.1724437045122;
        Fri, 23 Aug 2024 11:17:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm4677939f8f.44.2024.08.23.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:17:24 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] iio: pressure: bmp280: Add data ready trigger support
Date: Fri, 23 Aug 2024 20:17:13 +0200
Message-Id: <20240823181714.64545-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823181714.64545-1-vassilisamir@gmail.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 252 ++++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280.h      |  21 +++
 2 files changed, 269 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index e1336aeceec0..f5268a13bfdb 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -37,12 +37,14 @@
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
 
@@ -1271,6 +1273,74 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
+				  const struct iio_trigger_ops *trigger_ops,
+				  int (*int_config)(struct bmp280_data *data),
+				  irqreturn_t (*irq_thread_handler)(int irq, void *p))
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	struct fwnode_handle *fwnode;
+	int ret, irq, irq_type;
+	struct irq_data *desc;
+
+	fwnode = dev_fwnode(data->dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	irq = fwnode_irq_get(fwnode, 0);
+	if (!irq)
+		return dev_err_probe(data->dev, -ENODEV,
+				     "No interrupt found.\n");
+
+	desc = irq_get_irq_data(irq);
+	if (!desc)
+		return -EINVAL;
+
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
+	data->trig_open_drain = fwnode_property_read_bool(fwnode,
+							  "int-open-drain");
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
 
@@ -1769,6 +1839,85 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
+				 FIELD_PREP(BMP380_INT_CTRL_DRDY_EN,
+					    state ? 1 : 0));
+	if (ret) {
+		dev_err(data->dev, "Could not enable/disable interrupt\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct iio_trigger_ops bmp380_trigger_ops = {
+	.set_trigger_state = &bmp380_data_rdy_trigger_set_state,
+	.reenable = &bmp380_trigger_reenable,
+};
+
+static int bmp380_int_config(struct bmp280_data *data)
+{
+	int ret, int_cfg = FIELD_PREP(BMP380_INT_CTRL_OPEN_DRAIN,
+				      data->trig_open_drain) |
+			   FIELD_PREP(BMP380_INT_CTRL_LEVEL,
+				      data->trig_active_high);
+
+	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
+				 BMP380_INT_CTRL_SETTINGS_MASK, int_cfg);
+	if (ret) {
+		dev_err(data->dev, "Could not set interrupt settings\n");
+		return ret;
+	}
+
+	return 0;
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
@@ -1863,6 +2012,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
+	.trigger_probe = bmp380_trigger_probe,
 	.trigger_handler = bmp380_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
@@ -2401,6 +2551,92 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
+				 FIELD_PREP(BMP580_INT_CONFIG_INT_EN,
+					    state ? 1 : 0));
+	if (ret) {
+		dev_err(data->dev, "Could not enable/disable interrupt\n");
+		return ret;
+	}
+
+	return 0;
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
@@ -2477,6 +2713,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
+	.trigger_probe = bmp580_trigger_probe,
 	.trigger_handler = bmp580_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
@@ -3024,10 +3261,17 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
-		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
-		if (ret)
-			return ret;
+	if (irq > 0) {
+		if (chip_id == BMP180_CHIP_ID) {
+			ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
+			if (ret)
+				return ret;
+		}
+		if (data->chip_info->trigger_probe) {
+			ret = data->chip_info->trigger_probe(indio_dev);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = data->chip_info->set_mode(data, BMP280_SLEEP);
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


