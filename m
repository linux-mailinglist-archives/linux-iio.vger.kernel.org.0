Return-Path: <linux-iio+bounces-21215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5444AF05D5
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A37A7BF3
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730813093CB;
	Tue,  1 Jul 2025 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JNKUGpyl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C96307AF7
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405986; cv=none; b=mORTOTMbEjDesMe7woD41OJMbYf02DU2WTAIQTymzFTPZ5bxUIYuhqCKhbiyyshPHlc/XdeKIrOok7SDdWC4ubN71tikGR0tgeWYd1AaQ6BtsDRolIxbE3NK++s5MzXMHHqWbUAxkaGZRrsjCdXRsObFBb4Njm/+glkFyyMadu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405986; c=relaxed/simple;
	bh=+d+NxpTsTAufeAHbXn6vZokwn73QBsqhiRNIGn6xEMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVgrmAqyB0PpgCGDZR2Nao1hS0iCDQWFnyV1C6elS0pios+Vk+yr9SSCVp/k6sOszFVx5KNjWuqvDOlbxqCyQHMwkpIT5Qac4rXMm6dPi+OWBrzB44iFhGvWDjZ0ES9zwqAInCANR0QuoEdFbbjf6PQvT/e/3jMVqOwKPq4f0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JNKUGpyl; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4080548891fso2153602b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405982; x=1752010782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HARK4yUyt3ToLiXOsTRFjUOUUAN/T6uBl9MD5Q99x4=;
        b=JNKUGpylAMjnGmD2wFUbPmMrcDvBn3o7M36pWOzGHeAuu1h3a/UrWS7LKqFUdVDr5V
         PVtkXtLaeYJenTh6qYu4+CENQm+CZk6YDeb5QmL+0fON/fkz2oNncgDW13XUbxC7wsrQ
         SNH+KnjruJM4PFx8WeDpYlmGzRZFv3ChjR5UxXjwUaqsXhg9zHqc0cHpBeaaY8QMgIJU
         E4B20SUQsRReo1Oug1GXkXsZ2ucj6Lp97TmBKOuHX9l8bGNASgZdis3aOd2rzHVbbKu3
         /8ukKp9jg4Jg7rf9gl2pv7OVvvzM4oTObsqljoGiO4+CtpX2FCeFAsNwG/Gvvk4PnLea
         FMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405982; x=1752010782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HARK4yUyt3ToLiXOsTRFjUOUUAN/T6uBl9MD5Q99x4=;
        b=Mh4876q0ldfUuIEhd96MeZC24JqR4ayjjlai/1pTvu03VO1jmK2WNxFwZaPhtBohJV
         PF8MFsjv++y1AxlOuTYHhWbE//7S2lYAfiqWu0nMrPpCz+g57ak5JTkpXAkEs4Kti44l
         1EWs7NNVc+L8IbwpIwPL2QDbf2nXVtupb1j1jbgadTPqJ5pQ8Q9EMbuCyQfTp+kgxDpU
         LElVKfKSdRZJw6vQFDV+TpDSI8qOP9/tNVbn9La5SlTaTYuaIV8g0OQFG8WwOeEsTvXU
         hxPpy2oFV9LpkqFh6x+IKzh7dIRGT3CgtNTV3C4fta1UVHe55mJR/sq3Z30HI3D/e7uf
         K/rw==
X-Gm-Message-State: AOJu0YyCIkc0gSPUspb/X7RRgkevGr2q89BiM5x/px9egG79ODG2b0YX
	QuEc3aP5O/db7AOEvMm4QYziV0CsoesNY54iUbKuGXcc5r4rpuPUigwJmleQ/YlKxdw=
X-Gm-Gg: ASbGncs11FFWJJ7Ytr8EtAKPASJsYRGSSjjVLwct1GORWxmWVdP0oD+5Hk713KaOgIz
	Q0/0ujJflqTNQ1gY7gmADlSkALg1y12rBAsMNCcl2DJgTwUjR8r0o8H9ICHhbBPph5rVh+iYeUi
	r7lLcRQMWwFu6lhGh3wSWZzJ+RgCf3MDz5HPriiSdn0p+aoV4bEbVWd3ItcvVv9VKS1wYg/pABW
	DOeycynyYp5zatJJvWiB5yV7GH4l2cjAdvHy/85uGs7M7ZGjasq1RbFRth0qg2wWfKAyk/yYIUB
	DuYFWvYtUNLxH0LKC4hogN40jvVfbm4gPaC5nI22syvu4oE6eTuCXYcHDcoFEKNYv0iyjDA6vjz
	F2AQ=
X-Google-Smtp-Source: AGHT+IHNvbIlM9B8xBbwOrEGY91WUX6qfGb1IgkqoOC/5A2b9xtY0fWbRtmKupZRSWPVdAK+GHh8ig==
X-Received: by 2002:a05:6808:4f14:b0:404:764:f7b6 with SMTP id 5614622812f47-40b8876a215mr265046b6e.9.1751405982526;
        Tue, 01 Jul 2025 14:39:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:59 -0500
Subject: [PATCH v3 11/12] iio: adc: ad_sigma_delta: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-11-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12172;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=+d+NxpTsTAufeAHbXn6vZokwn73QBsqhiRNIGn6xEMg=;
 b=owEBbAGT/pANAwAKAcLMIAH/AY/AAcsmYgBoZFWDmWkRubXMkuTiJqJVkkzxUBUyHg9U/GTIO
 n6FQf2+ha6JATIEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVgwAKCRDCzCAB/wGP
 wLhEB/dNn1oI1gAw2yzlTJ3TEzgEes0rXs7gal2teIWD2lz+kkGhtLq8TMW0ZGL7c2/3Gw34VdG
 tAHfy0Yo3yn9TuJfyDZ4MJLwa2kSt6kxTnXR3lKJe/LG3Bv3VYdAbwfpg7jIM8/XT+mBW80OtZI
 5jnPqV0qtM/+4x6vW3Y5n6WqDsU2UaQsIf+GsgRvqWCrlpMv3TYwy5+mjrUXVVnBzmv00BATqtz
 sbcTplgrWhJliRjA44VO1CHfX07yJ120rzh0w+MBKSNhZK3GJzmE5KohiFsegCIteAbrSCdq5o0
 WF/byPQ/V5iMVuvfp6xcJyYKadhOU+XKUbWl7Yz27S88n8E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add SPI offload support to the ad_sigma_delta module.

When the SPI controller has SPI offload capabilities, the module will
now use that for buffered reads instead of the RDY interrupt trigger.

Drivers that use the ad_sigma_delta module will have to opt into this
by setting supports_spi_offload since each driver will likely need
additional changes before SPI offload can be used. This will allow us
to gradually enable SPI offload support for each driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 165 +++++++++++++++++++++++----------
 include/linux/iio/adc/ad_sigma_delta.h |  14 +++
 2 files changed, 132 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 124c42e19f2e25723b67ea38f7d016f00ff91342..9d2dba0a0ee6d7fe60c8ea188ed614100419081d 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -27,6 +28,7 @@
 #include <linux/unaligned.h>
 
 #include <linux/iio/adc/ad_sigma_delta.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
@@ -467,8 +469,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	struct spi_transfer *xfer = sigma_delta->sample_xfer;
-	unsigned int i, slot, samples_buf_size;
-	unsigned int channel, scan_size;
+	unsigned int i, slot, channel;
 	u8 *samples_buf;
 	int ret;
 
@@ -496,25 +497,35 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	sigma_delta->active_slots = slot;
 	sigma_delta->current_slot = 0;
 
-	if (sigma_delta->active_slots > 1) {
-		ret = ad_sigma_delta_append_status(sigma_delta, true);
-		if (ret)
-			return ret;
-	}
+	if (ad_sigma_delta_has_spi_offload(sigma_delta)) {
+		xfer[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		xfer[1].bits_per_word = scan_type->realbits;
+		xfer[1].len = spi_bpw_to_bytes(scan_type->realbits);
+	} else {
+		unsigned int samples_buf_size, scan_size;
 
-	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits),
-				 sizeof(s64));
-	samples_buf_size += sizeof(s64);
-	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
-				    samples_buf_size, GFP_KERNEL);
-	if (!samples_buf)
-		return -ENOMEM;
+		if (sigma_delta->active_slots > 1) {
+			ret = ad_sigma_delta_append_status(sigma_delta, true);
+			if (ret)
+				return ret;
+		}
 
-	sigma_delta->samples_buf = samples_buf;
-	scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
-	/* For 24-bit data, there is an extra byte of padding. */
-	xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
-	xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
+		samples_buf_size =
+			ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits),
+			      sizeof(s64));
+		samples_buf_size += sizeof(s64);
+		samples_buf = devm_krealloc(&sigma_delta->spi->dev,
+					    sigma_delta->samples_buf,
+					    samples_buf_size, GFP_KERNEL);
+		if (!samples_buf)
+			return -ENOMEM;
+
+		sigma_delta->samples_buf = samples_buf;
+		scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
+		/* For 24-bit data, there is an extra byte of padding. */
+		xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
+		xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
+	}
 	xfer[1].cs_change = 1;
 
 	if (sigma_delta->info->has_registers) {
@@ -530,6 +541,8 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 						&xfer[1], 1);
 	}
 
+	sigma_delta->sample_msg.offload = sigma_delta->offload;
+
 	ret = spi_optimize_message(sigma_delta->spi, &sigma_delta->sample_msg);
 	if (ret)
 		return ret;
@@ -546,7 +559,19 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err_unlock;
 
-	ad_sd_enable_irq(sigma_delta);
+	if (ad_sigma_delta_has_spi_offload(sigma_delta)) {
+		struct spi_offload_trigger_config config = {
+			.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+		};
+
+		ret = spi_offload_trigger_enable(sigma_delta->offload,
+						 sigma_delta->offload_trigger,
+						 &config);
+		if (ret)
+			goto err_unlock;
+	} else {
+		ad_sd_enable_irq(sigma_delta);
+	}
 
 	return 0;
 
@@ -561,10 +586,15 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
-	reinit_completion(&sigma_delta->completion);
-	wait_for_completion_timeout(&sigma_delta->completion, HZ);
+	if (ad_sigma_delta_has_spi_offload(sigma_delta)) {
+		spi_offload_trigger_disable(sigma_delta->offload,
+					    sigma_delta->offload_trigger);
+	} else {
+		reinit_completion(&sigma_delta->completion);
+		wait_for_completion_timeout(&sigma_delta->completion, HZ);
 
-	ad_sd_disable_irq(sigma_delta);
+		ad_sd_disable_irq(sigma_delta);
+	}
 
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
@@ -679,7 +709,8 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) &&
 	    ad_sd_disable_irq(sigma_delta)) {
 		complete(&sigma_delta->completion);
-		iio_trigger_poll(sigma_delta->trig);
+		if (sigma_delta->trig)
+			iio_trigger_poll(sigma_delta->trig);
 
 		return IRQ_HANDLED;
 	}
@@ -712,17 +743,6 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	unsigned long irq_flags = irq_get_trigger_type(sigma_delta->irq_line);
 	int ret;
 
-	if (dev != &sigma_delta->spi->dev) {
-		dev_err(dev, "Trigger parent should be '%s', got '%s'\n",
-			dev_name(dev), dev_name(&sigma_delta->spi->dev));
-		return -EFAULT;
-	}
-
-	sigma_delta->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
-						   iio_device_id(indio_dev));
-	if (sigma_delta->trig == NULL)
-		return -ENOMEM;
-
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
@@ -742,14 +762,33 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	if (ret)
 		return ret;
 
-	iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
+	if (ad_sigma_delta_has_spi_offload(sigma_delta)) {
+		sigma_delta->offload_trigger =
+			devm_spi_offload_trigger_get(dev, sigma_delta->offload,
+						     SPI_OFFLOAD_TRIGGER_DATA_READY);
+		if (IS_ERR(sigma_delta->offload_trigger))
+			return dev_err_probe(dev, PTR_ERR(sigma_delta->offload_trigger),
+					     "Failed to get SPI offload trigger\n");
+	} else {
+		if (dev != &sigma_delta->spi->dev)
+			return dev_err_probe(dev, -EFAULT,
+				"Trigger parent should be '%s', got '%s'\n",
+				dev_name(dev), dev_name(&sigma_delta->spi->dev));
 
-	ret = devm_iio_trigger_register(dev, sigma_delta->trig);
-	if (ret)
-		return ret;
+		sigma_delta->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+			indio_dev->name, iio_device_id(indio_dev));
+		if (!sigma_delta->trig)
+			return -ENOMEM;
 
-	/* select default trigger */
-	indio_dev->trig = iio_trigger_get(sigma_delta->trig);
+		iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
+
+		ret = devm_iio_trigger_register(dev, sigma_delta->trig);
+		if (ret)
+			return ret;
+
+		/* select default trigger */
+		indio_dev->trig = iio_trigger_get(sigma_delta->trig);
+	}
 
 	return 0;
 }
@@ -769,12 +808,29 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
 	if (!sigma_delta->slots)
 		return -ENOMEM;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad_sd_trigger_handler,
-					      &ad_sd_buffer_setup_ops);
-	if (ret)
-		return ret;
+	if (ad_sigma_delta_has_spi_offload(sigma_delta)) {
+		struct dma_chan *rx_dma;
+
+		rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev,
+			sigma_delta->offload);
+		if (IS_ERR(rx_dma))
+			return dev_err_probe(dev, PTR_ERR(rx_dma),
+					     "Failed to get RX DMA channel\n");
+
+		ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
+			rx_dma, IIO_BUFFER_DIRECTION_IN);
+		if (ret)
+			return dev_err_probe(dev, ret, "Cannot setup DMA buffer\n");
+
+		indio_dev->setup_ops = &ad_sd_buffer_setup_ops;
+	} else {
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &ad_sd_trigger_handler,
+						      &ad_sd_buffer_setup_ops);
+		if (ret)
+			return ret;
+	}
 
 	return devm_ad_sd_probe_trigger(dev, indio_dev);
 }
@@ -837,6 +893,20 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 			return sigma_delta->irq_line;
 	}
 
+	if (info->supports_spi_offload) {
+		struct spi_offload_config offload_config = {
+			.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+					    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+		};
+		int ret;
+
+		sigma_delta->offload = devm_spi_offload_get(&spi->dev, spi,
+							    &offload_config);
+		ret = PTR_ERR_OR_ZERO(sigma_delta->offload);
+		if (ret && ret != -ENODEV)
+			return dev_err_probe(&spi->dev, ret, "Failed to get SPI offload\n");
+	}
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
@@ -846,3 +916,4 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_init, "IIO_AD_SIGMA_DELTA");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Analog Devices Sigma-Delta ADCs");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 2037bb68b44115681ff48f66b580b63f50c2ea9e..6e70a412e218d54bbf9bb6861b1a4cc89be868e8 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -31,6 +31,8 @@ struct ad_sigma_delta;
 struct device;
 struct gpio_desc;
 struct iio_dev;
+struct spi_offload;
+struct spi_offload_trigger;
 
 /**
  * struct ad_sigma_delta_info - Sigma Delta driver specific callbacks and options
@@ -47,6 +49,10 @@ struct iio_dev;
  * @has_registers: true if the device has writable and readable registers, false
  *		if there is just one read-only sample data shift register.
  * @has_named_irqs: Set to true if there is more than one IRQ line.
+ * @supports_spi_offload: Set to true if the driver supports SPI offload. Often
+ *		special considerations are needed for scan_type and other channel
+ *		info, so individual drivers have to set this to let the core
+ *		code know that it can use SPI offload if it is available.
  * @addr_shift: Shift of the register address in the communications register.
  * @read_mask: Mask for the communications register having the read bit set.
  * @status_ch_mask: Mask for the channel number stored in status register.
@@ -65,6 +71,7 @@ struct ad_sigma_delta_info {
 	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
 	bool has_registers;
 	bool has_named_irqs;
+	bool supports_spi_offload;
 	unsigned int addr_shift;
 	unsigned int read_mask;
 	unsigned int status_ch_mask;
@@ -108,6 +115,8 @@ struct ad_sigma_delta {
 	struct spi_message	sample_msg;
 	struct spi_transfer	sample_xfer[2];
 	u8			*samples_buf;
+	struct spi_offload	*offload;
+	struct spi_offload_trigger *offload_trigger;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -121,6 +130,11 @@ struct ad_sigma_delta {
 	u8				sample_addr;
 };
 
+static inline bool ad_sigma_delta_has_spi_offload(struct ad_sigma_delta *sd)
+{
+	return sd->offload != NULL;
+}
+
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
 	unsigned int channel)
 {

-- 
2.43.0


