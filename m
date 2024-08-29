Return-Path: <linux-iio+bounces-8875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF04E9644A6
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FF9B238CC
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B31B012A;
	Thu, 29 Aug 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P+YE62tV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3F1AED4C
	for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934810; cv=none; b=jGLPSJHliEUenjVZYdTGhKL+I6p3bCNbXCaECMBX0/Do5ScMLFl5JPNI5LSM2hbi7rdD7hchj0Ge9vG31ns2dJyhER7jL0KlyBX7NaahgylZr2wyEuZE8zrrUrNyWEj4SEsJAPhik4Xg6AAqI+r6CYqjUBHVGnLdkVdjG4MsqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934810; c=relaxed/simple;
	bh=w8nUYGJBv9bfyc6zTQO/J4ppZxo97XPP+m2Jiyw3Bnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cqb0/xu0VWxmpUcJbw7AWIoKU9TrrFIsLqaTA7UxSsYRmoDhKrdu+tyqAkdJDLanwscrZpJjxomru47xNv6BCdgHFe33u19fVh+HLWNz4ncwT9lIF8+dMgxyIjherIOVxD3F7ZrAR+ji8RP2jIcGn9gAmGkxW9KyhXCOmTfAnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P+YE62tV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371c5187198so390501f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2024 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724934805; x=1725539605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOI0/LkEfO3vRmpVZA8C5jtFpDcwMZaIECMkAHo2fGg=;
        b=P+YE62tV3TqLL+hVjgbnooc3u5HE19kUIej3h4GzTM6O2CI4ucDCfIDgphbCMbG0Zs
         STxLv+fsY75yitiBxaB4MfX2Rwl9M0TLTJiQe4kEhZf6RJIqiRXt5+yQmoK5l56cJpCX
         8S4aklBoEKY75xS1kmKC2hY5N0o3XbTREMwvTFGXswptLhvI4Ex1b+VLrpbSzZNh4220
         INsrn9ku21G2EeBFRGdTT4CJi/GaN83PXR7aHhLKZCXAKVYg/6H7GGarA2bqbQZPlDr9
         RVo4PSAg1NAY8D400ZTup4qNSgDBMSW4yzeUuKM7ZgEAuoB+AjwL1BUI4i9Mi2wNicQ9
         UtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934805; x=1725539605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOI0/LkEfO3vRmpVZA8C5jtFpDcwMZaIECMkAHo2fGg=;
        b=wKq5m2ZJmIGN5KtsPmibtCz7wBzLa1QZUismka2ywt1ab3QjxJMDlXFvS2i3C09WVs
         NigaKgQlOi+pm6M18Ym9tbOib8AfB13lxnOz4g/r5Yfl/2Jn/lDB5yeCQax/op3mmhnE
         NNb3EjNi3+/xTcqEIxFsHd7jV3biDxg2R397mjaFCxkbshar8gRiSVgeP2EVicUahI6U
         xV8BUjucdXG2weZ8QBdQHI//DFmJaLR7QuMj0NEtPVcb7SLY5FWPIQZfIH1tgLLJQdPn
         xepqIve9NHf+JdRbHXRGqt/xxRndrIW906uwYdsIfTXExs2v/IZWdg75sgcYjFOkKFth
         R+iw==
X-Gm-Message-State: AOJu0Yx0wJz0LiRKKc0+HKG5dcNBNkPmeRLEOqA2nCB9Db22gXNDGz6e
	+/HAyrcYb7/d9hC3IAHCnSGfhsvxWnsJEy6Ru0HVy8HbYWrIZq8mM4ESxhA6iv8=
X-Google-Smtp-Source: AGHT+IFdUw2IETmAulQYBiAIFcMarSHktWwFm/Cm9Eo5FKwCWrkpnRWQ5JZF4ue2V6ckuXT+5VD6XA==
X-Received: by 2002:a05:6000:1f0e:b0:371:8a91:9e72 with SMTP id ffacd0b85a97d-3749b54cfd1mr1806377f8f.30.1724934805262;
        Thu, 29 Aug 2024 05:33:25 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9978bsm1315042f8f.49.2024.08.29.05.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:24 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 Aug 2024 14:32:05 +0200
Subject: [PATCH RFC 7/8] iio: dac: ad3552r: add axi platform driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wip-bl-ad3552r-axi-v0-v1-7-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for ad3552r AXI DAC IP version.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/Kconfig       |  11 +
 drivers/iio/dac/Makefile      |   1 +
 drivers/iio/dac/ad3552r-axi.c | 572 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 584 insertions(+)

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
index 000000000000..98e5da08c973
--- /dev/null
+++ b/drivers/iio/dac/ad3552r-axi.c
@@ -0,0 +1,572 @@
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
+#include <linux/iio/buffer.h>
+#include <linux/iio/backend.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/units.h>
+
+#include "ad3552r.h"
+
+enum ad3552r_synchronous_mode_status {
+	AD3552R_NO_SYNC,
+	AD3552R_EXT_SYNC_ARM,
+};
+
+struct ad3552r_axi_state {
+	struct gpio_desc *reset_gpio;
+	struct device *dev;
+	struct iio_backend *back;
+	unsigned long active_scan_mask;
+	enum ad3552r_id chip_id;
+	bool single_channel;
+	bool synced_transfer;
+};
+
+static int axi3552r_qspi_update_reg_bits(struct iio_backend *back,
+					 u32 reg, u32 mask, u32 val,
+					 size_t xfer_size)
+{
+	u32 rval;
+	int err;
+
+	err = iio_backend_bus_reg_read(back, reg, &rval, xfer_size);
+	if (err)
+		return err;
+
+	rval &= ~mask;
+	rval |= val;
+
+	return iio_backend_bus_reg_write(back, reg, &rval, xfer_size);
+}
+
+static int ad3552r_axi_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct ad3552r_axi_state *st = iio_priv(indio_dev);
+	int err, ch = chan->channel;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		int clk_rate;
+
+		err = iio_backend_read_raw(st->back, chan, &clk_rate, 0,
+					   IIO_CHAN_INFO_FREQUENCY);
+		if (err != IIO_VAL_INT)
+			return err;
+
+		/*
+		 * Data stream SDR/DDR (clk_in/8 or clk_in/4 update rate).
+		 * Samplerate has sense in DDR only.
+		 */
+		if (st->single_channel)
+			clk_rate = DIV_ROUND_CLOSEST(clk_rate, 4);
+		else
+			clk_rate = DIV_ROUND_CLOSEST(clk_rate, 8);
+
+		*val = clk_rate;
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_RAW:
+		err = iio_backend_bus_reg_read(st->back,
+					       AD3552R_REG_ADDR_CH_DAC_16B(ch),
+					       val, 2);
+		if (err)
+			return err;
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
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			struct ad3552r_axi_state *st = iio_priv(indio_dev);
+			int ch = chan->channel;
+
+			return iio_backend_bus_reg_write(st->back,
+				    AD3552R_REG_ADDR_CH_DAC_16B(ch), &val, 2);
+		}
+		unreachable();
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad3552r_axi_update_scan_mode(struct iio_dev *indio_dev,
+					const unsigned long *active_scan_mask)
+{
+	struct ad3552r_axi_state *st = iio_priv(indio_dev);
+
+	st->active_scan_mask = *active_scan_mask;
+
+	return 0;
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
+	err = axi3552r_qspi_update_reg_bits(st->back,
+					    AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					    AD3552R_MASK_SPI_CONFIG_DDR,
+					    AD3552R_MASK_SPI_CONFIG_DDR, 1);
+	if (err)
+		return err;
+
+	/* Inform DAC IP to go for DDR mode from now on */
+	err = iio_backend_ddr_enable(st->back);
+	if (err)
+		goto exit_err;
+
+	switch (st->active_scan_mask) {
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
+		return -EINVAL;
+	}
+
+	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
+					&loop_len, 1);
+	if (err)
+		goto exit_err;
+
+	iio_backend_data_transfer_addr(st->back, val);
+	if (err)
+		goto exit_err;
+	/*
+	 * The EXT_SYNC is mandatory in the CN0585 project where 2 instances
+	 * of the IP are in the design and they need to generate the signals
+	 * synchronized.
+	 *
+	 * Note: in first IP implementations CONFIG EXT_SYNC (RO) can be 0,
+	 * but EXT_SYMC is anabled anyway.
+	 */
+
+	if (st->synced_transfer == AD3552R_EXT_SYNC_ARM)
+		err = iio_backend_ext_sync_enable(st->back);
+	else
+		err = iio_backend_ext_sync_disable(st->back);
+	if (err)
+		goto exit_err_sync;
+
+	err = iio_backend_data_format_set(st->back, 0, &fmt);
+	if (err)
+		goto exit_err;
+
+	err =  iio_backend_buffer_enable(st->back);
+	if (!err)
+		return 0;
+
+exit_err_sync:
+	iio_backend_ext_sync_disable(st->back);
+
+exit_err:
+	axi3552r_qspi_update_reg_bits(st->back,
+				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				      AD3552R_MASK_SPI_CONFIG_DDR,
+				      0, 1);
+
+	iio_backend_ddr_disable(st->back);
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
+	/* Inform DAC to set in DDR mode */
+	err = axi3552r_qspi_update_reg_bits(st->back,
+					    AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					    AD3552R_MASK_SPI_CONFIG_DDR,
+					    0, 1);
+	if (err)
+		return err;
+
+	return iio_backend_ddr_disable(st->back);
+}
+
+static int ad3552r_axi_set_output_range(struct ad3552r_axi_state *st,
+					unsigned int mode)
+{
+	int range_ch_0 = FIELD_PREP(AD3552R_MASK_CH0_RANGE, mode);
+	int range_ch_1 = FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode);
+
+	return axi3552r_qspi_update_reg_bits(st->back,
+				AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+				AD3552R_MASK_CH_OUTPUT_RANGE,
+				range_ch_0 | range_ch_1, 1);
+}
+
+static int ad3552r_axi_reset(struct ad3552r_axi_state *st)
+{
+	int err;
+
+	/* AXI reset performed by backend enable() */
+
+	st->reset_gpio = devm_gpiod_get_optional(st->dev,
+						 "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->reset_gpio))
+		return PTR_ERR(st->reset_gpio);
+
+	if (st->reset_gpio) {
+		gpiod_set_value_cansleep(st->reset_gpio, 1);
+		fsleep(10);
+		gpiod_set_value_cansleep(st->reset_gpio, 0);
+	} else {
+		err = axi3552r_qspi_update_reg_bits(st->back,
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
+static int ad3552r_axi_setup(struct ad3552r_axi_state *st)
+{
+	struct fwnode_handle *child __free(fwnode_handle) = NULL;
+	u8 gs_p, gs_n;
+	s16 goffs;
+	u16 id, rfb, reg = 0, offset = 0;
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
+	val = AD3552R_SCRATCH_PAD_TEST_VAL1;
+	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+					&val, 1);
+	if (err)
+		return err;
+
+	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				       &val, 1);
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
+	val = AD3552R_SCRATCH_PAD_TEST_VAL2;
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_SCRATCH_PAD,
+					&val, 1);
+	if (err)
+		return err;
+
+	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				       &val, 1);
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
+	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
+				       &val, 1);
+	if (err)
+		return err;
+
+	id = val;
+	mdelay(100);
+
+	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
+				       &val, 1);
+	if (err)
+		return err;
+
+	id |= val << 8;
+	if (id != AD3552R_ID) {
+		dev_err(st->dev, "Chip ID mismatch. Expected 0x%x, Read 0x%x\n",
+			AD3552R_ID, id);
+		return -ENODEV;
+	}
+
+	st->chip_id = id;
+
+	val = AD3552R_REF_INIT;
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+					&val, 1);
+	if (err)
+		return err;
+
+	val = AD3552R_TRANSFER_INIT;
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_TRANSFER_REGISTER,
+					&val, 1);
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
+	err = ad3552r_get_ref_voltage(st->dev, &val);
+	if (err)
+		return err;
+
+	err = axi3552r_qspi_update_reg_bits(st->back,
+				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
+				val, 1);
+	if (err)
+		return err;
+
+	err = ad3552r_get_drive_strength(st->dev, &val);
+	if (!err) {
+		err = axi3552r_qspi_update_reg_bits(st->back,
+					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					AD3552R_MASK_SDO_DRIVE_STRENGTH,
+					val, 1);
+		if (err)
+			return err;
+	}
+
+	child = device_get_named_child_node(st->dev, "channel");
+	if (!child)
+		return -EINVAL;
+
+	err = ad3552r_get_output_range(st->dev, st->chip_id, child, &range);
+	if (!err)
+		return ad3552r_axi_set_output_range(st, range);
+
+	if (err != -ENOENT)
+		return err;
+
+	/* Try to get custom range */
+	err = ad3552r_get_custom_gain(st->dev, child,
+					&gs_p, &gs_n, &rfb, &goffs);
+	if (err)
+		return err;
+
+	ad3552r_calc_custom_gain(gs_p, gs_n, goffs, &reg);
+
+	offset = abs((s32)goffs);
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_CH_OFFSET(0),
+					&offset, 1);
+	if (err)
+		return dev_err_probe(st->dev, err,
+					"Error writing register\n");
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_CH_OFFSET(1),
+					&offset, 1);
+	if (err)
+		return dev_err_probe(st->dev, err,
+					"Error writing register\n");
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_CH_GAIN(0),
+					&reg, 1);
+	if (err)
+		return dev_err_probe(st->dev, err,
+					"Error writing register\n");
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_CH_GAIN(1),
+					&reg, 1);
+	if (err)
+		return dev_err_probe(st->dev, err,
+					"Error writing register\n");
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad3552r_axi_buffer_setup_ops = {
+	.postenable = ad3552r_axi_buffer_postenable,
+	.predisable = ad3552r_axi_buffer_predisable,
+};
+
+static int ad3552r_set_synchronous_mode_status(struct iio_dev *indio_dev,
+					       const struct iio_chan_spec *chan,
+					       unsigned int status)
+{
+	struct ad3552r_axi_state *st = iio_priv(indio_dev);
+
+	st->synced_transfer = status;
+
+	return 0;
+}
+
+static int ad3552r_get_synchronous_mode_status(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad3552r_axi_state *st = iio_priv(indio_dev);
+
+	return st->synced_transfer;
+}
+
+static const char *const synchronous_mode_status[] = {
+	[AD3552R_NO_SYNC] = "no_sync",
+	[AD3552R_EXT_SYNC_ARM] = "ext_sync_arm",
+};
+
+static const struct iio_enum ad3552r_synchronous_mode_enum = {
+	.items = synchronous_mode_status,
+	.num_items = ARRAY_SIZE(synchronous_mode_status),
+	.get = ad3552r_get_synchronous_mode_status,
+	.set = ad3552r_set_synchronous_mode_status,
+};
+
+static const struct iio_chan_spec_ext_info ad3552r_axi_ext_info[] = {
+	IIO_ENUM("synchronous_mode", IIO_SHARED_BY_TYPE,
+		 &ad3552r_synchronous_mode_enum),
+	IIO_ENUM_AVAILABLE("synchronous_mode", IIO_SHARED_BY_TYPE,
+			   &ad3552r_synchronous_mode_enum),
+	{},
+};
+
+#define AD3552R_CHANNEL(ch) { \
+	.type = IIO_VOLTAGE, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_all = (((ch) == 0) ? \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0), \
+	.output = 1, \
+	.indexed = 1, \
+	.channel = (ch), \
+	.scan_index = (ch), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.shift = 0, \
+		.endianness = IIO_BE, \
+	}, \
+	.ext_info = ad3552r_axi_ext_info, \
+}
+
+static struct iio_chan_spec ad3552r_axi_channels[] = {
+	AD3552R_CHANNEL(0),
+	AD3552R_CHANNEL(1),
+};
+
+static const struct iio_info ad3552r_axi_info = {
+	.read_raw = &ad3552r_axi_read_raw,
+	.write_raw = &ad3552r_axi_write_raw,
+	.update_scan_mode = ad3552r_axi_update_scan_mode,
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
+	st->back = devm_iio_backend_get(&pdev->dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+
+	ret = devm_iio_backend_enable(&pdev->dev, st->back);
+	if (ret)
+		return ret;
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
+static const struct of_device_id ad3552r_axi_of_id[] = {
+	{ .compatible = "adi,ad3552r" },
+	{}
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

-- 
2.45.0.rc1


