Return-Path: <linux-iio+bounces-20439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B67AD5991
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E726817F8C0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0963B1AAE08;
	Wed, 11 Jun 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xGsOnCJN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1461991CF
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654323; cv=none; b=XHR29uX5h37ZcR1izfCGfzp4Q+DJ1HpcBATpWk8FO60/KrMeZx7LeR73sw/jSp6rsaqcqIeKEcyfQFtFiTGjhZ64jdpKAasHnoNt5/sHPqPlDGBXHLUJ5KFRL6wZehKXPeOC5BGn21Qf3HgSubSggPBtDKdfWx6gYYO9SyIyAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654323; c=relaxed/simple;
	bh=fZSNdaQw7LjO2JSM2umX2tfqykmAKg00XkcpPGh8Uac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jKhdhfX+YOJ7KI+IMOwuASBQEk4NqDEU+Evp67ziCFtgBJg7hYs3LcyNngr7fipkCny6IfNeib6ZlLGn8uJ4WGqb/nKu2AXwzISj91myf46k4+TJxEKRXRiMLGeTGRZFT4GdQiIFD+7HePMcvY57awvHAGZ04wSD17nh7cS8PEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xGsOnCJN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso7930913b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749654320; x=1750259120; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Btuiq67mOopxi+6Aea7VFzZVIX8u5AKrKDKKSNI+Q=;
        b=xGsOnCJN3Qu8024rEueuVy1Mp0AXF8XzJPERkbUUZigLixlvrxwZbQBUg490rfcLZO
         paM1LzroIQpnRRzHPHNbVnwnYESbFYZisk7jws+Qhp00DnQ/i33bC6uMK3xdewPjbM7S
         H7qcpg3aV3SKgFWhWqa0GGcXYrlIi5Wfr/uABCOMyX36uLLoqgfakpx1zQdN6SvFNkfb
         CPAI2oBeekwrmOdP2w7ulHRXqQiTpzgyTHHWokDfmR+FESRH6VOd4KZfBRMZVLFPNkXO
         bHTNrXJZ3aMU8jFGCD0oHdvunCxzsVsTcCkvf1DLn3kFG+6DEa/+xOUXArTfVYP/gXjV
         2iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654320; x=1750259120;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2Btuiq67mOopxi+6Aea7VFzZVIX8u5AKrKDKKSNI+Q=;
        b=rlM34E5Hzxh1LzY1ycQFTmnPAbUFlb30ghnhQQJPbVxbcWlyfi3AVyzcyWHDx8toux
         SrTfTPBvd/0buHWmtzvHweml3fAww9q3oyTwWdJh0dNYr4Nzc8U+E372T4q720SpEQYz
         r5Olpqo3HHDx9UbjuTU6e7olQMj28Q5u761W8n3JFmMuVRk7uqEo9sJXFjZRiGYNP34K
         lReIfOe28ZYBiY7Vq59WsbaTgN35IO3U0dnflvkVJngbb3kRrQsOM+mKY3orPxiYhKmg
         2W7WetWsNRyA2dTvThs6MgY7MlJA3EIvoqgJdnvjqE1mZDnUoO0YlqQam0GLXN790PCD
         tl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHbz3xdKIedK8MrJkZZhdnLBj7vfK/+5zAX1wLQNUJTrOtnkwW0DTlC7JAkyqOdxqS9BxUmiIFGFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzia2tFQsg+McmJxt6pVt2PTsA2mnsO7kmFDjbprEBRbxUblE
	GaEXuM3qv4HHY2VQR4s6rZ/NJ2i597JvprS65FgRmeKLvkkCQSxPs+sJXri98Kz3r2RtF2nPulE
	Vi7zE
X-Gm-Gg: ASbGncuFxuB/3rnGuQQCrly30C+247WSk2BgrPq1VA1z8DvN2sbozaGpsH4R1orGhY6
	z7e9EjCbHBCRNtsiHlFhaewM7j0z8bPNxunBHhjLXymODWgChVoE51U5+mS/f7fAqmKiDermnmd
	Jth6Pfr7gHEUIWKG/cEKBSj/8DrylpwJ0jx+H+4KWDGMRtg0V5O7/pyprvbINJcY5Bx1MgcamQR
	vFxYS/TTeFcWJWrHomC1S116KR7PlfO9KgSqf/1rh0NFIkMH+qGeFb8ydiazvt5p6GVwuOkcEXT
	SDWn3016gxgDlZUewxsrrpTcIJgf2T4qYb7vJ0bTe6VMgBWdjBnQbKRWtr0StpaeMU0=
X-Google-Smtp-Source: AGHT+IE2kNib/WhJGgeczqEw+psw/Mni4H9CXVBeRVZPfI7lAqfHf/tnDuEYm+hNO63ZG+gjAh/zBw==
X-Received: by 2002:a05:6808:1886:b0:409:f8e:726f with SMTP id 5614622812f47-40a5d11fe8emr2452486b6e.25.1749654309717;
        Wed, 11 Jun 2025 08:05:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:eb6c:30d1:632b:494])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a06fe0b60sm333782a34.28.2025.06.11.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:05:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 10:04:58 -0500
Subject: [PATCH] iio: adc: ad7949: use spi_is_bpw_supported()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-adc-ad7949-use-spi_is_bpw_supported-v1-1-c4e15bfd326e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABmbSWgC/x2Nuw7CMAwAf6XyjKU6PNrwKwhFaeOAl8aKKSBV/
 XcihhtuudvAuAobXLsNKr/FpCxN6NDB/IzLg1FSc3C9O/cXIhQpGNPcGPzJ42qMphLEwqSfYKt
 qqS9OSEMm549xyuMIraaVs3z/p9t933+5R0wKeQAAAA==
X-Change-ID: 20250611-iio-adc-ad7949-use-spi_is_bpw_supported-17f1293abf88
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Da Xue <da@libre.computer>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=fZSNdaQw7LjO2JSM2umX2tfqykmAKg00XkcpPGh8Uac=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSZsb3/rwLgkmmdrmG2X6iDG5bupSZxzHKyMz5
 3oQd+1Ia1OJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEmbGwAKCRDCzCAB/wGP
 wDstB/wNIV5zZQUDfhKoqTCwDnCkCXTZEcsR7JbEMDdQg28JswF5QVaE5e1Yq0JhwcyjC8aDwrU
 fAsPW165tqaxsQxKhws3W2cOua93FqpotHFP2N8u0UlkUw0wcC6+126TsYGc9tQ71wjVc4YnK3i
 RbZdSPDWmYcMOqQs5prQdR81D4G2lQo/3UHtbXIbAelqS/XcBVDOysrpA2a8g2TZQQQ9UzUKXbz
 TP80nyqp7x4I0RfDoXFadwdHKeg5/2DJ0AnSXiwLOUU9CzVciGoqrYUp8aZPkNHgnM8nS/kacRN
 rDXfySbiyXtmfxu9/Mavv4NHGutYLdpWgkcmkThw63yWNMZ7
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use spi_is_bpw_supported() instead of directly accessing spi->controller
->bits_per_word_mask. bits_per_word_mask may be 0, which implies that
8-bits-per-word is supported. spi_is_bpw_supported() takes this into
account while spi_ctrl_mask == SPI_BPW_MASK(8) does not.

Closes: https://lore.kernel.org/linux-spi/c8b8a963-6cef-4c9b-bfef-dab2b7bd0b0f@sirena.org.uk/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7949.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index edd0c3a35ab73cca5ff87632e4d588eb5d712b47..202561cad4012b67e23ad6d3623c913cfef35e68 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -308,7 +308,6 @@ static void ad7949_disable_reg(void *reg)
 
 static int ad7949_spi_probe(struct spi_device *spi)
 {
-	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
 	struct device *dev = &spi->dev;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
@@ -337,11 +336,11 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	ad7949_adc->resolution = spec->resolution;
 
 	/* Set SPI bits per word */
-	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
+	if (spi_is_bpw_supported(spi, ad7949_adc->resolution)) {
 		spi->bits_per_word = ad7949_adc->resolution;
-	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
+	} else if (spi_is_bpw_supported(spi, 16)) {
 		spi->bits_per_word = 16;
-	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
+	} else if (spi_is_bpw_supported(spi, 8)) {
 		spi->bits_per_word = 8;
 	} else {
 		dev_err(dev, "unable to find common BPW with spi controller\n");

---
base-commit: 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
change-id: 20250611-iio-adc-ad7949-use-spi_is_bpw_supported-17f1293abf88

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


