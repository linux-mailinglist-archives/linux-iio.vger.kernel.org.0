Return-Path: <linux-iio+bounces-13124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CA9E5CBB
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2F6282BE5
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE16225771;
	Thu,  5 Dec 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfFWHvuE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D922B8D9;
	Thu,  5 Dec 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418847; cv=none; b=oip9GJmlp+LkAS6wop0EMfRkQOgtpfwIZx7oyxq9xEjn5s9xVk+uhs8HjzNl1o7t2NUnsuCy78RvHYGft32WbS/bhQmYXm+w5M6wfNsjAHUMnftMyIOphFABzdE3O/O9oB+4U+FLF9o62WgGN4l89c+jKd/BJmHUqNzVjFDIBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418847; c=relaxed/simple;
	bh=1JB2wb1ixUQ2tLhVrAdRSy7hUKQW2Tn/gK7Kv0OWlYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQWsa/UC2htIdAZ/KeJfohFm1jos16vUvkHQ/QSAOM+L1x9hJ4C1xXsreFYDEAxu8SY0le+/AyC5WCCXS1S8L9HI2oa7OFul3uJpGoL1lfaK6SwBTCZXcYszUw2LpPcEBvsBWcvRSMNW4bzmL2X6LkgQB9NjthDnIg0ABqnOjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfFWHvuE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0bdb7ea5cso154893a12.0;
        Thu, 05 Dec 2024 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418844; x=1734023644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNQM2De0uWsZzOP6u/2v236oC/9A63z8kL2Apq3LH5U=;
        b=UfFWHvuEBHXjwZ/V5s0WxRcH2opkbdtzGCnDxkLsmDTSzLAbxcRhNzXhDwkcv5c9oP
         3FNE4CiITqpYa4gfFL2LG+dPVlE1e/PHFWQh5gTXQ9Z2hktgCWpPCQaUE1jGaiIkpiI8
         q0AjOgTPsELj/2k4ow9+fkLv9wz0fe2aLSu6N2Px/FQQYW9cbuiW7xjcNv8rJjBdnmaH
         FJnmKqJIrrPhUJd/J53DFIbMAOyOjx9z5TZtZ8es/K4MOhABME8GoXUyAeALtWZQ/Ed2
         skU1gA9Opx9DszsGK35yHGPh537jvfzDpDAa6LKfmfJXVVS+NuSCohuQXPRyw5nVl84y
         0kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418844; x=1734023644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNQM2De0uWsZzOP6u/2v236oC/9A63z8kL2Apq3LH5U=;
        b=rVbeF2w6PDS0zLzz0Cwvdm99/Ki+i3rOvFfzgqVuehmB0o2Sws52g1/wWL0p7zxhki
         0O0ceM4/CVppnTrP4ScZoMbQ1d2bLoVNyyiWnLDAe1/lB6S2qgiYk0HosON1TQk81yGm
         TxbvraBG2aUnVFBh3Kqi56wsC+NFOctSiayEX/0hD4LAKZtjO0QS1CU2AWJ+rRDX733l
         6ELTUh3YVVnCi9qPwF2CQakq1bvxmZwApFVb32CZaJxOS/Se7UAA95nNYXTCcZcttYXA
         Zxd/ip/CTobFGaiVXgJ78hmrzjk/SdlOWeb+OSIDsAoospzXXzLgF2QZsgyh/yOnIKjB
         G2bw==
X-Forwarded-Encrypted: i=1; AJvYcCVK3hYW6cXdZxIUqDa0HsSF8prkTwn1j8J6os9Y0ENKqknuD+yIvBvS+IafSGznjkKj7YQF3BQ6WZX3Ciq1@vger.kernel.org, AJvYcCVg98Y11MOF5464V7cEFznGtG7btsUiNe0CNC1VdwhfGj7Hgf1hFC3ibwgR1RtBNmaG3Qf+GLaltQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhkCEIqPBG26a23Jktok4YlsLQkvxalE7+b2dTvpH9pA7mJzL
	PxmufFCqT/AlC9ay0sUKxkxhz1BXP7Ya38kbQKmO/r5s+pfJ+Lr8
X-Gm-Gg: ASbGnctZoHIJlct9qOllrmGCt5B5IuzEE19J3ZuKbFsJpw6ygrDNBSJNrQLdL0UNH2r
	w9NkJ4LX3GHn7unciZE9aCOmWKl1YnSsPMuVLE4Mdo+G5O8B7PwH7srAgqmPPvWnAtlRiKFDTjM
	PhPeXpuUuczQ5mUsj9ukMBY1Zf8Nw899CpsaPpgrufaRZgZIE1GDonMe3ju836I/gMGUvBsoPkl
	+NwTwysLd72tI5LnZhdVKVMSOLM9VYn4h7+tx9xblYMrLlC7R6vlmkmfW42ZHH+cFVE8RwU3aUK
	6XA2Cieib8Ge4stET64+4sp9GG/o
X-Google-Smtp-Source: AGHT+IGq4lg6H7FLfQErxCEZpDhhsul+87GsgCeZ+A3HHj801HBO8Wz7dmM0P4nit/lDz16rSpbnkQ==
X-Received: by 2002:a05:6402:26c7:b0:5d0:bd3b:b9a9 with SMTP id 4fb4d7f45d1cf-5d10cb99b97mr4068454a12.8.1733418843531;
        Thu, 05 Dec 2024 09:14:03 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:14:03 -0800 (PST)
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
Subject: [PATCH v5 08/10] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Thu,  5 Dec 2024 17:13:41 +0000
Message-Id: <20241205171343.308963-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241205171343.308963-1-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
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
index e0a8b32239f..0696e908bdf 100644
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
index 4065b8f7c8a..28d997c5860 100644
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
index 61fd9a6f5fc..9829d5d3d43 100644
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
2.39.2


