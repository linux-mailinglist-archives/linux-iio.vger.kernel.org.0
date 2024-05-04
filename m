Return-Path: <linux-iio+bounces-4800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BA8BBBAE
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 15:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744AE281526
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50F92C1A9;
	Sat,  4 May 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOmMxs5R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42651CD3F;
	Sat,  4 May 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827647; cv=none; b=gqLOXQvt+hPch9xNCv9wDqN1k3AXC8DlTpv6APjTIw8bcP+OeoBLNupgb/L0gbpVEEzbNeXtzNEwZbwFSbg11voCAQFij58LazlLPu+MKKWFg977Wf6Fr6bc24pToOG51XPZR2TD182ADDMA7HAE1awK7btw1o0KFiZKS6dhhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827647; c=relaxed/simple;
	bh=QTUaeJzZmhyYybePZmbGnHJ9mzNoTDbedgqFEStBLgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JEsPuvp6BYgJUOzMASEhE0oFLvhwTCBffzhS4F2uiVPXxdFcR8o3jdZeB3aN/dyyvCPHeH+WI3C7hpRZKmQD6ocZf+c7fviXcoTU+1brgYnyQjUpuCVmjudP9FOCT82f0joIdiLAGD7OLs+6OF+N4ct15PED13IDkSWt+IhUL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOmMxs5R; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so4385261fa.0;
        Sat, 04 May 2024 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714827644; x=1715432444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyt/UJ+wQy7/zQyA/uXsrjlVTq/esAniIjm/2JYlJvE=;
        b=XOmMxs5RuSqNLQSuxrHfR/oVXSwMacDsTjjTdK2xaMSlndJzIYNoqebf5U7SAiL5Tx
         JuCZ5e45B0bPRMsT39ohQz8GLx2m2pQ68SomNcoE9vokPZJsyRPSx1HYXQUKILbRfxN6
         0tnLQxrRsvg/h2Y+YG30NoRLO6+EIT8OYmVgcOvw2z/0pas5f6Afsz7Ch98+W7yxxvJa
         FgoHuz2gaIRK7ys68Sew6kc6QMWEuAu2wqJ4pe2dmhHHSGLtgqOaEZKF9Dp886Vu3RbK
         95qNYr0TnC8egVrf2ASzN2BzuoCr8qj6tXkkbKZYdJQmF8h5kBonUlS4s5F9neS+uqu7
         778w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714827644; x=1715432444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyt/UJ+wQy7/zQyA/uXsrjlVTq/esAniIjm/2JYlJvE=;
        b=p71wvpx0/2k8B10dJL8KQB5h6sMAAE5ov/SYgtQTEnGj8GnaseZGjj+GHtRY48D2Jr
         LkA0bzwXCcGn0RUrlqk2jUcB4SAq0W1TRR8hLTtVo9D81mP5uKYsZChYoeiPFrkWL3sr
         6Iuuck6F7rCLj5IAWJInKK0WZMAQN2JMs6G9ZxbG30Pway74M/psUcIlhb5d46FGe/JF
         JTIu8qll7eunCT2HxKthDubxHGK1Y/yQSfgT6a9NQaTUQB9pV/IUzIHJnr/XJvHBK7FC
         6+CYnztS75bLZ93yLIDLkXij9p1Iv0Xr3EJs6WrgZgkbwh85FTauhrPUP3+MA7aXPp71
         wAKg==
X-Forwarded-Encrypted: i=1; AJvYcCWvpZ9rDJfiI62bRn7Qe9xQaLxiJbjmBrxW4lViV0H777WdsVTzFP+yxpu6ETLHr1glV3CFnrE76j7PsOp9UXxb+DF2kmtNw2SyeEk0OX6ZSGL9mqTLEYF2+b32ft+NsfF0TPk44rV/0Q==
X-Gm-Message-State: AOJu0YxB4/Seulc5QJkOdyy+3QEsMoTb1LRplnNUh+QebYyfP8EoiasW
	TSmlBhiYKh2SisPKPxwC4w5F0CXbcKyysZIl5oXexxeSg2hObki3
X-Google-Smtp-Source: AGHT+IFyIciXkDbvbhzjry+R1aJdvIy1b84y1uzuz1yYvcHkElDXrG/84HqmtW3xtyrqTiNrFKUfTQ==
X-Received: by 2002:a2e:9010:0:b0:2e2:b716:e67a with SMTP id h16-20020a2e9010000000b002e2b716e67amr967552ljg.1.1714827643787;
        Sat, 04 May 2024 06:00:43 -0700 (PDT)
Received: from [192.168.1.130] (BC24954B.unconfigured.pool.telekom.hu. [188.36.149.75])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b0041bf45c0665sm12888998wmq.15.2024.05.04.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 06:00:43 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Sat, 04 May 2024 14:59:48 +0200
Subject: [PATCH v2 1/2] iio: imu: bmi160: add support for bmi120
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240504-bmi120-v2-1-3b3ce6e1c3c6@gmail.com>
References: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
In-Reply-To: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
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
index a77f1a8348ff..468aa80318fc 100644
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
 
+const u8 bmi_chip_ids[] = {
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


