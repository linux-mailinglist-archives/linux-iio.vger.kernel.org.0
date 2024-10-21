Return-Path: <linux-iio+bounces-10847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE4C9A60F2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B661F21603
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D41E5713;
	Mon, 21 Oct 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zqrxBMTa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643F1E47C6
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504820; cv=none; b=A0gJ5SpXokYRaDmSaX2d2XukE0BcqmO0L9Q8PTkweoB7N+r3nUFdersrbYiI8AJv7KaZpQJoHk4WXQJM12ifd7bUwX/PLVm+tZobjLDl0ZGXS/4uEcR22J0sxxMcjW7rd47RrIasK4FTU1s5PrSx8yA1rZmsa7ooYUuTkkiKpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504820; c=relaxed/simple;
	bh=g5cZOk2TBRdNqBRRxIPoU5chsYH4Ym3JbGrRyU4zj2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AifMrjjYyTdcu4FRUGNuXlakNXIH+NNZ4Q9JFloGbfmet1bwlxj8D3bFpWwe9WOqYLXs2LN3DXwQUBAr03r59zqMV/1CGuj6La9gOKX2NVM8rH69eiKYPnuWZMyNHsTBla9tt/QRjrdsmgoaCSzzVFskNBPmr6/v4yGzrV4a7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zqrxBMTa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43169902057so18002095e9.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729504816; x=1730109616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPOrVtTUtrTNGw1M2sJsQdVYLeAplWcJ5G6hfZza2f8=;
        b=zqrxBMTaza9gmCIugvDKA28+0PPQqa8RJYzO9CaShDxAzZAYNfvKMDw/9toJwXJNN9
         WcaQoDzWq6Y1nVadAHiTjovp+6o2zKKsJAlIi1ZuoeLMB14uJJrlbyhL6i2VxSJYFPHY
         tZniExwR0F6/6sKmPM1AUpXLrO0e4TTT0m2mljRAxFX2m4K82jl+eyEo2sPa/yd/CLNi
         ECQwFvgwRfBTlcqIC83PrQOl1bmT8sxfGVlrdF3A4Oq5PTCUNk6Jcz4atX/HgzwJTN+W
         1wV/5vpYlY7SXLzehG0lWwP//eEvK1OWDQCgRZooF8sN1KpWRp+XH/Xg11/O/gNJjmCP
         aPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504816; x=1730109616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPOrVtTUtrTNGw1M2sJsQdVYLeAplWcJ5G6hfZza2f8=;
        b=IhVv3gZI70ysdBHzawfwrU+VYr5r6u0zJvciuUsiiIOkh/fcOT63k4YPBhaQC9Ummm
         kN3cV0LOB51YHppUmw+6h03MyWEhr9calh/CzNgaF3brPbZO3j8SHxLiC0fjVn37rF9Q
         /m9wxCObu0ps0dqpQ4gwGlrPiJTCs6FNYu+D6XMKeQePLpp+A/KS3ODPa+hMLoPi25Jv
         uqSMS2hUXh8Vu7V0lZI8x6KyW0eO0/GwKlKN7AfI8DNRV2QKv3fLhnmHXwIoFLoAAhLh
         L3JLGajX/+em5WHo5BrLlh7dbgsMOd5OpQecQMS/gWMphWJthsrbJSC5jDagd1AFOUUx
         5pqg==
X-Gm-Message-State: AOJu0YzmwXNCPXJZGOr+RZ8zII3cqvgbW+y75k21VrgxoyN+4XwGHTSP
	jfSTzLJAQPHV86grqbdiQuY754zHGtfDQFyJbZU3CPnC9vKiorRoCjbdto+yYPE=
X-Google-Smtp-Source: AGHT+IF07HOumQy50gBkQaWj0y5iUsQm/oWvfTD2vdo86U7e3YHPzzmO2E6zfR2esGYs7FlPdkcG0A==
X-Received: by 2002:a05:600c:4fc4:b0:42f:8287:c24d with SMTP id 5b1f17b1804b1-43161667fdfmr89174005e9.21.1729504816134;
        Mon, 21 Oct 2024 03:00:16 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58bbaasm52375995e9.23.2024.10.21.03.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:00:15 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 21 Oct 2024 12:00:12 +0200
Subject: [PATCH v2 4/5] iio: adc: ad7380: fix supplies for ad7380-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-ad7380-fix-supplies-v2-4-2ca551b3352a@baylibre.com>
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
In-Reply-To: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
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
X-Mailer: b4 0.14.2

ad7380-4 is the only device in the family that does not have an internal
reference. It uses "refin" as a required external reference.
All other devices in the family use "refio"" as an optional external
reference.

Fixes: 737413da8704 ("iio: adc: ad7380: add support for ad738x-4 4 channels variants")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e257f78d63edd7910fcb936ec5344922f8e70b99..65096717f0dd3ea6a4ff7020bc544d62b84cb8fd 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -89,6 +89,7 @@ struct ad7380_chip_info {
 	bool has_mux;
 	const char * const *supplies;
 	unsigned int num_supplies;
+	bool external_ref_only;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -431,6 +432,7 @@ static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
 	.num_supplies = ARRAY_SIZE(ad7380_supplies),
+	.external_ref_only = true,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -1047,17 +1049,31 @@ static int ad7380_probe(struct spi_device *spi)
 				     "Failed to enable power supplies\n");
 	msleep(T_POWERUP_MS);
 
-	/*
-	 * If there is no REFIO supply, then it means that we are using
-	 * the internal 2.5V reference, otherwise REFIO is reference voltage.
-	 */
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio");
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(&spi->dev, ret,
-				     "Failed to get refio regulator\n");
+	if (st->chip_info->external_ref_only) {
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev,
+							     "refin");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get refin regulator\n");
+
+		st->vref_mv = ret / 1000;
 
-	external_ref_en = ret != -ENODEV;
-	st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
+		/* these chips don't have a register bit for this */
+		external_ref_en = false;
+	} else {
+		/*
+		 * If there is no REFIO supply, then it means that we are using
+		 * the internal reference, otherwise REFIO is reference voltage.
+		 */
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev,
+							     "refio");
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get refio regulator\n");
+
+		external_ref_en = ret != -ENODEV;
+		st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
+	}
 
 	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
 		return dev_err_probe(&spi->dev, -EINVAL,

-- 
2.47.0


