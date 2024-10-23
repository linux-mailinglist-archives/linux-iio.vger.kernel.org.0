Return-Path: <linux-iio+bounces-11046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A635E9AD8CF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B91284428
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF061205E38;
	Wed, 23 Oct 2024 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z2VZ0kpt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F97204939
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727703; cv=none; b=AOObP8WXTdhSN+wo1udSGVMRZBGu5Z5h5h79WcqEvty+90M3idZGvwj48RIF+RbFsBekSBa9JB+punr1luRbHNLJRdCFAj3fGR7ZaW/DfFS71suleb87h1JEamMXFyDwxWfKAKLs+WOK4v9Hff+oFwiWyndIPQ6yEjaqpmcMzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727703; c=relaxed/simple;
	bh=hksfyNtvI8c0zcSVYvltOkcB7HflUdZ/dnRTHZtLyNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7v5x4NzzfZAlgNrXTYOP03Vh+9ixp0ZhvkTJTSLxSaymHyK09wGsFRxO6DW5NkGp7pG6hlBWFfD55PRRw3fl2Q1FmVK+4T9k4GBl66HOVo7f+pz/KoSdg1+exjsDWq9Sakp9NJrutMFcPVDxa40ANCFBGOVNySPw7PxNUY9Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z2VZ0kpt; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebc52deca0so136035eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727700; x=1730332500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXgjcYC4V8hToJDHO7m0/QEhFcbQteqE49QtIsCR78Q=;
        b=z2VZ0kptcjguzXDG5NWkuGrpzlLQfk5BQU5/g6SD1qalZysxGHX5GZ0GxrkK/0o3Kd
         MeTodPAZrGgyrf7TwUmKswcDYAcTeAM5ze/wGbV9BLA24BvoclYqpEaRR55lmoZJY7AC
         V3bgL1d6rWo8OR02PxxsL/dnSyPw5xuMycDMXELGE2AjmjXUSIn+oZD0bDYqHvWxeypZ
         Zqu4bZ7hwphxFxRVBLuyaEPn7hYO8wfuT9MqBddNvgG6IChXUsLHY9mjo+bbL+E1X68w
         7yFShwdO1DN5NDg2QZ1UySZUHf+83lRywDL0gBgEn0LNKkXB8DLjV3Jtw5EbHnVEB7aQ
         MSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727700; x=1730332500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXgjcYC4V8hToJDHO7m0/QEhFcbQteqE49QtIsCR78Q=;
        b=gv35L1DhyViOjP07U3kakSwhzWZ1A5Mp61QFuqnMI6eMEXXGPJAWIXiJ5Z1RQnOEyb
         +MUAC3duTUJL41cCV2VJbn7ogq2R6IKZNbSqLtQLXSZlYkJIq0k5nX7qGWz01VOITdJF
         07R8bgkN6VTOBI4+cRzeJcYoXkitv5DJYClaw1Uz+89O30SUilLFmw99U0ojQ1EV7qVH
         JOA0myNfQA/83HItmwN41YIlb8rDB19tTGofSXp9egS58eyzgc4GBIFkzrTr9k4YaCKW
         ew+cVEB4krxbIIuu/cv1STUuzlAL1PLD/53rBLnFMoOeP3bHWIRzDh230tAlBpxADt4T
         rhHw==
X-Forwarded-Encrypted: i=1; AJvYcCV20RViSIvyWrzZ4AQy+Dhp8Lkl2MPgPSHQwHPt4XPm8SfQZHOwMIi1G9h+efiq1XyeTVOpldRQazs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsCG51m+zz6F8H9Q7y00VSon8C4SR7SsnnZzarmgim9E05mv+
	Dv80iGNqp2BWhXQWz9dUZwThWWYAZvY0IMqbXZ6opqSfPsTzH3dXAAFvZuPqE/c=
X-Google-Smtp-Source: AGHT+IHX8HP07MxzT6bYrvS2Paasp659iMVaVElKbts9GaB7FyQn3FIL5fyqdvanLn34LceSDDaHRA==
X-Received: by 2002:a05:6820:1c8f:b0:5e7:cb2e:e01e with SMTP id 006d021491bc7-5ebee8fb6ebmr3022145eaf.7.1729727700604;
        Wed, 23 Oct 2024 16:55:00 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:13 -0500
Subject: [PATCH 09/11] iio: dac: ad5761: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-9-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Error returns are updated to use dev_err_probe().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5761.c | 100 +++++++++++------------------------------------
 1 file changed, 23 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index 6aa1a068adb0..55e33cf5806e 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -53,7 +53,6 @@ enum ad5761_supported_device_ids {
 /**
  * struct ad5761_state - driver instance specific data
  * @spi:		spi_device
- * @vref_reg:		reference voltage regulator
  * @use_intref:		true when the internal voltage reference is used
  * @vref:		actual voltage reference in mVolts
  * @range:		output range mode used
@@ -62,7 +61,6 @@ enum ad5761_supported_device_ids {
  */
 struct ad5761_state {
 	struct spi_device		*spi;
-	struct regulator		*vref_reg;
 	struct mutex			lock;
 
 	bool use_intref;
@@ -287,63 +285,6 @@ static const struct ad5761_chip_info ad5761_chip_infos[] = {
 	},
 };
 
-static int ad5761_get_vref(struct ad5761_state *st,
-			   const struct ad5761_chip_info *chip_info)
-{
-	int ret;
-
-	st->vref_reg = devm_regulator_get_optional(&st->spi->dev, "vref");
-	if (PTR_ERR(st->vref_reg) == -ENODEV) {
-		/* Use Internal regulator */
-		if (!chip_info->int_vref) {
-			dev_err(&st->spi->dev,
-				"Voltage reference not found\n");
-			return -EIO;
-		}
-
-		st->use_intref = true;
-		st->vref = chip_info->int_vref;
-		return 0;
-	}
-
-	if (IS_ERR(st->vref_reg)) {
-		dev_err(&st->spi->dev,
-			"Error getting voltage reference regulator\n");
-		return PTR_ERR(st->vref_reg);
-	}
-
-	ret = regulator_enable(st->vref_reg);
-	if (ret) {
-		dev_err(&st->spi->dev,
-			 "Failed to enable voltage reference\n");
-		return ret;
-	}
-
-	ret = regulator_get_voltage(st->vref_reg);
-	if (ret < 0) {
-		dev_err(&st->spi->dev,
-			 "Failed to get voltage reference value\n");
-		goto disable_regulator_vref;
-	}
-
-	if (ret < 2000000 || ret > 3000000) {
-		dev_warn(&st->spi->dev,
-			 "Invalid external voltage ref. value %d uV\n", ret);
-		ret = -EIO;
-		goto disable_regulator_vref;
-	}
-
-	st->vref = ret / 1000;
-	st->use_intref = false;
-
-	return 0;
-
-disable_regulator_vref:
-	regulator_disable(st->vref_reg);
-	st->vref_reg = NULL;
-	return ret;
-}
-
 static int ad5761_probe(struct spi_device *spi)
 {
 	struct iio_dev *iio_dev;
@@ -363,9 +304,27 @@ static int ad5761_probe(struct spi_device *spi)
 	st->spi = spi;
 	spi_set_drvdata(spi, iio_dev);
 
-	ret = ad5761_get_vref(st, chip_info);
-	if (ret)
-		return ret;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret,
+			"Failed to get voltage reference value\n");
+	if (ret == -ENODEV) {
+		/* Use Internal regulator */
+		if (!chip_info->int_vref)
+			return dev_err_probe(&spi->dev, -EIO,
+				"Voltage reference not found\n");
+
+		st->use_intref = true;
+		st->vref = chip_info->int_vref;
+	} else {
+		if (ret < 2000000 || ret > 3000000)
+			return dev_err_probe(&spi->dev, -EIO,
+				 "Invalid external voltage ref. value %d uV\n",
+				 ret);
+
+		st->use_intref = false;
+		st->vref = ret / 1000;
+	}
 
 	if (pdata)
 		voltage_range = pdata->voltage_range;
@@ -374,35 +333,22 @@ static int ad5761_probe(struct spi_device *spi)
 
 	ret = ad5761_spi_set_range(st, voltage_range);
 	if (ret)
-		goto disable_regulator_err;
+		return ret;
 
 	iio_dev->info = &ad5761_info;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->channels = &chip_info->channel;
 	iio_dev->num_channels = 1;
 	iio_dev->name = spi_get_device_id(st->spi)->name;
-	ret = iio_device_register(iio_dev);
-	if (ret)
-		goto disable_regulator_err;
 
-	return 0;
-
-disable_regulator_err:
-	if (!IS_ERR_OR_NULL(st->vref_reg))
-		regulator_disable(st->vref_reg);
-
-	return ret;
+	return iio_device_register(iio_dev);
 }
 
 static void ad5761_remove(struct spi_device *spi)
 {
 	struct iio_dev *iio_dev = spi_get_drvdata(spi);
-	struct ad5761_state *st = iio_priv(iio_dev);
 
 	iio_device_unregister(iio_dev);
-
-	if (!IS_ERR_OR_NULL(st->vref_reg))
-		regulator_disable(st->vref_reg);
 }
 
 static const struct spi_device_id ad5761_id[] = {

-- 
2.43.0


