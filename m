Return-Path: <linux-iio+bounces-20644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B6AD9CB6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07290172E7F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE8F2C15AC;
	Sat, 14 Jun 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDNbfp2Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F222F774;
	Sat, 14 Jun 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749904441; cv=none; b=mFJMuujk+ms/Q2QtILhVcGkKA+x2oMXoblAv26deDqi88fJIcjXXfxpOfMJnn+CiUNY+wA7olo4FXt3uHMzlh7yPtCS8g56EWY8oym1OI/bG1EK+tVuMI99dBDgqB5xSBsalXBhe0JPm6xQ558OLYzBwKEzMkTw6J7ocIgLH8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749904441; c=relaxed/simple;
	bh=V/hhGxDiuKJtoDq8go0oysqODmgNazHNjVE/A1L/JQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1J7Ic9HcxpFnD4QCwycCfZznPhVNw3Bp/wIva5/nFyW6jJR22JA0tGdm+ZDND3mZAKjbmiulECJngD69Q7o9foxAeyg+5HAsLEyE4hWLEToIcinPMWkTUv9P1OHmMPCCAA/N9hdDcFURiz09TwCjZEyrnrBIJoPGDkf0TORho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDNbfp2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2FAC4CEEB;
	Sat, 14 Jun 2025 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749904440;
	bh=V/hhGxDiuKJtoDq8go0oysqODmgNazHNjVE/A1L/JQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oDNbfp2Z453ar8cK7g8nF+OhDGvrDvZzFQ7JKYfS+NZfgKzFd1FglaWwkh/zZN3yE
	 MN/qYWwIUT8hYpIyyyMUPONwtqjkQW4P2tYDeCgDU0wp4ybclhjs1DBId6drGadp9P
	 Zv92/rp4znlqOjlwQ23uqSN2baulcDlZartEYZgI6EX9Pb34GVTP3AawuOPMw8Tp86
	 5hLrT7ZiJ3nWL/g56igqBfQxb3TDwQFBQD/bUG+7+XW79tMqafd7bOBh0pxTg9fdO3
	 IMELkVJablSrKZVSdny13t1vf8iZY4D1ZhjOVn2gxbBbIbqvj+uZnsoqdLJ4zDVyvP
	 Y552g7HhHiObA==
Date: Sat, 14 Jun 2025 13:33:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: surajsonawane0215@gmail.com
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: chemical: Add driver for Sharp GP2Y1010AU0F
Message-ID: <20250614133352.18cec415@jic23-huawei>
In-Reply-To: <20250612100758.13241-4-surajsonawane0215@gmail.com>
References: <20250612100758.13241-1-surajsonawane0215@gmail.com>
	<20250612100758.13241-4-surajsonawane0215@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jun 2025 15:37:46 +0530
surajsonawane0215@gmail.com wrote:

> From: Suraj Sonawane <surajsonawane0215@gmail.com>
>=20
> Implement support for the Sharp GP2Y1010AU0F optical dust sensor which
> measures particulate matter concentration using infrared scattering.
> The sensor requires precise 320=CE=BCs LED pulses with ADC sampling at 28=
0=CE=BCs
> after LED activation (as specified in datasheet section 6-1).
>=20
> The driver provides:
> - Raw density readings via IIO_DENSITY channel type
> - Hardware-agnostic operation via GPIO and IIO ADC interfaces
> - Power management through regulator framework
> - Device Tree binding support
>=20
> Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet=
/gp2y1010au_appl_e.pdf
>=20
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
A few additional comments from me.

Jonathan

>  obj-$(CONFIG_PMS7003) +=3D pms7003.o
> diff --git a/drivers/iio/chemical/gp2y1010.c b/drivers/iio/chemical/gp2y1=
010.c
> new file mode 100644
> index 000000000..3a8657035
> --- /dev/null
> +++ b/drivers/iio/chemical/gp2y1010.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Suraj Sonawane <surajsonawane0215@gmail.com>
> + * Sharp GP2Y1010AU0F Dust Sensor Driver
> + * Datasheet: https://global.sharp/products/device/lineup/data/pdf/datas=
heet/gp2y1010au_appl_e.pdf
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* Timings based on GP2Y1010AU0F datasheet Section 6-1 */
> +#define GP2Y1010_LED_PULSE_US     320  /* Total LED ON time (0.32 ms) */
> +#define GP2Y1010_SAMPLE_DELAY_US  280  /* ADC sampling after LED ON (0.2=
8 ms) */
> +
> +struct gp2y1010_data {
> +	struct gpio_desc *led_gpio;
> +	struct iio_channel *adc_chan;
> +	int v_clean;  /* Calibration: voltage in clean air (mV) */
> +};
> +
> +static int gp2y1010_read_raw(struct iio_dev *indio_dev,
> +							 struct iio_chan_spec const *chan,
> +							 int *val, int *val2, long mask)

Odd alignment. Aim for under the s of struct. That is immediately after the=
 bracket.

> +{
> +	struct gp2y1010_data *data =3D iio_priv(indio_dev);
> +	int ret, voltage_mv;
> +
> +	if (mask !=3D IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	gpiod_set_value(data->led_gpio, 1);
> +	udelay(GP2Y1010_SAMPLE_DELAY_US);
> +
> +	ret =3D iio_read_channel_processed(data->adc_chan, &voltage_mv);
> +
> +	/* Wait remaining time to complete 320 =C2=B5s total LED pulse width */
> +	udelay(GP2Y1010_LED_PULSE_US - GP2Y1010_SAMPLE_DELAY_US);
> +	gpiod_set_value(data->led_gpio, 0);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D voltage_mv;
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info gp2y1010_info =3D {
> +	.read_raw =3D gp2y1010_read_raw,
> +};
> +
> +static const struct iio_chan_spec gp2y1010_channels[] =3D {
> +	{
> +		.type =3D IIO_DENSITY,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +	},

Where there is only one channel, no need to bother with an array.
There are lots of drivers that do this, but I'm trying to discourage it
in new drivers.
indio_dev->channels =3D &gp271010_channel;
indio_dev->num_channels =3D 1;

is obvious enough.

> +};
> +
> +static int gp2y1010_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct gp2y1010_data *data;
> +	enum iio_chan_type ch_type;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->v_clean =3D 900;
> +
> +	data->led_gpio =3D devm_gpiod_get(dev, "led", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->led_gpio))
> +		return dev_err_probe(dev, PTR_ERR(data->led_gpio), "Failed to get LED =
GPIO\n");
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return ret;
> +	udelay(100);
> +
> +	data->adc_chan =3D devm_iio_channel_get(dev, "dust");
> +	if (IS_ERR(data->adc_chan))
> +		return dev_err_probe(dev, PTR_ERR(data->adc_chan), "Failed to get ADC =
channel\n");
> +
> +	ret =3D iio_get_channel_type(data->adc_chan, &ch_type);
> +	if (ret < 0)
> +		return ret;
> +	if (ch_type !=3D IIO_DENSITY)
> +		return dev_err_probe(dev, -EINVAL, "ADC channel is not density type\n"=
);

I'm confused.  The ADC channel type providing us a measurement service (as =
here we
are the consumer) is going to be voltage (or maybe current) because ADCs do=
n't measure dust.
This driver has to do the conversion from voltage to the value needed to re=
port a density channel.=20

> +
> +	indio_dev->name =3D dev_name(dev);

Hard code the part number here rather than getting it from elsewhere.  That=
 makes
it much easier to see that this is what we expect.

> +	indio_dev->info =3D &gp2y1010_info;
> +	indio_dev->channels =3D gp2y1010_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(gp2y1010_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

