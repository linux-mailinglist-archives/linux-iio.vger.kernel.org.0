Return-Path: <linux-iio+bounces-21024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23DAEC33D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC8516500E
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 23:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13B2EE99F;
	Fri, 27 Jun 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OWb2MtR1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70E2EE280
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067699; cv=none; b=jWG4MdISE6znIYkRkQio1VIXJQaXKc2dnaOdyvq1R9veX6ZmnBV8eGjINUxS40YLjoJ//QHIctCz0BNESPxyxSvvwojxNFm6FCFLtPKx0filXZw/yiFJSgQZFfB0Q8ESTpTleMEPms3oqarU9yShvWkBAdlrCd/WlMkPylSyfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067699; c=relaxed/simple;
	bh=9aRsS4c+EVWvvCxccNYIyqIDtyXAfYj+/CLYuMIN3pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+scyxwFQTm2jiNJKGEMAJcwonnNzG7/epQtbB8stBwwjdEvAysRsF7053QaMfBS2slg52D7x55MkuF87b9A7YUGDdFDLp1bTTjOJn6gNKDqyfHvazEFBHhTTqwzAQz4CVmUFEgf9pVg9Gs93wzga/mroxaCH2TjJaqOxKloQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OWb2MtR1; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40af40aef06so1886737b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067696; x=1751672496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09iKu9SVVSyk2GA4qCDi/PaMVttyfxxhvZ3lPr9vevk=;
        b=OWb2MtR1wxWGtvyURuwFNlK7gLRc6xu9vGdLneF6LF99Cy9Ir4kWgGN8v/cSXEW2jF
         isuTZj7VKw79ehjC+7VRiaXdmo1ZaerU7BKWtImM86gpPgC62ZfCNFolvXyGzcPGLqMI
         0vGcBXOEFQwe1CteQI0tbQ6H+QKyudkTc1+TqXzZd/chvrMfXpq4g02IiclIfxPN9FXY
         R9Ql5U2Cz1RPFSv3FiLRKwkc9+BaZ9YFbD3LiJVty5oTRdWqpOGo8G4Uz3ZinJTbvXh4
         uZayv3+R4L2rHO+sFgYpHGgdrgBmdxSOmgOQITj4d6ydzHyKvGr8MUuMm7JUTMN+o5D7
         fHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067696; x=1751672496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09iKu9SVVSyk2GA4qCDi/PaMVttyfxxhvZ3lPr9vevk=;
        b=sAjc8+ObFBDbCYXXgksxUUj3v/IWmzM+/XjyjKILQgHZE+QZ7CYLmKaqJ/aQS9nrIE
         pI4dhAxqo4GIenlc39LGW/pN90wldPk2vFZyJpMuJr90Fv+gnFzdreprn/oFOeqmV1vf
         bBOGJBr0BN4rh8BMgVvV9NUv6/6VXWTmteolk0P72d9nmY7fDM0YQjbwxWxySSuBCvaJ
         kQcesRb/kJGClWeY6TaEYgngmvoBp8gwIG1W5P0RabAjVkBXKEZIDPnEsP021aXE0SFE
         3ZMqFGEAh1S1mlsGqyigplQgvvOmbOOdXDrsuT0Yi/Q/YwYqFqyofmfCmZUnbGTWw41T
         tv+w==
X-Gm-Message-State: AOJu0YxRQchPbOlsEZIPGAA+Yfl1PMHpdGBswd9D6e6eyIkUNZfAPd21
	WCp3GEltUZowXRrq+RVtwuseyBkk+jiRpST/fuV2UKkfMANJqVloyP3B5eYe3BR2qcE=
X-Gm-Gg: ASbGncuTKMvcKmD1kJ+/5rlFvvlZLNVypLvPlCKBu8LJ/16ImSUvNYrdjVsTcTyxLeZ
	hLMU8+mCXmnNM6AMD52iPMCojDE9pEaipFJNC+plWvQ4gtmUPnSMIxroJEBas7V+FCptsrf8Zux
	zqRCSV8dkXl8Smhlw0MY/sbcK4d2peug1YxgGpBUtbC8WrcEJLXXhjs16IRyOvEDnS/HVCs3hVh
	gxUpjtfx5JZh4nyky6XW3Yv3f4+/ZXmKF/jgyJ/lhX56MbIWWfvQyCNeQlER1swiV4efttSKeEd
	DAlXyn+UziWJPsqMSVBHdZ7WlXK4SOG/pFxX4Z+634i32zZKVSzeTSCnDvjemPCRBbs=
X-Google-Smtp-Source: AGHT+IG1Wk0RDQrob8xKgWXmlHoHuY6AB0PgqLKkmTNyTKzQOEl+ROC0jliAQhtmVmMMXV9VLuLwNQ==
X-Received: by 2002:a05:6808:f0c:b0:40a:fb27:9e8d with SMTP id 5614622812f47-40b33dbc679mr4316226b6e.15.1751067695602;
        Fri, 27 Jun 2025 16:41:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:40:06 -0500
Subject: [PATCH v2 10/11] iio: adc: ad_sigma_delta: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-10-f49c55599113@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12134;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=9aRsS4c+EVWvvCxccNYIyqIDtyXAfYj+/CLYuMIN3pk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXywV67vkB9d6JV+WJ2Zr1c6efD/07BSsDkA4L
 WR8J0cM9EmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8sFQAKCRDCzCAB/wGP
 wDI5B/9CCmEdXzDOuikQ/opZVhbtfJKXzy9Qzi8FowIlYJz4BCXzKuqFBBSZMGisYoIhCuhPhA6
 f4PBsjoOtLaI6tGIus35F7XUFz4QL5RqREMegpvh4d1gBZdBnpLV/ErsFqNFVmgD5Z7JwMjUkMY
 6E5+T9/RVyAZPbZ77YmPekIWzaPCiq8MdC8JbJ8jv/t0RyCdhaYLbDucO9hHzJOFjapr2UNvv0H
 jNVm6vDeHtuiZfLP4+dGhTG+egQmIc1GusxBLNXUNNZmBm2XyWyDZhSQFUurlQstkoaBF1LpsKn
 5BLuM+4Hx3qaUv1MQvly3kro5IUBX/RQoIqPhfD07Inhxy2d
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
 drivers/iio/adc/ad_sigma_delta.c       | 163 +++++++++++++++++++++++----------
 include/linux/iio/adc/ad_sigma_delta.h |  14 +++
 2 files changed, 131 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 30ae7ef6d3f9f686b02176508813c689e6fb92f2..38ed52644563c8d1869b12bcf25c4d63be35dd17 100644
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
 
@@ -496,24 +497,34 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
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
 
-	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);
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
+			ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);
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
@@ -529,6 +540,8 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 						&xfer[1], 1);
 	}
 
+	sigma_delta->sample_msg.offload = sigma_delta->offload;
+
 	ret = spi_optimize_message(sigma_delta->spi, &sigma_delta->sample_msg);
 	if (ret)
 		return ret;
@@ -545,7 +558,19 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
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
 
@@ -560,10 +585,15 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
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
@@ -678,7 +708,8 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) &&
 	    ad_sd_disable_irq(sigma_delta)) {
 		complete(&sigma_delta->completion);
-		iio_trigger_poll(sigma_delta->trig);
+		if (sigma_delta->trig)
+			iio_trigger_poll(sigma_delta->trig);
 
 		return IRQ_HANDLED;
 	}
@@ -711,17 +742,6 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
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
@@ -741,14 +761,33 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
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
@@ -768,12 +807,29 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
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
@@ -836,6 +892,20 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
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
@@ -845,3 +915,4 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_init, "IIO_AD_SIGMA_DELTA");
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


