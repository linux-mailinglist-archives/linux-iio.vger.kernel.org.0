Return-Path: <linux-iio+bounces-20956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03DAE7CB9
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 11:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA77162842
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487FF2D9EC8;
	Wed, 25 Jun 2025 09:19:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990472E7637
	for <linux-iio@vger.kernel.org>; Wed, 25 Jun 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843144; cv=none; b=J27r3dtNVSBm4swWbsbKhhESj51eFLRlb/g3iZYu0hDOfteI96VCVtVQgVum208Ay+jVyqu5yVueBmMuBVrBqlAYoKX+z26Gx+PhkjiVmMD1yhsUmiEsIYMkT1oHTmQ+karYzDYwTUvdLD4zGCABydaYXtl1yFfJjcf20PK5aSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843144; c=relaxed/simple;
	bh=bXgR0gZq4E/6i1KFejw3gtvHwWbAUkDJvpL8kBM5pR0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3Nc1C9M//tKwfDANzEYWIpPhHBXqsfApr2zcpTEKBcVnRx9zRjWjKLeC3muwEJWuiZ5OxeerHh/yUQZ7If1a61V60jpHHSv7PjPi7FIEUxX+aULX5wrpeSbT5BgVXe0QNNHQDyZPsXGTMycJZSfP3Jhg6+lWfy0/WbkFPAS4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRx7T4Qr3z6GFbW;
	Wed, 25 Jun 2025 17:18:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 163401404C5;
	Wed, 25 Jun 2025 17:18:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 11:18:58 +0200
Date: Wed, 25 Jun 2025 10:18:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gabriel Lima de Moraes <gabriellimamoraes@gmail.com>
CC: <linux-iio@vger.kernel.org>, <gabriellimamoraes@ime.usp.br>, Vitor Marques
	<vitor.marques@ime.usp.br>, Gabriel =?ISO-8859-1?Q?Jos=E9?=
	<gabrieljpe@ime.usp.br>
Subject: Re: [PATCH] iio: light : veml6030 Remove code duplication
Message-ID: <20250625101857.00004dbf@huawei.com>
In-Reply-To: <20250623201539.16148-1-gabriellimamoraes@gmail.com>
References: <20250623201539.16148-1-gabriellimamoraes@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 17:15:39 -0300
Gabriel Lima de Moraes <gabriellimamoraes@gmail.com> wrote:

> From: Vitor Marques <vitor.marques@ime.usp.br>
>=20
> veml6030_hw_init() and veml6035_hw_init() have very similar bodies.
>=20
> Reduce code duplication by creating a common initialization function veml=
603x_hw_common_init().
>=20
> Signed-off-by: Vitor Marques <vitor.marques@ime.usp.br>
> Co-developed-by: Gabriel Lima <gabriellimamoraes@ime.usp.br>
> Co-developed-by: Gabriel Jos=E9 <gabrieljpe@ime.usp.br>
> ---
>  drivers/iio/light/veml6030.c | 187 ++++++++++++++++++-----------------

When a patch removing duplication ends up adding code it might not be
such a good idea...

A few comments inline, but in general there isn't a convincing argument
that I can see for this code unification.  So drop this.


>  1 file changed, 95 insertions(+), 92 deletions(-)
>=20
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 473a9c3e32a3..7959075b1ae8 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -33,6 +33,18 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> =20
> +int veml603x_hw_common_init(
> +    struct iio_dev *indio_dev,=20
> +    struct device *dev,
> +    int iio_init_val1,
> +    int iio_init_val2,
> +    const struct iio_gain_sel_pair *gain_sel,
> +    size_t gain_sel_size,
> +    const struct iio_itime_sel_mul *it_sel,
> +    size_t it_sel_size,
> +    int als_conf_val2
> +);

You have defined the function before it is used so why do you need
a forwards declaration?

> +
>  /* Device registers */
>  #define VEML6030_REG_ALS_CONF   0x00
>  #define VEML6030_REG_ALS_WH     0x01
> @@ -248,6 +260,66 @@ static void veml6030_als_shut_down_action(void *data)
>  	veml6030_als_shut_down(data);
>  }
> =20
> +int veml603x_hw_common_init(
> +    struct iio_dev *indio_dev,=20
> +    struct device *dev,
> +    int iio_init_val1,
> +    int iio_init_val2,

These parameters have names that managed to obscure what is going on
generally making this patch a bad idea.

> +    const struct iio_gain_sel_pair *gain_sel,
> +    size_t gain_sel_size,
> +    const struct iio_itime_sel_mul *it_sel,
> +    size_t it_sel_size,
> +    int als_conf_val2
Why 2?

> +)
> +{
> +	int ret, val;
> +	struct veml6030_data *data =3D iio_priv(indio_dev);
> +
> +	ret =3D devm_iio_init_iio_gts(dev, iio_init_val1, iio_init_val2,
> +			gain_sel, gain_sel_size,
> +			it_sel, it_sel_size,
> +			&data->gts);
> +	if (ret)
> +	return dev_err_probe(dev, ret, "failed to init iio gts\n");

Looks like you have some big formatting issues in here.

> +
> +	ret =3D veml6030_als_shut_down(data);
> +	if (ret)
> +	return dev_err_probe(dev, ret, "can't shutdown als\n");
> +
> +	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_CONF, als_conf_val2=
);

Wrapping this up doesn't provide any real advantage, requiring as it does
the reviewer to look at this function AND where the value is set rather
than seeing them in one place.

> +	if (ret)
> +	return dev_err_probe(dev, ret, "can't setup als configs\n");
> +
> +	ret =3D regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
> +		VEML6030_PSM | VEML6030_PSM_EN, 0x03);
> +	if (ret)
> +	return dev_err_probe(dev, ret, "can't setup default PSM\n");
> +
> +	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
> +	if (ret)
> +	return dev_err_probe(dev, ret, "can't setup high threshold\n");
> +
> +	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
> +	if (ret)
> +	return dev_err_probe(dev, ret, "can't setup low threshold\n");
> +
> +	ret =3D veml6030_als_pwr_on(data);
> +	if (ret)
> +	return dev_err_probe(dev, ret, "can't poweron als\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, veml6030_als_shut_down_action, da=
ta);
> +	if (ret < 0)
> +	return ret;
> +
> +	/* Clear stale interrupt status bits if any during start */
> +	ret =3D regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
> +	if (ret < 0)
> +	return dev_err_probe(dev, ret,
> +			"can't clear als interrupt status\n");
> +
> +	return ret;
> +}
> +
>  static const struct iio_event_spec veml6030_event_spec[] =3D {
>  	{
>  		.type =3D IIO_EV_TYPE_THRESH,
> @@ -973,52 +1045,17 @@ static int veml6030_regfield_init(struct iio_dev *=
indio_dev)
>   */
>  static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *de=
v)
>  {
> -	int ret, val;
> -	struct veml6030_data *data =3D iio_priv(indio_dev);
> -
> -	ret =3D devm_iio_init_iio_gts(dev, 2, 150400000,
> -				    veml6030_gain_sel, ARRAY_SIZE(veml6030_gain_sel),
> -				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
> -				    &data->gts);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to init iio gts\n");
> -
> -	ret =3D veml6030_als_shut_down(data);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't shutdown als\n");
> -
> -	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x1001);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't setup als configs\n");
> -
> -	ret =3D regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
> -				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't setup default PSM\n");
> -
> -	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't setup high threshold\n");
> -
> -	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't setup low threshold\n");
> -
> -	ret =3D veml6030_als_pwr_on(data);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't poweron als\n");
> -
> -	ret =3D devm_add_action_or_reset(dev, veml6030_als_shut_down_action, da=
ta);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Clear stale interrupt status bits if any during start */
> -	ret =3D regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
> -	if (ret < 0)
> -		return dev_err_probe(dev, ret,
> -				     "can't clear als interrupt status\n");
> -
> -	return ret;
> +	return veml603x_hw_common_init(
> +		indio_dev,
> +		dev,
> +		2,
> +		150400000,
> +		veml6030_gain_sel,
> +		ARRAY_SIZE(veml6030_gain_sel),
> +		veml6030_it_sel,
> +		ARRAY_SIZE(veml6030_it_sel),
> +		0x1001
> +	);
>  }
> =20
>  /*
> @@ -1029,52 +1066,18 @@ static int veml6030_hw_init(struct iio_dev *indio=
_dev, struct device *dev)
>   * update registers and then power on the sensor.
>   */
>  static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *de=
v)
> -{
> -	int ret, val;
> -	struct veml6030_data *data =3D iio_priv(indio_dev);
> -
> -	ret =3D devm_iio_init_iio_gts(dev, 0, 409600000,
> -				    veml6035_gain_sel, ARRAY_SIZE(veml6035_gain_sel),
> -				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
> -				    &data->gts);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to init iio gts\n");
> -
> -	ret =3D veml6030_als_shut_down(data);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't shutdown als\n");
> -
> -	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
> -			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't setup als configs\n");
> -
> -	ret =3D regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
> -				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't setup default PSM\n");
> -
> -	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't setup high threshold\n");
> -
> -	ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't setup low threshold\n");
> -
> -	ret =3D veml6030_als_pwr_on(data);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "can't poweron als\n");
> -
> -	ret =3D devm_add_action_or_reset(dev, veml6030_als_shut_down_action, da=
ta);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Clear stale interrupt status bits if any during start */
> -	ret =3D regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
> -	if (ret < 0)
> -		return dev_err_probe(dev, ret,
> -				     "can't clear als interrupt status\n");
> +{=09
> +	veml603x_hw_common_init(
> +        indio_dev,
> +        dev,
> +        0,
> +        409600000,
> +        veml6035_gain_sel,
> +        ARRAY_SIZE(veml6035_gain_sel),
> +        veml6030_it_sel,
> +        ARRAY_SIZE(veml6030_it_sel),
> +        VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD
> +	);
> =20
>  	return 0;
>  }


