Return-Path: <linux-iio+bounces-7554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14892FE17
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 18:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8D81F22107
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15E176AA2;
	Fri, 12 Jul 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KeMt8SQl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63917557E
	for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800248; cv=none; b=gkNjPunhN6iaVWZdTt1yN165jpIqJvnWD5JKhI1ZBYaUCokyDN5rlmArH5zJDKldLKx9GpWSwqpifq0jybr9VUjMr+Ao2L0jN0aX2PvNABD/2kGUMtZXmslHxN6TVIFrcrau1gChl67nGkIx2lcyTyrNhgJk8Lm5BOvnPFXuUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800248; c=relaxed/simple;
	bh=LiCm3tBJ7AYWSQZO/TCKsxT1uryLYML0nN19d4B4ZF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWw76Tb2V+2EO2Jq06JHkCYB0OP8G6uwmhhHbGXAUuVUHRzstMho8SPR/TIajLaocR36OpzHhJAcS2f++T4RLXm6r+ZZXo1wcQalPNtpqlCI/k5qTwKDF/u4tannpjGeYtTs24ojc1I4A8GuJNS4bE9r4eXsLRE1n7zwlIGuJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KeMt8SQl; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25e3bc751daso1170541fac.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800246; x=1721405046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yfWKG0y/JQs2Xv+AEtYK/Qt5yfxPJbz/kYQptJy6iA=;
        b=KeMt8SQlM0UjK4ie+NebsRt8QVaRmBzyREDsbvp7BBBBXeUmIwCVV5au67+bk861oH
         IsXsIQH3dygQEvxQoRPNyhGIxOf8yJuEho4nI5YEMbeimzXkOpx0NxjRhaVYJKwwtyYz
         cOx8nSo/DmI68jo9Z16I+/oZzrqnOXz26e3kAVXvF3a7rRh0xO/eQDScyzb99PTmNGAG
         /Iu9RWgUogGmojxW/iFu0ohf4Pf8/pDH6uPShT1o1p/5y6e32OVoEuphuGzaksFqB618
         R6QuWo8qXf3i9ylXRnMw8uOg/JxnaPTRSevR327PEuRzrtd8Fh/B+PwPHsRXW7WxhypW
         2TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800246; x=1721405046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yfWKG0y/JQs2Xv+AEtYK/Qt5yfxPJbz/kYQptJy6iA=;
        b=PoGuyxnyZ+geu8RhKTk1uslGlKz7UzT/BT7m3DrIcaKtYiRamJdu8LHlblBhW0qYkJ
         C65FmaZhzGCZpEurCeTHkBw7N8UTH1/oWgf4izKj78r10JExfiedjKysg00uyBgUN4HL
         0Dg7wL/yeJw2UadPLtwtR8lttszL3Y56dvEhYfgzw3Bck7AMftYHXB6B/49vy9IJT7tI
         Ehg/2FHx8hgi8VmU9OaaQoo0o8vr9CabXfIGi44GL69Kw4oUHvJwUAUtAHd2fqFa1xoB
         730keBO4xjjAhQ9HGlQo4U95VvJx/uA6sWPtW2/4zm5vI19KtPyZ+qr7qe5sdseCB6aN
         +iqg==
X-Forwarded-Encrypted: i=1; AJvYcCXT8gJeT/afGAM1odGkbpjP0KFp2SjXxfpgvcA9m3z23sZkDEunZrhvFCh+g1LfmNsoNpr2grHcxBBQP1VS4Gm6c1Zzs+TCaAm9
X-Gm-Message-State: AOJu0YwDQIkJfNY3hrDRBrV6XotJ0jQyuPP1Ftvr46czZxAiQHffV3L+
	DmGCs1pPnVn5JkqoQatDw/d/9CJW3i46II9Ktw/fFL2+5ZRVdkqM3zA+CZSjiVg=
X-Google-Smtp-Source: AGHT+IFZ4u28V0aXqe1EKH1JX+VjsznMpOJ+/9Zy0MPgBrfQDd+ZR7G8IEC/bVTMldowmHzd8Hm2Ug==
X-Received: by 2002:a05:6870:a11a:b0:254:a57e:1aed with SMTP id 586e51a60fabf-25eae84e38dmr10560652fac.26.1720800245795;
        Fri, 12 Jul 2024 09:04:05 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iio: dac: mcp4922: use devm_regulator_get_enable_read_voltage()
Date: Fri, 12 Jul 2024 11:03:54 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-3-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
helper function to reduce boilerplate code in the MCP4922 DAC driver.

The error message is slightly different because there is only one error
return path now.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/mcp4922.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index da4327624d45..f89af70fa5af 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -30,7 +30,6 @@ struct mcp4922_state {
 	struct spi_device *spi;
 	unsigned int value[MCP4922_NUM_CHANNELS];
 	unsigned int vref_mv;
-	struct regulator *vref_reg;
 	u8 mosi[2] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -132,24 +131,11 @@ static int mcp4922_probe(struct spi_device *spi)
 
 	state = iio_priv(indio_dev);
 	state->spi = spi;
-	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(state->vref_reg))
-		return dev_err_probe(&spi->dev, PTR_ERR(state->vref_reg),
-				     "Vref regulator not specified\n");
 
-	ret = regulator_enable(state->vref_reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable vref regulator: %d\n",
-				ret);
-		return ret;
-	}
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "Failed to get vref voltage\n");
 
-	ret = regulator_get_voltage(state->vref_reg);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to read vref regulator: %d\n",
-				ret);
-		goto error_disable_reg;
-	}
 	state->vref_mv = ret / 1000;
 
 	spi_set_drvdata(spi, indio_dev);
@@ -167,25 +153,17 @@ static int mcp4922_probe(struct spi_device *spi)
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register iio device: %d\n",
 				ret);
-		goto error_disable_reg;
+		return ret;
 	}
 
 	return 0;
-
-error_disable_reg:
-	regulator_disable(state->vref_reg);
-
-	return ret;
 }
 
 static void mcp4922_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct mcp4922_state *state;
 
 	iio_device_unregister(indio_dev);
-	state = iio_priv(indio_dev);
-	regulator_disable(state->vref_reg);
 }
 
 static const struct spi_device_id mcp4922_id[] = {

-- 
2.43.0


