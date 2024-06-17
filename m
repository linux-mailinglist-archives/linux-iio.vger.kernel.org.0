Return-Path: <linux-iio+bounces-6357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920890B228
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9121F25C3E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C41BBBE0;
	Mon, 17 Jun 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GH7yH8bt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699211BBBC3
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632197; cv=none; b=ITeSYiqBhMzCzlBrK84d/Cc7gw4Wb7uk4xtOtBnNojwshfekkPQUetB+Y+qu5AVZOCSMl0HDaO1JOlNOae/Eo5tvDZ9r604GKivxhHpb8DAEPvZ9lV4YY+7jpQHYlMgqhKwU/hVJTP7pb3+QjH+rtjROdVe8IQdB8nWozupdaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632197; c=relaxed/simple;
	bh=tZD2LK0TsNQLeO1PQXlfQAFGl//p991fLtVre5bjIaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivM1h/pyv3juYc1uNG78LDDNktcMFMC27ZlxTv+Qe4Y8EFlf6WUqbZ37fH6SA/F9sUaB995KVz8R/Ow7qCyjpkpHAQJINCOFhsuEqwlalzBSVU0ItaIM+jKv32t+swpsBMWCFiENaar+69W3d4xSk32V+Pgh/wLA799CsVgRFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GH7yH8bt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7955f3d4516so481841385a.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632195; x=1719236995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sTXUSoBs+YlsgH71N9X/wOixyDVYk1BR8pUCCabPaI=;
        b=GH7yH8btCLTIahVHMmCgkCtEAyZOv26d6YonoT372bAe3teEGxAynUuGD1tqlCdqhJ
         8wAHH1QJSaDiHBU4DaEzBWLZHeTi0RFwrBhNKBbJ/QIbcKPfwTKaOGACkWgr3CWLv7lS
         Xw/3zP4zLJ3Vo5i34TzmaZ3D/fuEzF6j0GZ6D0b3K1WEE8fPw0bPLZLGbobbqUYprKmL
         PDwd9w/jtxjsduMGvWHxj/m14mW/9dV+m6ilbTnQybdApbJwuEejY5Qjo2e51/vqZSbT
         XxXPfnTu8cHsit2UsmSyJNLTbDcG76I1nJIEWHeVtZ8IAIKfKG2CfDcI551AmXWPpLh+
         reSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632195; x=1719236995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sTXUSoBs+YlsgH71N9X/wOixyDVYk1BR8pUCCabPaI=;
        b=RDVvjdK8ymZkViozT5GtCzCcot806Bh0JH4suid+tuGQy5JXN94ujMc5oUEXPzRLi9
         cdYwBNzGamDvPBV/bhC691SM/1Yyx/Lvbrpi7NqImwpPzNzIlpi6VdH0YIAn23icNZ2P
         Gf1JqsD2gHwfMCSkqpelBxBo5VdwEGamcYYZy3d2jropNejuBCT/r14wJN84Ux+yXxcP
         xDucPnIGxHaaa0fKNgiLDwl4ZPXMBTZEgjHMMWvYm3G+vDFWnWR/vaa4cR7aABI0dX28
         WGX49PBDDz6BI52pCXrhgO2WjdrPU000a2posEz7BMcBzTT/emtM7OOTq3Zf3AF3SvCR
         EY4g==
X-Gm-Message-State: AOJu0YyOof2p7KB3DYGiDjl3zUgBoQZuUDTfOeR/yJ6tNLifbPqHx/qT
	JINzaZEm8fl/PSJm1eQ1bvXWI8L+zUB4fXp50hl5w0SxQ6/+oVo83CHMRt/o0R8=
X-Google-Smtp-Source: AGHT+IGjHbBOrTl20NthbniN5xVzM8rCge08JoanAoI0amw+zX4G0dqtT7iYT1wcjjqa5iiFtvInEw==
X-Received: by 2002:a05:620a:44c4:b0:795:5b00:edcb with SMTP id af79cd13be357-798d0243396mr1793084785a.21.1718632195400;
        Mon, 17 Jun 2024 06:49:55 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:55 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:45 -0400
Subject: [PATCH v3 05/41] iio: adc: axp20x_adc: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-5-88d1338c4cca@baylibre.com>
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
 drivers/iio/adc/axp20x_adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index d6c51b0f48e3..00c1a01cac63 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -712,9 +712,8 @@ static int axp20x_probe(struct platform_device *pdev)
 	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
 
 	if (info->data->adc_en2_mask)
-		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
-				   info->data->adc_en2_mask,
-				   info->data->adc_en2_mask);
+		regmap_set_bits(info->regmap, AXP20X_ADC_EN2,
+				info->data->adc_en2_mask);
 
 	/* Configure ADCs rate */
 	info->data->adc_rate(info, 100);

-- 
2.45.2


