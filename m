Return-Path: <linux-iio+bounces-13784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D56019FBF34
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 15:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90071884EDE
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73131D9A49;
	Tue, 24 Dec 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LhMJh62T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39EA1D90DC;
	Tue, 24 Dec 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050644; cv=none; b=AsnyCBB5v07guAuZre7mHaC0l/Iac5Mv2IlIbiPmoKMFfDH0+QjcAN6zrzgX02UOyp9A3Rg4tCPNARwZ1ZxGUMF2JLaNZgHhY3gTHNwhgaXuv4K/fHyp0JUVqwKORMg+9UEF7mOuQhrM+I2g4J//0ZgPfquF3eEk8nZiMfM2Kng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050644; c=relaxed/simple;
	bh=M3DLRx5kJOCugjbybd6OV6+mmQFiQwxHLl1HA0kraUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVOoJPzvxKI/YrIdya8l8/ZsvIHScnxL+13LbS4pNsljNamsdtJCTTbY16yO7sILaHBDr+Y8Qu5MMiaHSs/krpIc7QybTmZu1NCl9qukyX0wPOuOAjE23g1HtMqGKwvQJTOZkcZXRANgxXhPfR1cP6Y71KApHWKpi1H7h0IIfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LhMJh62T; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6a618981eso876966866b.3;
        Tue, 24 Dec 2024 06:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735050641; x=1735655441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtIDcdlTcL47l1JyKAXSQb+DUXo1fGrqYZ+NRkBcaJ4=;
        b=LhMJh62TlDfmo4NfTKy/CjIB64aeR+EvaHGoMV7qs/FumY5qeUhHPfqfFu/BjcWPQO
         vPAYXNyVgbPtaCmLx5KUZFBYjvMEAmqtAR3MMd2gxaR3IFamiYCBvocEiJDTBdd6Tjwc
         Et+3137pO4/XH+tByrNu8aoCUvhKiJgekNOGSozOUuH6SUYaKpH9x8SL5vSLMXFBd4en
         DcxtNNaZhYPw/0NLglTzLOfvXzl0geulbjESPlhCZcs/BZ1g+jaOeXhjGTAzuaZHC5Lq
         XxPFGq0CVZymRve0Rb9Wu9BRx5OS+vTFGWS3YZiaplWyg5mWrY6pJ+lJFVM2p4jMY4xt
         /YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735050641; x=1735655441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtIDcdlTcL47l1JyKAXSQb+DUXo1fGrqYZ+NRkBcaJ4=;
        b=gzierh2yBIV5pO4ELPGg9sIhQ0mxtTNlQ/c+Q2pm3xy7nL862jYXLwZjvnKfUaL+gR
         3J/TFbvqcU/OOPeUx4KgXSNDcHGN4hEuu9MvBbHjqQK+ARaeC/Q2vO7A08XH22Vn72dO
         i8NecoTgnjlKgM6Rokc0J+tMd/rtORQhI3VY8T/dMPBgkd6kNSedVyLtfo/GGem2tVFs
         D5yftqKLTHx+jLsw2eQzL/X84kBWiv2z2h/P+O2WmE/h0zwPspHzE3JJQUNoeMaMbArP
         yMZvv4NwmA3uPpY4O+hqzuWik/nlWPL7pBSE+64FjuSE8Np0V776aDVPPpBrabpz7G79
         tdfA==
X-Forwarded-Encrypted: i=1; AJvYcCWNDEiIs8ANC9pVer7DOHGHUBLIzpYpbJp7jeVqK9KmaNR4ggCNy+muVroSLM1hoXfKC3+vJtKYMlwTPGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQ3ld9TxF2VZyCazq4nw106isZcaJDqg8g35nSYDGuG4ovSjo
	n685qoKTVOGg6by7DZbkEaPIeegFjBX9qOmV8bIv2egUESZrJbTAFdZ9Lg==
X-Gm-Gg: ASbGncsvAH9mUqs4eRYEkMRtRTYD1Kc9u+wDuOe7weR3U3ha/CYeqpzgmevhy7cIxgn
	qlKcLM9idQm4eP+8DiK6NZLggCdenTYl+xrA1no7mrDR7vDB9yTFS5dUJLpbdLu2MpjD9W2NOh7
	tj1fPUBBKqdFVVNgUlKZIKqr31R517js4ndN2pMQaQ3A/Ba4mrjyb5dntCj9UpALiTZE2OULc0Y
	/t3v1iZLge7r2iZGqwORlvYGi74Lq6VAOwwu9npSuxG0al8dQ6T6ZkxyuqLYGmDygYbwDu+Bfxi
	IAK/GMGkb3qHq4947oQ5MpHxzcBgs8br3MSUkiv/euXEMB9w6YfEW/Vwbg30Jm3MWRF0aRxgGHQ
	GaD5PCzM=
X-Google-Smtp-Source: AGHT+IHbuxvtjRdu0Ntf+3XKJZS8NGXLreQtkLnmulcwU+OEWzchjnRtrfW5QBwUKRofxzAHfpMq/g==
X-Received: by 2002:a17:907:944b:b0:aa6:73ae:b3b3 with SMTP id a640c23a62f3a-aac2d13c90fmr1732470866b.32.1735050640570;
        Tue, 24 Dec 2024 06:30:40 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-a5d7-4700-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:a5d7:4700::e63])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0eae74e4sm658827166b.91.2024.12.24.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:30:40 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	gnstark@salutedevices.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/3] iio: adc: meson: simplify MESON_SAR_ADC_REG11 register access
Date: Tue, 24 Dec 2024 15:29:41 +0100
Message-ID: <20241224142941.97759-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224142941.97759-1-martin.blumenstingl@googlemail.com>
References: <20241224142941.97759-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simply check the max_register value to decide whether
MESON_SAR_ADC_REG11 is present on the current IP revision. This allows
dropping two additional bool fields from struct meson_sar_adc_param
which previously had to be manually kept in sync. No functional changes
intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 469af3c57066..997def4a4d2f 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -315,14 +315,12 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
 struct meson_sar_adc_param {
 	bool					has_bl30_integration;
 	unsigned long				clock_rate;
-	u32					bandgap_reg;
 	unsigned int				resolution;
 	const struct regmap_config		*regmap_config;
 	u8					temperature_trimming_bits;
 	unsigned int				temperature_multiplier;
 	unsigned int				temperature_divider;
 	u8					disable_ring_counter;
-	bool					has_reg11;
 	bool					has_vref_select;
 	u8					vref_select;
 	u8					cmv_select;
@@ -976,7 +974,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 			   MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
 			   regval);
 
-	if (priv->param->has_reg11) {
+	if (priv->param->regmap_config->max_register >= MESON_SAR_ADC_REG11) {
 		regval = FIELD_PREP(MESON_SAR_ADC_REG11_EOC, priv->param->adc_eoc);
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_EOC, regval);
@@ -1013,16 +1011,15 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 static void meson_sar_adc_set_bandgap(struct iio_dev *indio_dev, bool on_off)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	const struct meson_sar_adc_param *param = priv->param;
-	u32 enable_mask;
 
-	if (param->bandgap_reg == MESON_SAR_ADC_REG11)
-		enable_mask = MESON_SAR_ADC_REG11_BANDGAP_EN;
+	if (priv->param->regmap_config->max_register >= MESON_SAR_ADC_REG11)
+		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
+				   MESON_SAR_ADC_REG11_BANDGAP_EN,
+				   on_off ? MESON_SAR_ADC_REG11_BANDGAP_EN : 0);
 	else
-		enable_mask = MESON_SAR_ADC_DELTA_10_TS_VBG_EN;
-
-	regmap_update_bits(priv->regmap, param->bandgap_reg, enable_mask,
-			   on_off ? enable_mask : 0);
+		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				   MESON_SAR_ADC_DELTA_10_TS_VBG_EN,
+				   on_off ? MESON_SAR_ADC_DELTA_10_TS_VBG_EN : 0);
 }
 
 static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
@@ -1186,7 +1183,6 @@ static const struct iio_info meson_sar_adc_iio_info = {
 static const struct meson_sar_adc_param meson_sar_adc_meson8_param = {
 	.has_bl30_integration = false,
 	.clock_rate = 1150000,
-	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
 	.regmap_config = &meson_sar_adc_regmap_config_meson8,
 	.resolution = 10,
 	.temperature_trimming_bits = 4,
@@ -1197,7 +1193,6 @@ static const struct meson_sar_adc_param meson_sar_adc_meson8_param = {
 static const struct meson_sar_adc_param meson_sar_adc_meson8b_param = {
 	.has_bl30_integration = false,
 	.clock_rate = 1150000,
-	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
 	.regmap_config = &meson_sar_adc_regmap_config_meson8,
 	.resolution = 10,
 	.temperature_trimming_bits = 5,
@@ -1208,10 +1203,8 @@ static const struct meson_sar_adc_param meson_sar_adc_meson8b_param = {
 static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
 	.has_bl30_integration = true,
 	.clock_rate = 1200000,
-	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 10,
-	.has_reg11 = true,
 	.vref_voltage = 1,
 	.cmv_select = 1,
 };
@@ -1219,11 +1212,9 @@ static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
 static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 	.has_bl30_integration = true,
 	.clock_rate = 1200000,
-	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
 	.disable_ring_counter = 1,
-	.has_reg11 = true,
 	.vref_voltage = 1,
 	.cmv_select = 1,
 };
@@ -1231,11 +1222,9 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 	.has_bl30_integration = true,
 	.clock_rate = 1200000,
-	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
 	.disable_ring_counter = 1,
-	.has_reg11 = true,
 	.vref_voltage = 1,
 	.has_vref_select = true,
 	.vref_select = VREF_VDDA,
@@ -1245,11 +1234,9 @@ static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
 	.has_bl30_integration = false,
 	.clock_rate = 1200000,
-	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
 	.disable_ring_counter = 1,
-	.has_reg11 = true,
 	.adc_eoc = 1,
 	.has_vref_select = true,
 	.vref_select = VREF_VDDA,
-- 
2.47.1


