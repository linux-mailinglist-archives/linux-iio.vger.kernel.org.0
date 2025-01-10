Return-Path: <linux-iio+bounces-14095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F517A08DEE
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F8F188200C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1920D50C;
	Fri, 10 Jan 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dZyjTiU4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2D20CCF8
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504761; cv=none; b=u1LaRVfS2vyJx5P7s+/Em8sL0Qq8H/+FjeMRNOLBAaovsn6hA/ZUIRxlhM8Wr+ta/O8CWl8JI6Kvu1wydXZDc56tywSoi8NpGjj2N4h06O41DFQVDrbeGg6B02jrw5k/ZHs1R5mNE0e5d/HF9eAAAQ0kGFSLOc7rRWG8/jmunrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504761; c=relaxed/simple;
	bh=eLmsRz2kU/VsBTLT7cWoZsFdHlw9EcfCKFfQ7MuoN+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxAixvXnYU3F5TlL9zCZ4mbgrnqyQLDwsjdrXTXZ+Mv5njz3X4gtobkx0SSjjqnmbHSWUIG/Kv5uB1ZKYpb4tDRvpYyApKT3tnsD7LNLXYWMasZUyVEv39biR3a33LVqY9CV05CmrZSHx5TF5qaLvImAhTJjlylHtwiNd8EB3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dZyjTiU4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862f32a33eso859494f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504758; x=1737109558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9csxIoZsnXnkQ0kjyXCuv17Gc+ddK30W2l+lJEIpIR8=;
        b=dZyjTiU4aSwBraDinzbgQw1mkYpDMMS30dJm3IjlR/e6OZJpWrxG0NoqcVLtciTS18
         dgA1iogKfbYxmdh3I9k9Y8dwZzjKAon0VSq9XBCoSNMNsWODVTKoQp4bP8gd6u7Xp0rt
         xmj+xTNvOzfk8AsQS4kD4gX2Y4VyV7n7FoJCcPMU0DA9yXPKjHtQ3EmQygjkwATE1S6m
         iM2GB05JMwQ+yCiw2jqu//jnzat8ilJNjUSeW8ZjaSGXdyj6k6NpN55OYJEkI6zh9rcL
         49DQU8maEKhkc4+ngnvL3OiOcwQkkECbgyLM9zaHM6o/9CVHdNqFaf3DesXoeRdJKuuc
         7c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504758; x=1737109558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9csxIoZsnXnkQ0kjyXCuv17Gc+ddK30W2l+lJEIpIR8=;
        b=rPKcBnG87zuWQTIANgJPBgWk0YvBC/NlAutKyeQjJ+L93LhXiRHAjREuSEyVvxVSOB
         y+Izuy+CtAJk/1PtewWZAWWbJvZg2ARYCLNjKNTFnm1NJK7LE+ZUFVoPjb/dGOu3/vuy
         cFOl43cSZxg8kwRQHrF9/Tsc3NGCer90SvSS+/DrYMKu7iVUaJzkEpXuL5Y8BGFtY/k3
         YNfCVYMMobxS941hl0dvZ2VpuJzvxoaLV+Ye55bfsqrD/m65eifA+DxWo/JyPr6gUtg/
         Pgq4jihTHZ0/oiXqnsSinp9rqSE2vsidCyp/iigrjNIWj1197qOa854opiqxuWUDyZYJ
         qWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEesWuwYlfvUSXIPRuiQA585SdhYP7sB/wlUHTh2aniHsBrU5CkpwqsCsHozXa3ILtgEAONROBR3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXH/N2QViso/Y7Rll4X9UFb4Ae4KFPPoMQ87lB4ZH/ARvTajVc
	V71u8ptyiMkdjuGhtzEYtn+HeM2PM+arTxxZVQY6jbSMTs6GnV86hUELZOdhRio=
X-Gm-Gg: ASbGncs+bX08rio4AMXrijW4ds0QWX7Xazq8AOMo+uQHOuoOGVm/zM2z826ay7a4peU
	3Uizs0OeXcTcgLlA8mjO6PGyC4+vJBmgLURWxS/cVsiiqKKYJXBKiIUZhqCA2rHOiOYQA3alvXH
	VlzWALt1JycxHXdOOuu7n2rty+kRg9w+oSkHEfmqXVQnXFdThkfcnLE8FxYyb9DICp3hPpvY6kC
	waPbs0yLXbn0hyoHXzV75gp6O4RNc9SXSx8gHLNVuQyy0N6uzFwOaZRQR8=
X-Google-Smtp-Source: AGHT+IG3fecs8hj3Sm7/qV9LSBCo9KPWT3dpQPzpENKp6Hw42lpcZG9kE3jbZ4hxYhurp6vUcQ6Oxw==
X-Received: by 2002:a05:6000:4607:b0:386:380d:2cac with SMTP id ffacd0b85a97d-38a8730a7bdmr8198024f8f.26.1736504757608;
        Fri, 10 Jan 2025 02:25:57 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:57 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:20 +0100
Subject: [PATCH v3 8/9] iio: dac: ad3552r-hs: add ad3541/2r support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-8-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

A new FPGA HDL has been developed from ADI to support ad354xr
devices.

Add support for ad3541r and ad3542r with following additions:

- use common device_info structures for hs and non hs drivers,
- DMA buffering, use DSPI mode for ad354xr and QSPI for ad355xr,
- change sample rate to respect number of lanes.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-common.c |   4 +
 drivers/iio/dac/ad3552r-hs.c     | 225 ++++++++++++++++++++++++++++++++-------
 drivers/iio/dac/ad3552r.h        |   3 +
 3 files changed, 195 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index ded90bf57baf..b8807e54fa05 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -42,6 +42,7 @@ const struct ad3552r_model_data ad3541r_model_data = {
 	.ranges_table = ad3542r_ch_ranges,
 	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
 	.requires_output_range = true,
+	.num_spi_data_lanes = 2,
 };
 EXPORT_SYMBOL_NS_GPL(ad3541r_model_data, "IIO_AD3552R");
 
@@ -52,6 +53,7 @@ const struct ad3552r_model_data ad3542r_model_data = {
 	.ranges_table = ad3542r_ch_ranges,
 	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
 	.requires_output_range = true,
+	.num_spi_data_lanes = 2,
 };
 EXPORT_SYMBOL_NS_GPL(ad3542r_model_data, "IIO_AD3552R");
 
@@ -62,6 +64,7 @@ const struct ad3552r_model_data ad3551r_model_data = {
 	.ranges_table = ad3552r_ch_ranges,
 	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
 	.requires_output_range = false,
+	.num_spi_data_lanes = 4,
 };
 EXPORT_SYMBOL_NS_GPL(ad3551r_model_data, "IIO_AD3552R");
 
@@ -72,6 +75,7 @@ const struct ad3552r_model_data ad3552r_model_data = {
 	.ranges_table = ad3552r_ch_ranges,
 	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
 	.requires_output_range = false,
+	.num_spi_data_lanes = 4,
 };
 EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");
 
diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index bfb6228c9b9b..4600a9e84dfc 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -19,6 +19,31 @@
 #include "ad3552r.h"
 #include "ad3552r-hs.h"
 
+/*
+ * Important notes for register map access:
+ * ========================================
+ *
+ * Register address space is divided in 2 regions, primary (config) and
+ * secondary (DAC). Primary region can only be accessed in simple SPI mode,
+ * with exception for ad355x models where setting QSPI pin high allows QSPI
+ * access to both the regions.
+ *
+ * Due to the fact that ad3541/2r do not implement QSPI, for proper device
+ * detection, HDL keeps "QSPI" pin level low at boot (see ad3552r manual, rev B
+ * table 7, pin 31, digital input). For this reason, actually the working mode
+ * between SPI, DSPI and QSPI must be set via software, configuring the target
+ * DAC appropriately, together with the backend API to configure the bus mode
+ * accordingly.
+ *
+ * Also, important to note that none of the three modes allow to read in DDR.
+ *
+ * In non-buffering operations, mode is set to simple SPI SDR for all primary
+ * and secondary region r/w accesses, to avoid to switch the mode each time DAC
+ * register is accessed (raw accesses, r/w), and to be able to dump registers
+ * content (possible as non DDR only).
+ * In buffering mode, driver sets best possible mode, D/QSPI and DDR.
+ */
+
 struct ad3552r_hs_state {
 	const struct ad3552r_model_data *model_data;
 	struct gpio_desc *reset_gpio;
@@ -27,6 +52,8 @@ struct ad3552r_hs_state {
 	bool single_channel;
 	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
 	struct ad3552r_hs_platform_data *data;
+	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read values. */
+	u32 config_d;
 };
 
 static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
@@ -56,15 +83,19 @@ static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		/*
-		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
-		 * considered always on (considering buffering mode always).
+		 * Using a "num_spi_data_lanes" variable since ad3541/2 have
+		 * only DSPI interface, while ad355x is QSPI. Then using 2 as
+		 * DDR mode is considered always on (considering buffering
+		 * mode always).
 		 */
 		*val = DIV_ROUND_CLOSEST(st->data->bus_sample_data_clock_hz *
-					 4 * 2, chan->scan_type.realbits);
+					 st->model_data->num_spi_data_lanes * 2,
+					 chan->scan_type.realbits);
 
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_RAW:
+		/* For RAW accesses, stay always in simple-spi. */
 		ret = st->data->bus_reg_read(st->back,
 				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
 				val, 2);
@@ -93,6 +124,7 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		/* For RAW accesses, stay always in simple-spi. */
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
 			return st->data->bus_reg_write(st->back,
 				    AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
@@ -104,6 +136,42 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad3552r_hs_set_bus_io_mode_hs(struct ad3552r_hs_state *st)
+{
+	int bus_mode;
+
+	if (st->model_data->num_spi_data_lanes == 4)
+		bus_mode = AD3552R_IO_MODE_QSPI;
+	else
+		bus_mode = AD3552R_IO_MODE_DSPI;
+
+	return st->data->bus_set_io_mode(st->back, bus_mode);
+}
+
+static int ad3552r_hs_set_target_io_mode_hs(struct ad3552r_hs_state *st)
+{
+	int mode_target;
+
+	/*
+	 * Best access for secondary reg area, QSPI where possible,
+	 * else as DSPI.
+	 */
+	if (st->model_data->num_spi_data_lanes == 4)
+		mode_target = AD3552R_QUAD_SPI;
+	else
+		mode_target = AD3552R_DUAL_SPI;
+
+	/*
+	 * Better to not use update here, since generally it is already
+	 * set as DDR mode, and it's not possible to read in DDR mode.
+	 */
+	return st->data->bus_reg_write(st->back,
+				AD3552R_REG_ADDR_TRANSFER_REGISTER,
+				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
+					   mode_target) |
+				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
+}
+
 static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad3552r_hs_state *st = iio_priv(indio_dev);
@@ -132,6 +200,11 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
+	/*
+	 * With ad3541/2r support, QSPI pin is held low at reset from HDL,
+	 * streaming start sequence must respect strictly the order below.
+	 */
+
 	/* Primary region access, set streaming mode (now in SPI + SDR). */
 	ret = ad3552r_qspi_update_reg_bits(st,
 					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
@@ -139,48 +212,106 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
+	/*
+	 * Set target loop len, 0x2c 0r 0x2a, descending loop, and keeping loop
+	 * len value so it's not cleared hereafter when enabling streaming mode
+	 * (cleared by CS_ up).
+	 */
+	ret = ad3552r_qspi_update_reg_bits(st,
+		AD3552R_REG_ADDR_TRANSFER_REGISTER,
+		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
+		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
+	if (ret)
+		goto exit_err_streaming;
+
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_STREAM_MODE,
 				      loop_len, 1);
 	if (ret)
-		return ret;
+		goto exit_err_streaming;
 
-	/* Inform DAC chip to switch into DDR mode */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-					   AD3552R_MASK_SPI_CONFIG_DDR,
-					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
+	/* Setting DDR now, caching current config_d. */
+	ret = st->data->bus_reg_read(st->back,
+				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				     &st->config_d, 1);
 	if (ret)
-		return ret;
+		goto exit_err_streaming;
+
+	st->config_d |= AD3552R_MASK_SPI_CONFIG_DDR;
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				      st->config_d, 1);
+	if (ret)
+		goto exit_err_streaming;
 
-	/* Inform DAC IP to go for DDR mode from now on */
 	ret = iio_backend_ddr_enable(st->back);
-	if (ret) {
-		dev_err(st->dev, "could not set DDR mode, not streaming");
-		goto exit_err;
-	}
+	if (ret)
+		goto exit_err_ddr_mode_target;
+
+	/*
+	 * From here onward mode is DDR, so reading any register is not possible
+	 * anymore, including calling "ad3552r_qspi_update_reg_bits" function.
+	 */
+
+	/* Set target to best high speed mode (D or QSPI). */
+	ret = ad3552r_hs_set_target_io_mode_hs(st);
+	if (ret)
+		goto exit_err_ddr_mode;
+
+	/* Set bus to best high speed mode (D or QSPI). */
+	ret = ad3552r_hs_set_bus_io_mode_hs(st);
+	if (ret)
+		goto exit_err_bus_mode_target;
 
+	/*
+	 * Backend setup must be done now only, or related register values will
+	 * be disrupted by previous bus accesses.
+	 */
 	ret = iio_backend_data_transfer_addr(st->back, val);
 	if (ret)
-		goto exit_err;
+		goto exit_err_bus_mode_target;
 
 	ret = iio_backend_data_format_set(st->back, 0, &fmt);
 	if (ret)
-		goto exit_err;
+		goto exit_err_bus_mode_target;
 
 	ret = iio_backend_data_stream_enable(st->back);
 	if (ret)
-		goto exit_err;
+		goto exit_err_bus_mode_target;
 
 	return 0;
 
-exit_err:
-	ad3552r_qspi_update_reg_bits(st,
-				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-				     AD3552R_MASK_SPI_CONFIG_DDR,
-				     0, 1);
+exit_err_bus_mode_target:
+	/* Back to simple SPI, not using update to avoid read. */
+	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_TRANSFER_REGISTER,
+				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
+					   AD3552R_SPI) |
+				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
+
+	/*
+	 * Back bus to simple SPI, this must be executed together with above
+	 * target mode unwind, and can be done only after it.
+	 */
+	st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
 
+exit_err_ddr_mode:
 	iio_backend_ddr_disable(st->back);
 
+exit_err_ddr_mode_target:
+	/*
+	 * Back to SDR. In DDR we cannot read, whatever the mode is, so not
+	 * using update.
+	 */
+	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, 1),
+				1);
+
+exit_err_streaming:
+	/* Back to single instruction mode, disabling loop. */
+	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				AD3552R_MASK_SINGLE_INST |
+				AD3552R_MASK_SHORT_INSTRUCTION, 1);
+
 	return ret;
 }
 
@@ -193,11 +324,22 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	/* Inform DAC to set in SDR mode */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-					   AD3552R_MASK_SPI_CONFIG_DDR,
-					   0, 1);
+	/*
+	 * Set us to simple SPI, even if still in ddr, so to be able to write
+	 * in primary region.
+	 */
+	ret = st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
+	if (ret)
+		return ret;
+
+	/*
+	 * Back to SDR (in DDR we cannot read, whatever the mode is, so not
+	 * using update).
+	 */
+	st->config_d &= ~AD3552R_MASK_SPI_CONFIG_DDR;
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				      st->config_d, 1);
 	if (ret)
 		return ret;
 
@@ -205,6 +347,17 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Back to simple SPI for secondary region too now, so to be able to
+	 * dump/read registers there too if needed.
+	 */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_TRANSFER_REGISTER,
+					   AD3552R_MASK_MULTI_IO_MODE,
+					   AD3552R_SPI, 1);
+	if (ret)
+		return ret;
+
 	/* Back to single instruction mode, disabling loop. */
 	ret = ad3552r_qspi_update_reg_bits(st,
 					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
@@ -319,6 +472,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
+	/* HDL starts with DDR enabled, disabling it. */
 	ret = iio_backend_ddr_disable(st->back);
 	if (ret)
 		return ret;
@@ -352,6 +506,8 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 			 "Chip ID mismatch, detected 0x%x but expected 0x%x\n",
 			 id, st->model_data->chip_id);
 
+	dev_dbg(st->dev, "chip id %s detected", st->model_data->model_name);
+
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
 				      AD3552R_MASK_RESET_STATUS, 1);
@@ -364,14 +520,6 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
-	ret = st->data->bus_reg_write(st->back,
-				AD3552R_REG_ADDR_TRANSFER_REGISTER,
-				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
-					   AD3552R_QUAD_SPI) |
-				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
-	if (ret)
-		return ret;
-
 	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
 	if (ret)
 		return ret;
@@ -528,6 +676,9 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ad3552r_hs_of_id[] = {
+	{ .compatible = "adi,ad3541r", .data = &ad3541r_model_data },
+	{ .compatible = "adi,ad3542r", .data = &ad3542r_model_data },
+	{ .compatible = "adi,ad3551r", .data = &ad3551r_model_data },
 	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
 	{ }
 };
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index 3dc8d1d9c0f9..768fa264d39e 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -132,6 +132,8 @@
 
 #define AD3552R_MAX_RANGES	5
 #define AD3542R_MAX_RANGES	5
+#define AD3552R_SPI		0
+#define AD3552R_DUAL_SPI	1
 #define AD3552R_QUAD_SPI	2
 
 extern const struct ad3552r_model_data ad3541r_model_data;
@@ -153,6 +155,7 @@ struct ad3552r_model_data {
 	const s32 (*ranges_table)[2];
 	int num_ranges;
 	bool requires_output_range;
+	int num_spi_data_lanes;
 };
 
 struct ad3552r_ch_data {

-- 
2.47.0


