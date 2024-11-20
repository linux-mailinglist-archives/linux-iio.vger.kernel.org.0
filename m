Return-Path: <linux-iio+bounces-12439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62039D438E
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 22:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC57283949
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050691BDA80;
	Wed, 20 Nov 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3IPc9pwH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387931BBBC5
	for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138456; cv=none; b=nnbrVduAOFzvQukD6dJwHvmiT8htqOazkKSKyrd5xNHrQwxJKO7U8tXn98eB4oHWcFuPdKvyiov5M60G+VcfIdiAceEQ2Q2HizNM7WBn8dVb9Akbt9X/kwlIgQLL9+UzhpYvPLpDmU4jr4d16IikNSG7Qs/Y/CM0qVlZEiSHJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138456; c=relaxed/simple;
	bh=CyydzNDsDkr/quaSIfIhVHyKeXWWtMquRLckOhQ1Ays=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgOkfSp4zN7EXoTYMJeRJAPKpVeVVBbMIAwRvl4HwdbgouLFv7Cg5vp5ZPMd4S4pb7lRPUWOHcq6VQ8ygyTYDn7vCw4j2fbO+qUDAo5DmHrP5HtcU2GWj2YNZD0BB9GvwQ38wjS1SPssG2j5wMiMyodNHqkgs4sdAk04SD8cJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3IPc9pwH; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-296252514c2so224058fac.3
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 13:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138454; x=1732743254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77ie5w/VsDTXsB3Zb7StqnidCTZr0gF72TiY+5MfJgI=;
        b=3IPc9pwHG55nd29+1Rwi0wUX7A6UCLeUTEiPxdnFAsyS+ElPD7bNPKPzATc0w1wx1P
         QKGXYPMDkaODHGr2a+84eya9boaM5H3a6CXvg0SzO5el9uXDzGP/F+kTgzln7NTTiDrB
         /yQb80nPioT+VPSokUqYrkGTJ2ccYxQR4c6vhY4B7mKHuln+tmWm/sMYuZDpiJZ/uBQd
         TxcAH+3PlZqDpWRv6Q549KJ8nQQ5Stw6sxoc4xuNIXLWYDbFRDEkaOR38aRGvZEwQJbd
         GXw6mDCYdHDc3n+XF1gv0EmMi6iHMLtonJe+1xWyw9mw2BhLM4w78V4tRqc844UBie+e
         G1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138454; x=1732743254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77ie5w/VsDTXsB3Zb7StqnidCTZr0gF72TiY+5MfJgI=;
        b=ia8TBRjfxGqcNqA8ryaWKIxSPFSdbeNf/bITAJiUsnJl5IXKK/VyTJfkaR9n+dJkMt
         7vutr1o2WjrPgbT44stZzaBrXAClMRB9qeXMYn2PM1yNVWNU4i7qT/lHKxcbEAJ8Dui2
         1P3IoJ8Mv0DmVlDWyRLpOkbSvKgPY8OANjGTeq14otiC+AWJof7En4OavwCdWvHhBA2j
         6//BBPHOsE2LynpPpEub13J2tWnZE/5rwhh3I5lpYrCIKLvSoahdl3nXDudq+JWyenbk
         +1+PMAJZ2ezwBIF2zSv+QLfN11JJjh0fj1odaTXmGq7KVh67raagMAwXmd+FKsaWqIKV
         gUsA==
X-Forwarded-Encrypted: i=1; AJvYcCX5x3EMegGpJ3jlcJ7O2uAoyRIYYhVWi1+bZU2S5SEJjTteVYnjyMsJECNFopWnLWjA9r0BaSK3waM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3wOKw/tB8aSTKAuDfKeo5m0yQr0hdELH+pRzEJ6pPl0qQrBUz
	R/93f0J4m70OdnaGezflcAgXKMiYKui5GWzj8vLR0mTF40rIV87VIxL+iY0o0xQ=
X-Google-Smtp-Source: AGHT+IHfg51H/POGhX0HCvnX9lVYP+vG5yg84xlJ+/GItJcQcBHCoqSwnUiOnoiXmiJD2aLS8Sy3Mg==
X-Received: by 2002:a05:6871:4393:b0:296:b11b:a615 with SMTP id 586e51a60fabf-296d9e72b3cmr4816484fac.37.1732138454302;
        Wed, 20 Nov 2024 13:34:14 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:32 -0600
Subject: [PATCH 09/11] iio: dac ltc2632: drop driver remove function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-9-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Remove driver remove callback for the ltc2632 driver.

By making use of devm_iio_device_register(), we no longer need a driver
remove callback. Also since this was the last user of spi_get_drvdata(),
we can drop the call to spi_set_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ltc2632.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 28f8347eb687..999348836d87 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -317,7 +317,6 @@ static int ltc2632_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	spi_set_drvdata(spi, indio_dev);
 	st->spi_dev = spi;
 
 	chip_info = (struct ltc2632_chip_info *)
@@ -351,14 +350,7 @@ static int ltc2632_probe(struct spi_device *spi)
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
 
-	return iio_device_register(indio_dev);
-}
-
-static void ltc2632_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ltc2632_id[] = {
@@ -450,7 +442,6 @@ static struct spi_driver ltc2632_driver = {
 		.of_match_table = ltc2632_of_match,
 	},
 	.probe		= ltc2632_probe,
-	.remove		= ltc2632_remove,
 	.id_table	= ltc2632_id,
 };
 module_spi_driver(ltc2632_driver);

-- 
2.43.0


