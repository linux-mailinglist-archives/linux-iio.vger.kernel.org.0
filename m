Return-Path: <linux-iio+bounces-6365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8091490B249
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04802288BE8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E81C0DD9;
	Mon, 17 Jun 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z9HhHanv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E21BE86D
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632215; cv=none; b=B3o/hAsTf928TZacw9VsdC9WJ9HcrPfUVy+KB9XuenJl4ILOj+tqacBnYskHdRy0PihHkOiDVvqpA2tu8eotzkMYdSxEFjPWttZJA0FYIDi2eFtqeVxV4eRGlWRzxTqpePUVJiIfD6bzhcjSuweMSwaV5R9Z0Hy7r9WZHqzoVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632215; c=relaxed/simple;
	bh=4gIRZ/vu50pKU4o1TP9QUC/IjjrHpbnZ1GOSjHAMZ4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4upyDYcENdswEUU2UET2E3dwe29bL4m4xeeiAA/pFabbFG4jikWFVeSCDvKo3mhApWeuU4J0Sn219KJ4CXohzEcfep6wyp9zIh3TVn7Fn3AsMGWGC6FsWtO1RdwJ7DnWZKmSf9bcZDtKDDra/HIUvZyrXo6e6EdZpVDMXZDyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z9HhHanv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7955dfce860so281885085a.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632213; x=1719237013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXJIaHqTfmpNhZnTE583n/Ec2b/3cyzD9UXAylu36IA=;
        b=Z9HhHanvck0szH9SJQfMNDoJjXk1VCoVnfu5HWvcW3zocrYQWZSF32WATRWY4zO/X2
         QW54aR4Z4+mnEy9psHJ1VWcV2roH2OddRCS9VERJvS/X+60HJRQRZFrjVD3OP8ypAbtZ
         +Q2UKHFtQ4eTqnlXERCD0YAs7jYAuNjFO5ukajiu0PQrdeZDDYVu4n57mnkqmCAqO1sq
         bkRzsQnnOHA1LkWTjybJV0SKBusvF3rlXeHTNjXdVLUsE8to6V9Pxh4pue5J/JYNZFfJ
         mr5TIOKZdaT6WMTV/NlhREBObb3smD99XTJAVZ8suv69H+agzcLezUN0b17fJAs09AkZ
         nDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632213; x=1719237013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXJIaHqTfmpNhZnTE583n/Ec2b/3cyzD9UXAylu36IA=;
        b=XezJRYJ4XhNIsXZkaysM9rNcnZ2irukft6tCbwM5xQFwpv9npGBwbfPFhK8b+YqvgI
         YbISyCusYowlHTZVDVwUwa1A4RdaoOf4+pKQHKv7vSLyylD8XAWbtnHrfIyX1laM51tP
         rxGvE0QZnbwYzUgecfy4NaGArBkJWqRDSnpSSpz1XEYWVchAs+as6go3jWDy86hIZYNg
         s0CZbfuUaylLWAYSlfuM0lL2Hwrb2vtwhh3fS2i4kw+MmHuE1LslR42sZOUMN1nGVtCn
         L8ySM2JmEXPnnlxKhHXyS+p5vneBjNjrCIq/myAbtWv20c4HHaM7C76+h0w21sWU2b7Y
         Ohhg==
X-Gm-Message-State: AOJu0YwNqH2FLSSeEruAK/8Ig1IO4R7fqnTS+tgdPo3dt53FB6CZNnjz
	ulVia3V6AXfdJ6WLTWv5SmHEDCucxq0ax7IsZEiJ5F+u5AcfNbesm/NT3knvLHY=
X-Google-Smtp-Source: AGHT+IFE4+GjUcRvfBj86U5p9RlM1W0UrqMbwwjDZojT1mdFRj7PyY3udpb+reAC5jxDfHM60DBB3g==
X-Received: by 2002:a05:620a:28c7:b0:797:8564:920a with SMTP id af79cd13be357-798d2413c45mr1111201285a.29.1718632212779;
        Mon, 17 Jun 2024 06:50:12 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:12 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:53 -0400
Subject: [PATCH v3 13/41] iio: adc: meson_saradc: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-13-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/meson_saradc.c | 101 ++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 13b473d8c6c7..e16b0e28974e 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -546,35 +546,31 @@ static void meson_sar_adc_start_sample_engine(struct iio_dev *indio_dev)
 
 	reinit_completion(&priv->done);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN,
-			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			MESON_SAR_ADC_REG0_FIFO_IRQ_EN);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE,
-			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_SAMPLING_START,
-			   MESON_SAR_ADC_REG0_SAMPLING_START);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			MESON_SAR_ADC_REG0_SAMPLING_START);
 }
 
 static void meson_sar_adc_stop_sample_engine(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			  MESON_SAR_ADC_REG0_FIFO_IRQ_EN);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_SAMPLING_STOP,
-			   MESON_SAR_ADC_REG0_SAMPLING_STOP);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			MESON_SAR_ADC_REG0_SAMPLING_STOP);
 
 	/* wait until all modules are stopped */
 	meson_sar_adc_wait_busy_clear(indio_dev);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			  MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
 }
 
 static int meson_sar_adc_lock(struct iio_dev *indio_dev)
@@ -586,9 +582,8 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 
 	if (priv->param->has_bl30_integration) {
 		/* prevent BL30 from using the SAR ADC while we are using it */
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
-				   MESON_SAR_ADC_DELAY_KERNEL_BUSY,
-				   MESON_SAR_ADC_DELAY_KERNEL_BUSY);
+		regmap_set_bits(priv->regmap, MESON_SAR_ADC_DELAY,
+				MESON_SAR_ADC_DELAY_KERNEL_BUSY);
 
 		udelay(1);
 
@@ -614,8 +609,8 @@ static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
 
 	if (priv->param->has_bl30_integration)
 		/* allow BL30 to use the SAR ADC again */
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
-				   MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
+		regmap_clear_bits(priv->regmap, MESON_SAR_ADC_DELAY,
+				  MESON_SAR_ADC_DELAY_KERNEL_BUSY);
 
 	mutex_unlock(&priv->lock);
 }
@@ -869,17 +864,16 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 	 * disable this bit as seems to be only relevant for Meson6 (based
 	 * on the vendor driver), which we don't support at the moment.
 	 */
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			  MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL);
 
 	/* disable all channels by default */
 	regmap_write(priv->regmap, MESON_SAR_ADC_CHAN_LIST, 0x0);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_CTRL_SAMPLING_CLOCK_PHASE, 0);
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY,
-			   MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			  MESON_SAR_ADC_REG3_CTRL_SAMPLING_CLOCK_PHASE);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY);
 
 	/* delay between two samples = (10+1) * 1uS */
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
@@ -914,21 +908,17 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_MUX_SEL_MASK,
 			   regval);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_XP_DRIVE_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_XP_DRIVE_SW);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
+			MESON_SAR_ADC_CHAN_10_SW_CHAN0_XP_DRIVE_SW);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_YP_DRIVE_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_YP_DRIVE_SW);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
+			MESON_SAR_ADC_CHAN_10_SW_CHAN0_YP_DRIVE_SW);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_XP_DRIVE_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_XP_DRIVE_SW);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
+			MESON_SAR_ADC_CHAN_10_SW_CHAN1_XP_DRIVE_SW);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_YP_DRIVE_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_YP_DRIVE_SW);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
+			MESON_SAR_ADC_CHAN_10_SW_CHAN1_YP_DRIVE_SW);
 
 	/*
 	 * set up the input channel muxes in MESON_SAR_ADC_AUX_SW
@@ -944,12 +934,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 	regmap_write(priv->regmap, MESON_SAR_ADC_AUX_SW, regval);
 
 	if (priv->temperature_sensor_calibrated) {
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE1,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE1);
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE0,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE0);
+		regmap_set_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				MESON_SAR_ADC_DELTA_10_TS_REVE1);
+		regmap_set_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				MESON_SAR_ADC_DELTA_10_TS_REVE0);
 
 		/*
 		 * set bits [3:0] of the TSC (temperature sensor coefficient)
@@ -976,10 +964,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 					   regval);
 		}
 	} else {
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE1, 0);
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE0, 0);
+		regmap_clear_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				  MESON_SAR_ADC_DELTA_10_TS_REVE1);
+		regmap_clear_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				  MESON_SAR_ADC_DELTA_10_TS_REVE0);
 	}
 
 	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
@@ -1062,9 +1050,8 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 
 	meson_sar_adc_set_bandgap(indio_dev, true);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_ADC_EN,
-			   MESON_SAR_ADC_REG3_ADC_EN);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			MESON_SAR_ADC_REG3_ADC_EN);
 
 	udelay(5);
 
@@ -1079,8 +1066,8 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 	return 0;
 
 err_adc_clk:
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_ADC_EN, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			  MESON_SAR_ADC_REG3_ADC_EN);
 	meson_sar_adc_set_bandgap(indio_dev, false);
 	regulator_disable(priv->vref);
 err_vref:
@@ -1104,8 +1091,8 @@ static void meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 
 	clk_disable_unprepare(priv->adc_clk);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_ADC_EN, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			  MESON_SAR_ADC_REG3_ADC_EN);
 
 	meson_sar_adc_set_bandgap(indio_dev, false);
 

-- 
2.45.2


