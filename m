Return-Path: <linux-iio+bounces-6751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE99913AD9
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337891C20D14
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAFC181B88;
	Sun, 23 Jun 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWraizhK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1D181309;
	Sun, 23 Jun 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719149723; cv=none; b=k2TtgsB0faNTEq+umMniBNdEURpQT/6xK4jS8xUZYJe2ookNiag8VKvya9M3VsVE4vWYwDBwM5WUohhPTdLODO1uhs0aRupobsskEuybRDduU5okrXMCEi+DH3SC5jeHBy0BmlxO4py6yB9RaCkyA++HxVFlAM4tl4ydGE7D6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719149723; c=relaxed/simple;
	bh=ljiiD/ciKFYfKyOYkB80mOdXM+pgbtWpt4pkEfjyZig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUZ4RtAcFdDxvh5HQQXl0zNpJTYJYYAEgdnmex7NRhn3EKy0Q8bLGnRloGw9kE0SjqesBPQsEwBlFbkZeuA8uBVWCb7SWM2PEfcRAS/wo++H756DkgPPvu6fh4st0gu8zhjfTa87Dfn9NfnD7zShqFXMICsqrJC0A7rZq4TOTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWraizhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77514C32781;
	Sun, 23 Jun 2024 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719149723;
	bh=ljiiD/ciKFYfKyOYkB80mOdXM+pgbtWpt4pkEfjyZig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWraizhK7+uzTQEMRQzdXTci/6xdKU8gyp3b4YuG3RsTEqmHn8UcwGWf+2wi72+I5
	 rWUFZKSaN5fY6++rttAC13HQULmqJJybxLjincn2MuGw0MjcQEBb4QfrdL6QUpwbqq
	 e33xhHMeYVmDGBwZxYVXOAjHXW7toDoj33wOxqyM8RMl8rw3WR4BQsdEVYWr98V5O7
	 yVCLSLNTmFQ7X5S9Enf7RYwRoMcZlMbhqr00nOl99YH+DNcJt92QMBlEfn+U8AsS2g
	 ccOPIO0qZYMg3e79LND78StBGRu8O3rXnZKVbfWGyA7YGo+F49cskgdayg76UVubxX
	 YaCIW+yFGQiIw==
Date: Sun, 23 Jun 2024 14:35:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Marius Cristea <marius.cristea@microchip.com>, Maksim
 Kiselev <bigunclemax@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Okan Sahin <okan.sahin@analog.com>, Liam
 Beguin <liambeguin@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20240623143513.186c1976@jic23-huawei>
In-Reply-To: <20240620084040.3992-1-ramona.nechita@analog.com>
References: <20240620084040.3992-1-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 11:40:26 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> Added support for ad7770,ad7771,ad7779 ADCs. The
> device is capable of sending out data both on
> DOUT lines interface, as well as on the SDO line.
> The driver however implements only the SDO data
> streaming mode. SPI communication is used alternatively
> for accessing registers and streaming data, reading
> and writing to the registers is also checking for crc8.
Rewrap this description to up to 75 chars. I've edited a little as well.

Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of
sending out data both on DOUT lines interface, as on the SDO line. The
driver currently implements only the SDO data streaming mode. SPI 
communication is used alternatively for accessing registers and 
streaming data. Register access are protected by crc8.

> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>

Some other comments inline + a minor diversion into the silly nature
of the CRC handling for read register commands on this device.


> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> new file mode 100644
> index 000000000000..18a1e50cd877
> --- /dev/null
> +++ b/drivers/iio/adc/ad7779.c
> @@ -0,0 +1,936 @@

> +struct ad7779_state {
> +	struct spi_device		*spi;
> +	const struct ad7779_chip_info	*chip_info;
> +	struct clk				*mclk;
> +	struct iio_trigger		*trig;
> +	struct completion		completion;
> +	unsigned int			sampling_freq;
> +	enum ad7779_power_mode	power_mode;

The random indents here are a good example of why this sort of alignment is
more trouble that it is worth.  Just don't bother aligning them and use
a single space.  If there are related blocks of fields, add a blank line after
them to make that distinction.

> +	enum ad7779_filter		filter_enabled;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8			reg_rx_buf[3] __aligned(IIO_DMA_MINALIGN);
> +	u8			reg_tx_buf[3];
> +	u32			spidata_rx[8];
> +	u32			spidata_tx[8];
> +	u8			reset_buf[8];
> +};
> +
> +static const char * const ad7779_filter_type[] = {
> +	[AD7779_SINC3] = "sinc3_filter",
> +	[AD7779_SINC5] = "sinc5_filter",

Keep to naming of existing ABI for other drivers.  So just sinc3 and sinc5 I think.

> +};
> +
> +static int ad7779_spi_read(struct ad7779_state *st, u8 reg, u8 *rbuf)
> +{
> +	int ret;
> +	int length = 3;
> +	u8 crc_buf[2];
> +	u8 exp_crc = 0;
> +	struct spi_transfer reg_read_tr[] = {
> +		{
> +			.tx_buf = st->reg_tx_buf,
> +			.rx_buf = st->reg_rx_buf,
> +		},
> +	};
> +
> +	if (reg == AD7779_REG_GEN_ERR_REG_1_EN)
> +		length = 2;
> +	reg_read_tr[0].len = length;
> +
> +	st->reg_tx_buf[0] = AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_MSK, reg);
> +	st->reg_tx_buf[1] = 0;
> +	st->reg_tx_buf[2] = crc8(ad7779_crc8_table, st->reg_tx_buf, 2, 0);

This seems odd.  It can't check the crc before it's replied in byte 1.
So for the device end it can only set the crc error bit if it detects an
error in the whole transaction. That doesn't actually matter because
we receive the CRC back and can compare with CRC of what we sent +
returned data thus being sure the first bit was correct, but not that the
CRC we send in byte 3 made it.  *sigh*  There is no sensible way out of this
mess we can't check the crc error bit without another read transaction
introducing another CRC we can't check... So the device will for ever
remaining in an unknown CRC validation state.  Great.

Nothing wrong with your code btw, I just wanted to rant about how odd this
was.  Normal thing is either CRC on the back of the address so it can reject
immediately or CRC only for reads only in the device to host direction.



> +
> +	ret = spi_sync_transfer(st->spi, reg_read_tr, ARRAY_SIZE(reg_read_tr));
> +	if (ret)
> +		return ret;
> +
> +	crc_buf[0] = AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_MSK, reg);
> +	crc_buf[1] = st->reg_rx_buf[1];
> +	exp_crc = crc8(ad7779_crc8_table, crc_buf, 2, 0);
> +	if (reg != AD7779_REG_GEN_ERR_REG_1_EN && exp_crc != st->reg_rx_buf[2]) {
> +		dev_err(&st->spi->dev, "Bad CRC %x, expected %x",
> +			st->reg_rx_buf[2], exp_crc);
> +		return -EINVAL;
> +	}
> +	*rbuf = st->reg_rx_buf[1];
> +
> +	return 0;
> +}
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

	return spi_write()

> +}
> +
> +static int ad7779_spi_write_mask(struct ad7779_state *st, u8 reg, u8 mask,
> +				 u8 val)
> +{
> +	int ret;
> +	u8 regval, data;
> +
> +	ret = ad7779_spi_read(st, reg, &data);
> +	if (ret)
> +		return ret;
> +
> +	regval = data;
> +	regval &= ~mask;
> +	regval |= val;
> +
> +	if (regval == data)
> +		return 0;
> +
> +	return ad7779_spi_write(st, reg, regval);
> +}

...


> +
> +static int ad7779_get_calibscale(struct ad7779_state *st, int channel)
> +{
> +	int ret;
> +	u8 low, mid, high;
> +
> +	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_LOWER_BYTE(channel), &low);
> +	if (ret)
> +		return ret;
> +	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_MID_BYTE(channel), &mid);
> +	if (ret)
> +		return ret;
> +	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_UPPER_BYTE(channel), &high);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_PREP(AD7779_UPPER, high) | FIELD_PREP(AD7779_MID, mid) |
> +	       FIELD_PREP(AD7779_LOWER, low);

Read registers into a byte array then use a get_unaligned_be24() or similar
to get to the value.

> +}
> +
> +static int ad7779_set_calibscale(struct ad7779_state *st, int channel, int val)
> +{
> +	int ret;
> +	unsigned int gain;
> +	unsigned long long tmp;
> +
> +	tmp = val * 5592405LL;
> +	gain = DIV_ROUND_CLOSEST_ULL(tmp, MEGA);
> +	ret = ad7779_spi_write(st,
> +			       AD7779_REG_CH_GAIN_UPPER_BYTE(channel),
> +			       FIELD_GET(AD7779_UPPER, gain));

Add a local u8 array, and do put_unaligned_be24() into it.  Then you can
just write each element directly from the relevant byte in that array.

> +	if (ret)
> +		return ret;
> +	ret = ad7779_spi_write(st,
> +			       AD7779_REG_CH_GAIN_MID_BYTE(channel),
> +			       FIELD_GET(AD7779_MID, gain));
> +	if (ret)
> +		return ret;
> +	return ad7779_spi_write(st,
> +				AD7779_REG_CH_GAIN_LOWER_BYTE(channel),
> +				FIELD_GET(AD7779_LOWER, gain));
> +}
> +
> +static int ad7779_get_calibbias(struct ad7779_state *st, int channel)
> +{
> +	int ret;
> +	u8 low, mid, high;
> +
> +	ret = ad7779_spi_read(st, AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
> +			      &low);
> +	if (ret)
> +		return ret;
> +	ret = ad7779_spi_read(st, AD7779_REG_CH_OFFSET_MID_BYTE(channel), &mid);
> +	if (ret)
> +		return ret;
> +	ret = ad7779_spi_read(st,
> +			      AD7779_REG_CH_OFFSET_UPPER_BYTE(channel),
> +			      &high);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_PREP(AD7779_UPPER, high) | FIELD_PREP(AD7779_MID, mid) |
> +	       FIELD_PREP(AD7779_LOWER, low);
> +}
> +
> +static int ad7779_set_calibbias(struct ad7779_state *st, int channel, int val)
> +{
> +	int ret;
> +	u8 msb, mid, lsb;
> +
> +	msb = FIELD_GET(AD7779_UPPER, val);
> +	mid = FIELD_GET(AD7779_MID, val);
> +	lsb = FIELD_GET(AD7779_LOWER, val);
> +	ret = ad7779_spi_write(st,
> +			       AD7779_REG_CH_OFFSET_UPPER_BYTE(channel),
> +			       msb);
> +	if (ret)
> +		return ret;

Blank line after each call / error handle pair. So here.

> +	ret = ad7779_spi_write(st,
> +			       AD7779_REG_CH_OFFSET_MID_BYTE(channel),
> +			       mid);
> +	if (ret)
> +		return ret;

and here. Do the same in other similar functions as it helps readability.

> +	return ad7779_spi_write(st,
> +				AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
> +				lsb);
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
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
Don't do the claim and release in different scopes 
- it makes the code very hard to read.

Perhaps iio_device_claim_direct_scoped() will help here.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val = ad7779_get_calibscale(st, chan->channel);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (*val < 0)
> +			return -EINVAL;
> +		*val2 = GAIN_REL;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val = ad7779_get_calibbias(st, chan->channel);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (*val < 0)
> +			return -EINVAL;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->sampling_freq;
> +		iio_device_release_direct_mode(indio_dev);
> +		if (*val < 0)
> +			return -EINVAL;
> +		return IIO_VAL_INT;
> +	}
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return -EINVAL;
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
> +	enable_irq(st->spi->irq);

Add a comment to say something like DRDY output cannot be disabled so mask
at the host end.  Normally we do everything we can to make this at the
device end.

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
> +	return ad7779_spi_write(st,
> +			       AD7779_REG_GENERAL_USER_CONFIG_3,

Odd line wrap, put first two lines on one line.

> +			       AD7779_DISABLE_SD);
> +}
> +
> +static irqreturn_t ad7779_interrupt(int irq, void *private)
> +{
> +	iio_trigger_poll(private);
> +	return IRQ_HANDLED;
> +};

Can just use iio_trigger_generic_data_rdy_poll() for this. It's a very
common case so we have a standard implementation.



> +
> +static irqreturn_t ad7779_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u32 tmp[8];

This needs to include space for the timestamp, so I think 10 not 8.
Note that we normally put a comment at least for the sizing of these
as it is very easy to misunderstand.  I do plan to add runtime checks
to catch this but not this cycle as far too much else going on.


> +	int bit;
> +	int k = 0;
> +
> +	struct spi_transfer sd_readback_tr[] = {
> +		{
> +			.rx_buf = st->spidata_rx,
> +			.tx_buf = st->spidata_tx,
> +			.len = 32,
> +		}
> +	};
> +
> +	if (!iio_buffer_enabled(indio_dev))
> +		return IRQ_HANDLED;
> +
> +	st->spidata_tx[0] = AD7779_SPI_READ_CMD;
> +	ret = spi_sync_transfer(st->spi, sd_readback_tr,
> +				ARRAY_SIZE(sd_readback_tr));
> +	if (ret) {
> +		dev_err(&st->spi->dev,
> +			"spi transfer error in irq handler");

If this is a trigger and you don't call iio_trigger_notify_done() you will
be stuck.  Normally in such cases we just don't push to the buffer, but
do notify the trigger so that we get the next trigger.

> +		return IRQ_HANDLED;
> +	}
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
> +		tmp[k++] = st->spidata_rx[bit];
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &tmp[0], pf->timestamp);


> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}



> +
> +static int ad7779_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad7779_state *st;
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *start_gpio;

might as well combine

	struct gpio_desc *reset_gpio, *start_gpio;

> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
> +
> +	if (!spi->irq)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "DRDY irq not present\n");
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
> +	ret = ad7779_reset(indio_dev, start_gpio);
> +	if (ret)
> +		return ret;
> +
> +	ad7779_powerup(st, start_gpio);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7779_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
> +	indio_dev->masklength = AD7779_NUM_CHANNELS - 1;

You shouldn't be writing masklength from a driver. That's established by the core from
the channels array.

...

> +static const struct spi_device_id ad7779_id[] = {
> +	{
> +		.name = "ad7770",
> +		.driver_data = (__kernel_ulong_t)&ad7770_chip_info
> +	},
> +	{
> +		.name = "ad7771",
> +		.driver_data = (__kernel_ulong_t)&ad7771_chip_info
> +	},
> +	{
> +		.name = "AD7779",
> +		.driver_data = (__kernel_ulong_t)&AD7779_chip_info

I think kernel_ulong_t from mod_devicetable.h is fine here.

> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad7779_id);

Thanks,

Jonathan


