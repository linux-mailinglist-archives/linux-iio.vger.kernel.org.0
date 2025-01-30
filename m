Return-Path: <linux-iio+bounces-14729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABEBA22C3B
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC89164E31
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED751DE4EB;
	Thu, 30 Jan 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1HlglLDK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0171DF97B
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235338; cv=none; b=SaQn4qmo8FX9CtQeVeWmtD75U0gwsiUFCm6itFXpt15PNevawBOX00SBR5UK8xkoK3Uva8H10mLvsNi+eWm5HrPT2eEteVpgAFS3q/3TvFr6DdeHgw2yTOS8faxQ8WPFgEkCVlvAk0AivpCKQ96MQKl95o204EqFxlZVc1n60Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235338; c=relaxed/simple;
	bh=SRXFxvtaomd7dncfECqCKnYuxcpzErN8efr+LwBJBWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDtPdkkCDgHvsvcc/2fntW+h73sZRs2Q/srHFh4b6dw4jtp3RdQqhc8/1NhehrmXdPHws4F9xxc47yb31yE7ZKkD3WAV7zJjAkuX9MxL8PSKr8AC9U92El5s12Gcsxzo5lZcnLjOstQHkufAkC1M6xccWu9pHqKCsz+gtEVhPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1HlglLDK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so393273f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 03:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738235333; x=1738840133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UayGYi9vbQCj4e06kROwvC20GIlvXwKmVBbFVZIFCJQ=;
        b=1HlglLDKDPfZmXcebFXfd+lamLzuur1Hciyhkl9BsRo8HNAMfGpoM7btO+MxYgQn7S
         j2E8MfAnwWS2ujlmlItMLG4aT1i5FudGsAAlHaxRq/4ovmBQltiEF8mMc5UF/yzBu5z7
         lN2164tgZaV4XuxzDW4z8H0+UsYGESz2prYlLzbRsEfjEHfSRa93ghQC1Fe4ZrVqLweZ
         JGbHRUIL5Tv2V02I744xf/CuKy29JSPnWm2pTDzD0H3/ECQcoecz1XYxBj/jeuF+kSKb
         2rnu3yBdiEgJ8wnkq8nSqkA2vIMOSaPv4Y1tusN8jq9f/tauZckOESNyadhb7+tMFiJw
         XIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738235333; x=1738840133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UayGYi9vbQCj4e06kROwvC20GIlvXwKmVBbFVZIFCJQ=;
        b=mKwAjvZDthdmAd/NFeD3tCGxJoqmcIgzeO+QQJBK3AAkKGf5dFtG0v8HYYZNgOR3iK
         dDEQANKoxaEcJ6X1ctiPCiHoazXUI4+9Pc+Ysguxr3upANrNnbDWGZuvBmQNQ7yxl2Ju
         vbyjn5sPJQ/4nqmWIkbxSvaQlP1sXKheFlQ3V7RwAo0jreKVMJcybTxjmj1kTUZ4na4u
         x5MUnNLvDSEqXDdMcmmh+jdmoP9IxGc4a8TVXBAud+fayJ3zCS63kqm2b8bpBsRpuNRy
         sCJ16qs0uza/NG+WHbudXNd1zXFqyJA2mlgy5FKeMMC9gmuyKidEG5zXc9ywR2i9JGP8
         S9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXYL1ssxydroCrItJbqz5r50a8w1BNEngOQKjmA4p6nH0b5c+lHtl0YF9y16WMsbv/79s5hcMfjIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6nIH1bNgiF+DjfykJUdOGTg0PMWqINaUHl+IPzmg92pgac9H
	VaCYy4GUFEG7x8NEeCEl9wCXeeI7oodCcYAeL+yaQDr3XnRhXdPmqFM3c0vNkWA=
X-Gm-Gg: ASbGncvurlshxURPqfPWHLMyYKufTgZURppGINofpImTn9H619gNGtdAmWkajSUdOv2
	j1o5KZ5y0zq/8MP6hzuFroldaqFAgM3brngv/D3ngOk5xHJswYl1KT7KSin7FZe2QHMvi2MXLdM
	sU912s2y7NBSt4E3L5xBvym+ZhyjzOOilSZeiSr/OBoOag+VtlgaYIf3TYOFelaQHm1IPquXDSe
	QoeN4yj50C0mdtv/tad6ByieunA3g0S9Qlvs/8eI/WdJjunikD3vzfkOw8C9f9TTCZj1JR7Xw/f
	MyypTln4xNst5F96
X-Google-Smtp-Source: AGHT+IGMXy0Vlqp3I6Y4A/IetFnHXnW6LN3wV1XhbgQiMOsQ3bzN7Xk+rfgP1eUkOVdTjuMdYFFkMA==
X-Received: by 2002:a5d:6d0d:0:b0:38a:6183:77b9 with SMTP id ffacd0b85a97d-38c5a95722cmr2521220f8f.6.1738235332944;
        Thu, 30 Jan 2025 03:08:52 -0800 (PST)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:2c72:cd2d:79b2:82ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c102bb2sm1689225f8f.34.2025.01.30.03.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 03:08:52 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 30 Jan 2025 12:08:29 +0100
Subject: [PATCH v3 5/6] iio: adc: ad4030: add support for ad4632-16 and
 ad4632-24
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-eblanc-ad4630_v1-v3-5-052e8c2d897d@baylibre.com>
References: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
In-Reply-To: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.2

AD4632-24 and AD4632-16 are 2 channels ADCs. Both channels are
interleaved bit per bit on SDO line.

Both of them do not have evaluation board. As such, the support added
here can't be tested. Support is provided as best effort until someone get
their hands on one.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 45d99152d84aeb878c7554edfdc32d3a1295e9c4..753051edbf96e3532d3178726c1cd159263d7355 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -35,6 +35,8 @@
 #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
 #define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE	0x03
 #define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
+#define     AD4030_REG_CHIP_GRADE_AD4632_16_GRADE	0x05
+#define     AD4030_REG_CHIP_GRADE_AD4632_24_GRADE	0x02
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD			0x0A
 #define AD4030_REG_SPI_REVISION			0x0B
@@ -108,6 +110,9 @@
 #define AD4030_TCYC_NS			500
 #define AD4030_TCYC_ADJUSTED_NS		(AD4030_TCYC_NS - AD4030_TCNVL_NS)
 #define AD4030_TRESET_PW_NS		50
+#define AD4632_TCYC_NS			2000
+#define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS - AD4030_TCNVL_NS)
+#define AD4030_TRESET_COM_DELAY_MS	750
 
 enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_DIFF,
@@ -1169,10 +1174,44 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
 };
 
+static const struct ad4030_chip_info ad4632_16_chip_info = {
+	.name = "ad4632-16",
+	.available_masks = ad4630_channel_masks,
+	.channels = {
+		AD4030_CHAN_DIFF(0, ad4030_16_scan_types),
+		AD4030_CHAN_DIFF(1, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
+	.precision_bits = 16,
+	.num_voltage_inputs = 2,
+	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+};
+
+static const struct ad4030_chip_info ad4632_24_chip_info = {
+	.name = "ad4632-24",
+	.available_masks = ad4630_channel_masks,
+	.channels = {
+		AD4030_CHAN_DIFF(0, ad4030_24_scan_types),
+		AD4030_CHAN_DIFF(1, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
+	.precision_bits = 24,
+	.num_voltage_inputs = 2,
+	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+};
+
 static const struct spi_device_id ad4030_id_table[] = {
 	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
 	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
 	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
+	{ "ad4632-16", (kernel_ulong_t)&ad4632_16_chip_info },
+	{ "ad4632-24", (kernel_ulong_t)&ad4632_24_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4030_id_table);
@@ -1181,6 +1220,8 @@ static const struct of_device_id ad4030_of_match[] = {
 	{ .compatible = "adi,ad4030-24", .data = &ad4030_24_chip_info },
 	{ .compatible = "adi,ad4630-16", .data = &ad4630_16_chip_info },
 	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
+	{ .compatible = "adi,ad4632-16", .data = &ad4632_16_chip_info },
+	{ .compatible = "adi,ad4632-24", .data = &ad4632_24_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4030_of_match);

-- 
2.47.2


