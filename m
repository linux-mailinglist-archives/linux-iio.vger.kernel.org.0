Return-Path: <linux-iio+bounces-8758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F11A995DD81
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 13:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C5DB21751
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D875F15B0FE;
	Sat, 24 Aug 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAIUxP3x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175C154434;
	Sat, 24 Aug 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498489; cv=none; b=bpWCOdK3S2TQJK2QLXzAjjjizOJb0LitmSkkbflgoQRs1Eb1ompVrcF2n1808Eg9coPXxw8T+6PmQHLo72ZqHUdMFvRxr0czJ0oUa/h9nydjaAwnD+1M0inqhupfNfA+IuhsNHUEp3XYXisTz0Wm9IaEiD3pJeqhAfKx1GZ2BLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498489; c=relaxed/simple;
	bh=gZMrB4/oB2yUE4Qh3m9qRbVVxiDQTW2y47+UiPvs+f8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYwKZb0CVbRjuXHqH3FxFBnLN65m9zm98Ow49vUBfftdmMqwTOGNFMSQphm0B83yrtbxTny6Fgm7RiEQBDepesEkgtryLFowJYGtluFp9T7ZwGT+C7RV7yYr9ZNO/I3PoPnRV7b++QF1CZ9f2obAs0izB9xtqdsK6euJENBa4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAIUxP3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E01CC32781;
	Sat, 24 Aug 2024 11:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724498488;
	bh=gZMrB4/oB2yUE4Qh3m9qRbVVxiDQTW2y47+UiPvs+f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nAIUxP3xu4ocl5PVQBZ38Y1auLm6ijLVV8nnqTGpmgvCbIjGqXUk/QwYVzGQHp84g
	 gQ0WVvt+8nJW+l5HbxjGdm1S3dcQ/TVJcuPfJDcqj2eDlEF3gP0YIjDvbiu3ffY3QI
	 r208Lefz04UMEypmjxKNJq+fAGpBnkDeM6wUHvLPSUUynSmi5bbJSiDliOdT8952xT
	 qumr4ry9wFeV8Btebu7AyFJEJcGOYSn8277LxobUKScVl5nWBQHGLmvnpl7ZqMUopS
	 0uR7fHrtye+jMtIpgayW8VHKGAjNG0I3HKIL7GEz88IgRcalRAbirb9wya1YGKE0BL
	 1XHfRNz3IroGw==
Date: Sat, 24 Aug 2024 12:21:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240824122111.425fa689@jic23-huawei>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	<20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 14:45:18 +0200
Esteban Blanc <eblanc@baylibre.com> wrote:

> This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
>=20
> The driver implements basic support for the AD4030-24 1 channel
> differential ADC with hardware gain and offset control.
>=20
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Hi Esteban

Some additional comments.  David did a good review already so
I've tried not to duplicate too much of that.

The big one in here is don't use extended_name.
It's effectively deprecated for new drivers plus
it would have required you add a lot of ABI docs as every
sysfs file would have a strange name.

> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> new file mode 100644
> index 000000000000..a981dce988e5
> --- /dev/null
> +++ b/drivers/iio/adc/ad4030.c

> +struct ad4030_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	const struct ad4030_chip_info *chip;
> +	struct gpio_desc *cnv_gpio;
> +	int vref_uv;
> +	int vio_uv;
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
> +			u8 raw[AD4030_MAXIMUM_RX_BUFFER_SIZE];
> +			struct {
> +				s32 val;
> +				u32 common;
> +			} __packed buffered[AD4030_MAX_HARDWARE_CHANNEL_NB];

David pointed out this doesn't need to be packed.
Given you have a union here, add __beXX as needed to avoid casts below.

> +		};
> +	} rx_data __aligned(IIO_DMA_MINALIGN);

This one is always fun.  You shouldn't need to mark this second buffer
because normally SPI controllers don't shoot themselves in the foot
and it isn't normal software flow to fill rx_data whilst the SPI
controller is working on tx_data (I didn't notice you doing that
here either).

As such, we don't need tx_buf and rx_buf to be in different cachelines.
It is sufficient to mark just the first one (as that forces these
to start at a new cacheline) the second buffer can then sit later
in that same cacheline if the sizes end up so that happens.

So drop __aligned(IIO_DMA_MINALIGN from rx_data.


> +};
> +
> +#define AD4030_CHAN_CMO(_idx)  {					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D _idx * 2 + 2,					\
> +	.scan_index =3D _idx * 2 + 1,					\
> +	.extend_name =3D "Channel" #_idx " common byte part",		\

We more or less never use extend name any more because it makes writing
userspace code much harder.  Use the label callback to assign a label inste=
ad.

If we were still using this, it would need to be a lot simpler than that
and no spaces etc as it ends up int he sysfs file names.


> +	.scan_type =3D {							\
> +		.sign =3D 'u',						\
> +		.storagebits =3D 32,					\
> +		.realbits =3D 8,						\
> +		.endianness =3D IIO_BE,					\
> +	},								\
> +}
> +
> +#define AD4030_CHAN_IN(_idx, _storage, _real, _shift) {			\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
> +		BIT(IIO_CHAN_INFO_RAW),					\
> +	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
> +		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D _idx * 2,						\
> +	.channel2 =3D _idx * 2 + 1,					\
> +	.scan_index =3D _idx * 2,						\
> +	.extend_name =3D "Channel" #_idx " differential part",		\

As above, no to this for same reason.
This will generate a crazy ABI so I'm a bit surprised that didn't show
up in your testing.  Would have needed a lot of docs even if we did
still do things this way.

> +	.differential =3D true,						\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.storagebits =3D _storage,				\
> +		.realbits =3D _real,					\
> +		.shift =3D _shift,					\
> +		.endianness =3D IIO_BE,					\
> +	},								\
> +}
> +
> +static int ad4030_spi_read(void *context, const void *reg, size_t reg_si=
ze,
> +			   void *val, size_t val_size)
> +{
> +	struct ad4030_state *st =3D context;
> +
> +	struct spi_transfer xfer =3D {
> +		.tx_buf =3D st->tx_data,
> +		.rx_buf =3D st->rx_data.raw,
> +		.len =3D reg_size + val_size,
> +	};
> +	int ret;
> +
> +	memcpy(st->tx_data, reg, reg_size);
> +
> +	/*
> +	 * This should use spi_write_the_read but when doing so, CS never get
> +	 * deasserted.

I'm confused.  As a single transfer it won't be deasserted in the transfer
whereas spi_write_then_read() will. So is this comment backwards or
is it referring to something else?

> +	 */
> +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, &st->rx_data.raw[reg_size], val_size);
> +
> +	return ret;
> +}

> +
> +static int ad4030_get_chan_gain(struct iio_dev *indio_dev, int ch, int *=
val,
> +				int *val2)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	u16 gain;
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(st->regmap, AD4030_REG_GAIN_CHAN(ch),
> +			       st->rx_data.raw, AD4030_REG_GAIN_BYTES_NB);
> +	if (ret)
> +		return ret;
> +
> +	gain =3D be16_to_cpu(*(u16 *)st->rx_data.raw);

As below, I'd be tempted to use the unaligned getters to avoid the cast.
This isn't a performance path afterall so even if it's painful on
some arch, we don't really care.

> +
> +	/* From datasheet: multiplied output =3D input =C3=97 gain word/0x8000 =
*/
> +	*val =3D gain / 0x8000;
> +	*val2 =3D mul_u64_u32_div(gain % 0x8000, MICRO, 0x8000);
> +
> +	return 0;
> +}
> +
> +/*
> + * @brief Returns the offset where 1 LSB =3D (VREF/2^precision_bits - 1)=
/gain

Not kernel, doc so drop the @brief, or fully document it.

> + */
> +static int ad4030_get_chan_offset(struct iio_dev *indio_dev, int ch, int=
 *val)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(st->regmap, AD4030_REG_OFFSET_CHAN(ch),
> +			       st->rx_data.raw, AD4030_REG_OFFSET_BYTES_NB);
> +	if (ret)
> +		return ret;
> +
> +	switch (st->chip->precision_bits) {
> +	case 16:
> +		*val =3D sign_extend32(get_unaligned_be16(st->rx_data.raw), 15);
> +		break;
return 0;
> +
> +	case 24:
> +		*val =3D sign_extend32(get_unaligned_be24(st->rx_data.raw), 23);
> +		break;
return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
I'll always prefer early returns because I don't like scrolling
to check what happens after switch statements.
So move the returns up and drop this.

> +}
> +
> +static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int g=
ain_int,
> +				int gain_frac)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	__be16 *val =3D (__be16 *)st->rx_data.raw;

Hmm. This is a bit ugly. Maybe a union for that
buffer so you can reference it directly without the type casting?
Or be lazy and do a put_unaligned_be16 even though it's aligned ;)

> +	u64 gain;
> +
> +	gain =3D mul_u32_u32(gain_int, MICRO) + gain_frac;
> +
> +	if (gain > AD4030_REG_GAIN_MAX_GAIN)
> +		return -EINVAL;
> +
> +	*val =3D cpu_to_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO));
> +
> +	return regmap_bulk_write(st->regmap, AD4030_REG_GAIN_CHAN(ch), val,
> +			  AD4030_REG_GAIN_BYTES_NB);
> +}

> +
> +static int ad4030_conversion(struct ad4030_state *st,
> +			     const struct iio_chan_spec *chan)
> +{
> +	unsigned int bytes_to_read;
> +	unsigned char byte_index;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Number of bytes for one differential channel */
> +	bytes_to_read =3D BITS_TO_BYTES(chan->scan_type.realbits);
> +	/* Add one byte if we are using a differential + common byte mode */
> +	bytes_to_read +=3D (st->mode =3D=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
> +			st->mode =3D=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 1 : 0;
> +	/* Mulitiply by the number of hardware channels */
> +	bytes_to_read *=3D st->chip->num_channels;
> +
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +	ndelay(AD4030_TCNVH_NS);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +	ndelay(st->chip->tcyc);
> +
> +	ret =3D spi_read(st->spi, st->rx_data.raw, bytes_to_read);
> +	if (ret)
> +		return ret;
> +
> +	if (st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> +		return 0;
> +
> +	byte_index =3D BITS_TO_BYTES(chan->scan_type.realbits);
> +	for (i =3D 0; i < st->chip->num_channels; i++)
> +		st->rx_data.buffered[i].common =3D ((u8 *)&st->rx_data.buffered[i].val=
)[byte_index];
break line after =3D.

When it doesn't significantly hurt readability we still try to keep to 80
chars for IIO drivers.  People have big screens but a lot of kernel devs
love to have lots of windows across them - or have bad eyesight due to
years of code review!


> +
> +	return 0;
> +}

> +
> +static int ad4030_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (info) {
> +		case IIO_CHAN_INFO_RAW:
> +			return ad4030_single_conversion(indio_dev, chan, val);
> +
> +		case IIO_CHAN_INFO_SCALE:
> +			*val =3D (st->vref_uv * 2) / MILLI;
> +			*val2 =3D st->chip->precision_bits;
> +			return IIO_VAL_FRACTIONAL_LOG2;

No reason you can't read this whilst buffered capture in progress.
Maybe it's not worth the effort of special casing though.

It is the one thing people do read whilst doing buffered capture
though because they didn't cache it before starting the buffer
and it's needed for data interpretation unlike all the other controls.

Maybe just do a
	if (info =3D=3D IIO_CHAN_INFO_SCALE) {
	}
block at top of function?



> +
> +		case IIO_CHAN_INFO_CALIBSCALE:
> +			ret =3D ad4030_get_chan_gain(indio_dev, chan->channel,
> +						   val, val2);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		case IIO_CHAN_INFO_CALIBBIAS:
> +			ret =3D ad4030_get_chan_offset(indio_dev, chan->channel,
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



> +
> +static int ad4030_reset(struct ad4030_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	struct gpio_desc *reset;
> +	int ret;
> +
> +	/* Use GPIO if available ... */

Obvious comment given code. I'd drop it.

> +	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset),
> +				"Failed to get reset GPIO\n");
> +
> +	if (reset) {
> +		ndelay(50);
> +		gpiod_set_value_cansleep(reset, 0);
> +	} else {
> +		/* ... falback to software reset otherwise */
likewise. Feels obvious enough to not benefit from comment.
Maybe that's just me having seen far too many drivers though
so if you really think it is useful then fine to leave these.

> +		ret =3D ad4030_enter_config_mode(st);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(st->regmap, AD4030_REG_INTERFACE_CONFIG_A,
> +				   AD4030_REG_INTERFACE_CONFIG_A_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Wait for reset to complete before communicating to it */

I'd rather see a reference for the value than a generic comment
like this.  Also pull the actual value down here. Not particularly
useful to have a define for what is a real time unless you are going
 to have some combined docs for a bunch of timings (i.e a datasheet
table reference)


> +	fsleep(AD4030_TRESET_COM_DELAY_MS);
> +
> +	/* After reset, conversion mode is enabled. Switch to reg access */

This comment is good as not obvious without datasheet diving.
So one to definitely keep.


> +	return ad4030_enter_config_mode(st);
> +}
> +
> +static int ad4030_detect_chip_info(const struct ad4030_state *st)
> +{
> +	unsigned int grade;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4030_REG_CHIP_GRADE, &grade);
> +	if (ret)
> +		return ret;
> +
> +	grade =3D FIELD_GET(AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE, grade);
> +	if (grade !=3D st->chip->grade)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +					"Unknown grade(0x%x) for %s\n", grade,
> +					st->chip->name);

Is this similar to a missmatch on a whoami value?
I.e. should we print a message and carry on in the interests of providing
some degree of support for newer devices on older kernel?
(fallback compatibles in DT)

Superficially it seems to be matched with a particular compatible
so it seems likely.

> +
> +	return 0;
> +}
> +


>
> +static const struct spi_device_id ad4030_id_table[] =3D {
> +	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
> +	{}
As below.

I'm going to assume you have a bunch of other parts you plan to
support soon. Otherwise we normally don't add the chip specific
support until it is needed.  It tends to complicate initial driver
review a little and experience says that sometimes no other devices
are ever added.


> +};
> +MODULE_DEVICE_TABLE(spi, ad4030_id_table);
> +
> +static const struct of_device_id ad4030_of_match[] =3D {
> +	{ .compatible =3D "adi,ad4030-24", .data =3D &ad4030_24_chip_info },
> +	{}

I'm aiming for a bit more consistency in formatting of these.
As such made an arbitrary choice to prefer
 	{ }
for the terminators. Please go with that for new code.

> +};
> +MODULE_DEVICE_TABLE(of, ad4030_of_match);


