Return-Path: <linux-iio+bounces-7520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79092F0F1
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEBDB2349E
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E51A08B0;
	Thu, 11 Jul 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsgHAtYA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2931A0AF1;
	Thu, 11 Jul 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732591; cv=none; b=XcANpEA1yIbeBberW0tptrYVl5rXfqOpVIbqoaq2bVtBtan2nQ+sscjcXAtHF1oP7+u6fuysBkJ0pVMC/FX4MeQIfxOcZRV9jdhtw6gR3IA9ue1yezHtGtATVWDBecBjSVh6WH+nKSoP/13S2JbxBE61tCPLIz8mHeRCeutUVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732591; c=relaxed/simple;
	bh=mXlp8AXeYs1aDEecQQhE5xrrli/ravongaTp4YEvJjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZYbzggS0h7qmZxh54bdhO2Xl3AWOBdD4rx0QHpS8SN4kGK279Zq6615kvXOI4dJYtmOSiRvXw+6p1Pndoxq1N32Rhz/fl/u/IsolGH/clXbhy7RTdNq/U7cvffn+tjZbet0aNVvotMAneznngHb6plSh9v0YagTSsTj0Z36XvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsgHAtYA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso1742481a12.2;
        Thu, 11 Jul 2024 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732588; x=1721337388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERqlFA6Bq2+zv49jpttYmy1q1HQyui34ltOA6nDZRxM=;
        b=GsgHAtYAkGwRCEL2hwQ2ZHnY+1yRM6r/wa4cM6SetuRfx9gg/4wrCQIHS7eJqDEEVW
         9hXfc2nMQl9l/eej4tpSuFIE5BU740/FtdPQok4pxufZJZDxs0FF4iNph24R4a+xZXJk
         vjYMtZdybujD7G/qDu4EMfYIDh74iJT+hCSR2x93p/7NPdddpHZUxn3V6l+Bq8al9gtE
         VFPJ/fz2yZAiPo+Z+ot98R+yBJZ8cge52amJ+cYVwiRvPgCVEEX8br/t+DZTfNnvR8aN
         NNEtMt6CHpo654Tc7JdpEKKOdGFqmN/qpuC1KAezFDgXUHWhzWhpi4yMDlhnPfcJBITX
         qmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732588; x=1721337388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERqlFA6Bq2+zv49jpttYmy1q1HQyui34ltOA6nDZRxM=;
        b=GJ64IubndiEBxBJiWt+mhkIa2DA5Azikxxd9KKBqEw/E91ZzC/UFTwQLhVKCaHLl1D
         a20aOT/JJWiFo9TrCJrKKl3qI7ycSD2d5Yxf4RInwDEmKqWqvFvT3dXCkf9z/3trSRcR
         j4jkFiPI1/No/rIVa2gM7J2Muw/aRWg/hBmfocXjVoTFh+CxPF343zLMjQAdlnAqBJ+X
         KVb/892TBWR5s59XxzRz0WZ4eM8xhOoe41YTAIdQP+Fm9qDUP6qGVaqcIwA9LzSYV4zk
         88wOiXyQ1gFPuVcqJV3T45C3KmpYbXlw8Q5t6f8x6llmP0qsWIre4cPOH0wSXYwGTL5t
         fu4g==
X-Forwarded-Encrypted: i=1; AJvYcCWcG2RYI1uPnbdPX8jNvq0fuzlnxlBMpPHho5AHskBcFYrXgZwkS/uIxdo4jqwg6J1R+rMVnYcH0sO5ddJ65G0rhC+bpPUjd6AGC1qd6l1NxHtOVorQJxgjUAbf4aIimfUJm9ixZQEQzQX/N5YvJIaAWZUViv10jN5QzwMWVI3IXH0UPQ==
X-Gm-Message-State: AOJu0YzyaWKHUT5+tJ8R2laK+yqebSEm5uoDIk911FFbq8725YIQNBFB
	9X8+mWaXkPEsJk7+DIu1RoXjbkVfGUMVCXzswX0YDx5JD0WKNQo1
X-Google-Smtp-Source: AGHT+IGm7EgVWvkJNX/R8I+9PeJdcZv20AS+90ljfrjvX7Rk42cZ++VCnMjDtswmCoZdhZb1/VaYDA==
X-Received: by 2002:a50:ee93:0:b0:57c:fda3:b669 with SMTP id 4fb4d7f45d1cf-594bb180488mr5340564a12.17.1720732587637;
        Thu, 11 Jul 2024 14:16:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:27 -0700 (PDT)
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
Subject: [PATCH v1 09/10] iio: pressure: bmp280: Add data ready trigger support
Date: Thu, 11 Jul 2024 23:15:57 +0200
Message-Id: <20240711211558.106327-10-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c   | 271 ++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280-regmap.c |   2 +-
 drivers/iio/pressure/bmp280.h        |  23 ++-
 3 files changed, 290 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fc8d42880eb8..ee9b9676ad10 100644
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
 
@@ -1770,6 +1772,129 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
+	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CTRL,
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
+	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CTRL,
+				 BMP380_INT_CTRL_SETTINGS_MASK, int_cfg);
+	if (ret) {
+		dev_err(data->dev, "Could not set interrupt settings\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bmp380_trigger_probe(struct iio_dev *indio_dev)
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
+	irq = fwnode_irq_get_byname(fwnode, "DRDY");
+	if (!irq) {
+		dev_err(data->dev, "No DRDY interrupt found\n");
+		return -ENODEV;
+	}
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
+		dev_err(data->dev, "Invalid interrupt type specified\n");
+		return -EINVAL;
+	}
+
+	data->trig_open_drain = fwnode_property_read_bool(fwnode,
+							  "int-open-drain");
+
+	ret = bmp380_int_config(data);
+	if (ret)
+		return ret;
+
+	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
+					    indio_dev->name,
+					    iio_device_id(indio_dev));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &bmp380_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, data);
+
+	ret = devm_request_irq(data->dev, irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       IRQF_ONESHOT, indio_dev->name, data->trig);
+	if (ret) {
+		dev_err(data->dev, "request irq failed\n");
+		return ret;
+	}
+
+	ret = devm_iio_trigger_register(data->dev, data->trig);
+	if (ret) {
+		dev_err(data->dev, "iio trigger register failed\n");
+		return ret;
+	}
+
+	indio_dev->trig = iio_trigger_get(data->trig);
+
+	return 0;
+}
+
+
 static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -1863,6 +1988,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
+	.trigger_probe = bmp380_trigger_probe,
 	.trigger_handler = bmp380_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
@@ -2400,6 +2526,135 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
+static int bmp580_trigger_probe(struct iio_dev *indio_dev)
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
+	irq = fwnode_irq_get_byname(fwnode, "DRDY");
+	if (!irq) {
+		dev_err(data->dev, "No DRDY interrupt found\n");
+		return -ENODEV;
+	}
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
+		dev_err(data->dev, "Invalid interrupt type specified\n");
+		return -EINVAL;
+	}
+
+	data->trig_open_drain = fwnode_property_read_bool(fwnode,
+							  "int-open-drain");
+
+	ret = bmp580_int_config(data);
+	if (ret)
+		return ret;
+
+	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
+					    indio_dev->name,
+					    iio_device_id(indio_dev));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &bmp580_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, data);
+
+	ret = devm_request_irq(data->dev, irq,
+			       &iio_trigger_generic_data_rdy_poll,
+			       IRQF_ONESHOT, indio_dev->name, data->trig);
+	if (ret) {
+		dev_err(data->dev, "request irq failed\n");
+		return ret;
+	}
+
+	ret = devm_iio_trigger_register(data->dev, data->trig);
+	if (ret) {
+		dev_err(data->dev, "iio trigger register failed\n");
+		return ret;
+	}
+
+	indio_dev->trig = iio_trigger_get(data->trig);
+
+	return 0;
+}
+
 static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -2476,6 +2731,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
+	.trigger_probe = bmp580_trigger_probe,
 	.trigger_handler = bmp580_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
@@ -3020,10 +3276,17 @@ int bmp280_common_probe(struct device *dev,
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
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index d27d68edd906..cccdf8fc6c09 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -109,7 +109,7 @@ static bool bmp380_is_writeable_reg(struct device *dev, unsigned int reg)
 	case BMP380_REG_FIFO_WATERMARK_LSB:
 	case BMP380_REG_FIFO_WATERMARK_MSB:
 	case BMP380_REG_POWER_CONTROL:
-	case BMP380_REG_INT_CONTROL:
+	case BMP380_REG_INT_CTRL:
 	case BMP380_REG_IF_CONFIG:
 	case BMP380_REG_ODR:
 	case BMP380_REG_OSR:
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 93c006c33552..73d0d25ae0f4 100644
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
@@ -117,7 +126,7 @@
 #define BMP380_REG_OSR			0x1C
 #define BMP380_REG_POWER_CONTROL	0x1B
 #define BMP380_REG_IF_CONFIG		0x1A
-#define BMP380_REG_INT_CONTROL		0x19
+#define BMP380_REG_INT_CTRL		0x19
 #define BMP380_REG_INT_STATUS		0x11
 #define BMP380_REG_EVENT		0x10
 #define BMP380_REG_STATUS		0x03
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
@@ -399,6 +416,9 @@ struct bmp280_data {
 	struct regmap *regmap;
 	struct completion done;
 	bool use_eoc;
+	bool trig_open_drain;
+	bool trig_active_high;
+	struct iio_trigger *trig;
 	const struct bmp280_chip_info *chip_info;
 	union {
 		struct bmp180_calib bmp180;
@@ -497,6 +517,7 @@ struct bmp280_chip_info {
 	int (*set_mode)(struct bmp280_data *data, u8 mode);
 	int (*wait_conv)(struct bmp280_data *data);
 
+	int (*trigger_probe)(struct iio_dev *indio_dev);
 	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
 
-- 
2.25.1


