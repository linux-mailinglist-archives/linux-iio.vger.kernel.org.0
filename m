Return-Path: <linux-iio+bounces-9022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D538F968DB9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2917CB20B58
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A64B1CB518;
	Mon,  2 Sep 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjQPp7g+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDED1C62AB;
	Mon,  2 Sep 2024 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302551; cv=none; b=jAfQJMoIMdCCm1QJgSQNRm8xdMZgoOxV86ISdXE11+aiD8zJVI9oyvKopPiZD6kUKfPYszqS91M2B7YZW4b+D6wFFF7Lck/CDzFwM5w1cXWLqpxz+9nTN7WQ1kTbnH/a78GMbV08nMaKcIE2iqZKVy1xXFTCK1uFO+BirPU/zP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302551; c=relaxed/simple;
	bh=QyAVJGMiAY2LFK4Kijid6vcfHvf1Mrht5kDDvvp6A04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEn7Nju6iLl43mVSUEeafB+oRyr70PxmhgrbRV+pGaJkZN1fqG+DUdBt9Jc7NF99Hxiun9bFN5OuLE2h6fJhYyL1muqIRO+2Qb1eSoaYrN3Orhz2ppNAPZobf6RAzVrkZpyAuaY5do7u5uwOyJw8Tpni9SV/MBC9TDKNpZ9WtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjQPp7g+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso4462172a12.0;
        Mon, 02 Sep 2024 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302548; x=1725907348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxkS+G4/mG3C/JwlvfIOcjaZNNcAt8BK5nQ0rGeJ7ik=;
        b=IjQPp7g+2/8EkBFxAqoqoI8ath1Azr/wl/+PwJcVcomZkzS1FDSfumTmgaLVNbjaBP
         BuE07NcmlZXbyJDId3DcaEQVlnnU2RQRuW9sHm3XypWj5PZ7lzPhK4wcUKwSVc6hsDe7
         oMZ1u3jfwqebeVD0WWyRjsuVkCplWf8ya9WVJocDTd/XXVAXMj6HD6Yp3tdb5OF7od2T
         4+csSAk4+DCVujklwhntA2rOiEjNCsFvM9Yos2PbiSbtwzVAj66IyPAgRy2yT0gdbIrt
         Dp94Wh/IeEk3FOFfzeZxDfmAyttkYWgiwh/HJRojtB6EBC/rTfvMtUw5Ox8xf7Qke1fJ
         GXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302548; x=1725907348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxkS+G4/mG3C/JwlvfIOcjaZNNcAt8BK5nQ0rGeJ7ik=;
        b=aZ9/NGRXcO2B4v5MLhZiaFh30u3mrfdLHWMaLUT7BMfc9f5J5eTTcDaDF18hAMqqJm
         L/UGISPNz0MUKXdPZSbfoKj4P6LqYdAj/V3ImFieNHRY3nBWHvgvRG12R7g7FumTYDI6
         W0Vdrzyun0WbfMmNjW5aoHN6T09J9rWHAO23RyawvZAzH5nuV2XFx5sjZ4Wbu4wfD6Tm
         9DyaHq+LNU+mWLvefckr7/RA8k/k6myuGP1uSEz3uSBPZkHKvMzc7prlCfk8XZEobawB
         8hK5nh4DSCwJIx9dQpLmayXs63W2wreg8SvAh8FJN2OhlQ4eDxZP5Hq3OR2lHFCLSDmZ
         Y7zA==
X-Forwarded-Encrypted: i=1; AJvYcCVK2JipU1xXTmnZrvB+K/vbeuMqaOM2NDMhaFbXcoGyvDXhGjh0lq0YEL5bbRyF3EjZ/fnD6oNqk444@vger.kernel.org, AJvYcCVsxUUfvPu8Kb5BJi2Tm365v6xlOF1EoJAQ07FQnKP/9CMUIaNRfCshT6PLwTzMRqLBkxrXqE3m4Uxu+1+c@vger.kernel.org, AJvYcCXD9jBuhKIpC1NP5Iz1cO+Le4FMs+h0rWqMb8f/zKy7Mk2yc0s189MANOJnN647UCmffrnHHSLqt/uw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3z4J0Ur7fU2/771Ko9WkOSFbHLPd6LgTnu+B7GVpqM2rYp9OW
	3UCz5/vpSYeriFOgb4q8r9WoxfXYBLo31YEzH9iZwFc6ymo1HzWmyuy8Zci6Sew=
X-Google-Smtp-Source: AGHT+IEnVfm9q127Nc664sYpi9I18/xqg8GawB8oiKwgk/iVnqmY/YwBTFR3zcPraNY513eUjfC5NA==
X-Received: by 2002:a17:907:7f27:b0:a86:e168:609f with SMTP id a640c23a62f3a-a89a1fdd5f7mr1187633066b.0.1725302547804;
        Mon, 02 Sep 2024 11:42:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec0asm590537966b.53.2024.09.02.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:42:27 -0700 (PDT)
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
Subject: [PATCH v5 2/7] iio: pressure: bmp280: Add support for bmp280 soft reset
Date: Mon,  2 Sep 2024 20:42:17 +0200
Message-Id: <20240902184222.24874-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902184222.24874-1-vassilisamir@gmail.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 29 +++++++++++++++++++++++++++++
 drivers/iio/pressure/bmp280.h      |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 3b221e16aa42..cd975fad2753 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -964,6 +964,33 @@ static const unsigned long bme280_avail_scan_masks[] = {
 	0
 };
 
+static int bmp280_preinit(struct bmp280_data *data)
+{
+	struct device *dev = data->dev;
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset device.\n");
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
+		return dev_err_probe(dev, ret, "Failed to read status register.\n");
+
+	if (reg & BMP280_REG_STATUS_IM_UPDATE)
+		return dev_err_probe(dev, -EIO, "Failed to copy NVM contents.\n");
+
+	return 0;
+}
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -1081,6 +1108,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
 };
@@ -1201,6 +1229,7 @@ const struct bmp280_chip_info bme280_chip_info = {
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


