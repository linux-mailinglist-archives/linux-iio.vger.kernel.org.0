Return-Path: <linux-iio+bounces-4968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921D18C3291
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D596CB214A9
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3A418054;
	Sat, 11 May 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDD7E2n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE37F;
	Sat, 11 May 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445860; cv=none; b=IP909ElqADTfUQbQrd/5mHQyy2qOFKUjc+Mb0Ew2yDeYdvit9HhevWA9MTQiROGzZ3X34+za8NHslev45j6/GdOfEth6iUBmSha29XSnk3u4AMbbfS9JJQuILY7s/JjNS9FVSg6zS2rxU19GYBuGvCPirCutTx7WuqWGw6NxV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445860; c=relaxed/simple;
	bh=qDXgVQofl6xyMBerDDNaa7UF3HpCSL+u555/Dv4UeLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tA22q28jnVi6tDJ8LMVzkoENB6Ct7DPPeWluOdmjVHrBZMbrKJSXPmleICyPrNAL4sBUR4kUL/jqxGmEeEVA8OAAxsNwTBQla7enkNWJy3V114g0krh+Ivjt0B5V1xgt3RpB+uuz3bbSZoUBXGe8Ux2CMg+lGCGP7jbE2YkMY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCDD7E2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510D6C2BBFC;
	Sat, 11 May 2024 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715445859;
	bh=qDXgVQofl6xyMBerDDNaa7UF3HpCSL+u555/Dv4UeLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCDD7E2nF1/4zbRd7/4LZ0/4ULct/pvGJ0mxX70v+6WvQEwOw8ytnhaC0WlK8stK8
	 eNtIHzjtyvKnb06cyIvmoeb4DWoLsl8J+LW2rURMFid2GGKFvJ/N+GpUOWm+sZs/7S
	 sBas5UnJP74HDI/YpKqpViDkcCe+9ROfWbkOAzmMi4lr8IJZbfCZaxkwX9hyfzBQCd
	 k0y/Wgdhybndi8WNeqpQidAylgFUM08xjeeb+hTUH94DQuFoPCs9h7AyO/kKpX+0aT
	 YrczQcw18SEP9p/xMwo2k3u9QIYB9y7os00RD0hIrx1p9Gn5IX8SNOcof79//8K7Xa
	 3vOwwr3JNAIXg==
Date: Sat, 11 May 2024 17:44:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240511174405.10d7fce8@jic23-huawei>
In-Reply-To: <20240510064053.278257-3-Mariel.Tinaco@analog.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-3-Mariel.Tinaco@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 May 2024 14:40:53 +0800
Mariel Tinaco <Mariel.Tinaco@analog.com> wrote:

> The AD8460 is a =E2=80=9Cbits in, power out=E2=80=9D high voltage, high-p=
ower,
> highspeed driver optimized for large output current (up to =C2=B11 A)
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

I'd like to see some ABI docs for the debugfs interface.
The device is unusual enough that a general intro document or a lot
more in the series cover letter would be useful.

I'm not sure what the dmaengine usage in here is doing for example?
Driving the parallel bus perhaps?  David was correct that the binding
should reflect that part as well. I was assuming you'd only implemented
the spi part.

How to handle the pattern generator is also an interesting question.
That probably wants a version of the symbol interfaces we use for PSK
and similar.  We did have some DDS drivers a long time back in staging
but they only did a few fixed waveforms so this is breaking new ground.

Having looked a little at the datasheet, we may want to hard code
some limits - or get them from DT. Probably a bit too easy to set things
on fire otherwise.

Also, seems that this is only partly implemented. Please make that
clear in the patch description.  Perhaps this should have been an RFC
with a list of questions?

Jonathan

> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> new file mode 100644
> index 000000000..4049be0f5
> --- /dev/null
> +++ b/drivers/iio/dac/ad8460.c
> @@ -0,0 +1,652 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD8460 Waveform generator DAC Driver
> + *
> + * Copyright (C) 2024 Analog Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dma.h>
> +#include <linux/iio/buffer-dmaengine.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#define AD8460_CTRL_REG(x)                      (x)
> +#define AD8460_HVDAC_DATA_WORD_LOW(x)           (0x60 + (2 * (x)))
> +#define AD8460_HVDAC_DATA_WORD_HIGH(x)          (0x61 + (2 * (x)))
> +
> +#define AD8460_HV_RESET_MSK                     BIT(7)
> +#define AD8460_HV_SLEEP_MSK                     BIT(4)
> +#define AD8460_WAVE_GEN_MODE_MSK                BIT(0)
> +
> +#define AD8460_HVDAC_SLEEP_MSK                  BIT(3)
> +
> +#define AD8460_APG_MODE_ENABLE_MSK              BIT(5)
> +#define AD8460_PATTERN_DEPTH_MSK                GENMASK(3, 0)
> +
> +#define AD8460_SHUTDOWN_FLAG_MSK                BIT(7)
> +#define AD8460_DATA_BYTE_LOW_MSK                GENMASK(7, 0)
> +#define AD8460_DATA_BYTE_HIGH_MSK               GENMASK(5, 0)
> +
> +#define AD8460_NOMINAL_VOLTAGE_SPAN		80
> +#define AD8460_MIN_VREFIO_UV			120000
> +#define AD8460_MAX_VREFIO_UV			1200000
> +#define	AD8460_MIN_RSET_OHMS			2000
> +#define	AD8460_MAX_RSET_OHMS			20000
> +
> +struct ad8460_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	struct clk *sync_clk;
> +	/* lock to protect against multiple access to the device and shared dat=
a */
> +	struct mutex lock;
> +	u32 cache_apg_idx;
> +	u32 rset_ohms;
> +	int vref_mv;
> +};
> +

> +
> +static const char * const ad8460_powerdown_modes[] =3D {
> +	"three_state",
> +};
> +
> +static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan)
> +{
> +	return 0;

Why have the stubs in here?

> +}
> +
> +static int ad8460_set_powerdown_mode(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     unsigned int type)
> +{
> +	return 0;
> +}
> +
> +static int ad8460_get_hvdac_byte(struct ad8460_state *state,

byte? Seems to be getting a 14 bit value.

> +				 int index,
> +				 int *val)
> +{
> +	unsigned int high, low;
> +	int ret;
> +
> +	ret =3D regmap_read(state->regmap, AD8460_HVDAC_DATA_WORD_HIGH(index),
> +			  &high);

Use a bulk read? Then byteswap if necessary and mask the result.

> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
> +			  &low);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D FIELD_GET(AD8460_DATA_BYTE_HIGH_MSK, high) << 8 | low;
> +
> +	return ret;
> +}
> +
> +static int ad8460_set_hvdac_byte(struct ad8460_state *state,
> +				 int index,
> +				 int val)
> +{
> +	int ret;
> +
> +	ret =3D regmap_write(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
> +			   (val & 0xFF));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(state->regmap, AD8460_HVDAC_DATA_WORD_HIGH(index),
> +			    ((val >> 8) & 0xFF));

bulk write? or do these need to be ordered?

> +}
> +
> +static int ad8460_set_sample(struct ad8460_state *state, int val)
> +{
> +	int ret;
> +
> +	ret =3D ad8460_enable_apg_mode(state, 1);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&state->lock);
> +	ret =3D ad8460_set_hvdac_byte(state, 0, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(state->regmap,
> +				  AD8460_CTRL_REG(0x02),
> +				  AD8460_PATTERN_DEPTH_MSK,
> +				  FIELD_PREP(AD8460_PATTERN_DEPTH_MSK, 0));
> +}
> +
> +static int ad8460_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)
> +{
> +	struct ad8460_state *state =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +			return ad8460_set_sample(state, val);
> +		unreachable();
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +static int ad8460_probe(struct spi_device *spi)
> +{
> +	struct ad8460_state *state;
> +	struct iio_dev *indio_dev;
> +	struct regulator *vrefio;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state =3D iio_priv(indio_dev);
> +	mutex_init(&state->lock);
> +
> +	state->spi =3D spi;
> +
> +	state->regmap =3D devm_regmap_init_spi(spi, &ad8460_regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
> +				     "Failed to initialize regmap");
> +
> +	ret =3D devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_dev, "tx",
> +						  IIO_BUFFER_DIRECTION_OUT);

Ah. I take back my binding comment. I assume this is mapping some non stand=
ard
interface for the parallel data flow?

> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get DMA buffer\n");
> +
> +	state->sync_clk =3D devm_clk_get_enabled(&spi->dev, "sync_clk");
> +	if (IS_ERR(state->sync_clk))
> +		return dev_err_probe(&spi->dev, PTR_ERR(state->sync_clk),
> +				     "Failed to get sync clk\n");
> +
> +	vrefio =3D devm_regulator_get_optional(&spi->dev, "vrefio");
> +	if (IS_ERR(vrefio)) {
> +		if (PTR_ERR(vrefio) !=3D -ENODEV)
> +			return dev_err_probe(&spi->dev, PTR_ERR(vrefio),
> +					     "Failed to get vref regulator\n");
> +
> +		state->vref_mv =3D 1200;
> +
> +	} else {
> +		ret =3D regulator_enable(vrefio);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to enable vrefio regulator\n");
> +
> +		ret =3D devm_add_action_or_reset(&spi->dev,
> +					       ad8460_regulator_disable,
> +					       vrefio);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regulator_get_voltage(vrefio);
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to get ref voltage\n");
> +
> +		if (!in_range(ret, AD8460_MIN_VREFIO_UV, AD8460_MAX_VREFIO_UV))
> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					     "Invalid ref voltage range(%u) [%u, %u]\n",
> +					     ret, AD8460_MIN_VREFIO_UV,
> +					     AD8460_MAX_VREFIO_UV);
> +
> +		state->vref_mv =3D ret / 1000;
> +	}
> +
> +	ret =3D device_property_read_u32(&spi->dev, "adi,rset-ohms",
> +				       &state->rset_ohms);
> +	if (!ret) {
> +		if (!in_range(state->rset_ohms, AD8460_MIN_RSET_OHMS,
> +			      AD8460_MAX_RSET_OHMS))
> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					     "Invalid resistor set range(%u) [%u, %u]\n",
> +					     state->rset_ohms,
> +					     AD8460_MIN_RSET_OHMS,
> +					     AD8460_MAX_RSET_OHMS);
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
> +	indio_dev->name =3D "ad8460";
> +	indio_dev->info =3D &ad8460_info;
> +	indio_dev->channels =3D ad8460_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_HARDWARE;
> +	indio_dev->setup_ops =3D &ad8460_buffer_setup_ops;
> +
> +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ad8460_debugfs_init(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ad8460_of_match[] =3D {
> +	{ .compatible =3D "adi, ad8460" },
> +	{ },
No comma on 'null' terminators like this as we don't want to let
people put anything after them.

> +};
> +MODULE_DEVICE_TABLE(of, ad8460_of_match);


