Return-Path: <linux-iio+bounces-14032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EECA06370
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF3188ADB9
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C502036E9;
	Wed,  8 Jan 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IcjGHFO4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAB202C45
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357443; cv=none; b=m/AEkI1IfeITT18Djp+YSxyMcVB+uiiNSbwleHUczJj37ZPrH27Nxz+Dn/cVPQLuBdhdTpYk2f/6v8DWnmFuZDv82uWZCZ0q4XJalTwC522uHqCdi0DAgFGg+yb7+BCgI3GjBJnS6aFiA8JK+h3g0yzpZ/7LzrAmJByxDioCbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357443; c=relaxed/simple;
	bh=yPBj8+317vNPAuFqO9cv8l0b9AdvZ+jKb3gEbQivFoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V93+3mWMYXvOZ3njdwBboNqHcDSvFTWUIqdPVLBEg+4se8QthjMJac6Fruc1D+lrJAa+kT84NoaOdQpMZEv7lxvlaYgczBdIgsNCvbFVLGeG3UZqI9olUZ20IGsXiKBXMpLelry8AkXTQy3SUiJq8b42HQiM8TnPN6K9Vj6lh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IcjGHFO4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385deda28b3so20413f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357440; x=1736962240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNTleVNIiTU9nZ6xRJX/KSmh/FQGS6/eS5WcZiPevhQ=;
        b=IcjGHFO4bUZsVypNlpe5bFcQ8+unHA6rXaGqZFeicw6Tx+WJbM2tg0k9+fF5HsBfvS
         1mT1qc3o8Dy+djD4mwNv8ucKrpOJyudWA+aTFmeRHD7qAo7RL2r9fOlVn5HAz9CZs4u/
         ORVKvogTJLm23HIdibsLiPFYaLKdbgILNr8YddALiKLr2h0HTy6oFVFHO7NQNrVEWJg6
         DLumMkxhe0EBmw0g4qw/Z1hVnosqpkK8VNQPn6kUI2kDNuhlWV73QT2csA/VFAhnfLh5
         U0PMJYqzmDUxMxtqlxYcFU0fWW3BnFyIqAzwnj+wRaBf30gNBeSwUH5pQOEL078pBrbo
         H/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357440; x=1736962240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNTleVNIiTU9nZ6xRJX/KSmh/FQGS6/eS5WcZiPevhQ=;
        b=Wr37sq2pGzt8A/U4M6Dqhcs+JZVXJZUVLYzzDcpNogv3HyGRB4ILYP0vivCF2Y7DZa
         88dufjlwuE2m6s3qzNlJZdCVDyAURCmT3AWp+GDYV7kSsKRui1nkdQxJ5ZbGzSbMIFnM
         ShNaloE5CzT3iqFW4GSoLN/AcZUZbIAJ6YSEVJ0XgSWYUL656uzT/ztIrs5AeLq3LeUB
         D8MH+VMPGOFXfD/e8q5we3muv+K5LvX36gUvo0n0JMygr8b4IvNNfI2Wg0PhRagTXiKo
         X4ZzfmYc6GHKTXMSzhUrGnwm+lKw5w+sLekrBECrSGwT68m0h6A3AW6HoYpMzuN9YGcw
         67XA==
X-Forwarded-Encrypted: i=1; AJvYcCXwtdxurRqHXFU/VXAh4NwFbc0npaO8KOeLvt2ZbeqVuZDNQldVPZ7fFLPBIZ1jo6p0CEGr4k1Ctio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdK2DCkoTD7/ZI17/UIAMl1ZnPsy7yBuNz5I4/NgZOYZoK5aC
	Gmd3TN/9UQYXZKm0i7AA/T895nR+rGWmDCasut29b34Lo9rBwzKROxP/wrqKCXY=
X-Gm-Gg: ASbGnct7+gjeDNXPcUkiMjDMquEg1W0Q4jerH3TEXn3+hoiJTDFuun93WfpqZ0D5sfi
	B4Xr7M9vcN+yNXsajJ3Zj4MLtUX1ip7DAjjlWOAZN062FZmF65O2ci6Df3aUTWWX0wE1BA4ChWA
	akIx0ooNH6gWCliIyKuZS4DCFmGPIM/UeqqHLrJ90cmYaGwsvjUWaXpqtAMHJVs7ZDSPG8okY/m
	pejmMVI44KLcQYwafeEtys9U6Iequqb/vMtbDSxyOkHsVNlB0o87xV18UY=
X-Google-Smtp-Source: AGHT+IHtHhpOxNudv3flMNURgU+J5Uz+IMqJA+3tUtgmXAU844RXw/Uo6ltVqTOhohjFukKWhgwc6A==
X-Received: by 2002:a05:6000:4714:b0:386:3752:b28c with SMTP id ffacd0b85a97d-38a8732bb23mr2741757f8f.41.1736357440075;
        Wed, 08 Jan 2025 09:30:40 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:39 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:21 +0100
Subject: [PATCH v2 7/9] iio: dac: ad3552r: share model data structures
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-7-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
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
 drivers/iio/dac/ad3552r-common.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/dac/ad3552r-hs.c     |  8 --------
 drivers/iio/dac/ad3552r.c        | 36 ------------------------------------
 drivers/iio/dac/ad3552r.h        |  5 +++++
 4 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index 03e0864f5084..36920ec95836 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -37,6 +37,46 @@ static const s32 gains_scaling_table[] = {
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
index 4b5581039ae9..23f038464a0c 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -137,6 +137,11 @@
 extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
 extern const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2];
 
+extern const struct ad3552r_model_data ad3541r_model_data;
+extern const struct ad3552r_model_data ad3542r_model_data;
+extern const struct ad3552r_model_data ad3551r_model_data;
+extern const struct ad3552r_model_data ad3552r_model_data;
+
 enum ad3552r_id {
 	AD3541R_ID = 0x400b,
 	AD3542R_ID = 0x4009,

-- 
2.47.0


