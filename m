Return-Path: <linux-iio+bounces-20806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 693BDAE25AC
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 00:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D838218989C1
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF62246BCD;
	Fri, 20 Jun 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RTmqVQm6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D5261581
	for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458101; cv=none; b=rXq2409YRiLY/KjpZA6I0/fCT8PpnOiUaSfbqOm2S+55u/h6oNAHmhvqQRHRNu+JxoEPrtWc+VyarcBSfVk8Dz0yWKzwQCOyvXuBdaBeXoJruB16D/DUC27t3C6fb5usb4eD9xW2kN7LngVx24iU7mFCbXDYUUEdTrlPkFa+cQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458101; c=relaxed/simple;
	bh=IbUsb0IIrRbh86CcQ9q0Bs053cQYEkTsgXdxSwZMBi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivc7/PVKyMG0IsFbHuEBey0iOY7ZBf+KDNMU9Ly4yAPQcC7fh9wKPxexhEC3c+2nst0cWT7MWp2tQV76CwjJuK3sXkRB/XJ5/beTInVCZUS0eeXMCbbZnJE8hpMDQ3/mhIxn2907LTfthZ1U7AlQ77JDTIP40v+3IdNH2ZpzRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RTmqVQm6; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-735a8be4ea9so629425a34.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750458097; x=1751062897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTBvz5OHgnYilXTL9sKwLw3ZA7PkxwmvAPdMSwI1B94=;
        b=RTmqVQm65fB0/Air51ZXWggjZeFU29HExx/zMQJldzKK4/ld9+JfUNZzBW+EbvDP8y
         XUNZ1cHjQy4zH5OTo0IaZq1b4DPbTJGRAoNqk4OUTSYLFEvsKYCc5fugs6bvhm6ujqP/
         gBYhU+HrHMEB5xAgZUCAEDKdB5oug63xKx5SXrL+289jMqJosuxWtmrWtILMIqedV3qj
         uqLyz+1L68M/8PZGMW8KMHVt7tXVXGTx3CQ9Z9/PmojG49L/EWhOMHD3Vt9R+VOmXzGJ
         zeCaVjd/7DtMHHBqNZ6crD2UyM+zoUDX6i9IZ78yjAucn50TnJaaimpF3x/QGwgrFJFg
         PDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458097; x=1751062897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTBvz5OHgnYilXTL9sKwLw3ZA7PkxwmvAPdMSwI1B94=;
        b=hbSHNLFABxOwl4QB2gC+m+KNCteN/zna74meiAPBFiyfTOphqPR0+lkNzqUfiDamG6
         gQTpEEqXq9IxCjpqOEbWHe8+8+hqgJHnQhYt6+dVHqZOjQ+T/Mll3SlmEd3XGaS/TRpy
         BJVzrtXVOiCj1GH9LBhdeeOwDHIIfKHnR9jTfjZKb7zC6bFPHfSwkdhikVdxSexVZJxh
         CCgFhyhs5d+/TBPQ5BJ6yUpgLolLo95emFEXDpS1EEDWtKoRF0lU6NxWv4vZiO6aZUhv
         kMvIklsI7/DfbSurvZoX7gAahFrauAs6mxyf2IbwpwZCXfzVid3uDqM/Ktjuu7TyTsli
         0zIQ==
X-Gm-Message-State: AOJu0Yx9t5Q3k2bx86lydliSEco9wtM4WQGefvWOTIhuVXrxfwjcuJOz
	VUq2vO8tmKQrIAJocE/3deUE7PHlJbQT/uIf6yPzteOmsKjk/OJl+xIpKe9+C3oBJdo=
X-Gm-Gg: ASbGncuyAiV5tXQnQaKQrQds/r+3kGKByhvujU+URXwNUQpPU25lJC1+w0wxlZORSjA
	CTkn34XTCNqRA/V3u67aRvCtpA/g0sUMUCAIessAEYCZeEnXC1meAOnIUkhkpMF584NIkBAPmec
	YKumn3lnzyM1u+0QbYeQyat3QSv6jckqDZq/aCrcat2A7WOHv/z6f36vq23VP4slAPXWBxThyKS
	Au/EuDmFGHH6llLC7PCIQL3R+xu8Ad/zzA3EPXUlCm7bnD8sOgbnZ9l8UX68XAUHURIyEIIbMV9
	wviNQI7ddMoJVXasLsATgh4ZjwA0jjYopMxqaNwO2EV/zyAZAgF/5sNpZxVT+hGyYhaa
X-Google-Smtp-Source: AGHT+IExoXWKwinwKDXq3Vo+jK8Oj/C9dDlKCw/jO6YruhoWC/nvZZXKjVbM4r23Zba1ujtBTZZ/DQ==
X-Received: by 2002:a05:6870:6c05:b0:2cc:3d66:b6ea with SMTP id 586e51a60fabf-2eeee62f882mr3489259fac.34.1750458097025;
        Fri, 20 Jun 2025 15:21:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c4bf:cf27:203c:f8b0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ef481fe06esm7561fac.35.2025.06.20.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:21:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Jun 2025 17:20:14 -0500
Subject: [PATCH 8/9] iio: adc: ad_sigma_delta: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11663;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=IbUsb0IIrRbh86CcQ9q0Bs053cQYEkTsgXdxSwZMBi4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoVd7QIEkpAm8At8ewr1QJ5Q4JTRXtrGFfKuABn
 btA2SOVrXqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaFXe0AAKCRDCzCAB/wGP
 wO8hCACCwizbe0fpq3oB952erC2Os8cWTEUSeYu0/ZQllThL5X6FAKGEMZAZHK/qxP8InCOZB+U
 XGUs3LgDG2RH9oKE0YX4vPB0UHKUS7dpt+wshQgUgdVW7x4nEEbINSrEJPaaoCg+O0SmwkKWYeP
 0Ui0jFgpTNxSfKub+Ltqei9sVbx3CI708zVkeD/q1f7jDixv0VjuQd0bEKasMPeS2EadpOKBD7+
 k+M5tN1FoWfvo17YAV5iXRRqyHzkL9lRr7zGEsVFuWiE7BTjkdRLX9YWhmhwLrG5c5finf9DkqG
 xWcV5TzJwhfWjJHm0AOD5tgngAgUpzca0XHZ63HGq8pibzdm
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
 drivers/iio/adc/ad_sigma_delta.c       | 160 +++++++++++++++++++++++----------
 include/linux/iio/adc/ad_sigma_delta.h |  14 +++
 2 files changed, 129 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a9b97f5d4107a2e1bb74877d30403445e9b04a44..449b0756be96d3f864a6e7f070467ad7311bf7d5 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -14,11 +14,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/adc/ad_sigma_delta.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -460,8 +462,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	struct spi_transfer *xfer = sigma_delta->sample_xfer;
-	unsigned int i, slot, samples_buf_size;
-	unsigned int channel, scan_size;
+	unsigned int i, slot, channel;
 	u8 *samples_buf;
 	int ret;
 
@@ -489,23 +490,33 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
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
 
-	samples_buf_size = ALIGN(slot * scan_type->storagebits, 8);
-	samples_buf_size += sizeof(int64_t);
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
-	xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
-	xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
+		samples_buf_size = ALIGN(slot * scan_type->storagebits, 8);
+		samples_buf_size += sizeof(int64_t);
+		samples_buf = devm_krealloc(&sigma_delta->spi->dev,
+					    sigma_delta->samples_buf,
+					    samples_buf_size, GFP_KERNEL);
+		if (!samples_buf)
+			return -ENOMEM;
+
+		sigma_delta->samples_buf = samples_buf;
+		scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
+
+		xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
+		xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
+	}
 	xfer[1].cs_change = 1;
 
 	if (sigma_delta->info->has_registers) {
@@ -521,6 +532,8 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 						&xfer[1], 1);
 	}
 
+	sigma_delta->sample_msg.offload = sigma_delta->offload;
+
 	ret = spi_optimize_message(sigma_delta->spi, &sigma_delta->sample_msg);
 	if (ret)
 		return ret;
@@ -537,7 +550,19 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
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
 
@@ -552,10 +577,15 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
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
@@ -670,7 +700,8 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) &&
 	    ad_sd_disable_irq(sigma_delta)) {
 		complete(&sigma_delta->completion);
-		iio_trigger_poll(sigma_delta->trig);
+		if (sigma_delta->trig)
+			iio_trigger_poll(sigma_delta->trig);
 
 		return IRQ_HANDLED;
 	}
@@ -703,17 +734,6 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
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
@@ -733,14 +753,33 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
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
@@ -760,12 +799,29 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
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
@@ -828,6 +884,20 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
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


