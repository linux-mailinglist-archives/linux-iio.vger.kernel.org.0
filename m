Return-Path: <linux-iio+bounces-13092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B99E434C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C9281D29
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AEF1C3BFD;
	Wed,  4 Dec 2024 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPcWl7H6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB41A8F9A;
	Wed,  4 Dec 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336709; cv=none; b=HYObV3FgnR61FqVoQTi+Ad8Mu0Pc/KFnoXwxR2T5NqSql5IqPGaLKsLtbb/HcFzj+sw5kt24TyiZWIPPd9YE+rntkJ42tyYCGEmoe5jk4+OWZRS3pJ4i8AL2cFRO41M7tT7hUpFsrzeMlrxb9Q8Ipp7QIkqOOhiuCT7Tf3DK7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336709; c=relaxed/simple;
	bh=ebMgkYB23U8EmKhJlfYxI1oX1jRs6zqA7+xkC/VZIJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FonTpzjyB80kq0nknh5sDLrCRy1j4jta+IEH/LNXC5vBck884SUun6YDaoBWTx55nvupZKw423H6kIRix/YNPuzMXPqkYzBRWZP6e2+QajNJgYEBJjj4ya5FqvueJdiws41/FaTudrZOAd+t9jkIdIFeLxVwfuGPI6nBhy2gdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPcWl7H6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a0300d4cso116595e9.3;
        Wed, 04 Dec 2024 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336706; x=1733941506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm3ofDFIyWdFD3BL9+CgltgTWGwpBkqmG5EmpobcGu4=;
        b=kPcWl7H68FMu9XeMYemsp4WU6gzfVvJbX/9ecv1RBxFU+N0qiQ2tEdtdKoLQZLFpZf
         t3BB65xL0HYNFoWOR4OWz/r4/N8h9gEnTyt+5VE9DxTlycTRKyVvwcxeFiVytI9bkQ/4
         k3aGhyvQeM+43MQYt2KAe2Bseo2xH3Fnj7G3fkm2BecY32aqY4qievzpSkM4N85w5KNN
         SulhqwTjMq/9GOKopk6UeC30ck6cLNqJDo7u79B5HgG2SSJIw6dhcabyROiS6k2vdn4j
         J/pQAA4JIhrlqg50/KCJwhY29jk//bnmhfoVNFkBEQWPjCCuOxEv1Gq4adj8gOdnINlh
         RoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336706; x=1733941506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm3ofDFIyWdFD3BL9+CgltgTWGwpBkqmG5EmpobcGu4=;
        b=UzFg/vOoidjLh7oi+jT9+WVrbDmLFRjPvxqtPxR4uYxBuIrJKtIBVR4LL+QKaW2ZyF
         ZSmuLEBE/FjsrPX8VepyvE1ImP0SlQqVI5MfRAYreEUwADKMC1XcM4MFseOYGI57KJw4
         Seshv7lZnlQBYf9fqXa/4nEPogYF5+SfpYpGQnFteSD0rpVfA+A4+jabBsUszWEXnQsf
         6AdBUvzHpUmEZ5C4w82WqA6QEKYLrXp7PtU+OFZDXVitnNFsHWg4V4QlWkor/0mP1AAg
         QDVGXNa4TCE2ZG9whuvb9b/QYx4v8igUIj447TRmwQK1tVIYS9pvheaEFUd34IY5yaan
         nnnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW7tJbiUN6y/hpx97OuNGnY1ukA+LB7a+JiIn8EkORHFfdq2705lkQQLXbNej+SyZOWHDZnTrya02l1zng@vger.kernel.org, AJvYcCXf9ITsQQnDWdwCR3KGD1yp20XRzzNdt6QkeHugBfvSVLHqkVXlm5PjDfElZ0vCMfLuS+TIcu4If8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yzYbe1mUGaVHLlLoPsvoMQpguGVPBRZJWwOirF0nyxf713d8
	gZ0VOhWwIzlvnfF+yi9xbkm84dE3/3vcJw5CR4wMVNlLCcJEWCca
X-Gm-Gg: ASbGncv+w+bn/6W0DKgaqkxNfsJNSBWhYxrSYeGTUE4oSN8ZIy24ncvgF6bxL3tLSJK
	D7DOfbUjCqc4J6BnsKMED7ZSlMeV8V2nEF/OaQd/7+cnzHVgM2mANb2kOCDzK0yz6cwVtK74Enb
	0I3aSwgxq33+BEhfddyM1XA65ugLWXQfFm/RtUl6RRaRgdzT2JZpeeO61KQe9YateIJe5o7rT/S
	5EYGcZDx0QKEfUWyQ1g+jHK0ECCM6sT2UiybdJPzYQo1mCQqigh+zIR/b/fk/3LVuSzN0Xmy6oz
	lnHC/WIWHtoJwmVl+qamVVTavt5y
X-Google-Smtp-Source: AGHT+IE7bLuAVoCpyuUvlUIiAFM+ELTHiS32XSm+OjYltBG0NlOumsDIYcKiAEXyWeVCsSekrDkvIA==
X-Received: by 2002:a05:600c:138a:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-434d11c73d3mr25464195e9.6.1733336705949;
        Wed, 04 Dec 2024 10:25:05 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:05 -0800 (PST)
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
Subject: [PATCH v4 02/10] iio: accel: adxl345: rename variable data to st
Date: Wed,  4 Dec 2024 18:24:43 +0000
Message-Id: <20241204182451.144381-3-l.rubusch@gmail.com>
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

Rename the locally used variable data to st. The st refers to "state",
representing the internal state of the driver object. Further it
prepares the usage of an internal data pointer needed for the
implementation of the sensor features.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 44 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index eb3ce4434a5..88df9547bd6 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,7 +17,7 @@
 
 #include "adxl345.h"
 
-struct adxl345_data {
+struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 };
@@ -43,7 +43,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
-	struct adxl345_data *data = iio_priv(indio_dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
 	__le16 accel;
 	long long samp_freq_nhz;
 	unsigned int regval;
@@ -56,7 +56,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
 		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
 		 */
-		ret = regmap_bulk_read(data->regmap,
+		ret = regmap_bulk_read(st->regmap,
 				       ADXL345_REG_DATA_AXIS(chan->address),
 				       &accel, sizeof(accel));
 		if (ret < 0)
@@ -66,10 +66,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = data->info->uscale;
+		*val2 = st->info->uscale;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = regmap_read(data->regmap,
+		ret = regmap_read(st->regmap,
 				  ADXL345_REG_OFS_AXIS(chan->address), &regval);
 		if (ret < 0)
 			return ret;
@@ -81,7 +81,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);
+		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
 		if (ret < 0)
 			return ret;
 
@@ -99,7 +99,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
-	struct adxl345_data *data = iio_priv(indio_dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
 	s64 n;
 
 	switch (mask) {
@@ -108,14 +108,14 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
 		 * factor
 		 */
-		return regmap_write(data->regmap,
+		return regmap_write(st->regmap,
 				    ADXL345_REG_OFS_AXIS(chan->address),
 				    val / 4);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		n = div_s64(val * NANOHZ_PER_HZ + val2,
 			    ADXL345_BASE_RATE_NANO_HZ);
 
-		return regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,
+		return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
 					  ADXL345_BW_RATE,
 					  clamp_val(ilog2(n), 0,
 						    ADXL345_BW_RATE));
@@ -180,7 +180,7 @@ static void adxl345_powerdown(void *regmap)
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       int (*setup)(struct device*, struct regmap*))
 {
-	struct adxl345_data *data;
+	struct adxl345_state *st;
 	struct iio_dev *indio_dev;
 	u32 regval;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
@@ -189,17 +189,17 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
-	data = iio_priv(indio_dev);
-	data->regmap = regmap;
-	data->info = device_get_match_data(dev);
-	if (!data->info)
+	st = iio_priv(indio_dev);
+	st->regmap = regmap;
+	st->info = device_get_match_data(dev);
+	if (!st->info)
 		return -ENODEV;
 
-	indio_dev->name = data->info->name;
+	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
@@ -207,12 +207,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
-		ret = setup(dev, data->regmap);
+		ret = setup(dev, st->regmap);
 		if (ret)
 			return ret;
 
 		/* Enable full-resolution mode */
-		ret = regmap_update_bits(data->regmap, ADXL345_REG_DATA_FORMAT,
+		ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
 					 data_format_mask,
 					 ADXL345_DATA_FORMAT_FULL_RES);
 		if (ret)
@@ -221,14 +221,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	} else {
 		/* Enable full-resolution mode (init all data_format bits) */
-		ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
+		ret = regmap_write(st->regmap, ADXL345_REG_DATA_FORMAT,
 				   ADXL345_DATA_FORMAT_FULL_RES);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Failed to set data range\n");
 	}
 
-	ret = regmap_read(data->regmap, ADXL345_REG_DEVID, &regval);
+	ret = regmap_read(st->regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
 
@@ -237,11 +237,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 				     regval, ADXL345_DEVID);
 
 	/* Enable measurement mode */
-	ret = adxl345_powerup(data->regmap);
+	ret = adxl345_powerup(st->regmap);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
 
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.2


