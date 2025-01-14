Return-Path: <linux-iio+bounces-14361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1482EA10AEF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBD43A93C5
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A791D63E2;
	Tue, 14 Jan 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R90AKZTV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757EB1D54CF
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868718; cv=none; b=oss9b2cw/WBPoMOdXuTHQ5/q88DAWAj3bUZz2znICm6g2MbNdRZvxo1waUBEmMff1Jm9HzqQjkaMX6uNPpksjGnognJuZaPs3/6p014OG5VLhnxSb9R4gjEG1oiCrNgLfU+2TeuD5/tDgFxfG95t5npB9Eez0ISBUHOIMsLK+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868718; c=relaxed/simple;
	bh=3NLonDaZXZHxQwUe77tNiYWg1OYTBJ3xp2Pe4pve3KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgLIXS6XrR2kUSV4c930pdJmyRZevvL3ya0PZMN5NpAsujHbJgLe5kt0U8p8AJYSO3ZfYWBcoc4YxD6jzVXDyTmj1v83RiP42gY//PJYWzqUqYas/U11JKCdP8odZ1QCb/qjo5S3xdoMLu09I5i2eNS9aoSgIfFhkp25YViovGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R90AKZTV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361815b96cso39998955e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868715; x=1737473515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl1oUp9XUDJT3tl0OP8G5+aUHgYGYfeR2svkPzgkqwc=;
        b=R90AKZTVv61ku/u7zZDoYYkNvk+cBeesJVTA1j9xm4S8fljwmcventdWuM65LHAkP8
         sve6ZmXwSjo4dqJ3HyM3VkNwBO9cAJJnwYjqlPgA9N2UUW/LCtdkBSuaevRf788aGqFJ
         PlwI8FHrcGK0c6LVcaolVcICppwx9ERECJncNvAsMddsfqhIrnOE6YHWFBypZWH166Ip
         FRTvL6n/2U9caqXN1UAxtCfdDcoSdh4FiZoGpezwWNxr5bf2LnXrA5GXpJJwXHLYfig8
         vlw4XO08aV1nixToGiEKIH9G0Fa/uQye3faxvCePcjrWq35bh9K89YLTC1hJfTkr1C4e
         fvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868715; x=1737473515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl1oUp9XUDJT3tl0OP8G5+aUHgYGYfeR2svkPzgkqwc=;
        b=M9jughRucZU/tk7CQBmOW8IhXCtxlRL8vKbnRId1QtIo7hWJk4itUps00gL2PtIvas
         oXWLMVv7aaypmbydfHPzR5c3ooO7QsdQnEf4/A3v2fT5Xbox0bq31Gk5QZ6ZZpxNPEqJ
         7e6CxgHY55psFRLOl/ycDWrXSwkE7mx6abRpZ9wbHsQf10tjGsq0gJXRrowexu4t9gBE
         uQnfaoBD5fFn5rmflzMBbmZVrtSPq5dgSQgu7RFy/bGba9ytlI7wXua0OBHOE3+CxK8s
         mUTpow3p9k3dwyfV8zodJFR5rBsoT5b5PgFwe395mIZGjY8MH8Cawk+3zxdpZzuiHJps
         mWTg==
X-Forwarded-Encrypted: i=1; AJvYcCUo3D5QXShPnNaau4bSxbiWZybG6upwAi8URmj2rZGcYdB1OLRGGzc0KVAivUITKFtgwexpU2fX8ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOorZVK2wnC8Xk6sd4ickHfdDn2Cm+rq3cvx3gYlx3uHwRLuQ
	jcySulaHAbD/oJzYEmfFSXdgrNEiwREaf8tB8WYdevGSdLqu/t5fexX2Q3H3uzU=
X-Gm-Gg: ASbGncsHqud3AESKPhOkHuKDvWO/PhAeqwyV497+y2eZr9wZDMFfbiv4znV6DKc8lVs
	sFq1HvTmVX509eFJfzbr5KspZfihuYQPfs1SvhFX5RJzR+jt+29s+8AGCYqR2EFaElx3eDKGqVU
	LbLw9EHfPcVLoc9HY0TOma4Q9+28nC+HZhEqEgYmu7pSz7kWYdqYPOmXxGiSSivtF9BPZ2wqRn9
	q75X+XATvZVl1eoOxSoM0PfVHs1NNf0H0bnC+MMuunzVs8+KYUnnVbbAkU=
X-Google-Smtp-Source: AGHT+IEfWZ2AzTIekjMqWBTl6vtRsgu2N7dbvBTSOolVxS/YcloLUk61fkXYN/4GB0Xa3Ov03DzHjg==
X-Received: by 2002:a05:6000:490e:b0:386:32cb:4aa with SMTP id ffacd0b85a97d-38a8730ef59mr23946987f8f.45.1736868714557;
        Tue, 14 Jan 2025 07:31:54 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:53 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:17 +0100
Subject: [PATCH v4 8/9] iio: dac: ad3552r-hs: add ad3541/2r support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-8-979402e33545@baylibre.com>
References: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
In-Reply-To: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
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
 drivers/iio/dac/ad3552r-hs.c     | 260 +++++++++++++++++++++++++++++++--------
 drivers/iio/dac/ad3552r.h        |   3 +
 3 files changed, 216 insertions(+), 51 deletions(-)

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
index 98711f742c70..e8e309046f11 100644
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
@@ -27,8 +52,19 @@ struct ad3552r_hs_state {
 	bool single_channel;
 	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
 	struct ad3552r_hs_platform_data *data;
+	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read values. */
+	u32 config_d;
 };
 
+static int ad3552r_hs_reg_read(struct ad3552r_hs_state *st, u32 reg, u32 *val,
+			       size_t xfer_size)
+{
+	/* No chip in the family supports DDR read. Informing of this. */
+	WARN_ON_ONCE(st->config_d & AD3552R_MASK_SPI_CONFIG_DDR);
+
+	return st->data->bus_reg_read(st->back, reg, val, xfer_size);
+}
+
 static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
 					u32 reg, u32 mask, u32 val,
 					size_t xfer_size)
@@ -36,7 +72,7 @@ static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
 	u32 rval;
 	int ret;
 
-	ret = st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
+	ret = ad3552r_hs_reg_read(st, reg, &rval, xfer_size);
 	if (ret)
 		return ret;
 
@@ -56,16 +92,20 @@ static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
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
-		ret = st->data->bus_reg_read(st->back,
+		/* For RAW accesses, stay always in simple-spi. */
+		ret = ad3552r_hs_reg_read(st,
 				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
 				val, 2);
 		if (ret)
@@ -93,6 +133,7 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		/* For RAW accesses, stay always in simple-spi. */
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
 			return st->data->bus_reg_write(st->back,
 				    AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
@@ -104,6 +145,42 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
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
+	u32 mode_target;
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
@@ -132,10 +209,10 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
-	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
-				      loop_len, 1);
-	if (ret)
-		return ret;
+	/*
+	 * With ad3541/2r support, QSPI pin is held low at reset from HDL,
+	 * streaming start sequence must respect strictly the order below.
+	 */
 
 	/* Primary region access, set streaming mode (now in SPI + SDR). */
 	ret = ad3552r_qspi_update_reg_bits(st,
@@ -144,47 +221,98 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	/* Inform DAC chip to switch into DDR mode */
+	/*
+	 * Set target loop len, keeping the value: streaming writes at address
+	 * 0x2c or 0x2a, in descending loop (2 or 4 bytes), keeping loop len
+	 * value so that it's not cleared hereafter when _CS is deasserted.
+	 */
 	ret = ad3552r_qspi_update_reg_bits(st,
-					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-					   AD3552R_MASK_SPI_CONFIG_DDR,
-					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
+		AD3552R_REG_ADDR_TRANSFER_REGISTER,
+		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
+		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
 	if (ret)
-		goto exit_err_ddr;
+		goto exit_err_streaming;
+
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_STREAM_MODE,
+				      loop_len, 1);
+	if (ret)
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
+
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
 
+	/*
+	 * Back bus to simple SPI, this must be executed together with above
+	 * target mode unwind, and can be done only after it.
+	 */
+	st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
+
+exit_err_ddr_mode:
 	iio_backend_ddr_disable(st->back);
 
-exit_err_ddr:
-	ad3552r_qspi_update_reg_bits(st, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
-				     AD3552R_MASK_SINGLE_INST,
-				     AD3552R_MASK_SINGLE_INST, 1);
+exit_err_ddr_mode_target:
+	/*
+	 * Back to SDR. In DDR we cannot read, whatever the mode is, so not
+	 * using update.
+	 */
+	st->config_d &= ~AD3552R_MASK_SPI_CONFIG_DDR;
+	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				st->config_d, 1);
+
+exit_err_streaming:
+	/* Back to single instruction mode, disabling loop. */
+	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				AD3552R_MASK_SINGLE_INST |
+				AD3552R_MASK_SHORT_INSTRUCTION, 1);
 
 	return ret;
 }
@@ -198,11 +326,22 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
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
 
@@ -210,6 +349,17 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
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
@@ -324,6 +474,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
+	/* HDL starts with DDR enabled, disabling it. */
 	ret = iio_backend_ddr_disable(st->back);
 	if (ret)
 		return ret;
@@ -339,15 +490,23 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
-	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
-				     &val, 1);
+	/*
+	 * Caching config_d, needed to restore it after streaming,
+	 * and also, to detect possible DDR read, that's not allowed.
+	 */
+	ret = st->data->bus_reg_read(st->back,
+				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				     &st->config_d, 1);
+	if (ret)
+		return ret;
+
+	ret = ad3552r_hs_reg_read(st, AD3552R_REG_ADDR_PRODUCT_ID_L, &val, 1);
 	if (ret)
 		return ret;
 
 	id = val;
 
-	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
-				     &val, 1);
+	ret = ad3552r_hs_reg_read(st, AD3552R_REG_ADDR_PRODUCT_ID_H, &val, 1);
 	if (ret)
 		return ret;
 
@@ -357,6 +516,8 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 			 "chip ID mismatch, detected 0x%x but expected 0x%x\n",
 			 id, st->model_data->chip_id);
 
+	dev_dbg(st->dev, "chip id %s detected", st->model_data->model_name);
+
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
 				      AD3552R_MASK_RESET_STATUS, 1);
@@ -369,14 +530,6 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
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
@@ -400,10 +553,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
 	ret = ad3552r_get_drive_strength(st->dev, &val);
 	if (!ret) {
-		ret = ad3552r_qspi_update_reg_bits(st,
+		st->config_d |=
+			FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, val);
+
+		ret = st->data->bus_reg_write(st->back,
 					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-					AD3552R_MASK_SDO_DRIVE_STRENGTH,
-					val, 1);
+					st->config_d, 1);
 		if (ret)
 			return ret;
 	}
@@ -533,6 +688,9 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
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


