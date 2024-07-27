Return-Path: <linux-iio+bounces-7985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DA93E000
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 17:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5F01F21802
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FBC17F4F2;
	Sat, 27 Jul 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok0UE7fH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F853E22;
	Sat, 27 Jul 2024 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722094908; cv=none; b=jzAQeagLbcAVjWXNMk1JBJO3fUYQ3ChYdd903FolslbSh0Jilaux6QRtquJsDrOV4yxxaJLyEEtkITxfgUEtyF2u+ezJpv99fgaVwp4Sxq8gnb9bJZpJ+7IZ0igXPZIPmD/ZlGboc10HZ8ZOfoqz8q8GB08eiyssBsqhtAakbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722094908; c=relaxed/simple;
	bh=NUkUtQeGBcAdJ16jFHX+hYRL1RnBt8sD3aljsPpA6G8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQCHwAo3dA9ySos8TjC6+4fAi633KMiCQQ810WuILfcBcrEAk2d2Yv7zM5p/A/zroegSgMZd7qzVoB1I0lJKKe57AOJ1iXOsxTCg3y4wVYdCNJ5eBVT171ND3XR8UgoUS/2DnxiBddJY2kn/hLGA/brJ5D91/C0P/qeu+ytdpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok0UE7fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08FFC32781;
	Sat, 27 Jul 2024 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722094907;
	bh=NUkUtQeGBcAdJ16jFHX+hYRL1RnBt8sD3aljsPpA6G8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ok0UE7fHPFMUAFpcoCuV+jA9t7Vp36flXsLUZK0dCjJDKFArsXV1AliFpGBLCvYBM
	 PiwaC+nI4nFTzY+3/wUr7EaYY6EmNkpu5nehyP700SyO8ARsZBLwXZ9JLmnMdIpd6y
	 aqB3OZO18N4X6fAK6Op/TVIjkJZP5tMkf8RszaQsB7ZoOTXrg/U4xCAjpIdjHLYrA2
	 MwitJGuhiiOdb2EWodAZEGondJIYXTqksLQuVSJSjdudDhhwCaa8k7WH9adZU9sRm0
	 qVF5f6YQSMysXnm4PdoHqblRmeDfirk2cTAmTbtWTmPgjLy5oIWspI4pDka1gEFLS3
	 fhmF6M2rK6gyA==
Date: Sat, 27 Jul 2024 16:41:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, Marius
 Cristea <marius.cristea@microchip.com>, Ivan Mikhaylov
 <fr0st61te@gmail.com>, "Mike Looijmans" <mike.looijmans@topic.nl>, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Liam Beguin <liambeguin@gmail.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20240727164113.02a95b79@jic23-huawei>
In-Reply-To: <20240724155517.12470-5-ramona.nechita@analog.com>
References: <20240724155517.12470-1-ramona.nechita@analog.com>
	<20240724155517.12470-5-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 18:54:41 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of
> sending out data both on DOUT lines interface,as on the SDO line.
> The driver currently implements only theSDO data streaming mode. SPI
> communication is used alternatively foraccessingregisters and streaming
> data. Register access are protected by crc8.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Hi Ramona,

Various comments inline.  Key one though is make sure you read your
own code before posting as there is a bunch of left over stuff
from updates still in the code.

Jonathan

> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> new file mode 100644
> index 000000000000..7a83977fd00c
> --- /dev/null
> +++ b/drivers/iio/adc/ad7779.c

> +
> +static int ad7779_spi_write(struct ad7779_state *st, u8 reg, u8 val)
> +{
> +	int length = 3;
> +	struct spi_transfer reg_write_tr[] = {
> +		{
> +			.tx_buf = st->reg_tx_buf,
> +		},
> +	};
> +
> +	if (reg == AD7779_REG_GEN_ERR_REG_1_EN)
> +		length = 2;
> +	reg_write_tr[0].len = length;
> +
> +	st->reg_tx_buf[0] = FIELD_GET(AD7779_REG_MSK, reg);
> +	st->reg_tx_buf[1] = val;
> +	st->reg_tx_buf[2] = crc8(ad7779_crc8_table, st->reg_tx_buf, 2, 0);
> +
> +	return spi_sync_transfer(st->spi, reg_write_tr, ARRAY_SIZE(reg_write_tr));

spi_write()?

> +}


> +static int ad7779_set_sampling_frequency(struct ad7779_state *st,
> +					 unsigned int sampling_freq)
> +{
...

> +
> +	if (st->power_mode == AD7779_LOW_POWER)

At the moment we only end up in low power mode via suspend I think.
So this logic and indeed the tracking of power mode isn't yet needed.

> +		div = AD7779_LOWPOWER_DIV;
> +	else
> +		div = AD7779_HIGHPOWER_DIV;
> +


> +
> +static int ad7779_get_calibscale(struct ad7779_state *st, int channel)
> +{
> +	int ret;
> +	u8 calibscale[3];
> +	// u8 low, mid, high;
> +	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_LOWER_BYTE(channel), &calibscale[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_MID_BYTE(channel), &calibscale[1]);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_UPPER_BYTE(channel), &calibscale[2]);
> +	if (ret)
> +		return ret;
> +
> +	// return FIELD_PREP(AD7779_UPPER, high) | FIELD_PREP(AD7779_MID, mid) |
> +	//        FIELD_PREP(AD7779_LOWER, low);

Remember to cleanup before posting.  Always read through your own patch for this
sort of leftover stuff or get someone else to do it before posting (as can be hard
to spot in your own code).


> +	return get_unaligned_be24(calibscale);
> +}

> +
> +static int ad7779_set_calibbias(struct ad7779_state *st, int channel, int val)
> +{
> +	int ret;
> +	u8 calibbias[3];
> +	u8 msb, mid, lsb;
> +
> +	msb = FIELD_GET(AD7779_UPPER, val);
> +	mid = FIELD_GET(AD7779_MID, val);
> +	lsb = FIELD_GET(AD7779_LOWER, val);
? left over code?
> +	put_unaligned_be24(val, calibbias);
> +	ret = ad7779_spi_write(st,
> +			       AD7779_REG_CH_OFFSET_UPPER_BYTE(channel),
> +			       calibbias[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write(st,
> +			       AD7779_REG_CH_OFFSET_MID_BYTE(channel),
> +			       calibbias[1]);
> +	if (ret)
> +		return ret;
> +
> +	return ad7779_spi_write(st,
> +				AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
> +				calibbias[2]);
> +}
> +
> +static int ad7779_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long mask)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (mask) {
> +		case IIO_CHAN_INFO_CALIBSCALE:
> +			*val = ad7779_get_calibscale(st, chan->channel);
> +			iio_device_release_direct_mode(indio_dev);
> +			if (*val < 0)
> +				return -EINVAL;
> +			*val2 = GAIN_REL;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_CHAN_INFO_CALIBBIAS:
> +			*val = ad7779_get_calibbias(st, chan->channel);
> +			iio_device_release_direct_mode(indio_dev);
> +			if (*val < 0)
> +				return -EINVAL;
> +			return IIO_VAL_INT;
> +		case IIO_CHAN_INFO_SAMP_FREQ:
> +			*val = st->sampling_freq;
> +			iio_device_release_direct_mode(indio_dev);
> +			if (*val < 0)
> +				return -EINVAL;
> +			return IIO_VAL_INT;
> +		}
> +		return -EINVAL;
> +	}
> +	unreachable();
> +}
> +
> +static int ad7779_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
No need to wrap so much.  Stick a few of these on one line.

> +			    long mask)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad7779_set_calibscale(st, chan->channel, val2);

We have to take the direct_mode lock to read them but not write?
That seems backwards. Should always be able to read, but write
should be stopped if buffered capture in flight.


> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad7779_set_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad7779_set_sampling_frequency(st, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7779_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +
> +	ret = ad7779_spi_write_mask(st,
> +				    AD7779_REG_GENERAL_USER_CONFIG_3,
> +				    AD7779_MOD_SPI_EN_MSK,
> +				    FIELD_PREP(AD7779_MOD_SPI_EN_MSK, 1));
> +	if (ret)
> +		return ret;
> + 
> +	/* DRDY output cannot be disabled at device level

Comment syntax needs fixing.

> +	 * therefore we mask the irq at host end.
> +	 */
> +	enable_irq(st->spi->irq);
> +
> +	return 0;
> +}
> +
> +static int ad7779_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +
> +	disable_irq(st->spi->irq);
> +
> +	return ad7779_spi_write(st, AD7779_REG_GENERAL_USER_CONFIG_3,
> +			       AD7779_DISABLE_SD);
> +}
> +
> +static irqreturn_t ad7779_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +	int bit;
> +	int k = 0;
> +	/* Each channel shifts out HEADER + 24 bits of data

Wrong comment syntax, and also early than necessary line wrap.

> +	 * therefore 8 * u32 for the data and 64 bits for
> +	 * the timestamp
> +	 */
> +	u32 tmp[10]; 
> +
> +	struct spi_transfer sd_readback_tr[] = {
> +		{
> +			.rx_buf = st->spidata_rx,
> +			.tx_buf = st->spidata_tx,
> +			.len = 32,

Why 32?  Good to add some maths or a comment on the sizing.

> +		}
> +	};
> +
> +	if (!iio_buffer_enabled(indio_dev)){
> +		iio_trigger_notify_done(indio_dev->trig);
> +		return IRQ_HANDLED;

use a goto.

> +	}
> +
> +	st->spidata_tx[0] = AD7779_SPI_READ_CMD;
> +	ret = spi_sync_transfer(st->spi, sd_readback_tr,
> +				ARRAY_SIZE(sd_readback_tr));
> +	if (ret) {
> +		dev_err(&st->spi->dev,
> +			"spi transfer error in irq handler");
goto.

> +		iio_trigger_notify_done(indio_dev->trig);
> +		return IRQ_HANDLED;
> +	}
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, AD7779_NUM_CHANNELS - 1)
> +		tmp[k++] = st->spidata_rx[bit];

Update this to use Nuno's new macros for iterating over the scan mask.

> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &tmp[0], pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +static int ad7779_powerup(struct ad7779_state *st, struct gpio_desc *start_gpio)
> +{
> +	int ret;
> +	
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GEN_ERR_REG_1_EN,
> +				    AD7779_SPI_CRC_EN_MSK,
> +				    FIELD_PREP(AD7779_SPI_CRC_EN_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK, 1));

Do these need to be done separately?  Or can a single write be used to write
both fields?

> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_PDB_REFOUT_MSK,
> +				    FIELD_PREP(AD7779_MOD_PDB_REFOUT_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DCLK_CLK_DIV_MSK,
> +				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_ADC_MUX_CONFIG,
> +				    AD7779_REFMUX_CTRL_MSK,
> +				    FIELD_PREP(AD7779_REFMUX_CTRL_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +
> +	st->power_mode = AD7779_HIGH_POWER;
> +	ret = ad7779_set_sampling_frequency(st, AD7779_DEFAULT_SAMPLING_FREQ);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value(start_gpio, 0);
> +	/* Start setup time */
> +	fsleep(15);
> +	gpiod_set_value(start_gpio, 1);
> +	fsleep(15);
> +	gpiod_set_value(start_gpio, 0);
> +	fsleep(15);
> +
> +	return 0;
> +}
> +
> +static int ad7779_probe(struct spi_device *spi)
> +{

...

> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7779_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
> +
> +	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +					  		indio_dev->name, iio_device_id(indio_dev));

As has already been commented on. Fix all this alignment stuff.

> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops= &ad7779_trigger_ops;
> +	st->trig->dev.parent = &spi->dev;

devm_iio_trigger_alloc does this for you.
https://elixir.bootlin.com/linux/v6.10/source/drivers/iio/industrialio-trigger.c#L563

> +
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_request_irq(&spi->dev, spi->irq,
> +						   iio_trigger_generic_data_rdy_poll,
> +						   IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +						   indio_dev->name, st->trig);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "request irq %d failed\n",
> +				     st->spi->irq);

...

> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static int __maybe_unused ad7779_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +					       AD7779_LOW_POWER));
> +	if (ret)
> +		return ret;
> +
> +	st->power_mode = AD7779_LOW_POWER;
As above. There should be no need to track this as you only change it
in suspend / resume.

> +	return 0;
> +}
> +
> +static int __maybe_unused ad7779_resume(struct device *dev)

Don't need __maybe_unused as DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr() ensure
these functions are visible to the compiler, but that it them removes them
if they aren't in use.

> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +					       AD7779_HIGH_POWER));
> +	if (ret)
> +		return ret;
> +
> +	st->power_mode = AD7779_HIGH_POWER;
> +
> +	return 0;
> +}



