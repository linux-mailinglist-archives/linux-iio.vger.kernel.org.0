Return-Path: <linux-iio+bounces-12350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D89D050F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D821F21B56
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1CE1DAC89;
	Sun, 17 Nov 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCGlbxWI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EC1DD0C6;
	Sun, 17 Nov 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868105; cv=none; b=hd8CH9HQvRiBNGR6wd1ozh/1dQWtVncz9FaiZN9uvZoNwK8yDGojox7bFpnLJPG5Gme9uX5sTXZ4cw6CUmn7zUjw/tq2Gz6lgfoeas2F8lpqWXm2XXCPJ5FQORrtj1zwL9PZn5VYK9XaBbryguobse/cGjHPWnlYLkPmkLinqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868105; c=relaxed/simple;
	bh=Cd2tBZUuICf5FU5hTwdZ9b6RrklaSTv0sQOo6W4hS28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OfJ+hjTVRude/KOXK7vTg+SbUTqO3TDVd14p9D9X828YrnOCgcBDN0/fZdmkAcwtR6YtvsnX1DR/5G7NQZMeQI05Nue1aWqPpvUMGVXRRVhmerFbCchVUDygaX7B89A7ajpLlslCzwJec7a4hKM55UsJWI+3vyW5KmRd0J+Kze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCGlbxWI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43159469053so1867395e9.2;
        Sun, 17 Nov 2024 10:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868102; x=1732472902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KDSOkAKN9bBRfuUJxFrsniHWtfVPCBalN3GkkFmvHU=;
        b=aCGlbxWIff6o47n9D8jrg5oRkBwSorKg/rFMwr60O6uLHrSosVspuyrBa6mGhKIN9J
         GDxwXv1nLeYSl/hFrmzZ9vptMC9E6S7kN9bcfhAbT1PWpMk9rBDOZJAuztmAlajO+J8U
         HkOEucldiM2LDuxZu585xKVLaxdbVRR9k65oBk4jCfaDF9Cw2KhAT+YeivYRvv811tOH
         uYzzyzmPCED35aQf8i2DBMe0d0/YP3swv9R0ZivT+BruBq8HPz/glvwrcA1Go6pGcZxq
         GPA7BPhab8cxXORhxkVDxAHVvp9Qjh6rIRgwcp38LYp74R3vMnIS3YVCpV//B+NWohP5
         0++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868102; x=1732472902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KDSOkAKN9bBRfuUJxFrsniHWtfVPCBalN3GkkFmvHU=;
        b=WCGioxBbomKqVyUZKRrzQe+osKy5YNF0aF9fsoQD732TmSu5jt1jNTMGMDGfsIUiaF
         r8JMJs0P0oYuIF+pXVy/xE/OPgB/6bP5bi/51kFC1CFW9Q5n81MOQMmldxHAd1SWFNgt
         UjZvgPrgRQvsCmNZdpIH0ygdzD5imk1BaKZF2IdLdi+rp3PRusNCMIPQ+BI1h6XzFVwE
         q8DvBb50RDirXSdMWb74vVic9mDDqAfzdfaP8d95Tdev4FyEj0PDJ4sXVy6xbdgeCEun
         p0pZeEXlrDMcNDlWjSO6qRnIfsdhtvghUQa0UTik9pxLmcLljhrA6Wq2EfZdkrQTMrcE
         iKWw==
X-Forwarded-Encrypted: i=1; AJvYcCVqOr9TdjYk+uBnekP8JmUy151ABeYNih2Wd6kKmA4r/T8johz/zRv1cgYbKAlss0KThSs/pCT3S5vCkHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLsWA90vPdAQDLCbS8NJAIPFz8cdKqFlNRnZLZ099BRQRbg+Y
	rtEH+ngxFhrA6T+JyQLnkrlCFrq/alw+ZK/N/HKvj94vfWPo1BSQ
X-Google-Smtp-Source: AGHT+IHl2ZvOA71B3I+0fttI5e/0p7cmfj8FDx0YnNMQ+reLKTgTiipO6jeV9z3JbDW1Nn4wpfJZVA==
X-Received: by 2002:a05:600c:4710:b0:431:558c:d9e9 with SMTP id 5b1f17b1804b1-432df78ac1bmr35727395e9.5.1731868101646;
        Sun, 17 Nov 2024 10:28:21 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:21 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 07/22] iio: accel: adxl345: initialize IRQ number
Date: Sun, 17 Nov 2024 18:26:36 +0000
Message-Id: <20241117182651.115056-8-l.rubusch@gmail.com>
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

Add the possibility to claim an interrupt and init the state structure
with interrupt number and interrupt line to use. The adxl345 can use
two different interrupt lines, mainly to signal FIFO watermark events,
single or double tap, activity, etc. Hence, having the interrupt line
available is crucial to implement such features.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      | 1 +
 drivers/iio/accel/adxl345_core.c | 6 ++++++
 drivers/iio/accel/adxl345_i2c.c  | 2 +-
 drivers/iio/accel/adxl345_spi.c  | 8 ++++++--
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 3d5c8719db..cf4132715c 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -62,6 +62,7 @@ struct adxl345_chip_info {
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int irq,
 		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 81688a9eaf..902bd3568b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -11,6 +11,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -18,6 +19,7 @@
 #include "adxl345.h"
 
 struct adxl34x_state {
+	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 };
@@ -196,12 +198,14 @@ static const struct iio_info adxl345_info = {
  *                        also covers the adxl375 and adxl346 accelerometer
  * @dev:	Driver model representation of the device
  * @regmap:	Regmap instance for the device
+ * @irq:	Interrupt handling for async usage
  * @setup:	Setup routine to be executed right before the standard device
  *		setup
  *
  * Return: 0 on success, negative errno on error
  */
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int irq,
 		       int (*setup)(struct device*, struct regmap*))
 {
 	struct adxl34x_state *st;
@@ -224,6 +228,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
+
+	st->irq = irq;
 	st->info = device_get_match_data(dev);
 	if (!st->info)
 		return -ENODEV;
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 4065b8f7c8..604b706c29 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap, NULL);
+	return adxl345_core_probe(&client->dev, regmap, client->irq, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_i2c_info = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 61fd9a6f5f..39e7d71e1d 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -39,9 +39,13 @@ static int adxl345_spi_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
 	if (spi->mode & SPI_3WIRE)
-		return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
+		return adxl345_core_probe(&spi->dev, regmap,
+					  spi->irq,
+					  adxl345_spi_setup);
 	else
-		return adxl345_core_probe(&spi->dev, regmap, NULL);
+		return adxl345_core_probe(&spi->dev, regmap,
+					  spi->irq,
+					  NULL);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.39.5


