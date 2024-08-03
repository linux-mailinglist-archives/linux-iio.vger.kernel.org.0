Return-Path: <linux-iio+bounces-8183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71794690C
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B115E1C20D5D
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DA21369AE;
	Sat,  3 Aug 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcll7n1f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53D130AC8;
	Sat,  3 Aug 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722680990; cv=none; b=GtqJnr3trPHmGDMgOW8Zm/mB3ELvT5zwW8k+Yfz/BrMfYzk07rbTNQE8scC9ZsSa32NahzkkGJDlqbSoCLA0Ew4VZtrwgoPCnPbiGCsEseMOH5JBzqi97JodXfzwfH4w1OQ5q2CdB0VT62vkjC0dzc6WsGpjKFMUgKnnDoCiEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722680990; c=relaxed/simple;
	bh=kL9g6qYfClDFMTgvBBNhL7mJzJYT7Rq5Tso5Orb+34w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdEXVpKDdFSSOtKXNQYsihCmxvP8qjSH2VJmNLyhwHHkud7wlTZoIad5WDSGUPbOtLUQV7oAGGO4ZgFw6rUH5caUHeUXW+SdbccbC8l5zf4xuwEBj2WKUSpkSpDZRHWzIT2kwzYwJWzXqyI31Cx1L9dNtCYlqj6W1/ROUKDqGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcll7n1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5858EC116B1;
	Sat,  3 Aug 2024 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722680989;
	bh=kL9g6qYfClDFMTgvBBNhL7mJzJYT7Rq5Tso5Orb+34w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gcll7n1f/DhQkHR+G8roPSm4QhJ9sP3fW1iOeBh5vLIdnRTLFl11nhzMc8H1k9aTN
	 55aQ1m8HIks0Xd7jw6hsy/I5LAl+iCQOL2ol9x+1HbeqchnJmW8VBV00tDZ7IeWDFV
	 Hm389DyhbtoUK80qwGa/eokDQjN7PwsNcL6Q4PnPys3qoZK72pA4m1tctJckv4br2u
	 6GpH+YtgiS7192NUBwzpdXdBPplSnSlxbOcs3zAQoWjYc1NCLWhxEt3K9C8C2+eIt9
	 /agJ2c1428E0mTs1Jxq4Au3hJxdOTjUAQ7YJJF/dhyYO60sv/92B0nLO49OzU+kmZC
	 JhAkZLrgddI4Q==
Date: Sat, 3 Aug 2024 11:29:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240803112941.562d0eb0@jic23-huawei>
In-Reply-To: <20240730030509.57834-3-Mariel.Tinaco@analog.com>
References: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
	<20240730030509.57834-3-Mariel.Tinaco@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 11:05:09 +0800
Mariel Tinaco <Mariel.Tinaco@analog.com> wrote:

> The AD8460 is a =E2=80=9Cbits in, power out=E2=80=9D high voltage, high-p=
ower,
> high-speed driver optimized for large output current (up to =C2=B11 A)
> and high slew rate (up to =C2=B11800 V/=CE=BCs) at high voltage (up to =
=C2=B140 V)
> into capacitive loads.
>=20
> A digital engine implements user-configurable features: modes for
> digital input, programmable supply current, and fault monitoring
> and programmable protection settings for output current,
> output voltage, and junction temperature. The AD8460 operates on
> high voltage dual supplies up to =C2=B155 V and a single low voltage
> supply of 5 V.
>=20
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
Hi Mariel,

The test bot detected problems don't give me a high degree of confidence
in this driver in general. Please be much more careful and thorough in
build tests for v3.

Various minor comments inline

Jonathan

> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> new file mode 100644
> index 000000000..a94fa4526
> --- /dev/null
> +++ b/drivers/iio/dac/ad8460.c
> @@ -0,0 +1,976 @@

> +static int ad8460_set_hvdac_word(struct ad8460_state *state,
> +				 int index,
> +				 int val)
> +{
> +	put_unaligned_le16(val & 0x3FFF, &state->spi_tx_buf);

GENMASK for that constant.

> +
> +	return regmap_bulk_write(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(inde=
x),
> +				 state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
> +}


> +
> +static int ad8460_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)

Aim for wrapping to below 80 chars, not much shorter.
Feel free to group parameters though if you want to.

> +{
> +	struct ad8460_state *state =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +				return ad8460_set_sample(state, val);
> +			unreachable();
> +		case IIO_CURRENT:
> +			return regmap_write(state->regmap, AD8460_CTRL_REG(0x04),
> +					    FIELD_PREP(AD8460_SET_QUIESCENT_CURRENT_MSK, val));
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad8460_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long mask)
> +{
> +	struct ad8460_state *state =3D iio_priv(indio_dev);
> +	int data, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			scoped_guard(mutex, &state->lock) {
> +				ret =3D ad8460_get_hvdac_word(state, 0, &data);
> +				if (ret)
> +					return ret;
> +			}
> +			*val =3D data;
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			ret =3D regmap_read(state->regmap, AD8460_CTRL_REG(0x04), &data);
> +			if (ret)
> +				return ret;
> +			*val =3D data;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			ret =3D iio_read_channel_raw(state->tmp_adc_channel, &data);
> +			if (ret)
> +				return ret;
> +			*val =3D data;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D clk_get_rate(state->sync_clk);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* vCONV =3D vNOMINAL_SPAN * (DAC_CODE / 2**14) - 40V
		/*
		 * vCONV ...

for IIO multiline comment syntax.

> +		 * vMAX  =3D vNOMINAL_SPAN * (2**14 / 2**14) - 40V
> +		 * vMIN  =3D vNOMINAL_SPAN * (0 / 2**14) - 40V
> +		 * vADJ  =3D vCONV * (2000 / rSET) * (vREF / 1.2)
> +		 * vSPAN =3D vADJ_MAX - vADJ_MIN
> +		 * See datasheet page 49, section FULL-SCALE REDUCTION
> +		 */
> +		*val =3D AD8460_NOMINAL_VOLTAGE_SPAN * 2000 * state->refio_1p2v_mv;
> +		*val2 =3D state->rset_ohms * 1200;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad8460_select_fault_type(int chan_type, enum iio_event_direct=
ion dir)
> +{
> +	switch (chan_type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return AD8460_OVERVOLTAGE_POS;
> +		case IIO_EV_DIR_FALLING:
> +			return AD8460_OVERVOLTAGE_NEG;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
as below.

> +	case IIO_CURRENT:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return AD8460_OVERCURRENT_SRC;
> +		case IIO_EV_DIR_FALLING:
> +			return AD8460_OVERCURRENT_SNK;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
Can't get here. So drop the break.
> +	case IIO_TEMP:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return AD8460_OVERTEMPERATURE;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ad8460_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct ad8460_state *state =3D iio_priv(indio_dev);
> +	unsigned int fault;
> +	bool en;
> +	int ret;
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	fault =3D ad8460_select_fault_type(chan->type, dir);
> +	if (fault < 0)
> +		return fault;
> +
> +	ret =3D ad8460_get_fault_threshold_en(state, fault, &en);
> +	return ret ?: en;

Keep to simpler to read
	if (ret)
		return ret;

	return en;

> +}

> +
> +static struct iio_chan_spec_ext_info ad8460_ext_info[] =3D {
> +	AD8460_CHAN_EXT_INFO("raw0", 0, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw1", 1, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw2", 2, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw3", 3, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw4", 4, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw5", 5, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw6", 6, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw7", 7, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw8", 8, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw9", 9, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw10", 10, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw11", 11, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw12", 12, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw13", 13, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw14", 14, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw15", 15, IIO_SEPARATE,
> +			     ad8460_dac_input_read, ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("toggle_en", 0, IIO_SEPARATE,
> +			     ad8460_read_toggle_en,
> +			     ad8460_write_toggle_en),
> +	AD8460_CHAN_EXT_INFO("symbol", 0, IIO_SEPARATE,
> +			     ad8460_read_symbol,
> +			     ad8460_write_symbol),

Wrap closer to 80 chars.

> +	AD8460_CHAN_EXT_INFO("powerdown", 0, IIO_SEPARATE,
> +			     ad8460_read_powerdown, ad8460_write_powerdown),
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad8460_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			   &ad8460_powerdown_mode_enum),
> +	{}
> +};
> +
> +static const struct iio_event_spec ad8460_events[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_RISING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_FALLING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +#define AD8460_VOLTAGE_CHAN(_chan) {				\
> +	.type =3D IIO_VOLTAGE,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +			      BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.output =3D 1,						\
> +	.indexed =3D 1,						\
> +	.channel =3D (_chan),					\
> +	.scan_index =3D 0,					\
> +	.scan_type =3D {						\
> +		.sign =3D 'u',					\
> +		.realbits =3D 14,					\
> +		.storagebits =3D 16,				\
> +		.endianness =3D IIO_LE,				\
> +	},                                                      \
> +	.ext_info =3D ad8460_ext_info,                            \
> +	.event_spec =3D ad8460_events,				\
> +	.num_event_specs =3D ARRAY_SIZE(ad8460_events),		\
> +}
> +
> +#define AD8460_CURRENT_CHAN(_chan) {				\
> +	.type =3D IIO_CURRENT,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +	.output =3D 0,						\

I'm guessing this is also not used with the buffer.
set scan_index =3D -1 if so.

> +	.indexed =3D 1,						\
> +	.channel =3D (_chan),					\
> +	.scan_index =3D 1,					\
> +	.scan_type =3D {						\
> +		.sign =3D 'u',					\
> +		.realbits =3D 8,					\
> +		.storagebits =3D 8,				\
> +		.endianness =3D IIO_LE,				\
Generally don't provide these if you aren't using them for buffered
capture.  It's just unnecessary noise in the driver.

> +	},							\
> +	.event_spec =3D ad8460_events,				\
> +	.num_event_specs =3D ARRAY_SIZE(ad8460_events),		\
> +}
> +
> +#define AD8460_TEMP_CHAN(_chan) {				\
> +	.type =3D IIO_TEMP,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +	.output =3D 1,						\
> +	.indexed =3D 1,						\
> +	.channel =3D (_chan),					\
> +	.scan_index =3D 2,					\
> +	.scan_type =3D {						\
No sizing? =20
I suspect you don't want to present this for the buffered interface.
If so, set .scan_index =3D -1

> +		.sign =3D 'u',					\
> +		.endianness =3D IIO_LE,				\
> +	},							\
> +	.event_spec =3D ad8460_events,				\
> +	.num_event_specs =3D 1,					\
> +}
> +
> +static const struct iio_chan_spec ad8460_channels[] =3D {
> +	AD8460_VOLTAGE_CHAN(0),
> +	AD8460_CURRENT_CHAN(0),
> +};
> +
> +static const struct iio_chan_spec ad8460_channels_with_tmp_adc[] =3D {
> +	AD8460_VOLTAGE_CHAN(0),
> +	AD8460_CURRENT_CHAN(0),
> +	AD8460_TEMP_CHAN(0),
> +};
Unless you plan to very soon add support for devices with more channels,
drop the parameter and hardcode 0 in the definitions.

Chances are that if you do get a more complex device with more channels
you will need more than just a channel number anyway so this code
will change either way.  Hence better to keep it simple for now.


> +static int ad8460_probe(struct spi_device *spi)
> +{
> +	struct ad8460_state *state;
> +	struct iio_dev *indio_dev;
> +	struct regulator *refio_1p2v;
> +	u32 tmp[2], temp;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state =3D iio_priv(indio_dev);
> +	mutex_init(&state->lock);
> +
> +	indio_dev->name =3D "ad8460";
> +	indio_dev->info =3D &ad8460_info;
> +
> +	state->spi =3D spi;
> +
> +	state->regmap =3D devm_regmap_init_spi(spi, &ad8460_regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
> +				     "Failed to initialize regmap");
> +
> +	state->sync_clk =3D devm_clk_get_enabled(&spi->dev, NULL);

Lots of use of spi->dev, I'd suggest
struct device *dev =3D &spi->dev;
then replace all these instances with that local variable.

> +	if (IS_ERR(state->sync_clk))
> +		return dev_err_probe(&spi->dev, PTR_ERR(state->sync_clk),
> +				     "Failed to get sync clk\n");
> +
> +	state->tmp_adc_channel =3D devm_iio_channel_get(&spi->dev, "ad8460-tmp"=
);
> +	if (IS_ERR_OR_NULL(state->tmp_adc_channel)) {
> +		indio_dev->channels =3D ad8460_channels;
> +		indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels);
> +	} else {
> +		indio_dev->channels =3D ad8460_channels_with_tmp_adc;
> +		indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels_with_tmp_adc);
> +		dev_info(&spi->dev, "Found ADC channel to read TMP pin\n");

That will be apparent anyway once driver is registered, so don't fill the l=
og
with messages like this. dev_dbg() perhaps or drop it entirely.

> +	}
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "refio_1p2v");
> +	if (ret =3D=3D -ENODEV) {
> +		state->refio_1p2v_mv =3D 1200;
> +	} else if (ret < 0) {
> +		return dev_err_probe(&spi->dev, PTR_ERR(vrefio),
> +				     "Failed to get reference voltage\n");
> +	} else {
> +		state->refio_1p2v_mv =3D ret / 1000;
> +	}
> +
> +	if (!in_range(ret, AD8460_MIN_VREFIO_UV, AD8460_MAX_VREFIO_UV))
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				     "Invalid ref voltage range(%u mV) [%u mV, %u mV]\n",
> +				     ret, AD8460_MIN_VREFIO_UV / 1000,

Why print ret rather than state->refio_1p2v_mv?
Having a dev_err_probe() with ret as a later parameter is rather confusing
if nothing else.


> +				     AD8460_MAX_VREFIO_UV / 1000);
> +
> +	ret =3D device_property_read_u32(&spi->dev, "adi,rset-ohms", &state->rs=
et_ohms);
> +	if (ret) {
> +		state->rset_ohms =3D 2000;
> +	} else {
> +		if (!in_range(state->rset_ohms, AD8460_MIN_RSET_OHMS,
> +			      AD8460_MAX_RSET_OHMS))

Might as well combine as

	else if (!...
Then can also drop some brackets as single statements in each leg.


> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					     "Invalid resistor set range(%u) [%u, %u]\n",
> +					     state->rset_ohms,
> +					     AD8460_MIN_RSET_OHMS,
> +					     AD8460_MAX_RSET_OHMS);
> +	}
> +
> +	/* Arm the device by default */
> +	ret =3D device_property_read_u32_array(&spi->dev, "adi,range-microamp",
> +					     tmp, ARRAY_SIZE(tmp));
> +	if (!ret) {
> +		ret =3D regmap_write(state->regmap, AD8460_CTRL_REG(0x08),
> +				   (1 << 7) | AD8460_CURRENT_LIMIT_CONV(tmp[1]));

What is the (1 << 7)? Feels like a magic number that should have a define.

> +		if (ret)
> +			return dev_err_probe(&spi->dev, -EINVAL,
ret not -EINVAL;

> +					     "overcurrent src not valid: %d uA",
> +					     tmp[1]);
> +
> +		ret =3D regmap_write(state->regmap, AD8460_CTRL_REG(0x09),
> +				   (1 << 7) | AD8460_CURRENT_LIMIT_CONV(abs(tmp[0])));
> +		if (ret)
> +			return dev_err_probe(&spi->dev, -EINVAL,

same here and everywhere else where you are eating a potentially more meani=
ngful error
value.

> +					     "overcurrent snk not valid: %d uA",
> +					     tmp[0]);
> +	}
> +
> +	ret =3D device_property_read_u32_array(&spi->dev, "adi,range-microvolt",
> +					     tmp, ARRAY_SIZE(tmp));
> +	if (!ret) {

This is currently documented in the binding as only taking one set of value=
s.
Seems a lot more flexible here.

> +		ret =3D regmap_write(state->regmap, AD8460_CTRL_REG(0x0A),
> +				   (1 << 7) | AD8460_VOLTAGE_LIMIT_CONV(tmp[1]));
> +		if (ret)
> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					     "positive overvoltage not valid: %d uV",
> +					     tmp[1]);
> +
> +		ret =3D regmap_write(state->regmap, AD8460_CTRL_REG(0x0B),
> +				   (1 << 7) | AD8460_VOLTAGE_LIMIT_CONV(abs(tmp[0])));
> +		if (ret)
> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					     "negative overvoltage not valid: %d uV",
> +					     tmp[0]);
> +	}
> +
> +	ret =3D device_property_read_u32(&spi->dev, "adi,temp-max-millicelsius"=
, &temp);
I'd handled as a default of whatever is already in that
register.  Just write temp =3D default; before this call.

That way you just don't check ret for the property query. If it's there the
value in temp will be updated, if not we'll have the default.

Consider similar for the other cases.
It will make it easier to tell from the driver what happens if a property i=
s not
provided.  Also document defaults in the dt binding.

> +	if (!ret) {
> +		ret =3D regmap_write(state->regmap, AD8460_CTRL_REG(0x0C),
> +				   (1 << 7) | AD8460_TEMP_LIMIT_CONV(abs(temp)));
> +		if (ret)
> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					     "overtemperature not valid: %d",
> +					     temp);
> +	}
> +
> +	ret =3D ad8460_reset(state);
> +	if (ret)
> +		return ret;
> +
> +	/* Enables DAC by default */
> +	ret =3D regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),
> +				 AD8460_HVDAC_SLEEP_MSK,
> +				 FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, 0));
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->setup_ops =3D &ad8460_buffer_setup_ops;
> +
> +	ret =3D devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_dev, "tx",
> +						  IIO_BUFFER_DIRECTION_OUT);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get DMA buffer\n");
> +
> +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);

return devm_iio_device_register()

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

