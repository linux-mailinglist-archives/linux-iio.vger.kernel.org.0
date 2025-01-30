Return-Path: <linux-iio+bounces-14728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F704A22C39
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 12:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B7C7A2266
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2CA1E25F7;
	Thu, 30 Jan 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SDVALk9Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA871DE4E5
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235337; cv=none; b=rTHBuMTVDB+v9up3k8JqlcDr3lbbS/+UnqGaHiE/ylVt6cD9FyKMYNxsk7adhcXXgla64N42iNZMJGlurS1GeV5P0rNRwahEq3V4zgQtAgg1OhNlvUqnXFYWxgk/m6RsEYMQzg1Rz2QqIgYMoo1/ZF2ZH7ntc8o79MxfHc8tn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235337; c=relaxed/simple;
	bh=gBShLXgY42Nrg8z2tizx1TfeCixJE2QnYRnQRfA38XU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iV4OgSoOrf4BFw9xv1jBWVBOlEEjnADnJnccxfyCiijmEOsP4Z8iu+XjDyitGRrJ5qPAJVuEiZaXF4XiQve/YNViLFu0WszBt2D3Wj7Gph2B/HUCzYTE7aTDbYjgPd8i5F1vn3vxgS7zKgBsseVxS1Gx8xOlUSO/lI8TgcIYo78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SDVALk9Y; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385d7f19f20so301100f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 03:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738235332; x=1738840132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjhx5wt9QQEtO0Jg4tpIA+eRyiWc20pVAzwO1JbnIpg=;
        b=SDVALk9Y1zhDwokd+x98IpzGHiH/6+VZ/GoVEs4iJdfYIlfqoecvMWCMAXAPPQtstJ
         tVxksD4Ae8vsITTVxvpfrDC3G/U000P0mDNMAhimY0tv4a85LtcLn+NqF5LODXT/bMl6
         1xKEm7PbAL0eC54phegCqYJt36PFY7Yo9NEPKJTljFo3vA2uF2ji6KVpDwQ6NptnsgTB
         JASW2S9iVsEWwYGXqZ2eyz2jqShucykA07lLvr2kUMM8a3aA9zwokqbGG2M7iuETkymi
         S81xivYWGZy2UacXWwtSACfwYGRj3oguyyV4zySgxQxxiJMfdapCXxGXJkc2hAg6cz6V
         1QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738235332; x=1738840132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjhx5wt9QQEtO0Jg4tpIA+eRyiWc20pVAzwO1JbnIpg=;
        b=jHxkTqAguFQffUQyeOrVl0ZYbxQ46bsUSEfaCXYbOEy04h5dYsBG0+mg0mPBIruYTu
         2+YBWhwyWNPYVcYM/J4CnKBszHtWtuUbWb9tU2gOr1yoPHpn6I3AiiVg6y61yUu7z2ZS
         dEg8CXzJh4t4WOkZzU3zCBnmqavds9xGJBJwkjHo0AScuPa3sn9ACg0RIUkYlm8UlNbN
         byiVjy1dAMwHw4QdH+jmAnW67RbyIzz7pQO1Uvl86gz69JJKjiLOzjXevGBb4le95eg0
         1ZrGQO+oxEeNcd0mns3n3eUJ7MkAKc43DRx3KJMCz08Xn/IUWwb+pwlJfiOfZ+Jl0CVG
         Sj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBZVZHuJPh1zgNPqMJVw3e+sdCPttxlcyBjNFuMURwDmhCBZkGwTIH+SfT9UBQCpQPLpmdRJHzlaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuFhKgtb/zDLA1hT9ypgjIqP7d98Fvv2DGZDXK4Wh9j3igD8LF
	PV8TC4EAZMPrubXfRH0+VS8UlIRHa0ubaBDgVv2LLplgOHmvXg7RqzkMATNKRA8=
X-Gm-Gg: ASbGnctdJgV1dTeEW804+UVWqaNl1CHtkreO4XVH2gNXvVDfBqYHrliBPN9FJmIjunV
	zUFSx4Oy0IqcdWEKwADjYnMOgDA1xp+glYPDJPdFv4IAEbJLT85FgJAfJKBjsTQNL75uBVuqTTt
	yi+YeHzoqlYlV0CgS191CwBQmUrNkTW0OFq0jctOXVHRjJCij5i4xeKf0kLxtaFh3/GY+lZaRva
	XsZg4AZQ4TM/Ynp4Sh4Atp4EGyf7ZTKUfQyLCEUbH3pi7GJdMgW3lIfwefLrS4xu3JhO6Jicrg+
	rtbycqq1u+kFhazj
X-Google-Smtp-Source: AGHT+IFjoI61yKAH1/qlcMkFEZtKJU8SHD1shEUiDlMDgKswhqK3QewTAvmaNHhSSflrdl7MYyCS1g==
X-Received: by 2002:a5d:588c:0:b0:385:f38e:c0c3 with SMTP id ffacd0b85a97d-38c51930ff6mr5793910f8f.6.1738235330319;
        Thu, 30 Jan 2025 03:08:50 -0800 (PST)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:2c72:cd2d:79b2:82ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c102bb2sm1689225f8f.34.2025.01.30.03.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 03:08:49 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 30 Jan 2025 12:08:26 +0100
Subject: [PATCH v3 2/6] iio: adc: ad4030: add driver for ad4030-24
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250130-eblanc-ad4630_v1-v3-2-052e8c2d897d@baylibre.com>
References: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
In-Reply-To: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.2

This adds a new driver for the Analog Devices INC. AD4030-24 ADC.

The driver implements basic support for the AD4030-24 1 channel
differential ADC with hardware gain and offset control.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  14 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4030.c | 934 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 950 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01e76f76b051b566b0aed48011621e170f192a2b..9571a917b0437a802190101c0a83bba9bf790ffc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1281,6 +1281,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+F:	drivers/iio/adc/ad4030.c
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071a77ec7d94cec06d4378ece44440b..9677343a3269db6405dfdd4e938423806c891b47 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -33,6 +33,20 @@ config AD4000
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4000.
 
+config AD4030
+	tristate "Analog Devices AD4030 ADC Driver"
+	depends on SPI
+	depends on GPIOLIB
+	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices AD4030 and AD4630 high speed
+	  SPI analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4030.
+
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ee19afba62b7fe0a68309c16f3581d98c5b8f653..326536bb672da3d6229b66af13874d122b2f7b94 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
+obj-$(CONFIG_AD4030) += ad4030.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
new file mode 100644
index 0000000000000000000000000000000000000000..e06424b7f2590d28a57943949b070cd7e185fbb7
--- /dev/null
+++ b/drivers/iio/adc/ad4030.c
@@ -0,0 +1,934 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD4030 and AD4630 ADC family driver.
+ *
+ * Copyright 2024 Analog Devices, Inc.
+ * Copyright 2024 BayLibre, SAS
+ *
+ * based on code from:
+ *	Analog Devices, Inc.
+ *	  Sergiu Cuciurean <sergiu.cuciurean@analog.com>
+ *	  Nuno Sa <nuno.sa@analog.com>
+ *	  Marcelo Schmitt <marcelo.schmitt@analog.com>
+ *	  Liviu Adace <liviu.adace@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#define AD4030_REG_INTERFACE_CONFIG_A			0x00
+#define     AD4030_REG_INTERFACE_CONFIG_A_SW_RESET	(BIT(0) | BIT(7))
+#define AD4030_REG_INTERFACE_CONFIG_B			0x01
+#define AD4030_REG_DEVICE_CONFIG			0x02
+#define AD4030_REG_CHIP_TYPE				0x03
+#define AD4030_REG_PRODUCT_ID_L				0x04
+#define AD4030_REG_PRODUCT_ID_H				0x05
+#define AD4030_REG_CHIP_GRADE				0x06
+#define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
+#define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
+#define AD4030_REG_SCRATCH_PAD			0x0A
+#define AD4030_REG_SPI_REVISION			0x0B
+#define AD4030_REG_VENDOR_L			0x0C
+#define AD4030_REG_VENDOR_H			0x0D
+#define AD4030_REG_STREAM_MODE			0x0E
+#define AD4030_REG_INTERFACE_CONFIG_C		0x10
+#define AD4030_REG_INTERFACE_STATUS_A		0x11
+#define AD4030_REG_EXIT_CFG_MODE		0x14
+#define     AD4030_REG_EXIT_CFG_MODE_EXIT_MSK	BIT(0)
+#define AD4030_REG_AVG				0x15
+#define     AD4030_REG_AVG_MASK_AVG_SYNC	BIT(7)
+#define     AD4030_REG_AVG_MASK_AVG_VAL		GENMASK(4, 0)
+#define AD4030_REG_OFFSET_X0_0			0x16
+#define AD4030_REG_OFFSET_X0_1			0x17
+#define AD4030_REG_OFFSET_X0_2			0x18
+#define AD4030_REG_OFFSET_X1_0			0x19
+#define AD4030_REG_OFFSET_X1_1			0x1A
+#define AD4030_REG_OFFSET_X1_2			0x1B
+#define     AD4030_REG_OFFSET_BYTES_NB		3
+#define     AD4030_REG_OFFSET_CHAN(ch)		(AD4030_REG_OFFSET_X0_2 + \
+						(AD4030_REG_OFFSET_BYTES_NB * \
+						(ch)))
+#define AD4030_REG_GAIN_X0_LSB			0x1C
+#define AD4030_REG_GAIN_X0_MSB			0x1D
+#define AD4030_REG_GAIN_X1_LSB			0x1E
+#define AD4030_REG_GAIN_X1_MSB			0x1F
+#define     AD4030_REG_GAIN_MAX_GAIN		1999970
+#define     AD4030_REG_GAIN_BYTES_NB		2
+#define     AD4030_REG_GAIN_CHAN(ch)		(AD4030_REG_GAIN_X0_MSB + \
+						(AD4030_REG_GAIN_BYTES_NB * \
+						(ch)))
+#define AD4030_REG_MODES			0x20
+#define     AD4030_REG_MODES_MASK_OUT_DATA_MODE	GENMASK(2, 0)
+#define     AD4030_REG_MODES_MASK_LANE_MODE	GENMASK(7, 6)
+#define AD4030_REG_OSCILATOR			0x21
+#define AD4030_REG_IO				0x22
+#define     AD4030_REG_IO_MASK_IO2X		BIT(1)
+#define AD4030_REG_PAT0				0x23
+#define AD4030_REG_PAT1				0x24
+#define AD4030_REG_PAT2				0x25
+#define AD4030_REG_PAT3				0x26
+#define AD4030_REG_DIG_DIAG			0x34
+#define AD4030_REG_DIG_ERR			0x35
+
+/* Sequence starting with "1 0 1" to enable reg access */
+#define AD4030_REG_ACCESS			0xA0
+
+#define AD4030_MAX_IIO_SAMPLE_SIZE_BUFFERED	BITS_TO_BYTES(64)
+#define AD4030_MAX_HARDWARE_CHANNEL_NB		2
+#define AD4030_MAX_IIO_CHANNEL_NB		5
+#define AD4030_SINGLE_COMMON_BYTE_CHANNELS_MASK	0b10
+#define AD4030_GAIN_MIDLE_POINT			0x8000
+/*
+ * This accounts for 1 sample per channel plus one s64 for the timestamp,
+ * aligned on a s64 boundary
+ */
+#define AD4030_MAXIMUM_RX_BUFFER_SIZE			\
+	(ALIGN(AD4030_MAX_IIO_SAMPLE_SIZE_BUFFERED *	\
+	      AD4030_MAX_HARDWARE_CHANNEL_NB,		\
+	      sizeof(s64)) + sizeof(s64))
+
+#define AD4030_VREF_MIN_UV		(4096 * MILLI)
+#define AD4030_VREF_MAX_UV		(5000 * MILLI)
+#define AD4030_VIO_THRESHOLD_UV		(1400 * MILLI)
+#define AD4030_SPI_MAX_XFER_LEN		8
+#define AD4030_SPI_MAX_REG_XFER_SPEED	(80 * MEGA)
+#define AD4030_TCNVH_NS			10
+#define AD4030_TCNVL_NS			20
+#define AD4030_TCYC_NS			500
+#define AD4030_TCYC_ADJUSTED_NS		(AD4030_TCYC_NS - AD4030_TCNVL_NS)
+#define AD4030_TRESET_PW_NS		50
+
+enum ad4030_out_mode {
+	AD4030_OUT_DATA_MD_DIFF,
+	AD4030_OUT_DATA_MD_16_DIFF_8_COM,
+	AD4030_OUT_DATA_MD_24_DIFF_8_COM,
+	AD4030_OUT_DATA_MD_30_AVERAGED_DIFF,
+	AD4030_OUT_DATA_MD_32_PATTERN
+};
+
+struct ad4030_chip_info {
+	const char *name;
+	const unsigned long *available_masks;
+	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];
+	u8 grade;
+	u8 precision_bits;
+	/* Number of hardware channels */
+	int num_voltage_inputs;
+	unsigned int tcyc_ns;
+};
+
+struct ad4030_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	const struct ad4030_chip_info *chip;
+	struct gpio_desc *cnv_gpio;
+	int vref_uv;
+	int vio_uv;
+	int offset_avail[3];
+	enum ad4030_out_mode mode;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 */
+	u8 tx_data[AD4030_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	union {
+		u8 raw[AD4030_MAXIMUM_RX_BUFFER_SIZE];
+		struct {
+			s32 diff;
+			u8 common;
+		};
+	} rx_data;
+};
+
+/*
+ * For a chip with 2 hardware channel this will be used to create 2 common-mode
+ * channels:
+ * - voltage4
+ * - voltage5
+ * As the common-mode channels are after the differential ones, we compute the
+ * channel number like this:
+ * - _idx is the scan_index (the order in the output buffer)
+ * - _ch is the hardware channel number this common-mode channel is related
+ * - _idx - _ch gives us the number of channel in the chip
+ * - _idx - _ch * 2 is the starting number of the common-mode channels, since
+ *   for each differential channel there is a common-mode channel
+ * - _idx - _ch * 2 + _ch gives the channel number for this specific common-mode
+ *   channel
+ */
+#define AD4030_CHAN_CMO(_idx, _ch)  {					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.address = (_ch),						\
+	.channel = ((_idx) - (_ch)) * 2 + (_ch),			\
+	.scan_index = (_idx),						\
+	.scan_type = {							\
+		.sign = 'u',						\
+		.storagebits = 8,					\
+		.realbits = 8,						\
+		.endianness = IIO_BE,					\
+	},								\
+}
+
+/*
+ * For a chip with 2 hardware channel this will be used to create 2 differential
+ * channels:
+ * - voltage0-voltage1
+ * - voltage2-voltage3
+ */
+#define AD4030_CHAN_DIFF(_idx, _storage, _real, _shift) {		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_CALIBSCALE) |				\
+		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
+		BIT(IIO_CHAN_INFO_RAW),					\
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
+		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.address = (_idx),						\
+	.channel = (_idx) * 2,						\
+	.channel2 = (_idx) * 2 + 1,					\
+	.scan_index = (_idx),						\
+	.differential = true,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.storagebits = _storage,				\
+		.realbits = _real,					\
+		.shift = _shift,					\
+		.endianness = IIO_BE,					\
+	},								\
+}
+
+static int ad4030_enter_config_mode(struct ad4030_state *st)
+{
+	st->tx_data[0] = AD4030_REG_ACCESS;
+
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_data,
+		.bits_per_word = 8,
+		.len = 1,
+		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
+	};
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad4030_exit_config_mode(struct ad4030_state *st)
+{
+	st->tx_data[0] = 0;
+	st->tx_data[1] = AD4030_REG_EXIT_CFG_MODE;
+	st->tx_data[2] = AD4030_REG_EXIT_CFG_MODE_EXIT_MSK;
+
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_data,
+		.bits_per_word = 8,
+		.len = 3,
+		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
+	};
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	int ret;
+	struct ad4030_state *st = context;
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_data,
+		.rx_buf = st->rx_data.raw,
+		.bits_per_word = 8,
+		.len = reg_size + val_size,
+		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
+	};
+
+	if (xfer.len > ARRAY_SIZE(st->tx_data) ||
+	    xfer.len > ARRAY_SIZE(st->rx_data.raw))
+		return  -EINVAL;
+
+	ret = ad4030_enter_config_mode(st);
+	if (ret)
+		return ret;
+
+	memset(st->tx_data, 0, ARRAY_SIZE(st->tx_data));
+	memcpy(st->tx_data, reg, reg_size);
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	memcpy(val, &st->rx_data.raw[reg_size], val_size);
+
+	return ad4030_exit_config_mode(st);
+}
+
+static int ad4030_spi_write(void *context, const void *data, size_t count)
+{
+	int ret;
+	struct ad4030_state *st = context;
+	bool is_reset = count >= 3 &&
+			((u8 *)data)[0] == 0 &&
+			((u8 *)data)[1] == 0 &&
+			((u8 *)data)[2] == 0x81;
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_data,
+		.bits_per_word = 8,
+		.len = count,
+		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
+	};
+
+	if (count > ARRAY_SIZE(st->tx_data))
+		return  -EINVAL;
+
+	ret = ad4030_enter_config_mode(st);
+	if (ret)
+		return ret;
+
+	memcpy(st->tx_data, data, count);
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * From datasheet: "After a [...] reset, no SPI commands or conversions
+	 * can be started for 750us"
+	 *  After a reset we are in conversion mode, no need to exit config mode
+	 */
+	if (is_reset) {
+		fsleep(750);
+		return 0;
+	}
+
+	return ad4030_exit_config_mode(st);
+}
+
+static const struct regmap_bus ad4030_regmap_bus = {
+	.read = ad4030_spi_read,
+	.write = ad4030_spi_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static const struct regmap_range ad4030_regmap_rd_range[] = {
+	regmap_reg_range(AD4030_REG_INTERFACE_CONFIG_A, AD4030_REG_CHIP_GRADE),
+	regmap_reg_range(AD4030_REG_SCRATCH_PAD, AD4030_REG_STREAM_MODE),
+	regmap_reg_range(AD4030_REG_INTERFACE_CONFIG_C,
+			 AD4030_REG_INTERFACE_STATUS_A),
+	regmap_reg_range(AD4030_REG_EXIT_CFG_MODE, AD4030_REG_PAT3),
+	regmap_reg_range(AD4030_REG_DIG_DIAG, AD4030_REG_DIG_ERR),
+};
+
+static const struct regmap_range ad4030_regmap_wr_range[] = {
+	regmap_reg_range(AD4030_REG_CHIP_TYPE, AD4030_REG_CHIP_GRADE),
+	regmap_reg_range(AD4030_REG_SPI_REVISION, AD4030_REG_VENDOR_H),
+};
+
+static const struct regmap_access_table ad4030_regmap_rd_table = {
+	.yes_ranges = ad4030_regmap_rd_range,
+	.n_yes_ranges = ARRAY_SIZE(ad4030_regmap_rd_range),
+};
+
+static const struct regmap_access_table ad4030_regmap_wr_table = {
+	.no_ranges = ad4030_regmap_wr_range,
+	.n_no_ranges = ARRAY_SIZE(ad4030_regmap_wr_range),
+};
+
+static const struct regmap_config ad4030_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = 0x80,
+	.rd_table = &ad4030_regmap_rd_table,
+	.wr_table = &ad4030_regmap_wr_table,
+	.max_register = AD4030_REG_DIG_ERR,
+};
+
+static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val,
+				 int *val2)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	if (chan->differential) {
+		*val = (st->vref_uv * 2) / MILLI;
+		*val2 = st->chip->precision_bits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	*val = st->vref_uv / 256;
+	return IIO_VAL_INT;
+}
+
+static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val,
+				      int *val2)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	u16 gain;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, AD4030_REG_GAIN_CHAN(chan->address),
+			       st->rx_data.raw, AD4030_REG_GAIN_BYTES_NB);
+	if (ret)
+		return ret;
+
+	gain = get_unaligned_be16(st->rx_data.raw);
+
+	/* From datasheet: multiplied output = input × gain word/0x8000 */
+	*val = gain / AD4030_GAIN_MIDLE_POINT;
+	*val2 = mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, NANO,
+				AD4030_GAIN_MIDLE_POINT);
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+/* Returns the offset where 1 LSB = (VREF/2^precision_bits - 1)/gain */
+static int ad4030_get_chan_calibbias(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     int *val)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap,
+			       AD4030_REG_OFFSET_CHAN(chan->address),
+			       st->rx_data.raw, AD4030_REG_OFFSET_BYTES_NB);
+	if (ret)
+		return ret;
+
+	switch (st->chip->precision_bits) {
+	case 16:
+		*val = sign_extend32(get_unaligned_be16(st->rx_data.raw), 15);
+		return IIO_VAL_INT;
+
+	case 24:
+		*val = sign_extend32(get_unaligned_be24(st->rx_data.raw), 23);
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int gain_int,
+				      int gain_frac)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	u64 gain;
+
+	if (gain_int < 0 || gain_frac < 0)
+		return -EINVAL;
+
+	gain = mul_u32_u32(gain_int, MICRO) + gain_frac;
+
+	if (gain > AD4030_REG_GAIN_MAX_GAIN)
+		return -EINVAL;
+
+	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL(gain * AD4030_GAIN_MIDLE_POINT,
+						 MICRO),
+			   st->tx_data);
+
+	return regmap_bulk_write(st->regmap,
+				 AD4030_REG_GAIN_CHAN(chan->address),
+				 st->tx_data, AD4030_REG_GAIN_BYTES_NB);
+}
+
+static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     int offset)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	if (offset < st->offset_avail[0] || offset > st->offset_avail[2])
+		return -EINVAL;
+
+	st->tx_data[2] = 0;
+
+	switch (st->chip->precision_bits) {
+	case 16:
+		put_unaligned_be16(offset, st->tx_data);
+		break;
+
+	case 24:
+		put_unaligned_be24(offset, st->tx_data);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_bulk_write(st->regmap,
+				 AD4030_REG_OFFSET_CHAN(chan->address),
+				 st->tx_data, AD4030_REG_OFFSET_BYTES_NB);
+}
+
+static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
+					unsigned int mask)
+{
+	return mask & AD4030_SINGLE_COMMON_BYTE_CHANNELS_MASK;
+}
+
+static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	if (ad4030_is_common_byte_asked(st, mask))
+		st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
+	else
+		st->mode = AD4030_OUT_DATA_MD_DIFF;
+
+	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
+				  AD4030_REG_MODES_MASK_OUT_DATA_MODE,
+				  st->mode);
+}
+
+static int ad4030_conversion(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type scan_type = indio_dev->channels->scan_type;
+	unsigned char diff_realbytes = BITS_TO_BYTES(scan_type.realbits);
+	unsigned int bytes_to_read;
+	int ret;
+
+	/* Number of bytes for one differential channel */
+	bytes_to_read = diff_realbytes;
+	/* Add one byte if we are using a differential + common byte mode */
+	bytes_to_read += (st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
+			st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 1 : 0;
+	/* Mulitiply by the number of hardware channels */
+	bytes_to_read *= st->chip->num_voltage_inputs;
+
+	gpiod_set_value_cansleep(st->cnv_gpio, 1);
+	ndelay(AD4030_TCNVH_NS);
+	gpiod_set_value_cansleep(st->cnv_gpio, 0);
+	ndelay(st->chip->tcyc_ns);
+
+	ret = spi_read(st->spi, st->rx_data.raw, bytes_to_read);
+	if (ret)
+		return ret;
+
+	if (st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
+		return 0;
+
+	st->rx_data.common = st->rx_data.raw[diff_realbytes];
+
+	return 0;
+}
+
+static int ad4030_single_conversion(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan, int *val)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4030_set_mode(indio_dev, BIT(chan->scan_index));
+	if (ret)
+		return ret;
+
+	ret = ad4030_conversion(indio_dev);
+	if (ret)
+		return ret;
+
+	if (chan->differential)
+		*val = st->rx_data.diff;
+	else
+		*val = st->rx_data.common;
+
+	return IIO_VAL_INT;
+}
+
+static irqreturn_t ad4030_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4030_conversion(indio_dev);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_data.raw,
+					   pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static const int ad4030_gain_avail[3][2] = {
+	{ 0, 0 },
+	{ 0, 30518 },
+	{ 1, 999969482 },
+};
+
+static int ad4030_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *channel,
+			     const int **vals, int *type,
+			     int *length, long mask)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = st->offset_avail;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*vals = (void *)ad4030_gain_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_RANGE;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, int *val,
+				    int *val2, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return ad4030_single_conversion(indio_dev, chan, val);
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4030_get_chan_calibscale(indio_dev, chan, val, val2);
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad4030_get_chan_calibbias(indio_dev, chan, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4030_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long info)
+{
+	int ret;
+
+	if (info == IIO_CHAN_INFO_SCALE)
+		return ad4030_get_chan_scale(indio_dev, chan, val, val2);
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad4030_read_raw_dispatch(indio_dev, chan, val, val2, info);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan, int val,
+				     int val2, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4030_set_chan_calibscale(indio_dev, chan, val, val2);
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val2 != 0)
+			return -EINVAL;
+		return ad4030_set_chan_calibbias(indio_dev, chan, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4030_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long info)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad4030_write_raw_dispatch(indio_dev, chan, val, val2, info);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static int ad4030_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	const struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
+}
+
+static int ad4030_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     char *label)
+{
+	if (chan->differential)
+		return sprintf(label, "differential%lu\n", chan->address);
+	return sprintf(label, "common-mode%lu\n", chan->address);
+}
+
+static const struct iio_info ad4030_iio_info = {
+	.read_avail = ad4030_read_avail,
+	.read_raw = ad4030_read_raw,
+	.write_raw = ad4030_write_raw,
+	.debugfs_reg_access = ad4030_reg_access,
+	.read_label = ad4030_read_label,
+};
+
+static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4030_set_mode(indio_dev, *indio_dev->active_scan_mask);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
+	.preenable = ad4030_buffer_preenable,
+};
+
+static int ad4030_regulators_get(struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	static const char * const ids[] = { "vdd-5v", "vdd-1v8" };
+	int ret;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ids), ids);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	st->vio_uv = devm_regulator_get_enable_read_voltage(dev, "vio");
+	if (st->vio_uv < 0)
+		return dev_err_probe(dev, st->vio_uv,
+				     "Failed to enable and read vio voltage\n");
+
+	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (st->vref_uv < 0) {
+		if (st->vref_uv != -ENODEV)
+			return dev_err_probe(dev, st->vref_uv,
+					     "Failed to read ref voltage\n");
+
+		/* if not using optional REF, the internal REFIN must be used */
+		st->vref_uv = devm_regulator_get_enable_read_voltage(dev,
+								     "refin");
+		if (st->vref_uv < 0)
+			return dev_err_probe(dev, st->vref_uv,
+					     "Failed to read refin voltage\n");
+	}
+
+	return 0;
+}
+
+static int ad4030_reset(struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct gpio_desc *reset;
+	int ret;
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset),
+				     "Failed to get reset GPIO\n");
+
+	if (reset) {
+		ndelay(50);
+		gpiod_set_value_cansleep(reset, 0);
+	} else {
+		ret = regmap_write(st->regmap, AD4030_REG_INTERFACE_CONFIG_A,
+				   AD4030_REG_INTERFACE_CONFIG_A_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad4030_detect_chip_info(const struct ad4030_state *st)
+{
+	unsigned int grade;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD4030_REG_CHIP_GRADE, &grade);
+	if (ret)
+		return ret;
+
+	grade = FIELD_GET(AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE, grade);
+	if (grade != st->chip->grade)
+		dev_warn(&st->spi->dev, "Unknown grade(0x%x) for %s\n", grade,
+			 st->chip->name);
+
+	return 0;
+}
+
+static int ad4030_config(struct ad4030_state *st)
+{
+	st->offset_avail[0] = (int)BIT(st->chip->precision_bits - 1) * -1;
+	st->offset_avail[1] = 1;
+	st->offset_avail[2] = BIT(st->chip->precision_bits - 1) - 1;
+
+	if (st->vio_uv < AD4030_VIO_THRESHOLD_UV)
+		return regmap_write(st->regmap, AD4030_REG_IO,
+				    AD4030_REG_IO_MASK_IO2X);
+
+	return 0;
+}
+
+static int ad4030_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad4030_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	st->regmap = devm_regmap_init(dev, &ad4030_regmap_bus, st,
+				      &ad4030_regmap_config);
+	if (IS_ERR(st->regmap))
+		dev_err_probe(dev, PTR_ERR(st->regmap),
+			      "Failed to initialize regmap\n");
+
+	st->chip = spi_get_device_match_data(spi);
+	if (!st->chip)
+		return -EINVAL;
+
+	ret = ad4030_regulators_get(st);
+	if (ret)
+		return ret;
+
+	/*
+	 * From datasheet: "Perform a reset no sooner than 3ms after the power
+	 * supplies are valid and stable"
+	 */
+	fsleep(3000);
+
+	ret = ad4030_reset(st);
+	if (ret)
+		return ret;
+
+	ret = ad4030_detect_chip_info(st);
+	if (ret)
+		return ret;
+
+	ret = ad4030_config(st);
+	if (ret)
+		return ret;
+
+	st->cnv_gpio = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
+	if (IS_ERR(st->cnv_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
+				     "Failed to get cnv gpio\n");
+
+	/*
+	 * One hardware channel is split in two software channels when using
+	 * common byte mode. Add one more channel for the timestamp.
+	 */
+	indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
+	indio_dev->name = st->chip->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad4030_iio_info;
+	indio_dev->channels = st->chip->channels;
+	indio_dev->available_scan_masks = st->chip->available_masks;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad4030_trigger_handler,
+					      &ad4030_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to setup triggered buffer\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const unsigned long ad4030_channel_masks[] = {
+	/* Differential only */
+	BIT(0),
+	/* Differential and common-mode voltage */
+	GENMASK(1, 0),
+	0,
+};
+
+static const struct ad4030_chip_info ad4030_24_chip_info = {
+	.name = "ad4030-24",
+	.available_masks = ad4030_channel_masks,
+	.channels = {
+		AD4030_CHAN_DIFF(0, 32, 24, 8),
+		AD4030_CHAN_CMO(1, 0),
+		IIO_CHAN_SOFT_TIMESTAMP(2),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
+	.precision_bits = 24,
+	.num_voltage_inputs = 1,
+	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+};
+
+static const struct spi_device_id ad4030_id_table[] = {
+	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4030_id_table);
+
+static const struct of_device_id ad4030_of_match[] = {
+	{ .compatible = "adi,ad4030-24", .data = &ad4030_24_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4030_of_match);
+
+static struct spi_driver ad4030_driver = {
+	.driver = {
+		.name = "ad4030",
+		.of_match_table = ad4030_of_match,
+	},
+	.probe = ad4030_probe,
+	.id_table = ad4030_id_table,
+};
+module_spi_driver(ad4030_driver);
+
+MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
+MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
+MODULE_LICENSE("GPL");

-- 
2.47.2


