Return-Path: <linux-iio+bounces-6370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E390B25E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895C01C235B4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551AC1C8FA7;
	Mon, 17 Jun 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VVO+N0Ip"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A151C68AA
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632226; cv=none; b=mE3nPk3OnzBcbN80WhHJ542++qe3rlDFwA+fQHIUG5J16O7hwRj+4DNDJ2JQTXwHlpeVxm6IfdvVuFZCe2S9eMC0KyhfFpBx7WuzjxtELZ8F6HTx5QK1qHSHUM47pj/qIBbtWnAhbspK0fhxkXPctdcyqLfeGwbQ9yxT/OdHt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632226; c=relaxed/simple;
	bh=6WpzNw/7O6Bgfvz8lndloRTTgJyhcPEVJA0wYoY3R1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4KPmOh/v+0gTfdLogdgN6mHq7+c4kDrWk4JYnM1Lfd73lNfP8wf0ncGuISkkrtGbJi3DixICkVlHC6mWvDafVAav8yWqedPJvDW1P8zd1aPCAGuwH5nC0LCtC0UTP6p8EF03dAt+z6Oyl2oXo1einHB9gwhold2/LTWNMOd4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VVO+N0Ip; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-795569eede0so223561285a.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632223; x=1719237023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l19FGmHt7cx9Y1e6lJcD6lg62Kq+f+HHsekNkW7FIwQ=;
        b=VVO+N0IpHcp7+6ovF/NjZ5ByBDXohpHc0OKRClH9T7Sh5Oi1t7vIpLA74VPxTIgSos
         Im8M0kKeXRIeaDPASy5aaaWqyL93LKO9BNOBKQ6xQV0zVo5pmYUMUC2TpvzUEOPOyrHP
         aGJJl7t6QK67ZiryOk3XuPM5LAGbJhSOrISAV38oqZphsFBw9pZCrHKtNkNLLBvSIt3W
         n+lALuaylr75MwI/KmKaH7uIXKyAWIJwXfrctaacP2H1bZwlwofRxjxsNCyClx1ftyVs
         XGe1NJZzEDU0uAcyU+fxR9SL6sOnXEOcudakujdnLZWwYTqjljEPVjPJHzgR/8gAXlKG
         KYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632223; x=1719237023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l19FGmHt7cx9Y1e6lJcD6lg62Kq+f+HHsekNkW7FIwQ=;
        b=qcrjfXjIbz+8vUElqjmNKBGzfPGWZ/wwZt2e2ZHmgL80HPnisk6cb6CAAnG9QRheYK
         MubUkftl+mV0s10i7JG+EVA7azyhajwk0fSgMGkS9PKB2+9hjYCbnHosNzAcmAp1XvoN
         ojUXpL7sGt97kczTv0nl1wKqLaeGyhP+m1q86IxbPztKQ5xB9AqF8yiwpfX73me6NkTW
         8iPHfcIeRgI/SxjYnhFcEsKMWrXjDMT7TRmyRDwRvNfn5DrN7U+89xcq80FtHyPFKHZR
         YTmjZjLgeK5OoQ22Z7mctXPXqAkFciOuDuxueyE9zwkb5TLXMIHla6pFfFn1KS/zvFee
         5y/g==
X-Gm-Message-State: AOJu0YyeaxiMK5V4IX8Hu4DzYN8XklzB3+gEJ/Cvjhx6iopL9luNPf+s
	4HSbqd5k9UW5BRww9cHLd1+MktPhq/EpixJTRnYM8EAM8We48gUqmFzgod4yCH4=
X-Google-Smtp-Source: AGHT+IEh7KDprGK33BeeaVNTDiPQqvpWOrx7hEFjzf44w52REiEzqTJNM1IGPx8qlAanIRK9VBBUsQ==
X-Received: by 2002:a05:620a:4101:b0:795:dca5:e9b7 with SMTP id af79cd13be357-798d26b4948mr1182835585a.69.1718632223483;
        Mon, 17 Jun 2024 06:50:23 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:23 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:58 -0400
Subject: [PATCH v3 18/41] iio: adc: stm32-dfsdm-adc: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-18-88d1338c4cca@baylibre.com>
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
 drivers/iio/adc/stm32-dfsdm-adc.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 9a47d2c87f05..fabd654245f5 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -759,8 +759,7 @@ static int stm32_dfsdm_start_conv(struct iio_dev *indio_dev,
 	return 0;
 
 filter_unconfigure:
-	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_CFG_MASK, 0);
+	regmap_clear_bits(regmap, DFSDM_CR1(adc->fl_id), DFSDM_CR1_CFG_MASK);
 stop_channels:
 	stm32_dfsdm_stop_channel(indio_dev);
 
@@ -774,8 +773,7 @@ static void stm32_dfsdm_stop_conv(struct iio_dev *indio_dev)
 
 	stm32_dfsdm_stop_filter(adc->dfsdm, adc->fl_id);
 
-	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_CFG_MASK, 0);
+	regmap_clear_bits(regmap, DFSDM_CR1(adc->fl_id), DFSDM_CR1_CFG_MASK);
 
 	stm32_dfsdm_stop_channel(indio_dev);
 }
@@ -951,16 +949,14 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 
 	if (adc->nconv == 1 && !indio_dev->trig) {
 		/* Enable regular DMA transfer*/
-		ret = regmap_update_bits(adc->dfsdm->regmap,
-					 DFSDM_CR1(adc->fl_id),
-					 DFSDM_CR1_RDMAEN_MASK,
-					 DFSDM_CR1_RDMAEN_MASK);
+		ret = regmap_set_bits(adc->dfsdm->regmap,
+				      DFSDM_CR1(adc->fl_id),
+				      DFSDM_CR1_RDMAEN_MASK);
 	} else {
 		/* Enable injected DMA transfer*/
-		ret = regmap_update_bits(adc->dfsdm->regmap,
-					 DFSDM_CR1(adc->fl_id),
-					 DFSDM_CR1_JDMAEN_MASK,
-					 DFSDM_CR1_JDMAEN_MASK);
+		ret = regmap_set_bits(adc->dfsdm->regmap,
+				      DFSDM_CR1(adc->fl_id),
+				      DFSDM_CR1_JDMAEN_MASK);
 	}
 
 	if (ret < 0)
@@ -981,8 +977,8 @@ static void stm32_dfsdm_adc_dma_stop(struct iio_dev *indio_dev)
 	if (!adc->dma_chan)
 		return;
 
-	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_RDMAEN_MASK | DFSDM_CR1_JDMAEN_MASK, 0);
+	regmap_clear_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
+			  DFSDM_CR1_RDMAEN_MASK | DFSDM_CR1_JDMAEN_MASK);
 	dmaengine_terminate_all(adc->dma_chan);
 }
 
@@ -1305,9 +1301,8 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 	if (status & DFSDM_ISR_ROVRF_MASK) {
 		if (int_en & DFSDM_CR2_ROVRIE_MASK)
 			dev_warn(&indio_dev->dev, "Overrun detected\n");
-		regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
-				   DFSDM_ICR_CLRROVRF_MASK,
-				   DFSDM_ICR_CLRROVRF_MASK);
+		regmap_set_bits(regmap, DFSDM_ICR(adc->fl_id),
+				DFSDM_ICR_CLRROVRF_MASK);
 	}
 
 	return IRQ_HANDLED;

-- 
2.45.2


