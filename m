Return-Path: <linux-iio+bounces-10560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1299C6DB
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 12:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7DD283ACE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE8E19DFAC;
	Mon, 14 Oct 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mYkdjyuB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02115B143
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900590; cv=none; b=mxQtHSrgv6EgtCguM+dlTiA25YcU2AAE1/bJTKM+tMBBkLR0RmAJLVhB1OVDvLfI+W7BZNrmMDU1ivC1G3/jCx1OPNrJHVE4usS+J5apeHI6Yy1H/Ur1KFI1cQPrd2Nh5QkBTRSV4VWtqrobyECXS2UCsq1kNlMyDAaUPR7psx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900590; c=relaxed/simple;
	bh=zvFEdoZTjuTICzwjy5PKYblUOGq7AMvN2uudIER9MRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqUrTMObgShMkQIhRQlrAbWutmJM1eb/fMtKrvEWbtrGbaDxOWxxDY93ZsnoITAmKsfjk3iA6ElIJX0xp5dboqpz/RTRNYLGJWjA8uizp/k+BZEGGGuycvbq/XIqhD9vL0jQ/AI9PGWtjk2yvNWLYZhBQWHGEdGHnm2K4iGQR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mYkdjyuB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1646083e87.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728900586; x=1729505386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+r5zWkhXYpo0sCSxmrd5wUjoXNcmDHFuqjwoNyFVU8=;
        b=mYkdjyuBWCKUR3z62Z5zgTF5m4Hj95CzRK4acGeN1H0E+l3f0bYr2ymieTrHwfqZIV
         /XhGdUbpSWAZTErv+LSlz2rNJTN49kZWAfBigJZiO38YWOMb7PRjfjSCihonpeXXBx4R
         MepElbCTmGrlRiNHmcVTldbtEqcDaWOO7LB9PaEMoBHr200gf1jTNoOoV0BKsvfaJvkx
         emgqh94YsUWp1AMRiaW63NEe/1FwYEmyqNhaAy2egbsuEodKj+spCqvhQa8pZBl5ANqQ
         QHC2+BR04aQ10hr4TX9AZsvoltAxgNTX1O1Qzi3rhK8IpUhG0NSrZ3jpMY2sUYaxGTpd
         GOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900586; x=1729505386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+r5zWkhXYpo0sCSxmrd5wUjoXNcmDHFuqjwoNyFVU8=;
        b=VJnlHI2LmiH6h2Ajk+dKo/Q4l8ySj87xwA3EhqxypnSUQajHzrQO0XM/3iS2CdDFvp
         MUhEJpV8ZECherup+nx1+bGcYcRdgQLsCgZ9TWeIjO+U+gZTuhSXICkdUB0IvpJUz1aX
         GPsaHcmUeja4tDTCa4wocNBBruNXmIy9Y5YQifslFqZVnA9qxfTJWWdOCCXQhlLpza1x
         0Qo7rgyvK4qsj7cEoIW/AunoVdI9tL93rd2p4034ZOKL9CdnaHHSpi5/TCpoNbL0g2eO
         w3+KZ4GRqvpRzTH+U/n0GslYkthOZ2Ueop/29TbpL3ozpNXeoeKmNhoxH4Ymp95xVCx/
         vl6A==
X-Gm-Message-State: AOJu0Yx6RrB4fpJlCtW0MVNM7x1zCiWRH4mC1HyXmKKcIlTL/IUahiVA
	GnZkcbFyq/2V0zkR9QgPJFBW6hktRPNlxzXGihEMiFmkWnTyIAiAnT5dryvmZiQ=
X-Google-Smtp-Source: AGHT+IHkz6sGEm2NTB8q9oLQvXl/+67lcFlK3z/h9YzoKK039P1XoiGS0C+EkvM2BjFwhM//XglFFA==
X-Received: by 2002:a05:6512:110e:b0:539:fc75:99ae with SMTP id 2adb3069b0e04-539fc759ab3mr359986e87.31.1728900585798;
        Mon, 14 Oct 2024 03:09:45 -0700 (PDT)
Received: from [127.0.1.1] (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee0afsm10969352f8f.102.2024.10.14.03.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:09:45 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 14 Oct 2024 12:08:13 +0200
Subject: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add High Speed ad3552r platform driver.

The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
through the current AXI backend, or similar alternative IIO backend.

Compared to the existing driver (ad3552r.c), that is a simple SPI
driver, this driver is coupled with a DAC IIO backend that finally
controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
maximum transfer rate of 33MUPS using dma stream capabilities.

All commands involving QSPI bus read/write are delegated to the backend
through the provided APIs for bus read/write.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/Kconfig      |  14 ++
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ad3552r-hs.c | 526 +++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/dac/ad3552r-hs.h |  18 ++
 drivers/iio/dac/ad3552r.h    |   7 +
 5 files changed, 566 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index fa091995d002..fc11698e88f2 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -6,6 +6,20 @@
 
 menu "Digital to analog converters"
 
+config AD3552R_HS
+	tristate "Analog Devices AD3552R DAC High Speed driver"
+	select ADI_AXI_DAC
+	help
+	  Say yes here to build support for Analog Devices AD3552R
+	  Digital to Analog Converter High Speed driver.
+
+          The driver requires the assistance of an IP core to operate,
+          since data is streamed into target device via DMA, sent over a
+	  QSPI + DDR (Double Data Rate) bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad3552r-hs.
+
 config AD3552R
 	tristate "Analog Devices AD3552R DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index c92de0366238..d92e08ca93ca 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -4,6 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_AD3552R_HS) += ad3552r-hs.o ad3552r-common.o
 obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
 obj-$(CONFIG_AD5360) += ad5360.o
 obj-$(CONFIG_AD5380) += ad5380.o
diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
new file mode 100644
index 000000000000..cb29a600e141
--- /dev/null
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -0,0 +1,526 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD3552R
+ * Digital to Analog converter driver, High Speed version
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/backend.h>
+#include <linux/iio/buffer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/units.h>
+
+#include "ad3552r.h"
+#include "ad3552r-hs.h"
+
+struct ad3552r_hs_state {
+	const struct ad3552r_model_data *model_data;
+	struct gpio_desc *reset_gpio;
+	struct device *dev;
+	struct iio_backend *back;
+	bool single_channel;
+	struct ad3552r_hs_platform_data *data;
+	bool ddr_mode;
+};
+
+static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
+					u32 reg, u32 mask, u32 val,
+					size_t xfer_size)
+{
+	u32 rval;
+	int err;
+
+	err = st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
+	if (err)
+		return err;
+
+	rval &= ~mask;
+	rval |= val;
+
+	return st->data->bus_reg_write(st->back, reg, rval, xfer_size);
+}
+
+static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		int sclk;
+
+		ret = iio_backend_read_raw(st->back, chan, &sclk, 0,
+					   IIO_CHAN_INFO_FREQUENCY);
+		if (ret != IIO_VAL_INT)
+			return -EINVAL;
+
+		/* Using 4 lanes (QSPI) */
+		*val = DIV_ROUND_CLOSEST(sclk * 4 * (1 + st->ddr_mode),
+					 chan->scan_type.storagebits);
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_RAW:
+		ret = st->data->bus_reg_read(st->back,
+				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
+				val, 2);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			return st->data->bus_reg_write(st->back,
+				    AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
+				    val, 2);
+		}
+		unreachable();
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	struct iio_backend_data_fmt fmt = {
+		.type = IIO_BACKEND_DATA_UNSIGNED
+	};
+	int loop_len, val, err;
+
+	/* Inform DAC chip to switch into DDR mode */
+	err = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					   AD3552R_MASK_SPI_CONFIG_DDR,
+					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
+	if (err)
+		return err;
+
+	/* Inform DAC IP to go for DDR mode from now on */
+	err = iio_backend_ddr_enable(st->back);
+	if (err) {
+		dev_warn(st->dev, "could not set DDR mode, not streaming");
+		goto exit_err;
+	}
+
+	st->ddr_mode = true;
+
+	switch (*indio_dev->active_scan_mask) {
+	case AD3552R_CH0_ACTIVE:
+		st->single_channel = true;
+		loop_len = 2;
+		val = AD3552R_REG_ADDR_CH_DAC_16B(0);
+		break;
+	case AD3552R_CH1_ACTIVE:
+		st->single_channel = true;
+		loop_len = 2;
+		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
+		break;
+	case AD3552R_CH0_CH1_ACTIVE:
+		st->single_channel = false;
+		loop_len = 4;
+		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
+		break;
+	default:
+		err = -EINVAL;
+		goto exit_err_ddr;
+	}
+
+	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
+				      loop_len, 1);
+	if (err)
+		goto exit_err_ddr;
+
+	err = iio_backend_data_transfer_addr(st->back, val);
+	if (err)
+		goto exit_err_ddr;
+
+	err = iio_backend_data_format_set(st->back, 0, &fmt);
+	if (err)
+		goto exit_err_ddr;
+
+	err = iio_backend_data_stream_enable(st->back);
+	if (err)
+		goto exit_err_ddr;
+
+	return 0;
+
+exit_err_ddr:
+	iio_backend_ddr_disable(st->back);
+
+exit_err:
+	ad3552r_qspi_update_reg_bits(st,
+				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				     AD3552R_MASK_SPI_CONFIG_DDR,
+				     0, 1);
+
+	iio_backend_ddr_disable(st->back);
+
+	st->ddr_mode = false;
+
+	return err;
+}
+
+static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	int err;
+
+	err = iio_backend_data_stream_disable(st->back);
+	if (err)
+		return err;
+
+	/* Inform DAC to set in SDR mode */
+	err = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					   AD3552R_MASK_SPI_CONFIG_DDR,
+					   0, 1);
+	if (err)
+		return err;
+
+	err = iio_backend_ddr_disable(st->back);
+	if (err)
+		return err;
+
+	st->ddr_mode = false;
+
+	return 0;
+}
+
+static int ad3552r_hs_set_output_range(struct ad3552r_hs_state *st,
+				       unsigned int mode)
+{
+	return ad3552r_qspi_update_reg_bits(st,
+				AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+				AD3552R_MASK_CH_OUTPUT_RANGE,
+				FIELD_PREP(AD3552R_MASK_CH0_RANGE, mode) |
+				FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode),
+				1);
+}
+
+static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
+{
+	int err;
+
+	st->reset_gpio = devm_gpiod_get_optional(st->dev,
+						 "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->reset_gpio))
+		return PTR_ERR(st->reset_gpio);
+
+	if (st->reset_gpio) {
+		fsleep(10);
+		gpiod_set_value_cansleep(st->reset_gpio, 1);
+	} else {
+		err = ad3552r_qspi_update_reg_bits(st,
+					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
+					AD3552R_MASK_SOFTWARE_RESET,
+					AD3552R_MASK_SOFTWARE_RESET, 1);
+		if (err)
+			return err;
+	}
+	msleep(100);
+
+	return 0;
+}
+
+static int ad3552r_hs_scratch_pad_test(struct ad3552r_hs_state *st)
+{
+	int err, val;
+
+	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				      AD3552R_SCRATCH_PAD_TEST_VAL1, 1);
+	if (err)
+		return err;
+
+	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				     &val, 1);
+	if (err)
+		return err;
+
+	if (val != AD3552R_SCRATCH_PAD_TEST_VAL1) {
+		dev_err(st->dev,
+			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
+			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
+		return -EIO;
+	}
+
+	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				      AD3552R_SCRATCH_PAD_TEST_VAL2, 1);
+	if (err)
+		return err;
+
+	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				     &val, 1);
+	if (err)
+		return err;
+
+	if (val != AD3552R_SCRATCH_PAD_TEST_VAL2) {
+		dev_err(st->dev,
+			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
+			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
+					u16 gain, u16 offset)
+{
+	int err;
+
+	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_OFFSET(0),
+				      offset, 1);
+	if (err)
+		return dev_err_probe(st->dev, err, "Error writing register\n");
+
+	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_OFFSET(1),
+				      offset, 1);
+	if (err)
+		return dev_err_probe(st->dev, err, "Error writing register\n");
+
+	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(0),
+				      gain, 1);
+	if (err)
+		return dev_err_probe(st->dev, err, "Error writing register\n");
+
+	err = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(1),
+				      gain, 1);
+	if (err)
+		return dev_err_probe(st->dev, err, "Error writing register\n");
+
+	return 0;
+}
+
+static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
+{
+	u8 gs_p, gs_n;
+	s16 goffs;
+	u16 id, rfb;
+	u16 gain = 0, offset = 0;
+	u32 val, range;
+	int err;
+
+	err = ad3552r_hs_reset(st);
+	if (err)
+		return err;
+
+	err = iio_backend_ddr_disable(st->back);
+	if (err)
+		return err;
+
+	err = ad3552r_hs_scratch_pad_test(st);
+	if (err)
+		return err;
+
+	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
+				     &val, 1);
+	if (err)
+		return err;
+
+	id = val;
+
+	err = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
+				     &val, 1);
+	if (err)
+		return err;
+
+	id |= val << 8;
+	if (id != st->model_data->chip_id)
+		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
+			 AD3552R_ID, id);
+
+	err = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				      0, 1);
+	if (err)
+		return err;
+
+	err = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_TRANSFER_REGISTER,
+				      AD3552R_MASK_QUAD_SPI |
+				      AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
+	if (err)
+		return err;
+
+	err = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
+	if (err)
+		return err;
+
+	err = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
+	if (err)
+		return err;
+
+	err = ad3552r_get_ref_voltage(st->dev);
+	if (err < 0)
+		return err;
+
+	val = err;
+
+	err = ad3552r_qspi_update_reg_bits(st,
+				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
+				val, 1);
+	if (err)
+		return err;
+
+	err = ad3552r_get_drive_strength(st->dev, &val);
+	if (!err) {
+		err = ad3552r_qspi_update_reg_bits(st,
+					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					AD3552R_MASK_SDO_DRIVE_STRENGTH,
+					val, 1);
+		if (err)
+			return err;
+	}
+
+	struct fwnode_handle *child __free(fwnode_handle) =
+				device_get_named_child_node(st->dev, "channel");
+	if (!child)
+		return -EINVAL;
+
+	/*
+	 * One of "adi,output-range-microvolt" or "custom-output-range-config"
+	 * must be available in fdt.
+	 */
+	err = ad3552r_get_output_range(st->dev, st->model_data, child, &range);
+	if (!err)
+		return ad3552r_hs_set_output_range(st, range);
+	if (err != -ENOENT)
+		return err;
+
+	err = ad3552r_get_custom_gain(st->dev, child, &gs_p, &gs_n, &rfb,
+				      &goffs);
+	if (err)
+		return err;
+
+	gain = ad3552r_calc_custom_gain(gs_p, gs_n, goffs);
+	offset = abs(goffs);
+
+	return ad3552r_hs_setup_custom_gain(st, gain, offset);
+}
+
+static const struct iio_buffer_setup_ops ad3552r_hs_buffer_setup_ops = {
+	.postenable = ad3552r_hs_buffer_postenable,
+	.predisable = ad3552r_hs_buffer_predisable,
+};
+
+#define AD3552R_CHANNEL(ch) { \
+	.type = IIO_VOLTAGE, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.output = 1, \
+	.indexed = 1, \
+	.channel = (ch), \
+	.scan_index = (ch), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_BE, \
+	} \
+}
+
+static const struct iio_chan_spec ad3552r_hs_channels[] = {
+	AD3552R_CHANNEL(0),
+	AD3552R_CHANNEL(1),
+};
+
+static const struct iio_info ad3552r_hs_info = {
+	.read_raw = &ad3552r_hs_read_raw,
+	.write_raw = &ad3552r_hs_write_raw,
+};
+
+static int ad3552r_hs_probe(struct platform_device *pdev)
+{
+	struct ad3552r_hs_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->dev = &pdev->dev;
+
+	st->data = pdev->dev.platform_data;
+	if (!st->data)
+		dev_err_probe(st->dev, -ENODEV, "No platform data !");
+
+	st->back = devm_iio_backend_get(&pdev->dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+
+	ret = devm_iio_backend_enable(&pdev->dev, st->back);
+	if (ret)
+		return ret;
+
+	st->model_data = device_get_match_data(&pdev->dev);
+
+	indio_dev->name = "ad3552r";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->setup_ops = &ad3552r_hs_buffer_setup_ops;
+	indio_dev->channels = ad3552r_hs_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad3552r_hs_channels);
+	indio_dev->info = &ad3552r_hs_info;
+
+	ret = devm_iio_backend_request_buffer(&pdev->dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad3552r_hs_setup(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static const struct ad3552r_model_data ad3552r_model_data = {
+	.model_name = "ad3552r",
+	.chip_id = AD3552R_ID,
+	.num_hw_channels = 2,
+	.ranges_table = ad3552r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
+};
+
+static const struct of_device_id ad3552r_hs_of_id[] = {
+	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad3552r_hs_of_id);
+
+static struct platform_driver axi_ad3552r_driver = {
+	.driver = {
+		.name = "ad3552r-axi",
+		.of_match_table = ad3552r_hs_of_id,
+	},
+	.probe = ad3552r_hs_probe,
+};
+module_platform_driver(axi_ad3552r_driver);
+
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_AUTHOR("Angelo Dureghello <adueghello@baylibre.com>");
+MODULE_DESCRIPTION("AD3552R Driver - AXI IP version");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_AD3552R);
diff --git a/drivers/iio/dac/ad3552r-hs.h b/drivers/iio/dac/ad3552r-hs.h
new file mode 100644
index 000000000000..dbf71d5e58c1
--- /dev/null
+++ b/drivers/iio/dac/ad3552r-hs.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2024 Analog Devices Inc.
+ * Copyright (c) 2024 Baylibre, SAS
+ */
+#ifndef __LINUX_PLATFORM_DATA_AD3552R_HS_H__
+#define __LINUX_PLATFORM_DATA_AD3552R_HS_H__
+
+struct iio_backend;
+
+struct ad3552r_hs_platform_data {
+	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val,
+			    size_t data_size);
+	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val,
+			     size_t data_size);
+};
+
+#endif /* __LINUX_PLATFORM_DATA_AD3552R_HS_H__ */
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index 088eb8ecfac6..fc00ed4c2565 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -38,6 +38,8 @@
 #define AD3552R_REG_ADDR_TRANSFER_REGISTER		0x0F
 #define   AD3552R_MASK_MULTI_IO_MODE			GENMASK(7, 6)
 #define   AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
+#define   AD3552R_MASK_DUAL_SPI				BIT(6)
+#define   AD3552R_MASK_QUAD_SPI				BIT(7)
 #define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
 #define   AD3552R_MASK_CRC_ENABLE			(GENMASK(7, 6) |\
 							 GENMASK(1, 0))
@@ -129,6 +131,11 @@
 #define AD3552R_GAIN_SCALE				1000
 #define AD3552R_LDAC_PULSE_US				100
 
+#define AD3552R_CH0_ACTIVE				BIT(0)
+#define AD3552R_CH1_ACTIVE				BIT(1)
+#define AD3552R_CH0_CH1_ACTIVE				(AD3552R_CH0_ACTIVE | \
+							 AD3552R_CH1_ACTIVE)
+
 #define AD3552R_MAX_RANGES	5
 #define AD3542R_MAX_RANGES	6
 

-- 
2.45.0.rc1


