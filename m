Return-Path: <linux-iio+bounces-21212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F66AF05CC
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1CAA7B29F4
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CF3093AD;
	Tue,  1 Jul 2025 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tUlvfjdm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C182FEE3D
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405982; cv=none; b=jAhsIObSjlSvehJKr/a5S2ZdCppAbEFb529zOv1jYCCOT67B5jNVLARWYZXK002NQNh/cjhNjrFAFElWTMnrUCxZVx3JzOEvDqWFAiQHUrFZHT1NICPBY6iAmBOgRnTF4QbT7drbXmFxspXY9Q4H9QR7UsJ8Hw+TxlKwuVnbaNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405982; c=relaxed/simple;
	bh=C5gxKS3jTVgzKfsZ8e1RL24XN2xLOEjjLOcnNVrTiz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lD4JNoBJqCeYlg2/NqSpYAFeC15Cz8+4sITdlmKmCAA8dRJbSzkjLwRnptmfLa27iko+v2eKDYuYQtyVty0ZAGqkU6MJdClsZLby/Qzrmv5vK8GyyUHOEzBknh0Ol56PtxILHf0GUbQLzuicqPE5TNHTHDBkyJ5avxAkkzIpvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tUlvfjdm; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40b71debe9aso786380b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405979; x=1752010779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dNsRfhxESTJ1ulyXjxpfIFM4GNzQZzgqJncfLY7uiU=;
        b=tUlvfjdmvGL6epEJr9lN6+c7b8K8xvl3c77P2t4BAP+aS48AK+cNKlObtwUGCXLOxX
         yJWYVOZNo4UpH4ttBmqQf4PCBGwLmLCY9USFvLrtvVshfIUGyMn+6+Tn3SgS5EEADfIn
         1UdfblkBokvm8OgT/rMqAIcdLreopftTFyiH4YYne+DuLY9mZNkaX8v8OvbJlpjjj6Jf
         xwKHEERXMP83UeCTsOwOWrVqb5ANTkn5kUtP46D3Fb/PApa7CVxKsRHNR+Bm9SjerfbO
         YGfELzkqSz3caXFAGvSJ+dSWHmNDGvp2VI6M2kJm/0zctx5bC3EHx1AU3nuMCnma5UPw
         xxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405979; x=1752010779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dNsRfhxESTJ1ulyXjxpfIFM4GNzQZzgqJncfLY7uiU=;
        b=qBHxpXGu9IlQ9aQrLE6YKtR5NJWz0BNwMLGmK2C5OKLp0G8YaIujYIa5BOowN12FiJ
         vOAGf1aGTrQycKBAiW+FPVGnLi+I5m3lNO4agTknkPj3Wa+E8y9a1/R241jHdJI6kmtC
         I7F1eZ+x+Es31rtQkNG3XaKobSngPF58v85btovVIdWS20W+yu+lKvNwecCbcnnZlqSG
         dJW2XJ5ieNuApayjl8dcBmYBaDVpvi+x6qonzx9Z12yBc5Z7n1J3ouRe77dl5HGtk6qb
         s7foSkHvXnjhMmSG1h61kkKOipIzKC1m4gTRr4r1+Bbz+//CidSPhM1kCI1hsGQCSk0v
         R0FA==
X-Gm-Message-State: AOJu0Yzq5CvotpyWx5ooOeWTL5AQSsrZ5gkFesj1F7kk+EUmhRcFbdJs
	W8GE5gNUC4Hco6RG2qwD/iYgwctaKRp1tLxBlKmggfY6W7FpYmO2+z7+ic9iGLkX37c=
X-Gm-Gg: ASbGncuGRewTeeC7l8NuGIxjuugCvSTvf1H6efNeOCkS8CF/Abhr9wzjk7iNUaKdTjT
	KKJjfdLO+c1NIfAopgAFj2FKjiYuUZHrOEzt5kSmi6MG+rGujEWJmB8S0huTtotqjlh38/Oo6Et
	VFlqExzcY96SDfCMZGQwWPbe8lJy5nu+GgNsVnuuQA7ndX3dsuvyyuApjugSd4N87OxrvunoWtb
	Cz5i0Maz8d2OXdT4sBUPnrJrKKUg7hmwhIb0KJlN46pNoZXMtHQossWxbQfB9y8clxeu9u8hH26
	7HTvXw8W6D+TTspUwQiVdkEDUfVpib4NI/1t7Uvh9nC9xTc+0QHfWugAPNF+fAxsUeKr
X-Google-Smtp-Source: AGHT+IF2mPCAO9B4RH+Pk2P7QDjXh8JA0YwcU32FcC3oDgcwmaLUwh9y/9KVk9LuRqWbIHchNmSxow==
X-Received: by 2002:a05:6808:8950:b0:40a:d024:993b with SMTP id 5614622812f47-40b888180e1mr265485b6e.22.1751405979093;
        Tue, 01 Jul 2025 14:39:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:56 -0500
Subject: [PATCH v3 08/12] iio: adc: ad_sigma_delta: use
 spi_optimize_message()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-8-42abb83e3dac@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5695; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=C5gxKS3jTVgzKfsZ8e1RL24XN2xLOEjjLOcnNVrTiz4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFVvZqfJaoWTIme+NA4sQVgYjMFydXFnH5zE/
 MoV/96EwTSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVbwAKCRDCzCAB/wGP
 wNmICACT8FDGHvOGIV0tIDWHCXJp2C3wYrn3BARLAwYgq4DxANWCn5a3fBLMQ3lGFEJ1scbKib1
 zACXKI/x1YwmlqDtKc6tIuRtxM9s1cfYcPq4t9lLGE4j4NzU4Hr2agMx56vE4jpf3LUUTvLaaEl
 sBSQ2JXrWkzE+LXOJ4IvJaDRRPa86wNXlE9Bvq4CtcVIZdEoeXaQsJYhcurfLp8FlfSAbXo3UOW
 u/vIN3AsOFE1uHNLs70kRVwmC/VN6K6T9w/2C+PASUpA609d1dh24HvaSvPzPBWvuza+AWZ+cuv
 8vI05h8l2RstdV/XrtccMn7D3YK4+Ilg5RIcjqvIgOWnu3L9
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use spi_optimize_message() to improve the performance of buffered reads.

By setting up the SPI message and pre-optimizing it in the buffer
postenable callback, we can reduce overhead during each sample read.

A rough estimate shows that this reduced the CPU usage of the interrupt
handler thread from 22% to 16% using an EVAL-AD4112ARDZ board on a
DE10-Nano (measuring a single channel at the default 6.2 kHz sample
rate).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 72 ++++++++++++++++------------------
 include/linux/iio/adc/ad_sigma_delta.h |  3 ++
 2 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ce549775ac3d68fd11e660b6b993ac661301756a..124c42e19f2e25723b67ea38f7d016f00ff91342 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -466,8 +466,9 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
+	struct spi_transfer *xfer = sigma_delta->sample_xfer;
 	unsigned int i, slot, samples_buf_size;
-	unsigned int channel;
+	unsigned int channel, scan_size;
 	u8 *samples_buf;
 	int ret;
 
@@ -510,6 +511,28 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	sigma_delta->samples_buf = samples_buf;
+	scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
+	/* For 24-bit data, there is an extra byte of padding. */
+	xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
+	xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
+	xfer[1].cs_change = 1;
+
+	if (sigma_delta->info->has_registers) {
+		xfer[0].tx_buf = &sigma_delta->sample_addr;
+		xfer[0].len = 1;
+
+		ad_sd_set_read_reg_addr(sigma_delta,
+					sigma_delta->info->data_reg ?: AD_SD_REG_DATA,
+					&sigma_delta->sample_addr);
+		spi_message_init_with_transfers(&sigma_delta->sample_msg, xfer, 2);
+	} else {
+		spi_message_init_with_transfers(&sigma_delta->sample_msg,
+						&xfer[1], 1);
+	}
+
+	ret = spi_optimize_message(sigma_delta->spi, &sigma_delta->sample_msg);
+	if (ret)
+		return ret;
 
 	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
@@ -529,6 +552,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 err_unlock:
 	spi_bus_unlock(sigma_delta->spi->controller);
+	spi_unoptimize_message(&sigma_delta->sample_msg);
 
 	return ret;
 }
@@ -550,7 +574,10 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 
 	ad_sigma_delta_disable_all(sigma_delta);
 	sigma_delta->bus_locked = false;
-	return spi_bus_unlock(sigma_delta->spi->controller);
+	spi_bus_unlock(sigma_delta->spi->controller);
+	spi_unoptimize_message(&sigma_delta->sample_msg);
+
+	return 0;
 }
 
 static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
@@ -560,50 +587,19 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	u8 *data = sigma_delta->rx_buf;
-	unsigned int transfer_size;
 	unsigned int sample_size;
 	unsigned int sample_pos;
 	unsigned int status_pos;
 	unsigned int reg_size;
-	unsigned int data_reg;
+	int ret;
 
 	reg_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
+	/* For 24-bit data, there is an extra byte of padding. */
+	status_pos = reg_size + (reg_size == 3 ? 1 : 0);
 
-	if (sigma_delta->info->data_reg != 0)
-		data_reg = sigma_delta->info->data_reg;
-	else
-		data_reg = AD_SD_REG_DATA;
-
-	/* Status word will be appended to the sample during transfer */
-	if (sigma_delta->status_appended)
-		transfer_size = reg_size + 1;
-	else
-		transfer_size = reg_size;
-
-	switch (reg_size) {
-	case 4:
-	case 2:
-	case 1:
-		status_pos = reg_size;
-		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[0]);
-		break;
-	case 3:
-		/*
-		 * Data array after transfer will look like (if status is appended):
-		 * data[] = { [0][sample][sample][sample][status] }
-		 * Keeping the first byte 0 shifts the status position by 1 byte to the right.
-		 */
-		status_pos = reg_size + 1;
-
-		/* We store 24 bit samples in a 32 bit word. Keep the upper
-		 * byte set to zero. */
-		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
-		break;
-
-	default:
-		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
+	ret = spi_sync_locked(sigma_delta->spi, &sigma_delta->sample_msg);
+	if (ret)
 		goto irq_handled;
-	}
 
 	/*
 	 * For devices sampling only one channel at
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 5056677c9941afadc2383febbcafeb02e23a4f44..2037bb68b44115681ff48f66b580b63f50c2ea9e 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -105,6 +105,8 @@ struct ad_sigma_delta {
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
 	unsigned int		*slots;
+	struct spi_message	sample_msg;
+	struct spi_transfer	sample_xfer[2];
 	u8			*samples_buf;
 
 	/*
@@ -116,6 +118,7 @@ struct ad_sigma_delta {
 	 */
 	u8				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
 	u8				rx_buf[16] __aligned(8);
+	u8				sample_addr;
 };
 
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,

-- 
2.43.0


