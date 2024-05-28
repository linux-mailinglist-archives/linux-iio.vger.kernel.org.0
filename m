Return-Path: <linux-iio+bounces-5391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD58D1E6A
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F83E281796
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379916FF49;
	Tue, 28 May 2024 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dof7YV+r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72216F851
	for <linux-iio@vger.kernel.org>; Tue, 28 May 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906043; cv=none; b=RkRBkEvn1zWL12Ibe0Gl7P3OCdrZINGeCrFn8/eDDE/CXuY1PVeZ1Uf2prDdWW0cq1CnOEhvg3+PZAQ7yGsICVVYuhNx67Z75xJhbLc718I3YnwfW2og1UFirlweElUtCTJEmWErmYnXwwMwCvJEHPJAqnf+5KffiqF9+LNP+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906043; c=relaxed/simple;
	bh=0+eT89saMS4Y0sggsTElWNXdwkYg6QkyeONV+G5bPjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHpDx2vl8I48BRNxUDSu+KPCuWUrHkPujrpyXN1XgYbwADsa8eJe/+nZ1b0/K3SBTZtZIHGmH65rut03/BZJS7s+SMXarSUJxrKHPDpCCSeDqUks51nBbhalyLl5rJgCPIqp9M3uD9a11O2d4xK9Ul15jNIOflJWBWmHICSJt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dof7YV+r; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so669557f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 28 May 2024 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716906039; x=1717510839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kA96oc/kl3sYd8WdlE3Ax8TpqvioyNc0mC+dpMmE3GE=;
        b=dof7YV+rVqYYPCOI74KDM3BckoE5nTTfPeggizgh0qZ3GVamoeW0nvc5uX+p8R7+nA
         g4Cdm6W8HmwhvOnKBI9lvAE4e9A7/M5AeRmYh1SFEB6mymStyydCadWOv9KeothyzY4Z
         iA+rktaD29IipFnB++W4KfwzSTq4LSvJHwJ31YroFs22QnLPK7J9iTV/bz/cc0j4nue7
         2HLf0yjSZ/BxCkj5yBmMtKas54+5to8u8OiZ9KfpJacAXA+6lYHbXpEcLMIsoOpAD6vI
         8NjcDPeRgApYp2FKBy/afFidxIYk6VsO7Mal+EU1MNJyV2avDBBfqd4PzlVxuL19TfDI
         YPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906039; x=1717510839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA96oc/kl3sYd8WdlE3Ax8TpqvioyNc0mC+dpMmE3GE=;
        b=fU5xQQKsdQuQ3IH60CRyzMX08frFr3x3VoflTpGwMfUeNVRGi4CUDiODooNxY5aaeN
         qrmIn/iK0g4kntCxdPuM8guJCplkN2iUpXcaaoK8utBt7kMy1UccgaRGmzpdBLvsImhG
         2BCfVBetYU3hNdK2RWAVDTBdMyma1TMfGB0OEcQFq8B5PeHuo5kv2nWWK78NS20Q/M+X
         0uW0A+GNn+MgPESISQ0SAVLdcPFIfyoj5qVX59Fx2OiijoTs0Q7UgIGWR2PN4XPYTQtd
         e6pGLV3EQmvT6eDh50Rjgy7kcefcOTsem+44OUfBlJYPmfDBcpSJ+8lzN9+W0CkV1Gzg
         tumg==
X-Forwarded-Encrypted: i=1; AJvYcCX4EI/97tFKmkGqYE2pGrLhu1j0I0URRVzx4/hP9uyS+aFnsQUaFyEnTZDApHvSS/g6UbTiiv+AZR8kCamiDAFBLWpKIeF3sRTp
X-Gm-Message-State: AOJu0Yw9LTs5IftP/ds3UqNh+rx6C45XB0+ZNsO2fa/BwPqIQiZEtiTS
	4J0Z74VYuYZs0nLC0uQNWQVj3EIQ/9G3vRXytPckS6CogXgDYT1wmGAg9BY7s2I=
X-Google-Smtp-Source: AGHT+IGuQwMLzdoy3JvonybMKiytZ6Xf7sE0EVy4nEWFlNaSQbwGqE+Fma3/9rr0X61F+fvQWBJhuQ==
X-Received: by 2002:adf:a18d:0:b0:346:47d6:5d17 with SMTP id ffacd0b85a97d-3552fe01f0emr9222025f8f.57.1716906039202;
        Tue, 28 May 2024 07:20:39 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db5esm11999275f8f.15.2024.05.28.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:20:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 May 2024 16:20:29 +0200
Subject: [PATCH v7 2/7] iio: adc: ad7380: new driver for AD7380 ADCs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240528-adding-new-ad738x-driver-v7-2-4cd70a4c12c8@baylibre.com>
References: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
In-Reply-To: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Stefan Popa <stefan.popa@analog.com>
X-Mailer: b4 0.13.0

From: David Lechner <dlechner@baylibre.com>

This adds a new driver for the AD7380 family ADCs.

The driver currently implements basic support for the AD7380, AD7381,
2-channel differential ADCs. Support for additional single-ended,
pseudo-differential and 4-channel chips that use the same register map
as well as additional features of the chip will be added in future patches.

Co-developed-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
[Julien Stephan: add datasheet links of supported parts]
[Julien Stephan: fix rx/tx buffer for regmap access]
[Julien Stephan: fix scale issue]
[Julien Stephan: use the new iio_device_claim_direct_scoped
instead of iio_device_claim_direct_mode]
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  16 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7380.c | 438 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 456 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f162600e982..315b3060946f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -435,6 +435,7 @@ S:	Supported
 W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+F:	drivers/iio/adc/ad7380.c
 
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8db68b80b391..631386b037ae 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -155,6 +155,22 @@ config AD7298
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7298.
 
+config AD7380
+	tristate "Analog Devices AD7380 ADC driver"
+	depends on SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  AD7380 is a family of simultaneous sampling ADCs that share the same
+	  SPI register map and have similar pinouts.
+
+	  Say yes here to build support for Analog Devices AD7380 ADC and
+	  similar chips.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7380.
+
 config AD7476
 	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index edb32ce2af02..bd3cbbb178fa 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7292) += ad7292.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7923) += ad7923.o
+obj-$(CONFIG_AD7380) += ad7380.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
new file mode 100644
index 000000000000..dac7e11755ff
--- /dev/null
+++ b/drivers/iio/adc/ad7380.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD738x Simultaneous Sampling SAR ADCs
+ *
+ * Copyright 2017 Analog Devices Inc.
+ * Copyright 2024 BayLibre, SAS
+ *
+ * Datasheets of supported parts:
+ * ad7380/1 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7380-7381.pdf
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* 2.5V internal reference voltage */
+#define AD7380_INTERNAL_REF_MV		2500
+
+/* reading and writing registers is more reliable at lower than max speed */
+#define AD7380_REG_WR_SPEED_HZ		10000000
+
+#define AD7380_REG_WR			BIT(15)
+#define AD7380_REG_REGADDR		GENMASK(14, 12)
+#define AD7380_REG_DATA			GENMASK(11, 0)
+
+#define AD7380_REG_ADDR_NOP		0x0
+#define AD7380_REG_ADDR_CONFIG1		0x1
+#define AD7380_REG_ADDR_CONFIG2		0x2
+#define AD7380_REG_ADDR_ALERT		0x3
+#define AD7380_REG_ADDR_ALERT_LOW_TH	0x4
+#define AD7380_REG_ADDR_ALERT_HIGH_TH	0x5
+
+#define AD7380_CONFIG1_OS_MODE		BIT(9)
+#define AD7380_CONFIG1_OSR		GENMASK(8, 6)
+#define AD7380_CONFIG1_CRC_W		BIT(5)
+#define AD7380_CONFIG1_CRC_R		BIT(4)
+#define AD7380_CONFIG1_ALERTEN		BIT(3)
+#define AD7380_CONFIG1_RES		BIT(2)
+#define AD7380_CONFIG1_REFSEL		BIT(1)
+#define AD7380_CONFIG1_PMODE		BIT(0)
+
+#define AD7380_CONFIG2_SDO2		GENMASK(9, 8)
+#define AD7380_CONFIG2_SDO		BIT(8)
+#define AD7380_CONFIG2_RESET		GENMASK(7, 0)
+
+#define AD7380_CONFIG2_RESET_SOFT	0x3C
+#define AD7380_CONFIG2_RESET_HARD	0xFF
+
+#define AD7380_ALERT_LOW_TH		GENMASK(11, 0)
+#define AD7380_ALERT_HIGH_TH		GENMASK(11, 0)
+
+struct ad7380_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+#define AD7380_CHANNEL(index, bits) {				\
+	.type = IIO_VOLTAGE,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.indexed = 1,						\
+	.differential = 1,					\
+	.channel = 2 * (index),					\
+	.channel2 = 2 * (index) + 1,				\
+	.scan_index = (index),					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = (bits),				\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+}
+
+#define DEFINE_AD7380_2_CHANNEL(name, bits)	\
+static const struct iio_chan_spec name[] = {	\
+	AD7380_CHANNEL(0, bits),		\
+	AD7380_CHANNEL(1, bits),		\
+	IIO_CHAN_SOFT_TIMESTAMP(2),		\
+}
+
+DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16);
+DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14);
+
+/* Since this is simultaneous sampling, we don't allow individual channels. */
+static const unsigned long ad7380_2_channel_scan_masks[] = {
+	GENMASK(1, 0),
+	0
+};
+
+static const struct ad7380_chip_info ad7380_chip_info = {
+	.name = "ad7380",
+	.channels = ad7380_channels,
+	.num_channels = ARRAY_SIZE(ad7380_channels),
+};
+
+static const struct ad7380_chip_info ad7381_chip_info = {
+	.name = "ad7381",
+	.channels = ad7381_channels,
+	.num_channels = ARRAY_SIZE(ad7381_channels),
+};
+
+struct ad7380_state {
+	const struct ad7380_chip_info *chip_info;
+	struct spi_device *spi;
+	struct regmap *regmap;
+	unsigned int vref_mv;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 * Make the buffer large enough for 2 16-bit samples and one 64-bit
+	 * aligned 64 bit timestamp.
+	 */
+	struct {
+		u16 raw[2];
+
+		s64 ts __aligned(8);
+	} scan_data __aligned(IIO_DMA_MINALIGN);
+	u16 tx;
+	u16 rx;
+};
+
+static int ad7380_regmap_reg_write(void *context, unsigned int reg,
+				   unsigned int val)
+{
+	struct ad7380_state *st = context;
+	struct spi_transfer xfer = {
+		.speed_hz = AD7380_REG_WR_SPEED_HZ,
+		.bits_per_word = 16,
+		.len = 2,
+		.tx_buf = &st->tx,
+	};
+
+	st->tx = FIELD_PREP(AD7380_REG_WR, 1) |
+		 FIELD_PREP(AD7380_REG_REGADDR, reg) |
+		 FIELD_PREP(AD7380_REG_DATA, val);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad7380_regmap_reg_read(void *context, unsigned int reg,
+				  unsigned int *val)
+{
+	struct ad7380_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = 16,
+			.len = 2,
+			.tx_buf = &st->tx,
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = 10, /* t[CSH] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+		}, {
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = 16,
+			.len = 2,
+			.rx_buf = &st->rx,
+		},
+	};
+	int ret;
+
+	st->tx = FIELD_PREP(AD7380_REG_WR, 0) |
+		 FIELD_PREP(AD7380_REG_REGADDR, reg) |
+		 FIELD_PREP(AD7380_REG_DATA, 0);
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret < 0)
+		return ret;
+
+	*val = FIELD_GET(AD7380_REG_DATA, st->rx);
+
+	return 0;
+}
+
+static const struct regmap_config ad7380_regmap_config = {
+	.reg_bits = 3,
+	.val_bits = 12,
+	.reg_read = ad7380_regmap_reg_read,
+	.reg_write = ad7380_regmap_reg_write,
+	.max_register = AD7380_REG_ADDR_ALERT_HIGH_TH,
+	.can_sleep = true,
+};
+
+static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
+				     u32 writeval, u32 *readval)
+{
+	iio_device_claim_direct_scoped(return  -EBUSY, indio_dev) {
+		struct ad7380_state *st = iio_priv(indio_dev);
+
+		if (readval)
+			return regmap_read(st->regmap, reg, readval);
+		else
+			return regmap_write(st->regmap, reg, writeval);
+	}
+	unreachable();
+}
+
+static irqreturn_t ad7380_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7380_state *st = iio_priv(indio_dev);
+	struct spi_transfer xfer = {
+		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
+		.len = 4,
+		.rx_buf = st->scan_data.raw,
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
+					   pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ad7380_read_direct(struct ad7380_state *st,
+			      struct iio_chan_spec const *chan, int *val)
+{
+	struct spi_transfer xfers[] = {
+		/* toggle CS (no data xfer) to trigger a conversion */
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = chan->scan_type.realbits,
+			.delay = {
+				.value = 190, /* t[CONVERT] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = 10, /* t[CSH] */
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+		},
+		/* then read both channels */
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = chan->scan_type.realbits,
+			.rx_buf = st->scan_data.raw,
+			.len = 4,
+		},
+	};
+	int ret;
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(st->scan_data.raw[chan->scan_index],
+			     chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int ad7380_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			return ad7380_read_direct(st, chan, val);
+		}
+		unreachable();
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * According to the datasheet, the LSB size for fully differential ADC is
+		 * (2 × VREF) / 2^N, where N is the ADC resolution (i.e realbits)
+		 */
+		*val = st->vref_mv;
+		*val2 = chan->scan_type.realbits - 1;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad7380_info = {
+	.read_raw = &ad7380_read_raw,
+	.debugfs_reg_access = &ad7380_debugfs_reg_access,
+};
+
+static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
+{
+	int ret;
+
+	/* perform hard reset */
+	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+				 AD7380_CONFIG2_RESET,
+				 FIELD_PREP(AD7380_CONFIG2_RESET,
+					    AD7380_CONFIG2_RESET_HARD));
+	if (ret < 0)
+		return ret;
+
+	/* select internal or external reference voltage */
+	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+				 AD7380_CONFIG1_REFSEL,
+				 FIELD_PREP(AD7380_CONFIG1_REFSEL,
+					    vref ? 1 : 0));
+	if (ret < 0)
+		return ret;
+
+	/* SPI 1-wire mode */
+	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+				  AD7380_CONFIG2_SDO,
+				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
+}
+
+static void ad7380_regulator_disable(void *p)
+{
+	regulator_disable(p);
+}
+
+static int ad7380_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad7380_state *st;
+	struct regulator *vref;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
+
+	vref = devm_regulator_get_optional(&spi->dev, "refio");
+	if (IS_ERR(vref)) {
+		if (PTR_ERR(vref) != -ENODEV)
+			return dev_err_probe(&spi->dev, PTR_ERR(vref),
+					     "Failed to get refio regulator\n");
+
+		vref = NULL;
+	}
+
+	/*
+	 * If there is no REFIO supply, then it means that we are using
+	 * the internal 2.5V reference, otherwise REFIO is reference voltage.
+	 */
+	if (vref) {
+		ret = regulator_enable(vref);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev,
+					       ad7380_regulator_disable, vref);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(vref);
+		if (ret < 0)
+			return ret;
+
+		st->vref_mv = ret / 1000;
+	} else {
+		st->vref_mv = AD7380_INTERNAL_REF_MV;
+	}
+
+	st->regmap = devm_regmap_init(&spi->dev, NULL, st, &ad7380_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "failed to allocate register map\n");
+
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad7380_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = ad7380_2_channel_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad7380_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	ret = ad7380_init(st, vref);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad7380_of_match_table[] = {
+	{ .compatible = "adi,ad7380", .data = &ad7380_chip_info },
+	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
+	{ }
+};
+
+static const struct spi_device_id ad7380_id_table[] = {
+	{ "ad7380", (kernel_ulong_t)&ad7380_chip_info },
+	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad7380_id_table);
+
+static struct spi_driver ad7380_driver = {
+	.driver = {
+		.name = "ad7380",
+		.of_match_table = ad7380_of_match_table,
+	},
+	.probe = ad7380_probe,
+	.id_table = ad7380_id_table,
+};
+module_spi_driver(ad7380_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD738x ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.44.0


