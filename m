Return-Path: <linux-iio+bounces-12101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5189F9C341D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 18:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C441C206A5
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 17:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603BC62171;
	Sun, 10 Nov 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiwrKhWq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6417C69;
	Sun, 10 Nov 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731260951; cv=none; b=a7FMabcoaKseYvhxH2K2M8B2Hov1Tnf8D9B4U6iP+cvM3bsqSiyOf40R0He3+cz/o+PBTRrAnbQGSfr9qTfD+LrXN/GBIEyLy8hE2ttce50Z9yzqR3TylqcPoXIemQz1ZDxemBMttY0rujgOB6S1AKpjQ234mcv3sawnlRnucv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731260951; c=relaxed/simple;
	bh=olh7EWPrDhaRUfff6mnUurhcFt5ymWoIlhErKU+Bawo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TJMBtnvnhzX297e8Y/0zmMrPHdMMZzrmvsT4oImZHmv94MBU79Aas++Qswd/xvqt0WI68owp3Ftiy3WN1tDrRxIcVZQ2W0Aqr8d4x7DQdIMIptzio/aW/Wbj1NPuAn8PiSN19bg3EpZCZ1mESmGImh1e0uGfZt7IdZxtQAXJPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiwrKhWq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so32290975e9.2;
        Sun, 10 Nov 2024 09:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731260947; x=1731865747; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIF8mMN4nxIyYddDOcxkqt6QD4vDuU8tCwTAU8nq3vc=;
        b=iiwrKhWqbfBnXTsHYmO5dkobkyHtSTQUwojsAvvFGTTw4ciY2+LShVH+mllWP6n8vR
         RvewSaQAVs7AIxWDd/P5+Ot4uwNDeX7+n32A2YLTeG8x9+1OPJOlW57UuEMI+qTiAJm7
         EzvMbxdCLN3FCJGJoZbx0pXJ5vZhWjtjV7VFBQTzy36tnHKHlKbUkSnMEWfChkSzbdVu
         Ul/qJIym9oq2RO1T9kc8AM7n8ZjFygta9fcIv0eNQ7bcZn5CeT9/c/PIlnd3ugwNhiVI
         TJUSCWRZ23SESEqcQL8qInxLXN5TsZ5jjMUNHfcUn1iuuWZRMu5Sqlcru3sb2I2pgyCa
         4gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731260947; x=1731865747;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIF8mMN4nxIyYddDOcxkqt6QD4vDuU8tCwTAU8nq3vc=;
        b=uQqahAtd4t0fAnadDYFCx3jYr3fK2MlDQAqEdod+BLd0N1MqWd1/YAOIVDlS7nYaEU
         6KhoC+nZK+BoGE/PFMVnEW5foWJIujc3Y2wvzKWc9l0koNRFknhD8u/Y+iLYN5107vJd
         ZmdAkMjvvQe9jRCbYpxWTyxdKT1l2XnsShXG4roQEhmcBcSVBi+Br2r1qlrBHfNUXIlg
         9ZbT92dvPvtP/eb5As0mqB73KuvxomHdhsjUKtFkc7I2xbq9IP0WA4EoFshjfN+jW2g8
         JAi6j9Zng5XJ4cGYCpOaC8hoiHHF6vU9xRXaBJENFlHhg9GAW/u1wfXQTI1qDN6VLHC8
         +gMA==
X-Forwarded-Encrypted: i=1; AJvYcCU++iD4sxwD6kyPZ4CtgQUQJBF4MgU5pg8RmzDYoTCppjWdxD51AzxlRWhykPx0KLR44OdiGV8qnJfJBNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxAyX0XMhyQ2emd5igtITcOUiVZDaxhyZt98o48bhzSByJ3fHD
	8CEW5x23qX1W6ANoZd4CANGfRR1sHEoXgAHlQrABV1SSvauo8p4mMsQA7w==
X-Google-Smtp-Source: AGHT+IHgwU/me8r/JPkiRKjPVTEoxDTXLy2P3JRJuLNStURzQuwr6anmyDJYFtkF1IpCQigMmoTb9A==
X-Received: by 2002:a05:600c:1e83:b0:431:44aa:ee2e with SMTP id 5b1f17b1804b1-432b74fa90cmr87892995e9.4.1731260947199;
        Sun, 10 Nov 2024 09:49:07 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-42ae-9365-9761-6ab9.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:42ae:9365:9761:6ab9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0530694sm152527255e9.7.2024.11.10.09.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 09:49:06 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 10 Nov 2024 18:49:05 +0100
Subject: [PATCH v2] iio: light: veml6030: add support for triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241110-veml6030_triggered_buffer-v2-1-ecda3b6ed77f@gmail.com>
X-B4-Tracking: v=1; b=H4sIABDyMGcC/33NTQqDMBCG4avIrJuSqE1DV71HEYlxjAP+MbGhR
 bx7U6HbLt8P5pkNAjJhgFu2AWOkQPOUIj9l4Ho7eRTUpoZc5qVSUouI46BlIeuVyXtkbOvm2XX
 IwhbGGO1s6RxCul8YO3od9qNK3VNYZ34fr6L6rj/1+keNSihRGiVtk3B30Xc/WhrObh6h2vf9A
 xCAI2vCAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731260946; l=5644;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=olh7EWPrDhaRUfff6mnUurhcFt5ymWoIlhErKU+Bawo=;
 b=cIXQJv+dpei/oEiwT7nZJNssTcA4E6FgUab9bLqS0oZ1m7Jivafx3IkXhYWS8KpF74qHEQj+P
 hsAytoUa5ITCozbJ51mfywdJeIVg4ETa/5V7G8cUuV3yHIaq+okaktr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

All devices supported by this driver (currently veml6030, veml6035
and veml7700) have two 16-bit channels, and can profit for the same
configuration to support data access via triggered buffers.

The measurements are stored in two 16-bit consecutive registers
(addresses 0x04 and 0x05) as little endian, unsigned data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Use u16 instead of __le16 for the channels.
- Move scan struct from data to trigger_handler.
- Drop avail_scan_masks.
- Fix scan_type (IIO_CPU instead of IIO_LE, drop shift = 0).
- Link to v1: https://lore.kernel.org/r/20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com
---
 drivers/iio/light/Kconfig    |  2 ++
 drivers/iio/light/veml6030.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

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
index ccb43dfd5cf7..ce9af9a0e933 100644
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
@@ -56,6 +59,12 @@
 #define VEML6035_INT_CHAN     BIT(3)
 #define VEML6035_CHAN_EN      BIT(2)
 
+enum veml6030_scan {
+	VEML6030_SCAN_ALS,
+	VEML6030_SCAN_WH,
+	VEML6030_SCAN_TIMESTAMP,
+};
+
 struct veml603x_chip {
 	const char *name;
 	const int(*scale_vals)[][2];
@@ -242,6 +251,13 @@ static const struct iio_chan_spec veml6030_channels[] = {
 						     BIT(IIO_CHAN_INFO_SCALE),
 		.event_spec = veml6030_event_spec,
 		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
+		.scan_index = VEML6030_SCAN_ALS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_INTENSITY,
@@ -253,7 +269,15 @@ static const struct iio_chan_spec veml6030_channels[] = {
 				BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6030_SCAN_WH,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6030_SCAN_TIMESTAMP),
 };
 
 static const struct iio_chan_spec veml7700_channels[] = {
@@ -266,6 +290,13 @@ static const struct iio_chan_spec veml7700_channels[] = {
 				BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6030_SCAN_ALS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_INTENSITY,
@@ -277,7 +308,15 @@ static const struct iio_chan_spec veml7700_channels[] = {
 				BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6030_SCAN_WH,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6030_SCAN_TIMESTAMP),
 };
 
 static const struct regmap_config veml6030_regmap_config = {
@@ -889,6 +928,35 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t veml6030_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct veml6030_data *data = iio_priv(iio);
+	unsigned int reg;
+	int ch, ret, i = 0;
+	struct {
+		u16 chans[2];
+		aligned_s64 timestamp;
+	} scan;
+
+	iio_for_each_active_channel(iio, ch) {
+		ret = regmap_read(data->regmap, VEML6030_REG_DATA(ch),
+				  &reg);
+		if (ret)
+			goto done;
+
+		scan.chans[i++] = reg;
+	}
+
+	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
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
@@ -1077,6 +1145,12 @@ static int veml6030_probe(struct i2c_client *client)
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
base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
change-id: 20241106-veml6030_triggered_buffer-a38886ca4cce

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


