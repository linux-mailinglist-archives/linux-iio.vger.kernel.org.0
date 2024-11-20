Return-Path: <linux-iio+bounces-12437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB319D438B
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 22:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965831F2107D
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745FB1CACC9;
	Wed, 20 Nov 2024 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="evUxwzHM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB41C9DFC
	for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138453; cv=none; b=OUdciJ6TBI5unYxfM+ePjg1aOL/Wcc08hzqZN1gWD8XV4F9E4J97RV1Y8EAvqS4dNvuDe/4uv4hNtMxAvtxkan1mz8GoyYYMRYjzuPc/I+PfrMkcfW+VY/NyWpMmGD+oUyW/NUfWnbh61Cjv0yZdnbBNBJhPOaxIDaL4uvrQn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138453; c=relaxed/simple;
	bh=KPajQC1aALEfbneuHvtuGop3ovSJzfya4SbeCBcQxC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEWHJ1r+2QrzZlxkcu1ND41SofUNf/cF1eM9RnOosT4C3IAxcxhP/PuyN09LaPUS9OgdXBI+2piW7U2Dnmx7UO69aNrxQbnslyPQC3Qz/6JSoqIf/SHnsqcOR+Q8hz5ce1YXk076y23/GcUJvAxsA2Qyd1JDa9x40f8ZJXaaSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=evUxwzHM; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-296085d59caso212941fac.0
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138451; x=1732743251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOcVB06XaJFOi/s6psv+BsWaLcpfMNJDY6ZQUGIvfPw=;
        b=evUxwzHM37PcH3OZ+VRAL7LA11tobqW5GV7WawyP8IUEbHO7LGV3ZdpwpVyhlMvbNV
         xf60zvj0kB2wIWP8pVvxei9kE9ROpt0ih6HpvHWVqHGT959qp3M1TRszo4wEoQON9D5a
         1Ehpz3MCWJ5dhlRerh7Cdv5yafKVQlE8fDm9Ejrac1v7XHlKMplysY5VXuEKHJwX34Ak
         4hZBCyVoumari/S9I2m0/y51okrSof318rBcrblj2wd98vG4WVEWnDQAT/o4BQVMU7DY
         kKAd8U6W5MbZWf+lu5QQ+q1QpEsB11T9Jf2a6PjRTFkO4PN5ajWuNLoCaNyEndEYLCT0
         5LhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138451; x=1732743251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOcVB06XaJFOi/s6psv+BsWaLcpfMNJDY6ZQUGIvfPw=;
        b=m877ghTOSm5F2VKaUBo3t/SBf1CXbOdGfR85rQZFvqbt4Z3PEKxH8YFfRm7U0V9JXJ
         xf9L2wpWLCoKcuFG02gMOnDN8dtAuEnK/rK27Bp63ZaDadeBtZjRVibkipo103szyyr1
         nt2i+WVLQfix5p50i9NwvU+TIC1vJjDsSshA+Dq7kn1ynAbW72d5/sUMvbmd+UpO5pg7
         x4vW30VLg+tJVKhyQz1OLFfprAJJBkb3Yt9GrXOV7NjddP34VoKbgXCkEFbxBZe+ABye
         WGNaQp+VmFSb/VeKhB3+ZI0V9yGi300iBXlm0IN6mnCCyuj1Ojbmw/0Wz/X9E5GtoDqO
         kpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvVyYx6FYMIc4Thti8VBUYEg8eNZ//BoBPlYLlGkLhyyjD9tjfrkODythVcOnIBseIefcdeZMq7UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6IlZYnm2U26e63u1sMRRai5bHtpzcONn7+49+Hr2VicgDBE8
	Q8j1Owjg8pDR8LowHtRH91Yjb4CRJ0D5oYK+EXWt0/JyrLlPbqMUObZ2ozPApKQ=
X-Gm-Gg: ASbGnctuuPyfIDQbgpQd49gQtc6XunG6vJ+pu45btDgqFfcv2sVfHf4YAx1OdgbZq6Y
	uqSqIqaqepj6TJMdtLZy7HTU14sHo7u+pM0MyK/4ORs2GNZcx2oQd7BZvcINU74ChTbwlb232mS
	hAP+v45FujsRYO17g5meKAA4+bi90NxODECq6AM6pM0ulo/VdXb0WuAMdT1fG/0OZOTNDbWmyqI
	AMSA+B691StNZzD/JMssyneKdJUVX9TiqOFJD8m1dHa8chVkCG4G8rPi8M5zq1YYjMO6NdoyZeC
	B6/LeQ==
X-Google-Smtp-Source: AGHT+IGZjpgvy1HtxraukJAx9aw7qrY82YEtPjjvc0y70FfHyFvmqDxdPRVkajBg6fK1WC3NQZuHSA==
X-Received: by 2002:a05:6870:ad05:b0:296:9c08:51a3 with SMTP id 586e51a60fabf-296d9f50b0bmr4358153fac.39.1732138450920;
        Wed, 20 Nov 2024 13:34:10 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:30 -0600
Subject: [PATCH 07/11] iio: dac ad8801: drop driver remove function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-7-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Remove driver remove callback in the ad8801 driver.

By making use of devm_iio_device_register(), we no longer need a driver
remove callback. Also since this was the last user of spi_get_drvdata(),
we can drop the call to spi_set_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad8801.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
index bd857754fc11..8a362fae2eca 100644
--- a/drivers/iio/dac/ad8801.c
+++ b/drivers/iio/dac/ad8801.c
@@ -136,14 +136,13 @@ static int ad8801_probe(struct spi_device *spi)
 		state->vrefl_mv = ret / 1000;
 	}
 
-	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad8801_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad8801_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad8801_channels);
 	indio_dev->name = id->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret,
 				     "Failed to register iio device\n");
@@ -151,13 +150,6 @@ static int ad8801_probe(struct spi_device *spi)
 	return 0;
 }
 
-static void ad8801_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-}
-
 static const struct spi_device_id ad8801_ids[] = {
 	{"ad8801", ID_AD8801},
 	{"ad8803", ID_AD8803},
@@ -170,7 +162,6 @@ static struct spi_driver ad8801_driver = {
 		.name	= "ad8801",
 	},
 	.probe		= ad8801_probe,
-	.remove		= ad8801_remove,
 	.id_table	= ad8801_ids,
 };
 module_spi_driver(ad8801_driver);

-- 
2.43.0


