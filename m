Return-Path: <linux-iio+bounces-24478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3CBA5486
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 00:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1854B1C027D2
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844C30CD9B;
	Fri, 26 Sep 2025 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNfHssd7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4E30CB55
	for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924151; cv=none; b=OOvX6neMAtNvFagwgDV99ZshIVh6Um4hULh0XKOqcynOScnYKtxRw2dsA9FYDAhmamSYa9hYuF9OeVilzxuSDCpqeML/FBZOur1Kbbqf+Gf57ulrJLGFJjhcYrYhEHVHLbZK6eB+hoxX0UZZrZ14D7JL2xnsYIywJNJPvIcOpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924151; c=relaxed/simple;
	bh=LnWL/eUtq4rVJMr0VvgPgsd6M0BfJcGXTYJCVy3ATEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcVxeBLnyOluAv4b3V8yVEHlMVd/uLBHqeEC8CwK7qu9bgfdUpxtX7Nmv47r7v/pqeVxaesoVToG+cnMYof45A8wjuSKpXe0fZQE8KG8IriXA0XduqutIv4x6XDr4AXdwAkHbJTyGH1ncdAelxgJNGsLT6I7BI5nq1PhYdOqxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNfHssd7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b303f7469so18532605e9.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758924148; x=1759528948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYzdGix8BnDpLsQQ8Se/5oFsA9jb9ULckmXaMvv98ZU=;
        b=lNfHssd7rOnumZ7PxZMA6dzX2h7stcMItRgSpnOw7TbV7YI+yL/CMTfzsDU6dUfcFL
         vV2H/ZOQs3+xtPSmm38KzVjedw0DZUsg2iFbmybgERSdFujQHqetG84UhtuCTtpXy+94
         My4hMA6d3CjWimqXFDgQVioWOXOKuk6cyEeJdTsp1VXln6zqkB4QgTU+g0XaxeczDVQK
         SRwkc8KPICOjLTfLkmg1XicvaI7oP4ddMGYVhaSzrn4UN8yiHfx9BrpwukKj3xJ6HWQz
         ODYkWV5NiXJyHeC6jyRlVdEmcjj2GtuvMfEb9l1ExpC54ev9MESuh/eFd40/zcJMoZ7E
         ZPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758924148; x=1759528948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYzdGix8BnDpLsQQ8Se/5oFsA9jb9ULckmXaMvv98ZU=;
        b=YYJNt6G9U7UCHtSbZPPKqook54lcxNlc0i+qIQ9I86HtTkAxmHjoXyaXHRnIBVdnO6
         fpQf6L4G4A7kOSMf2qHBFowkaVJcuHZC4AMbdCC2niOxK3JxXF0aHIxD1E53IfzdY5CI
         MD96UA4JwfSdhHaaUhwMpYVhEwhZ0gzFRFmWCE5EaGY7lHzfCMWTq17+HyQIX1gN9qw9
         /cx+GKrnRE+vYvmo32mTP2oVUcf+5jrbrx7Fol3zL/AtbffchC7pSOg0+h9bkdjNk99O
         cChnPhAwPqBs39JWRbe20mpa2pN2YOi8tntc3uY5fOavKwoWlpFmrfBafIKMLdSl8iVN
         4vEg==
X-Forwarded-Encrypted: i=1; AJvYcCWOlOyUswzD+aOyOO7gTqHfpH0yRBO3PUeu86VDGqKuHqM2w4ZWZwkLuQxSsDGlTYqihxdHtWq40aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGfFem/KQZ8rHZZqm4FQ6Em02c71OlPyk/LR9sg4XgyMNpzNM
	JOniUdxB4t+lAQQHikEQmn3Szf7W1nWAqRevBsBBzmhc6G+7GRktuvdc
X-Gm-Gg: ASbGncvZP+ueu9bo89H8eJCiMu9QlsrIifFc7ZoER2k3Lfzsyx5qRDbVKiebkwrY1BP
	LbauHbQkHBGjhNPWZKvFtAnCQqY+ZOjJoZXWWonbtZC+IQlpaIs4QFGIw1t40a6XtAiIFiMT8/M
	OUKmrmUfch0dD/hwsceo3RH8uY2uFrVJNzrqZzCrmY0GQPXgaXCnvM2yVL56+rO4crT8J0gaoWC
	Bj0nS/nuOKrrbSuAtwOC3te9ZpmIqSTN1Vm3+3aoxPD9Vys9m/hKWP3sbd2RpXsPcrTjX1DiJEH
	b70SbW9nAtcvCQ6YXzN5917eIx5wm4ALYc/ZCOgxeOHkHxHIVBofykzhnIa2MwykBWZdmxSxQoe
	QX/WTz3J+oU6cV9sSKB6RJewhyHHbuCXe90LBPZoH
X-Google-Smtp-Source: AGHT+IGoY788MocxM/Yeo9Z/ZnhTn627HRM+iBXQ+j6kx/4C6ogw48xYh5ggzjXLHgByZEfouFzrWg==
X-Received: by 2002:a05:6000:220b:b0:3d7:2284:b20 with SMTP id ffacd0b85a97d-40e458a93b6mr7635010f8f.3.1758924147872;
        Fri, 26 Sep 2025 15:02:27 -0700 (PDT)
Received: from localhost.localdomain ([37.163.230.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm8410236f8f.55.2025.09.26.15.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:02:26 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 3/4] iio: mpl3115: add support for DRDY interrupt
Date: Sat, 27 Sep 2025 00:01:49 +0200
Message-Id: <20250926220150.22560-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250926220150.22560-1-apokusinski01@gmail.com>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPL3115 sensor features a "data ready" interrupt which indicates the
presence of new measurements.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 197 ++++++++++++++++++++++++++++++---
 1 file changed, 184 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 80af672f65c6..13c8b338a15e 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -7,49 +7,77 @@
  * (7-bit I2C slave address 0x60)
  *
  * TODO: FIFO buffer, altimeter mode, oversampling, continuous mode,
- * interrupts, user offset correction, raw mode
+ * user offset correction, raw mode
  */
 
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger.h>
 
 #define MPL3115_STATUS 0x00
 #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
 #define MPL3115_OUT_TEMP 0x04 /* MSB first, 12 bit */
 #define MPL3115_WHO_AM_I 0x0c
+#define MPL3115_INT_SOURCE 0x12
+#define MPL3115_PT_DATA_CFG 0x13
 #define MPL3115_CTRL_REG1 0x26
+#define MPL3115_CTRL_REG3 0x28
+#define MPL3115_CTRL_REG4 0x29
+#define MPL3115_CTRL_REG5 0x2a
 
 #define MPL3115_DEVICE_ID 0xc4
 
 #define MPL3115_STATUS_PRESS_RDY BIT(2)
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
-#define MPL3115_CTRL_RESET BIT(2) /* software reset */
-#define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
-#define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
-#define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
+#define MPL3115_INT_SRC_DRDY BIT(7)
+
+#define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
+
+#define MPL3115_CTRL1_RESET BIT(2) /* software reset */
+#define MPL3115_CTRL1_OST BIT(1) /* initiate measurement */
+#define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
+#define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
+
+#define MPL3115_CTRL3_IPOL1 BIT(5)
+#define MPL3115_CTRL3_IPOL2 BIT(1)
+
+#define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
+
+#define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
+
+#define MPL3115_INT2 BIT(2) /* flag that indicates INT2 in use */
 
 struct mpl3115_data {
 	struct i2c_client *client;
+	struct iio_trigger *drdy_trig;
 	struct mutex lock;
 	u8 ctrl_reg1;
 };
 
+enum mpl3115_irq_type {
+	INT2_ACTIVE_LOW  = MPL3115_INT2 | IRQF_TRIGGER_FALLING,
+	INT2_ACTIVE_HIGH = MPL3115_INT2 | IRQF_TRIGGER_RISING,
+	INT1_ACTIVE_LOW  = (!MPL3115_INT2) | IRQF_TRIGGER_FALLING,
+	INT1_ACTIVE_HIGH = (!MPL3115_INT2) | IRQF_TRIGGER_RISING,
+};
+
 static int mpl3115_request(struct mpl3115_data *data)
 {
 	int ret, tries = 15;
 
 	/* trigger measurement */
 	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-		data->ctrl_reg1 | MPL3115_CTRL_OST);
+		data->ctrl_reg1 | MPL3115_CTRL1_OST);
 	if (ret < 0)
 		return ret;
 
@@ -58,7 +86,7 @@ static int mpl3115_request(struct mpl3115_data *data)
 		if (ret < 0)
 			return ret;
 		/* wait for data ready, i.e. OST cleared */
-		if (!(ret & MPL3115_CTRL_OST))
+		if (!(ret & MPL3115_CTRL1_OST))
 			break;
 		msleep(20);
 	}
@@ -166,9 +194,11 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	int ret, pos = 0;
 
 	scoped_guard(mutex, &data->lock) {
-		ret = mpl3115_request(data);
-		if (ret < 0)
-			goto done;
+		if (!(data->ctrl_reg1 & MPL3115_CTRL1_ACTIVE)) {
+			ret = mpl3115_request(data);
+			if (ret < 0)
+				goto done;
+		}
 
 		if (test_bit(0, indio_dev->active_scan_mask)) {
 			ret = i2c_smbus_read_i2c_block_data(data->client,
@@ -224,10 +254,147 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (!(ret & MPL3115_INT_SRC_DRDY))
+		return IRQ_NONE;
+
+	iio_trigger_poll_nested(data->drdy_trig);
+
+	return IRQ_HANDLED;
+}
+
+static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 ctrl_reg1 = data->ctrl_reg1;
+
+	if (state)
+		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
+	else
+		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+
+	guard(mutex)(&data->lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+					ctrl_reg1);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
+					state ? MPL3115_CTRL4_INT_EN_DRDY : 0);
+	if (ret < 0)
+		goto reg1_cleanup;
+
+	data->ctrl_reg1 = ctrl_reg1;
+
+	return 0;
+
+reg1_cleanup:
+	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+				  data->ctrl_reg1);
+	return ret;
+}
+
+static const struct iio_trigger_ops mpl3115_trigger_ops = {
+	.set_trigger_state = mpl3115_set_trigger_state,
+};
+
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
 };
 
+static int mpl3115_trigger_probe(struct mpl3115_data *data,
+				 struct iio_dev *indio_dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&data->client->dev);
+	int ret, irq, irq_type, irq_cfg_flags = 0;
+
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq < 0) {
+		irq = fwnode_irq_get_byname(fwnode, "INT2");
+		if (irq < 0)
+			return 0;
+
+		irq_cfg_flags |= MPL3115_INT2;
+	}
+
+	irq_type = irq_get_trigger_type(irq);
+	if (irq_type != IRQF_TRIGGER_RISING && irq_type != IRQF_TRIGGER_FALLING)
+		return -EINVAL;
+
+	irq_cfg_flags |= irq_type;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_CFG,
+					MPL3115_PT_DATA_EVENT_ALL);
+	if (ret < 0)
+		return ret;
+
+	switch (irq_cfg_flags) {
+	case INT2_ACTIVE_HIGH:
+		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
+						MPL3115_CTRL3_IPOL2);
+		if (ret)
+			return ret;
+
+		break;
+	case INT2_ACTIVE_LOW:
+		break;
+	case INT1_ACTIVE_HIGH:
+		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG5,
+						MPL3115_CTRL5_INT_CFG_DRDY);
+		if (ret)
+			return ret;
+
+		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
+						MPL3115_CTRL3_IPOL1);
+		if (ret)
+			return ret;
+
+		break;
+	case INT1_ACTIVE_LOW:
+		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG5,
+						MPL3115_CTRL5_INT_CFG_DRDY);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	data->drdy_trig = devm_iio_trigger_alloc(&data->client->dev,
+						 "%s-dev%d",
+						 indio_dev->name,
+						 iio_device_id(indio_dev));
+	if (!data->drdy_trig)
+		return -ENOMEM;
+
+	data->drdy_trig->ops = &mpl3115_trigger_ops;
+	iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+	ret = devm_iio_trigger_register(&data->client->dev, data->drdy_trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(data->drdy_trig);
+
+	return devm_request_threaded_irq(&data->client->dev, irq,
+					 NULL,
+					 mpl3115_interrupt_handler,
+					 IRQF_ONESHOT,
+					 "mpl3115_irq",
+					 indio_dev);
+}
+
 static int mpl3115_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -258,15 +425,19 @@ static int mpl3115_probe(struct i2c_client *client)
 
 	/* software reset, I2C transfer is aborted (fails) */
 	i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
-		MPL3115_CTRL_RESET);
+		MPL3115_CTRL1_RESET);
 	msleep(50);
 
-	data->ctrl_reg1 = MPL3115_CTRL_OS_258MS;
+	data->ctrl_reg1 = MPL3115_CTRL1_OS_258MS;
 	ret = i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
 		data->ctrl_reg1);
 	if (ret < 0)
 		return ret;
 
+	ret = mpl3115_trigger_probe(data, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		mpl3115_trigger_handler, NULL);
 	if (ret < 0)
@@ -285,7 +456,7 @@ static int mpl3115_probe(struct i2c_client *client)
 static int mpl3115_standby(struct mpl3115_data *data)
 {
 	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-		data->ctrl_reg1 & ~MPL3115_CTRL_ACTIVE);
+		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
 }
 
 static void mpl3115_remove(struct i2c_client *client)
-- 
2.25.1


