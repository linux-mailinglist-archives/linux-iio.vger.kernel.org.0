Return-Path: <linux-iio+bounces-5177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E808CC312
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 16:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9489C1C22A84
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280F1420C6;
	Wed, 22 May 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbX8uhNh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62E1420A9;
	Wed, 22 May 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387508; cv=none; b=fYbpVAXPqtlV+Pb+iGNWBS5blgd2jvBd8OOo0gsgKdr9+2inINpVH74GK0SPcF8UWco4nJOAx9R3hz1v7DBFu51kvBpp9/pcZkvuQSVQsGk1uSAoTzyS37tq9Gs5nvUwGr0NGVmIi2lszukScFnsu5mR+/v98H3MO+7KGic+o9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387508; c=relaxed/simple;
	bh=DzD3By/k32ba5WE4lkz1fnbWIaEp00hl3xtDtbiR0UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou8FzpQ/aCVfQ5neijLEc71GYBsBE+FyoA9SoiWk3+PzRkhIipvRTmddrb+FBepODH/df2/dg2vumDt2s208iByFWcWDTxXIfB2iQCJVyP/J7TSgNP8YkCPE9jnPz2UwrDjXVIYIl7me/rth/J5+FjB7Il3HrLp5Uj5JFUAru4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbX8uhNh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716387507; x=1747923507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DzD3By/k32ba5WE4lkz1fnbWIaEp00hl3xtDtbiR0UQ=;
  b=lbX8uhNh5kGoMzUBRKNUeCbiQLpYTG7YL9/18nZKNsFx08tPVeLmEFoo
   Wws5Yx0eumnr5dQqeNmfmgeHfoYAXggtBSusJ/DRj+dL0GMQ7bWemjzdW
   kodQDvsbxXDCicXzZ1J0KMYwyArOP5Pym82TR57BJg49HyJxbjj0QurGq
   TwfbQ6OcLoR2O74qeLt5ABHYgRZUap/frMPcv2TyzRtb6TQvfV/RAnLCD
   fMj1sfeUwcq9Zj7/obDS16YTs+Nfs5nbTB/RNsMCI1qk/LOnC4nB6ygRw
   5qv/mRAeaXucrS5dA0TI3MLK6L06blHZqEXln0pzuKHleycmu9c/y7HMC
   Q==;
X-CSE-ConnectionGUID: OZ7IH4LSSeSlzGzSlMyGyQ==
X-CSE-MsgGUID: ncO0//OmTzWBGsPDo4OmFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="35153062"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="35153062"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:18:26 -0700
X-CSE-ConnectionGUID: grwJF+TdT0CIoo9mbbKiRQ==
X-CSE-MsgGUID: 1bkH+k1zQxCne/+96+VV9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33745251"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:18:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9mnL-00000009zQk-2PVx;
	Wed, 22 May 2024 17:18:19 +0300
Date: Wed, 22 May 2024 17:18:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: ranechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: adc: add support for ad777x family
Message-ID: <Zk3-qxCb0zfR440Q@smile.fi.intel.com>
References: <20240522120005.18197-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522120005.18197-1-ramona.nechita@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 02:59:53PM +0300, ranechita wrote:
> Added support for ad7770,ad7771,ad7779 ADCs. The
> data is streamed only on the spi-mode, without
> using the data lines.

> ---

Please, explain here, in the comment area, why any existing driver can not be
reused (extended) for these ADCs.

...

> +#include <linux/gpio.h>

This header must not be in the new code.

...

> +#define AD777X_SINC3_MAXFREQ			16000
> +#define AD777X_SINC5_MAXFREQ			128000

HZ_PER_KHZ ? You will need units.h.

...

> +#define DEC3					1000
> +#define DEC6					1000000

NIH some of units.h constants. Use them.

...


> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8			reg_rx_buf[3] ____cacheline_aligned;
> +	u8			reg_tx_buf[3];

> +	u8			spidata_rx[32];
> +	u8			spidata_tx[32];

These will not be cache aligned. Is it a problem?

> +	u8			reset_buf[8];
> +};

...

> +static bool ad777x_has_axi_adc(struct device *dev)
> +{
> +	return device_property_present(dev, "spibus-connected");
> +}

Seems like useless wrapper to me. Why can't be used in-line?

...

> +	st->reg_tx_buf[0] = AD777X_SPI_READ_CMD | (reg & 0x7F);

GENMASK()

> +	st->reg_tx_buf[1] = 0;
> +	st->reg_tx_buf[2] = crc8(ad777x_crc8_table, st->reg_tx_buf, 2, 0);

...

> +	ret = spi_sync_transfer(st->spi, reg_read_tr,
> +				ARRAY_SIZE(reg_read_tr));

One line.

Where is the ret check?

> +	crc_buf[0] = AD777X_SPI_READ_CMD | (reg & 0x7F);

GENMASK()

> +	crc_buf[1] = st->reg_rx_buf[1];
> +	exp_crc = crc8(ad777x_crc8_table, crc_buf, 2, 0);
> +	if (st->crc_enabled && exp_crc != st->reg_rx_buf[2]) {
> +		dev_err(&st->spi->dev, "Bad CRC %x, expected %x",
> +			st->reg_rx_buf[2], exp_crc);
> +		return -EINVAL;
> +	}
> +	*rbuf = st->reg_rx_buf[1];
> +
> +	return ret;

...

> +	return spi_sync_transfer(st->spi, reg_write_tr,
> +				ARRAY_SIZE(reg_write_tr));

One line. Haven't you forgot to include array_size.h?

...

> +static int ad777x_spi_write_mask(struct ad777x_state *st,
> +				 u8 reg,
> +				 u8 mask,
> +				 u8 val)

Make it less LoCs.

> +{
> +	int ret;
> +	u8 regval, data;
> +
> +	ret = ad777x_spi_read(st, reg, &data);
> +	if (ret)
> +		return ret;
> +
> +	regval = data;
> +	regval &= ~mask;
> +	regval |= val;
> +
> +	if (regval != data) {
> +		ret = ad777x_spi_write(st, reg, regval);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;

This all can be written as

	if (regval != data)
		return ad777x_spi_write(st, reg, regval);

	return 0;

...or...

	if (regval == data)
		return 0;

	return ad777x_spi_write(st, reg, regval);

(I prefer the latter as it shows better the flow)

> +}

No mutex no nothing for RMW op like this?

Btw, can't you use regmap for IO?

...

> +	if (st->filter_enabled == AD777X_SINC3 &&
> +	    sampling_freq > AD777X_SINC3_MAXFREQ) {
> +		return -EINVAL;
> +	} else if (st->filter_enabled == AD777X_SINC5 &&

Redundant 'else'

> +		   sampling_freq > AD777X_SINC5_MAXFREQ) {

Broken indentation.

> +		return -EINVAL;
> +	}

Unneeded {}.

...

> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_LSB, lsb);
> +	if (ret)
> +		return ret;
> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_MSB, msb);
> +	if (ret)
> +		return ret;

Can you use 16-bit writes?
Same Q to all similar LSB/MSB write groups.

...

> +	if (div % kfreq != 0) {

' != 0' is redundant

> +	}

...

> +	ret |= ad777x_spi_write(st, AD777X_REG_SRC_UPDATE, 0x1);

|= ???

> +	if (ret)
> +		return ret;
> +	usleep_range(10, 15);

fsleep()

...

> +	ret |= ad777x_spi_write(st, AD777X_REG_SRC_UPDATE, 0x0);
> +	if (ret)
> +		return ret;
> +	usleep_range(10, 15);

The same two comments as per above.

...

> +	ret = ad777x_spi_write_mask(st, AD777X_REG_DOUT_FORMAT,
> +				    AD777X_DOUT_FORMAT_MSK,
> +				    FIELD_PREP(AD777X_DOUT_FORMAT_MSK,
> +					       mode));

Broken indentation.

Where is the ret check?

> +	switch (mode) {
> +	case AD777x_4LINES:
> +		ret = ad777x_set_sampling_frequency(st,
> +						    AD777X_DEFAULT_SAMPLING_FREQ);

There is no point to have this line being wrapped.

> +		if (ret)
> +			return ret;
> +		axiadc_write(axi_adc_st, ADI_REG_CNTRL, AXI_CTRL_4_LINES);
> +		break;
> +	case AD777x_2LINES:
> +		ret = ad777x_set_sampling_frequency(st,
> +						    AD777X_DEFAULT_SAMPLING_2LINE);

Ditto.

> +		if (ret)
> +			return ret;
> +		axiadc_write(axi_adc_st, ADI_REG_CNTRL, AXI_CTRL_2_LINES);
> +		break;
> +	case AD777x_1LINE:
> +		ret = ad777x_set_sampling_frequency(st,
> +						    AD777X_DEFAULT_SAMPLING_1LINE);

Ditto.

> +		if (ret)
> +			return ret;
> +		axiadc_write(axi_adc_st, ADI_REG_CNTRL, AXI_CTRL_1_LINE);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

...

> +static int ad777x_set_filter(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     unsigned int mode)
> +{
> +	struct ad777x_state *st = ad777x_get_data(indio_dev);

> +	int ret = 0;

What is the purpose of the assignment?

> +	ret = ad777x_spi_write_mask(st,
> +				    AD777X_REG_GENERAL_USER_CONFIG_2,
> +				    AD777X_FILTER_MSK,
> +				    FIELD_PREP(AD777X_FILTER_MSK, mode));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad777x_set_sampling_frequency(st, st->sampling_freq);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->filter_enabled = mode;
> +
> +	return 0;
> +}

...

> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad777x_set_calibscale(st, chan->channel, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad777x_set_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad777x_set_sampling_frequency(st, val);
> +	}
> +
> +	return -EINVAL;

Use 'default' case.

...

> +	for (i = 0; i < AD777X_NUM_CHANNELS; i++) {
> +		bit = test_bit(i, scan_mask);
> +		if (bit)
> +			st->active_ch |= BIT(i);
> +		else
> +			st->active_ch &= ~BIT(i);
> +	}

How is this differ to bitmap_copy()?

...

> +		for (i = 0; i < AD777X_NUM_CHANNELS; i++) {
> +			if (st->active_ch & BIT(i)) {

for_each_set_bit();

> +				tmp[k] = st->spidata_rx[4 * i];
> +				tmp[k + 1] = st->spidata_rx[4 * i + 1];
> +				tmp[k + 2] = st->spidata_rx[4 * i + 2];
> +				tmp[k + 3] = st->spidata_rx[4 * i + 3];

Shouldn't be __le32 used for the Rx buffer?
With that it it as simple as copy __le32 to a CPU u32.

> +				k += 4;
> +			}
> +		}

...

> +	for (i = 0; i < AD777X_RESET_BUF_SIZE; i++)
> +		st->reset_buf[i] = 0xFF;

memset().

...

> +	if (reset_gpio) {
> +		gpiod_set_value(reset_gpio, 1);
> +		usleep_range(225, 230);

fsleep()

> +		return 0;
> +	}
> +
> +	ret = spi_sync_transfer(st->spi, reg_read_tr,
> +				ARRAY_SIZE(reg_read_tr));
> +	if (ret)
> +		return ret;
> +	usleep_range(225, 230);

fsleep()

...

> +static const struct iio_chan_spec_ext_info ad777x_ext_info[] = {
> +	IIO_ENUM("data_lines", IIO_SHARED_BY_ALL, &ad777x_data_lines_enum),
> +	IIO_ENUM_AVAILABLE("data_lines", IIO_SHARED_BY_ALL,
> +				  &ad777x_data_lines_enum),
> +	{ },

No comma for the terminator entry. Same for the other similar cases.

> +};

...

> +	.max_rate = 4096000UL,

HZ_PER_KHZ ?

...

> +	.max_rate = 4096000UL,

Ditto.

...

> +static void ad777x_clk_disable(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}

See below.

...

> +	if (strcmp(st->chip_info->name, "ad7771") == 0)
> +		conv->chip_info = &conv_chip_info_filter;
> +	else
> +		conv->chip_info = &conv_chip_info;

No, just make it driver_data directly.

...

> +	if (strcmp(st->chip_info->name, "ad7771") == 0)
> +		indio_dev->channels = ad777x_channels_filter;
> +	else
> +		indio_dev->channels = ad777x_channels;

Ditto.

...

> +	ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq, NULL,

With

	struct device *dev = &st->spi->dev;

entire function become easier to read.

> +					ad777x_irq_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&st->spi->dev, ret,
> +				     "request irq %d failed\n",
> +				     st->spi->irq);

...

> +	gpiod_set_value(start_gpio, 0);
> +	usleep_range(10, 15);
> +	gpiod_set_value(start_gpio, 1);
> +	usleep_range(10, 15);
> +	gpiod_set_value(start_gpio, 0);
> +	usleep_range(10, 15);

fsleep() in all cases.

...

> +	ret = devm_add_action_or_reset(&spi->dev,
> +				       ad777x_reg_disable,
> +				       st->vref);

Make it occupy less LoCs.

> +	if (ret)
> +		return ret;

...

> +	st->mclk = devm_clk_get(&spi->dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
> +
> +	ret = clk_prepare_enable(st->mclk);
> +	if (ret < 0)
> +		return ret;

> +	ret = devm_add_action_or_reset(&spi->dev,
> +				       ad777x_clk_disable,
> +				       st->mclk);
> +	if (ret)
> +		return ret;

So, what's wrong with the _enabled() API?

...

> +	st->chip_info = device_get_match_data(&spi->dev);
> +	if (!st->chip_info) {
> +		const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +		if (id) {
> +			st->chip_info =
> +				(struct ad777x_chip_info *)id->driver_data;
> +		}
> +		if (!st->chip_info)
> +			return -EINVAL;
> +	}

We have an API for all this.
spi_get_device_match_data().

...

> +static SIMPLE_DEV_PM_OPS(ad777x_pm_ops, ad777x_suspend, ad777x_resume);

Use new PM macros that starts with DEFINE_.

...

> +static struct spi_driver ad777x_driver = {
> +	.driver = {
> +		.name = "ad777x",
> +		.pm = &ad777x_pm_ops,

You will need a pm_sleep_ptr() or alike.

> +		.of_match_table = ad777x_of_table,
> +	},
> +	.probe = ad777x_probe,
> +	.id_table = ad777x_id,
> +};
> +module_spi_driver(ad777x_driver);

-- 
With Best Regards,
Andy Shevchenko



