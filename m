Return-Path: <linux-iio+bounces-13097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C719E435C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B574281189
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74B202C4D;
	Wed,  4 Dec 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIU2fujH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C92202C23;
	Wed,  4 Dec 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336717; cv=none; b=QuGCwT/oppeupPhX9DK40nnW0jPsJalV1AqOnO8fZzazasesKTQczkqLFcG4gsytdJ0Vh3DkYzhPOa6KeLiJ+XKZ1QL49SKV8NfdSrQ90u3vEFqvAkxHeA/Ni6lQVJi1RQ2oDWUcytDPKGbwWAnDfuZTbJpPf/A2axZLkjf8gYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336717; c=relaxed/simple;
	bh=S0inAZHl0ztwEsx1oI5GmcmBpR7IlLnBA3TzthoW+tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrP+mI6mOKdQjdKKDScuEuTZtqtVW2UnXsmtaEkzbamYA5UvFYSCqfhd2+wsXhzXJUehnzrs7lCPirIcs6SbLG4htu3yx1tVPhMKzvlEDkOKK3AL6s9annRD4ry6FDgcxtDv2Z0lE/34AT+TZoB7JH2SxbVOqTH+ROa6sKl6aCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIU2fujH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a1095fe4so98115e9.1;
        Wed, 04 Dec 2024 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336713; x=1733941513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXBB/e7iBLl04dNygS4ZhKgIlKO+KsaUlZhrp4pFDcA=;
        b=kIU2fujH7ujF3k0p73JRbqUNYRXIkNJd4tktMsaxfzVM2whuAGG00WvHTg00LqFMY1
         86qg9pms7sXHWsS8rvHCnnx+mdrKy1RE9z+tyr+nnGdt+qBT5gZNJ4fBsqazbpuAi/Kx
         RLJSYeqx1nGcJe+LnNYRdTarfIea4MxtX9aT0u7bTdJEaM6vNIynOImdkFizuhHuuXDG
         uUa960f1tUK5SXm2GwlA7p4LDs+XbNHH1kcwm3I2yWiLLNV7vaORQ1yMLih+86f1S7w5
         V4YzLFPNBlO59FVR7pKTixqstIsnitqY2tARgHRiOTW+PtTijuxWejsRa/L+gFVUGW08
         Xhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336713; x=1733941513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXBB/e7iBLl04dNygS4ZhKgIlKO+KsaUlZhrp4pFDcA=;
        b=HWSVK/vUGDhGBOMwGgWmtez8VhlFlweD6wUftomFBaa64+Slkc+5O+BaGnHGqkKIZT
         BGOvpj+9jaSVPXGqwZp1Gz6iIEdIOVE72bLvGkz2mcWtpNQXIoqvuKTybbekWDr85+q9
         9x1kp7Rqm9yJO1nu6w+787PP4mvxLXexyWpjqdE3DX3IvfdRJs0vl9Jdrt1TIbxsDA/J
         ha0xguyccohmX6v/YWS6nNJ70N9vHMSL6dtmLzvhbD6RV6ypSfm5Gxm5XyoyX5vZdCX7
         c25zCEViVsYCya9EcFazQ2rsi3awSpBmRaUkxCaiK1MYBHm5Uk15mNM7GTOBxpRjbbgN
         tRtw==
X-Forwarded-Encrypted: i=1; AJvYcCWIpnZV45yyYrO9TtgW2p3B7mQ5er1du9odfL/4KtuWwS92HcDOiutu17ZdZsL9wHCtEzHT20sV8TA=@vger.kernel.org, AJvYcCXAem93eaSM+SVfStEn3wd+rf5BebkBEMw7Zpho/AmG1AEE7W+15kK+AHLQcBX9gzG3K7ANzToiKTRvAgoR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RBGimhpbLaQXxfRMuswvbbv6MyUrXVJWaC/EAajj2FdxBrZW
	6QMOcTA0HM5trQrALSEgKkHnKt2udaaF7em0nP+VliqpbwYAKSHU
X-Gm-Gg: ASbGncvsExU18VyQ1QLhFbtOwIe5X0dcLo9dXWleEMPgLSRF8iM2/RjYSnYlKbrbgnA
	dYj09Zh+YykUA5i8jhlTMWx5W0FmcL3HpmDEePKaNWQYuGHP/E8VcEWB+ncHua7Gw3TEejr0oKZ
	+pRgkpoxul0Dl2PT1kAUg8GXxshVhvbrM5h8tCljU8v0PGj3fg7uUDJ1O9QBo6a+XIzsdzWaD8X
	UxsgwElR9/AwCvFsXuje2TC9CanJ8bKSCdQR+WHQQkikTQgDx7bp0/xzqwKNQSOLkhlNBmR8UMT
	I7Ay3L3ApUB1P0lqwPLqvtD3D7F2
X-Google-Smtp-Source: AGHT+IGagPwAt2PxYUXWY0BQ0/B264RsulgEv9md3QD0MhQb/KiieyqodcaSaPDCuVlCfeE2U+V1EA==
X-Received: by 2002:a05:600c:4f4a:b0:432:dc5a:b301 with SMTP id 5b1f17b1804b1-434d0a37b2dmr26897645e9.8.1733336712583;
        Wed, 04 Dec 2024 10:25:12 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:11 -0800 (PST)
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
Subject: [PATCH v4 07/10] iio: accel: adxl345: initialize IRQ number
Date: Wed,  4 Dec 2024 18:24:48 +0000
Message-Id: <20241204182451.144381-8-l.rubusch@gmail.com>
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
index 1d020b0d79c..e0a8b32239f 100644
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
2.39.2


