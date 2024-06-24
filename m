Return-Path: <linux-iio+bounces-6851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4121991583F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 22:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EC328606D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEF1A08CE;
	Mon, 24 Jun 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZTx//brT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2319DF5D
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261997; cv=none; b=Drkb0T5kp02US9NPMA/iAHOFSyJaHvI2bTP00tAIV0kO6/sMLYHRaMRIIqiO7j8PS4IbqlihjTG56lDwhGo2SAFgGY1RXBlWYCZK7IpSDtBFRSsUfF1FRK1Kz70eep2hV/kaJlwBO0DxEoZmoGlsg2lQ6hCfbbdiTNQYAbpvdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261997; c=relaxed/simple;
	bh=M5ncsogjwIKi7yTwd3on+qTwjMFKb9OhWUuYpkcn5s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM3GEsbnVZ5M9SKRDzeq5mNxpYqH9WMBpUsdEvB483FZZIolESJLgTRm3WIpJjrljJlI2wI7Psd2fHUs64KUI+elyCX8rZDxzmieBWlpMsL3VoiACDq2sDdHk1V8a7rj6VoPJa8GENQF00YZpw/QNfPWo6SEV8EeRYWjviACmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZTx//brT; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-700a6853664so1584808a34.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719261994; x=1719866794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keq6dAlPadRHMn2hspGHDGXT5Yre2UihnSFV/6UPPyU=;
        b=ZTx//brTD8K18G842k/4ZHXiw/KkGaEtWETy9vIM1vMgW5Sl7JMOfF/fhCGUjHHcn6
         Zxs3t+h3cl4hx4Syk6eQgQUmLr/wzdm39GYHxvwEq+AKg1TeKxQYLUMxjMrvQpY8ofLS
         jIz5HA833nzMUDJr1XoMKbWJvreUNfmwGn/Lk57K3tSJDbH9OAAbr0JhdnZZZ1djPTXo
         VT2wpTBuM9IB9PaCLb1VgqN/BTatgBrSknDncVDdc5sq80WjfRg1Cip0X3LXJDqZCPUd
         MsqQAC2mWd6KcRsdscrrLgwdCszJGZq+WUMR864x/cExeWq437VfbFsqjXMOiusCCjAV
         4m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261994; x=1719866794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keq6dAlPadRHMn2hspGHDGXT5Yre2UihnSFV/6UPPyU=;
        b=pwytk88lRWbhpqzCGpPlkVJHPY8f1/lYkY0G4Yp+sPdqGRwVqIzxmpZau4dthqU0pj
         W+QUeJiIF/7fRnDbYFPd1MHD4NOHnqrLyO/aMcW8hq+m5objr6xMeLuor1DD4/YEn5iU
         8Kf1lFM7JxkHCAw7vX1uSPulYsaH4G0T3iL0pC5p49ypT3Ta18IpGujiL13pD215GmzA
         HGHqrD2C0nOCxl0tDr4xW2xjOQ1gw9m/E0RQIsd68TQcV8E1LBq+J3NmyBWqhVT3XSL9
         HnS1jfmSpGBjpN5tRPv3c67dOljsv60u/yWqElCDoyMc5ZI8a+yUGO2ViV/mvADy9NrU
         ePAw==
X-Forwarded-Encrypted: i=1; AJvYcCVgg12LW8X29i08tI0Hg+oIHd+2qsUjWojkYBU66Av7Z7ltXLKP5b1e/ftmSnpZsmMKo7ppT1cV4gYRT4E2s5vOfcbojAxIPSM4
X-Gm-Message-State: AOJu0Yzw1LZOt3by/+HPYYRJSvYsJhPVOWZhSNNn2avss5pu782IqOnz
	hhddGlKNF6Tg0tK5xeK66aG8gA36hiuuCeVP7th6VfZAf/VKw+R51xgk29D0hOY=
X-Google-Smtp-Source: AGHT+IF7EFvGMEWr3pSOe3ttWzuPOBO9uekNYTXi7CPcw+9uIitHHwkUX7fmGEK32jf/6d5fRZGkyA==
X-Received: by 2002:a05:6870:d629:b0:251:2766:deb5 with SMTP id 586e51a60fabf-25d0163f01bmr6692531fac.9.1719261994534;
        Mon, 24 Jun 2024 13:46:34 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c106dbsm2092849fac.58.2024.06.24.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:46:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: ad7944: use devm_spi_optimize_message()
Date: Mon, 24 Jun 2024 15:46:08 -0500
Message-ID: <20240624-devm_spi_optimize_message-v3-2-912138c27b66@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
References: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use new devm_spi_optimize_message() helper to simplify repeated code
in the ad7944 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 4602ab5ed2a6..a6ac17c13a29 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -134,18 +134,12 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
 /* fully differential */
 AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 
-static void ad7944_unoptimize_msg(void *msg)
-{
-	spi_unoptimize_message(msg);
-}
-
 static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
 					 const struct iio_chan_spec *chan)
 {
 	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: can get better performance from some SPI controllers if we use
@@ -175,11 +169,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 3);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
@@ -188,7 +178,6 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: can get better performance from some SPI controllers if we use
@@ -209,11 +198,7 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
@@ -221,7 +206,6 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 				      u32 n_chain_dev)
 {
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: SCLK has to be low before we toggle CS to avoid triggering the
@@ -249,11 +233,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 /**

-- 
2.45.2


