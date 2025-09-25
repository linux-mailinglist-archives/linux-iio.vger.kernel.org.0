Return-Path: <linux-iio+bounces-24443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B010BA169C
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C321C028CD
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99518320CAB;
	Thu, 25 Sep 2025 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miyjEgk5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913A321F3A
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833171; cv=none; b=C+GXV3FNtFfGy4SIivWrkPiueyyx2EvtkOjRSnPPUUJOYLbDRqUWx4em6U5BqUTar11jbavT+uZmPEVS/jdgLLIuXQqz+FG6q4ZRf2RlzX8n2j0kAPcaXro7HQrR10rADK8HmWhJZ/lw+f/mlrvwMpGS6gBVtoJXT8xkAp7mVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833171; c=relaxed/simple;
	bh=LnWL/eUtq4rVJMr0VvgPgsd6M0BfJcGXTYJCVy3ATEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqVyJQV17XS4ttLkBwPeSo6EAD27s3vUUlKPl7MNJa4rMZq1N2We2rjrKRBXLCkeSKfeu+Up3VYL3SreaWC2aRo3qsW0bwoTwDc8h7rPWil8vAJjwNezitipnGocZh8a0UrVbJ58LJ0fVD5GSlmmy1phXdd17S80dg0QdUieCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miyjEgk5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso946905f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833168; x=1759437968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYzdGix8BnDpLsQQ8Se/5oFsA9jb9ULckmXaMvv98ZU=;
        b=miyjEgk5qc3q13fRPxLL3u7sSt8qvsp4Z8Wls3H+2J8BF3pw3cFOEPRYz3RW10pLq1
         IOO6WCwEQ3nOXJfZqa9a4yFleZ5Sj5RBxyrdu4132uQYu1BhSp+vM9zOOcpFQewcVXDk
         APIOUMmvgJD3h8HyJ2kL1SwIZ9wga0Z2RpRBga5qtedZgolKzgn+Nc/xsyCm8BErGk6T
         6PCG4bymSX7rO7RpnGzjuaFxIcHrqdvisiUT6bWZYzl+KTC09RKEgKdfET6iw8fY36ZA
         744vSl0J8DlW8dmE/QACalox8OLw4Njy3t2zaz6TFw2VQgKakqYX+G7nNPZM3nK4U6t6
         RFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833168; x=1759437968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYzdGix8BnDpLsQQ8Se/5oFsA9jb9ULckmXaMvv98ZU=;
        b=SfWAlErmngOHNfIEcZ54E+LFDDxmkHpPLPT4beJGZkzhRwJZ6tRyCp+qg5j3XAicDI
         Gk9Lbt1gNEIvqNr4wprf9YUCnaLofeEgq9QpXgYgurOquPT7ifQI6Kam2dIb8tCQ7fMA
         6v+mhf6WEQnK+pnw/BQU183gPU3tUijKwkn8bonyZ4+zdHFu58BmciyGrEA+NDzMdjld
         ruIitvgnoO9bNvItePFAUHDkZwemMn7hYRNlKL08cjPHHdJSmc3kNnQyK9y40hJLPHLG
         9QM6XEW0UEgwJC0euWbGet8/2uUXFQkMrDvB0hOrB6Ko0XUg1gfRwsVG7RNMXjivJ79T
         DloA==
X-Forwarded-Encrypted: i=1; AJvYcCX2kbYpN1t8m9FIVfXbWXGKIjKhI5SpkXpw2zV/GNzeC1Ecxsuqru3qL7mUttvwwlDlDBqz7HG24jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYQa4Dv9qWCP1h7RiRqNn+J+4zhTyDTtDmWi6yFBZvRENPJl1
	6c23UWiuSILyny8YgqtTl8rZq/ALlisOzbuVj9bVQyE02jibkWAgbt4J
X-Gm-Gg: ASbGncvVpFQSnp6UfdWZSXwIUph8ITYV42SXjNniIFgU2uD5HU3LKFEDY9037szM4FE
	ks0hdUiEjhApr20qkIygH16QwOCgdudnW9wM/3Dnc49p8ptBWVnWAUF1CgSQQjLWBHsMyIeTrsn
	BbnJnUMWpBeHMPkVfN2xzzLjW+1DlD6uvWDZNKd2lar5k/6lPicq+VvM8kKSIZ4Q7fqBo/Jp0YR
	URzHEQeivX/SL8mJp2bfZ0/twyIf6LhVzfjZkNX3sj2uekH+SpkjYMWVMdTSa981jWL24EuPrKX
	AOKVnB0TneoOiepQ1+Z71XVpxONENIsjK0Za/pnQVc6Ehm2ilCQuiZCbypdVTRRVrlxF73C4voY
	ykBzYodWP1SYfhfqvP+PsV4D7VFytJLMxOYDwpQE=
X-Google-Smtp-Source: AGHT+IERzY3GDwl0z9WpDJV+rnWF1AhP367sDlX6Dqwa/uXl0e9cwsI1wV5HbBFQ9X09JFqhMxXv1w==
X-Received: by 2002:a5d:5f52:0:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-40e46237c2bmr4659410f8f.11.1758833167721;
        Thu, 25 Sep 2025 13:46:07 -0700 (PDT)
Received: from localhost.localdomain ([78.209.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm91201395e9.1.2025.09.25.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:46:07 -0700 (PDT)
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
Subject: [PATCH v2 3/4] iio: mpl3115: add support for DRDY interrupt
Date: Thu, 25 Sep 2025 22:45:37 +0200
Message-Id: <20250925204538.63723-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925204538.63723-1-apokusinski01@gmail.com>
References: <20250925204538.63723-1-apokusinski01@gmail.com>
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


