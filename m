Return-Path: <linux-iio+bounces-13052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3411F9E2DC4
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F509B434B3
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8320C00E;
	Tue,  3 Dec 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQzqE9p5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96D20B80A;
	Tue,  3 Dec 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259200; cv=none; b=Begi3evEm1emBeZhK7nG7VznTBeqV0bbzKemQRl7gSXKqIh0XCiYmJGt0BnePCWwkR24gAczVNFObNmmZ5jkmaR7EICn0/C/FC3Z/VBfP7WWnAmbwS2q3MT1Uhh1OArg0B6hssw0P57O2xBCFWHNg7yT20FObxjTHjJf+tx/BMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259200; c=relaxed/simple;
	bh=xmZUynmRWNWKGnq7UcYg+jNu/xpT4i/K33pytjM2Xx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grnyGRNfFPC/CVpbkTYzS09GYzGeFzrXweMp5/yAJ1gBXX7oj59fZKSk30r5UPkqq+oafbuAogOKec12ng11oXyYZihY3Q325DqMi83yisDhNn1MruKkGUJZ/3F/JQbp14xY1WZVcuxm5WG/9Dgk7aTp8nNqwzaeSOMedlUIDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQzqE9p5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4349d25eb5bso5220575e9.0;
        Tue, 03 Dec 2024 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259197; x=1733863997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDuxrRBgTslcQZJKzlz1N9LrOE4h7D4sKvBVuQ6VaRQ=;
        b=dQzqE9p5uYL704b1f0Sasw/Fxe6+dVVw5HTOScGPtN69ZYHKjBsTu3Hp/FpCLh+XUz
         LDzxEKlCTtq2B/XvnU3uPbLrb28wCdC3yhIdbXhHLqgbOil6gv/0VoBkPjdTDn1tD6Qr
         wERZFP0uLFJDo0NDBkhm5bxQp9VsHeZWDIfJXkuQzRzHPjqv8ryXDFIRvl5Pudn25UIE
         w+B3ZTtGvFA2pagAhpqXYHALoS362Vb5KyD7cc5vVjIIjwNXo7m+BWJq8JH6RGyPy6xk
         sXYOHTdJ7F7pjyL5uvB84ECz63eATYM72hEB7Y6PqXDi3YSQ1cWAIbacu2i6mG545/BX
         Y1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259197; x=1733863997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDuxrRBgTslcQZJKzlz1N9LrOE4h7D4sKvBVuQ6VaRQ=;
        b=shfFHvFVe/1X0NJXKTw6xpaW8bV9FO/JxHOEmINN/qUiF73w0oNcFJaxrNuYAF91YS
         Lote3aPDB1V0AbXBSe0boHp7Il64CWnwEQqp0LHE+TQig0AIVLfcTu1awXTCCKHXZBGS
         FC72fS7rOPIICRkoLUTWWrQ8dYzV/u2+W6SV8l7ztDo8RWUwsZm4/pQIgTL43ieVgfRY
         ZgkTcJxMSvqK/XMW0aCOVifbYe3idpjD6FZlaQCvq5NvKtBQ/1OYKw6u1v6jxYmL79kZ
         kBvRW6nZIMhFMoOxHcv6mLhs5cEJgs7LeTBoiLtHS1/I413pfe8J+b8ZWEBb+J28AooU
         gOkA==
X-Forwarded-Encrypted: i=1; AJvYcCUGJ/2Zq3ITshPsprOUkIclQMmjtyGTF03kuFkrOERH+7Pe3YgqwGAjrIJf4flRrJxHtlaPZ1wyCAM=@vger.kernel.org, AJvYcCVLA+kJgADy2Mfy9kHw7S68vF5+dLJJFUVhRjJ5ppnrBsQ/djz/PhS+CzC6nI8bHwvH0gpm+bzXWL1t7mvi@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCx5sjgzyzaBBYsEUDLmG86GUQCqhciO15i4eK9fd4EFvX3Xc
	MktMzoF4BRPtINZLendv50pxO8n+qg3fkyo4P/cLmtbjoHF+rFce
X-Gm-Gg: ASbGncuj7xlu8z0EfXbAP6keqlPnlxSzm6Epm5doWGbp+1QljstT9CIEY6t/OedoKpp
	h7t0LsfbFyz0C1VhEMIJseVCvKuDESJeIMvqrMjNvseQf7ZzlLd4iViPZsdyhkR3Rsai4/9iMwU
	2jcH4lgW7cs/Mg7qrGoKDQHMikMkPOYaN9DV8SJx8LrVYhKxQGcv9Jt19tpaeBilUNT0Ie4mLRi
	3fFhBL3V0lzJomfAliZSxFnOZ0XDW1ocdBA76L29oomVqiwsJCDFQdMSeTaxeJ0bpflEk/Lo5Kg
	j0xo4aXT3litQxTbNhaK1irjcEtz
X-Google-Smtp-Source: AGHT+IGhwrPtB3Jdn0AgOUg68IG6L6rn9HZdnWNlWAUNaXKr9aCy64UakjwlY+xrlpMYwoS8D7+adg==
X-Received: by 2002:a05:6000:1a8b:b0:385:e16b:72be with SMTP id ffacd0b85a97d-385fde34e60mr1107253f8f.14.1733259196673;
        Tue, 03 Dec 2024 12:53:16 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:16 -0800 (PST)
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
Subject: [PATCH v3 08/10] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Tue,  3 Dec 2024 20:52:39 +0000
Message-Id: <20241203205241.48077-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203205241.48077-1-l.rubusch@gmail.com>
References: <20241203205241.48077-1-l.rubusch@gmail.com>
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
index ed81d5cf445..c07709350d3 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -127,6 +127,7 @@ struct adxl345_chip_info {
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       bool fifo_delay_default,
 		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index dc91b2dcd62..636b8ec48db 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -22,6 +22,7 @@ struct adxl345_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
 };
 
@@ -193,12 +194,21 @@ static const struct iio_info adxl345_info = {
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
@@ -230,6 +240,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (!st->info)
 		return -ENODEV;
 
+	st->fifo_delay = fifo_delay_default;
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index cb23fb11fcd..8c385dd6c01 100644
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
index 015b334e5b0..ec1773e7ff1 100644
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
 
+	needs_delay = (spi->max_speed_hz > ADXL345_MAX_FREQ_NO_FIFO_DELAY);
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


