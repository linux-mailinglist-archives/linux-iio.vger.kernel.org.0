Return-Path: <linux-iio+bounces-7900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB593CB1E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53A91C21774
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA1152166;
	Thu, 25 Jul 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt2AuKlT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEB14EC77;
	Thu, 25 Jul 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949057; cv=none; b=nSpXZpT5q6dwxeGL0IlLrl99lXT8NcnAtNkus2w2gVjZUQSzUsGpL9bNg0HNCy1jwedRvcQZ+9Qnf2Zv8SixR3ybJIAopIczteYos2fbNzGoz1A6ra/gLLQsmeVZdOEFdW2i/0C083CVHCIeko3QN1jZO48zjJ1T3rrhCygnoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949057; c=relaxed/simple;
	bh=MMQV8GSkCu3y39mDMyqIRWWQc62N16URz8VHe31HhQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f619qDUMuffXZxZML611I2gjIWSTCJEF4J5+i6r/NDgql9eraK3XETSkG76hURvP7uNroxrdXwlH12jdEkk8n6KpbllhXqNFvhLV2hC4N+m+zd1EOFaKgCVi9TgVgCcwafP3sq6WpXFSZFb2NL+erCoP9QnBdApZUyZCYrcpR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt2AuKlT; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efd8807aaso1046258e87.3;
        Thu, 25 Jul 2024 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949054; x=1722553854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZL6CFksjO07swkGQgmm7spK2mqvVGacGmHjhZjHKvo=;
        b=Jt2AuKlTFcSen7+MRNOfsMONWgJRwD7BJtOyZZlKobWt3gQMDpgeFMEaoJ5iiTi1ai
         5wItfyZ9eq8hXpaIEd90MUrU2m8wua9ttbsAnB/ufpwTHB7QtF4ds2d1A8BWVMiFkk8j
         ZWZXzumbdRuAg0FOUDfD+xWpcvQ88age7EgEUspW0Td/Mje2JBze4kPERIOO8bd7GP4o
         FVPTCjUxKKFFUce/5pYvkhW3BQJ/iTjnS79b2FSnCzgniCqYnuq9mEmh2oAxOJ7u6l35
         LE9Cao8LL+aGxxMF697//lSMGOGr2FKXL3VeUFYf2GEkNyLtVaTWnnX7GrYGMT1hYuB0
         tZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949054; x=1722553854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZL6CFksjO07swkGQgmm7spK2mqvVGacGmHjhZjHKvo=;
        b=lzvj5C7GLrs9rrB0debz8LeuWafV6KYHSCjdqFtqSVz+FhO1jolJ32Q58Lvnrsw6W0
         nbOOFYE2FXo1KLrX3sreGPrJXS0ng0qHXE7a0BVVYLwujnU2jYSG5ss2nGQTAVorGyt7
         VRYx4KM2QTix0tiQmNSxoeIyB7lCOJRP7swlOhdNvfhUXSBOj0CnwtW8h4nzgd/9vB1o
         Dc3Wr46RoIsTJc7CHTpaZz5G82M+ecvSih9DbXER8wchYa9s/Ae1DyuucJsw9IXbo3a4
         yZpufwTl1z/WkNfF2SSRgYxbQgWE3bSk887QiO0u6xypgN8ZEAGTVb1O/ZS6MqZAo336
         raqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtW3WR/6dzh3WyRBmlYGZtQu9ChOk0LeZn3ugvK11oJfoqbLd4I0Xpq7dKbUJaIndVng/msizlIO7ogwUBNhbw5ZIjle4XhhD1mVdFBBMrGvSfH/OpD4O/2pp3ojqJfZ+wkJzw3b3GorP6g92WUAtyRysyrv42O7HNH0i6v6zRDefiYw==
X-Gm-Message-State: AOJu0Ywxf1NWtfqFp1owN2/4P7WJM3nmBg97MlttfpaZD//G2cAfyyvH
	UOWwy8DXZWg/6Si7Yac0dIz+Ma3BlZXbZdB0e5mZu0ZBWFdXbONT
X-Google-Smtp-Source: AGHT+IHJ1Gldkr21BklkLNa8tUn78tUdFexIrYrwQg8Oz2ybidiV5jFF/n93CYZLJUNrsaGZCkFVGg==
X-Received: by 2002:a05:6512:e95:b0:52f:cce4:51f3 with SMTP id 2adb3069b0e04-52fd3f6b991mr3021337e87.44.1721949053785;
        Thu, 25 Jul 2024 16:10:53 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236e3sm115429266b.25.2024.07.25.16.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:10:53 -0700 (PDT)
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
Subject: [PATCH v2 6/7] iio: pressure: bmp280: Add data ready trigger support
Date: Fri, 26 Jul 2024 01:10:38 +0200
Message-Id: <20240725231039.614536-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725231039.614536-1-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c   | 309 ++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280-regmap.c |   2 +-
 drivers/iio/pressure/bmp280.h        |  23 +-
 3 files changed, 328 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4a8d2ed4a9c4..4238f37b7805 100644
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
 
@@ -1761,6 +1763,148 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
+	if (!irq) {
+		dev_err(data->dev, "No interrupt found\n");
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
+	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+					bmp380_irq_thread_handler, IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
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
@@ -1854,6 +1998,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
+	.trigger_probe = bmp380_trigger_probe,
 	.trigger_handler = bmp380_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
@@ -2390,6 +2535,154 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
+	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &int_ctrl);
+	if (ret)
+		return IRQ_NONE;
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
+	if (!irq) {
+		dev_err(data->dev, "No interrupt found\n");
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
+	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+					bmp580_irq_thread_handler, IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
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
@@ -2466,6 +2759,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
+	.trigger_probe = bmp580_trigger_probe,
 	.trigger_handler = bmp580_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
@@ -3013,10 +3307,17 @@ int bmp280_common_probe(struct device *dev,
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
index f5d192509d61..754eda367941 100644
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
@@ -504,6 +524,7 @@ struct bmp280_chip_info {
 	int (*set_mode)(struct bmp280_data *data, enum bmp280_op_mode mode);
 	int (*wait_conv)(struct bmp280_data *data);
 
+	int (*trigger_probe)(struct iio_dev *indio_dev);
 	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
 
-- 
2.25.1


