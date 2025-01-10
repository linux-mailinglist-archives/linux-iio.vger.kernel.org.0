Return-Path: <linux-iio+bounces-14094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748EDA08DEC
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FE51882A06
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8BC20D4E8;
	Fri, 10 Jan 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w/gORKiK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1020CCDC
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504760; cv=none; b=dRqUIplqy+Ro4DaSsekjtdx7Jmw1NJIb0yYkz0ZTkY+NFC/q3Y1wMx6fP45tgvQyKirsFlOaaxiNvFb8g6+wWyzatidq0nXd/1ZQF2/ONDFqSvNFogPLzGHzwXow4zwnlS1U1B5X0ddKh8uAqS1TBv3Q20nW47ueKBn7na3stFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504760; c=relaxed/simple;
	bh=qbjBbaaMORZ2C/r7D6kKFFoTby+h9J4MotML4lNxyIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSNp/scjdVVK+0r9a+22vsPKiLrGfPQvLmmj1Lmv4vp6uQMDvG3RsBzFzF4fScpR06foe3uRqcsOrpISjKJ7pxhQL/HDf6zFOBzmxBl0mrY3+/R9KtmJZC4QXpxRpjWo9uW4zpD8XDQWl8KsxqCnxF32meT5uIlAYTB+kjWCNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w/gORKiK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385dece873cso988032f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504756; x=1737109556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Kx2U6q9HoFXfGBhWuMH4r6aDSJAYrYoiytjBds/B5M=;
        b=w/gORKiKcmqjTdn8eMNtXcfMcVfcoZBFQtlKOQWQ2ZP0s7VT6nN1sX/fsDDY8ZTmKY
         cNxEOJH1/FIvi1hll9vdBflgkMyfNYfLB8x6fpVQp7Vu3UCREh4G+bKTcv7zOUTU1fP/
         w5mQX6CtVmWohtpD5OqNfKFXV/7Jl5+oq7HdKgv0f83KfMHlNsmAfVl27eLv0EXdKq9b
         c1XwzLfDQM5HU8LTqfU0QhpWOE27aMlTAyh21x5kWgKLXIDPhZtkfSvcTr/p9cnEcEuz
         q3UWQw4rut9dZHpOcCbZwpMi0DWd4Z/glCKwVy1D4+DlH44bNn7Hitq3BOy8ddplomP9
         y9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504756; x=1737109556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Kx2U6q9HoFXfGBhWuMH4r6aDSJAYrYoiytjBds/B5M=;
        b=Vm3OFjBXoxoaiDzloHmvh7p9u5v3qGQi4gmIBstgy/0bibsZoILhjehFaIyIAgSEig
         I5H807329HsuAWpK2iQgYMROcETXaWrrCnxYKNnWkgpEXl5V/ciWBAGP0SDJwiMxhcZB
         V3h6h8ZgEcw4GWAHYlmoHikGZFBDr7CXI3COcqEoEt5AvlTgEYfNk45aGrJmZxDl8J1y
         hwrJ5hGLt41KufMODeT5wu12AXqOYcHZzpWODo96kQSaMwyZxCuRvj4LmdsLFMyfAl90
         Dz3F7A2hBHPt5MsMHrxzmbeXfHcTR3u1Y7/OY48pkc+1Js67zudiAe3eC05IeAgvISwr
         ewFg==
X-Forwarded-Encrypted: i=1; AJvYcCX6LsGNF77w2apOpc1iS6gax/TXvP7N0+N3l8Di3Q4J+zgHs5IF/jv7TnhakgXt+7l2uRRW/QN8IYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+NRWXEoobzYRh8ZsdPrwo/QCZ2NJHyd+bl2hgChzOYYibTI+
	drnQifXjbc4QvQmLQEehzjAlYM7REAWtOsBj4pircIDWBFSJcJxCdb42lZM+G4Q=
X-Gm-Gg: ASbGncv7r3I1UKZQrqk8Q22LDaVfw1VqGJ09+l3y2QElcSc2TFJnDEu/mHG7oGb7bYY
	JIEMe5ZJecWlGS6+Yq0Qucyh/IcOIKjAJkt1qaT8nMXl8mSmXUmPoA0bNccdI4wGKaiDwtGKp5s
	kWfyXmEMWXq5/3NrXRlkLQSsFMH0DjmtewaFkFZvzJYsfqlsYE2l9E9nRrwWPrz+4Z5dKKrVk8q
	uG6KNlzWTClp7PPSQM+PpoJprZuRdUAnrURUAxul7yl+wr3E098iogqIlA=
X-Google-Smtp-Source: AGHT+IG82hMo5QGB6iKUOWfQPS4RQCDDjewm0fKX2KX/ecqqguePtF0145e0Hk0+9rBXeMiMBSaS0Q==
X-Received: by 2002:a05:6000:4022:b0:386:459e:655d with SMTP id ffacd0b85a97d-38a87306d7bmr8351298f8f.20.1736504756228;
        Fri, 10 Jan 2025 02:25:56 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:55 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:19 +0100
Subject: [PATCH v3 7/9] iio: dac: ad3552r: share model data structures
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-7-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
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
index 991b11702273..bfb6228c9b9b 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -527,14 +527,6 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
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


