Return-Path: <linux-iio+bounces-6987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DA91A5FE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 14:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BC328C44B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A215574C;
	Thu, 27 Jun 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wKcwFskg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AEF15250C
	for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489584; cv=none; b=n6hTRVP05ryXWCHOdC14mFAtjBY+5Wq1MGNIrWagLPDYCkmf0nZwipNVwMiCEyF1PuD2VkCffNcJQDQgHA/0Kb/NGQpnVFzAq9+o/Hu+eCbnC3W3nDZf2Tj+qbywmYcuQGKs6bbOBQH992Gwd0wor9hT3ak7ekN9b/cL08JdRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489584; c=relaxed/simple;
	bh=X+U9orsJPedPPYpbVqaxFxgLXQNZIgsHA3wxCEbSSGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKBQcG7K9Uc5ZTrH0BpvE9S88KSjW1XeQTcTg0zF10IZvtZcOg1JqfcSQ9mPf9kKvoIij37l5fKVrf224eWTDCSdOry7bp1oLRHBjCU5YTKXZvI0rWyNexH5oNvMR1WpLcgyLyfhb5Fkvlum32pBnQqRG9d1Xi2Ei7oeHDjYlDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wKcwFskg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so61233485e9.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719489580; x=1720094380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPaBhwXRFZDYoHIsl0z64oG+ritfujt2e0VQs2bXTfQ=;
        b=wKcwFskgkvzEL2BqidkCFvuXqCzD0OmCXn819gjDkbH6FQ0Y6kL6fDI3C/BKrmjvSZ
         6tL/t23gLBBPKAfSP+JoUHWb4X1IqCxVsWAKX9F101YUNaUhJiY2VfQShmICYgv9evSI
         muv+63Jb+eFiRS9JmkUOL8ikb5ArbzkcfT2Z1udca7lhtqEnZhkAli+SlcehVGT1CZNp
         XxW0Jvs9vxj+piE4DjhI+RGAVC8gIcQkwUO2aEkbLLWxHAWMuGLq7fAeVwzJhP//HS5B
         i+NpajxEotTIW0xIHcfQ3DcFRbLaRCMBP8rSAhMlL8VLWWP87e+ErTjQsrD7VW4AKh7l
         fa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489580; x=1720094380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPaBhwXRFZDYoHIsl0z64oG+ritfujt2e0VQs2bXTfQ=;
        b=OyIM6ynVGSf8dTwQizQXQCFOkPhYQ7j13CIrtfTyfCpwBAQ3/ToUYRY18hUPfwSmX0
         A438MqPEO/RZwjyZBfgk2F5IZ/aZeuf2S+eSpO5+VJAA3oU/tMnKwhvzs2d1k+X10Di9
         Qpo5hI4AFAXD+zSWBNkmi5H4wIsqbAuQyBs5XfomCCtveXY8S0nQ1V4eFgG+Qr1h926x
         T1IIU47g3Z2oFeHFnZpclMvRm67UfnkHCWjlYvVZkhDv+wfsCuTqetVqGxHZdy9vDm98
         pnVjUg8d03zqa0JKNqGU1ycq6qyrxj4lEbqwrHzHVNeBFaMBkdx4xCujNzoTs07pZNh5
         u8+A==
X-Forwarded-Encrypted: i=1; AJvYcCUn5CRotN9pzt43wpCWhdXErnJg+tcrlAn+h2CJCG3jEQq94MKHvhcQuRTXHnxkXg0gf4JbvlKWOLUAUAopz/1uOR/v0pPbTD/v
X-Gm-Message-State: AOJu0Yy3mZyZjLhIyni9CVja0evu8QsXjvJa4t5jFaBuzT0X6483k76e
	2CTYlFJNFhyGjK78aCDSLY+zhquxqpFjimn7JlNAhyoL5PGlrDxbWInO/2eeEWhlrhv3eDnhpd2
	2
X-Google-Smtp-Source: AGHT+IHaktcuchUcGXX0ixQ06T2avcJHBDCOsaExCDqmOixsv3K88f74FPkZm85nR0VbP3P6moh8/w==
X-Received: by 2002:a05:600c:16c4:b0:425:5ec4:c880 with SMTP id 5b1f17b1804b1-4255ec4ca57mr26306035e9.35.1719489580592;
        Thu, 27 Jun 2024 04:59:40 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:4435:7af:3956:8dba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82462a2sm63473585e9.2.2024.06.27.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:59:40 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 27 Jun 2024 13:59:16 +0200
Subject: [PATCH RFC 5/5] iio: adc: ad4030: add support for ad4632-16 and
 ad4632-24
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-eblanc-ad4630_v1-v1-5-fdc0610c23b0@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
To: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1719489572; l=3059;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=X+U9orsJPedPPYpbVqaxFxgLXQNZIgsHA3wxCEbSSGs=;
 b=U1NIU0lHAAAAAQAAAhcAAAAHc3NoLXJzYQAAAAMBAAEAAAIBALJZcW6pLD4ksSdWnXd5r65Ze
 5Qc5pH7+DmmbKJasOXeVYRPFEmnORS7pwhURG11AMVFmnCVYWj+wPYrbCEeM7XKfO4oQzc66kYB
 7y0RrFwjoWKofytjI026zV5b2pn1JAItgu0Ijth+TSa6KVOTSXqqiVzOTDM1WL0hAIIzpkhE3Vt
 AVJrFDsh/nWed9OpeSS+S6e3ZxyJtlnhqbVIemcDmjwMihtFgTKeJWlxP7KGY/RQKPF/Ef7pS+O
 AckOrxuqGKvpOiNVCmuQEUQM0+r4uvwtja4zRSl+huqW+g1nLyReoZPzFwfJWREd+89dtTJTXN7
 xmmFNdX6KzRKBLVw1RY/R3mhAd+MkrdiNaRNKj+LO1QIxPoW90cPG9WpdVDUZf1VxhdciB6Hlxn
 lfEDFuCxU0n5H+kC4eiZvw+c9D4xX7iVdjPTMEaE6GBQNnMncdljBwA5NVN8WcaUhnAQnq7qhcz
 85L2Br7MPqe3q3J/PHIe0nHO56j7tTY6cFFs/ckqcQSTJigh2rA7InN1d7GqZFLzlewRTGaCY+M
 93d7DCIuxTxJWRpVm7NW1FBeX6d00+dAcQ/dS+jmA3kcdRoWtH160jmmYYvOgrsQTcMIQrPtK+B
 rULRmmIvEIJMF5UfNmxruWmWn6MM/xeejTNszoKqrORpbr7q3BnkKt2y/KdAAAABnBhdGF0dAAA
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIAWDhNffkPeiiC2hv5s9aeCJZMPVf
 uritwhdaJ5Cpr3mh9tTP0IA7wYQB1K927FWb8FHVUzBw7TTzpyu+w9qq23pFWSYRDTzsGSofoWx
 wLlaPBd85E5jjFIiA/rbWlqPV88pJjQF28uTojtrUHdjgmnJ0AUi/M3XtyemjMc+uWRiijfC3n3
 JDW94t3UWAXVjWYo8isXs2tb85cRjEZKEc+oAsBntkpsXbVGtvOhMJKbSCJZCekLOyrFbG+CvPq
 oQs89PaMiKEk1F+wpa/JaCrgygDet07h5+OogXUE/n0SWpvmTyXVHV8a2Y6wd22zVkHgUCal/VC
 0kETn7No9v+4z9jYpAcSzeNLsMAUxPIdPhr7DWHg2NiwsRdVb8JdzS6SFRhnTo/SrycbAOoC980
 4uq/zsyEtDESwylB1MhGb6oSTkj6Vtl8LN72LIHBXFH5ndniP1MX5xQf4hcK4s2PBQC8pHMYd+2
 m3djFHLxozMYhBciOcsBqAT0DxEu7jcmiFXWHE6hfyc7daY7bLMeLiYAvR67Dh4v+qn/oEFsd2A
 1UVU0DBAQpeNvR7gdaVJ01/XVvJ6FIfaFi3VQICOfUEdtU0aFxEan0VpoI7TXcRMuaLWGKFpbGm
 ENrjRj5oqa362xrvgZc31m+aTU7nTEzXkY1MleOB3Ea++k1Jtn+Lzrks=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

AD4632-24 and AD4632-16 are 2 channels ADCs. Both channels are
interleaved bit per bit on SDO line.

Both of them do not have evaluation board. As such, the support added
here can't be tested. Support is provided as best effort until someone get
their hands on one.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 09d2f6d8cfe6..1a5517f339aa 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -34,6 +34,8 @@
 #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE		0x10
 #define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE		0x03
 #define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE		0x00
+#define     AD4030_REG_CHIP_GRADE_AD4632_16_GRADE		0x05
+#define     AD4030_REG_CHIP_GRADE_AD4632_24_GRADE		0x02
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE		GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD					0x0A
 #define AD4030_REG_SPI_REVISION					0x0B
@@ -1012,10 +1014,44 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 	.num_channels = 2,
 };
 
+static const struct ad4030_chip_info ad4632_16_chip_info = {
+	.name = "ad4632-16",
+	.available_masks = ad4630_channel_masks,
+	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
+	.channels = {
+		AD4030_CHAN_IN(0, ad4030_16_scan_types),
+		AD4030_CHAN_IN(1, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(2),
+		AD4030_CHAN_CMO(3),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
+	.precision_bits = 16,
+	.num_channels = 2,
+};
+
+static const struct ad4030_chip_info ad4632_24_chip_info = {
+	.name = "ad4632-24",
+	.available_masks = ad4630_channel_masks,
+	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
+	.channels = {
+		AD4030_CHAN_IN(0, ad4030_24_scan_types),
+		AD4030_CHAN_IN(1, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(2),
+		AD4030_CHAN_CMO(3),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
+	.precision_bits = 24,
+	.num_channels = 2,
+};
+
 static const struct spi_device_id ad4030_id_table[] = {
 	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
 	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
 	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
+	{ "ad4632-16", (kernel_ulong_t)&ad4632_16_chip_info },
+	{ "ad4632-24", (kernel_ulong_t)&ad4632_24_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad4030_id_table);
@@ -1024,6 +1060,8 @@ static const struct of_device_id ad4030_of_match[] = {
 	{ .compatible = "adi,ad4030-24", .data = &ad4030_24_chip_info },
 	{ .compatible = "adi,ad4630-16", .data = &ad4630_16_chip_info },
 	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
+	{ .compatible = "adi,ad4632-16", .data = &ad4632_16_chip_info },
+	{ .compatible = "adi,ad4632-24", .data = &ad4632_24_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ad4030_of_match);

-- 
2.44.1


