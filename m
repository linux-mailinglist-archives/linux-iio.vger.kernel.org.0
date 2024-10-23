Return-Path: <linux-iio+bounces-11040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEFA9AD8C3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E201F26639
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61491FF7B7;
	Wed, 23 Oct 2024 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OEN7a9NJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848C200B81
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727688; cv=none; b=BgrfMpYyAR3lsq1ZHpo1KOaFqKIqlNdey3HCGPvvg+zXB1Q65tyR9QaUeG5essx2t32i0JcYVEy34Pq7UrIz9CNWSeav30pe2z/utKVmBmdfeUAMp8pOWYL4Y0dEMqe7pTaKLT7cELM0A3blaqu9STbBCM1FhvZUFuGpgndtctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727688; c=relaxed/simple;
	bh=BZeNhUpFlkIYdGaRA/ukfyi29Qtnq8SmBSpRm9b6skE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0ZW3EYyHlC3BjfLYrRwNjSBDQLiM/zNfbI9Ue4K2y9JaBrBHo+NeLjFXHdUMnM/mlp//0ilX4w4wqEUqZDfQp6gjehdGj8wxxPiNbiSInbG30OdoWMsu6QQHKl7TeaIeiGtRxdIP+dHOShdLiTC+j0PaNO2HtkZh9tvv9dpQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OEN7a9NJ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5e7ae4c504fso120253eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727685; x=1730332485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIpJs6ysMWquyQzdUXSLhEt4udqL7m21w5SiuwdawWo=;
        b=OEN7a9NJi/wWWUqM8TdHgN8IFz2fiBenKgnNERE8W6gPb6qFMHP9SsxPBkShkzFcmj
         G326otOw0qdXHQYq7maBUnUTfn6ty8rlBpTqfwt80Tq4p6p8T+KnsZ1a39Mw48wRT59p
         2ucb6bvBHbv8bDG0z6bFexXEdRmAxxc8Q2XOIK/YslNDiFlsHLXFOmIR6Al0X1vPzoBU
         wg9cQ3KO815ibQXylNjAHYchTg7wc86Z94jy1QjZ2pyyTivXMlZXjJIV4mSbOySaSLRr
         K+a+P/KS4n2gwFJ6KGeKpiMkRBmJvNCIeXegKzBeM0NR2dAqnZdxvOXpMg6JpL+44Vez
         i5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727685; x=1730332485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIpJs6ysMWquyQzdUXSLhEt4udqL7m21w5SiuwdawWo=;
        b=W7f6IKQJxh5q5KNfi5kzKWRBHjGxtp+vuazZGXhjrf5fR+KQ8ZkaVXTEsvlHBSM5Ka
         bCU+Q1lvoDjD+2uhz4V9nTr51jroaSVR4JTC5PU30I54klohdS72E4/Hx+SUwUtTh+W7
         iqCLmF+cZYW2xF+df4lB5eySxcSiVU5+3HyFoVVetiBZVEbQ3ziSk6CmFR87vjo25kef
         IhnCoT3CuedVCrUVkcExSSKCacFtf26ws+mS64GXtXL2C1u8KrpqFgtp2Re96qmdhfJq
         v9W/CBrmtTxObXkTv/L2kLrKBVk8JUTMX8wftDgq4K3fO9wSN3nxbOo5nRa5zvOltcWp
         tWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1pkpCLcNHADJ3wIT6YQ7/g7d+Ddia7jggHT5YueC9cTtzckH1FvDz/WZca/9aJ6Xh2JvznLR1pbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAguCwEzgtoc0XOpia7c53Qo35l2Se51DSIF3opPSXkKF5z7nL
	D4NLzppTPemEOn0lhjmVx8IJ4N6JO6NdCNc1TODP9gJuYOp/aBxO22KxDl1CR8I=
X-Google-Smtp-Source: AGHT+IGo8FI1xaZrv+ilwOQNiRHtt7Ey1e86tF2/rnmxXcdoKSdAIdz9WvjSqMtBq2Hp4kNTnjKXhw==
X-Received: by 2002:a05:6820:628:b0:5eb:4f45:d209 with SMTP id 006d021491bc7-5ebee6dd82bmr3108682eaf.3.1729727685558;
        Wed, 23 Oct 2024 16:54:45 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:07 -0500
Subject: [PATCH 03/11] iio: dac: ad5446: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-3-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Also simplify == NULL check while we are touching that line.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5446.c | 57 ++++++++++++++----------------------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 708629efc157..574de97c1c08 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -32,7 +32,6 @@
  * struct ad5446_state - driver instance specific data
  * @dev:		this device
  * @chip_info:		chip model specific constants, available modes etc
- * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
  * @cached_val:		store/retrieve values during power down
  * @pwr_down_mode:	power down mode (1k, 100k or tristate)
@@ -43,7 +42,6 @@
 struct ad5446_state {
 	struct device		*dev;
 	const struct ad5446_chip_info	*chip_info;
-	struct regulator		*reg;
 	unsigned short			vref_mv;
 	unsigned			cached_val;
 	unsigned			pwr_down_mode;
@@ -226,32 +224,16 @@ static int ad5446_probe(struct device *dev, const char *name,
 {
 	struct ad5446_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
-	int ret, voltage_uv = 0;
-
-	reg = devm_regulator_get(dev, "vcc");
-	if (!IS_ERR(reg)) {
-		ret = regulator_enable(reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(reg);
-		if (ret < 0)
-			goto error_disable_reg;
-
-		voltage_uv = ret;
-	}
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
+	if (!indio_dev)
+		return -ENOMEM;
+
 	st = iio_priv(indio_dev);
 	st->chip_info = chip_info;
 
 	dev_set_drvdata(dev, indio_dev);
-	st->reg = reg;
 	st->dev = dev;
 
 	indio_dev->name = name;
@@ -264,33 +246,26 @@ static int ad5446_probe(struct device *dev, const char *name,
 
 	st->pwr_down_mode = MODE_PWRDWN_1k;
 
-	if (st->chip_info->int_vref_mv)
-		st->vref_mv = st->chip_info->int_vref_mv;
-	else if (voltage_uv)
-		st->vref_mv = voltage_uv / 1000;
-	else
-		dev_warn(dev, "reference voltage unspecified\n");
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	return 0;
+	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+	if (ret == -ENODEV) {
+		if (chip_info->int_vref_mv)
+			st->vref_mv = chip_info->int_vref_mv;
+		else
+			dev_warn(dev, "reference voltage unspecified\n");
+	} else {
+		st->vref_mv = ret / 1000;
+	}
 
-error_disable_reg:
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
-	return ret;
+	return iio_device_register(indio_dev);
 }
 
 static void ad5446_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
 }
 
 #if IS_ENABLED(CONFIG_SPI_MASTER)

-- 
2.43.0


