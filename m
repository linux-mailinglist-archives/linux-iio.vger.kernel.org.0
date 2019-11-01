Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E9EC6A4
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 17:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfKAQYb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 12:24:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36348 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfKAQYb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 12:24:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id d13so11227209qko.3;
        Fri, 01 Nov 2019 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/u7vvBKrO78nl6cTsypZyw2hu64SQuE+nIkgTCiHPM=;
        b=cqlra85jdcJ8PTmzi849mlRHrmk25SYiOVkwNh8Z0G6kwfg+6rpX5yFIHNyECpqVbc
         f2ZPrTb6zEawq41Cx97o6e7NJ11QYsqy8WKFlawJnnQD2EzKaYyC1tJXt/bi0B392cwd
         NXloJvA2/Xc3uYMRK6Of1Y6LEGqYmeZenGuOI1WbBkaS4cFCXJncadb6MZp80ZMFxQ3N
         Fo9xDSpdq+8Hue/LWHupWmi9zrjfntE2TKv4TDvV/TdseUACqzN9crokXbHCQ8nhBnjn
         3LjdyjCeA0KLI8hzhk2dMk9wq31J59evdIpMqSKXJZ3tIMwt1O3/W1eCmwQ+ALt8q6re
         SohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/u7vvBKrO78nl6cTsypZyw2hu64SQuE+nIkgTCiHPM=;
        b=Twgu0Sd83YzcTe+d43RiS1lsMW8m5g9h5+gvdWrdYNrhLZxPbgEE71lbDP6k/2V68H
         r3p6uit+y2uwNV34BvdTBz50qhoHI8/YBv7bx/l+aIO7JU0VxDs9S169nAwSThUFWyLB
         F0JYFhlVp9NhKyaCWmnTDSy75Y82UI1NjD/xDs/m0AP1oEM94cjvZNNsaaBRL8YWgzeF
         3/MVMFsMIiMG7XfbOL5ihb5pcqQPX0R7Z1yCulP3q60iQ62ekrFWsd3eGu7Mk7SgQsVT
         W456qBPpWtJNkv0dhKhmGFleBDpzEMOlZP4dUF0pjSyPQwrAvaPl3XSNJK4clEsgVhxg
         D4DQ==
X-Gm-Message-State: APjAAAXa9zz+Ak6QXDMWwc0j4VJnwwIDUzIToVRUasR1ngnXH558vMx1
        wDzdECUUaJoUE6QggvkumnM=
X-Google-Smtp-Source: APXvYqxf+Lhy49tP+ZEh4M/9SnGDqb3JE60q7IB1k0dn2kYT5Ty9sdzFmpE4/fWmsCr5ojAorw/XkA==
X-Received: by 2002:a37:d02:: with SMTP id 2mr6626927qkn.307.1572625470276;
        Fri, 01 Nov 2019 09:24:30 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id l14sm1107234qkj.61.2019.11.01.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 09:24:29 -0700 (PDT)
Date:   Fri, 1 Nov 2019 13:24:26 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 2/2] iio: adc: Add driver support for AD7292
Message-ID: <9f8eccec804b398c73450911f97a4b250f6067da.1572614297.git.marcelo.schmitt1@gmail.com>
References: <cover.1572614297.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572614297.git.marcelo.schmitt1@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD7292 is a 10-bit monitor and control system with ADC, DACs,
temperature sensor, and GPIOs.

Configure AD7292 devices in direct access mode, enabling single-ended
ADC readings.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
Changelog V2 -> V3:
- fix up a typo in channel macros

 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  10 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7292.c | 350 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 362 insertions(+)
 create mode 100644 drivers/iio/adc/ad7292.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d00e871c4c6..5941cfc0d6f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -818,6 +818,7 @@ M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
+F:	drivers/iio/adc/ad7292.c
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 
 ANALOG DEVICES INC AD7606 DRIVER
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 632b331429c6..02587c990cb5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -59,6 +59,16 @@ config AD7291
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7291.
 
+config AD7292
+	tristate "Analog Devices AD7292 ADC driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices AD7292
+	  8 Channel ADC with temperature sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7292.
+
 config AD7298
 	tristate "Analog Devices AD7298 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 4779ab3ff8fb..1818f2f66566 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7173) += ad7173.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7291) += ad7291.o
+obj-$(CONFIG_AD7292) += ad7292.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD738X) += ad738x.o
 obj-$(CONFIG_AD7768) += ad7768-1.o
diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
new file mode 100644
index 000000000000..e2badf6ac10d
--- /dev/null
+++ b/drivers/iio/adc/ad7292.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD7292 SPI ADC driver
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+
+#define ADI_VENDOR_ID 0x0018
+
+/* AD7292 registers definition */
+#define AD7292_REG_VENDOR_ID		0x00
+#define AD7292_REG_CONF_BANK		0x05
+#define AD7292_REG_CONV_COMM		0x0E
+#define AD7292_REG_ADC_CH(x)		(0x10 + (x))
+
+/* AD7292 configuration bank subregisters definition */
+#define AD7292_BANK_REG_VIN_RNG0	0x10
+#define AD7292_BANK_REG_VIN_RNG1	0x11
+#define AD7292_BANK_REG_SAMP_MODE	0x12
+
+#define AD7292_RD_FLAG_MSK(x)		(BIT(7) | ((x) & 0x3F))
+
+/* AD7292_REG_ADC_CONVERSION */
+#define AD7292_ADC_DATA_MASK		GENMASK(15, 6)
+#define AD7292_ADC_DATA(x)		FIELD_GET(AD7292_ADC_DATA_MASK, x)
+
+/* AD7292_CHANNEL_SAMPLING_MODE */
+#define AD7292_CH_SAMP_MODE(reg, ch)	((reg >> 8) & BIT(ch))
+
+/* AD7292_CHANNEL_VIN_RANGE */
+#define AD7292_CH_VIN_RANGE(reg, ch)	(reg & BIT(ch))
+
+#define AD7292_VOLTAGE_CHAN(_chan)					\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_SCALE),			\
+	.indexed = 1,							\
+	.channel = _chan,						\
+}
+
+static const struct iio_chan_spec ad7292_channels[] = {
+	AD7292_VOLTAGE_CHAN(0),
+	AD7292_VOLTAGE_CHAN(1),
+	AD7292_VOLTAGE_CHAN(2),
+	AD7292_VOLTAGE_CHAN(3),
+	AD7292_VOLTAGE_CHAN(4),
+	AD7292_VOLTAGE_CHAN(5),
+	AD7292_VOLTAGE_CHAN(6),
+	AD7292_VOLTAGE_CHAN(7)
+};
+
+static const struct iio_chan_spec ad7292_channels_diff[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.indexed = 1,
+		.differential = 1,
+		.channel = 0,
+		.channel2 = 1,
+	},
+	AD7292_VOLTAGE_CHAN(2),
+	AD7292_VOLTAGE_CHAN(3),
+	AD7292_VOLTAGE_CHAN(4),
+	AD7292_VOLTAGE_CHAN(5),
+	AD7292_VOLTAGE_CHAN(6),
+	AD7292_VOLTAGE_CHAN(7)
+};
+
+struct ad7292_state {
+	struct spi_device *spi;
+	struct regulator *reg;
+	unsigned short vref_mv;
+
+	__be16 d16 ____cacheline_aligned;
+	u8 d8[2];
+};
+
+static int ad7292_spi_reg_read(struct ad7292_state *st, unsigned int addr)
+{
+	int ret;
+
+	st->d8[0] = AD7292_RD_FLAG_MSK(addr);
+
+	ret = spi_write_then_read(st->spi, st->d8, 1, &st->d16, 2);
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(st->d16);
+}
+
+static int ad7292_spi_subreg_read(struct ad7292_state *st, unsigned int addr,
+				  unsigned int sub_addr, unsigned int len)
+{
+	unsigned int shift = 16 - (8 * len);
+	int ret;
+
+	st->d8[0] = AD7292_RD_FLAG_MSK(addr);
+	st->d8[1] = sub_addr;
+
+	ret = spi_write_then_read(st->spi, st->d8, 2, &st->d16, len);
+	if (ret < 0)
+		return ret;
+
+	return (be16_to_cpu(st->d16) >> shift);
+}
+
+static int ad7292_single_conversion(struct ad7292_state *st,
+				    unsigned int chan_addr)
+{
+	int ret;
+
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->d8,
+			.len = 4,
+			.delay_usecs = 6,
+		}, {
+			.rx_buf = &st->d16,
+			.len = 2,
+		},
+	};
+
+	st->d8[0] = chan_addr;
+	st->d8[1] = AD7292_RD_FLAG_MSK(AD7292_REG_CONV_COMM);
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(st->d16);
+}
+
+static int ad7292_vin_range_multiplier(struct ad7292_state *st, int channel)
+{
+	int samp_mode, range0, range1, factor = 1;
+
+	/*
+	 * Every AD7292 ADC channel may have its input range adjusted according
+	 * to the settings at the ADC sampling mode and VIN range subregisters.
+	 * For a given channel, the minimum input range is equal to Vref, and it
+	 * may be increased by a multiplier factor of 2 or 4 according to the
+	 * following rule:
+	 * If channel is being sampled with respect to AGND:
+	 *	factor = 4 if VIN range0 and VIN range1 equal 0
+	 *	factor = 2 if only one of VIN ranges equal 1
+	 *	factor = 1 if both VIN range0 and VIN range1 equal 1
+	 * If channel is being sampled with respect to AVDD:
+	 *	factor = 4 if VIN range0 and VIN range1 equal 0
+	 *	Behavior is undefined if any of VIN range doesn't equal 0
+	 */
+
+	samp_mode = ad7292_spi_subreg_read(st, AD7292_REG_CONF_BANK,
+					   AD7292_BANK_REG_SAMP_MODE, 2);
+
+	if (samp_mode < 0)
+		return samp_mode;
+
+	range0 = ad7292_spi_subreg_read(st, AD7292_REG_CONF_BANK,
+					AD7292_BANK_REG_VIN_RNG0, 2);
+
+	if (range0 < 0)
+		return range0;
+
+	range1 = ad7292_spi_subreg_read(st, AD7292_REG_CONF_BANK,
+					AD7292_BANK_REG_VIN_RNG1, 2);
+
+	if (range1 < 0)
+		return range1;
+
+	if (AD7292_CH_SAMP_MODE(samp_mode, channel)) {
+		/* Sampling with respect to AGND */
+		if (!AD7292_CH_VIN_RANGE(range0, channel))
+			factor *= 2;
+
+		if (!AD7292_CH_VIN_RANGE(range1, channel))
+			factor *= 2;
+
+	} else {
+		/* Sampling with respect to AVDD */
+		if (AD7292_CH_VIN_RANGE(range0, channel) ||
+		    AD7292_CH_VIN_RANGE(range1, channel))
+			return -EPERM;
+
+		factor = 4;
+	}
+
+	return factor;
+}
+
+static int ad7292_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7292_state *st = iio_priv(indio_dev);
+	unsigned int ch_addr;
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ch_addr = AD7292_REG_ADC_CH(chan->channel);
+		ret = ad7292_single_conversion(st, ch_addr);
+		if (ret < 0)
+			return ret;
+
+		*val = AD7292_ADC_DATA(ret);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * To convert a raw value to standard units, the IIO defines
+		 * this formula: Scaled value = (raw + offset) * scale.
+		 * For the scale to be a correct multiplier for (raw + offset),
+		 * it must be calculated as the input range divided by the
+		 * number of possible distinct input values. Given the ADC data
+		 * is 10 bit long, it may assume 2^10 distinct values.
+		 * Hence, scale = range / 2^10. The IIO_VAL_FRACTIONAL_LOG2
+		 * return type indicates to the IIO API to divide *val by 2 to
+		 * the power of *val2 when returning from read_raw.
+		 */
+
+		ret = ad7292_vin_range_multiplier(st, chan->channel);
+		if (ret < 0)
+			return ret;
+
+		*val = st->vref_mv * ret;
+		*val2 = 10;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info ad7292_info = {
+	.read_raw = ad7292_read_raw,
+};
+
+static void ad7292_regulator_disable(void *data)
+{
+	struct ad7292_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
+static int ad7292_probe(struct spi_device *spi)
+{
+	struct ad7292_state *st;
+	struct iio_dev *indio_dev;
+	struct device_node *child;
+	bool diff_channels = 0;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = ad7292_spi_reg_read(st, AD7292_REG_VENDOR_ID);
+	if (ret != ADI_VENDOR_ID) {
+		dev_err(&spi->dev, "Wrong vendor id 0x%x\n", ret);
+		return -EINVAL;
+	}
+
+	spi_set_drvdata(spi, indio_dev);
+
+	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret) {
+			dev_err(&spi->dev,
+				"Failed to enable external vref supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev,
+					       ad7292_regulator_disable, st);
+		if (ret) {
+			regulator_disable(st->reg);
+			return ret;
+		}
+
+		ret = regulator_get_voltage(st->reg);
+		if (ret < 0)
+			return ret;
+
+		st->vref_mv = ret / 1000;
+	} else {
+		/* Use the internal voltage reference. */
+		st->vref_mv = 1250;
+	}
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad7292_info;
+
+	for_each_available_child_of_node(spi->dev.of_node, child) {
+		diff_channels = of_property_read_bool(child, "diff-channels");
+		if (diff_channels)
+			break;
+	}
+
+	if (diff_channels) {
+		indio_dev->num_channels = ARRAY_SIZE(ad7292_channels_diff);
+		indio_dev->channels = ad7292_channels_diff;
+	} else {
+		indio_dev->num_channels = ARRAY_SIZE(ad7292_channels);
+		indio_dev->channels = ad7292_channels;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad7292_id_table[] = {
+	{ "ad7292", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7292_id_table);
+
+static const struct of_device_id ad7292_of_match[] = {
+	{ .compatible = "adi,ad7292" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7292_of_match);
+
+static struct spi_driver ad7292_driver = {
+	.driver = {
+		.name = "ad7292",
+		.of_match_table = ad7292_of_match,
+	},
+	.probe = ad7292_probe,
+	.id_table = ad7292_id_table,
+};
+module_spi_driver(ad7292_driver);
+
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt1@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices AD7292 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.23.0

