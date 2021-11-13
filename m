Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39D044F470
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhKMSNx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 13:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhKMSNx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 13:13:53 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F91260FDA;
        Sat, 13 Nov 2021 18:10:57 +0000 (UTC)
Date:   Sat, 13 Nov 2021 18:15:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: addac: add AD74413R driver
Message-ID: <20211113181529.72c974f8@jic23-huawei>
In-Reply-To: <20211105143550.1783528-4-demonsingur@gmail.com>
References: <20211105143550.1783528-1-demonsingur@gmail.com>
        <20211105143550.1783528-4-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  5 Nov 2021 16:35:50 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> Add IIO ADDAC driver for AD74413R.

Nice to have a tiny bit more detail in the description particularly
as you support multiple parts but only mention one here or in the
patch title.  Generally a short description of the part + highlights
of the features supported are useful things to have in the description
of a new driver patch.

Also nice to have is an example of what the file structure in sysfs looks like.
In this particular driver that would be really useful as it is rather non obvious!
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

I'll be looking for an ack from Linus W for this as it is also a GPIO driver
and a slightly odd one at that for inputs anyway.

Given it's a complex driver I've probably spotted things I missed in earlier
reviews as we are getting closer to where we want to be.

...

> diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
> index 2e64d7755d5e..06b26f8d0144 100644
> --- a/drivers/iio/addac/Kconfig
> +++ b/drivers/iio/addac/Kconfig
> @@ -5,4 +5,16 @@
>  
>  menu "Analog to digital and digital to analog converters"
>  
> +config AD74413R
> +	tristate "Analog Devices AD74413R/AD74412R driver"
> +	depends on GPIOLIB && SPI
> +	select REGMAP_SPI
> +	select CRC8
> +	help
> +	  Say yes here to build support for Analog Devices AD74413R/AD74412R

Put them in numeric order in descriptions.  If we end up adding additional
parts later, it is then obvious where they should go.

> +	  quad-channel software configurable input/output solution.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad74413r.
> +
>  endmenu

...

> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> new file mode 100644
> index 000000000000..112e2810b4bc
> --- /dev/null
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -0,0 +1,1492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Analog Devices, Inc.
> + * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/crc8.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <dt-bindings/iio/addac/adi,ad74413r.h>
> +
> +#define AD74413R_CRC_POLYNOMIAL	0x7
> +DECLARE_CRC8_TABLE(ad74413r_crc8_table);
> +
> +#define AD74413R_CHANNEL_MAX	4
> +
> +struct ad74413r_config {
> +	bool hart_support;
> +};
> +
> +struct ad74413r_channel_config {
> +	u32 func;
> +	bool gpo_comparator;
> +	bool initialized;
> +};
> +
> +struct ad74413r_channels {
> +	struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +struct ad74413r_state {
> +	struct ad74413r_channel_config	channel_configs[AD74413R_CHANNEL_MAX];
> +	unsigned int			gpo_gpio_offsets[AD74413R_CHANNEL_MAX];
> +	unsigned int			comp_gpio_offsets[AD74413R_CHANNEL_MAX];
> +	struct gpio_chip		gpo_gpiochip;
> +	struct gpio_chip		comp_gpiochip;
> +	struct mutex			lock;
> +	struct completion		adc_data_completion;
> +	unsigned int			num_gpo_gpios;
> +	unsigned int			num_comparator_gpios;
> +
> +	struct spi_device		*spi;
> +	struct regulator		*refin_reg;
> +	struct regmap			*regmap;
> +	struct device			*dev;
> +	struct iio_trigger		*trig;
> +	const struct ad74413r_config	*config;
> +
> +	u32				rsense_resistance_ohms;
> +
> +	struct spi_message		reg_read_msg;
> +	struct spi_transfer		reg_read_xfer[2];
> +
> +	struct spi_message		reg_write_msg;
> +	struct spi_transfer		reg_write_xfer[1];
> +
> +	size_t				adc_active_channels;
> +	struct spi_message		adc_samples_msg;
> +	struct spi_transfer		adc_samples_xfer[AD74413R_CHANNEL_MAX + 1];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		__be32 rx_buf[AD74413R_CHANNEL_MAX];
> +		s64 timestamp;
> +	} adc_samples ____cacheline_aligned;

I would rename this structure as it shadows the first part of the tx_buf that follows
and that makes it a tiny bit tricky to spot the difference where these are used.

> +	__be32				adc_samples_tx_buf[AD74413R_CHANNEL_MAX];
> +	__be32				reg_read_buf[2];
> +	__be32				reg_write_buf[1];

This doesn't seem to be treated as a __be32 in the driver, so perhaps that's not the
appropriate type?

> +};
> +

> +#define AD74413R_ADC_RESULT_MAX		((1 << 16) - 1)

GENMASK(15, 0) might be clearer?


> +static void ad74413r_format_reg_write(unsigned int reg, unsigned int val,
> +				      u8 *buf)
> +{
> +	buf[0] = reg & 0xff;

So reg is a u8?  Make it one in the function definition and move any necessary masking
to the callers.

> +	buf[1] = (val >> 8) & 0xff;
> +	buf[2] = val & 0xff;

This in put_unaligned_be16() I think.  Use that to make this explicit if possible.

> +	buf[3] = ad74413r_crc(buf);
> +}
> +
> +static int ad74413r_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct spi_device *spi = context;
> +	struct ad74413r_state *st = spi_get_drvdata(spi);

This is a bad sign that the driver structure is wrong.  We should always
be calling this sort of function from a place where we already have access to the
top of a tree of structures (typically the iio_dev in this case).

I would pass either the struct iio_dev or the struct ad74413r_state into the
regmap registration as the context.

> +	u8 *buf = (u8 *)&st->reg_write_buf[0];

As noted above, reg_write_buf[] gets treated as a u8 array so cleaner to make
it such an array.

> +
> +	ad74413r_format_reg_write(reg, val, buf);
> +
> +	return spi_sync(spi, &st->reg_write_msg);
> +}
> +
> +static int ad74413r_crc_check(struct ad74413r_state *st, u8 *buf)
> +{
> +	u8 expected_crc = ad74413r_crc(buf);
> +
> +	if (buf[3] != expected_crc) {
> +		dev_err(st->dev, "Bad CRC %02x for %02x%02x%02x\n",
> +			buf[3], buf[0], buf[1], buf[2]);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad74413r_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct spi_device *spi = context;
> +	struct ad74413r_state *st = spi_get_drvdata(spi);
> +	u8 *tx_buf = (u8 *)&st->reg_read_buf[0];
> +	u8 *rx_buf = (u8 *)&st->reg_read_buf[1];

Seems this is being treated as a u8 array, perhaps make it one to avoid the
need to cast in lots of places.

> +	int ret;
> +
> +	ad74413r_format_reg_write(AD74413R_REG_READ_SELECT, reg, tx_buf);
> +
> +	ret = spi_sync(spi, &st->reg_read_msg);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_crc_check(st, rx_buf);
> +	if (ret)
> +		return ret;
> +
> +	*val = (rx_buf[1] << 8) | rx_buf[2];

get_unaligned_be16() to make it explicit what is going on here - also might be
more efficient on some architectures.


> +
> +	return 0;
> +}
> +
> +const struct regmap_config ad74413r_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.reg_read = ad74413r_reg_read,
> +	.reg_write = ad74413r_reg_write,
> +};
> +

...

> +
> +static int ad74413r_range_to_voltage_offset_raw(struct ad74413r_state *st,
> +						unsigned int range, int *val)
> +{
> +	switch (range) {
> +	case AD74413R_ADC_RANGE_10V:
> +	case AD74413R_ADC_RANGE_2P5V_EXT_POW:
> +		*val = 0;
> +		return 0;
> +	case AD74413R_ADC_RANGE_2P5V_INT_POW:
> +		*val = -AD74413R_ADC_RESULT_MAX;
> +		return 0;
> +	case AD74413R_ADC_RANGE_5V_BI_DIR:
> +		*val = -AD74413R_ADC_RESULT_MAX / 2;
> +		return 0;
> +	}
> +
> +	dev_err(st->dev, "ADC range invalid\n");
> +	return -EINVAL;

I'd prefer if this was in a default: branch of the above switch as makes
it really obvious to compilers that we are handling all the cases.

Same for similar code elsewhere in the driver.

> +}

...

> +static int _ad74413r_get_single_adc_result(struct ad74413r_state *st,
> +					   unsigned int channel, int *val)
> +{
> +	unsigned int uval;
> +	int ret;
> +
> +	reinit_completion(&st->adc_data_completion);
> +
> +	ret = ad74413r_set_adc_channel_enable(st, channel, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_SINGLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = wait_for_completion_timeout(&st->adc_data_completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret) {
> +		ret = -ETIMEDOUT;
> +		return ret;
> +	}
> +
> +	ret = regmap_read(st->regmap, AD74413R_REG_ADC_RESULT_X(channel),
> +			  &uval);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_OFF);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_set_adc_channel_enable(st, channel, false);
> +	if (ret)
> +		return ret;
> +
> +	*val = uval;
> +	ret = IIO_VAL_INT;
> +
> +	return ret;

	return IIO_VAL_INT;

> +}
> +

...

> +
> +static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
> +				     const unsigned long *active_scan_mask)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +	struct spi_transfer *xfer;
> +	unsigned int channel;
> +	int index = 0;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	spi_message_init(&st->adc_samples_msg);
> +	st->adc_active_channels = 0;
> +
> +	for_each_clear_bit(channel, active_scan_mask, AD74413R_CHANNEL_MAX) {
> +		ret = ad74413r_set_adc_channel_enable(st, channel, false);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (*active_scan_mask == 0)
> +		goto out;
> +
> +	/*
> +	 * The read select register is used to select which register's value
> +	 * will be sent by the slave on the next SPI frame.
> +	 *
> +	 * Create an SPI message that, on each step, writes to the read select
> +	 * register to select the ADC result of the next enabled channel, and
> +	 * reads the ADC result of the previous enabled channel.
> +	 *
> +	 * Example:
> +	 * W: [WCH1] [WCH2] [WCH2] [WCH3] [    ]
> +	 * R: [    ] [RCH1] [RCH2] [RCH3] [RCH4]

Nice explanation. Thanks.

> +	 */
> +
> +	for_each_set_bit(channel, active_scan_mask, AD74413R_CHANNEL_MAX) {
> +		u8 *tx_buf;
> +
> +		ret = ad74413r_set_adc_channel_enable(st, channel, true);
> +		if (ret)
> +			goto out;
> +
> +		st->adc_active_channels++;
> +
> +		xfer = &st->adc_samples_xfer[index];
> +
> +		if (index == 0)
> +			xfer->rx_buf = NULL;
> +		else
> +			xfer->rx_buf = &st->adc_samples.rx_buf[index - 1];
> +
> +		tx_buf = (u8 *)&st->adc_samples_tx_buf[index];

Whilst it would make the code a little more complex, I'd suggest making
adc_samples_tx_buf a u8 array as it is not a __be32 one in any real sense.

Perhaps get tx_buf = st->adc_samples_tx_buf; outside the loop and then
increment that pointer by 4 in here.  That will match nicely with
the len value as you set it so it will be obvious what is going on.

> +
> +		xfer->tx_buf = tx_buf;
> +		xfer->len = 4;
> +		xfer->cs_change = 1;
> +
> +		ad74413r_format_reg_write(AD74413R_REG_READ_SELECT,
> +					  AD74413R_REG_ADC_RESULT_X(channel),
> +					  tx_buf);
> +
> +		spi_message_add_tail(xfer, &st->adc_samples_msg);
> +
> +		index++;
> +	}
> +
> +	xfer = &st->adc_samples_xfer[index];
> +
> +	xfer->tx_buf = NULL;
> +	xfer->rx_buf = &st->adc_samples.rx_buf[index - 1];
> +	xfer->len = 4;
> +	xfer->cs_change = 0;

Unlike the register read write equivalents of this in probe() setting this sequence up
makes much more sense as it's both larger and in a performance sensitive path.

 
> +
> +	spi_message_add_tail(xfer, &st->adc_samples_msg);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +

...

> +
> +static int ad74413r_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (chan->output)
> +				return ad74413r_get_output_voltage_scale(st,
> +					val, val2);
> +			else
> +				return ad74413r_get_input_voltage_scale(st,
> +					chan->channel, val, val2);
> +		case IIO_CURRENT:
> +			if (chan->output)
> +				return ad74413r_get_output_current_scale(st,
> +					val, val2);
> +			else
> +				return ad74413r_get_input_current_scale(st,
> +					chan->channel, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return ad74413r_get_input_voltage_offset(st,
> +				chan->channel, val);
> +		case IIO_CURRENT:
> +			return ad74413_get_input_current_offset(st,
> +				chan->channel, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_RAW: {

Only need to define scope if you are going to have local variables.  There
aren't any so in this case brackets add nothing useful.

> +		if (chan->output)
> +			return -EINVAL;
> +
> +		return ad74413r_get_single_adc_result(indio_dev, chan->channel,
> +						      val);
> +	}
> +	case IIO_CHAN_INFO_PROCESSED: {
> +		int ret;
> +
> +		ret = ad74413r_get_single_adc_result(indio_dev, chan->channel,
> +						     val);
> +		if (ret < 0)
> +			return ret;
> +
> +		ad74413r_adc_to_resistance_result(*val, val);
> +
> +		return ret;
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad74413r_get_adc_rate(st, chan->channel, val);
> +	}
> +
> +	return -EINVAL;
Move to default: in the switch

> +}
> +
> +static int ad74413r_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct ad74413r_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!chan->output)
> +			return -EINVAL;
> +
> +		if (val > AD74413R_DAC_CODE_MAX) {
> +			dev_err(st->dev, "Invalid DAC code\n");
> +			return -EINVAL;
> +		}
> +
> +		return ad74413r_set_channel_dac_code(st, chan->channel, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad74413r_set_adc_rate(st, chan->channel, val);
> +	}
> +
> +	return -EINVAL;
Move that to a default: entry to suppress any 'unhandled case' warnings from static analysis.

> +}

...

> +static const struct iio_info ad74413r_info = {
> +	.read_raw = &ad74413r_read_raw,
> +	.write_raw = &ad74413r_write_raw,
> +	.read_avail = &ad74413r_read_avail,
> +	.update_scan_mode = &ad74413r_update_scan_mode,
> +};
> +
> +#define AD74413R_CHANNEL(_type, _output, extra_mask_separate)		\

I'd be tempted to drop this first definition and just have the ADC and DAC ones below.
Might cost you a few repeated lines, but reduce the levels of macros that
a reviewer needs to look at.


> +		.type = _type,						\
> +		.indexed = 1,						\
> +		.output = _output,					\

For macros you should have () around all variables.  Avoids odd results if
particular weird strings are passed in.  Normally one of the static checkers
will complain about this.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> +				      | extra_mask_separate
> +
> +#define AD74413R_DAC_CHANNEL(_type, extra_mask_separate)		\
> +	{								\
> +		AD74413R_CHANNEL(_type, 1, extra_mask_separate),	\
> +	}
> +
> +#define AD74413R_ADC_CHANNEL(_type, extra_mask_separate)		\
> +	{								\
> +		AD74413R_CHANNEL(_type, 0, extra_mask_separate		\
> +			| BIT(IIO_CHAN_INFO_SAMP_FREQ)),		\
> +		.info_mask_separate_available =				\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 16,					\
> +			.storagebits = 32,				\
> +			.shift = 8,					\
> +			.endianness = IIO_BE,				\
> +		},							\
> +	}
> +
> +#define AD74413R_ADC_VOLTAGE_CHANNEL					\
> +	AD74413R_ADC_CHANNEL(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE)	\
> +			     | BIT(IIO_CHAN_INFO_OFFSET))
> +
> +#define AD74413R_ADC_CURRENT_CHANNEL					\
> +	AD74413R_ADC_CHANNEL(IIO_CURRENT,  BIT(IIO_CHAN_INFO_SCALE)	\
> +			     | BIT(IIO_CHAN_INFO_OFFSET))
> +
> +static struct iio_chan_spec ad74413r_high_impedance_channels[] = {
> +	AD74413R_ADC_VOLTAGE_CHANNEL,

This is the same as the voltage_input_channels one below, perhaps just
have one and point to it from both places?

> +};
> +
> +static struct iio_chan_spec ad74413r_voltage_output_channels[] = {
> +	AD74413R_DAC_CHANNEL(IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE)),
> +	AD74413R_ADC_CURRENT_CHANNEL,
> +};
> +
> +static struct iio_chan_spec ad74413r_current_output_channels[] = {
> +	AD74413R_DAC_CHANNEL(IIO_CURRENT, BIT(IIO_CHAN_INFO_SCALE)),
> +	AD74413R_ADC_VOLTAGE_CHANNEL,
> +};
> +
> +static struct iio_chan_spec ad74413r_voltage_input_channels[] = {
> +	AD74413R_ADC_VOLTAGE_CHANNEL,
> +};
> +
> +static struct iio_chan_spec ad74413r_current_input_channels[] = {
> +	AD74413R_ADC_CURRENT_CHANNEL,
> +};
> +
> +static struct iio_chan_spec ad74413r_resistance_input_channels[] = {
> +	AD74413R_ADC_CHANNEL(IIO_RESISTANCE, BIT(IIO_CHAN_INFO_PROCESSED)),
> +};
> +
> +static struct iio_chan_spec ad74413r_digital_input_channels[] = {
> +	AD74413R_ADC_VOLTAGE_CHANNEL,

I wonder if this indicates that we shouldn't be treating those
as digital inputs at all, but rather as IIO threshold events? That way the threshold
programming etc will be natural.  It's documented as the ADC being 'available' in
digital input mode though so perhaps we are better sticking with what people expect
to see? 

I also see we have a counter on the inputs so I guess at somepoint we may end
up with counter subsystem support in here as well.

> +};
> +
> +#define _AD74413R_CHANNELS(_channels)			\
> +	{						\
> +		.channels = _channels,			\
> +		.num_channels = ARRAY_SIZE(_channels),	\
> +	}
> +
> +#define AD74413R_CHANNELS(name) \
> +	_AD74413R_CHANNELS(ad74413r_ ## name ## _channels)
> +
> +static const struct ad74413r_channels ad74413r_channels_map[] = {
> +	[CH_FUNC_HIGH_IMPEDANCE] = AD74413R_CHANNELS(high_impedance),
> +	[CH_FUNC_VOLTAGE_OUTPUT] = AD74413R_CHANNELS(voltage_output),
> +	[CH_FUNC_CURRENT_OUTPUT] = AD74413R_CHANNELS(current_output),
> +	[CH_FUNC_VOLTAGE_INPUT] = AD74413R_CHANNELS(voltage_input),
> +	[CH_FUNC_CURRENT_INPUT_EXT_POWER] = AD74413R_CHANNELS(current_input),
> +	[CH_FUNC_CURRENT_INPUT_LOOP_POWER] = AD74413R_CHANNELS(current_input),
> +	[CH_FUNC_RESISTANCE_INPUT] = AD74413R_CHANNELS(current_input),
> +	[CH_FUNC_DIGITAL_INPUT_LOGIC] = AD74413R_CHANNELS(current_input),
> +	[CH_FUNC_DIGITAL_INPUT_LOOP_POWER] = AD74413R_CHANNELS(resistance_input),
> +	[CH_FUNC_CURRENT_INPUT_EXT_POWER_HART] = AD74413R_CHANNELS(digital_input),
> +	[CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART] = AD74413R_CHANNELS(digital_input),
> +};
> +

...


> +static int ad74413r_setup_gpios(struct ad74413r_state *st)
> +{
> +	struct ad74413r_channel_config *config;
> +	unsigned int gpio_i;
> +	unsigned int i;
> +	u8 gpo_config;
> +	int ret;
> +
> +	for (i = 0, gpio_i = 0; i < AD74413R_CHANNEL_MAX; i++) {
> +		config = &st->channel_configs[i];
> +
> +		if (config->gpo_comparator)
> +			gpo_config = AD74413R_GPO_CONFIG_COMPARATOR;
> +		else
> +			gpo_config = AD74413R_GPO_CONFIG_LOGIC;
> +
> +		ret = ad74413r_set_gpo_config(st, i, gpo_config);
> +		if (ret)
> +			return ret;
> +
> +		if (config->gpo_comparator)
> +			continue;

Perhaps combine the two loops and use separate gpio_X indexes to deal with the two paths?
Or am I missing a reason you can't do that?

> +
> +		st->gpo_gpio_offsets[gpio_i++] = i;
> +	}
> +
> +	for (i = 0, gpio_i = 0; i < AD74413R_CHANNEL_MAX; i++) {
> +		config = &st->channel_configs[i];
> +
> +		if (config->func != CH_FUNC_DIGITAL_INPUT_LOGIC
> +			|| config->func != CH_FUNC_DIGITAL_INPUT_LOOP_POWER) {
> +			continue;
> +		}
> +
> +		st->comp_gpio_offsets[gpio_i++] = i;
> +	}
> +
> +	return 0;
> +}
> +
...

> +static int ad74413r_probe(struct spi_device *spi)
> +{
> +	struct ad74413r_state *st;
> +	struct iio_dev *indio_dev;
> +	const char *name;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, st);

As noted above, this shouldn't be needed as we should be passing st of indio_dev
to the regmap registration and hence be able to get them from context.

> +
> +	st->spi = spi;
> +	st->dev = &spi->dev;
> +	st->config = device_get_match_data(&spi->dev);
> +	mutex_init(&st->lock);
> +	init_completion(&st->adc_data_completion);
> +
> +	name = dev_name(st->dev);

what does this return?  For indio_dev->name it should be the part number and I'm
not sure this is.

> +
> +	st->reg_read_xfer[0].tx_buf = &st->reg_read_buf[0];
> +	st->reg_read_xfer[0].len = 4;
If you can structure this as ARRAY_SIZE() of appropriate buffer
and hence only have the size in one place that would be good.

I'd be tempted to have a reg_tx_buf[] and reg_rx_buf[] and reuse
the tx_buf for both the read and write paths.

I think that would be cleaner than thes offsets into reG_read_buf

> +	st->reg_read_xfer[0].cs_change = 1;
> +	st->reg_read_xfer[1].rx_buf = &st->reg_read_buf[1];
> +	st->reg_read_xfer[1].len = 4;
> +	st->reg_read_xfer[1].cs_change = 0;

cs_change == 0 will be the default and is the 'obvious' one at that so no
need to set it here - just in the case when its different from normal.

> +	spi_message_init_with_transfers(&st->reg_read_msg,
> +					st->reg_read_xfer, 2);
> +
> +	st->reg_write_xfer[0].tx_buf = &st->reg_write_buf[0];
> +	st->reg_write_xfer[0].len = 4;
> +	st->reg_write_xfer[0].cs_change = 0;
> +	spi_message_init_with_transfers(&st->reg_write_msg,
> +					st->reg_write_xfer, 1);

I'm a little doubtful that pre initializing these simple transfers is
worth while.  The write is just an spi_write() and the read could
be nicely mapped onto spi_write_then_read() if that supported the
cs_change flag. Unfortunately it doesn't, but but this is still not
a particularly expensive thing to set up on each call allowing you
to make it local to the calls and avoid the need for access to st.
That would make the regmap code look a lot more like standard regmap_spi
which would give me warn and fuzzy feelings :)

> +
> +	st->regmap = devm_regmap_init(st->dev, NULL, spi,

Mentioned above, but given you need access to contents of st, I'd pass
that rather than spi in here.

The pattern of transfers in this driver is reasonably common (I think) so
it might be worth thinking about adding this crc checked spi transfer to
the generic code at some point

> +				      &ad74413r_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);;
> +
> +	st->refin_reg = devm_regulator_get(st->dev, "refin");
> +	if (IS_ERR(st->refin_reg))
> +		return PTR_ERR(st->refin_reg);

return dev_err_probe()
for calls that we know can fail. It will print a message if not deferred but
importantly it will add debug info for the reason the driver load was deferred
which can be very helpful to have.

> +
> +	ret = regulator_enable(st->refin_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(st->dev, ad74413r_regulator_disable,
> +				       st->refin_reg);
> +	if (ret)
> +		return ret;
> +
> +	st->rsense_resistance_ohms = 100;
> +	device_property_read_u32(st->dev, "adi,rsense-resistance-ohms",
> +				 &st->rsense_resistance_ohms);
> +
> +	st->trig = devm_iio_trigger_alloc(st->dev, "%s-dev%d", name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad74413r_trigger_ops;
> +	st->trig->dev.parent = st->dev;

The parent should be set by the devm_iio_trigger_alloc call above.

> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_iio_trigger_register(st->dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = name;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;

INDIO_BUFFER_SOFTWARE should be set by the core in
devm_iio_triggered_buffer_setup()

> +	indio_dev->info = &ad74413r_info;
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	ret = ad74413r_parse_channel_configs(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74413r_setup_channels(indio_dev);
> +	if (ret) {
> +		dev_err(st->dev, "Failed to setup channels: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ad74413r_setup_gpios(st);
> +	if (ret) {
> +		return ret;
> +	}
> +
> +	if (st->num_gpo_gpios) {
> +		st->gpo_gpiochip.owner = THIS_MODULE;
> +		st->gpo_gpiochip.label = name;
> +		st->gpo_gpiochip.base = -1;
> +		st->gpo_gpiochip.ngpio = st->num_gpo_gpios;
> +		st->gpo_gpiochip.parent = st->dev;
> +		st->gpo_gpiochip.can_sleep = true;
> +		st->gpo_gpiochip.set = ad74413r_gpio_set;
> +		st->gpo_gpiochip.set_multiple = ad74413r_gpio_set_multiple;
> +		st->gpo_gpiochip.set_config = ad74413r_gpio_set_gpo_config;
> +		st->gpo_gpiochip.get_direction =
> +			ad74413r_gpio_get_gpo_direction;
> +
> +		ret = devm_gpiochip_add_data(st->dev, &st->gpo_gpiochip, st);
> +		if (ret)
> +			return ret;

Good idea to present this as two separate gpiochips.

> +	}
> +
> +	if (st->num_comparator_gpios) {
> +		st->comp_gpiochip.owner = THIS_MODULE;
> +		st->comp_gpiochip.label = name;
> +		st->comp_gpiochip.base = -1;
> +		st->comp_gpiochip.ngpio = st->num_comparator_gpios;
> +		st->comp_gpiochip.parent = st->dev;
> +		st->comp_gpiochip.can_sleep = true;
> +		st->comp_gpiochip.get = ad74413r_gpio_get;
> +		st->comp_gpiochip.get_multiple = ad74413r_gpio_get_multiple;
> +		st->comp_gpiochip.set_config = ad74413r_gpio_set_comp_config;
> +		st->comp_gpiochip.get_direction =
> +			ad74413r_gpio_get_comp_direction;
> +
> +		ret = devm_gpiochip_add_data(st->dev, &st->comp_gpiochip, st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ad74413r_set_adc_conv_seq(st, AD74413R_CONV_SEQ_OFF);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(st->dev, spi->irq, ad74413r_adc_data_interrupt,
> +			       IRQF_TRIGGER_FALLING, name, indio_dev);

Generally we try to avoid forcing the direction of irqs in a driver.  They should
be correctly established by firmware and it is annoying common for someone to stick
an inverter in the path as a cheap level converter.

> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(st->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad74413r_trigger_handler,
> +					      &ad74413r_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(st->dev, indio_dev);
> +}
> +

