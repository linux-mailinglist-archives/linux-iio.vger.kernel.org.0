Return-Path: <linux-iio+bounces-12276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6F9C95DE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63042B23578
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFCE1AF0DA;
	Thu, 14 Nov 2024 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivrb82qg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195191B6CFD;
	Thu, 14 Nov 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625825; cv=none; b=eSYKYIH5kvQbRiHiNxr+PoGIi02PgMrKRdRssEtWnEVZBx4vfEEQrrNSrLinb/fWCU3wPGDIzu0izJFkxDOJCJcx5QUcbRuCPAPUc6TXeDNu240GuAF8RHqTbyv++KzSSkRQrCanqsew0Dah//hAXKMgH2E+h6nnlYwIZ+Kdxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625825; c=relaxed/simple;
	bh=/tlYLFbF5U0jBlu3EZcSiAo93PeJTn0dkOQHzGrZgw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFzgZ6B0qhxYX49TUKbzRmhhOpH4/otGelbD4LEMXPd8/zCNiS6BPfsrRyNwhRbQK/5jFxF+M5gZos3phn+c12W+3f5PvQV5OD5WCi1NFhDNEmbvA7xVAvFZwk4elOfSw8znzdKaiELgpjgPcELrvKpTJA7uXhPKV08wLoorcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivrb82qg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3821b30684cso78824f8f.3;
        Thu, 14 Nov 2024 15:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625822; x=1732230622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nQfd9oBiFTMVAk4ml+D0pBoUO3sBiue9pIvFVoIsxY=;
        b=ivrb82qgcj3h6y62T0sWG20Tck+Bsocvb2cN4XYilhP+Fo+rCMP4xIcnFjbl+Lo87F
         efFJnCTrmhi1+vrG10gHgn9wGWoCoOh7NN6sWOjb10MS1zpq31GFCmK56/whrPfd26Yo
         eMyNQ/ZrGTMg7C8Gucx9/k6A8mVPjVSpcAlMByCfmc01IT/2bWBTmnOko2aOnxtRhHjg
         7vaCAxl4c3NGxGd/VZbwN+64ELDNZxbwlrZ0PB6whhMlXJcBlUnULNl8uv0c5MA2q4jt
         U6pA4Ibw76HNOFoF84SPMhx9ZndCuiqBETZx8gTPI6ywWDNpMJhA+p5O8sY6C0zj/yba
         tfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625822; x=1732230622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nQfd9oBiFTMVAk4ml+D0pBoUO3sBiue9pIvFVoIsxY=;
        b=mFtPAkJ7fSo7i6Kfc5G8PWeeZcj6tIOY8lZIeAVnFfC8t+UmWJB/bK0tuQpm1qmTAA
         2RS1YiISlawvfG221IF4uRSDGnB7sdPEhZR0zrHKGv1oDhmWWZDsgEM5IUs6WSVvqO2i
         qiKkfjoVj5j5rXtmk1RHFsFLwNoc1TAZPa/TP37wAPNy76gkdS8qoYLCwpA8VV5V3Sb9
         01bQD7wRfbEYcvnvALqVrjLQt2P49WxSzXx23/TUhCixSknbTekmqb0p+hfpXiOk7Whn
         VyX17yZ+pbqfLzQY8vVFytm9+S5zsXVc2LJZydX6ZzmT4EEm1/CqjuiUejwvJoh1pqCo
         fKXg==
X-Forwarded-Encrypted: i=1; AJvYcCUjjS0yaCyf7/FPm+WYfOzfLj756fky42PPBWT7K4kBoH6IkmRpglDWqLbQbhsFI2463GGBNXEBwigpKtHh@vger.kernel.org, AJvYcCXlTt4OLhXcgqJi37rmCmIC8HG0Cv5LXZIOvXcMTS0wYfeGL4/8m4dfOFYdV3rKT/3ba3ofxg6O4L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwit++myfysxX86BEMdvFe/o6cNxU//JQhj7cNQyW/3rcX2O2
	Uyx91CG1o+BUXEAQew6dXzAYN6l6i4ElP5P3SRsmETIgdsd4TSq+
X-Google-Smtp-Source: AGHT+IFn3QBADN+EayYdZk68AeKItCRkqrPOgOoeOilai8nsnbbD1w8ngdKT7stj0dgA/GpydAkyVw==
X-Received: by 2002:a05:600c:4710:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-432df7878bcmr1569915e9.4.1731625822289;
        Thu, 14 Nov 2024 15:10:22 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:22 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 08/22] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Thu, 14 Nov 2024 23:09:48 +0000
Message-Id: <20241114231002.98595-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
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
index 57bc530cc3..ef3b7d9fb4 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -22,6 +22,7 @@ struct adxl34x_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	bool fifo_delay; /* delay: delay is needed for SPI */
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -197,13 +198,14 @@ static const struct iio_info adxl345_info = {
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
@@ -232,6 +234,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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
2.39.2


