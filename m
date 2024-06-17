Return-Path: <linux-iio+bounces-6359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E2B90B22E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307611C23562
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90C1BC08B;
	Mon, 17 Jun 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rOTG6Jg6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D511BC072
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632202; cv=none; b=DrkjIoPdVq/4r1lHw3P18ba4oeUQurmVRHtBYWL/Na+mQIbSbft1IrlweG/J86LaAcmqhDCyBJmaXjgD7galV20/WspQXipU66wLgFPVwU3ks5Xt+3j6+mbCXrEadv2QRVS2Y+1Hb0EYuRDSulG3XVMGaVqK517R1bhK+wBvVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632202; c=relaxed/simple;
	bh=StudXC8HM5AaA51joNKIseNwtqaK04Fr9WYaAPBMqi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kh2Ly8wxD9KDaWS7ANtWKZKrx+Cl7FvnlT/ZNt1zgzkMoBU6aOfQki49f44pa1qBkAsP/Lg6XbS84F92V2OUo0ha7R21awInhNgb+T2zLSHcKYsCQYTlPD1cL7Upw3o2KtQFcZqiwJRdbquyZXEWKHvwi611RPt+4RTddXQm9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rOTG6Jg6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-796df041d73so313346685a.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632200; x=1719237000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrcJbk8xCEXw8t4EaXrcTeVF+NCC1LSKzcpZFP4BG5g=;
        b=rOTG6Jg6AFDvVQuvhTCMgfNkzi7Kzm7o+vUGfVhwN7vuApciSL3d4JkEooKRzezAnl
         kgU2Abrb/yPqufSoeGsqocss7K6YGumoYv8mW/FN8wsDrILqttu8APaBqglKtx3GRpwR
         10KLQphkQKUKTQeQoUQaTpN15YuRqUOJrKgg9lQYcmP+BurmG45MdHwXtdG79lX6B99M
         MhEIWn2xpq2in4srZC1z/j8rMuOcu7g6guEhaqZ1z+B4MebhQKCTPHuaWHaZP9qI8VPI
         khM5IL2/o1PWaMIPCVowUG6XGaTfZoVwNTWFknN09Fy5FHT1d8stbiiMMVL+JG7Ki3tN
         y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632200; x=1719237000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrcJbk8xCEXw8t4EaXrcTeVF+NCC1LSKzcpZFP4BG5g=;
        b=UCdMeTWIPE2JRfFKC4JQFtEUKRxOOFt0BUR4Nn2kVSPTOLtwo0/ZSECZEzLQNHfnuf
         GS/ny1RgzutZxbneRubVbngQV3Ygr3oDzeDidwJqeZPZtRoR3wby3aPbrH49x4qBDB1J
         ME210WIC6X7jYmqYGjoy0JmIETJE+6BGpW+HgF5u9nR2ceOF+SeOr/c4Z9xAwLgr4IXS
         4ge+1Iu+TQV2iR7YW/ou7i0Oe5oadCuyjGJWIl4mOTaCwuOEl1AncKdskj+dYj3/sS5z
         NX+pmW+uPTyTpDbIYgWF7F0scAbmaFiBsGpw9dgXmkaNQ3vtUNxBMqw/goXrb6jW0Oxr
         /oIA==
X-Gm-Message-State: AOJu0YwJHP9rQ6rpKjFQSO6Um2HL+eU9cWGG2V7thZ6XNNL9xg9EyvYm
	5FaRCZIbBjMfsNqrVOQIak0TXpGv6+hPTkylABawAXMHwI7WPz4vRm490eb07ZY=
X-Google-Smtp-Source: AGHT+IE5uBXfLurzd0jxJqKEavsP5xlBerQNz/5zZPhVz/sS8JYp4QTVcbxX+BgweFysUZBWMYLagg==
X-Received: by 2002:a05:620a:1a81:b0:795:4e35:ea9d with SMTP id af79cd13be357-798d2692fc4mr1312471985a.60.1718632199656;
        Mon, 17 Jun 2024 06:49:59 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:59 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:47 -0400
Subject: [PATCH v3 07/41] iio: adc: bcm_iproc_adc: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-7-88d1338c4cca@baylibre.com>
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

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 5bc514bd5ebc..6bc149c51414 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -357,8 +357,8 @@ static int iproc_adc_enable(struct iio_dev *indio_dev)
 	int ret;
 
 	/* Set i_amux = 3b'000, select channel 0 */
-	ret = regmap_update_bits(adc_priv->regmap, IPROC_ANALOG_CONTROL,
-				IPROC_ADC_CHANNEL_SEL_MASK, 0);
+	ret = regmap_clear_bits(adc_priv->regmap, IPROC_ANALOG_CONTROL,
+				IPROC_ADC_CHANNEL_SEL_MASK);
 	if (ret) {
 		dev_err(&indio_dev->dev,
 			"failed to write IPROC_ANALOG_CONTROL %d\n", ret);
@@ -543,8 +543,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	if (adc_priv->irqno < 0)
 		return adc_priv->irqno;
 
-	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
-				IPROC_ADC_AUXIN_SCAN_ENA, 0);
+	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
+				IPROC_ADC_AUXIN_SCAN_ENA);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
 		return ret;

-- 
2.45.2


