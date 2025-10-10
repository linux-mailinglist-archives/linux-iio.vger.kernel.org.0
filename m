Return-Path: <linux-iio+bounces-24900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CBEBCCBEA
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 13:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C4284E0EBE
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A62EF651;
	Fri, 10 Oct 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="xnByoS9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F172868B8
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095435; cv=none; b=qenPwh9BRUgjhNVTOC3Yhzo82UMHsMUYSIJFCb1oKhpiBk9RGIOh4gTvBDID+uZ8Y/PTx21fOlYO8KD2l4DPLLu7IbxXM8dWkFG2zgf0s1P7w9cY9RLjCJJVkBP/K84QdeA53ndfVfmjKin0wPF0KrlrcY+n8hOQHrIDmrKh38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095435; c=relaxed/simple;
	bh=mMyIIkLVcrrb0wPuX0C0VvYdWc2+/nklktp5ep9npF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3nV9mID2ZT5n7aAW/NYMIvbILV1HshueH3xpFahQOg8zKGK/CqbfZsM2fRphBxQE+4MrIpGEh00uVb5WDh+8YBVZguhb8kg2U1hQ1XLv/WJgS+siLVfyfqft+Rv5Ypt8dww8N3MpDwj61MOZY5KnzhzKyVX8I+72URmTwkTh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=xnByoS9p; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3d50882cc2so366455266b.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095431; x=1760700231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELgsobtQfQYaj2rheZjWea7ydMelXZKML2smUF3KeSo=;
        b=xnByoS9pEkkTleuUmhMi/srI51rYrB+qK2cf9qFXmPQApLecd6DuT24lfMvvAa8Nxc
         ie23i2JxEA5dZxEWP39/dux2h86sDR/6CYymTk2yjiFTHDsLsvvtY6WHUDEbYspTUqq1
         Uy91aoUNrvp4cDo2ySZDRt1gHn/kwLYGp8UW9SSsco0sNvKGr4pYF247oyugbgtXjz1W
         VnLn8hXtKgYnmh8c/xYg+9GGe59f1IBpcrbXrjB+Bhyro7TyektbpAJ0T2aAKUjz76iT
         77TRLIhq+5nYJbqnaCScJ0y/L66LuQ8Vww0Q/ebqvLxN9CWi5MDvZVbNtlQtmWVnONjd
         vpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095431; x=1760700231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELgsobtQfQYaj2rheZjWea7ydMelXZKML2smUF3KeSo=;
        b=wTFgynewNm6t70iWittP2azchzQDTTZOlukBYA5vbbtcWRPUhelLbvFunMAuoQlTfC
         Bp8nPyW9oCAQiHcRJkFvhxS75d9UlKCNNAdDbxfrlKJ8RltBCoXYecK5y0GGjFMH2kgX
         StXkuycSiIG0+6z6ZF1FG9KzpNXR3q9GnaNeOe51WoCMnm5XPceCFvBCRunq1axdkegj
         Bh8y4TZ3COSJAfujjcLAU4X5kNtoD4FcqqgfzY8OMh1d/km2wjEo6qRPY0lFWuTIxBV+
         A4nqAINcLVADYl1qK9a0ipWbDTlzZQzjfWFpee0Wh5gfprb8iMkakfMsXdOa+Bx5eq5z
         PDnw==
X-Forwarded-Encrypted: i=1; AJvYcCUMxN490iM129zkev3mVYVYJyohkBvKPTGRb+bw2nB7Ah6z6mlfXj7+paTPGb7AyNgLkSowGMAdKTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68aJNvxBG+IM4LD71WuY6Y08es4K+xZMq/PqRAkGdHaw6SEd3
	OxSYC398nv/I6VFbjtapYKpjKvU3dAbjVIN5osU2ArCT2kLD/FFKaI75zMzIxkUnqeE=
X-Gm-Gg: ASbGncuhJtOV/1Pg8+j0ZXeSY4qgpuCgvKI+UeogoUYSJRfFsIHdM9wh5HvTiDgvoxG
	itbTQXTVJFeBWBohElJgTSHR8euE/dVN3cI7fN3qiVXApqQJhZ4c3+4xJD2ZC2pCBX7DyaGLZvg
	CYKbChn+wa5saMXwpMiD7zf4DKtXcmgYlIuHy8mBxRMbl2d3+oltssDdjjN7LKDC3FRQm1lj9jr
	BN/JUlUoGdhfw3fSUzvQXLizm0WJ8DfiWMW2XmYrFjYJBiFTlxQBv7oyVE8GLxHhKYTE8wq1BL+
	Io/7E0b5isxmyQ9jSkggkT+1IlTyrTF7EmWcbU7SHrZRM2PKyeWJ2zkq7sbHme6E/4g2MBeE28x
	OFywyFjZfAHqm2gOlDZfZ3pmXWTWrHMgVSRX2see9DCGQxfuwkFoe0LOD6l90rn4PqawkW58P1a
	m9HJAz/U9L3efNLCyCQy8=
X-Google-Smtp-Source: AGHT+IEazEcfDMQ1uS/zgK2E/jPXEFvp5XK0p+/bmCtELkuTX5ruB8Jnspac8zh5gskZvsO37vvhug==
X-Received: by 2002:a17:907:d1d:b0:b3e:109c:6377 with SMTP id a640c23a62f3a-b50ac0cc054mr999397666b.35.1760095431074;
        Fri, 10 Oct 2025 04:23:51 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Oct 2025 13:21:59 +0200
Subject: [PATCH RFC 1/6] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-bat-temp-adc-v1-1-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=4302;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=mMyIIkLVcrrb0wPuX0C0VvYdWc2+/nklktp5ep9npF0=;
 b=Anj4djN5fZo5UopPnPuOgAqUeaPAFisNGoBoBxVpGh9NSw16i8ZAnv+A3uAwEefrFWd9OsbKn
 MdneIq8lbwPCVlC9ITCcTngYAU+EQHqQVzOywSna1lVKqGAZaGtrx4w
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the BAT_THERM channels with millivolt as output, which can then be
used along with information regarding the NTC in the battery, to get the
actual battery temperature.

A static lookup table in the ADC driver won't work since different
devices have different Ohm and Beta values in their battery NTCs, for
example a NTC can be 10kOhm & B=3435K.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c         |  6 ++++++
 drivers/iio/adc/qcom-vadc-common.c       | 16 ++++++++++++++++
 include/linux/iio/adc/qcom-vadc-common.h |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index af3c2f659f5e..6ad75368d3a3 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -543,6 +543,12 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
 					SCALE_HW_CALIB_XOTHERM)
+	[ADC5_BAT_THERM_30K_PU]	= ADC5_CHAN_VOLT("bat_therm_30k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
+	[ADC5_BAT_THERM_100K_PU] = ADC5_CHAN_VOLT("bat_therm_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
+	[ADC5_BAT_THERM_400K_PU] = ADC5_CHAN_VOLT("bat_therm_400k_pu", 0,
+					SCALE_HW_CALIB_THERM_VOLT)
 	[ADC5_BAT_ID_100K_PU]	= ADC5_CHAN_TEMP("bat_id", 0,
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index b03cf584b165..09a13e2b0ef4 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -309,6 +309,10 @@ static int qcom_vadc_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
+static int qcom_vadc_scale_hw_calib_therm_volt(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec);
 static int qcom_vadc7_scale_hw_calib_therm(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
@@ -333,6 +337,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
 static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
 	[SCALE_HW_CALIB_DEFAULT] = {qcom_vadc_scale_hw_calib_volt},
 	[SCALE_HW_CALIB_THERM_100K_PULLUP] = {qcom_vadc_scale_hw_calib_therm},
+	[SCALE_HW_CALIB_THERM_VOLT] = {qcom_vadc_scale_hw_calib_therm_volt},
 	[SCALE_HW_CALIB_XOTHERM] = {qcom_vadc_scale_hw_calib_therm},
 	[SCALE_HW_CALIB_THERM_100K_PU_PM7] = {
 					qcom_vadc7_scale_hw_calib_therm},
@@ -583,6 +588,17 @@ static int qcom_vadc_scale_hw_calib_therm(
 				 voltage, result_mdec);
 }
 
+static int qcom_vadc_scale_hw_calib_therm_volt(
+				const struct u32_fract *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_uv)
+{
+	*result_uv = qcom_vadc_scale_code_voltage_factor(adc_code,
+				prescale, data, 1000);
+
+	return 0;
+}
+
 static int qcom_vadc_scale_hw_calib_die_temp(
 				const struct u32_fract *prescale,
 				const struct adc5_data *data,
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index aa21b032e861..3ae091fa93d7 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -93,6 +93,8 @@ struct vadc_linear_graph {
  *	voltage (uV) with hardware applied offset/slope values to adc code.
  * SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
  *	lookup table. The hardware applies offset/slope to adc code.
+ * SCALE_HW_CALIB_THERM_VOLT: Returns voltage in uV of a temperature channel.
+ *	The hardware applies offset/slope to adc code.
  * SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
  *	100k pullup. The hardware applies offset/slope to adc code.
  * SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
@@ -114,6 +116,7 @@ enum vadc_scale_fn_type {
 	SCALE_PMI_CHG_TEMP,
 	SCALE_HW_CALIB_DEFAULT,
 	SCALE_HW_CALIB_THERM_100K_PULLUP,
+	SCALE_HW_CALIB_THERM_VOLT,
 	SCALE_HW_CALIB_XOTHERM,
 	SCALE_HW_CALIB_THERM_100K_PU_PM7,
 	SCALE_HW_CALIB_PMIC_THERM,

-- 
2.51.0


