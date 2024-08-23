Return-Path: <linux-iio+bounces-8721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3F95D525
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C78D284CA2
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6091925A9;
	Fri, 23 Aug 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR/kcwLd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3801922C0;
	Fri, 23 Aug 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437044; cv=none; b=PgbVG6Jp5qvvcb27g3BdPiMgDSdbg5jrXdCFtZu+NZ0iDyOg1YfpXNZBSH3IDuJ1FEL3mnBSTKZk6E2vqxxKOrtamt7CwaUrrAzYKX0hXh9Q00utS1mZWvHmhyHFPVvuLhwzqTApG+41+iXkRM/dlOkQ89vqVhjMZtXvthvhlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437044; c=relaxed/simple;
	bh=dInEK1RyoEbx8ygTH0UIyODtMxSFAhWcTeVnffqBY8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krsPT2mxjsMSbb8/rH/99MhJaRlu6pERrXmTFUOeW9OYyFYQXCkYhuOtvtHhOK7IwgpzMsIQx+fcnGCCr+aH5DdAFlu85wHBwl1S4AB3y09fYv5npHX0458HzQ077oqTcGIW70vqusQrchUPD2Rgd2Rwx0UDc/i3eAAuHhhysY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR/kcwLd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428119da952so18506945e9.0;
        Fri, 23 Aug 2024 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437041; x=1725041841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nol3XnobnccYGXWjsSL+QwZzmXq+Own29WJ/wbPBdgk=;
        b=eR/kcwLdIGZ5tENCkaNngPUTi6dB0y1CBJz+zkaqMnxnpTnELKgqHFOaCJq1lZ0oZ3
         fKki/jSNQGb5mJAg/q65Ny4T4YfGetoG0qkoxmxEI7zlWDS0LtpFl999uiz3gchE+U74
         +fZdzAMLEjBbgyn9pn02iVob5m/0libeOCfvtAcYHek2Ce0Z7aCn4DZnwJrX4c0FZm1i
         2RyQfCXqMPheajMmENEIsTqr7mhhSlHzKfDxfkRco+7jyPdyHCJBETOosTvp/tY1m8XR
         G2TvVCcjRlItAYGQgKr+WQ6s0V+I4MUPVE0rHC2IyJ9SDsqr1TCFapNppeB0dy/GSeS8
         +7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437041; x=1725041841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nol3XnobnccYGXWjsSL+QwZzmXq+Own29WJ/wbPBdgk=;
        b=cKdpycxi1g+kkdKmX6tgWP+Vgb8xIeOslCmrxbLCcRA07Pnth1tKu7J/0d33JJ3jN5
         PO02XjV5cHi3dioaNh6LTtidnpW00OAJ3sRpuEHRDcOq8OVJIN88waEPjhttDqe19toY
         fUtq5hby1vUUskP0eFbVODeJBYWFKfGtJKYhY6Oj+pZIlKMuhAp9OpJ4zPhwYsqpjlf0
         CftwGzPepTwOzO/zyKtkRqWR1LYml5/BD+9C5soQp+KykQ3UmUIvvzPlew5K2Uzws+H2
         m1bJe4YWTP/PO8jzqIcXWyvyYxyFuKYbuaqJ8wdvVbPQVVIsnYD9+wCcRmekMZHINW/f
         P3oA==
X-Forwarded-Encrypted: i=1; AJvYcCVPHrmQx2FVJFJ8K7T2rr2Prgo+BWAkFDnFm51eTvNRdLYhBmouIUEQBDqv+vXZLgg8a8AMTG2USAT0XOw0@vger.kernel.org, AJvYcCVkIo5UBMC64Bd0VMO0l43SbpoD15yXGlI86eCTDR/f4T+35j8mZ1Ca36s1jl4JYwWs9K4bn4NjhWAa@vger.kernel.org, AJvYcCWKPIWtO3pNlfFuzhsSlwTqCyK/PdymqV6tP3ubOPhNY6wcLCJHPYN51HpigaxolXQG7jYvtuV9fXIX@vger.kernel.org
X-Gm-Message-State: AOJu0YyyS6TDwGCP4gvnRjdx+JwiHMBaj7eiZ+c75dzmHQh0tT4etfSW
	GPpJm6Gy5dhDV9cvQK0yH1PGYKHQBpTvkkb+O3zcbKkAht/VnYAB
X-Google-Smtp-Source: AGHT+IGy/pxOyZdjCPAqNV54p2ut2qDfwuz42B5CWo92jB82B1jfwDxcLoKPba9RAYjmBd/ejhBWwg==
X-Received: by 2002:a05:6000:1f89:b0:367:9ce3:1667 with SMTP id ffacd0b85a97d-3731189afa4mr2351730f8f.15.1724437040947;
        Fri, 23 Aug 2024 11:17:20 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm4677939f8f.44.2024.08.23.11.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:17:20 -0700 (PDT)
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
Subject: [PATCH v3 2/7] iio: pressure: bmp280: Add support for bmp280 soft reset
Date: Fri, 23 Aug 2024 20:17:09 +0200
Message-Id: <20240823181714.64545-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823181714.64545-1-vassilisamir@gmail.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 26 ++++++++++++++++++++++++++
 drivers/iio/pressure/bmp280.h      |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c23515048081..e01c9369bd67 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -965,6 +965,30 @@ static const unsigned long bme280_avail_scan_masks[] = {
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
+	usleep_range(data->start_up_time, data->start_up_time + 500);
+
+	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Failed to read status register.\n");
+
+	if (reg & BMP280_REG_STATUS_IM_UPDATE)
+		return dev_err_probe(data->dev, ret,
+				     "Failed to copy NVM contents.\n");
+
+	return 0;
+}
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -1082,6 +1106,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
 };
@@ -1202,6 +1227,7 @@ const struct bmp280_chip_info bme280_chip_info = {
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


