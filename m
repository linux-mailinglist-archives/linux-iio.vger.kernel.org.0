Return-Path: <linux-iio+bounces-8998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A795A96876F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 14:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AB91C221E3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA419E994;
	Mon,  2 Sep 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGxVJWeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03F19E982;
	Mon,  2 Sep 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280009; cv=none; b=gfLfH0zi2XvlRwpN7p8JlQiHc97QRvvgpDZ8obtFyty5OBjH0kt4Ge3mHxYyB7f/gJqZt+qBq4jnlCIzouLOkvsBdXuy2LIV0nAORR0rK9kRYqQNKUZXTM15WLFieel3EGjojOOO4BD75rzRxkbqVhQ6a/kh8sEXVb9OlOBvbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280009; c=relaxed/simple;
	bh=u23lLlR2LTFpNoo060oBArKO34KHX3ibQDt3BqMpP8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uah+fupxfdguWbw3bDhnGeYQTbXOrEzcGlNksNj4zahVy0vssmnO65lvYJLcJpsTzyW5NPAWpcy3/XCutBF636jUAl8n1uH9Pk2jEWLg7ZxK6Tw6qFRS6O7EqagFRpPvhi0Tw/knirceH7YDg3w0lyCJC+Q89rgro6P+RVcj2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGxVJWeV; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70f6a1afc90so1489662a34.3;
        Mon, 02 Sep 2024 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725280006; x=1725884806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnPtFcGe9Ohue1ceEAKQ0hqJ4AZSlXIRdYW8CNiWYBQ=;
        b=UGxVJWeVMUMVK4vCY18NQMH5UKNGbmqYNh/oncX83RgJaxHJDG+YEtBDNkNTnkeQ+r
         vFM52VX76HmdfS3nHuhgFasmHxio7K2b44bJlctsfbHUNTF3abM63BvGbvrel2ypck8K
         NvQKQrf5Rlap8quoUZ0V4dFhlBV+RFs122pssBQnGnjgGeWVL4oaGoCMquLIlPVFSEUQ
         pAlfVFHGm/TV9B53KxjtUZUVjapV/TXgJKLxrWnO1r1/y1ibNpWUE8VYY13mR3OTjc4z
         n0kMxU3dnF2m7S9/YRyhDBpwqmciq6aCoYLPhGZMBWqLuDQKUZTNQbmSacy3XesLJMHK
         hIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280006; x=1725884806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnPtFcGe9Ohue1ceEAKQ0hqJ4AZSlXIRdYW8CNiWYBQ=;
        b=NBoNGne1p4ssvmscMFcLsbyC0Id5SLsFa0JzPF40cWhkTSYW21YV6R8F4cMSKN8lvC
         SfBMG6ZZAUJJC6PmZSwVUGs6xiYM1wHEwxAVHcaRDFAPTzh/TG4OTEhPdkRECDpLgkSw
         Tr8i2IQGmlOFPHFKPSNpQA4/SVKXgVA/hu9O0iZIwMBFXvSwUtGeyKSz9L+Ua2GpK6yH
         xpO5zQpEphUXt05cdvQ1sLBJweT6G+3nOTkxLyrw1SosxPdnRJ2oa7a4VC9zWDwJ3dRW
         5uej3rtQ9rBkbw1FeY3tiasrNMKY6thsmEVLeluHCJxysTB68mWRHAHQldg//AVSaqTa
         3/ag==
X-Forwarded-Encrypted: i=1; AJvYcCVLv4K7pphNfPRRhlfdIsZEeQm8fU5e+bqNqPLSwxT61xKKbvsl6Ov1hq72IkdOoXa5JjSGoX7ZdEepnj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOt4mLJ/4RNW+dfw6otYZDzr/ovi+4FV1MHhmBk09dRA8HzFIy
	f0iDekcvooSnxUGFXzCaKtdmQI9vIdJYEiS89Aga/sLFjZPD30Go0dICxZdR
X-Google-Smtp-Source: AGHT+IGJl4DOZ96kdl7BjqFcimeytenEOZdQB07gWC5u/GOsyv0nJSQybXVm1Q+5nD5MjPlilz05JQ==
X-Received: by 2002:a05:6358:e48e:b0:1aa:bc07:a3da with SMTP id e5c5f4694b2df-1b7f19e1e86mr932814355d.14.1725280005884;
        Mon, 02 Sep 2024 05:26:45 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e575b7dfsm6789541b3a.190.2024.09.02.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:26:45 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 2/2] iio: proximity: vl53l0x-i2c: Added continuous mode support
Date: Mon,  2 Sep 2024 17:55:56 +0530
Message-ID: <20240902122557.129013-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902122557.129013-1-abhashkumarjha123@gmail.com>
References: <20240902122557.129013-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The continuous mode of the sensor is enabled in the buffer_postenable.
Replaced the original irq handler with a threaded irq handler to perform
i2c reads during continuous mode.
The continuous mode is disabled by disabling the buffer.
Added a trigger for this device to be used for continuous mode.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 162 +++++++++++++++++++++++-----
 1 file changed, 137 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 31d6aeb95..26183c352 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -22,6 +22,10 @@
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define VL_REG_SYSRANGE_START				0x00
 
@@ -49,14 +53,75 @@ struct vl53l0x_data {
 	struct completion completion;
 	struct regulator *vdd_supply;
 	struct gpio_desc *reset_gpio;
+	struct iio_trigger *trig;
+
+	struct {
+		u16 chan;
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
-static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
+static int vl53l0x_clear_irq(struct vl53l0x_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					VL_REG_SYSTEM_INTERRUPT_CLEAR, 1);
+	if (ret < 0)
+		dev_err(dev, "failed to clear error irq: %d\n", ret);
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					VL_REG_SYSTEM_INTERRUPT_CLEAR, 0);
+	if (ret < 0)
+		dev_err(dev, "failed to clear range irq: %d\n", ret);
+
+	ret = i2c_smbus_read_byte_data(data->client, VL_REG_RESULT_INT_STATUS);
+	if (ret < 0 || ret & 0x07) {
+		dev_err(dev, "failed to clear irq: %d\n", ret);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
+{
+	struct iio_poll_func *pf = priv;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+	u8 buffer[12];
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(data->client,
+					VL_REG_RESULT_RANGE_STATUS,
+					sizeof(buffer), buffer);
+	if (ret < 0)
+		return ret;
+	else if (ret != 12)
+		return -EREMOTEIO;
+
+	data->scan.chan = get_unaligned_be16(&buffer[10]);
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+	ret = vl53l0x_clear_irq(data);
+	if (ret < 0)
+		return ret;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t vl53l0x_threaded_irq(int irq, void *priv)
 {
 	struct iio_dev *indio_dev = priv;
 	struct vl53l0x_data *data = iio_priv(indio_dev);
 
-	complete(&data->completion);
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll_nested(indio_dev->trig);
+	else
+		complete(&data->completion);
 
 	return IRQ_HANDLED;
 }
@@ -71,8 +136,9 @@ static int vl53l0x_configure_irq(struct i2c_client *client,
 	if (!irq_flags)
 		irq_flags = IRQF_TRIGGER_FALLING;
 
-	ret = devm_request_irq(&client->dev, client->irq, vl53l0x_handle_irq,
-			irq_flags, indio_dev->name, indio_dev);
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+			NULL, vl53l0x_threaded_irq,
+			irq_flags | IRQF_ONESHOT, indio_dev->name, indio_dev);
 	if (ret) {
 		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
 		return ret;
@@ -87,26 +153,6 @@ static int vl53l0x_configure_irq(struct i2c_client *client,
 	return ret;
 }
 
-static void vl53l0x_clear_irq(struct vl53l0x_data *data)
-{
-	struct device *dev = &data->client->dev;
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(data->client,
-					VL_REG_SYSTEM_INTERRUPT_CLEAR, 1);
-	if (ret < 0)
-		dev_err(dev, "failed to clear error irq: %d\n", ret);
-
-	ret = i2c_smbus_write_byte_data(data->client,
-					VL_REG_SYSTEM_INTERRUPT_CLEAR, 0);
-	if (ret < 0)
-		dev_err(dev, "failed to clear range irq: %d\n", ret);
-
-	ret = i2c_smbus_read_byte_data(data->client, VL_REG_RESULT_INT_STATUS);
-	if (ret < 0 || ret & 0x07)
-		dev_err(dev, "failed to clear irq: %d\n", ret);
-}
-
 static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 				  const struct iio_chan_spec *chan,
 				  int *val)
@@ -128,7 +174,9 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 		if (time_left == 0)
 			return -ETIMEDOUT;
 
-		vl53l0x_clear_irq(data);
+		ret = vl53l0x_clear_irq(data);
+		if (ret < 0)
+			return ret;
 	} else {
 		do {
 			ret = i2c_smbus_read_byte_data(client,
@@ -163,7 +211,14 @@ static const struct iio_chan_spec vl53l0x_channels[] = {
 		.type = IIO_DISTANCE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(32),
 };
 
 static int vl53l0x_read_raw(struct iio_dev *indio_dev,
@@ -221,6 +276,41 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
 	return 0;
 }
 
+static int vl53l0x_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+
+	return i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START, 0x02);
+}
+
+static int vl53l0x_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START, 0x01);
+	if (ret < 0)
+		return ret;
+
+	/* Let the ongoing reading finish */
+	reinit_completion(&data->completion);
+	wait_for_completion_timeout(&data->completion, HZ/10);
+	vl53l0x_clear_irq(data);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
+	.postenable = &vl53l0x_buffer_postenable,
+	.postdisable = &vl53l0x_buffer_postdisable,
+};
+
+static const struct iio_trigger_ops vl53l0x_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
 static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
@@ -278,9 +368,31 @@ static int vl53l0x_probe(struct i2c_client *client)
 	if (client->irq) {
 		init_completion(&data->completion);
 
+		data->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+						indio_dev->name,
+						iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &vl53l0x_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+		ret = devm_iio_trigger_register(&client->dev, data->trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(data->trig);
+
 		ret = vl53l0x_configure_irq(client, indio_dev);
 		if (ret)
 			return ret;
+
+		ret = devm_iio_triggered_buffer_setup(&client->dev,
+					indio_dev,
+					NULL,
+					&vl53l0x_trigger_handler,
+					&iio_triggered_buffer_setup_ops);
+		if (ret)
+			return ret;
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.43.0


