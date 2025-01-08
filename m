Return-Path: <linux-iio+bounces-14033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E1AA06374
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ECF3A6A04
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB762036E5;
	Wed,  8 Jan 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yls+ca7I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAF202F97
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357445; cv=none; b=HUhQgcNEn+DgDTwwFJ/iiR9blEDoAM0NRHEwW6LdJ9VbRMw/+Ty7nTBmZOg3j0XREMB8RELLuCyR5AiyQwopbSZATsxCwwxZccq6a0bbHdgajceXnFYSDopi4kAnAsN2qmv8yWru9uvhSKCcgZGmhLHxToANyvk44p5dI7x1zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357445; c=relaxed/simple;
	bh=AhVYyfcJyUQuknu+k6SdzE03Oz9o2XZyVIS6TgjYN9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lu4+Kp4Ht7tX6F0VZGMtAuJn/KO4gkWK57flMwqp29RVqpwCSTlpb1L/PjUoUBX7GwHt15C0UTkjdqIcZEb3sgWOiIHMWehfuM63wSmNyWNd6RPbfdHBi5hddM/SboU/sapkYZdNtGEmIb+AZQQeAR2cZu16Hj+UsesSaYIjOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yls+ca7I; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so42568f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357442; x=1736962242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yW2QdAEBTAIXZ0FwhrlcyQ2UztjJ2op9sufvOiml2fo=;
        b=yls+ca7IH+kAgA1RZj9pj4FKS3rOktfhWqa+iCwQfZo3d7mOkYAOS8aDi397ceBCTS
         4H/iwHpgcNo14MSE0djxbMWt01Gevd04Qg/owcM1t6BlQyPQi1lE7KhNw2jmN1V2oYuw
         CQqqs7upNth528bte3MbE8cP1wCM0AYIUOTu5bp+EZEW6nbMO2MRVbjmEVHiHSLKlZbr
         6eBnd+Vy8yWNkeRObu5ekjUZKbF6y4ozxNe21ahTw+JsU0NxuYVQk1c3IYRwHMwKITCK
         th5nYMB8cSkSt09i6VircdoOPPgVZTNGWrYKx/RpWAOEfq1ObZkh/YGTKzrYX7bVjTBf
         gxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357442; x=1736962242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yW2QdAEBTAIXZ0FwhrlcyQ2UztjJ2op9sufvOiml2fo=;
        b=hTGuJcpoF+VKb7ZXMiizVqgn6UeOjj+F/6ZKinRXxDn40AzsQFGx5Omnm7mG50tX6x
         YEgSJoKHsMLf8884V2UBRUxq12Z2c0uTM+/oGY2umjKIHGBfHzpL9Nmid7hNGCIV+KjH
         xvsq1heeDUXDYdxf8Ahbr3pX/HvrJ9mvA7MpsmamTuG5xi1CzEPLt/TZRTeYEYqqjA/w
         bZ50JNeqK8U1CB9Glio2JIclIln35m3oHZlv3G4p7lY2HtuoEnGxfKTq/l2eKl5B/f9+
         WFR5asylK5RYJeDVotw6ltN0hOWqAZyPdxSObspuD4yhFvcvI4anm2P1TdBo8TZS6lMY
         VnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX90cU4hvWRntLzvtelEl3Mwen5O7RuoWXm6hKM+MGDIWDO32MHHWW7jVwXKsTr9i8SBBr9gqYgC0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDk1FW70FtF1DwDbNvmn9PdTU9noGt3QC58PQrXqrKpyUYhhj
	vnUzrw9hSyAjhbZkaUqgebt9IxOs1po7wDH1Eyj0iBt2JYD5PuQH+zQec5Um0/8=
X-Gm-Gg: ASbGncvoUMcHap5Q3X6TKkAO+8T4lfwaKuxSanu8tB5rQCuPOWk/GerCx5CWwC326Br
	UbVxXbMQ+g0dRr0PxNZQ+/DAtq2sx3BAieYe32+Xwyw3suAH1jqa2faqNE6h9UMJqbvHP90j4AB
	XZRhUFMmPVIQB+CMLYXUWN4ckfisL+KWE2yEw1RT8apWohGLP/dMKBhdy3PmSQ7c5NXfr7y2f0g
	hyVek+kiTeYDHA09m0s1+flliDS8nLpJ2b3NMgDu6sNAyGGvDt5idaYqyw=
X-Google-Smtp-Source: AGHT+IELdA96ehkDADF185V5g/Df7b6lGEqYEK4L8hpBP5+JsHgb8jVH/uZYHGv/eMK8ObED+oHDSw==
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr2600226f8f.24.1736357441570;
        Wed, 08 Jan 2025 09:30:41 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:40 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:22 +0100
Subject: [PATCH v2 8/9] iio: dac: ad3552r-hs: add ad3541/2r support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-8-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

A new fpga HDL has been developed from ADI to support ad354xr
devices.

Add support for ad3541r and ad3542r with following additions:

- use common device_info structures for hs and non hs drivers,
- DMA buffering, use DSPI mode for ad354xr and QSPI for ad355xr,
- change samplerate to respect number of lanes.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-common.c |   4 +
 drivers/iio/dac/ad3552r-hs.c     | 240 ++++++++++++++++++++++++++++++++-------
 drivers/iio/dac/ad3552r.h        |   3 +
 3 files changed, 206 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index 36920ec95836..fa3050dc2efa 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -44,6 +44,7 @@ const struct ad3552r_model_data ad3541r_model_data = {
 	.ranges_table = ad3542r_ch_ranges,
 	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
 	.requires_output_range = true,
+	.num_spi_data_lanes = 2,
 };
 EXPORT_SYMBOL_NS_GPL(ad3541r_model_data, "IIO_AD3552R");
 
@@ -54,6 +55,7 @@ const struct ad3552r_model_data ad3542r_model_data = {
 	.ranges_table = ad3542r_ch_ranges,
 	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
 	.requires_output_range = true,
+	.num_spi_data_lanes = 2,
 };
 EXPORT_SYMBOL_NS_GPL(ad3542r_model_data, "IIO_AD3552R");
 
@@ -64,6 +66,7 @@ const struct ad3552r_model_data ad3551r_model_data = {
 	.ranges_table = ad3552r_ch_ranges,
 	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
 	.requires_output_range = false,
+	.num_spi_data_lanes = 4,
 };
 EXPORT_SYMBOL_NS_GPL(ad3551r_model_data, "IIO_AD3552R");
 
@@ -74,6 +77,7 @@ const struct ad3552r_model_data ad3552r_model_data = {
 	.ranges_table = ad3552r_ch_ranges,
 	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
 	.requires_output_range = false,
+	.num_spi_data_lanes = 4,
 };
 EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");
 
diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index bfb6228c9b9b..5995bab6a9b1 100644
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
+ * DAC appropriately, together with the backend api to configure the bus mode
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
+	 * With ad3541/2r supoport, QSPI pin is held low at reset from HDL,
+	 * streaming start sequence must respect strictly the order below.
+	 */
+
 	/* Primary region access, set streaming mode (now in SPI + SDR). */
 	ret = ad3552r_qspi_update_reg_bits(st,
 					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
@@ -139,48 +212,114 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
+	/*
+	 * Set target loop len, 0x2c 0r 0x2a, descending loop,
+	 * and keeping loop len value so it's not cleared hereafter when
+	 * enabling streaming mode (cleared by CS_ up).
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
+	/*
+	 * Registers dump for debug purposes is only possible until here,
+	 * read in primary region must be SPI SDR (DDR read is never possible,
+	 * D/QSPI SDR read in primary region is also not possible).
+	 */
+
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
+
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
 
+	/*
+	 * From here onward mode is DDR, so reading any register is not
+	 * possible anymore, including calling "ad3552r_qspi_update_reg_bits"
+	 * function.
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
+
+	/*
+	 * Backend setup must be done now only, or related register values
+	 * will be disrupted by previous bus accesses.
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
 
+	/*
+	 * Back bus to simple SPI, this must be executed together with above
+	 * target mode unwind, and can be done only after it.
+	 */
+	st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
+
+exit_err_ddr_mode:
 	iio_backend_ddr_disable(st->back);
 
+exit_err_ddr_mode_target:
+	/*
+	 * Back to SDR.
+	 * In DDR we cannot read, whatever the mode is, so not using update.
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
 
@@ -193,11 +332,22 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	/* Inform DAC to set in SDR mode */
-	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-					   AD3552R_MASK_SPI_CONFIG_DDR,
-					   0, 1);
+	/*
+	 * Set us to simple SPI, even if still in ddr, so to be able
+	 * to write in primary region.
+	 */
+	ret = st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
+	if (ret)
+		return ret;
+
+	/*
+	 * Back to SDR
+	 * (in DDR we cannot read, whatever the mode is, so not using update).
+	 */
+	st->config_d &= ~AD3552R_MASK_SPI_CONFIG_DDR;
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				      st->config_d, 1);
 	if (ret)
 		return ret;
 
@@ -205,11 +355,21 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	/* Back to single instruction mode, disabling loop. */
+	/*
+	 * Back to simple SPI for secondary region too now,
+	 * so to be able to dump/read registers there too if needed.
+	 */
 	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
-					   AD3552R_MASK_SINGLE_INST,
-					   AD3552R_MASK_SINGLE_INST, 1);
+					   AD3552R_REG_ADDR_TRANSFER_REGISTER,
+					   AD3552R_MASK_MULTI_IO_MODE,
+					   AD3552R_SPI, 1);
+	if (ret)
+		return ret;
+
+	/* Back to single instruction mode, disabling loop. */
+	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				      AD3552R_MASK_SINGLE_INST,
+				      AD3552R_MASK_SINGLE_INST, 1);
 	if (ret)
 		return ret;
 
@@ -319,6 +479,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
+	/* HDL starts with DDR enabled, disabling it. */
 	ret = iio_backend_ddr_disable(st->back);
 	if (ret)
 		return ret;
@@ -352,6 +513,8 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 			 "Chip ID mismatch, detected 0x%x but expected 0x%x\n",
 			 id, st->model_data->chip_id);
 
+	dev_info(st->dev, "chip id %s detected", st->model_data->model_name);
+
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
 				      AD3552R_MASK_RESET_STATUS, 1);
@@ -364,14 +527,6 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
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
@@ -528,6 +683,9 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ad3552r_hs_of_id[] = {
+	{ .compatible = "adi,ad3541r", .data = &ad3541r_model_data },
+	{ .compatible = "adi,ad3542r", .data = &ad3542r_model_data },
+	{ .compatible = "adi,ad3551r", .data = &ad3551r_model_data },
 	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
 	{ }
 };
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index 23f038464a0c..9d450019ece9 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -132,6 +132,8 @@
 
 #define AD3552R_MAX_RANGES	5
 #define AD3542R_MAX_RANGES	5
+#define AD3552R_SPI		0
+#define AD3552R_DUAL_SPI	1
 #define AD3552R_QUAD_SPI	2
 
 extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
@@ -156,6 +158,7 @@ struct ad3552r_model_data {
 	const s32 (*ranges_table)[2];
 	int num_ranges;
 	bool requires_output_range;
+	int num_spi_data_lanes;
 };
 
 struct ad3552r_ch_data {

-- 
2.47.0


