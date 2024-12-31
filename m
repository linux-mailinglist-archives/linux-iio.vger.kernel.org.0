Return-Path: <linux-iio+bounces-13872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4C9FF1A3
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87F41625C4
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1E1B423F;
	Tue, 31 Dec 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NdfhBbfu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D4189BA2;
	Tue, 31 Dec 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735674163; cv=none; b=ctShqUva6sXrxqzwwUv0Y5Bu+3m+5n4TtjRp7J5HNoMgdULmyNjjCPwiOCw09KktQtOlTmn0W/3lRa6C3EdZSzQEO/iqiNAFFj3ye1ollno97dmdCvLu9bHM0ioSjBaaU52kR3gLMPuDvQUi3hROCotAtzwvyaCaKpsJpy4URzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735674163; c=relaxed/simple;
	bh=MPOYkYon481krNsCMV3UbjmMEweeni9FE5L3eJtlKUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUpZndx0elfIUt0ufZ5Cbx45Vvx8rSMLRiCs/plTwUDpkoVd5taO2eHgzEqkg51N3LybmnOmaR9T8ikm1LRwd19fRzsCuTRAdUDc2klrPNJZ3iFlENsHM7POVqKiPg1iZFICuHhNsDDpruqK7ROBYr4fx9/y5YEdjeThxDR/ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NdfhBbfu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa67333f7d2so1475137466b.0;
        Tue, 31 Dec 2024 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735674160; x=1736278960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0rCVlJGM8FFZAG5A27B92FYIY+5Ez2lvNjy4sLQwHo=;
        b=NdfhBbfuPqKinhn47yVVl1D9Yj2mwymgJPYenG0hr49WcOtI5FRxZOUjQmzH/b2oVk
         fTTvrjIYxXMpA2IMsGWzeaRbiW58DxSqOnsWPxhJyNaEG4dV0SU8K5ZAyJ72yE+rtK6x
         IXS7xPPN4rwENCI/9FiL6n22WLLez1VNV8aB3ylAk4hUX+JtnHiyAdvftjASUUAwXO14
         3b/lJrQaytVh9fO4lZ6uEUIfPJScB2Wqq2bFtWBmxYsGHPtn4ht2m7OpbE7KVTF51r+q
         Yp58+imZJVrdx980nfweMxrxTTJz79VM8wtjo2r5vvZX50voSxqnjsl5UITJxnfb4Q+R
         PtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735674160; x=1736278960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0rCVlJGM8FFZAG5A27B92FYIY+5Ez2lvNjy4sLQwHo=;
        b=HNz2E39gLM71Oda3i+/kg7zlNk5gsFl7WdQ1JJ5Ji4sZ1ssl4LHE1EM/IfoC7msBrO
         2ZmINeoFTqG6XylQr1DrxUiuwmIkJtIV3nIb0911FLZkDqENfh8Mq9APzpJWhaiOTT9t
         cGLlsyV0U/gjro5zK/RakZGk5tJQrDiFgEkBAlYRJ0b/6MysOxhnXYXM4OxWLbZexil7
         P54YrBquqe4Jp4m93htz3BXAQWF7IC2xsbGxWNSoK1t6BfRpNPpXLPoIWGIvJ3Co7qQn
         MunTGb2drW+gWCzQRoTluqO0b7BTyznV0tA6gniEFdiVKxqZhFGtR7hqjGujaI38yC47
         O7qg==
X-Forwarded-Encrypted: i=1; AJvYcCUalJYSsoxtnfiH/XAL4KuLM32/IMFWrn4ZwoCskkzMGO+6agv87+CL1nu0QTzbxi/nEDKTP/QulUBR3aKi@vger.kernel.org, AJvYcCUb/RSDJEuWpxKJMfADH6DnA9hhR+t+XItYKaFeZ/QhOtFe7jW8hx4gq88/WpyxdU1hRgHJ6FQbKJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSZOZFvv4emNBDUtd5y9rZl9sGeegO5Hg7HQoZe5oA4Fq2Utr
	0Vs+LiffWD60XJYlrWkT9A1m3P17ZcaWunMgWrhCd+txTktH1YtkkyNM5Q==
X-Gm-Gg: ASbGnctQcV5G1VkhT/sahRvHRDSnGGzElbHDm1JsEXSkS0RA0EEJlbQefTeVG5LDSzN
	W5DZZcXMXwk+KzceLSIfqWez374HjtazD8LCBjgtFzIIR237ENEeDyhMCI2g7yC4/ixB8KSy4Rb
	PDyjoNGKWyuutxjaE5wUnxhF0Xb0Cbus9BBs3opT1aoDgJVyueaCL/ypbX8H+xs+JAOAHG7z2z+
	uU7R3C3r9dXqqTZjT2dvFO3mGC/sYWaUZfwMT3Vo84CfQJm8GUun5SNR8EXXM29lmXRc7DSpVS9
	KNilXiqBvf3E+WHlGdlLEXr7fOtfgUXkMh7s7hMPw28SmHWWBCm0T4oo0QKCuw8bYg8/2mIHQhq
	bkXYQq3Xtqrf5Lb82qHCwaawk
X-Google-Smtp-Source: AGHT+IFUyhcb9Cx4FtvKLUY9YCOTTUG3voJ3IdPFUMD6nijH05dZt6EZuVPrz0AfxFYRAHfrGVRcIQ==
X-Received: by 2002:a17:907:8004:b0:aae:b9e5:ed07 with SMTP id a640c23a62f3a-aaeb9e5f697mr2477282066b.58.1735674159532;
        Tue, 31 Dec 2024 11:42:39 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b300-ce00-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:b300:ce00:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f9acsm16237820a12.31.2024.12.31.11.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 11:42:38 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	christianshewitt@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v1 2/2] iio: adc: meson: add support for the GXLX SoC
Date: Tue, 31 Dec 2024 20:42:07 +0100
Message-ID: <20241231194207.2772750-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
References: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SARADC IP on the GXLX SoC itself is identical to the one found on
GXL SoCs. However, GXLX SoCs require poking the first three bits in the
MESON_SAR_ADC_REG12 register to get the three MPLL clocks (used as clock
generators for the audio frequencies) to work.

The reason why there are MPLL clock bits in the ADC register space is
entirely unknown and it seems that nobody is able to comment on this.
So clearly mark this as a workaround and add a warning so users are
notified that this workaround can change (once we know what these bits
actually do).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 997def4a4d2f..df15a2566ec7 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -160,6 +160,11 @@
 	#define MESON_SAR_ADC_REG11_EOC				BIT(1)
 	#define MESON_SAR_ADC_REG11_VREF_SEL			BIT(0)
 
+#define MESON_SAR_ADC_REG12					0x30
+	#define MESON_SAR_ADC_REG12_MPLL0_UNKNOWN		BIT(0)
+	#define MESON_SAR_ADC_REG12_MPLL1_UNKNOWN		BIT(1)
+	#define MESON_SAR_ADC_REG12_MPLL2_UNKNOWN		BIT(2)
+
 #define MESON_SAR_ADC_REG13					0x34
 	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
 
@@ -326,6 +331,7 @@ struct meson_sar_adc_param {
 	u8					cmv_select;
 	u8					adc_eoc;
 	enum meson_sar_adc_vref_sel		vref_voltage;
+	bool					enable_mpll_clock_workaround;
 };
 
 struct meson_sar_adc_data {
@@ -995,6 +1001,15 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 				    priv->param->cmv_select);
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_CMV_SEL, regval);
+
+		if (priv->param->enable_mpll_clock_workaround) {
+			dev_warn(dev,
+				 "Enabling unknown bits to make the MPLL clocks work. This may change so always update dtbs and kernel together\n");
+			regmap_write(priv->regmap, MESON_SAR_ADC_REG12,
+				     MESON_SAR_ADC_REG12_MPLL0_UNKNOWN |
+				     MESON_SAR_ADC_REG12_MPLL1_UNKNOWN |
+				     MESON_SAR_ADC_REG12_MPLL2_UNKNOWN);
+		}
 	}
 
 	ret = clk_set_parent(priv->adc_sel_clk, priv->clkin);
@@ -1219,6 +1234,17 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 	.cmv_select = 1,
 };
 
+static const struct meson_sar_adc_param meson_sar_adc_gxlx_param = {
+	.has_bl30_integration = true,
+	.clock_rate = 1200000,
+	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
+	.resolution = 12,
+	.disable_ring_counter = 1,
+	.vref_voltage = VREF_VOLTAGE_1V8,
+	.cmv_select = true,
+	.enable_mpll_clock_workaround = true,
+};
+
 static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 	.has_bl30_integration = true,
 	.clock_rate = 1200000,
@@ -1267,6 +1293,11 @@ static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
 	.name = "meson-gxl-saradc",
 };
 
+static const struct meson_sar_adc_data meson_sar_adc_gxlx_data = {
+	.param = &meson_sar_adc_gxlx_param,
+	.name = "meson-gxlx-saradc",
+};
+
 static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
 	.param = &meson_sar_adc_gxl_param,
 	.name = "meson-gxm-saradc",
@@ -1298,6 +1329,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 	}, {
 		.compatible = "amlogic,meson-gxl-saradc",
 		.data = &meson_sar_adc_gxl_data,
+	}, {
+		.compatible = "amlogic,meson-gxlx-saradc",
+		.data = &meson_sar_adc_gxlx_data,
 	}, {
 		.compatible = "amlogic,meson-gxm-saradc",
 		.data = &meson_sar_adc_gxm_data,
-- 
2.47.1


