Return-Path: <linux-iio+bounces-6691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5D5912EE8
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214AF283DA7
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 20:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FE117C7A4;
	Fri, 21 Jun 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OQMtcmVH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369417BB26
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003103; cv=none; b=Yz/MDne6bAhigh6bo5dHlWK8qZ7xQhHb4KcmjRa09iJMX8RXC8UzcU82Uz6NZX0EgdyLGD1SKSq56tDdn9l8XIs1BXDtEjzuD0XimCWMkA2J/KxqQ4hJn+veswa02fBNDlTHwA6rBpF2IrYm0j5RW6f0mvZZ6KNpDQO1TIxcThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003103; c=relaxed/simple;
	bh=M5ncsogjwIKi7yTwd3on+qTwjMFKb9OhWUuYpkcn5s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkc3gN/BQi4Hze4FndY7bh/T7tzE9YcHC7n5kSJWjkwJQOSQW+pNnx+Oph0J/zlUmfP3QzvEkDSqSANMjCuGftg86E4wudKbErBwrS/j1zkfNAZCMD9+Bpx0mPZVCuQcprXHmET6F/giLUp6nnbDFWxHaaWajsGYFkh5X4unCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OQMtcmVH; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d516d3f0b2so1463779b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719003100; x=1719607900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keq6dAlPadRHMn2hspGHDGXT5Yre2UihnSFV/6UPPyU=;
        b=OQMtcmVHb2os4Ig1fSbc4NNPpl18XL6hFGMqxJ/1M1WyX+fBoxFTKG+ayktWk4FB2F
         b358bfJvHJjh5Ibn9Q8UhU7xWaMz73AKXrHVHr4itznrmB0SrADT+q1g7CUAkR8xQzic
         QNEII7HYMX4xZntONgf2IftB81wGXVX4cmQCCEkpeadZ4JH+V9EWPe4jHtoUgFbNlYxy
         GuvYUxoHLWHrA/ZMotsBCBAGI2lOQVZ4auvqaL3k7Q1NMFMynNhu6Whwn4aUUJSWtvqt
         0DpcUnqpkPqEvASsjd5mCIradRm6y8QJqNfk/pNtYzj+enT7NSEudIKMtgbamasyNtBK
         H8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003100; x=1719607900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keq6dAlPadRHMn2hspGHDGXT5Yre2UihnSFV/6UPPyU=;
        b=bausPLWZxtgQDoUEdyHizJ5dZSF9yuJTHS+JnR3Doo/R4wILIu56yaHE9rc36m2duz
         qYRGHT6x3wFVJwDOgBL6ruQuhDz26kGFgpRDnhxE3M5l2QbAbhBlkzjOo+3aecudCLR+
         ivZjy/j0OLDbt23XuuJLaa+4QXHfbxNAA4r902NJKXncpqACScMUzkiF2fqcMZIuWaWp
         lJC0u0eGDH8CWj4qpC19MZjLI8kjU76JJ8+gGjmIsFaQhItSezsFIhw6t1DbFxUID5fR
         oHhwIOMuvhOhDwj4ZIEbemN1Hsj3WdAQFRQ/G2FED8YAfrHySX+KvTyg0Vjbsc1FtxWb
         JH0g==
X-Forwarded-Encrypted: i=1; AJvYcCXYIJ83kIDSXomyjFjL4dMXTEDlGBGc5SN3MXcZNoAnuQ/wPSXdzYRIOgOp8zI0RjdnAhlyokimnVtv6vFM4MLDfGUicAGsuCim
X-Gm-Message-State: AOJu0YwInP6MbYAfBERi4Jl0s12nL5VfrNaDg9SGsMMmqX7ZiQV1NwmF
	CkmshCji0U8RdHk2YI8CHSxBJ0FTrLBCCXXz89OhDrWO47jGR9TgeVR7jswCsbM=
X-Google-Smtp-Source: AGHT+IEczRmq7EpJ/frerAFCfsSGm1g7w7xf40xN3hyRyZjge33d8FOSAQi0k4RN4+jkSstOJt1cxg==
X-Received: by 2002:a05:6808:f8b:b0:3d2:2aa8:3b2c with SMTP id 5614622812f47-3d51b9e2b73mr10572440b6e.33.1719003099967;
        Fri, 21 Jun 2024 13:51:39 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5345e584dsm428089b6e.55.2024.06.21.13.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:51:39 -0700 (PDT)
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
Subject: [PATCH 3/3] iio: adc: ad7944: use devm_spi_optimize_message()
Date: Fri, 21 Jun 2024 15:51:32 -0500
Message-ID: <20240621-devm_spi_optimize_message-v1-3-3f9dcba6e95e@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
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


