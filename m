Return-Path: <linux-iio+bounces-12610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DB9D77D7
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF940B23E84
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E3A13C67C;
	Sun, 24 Nov 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF0QMYid"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9850B660;
	Sun, 24 Nov 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732474752; cv=none; b=JewyyBSnWBk+eg/Zapfm7I4VirXxJK2rCZk3PD4bw4Ojkg9g3RN8LkfFNIIMbGLHtExWbeqpJ/UNRj1NfFmCgC9dQIwD+goekZZcViGxPFZ/Vk+xhNJIpJj1cb+pWR8fk7YDz2xLyYX4ulBC1pnYpKUv19dMCCAy3xVeZQcDwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732474752; c=relaxed/simple;
	bh=JQdkJTLMRjroOg09GCSoxu6tzbAPuFf+fJPweLxpMSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SEzIQYrQ9KNXpLHnb+KeHpFoTOUAB3/YcmjXaz081SVz9O5+6W0fsk3UHXITbdCHRnkTyHEN1SmTDPX5FIPftB31bLhCoLb4A5PBeL3/46dKqwT1T/uT8ByvHfj6Hm3FS53bRTLndX1X8BE8A0Ynlu9KPG5c9hPgratl7dqjZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF0QMYid; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso3511375e9.0;
        Sun, 24 Nov 2024 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732474749; x=1733079549; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EKx/tMnFk/mNXgsixb4ZIO9kL4LVI+YFTB7W9UaPMQ=;
        b=HF0QMYidie1VeKGccHBqB3Bkn66MQdVChJV66FyRC5/yvOMsR4YzNt6ohdhKAAQAgu
         VhEGuKO9GJjCSV0X0ZdDoU/1RsZ+Z1ul+RPZUPrVtWsexoYhEvla+a+Z4/rKmJx7DF1E
         Zu3YAydgltoE/WiGe/W1AteCILloH+cLkIPGCHwlrfJz6p7lliTHX5blDo06gaGUboLR
         DH7mU3caegB04MoxZG4AFwa013btNEfOO/E6l3kPrHjXCVumRokKjkFZLl2xtikoIB9L
         8gzHAPXOTdUS4Je5tifKiEb4oRe1hpYRogMOlJRoE8zkDbWDKchVNTPXKv9DHsGKWH0s
         jIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732474749; x=1733079549;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EKx/tMnFk/mNXgsixb4ZIO9kL4LVI+YFTB7W9UaPMQ=;
        b=JM91ITmx+xS6YKQwE9HES4hEyI4urA0u22PL0aRF5OnswDHtKyjuSuKIzhrpx0xyp9
         wECxqG8pTht78yGCeUOd4Egcm7qoUqMzO0zgXdDNr4DK8GclqdTXAMqyLAl31sIo5dRY
         F2N+dKUMi1bDbDmb2E0SH7M/qotuTAE1OLPKuhR6t21yHSMaEgiwClG7pDlUm74FruCy
         I7JBw6mxptFtkQYffZKnGcgwpBxBhJXX+6OBXJNWYM5k/c9NFfcl9kE8Rxek9tQZYF/Y
         d1JUHEYzNxzlt707n8WPGHVbzvX2RdZgpLnl7cZisAQRfvOCWKchhRea7r/RcH/2HCxr
         mnCg==
X-Forwarded-Encrypted: i=1; AJvYcCXo30xUQTV85JhW0wFzATPKt55wbljdi1ZoupjtR4IYL4HmoAtIBvgUI4vc9H3g8bOPmAwsLm1RUVNWnFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhBAAbQrWniO30LO8Qs8kjvnh5p9LQCxb1n4Crj9USAkJ9GbC
	42KdBarkqSSKbaXGepq2pbOa1v7MrVZMZUEgSyczBVw/9/fxicHG
X-Gm-Gg: ASbGncvsmptINWkymSkcxhpNm9fee+spVWL69AIEreQeuX4mb+Qq0nFWt9zNY5CWcWT
	mwXvXmMrOweiz7QiA/1eJnGCn9nJpFsydeodbmhujSKYimB0iwCHHbrkBBslb8dQO9flrY40gt/
	0F5hespfkzQdMR9NHdRMP10fVcB/CEhsSFpTmpazc2liZGYW0x1MIhucMNwW42bvro8BapSlx72
	avUVmWqagR7RTa9Pj9tsuHd4eL+SinZBVbpiTO1fxFFFlwlrmZJbqg20DniXhmr87JdfrMR6UXm
	vh2u2dGold101ZZPL2tzcq+VV4l31bGBuasoEmNwQz8NnnJhbjS3M6ZI00/6dA0QXID9WZ7J
X-Google-Smtp-Source: AGHT+IE2ml5prF4Uh65lndfftmCk5c148TsMrlkoElOHSzLEuz3/E4kdxq9isJwa8U92ssZjHiVh7g==
X-Received: by 2002:a5d:5984:0:b0:37d:54de:1609 with SMTP id ffacd0b85a97d-38260b4574fmr8196620f8f.10.1732474749023;
        Sun, 24 Nov 2024 10:59:09 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-ca17-b30f-f373-544f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:ca17:b30f:f373:544f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe3cbsm8319558f8f.38.2024.11.24.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 10:59:08 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 24 Nov 2024 19:59:06 +0100
Subject: [PATCH v3] iio: light: veml6030: add support for triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-veml6030_triggered_buffer-v3-1-565bb6b4b5c8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHl3Q2cC/33NywrCMBCF4VeRrI3kUtPiyvcQKWkySQd6kaQGp
 fTdTQtCV13+B+abmUQICJHcTjMJkDDiOOSQ5xMxrR48ULS5iWCi4JwpmqDvFJOsngJ6DwFs3by
 dg0C1rKpKGV0YAyTfvwI4/Gz245m7xTiN4bu9Snxd/2p5oCZOOS0qznSTcXNVd99r7C5m7MmqJ
 rGTODuSRJbAWC0bBbYs3V5aluUH+36TmAwBAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732474747; l=5873;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=JQdkJTLMRjroOg09GCSoxu6tzbAPuFf+fJPweLxpMSU=;
 b=NnubLUr7juHNJwKFkrAUOvoX+FG1PUk3+W1fM9TxyE3FwcXMKe6wEFTALnGKZWbdycgqa881V
 omJmp000+QmAaftFCVBmj51nJli867djEIFQrxGFkN2s0Bl2PzQDYZ5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

All devices supported by this driver (currently veml6030, veml6035
and veml7700) have two 16-bit channels, and can profit for the same
configuration to support data access via triggered buffers.

The measurements are stored in two 16-bit consecutive registers
(addresses 0x04 and 0x05) as little endian, unsigned data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Ensure that the holes in the scan struct are initialized to zero.
- Link to v2: https://lore.kernel.org/r/20241110-veml6030_triggered_buffer-v2-1-ecda3b6ed77f@gmail.com

Changes in v2:
- Use u16 instead of __le16 for the channels.
- Move scan struct from data to trigger_handler.
- Drop avail_scan_masks.
- Fix scan_type (IIO_CPU instead of IIO_LE, drop shift = 0).
- Link to v1: https://lore.kernel.org/r/20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com
---
 drivers/iio/light/Kconfig    |  2 ++
 drivers/iio/light/veml6030.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

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
index ccb43dfd5cf7..9b71825eea9b 100644
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
@@ -889,6 +928,37 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
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
+	memset(&scan, 0, sizeof(scan));
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
@@ -1077,6 +1147,12 @@ static int veml6030_probe(struct i2c_client *client)
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
base-commit: ab376e4d674037f45d5758c1dc391bd4e11c5dc4
change-id: 20241106-veml6030_triggered_buffer-a38886ca4cce

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


