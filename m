Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB82F4DA2
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfKHN45 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 08:56:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38449 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKHN45 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 08:56:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id p20so6562321qtq.5;
        Fri, 08 Nov 2019 05:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fr+fOzNosfHP0Tp2y2igWIUUwB2Y8o78v//UEBNfK1s=;
        b=N1be/F3Mis3T8PsInSziJNPrdJBx8xEXMM0MErZmazCVYtu5+j7VkIIkdtcBy92SO1
         6wm61EcWBxV3X3h2uRrvK1Gba8JHQRacLJNFBQfIy1KwyBu8dz2BjgsbMVykPmRrSzWd
         vzA7b/TNpSE4z50JA5mL7p809NYOiw1Y2zxSbbXMl0zqO28N1wSWmSGAuqXYcooTThT9
         CnycNqq2u/W5M5YSm6s6feZdsM4cfYRsN6wRv8pGgmNc53fF4Ps4nt2TIU7ga7RsJFOt
         w2aDWw+m2Uyx0NbWWg9k9v5B7lO9VGc8LsTDG3m+p4JaA0Rxzq2++tXVhcE8JM3jAFVO
         Tw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fr+fOzNosfHP0Tp2y2igWIUUwB2Y8o78v//UEBNfK1s=;
        b=iald6MsH5lqfuwpC2jG+lMsOW465yQttu4/bYyxBYTpYhqm6G+JOGs6lMARa0EinuY
         hnMb7FrzuMEH8haJ3RUIebWYnaZeJhlfHtKaA66Pncx9LuawJaaWqG+dZUSDAUVDHAKp
         ialczkmovRLIozEnN/UP1t8K4/86I1mZPYgvPUrap5btoBoOrvcaAfaBUue769WCStE1
         OxGbMQNQ3tRFnhy2J3IBk/pJURnosDDqY+9uqgi6HigwZLp3rFn50aStQCL+R7lnvxLe
         m0IT2TYmRMbyw2x261ZYdvBZnjDNHbhnmSKb6gpDEjBIk9kOSxfj1ws3j41dhm41q/St
         sePw==
X-Gm-Message-State: APjAAAWM8FspiMDqaHwC5gMO0mfAjc36QygsUlt3lUKw7fjYX4LPLEj7
        lBbJ+77zmwG4yxSuTIka+MY=
X-Google-Smtp-Source: APXvYqy3UFLdD1IGCaShpSzvMAIf1Zl6RtszGRMCL4YJigd/NJHuWMLjuUmEu9v2fmZVd8qfr4Dhbw==
X-Received: by 2002:ac8:6641:: with SMTP id j1mr10903266qtp.48.1573221416224;
        Fri, 08 Nov 2019 05:56:56 -0800 (PST)
Received: from smtp.gmail.com ([2804:d43:422:3955:b4df:7a81:96e1:236e])
        by smtp.gmail.com with ESMTPSA id w20sm2512800qkj.87.2019.11.08.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:56:55 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:56:50 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v4 2/2] iio: adc: Add driver support for AD7292
Message-ID: <e69275f5cda89cdeb1360b1ed5391dae9583ef82.1573145089.git.marcelo.schmitt1@gmail.com>
References: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
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
Changelog V3 -> V4:
- added brackets to shield macro parameters

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
index 000000000000..a6798f7dfdb8
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
+#define AD7292_CH_SAMP_MODE(reg, ch)	(((reg) >> 8) & BIT(ch))
+
+/* AD7292_CHANNEL_VIN_RANGE */
+#define AD7292_CH_VIN_RANGE(reg, ch)	((reg) & BIT(ch))
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

