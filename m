Return-Path: <linux-iio+bounces-8900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87338966A4C
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 22:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE691C21BAB
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E581BF32E;
	Fri, 30 Aug 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3XTdsU8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AB1BF31D;
	Fri, 30 Aug 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049043; cv=none; b=o37vPXu6QTNVLrQUYuHwzeHUygQKhPvDqDdJycrTwv7Tm+fzqWgd4tXH5WrFxxBBFrzdXZUr9a+Pgc2Rcq8AgpmXnAud3Hgred05K5u2qR6Vx3uXkYo1uXSum6SWk+WkZ53+srF+lYfYXaRLbzkyceSMqA149zW44dBKq6BHdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049043; c=relaxed/simple;
	bh=kuGb3WJ3qlPjwbQZqwSoMTeTEWH8fLqpvs4rAg86zuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMXacisPWCsciu98c3nGNK5NpjKXRB3UtLAkxKArQ5HJE5Spq8+MAGey7ELRchqXShN/bckC+lwg0qiSay2M1Gy7r+Q4DZpTkm8wvO/EvyH33FD5X8Q0KbRXCSODlfmirP0m1OhAjksboA+m/ti/A3Tis7SR2UH7FZSnH8zwY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3XTdsU8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714287e4083so2028582b3a.2;
        Fri, 30 Aug 2024 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049041; x=1725653841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi+Say77cH1ylZ4XneSFtnKiT60ynjvcD6h/n+L53uA=;
        b=a3XTdsU8KX4Dj/5dzJiZO5YAw5BIT0U6TnmJfFoP0kploYGfRpMQcRV2lkLlJQBqdC
         YlSIEtCv13l6sVf40yvSJeiFWDRZN/kguuQ/wpQa0ufVxeYxbW5xAVDB3gc/5TMd5GOu
         LGZGYTVhcxjGSKKOC8orpBbK2sRLa924/WB8WeAv2uKZ1NLW5NTq3JTAhsHruEpi0yeA
         YGqr06wJ8ibD90VaSHmAiPoYDdF52OEIIW8nk1buPg2eDKhMxMr/ezmrr1ox61CI2QZ9
         LAsRwvNnuVSDbl0vmYtzwpLjlLonTA39i8D3wsCGNak352x08UDddhBK53mOmyPRolkR
         EeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049041; x=1725653841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi+Say77cH1ylZ4XneSFtnKiT60ynjvcD6h/n+L53uA=;
        b=jCYeoMsSTyBrJoRg87l/FNZ/G14vaFdrDVM2RvdwMVijF3jdyaq31l3D0kFRAR0FBz
         HO7RQ5YQjhX2D5bsqe8cBH6HIpu4bN8NZfHgIoxUr7L9m9Igoz0+hnSHX5yYrtS9HowU
         mYxBCpndVs8y54BPZb8ovQeO63jL8TtuCe4mwv42pR4XHYg2nLe6c0d+1FFwJGKIKOvj
         3ZMcrEn+iXQCXNDoVyhp0ligdLjLoFZg6EMLFqL/6QbdBOO9gyc8a8OTpKrDVi7Jf/xT
         WXiokn1k5n3/JlulP+c+kfEyEGUrCsxwmC/LC+oGDqJWotzU/JBxsHHs4X621oLNYTpR
         37Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUCVhLAjqbOUBs1O8JXkvOA5abC9+djjh2SLPtVv5c0zcJbHpY6AhuM7ARDh6evGL9mDGFN3zvzVxW/MSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcImFXk3NOI4riHUInzXJXTrT0FffyR8eOveYI/Unh8KLdQhA
	H+s1cfuRtS4oFTXVa/MIStrMyLIqKu7EBYmQNeSO0Vf6hzXyyWJvynIWkO/h
X-Google-Smtp-Source: AGHT+IH77ZkU6rLkTqxj259tg7vHn96jqdsZUiM0N5nxtf3ldYpsu6QUlittVbx6fPS/DmNHvWjkHQ==
X-Received: by 2002:a05:6a00:2388:b0:70d:2693:d215 with SMTP id d2e1a72fcca58-7173b60ca4emr1196059b3a.16.1725049040592;
        Fri, 30 Aug 2024 13:17:20 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([2401:4900:608e:fa44:845a:20a9:791f:c32b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e56e5c23sm3257476b3a.172.2024.08.30.13.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:17:20 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 2/2] iio: proximity: vl53l0x-i2c: Added continuous mode support
Date: Sat, 31 Aug 2024 01:46:26 +0530
Message-ID: <20240830201627.298264-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
References: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
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

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 125 ++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 2b3dd18be..b0c947586 100644
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
 
@@ -49,14 +53,58 @@ struct vl53l0x_data {
 	struct completion completion;
 	struct regulator *vdd_supply;
 	struct gpio_desc *reset_gpio;
+
+	struct {
+		u16 chan;
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
-static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
+static void vl53l0x_clear_irq(struct vl53l0x_data *data)
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
+	if (ret < 0 || ret & 0x07)
+		dev_err(dev, "failed to clear irq: %d\n", ret);
+}
+
+static irqreturn_t vl53l0x_threaded_irq(int irq, void *priv)
 {
 	struct iio_dev *indio_dev = priv;
 	struct vl53l0x_data *data = iio_priv(indio_dev);
+	u8 buffer[12];
+	int ret;
 
-	complete(&data->completion);
+	if (iio_buffer_enabled(indio_dev)) {
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						VL_REG_RESULT_RANGE_STATUS,
+						sizeof(buffer), buffer);
+		if (ret < 0)
+			return ret;
+		else if (ret != 12)
+			return -EREMOTEIO;
+
+		data->scan.chan = (buffer[10] << 8) + buffer[11];
+		iio_push_to_buffers_with_timestamp(indio_dev,
+						&data->scan,
+						iio_get_time_ns(indio_dev));
+
+		iio_trigger_notify_done(indio_dev->trig);
+		vl53l0x_clear_irq(data);
+	} else
+		complete(&data->completion);
 
 	return IRQ_HANDLED;
 }
@@ -71,8 +119,9 @@ static int vl53l0x_configure_irq(struct i2c_client *client,
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
@@ -87,26 +136,6 @@ static int vl53l0x_configure_irq(struct i2c_client *client,
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
@@ -163,7 +192,14 @@ static const struct iio_chan_spec vl53l0x_channels[] = {
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
@@ -221,6 +257,40 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
 	return 0;
 }
 
+static int vl53l0x_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START, 0x02);
+	if (ret < 0)
+		return ret;
+
+	return 0;
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
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
+	.postenable = &vl53l0x_buffer_postenable,
+	.postdisable = &vl53l0x_buffer_postdisable,
+};
+
 static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
@@ -279,6 +349,13 @@ static int vl53l0x_probe(struct i2c_client *client)
 		ret = vl53l0x_configure_irq(client, indio_dev);
 		if (ret)
 			return ret;
+
+		ret = devm_iio_triggered_buffer_setup(&client->dev,
+					indio_dev,
+					&iio_pollfunc_store_time,
+					NULL, &iio_triggered_buffer_setup_ops);
+		if (ret)
+			return ret;
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.43.0


