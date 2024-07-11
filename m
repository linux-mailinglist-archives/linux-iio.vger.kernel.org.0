Return-Path: <linux-iio+bounces-7516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE7D92F0E5
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5751C2295C
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7D21A0715;
	Thu, 11 Jul 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ3erRy/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B01A00EB;
	Thu, 11 Jul 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732586; cv=none; b=qlabfqmhBdLgjsdiKer/FfS7cG9klabtB6UX4yPiFEca3xZZvLOHu6jOmZPhk1Qm/n/JPlyv/JsuSztacMUCD/W6tuqZzKNpOUz8Fiu0JZme2xTiSwlDCsGNPwF7WPIFwqMznLqZGZGGBp4svHb4Fqoi+Z8vH8I6nXUz0t0vGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732586; c=relaxed/simple;
	bh=oNz9jbnau5US66OL2TkVYMflazhurOtygod0jl8rWz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjoB327NRCiUO8z6LkoB3hqbk1dOYsfVJGAuxl8Jl40NZALsdt5/37telECS8OnuMcQj5poOL0ht8nukpVFf69GP1X6az/dU4iZW6lxPMm6CrUfVIZKU/Wb/J7SWu450uGkbDoRemNTfKIgUKVPBbe8THfvmw7esyx4JzT3Gt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ3erRy/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so17161141fa.2;
        Thu, 11 Jul 2024 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732583; x=1721337383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCp4C86w9awpHIw8DaJsMnbo3g5VipSX+X5uHPVqBok=;
        b=GQ3erRy/GF71EVkXkuVZalM3BvOR/JNzNJpyyjURiCIhFMcBlwf1yYtKxiM9KgPe4P
         FpI6cH6QJI0gTpUs7g+m+L7dOJjL+j/llT0mjFPb2Mv97FlkRIk/AH1OJXBrbaPd/9zU
         9DGQnr/wkbYhIwiMTpixS50psNly+HmOnoR5P1ykhe3Vfj0DSWLJ4iCxGtMMLDYWOaS2
         ylG+p7EgeMaOvGbbn1LzVwq6+tecnfjxxgmXk4f4+1HRmtivFuc9a0g3FHj0/TmJUj6S
         fcsZ92pYiYXqWrlbEqZhljv5LcPA9qEoHi57LnU9awz50m+RsgpljK6u18eeiv1yeb6d
         U7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732583; x=1721337383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCp4C86w9awpHIw8DaJsMnbo3g5VipSX+X5uHPVqBok=;
        b=Ve2tgJ2vW1Bsl9mwx8bBSFFiOGFIuUwfg8t/Qof+hrcROQMJPOWVgPzw8ss0fW5SK3
         6Gvw4cLt4y9B+pEP5FRWy/bEYpqrAneX/GvJoELepk7eUr4tsGBqkLZD67gkEA85dAmo
         k6gMlYJ59ysjBolYjtx5tB9NFFYfsGuTseFZmfSt+9Wus0YjXhzf2n4cvUxn/lT57F8Y
         tf3LS98Mdt3nczpyx30xmVc/Ujz5f6s7hYJUeJsjx/uQsIOlglTHwCRknsoYNbbU1zMx
         jwu+1PQGqcr8Q49/d9ZqkmZJCUAGXnIW93Iy+nU4Ie6buDtVAfGZQMJ8gQxt0gRRZ8jK
         7Q0g==
X-Forwarded-Encrypted: i=1; AJvYcCVcw5kJv+1huXZhdqHc+91rF+SQbtg9YA4SKUWG9IyXSPfvrSbzYXLg8RAR93Pxd4QZIxb7orUZZYqVWhIbF/Bsw85QlGE9TtoPU0uZlkcb0tGKd3g5jGCzeLqc4i8C2OCS3/2GcVvsQE9OvPYWCk44WSNYZMz2uR0FmIHRTg6sTZMGZg==
X-Gm-Message-State: AOJu0YzBlKQforv08KU74ZwHc+K+3q3HAGd5kw5oomhl+bipI3JxCMVB
	bT8FFlGVh0EREDR0YuMqfw0I89fEopyZ7t7BcNaLgeHwBN1GvtSk
X-Google-Smtp-Source: AGHT+IEYZLAB94CBOmZJVnkxcftaT7/EGoAOq6CXg50riSEJYqiv8MglGKQVpKvOSm6lRLQ5iAFNLw==
X-Received: by 2002:a05:651c:102f:b0:2ec:1a8b:c374 with SMTP id 38308e7fff4ca-2eeb3198692mr60717471fa.45.1720732582984;
        Thu, 11 Jul 2024 14:16:22 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:22 -0700 (PDT)
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
Subject: [PATCH v1 05/10] iio: pressure: bmp280: Add support for bmp280 soft reset
Date: Thu, 11 Jul 2024 23:15:53 +0200
Message-Id: <20240711211558.106327-6-vassilisamir@gmail.com>
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

The BM(P/E)28x devices have an option for soft reset which is also
recommended by the Bosch Sensortech BME2 Sensor API to be used before the
initial configuration of the device.

Link: https://github.com/boschsensortec/BME280_SensorAPI/blob/bme280_v3.5.1/bme280.c#L429
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 28 ++++++++++++++++++++++++++++
 drivers/iio/pressure/bmp280.h      |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 9c32266403bd..caee586b2268 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -958,6 +958,32 @@ static const unsigned long bme280_avail_scan_masks[] = {
 	0
 };
 
+static int bmp280_preinit(struct bmp280_data *data)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
+	if (ret) {
+		dev_err(data->dev, "Failed to reset device.\n");
+		return ret;
+	}
+
+	usleep_range(data->start_up_time, data->start_up_time + 500);
+
+	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "Failed to read status register.\n");
+		return ret;
+	}
+	if (reg & BMP280_REG_STATUS_IM_UPDATE) {
+		dev_err(data->dev, "Failed to copy NVM contents.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -1074,6 +1100,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
 };
@@ -1191,6 +1218,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
 };
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 56c01f224728..02647454bd02 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -205,6 +205,9 @@
 #define BMP280_REG_CONFIG		0xF5
 #define BMP280_REG_CTRL_MEAS		0xF4
 #define BMP280_REG_STATUS		0xF3
+#define BMP280_REG_STATUS_IM_UPDATE	BIT(0)
+#define BMP280_REG_RESET		0xE0
+#define BMP280_RST_SOFT_CMD		0xB6
 
 #define BMP280_REG_COMP_TEMP_START	0x88
 #define BMP280_COMP_TEMP_REG_COUNT	6
-- 
2.25.1


