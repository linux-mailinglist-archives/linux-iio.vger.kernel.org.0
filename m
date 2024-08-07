Return-Path: <linux-iio+bounces-8308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4C94AADC
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7520C1F29049
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E63D8405D;
	Wed,  7 Aug 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VinEj13i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA581AD7;
	Wed,  7 Aug 2024 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042690; cv=none; b=eeVtl4vza0ZFDVZpDenvzxaPl6DYd9o//Ow2wx+Ybiqz0u16wENoFY6slE9UNg25VfJnWXfqCedfJCi3EiItE5ZNoW/cjqES7UeIWjlQH0rR4iisjS/eNUEwiFfH+OdvJPuHo3m7LYaQk/C+re+rGFH0VditKEh0HNaBjmogO1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042690; c=relaxed/simple;
	bh=684IISxg8vaXAJXLeWrPuba5w804vEdG4sa39zu06b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KoycnNfQr/i7Wmu8PwD2Y8sYhhyyEau5KwYDk5ZpGizTabtCE1IO0Xsy2tSKM/+ym46p0blpXEzJsQaPIkGkh5uHooEeE0JnYoJ676dLqIV69y2D/L+VXIgfb+wmVAK7sXT9uJfahIin0kvBjbebm+Se/7NeRNeJ1khL6qY05XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VinEj13i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42819654737so13268565e9.1;
        Wed, 07 Aug 2024 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723042687; x=1723647487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNpPNkP50fJTrVWUrfvyS64Vg7K67/EiLu5HJxO6FNU=;
        b=VinEj13iKbnpUOYuJENHhWaO5S1Xvm7HBzh8NdF38JTsGMJA/RLKyyUZQ8DL42Wzjn
         se1m6pJRr05iEQlPgzv/RKQPGcs3kE8GGZNLDoEQdeqkx0OqEAnaG0GMk8hxRWZIumuz
         jfHHb7CPNcCS7niUgOYFE9zm+kb+TN8Nz9ePEVfA2/2qUq8BdIK/0Vr8/joOO1MK/1z+
         Z4qdDdxReNjrwUO5VteGScKLPvSZQ4jBDzrjKz3fYmsV8YvLJJ1VKipg6XgX6jCWdP3v
         kfsYyNIiQEcEpPBOhhaipCOoLW1UF7ialkhBmJ2NoCg9Cy9wrKlwPECX0SnawligZI1h
         VAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042687; x=1723647487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNpPNkP50fJTrVWUrfvyS64Vg7K67/EiLu5HJxO6FNU=;
        b=pSImZolnv7q2rPjCIOxRyg+zBKcj+5FuZCwnqe0fvShPJZbwr0/BKVC5FFlHKVbgGm
         3g5TpF8MG+Tw8g+ddNgZaEXmiNFW/JOMgOOeaTT3q5dZDrTqS6XOrK1+/GpBsqHhSBGT
         YnSqtvd2tNXX48T+QbWTVP8kx+iUHK4txPbLenLQfWWU87ee74d+DBBBYfCXhm5jKIIl
         2M7bKk3YIiJOpv8kRZSRZji888xM2YzRGUCS3iwzum+de86jn0uFwgT+Vw3s2zb0QtGJ
         RiTZXRJ5a6c0RtDMo26L+cgFtStWVVIqAi/+FrSch2Xk4Iq0Wc+8TvIXKJc7qqe2HiBg
         fsJA==
X-Forwarded-Encrypted: i=1; AJvYcCUz6f6T9XTzYmwApAlUXjWJ+iEEGkQujb11LoE2+od+4oJozgWtJF5VX+BPwJe0c1DjmK63RFqr/OBydZ4Rwh/OyCF214Mze8dkgctoRjbXw9gjnFoj69OHG2ybHtlxZTVNhhJQOU3oaVIUlpXUM7jHCNVWetgf9/TwmKhgz4Gepm4ikg==
X-Gm-Message-State: AOJu0YwLOMqss6+LxTw6Q97B6DVgpOQj9SjSBtPnNUXxBWw4ndk28mIM
	7rECkkPdbaDkzJ6FRf7rydzcgBHyMHG/TYC4ydRfi+nr5vUTXLdb
X-Google-Smtp-Source: AGHT+IFoLKMRR4oqyU27FQklDGMTnP7tyGvM3y7Fp1AgDO9bMqSdSlFhEHOXQIykI/6uf1IXvUaXMA==
X-Received: by 2002:a05:600c:1c8a:b0:424:ad14:6b79 with SMTP id 5b1f17b1804b1-428e6af7f46mr139110875e9.8.1723042687311;
        Wed, 07 Aug 2024 07:58:07 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971993sm33273055e9.16.2024.08.07.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:58:07 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Date: Wed, 07 Aug 2024 17:58:05 +0300
Subject: [PATCH 2/2] iio: adc: ad7173: add support for ad4113
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-ad4113-v1-2-2d338f702c7b@analog.com>
References: <20240807-ad4113-v1-0-2d338f702c7b@analog.com>
In-Reply-To: <20240807-ad4113-v1-0-2d338f702c7b@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutz_ceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042684; l=2795;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=684IISxg8vaXAJXLeWrPuba5w804vEdG4sa39zu06b0=;
 b=zovgOhTELuu+1gvA3WETOHtCX0OjRgWhxPh8Q6k1mTVMe09Bm5Ub3qAJApNrkyqgaq3zDxHdS
 8HSWhhp6P3PAkn1JnRCaYks1gPHEOREesSOJ3FXMPnH0qbFeLdtWVQz
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=

This commit adds support for the AD4113 ADC.
The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
converter (ADC) that integrates an analog front end (AFE) for four
fully differential or eight single-ended inputs.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a854f2d30174..82b63f9705b3 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -3,7 +3,7 @@
  * AD717x and AD411x family SPI ADC driver
  *
  * Supported devices:
- *  AD4111/AD4112/AD4114/AD4115/AD4116
+ *  AD4111/AD4112/AD4113/AD4114/AD4115/AD4116
  *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
  *  AD7175-8/AD7176-2/AD7177-2
  *
@@ -84,6 +84,7 @@
 #define AD4111_ID			AD7173_ID
 #define AD4112_ID			AD7173_ID
 #define AD4114_ID			AD7173_ID
+#define AD4113_ID			0x31D0
 #define AD4116_ID			0x34d0
 #define AD4115_ID			0x38d0
 #define AD7175_8_ID			0x3cd0
@@ -294,6 +295,23 @@ static const struct ad7173_device_info ad4112_device_info = {
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 };
 
+static const struct ad7173_device_info ad4113_device_info = {
+	.name = "ad4113",
+	.id = AD4113_ID,
+	.num_voltage_in_div = 8,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 8,
+	.num_gpios = 2,
+	.higher_gpio_bits = true,
+	.has_vincom_input = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
 static const struct ad7173_device_info ad4114_device_info = {
 	.name = "ad4114",
 	.id = AD4114_ID,
@@ -1437,6 +1455,7 @@ static int ad7173_probe(struct spi_device *spi)
 static const struct of_device_id ad7173_of_match[] = {
 	{ .compatible = "adi,ad4111",	.data = &ad4111_device_info },
 	{ .compatible = "adi,ad4112",	.data = &ad4112_device_info },
+	{ .compatible = "adi,ad4113",	.data = &ad4113_device_info },
 	{ .compatible = "adi,ad4114",	.data = &ad4114_device_info },
 	{ .compatible = "adi,ad4115",	.data = &ad4115_device_info },
 	{ .compatible = "adi,ad4116",	.data = &ad4116_device_info },
@@ -1454,6 +1473,7 @@ MODULE_DEVICE_TABLE(of, ad7173_of_match);
 static const struct spi_device_id ad7173_id_table[] = {
 	{ "ad4111",   (kernel_ulong_t)&ad4111_device_info },
 	{ "ad4112",   (kernel_ulong_t)&ad4112_device_info },
+	{ "ad4113",   (kernel_ulong_t)&ad4113_device_info },
 	{ "ad4114",   (kernel_ulong_t)&ad4114_device_info },
 	{ "ad4115",   (kernel_ulong_t)&ad4115_device_info },
 	{ "ad4116",   (kernel_ulong_t)&ad4116_device_info },

-- 
2.43.0


