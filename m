Return-Path: <linux-iio+bounces-7896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6FE93CB12
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D891F23EA0
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302A149DF0;
	Thu, 25 Jul 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA+wDTPD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E11494C4;
	Thu, 25 Jul 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949051; cv=none; b=kQE80rWe26VY3RI8DFf8og2U68fcJro631Ta7n+tHOGkymE3LZFAInh27vIR6LRk70Sjbw4TVg5PoiUVEuTcDTukYLObAiVx6le07w64bVt7X+oTZiUyIYWwE8JkIIVRKr3zr3eR23yjaPVYTI0yYBJV3+Ohd5YBO7ZCRUc6Qi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949051; c=relaxed/simple;
	bh=ksdn5wB+tta7x/8oVgg9wypSwwNZ9K6lCaVpblbLZs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwAQyIIfYzWpXrPRJ7CQJ0ImP1KnadPhPpV8i48cMZATBlLoQp93gs0fSAjPBT1ci2ij1lGuLQYWjoWQXpM63Iy4W49uwbuDA0YzVuWjk0LwYboJw5Vj+PNRI5Sz7WTHGPL6+RqGLipnPL4RhI3GifAySytnuZY0pntKIZASeJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA+wDTPD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aada2358fso185350166b.0;
        Thu, 25 Jul 2024 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949048; x=1722553848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1oyEP+an+rM2gjFALCv/EpHEYlPmPknAR8aXXGP/Y0=;
        b=aA+wDTPDAjogAXtxxF26qL3mIV3FdWEahBBatopSrd5fLVPmbCnnTV+G/pMX2wgHpu
         cImXHi/QTu74dp+gE8ntkCrqbIKl+HL7W7bO+sOjv1niYxUJE+otl8zX27i8hCm2fHTe
         +ZtmaqUhxdnU4ld2sSFNUo/iSzaOyVzwiRtEhjisV+L5X3Q3BEwcg1lrpUYLhdSeugky
         XPyxna+yBMU4pzD3oILDdmRDhLG84wBdBnmaDy/3Nv9sQO0AjtwrVAgxYH+uKVwGyZ9e
         E5oZn43K/7beOA77JPpYxJ9l0w3tMn3AVHLt3bmm3Z0txKFgCC1y8UJn9ngRukhS09Xq
         MuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949048; x=1722553848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1oyEP+an+rM2gjFALCv/EpHEYlPmPknAR8aXXGP/Y0=;
        b=l7m20OwvHukxtnmGEZV/EgtFnX0ddQQhydWYGIs66ySuuQM0QzuFsWAXYMbq0GZTTf
         iEVMdLb9L7SBEcwEVPvwcP+3ik4nH1LQP5PcDop41HcaXyVvWQMfSnwdBYR+nYSw1lsK
         9C4RiGm8tFWkwEjbogFSW8Wz3GPPFI8mMCX0NXmQ7eBh+p12b49tfEjiuf9JDce1H5hU
         IL9BRHXyRfepUFj07QvTrfGlvsU5pp1xLID11s1yqusD57MxF3ft/NH5plhhv/kpax71
         F2H+NXcMudDjVIZVPRgvubKeYFl1D80HHoFXoQbhxJCFOylHwh6wyI9o9RgPFIQkisTQ
         E6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnmD1k5PVEulQABjWERowJxrw+/xJkOvX8EDBcxAZX8tcBbWohnjCb4VmEMu0+VIwWTIfNWrUoTil0lWgii2NUEeDxLl+QQV4qjrbkHNKLo3hpO2QpqjHwNRWLANoXdyVtfV5+efmN9MCSVqRZnezkfuJyifYWOax5tWj2Blv0yd8v7A==
X-Gm-Message-State: AOJu0Yw2R8TYiyiX8J8IXeBL8K1W39TPkcikFUpDH15B6OgtX2YnvAQS
	hJ1O2QjFSoK9WWb0vuB5ZXgOpaXhLcMwhfADlPL3ltGHqelap+7p
X-Google-Smtp-Source: AGHT+IF3ExE82pbTxPu5JshPyHrsv0Qoi+brVSypnQOZVZ7IJWFwLg8VOtfhbdzAKktNy/vb39daYg==
X-Received: by 2002:a17:907:7209:b0:a7a:a2e3:3739 with SMTP id a640c23a62f3a-a7ab2ed1448mr726184766b.20.1721949047729;
        Thu, 25 Jul 2024 16:10:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236e3sm115429266b.25.2024.07.25.16.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:10:47 -0700 (PDT)
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
Subject: [PATCH v2 2/7] iio: pressure: bmp280: Add support for bmp280 soft reset
Date: Fri, 26 Jul 2024 01:10:34 +0200
Message-Id: <20240725231039.614536-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725231039.614536-1-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
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
index d5e5eb22667a..acbc33aacc09 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -963,6 +963,32 @@ static const unsigned long bme280_avail_scan_masks[] = {
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
@@ -1079,6 +1105,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
 };
@@ -1196,6 +1223,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
 };
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 9bea0b84d2f4..a9f220c1f77a 100644
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


