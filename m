Return-Path: <linux-iio+bounces-16787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C2A5FC90
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379113B0E3C
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BE6269D0A;
	Thu, 13 Mar 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVT8xwq+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB61386DA;
	Thu, 13 Mar 2025 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884670; cv=none; b=Iv39tpCODBN+DIpSIwOX1riSIrLlSG3dNSr4a4Tlj1nIGKFRuuLjYPHOT7i3G4+C2nw3Mjabo2j4VOW87PyiqNvtq1bEnWQdSLtmFE6jmyrymYULHlnyGQiWl+M1OYZY+O9Ylaun4EXbJ3F5Q5qzMS8C+dfDAjBxvlR+QZXo+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884670; c=relaxed/simple;
	bh=gASdt8h5VIpUlb3Vd3Zh4gCwb5FEXKYIJ8Fe7ic7sSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDz7Xd4G5riNbgSw2Eyh7OrWkXOkteAQq34ELceKY5wB0TaFWG2misxM81bQiOXFxoucu1+CQIoR6QrptfJDY6Sq/pom74dy2/choFm6stvZPA7IRP4yKZ9GuPhDMN/xQSHwivjErTj9WYXkfHvg9x93Chnsydle/g7pzjDsDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVT8xwq+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7f9f57192so20393766b.3;
        Thu, 13 Mar 2025 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884667; x=1742489467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCQDcTYoRpdtmyWWmyEYcUe0QuhTYZStwQHeV2Ey30U=;
        b=YVT8xwq+QzUWttFNok+jOm4zTqfycZasCWdiGB8FHeVDCUuf4Ve0OCqqlQ+z+ddDsr
         wsORQXVuKpkNk80sccgLv4SyeCb9Odiv7snLAzpQF1XRmD4bHk2LxbL6rfrQ4KO68Man
         zmET+UR5P9vyNIB1pIs9Qe2aALDb3ivmza+ulQzyUJ1w+BW1GabPG91R4zSoHm1YshB5
         NsSHFvHBbeJNI15+wZHG3FtMt4NDG0EYBzKonoi8M/dWeAGoTt8uP1LioEtGTrAn7IiV
         zCHP4moNL8cqvHppap7roGBihy2BXVXbwze9IUoJKW9669h84FYSkyEseyjr5fCfpeff
         f2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884667; x=1742489467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCQDcTYoRpdtmyWWmyEYcUe0QuhTYZStwQHeV2Ey30U=;
        b=Be2OPaY/JXo5nQm5BWDx0Yz0bbEHjNU/4oZt9Eq4APXvsr7fN4nLofohb5K0lLyN+J
         5Tudpnc1ckJDHGDssp+z1NkYGRy/pV3J+QsuFBwxjzAy9j08Zbv8gzVmrlbsI6O2T3mJ
         bKn6hN/ltlx3CnXwMCblIz1/w7TfQWCKOPMSOSn7/aqad//85tYeNeu8q9g1RPDcQFfa
         rUkgXUvvz0X1+JWpjXgblrNkpohtzsV38Gk8GAFUF42NmL2Je8tjzcK6kKrqZMAgSrgX
         0dhAR6TZ7qq6PNw4vJ+aDcONW69Yz9FpWZMttWjdT5T1hbFUclZwIyTDZZUlTBxt3OVv
         RW/w==
X-Forwarded-Encrypted: i=1; AJvYcCUZeGiOx3G06VbUOIRxlLORVeuiBhmd+mO9ma+zg5sOIh2gV8qecnmP/swAI78Q+E/Yr6nI3ztm9NGQAt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgeZjCxJTkEm4RtP5tghvVFuoRDUR/VRfhDEeqYWVvWtyh21E1
	D1T+ItKSrp+OmpvrjbfRop3PlcCql9x+n0hw/dR+5LeuiM9CxRXq
X-Gm-Gg: ASbGncvJvY/0vU2SwdVXcjlCpGxVma5cWrgfhi5PYL2hWBHpS+zczoN5W+DC3MF8Rmp
	CpMZEMt+9P2JaJEV9uIEAZq9byKmv5SNtIYSvhaZ9FQUTUugTJoQif3r/o/Xl1EW/1JO5gagVZZ
	jBOVJEfYwqYpyIObCfKVN8cdmNQ49JicWeYWe9NZPuB7pAfsG/Bj6PagvW5Pcq815bju3UpCPn+
	44f9mQfR9abAYK2ZGBaRgGwx5ptaoE3ANhxba61MOiw94e0KInUH+zp6nWy7QomeOgABSCKqrII
	n0UaiamvKIXwBmhurqVbNeY+vIR1/QxvO483SDLrFlNrbFgz1+BcAip6Ypu3avAK5QrKrEzehsG
	EKubqELM/qIglodBtTAe/3Fg=
X-Google-Smtp-Source: AGHT+IFoYpY9+p5Pdltw7mEXmmWrymiPL9vL29gk2nTjGAaXP0Cck+MJ0ev8iNlJiErdfM+PTfHxLA==
X-Received: by 2002:a17:907:360c:b0:ac0:b71e:44e1 with SMTP id a640c23a62f3a-ac27137e457mr1033506866b.6.1741884666966;
        Thu, 13 Mar 2025 09:51:06 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:06 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 01/14] iio: accel: adxl345: use regmap cache for INT mapping
Date: Thu, 13 Mar 2025 16:50:36 +0000
Message-Id: <20250313165049.48305-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use regmap cache to replace the maintenance of the interrupt mapping
state by a member variable intio. The interrupt mapping is initialized
when the driver is probed, and it is perfectly cacheable.

The patch will still leave the function set_interrupts(). A follow up
patch takes care of it, when cleaning up the INT enable register
variable.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  4 ++
 drivers/iio/accel/adxl345_core.c | 64 ++++++++++++++++++++------------
 drivers/iio/accel/adxl345_i2c.c  |  2 +
 drivers/iio/accel/adxl345_spi.c  |  2 +
 4 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index bc6d634bd85c..7d482dd595fa 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -111,6 +111,10 @@
  */
 #define ADXL375_USCALE	480000
 
+struct regmap;
+
+bool adxl345_is_volatile_reg(struct device *dev, unsigned int reg);
+
 struct adxl345_chip_info {
 	const char *name;
 	int uscale;
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 22c5a9c08459..6f337b26999a 100644
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
@@ -76,6 +75,25 @@ static const unsigned long adxl345_scan_masks[] = {
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
+	case ADXL345_REG_ACT_TAP_STATUS:
+	case ADXL345_REG_FIFO_STATUS:
+	case ADXL345_REG_INT_SOURCE:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(adxl345_is_volatile_reg, "IIO_ADXL345");
+
 /**
  * adxl345_set_measure_en() - Enable and disable measuring.
  *
@@ -98,22 +116,7 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
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
@@ -265,6 +268,7 @@ static const struct attribute_group adxl345_attrs_group = {
 
 static int adxl345_set_fifo(struct adxl345_state *st)
 {
+	unsigned int intio;
 	int ret;
 
 	/* FIFO should only be configured while in standby mode */
@@ -272,11 +276,14 @@ static int adxl345_set_fifo(struct adxl345_state *st)
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
@@ -492,6 +499,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	struct adxl345_state *st;
 	struct iio_dev *indio_dev;
 	u32 regval;
+	u8 intio = ADXL345_INT1;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
 					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
@@ -556,16 +564,26 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


