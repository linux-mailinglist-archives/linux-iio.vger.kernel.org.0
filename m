Return-Path: <linux-iio+bounces-19145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56935AA9AFF
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB8017DF8F
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE326B0A9;
	Mon,  5 May 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZLahehg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D21AC458;
	Mon,  5 May 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467233; cv=none; b=R0ccIGkoA5m3cV6CN8w1rOb3Q+3hXnQ5JA4gwZig2lCkKfXjZRBJyRIHbyI8yMJ3QWZdHSL9nivPp7+Z7VqPGfwNxBRJ5zaSnQVfJJJFemY5ObCU/KogISYAZQU1ynV6yk9SYNGyMmgQ0fBXSZRu8OdotTto8YXI2p6wjrKU3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467233; c=relaxed/simple;
	bh=y0ZpQ6ZMJcFQtR9JoG+u889WezBkhmmP03zluTSmHI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVlLAYQTKvTOA/ERM216NQJkvkZKKznT09cU17piPyVyqmWV01BiFWPzJLTD2mxjA0emuRbKZjWvL9TgGb76ksredGywWKsKyQJeAaiI8dpZEBmW8Cgl3YhUfiOo/1FgMg/Wp543sOHeMMgIZq/D4iMrdOyRfvkKvfjC0oFE2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZLahehg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99E6C4CEE4;
	Mon,  5 May 2025 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746467233;
	bh=y0ZpQ6ZMJcFQtR9JoG+u889WezBkhmmP03zluTSmHI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZLahehgYKmOiKeq33MCXS9z+7/V21fRzPEjMB5Hk+QNX42SiGWX1+qR3ytW74FkT
	 fo4ZvYFj3tqn3r1Au7PS/qTnPFenYuuUjyiGsDAsVFLkJSyXzIB6EOX1YmYiDM0rPo
	 GD8dUJBaxM/hRz3fY62UHxQS2do9v/xKKNK9MEwSBjZg+X6p5Zar7u48eRSOTfbw5q
	 BWXitrKnIaSezFNbBNbme+RfsTQMNVvwhWdCHoxOFJFHoJJkJWjyBCT7AbVjw2QgDX
	 wPnFefOXCPEuQ/zeKMcTUesYNiKXYlpvXFz8ALouvj4aUe9e0ZzuDgJM5L7ksWUvF8
	 3nkFQuqcQy0EA==
Date: Mon, 5 May 2025 18:47:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?VMOzdGggSsOhbm9z?= via B4 Relay
 <devnull+gomba007.gmail.com@kernel.org>
Cc: gomba007@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: chemical: Add driver for SEN0322
Message-ID: <20250505184705.6f00321a@jic23-huawei>
In-Reply-To: <20250505-iio-chemical-sen0322-v2-2-217473983b42@gmail.com>
References: <20250505-iio-chemical-sen0322-v2-0-217473983b42@gmail.com>
	<20250505-iio-chemical-sen0322-v2-2-217473983b42@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 05 May 2025 09:52:59 +0200
T=C3=B3th J=C3=A1nos via B4 Relay <devnull+gomba007.gmail.com@kernel.org> w=
rote:

> From: T=C3=B3th J=C3=A1nos <gomba007@gmail.com>
>=20
> Add support for the DFRobot SEN0322 oxygen sensor.
>=20
> Datasheet:
> 	https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322

Checkpatch is lagging behind the times, but it is fine to use this
as a formal tag in the tag block..
>=20
> To instantiate (assuming device is connected to I2C-2):
> 	echo 'sen0322 0x73' > /sys/class/i2c-dev/i2c-2/device/new_device
>=20
> To get the oxygen concentration (assuming device is iio:device0) multiply
> the values read from:
> 	/sys/bus/iio/devices/iio:device0/in_concentration_raw
> 	/sys/bus/iio/devices/iio:device0/in_concentration_scale
>=20
Datasheet: https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322

> Signed-off-by: T=C3=B3th J=C3=A1nos <gomba007@gmail.com>
A few other little things inline.

Nice little driver :)

Jonathan

> diff --git a/drivers/iio/chemical/sen0322.c b/drivers/iio/chemical/sen032=
2.c
> new file mode 100644
> index 000000000000..c2dfb0ff7f40
> --- /dev/null
> +++ b/drivers/iio/chemical/sen0322.c
> @@ -0,0 +1,167 @@
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
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define SEN0322_REG_DATA	0x03
> +#define SEN0322_REG_COEFF	0x0A
> +
> +struct sen0322 {
> +	struct regmap	*regmap;
> +};
> +
> +static int sen0322_read_scale(struct sen0322 *sen0322, int *num, int *de=
n)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(sen0322->regmap, SEN0322_REG_COEFF, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val) {
> +		*num =3D val;
> +		*den =3D 100000;
> +	} else {
> +		*num =3D 209;
> +		*den =3D 120000;

This is odd enough, that perhaps we could add a comment on why, or at least
a cross reference to where these numbers come from?
What is the special meaning of 0?

> +	}
> +
> +	dev_dbg(regmap_get_device(sen0322->regmap), "scale: %d/%d\n",
> +		*num, *den);
> +
> +	return 0;
> +}
> +
> +static int sen0322_read_data(struct sen0322 *sen0322)
> +{
> +	u8 data[4] =3D { 0 };

If you are only read 3 bytes, why is this 4 long?

> +	int ret;
> +
> +	ret =3D regmap_bulk_read(sen0322->regmap, SEN0322_REG_DATA, data, 3);

Having shortened above, use sizeof(data) for that 3 to avoid
any potential future mismatch in sizes.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D data[0] * 100 + data[1] * 10 + data[2];
> +
> +	dev_dbg(regmap_get_device(sen0322->regmap), "data: %d\n", ret);

Given you more or less directly provide this to userspace now I'd drop
the dev_dbg() as not adding any value for debugging.

> +
> +	return ret;
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
As the sensor only does concentration, you could either drop this
check on basis we can't get here without it or if you want=20
a strong sanity check do it outside the switch statement as
	if (chan->type !=3D IIO_CONCENTRATION)
		return -EINVAL;


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
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_CONCENTRATION:
> +			ret =3D sen0322_read_scale(sen0322, val, val2);
> +			if (ret < 0)
> +				return ret;
> +
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



