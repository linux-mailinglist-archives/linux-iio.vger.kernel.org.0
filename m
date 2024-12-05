Return-Path: <linux-iio+bounces-13118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ECA9E5CA8
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2245B2820C3
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE9226EEF;
	Thu,  5 Dec 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIIwlIX2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471FA225787;
	Thu,  5 Dec 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418837; cv=none; b=VF/LsIEBdg/uLxvh6T1fxVqcDALshWJ+cbsnDVZwMU2B4wjM7+4JIa9rm6YlLEzgDS5gRj8Je8Zg9NkctzbX3NzKtCnpNzGenVfFiKz+21V7tCzHG/+it3/378U/u3JsuiBYkcq3pl9lj6K6b05JU4dc3EKWIYrpRMignSW9tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418837; c=relaxed/simple;
	bh=ebMgkYB23U8EmKhJlfYxI1oX1jRs6zqA7+xkC/VZIJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4soDF0H77SoYhjAZ55U27nCaDWnUia9gUNxAVpBU+hrpu1NRaXmZuALw/S55Yd+Ghxi92L6ZAiv7LyYBStK/P4X+Yf5cMpXMxTkiZc0/9G3KyevkP0cpJjzZ17a1RgsmtJyXuTi5X25vliCqSEezFXkuqbboI5JSaj5CjjRQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIIwlIX2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0b85c5574so171301a12.2;
        Thu, 05 Dec 2024 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418833; x=1734023633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm3ofDFIyWdFD3BL9+CgltgTWGwpBkqmG5EmpobcGu4=;
        b=VIIwlIX272mq9UeTuEfTi62Xs4d5qHflPTbINWEZrCccXfpVz6bSFfHXjJugfNi0bf
         Wh494h5uV0NTmt71W6mg8sIvtwRILsq54ABIgRMOz8+cPOzodMIqqSdIWtZAHg+/yYxr
         TNUIdC76Mw1Jr5Hk6KQvNi40iRmQF2e98IAw4G2E28E9CeBTChHw3FgeT6gFiNe5ACDU
         n35BEdy20XFt1bmG74ghUE4ki3q3sinnsgGntiL8KoYzcbifJtm2gZaxY9P7qg0c38hV
         TU7qjTOLoANQMwwA+pfY6UJEZg3TC3JWLIgUUMR5i2v+PNLd3RNWAAYIg/xrp+23mh+i
         DHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418833; x=1734023633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm3ofDFIyWdFD3BL9+CgltgTWGwpBkqmG5EmpobcGu4=;
        b=cIQFs32XBiR+7CZrjXdCsBi+MHScFs537JuIJH1tbsrCtbU6T2wPSt26fn76NGhuow
         kL3hJo+jBcmEDERLP7WWJH1bJ0irRXm1FMj499a6QuNGCZUoN8FdnVPbxAVn6PoyBC/f
         r+pphZaCRj1gLzJkPlLbJUeWS9RLKn2UnsC1FtLhxMAh/2gViRMeZqXRsXhfOPofP7pk
         AZCvKo+olRy8TSQwiWLjVUY1ffrBgSoqSPkloxudHP6cwSDPnfkyXBnKpkoyDlJBB6If
         dY9pEsr+JMVQq/mpwjfKNghqTn+fwdZ73rDgbNyyNLVFZ0dHwdqpl6IHEwW5rdsKjgCu
         onjg==
X-Forwarded-Encrypted: i=1; AJvYcCVRfTC7pB0VJAg/TOw92cLzMfSbiwCpLXB6K/vKXeRF5II8f0pJP55DzOPwNeBSBqbzeGDUm9DRdzrY2SWc@vger.kernel.org, AJvYcCVpD8IYKSAgCD8zxFrSQbk6o+guJdRYQe7DW32dyrIcokn9Dd9cq7f9tWRia1uAAEJE5DByjaU7cuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4mDQUBwMfp6BA4VHPK4npOwh4UykE3xDtyR2f1av3Aze3/7p
	xmPRRvM2P2jfqQ/LITAg/el49VDCLexvwa8RswC4JOK1XDuupSAJ1lFi7A==
X-Gm-Gg: ASbGncv1UqEwdyjc2hfTaULssy/wAfWNhyPkqjJQPpn/CXww+qJJsKBieZFLPPDTZbx
	IZF+tVi3w9gxKuGkDqFKPOO0HcHWRdWZvhSy0ZEJuXE/I/XVML53WCevZkJNJjZZqkD+WN2zhRf
	JmZl9Gal5oS4OQ7DhDivu/lBQo5IYM7edQgOW0Smj9Gjy+z172XrF06EiszPvQHwWffLlKDH9WB
	gCX+eK0RX1Atu8w90Fc1fdKcxPIBUpTIMZR8t2LO1vEUlm/++iH8F7WJ72y+IroUQIzvdjOrtjc
	GlxHjB1t5fh2S1Ttzil9kuZafdQb
X-Google-Smtp-Source: AGHT+IHrr//m0ja8VQ6jXf2ws7mp45otghmQaUxXSsRXoD32kRkIRPZApLyCDvPbQ7FsVloDwpIkJw==
X-Received: by 2002:a05:6402:5292:b0:5d2:727d:dc04 with SMTP id 4fb4d7f45d1cf-5d2727dee72mr890508a12.8.1733418833422;
        Thu, 05 Dec 2024 09:13:53 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:53 -0800 (PST)
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
Subject: [PATCH v5 02/10] iio: accel: adxl345: rename variable data to st
Date: Thu,  5 Dec 2024 17:13:35 +0000
Message-Id: <20241205171343.308963-3-l.rubusch@gmail.com>
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


