Return-Path: <linux-iio+bounces-10417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC8F999412
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F76B218A2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087131E4121;
	Thu, 10 Oct 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9fUfsKt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8E198E99;
	Thu, 10 Oct 2024 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594044; cv=none; b=KVpHVXq1QKs0FaEx0kylhHau8RXGkQegOrSmDf0PekLWJ9psZ8AlL/CH/9vOoSzJP4Lxto1YmLD+1KuUX/CcZGw5lhPCSHfhuIZ8F1TWsH9WhatIzbQtL17INdxh35gZi4f/exVpOVmJO/tGqafuW0463hTq1mXEKSJ/7cuL3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594044; c=relaxed/simple;
	bh=PcDsXuaDHFvvIWrdoWi3vPz31G5jOSTAdjECd3pMCf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5FdhC0vQVTWeq6v++nBRjHBCN8Oo7r0wPPU/ITTGYo57RDamYCr0fG35ooVcQIF1WM05TO14UB/mc7M7l7EQxgIEL+RlX/HO6hpWzzjQAx0hvV8SYZNkka5I8ODx9ln09BbPoKbMLEH2U+dKCQvV0B92HM93hrV68K5VFMbUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9fUfsKt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a993302fa02so216736366b.0;
        Thu, 10 Oct 2024 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594041; x=1729198841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDfuWT3KuSpR/j9jD4F3+URq4vBzo64UPX30bJI27k4=;
        b=X9fUfsKtJbnwDIwGRmW8fRMkl/NXbDa7W7kuamSo7X3H3gZYmySFSF1a7qgZYq306f
         dIH00gK74VFKxGwtFjuLfsvGltKVY3XiKXrsUXmOS1LH5UX/v2+YfC108KG526VZ3kMu
         8IKv6IT6GrUXSp3yYBp7rsdpj/354//xQ8H+ChvWQEKUBgl/z1ipPOOrvKXI/eX/DlOo
         CwPuF0p3hBXTcObz3lmg+trIhjwXJAcc0B0Vyk+/GxX841pE7d9P/YLbH6S4ROgL4Xsv
         d/Sjf10GZVgoeSRYQgCvI3bKFgbYCrxfvUp4Ty7/tZsltfm0Mb1usRe4nftGvH2wqM9q
         KIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594041; x=1729198841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDfuWT3KuSpR/j9jD4F3+URq4vBzo64UPX30bJI27k4=;
        b=Ic+p1pNpLMuBNwE8fO/XGZxqQJ4dH9QACYw/J2qWVyBuxhZGu44AVX1pmuE2sx7GzB
         pfHtuOB09CmKvjvOrZ77DbboBVEn0ALf5PQWJYZJ9l5yT3TCCqDDL71K1Dr0byqNWKQ7
         4FxMiwUZmSh69OpF9S/Ksl3td01NonhG5hddPEeg9heUsxZOKTtd7O4/KBoftbUgX2xB
         tJY9pir3eS2fbrL9/1THZKvbMoevWzsFfE0j++XtRwgUef8uwGwKTJKHeoGpDLWgyx+2
         VA/uPqIoGxve4AAdBW6uzhpXobrB7e2k3n0PQSPVPuIp6UMjp7JMg+sDDx2GAYWO3PIb
         OHYA==
X-Forwarded-Encrypted: i=1; AJvYcCUCX/y+/lF1C6t5z6evb2T3IcikzIYHlO8ebU5UV/ewOkgRw5bzyTWHApp/YaCRUAJEeYAbfS5JLauD@vger.kernel.org, AJvYcCWmVQ7KZ6UJkmh+F1zT7xVgw9ErQoEI5CUdpK2nS1LiFTtJxsCu0NdNI2F3EMETXhWFXFqC1LVJkFqUaIy4@vger.kernel.org, AJvYcCXt7UEGVDDqQe04zIRCzlieni9zoFI8fDx29/wnyJrEB6KUcc85kM2L2dWHtl5utPRBhp/MWDKb7d+v@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2e2CO6psPfptuQ7khEj1M9qPGjDubqwr274T4AlbCI9WDNCYG
	Pp0VPscfuNf2d8g6qX/kU5OKQOAI809bWLsiYQc+MP0uBu0b2/TsfdeCVwfF
X-Google-Smtp-Source: AGHT+IEOBugJZVxAAB70AO/HZqDfhHLexouLS4frx+Bu0kyOUCGEfddPd5eMYCno3hP2yYylfWFMRA==
X-Received: by 2002:a17:907:c14:b0:a99:7539:2458 with SMTP id a640c23a62f3a-a99b95ee9f8mr18638466b.65.1728594041058;
        Thu, 10 Oct 2024 14:00:41 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:40 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/13] iio: chemical: bme680: Fix indentation and unnecessary spaces
Date: Thu, 10 Oct 2024 23:00:18 +0200
Message-ID: <20241010210030.33309-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Fix indentation issues, line breaking and unnecessary spaces
reported by checkpatch.pl.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 33 ++++++++++++------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 5d2e750ca2b9..95a667d56527 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -224,7 +224,7 @@ static int bme680_read_calib(struct bme680_data *data,
 	calib->res_heat_val = data->bme680_cal_buf_3[RES_HEAT_VAL];
 
 	calib->res_heat_range = FIELD_GET(BME680_RHRANGE_MASK,
-					data->bme680_cal_buf_3[RES_HEAT_RANGE]);
+					  data->bme680_cal_buf_3[RES_HEAT_RANGE]);
 
 	calib->range_sw_err = FIELD_GET(BME680_RSERROR_MASK,
 					data->bme680_cal_buf_3[RANGE_SW_ERR]);
@@ -294,8 +294,7 @@ static int bme680_get_t_fine(struct bme680_data *data, s32 *t_fine)
 	return 0;
 }
 
-static s16 bme680_compensate_temp(struct bme680_data *data,
-				  u32 adc_temp)
+static s16 bme680_compensate_temp(struct bme680_data *data, u32 adc_temp)
 {
 	return (bme680_calc_t_fine(data, adc_temp) * 5 + 128) / 256;
 }
@@ -445,12 +444,12 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
 				2136746228u, 2147483647u, 2126008810u,
 				2147483647u, 2147483647u};
 
-	var1 = ((1340 + (5 * (s64) calib->range_sw_err)) *
-			((s64) lookupTable[gas_range])) >> 16;
+	var1 = ((1340 + (5 * (s64)calib->range_sw_err)) *
+			((s64)lookupTable[gas_range])) >> 16;
 	var2 = ((gas_res_adc << 15) - 16777216) + var1;
 	var3 = ((125000 << (15 - gas_range)) * var1) >> 9;
 	var3 += (var2 >> 1);
-	calc_gas_res = div64_s64(var3, (s64) var2);
+	calc_gas_res = div64_s64(var3, (s64)var2);
 
 	return calc_gas_res;
 }
@@ -468,7 +467,7 @@ static u8 bme680_calc_heater_res(struct bme680_data *data, u16 temp)
 	if (temp > 400) /* Cap temperature */
 		temp = 400;
 
-	var1 = (((s32) BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
+	var1 = (((s32)BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
 	var2 = (calib->par_gh1 + 784) * (((((calib->par_gh2 + 154009) *
 						temp * 5) / 100)
 						+ 3276800) / 10);
@@ -571,9 +570,8 @@ static int bme680_chip_config(struct bme680_data *data)
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
@@ -587,8 +585,7 @@ static int bme680_chip_config(struct bme680_data *data)
 
 	/* IIR filter settings */
 	ret = regmap_update_bits(data->regmap, BME680_REG_CONFIG,
-				 BME680_FILTER_MASK,
-				 BME680_FILTER_COEFF_VAL);
+				 BME680_FILTER_MASK, BME680_FILTER_COEFF_VAL);
 	if (ret < 0) {
 		dev_err(dev, "failed to write config register\n");
 		return ret;
@@ -664,8 +661,7 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	return IIO_VAL_INT;
 }
 
-static int bme680_read_press(struct bme680_data *data,
-			     int *val, int *val2)
+static int bme680_read_press(struct bme680_data *data, int *val, int *val2)
 {
 	int ret;
 	u32 adc_press;
@@ -684,8 +680,7 @@ static int bme680_read_press(struct bme680_data *data,
 	return IIO_VAL_FRACTIONAL;
 }
 
-static int bme680_read_humid(struct bme680_data *data,
-			     int *val, int *val2)
+static int bme680_read_humid(struct bme680_data *data, int *val, int *val2)
 {
 	int ret;
 	u32 adc_humidity, comp_humidity;
@@ -706,8 +701,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	return IIO_VAL_FRACTIONAL;
 }
 
-static int bme680_read_gas(struct bme680_data *data,
-			   int *val)
+static int bme680_read_gas(struct bme680_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
@@ -889,8 +883,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
 
-	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
-			   BME680_CMD_SOFTRESET);
+	ret = regmap_write(regmap, BME680_REG_SOFT_RESET, BME680_CMD_SOFTRESET);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to reset chip\n");
 
-- 
2.43.0


