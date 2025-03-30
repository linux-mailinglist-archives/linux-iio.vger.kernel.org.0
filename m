Return-Path: <linux-iio+bounces-17335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60DAA7598A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 12:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C22316A46F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209181AF0D6;
	Sun, 30 Mar 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L/GmMel8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183341C173C;
	Sun, 30 Mar 2025 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329988; cv=none; b=unMTAw08c7Lz3QB2cI2wcGRTEB+Eaz4qSaCUqwjb7eBmpK8vK3T7ihHq89xKX50ceUTNq4F4hUKj3rfwuO3FDGUwUsaJ5tlwzMY8eqeweeiLRmp+MqGFR/uLdjK5C6vWcG/nOXU9ZsKdtr2s8dOkuxpTXMUwhQF6gEW9P2zRl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329988; c=relaxed/simple;
	bh=zn9UyA2LDVuqsFwfc1V/lCoeKYHU7fxSsHmtJP1x0vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNMw2hZCXsrScz+5TtQHDquppemUGZG2QHCezaZdsMtmFHAekCjbhBk/kQIv1gj+yQYOFl+NTpY1MG39Zc3pAk2KMdQrWeSikWdF2rHBmQQ5IQnn3pedhXD1oPefzcvIERKBTHWd1U12/v/lvxa7MPVB/MjrgRR8GyCEkznyJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=L/GmMel8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac41514a734so592867066b.2;
        Sun, 30 Mar 2025 03:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743329984; x=1743934784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTtCuTCHRBbsTSs+mYW7dl44DX61rt/HwjLokD2yAew=;
        b=L/GmMel83BQ7LmJn1vmIa9g0f4qjRStBAJU5vgaYjP3bCRxDSFhn8b4DuOyJAONeFb
         Tp5FXPo1vlbI7/mPBBDr8/lHQbmqrZvM+sRIdHuluTtpS1msWlQUidpAuZSO90vWRicp
         6hYzUWFZ8oLp3nM76ngAdgl/du2CI9kYe8hkaLRCDNazFL+D2U87dUTqSxBnPQQ9NaBQ
         40vGdztIEcPrSADggE1ajs+zZuax8jnbkRwm68+vtVUidfuotv1jEoZoMEtndl3Ur4S2
         gHK0Bul2v7TO6/l4SxTbLTtVlchUKvC6DcAGHHXYuZHW/shy8JWFy9eeHEfLWCBTPAyv
         kmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329984; x=1743934784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTtCuTCHRBbsTSs+mYW7dl44DX61rt/HwjLokD2yAew=;
        b=pwlP7UeCZoA2emxR2UD+Zx2Hd+QQITtcXnsHkROoyPsU0CXUXuvcRHd7ajlJ49q58r
         TNNtqD0KLs/sSLuRAU2ZvggwFTMGd+jiXbv1PtHm6svc70lpJA9Rtr8nH2VL3x4pcdZe
         MAeqnJMGN2XR3SPRPh5sZH8+keU76jm0wEC0fOozbPgBD4b1XLRix3f7+FpRSF++l4CI
         lb7usC6FjPR56T9FxDmySwdDMppYsu3N+VKIVzJYFkwVeLB89QAbR7HRNxjLzEjqc3jD
         FPE4lIfGOEt+0aQW9+gFUjfbEyUAsTzN5I0R/H3vlzpRPa/EMTuEiC+wehTtDPVD4A0A
         ZO+w==
X-Forwarded-Encrypted: i=1; AJvYcCUgW6G482KmDJ81pQCSUeNZtKu/y3k5jTXiZSIW/YYUJIIMINKbKsJbyHQ0jwneB+TPh5IHI144rpcGkZzJ@vger.kernel.org, AJvYcCUqWJ6ZkYn8eluDNxw4dMHuV/wvHkFdfOGdl1VrWa7/GbVdTrT0nPcKX7n40rlOxqu4RsYyp7N+Ta0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoG2j8YVKieprd26z3BDlA78vNlMhqHpSrGhcwyanAgYyADpWE
	KIY7ZLg81IHtLFfrGC6pGNL/Fo2pj5SZuixF/JPkLfAPtWy+6hqnY3zJCA==
X-Gm-Gg: ASbGnctMMlJGLDhsgiRbrXLkitJwSzNCQrbRyThJt3HMpt40QnZg03PkZCuwDnYm79w
	xDTe+WEn2kQL/dR/dD/5FJlvIWERpGydRP92WSiCRUX+TBkB2bURKRPhV32NSfGZNOEQ9z17R/9
	RSIS66XV3xuIWy1RfvpmCQc6pDtVhSwq/Wbi41EXi4PO6iXvofhwZHbkvGFNMyjoUk8MmmUidvu
	A99waonyAz/r17alxkIFGTn4bwj2AX+o17404DtFJENYZtRR35bcGnV45MgCbZCeMpsfYTACBS9
	dh3NIB74ERa58wm7v8E+qj2i6uNnKjORLDo7RqEB7SluuIptEoxNB+z7brkF77WBznNPTy6bPnG
	Qw/GRVooKyw3MldeTnalUm5YZvfUbgOPzHQ8j1oimKD5TNfEIWifoArntxx2TXuNG9XYI8g==
X-Google-Smtp-Source: AGHT+IGbom6ukdfm1Iae2/0wZaGQ/AxkHgAV9hqGJorFouonhgJiQTWGpJGqy61Bekd5gx/oqeH0eA==
X-Received: by 2002:a17:907:720e:b0:abf:7a26:c47e with SMTP id a640c23a62f3a-ac738b61ec5mr447216566b.43.1743329984174;
        Sun, 30 Mar 2025 03:19:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad73-6800-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:ad73:6800::e63])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac71922bb65sm459288866b.34.2025.03.30.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:19:42 -0700 (PDT)
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
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 2/2] iio: adc: meson: add support for the GXLX SoC
Date: Sun, 30 Mar 2025 12:19:22 +0200
Message-ID: <20250330101922.1942169-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330101922.1942169-1-martin.blumenstingl@googlemail.com>
References: <20250330101922.1942169-1-martin.blumenstingl@googlemail.com>
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

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 997def4a4d2f..c0f2a2ef0c68 100644
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
+	.vref_voltage = 1,
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
2.49.0


