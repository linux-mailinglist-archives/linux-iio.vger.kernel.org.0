Return-Path: <linux-iio+bounces-9531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9D4978C28
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 02:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B941F23E11
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C72107;
	Sat, 14 Sep 2024 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwC9zj+t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB779F6;
	Sat, 14 Sep 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273752; cv=none; b=DoPi25zByEBX0EwXeaodNZUAyZp452NHmnfu5YAJy7ySuhwCwrSh5J9AVA8w9MaZeHocY6US41qmsVm/qXWupTIoa21Lo8JPkqNg1sHKFLtvA+FVnsZpUCQCwWhe0m8fMKzB9BoQACvA8zAimfqTNFByzWUHs2hnZfv//odPMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273752; c=relaxed/simple;
	bh=GbA0gjji055dHjx+7A0z3FD74Sx7Dq30g7Be27Ov1Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVyHPEDDUkBsYnDq7W758nuDmcnGTnPEtYDxrIpLOmqVUd6XljfEpld1VAGRxQrEyqQJ6m+xDxr3q0kzXJinS5XO1vsSAGcjM8D4EUQs10CsrGWkPXhyHKeZ1DryTjJOOozS1SQOEL3d09D94UITEZESyqsOAHqcHblen12uSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwC9zj+t; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so3089150a12.1;
        Fri, 13 Sep 2024 17:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726273748; x=1726878548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYlso/8R0sVW3aJqtei6eUBHEzKAZZG3JvkFLdErIqQ=;
        b=cwC9zj+tseMG2Cl9aDx4is4OJyYQHCYyFbgSdLMGd9G8g0CMNu7jS5xiQxlOsay2zW
         WEHtL/bwP8X5miLRF1U7KijzWDiJwgT0jy6Ml6g0mSHey7SEW/9NYlqeBD9wiyd53uKB
         SmAkEN/UgYY/qvI0DnFIdRQen+R+7wHi8Xyn42T/hOYpJZvQwrdljoCZLqhrtC8Zb6BT
         bXm0By5DtMNEkXCfm/r/BRb9oMGTy+M3rU/G4luZorH4w3Iee5XtJgYbiggcRn7rvEJ1
         V5Kce0wEBt2TvkMP3l/Ha9ohu9htYMDHgwEYr59hwUauRGn7fnl0n/X+c6D3TP/k2erD
         cKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726273748; x=1726878548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYlso/8R0sVW3aJqtei6eUBHEzKAZZG3JvkFLdErIqQ=;
        b=r+wKZxEGp2Ytk5QIIBvUfpL3JYGVxiVXX2+W0evNoQnBWYaavKOWlEupiyWH8lpUa6
         yQOKu4Pmna1888bouD/MDHUBG2DYd7oLo1/Pgoq0v0noP4evaTUYvdCEoLaXiOGCbPHq
         V8WoUxBGJpbIrSwflrezBokf21l5TukecbbqeoSH6ztc37Z0Bl5RFgsu+lA3LIz8wc0y
         Qi62p+nAT80xTu7RoWp18pFqq7N8PSjual+5yfYY9Y9QZWiCMHOh8SVaOQySZR+9sOPO
         7/+5LfZTEqrZRHmz1WiR7H7SdqnE/cNCruBdNhp3UUt3K6qT5ouVq1xgrLIUOWZiMLuF
         M4vg==
X-Forwarded-Encrypted: i=1; AJvYcCUTBSl20Eb2MUPdxBakp8JO+jEL/59xDLrLSsx0FLzGb/Dg9KnMp61/AvmxlBb2ehqLM9UmsMZYLEiXIuaq@vger.kernel.org, AJvYcCV6OowPe2JwfOxMkPI4fEW9ESAw0WR8UPjdT1REC9KxdLr0XkD0UrJpYFtQOJEN/+o/hTWwfDSc1WBy@vger.kernel.org, AJvYcCWheepl3yS29bDH/wxhwnPFeZ/7T+SMOgCLka0b+7nRRdb1IjCIpDugxlsoKCRylaQtFsMJierjxUhD@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZdXRU/q/OedOmSOAEydZL/2CU9nCzEGe+p6EyquZ1Vy9+xWt
	gh/E9wqZrvEO1s7yWPgU9R/YUTFh+kydpjkkCfsGoOQ8w0B8tngE
X-Google-Smtp-Source: AGHT+IGkgKNWnFxVJdIUWkHFGUHXu6nH9fwnAMdXGyAaop+4/YyIyrHR4F3vQ6awTO2vakO/WXQQBg==
X-Received: by 2002:a17:907:1c1a:b0:a86:97c0:9bb3 with SMTP id a640c23a62f3a-a902961741bmr835655166b.51.1726273747750;
        Fri, 13 Sep 2024 17:29:07 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:6bd1:9a24:6b02:4a8f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f43f4sm15157666b.80.2024.09.13.17.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 17:29:07 -0700 (PDT)
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
Subject: [PATCH v7 3/4] iio: pressure: bmp280: Add data ready trigger support
Date: Sat, 14 Sep 2024 02:28:59 +0200
Message-Id: <20240914002900.45158-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240914002900.45158-1-vassilisamir@gmail.com>
References: <20240914002900.45158-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 225 ++++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280.h      |  21 +++
 2 files changed, 244 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 64fb2d720bec..58ff77cbee64 100644
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
 
@@ -1278,6 +1280,63 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
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
 
@@ -1779,6 +1838,81 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	return ret;
 }
 
+static void bmp380_trigger_reenable(struct iio_trigger *trig)
+{
+	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
+	unsigned int tmp;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMP380_REG_INT_STATUS, &tmp);
+	if (ret)
+		dev_err(data->dev, "Failed to reset interrupt.\n");
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
+			"Could not %s interrupt.\n", str_enable_disable(state));
+	return ret;
+}
+
+static const struct iio_trigger_ops bmp380_trigger_ops = {
+	.set_trigger_state = &bmp380_data_rdy_trigger_set_state,
+	.reenable = &bmp380_trigger_reenable,
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
+				      bmp380_int_pin_config,
+				      bmp380_irq_thread_handler);
+}
+
 static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -1873,6 +2007,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
+	.trigger_probe = bmp380_trigger_probe,
 	.trigger_handler = bmp380_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
@@ -2420,6 +2555,88 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
+		dev_err(data->dev, "Failed to reset interrupt.\n");
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
+			"Could not %s interrupt.\n", str_enable_disable(state));
+	return ret;
+}
+
+static const struct iio_trigger_ops bmp580_trigger_ops = {
+	.set_trigger_state = &bmp580_data_rdy_trigger_set_state,
+	.reenable = &bmp580_trigger_reenable,
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
+				      bmp580_int_pin_config,
+				      bmp580_irq_thread_handler);
+}
+
 static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -2496,6 +2713,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
+	.trigger_probe = bmp580_trigger_probe,
 	.trigger_handler = bmp580_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
@@ -3043,8 +3261,11 @@ int bmp280_common_probe(struct device *dev,
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


