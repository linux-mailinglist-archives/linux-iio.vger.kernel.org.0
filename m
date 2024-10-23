Return-Path: <linux-iio+bounces-11044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43FB9AD8CB
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E3D1C21D37
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08180204033;
	Wed, 23 Oct 2024 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aCC6Ggem"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867D2038B5
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727698; cv=none; b=G/Czh1rvqpAjJPc7/RZ7GmmKDdFx901Z5IkYqqDufsopzOoGFIRiJDmUGz0IjzbUi3l5wtScgHi67Fl9j5DBUhA7RIOWAWafWMgthAR+vSV1IkuCt4NrdIHQly54zk64jzCOozmsusPYDc2D0SasFv5Cjqz2TSZ8vsktHwbMjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727698; c=relaxed/simple;
	bh=WXSUGzKXof4KJHuJTVmWwMUBIzaYKCOmAUkj1cLreFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjXfJWtPNc7r+NPM2MiYAaPUP3KLo4lmTiRoyd26cI1G7ZHJQpNSv4wCtoEBpEfyH5k2RgyFBUw9Tm5UjwONeBOEtRPvLxwZ61yBDgEcdcGQuld5XS0eacInvuyTyWOFzO3gQ+yzSihTF/yZSiKeeZFPLtqwqnG4tgrM+BDH5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aCC6Ggem; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebc04d4777so143532eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727696; x=1730332496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/yIm2be4gnK0+kTlIbceXqBvtukZBq6O9tuHYtKMKc=;
        b=aCC6GgemP32ZW/IW6ShhL3kF3j5NTQnLEBUi6FMRapqVvexVVR1CUUwHcGfRSOjMF9
         m7ALe7AOOpB7ldZtG56S6aLI0QCd0TLuSUu/Lpclydff5OPYt5ISpmHQnc89Ifa8nPIg
         zBc+0uxiJqDZhKCumf7ojIVamDftQnX3+iNaKYhBIB0oKdJ4o+mdFRGTHnDSNeUK+mbO
         1kV4p9gwQHkX0f4c586sVdKwNus7Lagg1EE4m1e57FEPWzZEqsX1xsp1rcuFsgfFkNyy
         REhBbk6QWr8A8M1/rOJLeq3JagWiWpGRxM7FuO8HUxCDTF1YSMzFvVuEjsz0T7orn6Ec
         4vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727696; x=1730332496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/yIm2be4gnK0+kTlIbceXqBvtukZBq6O9tuHYtKMKc=;
        b=TJJeRPr/BVekv2/sC5wHKJ9o9KxBVutOmoSLu4ugDLZ5pwiBGFIaIzjT3Qatr7GnHt
         JMYCaIdEknRlGt2rGplci0U8wGVB1tjJpLg1LTge3PVGwbVETJug0yckrui5JENu2bMN
         uRln7pp4myU1SplFgtgWCSmoXCZdrc8otC5+ruRnWz0Xou7pFMe+CJBvk8M+ENv120hc
         otw7lyMcd+q99qPpsjapoLhz0rLbbt+e8zpjuZqBnGLHinZsFc3Ttzd+2Qu00r/D0pEN
         8UmLUpTRsRh3WdQ6QabI7rPM42e+1nH+QIFZNifKCJg4eJgsl2qagn5YbIqJp8ZKUQDH
         G8wg==
X-Forwarded-Encrypted: i=1; AJvYcCXooxOHeNkVdZzrnsDpdK04/+0GasjxouVdSJA/cMPFMLMdDWGpjRIQFX6rdqd6pTt6rbo31zrp+LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyULouFuI2yQDlH9mpd5dg5yDN+P1XKXtIL2+ZVgzwBHHz/VvWp
	9wG8dyG0D6yxlbltK4EZLcC/yIN7gJ67Y+UJU0u9GbgcTXCQsZhVE48h69ow8HW2GjWtpsN7MUj
	u
X-Google-Smtp-Source: AGHT+IHRTb/aabdrDQ611+8RrwSHC7WNs1WZvC13QFbK4R08i5t4ZJSrfjoYNDOtfVLaC0BtrhH8CQ==
X-Received: by 2002:a05:6820:2209:b0:5e1:cd24:c19c with SMTP id 006d021491bc7-5ebee2fe9b2mr3622584eaf.0.1729727695819;
        Wed, 23 Oct 2024 16:54:55 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:11 -0500
Subject: [PATCH 07/11] iio: dac: ad5624r: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-7-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5624r.h     |  1 -
 drivers/iio/dac/ad5624r_spi.c | 62 +++++++++----------------------------------
 2 files changed, 13 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/dac/ad5624r.h b/drivers/iio/dac/ad5624r.h
index 13964f3a22a4..14a439b06eb6 100644
--- a/drivers/iio/dac/ad5624r.h
+++ b/drivers/iio/dac/ad5624r.h
@@ -54,7 +54,6 @@ struct ad5624r_chip_info {
 struct ad5624r_state {
 	struct spi_device		*us;
 	const struct ad5624r_chip_info	*chip_info;
-	struct regulator		*reg;
 	unsigned short			vref_mv;
 	unsigned			pwr_down_mask;
 	unsigned			pwr_down_mode;
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 9304d0499bae..5a952b45f488 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -223,50 +223,27 @@ static int ad5624r_probe(struct spi_device *spi)
 {
 	struct ad5624r_state *st;
 	struct iio_dev *indio_dev;
-	int ret, voltage_uv = 0;
+	bool external_vref;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			goto error_disable_reg;
-
-		voltage_uv = ret;
-	} else {
-		if (PTR_ERR(st->reg) != -ENODEV)
-			return PTR_ERR(st->reg);
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret == -ENODEV)
 		/* Backwards compatibility. This naming is not correct */
-		st->reg = devm_regulator_get_optional(&spi->dev, "vcc");
-		if (!IS_ERR(st->reg)) {
-			ret = regulator_enable(st->reg);
-			if (ret)
-				return ret;
-
-			ret = regulator_get_voltage(st->reg);
-			if (ret < 0)
-				goto error_disable_reg;
-
-			voltage_uv = ret;
-		}
-	}
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+
+	external_vref = ret != -ENODEV;
+	st->vref_mv = external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
 
 	spi_set_drvdata(spi, indio_dev);
 	st->chip_info =
 		&ad5624r_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	if (voltage_uv)
-		st->vref_mv = voltage_uv / 1000;
-	else
-		st->vref_mv = st->chip_info->int_vref_mv;
-
 	st->us = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
@@ -276,31 +253,18 @@ static int ad5624r_probe(struct spi_device *spi)
 	indio_dev->num_channels = AD5624R_DAC_CHANNELS;
 
 	ret = ad5624r_spi_write(spi, AD5624R_CMD_INTERNAL_REFER_SETUP, 0,
-				!!voltage_uv, 16);
+				external_vref, 16);
 	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	return 0;
-
-error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+		return ret;
 
-	return ret;
+	return iio_device_register(indio_dev);
 }
 
 static void ad5624r_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad5624r_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
 }
 
 static const struct spi_device_id ad5624r_id[] = {

-- 
2.43.0


