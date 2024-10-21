Return-Path: <linux-iio+bounces-10898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B010F9A904C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353C21F22475
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9802B1FBCBA;
	Mon, 21 Oct 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEMCesX0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFC1FDF9E;
	Mon, 21 Oct 2024 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540416; cv=none; b=k+1xo1LSyqgU93xLTidHC51OBhH8s60YJ1RXWGIpk4Osm+qz9T8voV95bJDz/neggvmYsm2n4GNjjzx0Jm2jzQhWwnNQJ7Xcl053uCy7h9OrytBqJMuPKbQS8OsD9kJo4KLGW8HsGhSWYL7HZemZFB5kfZCvwsEOlBW5NQVcysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540416; c=relaxed/simple;
	bh=vyQi9ZTVnpbOKfBHPIcB5RMs9bY6xG8O3WtbCaEM738=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUAYXdxuGdxYR4Rt3EaIDB6yVM6//H1SFRM7K+sWsrfY9KUNOT7/YChJODZV4P9nwyflOHppQ9cBFQjS5ig+YcgGYUoxsgU4Ewu0TCB0r81yY5ySIObLPSt21s2CQbpxNa5NRIhzQSl0TLpSyvg6dJTxFc06DUSigSrpiboqzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEMCesX0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so27937785e9.3;
        Mon, 21 Oct 2024 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540413; x=1730145213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40gsg2Bc+Fe/tDyauIqUSjZTx45Ksw8BC4m72iFnA2c=;
        b=BEMCesX0k2Gn5LaEO6b4nbO/eK//D9g/T/HWbvqHJeTGcx0QrpZqwBU7zy40GwbJ57
         upMJUu1ZhwpzJwXJFFFNAeZ7ps5ukBui28WTVtHdyJiZdVbsmEZqN6/TswMDUOUtxG/q
         o9z1axftrzsvWjh8n5ZgYiR4F0tskSU79KXiISPOrNK1HgXAu7PrbaAIW9U4PdViHqfy
         2kFwkMPPAX3K+hRde+zG1iN93dbKEXfs2YWTQKXuIjApYKy143yQ4V6mHZiLKKfcTd+d
         oDtA0TcBMP3lUwLcAKTWQ5eGtZlzhbaW3mLvCZnvL1pRlJiBzz169vm0irscBRPt/MIn
         nP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540413; x=1730145213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40gsg2Bc+Fe/tDyauIqUSjZTx45Ksw8BC4m72iFnA2c=;
        b=ChUTOPiCkHkBKvppsIrPz+OOxoBAcCuh4m5bzyBipwMWv7GIRhtD36/KaA+AouwkE3
         WGnDJdtjS+zKJzApdeF3pGJ5ukjxzjPtDXkW7Kcjhz9D/t1YMKkF3l3mpmuN5N0Nl3/m
         Zh5o7ABJ7TuewpLZlqk1r3oNXUns0TPNzSlUuCBb34AynwHUsSMIN5R9KUjBMVmtF6an
         9Y9FcMA22o7EWXMmavnuh+9Z2Ai4QejR2VCqR4Vrbaktl95m8xjtwNXHjmsdmDc+21B7
         ueDuBim0QfBPaEloHYgZF8NEjs1qeYvcjls6JKzYeCKPv+xh1v4zKdUKtB5a+VRMJuIL
         w16A==
X-Forwarded-Encrypted: i=1; AJvYcCU89eSX2k9DGmSTf7OT5t1Hd9woFeb8CVkQhhCxb0r4KRT1FQYjnhxa4PThQU3im5L/fSWso8e3Axp02w48@vger.kernel.org, AJvYcCVzCTxZCS8cHW/dJJaCTWL+P675IJ3rIzphF1+DWIH0S8dyLqmkrB1XmJrqLWmtUvXkrjCRj8hKveM5@vger.kernel.org, AJvYcCXdlJDOXAbPO6nfh4ZSYfx2vXeD66Fk33hchK9P7z0VXEBPS6YfGkNvq6cK93jQM6R6oRLTnIsAYEWC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0OIDInQaijHYYKkj1Kfm7CEUzwXqCYyaeAdUwQ4yFNJauNf8
	jht/3elL2tTdQnOB6OtFEOASqoS9ltqHIeFW2UMbX5PzcBbwC8s+ybwMRA==
X-Google-Smtp-Source: AGHT+IHwj9o1i1V0HMBSOt42E/or9FfHo0hiuTGCPj37k6RUpifDaLmfQVgHNwaRTJjOgzVQXzmY3Q==
X-Received: by 2002:a5d:67cd:0:b0:37d:4318:d8e1 with SMTP id ffacd0b85a97d-37eab6e3db3mr7563883f8f.23.1729540412883;
        Mon, 21 Oct 2024 12:53:32 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:31 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] iio: chemical: bme680: Fix indentation and unnecessary spaces
Date: Mon, 21 Oct 2024 21:53:09 +0200
Message-ID: <20241021195316.58911-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix indentation issues, line breaking and unnecessary spaces
reported by checkpatch.pl.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 2ff85e29bfc1..2ad427f5deb4 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -229,7 +229,7 @@ static int bme680_read_calib(struct bme680_data *data,
 	calib->res_heat_val = data->bme680_cal_buf_3[RES_HEAT_VAL];
 
 	calib->res_heat_range = FIELD_GET(BME680_RHRANGE_MASK,
-					data->bme680_cal_buf_3[RES_HEAT_RANGE]);
+					  data->bme680_cal_buf_3[RES_HEAT_RANGE]);
 
 	calib->range_sw_err = FIELD_GET(BME680_RSERROR_MASK,
 					data->bme680_cal_buf_3[RANGE_SW_ERR]);
@@ -450,12 +450,12 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
 		2147483647u, 2126008810u, 2147483647u, 2147483647u
 	};
 
-	var1 = ((1340 + (5 * (s64) calib->range_sw_err)) *
-			((s64)lookup_table[gas_range])) >> 16;
+	var1 = ((1340LL + (5 * calib->range_sw_err)) *
+			(lookup_table[gas_range])) >> 16;
 	var2 = ((gas_res_adc << 15) - 16777216) + var1;
 	var3 = ((125000 << (15 - gas_range)) * var1) >> 9;
 	var3 += (var2 >> 1);
-	calc_gas_res = div64_s64(var3, (s64) var2);
+	calc_gas_res = div64_s64(var3, (s64)var2);
 
 	return calc_gas_res;
 }
@@ -473,7 +473,7 @@ static u8 bme680_calc_heater_res(struct bme680_data *data, u16 temp)
 	if (temp > 400) /* Cap temperature */
 		temp = 400;
 
-	var1 = (((s32) BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
+	var1 = (((s32)BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
 	var2 = (calib->par_gh1 + 784) * (((((calib->par_gh2 + 154009) *
 						temp * 5) / 100)
 						+ 3276800) / 10);
@@ -569,9 +569,8 @@ static int bme680_chip_config(struct bme680_data *data)
 	int ret;
 	u8 osrs;
 
-	osrs = FIELD_PREP(
-		BME680_OSRS_HUMIDITY_MASK,
-		bme680_oversampling_to_reg(data->oversampling_humid));
+	osrs = FIELD_PREP(BME680_OSRS_HUMIDITY_MASK,
+			  bme680_oversampling_to_reg(data->oversampling_humid));
 	/*
 	 * Highly recommended to set oversampling of humidity before
 	 * temperature/pressure oversampling.
@@ -585,8 +584,7 @@ static int bme680_chip_config(struct bme680_data *data)
 
 	/* IIR filter settings */
 	ret = regmap_update_bits(data->regmap, BME680_REG_CONFIG,
-				 BME680_FILTER_MASK,
-				 BME680_FILTER_COEFF_VAL);
+				 BME680_FILTER_MASK, BME680_FILTER_COEFF_VAL);
 	if (ret < 0) {
 		dev_err(dev, "failed to write config register\n");
 		return ret;
@@ -885,8 +883,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
 
-	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
-			   BME680_CMD_SOFTRESET);
+	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to reset chip\n");
 
-- 
2.43.0


