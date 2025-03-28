Return-Path: <linux-iio+bounces-17309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB1A74648
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C517C299
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B81B213236;
	Fri, 28 Mar 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC6ZcM8b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336D20E003;
	Fri, 28 Mar 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153794; cv=none; b=HSJdP9vdCMTFk3j5BL+GZSPZHItSMyIjYTxtmyLGzr598i8W1BILsvDcZmk7vOHaPSW99at2O4hHI4iQx6VpQhMzIykzYlw7ItJ1JgIqzUCv4XEyNXjjOK5ieCjmbf+MaL7WSDquxGbxEcRsTyerTcCGazZGvzXEyinTE93DeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153794; c=relaxed/simple;
	bh=LeC6GnMHRce9csG+fUQ22GMdxqev7xAiaq5XmBEu2tM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNazjhvf3igevcKsrUgI219LB9VTbIArHWZ+xxG+Kn8OhKqN/FJTwNqRg8fsLs1FThDn7kJ5S5b93Hv7WgCtTQIrRPJKEIgGXRJqvsX4YyDoSu7K4rYw4lIJiXModAhAgygqkiK6D4pGNjWkAELZKui3olCW8GaiaiRmztJO5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC6ZcM8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07B6C4CEE4;
	Fri, 28 Mar 2025 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743153793;
	bh=LeC6GnMHRce9csG+fUQ22GMdxqev7xAiaq5XmBEu2tM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SC6ZcM8bg51KCqPk2qfvfT4MO1XNm3bYNC2lMVFZ+WXIwXbQMGW1I2VLo8IJNVMJ0
	 YVyBP1CBRson+DA4J3curLkwp/D+pFg4ohnCZzes9NWrdBEVwqMzq1OUNDSlvjZbpw
	 beQlCeroTiGy6uujKcsFBLYKXcsxSRYdMAtQ9UmdmOBKokDGbtMuIsXRHSJlOHSJ6c
	 1aqcEl5xZwH4RzDo3N9dT4fAAJqNbLgAP+6i4zlcJo1Zpn2b4pEGqafiGkIhD/jHv0
	 3ZzQ+UYr5n5FMsOlJJiOCdn1mlsATGxfAQwbTuEjZkYTNlI7iCSaGFVsWNu/5p9l9T
	 rTRuWhL6dWOtA==
Date: Fri, 28 Mar 2025 09:23:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <20250328092305.6b51e395@jic23-huawei>
In-Reply-To: <20250324-togreg-v2-4-f211d781923e@analog.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
	<20250324-togreg-v2-4-f211d781923e@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025 19:22:58 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD3530R/AD3530 is an 8-Channel, 16-Bit Voltage Output DAC, while the
> AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC. These devices
> include software-programmable gain controls that provide full-scale
> output spans of 2.5V or 5V for reference voltages of 2.5V. They operate
> from a single supply voltage range of 2.7V to 5.5V and are guaranteed to
> be monotonic by design. Additionally, these devices features a 2.5V,
> 5ppm/=C2=B0C internal reference, which is disabled by default.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

This is a bit of an 'experiment' in reviewing after a red eye flight
so it may be even less coherent than I normally am!

> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c

> +
> +struct ad3530r_state {
> +	struct spi_device *spi;

As below. This seems unnecessary.

> +	struct regmap *regmap;
> +	struct mutex lock; /* protect the state of the device */

Be more specific on that comment.  What state needs protecting
beyond the bus locking that also goes on?  Typically look
for sequences that need to be atomic and say what data causes
that to be the problem here.

> +	struct ad3530r_chan chan[AD3530R_MAX_CHANNELS];
> +	const struct ad3530r_chip_info *chip_info;
> +	struct gpio_desc *ldac_gpio;
> +	int vref_mv;
> +	u8 ldac;
> +	bool range_multiplier;
> +};

> +
> +static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
> +{
> +	gpiod_set_value_cansleep(ldac_gpio, 0);
> +	usleep_range(AD3530R_LDAC_PULSE_US, AD3530R_LDAC_PULSE_US + 10);

fsleep()  unless this window is there for some reason I'm not seeing.

Maybe just usleep() is more appropriate.

> +	gpiod_set_value_cansleep(ldac_gpio, 1);
> +
> +	return 0;
> +}

> +static int ad3530r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +	__be16 reg_val;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D regmap_bulk_read(st->regmap,
> +				       st->chip_info->input_ch_reg(chan->channel),
> +				       &reg_val, 2);

sizeof(regval) instead of that 2.

> +		if (ret)
> +			return ret;
> +
> +		*val =3D FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(reg_val));
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->vref_mv;
> +		*val2 =3D 16;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 0;

Don't report an offset at all if it is always zero.  That is the default
when it is not reported.

> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
>

> +
> +#define AD3530R_CHAN_EXT_INFO(_name, _what, _read, _write) {		\
> +	.name =3D (_name),						\
> +	.read =3D (_read),						\
> +	.write =3D (_write),						\
> +	.private =3D (_what),						\
> +	.shared =3D IIO_SEPARATE,						\
> +}

Don't define a macro for filling these in unless you need it lots of times.
Just put the full initialisation inline.

> +
> +static const struct iio_chan_spec_ext_info ad3530r_ext_info[] =3D {
> +	AD3530R_CHAN_EXT_INFO("powerdown", 0, ad3530r_get_dac_powerdown,
> +			      ad3530r_set_dac_powerdown),
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3530r_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			   &ad3530r_powerdown_mode_enum),
> +	IIO_ENUM("muxout_select", IIO_SHARED_BY_ALL, &ad3530r_muxout_select_enu=
m),

For the muxout stuff see comments on the ABI docs patch.

> +	IIO_ENUM_AVAILABLE("muxout_select", IIO_SHARED_BY_ALL,
> +			   &ad3530r_muxout_select_enum),
> +	{ },
> +};
> +
> +#define AD3530R_CHAN(_chan) {						\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D _chan,						\
> +	.output =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.ext_info =3D ad3530r_ext_info,					\
> +}

...

> +
> +static int ad3530r_setup(struct ad3530r_state *st)
> +{
> +	const struct ad3530r_chip_info *chip_info =3D st->chip_info;
> +	struct device *dev =3D &st->spi->dev;

st->spi is only ever used to get the dev.  You can get that=20
from the regmap instead.  If that looks too messy for some reason then
you could also just store dev in st.

> +	struct gpio_desc *reset_gpio;
> +	int i, ret;
> +
> +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				     "Failed to get reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		/* Perform hardware reset */
> +		usleep_range(20, 25);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		/* Perform software reset */
> +		ret =3D regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
> +					 AD3530R_SW_RESET, AD3530R_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	usleep_range(10000, 15000);

fsleep() preferred.

> +
> +	/* Set operating mode to normal operation. */
> +	ret =3D regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0, 0);
> +	if (ret)
> +		return ret;

...

> +static int ad3530r_probe(struct spi_device *spi)
> +{
> +	static const char * const regulators[] =3D { "vdd", "iovdd" };
> +	const struct ad3530r_chip_info *chip_info;
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad3530r_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +
> +	st->regmap =3D devm_regmap_init_spi(spi, &ad3530r_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to init regmap");
> +
> +	mutex_init(&st->lock);
For new drivers, I'd prefer we use=20
	ret =3D devm_mutex_init(&st->lock);
	if (ret)
		return ret;

It only brings a small benefit in debug cases but still nice to have
given we can now do it without explicit mutex_destroy() calls.

> +
> +	chip_info =3D spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -ENODEV;
> +
> +	st->chip_info =3D chip_info;
> +
> +	ret =3D ad3530r_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					     regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return ret;
> +
> +	if (ret > 0) {

This is going to do something odd if the voltage returned is 0.=20
I'd just have ret >=3D 0 for this case.  We'll never see it in a real syste=
m, but
nice to have anyway.

> +		st->vref_mv =3D st->range_multiplier ? 2 * ret / 1000 : ret / 1000;
> +	} else {
> +		/* Internal reference. */
> +		ret =3D regmap_update_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
> +					 AD3530R_REFERENCE_CONTROL_MASK,
> +					 FIELD_PREP(AD3530R_REFERENCE_CONTROL_MASK, 1));
> +		if (ret)
> +			return ret;
> +
> +		st->vref_mv =3D st->range_multiplier ?
> +			      2 * AD3530R_INTERNAL_VREF_MV :
> +			      AD3530R_INTERNAL_VREF_MV;
> +	}

Jonathan

