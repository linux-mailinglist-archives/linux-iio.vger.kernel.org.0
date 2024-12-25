Return-Path: <linux-iio+bounces-13802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3F9FC64B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1D01883363
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFA1CEAC3;
	Wed, 25 Dec 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFq0+yQ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFE1CCEEC;
	Wed, 25 Dec 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150439; cv=none; b=kUpc2Zze758DXQbfVJqmxkiy2tycFxm3L8IqsZVXcDyt1NDeAHmtjQexv3rdNvZn1X7lbV5iayVfCbnR2jQLtyeqpGrmjwNhXh/xrIrgaE9xLIj56cpI0b0Yw+ipi9sm8TOtsfdvrzjq4xwGkvgKeMzDspUxQgsCwXFNk7SQrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150439; c=relaxed/simple;
	bh=UBP+XEB54+kJlSKCmzmGUC96jClchIpxCRoyT7H3i5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESbNMkr1AQ03/lMyTYz8NhS2X2iQYw2KVcDVUSrx4bI3qSj4q0ug3MhApOXqAokuoPV9mIDBC8uAvFU/3HRPGxg3VdxbZCGtfxAQHdENI9YtmbpBabKP3702ZQxocD2a6CobjKtZkhUiMOLUpdk+sSmFSjNInRA+DKn5wcqf2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFq0+yQ0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3cd821c60so1074484a12.3;
        Wed, 25 Dec 2024 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735150436; x=1735755236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=965nGCTrHAcWPGbVo5B4WZKkBPA60/xdYIjri6d4Rd8=;
        b=CFq0+yQ050gdCQGGEk/ZWkHkdF0iun+atHr6p7e9UZY/9ObK9xOqVgfwkossfNSY3/
         WZgwCnFHQjUsrwhC3XJnON/KTdXsyrK5i9xwburmNlS0rg8BIC/YoxUvVh4dkOdd7rWH
         qNkqKzWWu+r8tc88FTcpWpqhmtaP0CcqCBr4ysBrJt+uxVtQ+UJUL+qZzvrnpXOufd+Q
         DH/YYxnYItyIlfbq4eaq5KiiOdSE+WJb054GRLYP4+Ye+Nc0ja5SPdme9SbCeUUM3tJ1
         /mU/jsvdMMBBvkCS2vy04bVONU1sG1dKcvJdf4lzdgi2oT0/0AtR0U8irdUmOCFQbgOD
         geaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735150436; x=1735755236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=965nGCTrHAcWPGbVo5B4WZKkBPA60/xdYIjri6d4Rd8=;
        b=Gw4cXXYUfSEOV9qJAOdwk2c6ugu2z3zTy7JxGWiovZcBNj8oPZ6RE78pdw/5pwW92v
         wjIsWb095435WRxPP3Te95pVsqQPvsiHes2xn3PxJmNIEQdEf6PE6MefePLPKAFshvys
         wn17Bc/wAf5t2onHGynATVPIk/rBwfYoK/jam4n+HSLKZMchaIuiMJx7Rmg82irY8G8D
         h6g8vvqGerNes6Zro8jI5eFBauWGYWD4IpYXapY3ErFXMmtdUUTxg1PvF/LMuZJS5Pyp
         WeSJiepqkXO0Vlmj760mKaze7RWoTw+HIzmqjeUs6aWv/V+OjBL3ax7VrWysh1X36pJJ
         BRVg==
X-Forwarded-Encrypted: i=1; AJvYcCW1K4eZFYQQ7PUMMDV3bmym6xLOVuwhmuCpuNePMnoh3/lN2uUSEV1RUKSsrhief1eZxxCFBdAErXY=@vger.kernel.org, AJvYcCW6EZvFe6qcPuMyQpWMY1RO9nHO+KSwenncmcKXLX6E1XQjtM9Zhyg7zD78RcQHLqJhfHerqX7xnbpSezt0@vger.kernel.org
X-Gm-Message-State: AOJu0YzEz3x6Gf03YRjQA7sFZ6Fla8VOqiE8ZcSA1d/sQ78RnzJFAKUB
	vtN2i89GA3ApdQ0kBSwOzSj+kc4H+A/MvvzHOcE7ADYoTugKQ9F9
X-Gm-Gg: ASbGncuMmXEyU2xCOBU/GeMQx04j/U8JYCqGFCOg+2OClMUarpttVmyw8t9ACJr3Y4O
	yWXld+8GZJP1HIikpYelIaqrur+5CC4w8LV54N/95ovObE9oPLq8fdYPv0XxrUzpluxGIgKJ9Ri
	kcVv6SCtSTa/IZV/SqeVC3CTg5oJ4buiIHiOt/FQrWS1Dp9aL/4OYfr27ZG4LLC8G5dXgmRrU7A
	IrwstcPzcKdJf6o7Fq7a+QWj7YHNlPlJVgBwXVk80Qj9fWkh4G67TSVO7A+955WPGxMNH/+0lh5
	qmFS1CmYOXjZCbBiiTgfExWvA2v1SSFuO2E=
X-Google-Smtp-Source: AGHT+IEIH/+X+6n3lqk92gTsUZz0db8l+wPwkfKP0Q0O4SeQYuWSVG0Fnuex963FPWdv8YjL5zvNQw==
X-Received: by 2002:a05:6402:2695:b0:5d0:eb6b:1a31 with SMTP id 4fb4d7f45d1cf-5d81ddacfa5mr6260036a12.5.1735150435807;
        Wed, 25 Dec 2024 10:13:55 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm7721141a12.88.2024.12.25.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 10:13:54 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 5/7] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Wed, 25 Dec 2024 18:13:36 +0000
Message-Id: <20241225181338.69672-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241225181338.69672-1-l.rubusch@gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345.h      |  1 +
 drivers/iio/accel/adxl345_core.c | 11 +++++++++++
 drivers/iio/accel/adxl345_i2c.c  |  2 +-
 drivers/iio/accel/adxl345_spi.c  |  7 +++++--
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 3d5c8719d..6f39f16d3 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -62,6 +62,7 @@ struct adxl345_chip_info {
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       bool fifo_delay_default,
 		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 134e72540..987a0fe03 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -25,6 +25,7 @@
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	bool fifo_delay; /* delay: delay is needed for SPI */
 	int irq;
 	u8 intio;
 };
@@ -196,12 +197,21 @@ static const struct iio_info adxl345_info = {
  * adxl345_core_probe() - Probe and setup for the accelerometer.
  * @dev:	Driver model representation of the device
  * @regmap:	Regmap instance for the device
+ * @fifo_delay_default: Using FIFO with SPI needs delay
  * @setup:	Setup routine to be executed right before the standard device
  *		setup
  *
+ * For SPI operation greater than 1.6 MHz, it is necessary to deassert the CS
+ * pin to ensure a total delay of 5 us; otherwise, the delay is not sufficient.
+ * The total delay necessary for 5 MHz operation is at most 3.4 us. This is not
+ * a concern when using I2C mode because the communication rate is low enough
+ * to ensure a sufficient delay between FIFO reads.
+ * Ref: "Retrieving Data from FIFO", p. 21 of 36, Data Sheet ADXL345 Rev. G
+ *
  * Return: 0 on success, negative errno on error
  */
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       bool fifo_delay_default,
 		       int (*setup)(struct device*, struct regmap*))
 {
 	struct adxl345_state *st;
@@ -222,6 +232,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->info = device_get_match_data(dev);
 	if (!st->info)
 		return -ENODEV;
+	st->fifo_delay = fifo_delay_default;
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index e550bc078..eb3e0aadf 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap, NULL);
+	return adxl345_core_probe(&client->dev, regmap, false, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_i2c_info = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 61fd9a6f5..e03915ece 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -12,6 +12,7 @@
 #include "adxl345.h"
 
 #define ADXL345_MAX_SPI_FREQ_HZ		5000000
+#define ADXL345_MAX_FREQ_NO_FIFO_DELAY	1500000
 
 static const struct regmap_config adxl345_spi_regmap_config = {
 	.reg_bits = 8,
@@ -28,6 +29,7 @@ static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
 static int adxl345_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
+	bool needs_delay;
 
 	/* Bail out if max_speed_hz exceeds 5 MHz */
 	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
@@ -38,10 +40,11 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
+	needs_delay = spi->max_speed_hz > ADXL345_MAX_FREQ_NO_FIFO_DELAY;
 	if (spi->mode & SPI_3WIRE)
-		return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
+		return adxl345_core_probe(&spi->dev, regmap, needs_delay, adxl345_spi_setup);
 	else
-		return adxl345_core_probe(&spi->dev, regmap, NULL);
+		return adxl345_core_probe(&spi->dev, regmap, needs_delay, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.39.5


