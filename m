Return-Path: <linux-iio+bounces-9302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0D97034B
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 19:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E2F1F224C5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970316191E;
	Sat,  7 Sep 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsokSaVz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243115D5BB;
	Sat,  7 Sep 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725729313; cv=none; b=jLU+v1P/DvNt8EHueRyKEgkfL8cDqdV0pplSYNl72Hz5JLHsOMP4RZ6tMa5PAup78HH8GBmgUh7NWmrTjElKvxjIln/zPL3w8TXz6bdmEFWj3pRdTK1o2dXZnXD5apL3JhtrtKQe5RrfQwPSSfqXFjlHLIWRfxFo+jxI6SItV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725729313; c=relaxed/simple;
	bh=tcjsLNQyJNWKbgceFHvvMiUd+8SAPr95G7SirxnFvyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVRQdOGU/fWf1ovS94zwx8Bw8k5xzAlPwZrVEM4y/2nhXSCcCMjHRQB2lh9R4OAnUngIvRNCNNvUciAeYMTTDTRQClf2PTzG6a1pNSSErEBlTuIsBEGM27pZhz6U7FQchlia3tebnI7krhfCw5ht6+KKUrwqOf61RTVhRtn30Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsokSaVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F83C4CEC2;
	Sat,  7 Sep 2024 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725729312;
	bh=tcjsLNQyJNWKbgceFHvvMiUd+8SAPr95G7SirxnFvyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HsokSaVzpFt5vwQ3cyd0lZcxahqzecC6z/NlNokz3ietSnA5+TVLJNJll+GWhjWyy
	 EsDG1R21gwh9vWLWu0rHEx6daVbYWvNP+qDhZzLo2eba8tjMep9/pxPjb7bVk7Bz5s
	 Zi0lEPyu79aueh6A7d8KR9SgxFVjkBb0tUohhf6CttPRKuvFNcNxarhdPMHIiX2UkL
	 AlwDfUdLX0I9nPpqXztUliu8ZmJl8KLrosblAb6AV06Z+VTknehqzsSkH2ypY6jDQM
	 q5VAdQE0KLQ7tyUWprB2/31s72/Zp0DZfTn34s/dKOrsLc+6Q67LK/z28IPrzWQdEf
	 kRwi12gy5iNdA==
Date: Sat, 7 Sep 2024 18:14:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240907181449.1453bd41@jic23-huawei>
In-Reply-To: <20240904023040.23352-3-Mariel.Tinaco@analog.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
	<20240904023040.23352-3-Mariel.Tinaco@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Sep 2024 10:30:40 +0800
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
A few comments inline.

Jonathan


>  obj-$(CONFIG_ADI_AXI_DAC) +=3D adi-axi-dac.o
> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> new file mode 100644
> index 000000000000..6428bfaf0bd7
> --- /dev/null
> +++ b/drivers/iio/dac/ad8460.c
> @@ -0,0 +1,932 @@
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
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>

Given there are lots of IIO specific includes, probably a case
where pulling them out as a separate block after the main
includes makes sense.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
>
...


> +
> +	state =3D iio_priv(indio_dev);
> +	mutex_init(&state->lock);

Trivial but there is no a devm_mutex_init() that deals with the obscure
debug case where mutex uninit makes sense. Might as well use it here.

> +
> +	indio_dev->name =3D "ad8460";
> +	indio_dev->info =3D &ad8460_info;
> +
> +	state->spi =3D spi;
> +	dev =3D &spi->dev;
> +
> +	state->regmap =3D devm_regmap_init_spi(spi, &ad8460_regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(dev, PTR_ERR(state->regmap),
> +				     "Failed to initialize regmap");
> +
> +	state->sync_clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(state->sync_clk))
> +		return dev_err_probe(dev, PTR_ERR(state->sync_clk),
> +				     "Failed to get sync clk\n");
> +
> +	state->tmp_adc_channel =3D devm_iio_channel_get(dev, "ad8460-tmp");
> +	if (IS_ERR_OR_NULL(state->tmp_adc_channel)) {
> +		indio_dev->channels =3D ad8460_channels;
> +		indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels);
> +	} else {
> +		indio_dev->channels =3D ad8460_channels_with_tmp_adc;
> +		indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels_with_tmp_adc);
> +	}
> +
Add and enable the various other supplies. They are probably always
on in which case the regulator framework will work it's magic to avoid
use having to care that they aren't in the dts.

> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "refio_1p2v");
> +	if (ret =3D=3D -ENODEV)
> +		state->refio_1p2v_mv =3D 1200;
> +	else if (ret >=3D 0)
> +		state->refio_1p2v_mv =3D ret / 1000;
> +	else
> +		return dev_err_probe(dev, ret, "Failed to get reference voltage\n");
> +
...

> +	ret =3D device_property_read_u32_array(dev, "adi,range-microamp",
> +					     tmp, ARRAY_SIZE(tmp));
> +	if (!ret) {
> +		if (in_range(tmp[1], 0, AD8460_ABS_MAX_OVERCURRENT_UA))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x08),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_CURRENT_LIMIT_CONV(tmp[1]));

Your binding has a fixed set of values.  Yet this is anything in range.
Which is correct?  Based on datasheet I think it is flexible but
that you have listed the example values instead of the limits.


> +
> +		if (in_range(tmp[0], -AD8460_ABS_MAX_OVERCURRENT_UA, 0))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x09),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_CURRENT_LIMIT_CONV(abs(tmp[0])));
> +	}
> +
> +	ret =3D device_property_read_u32_array(dev, "adi,range-microvolt",
> +					     tmp, ARRAY_SIZE(tmp));
> +	if (!ret) {
> +		if (in_range(tmp[1], 0, AD8460_ABS_MAX_OVERVOLTAGE_UV))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x0A),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_VOLTAGE_LIMIT_CONV(tmp[1]));
> +
> +		if (in_range(tmp[0], -AD8460_ABS_MAX_OVERVOLTAGE_UV, 0))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x0B),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_VOLTAGE_LIMIT_CONV(abs(tmp[0])));
> +	}
> +
> +	ret =3D device_property_read_u32(dev, "adi,max-millicelsius", &temp);
> +	if (!ret) {
> +		if (in_range(temp, AD8460_MIN_OVERTEMPERATURE_MC,
> +			     AD8460_MAX_OVERTEMPERATURE_MC))
> +			regmap_write(state->regmap, AD8460_CTRL_REG(0x0C),
> +				     FIELD_PREP(AD8460_FAULT_ARM_MSK, 1) |
> +				     AD8460_TEMP_LIMIT_CONV(abs(temp)));
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
> +	ret =3D devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, "tx",
> +						  IIO_BUFFER_DIRECTION_OUT);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get DMA buffer\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

