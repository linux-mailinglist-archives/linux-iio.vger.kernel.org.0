Return-Path: <linux-iio+bounces-18536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8995A97A1A
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F307B3B53BB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEA12C108C;
	Tue, 22 Apr 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e/O7UYqD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005C29B220
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359728; cv=none; b=blHa5cXIeboJW5Rgkj3Qdle2n6nlgcmYr7YK578llfYZeadCiH5hZCDaL58vHSC+hJjzi1xo58cuYv3kPQQX776Vnyw+jKreYJUx/8agd552HTNmVtv86hOOpQH8viIT4X8MXfm7Fb6hAGmcsdEjx7A+TRALj7N7oMYa1k2BSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359728; c=relaxed/simple;
	bh=NLK9rHWGxHgHc450e6JA3Kx5J3+N1Fpz21XOi57G4v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Owulq52ZuaQrRxudwkdPE2TsonWAv1ooll4vMlPE9wNtkyRLikfKcTPsJTqAUaD1rpwZsSKXeQJNwVgNkm+TKzOc43ePnxrX53BN79TJvzpcD4IcP2WL1EpPjMqeQeisQrWccooGQwZzuv1MPZlP04sf7hhD/KyP8cemvWK4iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e/O7UYqD; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72ec58e45baso3526992a34.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745359726; x=1745964526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2koMhN4hR5KSSnBsIlIFgfxzAiKDp/j1dG+oyh3qTA=;
        b=e/O7UYqDUkRefYvToUKT446kzKBO9A0WUHnPgj/zYSgLmQ4sT5e7hPEoYoXrCkGgBb
         cQRdFAwflvGs9qoj6LKPYQoEsmhJnaML7cMVJMHNmOnj/owTcHzyqL0az1NekvDSdD53
         J1uT4r55gwwmOIeGpIfs6tw631RrlzkXdq9vaKtPFOxYYxcQABdMu67o94kKikEk3+Ny
         e3O/lOmvmi4h7DexBFJJPFQkeXQTVjTrO67wTkbm/Sl5p+NKUvGvYabITMukWhiGUB+6
         6vwZuHkW5lDZvribfw34G5EE/IAMar0BILG9BOsIg+SsHcrzqSuCRVxoVMyzJkLFGY6w
         Izuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359726; x=1745964526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2koMhN4hR5KSSnBsIlIFgfxzAiKDp/j1dG+oyh3qTA=;
        b=T5ept+RDlq9Jy6bsykFpia5Vfhim3weUWbcG6ep9nbTSJotv5pstLfwn89s7js8i3X
         5NZ6vsIQj2315n+aCXzoUGGvn71XoinlBhWk7a2MJDdHzXbIjkNFt4rn0AnHF6VVWfjb
         dV/APkMd6pFYxd81Uu75oK5r4DlE8oFOKHvAIjgj160zB/eqSZjOyr4SMcs7X9bGNze1
         UNA3TFCRAXV4mLiRkTeKECsYCK2jw5IHz3xVTkD1ZeIySSDW9ydQY00UDOicUF5VSB2M
         ZnloXqcFOmEN1y+F7K8/kFR7LlHtnSStG9yk6wZ46yQ+qWz0grzBcyMUchIvNkzaSbfG
         YDpw==
X-Gm-Message-State: AOJu0YwyjMmXzSYXuw/5rPO1Hvx8Fxw2t1oSn0KRg+OQq/4F1SDCWvLd
	3viPyh3gaJCXU+6012lfaGEs6iJO/8RNAJEZ+ehZY6XZsBaOiFsQWy/GDIR2vQqxoL7lnM8w6J/
	ifqk=
X-Gm-Gg: ASbGncvyU2Lp8CKyiSyPMCg9GDvvA/RJTeuHuPDSt5DQPgwZdCg7LubXj3ks8vvgJrh
	D7PGMcaqias+CcfmXGmzFLZo9vhLEouxmjkvTSGFegeVJRC4HOQHpVlR5N0Fg++aclUqdjFRdqL
	9E+x3t3AyKKYIovAW9XIzHHU3IuVHdOnVALJgsnQZWUfJHmU8nPmo3mOlVe3U3hEduLrVyTGgdE
	w3eYv1AN1JTPttK8BXzvgCGSFV99Yu4rip6WguQ4rRwK0KWXV9o7OSK6abq0N394WeQHVnGjL+7
	qEePm2FxgufLSoIMNsl8YB8dcyXOn6nkW5a/HtEL8n3GLCM=
X-Google-Smtp-Source: AGHT+IGFNJO8mza9AqNofho5qSYBgvNp+Om7GG3O2Gt9GY/65S+lLd+LZcwXnwmwWqXB1V0j4m9iVw==
X-Received: by 2002:a05:6830:d89:b0:72b:f997:19c4 with SMTP id 46e09a7af769-7300633746bmr10719999a34.26.1745359726102;
        Tue, 22 Apr 2025 15:08:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730048848dfsm2265938a34.52.2025.04.22.15.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:08:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 17:07:47 -0500
Subject: [PATCH v2 2/6] iio: adc: ad4695: use u16 for buffer elements
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-2-3fd36475c706@baylibre.com>
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2149; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NLK9rHWGxHgHc450e6JA3Kx5J3+N1Fpz21XOi57G4v0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoCBNEF8NBH0RqMMLTfdFHjCNvkxbyizvXzbZOT
 2HLvY2UrbKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAgTRAAKCRDCzCAB/wGP
 wNwyB/9rs4fiIS3OMnMGfruRlEWMmXyGhafV1CQnLWK3hgPBA4IaLbeHMxHscn+SRfkt3I9izF8
 Q8UWmSNooqT9zexYI/fpo7YhisDh9lWY91+Ru9+btIYsKwdZ7kI/4NpprLyDDqaKFr7AqtqjnAz
 fRhs7v0HUAi+Kq8sxshNAPdN5DcjIfOZ2szwGmrhNZl/b7x7Cse+4Y4TNXucPW2SPhYF7SKl1n/
 xBRPIVI+pDMV6g++uaysZeJ3AwhAQ+ZLI1YUL9U+jp2I5sx01IUB+XuF8Kl6WEq/rXhiFJ2CN/c
 7fjUlT4VnU7YwQrTrN7oOxOA/VPZfoMIoRPGRuzDsIUhOdJ5
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the type of the buffer elements to u16 since we currently only
support 16-bit word size. The code was originally written to also allow
for 32-bit word size when oversampling is enabled, but so far,
oversampling is only implemented when using SPI offload and therefore
doesn't use this buffer.

AD4695_MAX_CHANNEL_SIZE macro is dropped since it no longer adds any
value.

AD4695_MAX_CHANNELS + 2 is changed to AD4695_MAX_CHANNELS + 1 because
previously we were overallocating. AD4695_MAX_CHANNELS is the number of
of voltage channels and + 1 is for the temperature channel.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 68c6625db0d75f4cade7cb029e94191118dbcaa0..0c633d43e480d5404074e9fa35f1d330b448f0a2 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -106,8 +106,6 @@
 
 /* Max number of voltage input channels. */
 #define AD4695_MAX_CHANNELS		16
-/* Max size of 1 raw sample in bytes. */
-#define AD4695_MAX_CHANNEL_SIZE		2
 
 enum ad4695_in_pair {
 	AD4695_IN_PAIR_REFGND,
@@ -162,8 +160,8 @@ struct ad4695_state {
 	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
-		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
+		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
 	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;
@@ -660,9 +658,8 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
 	iio_for_each_active_channel(indio_dev, bit) {
 		xfer = &st->buf_read_xfer[num_xfer];
 		xfer->bits_per_word = 16;
-		xfer->rx_buf = &st->buf[rx_buf_offset];
+		xfer->rx_buf = &st->buf[rx_buf_offset++];
 		xfer->len = 2;
-		rx_buf_offset += xfer->len;
 
 		if (bit == temp_chan_bit) {
 			temp_en = 1;

-- 
2.43.0


