Return-Path: <linux-iio+bounces-13433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8589F17F2
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B45E188F966
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AD1A8F73;
	Fri, 13 Dec 2024 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I93g6yBK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47547198A32;
	Fri, 13 Dec 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124765; cv=none; b=L/K4npcU390sEz7qjjKonOodzhQsNVJT70bCaSLIPJwVwMeDagv2rEZNfXdEp6FvxQQgoMl7VHFAycqwJo/TtixRVdekkQw4AUhnd8wb4msOKnanBO1Sym07zCa0oxxUeGpI3o6Q6q4SmnsNV8NmAMfyKrMDfOxcdbzSYqtCg+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124765; c=relaxed/simple;
	bh=OnEi/NtWpRQrR4crDgkQmPpkIr60sP3pUIwvNBRDZyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZCzg5Q02+7FHdM85g4apXa0iHvq+ZfSXP7dS9Xuk9hGifNdJki3QY7RZ0PWFqOIyc6oVAjMxEwdOtk4VwaKNCX0BNEPAd2B4JdZl5c+AZ7I6FSreSlNjDzzDGIYHmt/MKY6szHmjPFqectXpPhEY9JUu8h7am+2+rqbd0TcTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I93g6yBK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361aa6e517so2487995e9.2;
        Fri, 13 Dec 2024 13:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124762; x=1734729562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWLUOvAYC/+QKYOvlVecoPGtDiIOOdHySdnie/FYzsE=;
        b=I93g6yBKg8fmsa/HB22YfQCo8WNETL3qgq+DSPzje1DpBUIbSHvGLxnsdypfZ/pGJq
         Kwjsnm8Bye8/vcXvrXVR4Oxd3MYNm8wGqD1FBlFlC4yuCqB/NK2/Hm3+gcVVynw2efch
         phGAyrTh93+4VuJYD6Ro+t/5AonLRRZraSyRpnbsPhkhn2DfEPH4LphJYR/5SyMc6xLs
         puWdwBtFSbHdOmBnm3cg83/b4UWMlzMrbPM/y3CG61xB17c28BQZlsGk46tVC7ztM6ij
         O+ZRuqd5lgMZUaXmEEdYZQPiO9n11NuFsT2oBc36TYtVyxI8hSll7XNneezhZzARXx4d
         ojow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124762; x=1734729562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWLUOvAYC/+QKYOvlVecoPGtDiIOOdHySdnie/FYzsE=;
        b=OUSlcXOVZWiT30sJlklm+hAzlxcTO5L6Apr7PNLydbjSzSZmERQ2i8eO4YFXcbM8+i
         ggg/3qfscIAbPqCZIieeHSQlg+6qtZYjl4UY7vAQ6hPRNITdeKbNHG7sf4X0vaSWwPY0
         JOYytGoL1FZR5sA1DYuyQ9MMByFXs9mkEyXcPgRf0mekkoM+aSS1ZRwUfm3KAkj+QlHz
         DVgnKoKFi7ZKSphNSzfK0OxhELlcOa3R0pTy0wsFPcyAr8cXJj5ZIGscwi22O1QSutI5
         D4OOAEzssexZkszoREgJDpYsaTHbZj7WhgZPEgOX/ZWv0c7knHxmlPGGUJIKWEfyzO6u
         xVoA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9b4uf5hcXXzqvZM1JNmMoPba/Zvk5QtBFEAIrQSL5wGH3UbuqP4OvMz+ZTJ0FDnT8Okv7vmQ3U1D6paS@vger.kernel.org, AJvYcCXKv2QuYa8my11/WXf7L4TrvxnoH4/9GabXQI8ymHkQCwHOEVljfaHxXKf+C4S/d+wxuwnZdh65EuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVktupCm9c36KPqDQ2T/W/3Ih6rVXYVPu+6xYYNB9jW1CIxb/g
	kriMudZ2y9Wep7fSEd+yy3KGqMyUtnYXGqGeFFpFJ6updYJfTdGh
X-Gm-Gg: ASbGncs6m5HVE41kdO8OTxT3vLX4/qn+DF7Kt1uYm8NuXzJRjP6Tk+dg3N/LBMBvCcZ
	v45jk1s19H7/5Puy86+w56Ecnh0evNwXLd1dZMeRgsI911i8YCQ9opvp0radoC6fPWdhFxIAfBl
	MjYGEwXhLlW6cwz2e30fIpVnLWmbSs5yoXSck88PlsHnDa2UpIIBRRAT1X89uWnm0VS649UvERQ
	SRmwodKD7m6LgJdBQ2wOJjMsmEZRqSTt5LVrsGixNwhIdW+fbaqZfbUnJM458uOmu2RKZ+x0VDd
	VTyLE85VrzfO7P41axIktKyLcbCYqUkTL80=
X-Google-Smtp-Source: AGHT+IEaB8ELntB6TFtQtjeN4DzEyRiil0MGC4A8CGZ6SVnONMmopDnvD9kZVWRZ+WHmSWxnK2hZDQ==
X-Received: by 2002:a5d:6d09:0:b0:385:df17:214f with SMTP id ffacd0b85a97d-3888e0f4580mr1234953f8f.9.1734124762342;
        Fri, 13 Dec 2024 13:19:22 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm552484f8f.57.2024.12.13.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:19:22 -0800 (PST)
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
Subject: [PATCH v7 4/7] iio: accel: adxl345: introduce interrupt handling
Date: Fri, 13 Dec 2024 21:19:06 +0000
Message-Id: <20241213211909.40896-5-l.rubusch@gmail.com>
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

Add the possibility to claim an interrupt. Init the state structure
with an interrupt line obtained from the DT. The adxl345 can use
two different interrupt lines for event handling. Only one is used.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b48bc838c..fb3b45d99 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -11,15 +11,22 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
 #include "adxl345.h"
 
+#define ADXL345_INT_NONE		0xff
+#define ADXL345_INT1			0
+#define ADXL345_INT2			1
+
 struct adxl345_state {
+	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	u8 intio;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -213,6 +220,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
+
 	st->info = device_get_match_data(dev);
 	if (!st->info)
 		return -ENODEV;
@@ -263,6 +271,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return ret;
 
+	st->intio = ADXL345_INT1;
+	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (st->irq < 0) {
+		st->intio = ADXL345_INT2;
+		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (st->irq < 0)
+			st->intio = ADXL345_INT_NONE;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
-- 
2.39.5


