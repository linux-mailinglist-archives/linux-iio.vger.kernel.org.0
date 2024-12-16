Return-Path: <linux-iio+bounces-13560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CA9F3CF5
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 22:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8141887BB8
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B591E1D54E3;
	Mon, 16 Dec 2024 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nIw4vgHd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F01D5AB7
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385450; cv=none; b=bD/eW37RIRagSwsi0ltDiIUpV1C2DZvTjG1wrc2ACAlKkRlwA77Rd8sGXOYG+hr/rr9pJkgNk/uZsjVuYjHeZJEWdiaRDhUDsIMrFyUE4SvMiXQk9/R+ePRbfvys354qwQk1kVgEIjN94fh5npuYd6DU4JDOLPkPjrRRItkoEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385450; c=relaxed/simple;
	bh=j1KQVWyRjJzV1KqouG5kBg5gSDPoYC1JMxGnsigizCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SFfoC1kcOYJKD1va6UYKf83U8GFEp0CEgVaww12N/sIo8HQlnqgOZ5mRPuNiqSx/N3x3b2yyOpUg/LsgYnFbikEbX46OqnrCl+MIOv9TZIrE3H/0rzcJCxXI4owsvm0TSeTLyXXdtpUUJYNqiJGoA2rs0L9/KzoLUr4pXVLXAEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nIw4vgHd; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29e2a50586dso2176368fac.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734385447; x=1734990247; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfz8Qyf8HO/uwLU4Ovm0zRhptn7NeZt8a31y9gqWbFY=;
        b=nIw4vgHd70u2ErimWbMMN98vER56lLszSr65mnKSMdpJXg5gDsHps9afEVbf9SuQLX
         L8os97Jr1ykolv7tt2Ti36AoHAE+1OBgCM5MSpMie6Mcxm+3Nk5E/9KPbAG7jH3ZyqlS
         rhO0vuYgBS/u7q33hExtH04wKBLlD01aexaUItvzz1dfk7neCUXRDZWi6TqKYrf5Hx/1
         v1qshHOWqd/s0thVK6ndtacQhSVW6vZrh+kn894BYPgnzHPOCJ2yVLbtrt2MUp1kCF7h
         9SGXZWy1Qz7fqku3wgfc7wTJgBsz08j4qfZrALsJQaQDyp3rDc8xFMYYSxo6FvzRdKHW
         Ih3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734385447; x=1734990247;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wfz8Qyf8HO/uwLU4Ovm0zRhptn7NeZt8a31y9gqWbFY=;
        b=dNRRCaci9FW+A4taUJyI0wE8hWOuvTC2uQpe7VaWQ1C7eUmfjJN8H6XfRJhMKoaCUe
         soasuHX0Yd6HZubwRg+aai/lmpuZitZ6MpxYBtY1NgZgg2GtdL5q5twGF7aURcIXnAdH
         pBt6Z7AaRsdZ3+6ikIs9RuP1CaOqbyGOOpUcYZ8HD+YW9OJWJ4JxD3dDFVV0aFk1wugS
         m8qSi8jG61rbdTEPQ+1QAqWS9pp7PYlrJACieuVB/A7JCfSqToZ29Qyg6xClXaZ6FsOq
         IA0kdso4zu5/M9l10rVjYXbgZbMH7D2hlrv3PC/BwgOLUduewD4Z7dv+jmLVxwHZ+eNP
         LXng==
X-Forwarded-Encrypted: i=1; AJvYcCVmCUYPUj80UZSzGYhrqeSSD7BpejKMSgv1GyekSj3Wv1x+gU8rECIG0pWqpPLMBD6mmKkjcJMxsUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcivRFaQKtPBqe3yLChXm+ICdXOz4qytF/ddUll1ecs+f7VoJK
	rg83n3FVIPUqm3zkcfCw6bRTTGQ7Iq7CXJC22tyVlzwSWYQ+TAihRRiP/6/spuk=
X-Gm-Gg: ASbGncuzfJ8tToyrLJUTouxvyb0XPgmwR+KVjQ+XG+XnwW6xWU0I5Z5B7dvnZDk/Usz
	uSO9auqMegBLN/JP7a/OhwfnHfnNg5ILvg4ux5t5zg+p85G5VZuoPQSa1a8gN4Scp+tLBPt+hr0
	QK4gT80i270t0YK+MZQxjyK+B8EUEtpCno9mlH6PqzHLugNUbA1MHKfeLO7Znci8v/hxu8vBA0L
	p3u5ChdxsoHdgt+wl5Vp2sfAhwUxm2PI0XAqaeZl2V0mPxVl0Vq8/ra3dOvQ2rfu5pNXmCkJ9vM
	OlNez/y8W1vf
X-Google-Smtp-Source: AGHT+IFZrT/j2VKlBtv+4Dva/WHzp4WJgWg8VD0OJ9jwCociHQ6PPiFAIN07RHcnUdsUCquDkKUbBQ==
X-Received: by 2002:a05:6870:392c:b0:2a3:d9b3:3d02 with SMTP id 586e51a60fabf-2a3d9b3b082mr5198901fac.40.1734385447306;
        Mon, 16 Dec 2024 13:44:07 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d2645500sm2233309fac.20.2024.12.16.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:44:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Dec 2024 15:44:03 -0600
Subject: [PATCH v2] iio: dac: ad7293: enable power before reset
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-iio-regulator-cleanup-round-6-v2-1-9482164b68cb@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACKfYGcC/42NTQ6CMBBGr0K6dkxb5CeuvIdh0ZYBJsGWTKWRE
 O5u5QQu30u+9+0iIhNGcS92wZgoUvAZ9KUQbjJ+RKA+s9BS35TSEogCMI7rbN6Bwc1o/LoAh9X
 3UEPTWllZlHWjWpEbC+NAn7P/7DJPFPNsO++S+tl/y0mBhL4yVVnLoUFXPqzZZrKMVxdeojuO4
 wsZlvVvzQAAAA==
X-Change-ID: 20241120-iio-regulator-cleanup-round-6-78b05be06718
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Change the order of regulator enable and reset so that power supplies
are turned on before touching the reset line. Generally, chips should
have the VDRIVE supply enabled before applying voltage on any pins.

While we are at it, remove the voltage level checks. If the power
supplies are not supplying the correct voltage, this is a hardware
design problem, not a software problem.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Dropped patches from "iio: use devm_regulator_get_enable_read_voltage
  round 6" that have already been applied.
- New patch for ad7293 that just enables power supplies and no longer
  reads the voltage.
- Link to v1: https://lore.kernel.org/r/20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com
---
 drivers/iio/dac/ad7293.c | 68 +++++++-----------------------------------------
 1 file changed, 9 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index 1d403267048240be1bf3d8b2a59685409b9087fd..d3f49b5337d2f512363d50b434d99d4e9b95059f 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -141,8 +141,6 @@ struct ad7293_state {
 	/* Protect against concurrent accesses to the device, page selection and data content */
 	struct mutex lock;
 	struct gpio_desc *gpio_reset;
-	struct regulator *reg_avdd;
-	struct regulator *reg_vdrive;
 	u8 page_select;
 	u8 data[3] __aligned(IIO_DMA_MINALIGN);
 };
@@ -777,6 +775,15 @@ static int ad7293_reset(struct ad7293_state *st)
 static int ad7293_properties_parse(struct ad7293_state *st)
 {
 	struct spi_device *spi = st->spi;
+	int ret;
+
+	ret = devm_regulator_get_enable(&spi->dev, "avdd");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "failed to enable AVDD\n");
+
+	ret = devm_regulator_get_enable(&spi->dev, "vdrive");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "failed to enable VDRIVE\n");
 
 	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
 						 GPIOD_OUT_HIGH);
@@ -784,24 +791,9 @@ static int ad7293_properties_parse(struct ad7293_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_reset),
 				     "failed to get the reset GPIO\n");
 
-	st->reg_avdd = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg_avdd))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_avdd),
-				     "failed to get the AVDD voltage\n");
-
-	st->reg_vdrive = devm_regulator_get(&spi->dev, "vdrive");
-	if (IS_ERR(st->reg_vdrive))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_vdrive),
-				     "failed to get the VDRIVE voltage\n");
-
 	return 0;
 }
 
-static void ad7293_reg_disable(void *data)
-{
-	regulator_disable(data);
-}
-
 static int ad7293_init(struct ad7293_state *st)
 {
 	int ret;
@@ -816,48 +808,6 @@ static int ad7293_init(struct ad7293_state *st)
 	if (ret)
 		return ret;
 
-	ret = regulator_enable(st->reg_avdd);
-	if (ret) {
-		dev_err(&spi->dev,
-			"Failed to enable specified AVDD Voltage!\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
-				       st->reg_avdd);
-	if (ret)
-		return ret;
-
-	ret = regulator_enable(st->reg_vdrive);
-	if (ret) {
-		dev_err(&spi->dev,
-			"Failed to enable specified VDRIVE Voltage!\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
-				       st->reg_vdrive);
-	if (ret)
-		return ret;
-
-	ret = regulator_get_voltage(st->reg_avdd);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to read avdd regulator: %d\n", ret);
-		return ret;
-	}
-
-	if (ret > 5500000 || ret < 4500000)
-		return -EINVAL;
-
-	ret = regulator_get_voltage(st->reg_vdrive);
-	if (ret < 0) {
-		dev_err(&spi->dev,
-			"Failed to read vdrive regulator: %d\n", ret);
-		return ret;
-	}
-	if (ret > 5500000 || ret < 1700000)
-		return -EINVAL;
-
 	/* Check Chip ID */
 	ret = __ad7293_spi_read(st, AD7293_REG_DEVICE_ID, &chip_id);
 	if (ret)

---
base-commit: 01958cb8a00d9721ae56ad1eef9cd7b22b5a34bb
change-id: 20241120-iio-regulator-cleanup-round-6-78b05be06718

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


