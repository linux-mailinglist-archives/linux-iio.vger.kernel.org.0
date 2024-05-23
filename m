Return-Path: <linux-iio+bounces-5235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCC18CDAD5
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 21:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE291F23B09
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 19:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF383CA0;
	Thu, 23 May 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u5210E6G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910CEC7
	for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492258; cv=none; b=SjVoLOpSU/PjygHhLJmQDB0gx0W41Z9J9qYiJIcRLRT10CXPLY/cs4hlHNUaohJCXz6906htf2sasKshcbIl3/nwzV/FJekIxrsGH1Iou4xW7hUBgjZ1Qmdb2aIJAsbH7ucxFZ5rjkDWLh3EkIdKUpIDA7D/zt1sdl+ARflDsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492258; c=relaxed/simple;
	bh=94JABJQL8qy9viN4gm+3mpt7FpZocvO5K7xLPSuAe3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Osn0B/ZeanKxjpLkydTARSa1MbCjR9M4i1f67xl1OSB8QNfwi8nWsxm3gp5EOFGvFT0UesqTrX5zWqmeRc73gBJSQ+rofRIZdK2uY7/2h550+8hcYR0S7Qg7K+ovYn19MvSSDeaz2IpUZFPfgPiQyVMw+oFRZKv9gblJ/JKNjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u5210E6G; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f8d0a1e500so51788a34.3
        for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716492255; x=1717097055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48sL3fNRN0eMYa6c0uqUHGXJzqXQ/QJQAI5gLVy3hB8=;
        b=u5210E6G9ZP9aFx6ij9nLe65Qi3JPSx5eSZhw6OicFL54zA/j5POneNNZE6x3f9Vw8
         MQWuyhNyeLqJn/ZR4Pe80cRsKiBDiE8Kcka1Y0hFFlK80GS7k0fJ6IXyVIk6yo9TmNOt
         XpjIAmisBg88TxtUQ1F89exi/c8J2PBThj41gAFoIddBWowKTmNt8eyhU9/UfyJAymgD
         vi3q9d4qlZF8duG8NSZTtuKBx/HGWIKpLIGXMcGWhkkc18Df7JUbyvEAJmrrBM47FE78
         0gGZhdbqeOL8HFTPnDr8CHKkwNI3TpBn3MZ+3dzOOya09v9h9SanadDwrFBnSjS9DWeY
         ZThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716492255; x=1717097055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48sL3fNRN0eMYa6c0uqUHGXJzqXQ/QJQAI5gLVy3hB8=;
        b=sm7ETmNKS+XgD5c1j0gSc5Idmf9e2svtb7E2omQH+cuE28o1WJlEwjee6ihR+/7WzN
         RvzWciVVNEMPgDfNnQl/JwsPj79jNB001XI7jbRomYFFHS5sFNvAS8vCNN3A+i7MUrsd
         ierQwiNt1KoL0iuXpND8JdTlSLBFM9ruqkeJ4rgS3KtS41DCAT3UcsQA/RGvBTco5Xf7
         vCyL/diI59DCmvXnZHzz0rRs/tzHKdCkzSynrUZ0TzYHlXIhlvl0321WTLxR5emmOGb+
         9Zdc3+keTX/jeiS5tbxpvJS5aKZcazODtxRC2xxmMH131W8c1+Z3z+XcYFBKP6YEeczi
         7skg==
X-Forwarded-Encrypted: i=1; AJvYcCVxuQR4PzGl7qMEohrgt1gFgP8x14eBXfD3nSCfnQgmSOQ/ZtG9rWvmT4YIrr1aGLX6Cfg/NCpTzN8yjdvQLJ9pJu5iszREngL4
X-Gm-Message-State: AOJu0YxWtIg7F/y9xy1hXGRTIV9CTtOBDjopQqtsppIIblu33fHaIHCY
	RpSfK22Wf8QdjhfaR0Y0O8bczPWGDhLhG2OWrFQqk3TrhoGDn66CALkoo+S9jn7oQ+e4IsAL7K0
	XHOE=
X-Google-Smtp-Source: AGHT+IE0KSJaVQb6UV/RuQW/BtUj1l1s6DTa7CZLmUnwSD8HHOuMHqiGy7vjsHo5+oFSDkod4Kl15A==
X-Received: by 2002:a05:6830:1618:b0:6f0:6864:eee6 with SMTP id 46e09a7af769-6f8d0a73937mr150380a34.10.1716492254835;
        Thu, 23 May 2024 12:24:14 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de62f3sm13145a34.42.2024.05.23.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:24:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: sort Makefile
Date: Thu, 23 May 2024 14:24:10 -0500
Message-ID: <20240523192412.3220547-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile for IIO ADC drivers is intended to be sorted alphabetically.
I can be tricky to keep it sorted when adding new drivers when not all
of the existing drivers are sorted. So let's sort everything now to make
it easier to keep it sorted in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

This was done mechanically using the sort feature in my text editor,
with the exception of the line starting with "xilinx-xadc-y".

 drivers/iio/adc/Makefile | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index edb32ce2af02..6a8c2da0e707 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_AD7280) += ad7280a.o
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7292) += ad7292.o
 obj-$(CONFIG_AD7298) += ad7298.o
-obj-$(CONFIG_AD7923) += ad7923.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
@@ -29,6 +28,7 @@ obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
+obj-$(CONFIG_AD7923) += ad7923.o
 obj-$(CONFIG_AD7944) += ad7944.o
 obj-$(CONFIG_AD7949) += ad7949.o
 obj-$(CONFIG_AD799X) += ad799x.o
@@ -90,42 +90,43 @@ obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
 obj-$(CONFIG_PAC1934) += pac1934.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
+obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 obj-$(CONFIG_QCOM_SPMI_RRADC) += qcom-spmi-rradc.o
-obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
-obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
+obj-$(CONFIG_QCOM_VADC_COMMON) += qcom-vadc-common.o
 obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
+obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
 obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
-obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
+obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
-obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
-obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
-obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
 obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
+obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
 obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
+obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
+obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
 obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
-obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
 obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
+obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
 obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
+obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
+obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
-obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
-obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_TI_LMP92064) += ti-lmp92064.o
 obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
@@ -134,7 +135,6 @@ obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
 obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
 obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
+obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
-obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
-obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
-- 
2.45.1


