Return-Path: <linux-iio+bounces-13430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A999F17E7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7641188F8FE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 21:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A8192D84;
	Fri, 13 Dec 2024 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAzS4F+N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50489186294;
	Fri, 13 Dec 2024 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124762; cv=none; b=QLEw3d/hB7OMAsUgnk17xJCtihCfVG/UmYaj2AND1WEPnqPyz3a1wC6PLlF0g4VZrKoU1zGsVcjEeHG0O+NNc6otGK+9pnbTaew1BCO3t9od5JncT/e2A46pIzB8kWO0xwdSszWce24N4diUpU7wtw41S9cvA/ydC1wLdb0Sze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124762; c=relaxed/simple;
	bh=Cr1713WajhHzvYvE8UfeGtOFiIQNZyadluwSxA0FUrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3nS3/Zha2NLs7SiBWWMiobEs1JmHgRjCPeLdhoo3hmtZ9HBfYzhaPe6tJA7MJnPjxzRP8vyhiOAbzqTOIDeJ7Sy7nbzX2olO36ImPmjW7YIwp/zIh8J1BTjnzqLFrc/nHXu/4F8UuySWKZoBmHR4LcNk7okoEM2FZeQKoA2S90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAzS4F+N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361aa6e517so2487905e9.2;
        Fri, 13 Dec 2024 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124759; x=1734729559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYXh6GxOLbpXiurdOh608cToA5zl7Wcej6r5BOVjdKA=;
        b=JAzS4F+NavfaX02i0Jxj/wyRUUq5dWMVHhyPL7kmL5cMU0Tdt+5LvMVBiNe4u24vI9
         JIgaOxwzT3VuUpB2TbE9oOV+OqdqdjQc0LgZMH+JGiduIPCX1wXfveTEX6RXB4JSoJVa
         V6w7VAfbxiJn8uuRQZ0FnUgi7SdbeSoA8OSDevcCr9/NsJlm3W7dWzgQ/zncLr4ypGuK
         u2JQuDsrJvA2L3sFkpULaFXW1Uz2QBZuitrkfzyBFvaDojvSm9ElINeBVfP02YYh4pgb
         HEyPVbPWIe9VNkbhEMr0ngVM74wtPEvdeuyJZLC2eC8Y8qP0nUAJyQ741Pk1ELkzXQBD
         rVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124759; x=1734729559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYXh6GxOLbpXiurdOh608cToA5zl7Wcej6r5BOVjdKA=;
        b=cImvU5BNZnghEWjpuaafDPSrSH66u/NPnsrXyR29g3v9ps7nj4Vkjbi7za+EYsMQVf
         xC3l1v6KEI/peiy5kWXWmpNiB+0NX19OSL1AuD+CqYsx37N+wkCB0qInPwr3o7OfM12N
         pnEdIKwAw3/79zVJS2YuTjjBTHkBCsVwv65jxACzj+SL+OuRl/qQqnl3nXMrEWH6e6XC
         MdvFDjvV+XevFTQK90cdhROPcRJY/eYJkF6Tce5Sf7yFXZ5Jfl9MpYKIAM2aj0a7F5bU
         tc3m5EdKo01bmIMYaxGY+neWxzOgby20ilwicN4rl+vWNBiYi1NZ7lpmbuz6jYIYZz3f
         tjJg==
X-Forwarded-Encrypted: i=1; AJvYcCV0arI5kOkRD5VPvdhP+xxnmcG5sdGnFukHqmJv/HC8oueD4S9lc/ysp21QmG+KMLpEccp2ydNDA/5FZVSa@vger.kernel.org, AJvYcCVAhN3gWWonXwoKi9lgz8A5aDYcmHpS4Pwz0FG0S7i43AhUID6Gc6ZCI0DMAyHGfNfGedOWeFtvJWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwksOWRyVKESjKd7j0xDjiK0twogoUrO2vgsFPbeyCTXi9z2+/D
	hPGA1MnRQNZVbjcgZTcd76hw+sBsLNNhs76O+ySjdTy0F3NfrQWN
X-Gm-Gg: ASbGnctS7lEnE0oEFTALonzjTe9Wp9z7I62SfN4n7lJADijy6hZDD7onv3oeIWfhVUK
	9ZS+jyb+JArHvxqoYnKNx2cMXV1CecGw1Binb0hCKABPP0Ls2iZTA5AqNpoDUs3KpIBvqpG1hh4
	IK1Tw86pQGB+/SYfT9/kOBK3rjrfYffV1Z7xWfYqhRFvJNGRUI5MoQ0ka2jFIM5HLJZ3Fc1Iith
	oYdMLdAOnTPVEDu3MgHxfL4pymxfknQIRmo9fADJUbj6odRO/Yo9XSQl1R40Dw802mMRqX8/81a
	gjm+YYGOfee/vVDnBSF7d+OaYCkt8bHMjIM=
X-Google-Smtp-Source: AGHT+IEUEIVWjEfgKbM8Cc8zH/n9VX8CQxTXDlBMaTADnP3GWvmd/JKE2uz/zdWjMIiotMQeD5v83w==
X-Received: by 2002:a05:600c:3552:b0:434:f335:85c with SMTP id 5b1f17b1804b1-4362aaaab94mr12988415e9.6.1734124758517;
        Fri, 13 Dec 2024 13:19:18 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm552484f8f.57.2024.12.13.13.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:19:18 -0800 (PST)
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
Subject: [PATCH v7 1/7] iio: accel: adxl345: add function to switch measuring mode
Date: Fri, 13 Dec 2024 21:19:03 +0000
Message-Id: <20241213211909.40896-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213211909.40896-1-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 42 +++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 88df9547b..b48bc838c 100644
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
@@ -237,11 +255,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 				     regval, ADXL345_DEVID);
 
 	/* Enable measurement mode */
-	ret = adxl345_powerup(st->regmap);
+	ret = adxl345_set_measure_en(st, true);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
 
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5


