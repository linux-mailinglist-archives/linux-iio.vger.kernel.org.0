Return-Path: <linux-iio+bounces-4805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061E18BBF5A
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 07:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0554281EED
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 05:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55526112;
	Sun,  5 May 2024 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFx0DgI6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79B187F;
	Sun,  5 May 2024 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714887445; cv=none; b=BEM3ia3co9ICpa3hyQdIZcEcJxZHEJemiLPYeGhaCJ51gD/nxUIGQ4ncb43ITzDd6ZHWAutO3qeL8IazAt5n73jcKC2WhpG9LyE1GOnSNezuY6jRPYwP5FiXaBRx7Xd3jIyT8dcduHg9Fvoy/1YjWK6pgxVwo1kjMVY04K6cxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714887445; c=relaxed/simple;
	bh=mPgXY5mYvNaXw5It2IL/zqOboxuQqHy32zSe4AmqozY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJv/KLpcgBoYnw3h5qecnJwJdZ3Hx9V8KbHfnnWMptJY/jkete+Xe/NE+grMcf+i+gA4LhvXUPHU5mKd50rR00mq93KEMOCudTOI3bl5FS50DE7/jFrimAblVMZryEqM8pOoFtmv5cGmjtFQndccF8L3aruK8NPs2cKavAoXzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFx0DgI6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso7958995e9.1;
        Sat, 04 May 2024 22:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714887442; x=1715492242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLU07Iya6lCSJrZFYezoVEn/G4gnnpRGbLri4p/BRic=;
        b=iFx0DgI6vy4ZvxRocrLm832mANXBMPSz1IEqNpSH85CUSfAXiV4kXrOiXbNuK5bZTH
         sswxb9bJZ01DEnyn/vYye10qPFUQTWLTkwKMZsJa3nIHu6PmQhEbP01o7VwZiHlqppsw
         h+M/3q2tyDny6lnDGv5XcS0pmVVIQRLMnsWwgv76ekdVSuhjYdHHBDi9SvHtWcIlyXjb
         GbxJ6MlKkETaX8ja0BNLGMGN4IFCikc9KvER01l0LUWbwY2xcmU2Eaq36SECZNoNf/Dc
         UuM7IMAJLsIBK8PCMrZHtYlm5kYfwTt/E63EnQSq//lQqvI5IfDNLqT00cK6yrvOGpDq
         /X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714887442; x=1715492242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLU07Iya6lCSJrZFYezoVEn/G4gnnpRGbLri4p/BRic=;
        b=b+cdyUYVZRKJE0xKUp8wyH8YtjJJj9XNCbfNitamq6m2NFQKkNLWaFmBrzhl9o4eh7
         41RJAIRm6scuk5gDVu4rTlzb3eq8Lb4sEy5hQmWgkJAT0W35Qv82X9LEUkr1K4KyncBP
         qZ7k69N/NSSRcFafaSDOShgKef0+purY93nif40K8xTcSwrwEPyBoCIZmRoAR3C4vg4P
         reHscqLKDbAEfZtgysrDP+a8/fkzyx8zUTOrTD4UenNjshJc9WDt9sxd5a+xiS0w2gAV
         349uQPu1hhoOZWKn7P/G4C5TdR1REN2EtN0ecwDvmKHvHCy83dKg74UZZ3uBNADh7D9o
         5Spg==
X-Forwarded-Encrypted: i=1; AJvYcCUYBOz+hEkQYO0Kf2tzTY1wGDMlFsfSBh1by8dftkUkpEbwZ82JDIF/r5jM7TWmOYCNJPaRNBzmbVFvN159vrbnS2UbjWE91y2GHij66X8nbsJcPeOFQ8S7MFeu1Bw8Gj6mNPJ8IfOnbA==
X-Gm-Message-State: AOJu0YzuAplXhVZahX/p1wCAkbyLCoQ/5B4tDCg7tVgTHd2icy5Fw2V3
	SkuC0+DUMkdlrmO4RygOt5qy/9Uil8tnvfjwqTf0J9AyUQ/obAVY
X-Google-Smtp-Source: AGHT+IHc+yHGElyh/cV9RTXB00aZOZHQGcqcdMKjpzq3t8cBnM61nga7w+w941bQaY0ctHEju4Q3Ww==
X-Received: by 2002:a05:600c:444f:b0:41b:dabe:8633 with SMTP id v15-20020a05600c444f00b0041bdabe8633mr4832876wmn.21.1714887442255;
        Sat, 04 May 2024 22:37:22 -0700 (PDT)
Received: from [192.168.1.130] (51B6DCE0.unconfigured.pool.telekom.hu. [81.182.220.224])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b00418f72d9027sm15050957wmo.18.2024.05.04.22.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 22:37:21 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Sun, 05 May 2024 07:36:54 +0200
Subject: [PATCH v3 1/2] iio: imu: bmi160: add support for bmi120
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240505-bmi120-v3-1-15cee3d0b2ef@gmail.com>
References: <20240505-bmi120-v3-0-15cee3d0b2ef@gmail.com>
In-Reply-To: <20240505-bmi120-v3-0-15cee3d0b2ef@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.13.0

From: Danila Tikhonov <danila@jiaxyga.com>

Add support for bmi120 low power variant of bmi160.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Co-developed-by: Barnabás Czémán <trabarni@gmail.com>
Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 26 ++++++++++++++++++++------
 drivers/iio/imu/bmi160/bmi160_i2c.c  |  3 +++
 drivers/iio/imu/bmi160/bmi160_spi.c  |  3 +++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index a77f1a8348ff..90aa04d94da5 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -26,6 +26,7 @@
 #include "bmi160.h"
 
 #define BMI160_REG_CHIP_ID	0x00
+#define BMI120_CHIP_ID_VAL	0xD3
 #define BMI160_CHIP_ID_VAL	0xD1
 
 #define BMI160_REG_PMU_STATUS	0x03
@@ -112,6 +113,11 @@
 	.ext_info = bmi160_ext_info,				\
 }
 
+static const u8 bmi_chip_ids[] = {
+	BMI120_CHIP_ID_VAL,
+	BMI160_CHIP_ID_VAL,
+};
+
 /* scan indexes follow DATA register order */
 enum bmi160_scan_axis {
 	BMI160_SCAN_EXT_MAGN_X = 0,
@@ -704,6 +710,16 @@ static int bmi160_setup_irq(struct iio_dev *indio_dev, int irq,
 	return bmi160_probe_trigger(indio_dev, irq, irq_type);
 }
 
+static int bmi160_check_chip_id(const u8 chip_id)
+{
+	for (int i = 0; i < ARRAY_SIZE(bmi_chip_ids); i++) {
+		if (chip_id == bmi_chip_ids[i])
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
 static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 {
 	int ret;
@@ -737,12 +753,10 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 		dev_err(dev, "Error reading chip id\n");
 		goto disable_regulator;
 	}
-	if (val != BMI160_CHIP_ID_VAL) {
-		dev_err(dev, "Wrong chip id, got %x expected %x\n",
-			val, BMI160_CHIP_ID_VAL);
-		ret = -ENODEV;
-		goto disable_regulator;
-	}
+
+	ret = bmi160_check_chip_id(val);
+	if (ret)
+		dev_warn(dev, "Chip id not found: %x\n", val);
 
 	ret = bmi160_set_mode(data, BMI160_ACCEL, true);
 	if (ret)
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index a081305254db..d0ec5301ad9a 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -37,6 +37,7 @@ static int bmi160_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bmi160_i2c_id[] = {
+	{"bmi120", 0},
 	{"bmi160", 0},
 	{}
 };
@@ -52,12 +53,14 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
 	 * the affected devices are from 2021/2022.
 	 */
 	{"10EC5280", 0},
+	{"BMI0120", 0},
 	{"BMI0160", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
 static const struct of_device_id bmi160_of_match[] = {
+	{ .compatible = "bosch,bmi120" },
 	{ .compatible = "bosch,bmi160" },
 	{ },
 };
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 8b573ea99af2..9f40500132f7 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -34,18 +34,21 @@ static int bmi160_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bmi160_spi_id[] = {
+	{"bmi120", 0},
 	{"bmi160", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
 
 static const struct acpi_device_id bmi160_acpi_match[] = {
+	{"BMI0120", 0},
 	{"BMI0160", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
 static const struct of_device_id bmi160_of_match[] = {
+	{ .compatible = "bosch,bmi120" },
 	{ .compatible = "bosch,bmi160" },
 	{ },
 };

-- 
2.45.0


