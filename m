Return-Path: <linux-iio+bounces-10293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2C9931D9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8501F22E06
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A01D9695;
	Mon,  7 Oct 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Afbj57m8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA021DA0E0
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315952; cv=none; b=ngJx3WxMSw/BcN3FiN4HJ12tWi5W+gN3Pfb6XQn+nX7KPa/iydPlsp4h6cXZ5GI9ZIjXvyVKvgJEgrDnvri0xjY7nWRn+rPOfqeJUWcr1nf3sLT0fFDKWOazCJmzj/gkDoXQc1XScvCecnBi0CPiw0SgA62WXnslVq6Bg2RlrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315952; c=relaxed/simple;
	bh=2IxdougJyqNRz74S7DpsCNl1pnl2tsBFx1nzEHz/Xiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9Z4oq0jAMHhJHyz/9lujdtJpKLW7XJpCmyBw2MgTqN6OWe07a4OEyUlO3OE2LRYw8+DRXG9FKhTNKrcv1pGAGHHuvQkyx+mk/PIXTI1LiiIPzBtKjJRGmjoGJ2puskqJmbZFcbA8e+EEhQsr+4lXCPIBpowplma4rq4VowcZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Afbj57m8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so47268875e9.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728315947; x=1728920747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xerIRuBcdPIcjxkDvRuqy8DYlqfSAe4ihD2g3Fjids=;
        b=Afbj57m8kXm9AeRZPN7jeVUnETkA8Ur1vBOdgdqKTuuHgI2XOBCFdDMORHmw1SwMo9
         c4XlC/MtNZp3EsTMKB7xOiwe9UZeVvaN14OMlkzcT++VcbP3tJiQHRmphgJhiHH0FT2r
         lM2mgNUmLb2I8x3HKJaOjbOSpKpXpAfGeXYHJb2aChWofZtGwSaQJV7nFT9uXW8hDZAF
         gECUyV+4Zs2pXv1fI2ywSFZBbfcEY99S8O/YZ1wbCo1CIyGEX5DzN/25fDH0y9ihXrtS
         Y/2bhBhpL61MvHVIz+TdlzWt+VtdVXNnGKQRDwRljIYmLK0ZjkL9zR/HsZJ+gp4F3ibl
         7NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315947; x=1728920747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xerIRuBcdPIcjxkDvRuqy8DYlqfSAe4ihD2g3Fjids=;
        b=xLWPhxthTQN1Pqij+o9W9rpKJYmePNSrN6FLdedAOrCfSJbDxyFje2eJTqGphy8TnN
         wEdk/sT4ABbYmZ09xWv84nTv7lZC+FcviBTrEy7aSe1vUli2jDTCZb7maAcvj1vZg8cj
         om0MuSqK2VbLHmtGEksJPqeYJm7V0KCN1Hobcuqp4O/smSL9IZGkEQ64Iq+EF5GjDHER
         j2Y9BHrnoSjjZDLtxLwGv6sz8PXpwIAyuuwuAFWrnFleN/lIiK0dXIRKJpsYXNKoaQmk
         spUPSTZPU1eR8hdZKT+X+rek8Z1S2kMFYqkH40jBJO7yzToyUUc/GFXTiv6LR79g59d6
         aWgg==
X-Gm-Message-State: AOJu0Yw7HRxtUvAUcLH8Qs59xrBTqJPj2iqWXfqH2hWLboCQ9MmH12fO
	x3UKmHXyiU6hAepJm0rSCFtEdJqLgO3EdM7AqqelScCMEGpAoz8gJwTIxFUuhgA=
X-Google-Smtp-Source: AGHT+IFmckd0DUvY5nrWyEn/6hzLuORieedAjB/Bvo2/O+xUmyY96AmtbwXlCI6qQBy/zXyXN9lM/Q==
X-Received: by 2002:a05:600c:1ca5:b0:42c:b3e5:f688 with SMTP id 5b1f17b1804b1-42f85a6c5bfmr85650685e9.4.1728315947438;
        Mon, 07 Oct 2024 08:45:47 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm17645555e9.20.2024.10.07.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:45:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 07 Oct 2024 17:45:47 +0200
Subject: [PATCH 4/6] iio: adc: ad7380: add missing supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-ad7380-fix-supplies-v1-4-badcf813c9b9@baylibre.com>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
In-Reply-To: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

vcc and vlogic are required but are not retrieved and enabled in the
probe. Add them.

In order to prepare support for additional parts requiring different
supplies, add vcc and vlogic to the platform specific structures

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e033c7341911..9ef44b605144 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -75,6 +75,7 @@
 #define T_CONVERT_NS 190		/* conversion time */
 #define T_CONVERT_0_NS 10		/* 1st conversion start time (oversampling) */
 #define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
+#define T_POWERUP_MS 5			/* Power up */
 
 struct ad7380_timing_specs {
 	const unsigned int t_csh_ns;	/* CS minimum high time */
@@ -86,6 +87,8 @@ struct ad7380_chip_info {
 	unsigned int num_channels;
 	unsigned int num_simult_channels;
 	bool has_mux;
+	const char * const *supplies;
+	unsigned int num_supplies;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -243,6 +246,10 @@ DEFINE_AD7380_8_CHANNEL(ad7386_4_channels, 16, 0, u);
 DEFINE_AD7380_8_CHANNEL(ad7387_4_channels, 14, 0, u);
 DEFINE_AD7380_8_CHANNEL(ad7388_4_channels, 12, 0, u);
 
+static const char * const ad7380_supplies[] = {
+	"vcc", "vlogic",
+};
+
 static const char * const ad7380_2_channel_vcm_supplies[] = {
 	"aina", "ainb",
 };
@@ -338,6 +345,8 @@ static const struct ad7380_chip_info ad7380_chip_info = {
 	.channels = ad7380_channels,
 	.num_channels = ARRAY_SIZE(ad7380_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
 };
@@ -347,6 +356,8 @@ static const struct ad7380_chip_info ad7381_chip_info = {
 	.channels = ad7381_channels,
 	.num_channels = ARRAY_SIZE(ad7381_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
 };
@@ -356,6 +367,8 @@ static const struct ad7380_chip_info ad7383_chip_info = {
 	.channels = ad7383_channels,
 	.num_channels = ARRAY_SIZE(ad7383_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
@@ -367,6 +380,8 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.channels = ad7384_channels,
 	.num_channels = ARRAY_SIZE(ad7384_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
@@ -378,6 +393,8 @@ static const struct ad7380_chip_info ad7386_chip_info = {
 	.channels = ad7386_channels,
 	.num_channels = ARRAY_SIZE(ad7386_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
@@ -388,6 +405,8 @@ static const struct ad7380_chip_info ad7387_chip_info = {
 	.channels = ad7387_channels,
 	.num_channels = ARRAY_SIZE(ad7387_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
@@ -398,6 +417,8 @@ static const struct ad7380_chip_info ad7388_chip_info = {
 	.channels = ad7388_channels,
 	.num_channels = ARRAY_SIZE(ad7388_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
@@ -408,6 +429,8 @@ static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.channels = ad7380_4_channels,
 	.num_channels = ARRAY_SIZE(ad7380_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -417,6 +440,8 @@ static const struct ad7380_chip_info ad7381_4_chip_info = {
 	.channels = ad7381_4_channels,
 	.num_channels = ARRAY_SIZE(ad7381_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -426,6 +451,8 @@ static const struct ad7380_chip_info ad7383_4_chip_info = {
 	.channels = ad7383_4_channels,
 	.num_channels = ARRAY_SIZE(ad7383_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.vcm_supplies = ad7380_4_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
@@ -437,6 +464,8 @@ static const struct ad7380_chip_info ad7384_4_chip_info = {
 	.channels = ad7384_4_channels,
 	.num_channels = ARRAY_SIZE(ad7384_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.vcm_supplies = ad7380_4_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
@@ -448,6 +477,8 @@ static const struct ad7380_chip_info ad7386_4_chip_info = {
 	.channels = ad7386_4_channels,
 	.num_channels = ARRAY_SIZE(ad7386_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
@@ -458,6 +489,8 @@ static const struct ad7380_chip_info ad7387_4_chip_info = {
 	.channels = ad7387_4_channels,
 	.num_channels = ARRAY_SIZE(ad7387_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
@@ -468,6 +501,8 @@ static const struct ad7380_chip_info ad7388_4_chip_info = {
 	.channels = ad7388_4_channels,
 	.num_channels = ARRAY_SIZE(ad7388_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
@@ -1004,6 +1039,14 @@ static int ad7380_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
 
+	devm_regulator_bulk_get_enable(&spi->dev, st->chip_info->num_supplies,
+				       st->chip_info->supplies);
+
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to enable power supplies\n");
+	msleep(T_POWERUP_MS);
+
 	/*
 	 * If there is no REFIO supply, then it means that we are using
 	 * the internal 2.5V reference, otherwise REFIO is reference voltage.

-- 
2.46.0


