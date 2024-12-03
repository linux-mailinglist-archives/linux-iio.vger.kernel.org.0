Return-Path: <linux-iio+bounces-13046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F89E2D9D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B83165D28
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48054209F5E;
	Tue,  3 Dec 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBBggEGI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD5207A3B;
	Tue,  3 Dec 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259189; cv=none; b=Yo+iSoFHaI/Hv3sw7XycUbFWmpt1YiDBH+O9NbGGWhGBFtt5PIkfimuMTrRdJjjrBnV4JVXviHY6EpwH80Ss4XeE28r8yY09u4R9YI13fWN86v462OLcLQ8eszehhsPHkM5TkhhbcF8f2pcnIXGlBEOOJOCwDfOde/FJYMUBi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259189; c=relaxed/simple;
	bh=+SXaFaCDUVInjRlDueNbx9/MYhzQH+ayDZ4JgqAY0DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVXpc/eGO/8Mz93dmKfMoTVkHPxg+aZF3YcKi6nsB9xNbipZ816GdGMQ4tef+ULJn9COWillvDvYHlSfiCB/F9wRW9KgW9Df3E/b7/7/Aq+8RhciXg5H1G+t5fcF5tOBrTzQROCf0iqGi0cPcp7T0CGwhDdtkmbwdLlyICmrNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBBggEGI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a0300d4cso5194725e9.3;
        Tue, 03 Dec 2024 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259185; x=1733863985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq8vAqrAI+qdVi5s97T365YIN/eEAmM+hfA50EMM1b0=;
        b=SBBggEGIFKcoUEMPss3tkrOFx1qPUZrddwQS/eg8w71wRW54g+jl9BtLcsp9BBiXTl
         POXA1wib7AdHYCYPVRFr0syX0Kr/AiyR8hv1ZAVnlZP7BsrZQY1eRufDDTnzwrnK0d5f
         Qfy2wP6mFN6ecs4Zs49dXztDsxh/CrSik6eFciW1RFI3opDCaeGCPkGhaiYIWdpZ67Gi
         O+yb8sWLHGtikYeAXBYBFKZB18sywaDTJAyVyyK1Hi3Bp+Y9B+Pzq6t37GDvJp3SsApF
         1Acilu9L/oOQaA9yShPOau0LDKpYZYOSHrJE4o302hjPiu1Z/X87D1e9in7K1BCAQ9uM
         rcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259185; x=1733863985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq8vAqrAI+qdVi5s97T365YIN/eEAmM+hfA50EMM1b0=;
        b=t2x5r10lPAm0aflb3l4/Fzs0BDzsg1RFC61EDT8vUTVfewPHxqKuJOQTvXsITxEsgV
         xhbFp9r8Tuze9Fwy8t87CFpJAn9zb7ODrKPpml/IemAhjfng1HjRxnZyjEht8ryHD2D+
         lFLj9LCRjdFMfs2LtPzPI1+qdSMpMiQyJFfetLBaJwZZNa3Fu9ZZUr4yhsgbktH1j/SY
         HsSK1PFNNpiOnZzrC19doium36rjXK0NM3N1bnMckKhaxiuzDdopy0IYxUJgpcQeas53
         9C/5V5L6bDIaHXHgM+kMTzhQijL6OqsqigmBbz1dhQbtnlM+biuvvFjk5Q8iQprCCqsF
         vakw==
X-Forwarded-Encrypted: i=1; AJvYcCUSUq9o8ey90bffIxKUVnE+EbLWfXjqMcr1XS5ERs5qGWwPtwe7T97YceTOWp/cW1u7Kw8/Yur906kTHtgC@vger.kernel.org, AJvYcCVur4XKQZ7LRR4BxFrrtjJopJ6zIE7/yqiuJQydC3ekqY670d19SGYwMx/tpgPB/DmFQrkBQh8qCYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPewCbTYoc6h1PhR2XFJoEIz3cx4Ap/e8XFZPyMbLVNTgT+po
	Yny1gFmZBYXUUMIw3FrkQgDRk12U7eLF5G40/tlqd4viVQczvo36
X-Gm-Gg: ASbGncuotBtG8fLl7hhz2dSVUXnTXTJ01oR9E3SShIfDVx4gAjOAtUji1XCOZTykuEz
	reYpwooL0kIyJpsK9SvOGHhX6tD8wEsXWjQmbKIYy/4CW6PnPxWgEuxVWsdxFi441BwwZbPFnVi
	/nsFzJC63a4VqKMVXfZFvCrS70BIK7zMq+xqRy67FXIX1ZY4uU1u2SwrgAdqR+9F95dfF8WTMUs
	zKyYmoZMS4AnIcQNRn4cXXyYD6n3w3z+svQpAowW1Y2UpdVX0ZWMKZSi6dqG7SqwxaUHatIG3ao
	sJiOisKvBNwEw/kdFRyMFmrV67k/
X-Google-Smtp-Source: AGHT+IEuhrMEyESbHuppQVOFrd1cwDwo/Nx+cBC78f/SfDyN61wYe2toUGlxUF4V9SGLbLDxZ4dBRw==
X-Received: by 2002:a05:6000:184e:b0:385:fa20:6583 with SMTP id ffacd0b85a97d-385fddd3462mr1088243f8f.2.1733259185441;
        Tue, 03 Dec 2024 12:53:05 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:05 -0800 (PST)
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
Subject: [PATCH v3 02/10] iio: accel: adxl345: rename variable data to st
Date: Tue,  3 Dec 2024 20:52:33 +0000
Message-Id: <20241203205241.48077-3-l.rubusch@gmail.com>
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

Rename the locally used variable data to st. The st refers to "state",
representing the internal state of the driver object. Further it
prepares the usage of an internal data pointer needed for the
implementation of the sensor features.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 44 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index cf73d7052e9..0b613f5652e 100644
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
2.39.5


