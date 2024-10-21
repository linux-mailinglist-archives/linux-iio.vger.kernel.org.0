Return-Path: <linux-iio+bounces-10863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A349A690F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49982B2475F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77E1F890F;
	Mon, 21 Oct 2024 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pjt9Frky"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E31F8EED
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514508; cv=none; b=n84qxTwMhVSjEAOpYHEu048z5sUnB6Hb5FEN5/2SPMrbcHnaZudL4Be8f6UNuW59XknX+z3awAJaeT8BcHbq41xn+VSXV4aFv53KniPG6rZqoWTueBE5y2RMfxUoCdq/98RitzRi5mDFPHx+VGG2FYSXz9TR4xmcRugh+umycQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514508; c=relaxed/simple;
	bh=+o6bp04I5BqDmfOEHCO23uasXPx/7oacpZXUGndUfMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AL/2g9dOFebTDTk6KpyJVC5bLp9Zjp+HUll0763VpSA5cgaBZZDIfh+NkSqj02us/OKGk0TL7ha0hT5Nn/90VZ0UmuE4ZW4cI4sVMS51/gDqj8MfU2wcTVBR3hcatRN6o7MRIZJITCyGg15AkU2paiT3J7mpFViMAvX+e/hDkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pjt9Frky; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so46977385e9.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729514504; x=1730119304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1HCPyfTHFOzi0OW+XwcggtuS5NSbaaZ9sz79P9HfH4=;
        b=pjt9FrkyzrSc1IF8G+lssT1zDICYzmsSR7tAaGKbysVGTLztvTX+kbpdabIGDoiUwD
         d56hRQmjOcFritE3BZKywxp3OJnxCdZAEO8VqiFr2cPfVBxwxjjj/BLkpibnLmtUErED
         FuM23yzNeXFnYZj3+aaSLZxX8tTvPRwqMp8fCmaKsGXZ2xQ5dKz+N2FyMc2aBYhLsjyv
         isEOyFFtOx4gnDDkGGeSqJZaiH3StjIz++io6cPxZ5WJ9ESZ7egOcL1oaLxtBkVSq7wy
         g20Hpvygt6IaD/3WIjFiabm85fIkkRpjhRESBOAz03J3ZXVYdh67A0c8DQm5pQRVFhGh
         kDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514504; x=1730119304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1HCPyfTHFOzi0OW+XwcggtuS5NSbaaZ9sz79P9HfH4=;
        b=r/f+0IZKEnq64X/L42pOexs1x+A2GVw4i7Ywb2K3kx98rvtItPO1ijrr2VTqgOb3kG
         wc7yVl63DBc56Bsl9cu+jzuTxOpdNaXnuCRffadzpurkyDK1u15BL6Avt/xfkkmptSIo
         YxBMfXGdu7Ox8MF1L9qMSaoKPn/K6LiCk/hWGDATrgUA9pGBTggEgHslInyM6UOU6CXg
         8ci8AmRZtBVo8AfFm25xxyv26vLyNfroMvkD5yVwEN2+z0O6ZZuqyfoeJmFxYQp7EajO
         bvJR63rYjzEdR+1U85GGSqZvqEbf/0MZO4VtDi5tkzkdiO2hkR9HYjhIffb0oqApN3vx
         NB7Q==
X-Gm-Message-State: AOJu0YwJcdiiCqrrZDEtdfSMpHAmGA2ExwkGBCy6TJSlI5+yrcgPrXvC
	AvHra1J9WtyRM3ntQAtDkue1+Fu4qbiMXY8chiJEHud3l2UsxRSK2IArjiDmXSs=
X-Google-Smtp-Source: AGHT+IFkafWkZorc93ACmLp5j36aBlEaI2nzv6Hk69DkR2sl2P9KsOR3cVd8iGopG0YDkBWwd4fT3g==
X-Received: by 2002:a05:600c:198c:b0:431:58bc:ad5e with SMTP id 5b1f17b1804b1-4316168e56dmr91800685e9.28.1729514503715;
        Mon, 21 Oct 2024 05:41:43 -0700 (PDT)
Received: from [127.0.1.1] (host-82-61-199-210.retail.telecomitalia.it. [82.61.199.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc88esm55996075e9.46.2024.10.21.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:41:43 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 21 Oct 2024 14:40:17 +0200
Subject: [PATCH v7 7/8] iio: dac: ad3552r: add high-speed platform driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
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
 drivers/iio/dac/ad3552r-hs.c | 547 +++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/dac/ad3552r-hs.h |  18 ++
 drivers/iio/dac/ad3552r.h    |   4 +
 5 files changed, 584 insertions(+)

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
index 000000000000..27bdc35fdc29
--- /dev/null
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -0,0 +1,547 @@
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
+	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
+	struct ad3552r_hs_platform_data *data;
+};
+
+static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
+					u32 reg, u32 mask, u32 val,
+					size_t xfer_size)
+{
+	u32 rval;
+	int ret;
+
+	ret = st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
+	if (ret)
+		return ret;
+
+	rval = (rval & ~mask) | val;
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
+	int ch = chan->channel;
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
+		/*
+		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
+		 * considered always on (considering buffering mode always).
+		 */
+		*val = DIV_ROUND_CLOSEST(sclk * 4 * 2,
+					 chan->scan_type.realbits);
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
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->ch_data[ch].scale_int;
+		*val2 = st->ch_data[ch].scale_dec;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = st->ch_data[ch].offset_int;
+		*val2 = st->ch_data[ch].offset_dec;
+		return IIO_VAL_INT_PLUS_MICRO;
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
+	int loop_len, val, ret;
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
+	case AD3552R_CH0_ACTIVE | AD3552R_CH1_ACTIVE:
+		st->single_channel = false;
+		loop_len = 4;
+		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
+				      loop_len, 1);
+	if (ret)
+		return ret;
+
+	/* Inform DAC chip to switch into DDR mode */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					   AD3552R_MASK_SPI_CONFIG_DDR,
+					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
+	if (ret)
+		return ret;
+
+	/* Inform DAC IP to go for DDR mode from now on */
+	ret = iio_backend_ddr_enable(st->back);
+	if (ret) {
+		dev_err(st->dev, "could not set DDR mode, not streaming");
+		goto exit_err;
+	}
+
+	ret = iio_backend_data_transfer_addr(st->back, val);
+	if (ret)
+		goto exit_err;
+
+	ret = iio_backend_data_format_set(st->back, 0, &fmt);
+	if (ret)
+		goto exit_err;
+
+	ret = iio_backend_data_stream_enable(st->back);
+	if (ret)
+		goto exit_err;
+
+	return 0;
+
+exit_err:
+	ad3552r_qspi_update_reg_bits(st,
+				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+				     AD3552R_MASK_SPI_CONFIG_DDR,
+				     0, 1);
+
+	iio_backend_ddr_disable(st->back);
+
+	return ret;
+}
+
+static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_backend_data_stream_disable(st->back);
+	if (ret)
+		return ret;
+
+	/* Inform DAC to set in SDR mode */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					   AD3552R_MASK_SPI_CONFIG_DDR,
+					   0, 1);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_ddr_disable(st->back);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static inline int ad3552r_hs_set_output_range(struct ad3552r_hs_state *st,
+					      int ch, unsigned int mode)
+{
+	int val;
+
+	if (ch == 0)
+		val = FIELD_PREP(AD3552R_MASK_CH0_RANGE, mode);
+	else
+		val = FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode);
+
+	return ad3552r_qspi_update_reg_bits(st,
+					AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+					AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
+					val, 1);
+}
+
+static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
+{
+	int ret;
+
+	/*
+	 * Using inverted "active-high" logic here, since ad3552r classic-spi
+	 * fdt node (and driver) is using the same logic.
+	 */
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
+		ret = ad3552r_qspi_update_reg_bits(st,
+					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
+					AD3552R_MASK_SOFTWARE_RESET,
+					AD3552R_MASK_SOFTWARE_RESET, 1);
+		if (ret)
+			return ret;
+	}
+	msleep(100);
+
+	return 0;
+}
+
+static int ad3552r_hs_scratch_pad_test(struct ad3552r_hs_state *st)
+{
+	int ret, val;
+
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				      AD3552R_SCRATCH_PAD_TEST_VAL1, 1);
+	if (ret)
+		return ret;
+
+	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				     &val, 1);
+	if (ret)
+		return ret;
+
+	if (val != AD3552R_SCRATCH_PAD_TEST_VAL1)
+		return dev_err_probe(st->dev, -EIO,
+			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
+			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
+
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				      AD3552R_SCRATCH_PAD_TEST_VAL2, 1);
+	if (ret)
+		return ret;
+
+	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
+				     &val, 1);
+	if (ret)
+		return ret;
+
+	if (val != AD3552R_SCRATCH_PAD_TEST_VAL2)
+		return dev_err_probe(st->dev, -EIO,
+			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
+			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
+
+	return 0;
+}
+
+static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
+					int ch, u16 gain, u16 offset)
+{
+	int ret;
+
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_OFFSET(ch),
+				      offset, 1);
+	if (ret)
+		return dev_err_probe(st->dev, ret, "Error writing register\n");
+
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(ch),
+				      gain, 1);
+	if (ret)
+		return dev_err_probe(st->dev, ret, "Error writing register\n");
+
+	return 0;
+}
+
+static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
+{
+	s16 goffs;
+	u16 id;
+	u16 gain = 0, offset = 0;
+	u32 ch, val, range;
+	int ret;
+
+	ret = ad3552r_hs_reset(st);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_ddr_disable(st->back);
+	if (ret)
+		return ret;
+
+	ret = ad3552r_hs_scratch_pad_test(st);
+	if (ret)
+		return ret;
+
+	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
+				     &val, 1);
+	if (ret)
+		return ret;
+
+	id = val;
+
+	ret = st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
+				     &val, 1);
+	if (ret)
+		return ret;
+
+	id |= val << 8;
+	if (id != st->model_data->chip_id)
+		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
+			 AD3552R_ID, id);
+
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				      0, 1);
+	if (ret)
+		return ret;
+
+	ret = st->data->bus_reg_write(st->back,
+				AD3552R_REG_ADDR_TRANSFER_REGISTER,
+				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
+					   AD3552R_QUAD_SPI) |
+				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
+	if (ret)
+		return ret;
+
+	ret = ad3552r_get_ref_voltage(st->dev, &val);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	ret = ad3552r_qspi_update_reg_bits(st,
+				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
+				val, 1);
+	if (ret)
+		return ret;
+
+	ret = ad3552r_get_drive_strength(st->dev, &val);
+	if (!ret) {
+		ret = ad3552r_qspi_update_reg_bits(st,
+					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					AD3552R_MASK_SDO_DRIVE_STRENGTH,
+					val, 1);
+		if (ret)
+			return ret;
+	}
+
+	device_for_each_child_node_scoped(st->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return dev_err_probe(st->dev, ret,
+					     "reg property missing\n");
+
+		ret = ad3552r_get_output_range(st->dev, st->model_data, child,
+					       &range);
+		if (!ret) {
+			st->ch_data[ch].range = range;
+
+			ret = ad3552r_hs_set_output_range(st, ch, range);
+			if (ret)
+				return ret;
+
+		} else if (ret == -ENOENT) {
+			ret = ad3552r_get_custom_gain(st->dev, child,
+						&st->ch_data[ch].p,
+						&st->ch_data[ch].n,
+						&st->ch_data[ch].rfb,
+						&st->ch_data[ch].gain_offset);
+			if (ret)
+				return ret;
+
+			gain = ad3552r_calc_custom_gain(st->ch_data[ch].p,
+						st->ch_data[ch].n,
+						st->ch_data[ch].gain_offset);
+			offset = abs(goffs);
+
+			st->ch_data[ch].range_override = 1;
+
+			ret = ad3552r_hs_setup_custom_gain(st, ch, gain,
+							   offset);
+			if (ret)
+				return ret;
+		} else {
+			return ret;
+		}
+
+		ad3552r_calc_gain_and_offset(&st->ch_data[ch], st->model_data);
+	}
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad3552r_hs_buffer_setup_ops = {
+	.postenable = ad3552r_hs_buffer_postenable,
+	.predisable = ad3552r_hs_buffer_predisable,
+};
+
+#define AD3552R_CHANNEL(ch) { \
+	.type = IIO_VOLTAGE, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
+			      BIT(IIO_CHAN_INFO_OFFSET), \
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
+		return dev_err_probe(st->dev, -ENODEV, "No platform data !");
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
+	if (!st->model_data)
+		return -ENODEV;
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
+static struct platform_driver ad3552r_hs_driver = {
+	.driver = {
+		.name = "ad3552r-hs",
+		.of_match_table = ad3552r_hs_of_id,
+	},
+	.probe = ad3552r_hs_probe,
+};
+module_platform_driver(ad3552r_hs_driver);
+
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_AUTHOR("Angelo Dureghello <adueghello@baylibre.com>");
+MODULE_DESCRIPTION("AD3552R Driver - High Speed version");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BACKEND);
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
index 22bd9ad27c65..6120a08e08a4 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -129,8 +129,12 @@
 #define AD3552R_GAIN_SCALE				1000
 #define AD3552R_LDAC_PULSE_US				100
 
+#define AD3552R_CH0_ACTIVE				BIT(0)
+#define AD3552R_CH1_ACTIVE				BIT(1)
+
 #define AD3552R_MAX_RANGES	5
 #define AD3542R_MAX_RANGES	6
+#define AD3552R_QUAD_SPI	2
 
 extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
 extern const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2];

-- 
2.45.0.rc1


