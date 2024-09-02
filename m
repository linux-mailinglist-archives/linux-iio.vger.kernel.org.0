Return-Path: <linux-iio+bounces-9026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A678C968DC8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7471C223AC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC21C62A9;
	Mon,  2 Sep 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzf8+/tU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36FA21C17D;
	Mon,  2 Sep 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302558; cv=none; b=cyFIVT8ogMWfUKN+s294ibnkeg6ekLiCDuQj/IA4yo6Y/GAgSiNpRbNrYU1BVUGdBfo7OQMx+bnaBO/RtFE3MoGxZYIrAL5lfSBDsJwNLT4GB2DjQ/uWwZby2n1ieEZuLrmxOVyugcV9nq+thDTdqBduW+ayXvMRdzev25XnrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302558; c=relaxed/simple;
	bh=JLGdr8dn/4cNOUgp1SlM//NNrNxkIn4AfxGXTNvhkXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3qGakyuhenFg4sip3m2kUekRBfRqG5tE9Xj3D4Ba0BErMtu9vpJ9HNYlnFkkIY7+86vieHJjNONnT+iEMCxzyinJqWagWkC72qlx+2kZaXJ2j9z5sqNgQ3EAap483B0t1H5CRcOlbiFKMS89TB1/9b8DyQQtdJpK0EaJqrcWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzf8+/tU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86984e035aso551004366b.2;
        Mon, 02 Sep 2024 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302553; x=1725907353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtUyd1x07/AOHbjnYKnt62eAHZJsJYoZUWuDynWvrW8=;
        b=fzf8+/tUxEbP2NoyYGQ5Rgz8KsjVFjLpdhzFZ1cFa7/iJS3wwOyvJI/99aJlHWgXIk
         gBqXWDNPHNMlHULgbq5r6LDFeTYiBryzFBXN9hFQvK5OnEzml3W/FazqoKIOBmxbdW/n
         HmaNHIh7Z3sPJoVi0vmTkL/I6p/XZXSPCdIBOkFdSwFYXt7+pZAqmN4OdMO0oT3Ioh5n
         H8iNXF7iO/aqegCbtA+c50dnk5LCS96FBAa4NZQlgXvcDP1aHj12/Armtl7a71eEvn5S
         gXiEMh5VcEUN4c0ihqMYXvwMUu0kRns6kTU/gGboG2dIpdNu8lfcks6ZO5WJHpkO0Lp+
         UFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302553; x=1725907353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtUyd1x07/AOHbjnYKnt62eAHZJsJYoZUWuDynWvrW8=;
        b=JGs11UWQ2slovrrSdCrpXaLrnnFb3yOqKJKaq++sEz8+KBw9MOVFJt0eO4Umj+ycFs
         VBL4BSxwbS1kBqjH6TS4ZrtQSmxygvWCLUFAXRgOzUw9EmLOp4PYfEkSZS4wINGG+Rfp
         M7XZdN//AIQ+Kbp/95/sj1FcYZ6Lp/NuXwb15fBX7rf+KYtXAE+Y6xiqJdBNMZIfm4XL
         wL5FodUMM2C7vSvs2URKggJPaC7UBjWo4deZGX1+2h/kvdGZ1uLiYv9SKNvXKirh6mZ0
         5lRukfSo+JKlMDUg4I7JLiIOAk0j/BHUW3gpK1Xel3YdRWnhPI5QKEdNiNtH88B2IcgX
         01aA==
X-Forwarded-Encrypted: i=1; AJvYcCUoCkbT/MsBY/C4E5p8fE6bNiJHcDPLg5/5TLM032G4Rnt9GdEVHGQRup2x63+xEcmLDpMa9tob0dwU@vger.kernel.org, AJvYcCVu4R0ow5+UcCZ5fo2CHli48bH9Xpyih7QscyPVXvzXDsEhaSiUiGvN8ynTOaKQfeTpxxH83CtY2as8Spg4@vger.kernel.org, AJvYcCW2kf+cUn6+IpWuN/mo29FZKxHr4Dz6OOQDVg6Fwm/dJXI5NipEgM56B7r0yy+tLvyGJ2SoMJpbAR6M@vger.kernel.org
X-Gm-Message-State: AOJu0YyPsWkIjOPYh2xAak6PCEJz9CGL9DYSJpqG58yLuPN99Xdo91uj
	O4Owb3xuZQitrlYL+OamljeLEetBgXe8CBv1DeTVqDM1BU7WuMBd
X-Google-Smtp-Source: AGHT+IEdgu3OGxy6vYTS1GEQpHhoym+apinNg4KLbciHtCNE3E/yZsIOthFLniGC5Wzb35JcsX3Cmw==
X-Received: by 2002:a17:907:1c9f:b0:a8a:18f9:269f with SMTP id a640c23a62f3a-a8a18f92a81mr97891266b.60.1725302552231;
        Mon, 02 Sep 2024 11:42:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec0asm590537966b.53.2024.09.02.11.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:42:31 -0700 (PDT)
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
Subject: [PATCH v5 6/7] iio: pressure: bmp280: Add data ready trigger support
Date: Mon,  2 Sep 2024 20:42:21 +0200
Message-Id: <20240902184222.24874-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902184222.24874-1-vassilisamir@gmail.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 226 ++++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280.h      |  21 +++
 2 files changed, 245 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index b8a55de78616..74233778df35 100644
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
 
@@ -1278,6 +1280,64 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
+				  const struct iio_trigger_ops *trigger_ops,
+				  int (*int_config)(struct bmp280_data *data),
+				  irq_handler_t irq_thread_handler)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+	struct device *dev = data->dev;
+	struct fwnode_handle *fwnode;
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
+		return dev_err_probe(dev, ret, "request irq failed.\n");
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
 
@@ -1781,6 +1841,81 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
+				      bmp380_int_config,
+				      bmp380_irq_thread_handler);
+}
+
 static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -1875,6 +2010,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
+	.trigger_probe = bmp380_trigger_probe,
 	.trigger_handler = bmp380_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
@@ -2417,6 +2553,88 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
+static int bmp580_int_config(struct bmp280_data *data)
+{
+	int pin_drive_cfg = FIELD_PREP(BMP580_INT_CONFIG_OPEN_DRAIN,
+				       data->trig_open_drain);
+	int pin_level_cfg = FIELD_PREP(BMP580_INT_CONFIG_LEVEL,
+				       data->trig_active_high);
+	int ret, int_cfg = pin_drive_cfg | pin_level_cfg;
+
+	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
+				 BMP580_INT_CONFIG_MASK, int_cfg);
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
+				      bmp580_int_config,
+				      bmp580_irq_thread_handler);
+}
+
 static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -2493,6 +2711,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
+	.trigger_probe = bmp580_trigger_probe,
 	.trigger_handler = bmp580_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
@@ -3040,8 +3259,11 @@ int bmp280_common_probe(struct device *dev,
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


