Return-Path: <linux-iio+bounces-13098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6EF9E435F
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6EA283061
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB862066C1;
	Wed,  4 Dec 2024 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoJ4basF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76B202C35;
	Wed,  4 Dec 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336717; cv=none; b=Jyzv6XY0oNG2ip2qBnswnsiCl3VzvgQNg/hwkdmG3TRA5nNEwPplzIrzeWjenM3mT9VQ6QOKbcfhgWWwn9xVr0xcLEtlOgl62a76un83x+2bBm5u5ajUiFaj8WKDzzeF4kuMcQXZnae9zEigrRcDB81QN/hdRjz7OIAA9SsFZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336717; c=relaxed/simple;
	bh=1JB2wb1ixUQ2tLhVrAdRSy7hUKQW2Tn/gK7Kv0OWlYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=USFuXxgn7xK2TT5LPnlfQ/5d0AZiuu5Jna6/Z68+FihHQhkgPNkrHg/4AeXCKdl2PFTVcSIyBOvVzwpFi2nOqF4gaEZAvB+fhZvCcCq3dA2HIBlnbTQA94Q17SIaZhIufGDqzx3SmpdHm0lK9Icixjp98r8FfxgEc1gV3E5NVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoJ4basF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a36b82b7so90485e9.1;
        Wed, 04 Dec 2024 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336714; x=1733941514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNQM2De0uWsZzOP6u/2v236oC/9A63z8kL2Apq3LH5U=;
        b=FoJ4basFxZ+WIAo4uXdC62+WFbq4fsFx0+6/0NNjB5ByLI8oi+2fi1V8Rcz5cSF/oY
         SjFQd+M2/3vzQAT7ewJWNMF6xsOyKmmvqs96ezsnke9O7TfB+L8gkW4f68Ls8NJpH2Mi
         bAQ72jA6Tw4BqrOtABcE16K3dZLHFbSK2Uv+C7Xbx1G3njDPSBApJB8SIVDRXHLgy6Ba
         /KF2CNb1OhMXco5/RPvxBvrUFAwYGSjWyuCbDRGEa9Ozf1zPkh9LsANmtmIYtg486KoI
         BuJ/NA8EfeoF0YS5F1lvKLSZWFLUL4xHNJ3vGg7ITObJ0HN2ib5SZ1ssni+/5dSsil9E
         aPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336714; x=1733941514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNQM2De0uWsZzOP6u/2v236oC/9A63z8kL2Apq3LH5U=;
        b=WX+sKxU3veqe+fJTipGxvOaQRXSII6qeeNTK3E3gqGmT/Wd9heMBoo+wXqoJp6Oaus
         +/fkTIxs0lruloQSd/L8dOQxenCoX9U/vu+AOqLqNMkuCF4Wa6TFIO6bWwvQZCu2n2H3
         e2RFUtRJFtYpY1AKnBibcf+v7GLjRvpAU0EGD7yX9yGbKzsROOTP40QMQ5dHKBYAmwSK
         URZRuyUkZJMwMX87uhrtKHpPV6oO4CEGf5zFgwdfdPIKgYDR6sV16umgtjRwq4YzCOzK
         txkO1KYC1Mjx5xs2qOZ1cZaNu5sef4DqeHeA0vvfM1VR1cpwiT3sixswo9RjVUZHff4a
         iOHA==
X-Forwarded-Encrypted: i=1; AJvYcCVsD9wkTrhC8qXvUKXXpyV2s+IIJ68dKbGk0dG/X+AytF7QMLpz28IKYrL7S14k+F1Ky0fv2q4ZYl1ul3bz@vger.kernel.org, AJvYcCXhyEIKAR6GMBpD6vOpkxeV7mjEHiqgE0rToxoKjg+CQlZEZdig0zGk1AREYG3QivwpCp4xRrFP9p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVCrMMbpITafBpZ/GFlvPSXCR2uc162sn+ksX83eXuiwQvFvw
	pCxS2mIjTOhq47yvShr9nQwCKNcJ//OrVBO0k7fRvjJMwGz+tmlO
X-Gm-Gg: ASbGncu5hujKtTkJXV9jiXMG5Bz+6s64oYg9Gbejvok4N0yR6Tq95sFHZUATEWpZUWp
	tqdlc9wLK1aK4pgUr0ajq6jInieXavmf5s4OW2WDoMj/ckWrIVlvPPzoBffHSaNtXbI8y5kcIF6
	3NFzMbBJahsfJTMG5DZnlXYt8hj0Bcw7A5lasXA+1nvPoSksnY5H6k0CBuuikbUKkyrmLIC2AW2
	9r+7vWqEwjaEJ+xKAjjZKv4Eiqwio/9ROTunTIScYWg/iYbAMy6KkkzARsqPqBF5fNpNbv88kdc
	sm7GetDJuzF/jE3FhOIc6jcOlKNT
X-Google-Smtp-Source: AGHT+IFW1FLYDpdRtB5tR/zp4nXMF6Gn37gIcoA5IgJjlA6tw3LUgBIkGiAgCISOrgI9G/Rng48BPQ==
X-Received: by 2002:a05:600c:1ca2:b0:434:9d0d:1347 with SMTP id 5b1f17b1804b1-434d0a03f25mr26595175e9.5.1733336714339;
        Wed, 04 Dec 2024 10:25:14 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:13 -0800 (PST)
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
Subject: [PATCH v4 08/10] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Wed,  4 Dec 2024 18:24:49 +0000
Message-Id: <20241204182451.144381-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204182451.144381-1-l.rubusch@gmail.com>
References: <20241204182451.144381-1-l.rubusch@gmail.com>
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


