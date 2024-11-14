Return-Path: <linux-iio+bounces-12275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F396D9C95DC
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E621F22A07
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222E1B85CB;
	Thu, 14 Nov 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0cet28v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317491B652B;
	Thu, 14 Nov 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625825; cv=none; b=qZCklLzbz4kZuH3wpwkvVepUmEPbrnEh5V8obVHpsgXmUrypHhhvbA73/DULXdf5jmFpsTQM5MCAw5AS9/hlMMn+rlm1kMUg9uM1yUiW3D2wqDBc70vF4RfzlKrqcnp83HIDePOsjBLLWgfXDZapbXw+ZIu/xR9QGRJ3NgWEx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625825; c=relaxed/simple;
	bh=P6fP/53q4Y/fGhQc7znhU6vSxa5i0hA/JOshgdNgSSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtRYv23C4+JVOD3lNcg+RpPwVxGv1AbxNywNl8L1c8z1cOoXCBjW83M0+qVbKGWLKQT9p1X/4Zaczv/7xC3vbeTyLt+5EIxWrZX8Vft4/uFuOdSf3EYrxeYI1G+GENaqYBr66bQL2WmNfgQq1YuLA4KK3Ew0fBhnbhnIf1m2Y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0cet28v; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3821ae348e3so97451f8f.1;
        Thu, 14 Nov 2024 15:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625821; x=1732230621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmxRbwjCLcQZiy0Ryza4mLE/JTiqL1qzBY9++dH1cFk=;
        b=h0cet28vdR4G88cQi6N+1RiwHS/ddJjt4TszwL4EVW3UuwenJwAS8hjO3L2+K5G6Pm
         W2jFgMx6yJT7lQof0gnvf8zD5B9jrFTUPBSSLxv7yffKGmdcAbvcQuN234KnfxTo7Cqt
         ps6wkCKvHidCZCsBYgZHimMTQeo/rqVAnwFr3n892KUQsQ7Lt7dkNBBPoiza0o+4Vspq
         x3DuHjwGnG8ezpBCJIvsRJCRzS7sti3YBppfxwxCUA+qGFZy3lDdim2xKnJPfu/UpMGk
         joI6+crIqAZh6e/+pHRpC5NFmzBXEQGNifsfXYfXq9vu9nHTytnBg86/E8ybnPVIKdva
         h/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625821; x=1732230621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmxRbwjCLcQZiy0Ryza4mLE/JTiqL1qzBY9++dH1cFk=;
        b=X2lkWadjUrIn1z8Pe2OR883jWT7Y/ir43ZObPfSWBJt4BTYqbCzGlLypWzIy8lyI04
         uTOdRfVa4KSe8fNXsSpgE4/3vLzyRMnvHFivCc1O1zff4yWxLxe0OaBhcIEATKPiwng5
         zdS5NMoUqQazf2rvll5l0X9+I8wzAu40/p8pTit9xu6tDQwQXkbElJOqW2X4uwCD1+Wf
         A2+Pt53DQ2FKsIAINuiQPd07V19/pwgBN7EBtbPS/S73qsyvHb+EGXiD+nhWMzCHO0r3
         SSrmbE2vnzGmCVqpdZzqKxfujswkhCZBE0DVyiz0JbBgvow4rJa38nmV+bFfJcbYfz8C
         U/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV96JxWRkm9Z1xvGDQHPE4b9JK/+hyHRt2xAF2ZOzD7TBfCR8foyy25sp1SPN8/5YqDQIDImJpYgb71gfPE@vger.kernel.org, AJvYcCWiNS1QK5BfIN9i6EAOeDdALO6U/wM1Lfszvh6J9SFCZFPUzUB4oEfHsQ6pA2Zj88mQGSV+4QqZ0B8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Nk+BdU0Fb7uZWZjxRsVo7TUPtXtqqB0X5JruQ532yV0AEGvn
	BjziEthEpr0h6bzN0+8Ob6kyoZvllC0RglbobK9mSaNxJJVY88TX
X-Google-Smtp-Source: AGHT+IFa8xPLtLnV/VOR1rKadOtXIa8vEqe+EAZtR1A1XHfdKWs7qy+LTT5qraKkx/sGMZ2J5F88cg==
X-Received: by 2002:a05:600c:45d4:b0:431:5632:4480 with SMTP id 5b1f17b1804b1-432df793c51mr1577105e9.6.1731625821365;
        Thu, 14 Nov 2024 15:10:21 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:20 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 07/22] iio: accel: adxl345: initialize IRQ number
Date: Thu, 14 Nov 2024 23:09:47 +0000
Message-Id: <20241114231002.98595-8-l.rubusch@gmail.com>
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
index bcec3a8e05..57bc530cc3 100644
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
@@ -194,12 +196,14 @@ static const struct iio_info adxl345_info = {
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
@@ -222,6 +226,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
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
2.39.2


