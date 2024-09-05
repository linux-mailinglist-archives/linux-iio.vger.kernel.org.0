Return-Path: <linux-iio+bounces-9205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1796DDE1
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8339D28A49C
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA05B1A0AE9;
	Thu,  5 Sep 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kylLoXha"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8961A08BA
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549563; cv=none; b=mYqL31lz0DkX+RqakvdWdaRkWLJ9wMg9Ik43Dfjr0oDcGMgR/HgiOpdiYQ/B/M3lD8DinMIg8mNJwyehLQ8Vwb4t32zuuwxwpWLXHQLsNPIW2kWV+FHv5GaZ6FC+Y/Hg4WapAZbXZJYKrckAfwR3g3d1NOIqJlaPixJeiG8yA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549563; c=relaxed/simple;
	bh=lI1gtJVyDHy48zQkd2d6kbfKlHnZ8EcgEnH6Aw5T1bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3VEIhSvhazswZK1tx4buqq6PjRXqr/iWKElMBoJ9biSV5TsCp7jYXg+4mQ+oGD6FsGfSwzExV7Et8p5hXXINw1+xjtIDMnTmH24xYdqYGSfNSfaOlOTkbtzQfJnrmlC6fdQhbwzY+e3rwrDnDfhf4kbdbsY+OAaeZrRbthONvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kylLoXha; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bbe908380so7783585e9.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725549560; x=1726154360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NczfyexhZhIfp/ANPsZ2m3BHeYjUbb1KyHqj1qX1qc=;
        b=kylLoXhap8B3vvEVgSxifmtQOmvCnJPzrKB4/owl/+jT7JxTLqaW54jvrRimSfeI7d
         A1ZpcTF9qi6CLrm3F+VtU6lkXi21cPR/vi6gWqoYrQsaogOXj4/j4uvxh93pRx+zkNw3
         Qa3M1MSUzRo1owcGogVWTj0jXCzW8H7HGipDcAhObHt6krxMMK2Q3LxsxFkAN87waaZf
         cxxjJxa7VAl71zN31yOOjoUvZAzyt3bgic5rw9mcltanDjXylesM6GvBvSrGBnjvUgrV
         WIl1Pens3IApstr0KQdSMrb0GnUFPrXy3RQngc7mlbMnNLD7cK6gRdeBaAN0RsmpHqfr
         mKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549560; x=1726154360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NczfyexhZhIfp/ANPsZ2m3BHeYjUbb1KyHqj1qX1qc=;
        b=BUamJeJa8Rh8xqubW5DLvPuUnPYWZuWyNZr11Bb1V37V0+Uw1Ondy7TcxkmIzuPEFd
         UP1/jw7ERzdmXe3CSMsQ71c2cLrqELQrrbzxPwXL/nfx6M8tMhyqm0pvp3GReQ2UMsys
         y2udHlteEk9Mt73ZkBUYON84oWchio/4W9omri+P/04GEVbzrvBXuJ0XjqzdEN4Db9iB
         1XfSSiN0n8UctlV9xWFcNYVIm6bwNKm2xDFbRHfcqgwNExY+4gtgtVvpNXKGcuD0Z57l
         lAxM2QulTTT41prxRZYkSp1d8gWE+L8hn5Q48R/lEM9GLJRPD3kTg6ncJIpA4hncwIFw
         IYHA==
X-Gm-Message-State: AOJu0Yy/b1D3r4colIhMMGxzjGB8ef0jf5nDJFaGJYhK+XNSXSrwgbih
	osEilUqosM33wVY4SzZFwg0aJPRnWQg1KaH3Fwl1H3FS7UlzFV9pzXv+3E+BDKY=
X-Google-Smtp-Source: AGHT+IFg2VEC7Uz0WAqqyr9WpHHEFI7lj806Vy9UFqGm8HYWJRNA7e8sLy5pAMB4uV5wxsccWuRfDQ==
X-Received: by 2002:adf:e3d0:0:b0:368:64e:a7dd with SMTP id ffacd0b85a97d-374bcff3b7fmr11061019f8f.53.1725549559550;
        Thu, 05 Sep 2024 08:19:19 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1de81b2sm14031076f8f.30.2024.09.05.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:19:15 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 05 Sep 2024 17:17:38 +0200
Subject: [PATCH v2 8/9] iio: dac: ad3552r: add axi platform driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for ad3552r-axi, where ad3552r has to be controlled
by the custom (fpga-based) ad3552r AXI DAC IP.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Co-developed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/Kconfig       |  11 +
 drivers/iio/dac/Makefile      |   1 +
 drivers/iio/dac/ad3552r-axi.c | 567 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 579 insertions(+)

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
index 000000000000..a9311f29f45d
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
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/units.h>
+
+#include "ad3552r.h"
+
+enum ad3552r_synchronous_mode_status {
+	AD3552R_NO_SYNC,
+	AD3552R_EXT_SYNC_ARM,
+};
+
+struct ad3552r_axi_model_data {
+	const char *model_name;
+	enum ad3552r_id chip_id;
+	unsigned int num_hw_channels;
+};
+
+struct ad3552r_axi_state {
+	const struct ad3552r_axi_model_data *model_data;
+	struct gpio_desc *reset_gpio;
+	struct device *dev;
+	struct iio_backend *back;
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
+	return iio_backend_bus_reg_write(back, reg, rval, xfer_size);
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
+		return -EINVAL;
+	}
+
+	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
+					loop_len, 1);
+	if (err)
+		goto exit_err;
+
+	err = iio_backend_data_transfer_addr(st->back, val);
+	if (err)
+		goto exit_err;
+
+	/*
+	 * The EXT_SYNC is mandatory in the CN0585 project where 2 instances
+	 * of the IP are in the design and they need to generate the signals
+	 * synchronized.
+	 *
+	 * Note: in first IP implementations CONFIG EXT_SYNC (RO) can be 0,
+	 * but EXT_SYMC (ext synch ability) is enabled anyway.
+	 */
+	if (st->synced_transfer == AD3552R_EXT_SYNC_ARM)
+		err = iio_backend_ext_sync_enable(st->back);
+	else
+		err = iio_backend_ext_sync_disable(st->back);
+	if (err)
+		goto exit_err_sync;
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
+	/* Inform DAC to set in SDR mode */
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
+	u16 id, rfb;
+	u16 reg = 0, offset = 0;
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
+	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+					AD3552R_SCRATCH_PAD_TEST_VAL1, 1);
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
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_SCRATCH_PAD,
+					AD3552R_SCRATCH_PAD_TEST_VAL2, 1);
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
+
+	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
+				       &val, 1);
+	if (err)
+		return err;
+
+	id |= val << 8;
+	if (id != st->model_data->chip_id) {
+		dev_err(st->dev, "Chip ID mismatch. Expected 0x%x, Read 0x%x\n",
+			AD3552R_ID, id);
+	}
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+					AD3552R_REF_INIT, 1);
+	if (err)
+		return err;
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_TRANSFER_REGISTER,
+					AD3552R_TRANSFER_INIT, 1);
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
+	err = ad3552r_get_output_range(st->dev, st->model_data->chip_id,
+				       child, &range);
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
+					offset, 1);
+	if (err)
+		return dev_err_probe(st->dev, err,
+					"Error writing register\n");
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_CH_OFFSET(1),
+					offset, 1);
+	if (err)
+		return dev_err_probe(st->dev, err,
+					"Error writing register\n");
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_CH_GAIN(0),
+					reg, 1);
+	if (err)
+		return dev_err_probe(st->dev, err,
+					"Error writing register\n");
+
+	err = iio_backend_bus_reg_write(st->back,
+					AD3552R_REG_ADDR_CH_GAIN(1),
+					reg, 1);
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
+	{}
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

-- 
2.45.0.rc1


