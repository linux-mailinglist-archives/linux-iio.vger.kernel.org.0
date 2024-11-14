Return-Path: <linux-iio+bounces-12270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F89C95D2
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FDB284B02
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B71B393A;
	Thu, 14 Nov 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1mj8GUo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987DE1B21B9;
	Thu, 14 Nov 2024 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625820; cv=none; b=B7cYfr1XjEeg78CubQ/nTdMm1wUuV0YPjva8Lu2fzDyha2TMLcvaMP8LaqD2z59MDlckQs/+kWbjzkHE8eEH3jUKxjttQlW+ks+OSaG8UiisexyIdAi3kQgoVLAnjnO8WSxewJQoO+5RSpAP5kivHV/OIfaPBOaOKVIUEitEgtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625820; c=relaxed/simple;
	bh=vXMd3bUouv/WV7BNNEBeLPEuXmjltJJ2I4sZLLnoAXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QllKxwauv5dk5bc6nnAw63xXpbXwYw8Plzrr2iuC3YBAgq8cDAl/tyUkW1/BCy8f4Bt540flQHb0+ZAA6GCP6WYfHphOSc2KqHEG1g0pJo1NxpSJ9MZmO0pvBbT6uDF5c2lLwa/INpi2yulB6Pb0Pv/w1re1zQdWTilzOY9IVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1mj8GUo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d432f9f5aso60006f8f.3;
        Thu, 14 Nov 2024 15:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625817; x=1732230617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL7aJCXSASL5a/Feg30aFqhCV24wGmaLRDtir+JmL5k=;
        b=C1mj8GUo7JyutNGnrjSuIJ2MF51ZyqTO57Bh12dWad/HSexezhdybxCV5XqIN0ohCi
         Yh4T6qOHLOhYFOVE5HucOLztxF/AT4kdiIGX/eI36u6MvdYv7Y2+FyPb+Dbp1b7AabPF
         nJjE4PoLoADYlf/qimwAxPkSfhRbCUkgOcmot23+5jQyGAVpTDaD+rM8e9bXxdcnxebl
         ddWkhVtNsIB/fB29Mp8Agy8i5+FzTepy/TzvRPvhApeL6xT/TktZYva8ldov2erl4OZz
         +caFcUUW2mcnzP+9ZEtGRFh48bXaUR/WW1ZMivUmCedsN/Adwumb9qUMfKws2gPQGYY5
         16HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625817; x=1732230617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL7aJCXSASL5a/Feg30aFqhCV24wGmaLRDtir+JmL5k=;
        b=mtSiXy5Jr6FaWExnaXJJojDmQL+B3sq8Jiex480ONcyPa5oV1lk84j0zXh4rSz5NjH
         u/4RCDXygBYrwK5mydRjJT+9IRv8Sf3lE4JAc6Oa1ipCd0Zal8c2wGHT4lmjVCOegzBB
         xyTgEfU2tDdaT753Dub5p6gvL3EtFWKUZH0wLixEJ6fE5TtOW8E9cRxQlC2offaK5zUJ
         ZI0YceVubzK71wIE0peIQHibEmfQW9XDtPwbs7M/HmPcP2QLPG85IW7PxXPMJ7K3qiEf
         OGzWnmbt19unR/bwBu3dWwZ9Dt4MG+dtuji0BGyX2HPnWmTnWtFhbrAVttBupGn1g4NO
         Q/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCW41hHOmdclPYtnynIpOFXJV78W2B/pGXNXpviWjRlSAX/pf6UUZ7Hmk0Zf9TEcAYfpz7KKK2XCWbyAU2JU@vger.kernel.org, AJvYcCXo2zeScRGDgOQOlVQPcgDnyWYLqP1lPzwLUOoc60wvINHkKslHAe8+8O/bdG956R1G07Yim8CDoOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJXoXoz/Ltw3i1u/nU4S+dua5dAj+Z+k4QiG+q5tdn8/nGc1I
	0GfaWqyuyEss0Pm8wxYPEFf7O1H642hEnr2EkMEKCiAgFOOUWEHn
X-Google-Smtp-Source: AGHT+IEOUNbTCQ4D3xhfcr9oaq9a76+9sXJvK1TxKNmF8DAb7EydMz88hAAyjJcRsEJHg0tLv2gHDA==
X-Received: by 2002:a05:600c:3589:b0:42c:c59a:ac21 with SMTP id 5b1f17b1804b1-432df7229eamr1715315e9.2.1731625816737;
        Thu, 14 Nov 2024 15:10:16 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:15 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 02/22] iio: accel: adxl345: rename variable data to st
Date: Thu, 14 Nov 2024 23:09:42 +0000
Message-Id: <20241114231002.98595-3-l.rubusch@gmail.com>
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

Rename the locally used variable data to st. The st refers to "state",
representing the internal state of the driver object. Further it
prepares the usage of an internal data pointer needed for the
implementation of the sensor features.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 42 ++++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index d121caf839..3fb7a7b1b7 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -43,7 +43,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
-	struct adxl345_data *data = iio_priv(indio_dev);
+	struct adxl345_data *st = iio_priv(indio_dev);
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
+	struct adxl345_data *st = iio_priv(indio_dev);
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
@@ -181,7 +181,7 @@ static void adxl345_powerdown(void *regmap)
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       int (*setup)(struct device*, struct regmap*))
 {
-	struct adxl345_data *data;
+	struct adxl345_data *st;
 	struct iio_dev *indio_dev;
 	u32 regval;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
@@ -190,17 +190,17 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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
@@ -208,12 +208,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
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
@@ -222,14 +222,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
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
 
@@ -238,11 +238,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


