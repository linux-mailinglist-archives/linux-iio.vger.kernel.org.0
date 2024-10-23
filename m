Return-Path: <linux-iio+bounces-11043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ACE9AD8C9
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5E91F26B91
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC020371F;
	Wed, 23 Oct 2024 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pEHMMLjj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534920110D
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727695; cv=none; b=gZK8uwVLDyoD7p2d2mtztRV1rccfgZfGrbs8YqFnQFsOUFQNsaUvOI571hisD+SwhlmjBSPx6e+pZ5spHb5z+fA59S6YAcHjbA5IGH+UJWVn7VkoQwp5+ImYDO3415LSg7we7ns0ho7QxwtNUjUFFeZmIHrpx8P3/NHW99svvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727695; c=relaxed/simple;
	bh=eodQcTyvrhGf+yUx3CV8lHgZoGBVQssedMmfdXFFW70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mzi7c7BCrz/sFoitYCLnq9HkxviDspc3gJC2UQPPFXYo7tH3k036CphsALM5bf4tH0rThpowYmTjnMyykYC/TM+WUIeURGsX5eWSq3LNFb3J2mAbL3WueaoVSWvlOHgJIouzqHnv0IqFb4pJ6upulZkATNcCrtECg5WzoflZbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pEHMMLjj; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-718123ec383so202406a34.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727693; x=1730332493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNDl0JsjI2ngL2OUq0CBnv+Q1hyMOtpynagqCTgnhh4=;
        b=pEHMMLjjBfPq/OGxfTStJ4BXiygNm9szm+eUn+yBT82JC8OO0Stw4QH2+F8t92Mujh
         J3BvXQdXhr2GE4THd9jHE3tezddcsZ3EFCKMCNpce5xOTvhw+KqVR25pcMQAhZWAFZAR
         18m8tSreFrxozz2DMXXRiajJ8u51U86yIAjNvlUELLtOstqzMnMdCgY2OaC7FILjMUq9
         1MvAAOeM9ae3G4s7qelBBD/HJkAaan1rX+pzm4hHZq17sYAh5QGxBzGwD4SqN3XRG7IE
         CJSknZqWomNnrc156eqepHCkhr70wXfAcAHMIb5YJNm5VAEgqz9RYrmppNyoyfLFxJan
         vayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727693; x=1730332493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNDl0JsjI2ngL2OUq0CBnv+Q1hyMOtpynagqCTgnhh4=;
        b=Z9XQPvwO6ilkE5tL3eIP3Cco2pEnbjM1Nxl/i8wcVSY058aFhK8l+RDwWkKqbBMaKj
         ZGBylREg/TRs4bulyX+0ngAtXorUSB9JNT7btOkM8MeEpumqfbf/blYFlHc7AT5KuC64
         U0pM91WkhiH+mEgSGzuGQKma1v2JHkBq/faBPkF+oSzv+tpqZAJEJJUEnL8qBY1FGpGh
         gbYjjfR7gCK6A/3Y1zgjnQjmmGOg7pp3TwNSKnOh0E8YmfGrBJ9kmUvhVYYm3OoDA91z
         8YCZt9Lrm6ZgKwzX+Dt7svjInPFcdQfdD631LI6nTwofmmDXXpGE085qGDDMU3hDee/C
         rxWA==
X-Forwarded-Encrypted: i=1; AJvYcCWbthMYy+LAyORMkuTI35dtPatiAKcBEJ4XKxuXOM8SkKGCoSkgqOu7JHhqHTf0VR20PRkoU8iuCZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOlbSpoV07g/NdDRDuROVvkdqNLm7qhMM66gvmUoja7YGE02g
	OID6OdAXLycJmxAHh8dykTXKcrSGhSR+8ccN/PhLTvxouZob+k5IRmcWkc+kPd/Gilqb5cEiOJN
	W
X-Google-Smtp-Source: AGHT+IFIuwReVcdIdbunzDzkviLkIqgHxfk94OzuL5c7zcvw3lrHA5VqCjHLaUK5+XcjjvThPDRwKA==
X-Received: by 2002:a05:6830:448b:b0:710:f375:a6c9 with SMTP id 46e09a7af769-7184b286fd8mr5065169a34.7.1729727692954;
        Wed, 23 Oct 2024 16:54:52 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:10 -0500
Subject: [PATCH 06/11] iio: dac: ad5504: drop driver remove callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-6-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Drop use of the driver remove callback in the ad5504 driver.

By making use of a a devm_ helper, we can avoid the need for the remove
callback entirely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5504.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index f1717955ddcf..ff0765c8af47 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -279,7 +279,6 @@ static int ad5504_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 
 	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
@@ -315,14 +314,7 @@ static int ad5504_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	return iio_device_register(indio_dev);
-}
-
-static void ad5504_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad5504_id[] = {
@@ -337,7 +329,6 @@ static struct spi_driver ad5504_driver = {
 		   .name = "ad5504",
 		   },
 	.probe = ad5504_probe,
-	.remove = ad5504_remove,
 	.id_table = ad5504_id,
 };
 module_spi_driver(ad5504_driver);

-- 
2.43.0


