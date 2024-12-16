Return-Path: <linux-iio+bounces-13558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5B99F3AFE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A9516B45B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91B71D88AC;
	Mon, 16 Dec 2024 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p8wqPB22"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153331D6DDD
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381482; cv=none; b=JHEnW2Lp33Zdi/G/4oT9UYAg7zZOzJDNu5CMq+CtOhAA5u0+TN3ScT+qKy0WCjSdk07e8egJzGa0TQeDHOOZVH+yT9Shes2Iqc51y83PNBUfMX+VTdJF9H7IqK4A6NoXeclPhIxXAnka8nC4nete9D6cBNSnhkt9DFtKo/01wFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381482; c=relaxed/simple;
	bh=fhIaZIU8N17kLdlDj3FvIPnGKPWD9hvQNICrAM+vev0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYVENREUuxnuKhvOsPO87NLNwNMPNEFho4l9IGrF1UwPEgZv3E5HoRTshktcu8lNGaIXNc6Yw0vhSb82g/q/Lztan4fdxOKRKxjfMOsMvEisSqW6/3fls5uNnP4FjPs4NF5c5C5PPnzL1XTTQ8lS6alRrsjywU9lqRUQcfQX6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p8wqPB22; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2205286f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381478; x=1734986278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBnYDoHsAqIoRToyg5lSiulRrJe70q5zy9qwaav1yaQ=;
        b=p8wqPB22h7TjNyNJe/YrsN0jbTuYNEY/jJCLd5wmaaxFI7+YSqNe3QNNYa9lo+d7XW
         7t92st4c+TOIBJ3J2f/Pm7hYIxyE4UgsW+zPNRHTjpz8pVeuci6JrIebkP7cqGAW1Ov8
         Bjj24XWpMPJ5IgTQtLNY9d3q7f+21hHu33rK2Dw5/XgqCWC4mafs+0BIO8NDK43Q7OwR
         5JM3d4hntjyI/xeuQxAJ0m7rVfHXPTvF60+LtlI32MHR46amMohOjLuGIL2irp+3eqH1
         I467LJz/MAMvorl+fZ7zkUfThM2l1daC1xLRSyaHW9+Knriu0zrownHfP1bUbA9zMDLY
         0vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381478; x=1734986278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBnYDoHsAqIoRToyg5lSiulRrJe70q5zy9qwaav1yaQ=;
        b=ThberQSFXdpfcuKtKG3+cMjtQjQv1t3zcUIT8ErAf1D7edaUBURVr2PkdcUR22u87+
         ymmrfM+Tm3Y/ObnsocgF8fFmsgj3HYdo+NR5Ym+PGBjJdMQfGtyKW/yB/zE0JROGb2Xp
         +RIph/yJnJM9ZLLeR8kDWkNuXfetY+1Q1Ddgwj8cTAKrG+D+7hyQALXZ6JW69FC+pTz1
         9jfzBzpbTUrGSs5y6lo3/uknA3Z7XF/uKxgUMVDb/x1CPBIxsqdbv4UMvX7qWjnAoBWU
         VhzEtAQBz+RYoixjJtQx1VCs6N8nl5f/S2Nr6DvjuKGw8bEM1OtJ88ZgxFLrBPcGcGn+
         8L0w==
X-Forwarded-Encrypted: i=1; AJvYcCVqW9N8s2g0JBwzp7Y7Hs9kCUYWroRSl+Zg+9LtjNc5Re1xV/CDGjZkBxeBaw6teUGCj8/6PdOeqJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4dPmbx0k5dN9LRp+K6CCNwn0GQsaBr/zRn/EQW83RJEPLjJt
	ZI6NOCcml3y50I3LCuShWddyBYoTErcJDdeAZEpJ/ncAZ+za0o06cUZlIAydUT4=
X-Gm-Gg: ASbGncsNpbcg3rjFhomRNF671hUfxVktOwRFynkA5EAVzcQNDxDDnQQZcvWEb520Ylv
	v3Lwbp3PodJFAoQgTX4f4vgIxtQWmmOTSYHMrlqEH2DnbTC0IcnsF33O0vdrDni6E2wee2PZDJB
	4O1Bk2xI7LaHoNtclgEvb45FTsTlZ/nmU3Afh6EtnPTjoRRj/nNkni6ZV/wR0Zy3dayfnUl7k2k
	WKvmGdtpmsdRzsP8Tf57ZpaIAZMpYBZCZA7gppm6yroSKb/TU+f20yJINMsMiFSzUM2EhXzxjui
	4ydKaKEZc/AA6DavSaBOqbAah9VstFCuqQ==
X-Google-Smtp-Source: AGHT+IGEWMTl1okNCoujfg1r/XSS/1SU3NYzNJJuxvX9kjFoMuurT9yAM5h06XUBgniBY1yY+QDB1w==
X-Received: by 2002:a5d:6c65:0:b0:385:e105:d884 with SMTP id ffacd0b85a97d-3888e0f2da3mr12867098f8f.46.1734381478264;
        Mon, 16 Dec 2024 12:37:58 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:57 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:27 +0100
Subject: [PATCH 7/8] iio: dac: ad3552r-hs: add ad3541/2r support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-7-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
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
- use DAC "instruction mode" when backend is not buffering, suggested
  from the ADI HDL team as more proper configuration mode to be used
  for all ad35xxr devices,
- change samplerate to respect number of lanes.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-common.c |  44 +++++++
 drivers/iio/dac/ad3552r-hs.c     | 262 ++++++++++++++++++++++++++++++++-------
 drivers/iio/dac/ad3552r.c        |  36 ------
 drivers/iio/dac/ad3552r.h        |   8 ++
 4 files changed, 270 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index 03e0864f5084..2a0dd18ca906 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -47,6 +47,50 @@ u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
 }
 EXPORT_SYMBOL_NS_GPL(ad3552r_calc_custom_gain, "IIO_AD3552R");
 
+const struct ad3552r_model_data ad3541r_model_data = {
+	.model_name = "ad3541r",
+	.chip_id = AD3541R_ID,
+	.num_hw_channels = 1,
+	.ranges_table = ad3542r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
+	.requires_output_range = true,
+	.num_spi_data_lanes = 2,
+};
+EXPORT_SYMBOL_NS_GPL(ad3541r_model_data, "IIO_AD3552R");
+
+const struct ad3552r_model_data ad3542r_model_data = {
+	.model_name = "ad3542r",
+	.chip_id = AD3542R_ID,
+	.num_hw_channels = 2,
+	.ranges_table = ad3542r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
+	.requires_output_range = true,
+	.num_spi_data_lanes = 2,
+};
+EXPORT_SYMBOL_NS_GPL(ad3542r_model_data, "IIO_AD3552R");
+
+const struct ad3552r_model_data ad3551r_model_data = {
+	.model_name = "ad3551r",
+	.chip_id = AD3551R_ID,
+	.num_hw_channels = 1,
+	.ranges_table = ad3552r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
+	.requires_output_range = false,
+	.num_spi_data_lanes = 4,
+};
+EXPORT_SYMBOL_NS_GPL(ad3551r_model_data, "IIO_AD3552R");
+
+const struct ad3552r_model_data ad3552r_model_data = {
+	.model_name = "ad3552r",
+	.chip_id = AD3552R_ID,
+	.num_hw_channels = 2,
+	.ranges_table = ad3552r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
+	.requires_output_range = false,
+	.num_spi_data_lanes = 4,
+};
+EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");
+
 static void ad3552r_get_custom_range(struct ad3552r_ch_data *ch_data,
 				     s32 *v_min, s32 *v_max)
 {
diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index e613eee7fc11..58c8661f483b 100644
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
+		bus_mode = IIO_BACKEND_INTERFACE_SERIAL_QSPI;
+	else
+		bus_mode = IIO_BACKEND_INTERFACE_SERIAL_DSPI;
+
+	return iio_backend_interface_type_set(st->back, bus_mode);
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
@@ -132,48 +200,127 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
-	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
-				      loop_len, 1);
+	/*
+	 * With ad3541/2r supoport, QSPI pin is held low at reset from HDL,
+	 * streaming start sequence must respect strictly the order below.
+	 */
+
+	/* Primary region access, set streaming mode (now in SPI + SDR). */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					   AD3552R_MASK_SINGLE_INST, 0, 1);
 	if (ret)
 		return ret;
 
-	/* Inform DAC chip to switch into DDR mode */
+	/*
+	 * Set target loop len, 0x2c 0r 0x2a, descending loop,
+	 * and keeping loop len value so it's not cleared hereafter when
+	 * enabling streaming mode (cleared by CS_ up).
+	 */
 	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-					   AD3552R_MASK_SPI_CONFIG_DDR,
-					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
+		AD3552R_REG_ADDR_TRANSFER_REGISTER,
+		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
+		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
 	if (ret)
-		return ret;
+		goto exit_err_streaming;
+
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_STREAM_MODE,
+				      loop_len, 1);
+	if (ret)
+		goto exit_err_streaming;
+
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
+	if (ret)
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
+
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
+
+	/*
+	 * Back bus to simple SPI, this must be executed together with above
+	 * target mode unwind, and can be done only after it.
+	 */
+	iio_backend_interface_type_set(st->back,
+				       IIO_BACKEND_INTERFACE_SERIAL_SPI);
 
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
 
@@ -186,11 +333,23 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
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
+	ret = iio_backend_interface_type_set(st->back,
+					     IIO_BACKEND_INTERFACE_SERIAL_SPI);
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
 
@@ -198,6 +357,24 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Back to simple SPI for secondary region too now,
+	 * so to be able to dump/read registers there too if needed.
+	 */
+	ret = ad3552r_qspi_update_reg_bits(st,
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
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -304,10 +481,18 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
+	/* HDL starts with DDR enabled, disabling it. */
 	ret = iio_backend_ddr_disable(st->back);
 	if (ret)
 		return ret;
 
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				      AD3552R_MASK_SINGLE_INST |
+				      AD3552R_MASK_SHORT_INSTRUCTION, 1);
+	if (ret)
+		return ret;
+
 	ret = ad3552r_hs_scratch_pad_test(st);
 	if (ret)
 		return ret;
@@ -330,6 +515,8 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 				     "chip id error, expected 0x%x, got 0x%x\n",
 				     st->model_data->chip_id, id);
 
+	dev_info(st->dev, "chip id %s detected", st->model_data->model_name);
+
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
 				      AD3552R_MASK_RESET_STATUS, 1);
@@ -342,14 +529,6 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
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
@@ -505,15 +684,10 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-static const struct ad3552r_model_data ad3552r_model_data = {
-	.model_name = "ad3552r",
-	.chip_id = AD3552R_ID,
-	.num_hw_channels = 2,
-	.ranges_table = ad3552r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
-};
-
 static const struct of_device_id ad3552r_hs_of_id[] = {
+	{ .compatible = "adi,ad3541r", .data = &ad3541r_model_data },
+	{ .compatible = "adi,ad3542r", .data = &ad3542r_model_data },
+	{ .compatible = "adi,ad3551r", .data = &ad3551r_model_data },
 	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
 	{ }
 };
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index e7206af53af6..9d28e06b80c0 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -649,42 +649,6 @@ static int ad3552r_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-static const struct ad3552r_model_data ad3541r_model_data = {
-	.model_name = "ad3541r",
-	.chip_id = AD3541R_ID,
-	.num_hw_channels = 1,
-	.ranges_table = ad3542r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
-	.requires_output_range = true,
-};
-
-static const struct ad3552r_model_data ad3542r_model_data = {
-	.model_name = "ad3542r",
-	.chip_id = AD3542R_ID,
-	.num_hw_channels = 2,
-	.ranges_table = ad3542r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
-	.requires_output_range = true,
-};
-
-static const struct ad3552r_model_data ad3551r_model_data = {
-	.model_name = "ad3551r",
-	.chip_id = AD3551R_ID,
-	.num_hw_channels = 1,
-	.ranges_table = ad3552r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
-	.requires_output_range = false,
-};
-
-static const struct ad3552r_model_data ad3552r_model_data = {
-	.model_name = "ad3552r",
-	.chip_id = AD3552R_ID,
-	.num_hw_channels = 2,
-	.ranges_table = ad3552r_ch_ranges,
-	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
-	.requires_output_range = false,
-};
-
 static const struct spi_device_id ad3552r_id[] = {
 	{
 		.name = "ad3541r",
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index 4b5581039ae9..9d450019ece9 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -132,11 +132,18 @@
 
 #define AD3552R_MAX_RANGES	5
 #define AD3542R_MAX_RANGES	5
+#define AD3552R_SPI		0
+#define AD3552R_DUAL_SPI	1
 #define AD3552R_QUAD_SPI	2
 
 extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
 extern const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2];
 
+extern const struct ad3552r_model_data ad3541r_model_data;
+extern const struct ad3552r_model_data ad3542r_model_data;
+extern const struct ad3552r_model_data ad3551r_model_data;
+extern const struct ad3552r_model_data ad3552r_model_data;
+
 enum ad3552r_id {
 	AD3541R_ID = 0x400b,
 	AD3542R_ID = 0x4009,
@@ -151,6 +158,7 @@ struct ad3552r_model_data {
 	const s32 (*ranges_table)[2];
 	int num_ranges;
 	bool requires_output_range;
+	int num_spi_data_lanes;
 };
 
 struct ad3552r_ch_data {

-- 
2.47.0


