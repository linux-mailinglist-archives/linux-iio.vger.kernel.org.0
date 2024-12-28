Return-Path: <linux-iio+bounces-13850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCE49FDCA2
	for <lists+linux-iio@lfdr.de>; Sun, 29 Dec 2024 00:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DB63A14EA
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D5199E88;
	Sat, 28 Dec 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z06gABHU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B871946B8;
	Sat, 28 Dec 2024 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735428604; cv=none; b=n5Mvn9uabCRrArBtTB9qzofPHgHABlXGLjsetH2TfOUtTa45+Ainl4xulSBPEzPLomvybDq3R7nrVegwcc9Ofnj499GmoRWorTyS+ttWTk+YJr241zwLFktzyBID/kFsUu09dDd/bj3o6yePpffR1rKauNuJIMysUAw+O9cLUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735428604; c=relaxed/simple;
	bh=UBP+XEB54+kJlSKCmzmGUC96jClchIpxCRoyT7H3i5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prjZbGs0vXehH12h/URkP+MKtJRLDAzMZOtzWIhl2fpJXUyfQzITYL6AEeheyUTwQ2dRgNRjUHVeXyXnlYin92QoWYTf3+/XvEqGog/6ShpT7xjWEZs+qrknvr1mrUJJnh4Wk4xLUIcgmyqc3cQFLWqTD8bQ6yNg/pAT7qakwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z06gABHU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6a47a3da3so149403266b.1;
        Sat, 28 Dec 2024 15:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735428601; x=1736033401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=965nGCTrHAcWPGbVo5B4WZKkBPA60/xdYIjri6d4Rd8=;
        b=Z06gABHUdtFrt+XiD3ypo+dOdWhiTl80myKwV0RlrchnD6RyfZJG7HlFwFX/hAtR3Q
         tdwZBOSKD4jP5QsHsd/7N0ubyJoqcGbY30Um8ZVz4umE4hFN77hIGzAy1m0wXDVI2kZh
         VPAdaCd6HKuKB5chjWwzs5stkUUg5keg28qrfpxBh9d5XgG9AvV6ZlhnxAD6Ut2C+Y1U
         NugDMtIdimk1as8oJ5aZCSUxdpWGQEZ7TihKZROZ9U5fSU/St1TuT5EzwWa1EdQWv1t0
         lz8+Bt0FdXcEbb4VAosuVmU3I9nCLFL6EnF1fmfOnIV3sNdVuXfoU7DWkdf9vE3ULuMG
         BsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735428601; x=1736033401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=965nGCTrHAcWPGbVo5B4WZKkBPA60/xdYIjri6d4Rd8=;
        b=Y8a98KlmuR1/Rq03+24eAa1IEGSOqUqzwVC7NyQIidw4J9acBtR4Ku/pxPPktHo13S
         zVIH20EmRmfnhL6SSZvLEfl/0XxQBQmuVQMPnEww/xTNoGfHH0ofZ3XRXe/HefYFuZJF
         mmZs8ur7y87a84Z08yb0YkC4kIBRnA4XEPUJVaXQpNylnPfYH7x/sGZN+lL4/tCjR+Df
         jGaQmc66GW9LJgkQYs3NPWmHI1GhKbFRIn9jFgBvgTD7HN8KCdr0ZpBOqOZ/VqlUFU0s
         A7vIXXvN1GqSxOm5zVyI9lYM6sofYQMvLD25gUecCbyRsUwOZpVbJNGR56ftqWnG94xN
         LUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdgkFrVBTGXp292QlDaZUDuWlJCIik+bMO/V/KW9rNKrWSJjpjdcGKLCit7l2jLqmuAQoCybog7gkZuLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Vs8wGHLDCllTzPseFejCVJ+YHebO4UdodECP4qSLz19r8OKn
	pe2+TJCvI/CHrelB0XMZ24HTDSE3kDYUth/CZhUHjPErj7KbDasB
X-Gm-Gg: ASbGncuz8XRL0QQdqwbi7qg5jrHESnf8tH/4n9yoOMipvKitkdm5AGOVoUvTiLqHW11
	6leA3Ko+Y5p/6EXwyT6XVdUfDMYDUu52kE15Ct+vH0YYzV88hsbtb8SHH9lpxlSa2HluRj3hDk5
	OsCJkpKG6R0K6ZJ2UgLueYzH73cxZRocv8Wqn1IRJ/nwR+E4IwYe13GRdZ5ElFDUDLjnLpVO010
	jlpeuvk6Mfcv2xLxwxqWKK8Fn0BKVEzopnuGyJ0onOoGgeTtDGGgVvAtcizk+2phCDLXytb+UvP
	8o3D8FHc8j+DRpZr+nsYGp+15bpl2ZNahGE=
X-Google-Smtp-Source: AGHT+IEoLI4GfiaywvULk+9GKv3XjAhfOdFro0xrzmJ1zZiW7qpchEx8fNJwJDfgrIE25yVXeYvXSA==
X-Received: by 2002:a05:6402:2790:b0:5d0:e852:dca0 with SMTP id 4fb4d7f45d1cf-5d81de1c377mr10807347a12.11.1735428600937;
        Sat, 28 Dec 2024 15:30:00 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ac68sm12635156a12.78.2024.12.28.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 15:29:59 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 2/4] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Sat, 28 Dec 2024 23:29:47 +0000
Message-Id: <20241228232949.72487-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241228232949.72487-1-l.rubusch@gmail.com>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
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


