Return-Path: <linux-iio+bounces-13051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE679E2DA6
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A8F166183
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375EC20898A;
	Tue,  3 Dec 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChGkL5oK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95820B211;
	Tue,  3 Dec 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259198; cv=none; b=K8+Be71Ya+9G/ANTwIDy2/JTMrVwOMmrwMMhuYncI0uUUgXDIimF9b7R18DEMXHolVqI4wvx7Mq5s499uqpk5QcSNmUdVwQWJOuw+O7XbwpyehqrPjal8FYlz6MbsO0JbbmT5pyL3Wpi+SIB4qk29vwH2bc9jArqSNbCRyXB+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259198; c=relaxed/simple;
	bh=FY91FECIG8vyXTtfxzalXSXZ249nSTm+wGDBjFYvNpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+KGl03Cju4D1EnG0nJEbCC8uKuxwxXqgZSChyrzScxJiFrTqREAxkNgHAE48IJnECbq0M5fWFYDQ1vsZVBReCREEWQN6PPHedJ/dmlm9wKaqqSWILTb6is9IVn3A8Pc5kUXnI65mLwohsWOy05Rbozzbybsr6aemlzXYggG4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChGkL5oK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a29ecbceso7078605e9.0;
        Tue, 03 Dec 2024 12:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259194; x=1733863994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA7vOziRlmc/bZx4fMvI0r+Cuk3SCmX4PpXxbI8VPks=;
        b=ChGkL5oKYMG4OGy9tnFfWEKYdX4NhGnSNGcgZkNZiTWewNUHHL62btl3Jch5OSbsC8
         egFdjkJ3F/NCkn44qD9vXebn3x8CCwad2NZMjNzwHeGEpK8Aj0J8BkR0tLgGNeOYdsK2
         3x8Fme6O3bxCBSfBY5GR5cF8bGjNqkUhCXlDPfL6F5FKOQvVs02PADhyBY7bkUvbPLge
         DKizbwFL+CrEqPrv0TNrWvOpvx46u6O6UgXLX6VxCbHWgl3cFYF+6ghejfXbrj+MhbXZ
         A8x6+WN5zj/QxFp3zKNtFh7w37qMI2Y+JmejbNSaXqyAH5Wuh2hKtzytogOav731/PTB
         diBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259194; x=1733863994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA7vOziRlmc/bZx4fMvI0r+Cuk3SCmX4PpXxbI8VPks=;
        b=CnuYDsFThDhlfVgQD+l/xnFglGdo9mtPG5Fy+PvgbV3hML9FqTOwO4v8sF3ojbQcfj
         3oUA3psShPC3n4Yb46JJKtIIuStG8QIPlDkejjogwVbjr0d/Z3Ra6neKCvRqNgD/Uty3
         cXKAPQL4OMN6DwD5/P/0JLqTZeiA3PfiEEj6iPy4l2nb1xJrCm04SBn7mDUG4JlJIoWw
         B5RpRSOWZGmxqT0A+agEFxyU1TM5hWL3jOba9zdEGYcIRQr9L+62CHo4Q4A0R6QZusO5
         4runpQDdu8Ji3QrDWB7ZDa+tTcPWfvPy7ctyhPYlsKHR5VwZ+uVsggmdy3TRU1qOUTrk
         pRMg==
X-Forwarded-Encrypted: i=1; AJvYcCUbbYyem3zidzD2o7ygaho3Mpqn/Vrq0RPL22KlRKu0UDjVgXfDpQURZdPgknqfeUISLOvFX9fYGnQrUCqJ@vger.kernel.org, AJvYcCWE2jcwnp/0AkvUeWMKDaZjGF28qWM7H+et2ztuA3sMlHjNQI9NuMGPLfNT6/U5DB2alw6C9WHBJLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk02RA3A4C0n0qttr5S3wbAzwiNzCzkE3EeuT4w8OU8OigXch7
	fSxCaymtjC5A9mExDxOYP9ZagcDtAJ0zRv1JFfx/TVw936mN/jwg
X-Gm-Gg: ASbGncslLvzVoxJDHfb7Cg2veVR1LEl8Jt4rPEp1E06rPkqs3oo8tFTK3bQ3SwbzVVN
	b3DRTzsTjdoVmAQXzvWdwgWwat+dfh8cJW7TTkcxji3uatVGd3k+h9byJ7HmkIwOqurk4BzVKJX
	kAd3iOhRFh9kXgemiwtCEHl/4P6lZQT/kN8w7jXFD7eGxI16xEIjC6TjtEKPMqtZAnlgYEfXZ0b
	7NV7u19kRUesS5nLqSiTZ15aA+aRc90TCZVpXodgErN5s3TI3nEQKjmhJm46OVm5L7xpnajPuVS
	AjGHpSlkktIypwMSZmOIeyq2tF+x
X-Google-Smtp-Source: AGHT+IF8CuGWZEBktezY5BS7YphnMd2zJ/kIWieEl2c7J3moHhstF2htiyuWmP6rtnP+sHe/iTdE6Q==
X-Received: by 2002:a05:6000:4011:b0:382:4e71:1a12 with SMTP id ffacd0b85a97d-385fd3c30aamr1439178f8f.1.1733259194422;
        Tue, 03 Dec 2024 12:53:14 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:14 -0800 (PST)
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
Subject: [PATCH v3 07/10] iio: accel: adxl345: initialize IRQ number
Date: Tue,  3 Dec 2024 20:52:38 +0000
Message-Id: <20241203205241.48077-8-l.rubusch@gmail.com>
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

Add the possibility to claim an interrupt and init the state structure
with interrupt number and interrupt line to use. The adxl345 can use
two different interrupt lines, mainly to signal FIFO watermark events,
single or double tap, activity, etc. Hence, having the interrupt line
available is crucial to implement such features.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 0bb2c653e13..dc91b2dcd62 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -11,6 +11,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -18,8 +19,10 @@
 #include "adxl345.h"
 
 struct adxl345_state {
+	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	u8 intio;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -212,6 +215,17 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
+
+	st->intio = -1;
+	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (st->irq > 0)
+		st->intio = ADXL345_INT1;
+	else {
+		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (st->irq > 0)
+			st->intio = ADXL345_INT2;
+	}
+
 	st->info = device_get_match_data(dev);
 	if (!st->info)
 		return -ENODEV;
-- 
2.39.5


