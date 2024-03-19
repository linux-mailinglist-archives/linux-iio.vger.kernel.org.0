Return-Path: <linux-iio+bounces-3623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F987FF99
	for <lists+linux-iio@lfdr.de>; Tue, 19 Mar 2024 15:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FB61F219D2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Mar 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3681AA5;
	Tue, 19 Mar 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HY7OCI+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32E81753
	for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858502; cv=none; b=V0/WqAsN/qOWzpYMmvaAa92Smsp2s17qXN4VJXfdGR7i9sEf2ealXabnivXwNgC32IGDa2FJ4qBPuap6zuYtG2n/TG48motlUL6Pz1Op0imN1iqBVbET1gNTiAQ0Jx6hpdcJjoVqg/5FpC7yR8SL10BbQIArKSDGR4TRCzVnWd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858502; c=relaxed/simple;
	bh=9GbFcOTWiKjScp+RpCHlH4Fi1wgrk546bJ/iYw8wQ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WpRtAIKYCir32QTzBgeZOh1ok2QHUqIcrtACp+HYYUvsflhmGdmCdol08aLYddI91JZ6uOTswHwvHhEndpGLiq95aHJWsu3Xzgxwf/FS6/VKJXIMzR8O0X0c6LcqLhdCn3wTBs8P7lbR26soZQw3jc9Tbrfa++yORM1L51wpBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HY7OCI+1; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-221e76cad07so2872198fac.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710858498; x=1711463298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DabY1J15YwNFzBEyYpS0eyo0GUzWeUGxiUlnH1vBQRc=;
        b=HY7OCI+1Mq5r0FYYqEJr2W96YA3DXtbLCStSfqeRGe/O8uPxCBcSp5DFvd9gLRfy5W
         JXbhYXCXNStVKo+igBhOFNwRtwTVgjBtjPiAh+t6jiKS/GBeRteorfdOKZXVQUUB7dQ8
         IzyNGBIGsYodBVMygFxfJPm4m9jSWsaxEIKRayxRLhIfnKQ7oB3fMSDaYAmfcduU4ND/
         6/McSeLrmtF77oGNG8+FNsgHTgxXU6qy7Oj4TNAL3dkiU9XWC1R/6jZF01eYWriT5nfk
         9ywPoGmfZsmfc9cqAkRRFotcyvs3VgCyofZ0kfFYjveCModMWM4k7EDmNA8AprLUwc+Z
         4ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710858498; x=1711463298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DabY1J15YwNFzBEyYpS0eyo0GUzWeUGxiUlnH1vBQRc=;
        b=fHVr0yKUj/ups0P8Al70vlYG8U15dwJEs9YH+xs6mOuAjQVPa6VnokqUW16NA5HeJ5
         8DyJIb8xzlmEh0UdVgR8mYsDQDdeGSgY6bDj9xHTHu9gNmIz2WOf/r91l6lOiKcByCkU
         asKmV/lCcKn3O7QuJoo8Qg/YrVXYL80eMFpC5F8waZadXy6Jo9L+NMb/sq6ADtoRcr4D
         Mak4AhqMOyVIwS0dcHhwCVFDN7t9F+7n4PF5fgRu6TSfsq9RrTc1QynnMUR9HNSVUUDU
         TVTKtl/bEMVunobqQWR3OmDqqTlfpCTOJelJmsFJpVL2739yNSfIX1nyqG/cPvsZqKoJ
         jH0g==
X-Forwarded-Encrypted: i=1; AJvYcCXeCKNLHfZ/dJsJ49sLUOktS6MPI94W3dr0fT/kI+zoTFUnl5b/0bYDdbKpI4EMosfiN3yyqdD8VYNXXySGVIb/NAKsAUEDtVc+
X-Gm-Message-State: AOJu0YxnV5NeSS6PySYsNqSO1NInfptsSTlhheAO9/MIrGZeqZrEjyjq
	wVt+DFN+chym1OD0gi77o1lzl3EWvToUpx/eN8WJa7pdTSITA66ZxoOB0r/4+jM=
X-Google-Smtp-Source: AGHT+IEe4rJIgkiBbhM6357gOOrXF6hRB0FJnB/1BJObpwDPwM9T+fl+h9ubcUOONq6hH3bZfIL73g==
X-Received: by 2002:a05:6870:7252:b0:221:403c:f942 with SMTP id y18-20020a056870725200b00221403cf942mr866594oaf.26.1710858498692;
        Tue, 19 Mar 2024 07:28:18 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ee12-20020a0568306f0c00b006e69a8c809csm427402otb.62.2024.03.19.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:28:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] iio: adc: ad7944: simplify adi,spi-mode property parsing
Date: Tue, 19 Mar 2024 09:27:45 -0500
Message-ID: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This simplifies the adi,spi-mode property parsing by using
device_property_match_property_string() instead of two separate
functions. Also, the error return value is now more informative
in cases where there was problem parsing the property.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Reorder error path to avoid else statement
- Link to v1: https://lore.kernel.org/r/20240318-ad7944-cleanups-v1-1-0cbb0349a14f@baylibre.com
---
 drivers/iio/adc/ad7944.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index d5ec6b5a41c7..261a3f645fd8 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -366,7 +366,6 @@ static int ad7944_probe(struct spi_device *spi)
 	struct ad7944_adc *adc;
 	bool have_refin = false;
 	struct regulator *ref;
-	const char *str_val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -382,16 +381,18 @@ static int ad7944_probe(struct spi_device *spi)
 
 	adc->timing_spec = chip_info->timing_spec;
 
-	if (device_property_read_string(dev, "adi,spi-mode", &str_val) == 0) {
-		ret = sysfs_match_string(ad7944_spi_modes, str_val);
-		if (ret < 0)
-			return dev_err_probe(dev, -EINVAL,
-					     "unsupported adi,spi-mode\n");
+	ret = device_property_match_property_string(dev, "adi,spi-mode",
+						    ad7944_spi_modes,
+						    ARRAY_SIZE(ad7944_spi_modes));
+	if (ret < 0) {
+		if (ret != -EINVAL)
+			return dev_err_probe(dev, ret,
+					     "getting adi,spi-mode property failed\n");
 
-		adc->spi_mode = ret;
-	} else {
 		/* absence of adi,spi-mode property means default mode */
 		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
+	} else {
+		adc->spi_mode = ret;
 	}
 
 	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)

---
base-commit: 1446d8ef48196409f811c25071b2cc510a49fc60
change-id: 20240318-ad7944-cleanups-9f95a7c598b6

