Return-Path: <linux-iio+bounces-5724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855168FAA54
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 07:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C591F215C9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 05:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D16140399;
	Tue,  4 Jun 2024 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO4whNME"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D01140374;
	Tue,  4 Jun 2024 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480482; cv=none; b=szEZ0gCS3Y/OF8UakIfXws6hwDJMsPSP5vRTLp3s7IiZPbwXRhoDQ0Lzz79GmhSfKewNECTSmdCy1nABhiqarqb14YMU1xyJAshhEjsoNfHwaLYuYx7iZSu//hrlPOvKImsaytCVY0ehJHZaIBPk3ZlF/VscH6qhQwRI1jP+ve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480482; c=relaxed/simple;
	bh=vBMOrsEvWet6SnV8icQIYbE/21MSLFGaoualfXxCRnI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uk+dHcVR61TlojSLJ+FFkZug+OjnS2TKjv+Xa2nu7wKSMRHtNF5uOtl+pU/HoNqJS1r1IRV4ZOvd3eAlvL16B2bzY/uJ7FclmCUYweOEX+UN3+HsKYCbDly+8vQBP1Ve837xyQehqxufoNuKhyY0K/by8x06NIcALoWob6lgbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UO4whNME; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a68b0fbd0so1485997a12.1;
        Mon, 03 Jun 2024 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717480479; x=1718085279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNXQ/SoJYaWo0NJj93vx8GPkV2wEKcXWEow45UeQsg8=;
        b=UO4whNMEd0MfoVjqlp1gfxzbuWdsEmGYEJBANDjE8KqAYcC7F44iVb0of7oP70+uCa
         ap9T1rIBgsyYr0OKkPft6pugbyl370nUz6lsBuqVwMAzKNfiNMU8WYjPMeuWpoZ6IisB
         OaTY93qrxfDiPXnFj0ZoxdWcVAoZ/XXmDb5FAzb1pIs70kySy6bLtyDbEV0zd3lGFxp1
         Uuy3w+TzB+xOEgzwHoEODk5KEhTVKcGXDnkTQoHDMn4ajxHr2LDgFwnXhRCFdFr9S+ky
         eYv+9zprqfkCBLyLCxljDVJBR92xyfuWJXg138QWmpiXM9KPfhNZd1jdImfMbVZUgXik
         MIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717480479; x=1718085279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNXQ/SoJYaWo0NJj93vx8GPkV2wEKcXWEow45UeQsg8=;
        b=jmIm+TztqgEkMNgZu9Ot+lOiEz/R3DfoKRDVC1RxrvKEGoDHvKEnGwz6nO5WTUmY1E
         JhoGup3KLsC2ecvD935f9PMEE5yhApmRDOI+x328mwEEvp3XDHG9zyOK9ufdbc/MdU9i
         X2X/Xo0NMDJYVtkb5960d6XMwgemglGaJX9jEjJUbUVNQ+Xb5bOz3GcZ/nXgasEnBLfh
         NpFcwJi0R1wXNkh8Uth8TUfXPI6A+sVKf8FD5HvnXleAJ4KRw5C5oB4VbB3h0Kb0uIef
         MJtYtLSIg97WLhTFZiATIxaGmr7D1lzbaPP1L68U2d9pnOc3WT/rlK72rTUvrNxgyjh4
         +72w==
X-Forwarded-Encrypted: i=1; AJvYcCVVrNZvDTHyPz1N9Hw9iRR7wibuEK/oX+AHcsDhQcvThDz1km7MLLY4BHYnAQQuKa0RKa125q/GkLnQMGgki+sj5bNGW9bvNT37zVBd3hCcP/q9El15mbkJWHSdVoOv6nUfdJkMoaqTtK8Rx0JtQIm4TrdGYiaH7DxLUo/FcNCNLDP20Q==
X-Gm-Message-State: AOJu0YwYzG1fklLFjE1+lJ3n8DYhzJt3RiGoojRHfmtoKFhGabyb/hXs
	uUcIi9hMuPzT6s4E1Z6s7rNkdgaWnlBEVEz5eTXasNhktrrILxsk
X-Google-Smtp-Source: AGHT+IFvO3hGcwGjzkhM2BCfkJy/zitS1v/oJjTYW85m+xbHO4VeID9IRH5+ElX1GrCzxo+B/yunjA==
X-Received: by 2002:a50:9ee1:0:b0:578:36a2:7073 with SMTP id 4fb4d7f45d1cf-57a36450a36mr7711221a12.29.1717480478704;
        Mon, 03 Jun 2024 22:54:38 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a4fc842b5sm4895643a12.71.2024.06.03.22.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:54:38 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: meson: add support for the GXLX SoC
Date: Tue,  4 Jun 2024 05:54:31 +0000
Message-Id: <20240604055431.3313961-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604055431.3313961-1-christianshewitt@gmail.com>
References: <20240604055431.3313961-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The SARADC IP on GXLX is identical to the one found on GXL SoCs: except
GXLX requires poking the first three bits in the MESON_SAR_ADC_REG12
register to get the three MPLL clocks (used as clock generators for the
audio frequencies) to work. Register bits are from the vendor kernel.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/iio/adc/meson_saradc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 13b473d8c6c7..200eb8271617 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -160,6 +160,11 @@
 	#define MESON_SAR_ADC_REG11_EOC                         BIT(1)
 	#define MESON_SAR_ADC_REG11_VREF_SEL                    BIT(0)
 
+#define MESON_SAR_ADC_REG12					0x30
+	#define MESON_SAR_ADC_REG12_MPLL0_UNKNOWN		BIT(0)
+	#define MESON_SAR_ADC_REG12_MPLL1_UNKNOWN		BIT(1)
+	#define MESON_SAR_ADC_REG12_MPLL2_UNKNOWN		BIT(2)
+
 #define MESON_SAR_ADC_REG13					0x34
 	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
 
@@ -327,6 +332,7 @@ struct meson_sar_adc_param {
 	u8					vref_select;
 	u8					cmv_select;
 	u8					adc_eoc;
+	bool					mpll_clock_bits;
 	enum meson_sar_adc_vref_sel		vref_volatge;
 };
 
@@ -1009,6 +1015,12 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 				    priv->param->cmv_select);
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_CMV_SEL, regval);
+
+		if (priv->param->mpll_clock_bits)
+			regmap_write(priv->regmap, MESON_SAR_ADC_REG12,
+				     MESON_SAR_ADC_REG12_MPLL0_UNKNOWN |
+				     MESON_SAR_ADC_REG12_MPLL1_UNKNOWN |
+				     MESON_SAR_ADC_REG12_MPLL2_UNKNOWN);
 	}
 
 	ret = clk_set_parent(priv->adc_sel_clk, priv->clkin);
@@ -1241,6 +1253,17 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
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
+	.mpll_clock_bits = true,
+};
+
 static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 	.has_bl30_integration = true,
 	.clock_rate = 1200000,
@@ -1293,6 +1316,11 @@ static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
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
@@ -1324,6 +1352,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
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
2.34.1


