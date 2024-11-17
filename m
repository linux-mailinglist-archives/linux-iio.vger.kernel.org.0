Return-Path: <linux-iio+bounces-12351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604099D0511
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB632B22550
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC81DD531;
	Sun, 17 Nov 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCuEzZQG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F21DA628;
	Sun, 17 Nov 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868105; cv=none; b=Q/fzd7Pguuz9YWVsCcziX54dgKMR8nZFSGEd9AVUCa9DGzM3scoSVdj+rpTCtZ4GzvRSTvk9VMdKzgipui1/NEoTRi4LZkuUdS+CPq7hnwzfJRsLSvZQyUL4N13p5pzUNScYgmBdkktY48x6a4vkns3GYLyBfFlo3YzR/9fsL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868105; c=relaxed/simple;
	bh=RPvfTp2cv2107R2RLYpfauTAm08ezaOfag6H6xQEl70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srB4E9iQH3txKxEiNAFWWjh4OtYybZ8gTAiz+oIRMlXYFmu82jipYFO87Ze6b7lGrTEgiTd7nP1NuhYxxtdBvqT84mGQab0ixfTKLFa4rBIgbxC046Qkj28t+yjS3GJ1s6GdoYaL39bkh6TylTRaIHQIlSKaDI9cRF//5gmIQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCuEzZQG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43159469053so1867405e9.2;
        Sun, 17 Nov 2024 10:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868102; x=1732472902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QH8gYycQZ+3mi37d5ffBI3sVj1MCkPULMK4Fd22p4wI=;
        b=QCuEzZQGvk3V0wQKNg31ggp1R3i9Ic3FSQ4zQjoo0K7CX69a3jOqK8k9nVK10dR5eQ
         o+pmAmYkp76IsXdB1QUPNXIyfcyXRH1NiN3JWWeqvqB88DpVXEcBQrNeWR7HU58jUEv4
         WvRLj5RkezoQTxcglwyK6gRaWvNibK1DLTsJyXr0HL+eBGlp/AlbrqLvf4iwkpAx9tMx
         NaXbaiEd+koBNPX7TTE2XeUmPhATc2QGaSfmS9C8MN9FnN2Y4vdzXYtCUV4T9C8e18nL
         TgP3eUkqo1gOGnTzMnLY6S/LM/Lb1l64SoLdPeNrDnYRoDPBwow+O5bT0ea5AaLck/sq
         KImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868102; x=1732472902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QH8gYycQZ+3mi37d5ffBI3sVj1MCkPULMK4Fd22p4wI=;
        b=q+Y1GQ01Fdx8i4WqcDv+71Rl/IDrtVKF+eCJq1XmDY6v/M+4bS2eCcQe+sxEr43tXQ
         M4V/JETkm5AlhJpmt3othnMr/8JO7qCzBm66qgmefCyWNk16F11dXgVtVi3eSoWkvUzh
         bW6xe6hMgsPFolmuifn6sEt6akswZ94tdZQKB2kovqEVb//KRnhBqVa3zHSFeL/t2R65
         Zl22Um7rKll3d8b2HoruEaUkOnCDro2xQcXS9FpYDigELUZ2n/NfsaNJfSv5cM8osBLs
         Y0B3mqNGoE1omt5yGtxmk2iDOn67u8Yvh0UGobE02Akpp22xSutooSgI0PmJRr5d7kgG
         belA==
X-Forwarded-Encrypted: i=1; AJvYcCXGuZjioMyIcQ7os4G6yrWbFf9paZwnYz8W1M5E26VHS5cHrXbFw9P/xDpJ8/wiRhyeul1Fykd/n5sYhYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTFSXFyQuTujZo/KUKTyE2P3vGgsTegaDyZjLmCU7gQlOkP7a
	xhPOL850PfQFwgiqsqJ1bdSr6E/c10gi37uOFBLeooU8BHiMQyAK
X-Google-Smtp-Source: AGHT+IH8mE13aDycfKCqr3mPzQD8LmO8z2ZiHOFC14Lzgc5GTLbASRYC15+JjRmpk0zMJxR6OZqkoQ==
X-Received: by 2002:a05:600c:1991:b0:42c:ba83:3efa with SMTP id 5b1f17b1804b1-432df6841femr35135495e9.0.1731868102450;
        Sun, 17 Nov 2024 10:28:22 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:22 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 08/22] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Sun, 17 Nov 2024 18:26:37 +0000
Message-Id: <20241117182651.115056-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to delay FIFO access when SPI is used. According to
the datasheet this is needed for the adxl345. When initialization
happens over SPI the need for delay is to be signalized, and the delay
will be used.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      | 2 +-
 drivers/iio/accel/adxl345_core.c | 6 +++++-
 drivers/iio/accel/adxl345_i2c.c  | 2 +-
 drivers/iio/accel/adxl345_spi.c  | 3 +++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index cf4132715c..4ba493f636 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -62,7 +62,7 @@ struct adxl345_chip_info {
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-		       int irq,
+		       int irq, bool fifo_delay_default,
 		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 902bd3568b..51b229cc44 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -22,6 +22,7 @@ struct adxl34x_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	bool fifo_delay; /* delay: delay is needed for SPI */
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -199,13 +200,14 @@ static const struct iio_info adxl345_info = {
  * @dev:	Driver model representation of the device
  * @regmap:	Regmap instance for the device
  * @irq:	Interrupt handling for async usage
+ * @fifo_delay_default: Using FIFO with SPI needs delay
  * @setup:	Setup routine to be executed right before the standard device
  *		setup
  *
  * Return: 0 on success, negative errno on error
  */
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-		       int irq,
+		       int irq, bool fifo_delay_default,
 		       int (*setup)(struct device*, struct regmap*))
 {
 	struct adxl34x_state *st;
@@ -234,6 +236,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (!st->info)
 		return -ENODEV;
 
+	st->fifo_delay = fifo_delay_default;
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 604b706c29..fa1b7e7026 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap, client->irq, NULL);
+	return adxl345_core_probe(&client->dev, regmap, client->irq, false, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_i2c_info = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 39e7d71e1d..75940d9c1c 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -12,6 +12,7 @@
 #include "adxl345.h"
 
 #define ADXL345_MAX_SPI_FREQ_HZ		5000000
+#define ADXL345_MAX_FREQ_NO_FIFO_DELAY	1500000
 
 static const struct regmap_config adxl345_spi_regmap_config = {
 	.reg_bits = 8,
@@ -41,10 +42,12 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (spi->mode & SPI_3WIRE)
 		return adxl345_core_probe(&spi->dev, regmap,
 					  spi->irq,
+					  spi->max_speed_hz > ADXL345_MAX_FREQ_NO_FIFO_DELAY,
 					  adxl345_spi_setup);
 	else
 		return adxl345_core_probe(&spi->dev, regmap,
 					  spi->irq,
+					  spi->max_speed_hz > ADXL345_MAX_FREQ_NO_FIFO_DELAY,
 					  NULL);
 }
 
-- 
2.39.5


