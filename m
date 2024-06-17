Return-Path: <linux-iio+bounces-6358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FED90B46C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12C4B35B40
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8395E1BC07C;
	Mon, 17 Jun 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A3xXLBOV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15BD1BBBED
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632201; cv=none; b=Dj5M9Z6eLApKL/TFUBzFpYod0FNIeMRtbe2fxtOUVq2N4yXndaP9U6mR8AOHo1xAjfqfVvSUXYMvg9zyB8dFwj1k+WlYxARJ0oZYoeUSrsLR6rpSrOc3+zRqWWdO1K9pQoDRtlmUIq1uhIRHIreNGPf+q17v6jSAwqCRaD0VLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632201; c=relaxed/simple;
	bh=UCswPzc07ScF6/5JfvW+wgRVfrWxtjhgBr2M86YwQWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biJBVEC/my8fBhkeTsmlEb4cKB44uTh7cYRW5W2Cu1DprRxqTT4fx2EHLrmIJeBHJ1OOyHbh5tU89nM4Ttprj+3ECfiniRUoJ8Bd93dAmmj2cyhyl2DlMxq+EKJgojHu/Iw7Sd0Bktx281yFVtUNTrrCZcrrYygQnbSR2CoeUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A3xXLBOV; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80b7f0910cbso1458937241.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632197; x=1719236997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6UQvfPsoXnGJXINmWjQmEBO62NliLdepCpDJh/A7YM=;
        b=A3xXLBOVEYV2a1xaHfp8tGJxvVyJrhEgbLRL2iP38m5u6LJKCaPvEGN3R5j3rbSt3F
         ixmA2AzuSygMF4vVqQ8kwQ4UzOpIbHjqG/R5qmMXw1rr6wwOQbg/emQNejk9mKMrPh6G
         oBOnyWkhQHobo+sVutL7OvYFHjoPVJwotjkxj3UTr3JRvUGayeD2TVYYaWOZuajdZu3j
         YG2HOc7FzoV0xyvUtsJlkvx1k1a8vaQ4YVxl/fIC5MV65wULii0QS1ybMJclLR4Kn1l0
         BexxcW/dD4qrVPDV2+qyWy5NiejSJ4kp042DDKh2ZDXu/oG9aXrPSKghMFMZ8+1BXJ+i
         4AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632197; x=1719236997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6UQvfPsoXnGJXINmWjQmEBO62NliLdepCpDJh/A7YM=;
        b=qwbQA/AN4WVKos/pkZiUz4D9YIHPsCRTwSP5qyX2UNNYODQA+MKBoopd/CWqVVlOWB
         TYlf1F4Uw9b1keyEHo1P8eRgN/WNMmvUxHwySMZmq9lomsbx/UbwsaX+ufq9B1K+vPBN
         ny7jToRQRFz0FP406B2vYOkiw1WkTpH4tXsGGXRf+iFl9JzGLocbafc39teyjRHhkunJ
         7V50SbYeNpqS/vnhbCcVXQYd8l66cWw5XzWqNNq/1JUJQJVnYAADaep2Tg51ItrK6zku
         E3z0E3GLnF/qzMCz4phaaBvvqBQ2hAMPKdXX8CgiiVNYTSd+nkP0P4vLqW4DBhVFH/8M
         L6Zg==
X-Gm-Message-State: AOJu0YzJk/dZ8+bpiYXC99yGFfD0UMeMObVJ51XfZ+5Of1laRbGG26pL
	A6ytVpjLrYsL03xGelt3Me2/jOhRDmB+U2sUPIfqs4nepeW6d9hY+J1emjavWjk=
X-Google-Smtp-Source: AGHT+IHh1rKlzT8+664YalrD1JcHiwA7k7yzEL0kYz4H+P2//V4FMw+RVSrpyNsoJMn06TFOuuRyhA==
X-Received: by 2002:a67:f452:0:b0:48d:a159:dd80 with SMTP id ada2fe7eead31-48dae329fbdmr9819998137.12.1718632197524;
        Mon, 17 Jun 2024 06:49:57 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:57 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:46 -0400
Subject: [PATCH v3 06/41] iio: adc: axp288_adc: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-6-88d1338c4cca@baylibre.com>
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

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/axp288_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 49fff1cabd0d..f135cf2362df 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -247,8 +247,8 @@ static int axp288_adc_initialize(struct axp288_adc_info *info)
 		return ret;
 
 	/* Turn on the ADC for all channels except TS, leave TS as is */
-	return regmap_update_bits(info->regmap, AXP20X_ADC_EN1,
-				  AXP288_ADC_EN_MASK, AXP288_ADC_EN_MASK);
+	return regmap_set_bits(info->regmap, AXP20X_ADC_EN1,
+			       AXP288_ADC_EN_MASK);
 }
 
 static const struct iio_info axp288_adc_iio_info = {

-- 
2.45.2


