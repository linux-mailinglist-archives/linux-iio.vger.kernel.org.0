Return-Path: <linux-iio+bounces-13120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008749E5CAE
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836B51883CFE
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075F227BA4;
	Thu,  5 Dec 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1aXfuo/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B47227B80;
	Thu,  5 Dec 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418839; cv=none; b=BqCl46Sc+yrSt+4jdrfC1ymqTG0KEPRKSM12SEQTI+zi8CKlNmSX++1i1ejk98jdoa8XwGVuDM8rsngHNNVh+PLs1rfYBfviiSp0+oLwp9bjJ3SzmE47SIpuMyxim/ruLaIEiwN9fRM9dPe3LUow9CWyueLJvDE5JQW0d5s5MQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418839; c=relaxed/simple;
	bh=gOf02a1jPfvJOuetJm2rPZvTaAz1JfUZwEdwhYgo87U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7NFFQWW/G7q5ZRenIg/EwRwLbLgZRhG/UeWvG/XrD71FWKhT6BIf4DQt6cAW84q7aoKN0atZA9ruIjsQJ/bXUr/gG4gRGe8H0dMEO7MesiWfPas9MpsLO8++HUWJOFF02UY7TVvtqHtla/OhyydHSP7dUZ5lEKr4vJO2z9XH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1aXfuo/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0d81eff58so179220a12.0;
        Thu, 05 Dec 2024 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418836; x=1734023636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRuw2enA1+kkdjSgQgqyvtqwVBm94V5xgygsnwgPZM4=;
        b=j1aXfuo/2SIjM58zp4nPVjn3oaaOT4Mk1Z4LIx84zhii7VXzxagHGiqkCCOiXXOArQ
         I0feG5EJnAgCQr9NBygUVm++3Ij4tlhv3OXM4P57EmjJfFxTY4JY5lOcjQarBz1kD6Xe
         sRT1c8KWuS1heYgFy6XX/mc0/ogbf1k4paxVbSBgLTWn2peJGN6Gaecb8NwkL0p9SMCj
         /m2sQZFuueBpseMRnZrUTnb5NaR9ebfbsKemKhQVnoYdrOyzWrtD2baL7gn9H/KDhtEI
         xfaJlatTY7scS4gAKinFTA6MHQYGRTAdqiFTM0cFlXx4oOfuyOlbufY+tofqqKbPmHNK
         XiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418836; x=1734023636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRuw2enA1+kkdjSgQgqyvtqwVBm94V5xgygsnwgPZM4=;
        b=MKTfqkboAZtirhrV4gZO4+BmHUqWBAFLUH1DgbuTa1qhfiQZHGNNEpb7QN94Vzkitr
         DQZrHNowCzlUYFo3HbLz8eHAEJOT+PcSNWR9V/m0490NCLEV/yWgRhLNfvBJaf96Wlk2
         HlGVDSeCtCuq49HZzH7u181HPd1cyHf8gx6LLAL3RKDZ0eU/e16FHws/sKPy/Ugg5A/N
         MUUbnnyJwjwwTzFQPnSim7MFSOSSEVhSnZCHEf46Tq7pgfqbPGln68uO+5Ic6/MmdxuW
         guFKhj32aBL6+RdhuQT5NgUZ2ht7YeXUxKZ3pjQf8o6YM6FzbEh/LLbU/rKeoLQCnp11
         1Kfg==
X-Forwarded-Encrypted: i=1; AJvYcCUAh8C6VPkUvJ0xEpxIK6GOKR5xv1qwi83gnW801qSA/EF72VRY7eKCjMzHOb6RFLq6RO5fDlGuReo=@vger.kernel.org, AJvYcCWwwI1zB5KVr2EMYzzcNGBXi16wz6p3hkXOJsq2y8te5mcS4rJ15pHNgW9e9qkB3hvXv3MZ1Pq7q9+JaZNy@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5gpWPznO4fOaXRsp39+uE2mpTlGoOTHfQJRwbdFf8a5JNpM/
	9DQpf/W6PUCJlWnk6oYmK8kAv+mIxJxo27GTDFIPcWF7yNauEOKP
X-Gm-Gg: ASbGncuMYcrIBg5iXLugrJyDYbjGABhNBuUhhrdo4C4zcsPjQgut/zUDVzbh8X/kdl/
	tCdg4AicI0rPTwkdOfmxVuWfEQ8UyWp/0r7REK0ede/jto6vzCzNk9xMCqSXhSzD/4v/7xWcjEM
	IMaUNq6XQrtQhiAsI9nEjwHK/iGIDv2vjcPfHO5g3MlZbvcjmFImsm1Uif1rZG4/jnLA6FMcfa0
	q5sF5EyWB/g0FPFOKK0GySOyb9a0RZHTCr7Jk9Yo8FH3vV7ZkhyKFd4V/86x9BZILCK9iNCrcgf
	a5lyYFXBZtuRkr8BDvi8rYQQHSTM
X-Google-Smtp-Source: AGHT+IEPmmIHEU8L9dudNBH7URQZNM1P0X5zrxs/mSndPxxhnR2eSsDA7khSQngJ2D7rowE41ySI8Q==
X-Received: by 2002:a05:6402:27d1:b0:5d0:e852:dca0 with SMTP id 4fb4d7f45d1cf-5d10cbad297mr3915551a12.11.1733418836208;
        Thu, 05 Dec 2024 09:13:56 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:55 -0800 (PST)
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
Subject: [PATCH v5 04/10] iio: accel: adxl345: add function to switch measuring mode
Date: Thu,  5 Dec 2024 17:13:37 +0000
Message-Id: <20241205171343.308963-5-l.rubusch@gmail.com>
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

Replace the powerup / powerdown functions by a generic function to put
the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
several features of the accelerometer, it is recommended to put
measuring in STANDBY mode.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 44 ++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 98ff37271f1..1d020b0d79c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -138,6 +138,34 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+/**
+ * adxl345_set_measure_en() - Enable and disable measuring.
+ *
+ * @st: The device data.
+ * @en: Enable measurements, else standby mode.
+ *
+ * For lowest power operation, standby mode can be used. In standby mode,
+ * current consumption is supposed to be reduced to 0.1uA (typical). In this
+ * mode no measurements are made. Placing the device into standby mode
+ * preserves the contents of FIFO.
+ *
+ * Return: Returns 0 if successful, or a negative error value.
+ */
+static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
+{
+	unsigned int val = 0;
+
+	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
+	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+}
+
+static void adxl345_powerdown(void *ptr)
+{
+	struct adxl345_state *st = ptr;
+
+	adxl345_set_measure_en(st, false);
+}
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
 );
@@ -158,16 +186,6 @@ static const struct iio_info adxl345_info = {
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 };
 
-static int adxl345_powerup(void *regmap)
-{
-	return regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
-}
-
-static void adxl345_powerdown(void *regmap)
-{
-	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
-}
-
 /**
  * adxl345_core_probe() - Probe and setup for the accelerometer.
  * @dev:	Driver model representation of the device
@@ -236,13 +254,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 				     regval, ADXL345_DEVID);
 
 	/* Enable measurement mode */
-	ret = adxl345_powerup(st->regmap);
+	ret = adxl345_set_measure_en(st, true);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
 
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.39.2


