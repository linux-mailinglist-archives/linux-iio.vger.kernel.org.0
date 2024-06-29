Return-Path: <linux-iio+bounces-7042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC891CE26
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1851C20380
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5B8288C;
	Sat, 29 Jun 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuoAtlXt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968F39ADD;
	Sat, 29 Jun 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719679194; cv=none; b=hqily3EMKYsiHs3731SWPjcoXSGRI7jVoQ5UkuNjTGrdTyHuc885aEavXU5OJV3oxoAehf113fUtV0NhX9c6r0PvBu53H3FDw092nLkmBVMrXyCig3JyF4hcwzb1HJHua8nM9B/IReNn+K/1js5VMYc2y0S2ze4AELQouXk4oeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719679194; c=relaxed/simple;
	bh=76F/mm0smFYxOp/teP1sqYJ07KHNxLnyaeWkOchFa9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt+Xvd/MYUg8Tgygb6Z9+yY4WeFciza8/axhOwf1+8Wydr+LtyPP+A1ZjXtKuwka780fSIZ4yD1PTuTizJgmkYuxV8lNNXGTAMQDH5zr9WVPpzG/4Ok8j2XHflShixZwov0EKOFM76a9BRxOuQe3Yu20b5a3peUtC+vdpZstd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuoAtlXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A34BC2BBFC;
	Sat, 29 Jun 2024 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719679193;
	bh=76F/mm0smFYxOp/teP1sqYJ07KHNxLnyaeWkOchFa9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JuoAtlXt1BxgKBJ0QCoE+Zxq0uAM6mq8R0qS3H5exCib/FJsUp24pZhTmhpaEo8d6
	 SgLo2kB0e1HZC/UFh7z7vbeSjfA54g6CcGhYT0AKMTVWAoQI3DOBqtE67yEAfI1raM
	 s0yhA7PTAFjm2ql8nEOfMDXzOfJX0n9ZZZ8L0Y1riJfA2Axisy/6JDWfj/hTrNGREN
	 JD66V2kaMkVVdMzJinJfkn4fjv2ZCOaazbgr0OKmkP3ha4AEfrvT4Yj91s13Smem9P
	 3/pG16Q7eH/1agdMDTdLhcEVtzg5pWOBKH8ZN2DvvVuXTYX2aC4PZ0OXn0nn4AvsZM
	 AGrUTA1RWMctQ==
Date: Sat, 29 Jun 2024 17:39:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240629173945.25b72bde@jic23-huawei>
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	<20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 13:59:13 +0200
Esteban Blanc <eblanc@baylibre.com> wrote:

> This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> 
> The driver implements basic support for the AD4030-24 1 channel
> differential ADC with hardware gain and offset control.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
A few comments inline.

Jonathan

> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> new file mode 100644
> index 000000000000..6d537e531d6f
> --- /dev/null
> +++ b/drivers/iio/adc/ad4030.c
> @@ -0,0 +1,822 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4030 and AD4630 ADC family driver.
> + *
> + * Copyright 2024 Analog Devices, Inc.
> + * Copyright 2024 BayLibre, SAS
> + *
> + * based on code from:
> + *	Analog Devices, Inc.
> + *	  Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> + *	  Nuno Sa <nuno.sa@analog.com>
> + *	  Marcelo Schmitt <marcelo.schmitt@analog.com>
> + *	  Liviu Adace <liviu.adace@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/units.h>
> +#include <linux/clk.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define AD4030_REG_INTERFACE_CONFIG_A				0x00
> +#define     AD4030_REG_INTERFACE_CONFIG_A_SW_RESET		(BIT(0) | BIT(7))
> +#define AD4030_REG_INTERFACE_CONFIG_B				0x01
> +#define AD4030_REG_DEVICE_CONFIG				0x02
> +#define AD4030_REG_CHIP_TYPE					0x03
> +#define AD4030_REG_PRODUCT_ID_L					0x04
> +#define AD4030_REG_PRODUCT_ID_H					0x05
> +#define AD4030_REG_CHIP_GRADE					0x06
> +#define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE		0x10
> +#define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE		GENMASK(7, 3)
> +#define AD4030_REG_SCRATCH_PAD					0x0A
> +#define AD4030_REG_SPI_REVISION					0x0B
> +#define AD4030_REG_VENDOR_L					0x0C
> +#define AD4030_REG_VENDOR_H					0x0D
> +#define AD4030_REG_STREAM_MODE					0x0E
> +#define AD4030_REG_INTERFACE_CONFIG_C				0x10
> +#define AD4030_REG_INTERFACE_STATUS_A				0x11
> +#define AD4030_REG_EXIT_CFG_MODE				0x14
> +#define     AD4030_REG_EXIT_CFG_MODE_MASK_EXIT_CONFIG_MD	BIT(0)

Maybe can shorten to AD4030_REG_EXIT_CFG_MODE_EXIT_MSK
or something like that?

> +#define AD4030_REG_AVG						0x15
> +#define     AD4030_REG_AVG_MASK_AVG_SYNC			BIT(7)
> +#define     AD4030_REG_AVG_MASK_AVG_VAL				GENMASK(4, 0)
> +#define AD4030_REG_OFFSET_X0_0					0x16
> +#define AD4030_REG_OFFSET_X0_1					0x17
> +#define AD4030_REG_OFFSET_X0_2					0x18
> +#define AD4030_REG_OFFSET_X1_0					0x19
> +#define AD4030_REG_OFFSET_X1_1					0x1A
> +#define AD4030_REG_OFFSET_X1_2					0x1B
> +#define     AD4030_REG_OFFSET_BYTES_NB				3
> +#define     AD4030_REG_OFFSET_CHAN(ch)				(AD4030_REG_OFFSET_X0_2 +	\
> +								(AD4030_REG_OFFSET_BYTES_NB *	\
> +								(ch)))
Feel free to not have everything perfectly aligned.  So I'd reduce alignment of
the values and just have one two where it gets pushed further right by
a long name.

> +#define AD4030_REG_GAIN_X0_LSB					0x1C
> +#define AD4030_REG_GAIN_X0_MSB					0x1D
> +#define AD4030_REG_GAIN_X1_LSB					0x1E
> +#define AD4030_REG_GAIN_X1_MSB					0x1F
> +#define     AD4030_REG_GAIN_MAX_GAIN				1999970
> +#define     AD4030_REG_GAIN_BYTES_NB				2
> +#define     AD4030_REG_GAIN_CHAN(ch)				(AD4030_REG_GAIN_X0_MSB +	\
> +								(AD4030_REG_GAIN_BYTES_NB *	\
> +								(ch)))
> +#define AD4030_REG_MODES					0x20
> +#define     AD4030_REG_MODES_MASK_OUT_DATA_MODE			GENMASK(2, 0)
> +#define     AD4030_REG_MODES_MASK_LANE_MODE			GENMASK(7, 6)
> +#define AD4030_REG_OSCILATOR					0x21
> +#define AD4030_REG_IO						0x22
> +#define     AD4030_REG_IO_MASK_IO2X				BIT(1)
> +#define AD4030_REG_PAT0						0x23
> +#define AD4030_REG_PAT1						0x24
> +#define AD4030_REG_PAT2						0x25
> +#define AD4030_REG_PAT3						0x26
> +#define AD4030_REG_DIG_DIAG					0x34
> +#define AD4030_REG_DIG_ERR					0x35
> +
> +/* Sequence starting with "1 0 1" to enable reg access */
> +#define AD4030_REG_ACCESS		0xa0
> +
> +#define AD4030_MAX_DIFF_CHANNEL_NB	2
> +#define AD4030_MAX_COMMON_CHANNEL_NB	AD4030_MAX_DIFF_CHANNEL_NB
> +#define AD4030_MAX_TIMESTAMP_CHANNEL_NB	1
> +#define AD4030_ALL_CHANNELS_NB		(AD4030_MAX_DIFF_CHANNEL_NB +	\
> +					AD4030_MAX_COMMON_CHANNEL_NB +	\
> +					AD4030_MAX_TIMESTAMP_CHANNEL_NB)
> +#define AD4030_VREF_MIN_UV		(4096 * MILLI)
> +#define AD4030_VREF_MAX_UV		(5000 * MILLI)
> +#define AD4030_VIO_THRESHOLD_UV		(1400 * MILLI)
> +
> +#define AD4030_SPI_MAX_XFER_LEN		8
> +#define AD4030_SPI_MAX_REG_XFER_SPEED	(80 * MEGA)
> +#define AD4030_TCNVH_NS			10
> +#define AD4030_TCNVL_NS			20
> +#define AD4030_TCONV_NS			(300 - (AD4030_TCNVH_NS +	\
> +					AD4030_TCNVL_NS))
> +#define AD4030_TRESET_PW_NS		50
> +#define AD4030_TRESET_COM_DELAY_MS	750
> +
> +enum ad4030_out_mode {
> +	AD4030_OUT_DATA_MD_16_DIFF = 0x00,
> +	AD4030_OUT_DATA_MD_24_DIFF = 0x00,
> +	AD4030_OUT_DATA_MD_16_DIFF_8_COM = 0x01,
> +	AD4030_OUT_DATA_MD_24_DIFF_8_COM = 0x02,
> +	AD4030_OUT_DATA_MD_30_AVERAGED_DIFF = 0x03,
> +	AD4030_OUT_DATA_MD_32_PATTERN = 0x04
> +};
> +
> +struct ad4030_chip_info {
> +	const char *name;
> +	const unsigned long *available_masks;
> +	unsigned int available_masks_len;
> +	const struct iio_chan_spec channels[AD4030_ALL_CHANNELS_NB];
> +	u8 grade;
> +	u8 precision_bits;
> +	int num_channels;
> +};
> +
> +struct ad4030_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	const struct ad4030_chip_info *chip;
> +	struct gpio_desc *cnv_gpio;
> +	int vref_uv;
> +	int vio_uv;
> +	int min_offset;
> +	int max_offset;
> +	int offset_avail[3];
> +	u32 conversion_speed_hz;
> +	enum ad4030_out_mode mode;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> +	 * to live in their own cache lines.
> +	 */
> +	u8 tx_data[AD4030_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		union {
> +			/*
> +			 * Make the buffer large enough for MAX_NUM_CHANNELS 32-bit samples and
> +			 * one 64-bit aligned 64-bit timestamp.
> +			 */
> +			u8 raw[ALIGN(AD4030_MAX_DIFF_CHANNEL_NB * sizeof(u32) +
> +			       AD4030_MAX_COMMON_CHANNEL_NB * sizeof(u8),
> +			       sizeof(u64)) + sizeof(u64)];
> +			struct {
> +				s32 val[AD4030_MAX_DIFF_CHANNEL_NB];
> +				u8 common[AD4030_MAX_COMMON_CHANNEL_NB];
> +			};
> +		};
> +	} rx_data __aligned(IIO_DMA_MINALIGN);
> +};

> +
> +static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
> +			   void *val, size_t val_size)
> +{
> +	struct ad4030_state *st = context;
> +
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_data,
> +		.rx_buf = st->rx_data.raw,
> +		.len = reg_size + val_size,
> +	};
> +	int ret;
> +
> +	memcpy(st->tx_data, reg, reg_size);
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, &st->rx_data.raw[reg_size], val_size);

Can you just use spi_write_then_read() here?

> +
> +	return ret;
> +}


> +/*
> + * @brief Returns the offset where 1 LSB = (VREF/2^precision_bits - 1)/gain
> + */
> +static int ad4030_get_chan_offset(struct iio_dev *indio_dev, int ch, int *val)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	__be32 offset;
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, AD4030_REG_OFFSET_CHAN(ch), &offset,
> +			       AD4030_REG_OFFSET_BYTES_NB);

As Nuno observed, DMA safe buffers needed.  I don't think there has been any
change since I last checked that we should not assume regmap doesn't need them
(even though it probably doesn't) when run over transports that do.

> +	if (ret)
> +		return ret;
> +
> +	if (st->chip->precision_bits == 16)
> +		offset <<= 16;
> +	else
> +		offset <<= 8;

As below. This is hard tor read. Just use appropriate unaligned gets for the
two cases to extract the write bytes directly.

> +	*val = be32_to_cpu(offset);
> +
> +	return 0;
> +}
> +
> +static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int gain_int,
> +				int gain_frac)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	__be16 val;
> +	u64 gain;
> +
> +	gain = mul_u32_u32(gain_int, MICRO) + gain_frac;
> +
> +	if (gain > AD4030_REG_GAIN_MAX_GAIN)
> +		return -EINVAL;
> +
> +	val = cpu_to_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO));
> +
> +	return regmap_bulk_write(st->regmap, AD4030_REG_GAIN_CHAN(ch), &val,
> +			  AD4030_REG_GAIN_BYTES_NB);
> +}
> +
> +static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, int offset)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	__be32 val;
> +
> +	if (offset < st->min_offset || offset > st->max_offset)
> +		return -EINVAL;
> +
> +	val = cpu_to_be32(offset);
> +	if (st->chip->precision_bits == 16)
> +		val >>= 16;
> +	else
> +		val >>= 8;

I 'think' I get what this is doing but not 100% sure as it's a bit too unusual
and I'm not even sure what happens if we shift a __be32 value on a little endian
system. I would instead split this into appropriate cpu_to_be24() and cpu_to_be16()
to put the value directly in the right place rather than shifting in place.

> +
> +	return regmap_bulk_write(st->regmap, AD4030_REG_OFFSET_CHAN(ch), &val, 3);
> +}
> +
> +static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
> +					unsigned int mask)
> +{
> +	return mask & BIT(st->chip->num_channels);

That's not obvious.  So at very least add a comment on why that's the bit to check.

> +}
> +
> +static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	if (ad4030_is_common_byte_asked(st, mask))
> +		st->mode = st->chip->precision_bits == 24 ?
> +			AD4030_OUT_DATA_MD_24_DIFF_8_COM :
> +			AD4030_OUT_DATA_MD_16_DIFF_8_COM;

I'd match on each precision_bits value so it's clear that there is
only 24 and 16.  Probably a small switch statement.
Will be a little more code, but easier to read.


> +	else
> +		st->mode = AD4030_OUT_DATA_MD_24_DIFF;
> +
> +	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
> +				AD4030_REG_MODES_MASK_OUT_DATA_MODE,
> +				st->mode);
> +}
> +
> +static int ad4030_conversion(struct ad4030_state *st, const struct iio_chan_spec *chan)
> +{
> +	unsigned int bytes_to_read = (BITS_TO_BYTES(chan->scan_type.realbits) +
> +			     ((st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
> +			     st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 1 : 0)) *
> +			     st->chip->num_channels;

Too fiddly. I'd express this as a series if statements so it is easier to grasp
what each stage is doing.

> +	struct spi_transfer xfer = {
> +		.rx_buf = st->rx_data.raw,
> +		.len = bytes_to_read,
> +	};
> +	unsigned char byte_index;
> +	unsigned int i;
> +	int ret;
> +
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +	ndelay(AD4030_TCNVH_NS);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +	ndelay(AD4030_TCNVL_NS + AD4030_TCONV_NS);
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);

spi_read()?

> +	if (ret || (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> +		    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM))
> +		return ret;
> +

Split this so error is handled then the 'we are done here' condition
is handled.

> +	byte_index = st->chip->precision_bits == 16 ? 3 : 4;

Can we compute this rather than assume knowledge that precision_bits only takes
a few values?

> +	for (i = 0; i < st->chip->num_channels; i++)
> +		st->rx_data.common[i] = ((u8 *)&st->rx_data.val[i])[byte_index];
> +
> +	return 0;
> +}
> +
> +static int ad4030_single_conversion(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan, int *val)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad4030_set_mode(indio_dev, BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_exit_config_mode(st);

Failed register accesses are always a pain, but normal assumption if they fail
is that nothing got written. So should still be in config mode in the
error path and don't need to reset it.  If there is a reason to do otherwise
here add a cmment.

> +	if (ret)
> +		goto out_error;
> +
> +	ret = ad4030_conversion(st, chan);
> +	if (ret)
> +		goto out_error;
> +
> +	if (chan->channel < st->chip->num_channels)
> +		*val = st->rx_data.val[chan->channel];
> +	else
> +		*val = st->rx_data.common[chan->channel - st->chip->num_channels];
> +
> +out_error:
> +	ad4030_enter_config_mode(st);
> +
> +	return IIO_VAL_INT;
> +}

> +
> +static const int ad4030_gain_avail[3][2] = {
> +	{0, 0},
> +	{0, 30},
> +	{1, 999969},
Spaces after { and before } preferred.

> +};
> +

> +
> +static int ad4030_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (info) {
> +		case IIO_CHAN_INFO_RAW:
> +			return ad4030_single_conversion(indio_dev, chan, val);
> +
> +		case IIO_CHAN_INFO_SCALE:
> +			*val = (st->vref_uv * 2) / MILLI;
> +			*val2 = st->chip->precision_bits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +
> +		case IIO_CHAN_INFO_CALIBSCALE:

As per cover letter these seem somewhat pointless, but if I'm wrong
and they are useeful, roll this into scale (maths will get harder
but that's the side effect of keeping an interface simple) and offset.

> +			ret = ad4030_get_chan_gain(indio_dev, chan->channel,
> +						   val, val2);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		case IIO_CHAN_INFO_CALIBBIAS:
> +			ret = ad4030_get_chan_offset(indio_dev, chan->channel,
> +						     val);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	unreachable();
> +}

> +
> +static int ad4030_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	/* Make sure the SPI clock is within range to read register */
> +	if (st->spi->max_speed_hz > AD4030_SPI_MAX_REG_XFER_SPEED)
> +		st->spi->max_speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;

min

> +
> +	return ad4030_enter_config_mode(st);
> +}
> +
> +static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
> +	.preenable = ad4030_buffer_preenable,
> +	.postdisable = ad4030_buffer_postdisable,
> +};
> +
> +static int ad4030_regulators_get(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	static const char * const ids[] = {"vdd-5v", "vdd-1v8"};

Trivial, but I prefer spaces always after { and before } for arrays.

> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ids), ids);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	st->vio_uv = devm_regulator_get_enable_read_voltage(dev, "vio");
> +	if (st->vio_uv < 0)
> +		return dev_err_probe(dev, st->vio_uv,
> +				     "Failed to enable and read vio voltage");
> +
> +	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (st->vref_uv < 0) {
> +		if (st->vref_uv != -ENODEV)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to read vref voltage");
> +
> +		/* if not using optional REF, the internal REFIN must be used */
> +		st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "refin");
> +		if (st->vref_uv < 0)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to read vrefin voltage");
> +	}
> +
> +	if (st->vref_uv < AD4030_VREF_MIN_UV || st->vref_uv > AD4030_VREF_MAX_UV)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "vref(%d) must be in the range [%lu %lu]\n",
> +				     st->vref_uv, AD4030_VREF_MIN_UV,
> +				     AD4030_VREF_MAX_UV);
> +
> +	return 0;
> +}
> +
> +static int ad4030_reset(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *reset;
> +	int ret;
> +
> +	/* Use GPIO if available ... */
> +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset),
> +				"Failed to get reset GPIO\n");
> +
> +	if (reset) {
> +		ndelay(50);
> +		gpiod_set_value_cansleep(reset, 0);
> +		goto reset_end;

Rather than a goto, I'd use else { here.
I think that will end up as more readable code flow.
I was briefly wondering why this was an error path having misread it.


> +	}
> +
> +	/* ... falback to software reset otherwise */
> +	ret = ad4030_enter_config_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_INTERFACE_CONFIG_A,
> +			   AD4030_REG_INTERFACE_CONFIG_A_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +reset_end:
> +	/* Wait for reset to complete before communicating to it */
> +	fsleep(AD4030_TRESET_COM_DELAY_MS);
> +
> +	/* After reset, conversion mode is enabled. Switch to reg access */
> +	return ad4030_enter_config_mode(st);
> +}
> +
> +static int ad4030_detect_chip_info(const struct ad4030_state *st)
> +{
> +	unsigned int grade;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD4030_REG_CHIP_GRADE, &grade);
> +	if (ret)
> +		return ret;
> +
> +	grade = FIELD_GET(AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE, grade);
> +	if (grade != st->chip->grade)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +				"Unknown grade(%u) for %s\n", grade,

Indent to align after ( or if it's a too long a line as a result use
one tab only after the line above.  That tends to end up more
consistent than seen here.

> +				st->chip->name);
> +
> +	return 0;
> +}
> +
> +static int ad4030_config(struct ad4030_state *st)
> +{
> +	st->min_offset = (int)BIT(st->chip->precision_bits) * -1;
> +	st->max_offset = BIT(st->chip->precision_bits) - 1;
> +	st->offset_avail[0] = st->min_offset;
> +	st->offset_avail[1] = 1;
> +	st->offset_avail[2] = st->max_offset;
Perhaps void storing the same set of values twice in st.

> +
> +	if (st->vio_uv < AD4030_VIO_THRESHOLD_UV)
> +		return regmap_write(st->regmap, AD4030_REG_IO,
> +				AD4030_REG_IO_MASK_IO2X);
> +
> +	return 0;
> +}
> +
> +static int ad4030_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4030_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	/* Make sure the SPI clock is within range to read register */
> +	st->conversion_speed_hz = spi->max_speed_hz;
> +	if (spi->max_speed_hz > AD4030_SPI_MAX_REG_XFER_SPEED)
> +		spi->max_speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;

	st->conversion_speed_hz = min(spi->max_speed_hz,
				      AD4030_SPI_MAX_REG_XFER_SPEED);

> +
> +	st->regmap = devm_regmap_init(&spi->dev, &ad4030_regmap_bus, st,
> +				      &ad4030_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> +			      "Failed to initialize regmap\n");
> +
> +	st->chip = spi_get_device_match_data(spi);
> +	if (!st->chip)
> +		return -EINVAL;
> +
> +	ret = ad4030_regulators_get(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_detect_chip_info(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_config(st);
> +	if (ret)
> +		return ret;
> +
> +	st->cnv_gpio = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->cnv_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> +				     "Failed to get cnv gpio");
> +
> +	indio_dev->name = st->chip->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad4030_iio_info;
> +	indio_dev->channels = st->chip->channels;
> +	indio_dev->num_channels =  2 * st->chip->num_channels + 1;

hmm. This is non obviously.  Add a comment to the structure definition
and maybe one here as well.



> +	indio_dev->available_scan_masks = st->chip->available_masks;
> +	indio_dev->masklength = st->chip->available_masks_len;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ad4030_trigger_handler,
> +					      &ad4030_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


