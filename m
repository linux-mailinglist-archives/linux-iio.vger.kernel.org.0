Return-Path: <linux-iio+bounces-9646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAA597C700
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10A5B22751
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C219DF48;
	Thu, 19 Sep 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ez5Zdso8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49619D886
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737712; cv=none; b=GuLyCcS9Pxi8Lm9q1M06o8lVPBGlCueXL6OfDUI93X4BfAYpSQE2HM73lTjblnWsLVukEjMknVmrtL15666A2nFQV0QJdaDQYiiQ2UsAoEaPeNFnFQpm6VrAeY0WkzsUu29Q1dou2uFxkJL8QYo4NmTwo43Yr7hG6AGUDZGvsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737712; c=relaxed/simple;
	bh=dxIuSgsLljoogbghKvOdfLgQnWZp85dbsjJTAeiDw00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3DS3FR0m7mqasOTuwmJrZGBWZZtr6DFCBOgoKlxWWCRjzqhuh8M/NAdYuo1JLin/heOYmIOliqlSkiBIOFaCwqONpomXLPTkHqd4WFanfhlbU2F8f7MKot1Lz9zG1POVuvl5y5lbssY1dXUFzvhX9lxLdhcdtiMV37GtBrmcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ez5Zdso8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so4828115e9.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737707; x=1727342507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENiS9ar8wrYoh8gKiE5vvZpqfPrqs1+FYPNEzNP0wSM=;
        b=ez5Zdso8aQCBskaujm/rgztdZJjjlDCVgB7eZ9vxFPHkngr8GYQqS8X1wX2Tkw9qSe
         sZdYKwqd2MD3O11hcIUMTo2AQ8qds+vHh9DvAHXb9sf7YNwSsArS2g7j2okfCtvfUQ0y
         3BGTSjNPpX6LalVjPc2sdFm+71EIQpDeDUo4jeC8vLvmNP0a21KEttZot1CJut5O8WB3
         8MC70ZX+AjtII4098xmHassJUahOAb5t8o6SiaAcaQVYytvurFY7c0XhNgXKRiQHJgf4
         ZrdyQaV3LldMBCV+1/qP82chayT1YQBPfKX3fjhX5j/h1WwPvdoVV7L1rFoItdq5MSxU
         7KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737707; x=1727342507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENiS9ar8wrYoh8gKiE5vvZpqfPrqs1+FYPNEzNP0wSM=;
        b=LQsxS9jOYN9sg1EZFpm1sm40W3HWhVnCjhLEzSZ8ci+HvxjerpmZxoJnCWG7keZ3/7
         ZVbn0j4iTXHhnicMAMvR4OKrytOgSmhmkTEBXuCNbJ4wSlpB+NKblvKJJT7Ve7gbk3w/
         TAkouYU4DoIWnxWWwH7rk2GD+4ZWpXd4QD8nZxyksGlF7ZLwnrOBDOXl4u2IfEMscUJX
         wzs7BNUPDr9+Qk/GELPRDIlbg8srwQb/axid9GEIq34KeLLBVE0ICNUk6gxae6PglIcG
         RDjkUDZbNlJ+68VhO2XztUZEx1oUcIoqVrRqpjidCiKF2fJIN8BkYy2NzxnKxoy1KRzV
         G1lg==
X-Gm-Message-State: AOJu0YxJAO3kFuunml9IgZVrWh3KE9hsNL3zEYyEGL3bryJCeK4LXWaN
	mP1fvi6+m/pY/NVyL2Ict/fERSVKgb84faGJ/L/zOo8HPz0n/qz74U1ZC+8jMm0=
X-Google-Smtp-Source: AGHT+IEec+xCrXFc4VYZ9eKpkFZm4VIatYJ6VSPDZ/dlXU0kfHZibngMFxhWwRl47n5tAWxI0/2DLA==
X-Received: by 2002:a05:600c:3581:b0:42c:ae30:fc4d with SMTP id 5b1f17b1804b1-42cdb53190emr207000815e9.7.1726737707341;
        Thu, 19 Sep 2024 02:21:47 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:46 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 19 Sep 2024 11:20:05 +0200
Subject: [PATCH v3 09/10] iio: dac: ad3552r: add axi platform driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-9-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for ad3552r-axi, where ad3552r has to be controlled
by the custom (fpga-based) ad3552r AXI DAC IP.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/Kconfig                   |  11 +
 drivers/iio/dac/Makefile                  |   1 +
 drivers/iio/dac/ad3552r-axi.c             | 567 ++++++++++++++++++++++++++++++
 drivers/iio/dac/ad3552r.h                 |   9 +
 include/linux/platform_data/ad3552r-axi.h |  18 +
 5 files changed, 606 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 1cfd7e2a622f..030af7702a3c 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -16,6 +16,17 @@ config AD3552R
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad3552r.
 
+config AD3552R_AXI
+	tristate "Analog Devices AD3552R DAC driver, AXI version"
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices AD3552R
+	  Digital to Analog Converter, connected through the Xilinx
+	  fpga AXI interface.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad3552r-axi.
+
 config AD5064
 	tristate "Analog Devices AD5064 and similar multi-channel DAC driver"
 	depends on (SPI_MASTER && I2C!=m) || I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 56a125f56284..cc2af3aa3f52 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
+obj-$(CONFIG_AD3552R_AXI) += ad3552r-axi.o ad3552r-common.o
 obj-$(CONFIG_AD5360) += ad5360.o
 obj-$(CONFIG_AD5380) += ad5380.o
 obj-$(CONFIG_AD5421) += ad5421.o
diff --git a/drivers/iio/dac/ad3552r-axi.c b/drivers/iio/dac/ad3552r-axi.c
new file mode 100644
index 000000000000..85c594e149fa
--- /dev/null
+++ b/drivers/iio/dac/ad3552r-axi.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD3552R
+ * Digital to Analog converter driver, AXI DAC backend version
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
+#include <linux/platform_data/ad3552r-axi.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/units.h>
+
+#include "ad3552r.h"
+
+#define AD3552R_QSPI_LANES	4
+
+struct ad3552r_axi_model_data {
+	const char *model_name;
+	enum ad3552r_id chip_id;
+	unsigned int num_hw_channels;
+	unsigned int sample_storage_bits;
+};
+
+struct ad3552r_axi_state {
+	const struct ad3552r_axi_model_data *model_data;
+	struct gpio_desc *reset_gpio;
+	struct device *dev;
+	struct iio_backend *back;
+	bool single_channel;
+	struct ad3552r_axi_platform_data *data;
+	bool ddr_mode;
+	bool synchronouos_mode;
+};
+
+static int ad3552r_qspi_update_reg_bits(struct ad3552r_axi_state *st,
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
+static int ad3552r_axi_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct ad3552r_axi_state *st = iio_priv(indio_dev);
+	int ch = chan->channel;
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
+		*val = DIV_ROUND_CLOSEST(sclk * AD3552R_QSPI_LANES *
+					 (1 + st->ddr_mode),
+					 chan->scan_type.storagebits);
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_RAW:
+		ret = st->data->bus_reg_read(st->back,
+					     AD3552R_REG_ADDR_CH_DAC_16B(ch),
+					     val, 2);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad3552r_axi_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	struct ad3552r_axi_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			int ch = chan->channel;
+
+			return st->data->bus_reg_write(st->back,
+				    AD3552R_REG_ADDR_CH_DAC_16B(ch), val, 2);
+		}
+		unreachable();
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad3552r_axi_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad3552r_axi_state *st = iio_priv(indio_dev);
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
+		loop_len = AD3552R_STREAM_2BYTE_LOOP;
+		val = AD3552R_REG_ADDR_CH_DAC_16B(0);
+		break;
+	case AD3552R_CH1_ACTIVE:
+		st->single_channel = true;
+		loop_len = AD3552R_STREAM_2BYTE_LOOP;
+		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
+		break;
+	case AD3552R_CH0_CH1_ACTIVE:
+		st->single_channel = false;
+		loop_len = AD3552R_STREAM_4BYTE_LOOP;
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
+	/*
+	 * The EXT_SYNC is mandatory in the CN0585 project where 2 instances
+	 * of the IP are in the design and they need to generate the signals
+	 * synchronized.
+	 *
+	 * Note: in first IP implementations CONFIG EXT_SYNC (RO) can be 0,
+	 * but EXT_SYNC (ext synch ability) is enabled anyway.
+	 */
+	if (st->synchronouos_mode)
+		err = iio_backend_ext_sync_enable(st->back);
+	else
+		err = iio_backend_ext_sync_disable(st->back);
+	if (err)
+		goto exit_err_ddr;
+
+	err = iio_backend_data_format_set(st->back, 0, &fmt);
+	if (err)
+		goto exit_err_sync;
+
+	err = iio_backend_buffer_enable(st->back);
+	if (err)
+		goto exit_err_sync;
+
+	return 0;
+
+exit_err_sync:
+	iio_backend_ext_sync_disable(st->back);
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
+static int ad3552r_axi_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad3552r_axi_state *st = iio_priv(indio_dev);
+	int err;
+
+	err = iio_backend_buffer_disable(st->back);
+	if (err)
+		return err;
+
+	if (st->synchronouos_mode) {
+		err = iio_backend_ext_sync_disable(st->back);
+		if (err)
+			return err;
+	}
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
+static int ad3552r_axi_set_output_range(struct ad3552r_axi_state *st,
+					unsigned int mode)
+{
+	return ad3552r_qspi_update_reg_bits(st,
+				AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+				AD3552R_MASK_CH_OUTPUT_RANGE,
+				FIELD_PREP(AD3552R_MASK_CH0_RANGE, mode) |
+				FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode),
+				1);
+}
+
+static int ad3552r_axi_reset(struct ad3552r_axi_state *st)
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
+static int ad3552r_axi_scratch_pad_test(struct ad3552r_axi_state *st)
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
+static int ad3552r_axi_setup_custom_gain(struct ad3552r_axi_state *st,
+					 u16 gain, u16 offset)
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
+static int ad3552r_axi_setup(struct ad3552r_axi_state *st)
+{
+	struct fwnode_handle *child __free(fwnode_handle) = NULL;
+	u8 gs_p, gs_n;
+	s16 goffs;
+	u16 id, rfb;
+	u16 gain = 0, offset = 0;
+	u32 val, range;
+	int err;
+
+	err = ad3552r_axi_reset(st);
+	if (err)
+		return err;
+
+	err = iio_backend_ddr_disable(st->back);
+	if (err)
+		return err;
+
+	err = ad3552r_axi_scratch_pad_test(st);
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
+	st->synchronouos_mode =
+			fwnode_property_read_bool(dev_fwnode(st->dev),
+						  "adi,synchronous-mode");
+
+	child = device_get_named_child_node(st->dev, "channel");
+	if (!child)
+		return -EINVAL;
+
+	/*
+	 * One of "adi,output-range-microvolt" or "custom-output-range-config"
+	 * must be available in fdt.
+	 */
+	err = ad3552r_get_output_range(st->dev, st->model_data->chip_id,
+				       child, &range);
+	if (!err)
+		return ad3552r_axi_set_output_range(st, range);
+	if (err != -ENOENT)
+		return err;
+
+	err = ad3552r_get_custom_gain(st->dev, child, &gs_p, &gs_n, &rfb,
+				      &goffs);
+	if (err)
+		return err;
+
+	gain = ad3552r_calc_custom_gain(gs_p, gs_n, goffs);
+	offset = abs((s32)goffs);
+
+	return ad3552r_axi_setup_custom_gain(st, gain, offset);
+}
+
+static const struct iio_buffer_setup_ops ad3552r_axi_buffer_setup_ops = {
+	.postenable = ad3552r_axi_buffer_postenable,
+	.predisable = ad3552r_axi_buffer_predisable,
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
+static const struct iio_chan_spec ad3552r_axi_channels[] = {
+	AD3552R_CHANNEL(0),
+	AD3552R_CHANNEL(1),
+};
+
+static const struct iio_info ad3552r_axi_info = {
+	.read_raw = &ad3552r_axi_read_raw,
+	.write_raw = &ad3552r_axi_write_raw,
+};
+
+static int ad3552r_axi_probe(struct platform_device *pdev)
+{
+	struct ad3552r_axi_state *st;
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
+	if (!st->data) {
+		dev_err(&pdev->dev, "no platform data!\n");
+		return -ENODEV;
+	}
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
+	indio_dev->setup_ops = &ad3552r_axi_buffer_setup_ops;
+	indio_dev->channels = ad3552r_axi_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad3552r_axi_channels);
+	indio_dev->info = &ad3552r_axi_info;
+
+	ret = devm_iio_backend_request_buffer(&pdev->dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad3552r_axi_setup(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static const struct ad3552r_axi_model_data ad3552r_model_data = {
+	.model_name = "ad3552r",
+	.chip_id = AD3552R_ID,
+	.num_hw_channels = 2,
+};
+
+static const struct of_device_id ad3552r_axi_of_id[] = {
+	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad3552r_axi_of_id);
+
+static struct platform_driver axi_ad3552r_driver = {
+	.driver = {
+		.name = "ad3552r-axi",
+		.of_match_table = ad3552r_axi_of_id,
+	},
+	.probe = ad3552r_axi_probe,
+};
+module_platform_driver(axi_ad3552r_driver);
+
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_AUTHOR("Angelo Dureghello <adueghello@baylibre.com>");
+MODULE_DESCRIPTION("AD3552R Driver - AXI IP version");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index b1caa3c3e807..02805eec69a5 100644
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
@@ -129,6 +131,13 @@
 #define AD3552R_GAIN_SCALE				1000
 #define AD3552R_LDAC_PULSE_US				100
 
+#define AD3552R_STREAM_2BYTE_LOOP			0x02
+#define AD3552R_STREAM_4BYTE_LOOP			0x04
+#define AD3552R_CH0_ACTIVE				BIT(0)
+#define AD3552R_CH1_ACTIVE				BIT(1)
+#define AD3552R_CH0_CH1_ACTIVE				(AD3552R_CH0_ACTIVE | \
+							AD3552R_CH1_ACTIVE)
+
 #define AD3552R_MAX_RANGES	5
 #define AD3542R_MAX_RANGES	6
 
diff --git a/include/linux/platform_data/ad3552r-axi.h b/include/linux/platform_data/ad3552r-axi.h
new file mode 100644
index 000000000000..7c0db307102c
--- /dev/null
+++ b/include/linux/platform_data/ad3552r-axi.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2010-2024 Analog Devices Inc.
+ * Copyright (c) 2024 Baylibre, SAS
+ */
+#ifndef __LINUX_PLATFORM_DATA_AD3552R_AXI_H__
+#define __LINUX_PLATFORM_DATA_AD3552R_AXI_H__
+
+#include <linux/iio/backend.h>
+
+struct ad3552r_axi_platform_data {
+	int (*bus_reg_read)(struct iio_backend *back, u32 reg,
+			    unsigned int *val, size_t data_size);
+	int (*bus_reg_write)(struct iio_backend *back, u32 reg,
+			     unsigned int val, size_t data_size);
+};
+
+#endif /* __LINUX_PLATFORM_DATA_AD3552R_AXI_H__ */

-- 
2.45.0.rc1


