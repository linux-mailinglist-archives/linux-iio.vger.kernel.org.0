Return-Path: <linux-iio+bounces-8849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302589632F9
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 22:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6ED81F2527F
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8927A1AE025;
	Wed, 28 Aug 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DepO+fp9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48811AD3E3;
	Wed, 28 Aug 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878301; cv=none; b=HYLaLoP5xx28Gfh4r24GsTbhJ43LQI8wbBxQO8xIDig7fyR8f9mN1Y/NmTCLxR4rhXsgh0ulCu+sz0/HrHmKAIBgHE+CXz0AHz3MsYlaKcko0+tIpJHTEBboEv7mRcz1TIDKo6HZJEnRlVwmeyiI1sIZ73x58YOzENIi6amKS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878301; c=relaxed/simple;
	bh=vls9EuVu0bQaZPZBOJSZopuadCL4aBlQi8cbRT/QtzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXseWP1ZOGdCKbIxVCm5BBTTILrAIkQZfCvsKreuNeb8xI0XPZZWeRDIbWQo9zYkd0n8NWqNxPv6QS/yJap+LM8ks7GRM5Hx9qy58DzUz5535ZVwm8dbDUXSnYsARcd/4zGo550rKCfC0yfzX5JsOeRHhTC4kdtIS1yat2kz1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DepO+fp9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso7937495a12.0;
        Wed, 28 Aug 2024 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878298; x=1725483098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmUinFSzzE3WO95ZRcc7laRZdgnoTLEoTy9z6rGQ07o=;
        b=DepO+fp9bPshuPIxI7XjNrGMFXDEN4K6WW+n5fTzqOEnnuKzHD+MdQgEP4q1ATMI7x
         9VsnJrc9xGIFBBJXI7Ar6FbdTMAOp+0b9lNKrZpbvXRKqTkZdf8o8jbcgxrjBVJTEMAm
         DjfPg9DrFHrWaEq45cK48Dm5Lb9BXFc1yVT2K8qP8hMwk5yKk/FrPlHBB628v0/YgD2N
         jFQrwmHxytYTHAkDkK0pihwlRqKFIvlwEwSr55AaSNqHkQfFAkpf9vc/v/RJriJcSxjI
         x5xBkChOG+PWJCw8/TAUQ8RITtqZEghdWz7jUjvU4cjqLI2AHPn3Jm+Kgmpr7QTce+WR
         FzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878298; x=1725483098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmUinFSzzE3WO95ZRcc7laRZdgnoTLEoTy9z6rGQ07o=;
        b=k8sfEEK50DjdqOWZ1AVW+Nz5GEU9KCLgp+cfGeMkZmsnhrNJAo+7oDsEXH4nIbI5v/
         4WD6HmfvVm3kTddYubbm4PXPxb4JLEuUV5vI932D/dJ6T/NIMhrQxt/WT7znD1y7jOaJ
         aUpn2DiblLxS+od0PTL0+mCQbYnnhA//TTUR3+MVwtsoDrR5rqOFjASzPUziA8tknFCw
         nX9gTcuwW0b1hJ65/AsgZIkrEjJVsv++1lMD3m2ta5ue78bwueXlXQKjbqpg80LJya2i
         SB+lCQ6UtzlLnpIop6XiVOvr0E2UcRhCn4siqvy1mItY+ZxTbiwXyS6UuVqyUVfnDa4/
         pDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPtIKIgc86h1nLAW3EfzVKXT28i8LxWYocGyGt2Hf2LQRftlJxu0IpUykmmpQvyS0Hl35Z0ZBSXPgWx75X@vger.kernel.org, AJvYcCVXa1tWquzALIvn1HM0lxNuYVIe7ZmH5Bg9qCAj8xF7Pdk8QO9uVLvyuP4kJ6mpee4AF9/38+qLyX7t@vger.kernel.org, AJvYcCVxgpG3mjtVky3BVYtTnqbOu4DdQjWtc9daQ3NKI9ge9aTUernVeWCRcEXh0iWbb+7X0pbPKTBWK6M9@vger.kernel.org
X-Gm-Message-State: AOJu0YyoLZT/JKy8RuD561YN1gNgBDjK2gcho1ORg6PKLrN7lVX0i+Qt
	uxxUFNGkowcRWoPIbd71PO5Plm7sNNjkP4ePLkGiWXBN8iG3M/+X
X-Google-Smtp-Source: AGHT+IHFWw+TAr+FZNVGYM5sflWZXs/B2vQHD5ngf0A+Y7U0Ougy1cgRZf55M+qLmiDqDlCci4FpHg==
X-Received: by 2002:a05:6402:1ed1:b0:5ba:8ad7:4859 with SMTP id 4fb4d7f45d1cf-5c21ed3e1damr619677a12.14.1724878297280;
        Wed, 28 Aug 2024 13:51:37 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2f53sm2646566a12.19.2024.08.28.13.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:51:36 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v4 2/7] iio: pressure: bmp280: Add support for bmp280 soft reset
Date: Wed, 28 Aug 2024 22:51:22 +0200
Message-Id: <20240828205128.92145-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828205128.92145-1-vassilisamir@gmail.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 31 ++++++++++++++++++++++++++++++
 drivers/iio/pressure/bmp280.h      |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 9c705f2c4a7b..193a8fcbb5d8 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -965,6 +965,35 @@ static const unsigned long bme280_avail_scan_masks[] = {
 	0
 };
 
+static int bmp280_preinit(struct bmp280_data *data)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Failed to reset device.\n");
+
+	/*
+	 * According to the datasheet in Chapter 1: Specification, Table 2,
+	 * after resetting, the device uses the complete power-on sequence so
+	 * it needs to wait for the defined start-up time.
+	 */
+	fsleep(data->start_up_time);
+
+	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Failed to read status register.\n");
+
+	if (reg & BMP280_REG_STATUS_IM_UPDATE)
+		return dev_err_probe(data->dev, -EIO,
+				     "Failed to copy NVM contents.\n");
+
+	return 0;
+}
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -1082,6 +1111,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
 };
@@ -1202,6 +1232,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
 };
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4e675401d61b..73516878d020 100644
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


