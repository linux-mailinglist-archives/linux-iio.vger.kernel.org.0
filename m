Return-Path: <linux-iio+bounces-7512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D87392F0D8
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609451C20F10
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBD719F482;
	Thu, 11 Jul 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de05rCpV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24C770E6;
	Thu, 11 Jul 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732582; cv=none; b=boilFn7r/ez0Btkmptud/IugiGcjIArIA3UHWywTK9/5/ccz1TbMZKuL2HLSVFykQHRPoGQ4R7PdjVFXIx0Bf1/TK7XQpl1QZg8ELJtQCKPg+xB+WxtvOMyxZ5c5Go6voRmyl/jzMBsbC8w/o4F2eWkJ6Mx0ve5inXw/2tA7yuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732582; c=relaxed/simple;
	bh=Rwdi6Q9D/I6KXmAJBUQzkxRoJWu0Llv7++pHrz2iMhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pk0wZ/TEgkwhBwa9hNMHueNDb2i0jF47No0sCbrOqTNGf41brqbZ4UeMhdId32SmZnDX4zPDB/fgpQPgEnumgsQLLioalth4RTWV9w9rcACjzoEpSvfmqcY2Ql0SpmNSl4HYdLsVTP1fdHK/M/snYXHfK5DjPbEIann7ZhyEDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de05rCpV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so18238711fa.2;
        Thu, 11 Jul 2024 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732578; x=1721337378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9nzgbT0FGdXa+0/Jx/FoO1y5bmb3p3axOlg8rQy+GA=;
        b=de05rCpV9AGdmzUt/hrrVI9UTgcLOvUokLiS0L6M9WswtjZdCTgQAOWbHh7b+KDzja
         Ncx0Y+JyBQzsLVld9iFM/NzvnbzF7UY1JaqUVoJJgUloLLxLqELw/2IcRfppM0joxCaF
         PetrkVpZwVaPr5stX8GhSktGlazSMJ701jmSb95sQ/gw0TY3UeA58zHWdG1xj0C8oVy7
         xior/sZMbAopyNUfKwyl0BMjWznAt/fS7XqOBae1iB8UKpuKDc8VdkyGnqr9aGma+Xz+
         gxqXXg6QF9JwHLOXruPQJ0BBQf/fceZfMLiuKSnv1ONFUTUT9877wE8CftMRxix+70Fw
         4aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732578; x=1721337378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9nzgbT0FGdXa+0/Jx/FoO1y5bmb3p3axOlg8rQy+GA=;
        b=eao3arxXlVEpWS8l4WKkPoDErI+93XZavdvMgMWKGOMfBvdnd1iD/Y75FhtS/EvKcR
         n6G5RAmHmoqjdVJc+szDaxuw7PZIB1LSRmLjXW9jEB4Zn/bqgai4FYFtL/ouoFTZfXEu
         vk0oofvPEDpFU41qvVajrdhHsrh33tCJNGZuEuHe1kbJ0gv/QNbUvJFmpCTBGrcZtSjg
         kBqgw7/Ufl2IQF7MVRmg4ObOqushZMVzoYIl81btLrPhc8EFEPTifhLb6pMhZPuYFcUx
         eoXWxO8JtxLdaYTZZRisgseQKlHkPF8ix0Ue0ezmTgcaiZjtX7h+bcYG6VhGmWMkvVZ7
         nBjA==
X-Forwarded-Encrypted: i=1; AJvYcCVZQLbXRMWTWnNPx7Rix+RiFFLl7paRWvz1gTltB6VoYiMhbttAvF/UuHNeGBVShFNBMH8oRldGByrEzIGoNjtZbLmbBXimUQvmxOG3Nu8IKcsVw0EkrYlT9drhilEXe5WkbK6CNWY8wTfw95M6irt2+I+ciJURDHeL+F3GhwHYs/b05A==
X-Gm-Message-State: AOJu0YzZIfhr54R8e5Bt5wwrN6Kj4kcGpN1bJIrxYCFo2xk2AtWdrwpn
	MOQhZpkNzKs93rHjnGHRDpfewoZUzCsKnJQ11TQSyyIApsryYXF+
X-Google-Smtp-Source: AGHT+IEbD49X4NpzCy3qwikcrZ+FoIhWYVb1Yw6YPmcCJQ0KCme3Qfs7oMTtOuTsOYNIzKuTSgT8xA==
X-Received: by 2002:a2e:b0d8:0:b0:2ec:53a9:2037 with SMTP id 38308e7fff4ca-2eeb31887d7mr62051581fa.37.1720732578082;
        Thu, 11 Jul 2024 14:16:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/10] iio: pressure: bmp280: Fix regmap for BMP280 device
Date: Thu, 11 Jul 2024 23:15:49 +0200
Message-Id: <20240711211558.106327-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now, the BMP280 device is using the regmap of the BME280 which
has registers that exist only in the BME280 device.

Fixes: 14e8015f8569 ("iio: pressure: bmp280: split driver in logical parts")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c   |  2 +-
 drivers/iio/pressure/bmp280-regmap.c | 45 ++++++++++++++++++++++++++--
 drivers/iio/pressure/bmp280.h        |  1 +
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 2fc5724196e3..cc8553177977 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1186,7 +1186,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.chip_id = bme280_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
-	.regmap_config = &bmp280_regmap_config,
+	.regmap_config = &bme280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bme280_channels,
 	.num_channels = ARRAY_SIZE(bme280_channels),
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index fa52839474b1..d27d68edd906 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -41,7 +41,7 @@ const struct regmap_config bmp180_regmap_config = {
 };
 EXPORT_SYMBOL_NS(bmp180_regmap_config, IIO_BMP280);
 
-static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
+static bool bme280_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case BMP280_REG_CONFIG:
@@ -54,7 +54,35 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP280_REG_CONFIG:
+	case BMP280_REG_CTRL_MEAS:
+	case BMP280_REG_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP280_REG_TEMP_XLSB:
+	case BMP280_REG_TEMP_LSB:
+	case BMP280_REG_TEMP_MSB:
+	case BMP280_REG_PRESS_XLSB:
+	case BMP280_REG_PRESS_LSB:
+	case BMP280_REG_PRESS_MSB:
+	case BMP280_REG_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool bme280_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case BME280_REG_HUMIDITY_LSB:
@@ -71,7 +99,6 @@ static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
-
 static bool bmp380_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -167,7 +194,7 @@ const struct regmap_config bmp280_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-	.max_register = BME280_REG_HUMIDITY_LSB,
+	.max_register = BMP280_REG_TEMP_XLSB,
 	.cache_type = REGCACHE_RBTREE,
 
 	.writeable_reg = bmp280_is_writeable_reg,
@@ -175,6 +202,18 @@ const struct regmap_config bmp280_regmap_config = {
 };
 EXPORT_SYMBOL_NS(bmp280_regmap_config, IIO_BMP280);
 
+const struct regmap_config bme280_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BME280_REG_HUMIDITY_LSB,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = bme280_is_writeable_reg,
+	.volatile_reg = bme280_is_volatile_reg,
+};
+EXPORT_SYMBOL_NS(bme280_regmap_config, IIO_BMP280);
+
 const struct regmap_config bmp380_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 0933e411ae2c..4b0ebce001df 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -490,6 +490,7 @@ extern const struct bmp280_chip_info bmp580_chip_info;
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
+extern const struct regmap_config bme280_regmap_config;
 extern const struct regmap_config bmp380_regmap_config;
 extern const struct regmap_config bmp580_regmap_config;
 
-- 
2.25.1


