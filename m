Return-Path: <linux-iio+bounces-12008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892BA9C0FA4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 21:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D2A2811AB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DE2216A0B;
	Thu,  7 Nov 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyOCe3u1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B820212F11;
	Thu,  7 Nov 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010977; cv=none; b=sDwvMlTOyWBQoo+/Mbeaj24cLFDTErr383aCQvqanULGvBycXDJz4ZZd5Zx/B3RkTPmRbQqh2tLC6uLZ1QNx6ThhUjtMfkTVDIyKsdJhwJbsiEs6+15usAAeDgFESCR8gyIc36cQ22PRIgopRQHhQAEsL0Ij02a9OHOTCWvz7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010977; c=relaxed/simple;
	bh=I6y944szaKMubsG0mlyWDmKSWnPpWJibXStT334g2cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kZ2uQWGPJlCJG0tYsMayCBOm7msENHOu+LuMGNaaFssgJk4uHGtrBUfnqtmmhJN1fOTPMFB2Y2Bi7zeWcztaqY/qmEhhBl0vN1GVaIoZPEnpSGTGQ9/ABcAethjXFFSQdCqbZyLX9xBlGsGTmPBi8aw09seR9HoSV10fkpZedUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyOCe3u1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d447de11dso888901f8f.1;
        Thu, 07 Nov 2024 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731010974; x=1731615774; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5paEoDARaE3Ru7sTIlAo9NPnl9+WJnYXQ7Fyolyicw=;
        b=eyOCe3u1LCG5o3rHMx3oMBZQJepYx3e3uA2QvoIgCwfd+5CAM1RW5/9thap2kiXhi9
         yPfj3MRitCtZcbLi4kuzjoTwK9WMbORZbvoZon1QBfh7RWo0o77toaSoQa3NKj5cu6xj
         KReSkoY9F7L/Q2Vbgbz09v8glHvyxRcaHcc4yz21zkLYYxrG9UUHlK7O1alFrPVtkqgs
         DDhmfVy6jPOMNy0w3qg5BeonLpja0F5dEPhu5s7QbVNKz2yGSZPr6ifhN08wQytmiMPw
         Xdl4QIPtfTWx4K3b80m/cAv+3lsQ8E5ZPx0EeJ6bdHuKOqdS4NumnsY+nP4Y1SOxvmyU
         oKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010974; x=1731615774;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5paEoDARaE3Ru7sTIlAo9NPnl9+WJnYXQ7Fyolyicw=;
        b=DQqMhscnikC0C9prRWfvpbXR5Temd9UeT+Uz8D2dYR6hBDb+uHFXL7NDBnCOZJ+lw5
         pvYuUCkJvJn0aqiVenXsdaAd/4vXENjQ0qz7jbXx0blz7HkXo+RyaVOOJk/FUpOjZcwB
         Jzh1GuDAl3MPScM2hbGMpbMIQM3j2iDd8Y3+VyxCbRNxEyh6DySTmLBlGi2jW9Vv/L3i
         oqtw9Vel77aHxHNc89PLQSXqO5Sz0SnagoxsiTxTQ677hIUsiByNp9UNXjHCtdN7gMCA
         t5pB1N4vX9imUmW0dKvmOLThy8LXTtht6HGwbJ/SzKeaSyYmFQQNg98YjpPohPE0bpKN
         IQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWGpNsWvc7Pw1K7+AsosC6hwO2BLrK8wBNe6k/DldiFJYIuhEf3Qgcc+E9vW+ede2iFEruFofWbFvrN2gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFocX2hl6Sr9OWkJpWdIGusmL2B7egV+QX+5ndCDxHWAyWhPfE
	32Vhl79fc9kDIJbJkHfkyDFeH8RDvfS3qvYV9D8ZR08r45ZKy/XizUoekg==
X-Google-Smtp-Source: AGHT+IEmk6sbi63gjHW5BK0PmfOeJjYECUO9SpsDZj/iO1LIETsrHHU/41nVBHHr+NzKNtvSoWet4g==
X-Received: by 2002:a5d:6d0c:0:b0:37d:4657:ea7d with SMTP id ffacd0b85a97d-381f1835301mr376281f8f.49.1731010973691;
        Thu, 07 Nov 2024 12:22:53 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b4fe-bfa5-1068-9264.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b4fe:bfa5:1068:9264])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda0ed16sm2554824f8f.107.2024.11.07.12.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 12:22:53 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 07 Nov 2024 21:22:45 +0100
Subject: [PATCH] iio: light: veml6030: add support for triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJQhLWcC/x3MQQqDMBBG4avIrA0kRkLwKkUkjX/SAasysVIQ7
 97Q5bd476ICYRQamosEJxfe1grTNhRfYc1QPFdTp7veGO3UiffitNXTIZwzBPP0/KQEUcF6710
 MfYyg2u+CxN//+zHe9w8w4E2xawAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731010972; l=6049;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=I6y944szaKMubsG0mlyWDmKSWnPpWJibXStT334g2cM=;
 b=vQoUyT17a783VP5Pn+jYU1Kr3qeJgOWf14ZiK+FLxMJ0kYsnYbuvhdIr0yw3VOsoI0hCm31JC
 IfY3m/ybeCkCur3jgKBKjOHP+peuFfJHktEhfaE4Io5b5aPzcqMsf++
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

All devices supported by this driver (currently veml6030, veml6035
and veml7700) have two 16-bit channels, and can profit for the same
configuration to support data access via triggered buffers.

The measurements are stored in two 16-bit consecutive registers
(addresses 0x04 and 0x05) as little endian, unsigned data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig    |  2 ++
 drivers/iio/light/veml6030.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 29ffa8491927..0e2566ff5f7b 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -683,6 +683,8 @@ config VEML3235
 config VEML6030
 	tristate "VEML6030 and VEML6035 ambient light sensors"
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VEML6030
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index ccb43dfd5cf7..d57ae0c4cae3 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -28,6 +28,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 /* Device registers */
 #define VEML6030_REG_ALS_CONF   0x00
@@ -37,6 +39,7 @@
 #define VEML6030_REG_ALS_DATA   0x04
 #define VEML6030_REG_WH_DATA    0x05
 #define VEML6030_REG_ALS_INT    0x06
+#define VEML6030_REG_DATA(ch)   (VEML6030_REG_ALS_DATA + (ch))
 
 /* Bit masks for specific functionality */
 #define VEML6030_ALS_IT       GENMASK(9, 6)
@@ -56,6 +59,18 @@
 #define VEML6035_INT_CHAN     BIT(3)
 #define VEML6035_CHAN_EN      BIT(2)
 
+enum veml6030_scan {
+	VEML6030_SCAN_ALS,
+	VEML6030_SCAN_WH,
+	VEML6030_SCAN_TIMESTAMP,
+};
+
+static const unsigned long veml6030_avail_scan_masks[] = {
+	(BIT(VEML6030_SCAN_ALS) |
+	 BIT(VEML6030_SCAN_WH)),
+	0
+};
+
 struct veml603x_chip {
 	const char *name;
 	const int(*scale_vals)[][2];
@@ -86,6 +101,10 @@ struct veml6030_data {
 	int cur_gain;
 	int cur_integration_time;
 	const struct veml603x_chip *chip;
+	struct {
+		__le16 chans[2];
+		aligned_s64 timestamp;
+	} scan;
 };
 
 static const int veml6030_it_times[][2] = {
@@ -242,6 +261,14 @@ static const struct iio_chan_spec veml6030_channels[] = {
 						     BIT(IIO_CHAN_INFO_SCALE),
 		.event_spec = veml6030_event_spec,
 		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
+		.scan_index = VEML6030_SCAN_ALS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.shift = 0,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
 	{
 		.type = IIO_INTENSITY,
@@ -253,7 +280,16 @@ static const struct iio_chan_spec veml6030_channels[] = {
 				BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6030_SCAN_WH,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.shift = 0,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6030_SCAN_TIMESTAMP),
 };
 
 static const struct iio_chan_spec veml7700_channels[] = {
@@ -266,6 +302,14 @@ static const struct iio_chan_spec veml7700_channels[] = {
 				BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6030_SCAN_ALS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.shift = 0,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
 	{
 		.type = IIO_INTENSITY,
@@ -277,7 +321,16 @@ static const struct iio_chan_spec veml7700_channels[] = {
 				BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6030_SCAN_WH,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.shift = 0,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6030_SCAN_TIMESTAMP),
 };
 
 static const struct regmap_config veml6030_regmap_config = {
@@ -889,6 +942,30 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t veml6030_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct veml6030_data *data = iio_priv(iio);
+	int i, ret, reg;
+	int j = 0;
+
+	iio_for_each_active_channel(iio, i) {
+		ret = regmap_read(data->regmap, VEML6030_REG_DATA(i), &reg);
+		if (ret)
+			goto done;
+
+		data->scan.chans[j++] = reg;
+	}
+
+	iio_push_to_buffers_with_timestamp(iio, &data->scan, pf->timestamp);
+
+done:
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int veml6030_set_info(struct iio_dev *indio_dev)
 {
 	struct veml6030_data *data = iio_priv(indio_dev);
@@ -1068,6 +1145,7 @@ static int veml6030_probe(struct i2c_client *client)
 	indio_dev->channels = data->chip->channels;
 	indio_dev->num_channels = data->chip->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = veml6030_avail_scan_masks;
 
 	ret = data->chip->set_info(indio_dev);
 	if (ret < 0)
@@ -1077,6 +1155,12 @@ static int veml6030_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      veml6030_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to register triggered buffer");
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 

---
base-commit: c9f8285ec18c08fae0de08835eb8e5953339e664
change-id: 20241106-veml6030_triggered_buffer-a38886ca4cce

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


