Return-Path: <linux-iio+bounces-9585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5419792A5
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 19:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940911F229C8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC5A1D1305;
	Sat, 14 Sep 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRmiCdyc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C01CFEC1;
	Sat, 14 Sep 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726334316; cv=none; b=bvZZzcHARp5w9tlUlelaHAmlyxyLrOAxiHg8jkFVjTWb+vodwBZmS/9Cvp7LQATWHSHvxeL1Q4rlbNL9DKoVLnk96VQAJxskwRo7ySUwT95NhDGeOu3njNTsmqYpsTcANB9KrnE5GKY58gR/Cp4c6nLF83LZuKpHTxXZsoEd0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726334316; c=relaxed/simple;
	bh=xg6hK/fXzG2UUmxxWKEk6Ei3QeIfxPrF8uCj/a0xQJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTeIndGE4EZLbVjahmT8vQPD9JKcoZEfrfRiF3HwJJg1z2pBUvTtyhdGrQ0lv6mg6eZQz1L0Ujzt/imnzXS4UMPSewFYTl0NYwY9352f/GbQvkhUipiSKIp7wyH4dN5cXZyqXvILRGtqO9bjxxA+JwD0AgSxxBcUI+a72+oQb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRmiCdyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D180C4CEC0;
	Sat, 14 Sep 2024 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726334315;
	bh=xg6hK/fXzG2UUmxxWKEk6Ei3QeIfxPrF8uCj/a0xQJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qRmiCdyckqkGcjjjBMO0g8Eq7wAYr+oDt/A6VL8zgxEng59RocuRRPG5qfJ0LcrWY
	 /xgkW/GfgfJr0LU5YByThbW+AReCPHvCQKv1s4tstsFbz7FyDrVe1oAerbkrXn1YHu
	 0el/PZGKZTmVAbb1wrhwcwCqvL7f3AVWGo7phx1SMIcQYHMApYLC3skyBvSd9DF3X6
	 x02iM9gsaI0ANHQ9JvaaHUpYga74b7otn/4yuPsEBeGOFAAfFUnupluef4TVRnpqI7
	 5w17EI46CyqbDLtIF4dZHMQoNscjPAMAx+9NUs8KcFHWC3z06vKaZwO8nvkyWh+uQ0
	 Sspm74lpxy2PA==
Date: Sat, 14 Sep 2024 18:18:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240914181827.2c0a9578@jic23-huawei>
In-Reply-To: <20240912095435.18639-3-Mariel.Tinaco@analog.com>
References: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
	<20240912095435.18639-3-Mariel.Tinaco@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Sep 2024 17:54:35 +0800
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
Hi Mariel

A few minor comments from me.  I'd like it to sit on the list a while
longer, but if there is nothing else I can make minor tweaks whilst
applying.

Jonathan

> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> new file mode 100644
> index 000000000000..9ce3a0f288ba
> --- /dev/null
> +++ b/drivers/iio/dac/ad8460.c
> @@ -0,0 +1,947 @@


> +static struct iio_chan_spec_ext_info ad8460_ext_info[] =3D {
> +	AD8460_CHAN_EXT_INFO("raw0", 0, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw1", 1, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw2", 2, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw3", 3, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw4", 4, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw5", 5, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw6", 6, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw7", 7, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw8", 8, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw9", 9, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw10", 10, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw11", 11, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw12", 12, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw13", 13, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw14", 14, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("raw15", 15, ad8460_dac_input_read,
> +			     ad8460_dac_input_write),
> +	AD8460_CHAN_EXT_INFO("toggle_en", 0, ad8460_read_toggle_en,
> +			     ad8460_write_toggle_en),
> +	AD8460_CHAN_EXT_INFO("symbol", 0, ad8460_read_symbol,
> +			     ad8460_write_symbol),
> +	AD8460_CHAN_EXT_INFO("powerdown", 0, ad8460_read_powerdown,
> +			     ad8460_write_powerdown),
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad8460_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			   &ad8460_powerdown_mode_enum),
> +	{}
	{ }
is my style preference.  Mostly I want consistency and happened to pick this
for IIO.

> +};

> +#define AD8460_TEMP_CHAN {					\
> +	.type =3D IIO_TEMP,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +	.output =3D 1,						\

An output temperature channel?  That's a heater which seems unlikely
on this device.

> +	.indexed =3D 1,						\
> +	.channel =3D 0,						\
> +	.scan_index =3D -1,					\
> +	.event_spec =3D ad8460_events,				\
> +	.num_event_specs =3D 1,					\
> +}

> +static int ad8460_probe(struct spi_device *spi)
> +{
> +	struct ad8460_state *state;
> +	struct iio_dev *indio_dev;
> +	struct device *dev;
> +	u32 tmp[2], temp;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state =3D iio_priv(indio_dev);
> +
> +	indio_dev->name =3D "ad8460";
> +	indio_dev->info =3D &ad8460_info;
> +
> +	state->spi =3D spi;
> +	dev =3D &spi->dev;
Might as well do this one where you declare above.
	struct device *dev =3D &spi->dev;

> +
> +	state->regmap =3D devm_regmap_init_spi(spi, &ad8460_regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(dev, PTR_ERR(state->regmap),
> +				     "Failed to initialize regmap");
> +
> +	devm_mutex_init(dev, &state->lock);

Check return value.  devm registration can potentially fail.

...

> +
> +	/* Enables DAC by default */
> +	ret =3D regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),
> +				 AD8460_HVDAC_SLEEP_MSK,
> +				 FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, 0));

regmap_clear_bits() perhaps.

> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->setup_ops =3D &ad8460_buffer_setup_ops;
> +
> +	ret =3D devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, "tx",
> +						  IIO_BUFFER_DIRECTION_OUT);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get DMA buffer\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

