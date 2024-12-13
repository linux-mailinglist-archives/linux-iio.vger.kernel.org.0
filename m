Return-Path: <linux-iio+bounces-13434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C624D9F17F5
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97FE16715E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B21E47D9;
	Fri, 13 Dec 2024 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbZyMkJt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB01A256C;
	Fri, 13 Dec 2024 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124767; cv=none; b=pWb0ODjTuttWP8RNfUKGjOP5TODR/PGhXchaHA2WBNMryxjwUW8NRwTE0aOh+HltxypHH4zmwxykscGQqZtP8ab7hllWWiOfTOCdCVvdpBWrU/orExDjSCNCVCamN9LTw3JRT4RAMVdxC9iQp4rhAoEaueL0kby1TC4Tg/Xv0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124767; c=relaxed/simple;
	bh=j5DGeUfnb4uyusC39IXORvfxvwnQUHOflIxNU4SSH1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSY3aSXqlW+LiLAic+s8zeI5gGDzbpQ5U8D9CaSmTEcxX7a9F1IZkNYl20OywtRjYAgQy7nRyYHaqWnWMrmbNo/nVfgYwyy3XIi7YnGd8r8VJwRrprWmguwhcOmOR8L3AA5TYEoZLX1CG7S6nWmZ3ThIzpRWgGyy9uhw8SY72EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbZyMkJt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e44a1a2dso226977f8f.3;
        Fri, 13 Dec 2024 13:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124763; x=1734729563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTNf16r333zqsw4HO/Fw7K3fX8m4wdYfwIGp1t2rbUQ=;
        b=jbZyMkJteJiJxkKeK3p2k/cJbhtoPd06LTA3pIRMMsm5RgUyqZSYDTwo1EnQEqUhk8
         8nU78N7D89xWiMTi9M+1nC9D0cfYwjUnpznmmplOR+M9HFPZ2UhGiRaBkb8FWBaNZCSv
         ZMcu17e2Dr8Y8SxRKumLA4AMd6TRmUlVAMxBb7+JRPCDPr3YJxWIm5b/Xc7ZZh210p0j
         WPA6QzQbz+tFiRXyvA641WfSlC2D1OUEaPq+ovD0VVOyPC58kxQ2JGORB2PtWSou9+yx
         WMnNIhxVt59DEye3rDTpPMBl9ciq1iDdsNiREB100sMNMLurdtD8mUJxjCYGJoDT4Uu+
         htFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124763; x=1734729563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTNf16r333zqsw4HO/Fw7K3fX8m4wdYfwIGp1t2rbUQ=;
        b=HxmJFKp+7lA4dLiXrjbCadaHe4sO2ZVU0FNcMhBO6+JdIJeK7alnYJB8D4shdaFujG
         9TfQybewVW/lGTbffRVmgF3JsfS6Otyg517oKDYkxceSykFZtr3w1Ux8idrn8eH7tJvr
         ajcsqS0xjAJmUXMmgFS+8S8ICNShr0fA3xIgrfRMflBRCDepKzcqWm3iB0/B7GYCam3A
         /alX0apEfB4juvnW1J9P91KucgjO4sbDUwXDtGJcsh0J+G86LMz2c8D99hkVkX+NZXK8
         h3WRHm+HXzGfRt5+hSQthsa56zZ5KxruakxTcLPCYLHxT4utdzYp6HBjW5ESQOZQ9ESI
         qQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUP6NSMpPBVh/goni5LJAZtwsLUTy6vZI5/H/1kSTaRo7KzF46OATdVIp0jRkOirZRZdW1gl6WNd4o=@vger.kernel.org, AJvYcCVk6h7k165j3hWMAL1dc7U9wrIIiHsyoKJnxRm7sy9yCyDp9Mt4dusEA3aYpTUrhgnpfAK2aIWOXYlrDMqO@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVw7k30gvtfmv4Fgk/wSCfScSQmhar4bjJ39kAMYOqpFhwXr6
	NVW46QPZpc1Vq2jCPpoM4EBgq9sLph1fiAkilsVuQhS2F5UcwvU5
X-Gm-Gg: ASbGncs5JNMT5KpNpq5wWAUTsxuxrzLG7bbGCS+KLTzURSfuy6CZtOTQya/7InL9wx+
	sHozX2QyTtWyDsznyuPm7PNEPY7AEkSHiHx9mkaLTWOIZhT8jSfkyZs/psotkrbUHWKhSAU0cXB
	ZOVgZagMWIwuuFCpSOR9NTPWJ8e7wXOBuQGSjCauVjoRuMp3ENBeT6gkayXd1fmqRqtRpqJdNXv
	P6F5Ok6NCCv5/VfRtpO0wfYTR822YtTcd1r+9eX/jnvcDP7Z0OyDydJSxnQtG7bVEua2hdilZZu
	wl+fL7RPoV+BRGCCkhqGy+HlrNUsS2qos60=
X-Google-Smtp-Source: AGHT+IEBDnbOwxQdPvaxvSQchaiU9PLHKL7smE29ee/gA4RxFYYhBFP70McK7tuJQwVUvDg+ZWTGvg==
X-Received: by 2002:a05:6000:799:b0:386:3213:5b78 with SMTP id ffacd0b85a97d-38880ac18cbmr1260180f8f.3.1734124763434;
        Fri, 13 Dec 2024 13:19:23 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm552484f8f.57.2024.12.13.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:19:23 -0800 (PST)
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
Subject: [PATCH v7 5/7] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Fri, 13 Dec 2024 21:19:07 +0000
Message-Id: <20241213211909.40896-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213211909.40896-1-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 12 ++++++++++++
 drivers/iio/accel/adxl345_i2c.c  |  2 +-
 drivers/iio/accel/adxl345_spi.c  |  7 +++++--
 4 files changed, 19 insertions(+), 3 deletions(-)

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
index fb3b45d99..fc4f89f22 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -26,6 +26,7 @@ struct adxl345_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
 };
 
@@ -197,12 +198,21 @@ static const struct iio_info adxl345_info = {
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
@@ -225,6 +235,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (!st->info)
 		return -ENODEV;
 
+	st->fifo_delay = fifo_delay_default;
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 4065b8f7c..28d997c58 100644
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


