Return-Path: <linux-iio+bounces-7893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B13093C8A7
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 21:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A518C1C20B02
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 19:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7BC33CF1;
	Thu, 25 Jul 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/UoYBBJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CA41C6BE
	for <linux-iio@vger.kernel.org>; Thu, 25 Jul 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721935379; cv=none; b=UNgaj74o8hTfdzEaJbfqlNuwAhOIRF8IogZQygE6/V2HLbKcloq0mTzETsUM4ZwD+1a5aV3MKRNksm8yWzFY0JT3n573HmxQUvCQ/UNoj3nkbw75O2SNYV7IFZiq5jp2fozW5xoro2AERh3X8wom8tk1oxrz5JtnvDdbLZ1P6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721935379; c=relaxed/simple;
	bh=W74KhW7f18fdckH7PTnmfHoJXiOMCXxtfnQ2XKj2YVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j9EELJ8SgA15n3uEHsytFdvsqg563GlSzYONPkP8fctY0fxiiARc+OOVDcgNAyPRHZxiOYxi7tthUC+0pE94c+6pHi8w+R2mKmQwPwr05/SZjckQuHz7xbHV0EOYmsrG0xsxA32t21ofPpGZuAg5fEsG7v6DcgPhg+X7BwVY5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/UoYBBJ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5b850d969so151178eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Jul 2024 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721935376; x=1722540176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQMh1UJAxymzMN0ie+0N/QmjWGT/RhgZsPJdQF8YRPU=;
        b=r/UoYBBJ3Oye1sxuBHmMI6HcrVE7bRqgsUog/iYYK72qaIdi68L7t+4xXn223Gn/Py
         1fDz+oLmFqR4mpChqSDB/a4IqbriuOpAWUWio4z0XztHvrwoyEE/cp33D1NRQHYcNGrz
         eY2lkALflsHeQKGOzNrXG+PksokJ3nAe6OEvSpWIilIRPZ3hmlRJoHAc9ekktgKECO6U
         BmS33+JxCqjDpXJEgPTACT9yWo9tj4CiQJikvGP06VMi8fx7Hf3UIJ148ATJX/QYqz5p
         kXLotvuWcdtRw/YYRWXu2HwZ6+8IIyz6OZUnMu1tKl1k5YGPo3P9U/ZLvLfcr+q7ozsV
         +aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721935376; x=1722540176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQMh1UJAxymzMN0ie+0N/QmjWGT/RhgZsPJdQF8YRPU=;
        b=IKVY78wl+8d5zW1Pk+P1JVqDlTX8gpsAHQ2QCwix32B+SlJ3RJlCnkCFcppdN0eGEP
         gPpBRaCRrX91s/WY/GSnlAnGZy4C2qed4YOlbIrGdveC2o986nY9TT8+5q/tWqnY5HVi
         0QM3XzwKsJMUB8o6dNQehvIxVFfPERHVpIq4rKAf4+gI4PAw9QyMShJEzsfVTiiXc0x9
         1SwVtAcIrVyv5JDg9OCg0YZS6IQCosoaDbrbOUnhMp7+ZXlLzLEAG+B/7n+/bbvTF77P
         nqD7EvmMlDof7Ql3MZcXMDqGX0MD0Viu+1/3jZqeCH/4nGvxeqBhGdsdpiKTh2l3viUv
         QqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1AGIEwNxi0x95N7qsBiI4qDS0if3wX6fdLySx5jeokxtbqSmkpK2pSfO1QCC2BAzOgSJ6i5B27egsMGYFFqoaAxr1l8F1m/PA
X-Gm-Message-State: AOJu0YyUkMV6acjBYZ9qbK0izkbmLJURUeWsbIFTR/Xgmf1C5nQ3Um/p
	BB4pIJ75jxUpM6Ff2Ml0c//v3jb/fT705nRmaO2jzEWdcBjaStmjh1kkN7bvEwHPPJlJuoARX1W
	7
X-Google-Smtp-Source: AGHT+IHMS9ikhdwjEYofufmWSmmPD+rPCz3HDWUd5S/cb+div34BY8osZupPZHJa9CXarrFW8kIhUQ==
X-Received: by 2002:a05:6820:1b09:b0:5c4:7b18:b8eb with SMTP id 006d021491bc7-5d5ad9c892dmr5616917eaf.2.1721935376103;
        Thu, 25 Jul 2024 12:22:56 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930778280sm417754a34.64.2024.07.25.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 12:22:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	kernel@pengutronix.de,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-tsc2046: use devm_regulator_get_enable_read_voltage()
Date: Thu, 25 Jul 2024 14:22:51 -0500
Message-ID: <20240725-iio-regulator-refactor-round-4-v1-1-55e9dc1de325@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable_read_voltage() to replace
tsc2046_adc_configure_regulator() which does the same thing.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-tsc2046.c | 54 ++++++--------------------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 24b1d4390872..311d97001249 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -142,7 +142,7 @@ enum tsc2046_state {
 struct tsc2046_adc_priv {
 	struct spi_device *spi;
 	const struct tsc2046_adc_dcfg *dcfg;
-	struct regulator *vref_reg;
+	bool internal_vref;
 
 	struct iio_trigger *trig;
 	struct hrtimer trig_timer;
@@ -258,7 +258,7 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
 	case TI_TSC2046_ADDR_VBAT:
 	case TI_TSC2046_ADDR_TEMP0:
 		pd |= TI_TSC2046_SER;
-		if (!priv->vref_reg)
+		if (priv->internal_vref)
 			pd |= TI_TSC2046_PD1_VREF_ON;
 	}
 
@@ -741,49 +741,6 @@ static void tsc2046_adc_parse_fwnode(struct tsc2046_adc_priv *priv)
 	}
 }
 
-static void tsc2046_adc_regulator_disable(void *data)
-{
-	struct tsc2046_adc_priv *priv = data;
-
-	regulator_disable(priv->vref_reg);
-}
-
-static int tsc2046_adc_configure_regulator(struct tsc2046_adc_priv *priv)
-{
-	struct device *dev = &priv->spi->dev;
-	int ret;
-
-	priv->vref_reg = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(priv->vref_reg)) {
-		/* If regulator exists but can't be get, return an error */
-		if (PTR_ERR(priv->vref_reg) != -ENODEV)
-			return PTR_ERR(priv->vref_reg);
-		priv->vref_reg = NULL;
-	}
-	if (!priv->vref_reg) {
-		/* Use internal reference */
-		priv->vref_mv = TI_TSC2046_INT_VREF;
-		return 0;
-	}
-
-	ret = regulator_enable(priv->vref_reg);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, tsc2046_adc_regulator_disable,
-				       priv);
-	if (ret)
-		return ret;
-
-	ret = regulator_get_voltage(priv->vref_reg);
-	if (ret < 0)
-		return ret;
-
-	priv->vref_mv = ret / MILLI;
-
-	return 0;
-}
-
 static int tsc2046_adc_probe(struct spi_device *spi)
 {
 	const struct tsc2046_adc_dcfg *dcfg;
@@ -825,10 +782,13 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	indio_dev->num_channels = dcfg->num_channels;
 	indio_dev->info = &tsc2046_adc_info;
 
-	ret = tsc2046_adc_configure_regulator(priv);
-	if (ret)
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
 		return ret;
 
+	priv->internal_vref = ret == -ENODEV;
+	priv->vref_mv = priv->internal_vref ? TI_TSC2046_INT_VREF : ret / MILLI;
+
 	tsc2046_adc_parse_fwnode(priv);
 
 	ret = tsc2046_adc_setup_spi_msg(priv);

---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240725-iio-regulator-refactor-round-4-13f032a6f2cc

