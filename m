Return-Path: <linux-iio+bounces-8688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1695B55A
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21AF284C29
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547131CB32E;
	Thu, 22 Aug 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pnnK3CSK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78571C9EAC
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330757; cv=none; b=sdOwcmph3T61y5SvG8iZot2rKo3Ug4Q7AViax17MlIN2jkr7Nq1Pf51jDbN5Bqv80+QYt+p0ZPSxiwHJrkHB7s5UTZYY/+RpQ6ChUYDpRkGpRMcaVrVa6cUBlcvZz3O/NtBfzf4FVnBITM4y3hy0dulwpZBI4nYuPY26fviuj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330757; c=relaxed/simple;
	bh=5Bnt/F7jZXraT4H2FCJtEpXLhOhHhx7d/lVi5Mpg1Hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUhnU3BBNwk1tb32aFtBNd7hkM0ipiB1q25rDUycjjLIBFnLo65WuLtPHGKFJHpetBbYMRJcMy85F0D2fqS1ozpYFH7CNTNYrnskQ2VsL4XIEtIZWMdHAyaeLXGu/nQWy7wjPdOKKjyz171qp9RllrhoZ8PZouBXnNcSkZAVPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pnnK3CSK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so5980055e9.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724330752; x=1724935552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TePZx7uKybl8XWIbq7pzYvS9pX2NJvAwXyQoj0R4xAI=;
        b=pnnK3CSK8NrahRtgcaFb2yudiQY8wNB13uCQpYhZw7zkCrMv9P/xonI17FM51+J2zT
         1oPo571oP6N/O7aT7RF2KHiGjLllua/bogvWdLVTi7MwjaGQfZhFK0sR7QkiPVC+EBdC
         yE9mwrKfUgybuq9pu20KBlhbALGQksncmj0JP7PRXX4efMfJwsx11qUjzcPr3I/NxKJK
         iLcS07rwvN48bOnUCeS2Ida3/SnqJy5ydZEfIBhlNrUBoPinLWe5E24eeXdHc5Iigb+Z
         3vgQI21k1do2t5jUJxACe7rWjjcda0T9Rc1SUbgGpj+Gy9q2SJukO+qpOntpRQm/p/7j
         nvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330752; x=1724935552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TePZx7uKybl8XWIbq7pzYvS9pX2NJvAwXyQoj0R4xAI=;
        b=CtQvMelUPIGejD9676seS7K608qK+Sh8VbnSARBfCkMSyvKbWL5BgNkp0sWyS4/U0C
         uxDnx0UCVCzBr1GusmO9NKmytrSAal3F4vW3ecNYoV8xmlVLSF6D8VhxsOl3UPMT2Zjz
         4CnnxRS3Dan4OLSTplgzimIvV9wNmNZPNInfB7dNxxoPUSdHarki38QnIkhla6BvyJas
         RW9w8XxYe6/9FuC3EtADZGlg7tyVJ8qrxYf9Z937lNCcRGtcgATvGghO5eCLYb39A1/5
         Y+dkKsfHYD5vi8DHkkpCWZcKv6gSCuVatVBtbxWEnMTQEysjJEXf5FJpq/2i/aXNiI3c
         XHyg==
X-Forwarded-Encrypted: i=1; AJvYcCXEe7y+HDhfyeYku3jY+8hqu8+oYG2mWft0tkOduf5xN7vYv0HKFGhrJak+13P2YFHdCzaxz/zzy00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLElLIv2+I9YmdqNFYEkP0E3KsNg0J3/vQQS/VPmq/n9CbAnpP
	lwtkZy1V/S0950Msqs7TeVR2acZl2xeIW1tP8tyHiD/GjxEQocueksR9rUOQj3I=
X-Google-Smtp-Source: AGHT+IHmD9FFC4YM754r2z9rl+k4CgBL3hfNKSxSwu05zkktDBZ0VY0xQhB1R8q8P3KAkFjy5lKPQA==
X-Received: by 2002:a05:600c:310c:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42abd11e2famr46875155e9.10.1724330752027;
        Thu, 22 Aug 2024 05:45:52 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:8da6:6d6d:c8ed:16c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e269sm24032195e9.2.2024.08.22.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:45:51 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 22 Aug 2024 14:45:21 +0200
Subject: [PATCH 5/6] iio: adc: ad4030: add support for ad4632-16 and
 ad4632-24
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-eblanc-ad4630_v1-v1-5-5c68f3327fdd@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1724330740; l=3466;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=5Bnt/F7jZXraT4H2FCJtEpXLhOhHhx7d/lVi5Mpg1Hw=;
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
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIAYQUVgYxurWVlK4Gg1qDL7Af2K8n
 qYuGQDk5lFtyEfY0t6BNYTQOTvjfvUHSSDFSisTmuugQPCt7Rrw/8TAS+bgGwGvgGOmt5+eFq5K
 J7lZ+NQES8Q1DUeVtmJRs90RDjnS6z5IqjH1Z6M3k/Sf4dUjrdLRVbMAR3ZGKBenru/z2eDF0gQ
 lSNnDxeZhkNy56xXLuNnUFH9tNePzS4qbMyxw3fod/vmvO84pUVtG7nUCxOzA7i4ZE16f/fRzq+
 Vw6B8v/fKkaNj+gvngxNF4DyAmq2vfZyROiVkoKevi4Ie/CISr7aKfzjgUagPKTXK+qfvW6lrYI
 DPRnM6/0j5f0yMPP1MtdhBFEpH0qQBSI029gTLRZMyZs4/YhmagyqTm0MyQ5LKAPzvfeHtoXsB+
 3+qMKDAgp84nxkLlaZJWShHLv/sMDtRyauh73M7QjWEVw1B0d64MMuLqdGzY9CheP1iQYTM3fuI
 XsIF5VReIv8YNVY+2XTLsY4n9YYa1XiTU24GLSih/lv9UHEUWrzKlKXiii95DDQrdApzRtZNlJm
 UFqCaH/uW4thqBerFOLlGRJ5yj4rkV88ua0z6YNzBtB5sL54gc8GxhzJqcRWq3L0uRrNXnPxkzt
 k8EhRRW8XcXiohAZvB1G8pOjg8eaz/Z8ccTZgqvcwBhmXiTPvxaejUF8=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

AD4632-24 and AD4632-16 are 2 channels ADCs. Both channels are
interleaved bit per bit on SDO line.

Both of them do not have evaluation board. As such, the support added
here can't be tested. Support is provided as best effort until someone get
their hands on one.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index dbba5287b630..d42eb53b5e56 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -34,6 +34,8 @@
 #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
 #define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE	0x03
 #define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
+#define     AD4030_REG_CHIP_GRADE_AD4632_16_GRADE	0x05
+#define     AD4030_REG_CHIP_GRADE_AD4632_24_GRADE	0x02
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD			0x0A
 #define AD4030_REG_SPI_REVISION			0x0B
@@ -106,6 +108,8 @@
 #define AD4030_TCYC_NS			500
 #define AD4030_TCYC_ADJUSTED_NS		(AD4030_TCYC_NS - AD4030_TCNVL_NS)
 #define AD4030_TRESET_PW_NS		50
+#define AD4632_TCYC_NS			2000
+#define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS - AD4030_TCNVL_NS)
 #define AD4030_TRESET_COM_DELAY_MS	750
 
 enum ad4030_out_mode {
@@ -1068,10 +1072,46 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 	.tcyc = AD4030_TCYC_ADJUSTED_NS,
 };
 
+static const struct ad4030_chip_info ad4632_16_chip_info = {
+	.name = "ad4632-16",
+	.available_masks = ad4630_channel_masks,
+	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
+	.channels = {
+		AD4030_CHAN_IN(0, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(0),
+		AD4030_CHAN_IN(1, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(1),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
+	.precision_bits = 16,
+	.num_channels = 2,
+	.tcyc = AD4632_TCYC_ADJUSTED_NS,
+};
+
+static const struct ad4030_chip_info ad4632_24_chip_info = {
+	.name = "ad4632-24",
+	.available_masks = ad4630_channel_masks,
+	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
+	.channels = {
+		AD4030_CHAN_IN(0, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(0),
+		AD4030_CHAN_IN(1, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(1),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
+	.precision_bits = 24,
+	.num_channels = 2,
+	.tcyc = AD4632_TCYC_ADJUSTED_NS,
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
@@ -1080,6 +1120,8 @@ static const struct of_device_id ad4030_of_match[] = {
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


