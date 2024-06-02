Return-Path: <linux-iio+bounces-5602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7F8D74C8
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3261D1C20BFD
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCE736AF5;
	Sun,  2 Jun 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nECyuJAr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780B10A3D;
	Sun,  2 Jun 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717325615; cv=none; b=KFfoU8SdrXNZUvFqU/cinLQle4wYdnGcr5ScKGteShOrpXoL9Yad9/3XrxBW9cWoOQE17mHPWOMOUuXQGsugRNRJwTlxZNK7PzCBHZ2GEJTIJaxJYEA02MtMxOvPvGrV/GdMillvhFSz0uwmk7PoK0Ivzz9+BDD0MXxx4QCfTQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717325615; c=relaxed/simple;
	bh=bW6JY1oiafd6UKkp+Ffqz2g75+KR0i3bRctrCicrxHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAiqbpqgcrXpJuRFkvJq+9lC/3mWpMoNeDRUkqWQWKZB5I970z9DWyj6krYLZBURuEsWc6c+bU0EZDg+NC731sKDEsCGRiABnFzIj9c60ohsN7gY/LvOS9UpgeMV07Obw+eqEINAPd2CFZnOsGwK/9F6SKUZywpQ5vf8LyuSBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nECyuJAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26251C2BBFC;
	Sun,  2 Jun 2024 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717325615;
	bh=bW6JY1oiafd6UKkp+Ffqz2g75+KR0i3bRctrCicrxHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nECyuJArQKz38GmyAo4CWVsBxbGS8nWyxPRaqb8bviUu+NNc1bR3MbCZX+1wfUx/a
	 cwHH1hFteIO9AeLvzF/Qhg+J6iS6BD5cQf5hHvU6qLWgF9i3YKlkDOuakpDc+m3vPv
	 EYq0A6rWm/3dORwpVgQts8HT1e4eFANqXnw4reTk3382ixZ11pYRdC9dSLwHehPUeq
	 wQAreAl4VwYhjq02nfnh041B79uDc0Bh3Y2whHyJdiaT2cJYQ5rBQ5PuUrJ93beke/
	 UGFnJPeDstcnS0KgnMAk2jHkB749T0wOaT9oHryR8+6j/EjFI1mUI7F2L+TCZIC3Hf
	 N5poq4OepPB/w==
Date: Sun, 2 Jun 2024 11:53:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ranechita <ramona.nechita@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Nuno Sa <nuno.sa@analog.com>, "Marcelo
 Schmitt" <marcelo.schmitt@analog.com>, Marius Cristea
 <marius.cristea@microchip.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>, Okan Sahin
 <okan.sahin@analog.com>, Mike Looijmans <mike.looijmans@topic.nl>, "Liam
 Beguin" <liambeguin@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: iio: adc: add support for ad777x family
Message-ID: <20240602115319.686a2a80@jic23-huawei>
In-Reply-To: <20240529150322.28018-1-ramona.nechita@analog.com>
References: <20240529150322.28018-1-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 18:03:09 +0300
ranechita <ramona.nechita@analog.com> wrote:

> Added support for ad7770,ad7771,ad7779 ADCs. The
> data is streamed only on the spi-mode, without
> using the data lines.
> 
> Signed-off-by: ranechita <ramona.nechita@analog.com>
Others have commented on need to sort your patch submissions out.
Make sure that's fixed for next version.  1 series with driver
and bindings, fixed sign off etc.


Various comments inline.

Jonathan

> ---
>  drivers/iio/adc/Kconfig  |  11 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7779.c | 951 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 963 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7779.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 0d9282fa67f5..3e42cbc365d7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -206,6 +206,17 @@ config AD7768_1
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7768-1.
>  
> +config AD7779
> +	tristate "Analog Devices AD7779 ADC driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	help
> +	  Say yes here to build support for Analog Devices AD7779 SPI
In help text list all supported parts so that people can grep for them.

> +	  analog to digital converter (ADC)
It's not just an SPI converter. Seems to have a 4 wide serial interface
for directly clocking out the data as well. Might be worth mentioning that
even if the driver doesn't yet support it.

> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7779.
> +

> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> new file mode 100644
> index 000000000000..089e352e2d40
> --- /dev/null
> +++ b/drivers/iio/adc/ad7779.c
> @@ -0,0 +1,951 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD777X ADC
> + *
> + * Copyright 2023 Analog Devices Inc.

Probably worth updating given how much this is changing!


> +#define AD777X_CRC8_POLY			0x07
> +DECLARE_CRC8_TABLE(ad777x_crc8_table);
> +
> +enum ad777x_filter {
Don't use wild cards for defines. Just name it after a suitable specific
part number. Wild cards go wrong far too often.
> +	AD777X_SINC3,
> +	AD777X_SINC5,
> +};
> +
> +enum ad777x_variant {
> +	ad7770,
> +	ad7771,
> +	ad7779,
> +};
> +
> +enum ad777x_power_mode {
> +	AD777X_LOW_POWER,
> +	AD777X_HIGH_POWER,
> +};
> +
> +struct ad777x_chip_info {
> +	const char *name;
> +	struct iio_chan_spec const *channels;
> +};
> +
> +struct ad777x_state {

Choose a supported part and name after that. Wild cards go
wrong far too often because manufacturers love to put incompatible
and sometimes completely unrelated parts numbers between those used
for other devices.

> +	struct spi_device		*spi;
> +	const struct ad777x_chip_info	*chip_info;
> +	struct clk			*mclk;
> +	struct regulator		*vref;
> +	unsigned int			sampling_freq;
> +	enum ad777x_power_mode		power_mode;
> +	enum ad777x_filter		filter_enabled;
> +	unsigned int			active_ch;
> +	unsigned int			spidata_mode;
> +	unsigned int			crc_enabled;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8			reg_rx_buf[3] ____cacheline_aligned;

Comment is correct, but that alignment isn't.   Unfortunately
____cacheline_aligned is (on a few platforms) not sufficient as
it is the l1 cacheline size and DMA is done from last level cache
which has a larger cacheline.

use __aligned(IIO_DMA_MINALIGN) which handles this corner case.

> +	u8			reg_tx_buf[3];
> +	__be32			spidata_rx[8];
> +	__be32			spidata_tx[8];
> +	u8			reset_buf[8];
> +};
> +
> +static const char * const ad777x_filter_type[] = {
> +	[AD777X_SINC3] = "sinc3_filter",
> +	[AD777X_SINC5] = "sinc5_filter",
> +};
> +
> +static int ad777x_spi_read(struct ad777x_state *st, u8 reg, u8 *rbuf)
> +{
> +	int ret;
> +	int length = 2;
> +	u8 crc_buf[2];
> +	u8 exp_crc = 0;
> +	struct spi_transfer reg_read_tr[] = {
> +		{
> +			.tx_buf = st->reg_tx_buf,
> +			.rx_buf = st->reg_rx_buf,
> +		},
> +	};
> +
> +	if (st->crc_enabled)
> +		length = 3;
> +	reg_read_tr[0].len = length;
> +
> +	st->reg_tx_buf[0] = AD777X_SPI_READ_CMD | (reg & 0x7F);
> +	st->reg_tx_buf[1] = 0;
> +	st->reg_tx_buf[2] = crc8(ad777x_crc8_table, st->reg_tx_buf, 2, 0);
> +
> +	ret = spi_sync_transfer(st->spi, reg_read_tr, ARRAY_SIZE(reg_read_tr));
> +	if (ret)
> +		return ret;
> +
> +	crc_buf[0] = AD777X_SPI_READ_CMD | FIELD_GET(AD777X_REG_READ_MSK, reg);
> +	crc_buf[1] = st->reg_rx_buf[1];
> +	exp_crc = crc8(ad777x_crc8_table, crc_buf, 2, 0);
> +	if (st->crc_enabled && exp_crc != st->reg_rx_buf[2]) {
> +		dev_err(&st->spi->dev, "Bad CRC %x, expected %x",
> +			st->reg_rx_buf[2], exp_crc);
> +		return -EINVAL;
> +	}
> +	*rbuf = st->reg_rx_buf[1];
> +
> +	return 0;
> +}
> +
> +static int ad777x_spi_write(struct ad777x_state *st, u8 reg, u8 val)
> +{
> +	int length = 2;
> +	struct spi_transfer reg_write_tr[] = {
> +		{
> +			.tx_buf = st->reg_tx_buf,
> +		},
> +	};
> +
> +	if (st->crc_enabled)
> +		length = 3;
> +	reg_write_tr[0].len = length;
> +
> +	st->reg_tx_buf[0] = reg & 0x7F;
> +	st->reg_tx_buf[1] = val;
> +	st->reg_tx_buf[2] = crc8(ad777x_crc8_table, st->reg_tx_buf, 2, 0);

only fill that in if crc_enabled is set. 

> +
> +	return spi_sync_transfer(st->spi, reg_write_tr, ARRAY_SIZE(reg_write_tr));
> +}
> +
> +static int ad777x_spi_write_mask(struct ad777x_state *st, u8 reg, u8 mask,
> +				 u8 val)
> +{
> +	int ret;
> +	u8 regval, data;
> +
> +	ret = ad777x_spi_read(st, reg, &data);

When I see this sort of helper, it's usually a good sign that the author
should consider a custom regmap. I'm not 100% sure it is a good fit here
but it seems likely looking at this section of code.

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
> +	return ad777x_spi_write(st, reg, regval);
> +
> +}

> +static int ad777x_set_sampling_frequency(struct ad777x_state *st,
> +					 unsigned int sampling_freq)
> +{
> +	int ret;
> +	unsigned int dec;
> +	unsigned int div;
> +	unsigned int decimal;
> +	int temp;
> +	unsigned int kfreq;
> +	u8 msb, lsb;
> +
> +	if (st->filter_enabled == AD777X_SINC3 &&
> +	    sampling_freq > AD777X_SINC3_MAXFREQ)
> +		return -EINVAL;
> +
> +	if (st->filter_enabled == AD777X_SINC5 &&
> +		sampling_freq > AD777X_SINC5_MAXFREQ)

Align after ( as done on the one above.

> +		return -EINVAL;
> +
> +	if (st->spidata_mode == 1 &&
> +	    sampling_freq > AD777X_SPIMODE_MAX_SAMP_FREQ)
> +		return -EINVAL;
> +
> +	if (st->power_mode == AD777X_LOW_POWER)
> +		div = AD777X_LOWPOWER_DIV;
> +	else
> +		div = AD777X_HIGHPOWER_DIV;
> +
> +	kfreq = sampling_freq / KILO;
> +	dec = div / kfreq;
> +
> +	lsb = FIELD_GET(AD777X_FREQ_LSB_MSK, dec);
> +	msb = FIELD_GET(AD777X_FREQ_MSB_MSK, dec);

These local variables don't add much. Just use the
FIELD_GET() calls in appropriate places.

> +
> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_LSB, lsb);
> +	if (ret)
> +		return ret;
> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_MSB, msb);
> +	if (ret)
> +		return ret;
> +
> +	if (div % kfreq) {
> +		temp = (div * KILO) / kfreq;
> +		decimal = ((temp -  dec * KILO) << 16) / KILO;
> +		lsb = FIELD_GET(AD777X_FREQ_LSB_MSK, decimal);
> +		msb = FIELD_GET(AD777X_FREQ_MSB_MSK, decimal);
> +
> +		ret = ad777x_spi_write(st, AD777X_REG_SRC_IF_LSB, lsb);
> +		if (ret)
> +			return ret;
> +		ret = ad777x_spi_write(st, AD777X_REG_SRC_IF_MSB, msb);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = ad777x_spi_write(st, AD777X_REG_SRC_IF_LSB, 0x0);
> +		if (ret)
> +			return ret;
> +		ret = ad777x_spi_write(st, AD777X_REG_SRC_IF_MSB, 0x0);
> +		if (ret)
> +			return ret;
> +	}
> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_UPDATE, 0x1);
> +	if (ret)
> +		return ret;
> +	fsleep(15);
> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_UPDATE, 0x0);
> +	if (ret)
> +		return ret;
> +	fsleep(15);
> +
> +	st->sampling_freq = sampling_freq;
> +
> +	return 0;
> +}

...


> +static int ad777x_set_calibscale(struct ad777x_state *st, int channel, int val)
> +{
> +	int ret;
> +	u8 msb, mid, lsb;
> +	unsigned int gain;
> +	unsigned long long tmp;
> +
> +	tmp = val * 5592405LL;
> +	gain = DIV_ROUND_CLOSEST_ULL(tmp, MEGA);
> +	msb = FIELD_GET(AD777X_UPPER, gain);
> +	mid = FIELD_GET(AD777X_MID, gain);
> +	lsb = FIELD_GET(AD777X_LOWER, gain);
> +	ret = ad777x_spi_write(st,
> +			       AD777X_REG_CH_GAIN_UPPER_BYTE(channel),
> +			       msb);
> +	if (ret)
> +		return ret;
> +	ret = ad777x_spi_write(st,
> +			       AD777X_REG_CH_GAIN_MID_BYTE(channel),
> +			       mid);
> +	if (ret)
> +		return ret;
> +	return ad777x_spi_write(st,
> +				AD777X_REG_CH_GAIN_LOWER_BYTE(channel),
> +				lsb);
I assume these regisers are next to each other. If so I think Andy suggested
creating your own bulk read /write.  That would be a good cleanup.

> +}
> +
> +static int ad777x_get_calibbias(struct ad777x_state *st, int channel)
> +{
> +	int ret;
> +	u8 low, mid, high;
> +
> +	ret = ad777x_spi_read(st, AD777X_REG_CH_OFFSET_LOWER_BYTE(channel),
> +			      &low);
> +	if (ret)
> +		return ret;
> +	ret = ad777x_spi_read(st, AD777X_REG_CH_OFFSET_MID_BYTE(channel), &mid);
> +	if (ret)
> +		return ret;
> +	ret = ad777x_spi_read(st,
> +			      AD777X_REG_CH_OFFSET_UPPER_BYTE(channel),
> +			      &high);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_PREP(AD777X_UPPER, high) | FIELD_PREP(AD777X_MID, mid) |
> +	       FIELD_PREP(AD777X_LOWER, low);

get them directly into different bytes of a byte array then use a
get_unaligned_be24() call here to build this.

> +}
> +
> +static int ad777x_set_calibbias(struct ad777x_state *st, int channel, int val)
> +{
> +	int ret;
> +	u8 msb, mid, lsb;
> +
> +	msb = FIELD_GET(AD777X_UPPER, val);
> +	mid = FIELD_GET(AD777X_MID, val);
> +	lsb = FIELD_GET(AD777X_LOWER, val);
> +	ret = ad777x_spi_write(st,
> +			       AD777X_REG_CH_OFFSET_UPPER_BYTE(channel),
> +			       msb);

Put the FIELD_GET() inline.  Doing as above doesn't h elp mcuh.

> +	if (ret)
> +		return ret;
As below blank lines in appropriate locations to separate the blocks of code.


> +	ret = ad777x_spi_write(st,
> +			       AD777X_REG_CH_OFFSET_MID_BYTE(channel),
> +			       mid);
> +	if (ret)
> +		return ret;
> +	return ad777x_spi_write(st,
> +				AD777X_REG_CH_OFFSET_LOWER_BYTE(channel),
> +				lsb);
> +}
> +
> +static int ad777x_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long mask)
> +{
> +	struct ad777x_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);

Use the scoped version to simplify this quite a bit.


> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val = ad777x_get_calibscale(st, chan->channel);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
ret isn't set by anyone...

> +			return ret;
> +		*val2 = GAIN_REL;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val = ad777x_get_calibbias(st, chan->channel);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
as above.
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->sampling_freq;
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
and here.
> +			return ret;
> +		return IIO_VAL_INT;
> +	}
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return -EINVAL;
> +}
> +

> +
> +static int ad777x_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad777x_state *st = iio_priv(indio_dev);
> +
> +	bitmap_copy((unsigned long *)&st->active_ch, scan_mask, AD777X_NUM_CHANNELS);

Why have your own local tracking?  Just use the active_scan_mask directly.
Then this function can go away.

> +
> +	return 0;
> +}

> +
> +static int ad777x_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ad777x_state *st = iio_priv(indio_dev);
> +
> +	disable_irq_nosync(st->spi->irq);

I suspect to close the race of you thinking you are in buffered mode when
you aren't that the nosync variant isn't the right choice here.

> +	ret = ad777x_spi_write(st,
> +			       AD777X_REG_GENERAL_USER_CONFIG_3,
> +			       AD777X_DISABLE_SD);
> +	return ret;

return ad777x ..

> +}
> +
> +static irqreturn_t ad777x_irq_handler(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ad777x_state *st = iio_priv(indio_dev);
> +	int ret;
> +	__be32 tmp[8];
> +	int i;
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
> +	if (iio_buffer_enabled(indio_dev)) {

How do we get here without that being true?  Add a comment given if we did I'd
expect to see an alternative set of things to do in here. Also invert condition
to reduce indent.

	if (!iio_buffer_enabled(indio_dev))
		return IRQ_HANDLED;

	st->...

> +		st->spidata_tx[0] = AD777X_SPI_READ_CMD;
> +		ret = spi_sync_transfer(st->spi, sd_readback_tr,
> +					ARRAY_SIZE(sd_readback_tr));
> +		if (ret) {
> +			dev_err(&st->spi->dev,
> +				"spi transfer error in irq handler");
> +			return IRQ_HANDLED;
> +		}
> +		for (i = 0; i < AD777X_NUM_CHANNELS; i++) {
> +			if (st->active_ch & BIT(i))
> +				tmp[k++] = __be32_to_cpu(st->spidata_rx[i]);
Why?  We generally leave data reordering to userspace. Just report as a be32
channel if that's what it is.

> +		}
> +		iio_push_to_buffers(indio_dev, &tmp[0]);

Not obvious why you can't provide a timestamp given this is in the interrupt
handler for that capture completing (no fifo or similar to make that complex).
You will need to expand tmp though to allow for the timestamp to be inserted.

> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad777x_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
> +{
> +	struct ad777x_state *st = iio_priv(indio_dev);
> +	int ret;
> +	struct spi_transfer reg_read_tr[] = {
> +		{
> +			.tx_buf = st->reset_buf,
> +			.len = 8,
> +		},
> +	};
> +
> +	memset(st->reset_buf, 0xff, sizeof(st->reset_buf));
> +
> +	if (reset_gpio) {
> +		gpiod_set_value(reset_gpio, 1);
> +		fsleep(230);
> +		return 0;
> +	}
> +
> +	ret = spi_sync_transfer(st->spi, reg_read_tr,
> +				ARRAY_SIZE(reg_read_tr));
> +	if (ret)
> +		return ret;
> +
> +	fsleep(230);

Add a spec reference for these sleep times.

> +
> +	return 0;
> +}


> +static int ad777x_register(struct ad777x_state *st, struct iio_dev *indio_dev)
> +{

There is no obvious reason to break this out from probe. Just put the
code inline.  There may be reasons to break out some parts like the
irq setup, but currently the break doesn't help with readability.

> +	int ret;
> +	struct device *dev = &st->spi->dev;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad777x_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad777x_channels);
> +
> +	ret = devm_request_threaded_irq(dev, st->spi->irq, NULL,
> +					ad777x_irq_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request irq %d failed\n",
> +				     st->spi->irq);
> +
> +	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
> +					      &ad777x_buffer_setup_ops,
> +					      NULL);
Does this device have a fifo or similar reason for directly managing
the buffer rather than providing a trigger?
So far I'm not seeing any code to indicate the need for not using
the more common approach of a data ready trigger and a pollfunc
etc to actually grab the data.


> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "setup buffer failed\n");
> +
> +	ret = ad777x_spi_write_mask(st, AD777X_REG_DOUT_FORMAT,
> +				    AD777X_DCLK_CLK_DIV_MSK,
> +				    FIELD_PREP(AD777X_DCLK_CLK_DIV_MSK, 7));
> +	if (ret)
> +		return ret;
> +	st->spidata_mode = 1;
Always seems to be set when it might be queried. As such feels like a feature
you haven't implemented yet?  If so don't have the code here.
> +
> +	disable_irq_nosync(st->spi->irq);

Look at IRQF_NO_AUTOEN rather than turning it on then off again.
> +
> +	return devm_iio_device_register(&st->spi->dev, indio_dev);
> +}
> +
> +static int ad777x_powerup(struct ad777x_state *st, struct gpio_desc *start_gpio)
> +{
> +	int ret;
> +
> +	ret = ad777x_spi_write_mask(st, AD777X_REG_GENERAL_USER_CONFIG_1,
> +				    AD777X_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD777X_MOD_POWERMODE_MSK, 1));
> +	if (ret)
> +		return ret;

blank line here.

> +	ret = ad777x_spi_write_mask(st, AD777X_REG_GENERAL_USER_CONFIG_1,
> +				    AD777X_MOD_PDB_REFOUT_MSK,
> +				    FIELD_PREP(AD777X_MOD_PDB_REFOUT_MSK, 1));
> +	if (ret)
> +		return ret;

and here etc.  Basically separate every call + error handler block.
That helps readability a little.

> +	ret = ad777x_spi_write_mask(st, AD777X_REG_DOUT_FORMAT,
> +				    AD777X_DCLK_CLK_DIV_MSK,
> +				    FIELD_PREP(AD777X_DCLK_CLK_DIV_MSK, 1));
> +	if (ret)
> +		return ret;
> +	ret = ad777x_spi_write_mask(st, AD777X_REG_ADC_MUX_CONFIG,
> +				    AD777X_REFMUX_CTRL_MSK,
> +				    FIELD_PREP(AD777X_REFMUX_CTRL_MSK, 1));
> +	if (ret)
> +		return ret;
> +	ret = ad777x_spi_write_mask(st, AD777X_REG_GEN_ERR_REG_1_EN,
> +				    AD777X_SPI_CRC_EN_MSK,
> +				    FIELD_PREP(AD777X_SPI_CRC_EN_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +	st->power_mode = AD777X_HIGH_POWER;
> +	st->crc_enabled = true;
I'd be tempted to enable crc earlier and open code the spi write for that
instead of using helpers.  That way you can assume it is always on and
simplify the code.

No one ever wants to disable CRC on a chip that has it. It's rare enough
that people only fit such chips if they want that feature.

If there are reasons it can't be done earlier such as need to be
in particular power states or similar add a comment

> +	ret = ad777x_set_sampling_frequency(st, AD777X_DEFAULT_SAMPLING_FREQ);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value(start_gpio, 0);
> +	fsleep(15);
> +	gpiod_set_value(start_gpio, 1);
> +	fsleep(15);
> +	gpiod_set_value(start_gpio, 0);
> +	fsleep(15);
> +
> +	return 0;
> +}
> +
> +static int ad777x_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad777x_state *st;
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *start_gpio;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (IS_ERR(st->vref))
> +		return PTR_ERR(st->vref);
> +
> +	ret = regulator_enable(st->vref);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad777x_reg_disable,
> +				       st->vref);
> +	if (ret)
> +		return ret;
I'm surprised not to see the voltage on vref being queried.  I would think
the new
	devm_regulator_get_enable_read_voltage()
may be appropriate.

Why is it optional?  That can make sense if there is an internal
regulator but you aren't doing appropriate handling for that.


> +
> +	st->mclk = devm_clk_get(&spi->dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
> +
> +	ret = clk_prepare_enable(st->mclk);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad777x_clk_disable,
> +				       st->mclk);
> +	if (ret)
> +		return ret;
As Andy pointed out, there are helpers for these sequences of code.

> +
> +	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +
> +	start_gpio = devm_gpiod_get(&spi->dev, "start", GPIOD_OUT_HIGH);
> +	if (IS_ERR(start_gpio))
> +		return PTR_ERR(start_gpio);
> +
> +	crc8_populate_msb(ad777x_crc8_table, AD777X_CRC8_POLY);
> +	st->spi = spi;
> +
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return -ENODEV;
> +
> +	ret = ad777x_reset(indio_dev, start_gpio);
> +	if (ret)
> +		return ret;
> +
> +	ad777x_powerup(st, start_gpio);
> +	if (ret)
> +		return ret;
> +
> +	if (spi->irq)

Why?  If the device is only registered if the irq is present then
check that earlier and error out earlier.

Right now I think that a missing irq means the driver probe succeeds
but no user interfaces are provided. That doesn't make much sense.

> +		ret = ad777x_register(st, indio_dev);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused ad777x_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad777x_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad777x_spi_write_mask(st, AD777X_REG_GENERAL_USER_CONFIG_1,
> +				    AD777X_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD777X_MOD_POWERMODE_MSK,
> +					       AD777X_LOW_POWER));
> +	if (ret)
> +		return ret;
> +
> +	st->power_mode = AD777X_LOW_POWER;

This is never queried - so don't store this info until you
add code that needs to know the current state and for some reason
can't just read it from the register.

> +	return 0;
> +}
> +

