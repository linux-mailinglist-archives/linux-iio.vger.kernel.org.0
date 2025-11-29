Return-Path: <linux-iio+bounces-26558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6821C9376F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 04:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DDD3AA0C3
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 03:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13385233D88;
	Sat, 29 Nov 2025 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjt8GW2l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B99222560
	for <linux-iio@vger.kernel.org>; Sat, 29 Nov 2025 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388063; cv=none; b=IG1fPidBqjylSjtCctGKSpeRKvdUNhZ2xRI1F48oTxu2cjJbhugPUxi95arQ+nclvb7pR4LHR0RO5dB1giCENNVNB/IsZdfx1G19kHQ3ZS17DZV/xr3kcrq5jOSBZxmCG5jnuMJZUz8pFNKxoFjs0hCmVv88yn2MVm2oMOhEnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388063; c=relaxed/simple;
	bh=vVyK2OA9BueB0Wqbshf0aIbe/dr0Ml0Vv7Dw2/Y6QzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ji20fHAgNo+LbGhY8ySU212F+JFtrwLLB4kvEQRxlawKPWf0Lq1lXq567MNsSnTYCcR8X8fwbk6slIZUw7fSPQfUschrCJdq+42cOOj0LMUL0NdQLt7ZAMXadpaCX5/MzKHeNxolauWjXJUxudmKbkMHQOL2MrbdqRpAaczzqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjt8GW2l; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5e18598b9b1so1749873137.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 19:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764388060; x=1764992860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmni4V+uKnAPjyol8loTSbjc9cQwYf5Y7BodpeonkIM=;
        b=Rjt8GW2lo2+c3PzBtbVHbdoMtwW/VD5KX0Izp0y3CA1y6mTNFWKcTLKf/6I2B/GZ51
         gX017zOkXMWxB1GrOcGu2wKc0n+rm9rgUs0oqM8bsvt1HxykDd/txMGMs/NnLEV7aj0+
         S5FJtBqijkmDDhsHAiFxcLtpIHgvLvVkJQAbezhc60lyG+ZFx8sU8bk5NjF2Ood7o8it
         XiKH2zpfqhSXy+WfrfPkkqm6hXj8g0P7QFpwUphYmUQN+Hg4KqyVNzN+1vtlIQ+XOPLu
         iA4+EFkhIVSh8o71t+c3AyOsD3luatsDzIFaP39ojL1scNf2T1akRmC2ErQYSOEjTkFX
         7Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764388060; x=1764992860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rmni4V+uKnAPjyol8loTSbjc9cQwYf5Y7BodpeonkIM=;
        b=UiR6a6exLj5rGMQi1i6/PFysWtUNsU6SsGYZWB1bOU8apffNJAuCLqGhTK9YihZf/C
         uRf4Rq3QrrHzbN3GcqarNW/CT/AOqJjf0miavsnX4IdVvHBLJWcB0yXqw04+M+dTktD+
         xhJaCnB1rJ5+55z0qOCPvgkBgtkng2yQmhAYW/UkUetsGVzmPX/5IXyRbmI7mDajGR9j
         ISibY9GFejHz2GZOFajYb+N4+yCbLabdTq/7StlCxqIY/AEnpqCpM+Xo25wKMr9hmA7q
         +haN7NyHNe/N6ZmVvWO3O4yjymIl3z4XVg7bemlUwBOm0MkazoZcDVOD5N49RqAZpWRU
         hiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJfZDh40KoWbcxKKqe/Zk+j7B8MnIucxheKFflwoTwsjfhp8l5yQ6QI8w9FyqosfpcilHMXXOdFYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF44JhDKYswnfDKf7zysiwD8ES/S9ha2oDmRIJ6szj6N1ZJv1M
	4UwqNoyx4jp68ba7tpMhNbf75O5GdHCVrEoS8sJPTSyAuk1JLCTpdSoz
X-Gm-Gg: ASbGnctqyuje/CEMpcOzgk9T0fFgfnREiQ9AYHDy8x/WWDTZZYQgvjbGAMhP3LIwO6q
	uApjr1k+q0FE83yaROX5oGnINGqB/L0V9rDfvNFQC11BB9fAnUKAdxF+X+5rTcZFhn5bThg9Jm6
	F7BI8QK6KAR7EeV3rcDewxMLRcTq0SMRCkZp6QKz1Et5e82DpNxKC+MKNzjfeB+FZZbag7B0KlW
	OwBjE+qG2PwuQGUmxAdk72coygg+NFK8TSIlONJ8Hfa7ThiwbS/EhPsHMRvXG3q0zbtppLe5Dw1
	33nAERLkXrsCh/kqAshEEv6OQH3W7QNto4rlC6wmjN+/3qjerj/xaaGTzgtqRZgArS5BKUzVV3w
	fga7uqGECVLFBHLPDIWkzh32bG6j/OqYPlu/LPcmeNdeOcRz5nL21dcsZBz7ddiRwPrA0Gbscxk
	KyD25UNmP0Xi3v
X-Google-Smtp-Source: AGHT+IGxSFH3Bqps9OmzoPwMDyZjQ1B5vzVHzo7POG4taW5PgtexP6XyXLtzCFuQFZbnYFFtj5wGPg==
X-Received: by 2002:a67:e70b:0:b0:5db:27e9:933f with SMTP id ada2fe7eead31-5e1de350db3mr12092118137.40.1764388060047;
        Fri, 28 Nov 2025 19:47:40 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24d917860sm2562662137.2.2025.11.28.19.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 19:47:39 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 28 Nov 2025 22:47:13 -0500
Subject: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
In-Reply-To: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=26437; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=vVyK2OA9BueB0Wqbshf0aIbe/dr0Ml0Vv7Dw2/Y6QzM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJlaOddOX3ysbJAb8G0Vr1/Lo21fbj/5MLXuzOUmnly1n
 zkVG1f+6ShlYRDjYpAVU2RpT1j07VFU3lu/A6H3YeawMoEMYeDiFICJFFszMkyfl6K2P3xmit4p
 PZajYqYtSsunXBPMCd402771UPyXScyMDP82mczketxYmC7z49vyAJXK6StftIYzKW88VhyenDl
 djB8A
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
analog-to-digital converters.

These chips' MOSI pin is shared with a data-ready interrupt. Defining
this interrupt in devicetree is optional, therefore we only create an
IIO trigger if one is found.

Handling this interrupt requires some considerations. When enabling the
trigger the CS line is tied low (active), thus we need to hold
spi_bus_lock() too, to avoid state corruption. This is done inside the
set_trigger_state() callback, to let users use other triggers without
wasting a bus lock.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 MAINTAINERS                  |   1 +
 drivers/iio/adc/Kconfig      |  12 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1018.c | 811 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 825 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d5295b5d6eb..b3822cbff2c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25651,6 +25651,7 @@ M:	Kurt Borja <kuurtb@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
+F:	drivers/iio/adc/ti-ads1018.c
 
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58da8255525e..aa3f7023c64b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1664,6 +1664,18 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS1018
+       tristate "Texas Instruments ADS1018 ADC"
+       depends on SPI
+       select IIO_BUFFER
+       select IIO_TRIGGERED_BUFFER
+       help
+         If you say yes here you get support for Texas Instruments ADS1018 and
+         ADS1118 ADC chips.
+
+         This driver can also be built as a module. If so, the module will be
+         called ti-ads1018.
+
 config TI_ADS1100
 	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7cc8f9a12f76..72ef79becdec 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
 obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
+obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
new file mode 100644
index 000000000000..2e851a1addfd
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1018.c
@@ -0,0 +1,811 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Texas Instruments ADS1018 ADC driver
+ *
+ * Copyright (C) 2025 Kurt Borja <kuurtb@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/byteorder/generic.h>
+#include <linux/dev_printk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define ADS1018_CFG_DEFAULT		0x058b
+
+#define ADS1018_CFG_OS_TRIG		BIT(15)
+#define ADS1018_CFG_TS_MODE_EN		BIT(4)
+#define ADS1018_CFG_PULL_UP		BIT(3)
+#define ADS1018_CFG_NOP			BIT(1)
+#define ADS1018_CFG_VALID		(ADS1018_CFG_PULL_UP | ADS1018_CFG_NOP)
+
+#define ADS1018_CFG_MUX_MASK		GENMASK(14, 12)
+
+#define ADS1018_CFG_PGA_MASK		GENMASK(11, 9)
+#define ADS1018_PGA_DEFAULT		2
+
+#define ADS1018_CFG_MODE_MASK		GENMASK(8, 8)
+#define ADS1018_MODE_CONTINUOUS		0
+#define ADS1018_MODE_ONESHOT		1
+
+#define ADS1018_CFG_DRATE_MASK		GENMASK(7, 5)
+#define ADS1018_DRATE_DEFAULT		4
+
+#define ADS1018_CHANNELS_MAX		10
+
+struct ads1018_chan_data {
+	u8 pga_mode;
+	u8 data_rate_mode;
+};
+
+struct ads1018_chip_info {
+	const char *name;
+
+	const struct iio_chan_spec *channels;
+	unsigned long num_channels;
+
+	/* IIO_VAL_INT */
+	const unsigned int *data_rate_mode_to_hz;
+	unsigned long num_data_rate_mode_to_hz;
+
+	/* IIO_VAL_INT_PLUS_NANO */
+	const unsigned int (*pga_mode_to_gain)[2];
+	unsigned long num_pga_mode_to_gain;
+
+	/* IIO_VAL_INT_PLUS_MICRO */
+	const int temp_scale[2];
+};
+
+struct ads1018 {
+	struct spi_device *spi;
+	struct iio_trigger *indio_trig;
+
+	struct gpio_desc *drdy_gpiod;
+	int drdy_irq;
+
+	bool restore_mode;
+
+	struct ads1018_chan_data chan_data[ADS1018_CHANNELS_MAX];
+	const struct ads1018_chip_info *chip_info;
+
+	struct spi_message msg_read;
+	struct spi_transfer xfer;
+	__be16 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
+	__be16 rx_buf[2];
+};
+
+#define ADS1018_VOLT_DIFF_CHAN(_addr, _chan, _chan2, _realbits) {		\
+	.type = IIO_VOLTAGE,							\
+	.channel = _chan,							\
+	.channel2 = _chan2,							\
+	.scan_index = _addr,							\
+	.scan_type = {								\
+		.sign = 's',							\
+		.realbits = _realbits,						\
+		.storagebits = 16,						\
+		.shift = 16 - _realbits,					\
+		.endianness = IIO_BE,						\
+	},									\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.indexed = true,							\
+	.differential = true,							\
+}
+
+#define ADS1018_VOLT_CHAN(_addr, _chan, _realbits) {				\
+	.type = IIO_VOLTAGE,							\
+	.channel = _chan,							\
+	.scan_index = _addr,							\
+	.scan_type = {								\
+		.sign = 's',							\
+		.realbits = _realbits,						\
+		.storagebits = 16,						\
+		.shift = 16 - _realbits,					\
+		.endianness = IIO_BE,						\
+	},									\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.indexed = true,							\
+}
+
+#define ADS1018_TEMP_CHAN(_addr, _realbits) {					\
+	.type = IIO_TEMP,							\
+	.channel = 0,								\
+	.scan_index = _addr,							\
+	.scan_type = {								\
+		.sign = 's',							\
+		.realbits = _realbits,						\
+		.storagebits = 16,						\
+		.shift = 16 - _realbits,					\
+		.endianness = IIO_BE,						\
+	},									\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+static const struct iio_chan_spec ads1118_iio_channels[] = {
+	ADS1018_VOLT_DIFF_CHAN(0, 0, 1, 16),
+	ADS1018_VOLT_DIFF_CHAN(1, 0, 3, 16),
+	ADS1018_VOLT_DIFF_CHAN(2, 1, 3, 16),
+	ADS1018_VOLT_DIFF_CHAN(3, 2, 3, 16),
+	ADS1018_VOLT_CHAN(4, 0, 16),
+	ADS1018_VOLT_CHAN(5, 1, 16),
+	ADS1018_VOLT_CHAN(6, 2, 16),
+	ADS1018_VOLT_CHAN(7, 3, 16),
+	ADS1018_TEMP_CHAN(8, 14),
+	IIO_CHAN_SOFT_TIMESTAMP(9),
+};
+
+static const struct iio_chan_spec ads1018_iio_channels[] = {
+	ADS1018_VOLT_DIFF_CHAN(0, 0, 1, 12),
+	ADS1018_VOLT_DIFF_CHAN(1, 0, 3, 12),
+	ADS1018_VOLT_DIFF_CHAN(2, 1, 3, 12),
+	ADS1018_VOLT_DIFF_CHAN(3, 2, 3, 12),
+	ADS1018_VOLT_CHAN(4, 0, 12),
+	ADS1018_VOLT_CHAN(5, 1, 12),
+	ADS1018_VOLT_CHAN(6, 2, 12),
+	ADS1018_VOLT_CHAN(7, 3, 12),
+	ADS1018_TEMP_CHAN(8, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(9),
+};
+
+/**
+ * ads1018_get_data_rate_mode - Get current data-rate mode for a channel.
+ * @ad1018: Device data
+ * @address: Channel address
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Return: Current data-rate mode for the channel at @address.
+ */
+static u8 ads1018_get_data_rate_mode(struct ads1018 *ads1018, unsigned int address)
+{
+	return ads1018->chan_data[address].data_rate_mode;
+}
+
+/**
+ * ads1018_get_pga_mode - Get current PGA mode for a channel.
+ * @ad1018: Device data
+ * @address: Channel address
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Return: Current PGA mode for the channel at @address.
+ */
+static u8 ads1018_get_pga_mode(struct ads1018 *ads1018, unsigned int address)
+{
+	return ads1018->chan_data[address].pga_mode;
+}
+
+/**
+ * ads1018_set_data_rate_mode - Set a data-rate mode for a channel.
+ * @ad1018: Device data
+ * @address: Channel address
+ * @val: New data-rate mode for channel at @address.
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Lazily set a new data-rate mode for a channel.
+ */
+static void ads1018_set_data_rate_mode(struct ads1018 *ads1018, unsigned int address,
+				       u8 val)
+{
+	ads1018->chan_data[address].data_rate_mode = val;
+}
+
+/**
+ * ads1018_set_pga_mode - Set a PGA mode for a channel.
+ * @ad1018: Device data
+ * @address: Channel address
+ * @val: New PGA mode for channel at @address.
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Lazily set a new PGA mode for a channel.
+ */
+static void ads1018_set_pga_mode(struct ads1018 *ads1018, unsigned int address,
+				 u8 val)
+{
+	ads1018->chan_data[address].pga_mode = val;
+}
+
+/**
+ * ads1018_calc_delay - Calculates an appropriate delay for a single-shot
+ *			reading
+ * @ad1018: Device data
+ *
+ * Calculates an appropriate delay for a single shot reading, assuming the
+ * device's maximum data-rate is used.
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Return: Delay in microseconds.
+ */
+static unsigned long ads1018_calc_delay(struct ads1018 *ads1018)
+{
+	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
+	unsigned long max_drate_mode = chip_info->num_data_rate_mode_to_hz - 1;
+	unsigned int hz = chip_info->data_rate_mode_to_hz[max_drate_mode];
+
+	/* We subtract 10% data-rate error */
+	hz -= DIV_ROUND_UP(hz, 10);
+
+	/* Calculate time per sample in microseconds */
+	return DIV_ROUND_UP(MICROHZ_PER_HZ, hz);
+}
+
+/**
+ * ads1018_read_unlocked - Reads a conversion value from the device
+ * @ad1018: Device data
+ * @cnv: ADC Conversion value
+ * @hold_cs: Keep CS line asserted after the SPI transfer
+ *
+ * Reads the most recent ADC conversion value, without updating the
+ * device's configuration.
+ *
+ * Context: Expects spi_bus_lock() is held.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ads1018_read_unlocked(struct ads1018 *ads1018, __be16 *cnv, bool hold_cs)
+{
+	int ret;
+
+	ads1018->xfer.cs_change = hold_cs;
+
+	ret = spi_sync_locked(ads1018->spi, &ads1018->msg_read);
+	if (ret)
+		return ret;
+
+	if (cnv)
+		*cnv = ads1018->rx_buf[0];
+
+	return 0;
+}
+
+/**
+ * ads1018_oneshot - Performs a one-shot reading sequence
+ * @ad1018: Device data
+ * @cfg: New configuration for the device
+ * @cnv: Conversion value
+ *
+ * Writes a new configuration, waits an appropriate delay (assuming the new
+ * configuration uses the maximum data-rate) and then reads the most recent
+ * conversion.
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ads1018_oneshot(struct ads1018 *ads1018, u16 cfg, u16 *cnv)
+{
+	struct spi_transfer xfer[2] = {
+		{
+			.tx_buf = ads1018->tx_buf,
+			.len = sizeof(ads1018->tx_buf),
+			.delay = {
+				.value = ads1018_calc_delay(ads1018),
+				.unit = SPI_DELAY_UNIT_USECS,
+			},
+		},
+		{
+			.rx_buf = ads1018->rx_buf,
+			.len = sizeof(ads1018->rx_buf),
+		},
+	};
+	int ret;
+
+	ads1018->tx_buf[0] = cpu_to_be16(cfg);
+	ads1018->tx_buf[1] = 0;
+
+	ret = spi_sync_transfer(ads1018->spi, xfer, ARRAY_SIZE(xfer));
+	if (ret)
+		return ret;
+
+	*cnv = be16_to_cpu(ads1018->rx_buf[0]);
+
+	return 0;
+}
+
+static int
+ads1018_read_raw_unlocked(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
+	u8 drate_mode = ads1018_get_data_rate_mode(ads1018, chan->scan_index);
+	u8 pga_mode = ads1018_get_pga_mode(ads1018, chan->scan_index);
+	u8 max_drate_mode = chip_info->num_data_rate_mode_to_hz - 1;
+	u16 cnv, cfg;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		cfg = ADS1018_CFG_VALID | ADS1018_CFG_OS_TRIG;
+		cfg |= FIELD_PREP(ADS1018_CFG_MUX_MASK, chan->scan_index);
+		cfg |= FIELD_PREP(ADS1018_CFG_PGA_MASK, pga_mode);
+		cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_ONESHOT);
+		cfg |= FIELD_PREP(ADS1018_CFG_DRATE_MASK, max_drate_mode);
+
+		if (chan->type == IIO_TEMP)
+			cfg |= ADS1018_CFG_TS_MODE_EN;
+
+		ret = ads1018_oneshot(ads1018, cfg, &cnv);
+		if (ret)
+			return ret;
+
+		cnv >>= chan->scan_type.shift;
+		*val = sign_extend32(cnv, chan->scan_type.realbits - 1);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = chip_info->pga_mode_to_gain[pga_mode][0];
+			*val2 = chip_info->pga_mode_to_gain[pga_mode][1];
+			return IIO_VAL_INT_PLUS_NANO;
+
+		case IIO_TEMP:
+			*val = chip_info->temp_scale[0];
+			*val2 = chip_info->temp_scale[1];
+			return IIO_VAL_INT_PLUS_MICRO;
+
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = chip_info->data_rate_mode_to_hz[drate_mode];
+		return IIO_VAL_INT;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		 int *val, int *val2, long mask)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	ret = ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int
+ads1018_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		   const int **vals, int *type, int *length, long mask)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*vals = (const int *)ads1018->chip_info->pga_mode_to_gain;
+		*length = ads1018->chip_info->num_pga_mode_to_gain * 2;
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = ads1018->chip_info->data_rate_mode_to_hz;
+		*length = ads1018->chip_info->num_data_rate_mode_to_hz;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ads1018_write_raw_unlocked(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			   int val, int val2, long mask)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	const struct ads1018_chip_info *info = ads1018->chip_info;
+	unsigned int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < info->num_pga_mode_to_gain; i++) {
+			if (val == info->pga_mode_to_gain[i][0] &&
+			    val2 == info->pga_mode_to_gain[i][1])
+				break;
+		}
+
+		if (i == info->num_pga_mode_to_gain)
+			return -EINVAL;
+
+		ads1018_set_pga_mode(ads1018, chan->scan_index, i);
+		return 0;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < info->num_data_rate_mode_to_hz; i++) {
+			if (val == info->data_rate_mode_to_hz[i])
+				break;
+		}
+
+		if (i == info->num_data_rate_mode_to_hz)
+			return -EINVAL;
+
+		ads1018_set_data_rate_mode(ads1018, chan->scan_index, i);
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ads1018_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		  int val, int val2, long mask)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	ret = ads1018_write_raw_unlocked(indio_dev, chan, val, val2, mask);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int
+ads1018_write_raw_get_fmt(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static const struct iio_info ads1018_iio_info = {
+	.read_raw = ads1018_read_raw,
+	.read_avail = ads1018_read_avail,
+	.write_raw = ads1018_write_raw,
+	.write_raw_get_fmt = ads1018_write_raw_get_fmt,
+};
+
+static void ads1018_set_trigger_enable(struct ads1018 *ads1018)
+{
+	spi_bus_lock(ads1018->spi->controller);
+	ads1018_read_unlocked(ads1018, NULL, true);
+	enable_irq(ads1018->drdy_irq);
+}
+
+static void ads1018_set_trigger_disable(struct ads1018 *ads1018)
+{
+	disable_irq(ads1018->drdy_irq);
+	ads1018_read_unlocked(ads1018, NULL, false);
+	spi_bus_unlock(ads1018->spi->controller);
+}
+
+static int ads1018_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct ads1018 *ads1018 = iio_trigger_get_drvdata(trig);
+
+	/*
+	 * We need to lock the SPI bus and tie CS low (hold_cs) to catch
+	 * data-ready interrupts, otherwise the MISO line enters a Hi-Z state.
+	 */
+
+	if (state)
+		ads1018_set_trigger_enable(ads1018);
+	else
+		ads1018_set_trigger_disable(ads1018);
+
+	return 0;
+}
+
+static const struct iio_trigger_ops ads1018_trigger_ops = {
+	.set_trigger_state = ads1018_set_trigger_state,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int ads1018_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
+	unsigned int pga, drate, addr;
+	u16 cfg;
+
+	addr = find_first_bit(indio_dev->active_scan_mask, iio_get_masklength(indio_dev));
+	pga = ads1018_get_pga_mode(ads1018, addr);
+	drate = ads1018_get_data_rate_mode(ads1018, addr);
+
+	cfg = ADS1018_CFG_VALID;
+	cfg |= FIELD_PREP(ADS1018_CFG_MUX_MASK, addr);
+	cfg |= FIELD_PREP(ADS1018_CFG_PGA_MASK, pga);
+	cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_CONTINUOUS);
+	cfg |= FIELD_PREP(ADS1018_CFG_DRATE_MASK, drate);
+
+	if (chip_info->channels[addr].type == IIO_TEMP)
+		cfg |= ADS1018_CFG_TS_MODE_EN;
+
+	ads1018->tx_buf[0] = cpu_to_be16(cfg);
+	ads1018->tx_buf[1] = 0;
+
+	return spi_write(ads1018->spi, ads1018->tx_buf, sizeof(ads1018->tx_buf));
+}
+
+static int ads1018_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+
+	ads1018->tx_buf[0] = cpu_to_be16(ADS1018_CFG_DEFAULT);
+	ads1018->tx_buf[1] = 0;
+
+	return spi_write(ads1018->spi, ads1018->tx_buf, sizeof(ads1018->tx_buf));
+}
+
+static const struct iio_buffer_setup_ops ads1018_buffer_ops = {
+	.preenable = ads1018_buffer_preenable,
+	.postdisable = ads1018_buffer_postdisable,
+	.validate_scan_mask = iio_validate_scan_mask_onehot,
+};
+
+static irqreturn_t ads1018_irq_handler(int irq, void *dev_id)
+{
+	struct ads1018 *ads1018 = dev_id;
+
+	/*
+	 * We need to check if the "drdy" pin is actually active or if it's a
+	 * pending interrupt triggered by the SPI transfer.
+	 */
+	if (ads1018->drdy_gpiod && !gpiod_get_value(ads1018->drdy_gpiod))
+		return IRQ_HANDLED;
+
+	iio_trigger_poll(ads1018->indio_trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ads1018_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	struct {
+		__be16 conv;
+		aligned_s64 ts;
+	} scan = {};
+	int ret;
+
+	if (iio_device_claim_buffer_mode(indio_dev))
+		goto out_notify_done;
+
+	if (iio_trigger_using_own(indio_dev)) {
+		disable_irq(ads1018->drdy_irq);
+		ret = ads1018_read_unlocked(ads1018, &scan.conv, true);
+		enable_irq(ads1018->drdy_irq);
+	} else {
+		ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
+		scan.conv = ads1018->rx_buf[0];
+	}
+
+	iio_device_release_buffer_mode(indio_dev);
+
+	if (ret)
+		goto out_notify_done;
+
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
+
+out_notify_done:
+	iio_trigger_notify_done(ads1018->indio_trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ads1018_trigger_setup(struct iio_dev *indio_dev)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	struct spi_device *spi = ads1018->spi;
+	struct device *dev = &spi->dev;
+	const char *con_id = "drdy";
+	int ret;
+
+	ads1018->drdy_gpiod = devm_gpiod_get_optional(dev, con_id, GPIOD_IN);
+	if (IS_ERR(ads1018->drdy_gpiod))
+		return dev_err_probe(dev, PTR_ERR(ads1018->drdy_gpiod),
+				     "Failed to get %s GPIO.\n", con_id);
+
+	/* First try to get IRQ from SPI core, then from GPIO */
+	if (spi->irq > 0)
+		ads1018->drdy_irq = spi->irq;
+	else if (ads1018->drdy_gpiod)
+		ads1018->drdy_irq = gpiod_to_irq(ads1018->drdy_gpiod);
+	if (ads1018->drdy_irq < 0)
+		return dev_err_probe(dev, ads1018->drdy_irq,
+				     "Failed to get IRQ from %s GPIO.\n", con_id);
+
+	/* An IRQ line is only an optional requirement for the IIO trigger */
+	if (ads1018->drdy_irq == 0)
+		return 0;
+
+	ads1018->indio_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy", indio_dev->name,
+						     iio_device_id(indio_dev));
+	if (!ads1018->indio_trig)
+		return -ENOMEM;
+
+	iio_trigger_set_drvdata(ads1018->indio_trig, ads1018);
+	ads1018->indio_trig->ops = &ads1018_trigger_ops;
+
+	ret = devm_iio_trigger_register(dev, ads1018->indio_trig);
+	if (ret)
+		return ret;
+
+	/*
+	 * The "data-ready" IRQ line is shared with the MOSI pin, thus we need
+	 * to keep it disabled until we actually request data.
+	 */
+	return devm_request_irq(dev, ads1018->drdy_irq, ads1018_irq_handler,
+				IRQF_NO_AUTOEN, ads1018->chip_info->name, ads1018);
+}
+
+static int ads1018_spi_probe(struct spi_device *spi)
+{
+	const struct ads1018_chip_info *info = spi_get_device_match_data(spi);
+	struct iio_dev *indio_dev;
+	struct ads1018 *ads1018;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*ads1018));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ads1018 = iio_priv(indio_dev);
+	ads1018->spi = spi;
+	ads1018->chip_info = info;
+	spi_set_drvdata(spi, ads1018);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = info->name;
+	indio_dev->info = &ads1018_iio_info;
+	indio_dev->channels = info->channels;
+	indio_dev->num_channels = info->num_channels;
+
+	for (unsigned int i = 0; i < ADS1018_CHANNELS_MAX; i++) {
+		ads1018->chan_data[i].data_rate_mode = ADS1018_DRATE_DEFAULT;
+		ads1018->chan_data[i].pga_mode = ADS1018_PGA_DEFAULT;
+	}
+
+	ads1018->xfer.rx_buf = ads1018->rx_buf;
+	ads1018->xfer.len = sizeof(ads1018->rx_buf);
+	spi_message_init_with_transfers(&ads1018->msg_read, &ads1018->xfer, 1);
+
+	ret = ads1018_trigger_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, iio_pollfunc_store_time,
+					      ads1018_trigger_handler, &ads1018_buffer_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+/**
+ * ADS1018_FSR_TO_SCALE - Converts FSR into scale
+ * @_fsr: Full-scale range in millivolts
+ * @_res: ADC resolution
+ *
+ * Return: Scale in IIO_VAL_INT_PLUS_NANO format
+ */
+#define ADS1018_FSR_TO_SCALE(_fsr, _res) \
+	{ 0, ((_fsr) * (MICRO >> 6)) / BIT((_res) - 6) }
+
+static const unsigned int ads1018_gain_table[][2] = {
+	ADS1018_FSR_TO_SCALE(6144, 11),
+	ADS1018_FSR_TO_SCALE(4096, 11),
+	ADS1018_FSR_TO_SCALE(2048, 11),
+	ADS1018_FSR_TO_SCALE(1024, 11),
+	ADS1018_FSR_TO_SCALE(512, 11),
+	ADS1018_FSR_TO_SCALE(256, 11),
+};
+
+static const unsigned int ads1118_gain_table[][2] = {
+	ADS1018_FSR_TO_SCALE(6144, 15),
+	ADS1018_FSR_TO_SCALE(4096, 15),
+	ADS1018_FSR_TO_SCALE(2048, 15),
+	ADS1018_FSR_TO_SCALE(1024, 15),
+	ADS1018_FSR_TO_SCALE(512, 15),
+	ADS1018_FSR_TO_SCALE(256, 15),
+};
+
+static const unsigned int ads1018_data_rate_table[] = {
+	128, 250, 490, 920, 1600, 2400, 3300,
+};
+
+static const unsigned int ads1118_data_rate_table[] = {
+	8, 16, 32, 64, 128, 250, 475, 860,
+};
+
+static const struct ads1018_chip_info ads1018_chip_info = {
+	.name = "ads1018",
+
+	.channels = ads1018_iio_channels,
+	.num_channels = ARRAY_SIZE(ads1018_iio_channels),
+
+	.pga_mode_to_gain = ads1018_gain_table,
+	.num_pga_mode_to_gain = ARRAY_SIZE(ads1018_gain_table),
+
+	.data_rate_mode_to_hz = ads1018_data_rate_table,
+	.num_data_rate_mode_to_hz = ARRAY_SIZE(ads1018_data_rate_table),
+
+	.temp_scale = { 0, 125000 },
+};
+
+static const struct ads1018_chip_info ads1118_chip_info = {
+	.name = "ads1118",
+
+	.channels = ads1118_iio_channels,
+	.num_channels = ARRAY_SIZE(ads1118_iio_channels),
+
+	.pga_mode_to_gain = ads1118_gain_table,
+	.num_pga_mode_to_gain = ARRAY_SIZE(ads1118_gain_table),
+
+	.data_rate_mode_to_hz = ads1118_data_rate_table,
+	.num_data_rate_mode_to_hz = ARRAY_SIZE(ads1118_data_rate_table),
+
+	.temp_scale = { 0, 31250 },
+};
+
+static const struct of_device_id ads1018_of_match[] = {
+	{ .compatible = "ti,ads1018", .data = &ads1018_chip_info },
+	{ .compatible = "ti,ads1118", .data = &ads1118_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1018_of_match);
+
+static const struct spi_device_id ads1018_spi_match[] = {
+	{ "ads1018", (kernel_ulong_t)&ads1018_chip_info },
+	{ "ads1118", (kernel_ulong_t)&ads1118_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ads1018_spi_match);
+
+static struct spi_driver ads1018_spi_driver = {
+	.driver = {
+		.name = "ads1018",
+		.of_match_table = ads1018_of_match,
+	},
+	.probe = ads1018_spi_probe,
+	.id_table = ads1018_spi_match,
+};
+
+module_spi_driver(ads1018_spi_driver);
+
+MODULE_DESCRIPTION("Texas Instruments ADS1018 ADC Driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kurt Borja <kuurtb@gmail.com>");

-- 
2.52.0


