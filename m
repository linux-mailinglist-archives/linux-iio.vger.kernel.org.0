Return-Path: <linux-iio+bounces-19070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5580AA8902
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 20:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032293B7DF3
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B651D9A41;
	Sun,  4 May 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiZROIiz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66FA32;
	Sun,  4 May 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746384037; cv=none; b=HNAJ2eCAEtE/PB04Q93CmsHmC/y/j39D1joWc37DtSA0ba9AMFiogzfj//klrqMMHQOa5mYrzsWQCwSEX6PFNCktqUjDctX1LwG6VZM+rYvQ2IDQMzL12jEGkGf307YJhAzSb9/LFdWXNqnppPDcZx5BLyCI2El0vufCsNr22mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746384037; c=relaxed/simple;
	bh=Seioen4hZGFUwedgCHaEoeWWRh1MD0ol2ItWiQfG+xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOz1A1Bf7ubNGHkW0P0f4H5Yfhrx5Q+PI9TzOl2F8uPr6XvvKHLkWs0/v1q6gcTMl/1oa/dNb2GYkC1lC15sHOSRT7nKHE1W+w2bFpZfIYTuTcqALY4umtNBgP0XQdfJb38dB2CCCCx6A9DYD87ZHoAkvCRrtjkvA3dhqo5STiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiZROIiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE069C4CEE7;
	Sun,  4 May 2025 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746384037;
	bh=Seioen4hZGFUwedgCHaEoeWWRh1MD0ol2ItWiQfG+xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NiZROIizVe3sCQCXhixpf7QbdLfO47IM0H42fnbIvT/DnN7fkTsAY1drregfkJFwY
	 TgM5+YIPESgK2Fmk+zFdMWJcdVubGkqoyXtUjrf3FrTC/zBMg71PnLvbw6drhPxGQ5
	 7Ezbb6M3whWN20ZYq57PpLJ/G9A2lZBuQ2yuH9C840Xpd8saTm15oY4PJ/dd+v77Fg
	 OP/S/CokPFrDXsAaqmUac0MrOrJqJCIA4T2WnQSEiCbv6Hr2jS4Y9cYcB19c+gVxJz
	 7bpw9KTAYsTp4/I4pApCBS+yGD4fUEC0I35upMbJjKjkK8ozoommNYG6nEwIdmhTqD
	 OAU3QwuGTmT1w==
Date: Sun, 4 May 2025 19:40:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?VMOzdGggSsOhbm9z?= via B4 Relay
 <devnull+gomba007.gmail.com@kernel.org>
Cc: gomba007@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: Add driver for SEN0322
Message-ID: <20250504194030.4efe60db@jic23-huawei>
In-Reply-To: <20250428-iio-chemical-sen0322-v1-2-9b18363ffe42@gmail.com>
References: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
	<20250428-iio-chemical-sen0322-v1-2-9b18363ffe42@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 12:50:14 +0200
T=C3=B3th J=C3=A1nos via B4 Relay <devnull+gomba007.gmail.com@kernel.org> w=
rote:

> From: T=C3=B3th J=C3=A1nos <gomba007@gmail.com>
>=20
> Add support for the DFRobot SEN0322 oxygen sensor.
>=20
> Datasheet:
> 	https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322
>=20
> To instantiate (assuming device is connected to I2C-2):
> 	echo 'sen0322 0x73' > /sys/class/i2c-dev/i2c-2/device/new_device
>=20
> To read the oxygen concentration (assuming device is iio:device0):
> 	cat /sys/bus/iio/devices/iio:device0/in_concentration_input
>=20
> Signed-off-by: T=C3=B3th J=C3=A1nos <gomba007@gmail.com>

Hi T=C3=B3th

Nice little driver.  Main questions are around the userspace ABI and why
we have both _RAW and _PROCESSED reported. There are few reasons we
let drivers do that and I don't see what reason applies here.

Mostly it just confuses userspace by providing multiple ways to read the
same thing.

Jonathan

> diff --git a/drivers/iio/chemical/sen0322.c b/drivers/iio/chemical/sen032=
2.c
> new file mode 100644
> index 000000000000..5f1f4528401e
> --- /dev/null
> +++ b/drivers/iio/chemical/sen0322.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the DFRobot SEN0322 oxygen sensor.
> + *
> + * Datasheet:
> + *	https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322
> + *
> + * Possible I2C slave addresses:
> + *	0x70
> + *	0x71
> + *	0x72
> + *	0x73
> + *
> + * Copyright (C) 2025 T=C3=B3th J=C3=A1nos <gomba007@gmail.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define DRIVER_NAME "sen0322"
> +
> +#define SEN0322_REG_DATA	0x03
> +#define SEN0322_REG_COEFF	0x0A
> +
> +#define FIXED_FRAC_BITS		18
> +#define FIXED_INT(x)		((fixed_t)((x) << FIXED_FRAC_BITS))
> +
> +typedef u32 fixed_t;
> +
> +struct sen0322 {
> +	struct i2c_client	*client;
What do you need client for after probe?

There is a function to get the struct device from the regmap.

> +	struct regmap		*regmap;
> +	fixed_t			coeff;
> +};
> +
> +static fixed_t fixed_mul(fixed_t a, fixed_t b)
> +{
> +	u64 tmp;
> +
> +	tmp =3D (u64)a * (u64)b;
> +	tmp =3D (tmp >> FIXED_FRAC_BITS) + ((tmp >> FIXED_FRAC_BITS) & 1);

These need some comments.  It's moderately fiddly fixed point maths
and there are many ways to do that.

> +
> +	if (tmp > U32_MAX)
> +		return (fixed_t)U32_MAX;
> +	else
> +		return (fixed_t)tmp;
> +}
> +
> +static fixed_t fixed_div(fixed_t a, fixed_t b)
> +{
> +	u64 tmp;
> +
> +	tmp =3D (uint64_t)a << FIXED_FRAC_BITS;
> +	tmp +=3D (b >> 1);
> +
> +	return (fixed_t)(div_u64(tmp, b));
> +}
> +
> +static int sen0322_read_coeff(struct sen0322 *sen0322)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(sen0322->regmap, SEN0322_REG_COEFF, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val)
> +		sen0322->coeff =3D fixed_div(FIXED_INT(val), FIXED_INT(1000));
> +	else
> +		sen0322->coeff =3D fixed_div(FIXED_INT(209), FIXED_INT(1200));

This second one is just a number. Why not just put the constant here?

> +
> +	dev_dbg(&sen0322->client->dev, "coeff: %08X\n", sen0322->coeff);
> +
> +	return 0;
> +}
> +
> +static int sen0322_read_data(struct sen0322 *sen0322)
> +{
> +	u8 data[4] =3D { 0 };
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(sen0322->regmap, SEN0322_REG_DATA, data, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D data[0] * 100 +  data[1] * 10 + data[2];
> +
> +	dev_dbg(&sen0322->client->dev, "raw data: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int sen0322_read_prep_data(struct sen0322 *sen0322)
> +{
> +	fixed_t val;
> +	int ret;
> +
> +	if (!sen0322->coeff) {
> +		ret =3D sen0322_read_coeff(sen0322);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret =3D sen0322_read_data(sen0322);
> +	if (ret < 0)
> +		return ret;
> +
> +	val =3D fixed_mul(sen0322->coeff, FIXED_INT(ret));
Superficially looks like you could compute a correct _SCALE and
make this maths a userspace problem?

> +
> +	dev_dbg(&sen0322->client->dev, "prep data: %08X\n", val);
> +
> +	return val >> FIXED_FRAC_BITS;
> +}
> +
> +static int sen0322_read_raw(struct iio_dev *iio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct sen0322 *sen0322 =3D iio_priv(iio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_CONCENTRATION:

You need a strong reason to provide both _RAW and _PROCESSED.
What was your thinking here?=20

As a general rule, if the conversion is linear, then we provide
_RAW and _SCALE. If it's non linear then _PROCESSED.

The _RAW + _SCALE thing is for 2 reasons.
1 - userspace is better at maths as it has floating point easily
    available.
2 - if we ever add buffered capture then _RAW tends to be of a defined
    number of bits whereas processed is more complex.

> +			ret =3D sen0322_read_data(sen0322);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val =3D ret;
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_CONCENTRATION:
> +			ret =3D sen0322_read_prep_data(sen0322);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val =3D ret;
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_CONCENTRATION:
> +			*val =3D 1;
> +			*val2 =3D 100;

Given above you use the coeff in the calculation of processed
I don't understand what this scale is indicating.
Scale only applies to _RAW channels.

> +			return IIO_VAL_FRACTIONAL;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static const struct iio_chan_spec sen0322_channels[] =3D {
> +	{
> +		.type =3D IIO_CONCENTRATION,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
This doesn't need to be an array. Can just use one structure
and pass the address plus an explicit 1 for the number of channels
below.   Quite a few drivers do it like this though and I don't mind
much.

> +
> +static int sen0322_probe(struct i2c_client *client)
> +{
> +	struct sen0322 *sen0322;
> +	struct iio_dev *iio_dev;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -ENODEV;
> +
> +	iio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*sen0322));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	sen0322 =3D iio_priv(iio_dev);
> +	sen0322->client =3D client;
> +	sen0322->coeff =3D 0;
> +
> +	sen0322->regmap =3D devm_regmap_init_i2c(client, &sen0322_regmap_conf);
> +	if (IS_ERR(sen0322->regmap))
> +		return PTR_ERR(sen0322->regmap);
> +
> +	i2c_set_clientdata(client, sen0322);

I don't immediately see where this is used. If it's not then drop setting i=
t.

> +
> +	iio_dev->info =3D &sen0322_info;
> +	iio_dev->name =3D DRIVER_NAME;

As below. I'd rather see the name here as a string.

> +	iio_dev->channels =3D sen0322_channels;
> +	iio_dev->num_channels =3D ARRAY_SIZE(sen0322_channels);
> +	iio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, iio_dev);
> +}
> +
> +static const struct of_device_id sen0322_of_match[] =3D {
> +	{ .compatible =3D "dfrobot,sen0322" },
> +	{ /* sentinel */ }

No real need for the comment.

> +};
> +MODULE_DEVICE_TABLE(of, sen0322_of_match);
> +
> +static struct i2c_driver sen0322_driver =3D {
> +	.driver =3D {

> +		.name =3D DRIVER_NAME,
I'd rather see the string directly here.  There is no reason
why the iio_dev->name above would always match this so in general
it is easier to just see the strings in each place rather than
under a define.

> +		.of_match_table =3D sen0322_of_match,
> +	},
> +	.probe =3D sen0322_probe,
> +};
> +module_i2c_driver(sen0322_driver);
> +
> +MODULE_AUTHOR("T=C3=B3th J=C3=A1nos <gomba007@gmail.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("SEN0322 oxygen sensor driver");
>=20


