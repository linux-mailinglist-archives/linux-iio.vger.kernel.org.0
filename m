Return-Path: <linux-iio+bounces-14360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F8A10AEA
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C78018828B5
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97471D63DC;
	Tue, 14 Jan 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b+fxTTb1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25511CCED2
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868716; cv=none; b=W0YivMhAjRuwFHisO7pMRCuBW3cFNxs+pgYl3aivcd6ix1XNLyOhbwK+SXi2NQoENEz9zjdoPvwMX4o0EjWU5jrE0+sqI8j0p+UBvBrUvjEbj1T2QXG77EkQ9SsJcfQoB0ZSfgd5HHFspuQiitiLKw0iz/zN/exCzH6QDwarVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868716; c=relaxed/simple;
	bh=v1+O4noY3O0s65OrfzA8R59Ys8F2s28DZZGvtlbpJsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpUwct/FyoUepiCnVqzUYr2kLDF4FVTNzwSQ6u60OJ3YagfYBMO+qe8+oL72mNuYXld1YX3liZwx58vNVfK8TFxSdqKRgY1IsPyeUocEita15Ll9BCIg0Y5opoFjx18/pALZMa/N7EY7ijYjH3yXPABd/ZWpnzw37wfoyP+Qh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b+fxTTb1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43690d4605dso39431985e9.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868713; x=1737473513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuhTyNXJGoJmvY2b3b+eX+Gs7fiX+q1of8RI8yzzWR0=;
        b=b+fxTTb1TzxwAAIi9ec7h9eiNoFnlC30+kRP+rLVD2pV7wjZDmAaH6RCROwcrffXqt
         IJb4d9FVY+gqixbwGmPk9Bmhoj9Qie0LrtFJbbdLpkt3xcWEZDS5UpqAAyo2eZJSrIZG
         x1uUbY4MIZxp6MhTbpMkYM9u9t4NgpvNTb855y9BzmT0DKOpDqQVdyBNv5jW+NC5BpDi
         oM3BH+94p2pQBT9m3S7b5Z+E7FsGwCEMKtbhlZRq9JYO/vbGJZkLJKZBB9B4F2xERUQt
         ajw/+F8bbVj2pguKLU1XgH5n5G0kg9i63kxaHVhhU35nAnMpBz9XL/mXkPMN3QbzTsnP
         T/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868713; x=1737473513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuhTyNXJGoJmvY2b3b+eX+Gs7fiX+q1of8RI8yzzWR0=;
        b=er8fkC/KuGX4jPq3Ack6ZBDPua7QttQPT5krvVSu5GqqjubuiR2QVC84xWK9w1jFN4
         izzsSv9HfylUELa9MoygzUXQ7822dVuOtgUHkDIEPRvGqe/i2Yql3k/CS/Pj+WltA2ew
         lkmRBQ3T+NLieFfX74CzZ5pLMkPy8zZ5mbHGXw1x1wmgg/WmCMIcDs+ZF1RTaKgciUtm
         kTebif1puoxNS9mhIBUnUHGx+lgMC3K8IQ0IodSBXE5SzkMsaN87cJJHZggpVkgVPJ/+
         MOyNIGhEgGbAnJTXwFXUlmgArH37BMn/d9dKhm5cfz99iYJR+jlfMyqpoywQrrAWMVzG
         jVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMMij6k/5lwp3JUGcxf2s5ZOZkUfwh1CIeMwuzC7jdemFG+kvOoh3ID8zlJBIk2YpvQKTS0hnUiRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRosgM2awP9fdeANO5+/bPCkyLVOX7N2F1KcKdVN/bjN2Sa+e
	/prGqaoh24lD4ZG0W7tkIg49rsGOCs5J/bEdXWEM4OvoAf8NDj5HpPxH6/21Z9o=
X-Gm-Gg: ASbGncv3SzIZ2NOwGesdOvlDGMgLXVFbs1P9yZzEQSK/Ba4f6gANQO+YWTKno9KnUms
	Y1mpFCoEYbGxo4oogCIiVPJjcgL25wAygHrI1qfpKYHs4uGAoyEQ5/1988WccdSDgYA+rMrv5wd
	26Q/54Gkjy8AMhXQYvutNQDUmhwH9wS1C4BnIfp+J0uAHPYya65HmdA9s3j361xzSqCXjisHIJD
	2Mk+tra1ylBA1WxDDVtwZHyWYJJ4+Fdz75wt1c9A4aE6kXYnjEsFG0nIZ4=
X-Google-Smtp-Source: AGHT+IE4URCzRCcKwzMMg5I6jlVUcPCNFuZwZxe/rvVw9KP+ZpeRnhfpFCTY29EMVrFPBsE7qLoIQg==
X-Received: by 2002:a05:6000:1564:b0:38a:8d32:274e with SMTP id ffacd0b85a97d-38a8d322b18mr18955634f8f.5.1736868713121;
        Tue, 14 Jan 2025 07:31:53 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:52 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:16 +0100
Subject: [PATCH v4 7/9] iio: dac: ad3552r: share model data structures
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-7-979402e33545@baylibre.com>
References: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
In-Reply-To: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Preparing for new parts to be added also in the hs driver,
set model data structures in ad3552r-common.c, to be accessible
from both -hs and non hs driver.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-common.c | 46 ++++++++++++++++++++++++++++++++++++----
 drivers/iio/dac/ad3552r-hs.c     |  8 -------
 drivers/iio/dac/ad3552r.c        | 36 -------------------------------
 drivers/iio/dac/ad3552r.h        |  6 ++++--
 4 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index 03e0864f5084..ded90bf57baf 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -11,23 +11,21 @@
 
 #include "ad3552r.h"
 
-const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2] = {
+static const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2] = {
 	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
 	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
 	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
 	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
 	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= { -10000, 10000 }
 };
-EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, "IIO_AD3552R");
 
-const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
+static const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
 	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
 	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
 	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
 	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
 	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 }
 };
-EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, "IIO_AD3552R");
 
 /* Gain * AD3552R_GAIN_SCALE */
 static const s32 gains_scaling_table[] = {
@@ -37,6 +35,46 @@ static const s32 gains_scaling_table[] = {
 	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
 };
 
+const struct ad3552r_model_data ad3541r_model_data = {
+	.model_name = "ad3541r",
+	.chip_id = AD3541R_ID,
+	.num_hw_channels = 1,
+	.ranges_table = ad3542r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
+	.requires_output_range = true,
+};
+EXPORT_SYMBOL_NS_GPL(ad3541r_model_data, "IIO_AD3552R");
+
+const struct ad3552r_model_data ad3542r_model_data = {
+	.model_name = "ad3542r",
+	.chip_id = AD3542R_ID,
+	.num_hw_channels = 2,
+	.ranges_table = ad3542r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
+	.requires_output_range = true,
+};
+EXPORT_SYMBOL_NS_GPL(ad3542r_model_data, "IIO_AD3552R");
+
+const struct ad3552r_model_data ad3551r_model_data = {
+	.model_name = "ad3551r",
+	.chip_id = AD3551R_ID,
+	.num_hw_channels = 1,
+	.ranges_table = ad3552r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
+	.requires_output_range = false,
+};
+EXPORT_SYMBOL_NS_GPL(ad3551r_model_data, "IIO_AD3552R");
+
+const struct ad3552r_model_data ad3552r_model_data = {
+	.model_name = "ad3552r",
+	.chip_id = AD3552R_ID,
+	.num_hw_channels = 2,
+	.ranges_table = ad3552r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
+	.requires_output_range = false,
+};
+EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");
+
 u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
 {
 	return FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1) |
diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 25ee716b57cd..98711f742c70 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -532,14 +532,6 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-static const struct ad3552r_model_data ad3552r_model_data = {
-	.model_name = "ad3552r",
-	.chip_id = AD3552R_ID,
-	.num_hw_channels = 2,
-	.ranges_table = ad3552r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
-};
-
 static const struct of_device_id ad3552r_hs_of_id[] = {
 	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
 	{ }
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index e7206af53af6..9d28e06b80c0 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -649,42 +649,6 @@ static int ad3552r_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-static const struct ad3552r_model_data ad3541r_model_data = {
-	.model_name = "ad3541r",
-	.chip_id = AD3541R_ID,
-	.num_hw_channels = 1,
-	.ranges_table = ad3542r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
-	.requires_output_range = true,
-};
-
-static const struct ad3552r_model_data ad3542r_model_data = {
-	.model_name = "ad3542r",
-	.chip_id = AD3542R_ID,
-	.num_hw_channels = 2,
-	.ranges_table = ad3542r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
-	.requires_output_range = true,
-};
-
-static const struct ad3552r_model_data ad3551r_model_data = {
-	.model_name = "ad3551r",
-	.chip_id = AD3551R_ID,
-	.num_hw_channels = 1,
-	.ranges_table = ad3552r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
-	.requires_output_range = false,
-};
-
-static const struct ad3552r_model_data ad3552r_model_data = {
-	.model_name = "ad3552r",
-	.chip_id = AD3552R_ID,
-	.num_hw_channels = 2,
-	.ranges_table = ad3552r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
-	.requires_output_range = false,
-};
-
 static const struct spi_device_id ad3552r_id[] = {
 	{
 		.name = "ad3541r",
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index 4b5581039ae9..3dc8d1d9c0f9 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -134,8 +134,10 @@
 #define AD3542R_MAX_RANGES	5
 #define AD3552R_QUAD_SPI	2
 
-extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
-extern const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2];
+extern const struct ad3552r_model_data ad3541r_model_data;
+extern const struct ad3552r_model_data ad3542r_model_data;
+extern const struct ad3552r_model_data ad3551r_model_data;
+extern const struct ad3552r_model_data ad3552r_model_data;
 
 enum ad3552r_id {
 	AD3541R_ID = 0x400b,

-- 
2.47.0


