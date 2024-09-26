Return-Path: <linux-iio+bounces-9795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E732987620
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084D21C21B6D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4114AD2D;
	Thu, 26 Sep 2024 14:58:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA480E56A;
	Thu, 26 Sep 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362721; cv=none; b=JbYV/r2fEksLXKNZzFNXnOk4ZAFGO52kIgGvKTpckXL+Nk9Ii+qVDC99ojivuvQ4tYs0l98wB91uoDENghV+UF+LAlyGHyMTjng6h1Xk/M8IaGDqoWgVV9F8CZ8KW5dsu+IB+eN8YTkiFGwwoZXQ7CrOvrrdfnpPAoXSpy2rQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362721; c=relaxed/simple;
	bh=WXkLoQ+bRaoBgS75iXTKl+e21gQdl6ovFp1A4M+gWbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2o/VDIKdIAzax67IaM/DxN6KKk9OuozvpiYr8f35Es9GO7JrnyThux2w1UhS2BeqjIoIl0s72EL1JqOxM8SQj3227USw34eulHrY77QbGiL8nxQecDKCl05vVS54r5BXfJb4eOeQVMTLFkMyJ/ZJ5Rrbq4zdw9uOe3fkgHrsso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 1K8fEDczQcCVjcU2bWYqxg==
X-CSE-MsgGUID: ITyfCvRiSnegGoFSIZc0cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="14086227"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="14086227"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:58:39 -0700
X-CSE-ConnectionGUID: zoWFdV53TDeQSZev0wKpNg==
X-CSE-MsgGUID: Q5l7cEXrSIinncGEbTbXbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72333076"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:58:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1stpwu-0000000DENy-1h54;
	Thu, 26 Sep 2024 17:58:32 +0300
Date: Thu, 26 Sep 2024 17:58:32 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <ZvV2mHkl4qxVVmBH@smile.fi.intel.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
 <20240926135418.8342-4-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926135418.8342-4-ramona.nechita@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 26, 2024 at 04:53:57PM +0300, Ramona Alexandra Nechita wrote:
> Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of
> sending out data both on DOUT lines interface,as on the SDO line.
> The driver currently implements only the SDO data streaming mode. SPI
> communication is used alternatively for accessing registers and streaming
> data. Register accesses are protected by crc8.

...

> +struct ad7779_state {
> +	struct spi_device *spi;
> +	const struct ad7779_chip_info *chip_info;
> +	struct clk *mclk;
> +	struct iio_trigger *trig;
> +	struct completion completion;
> +	unsigned int sampling_freq;
> +	enum ad7779_filter filter_enabled;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		u32 chans[8];
> +		s64 timestamp;

	aligned_s64 timestamp;

while it makes no difference in this case, this makes code aligned inside
the IIO subsystem.

> +	} data __aligned(IIO_DMA_MINALIGN);

Note, this is different alignment to the above. And isn't the buffer below
should have it instead?

> +	u32			spidata_tx[8];
> +	u8			reg_rx_buf[3];
> +	u8			reg_tx_buf[3];
> +	u8			reset_buf[8];
> +};

...

> +static const char * const ad7779_power_supplies[] = {
> +	"avdd1", "avdd2", "avdd4"

Leave trailing comma.

> +};

...

> +static int ad7779_spi_read(struct ad7779_state *st, u8 reg, u8 *rbuf)
> +{
> +	int ret;

> +	int length = 3;

Why signed?

> +	u8 crc_buf[2];

> +	u8 exp_crc = 0;

Redundant assignment.

> +	struct spi_transfer reg_read_tr[] = {
> +		{
> +			.tx_buf = st->reg_tx_buf,
> +			.rx_buf = st->reg_rx_buf,
> +		},
> +	};
> +
> +	st->reg_tx_buf[0] = AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_MSK, reg);
> +	st->reg_tx_buf[1] = 0;
> +
> +	if (reg == AD7779_REG_GEN_ERR_REG_1_EN)
> +		length = 2;
> +	else
> +		st->reg_tx_buf[2] = crc8(ad7779_crc8_table, st->reg_tx_buf, 2, 0);

I would write this as

	if (reg == AD7779_REG_GEN_ERR_REG_1_EN) {
		length = 2;
	} else {
		length = 3;
		st->reg_tx_buf[2] = crc8(ad7779_crc8_table, st->reg_tx_buf, length - 1, 0);
	}

> +	reg_read_tr[0].len = length;
> +
> +	ret = spi_sync_transfer(st->spi, reg_read_tr, ARRAY_SIZE(reg_read_tr));
> +	if (ret)
> +		return ret;
> +
> +	crc_buf[0] = AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_MSK, reg);
> +	crc_buf[1] = st->reg_rx_buf[1];
> +	exp_crc = crc8(ad7779_crc8_table, crc_buf, 2, 0);

ARRAY_SIZE(crc_buf) / sizeof(crc_buf)


> +	if (reg != AD7779_REG_GEN_ERR_REG_1_EN && exp_crc != st->reg_rx_buf[2]) {
> +		dev_err(&st->spi->dev, "Bad CRC %x, expected %x",
> +			st->reg_rx_buf[2], exp_crc);
> +		return -EINVAL;
> +	}
> +	*rbuf = st->reg_rx_buf[1];
> +
> +	return 0;
> +}

Alternatively you can have a helper

static void ad7779_prepare_buf_with_crc(u8 reg, u8 val, u8 *buf)
{
	buf[0] = AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_MSK, reg);
	buf[1] = val;
	buf[2] = crc8(ad7779_crc8_table, buf, 2, 0);
}

static int ad7779_spi_read(struct ad7779_state *st, u8 reg, u8 *rbuf)
{
	struct spi_transfer t[] = {
		{
			.tx_buf = st->reg_tx_buf,
			.rx_buf = st->reg_rx_buf,
		},
	};
	u8 *buf = t[0].tx_buf;
	unsigned int length;
	int ret;

	ad7779_prepare_buf_with_crc(reg, 0, buf);

	if (reg == AD7779_REG_GEN_ERR_REG_1_EN)
		t[0].len = 2;
	else
		t[0].len = 3;

	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
	if (ret)
		return ret;

	ad7779_prepare_buf_with_crc(reg, t[0].rx_buf[1], buf);

	if (reg != AD7779_REG_GEN_ERR_REG_1_EN && buf[2] != t[0].rx_buf[2]) {
		dev_err(&st->spi->dev, "Bad CRC %x, expected %x", t[0].rx_buf[2], buf[2]);
		return -EINVAL;
	}
	*rbuf = t[0].rx_buf[1];

	return 0;
}

...

> +static int ad7779_spi_write(struct ad7779_state *st, u8 reg, u8 val)

Same comments as per _read() above.

...

> +static int ad7779_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +
> +	if (readval)

> +		return ad7779_spi_read(st, reg, (u8 *)readval);

This casting is incorrect as it breaks the big endianess.

> +	return ad7779_spi_write(st, reg, writeval);
> +}

...

> +	freq_khz = sampling_freq / KILO;

Now it's clear to use HZ_PER_KHZ.

...

> +	if (frac) {
> +		/*
> +		* In order to obtain the first three decimals of the decimation
> +		* the initial number is multiplied with 10^3 prior to the
> +		* division, then the original division result is subtracted and
> +		* the number is divided by 10^3.
> +		*/
> +		temp = (div * KILO) / freq_khz;
> +		decimal = ((temp -  dec * KILO) << 16) / KILO;

Unneeded extra space. Can be one line, btw.

		decimal = (((div * KILO) / freq_khz - dec * KILO) << 16) / KILO;

Is it something that mult_frac() from math.h does?

> +		ret = ad7779_spi_write(st, AD7779_REG_SRC_N_MSB,
> +				       FIELD_GET(AD7779_FREQ_MSB_MSK, decimal));
> +		if (ret)
> +			return ret;
> +		ret = ad7779_spi_write(st, AD7779_REG_SRC_N_LSB,
> +				       FIELD_GET(AD7779_FREQ_LSB_MSK, decimal));
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = ad7779_spi_write(st, AD7779_REG_SRC_N_MSB,
> +				       FIELD_GET(AD7779_FREQ_MSB_MSK, 0x0));
> +		if (ret)
> +			return ret;
> +		ret = ad7779_spi_write(st, AD7779_REG_SRC_N_LSB,
> +				       FIELD_GET(AD7779_FREQ_LSB_MSK, 0x0));
> +		if (ret)
> +			return ret;
> +	}

...

> +	ret = ad7779_spi_write(st, AD7779_REG_SRC_UPDATE, 0x1);

BIT(0) ?

> +	if (ret)
> +		return ret;
> +
> +	/* SRC update settling time */
> +	fsleep(15);
> +
> +	ret = ad7779_spi_write(st, AD7779_REG_SRC_UPDATE, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	/* SRC update settling time */
> +	fsleep(15);
> +
> +	st->sampling_freq = sampling_freq;
> +
> +	return 0;
> +}

...

> +	ret = ad7779_spi_write_mask(st,
> +				    AD7779_REG_GENERAL_USER_CONFIG_2,
> +				    AD7779_FILTER_MSK,
> +				    FIELD_PREP(AD7779_FILTER_MSK, mode));
> +	if (ret < 0)

In other cases there is no < 0 part, why here?

> +		return ret;
> +
> +	ret = ad7779_set_sampling_frequency(st, st->sampling_freq);
> +	if (ret < 0)

Ditto.

> +		return ret;

...

> +static int ad7779_set_calibscale(struct ad7779_state *st, int channel, int val)
> +{
> +	int ret;
> +	unsigned int gain;
> +	unsigned long long tmp;
> +	u8 gain_bytes[3];
> +
> +	/*
> +	 * The gain value is relative to 0x555555, which represents a gain of 1
> +	 */
> +	tmp = val * 5592405LL;
> +	gain = DIV_ROUND_CLOSEST_ULL(tmp, MEGA);

	gain = DIV_ROUND_CLOSEST_ULL((u64)val * 5592405LL, MEGA);

> +	put_unaligned_be24(gain, gain_bytes);
> +	ret = ad7779_spi_write(st, AD7779_REG_CH_GAIN_UPPER_BYTE(channel),
> +			       gain_bytes[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write(st, AD7779_REG_CH_GAIN_MID_BYTE(channel),
> +			       gain_bytes[1]);
> +	if (ret)
> +		return ret;
> +
> +	return ad7779_spi_write(st, AD7779_REG_CH_GAIN_LOWER_BYTE(channel),
> +				gain_bytes[2]);
> +}

...

> +static int ad7779_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (mask) {
> +		case IIO_CHAN_INFO_CALIBSCALE:
> +			*val = ad7779_get_calibscale(st, chan->channel);
> +			if (*val < 0)

The rule of thumb is try to avoid polluting output in case of error.

> +				return -EINVAL;

Shadowed error code, why?

> +			*val2 = GAIN_REL;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_CHAN_INFO_CALIBBIAS:
> +			*val = ad7779_get_calibbias(st, chan->channel);
> +			if (*val < 0)
> +				return -EINVAL;

Ditto.

> +			return IIO_VAL_INT;
> +		case IIO_CHAN_INFO_SAMP_FREQ:
> +			*val = st->sampling_freq;
> +			if (*val < 0)
> +				return -EINVAL;

Ditto.

> +			return IIO_VAL_INT;
> +		}

> +		return -EINVAL;

Make this to be default case in the switch.

> +	}
> +	unreachable();
> +}

...

> +static int ad7779_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)

long? Not unsigned long?

> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (mask) {
> +		case IIO_CHAN_INFO_CALIBSCALE:
> +			return ad7779_set_calibscale(st, chan->channel, val2);
> +		case IIO_CHAN_INFO_CALIBBIAS:
> +			return ad7779_set_calibbias(st, chan->channel, val);
> +		case IIO_CHAN_INFO_SAMP_FREQ:
> +			return ad7779_set_sampling_frequency(st, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	unreachable();
> +}

...

> +static irqreturn_t ad7779_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;

> +

This blank line has to be removed. Doesn't checkpatch complain?

> +	struct spi_transfer sd_readback_tr[] = {

It's the only transfer in the function, name it just 't'.

> +		{
> +			.rx_buf = st->data.chans,
> +			.tx_buf = st->spidata_tx,
> +			.len = AD7779_NUM_CHANNELS * AD7779_CHAN_DATA_SIZE,
> +		}
> +	};

> +	st->spidata_tx[0] = AD7779_SPI_READ_CMD;

It's better to use t.tx_buf[0] instead. See above as well, and apply this
approach to all your functions, so the idea is to make code more robust against
changes. With this in mind, it will become visible which buffer you operates on
in the entire function, no need to access it differently.

> +	ret = spi_sync_transfer(st->spi, sd_readback_tr,
> +				ARRAY_SIZE(sd_readback_tr));

With the above, this is one line.

> +	if (ret) {
> +		dev_err(&st->spi->dev,
> +			"spi transfer error in irq handler");

SPI
IRQ

One line.

> +		goto exit_handler;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->data, pf->timestamp);
> +
> +exit_handler:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

...

> +static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
> +{

Same comments as per above function.

> +	struct spi_transfer reg_read_tr[] = {
> +		{
> +			.tx_buf = st->reset_buf,
> +			.len = 8,
> +		},
> +	};
> +
> +	if (reset_gpio) {

> +		/* Delay for reset to occur is 225 microseconds*/

Missing white space and misplaced comment, should be immediate to fsleep()
and not here.

> +		gpiod_set_value(reset_gpio, 1);
> +		fsleep(230);
> +		return 0;
> +	} else {
> +		memset(st->reset_buf, 0xff, sizeof(st->reset_buf));
> +		ret = spi_sync_transfer(st->spi, reg_read_tr,
> +					ARRAY_SIZE(reg_read_tr));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Delay for reset to occur is 225 microseconds*/

Missing white space.

> +	fsleep(230);
> +
> +	return 0;
> +}

...

> +	gpiod_set_value(start_gpio, 0);
> +	/* Start setup time */
> +	fsleep(15);

This one is commented...

> +	gpiod_set_value(start_gpio, 1);
> +	fsleep(15);
> +	gpiod_set_value(start_gpio, 0);
> +	fsleep(15);

...but the other two.

...

> +static int ad7779_probe(struct spi_device *spi)
> +{

	struct device *dev = &spi->dev;

> +	struct iio_dev *indio_dev;
> +	struct ad7779_state *st;
> +	struct gpio_desc *reset_gpio, *start_gpio;
> +	int ret = -EINVAL;

> +	if (!spi->irq)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "DRDY irq not present\n");

		return dev_err_probe(dev, ret, "DRDY irq not present\n");

> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));

	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = devm_regulator_bulk_get_enable(&spi->dev,

	ret = devm_regulator_bulk_get_enable(dev,

> +					     ARRAY_SIZE(ad7779_power_supplies),
> +					     ad7779_power_supplies);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to get and enable supplies\n");

'dev' here and everywhere below and put this on one line.

> +	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
> +
> +	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +
> +	start_gpio = devm_gpiod_get(&spi->dev, "start", GPIOD_OUT_HIGH);
> +	if (IS_ERR(start_gpio))
> +		return PTR_ERR(start_gpio);
> +
> +	crc8_populate_msb(ad7779_crc8_table, AD7779_CRC8_POLY);
> +	st->spi = spi;
> +
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return -ENODEV;
> +
> +	ret = ad7779_reset(indio_dev, reset_gpio);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_powerup(st, start_gpio);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7779_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);

> +	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +					  indio_dev->name, iio_device_id(indio_dev));

At least it will be a room for one more parameter on the first line.

> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad7779_trigger_ops;
> +
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_request_irq(&spi->dev, spi->irq,
> +			      iio_trigger_generic_data_rdy_poll,
> +			      IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +			      indio_dev->name, st->trig);

It will be one line less with 'dev'.

> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "request irq %d failed\n",

IRQ

> +				     st->spi->irq);

One line. Why out of a sudden st-> ?


> +	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	init_completion(&st->completion);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad7779_trigger_handler,
> +					      &ad7779_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DCLK_CLK_DIV_MSK,
> +				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

...

> +static int ad7779_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7779_state *st = iio_priv(indio_dev);

	... val = FIELD_PREP(AD7779_MOD_POWERMODE_MSK, AD7779_LOW_POWER));

> +	return ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +					       AD7779_LOW_POWER));

	return ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
				     AD7779_MOD_POWERMODE_MSK, val);

Also note broken indentation in your version.

> +}

> +static int ad7779_resume(struct device *dev)

As per above.

> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +
> +	return ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +					       AD7779_HIGH_POWER));
> +}

-- 
With Best Regards,
Andy Shevchenko



