Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1844A167DCF
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgBUM6C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 07:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgBUM6B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 07:58:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45449206EF;
        Fri, 21 Feb 2020 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582289880;
        bh=JfuMqEvxzqjs+LoLa/shLMP2qrszBuyjaIxCwTpw2+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZqRgXg35D+cF6afTGRZtl/9kbo4xhDiCu/4GdaipVEk5amfKSMNH8spd7uJu7PNUo
         qIohjCv80Xxsy0flIDoB1M+2tgqGzJJ8zQZtFNcKNMu3SS9yeiqWYRqTBuHMVME8po
         NmJmnYoJMMty6lbuL0FrBqDLufzx3r4OeZ7kki1w=
Date:   Fri, 21 Feb 2020 12:57:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/5] iio: adc: ad9467: add support AD9467 ADC
Message-ID: <20200221125756.77e1e098@archlinux>
In-Reply-To: <20200220150317.1864-4-alexandru.ardelean@analog.com>
References: <20200220150317.1864-1-alexandru.ardelean@analog.com>
        <20200220150317.1864-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Feb 2020 17:03:16 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> The AD9467 is a 16-bit, monolithic, IF sampling analog-to-digital converter
> (ADC). It is optimized for high performanceover wide bandwidths and ease of
> use. The product operates at a 250 MSPS conversion rate and is designed for
> wireless receivers, instrumentation, and test equipment that require a high
> dynamic range. The ADC requires 1.8 V and 3.3 V power supplies and a low
> voltage differential input clock for full performance operation. No
> external reference or driver components are required for many applications.
> Data outputs are LVDS compatible (ANSI-644 compatible) and include the
> means to reduce the overall current needed for short trace distances.
> 
> Since the chip can operate at such high sample-rates (much higher than
> classical interfaces), it requires that a DMA controller be used to
> interface directly to the chip and push data into memory.
> Typically, the AXI ADC IP core is used to interface with it.
> 
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

A few minor things inline.

Jonathan
> ---
>  drivers/iio/adc/Kconfig  |  15 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad9467.c | 447 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 463 insertions(+)
>  create mode 100644 drivers/iio/adc/ad9467.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6cd48a256122..229b8bc6f9b6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -246,6 +246,21 @@ config AD799X
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad799x.
>  
> +config AD9467
> +	tristate "Analog Devices AD9467 High Speed ADC driver"
> +	depends on SPI
> +	select AXI_ADC
> +	help
> +	  Say yes here to build support for Analog Devices:
> +	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> +
> +	  The driver requires the assistance of the AXI ADC IP core to operate,
> +	  since SPI is used for configuration only, while data has to be
> +	  streamed into memory via DMA.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad9467.
> +
>  config ASPEED_ADC
>  	tristate "Aspeed ADC"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index e14fabd53246..5018220b8ec7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD7949) += ad7949.o
>  obj-$(CONFIG_AD799X) += ad799x.o
> +obj-$(CONFIG_AD9467) += ad9467.o
>  obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>  obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> new file mode 100644
> index 000000000000..f268bbb6bcf6
> --- /dev/null
> +++ b/drivers/iio/adc/ad9467.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD9467 SPI ADC driver
> + *
> + * Copyright 2012-2020 Analog Devices Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <linux/clk.h>
> +
> +#include <linux/iio/adc/axi-adc.h>
> +
> +/*
> + * ADI High-Speed ADC common spi interface registers
> + * See Application-Note AN-877:
> + *   https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
> + */
> +
> +#define ADI_ADC_REG_CHIP_PORT_CONF		0x00

These prefixes should reflect the chip we are supporting here.
They aren't true for 'all' ADI parts.  

You could come up with some 'generic' but not to generic prefix
if you prefer.

> +#define ADI_ADC_REG_CHIP_ID			0x01
> +#define ADI_ADC_REG_CHIP_GRADE			0x02
> +#define ADI_ADC_REG_CHAN_INDEX			0x05
> +#define ADI_ADC_REG_TRANSFER			0xFF
> +#define ADI_ADC_REG_MODES			0x08
> +#define ADI_ADC_REG_TEST_IO			0x0D
> +#define ADI_ADC_REG_ADC_INPUT			0x0F
> +#define ADI_ADC_REG_OFFSET			0x10
> +#define ADI_ADC_REG_OUTPUT_MODE			0x14
> +#define ADI_ADC_REG_OUTPUT_ADJUST		0x15
> +#define ADI_ADC_REG_OUTPUT_PHASE		0x16
> +#define ADI_ADC_REG_OUTPUT_DELAY		0x17
> +#define ADI_ADC_REG_VREF			0x18
> +#define ADI_ADC_REG_ANALOG_INPUT		0x2C
> +
> +/* ADI_ADC_REG_TEST_IO */
> +#define ADI_ADC_TESTMODE_OFF			0x0
> +#define ADI_ADC_TESTMODE_MIDSCALE_SHORT		0x1
> +#define ADI_ADC_TESTMODE_POS_FULLSCALE		0x2
> +#define ADI_ADC_TESTMODE_NEG_FULLSCALE		0x3
> +#define ADI_ADC_TESTMODE_ALT_CHECKERBOARD	0x4
> +#define ADI_ADC_TESTMODE_PN23_SEQ		0x5
> +#define ADI_ADC_TESTMODE_PN9_SEQ		0x6
> +#define ADI_ADC_TESTMODE_ONE_ZERO_TOGGLE	0x7
> +#define ADI_ADC_TESTMODE_USER			0x8
> +#define ADI_ADC_TESTMODE_BIT_TOGGLE		0x9
> +#define ADI_ADC_TESTMODE_SYNC			0xA
> +#define ADI_ADC_TESTMODE_ONE_BIT_HIGH		0xB
> +#define ADI_ADC_TESTMODE_MIXED_BIT_FREQUENCY	0xC
> +#define ADI_ADC_TESTMODE_RAMP			0xF
> +
> +/* ADI_ADC_REG_TRANSFER */
> +#define ADI_ADC_TRANSFER_SYNC			0x1
> +
> +/* ADI_ADC_REG_OUTPUT_MODE */
> +#define ADI_ADC_OUTPUT_MODE_OFFSET_BINARY	0x0
> +#define ADI_ADC_OUTPUT_MODE_TWOS_COMPLEMENT	0x1
> +#define ADI_ADC_OUTPUT_MODE_GRAY_CODE		0x2
> +
> +/* ADI_ADC_REG_OUTPUT_PHASE */
> +#define ADI_ADC_OUTPUT_EVEN_ODD_MODE_EN		0x20
> +#define ADI_ADC_INVERT_DCO_CLK			0x80
> +
> +/* ADI_ADC_REG_OUTPUT_DELAY */
> +#define ADI_ADC_DCO_DELAY_ENABLE		0x80
> +
> +/*
> + * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
> + */
> +
> +#define CHIPID_AD9467			0x50
> +#define AD9467_DEF_OUTPUT_MODE		0x08
> +#define AD9467_REG_VREF_MASK		0x0F
> +
> +enum {
> +	ID_AD9467,
> +};
> +
> +struct ad9467_state {
> +	struct spi_device		*spi;
> +	struct clk			*clk;
> +	unsigned int			output_mode;
> +
> +	struct gpio_desc		*pwrdown_gpio;
> +	struct gpio_desc		*reset_gpio;
> +};
> +
> +static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> +{
> +	unsigned char buf[3];
> +	int ret;
> +
> +	buf[0] = 0x80 | (reg >> 8);
> +	buf[1] = reg & 0xFF;
> +
> +	ret = spi_write_then_read(spi, &buf[0], 2, &buf[2], 1);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return buf[2];
> +}
> +
> +static int ad9467_spi_write(struct spi_device *spi, unsigned int reg,
> +			    unsigned int val)
> +{
> +	unsigned char buf[3];
> +
> +	buf[0] = reg >> 8;
> +	buf[1] = reg & 0xFF;
> +	buf[2] = val;
> +
> +	return spi_write(spi, buf, ARRAY_SIZE(buf));
> +}
> +
> +static int ad9467_reg_access(struct axi_adc_conv *conv, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad9467_state *st = axi_adc_conv_priv(conv);
> +	struct spi_device *spi = st->spi;
> +	int ret;
> +
> +	if (readval == NULL) {
> +		ret = ad9467_spi_write(spi, reg, writeval);
> +		ad9467_spi_write(spi, ADI_ADC_REG_TRANSFER,
> +				 ADI_ADC_TRANSFER_SYNC);
> +		return ret;
> +	}
> +
> +	ret = ad9467_spi_read(spi, reg);
> +	if (ret < 0)
> +		return ret;
> +	*readval = ret;
> +
> +	return 0;
> +}
> +
> +static const unsigned int ad9467_scale_table[][2] = {
> +	{2000, 0}, {2100, 6}, {2200, 7},
> +	{2300, 8}, {2400, 9}, {2500, 10},
> +};
> +
> +static void __ad9467_get_scale(struct axi_adc_conv *conv, int index,
> +			       unsigned int *val, unsigned int *val2)
> +{
> +	const struct axi_adc_chip_info *info = conv->chip_info;
> +	const struct iio_chan_spec *chan = &info->channels[0].iio_chan;
> +	unsigned int tmp;
> +
> +	tmp = (info->scale_table[index][0] * 1000000ULL) >>
> +			chan->scan_type.realbits;
> +	*val = tmp / 1000000;
> +	*val2 = tmp % 1000000;
> +}
> +
> +#define AD9467_CHAN(_chan, _si, _bits, _sign)				\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = _chan,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
> +		BIT(IIO_CHAN_INFO_CALIBPHASE) |				\

These don't seem to be handled that I can see...

> +		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
> +	.scan_index = _si,						\
> +	.scan_type = {							\
> +		.sign = _sign,						\
> +		.realbits = _bits,					\
> +		.storagebits = 16,					\
> +		.shift = 0,						\

shift of 0 is the "obvious" default so no need to specify it...

> +	},								\
> +}
> +
> +static const struct axi_adc_chan_spec ad9467_channels[] = {
> +	{
> +		.iio_chan = AD9467_CHAN(0, 0, 16, 'S'),
> +		.num_lanes = 8,
> +	},
> +};
> +
> +static const struct axi_adc_chip_info ad9467_chip_info_tbl[] = {
> +	[ID_AD9467] = {
> +		.id = CHIPID_AD9467,
> +		.max_rate = 250000000UL,
> +		.scale_table = ad9467_scale_table,
> +		.num_scales = ARRAY_SIZE(ad9467_scale_table),
> +		.channels = ad9467_channels,
> +		.num_channels = ARRAY_SIZE(ad9467_channels),
> +	},
> +};
> +
> +static int ad9467_get_scale(struct axi_adc_conv *conv, int *val, int *val2)
> +{
> +	const struct axi_adc_chip_info *info = conv->chip_info;
> +	struct ad9467_state *st = axi_adc_conv_priv(conv);
> +	unsigned int i, vref_val, vref_mask;
> +
> +	vref_val = ad9467_spi_read(st->spi, ADI_ADC_REG_VREF);
> +
> +	switch (info->id) {
> +	case CHIPID_AD9467:
> +		vref_mask = AD9467_REG_VREF_MASK;
> +		break;
> +	default:
> +		vref_mask = 0xFFFF;
> +		break;
> +	}
> +
> +	vref_val &= vref_mask;
> +
> +	for (i = 0; i < info->num_scales; i++) {
> +		if (vref_val == info->scale_table[i][1])
> +			break;
> +	}
> +
> +	if (i == info->num_scales)
> +		return -ERANGE;
> +
> +	__ad9467_get_scale(conv, i, val, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ad9467_set_scale(struct axi_adc_conv *conv, int val, int val2)
> +{
> +	const struct axi_adc_chip_info *info = conv->chip_info;
> +	struct ad9467_state *st = axi_adc_conv_priv(conv);
> +	unsigned int scale_val[2];
> +	unsigned int i;
> +
> +	if (val != 0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < info->num_scales; i++) {
> +		__ad9467_get_scale(conv, i, &scale_val[0], &scale_val[1]);
> +		if (scale_val[0] != val || scale_val[1] != val2)
> +			continue;
> +
> +		ad9467_spi_write(st->spi, ADI_ADC_REG_VREF,
> +				 info->scale_table[i][1]);
> +		ad9467_spi_write(st->spi, ADI_ADC_REG_TRANSFER,
> +				 ADI_ADC_TRANSFER_SYNC);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad9467_read_raw(struct axi_adc_conv *conv,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long m)
> +{
> +	struct ad9467_state *st = axi_adc_conv_priv(conv);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad9467_get_scale(conv, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!st->clk)
> +			return -ENODEV;
> +
> +		*val = clk_get_rate(st->clk);
> +
> +		return IIO_VAL_INT;
> +
> +	}
> +	return -EINVAL;

I'd put that in a default in the switch as you may get warnings
from some static checkers otherwise.

> +}
> +
> +static int ad9467_write_raw(struct axi_adc_conv *conv,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	const struct axi_adc_chip_info *info = conv->chip_info;
> +	struct ad9467_state *st = axi_adc_conv_priv(conv);
> +	unsigned long r_clk;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad9467_set_scale(conv, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!st->clk)
> +			return -ENODEV;
> +
> +		if (chan->extend_name)
> +			return -ENODEV;
> +
> +		r_clk = clk_round_rate(st->clk, val);
> +		if (r_clk < 0 || r_clk > info->max_rate) {
> +			dev_warn(&st->spi->dev,
> +				 "Error setting ADC sample rate %ld", r_clk);
> +			return -EINVAL;
> +		}
> +
> +		ret = clk_set_rate(st->clk, r_clk);
> +		if (ret < 0)
> +			return ret;
return clk_set_rate(st->clk, r_clk) is probably the same.
Might as well do early returns everywhere.

> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
> +{
> +	int ret;
> +
> +	ret = ad9467_spi_write(spi, ADI_ADC_REG_OUTPUT_MODE, mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad9467_spi_write(spi, ADI_ADC_REG_TRANSFER,
> +				ADI_ADC_TRANSFER_SYNC);
> +}
> +
> +static int ad9467_preenable_setup(struct axi_adc_conv *conv)
> +{
> +	struct ad9467_state *st = axi_adc_conv_priv(conv);
> +
> +	return ad9467_outputmode_set(st->spi, st->output_mode);
> +}
> +
> +static int ad9467_setup(struct ad9467_state *st, unsigned int chip_id)
> +{
> +	switch (chip_id) {
> +	case CHIPID_AD9467:
> +		st->output_mode = AD9467_DEF_OUTPUT_MODE |
> +				  ADI_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> +		break;

return 0 unless you are going to add anything after the switch statement.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ad9467_clk_disable(void *data)
> +{
> +	struct ad9467_state *st = data;
> +
> +	clk_disable_unprepare(st->clk);
> +}
> +
> +static int ad9467_probe(struct spi_device *spi)
> +{
> +	struct axi_adc_conv *conv;
> +	struct ad9467_state *st;
> +	unsigned int id;
> +	int ret;
> +
> +	conv = devm_axi_adc_conv_register(&spi->dev, sizeof(*st));
> +

No blank line between a call and it's error handler.

> +	if (IS_ERR(conv))
> +		return PTR_ERR(conv);
> +
> +	st = axi_adc_conv_priv(conv);
> +	st->spi = spi;
> +
> +	st->clk = devm_clk_get(&spi->dev, "sample-clock");
> +	if (IS_ERR(st->clk))
> +		return PTR_ERR(st->clk);
> +
> +	ret = clk_prepare_enable(st->clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad9467_clk_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(st->pwrdown_gpio))
> +		return PTR_ERR(st->pwrdown_gpio);
> +
> +	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +						 GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio))
> +		return PTR_ERR(st->reset_gpio);
> +
> +	if (st->reset_gpio) {
> +		udelay(1);
> +		ret = gpiod_direction_output(st->reset_gpio, 1);
> +		mdelay(10);
> +	}
> +
> +	spi_set_drvdata(spi, st);
> +
> +	id = spi_get_device_id(spi)->driver_data;
> +	conv->chip_info = &ad9467_chip_info_tbl[id];
> +
> +	id = ad9467_spi_read(spi, ADI_ADC_REG_CHIP_ID);
> +	if (id != conv->chip_info->id) {
> +		dev_err(&spi->dev, "Unrecognized CHIP_ID 0x%X\n", id);
> +		return -ENODEV;
> +	}
> +
> +	conv->reg_access = ad9467_reg_access;
> +	conv->write_raw = ad9467_write_raw;
> +	conv->read_raw = ad9467_read_raw;
> +	conv->preenable_setup = ad9467_preenable_setup;
> +
> +	return ad9467_setup(st, id);
> +}
> +
> +static const struct spi_device_id ad9467_id[] = {
> +	{ "ad9467", ID_AD9467 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad9467_id);
> +
> +static const struct of_device_id ad9467_of_match[] = {
> +	{ .compatible = "adi,ad9467" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad9467_of_match);
> +
> +static struct spi_driver ad9467_driver = {
> +	.driver = {
> +		.name = "ad9467",
> +		.of_match_table = ad9467_of_match,
> +	},
> +	.probe = ad9467_probe,
> +	.id_table = ad9467_id,

This is something I've only just started raising in reviews.
If a driver can't realistically be instantiated without firmware
bindings, there isn't really any point in providing the id_table
that I can think of so please remove.

> +};
> +module_spi_driver(ad9467_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD9467 ADC driver");
> +MODULE_LICENSE("GPL v2");

