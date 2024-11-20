Return-Path: <linux-iio+bounces-12438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0A9D438D
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 22:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B41F22608
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698131CACDD;
	Wed, 20 Nov 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S7GJH91g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679D1CACC4
	for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138455; cv=none; b=kjiVg71yZd/qqUrSBys0iQ35JlS3W17lF05cpIaWIbKkIM8XBhE7L5Fa6NZlQJ5kOK2/+9Q2qaX3HnA6IHyAsylUelqQmtG0UrwsbkqZMzAjJw0zZHpRtpJFJ5s6VlTjuGQKtwYxf+gyzLhgsw+C4NG9IWUKahRiLyTr0Ck0vvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138455; c=relaxed/simple;
	bh=cqpjVH/ZHG/gtX5vBp7R7T9+N9m5GCO0J0pDNO2Q4Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJvutiDLpYUxdALJ/tOUwzkXP1a2oibe228rJx2hNJHkenuILtYxsQyAHIG7IUQQbUB9eoTg/PlfF24cWdZyobeiud7+PMXb+Og7tg8dteRS/nkww9/w//Atu3XAA4U9arswFUoB+C1Sd1WI6V64I0U5yjBX5It/wyzKIusO/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S7GJH91g; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-296252514c2so224041fac.3
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138452; x=1732743252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEOSnirGLwe2cYoSNYVfb2qy88ppTs6R6KUAO1rKhdk=;
        b=S7GJH91gJmrpCWxFbekapCN3KauKDd6M5kC3f/Cr42LxAlz6ya7GKhll4OYuvrMaAm
         7muDJLFEDp6vFgBDQGUu8hs5G+Qydrze/U0dc1TksKycDFI2iQ4hB0nMQGYJ6GZL6Vyo
         C+Fkvp6GpIZdS8hqn696xnVHkd6ov9uDb1z5gk+WWZSPglzg2Wb//utFytLs+91nMnF4
         UqtHYG+smUjeNHuz918Fs3zstLm8vTUJ0zj9ctv3gTTpT5XdsAyYdLImlozfVXRK2G/6
         FLbCNb6cQ88yNv3V71lItfo+QC2HOcZD8oCR2poDpQDbubrotnF/sg2+Jui9H43bH4mw
         A/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138452; x=1732743252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEOSnirGLwe2cYoSNYVfb2qy88ppTs6R6KUAO1rKhdk=;
        b=OLw1eiTfQ/07Ov+QXb9mMhcecHUxdspCqo/qT+1Zh+LCQZ/U6IF/AgaOkIBdaQyoNj
         s72ZHCQ62U4qxwFfaYIO9D6Mw+ZeiPQvl3WsNjtrcFcZorq9YbaOYPI8xEm8x0/pdeTH
         EuqTNdlOEE2IFKgiJfXf39OsinmLqLrTe5AdHOUWqPeDotcOslpeIGoCZtKU9ivsanrC
         zajTwiktTikEJv9MpTc2P5Dj6cUCAuTB4e9Z07Ey0f01/oJIfrdk4uTOj0F02Y4j6RV0
         ToZKn22+NrLw13dnb8LgECIBQW/IpgVbdh3PlbOqau9F+ThTE9urE6VlAiUKOigqKSmP
         p4SA==
X-Forwarded-Encrypted: i=1; AJvYcCUruzeNV/9WkXqDGE9k0GNTRvllHVZVJYpTGabQCul9kUhEfaRIimUmY+VWtuOVrs5DhNn1GC5BTkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRdIKy5d7o2xzKeAbLSNOMSnBX7H1Y8r2+tK15l6QletEfx8k
	8Fy2McZ3etJMi/A2mIYnG+tZluhE6wJGvHxnheiwqhyJEDGzCGGx7oPcZcfP+X8=
X-Google-Smtp-Source: AGHT+IE3dNYFl8/w+vB/dPnniS0LPl8Cv8wHc2xOQWuQL26dH5rgdnki/dDN7dDXrEFszIQdl+kJPA==
X-Received: by 2002:a05:6870:c384:b0:296:de10:4ef with SMTP id 586e51a60fabf-296de10524cmr3093227fac.0.1732138452571;
        Wed, 20 Nov 2024 13:34:12 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:31 -0600
Subject: [PATCH 08/11] iio: dac: ltc2632: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-8-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Some use of dev_err() is replaced with dev_err_probe() to simplify
things even more since we are refactoring these lines anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ltc2632.c | 58 +++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index a4fb2509c950..28f8347eb687 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -41,13 +41,11 @@ struct ltc2632_chip_info {
  * @spi_dev:			pointer to the spi_device struct
  * @powerdown_cache_mask:	used to show current channel powerdown state
  * @vref_mv:			used reference voltage (internal or external)
- * @vref_reg:		regulator for the reference voltage
  */
 struct ltc2632_state {
 	struct spi_device *spi_dev;
 	unsigned int powerdown_cache_mask;
 	int vref_mv;
-	struct regulator *vref_reg;
 };
 
 enum ltc2632_supported_device_ids {
@@ -310,6 +308,7 @@ static int ltc2632_probe(struct spi_device *spi)
 	struct ltc2632_state *st;
 	struct iio_dev *indio_dev;
 	struct ltc2632_chip_info *chip_info;
+	bool has_external_vref;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -324,43 +323,26 @@ static int ltc2632_probe(struct spi_device *spi)
 	chip_info = (struct ltc2632_chip_info *)
 			spi_get_device_id(spi)->driver_data;
 
-	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (PTR_ERR(st->vref_reg) == -ENODEV) {
-		/* use internal reference voltage */
-		st->vref_reg = NULL;
-		st->vref_mv = chip_info->vref_mv;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to get vref regulator voltage\n");
 
-		ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER,
-				0, 0, 0);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Set internal reference command failed, %d\n",
-				ret);
-			return ret;
-		}
-	} else if (IS_ERR(st->vref_reg)) {
-		dev_err(&spi->dev,
-				"Error getting voltage reference regulator\n");
-		return PTR_ERR(st->vref_reg);
-	} else {
-		/* use external reference voltage */
-		ret = regulator_enable(st->vref_reg);
-		if (ret) {
-			dev_err(&spi->dev,
-				"enable reference regulator failed, %d\n",
-				ret);
-			return ret;
-		}
-		st->vref_mv = regulator_get_voltage(st->vref_reg) / 1000;
+	has_external_vref = ret != -ENODEV;
+	st->vref_mv = has_external_vref ? ret / 1000 : chip_info->vref_mv;
 
+	if (has_external_vref) {
 		ret = ltc2632_spi_write(spi, LTC2632_CMD_EXTERNAL_REFER,
-				0, 0, 0);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Set external reference command failed, %d\n",
-				ret);
-			return ret;
-		}
+					0, 0, 0);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+				"Set external reference command failed\n");
+	} else {
+		ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER,
+					0, 0, 0);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+				"Set internal reference command failed\n");
 	}
 
 	indio_dev->name = fwnode_get_name(dev_fwnode(&spi->dev)) ?: spi_get_device_id(spi)->name;
@@ -375,12 +357,8 @@ static int ltc2632_probe(struct spi_device *spi)
 static void ltc2632_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ltc2632_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-
-	if (st->vref_reg)
-		regulator_disable(st->vref_reg);
 }
 
 static const struct spi_device_id ltc2632_id[] = {

-- 
2.43.0


