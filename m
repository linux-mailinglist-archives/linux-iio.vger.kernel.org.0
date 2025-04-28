Return-Path: <linux-iio+bounces-18793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83F8A9FA7B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0275A68A9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DB01D8E07;
	Mon, 28 Apr 2025 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bTB6lxM2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C720C488
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871859; cv=none; b=hSmeDd5sXbo2w5XQ0IGVZjA1uYrl83vth5VAaiW1LlstIvLTIRNsi56utS8LmEO90+y0gPJCBPTaVVuT9vfl51KCDm2/mH/xO8EUuuBRDSutRcbPOBx4/RZSDmXYH4edfiqGSv4jhc4ISem4EkUFxLQodEgZKf8D//kGBFWeuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871859; c=relaxed/simple;
	bh=0ZROZIYuD1zVkkOa3PNcABnV8cSDGoSdT6l8Emh427M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CAEnlCV4ZOD25MSNeKF+I2UclnBH3Dg47keUghg0spBe1iT4wZ3S89WqOb0cLkk6PF2npeLFIkgVOMwWhUKHfIZa/nsU1r0ZQjsTL2zh4d99DiHLVFd8Gvh6kBNS7yxR3YovsHGP2UoB0sLQmAqqTgypXtbEsSOg0q/QVU3MU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bTB6lxM2; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fec2899574so3887259b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745871857; x=1746476657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLGFE4jWdVqehv02FfXRMamFv946mVo/oPig2GMtSpQ=;
        b=bTB6lxM2IAiqPw4WvBYbySq5aQ/xY8Tgsy7e8J4pGhrvVf2TCDLgv8ZyypGC7fO7uy
         nFmrMTsXoQk1HbHc/8cvm6RgpZKhQ10MrqreM1EvtnaK5m/DlBAGU7LtVZ9g3uKKPxW/
         MnHFMBHDuygzEUCxqB7dPBD1f/Ix+0sG5/MRGxXcILiwr+NkYm3i8E38cxOP5LfKYR7E
         11Qbz6to+ntf73IBcEZt/2PNui1r0+3DkG5IR04KvW8DY1ZliHdDyiSMb7LYvUTAoH2a
         VwOtBxQZjfCkJQiqdw8K8oVzdGmqPuiKftAg7vgiNYEivN3euW9/2iJTEO+hpndylD59
         tZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871857; x=1746476657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLGFE4jWdVqehv02FfXRMamFv946mVo/oPig2GMtSpQ=;
        b=mBMJCXZFA0pliGEnGmTlHAUmyPco8TJ3hkvlYIAHxz2jyWLgL+59Yrs24rUqrT4I5X
         mJd91t3UNKO1tE31xdrSbVXZUVNavhGFbnLaIWkS+TlkPLrBg5Vvxhl1YeEl21sNnSQC
         5bzmoe6BmO7TlkVauFAYVZISNB/YZY3TLJ/VSF6p+aexk3NxKOKBSj4P+OcXGn9q2eaV
         6+3N6/7ZFGcblcBY9vJ+gS/30jIlgqbEG6LAHYd9Qajf3vwY3IFGjkZErfCh/D/c9UEh
         rCNjpvrAw64/3M3lUJQtQ7RYQl4vHgg/daaFjVErlzdd8N3/iC7FMgbCpwwFVeRUwZXj
         siyA==
X-Gm-Message-State: AOJu0Yy+vySiD1kjQErCeddhZka4P2PU8Ij5yBwJV9RBbFqVAKMFuvkI
	AGAFeujkC3NJAVh7nO2UzN5MWtHXgW0y0GfPduAAUqc2xaVAjnHJPWPk3vilYSQ=
X-Gm-Gg: ASbGncsDMzYUxpQHpUfE2yIK9S89NmdlYbNwTYe2aFWpMXNVpBnVVqMumxI4zmWh+Ex
	vKI8QXET0AUiZxHqNXBZxbYUisXCjIGPUZRHNyl9ViP25Fx8EFLUgW9GgxjcXUx+9gHf20n/886
	SB7r0wg9JBv5Ih/VNEUtL1S2VA1LDziAm9ExQcrFeNe3d63sI/4O5ttReAYVh4TNkS6MLoFdozn
	puzxxWqX1A7+vhmsJIKG1imvlwqbHGk+dT1qkzn/b22wBS3kCVwfITDd2FGusAgldwImyBMI7NB
	kkauLodatKpOoilEdTiOvYvzkG4CH8c1y11S1SnlojaH1r4=
X-Google-Smtp-Source: AGHT+IH8dlw0ehMbgO7QpiThtCrPLkett8/hqgxlIDqGeXzMuHImTBnndaA0YhdIbBTxOtiX9weCIw==
X-Received: by 2002:a05:6808:22ac:b0:3fb:49cd:6bf5 with SMTP id 5614622812f47-402116118d5mr181018b6e.32.1745871856950;
        Mon, 28 Apr 2025 13:24:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec970ec5sm2196187b6e.34.2025.04.28.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:23:09 -0500
Subject: [PATCH v4 7/7] iio: adc: at91-sama5d2: use
 IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-7-6f7f6126f1cb@baylibre.com>
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=0ZROZIYuD1zVkkOa3PNcABnV8cSDGoSdT6l8Emh427M=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDL4H9/qOSxxJUC0We2S07QzezJ67119YrJbTCBQWHfa3
 IfLlnds6GQ0ZmFg5GKQFVNkeSNxc14SX/O1OTcyZsAMYmUCmcLAxSkAE1nZx8HQaj/NyyrO4M9V
 286Ze+pFsrgZNzAE7LTuNWJ6If864qfJ1GWuMZfv5etfnO7+LHa/YPf0mp/1bKnWYSnie63ab2r
 0xBkZWXdo5t3IqhA+uzThdzbzpxQPznV3+wJ+zHQRzp/qVf/qXOefRbnLtKzCTvyYlT6bx2G7ld
 vixFSLiz2dpro75BMesvzWquvbJ1nxeXli0kTNt+EMgTveSUnPkQoO0MiV5JI5m6e/4+OMlsDLp
 qa22oVqvRl8a0TrTJeJpfy1TZMOWlcpZnsot7lnhYS6QL5s0I2d3+Tca8qEZevC1nO4/D21WHVC
 aR2bhhHvi88S21yanvrbZayUYHweXnBlWt+GFWqm56QB
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer that gets used
with iio_push_to_buffers_with_ts(). This makes the code a bit easier to
read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is an alternative to [1].

[1]: https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timestamp-v1-2-4c6080710516@baylibre.com/
---
 drivers/iio/adc/at91-sama5d2_adc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 414610afcb2c4128a63cf76767803c32cb01ac5e..4ebaeb41aa4568e2461506471af0540af9d1a041 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -586,15 +586,6 @@ struct at91_adc_temp {
 	u16				saved_oversampling;
 };
 
-/*
- * Buffer size requirements:
- * No channels * bytes_per_channel(2) + timestamp bytes (8)
- * Divided by 2 because we need half words.
- * We assume 32 channels for now, has to be increased if needed.
- * Nobody minds a buffer being too big.
- */
-#define AT91_BUFFER_MAX_HWORDS ((32 * 2 + 8) / 2)
-
 struct at91_adc_state {
 	void __iomem			*base;
 	int				irq;
@@ -616,8 +607,8 @@ struct at91_adc_state {
 	struct at91_adc_temp		temp_st;
 	struct iio_dev			*indio_dev;
 	struct device			*dev;
-	/* Ensure naturally aligned timestamp */
-	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
+	/* We assume 32 channels for now, has to be increased if needed.*/
+	IIO_DECLARE_BUFFER_WITH_TS(u16, buffer, 32);
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.

-- 
2.43.0


