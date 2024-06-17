Return-Path: <linux-iio+bounces-6366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E13190B3F7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22FDB2E13A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D11C0DF8;
	Mon, 17 Jun 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dzifrHqA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5261C0DDB
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632217; cv=none; b=h9XobvNCtnzxcXJowBLIoYreIhBF53faG1fUQDrQ88rfUrIut72lrS4f2akhyOyLYXS2aGLl9hs5APW6BX9edOSePvAWWhNxxPn4CsbpHGjLx1LXGIQLOVGJ6GICFRsHl76R6fMJ7LjVVqRSn7yNqGPdGr82jvqusoyhvtyVz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632217; c=relaxed/simple;
	bh=fzPzUYcNz9V2ID3qrrApafMZGiDVZpy6ghrI0nU92Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gr5cjXQb0zjDHvzXd6uoZmJlibASta4KP2mPT4e4mflBtjBEjr5YtcbInF54Gn9flAYLA6czG7jc7e8vhQ00r7ZgHlH7cgQZPgdn8ZWWN5A49iy57nCGN3txIEMxwUKb88qGAQb+odrxnO1Je83oZ0qDmDWvUGG+aS/TXRBfEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dzifrHqA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-797dcb558ebso286427485a.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632215; x=1719237015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyaMuqBhP7o7wmqZwNnsnkbTtRp5AugJ4lcsefsATFM=;
        b=dzifrHqARGpGfebqYePD4sZTzikv72YPKBP2AeazQ5HPYDt9gNrqKHrvgA7wgvKTcF
         42SrehdpKxWyz4hf05fUqqExZF4dEFDmxRYmg4nvpmwdah2gZHL/JclvwaXxlewlOCyo
         c/BEHI+OSNSUTuamI3LOVhxPCmoh25zfufx8s7Jl2m6gJjRiYN+q5GYtHtFkz50+Fw/o
         13nm/a1f5Pu1YMFL1Ynp5emxpFm3hh0tL8Avk2LcOR4kfLIyMKZIdH21BtutmTkc8d8K
         FkR4Cqhjmtx4BpRM0xSgQaAPUdWR3QmhTzG2Y4alrkNho2MGRguFte4daMyTk986HO3P
         /3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632215; x=1719237015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyaMuqBhP7o7wmqZwNnsnkbTtRp5AugJ4lcsefsATFM=;
        b=bWBdcgbZLGsCP6QNxZwPAZAvBanZ1vi/7ExPq0+A/dwZ6kX59fiSCdapFTiOL8bHpS
         KkNmmeNylGiW1hzEQDYcvmDMCWX21YLuJNHGrCGxAdEvlMwFCUQUKl1XU/Q0pc0ceIxg
         AH4KxDVoKjzhFnCQs8Qs8X9SoPeXOl7i8Al4q4ls5yszTNMe7E4nFyjpdukZsvrwBNYy
         bhVVwP851IF4XL3jbeW8UjR0Zpe5AWrGRUvumRkRbPfu7UrpDvyHFDvKBM6gik3NQFLG
         rpzQNcUhx9DW3d4KvMRE0yT+0iBAYzj6p3re6Qij2E8llJuMQjLlmTKRlqfRmcMal7T3
         N80g==
X-Gm-Message-State: AOJu0YzLH/sbz8GruS1Xko9v6qGndOAGwgMIe74a7aUKJmr8cP2jzMks
	ex221A/7KK0eJzpXPV4jwBT7FQ/HiMsgIO3rS+Hf5Qa7wf1i6Unjl6S9nQEs4zs=
X-Google-Smtp-Source: AGHT+IG9rvLxXHys5yM3fiDf+G14AWJNmGoLIu5wSpeGGOXNzHBF3wjPuE24N3ncETdlUUNQNA6oSA==
X-Received: by 2002:a05:620a:45aa:b0:795:4e64:dbbe with SMTP id af79cd13be357-798d1f824a7mr1191474185a.0.1718632214915;
        Mon, 17 Jun 2024 06:50:14 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:14 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:54 -0400
Subject: [PATCH v3 14/41] iio: adc: mp2629_adc: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-14-88d1338c4cca@baylibre.com>
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
 drivers/iio/adc/mp2629_adc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 7c66c2cd5be2..5f672765d4a2 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -131,9 +131,8 @@ static int mp2629_adc_probe(struct platform_device *pdev)
 	info->dev = dev;
 	platform_set_drvdata(pdev, indio_dev);
 
-	ret = regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-				MP2629_ADC_START | MP2629_ADC_CONTINUOUS,
-				MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
+	ret = regmap_set_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			      MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
 	if (ret) {
 		dev_err(dev, "adc enable fail: %d\n", ret);
 		return ret;
@@ -163,10 +162,9 @@ static int mp2629_adc_probe(struct platform_device *pdev)
 	iio_map_array_unregister(indio_dev);
 
 fail_disable:
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_CONTINUOUS, 0);
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_START, 0);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			  MP2629_ADC_CONTINUOUS);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL, MP2629_ADC_START);
 
 	return ret;
 }
@@ -180,10 +178,9 @@ static void mp2629_adc_remove(struct platform_device *pdev)
 
 	iio_map_array_unregister(indio_dev);
 
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_CONTINUOUS, 0);
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_START, 0);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			  MP2629_ADC_CONTINUOUS);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL, MP2629_ADC_START);
 }
 
 static const struct of_device_id mp2629_adc_of_match[] = {

-- 
2.45.2


