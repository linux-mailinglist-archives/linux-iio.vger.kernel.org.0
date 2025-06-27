Return-Path: <linux-iio+bounces-21019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8BAEC328
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 01:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE46E7749
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3234298279;
	Fri, 27 Jun 2025 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AYyrBXmh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9B292B5A
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067692; cv=none; b=VIy/KQIosCYviHieutOPyu5+1u7XM2bKtVZiGRkSmkTmL+NZYl1F7tKJK3qQ40CNUMt8HezMdB1tWANh9jv2BKVPQhigY4nIofk+Or1pzX98MrryT1p5hoNdPQ7AK6ZKU7njIK8ysRLZQPk5olcb9MNTkJJ7BxLxCWjmVYs7kDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067692; c=relaxed/simple;
	bh=1w9k49FoTu+/FNwh8fqdJnOZWQOe3GEkbod4N9CfdFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GH4luxAliwuzQyJU5By40BVlmjcZkj4hqou0d9Y3qZ+mEsHXrjmVNoNV7mUzYSVIFIkchgw2GhZRvaM58rJXh6FExnAiDenOqEzZpUs8uBwv7S5Rl4VUfUQkwVl8+9uVodakyUSMTsQX/dC0Ij/oCHvV/UygnJV5Nj3DEYWWkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AYyrBXmh; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4079f80ff0fso2181521b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067689; x=1751672489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNbL5PGqFNoHzfRCAsoh2AXUDM6lXVyWkMQwcXklKjI=;
        b=AYyrBXmhI5Tdi5pXytgQSVzDR9M1qHo1nCBt5p/JGVVd++Hy6XRa0e32kWe0QLZnOk
         DjgImImk1ERN9RmI+pskjtY4ig8IaGbWNbVWyqlK9F4yTHqseP/us73j/+CICE40rBrn
         JmA+sVOYET5r8zlYB1ndxP+DVEhonN/oIFMnKVqjP8LXt4mxsfxXSu1+QvHc9SwYuhAe
         A/vSRMLHZbo5cFqXajQ5KaoxZoX9B3K9/Nr7XqUGEeOow1EWuj2fIHZJLkC+hHmykLXQ
         RobMhBnd5g8163ZCqOq7hVoW2YL9yUQZkKSvBWfrwmRRF7+U234Q5gJYUtKTYbzN89kO
         dcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067689; x=1751672489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNbL5PGqFNoHzfRCAsoh2AXUDM6lXVyWkMQwcXklKjI=;
        b=r7HR/G1GlJGuIJhYGNd2cR1/KMBGU5Ex1ER/RVDJUrwNPmgOQu+VkII5oHoyxwoZfl
         13hohgBZSF7DZo9+luDxVlAWWEcORXdz5E8UMKDnNrTf/bhAll7EMu4Ypa3WiCPhH7pF
         kKcrRxcE8IURa4++BIzQrODWTOxJx+50c8t80nd5WeAhtcQHoZHJX+ApydffKHLCnyd6
         D/xmZxXLDNDYDr6AOJlH4OBIZ7MYf7aoVZcZAZrxRU0Kl4TVXivI/8gAHAHRsDfTH6dc
         YzWsHYJKc9XI9BTakeiWKBuDbCDu8pJv+XsFsjjTU9p3jkRgZRtPIbJAL4qnHlGeyo/w
         Ri2g==
X-Gm-Message-State: AOJu0YwDgDQaOpSN4OSz9oLoCTcVW3qJZtvxrB5J2D3DvUHmKJ+UEntY
	opTfnPLUsCqTDjea7a3XSw7o8CzEtr09jTjfXP7LeK7qAMDfK33whX71XvkdCMsAojQ=
X-Gm-Gg: ASbGncuZpAAHEEJOiMyo8qsMV0jglM6gosCROXpp0yo3tBoC5QRXlouDr6IODVXgJhs
	4pESbYqNSAat6VvmJ7GDcEFTH2sGTETA9l7hyEFEDt1tuZ+bbyapqzDMIoRRKLoYch7mEvcYRTT
	Cp8fQHDiMaWctTqttDtna0HD73LLIX7A9KPk6e102KnDxzxG1MlPsFtkSma8AY4eblpwKVvB5yv
	2r7eBzgY2XemDsmaBaaLRAYMJlswrBt6An0Ns5m163ImQUvgF82HLHB6w9+HYEjGduB0ZIh0ABV
	7v8ZUTRmcbFcQALy3/aHtyH79vC8+ovE7JYeU2sQEZNrG3lp0AApXQzT8izvO9IxUyM=
X-Google-Smtp-Source: AGHT+IE7yAgNDxWCpdbfAu7y9ArOuEbulXmCvKPRZ4Y1LCezFJVsZ/pxp8wI03z2qqsNqcIa9dUGDw==
X-Received: by 2002:a05:6808:120b:b0:40a:5b53:6502 with SMTP id 5614622812f47-40b344e07f6mr4141978b6e.9.1751067689519;
        Fri, 27 Jun 2025 16:41:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:40:00 -0500
Subject: [PATCH v2 04/11] iio: adc: ad_sigma_delta: use BITS_TO_BYTES()
 macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-4-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3611; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1w9k49FoTu+/FNwh8fqdJnOZWQOe3GEkbod4N9CfdFg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXyvtTvFFxTVf3HN3d8mcYeIBpjOEsZtLqO7hz
 I6L5y8d9/6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8r7QAKCRDCzCAB/wGP
 wE5EB/48IvAlfz2ZPEHEGilu+LpJo2tza3hSAq8BbMNnerbFXPfA7uMSKR4XIJgMOHwC4/qkMi+
 gY/c9zjHpenIYdxEyGguzsD7t0T2rA79elo3i21y1q8iA8J3swuw+zd3aQboEjB0UeW26XiteFp
 CbNgSXDCNiwVgtOsFEHIDYt5CwFfTX7uAYpO+SYzCtyC0qK+mIKiqm+OiASnUaKBGoBgg5NCFds
 7uePDwtIx45NeZ5UEhojp+Cm7uRT3PH9EiaoP3WbaTmRIcaRvS92Hy2hN7eyvIXPnok44bpmw4V
 12SVbniqSV87Gu+1yf5S4bGzuCG5qLEr36Htis6kbRtzWZUc
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use the BITS_TO_BYTES() macro instead of dividing by 8 to convert bits
to bytes.

This makes it more obvious what unit conversion is taking place.

In one instance, we also avoid the temporary assignment to a variable
as it was confusing that reg_size was being used with two different
units (bits and bytes).

scan_type is factored out to reduce line wrapping.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 5362157966d89cbf0e602716aaaf0b78f3921b11..64ed8aeb71f7c6ca19fff0438fa5ccce0c1d8f8f 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/align.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -190,7 +191,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 	u8 *buf;
 	int ret;
 
-	size = DIV_ROUND_UP(reset_length, 8);
+	size = BITS_TO_BYTES(reset_length);
 	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -419,7 +420,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 		data_reg = AD_SD_REG_DATA;
 
 	ret = ad_sd_read_reg(sigma_delta, data_reg,
-		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
+		BITS_TO_BYTES(chan->scan_type.realbits + chan->scan_type.shift),
 		&raw_sample);
 
 out:
@@ -453,6 +454,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sigma_delta_single_conversion, "IIO_AD_SIGMA_DELTA");
 static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	unsigned int i, slot, samples_buf_size;
 	unsigned int channel;
 	u8 *samples_buf;
@@ -488,7 +490,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
+	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);
 	samples_buf_size += sizeof(s64);
 	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
 				    samples_buf_size, GFP_KERNEL);
@@ -543,6 +545,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	u8 *data = sigma_delta->rx_buf;
 	unsigned int transfer_size;
@@ -552,9 +555,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	unsigned int reg_size;
 	unsigned int data_reg;
 
-	reg_size = indio_dev->channels[0].scan_type.realbits +
-			indio_dev->channels[0].scan_type.shift;
-	reg_size = DIV_ROUND_UP(reg_size, 8);
+	reg_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
 
 	if (sigma_delta->info->data_reg != 0)
 		data_reg = sigma_delta->info->data_reg;
@@ -616,7 +617,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		}
 	}
 
-	sample_size = indio_dev->channels[0].scan_type.storagebits / 8;
+	sample_size = BITS_TO_BYTES(scan_type->storagebits);
 	sample_pos = sample_size * sigma_delta->current_slot;
 	memcpy(&sigma_delta->samples_buf[sample_pos], data, sample_size);
 	sigma_delta->current_slot++;

-- 
2.43.0


