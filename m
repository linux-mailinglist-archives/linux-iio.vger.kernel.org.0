Return-Path: <linux-iio+bounces-16595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89548A585E0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D8E7A4DAC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0A1DE2C4;
	Sun,  9 Mar 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEF5Puxp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB0748F;
	Sun,  9 Mar 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741538758; cv=none; b=Ns5Dq2cMNn50M2waEaC/3q61PcNMSiFUH+SSm134cx1FVYw80fWc3Dxpy+FYMYKWIejHiI2gjMEWY6yx0Jb8qc73BsZE7SwLsst8i/pn9a0VKaEkp4Hutvbpvh7/Pp3qcPCKerJkTKMkuRc0p93FhvwS5tSLKCy8U8Q225txWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741538758; c=relaxed/simple;
	bh=1+R5ZdVNSb2GbZABra6faLsIyErIjZ7NwqS1tmRYNtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJ8TQPVez9Lu1Gop9MgVm9ZD/3cHtOta7D46sXayEAFWiBM5b5Uu/buQZFaSM3cA4M+PnIMZOxT898/ELGx8V2ZvfJhogqaXRYLx6haHXoGOBAV0Khnw7otzPpCVcH+7D9gz1Z/8KSRLWDKHK10XxuejMXF35pNLzJ2Ej07g1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEF5Puxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF44AC4CEE3;
	Sun,  9 Mar 2025 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741538757;
	bh=1+R5ZdVNSb2GbZABra6faLsIyErIjZ7NwqS1tmRYNtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BEF5PuxpO3XnPIihhFSQa6ePdiMbd6cgmvkhYQ4XItSnWTnrbtlSxwDYRZHGl45Ux
	 24WMYWa2anZXFcPkTb/Ha7mvg9jov7QCe6W4D+xYpVB1ojnGOIwG1QOauX1Ou1SkZX
	 iMf1vM3De1ZuoeFtNekgsZOGbxa7M6BcqX1u4gwR2O6+HyK2dTv6mrVRp/OvSDY2yt
	 dm6S1UpEZ6Dd4NtjfIgZ7+ixTtg8OuZIRmpokGQObAcixxfdGgdYEtP8074qvcBgK5
	 Omz967hYeza+idUyGQkHcU614G7+MlMTSSvQxV+rYhKplVP1ni38ah4IreeECJ0oGv
	 sHQ3uLsVaUifA==
Date: Sun, 9 Mar 2025 16:45:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: light: al3010: Implement regmap support
Message-ID: <20250309164549.26d4cdfc@jic23-huawei>
In-Reply-To: <20250308-al3010-iio-regmap-v1-3-b672535e8213@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
	<20250308-al3010-iio-regmap-v1-3-b672535e8213@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 08 Mar 2025 21:01:00 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
>=20
> Modernize and make driver a bit cleaner.
>=20
> Incorporate most of the feedback given on new AL3000A.
Hi David,

Why does regmap bring benefits here?  This seems to be a like for like
change (no use of additional helpers / caching etc) so I'm not immediately
seeing the advantage.

Various comments inline. Main one is this is doing several not particularly
closely related changes that belong in separate patches.

Jonathan

>=20
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3010.c | 95 ++++++++++++++++++++++++++--------------=
------
>  1 file changed, 53 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 7cbb8b203300907a88f4a0ab87da89cabdd087f3..f6ed7246864a777fdb7d3861b=
74f5834e8af4105 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright (c) 2014, Intel Corporation.
>   * Copyright (c) 2016, Dyna-Image Corp.
> - * Copyright (c) 2020, David Heidelberg, Micha=C5=82 Miros=C5=82aw, Dmit=
ry Osipenko
> + * Copyright (c) 2020 - 2025, David Heidelberg, Micha=C5=82 Miros=C5=82a=
w, Dmitry Osipenko

This implies all 3 of you were involved in this update. If that's not
the case perhaps just add a new copyright line for this change.

>   *
>   * IIO driver for AL3010 (7-bit I2C slave address 0x1C).
>   *

> =20
>  static const struct iio_chan_spec al3010_channels[] =3D {
> @@ -69,40 +76,32 @@ static const struct attribute_group al3010_attribute_=
group =3D {
>  	.attrs =3D al3010_attributes,
>  };
> =20
> -static int al3010_set_pwr(struct i2c_client *client, bool pwr)
> +static int al3010_set_pwr_on(struct al3010_data *data)
>  {
> -	u8 val =3D pwr ? AL3010_CONFIG_ENABLE : AL3010_CONFIG_DISABLE;
> -	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM, val);
> +	return regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_ENAB=
LE);
Splitting this write into the on and off cases is a change that is
not closely related to regmap change, so probably wants to be in a separate
patch.

>  }
> =20
>  static void al3010_set_pwr_off(void *_data)
>  {
>  	struct al3010_data *data =3D _data;
> +	struct device *dev =3D regmap_get_device(data->regmap);
> +	int ret;
> =20
> -	al3010_set_pwr(data->client, false);
> +	ret =3D regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_DIS=
ABLE);
> +	if (ret)
> +		dev_err(dev, "failed to write system register\n");
>  }
> =20
>  static int al3010_init(struct al3010_data *data)
>  {
>  	int ret;
> =20
> -	ret =3D al3010_set_pwr(data->client, true);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D devm_add_action_or_reset(&data->client->dev,
> -				       al3010_set_pwr_off,
> -				       data);

As below. Not obvious to me why we'd want to move this.

> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
> -					FIELD_PREP(AL3010_GAIN_MASK,
> -						   AL3XXX_RANGE_3));
> -	if (ret < 0)
> +	ret =3D al3010_set_pwr_on(data);
> +	if (ret)
>  		return ret;
> =20
> -	return 0;
> +	return regmap_write(data->regmap, AL3010_REG_CONFIG,
> +			    FIELD_PREP(AL3010_GAIN_MASK, AL3XXX_RANGE_3));
>  }
> =20
>  static int al3010_read_raw(struct iio_dev *indio_dev,
> @@ -110,7 +109,7 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
>  			   int *val2, long mask)
>  {
>  	struct al3010_data *data =3D iio_priv(indio_dev);
> -	int ret;
> +	int ret, value;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -119,21 +118,21 @@ static int al3010_read_raw(struct iio_dev *indio_de=
v,
>  		 * - low byte of output is stored at AL3010_REG_DATA_LOW
>  		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
>  		 */
> -		ret =3D i2c_smbus_read_word_data(data->client,
> -					       AL3010_REG_DATA_LOW);
> -		if (ret < 0)
> +		ret =3D regmap_read(data->regmap, AL3010_REG_DATA_LOW, &value);
> +		if (ret)
>  			return ret;
> -		*val =3D ret;
> +
> +		*val =3D value;
> +
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret =3D i2c_smbus_read_byte_data(data->client,
> -					       AL3010_REG_CONFIG);
> -		if (ret < 0)
> +		ret =3D regmap_read(data->regmap, AL3010_REG_CONFIG, &value);
> +		if (ret)
>  			return ret;
> =20
> -		ret =3D FIELD_GET(AL3010_GAIN_MASK, ret);
> -		*val =3D al3010_scales[ret][0];
> -		*val2 =3D al3010_scales[ret][1];
> +		value =3D FIELD_GET(AL3010_GAIN_MASK, value);
I'm never a big fan of conflating use of one variable for the register value
(where value is a reasonable name) and the field extract from it where
it's not really. scale_idx or something like that would make more sense for
this second case.

> +		*val =3D al3010_scales[value][0];
> +		*val2 =3D al3010_scales[value][1];
> =20
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	}
> @@ -145,7 +144,7 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
>  			    int val2, long mask)
>  {
>  	struct al3010_data *data =3D iio_priv(indio_dev);
> -	int i;
> +	unsigned int i;

Looks like an unrelated change.  Possibly even one that isn't worth making.

> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -154,9 +153,8 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
>  			    val2 !=3D al3010_scales[i][1])
>  				continue;
> =20
> -			return i2c_smbus_write_byte_data(data->client,
> -					AL3010_REG_CONFIG,
> -					FIELD_PREP(AL3010_GAIN_MASK, i));
> +			return regmap_write(data->regmap, AL3010_REG_CONFIG,
> +					    FIELD_PREP(AL3010_GAIN_MASK, i));
>  		}
>  		break;
>  	}
> @@ -172,16 +170,20 @@ static const struct iio_info al3010_info =3D {
>  static int al3010_probe(struct i2c_client *client)
>  {
>  	struct al3010_data *data;
> +	struct device *dev =3D &client->dev;

This is confusing two things.  I'd prefer a precursor patch that
adds the local variable followed by one that adds the regmap stuff.

>  	struct iio_dev *indio_dev;
>  	int ret;
> =20
> -	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
>  	data =3D iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
> -	data->client =3D client;
> +	data->regmap =3D devm_regmap_init_i2c(client, &al3010_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "cannot allocate regmap\n");
> =20
>  	indio_dev->info =3D &al3010_info;
>  	indio_dev->name =3D AL3010_DRV_NAME;
> @@ -191,21 +193,30 @@ static int al3010_probe(struct i2c_client *client)
> =20
>  	ret =3D al3010_init(data);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "al3010 chip init failed\n");
> +		dev_err(dev, "failed to init ALS\n");
>  		return ret;
>  	}
> =20
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	ret =3D devm_add_action_or_reset(dev, al3010_set_pwr_off, data);

Moving this out here doesn't look like a change related to regmap.
Generally I'd prefer that stayed next to where the power on is as this
is not obviously undoing the al3010_init() given naming etc.

> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
>  }

