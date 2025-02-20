Return-Path: <linux-iio+bounces-15831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D01EA3D711
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35423B7B34
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D61F2C34;
	Thu, 20 Feb 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/jtmgTm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5D1F1521;
	Thu, 20 Feb 2025 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048166; cv=none; b=S5IWxdYU2PQFhmxrIORkquyzluikUHmLo/5yNJ0FHlRlbMnuTpC0OBnjttPojxmrvjmLvOPPnf5E9yTBG4ieXbGl0PPCIAsAeQJ9ws/PIxkmqU8MGMY11/ilhVsHQItdMfmWzEqYH3MaquqZnbIi9p5H8XWMVELZ9iViKz0rOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048166; c=relaxed/simple;
	bh=7vddfWcgN5NPgYxESRfdWR+ETzQmOz72tXjE8Ji6AKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQ80rVLW9jFtGtvMMBl5FOqFluGBzuQC/SHv5EEHBTnytXN09AxJ7KCBB/cZFvwJDTdTbZb0mfFudVU5BP4E9rfDy1gFHUzUBrRxhQH1PX58GUhSZeZeoiZGDMklhamPuuunq74ICRhnXGwGE/6f8qhXeJerzWnl/PLRfBWNvlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/jtmgTm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7ee6f5535so12111766b.1;
        Thu, 20 Feb 2025 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048163; x=1740652963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6PsnNzOuhiDxjE9qBwgD4F49zf6LzwC4nPLEAzL+KI=;
        b=O/jtmgTmEO5M5jZu6oiq9Mzn+XwszVw9nA1Tvo8KTfa2WxaUK76+dUIHKd7zyYZrUm
         ZybUYGuJTWbPZwTRfry6sOodme1UU6NSwXhr+Uj3Vp5Gu3zO3PJBAQzBb6SqNI1qVX+r
         wiDamsXRDaDliYo20P9gm8MAkte29EWQZPXDSiHJcpa2UNIMsTBC9eJa/PaaayqtnmG/
         /qituWdLX1cW0tzJneXDplHdJZhXUa4QUOrODO9eHO+ItvPqvaDpVcB802zhjWohzGCK
         X1jkuCMi+3pbxe9L8kFJYIKmhEumq9SFXx2AxA2cywjhaxIFZKaelWWPzPCuHl1/kQxO
         OOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048163; x=1740652963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6PsnNzOuhiDxjE9qBwgD4F49zf6LzwC4nPLEAzL+KI=;
        b=Fk6tuquqOQugxHeJ4JkCZgnJAc22J/mSpTBxioaBhxbN9OwPm3PFuutdgBvTSB658U
         eOb91th4+VPA9uQPZc538Ij8IdK49Hx0xhYo+/cZxMbz9xLdEcgVpR3GcrfcfN7FjYB/
         BhJXTQhjzi0HAvSzfAYCSXIZsq5hT6WQqfZ4qjyca5cA0QpNWTHvUuguwiH/eh4Yv5mm
         I6cZiEVAA3R2vAp866EjohPhT0pIq5gprweUEzdxro9h+M2AcEW9+wtw4/Jrn9kipjmU
         UQJCpXPiY/gDA8R+yEok82fEky9zmsMl5BtGKURV75cCbKJi6KrgJVjQP4FgZw8zpXxg
         88oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhPo+lPviwmcCOQ9Lewz4Ts9ypTKdn6py6utD2zdZilLiHQb4uFh0oJkbzFXRGG10MEpYyQjLeSOSxJUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhs0T2xkQtSiHVJ0vJzoUfPVOJQxIZ0L6wixdITkPm7eX0F4d
	GHhdprhk0QPUz8nmkvMUc3TaImSMA4d89PzWY/jhvVkMGRws8FRQ
X-Gm-Gg: ASbGnct907s9QEPZawY47j7OXewRw/NciFVCH3GXbYMpKrRK5XETMWYn/Sdk0JKzT1j
	HQm10/TpviYol9knbZAQS1CsTltfTdqmDE5zEEgqDQIuOwCfRAMuu25amOXGKxEJETtWetfCoLs
	HIlzCaRKFRjk0dTzjjKo+lrhES7WkaYOZBLDDu3ux9O5HqEcoI17uXJNwnjdrDXsD6tWVIQZO4+
	AnHMF8oX+ovIkczgF1nzQhnr6WOhfCQFL1cp1G/HtGEaW52kO3RXXVDN8PO6jis0x2MMLYL7ZFG
	yCWDM9vAm1Qx7Ao7z+X2U3cI1KbYt4lNdyW7X0TRezMxIGCkJBhw5U6iTBcY1vhyrMi6FA==
X-Google-Smtp-Source: AGHT+IEMnExlFBvdPVupW4U192bMGJot5oRB8i5ec8KWtogtQ7yFXPGlhjc7ng4+XzJkoYHYmK5MnQ==
X-Received: by 2002:a17:907:3d8e:b0:aa6:9574:1728 with SMTP id a640c23a62f3a-abb70acbb97mr912473166b.6.1740048162418;
        Thu, 20 Feb 2025 02:42:42 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:42 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 04/15] iio: accel: adxl345: use regmap cache for INT mapping
Date: Thu, 20 Feb 2025 10:42:23 +0000
Message-Id: <20250220104234.40958-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use regmap cache to replace maintaining the member variable intio
for the interrupt mapping state. The interrupt mapping is initialized
when the driver is probed, and it is perfectly cacheable.

The patch will still leave the function set_interrupts(). A follow up
patch takes care of it, when cleaning up the INT enable register
variable.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  4 ++
 drivers/iio/accel/adxl345_core.c | 63 ++++++++++++++++++++------------
 drivers/iio/accel/adxl345_i2c.c  |  2 +
 drivers/iio/accel/adxl345_spi.c  |  2 +
 4 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index bc6d634bd85c..a2a81caa292a 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,6 +8,8 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+#include <linux/regmap.h>
+
 #define ADXL345_REG_DEVID		0x00
 #define ADXL345_REG_THRESH_TAP		0x1D
 #define ADXL345_REG_OFSX		0x1E
@@ -111,6 +113,8 @@
  */
 #define ADXL375_USCALE	480000
 
+bool adxl345_is_volatile_reg(struct device *dev, unsigned int reg);
+
 struct adxl345_chip_info {
 	const char *name;
 	int uscale;
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 22c5a9c08459..c4cff74a5d10 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,7 +36,6 @@ struct adxl345_state {
 	struct regmap *regmap;
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	int irq;
-	u8 intio;
 	u8 int_map;
 	u8 watermark;
 	u8 fifo_mode;
@@ -76,6 +75,24 @@ static const unsigned long adxl345_scan_masks[] = {
 	0
 };
 
+bool adxl345_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADXL345_REG_DATA_AXIS(0):
+	case ADXL345_REG_DATA_AXIS(1):
+	case ADXL345_REG_DATA_AXIS(2):
+	case ADXL345_REG_DATA_AXIS(3):
+	case ADXL345_REG_DATA_AXIS(4):
+	case ADXL345_REG_DATA_AXIS(5):
+	case ADXL345_REG_FIFO_STATUS:
+	case ADXL345_REG_INT_SOURCE:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(adxl345_is_volatile_reg, IIO_ADXL345);
+
 /**
  * adxl345_set_measure_en() - Enable and disable measuring.
  *
@@ -98,22 +115,7 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
 static int adxl345_set_interrupts(struct adxl345_state *st)
 {
-	int ret;
-	unsigned int int_enable = st->int_map;
-	unsigned int int_map;
-
-	/*
-	 * Any bits set to 0 in the INT map register send their respective
-	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
-	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
-	 */
-	int_map = st->intio ? st->int_map : ~st->int_map;
-
-	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
-	if (ret)
-		return ret;
-
-	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
 }
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
@@ -265,6 +267,7 @@ static const struct attribute_group adxl345_attrs_group = {
 
 static int adxl345_set_fifo(struct adxl345_state *st)
 {
+	unsigned int intio;
 	int ret;
 
 	/* FIFO should only be configured while in standby mode */
@@ -272,11 +275,14 @@ static int adxl345_set_fifo(struct adxl345_state *st)
 	if (ret < 0)
 		return ret;
 
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_MAP, &intio);
+	if (ret)
+		return ret;
+
 	ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL,
 			   FIELD_PREP(ADXL345_FIFO_CTL_SAMPLES_MSK,
 				      st->watermark) |
-			   FIELD_PREP(ADXL345_FIFO_CTL_TRIGGER_MSK,
-				      st->intio) |
+			   FIELD_PREP(ADXL345_FIFO_CTL_TRIGGER_MSK, intio) |
 			   FIELD_PREP(ADXL345_FIFO_CTL_MODE_MSK,
 				      st->fifo_mode));
 	if (ret < 0)
@@ -492,6 +498,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	struct adxl345_state *st;
 	struct iio_dev *indio_dev;
 	u32 regval;
+	u8 intio = ADXL345_INT1;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
 					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
@@ -556,16 +563,26 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return ret;
 
-	st->intio = ADXL345_INT1;
 	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
 	if (st->irq < 0) {
-		st->intio = ADXL345_INT2;
+		intio = ADXL345_INT2;
 		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
 		if (st->irq < 0)
-			st->intio = ADXL345_INT_NONE;
+			intio = ADXL345_INT_NONE;
 	}
 
-	if (st->intio != ADXL345_INT_NONE) {
+	if (intio != ADXL345_INT_NONE) {
+		/*
+		 * Any bits set to 0 in the INT map register send their respective
+		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
+		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
+		 */
+		regval = intio ? 0xff : 0;
+
+		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
+		if (ret)
+			return ret;
+
 		/* FIFO_STREAM mode is going to be activated later */
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
 		if (ret)
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index eb3e0aadf51d..6ce567fd3ba6 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -17,6 +17,8 @@
 static const struct regmap_config adxl345_i2c_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.volatile_reg = adxl345_is_volatile_reg,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int adxl345_i2c_probe(struct i2c_client *client)
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index e03915ece8b6..200bdf975518 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -19,6 +19,8 @@ static const struct regmap_config adxl345_spi_regmap_config = {
 	.val_bits = 8,
 	 /* Setting bits 7 and 6 enables multiple-byte read */
 	.read_flag_mask = BIT(7) | BIT(6),
+	.volatile_reg = adxl345_is_volatile_reg,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
-- 
2.39.5


