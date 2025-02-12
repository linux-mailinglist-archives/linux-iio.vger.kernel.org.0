Return-Path: <linux-iio+bounces-15449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C81A329C6
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0895F1664D2
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F62211473;
	Wed, 12 Feb 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2glqTz5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1620B80A;
	Wed, 12 Feb 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373619; cv=none; b=cabzvPhDEGZqXX/G3lmYiZRSQllYIcPUMgtD/7c5bftGwH7zgUnvN0oGra+9EJrooX9tOLiMs5sgWP/xr0OjeK+mhurcvGK9VPo4z1RqVkwaLiueG4SgAgY6Pk/vldOr9Mp6Lfi5KMgPbbcOiIuXk8Yy8dlFH8t/Mw+X1CYReLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373619; c=relaxed/simple;
	bh=6UBIy2yl19Z8hdfeYmM+wiw34pcAPhm1NPybtwJR66Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WViMJ/CpFrTB/mLV+ZcGuotIEIyS1aOJk7zoRu04+/KAU+43144xIW3cKdSh6b5EVOJZgIixIEo/A8/6sTFOy8h3DkU2+0y9Rxsgrd2fvdqbsBsdKMJLg0A+sLJHvfhG3YphtciNzDcLapz92amVlKG4DHfTiLjiwQba3VJ4HYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2glqTz5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4395f81db4dso1472405e9.1;
        Wed, 12 Feb 2025 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739373616; x=1739978416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FebLBy1I+iKIlktLhbdjKRC3uSzvxTjYsBfgsiByPsM=;
        b=U2glqTz5MDQTvSkVGWcvORx4bkNQLsamenDpcm8hAE+9dbOScjCN07I9O1uXblC68c
         BJw/FFPSkTFoF+I8DCBsZAOrHvM85WH+CNoJxWCbdY4xXcGdz5VX/vOgMVgAdDZUSYBx
         zWgp4p7IrZrNix/nCsvjfVA51NAe+ONd2MxxBvhBtjNIvZ6TDYTVXDc3MENFZ6V/iRnf
         ARx8MSJwdHkFukliBQlluNl26Dxh7atUZU3sh2t+gmTo3RgirG353EhOQjrI5gasTIvo
         YXxVABTlidhKBw+gxBqGsCuzA/ZdXgpf+x0mWcvp186sAJebvuKzhWhuCvasSHrcB3cC
         cFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373616; x=1739978416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FebLBy1I+iKIlktLhbdjKRC3uSzvxTjYsBfgsiByPsM=;
        b=iSp9o7ZwsRyl0AATt/zX4V4qDQJqFHQB1MNw3lGiCv4NNJL2qNG4WeMGlO+OmGvAWR
         qcRNifDUw3MBC7N6kCoUpIwKNw4KrjdRq84cEjRHR6ngnrMufy1bzVDW0qxTBG71q88w
         2o+49BpWPTFKhHnYOZIM6k+fcrZYgGejQ+cAzxpyFrOeV/+IWDuwwHKm0UwKyQ8vJO1s
         /9R3P8YR7us5MYYvcIt5bOn/LNYgwCpkgoy6DPZuf9ZtxeS4jTplgPR115EkycJ1g/xH
         7T+fPqa3VFBnghFg2QrMA5MmsGOQVwWEfVVFOMBJV3KoBiNJbBZPrDYIEeJAa5cBiNHM
         wrJw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQyUzMxt6iWNKC5cPpy+IaEJOdH75/ndQXqjgfs3HkpArXBXMupYIxQPlW11I69X7+4bZa7N/Juow@vger.kernel.org, AJvYcCUN0VdOJ7Gq9ZazWyHd/jOMHTZ8/cu09PboTG1ZJZLKKasKELnAXmAKdM+YIKlZxhCdSnVTXwb6Yhitbyfr@vger.kernel.org, AJvYcCVz4PLIpyOUPEuW6r4XlvKX1OHJCj2dI5Sc+OFpiBIn8W6mROEvCaVfG2tz2vFm4eKilJ59xgMOd4I6@vger.kernel.org, AJvYcCXb+YTR9J7qF+24GltGiynoemKSKI2YbT41ntNIxHw0/IBx0wp+3fGbekaTD3LYrhqOSkpSbaD5OtXxsR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ91vukH+mXAoyZyasBYVNY1Y4ZozKQUExFqkMT1n0dcqmm7mr
	XNvSoMTcduZMvBVXy+CLTRCfq7zn6AEtJRcUsvbWimZOuIeFkahYDiiEKWxER50pjMHV6ThMQZp
	imZr/RY5ochOu4cvVhufXlUC3Thw=
X-Gm-Gg: ASbGncvb8UUFo3PFeV6ZO/ROz6vTfG38B7wDyTeUfuzL0pz7BGUA4xtaUoTUmahLdCr
	JDqkYMH8TLJ9AltLURkj5kFJA9jEhEGNqgAjvmC1Mey8Nxidz8R14S7ZA/ZaGg2CX9S2PERmc2g
	==
X-Google-Smtp-Source: AGHT+IEu4cbfIywFjgBiWQpXzBDsoopxcNahgaqAyJFgoD394y3tFpiHn4ZgtT6PKSrxgK4ivR0PCiaPRsNGemoK2wU=
X-Received: by 2002:a05:600c:4f83:b0:434:f3d8:62db with SMTP id
 5b1f17b1804b1-4395839dc90mr32260825e9.2.1739373615749; Wed, 12 Feb 2025
 07:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212064657.5683-1-clamor95@gmail.com> <20250212064657.5683-3-clamor95@gmail.com>
 <Z6ywGgofzU1bvm0H@smile.fi.intel.com>
In-Reply-To: <Z6ywGgofzU1bvm0H@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Feb 2025 17:20:04 +0200
X-Gm-Features: AWEUYZldMH6mD-PBye5pg6q0-fwhGqW0-eCd46K-83ooQgR0RtuGbLAultk6xic
Message-ID: <CAPVz0n1UuZPCb3Jdj_fK3Ut7WKBgtvj7aROqJ4YeYVMutuyv7A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] iio: light: Add support for AL3000a illuminance sensor
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Emil Gedenryd <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, 
	Mudit Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, 
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:28 Andy=
 Shevchenko
<andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 12, 2025 at 08:46:56AM +0200, Svyatoslav Ryhel wrote:
> > AL3000a is a simple I2C-based ambient light sensor, which is
> > closely related to AL3010 and AL3320a, but has significantly
> > different hardware configuration.
>
> (Note, the part of the below comments are applicable to your other series=
)
>
> ...
>
> > +/*
> > + * AL3000a - Dyna Image Ambient Light Sensor
> > + */
>
> Can be on a single line.
>

Patch checking script did not catch this as warning or style issue. If
such commenting is discouraged than please add this to patch checking
script. Comments are stripped on compilation anyway, they do not
affect size.

> ...
>
> > +#include <linux/bitfield.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
>
> > +#include <linux/of.h>
>
> No of*.h in the new code, please.
>
> > +#include <linux/regulator/consumer.h>
>
> Too small headers to be included. You use much more.
>

Is there a check which determines the amount of headers I must include
and which headers are mandatory to be included and which are forbidden
to inclusion. Maybe at least a list? Thanks

>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
>
> ...
>
> > +/*
> > + * This are pre-calculated lux values based on possible output
> > + * of sensor (range 0x00 - 0x3F)
> > + */
>
> types.h
>
> > +static const u32 lux_table[64] =3D {
>
> I think you don't need 64 to be there, but okay, I understand the intenti=
on.
>
> > +     1, 1, 1, 2, 2, 2, 3, 4, 4, 5, 6, 7, 9, 11, 13, 16,
>
> For the better readability and maintenance put pow-of-2 amount of values =
per
> line, like 8, and add the respective comment:
>
>         1, 1, 1, 2, 2, 2, 3, 4,                                 /*  0 -  =
7 */
>         4, 5, 6, 7, 9, 11, 13, 16,                              /*  8 - 1=
5 */
>
> > +     19, 22, 27, 32, 39, 46, 56, 67, 80, 96, 116, 139,
> > +     167, 200, 240, 289, 347, 416, 499, 600, 720, 864,
> > +     1037, 1245, 1495, 1795, 2155, 2587, 3105, 3728, 4475,
> > +     5373, 6450, 7743, 9296, 11160, 13397, 16084, 19309,
> > +     23180, 27828, 33408, 40107, 48148, 57803, 69393,
> > +     83306, 100000
>
> Leave trailing comma, it's not a terminated list generally speaking
> (in the future it might grow).

No, this list will not grow since the bit field seems to be 0x3f
(datasheet is not available, code is adaptation of downstream driver).

> > +};
>
> ...
>
> > +struct al3000a_data {
> > +     struct i2c_client *client;
>
>         struct regmap *map;
>
> will suffice, I believe, see below.
>
>
> > +     struct regulator *vdd_supply;
> > +};
>
> ...
>
> > +static const struct iio_chan_spec al3000a_channels[] =3D {
> > +     {
> > +             .type =3D IIO_LIGHT,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
>
> > +     }
>
> Leave trailing comma
>
> > +};
>
> ...
>
> > +static int al3000a_set_pwr(struct al3000a_data *data, bool pwr)
> > +{
> > +     struct device *dev =3D &data->client->dev;
> > +     u8 val =3D pwr ? AL3000A_CONFIG_ENABLE : AL3000A_CONFIG_DISABLE;
> > +     int ret;
> > +
> > +     if (pwr) {
> > +             ret =3D regulator_enable(data->vdd_supply);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "failed to enable vdd power supply\n=
");
> > +                     return ret;
>
> With struct regmap *map in mind, the struct device *dev can be derived us=
ing
> the respective API.
>
> > +             }
> > +     }
> > +
> > +     ret =3D i2c_smbus_write_byte_data(data->client, AL3000A_REG_SYSTE=
M, val);
>
> Why not using regmap I=E6=B6=8E APIs?
>

This adaptation was written quite a long time ago, patch check did not
complained about using of i2c smbus. Is use of regmap mandatory now?
Is it somewhere specified? Thanks

I am not a full time linux contributor and may not be familiar with
the recent rules.

> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to write system register\n");
> > +             return ret;
> > +     }
> > +
> > +     if (!pwr) {
> > +             ret =3D regulator_disable(data->vdd_supply);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "failed to disable vdd power supply\=
n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan, int *val,
> > +                         int *val2, long mask)
> > +{
> > +     struct al3000a_data *data =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
>
> > +             ret =3D i2c_smbus_read_byte_data(data->client,
> > +                                            AL3000A_REG_DATA);
>
> It may be a single line. There is a lot of room.
>
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             *val =3D lux_table[ret & 0x3F];
>
> I believe you want to define the size of that table and use it here.
> Also this needs a comment to explain the meaning of the ret >=3D 64 and
> when it may happen.
>
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val =3D 1;
> > +
> > +             return IIO_VAL_INT;
>
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return -EINVAL;
>
> Return directly from the default case.
>
> > +}
>
> ...
>
> > +static int al3000a_probe(struct i2c_client *client)
> > +{
> > +     struct al3000a_data *data;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
>
>         struct device *dev =3D &client->dev;
>
> will make the below lines shorter and easier to read.
>
>
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data =3D iio_priv(indio_dev);
> > +     i2c_set_clientdata(client, indio_dev);
> > +     data->client =3D client;
> > +
> > +     data->vdd_supply =3D devm_regulator_get(&client->dev, "vdd");
> > +     if (IS_ERR(data->vdd_supply))
> > +             return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supp=
ly),
> > +                                  "failed to get vdd regulator\n");
>
> err.h
>
> > +     indio_dev->info =3D &al3000a_info;
> > +     indio_dev->name =3D AL3000A_DRV_NAME;
> > +     indio_dev->channels =3D al3000a_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(al3000a_channels);
>
> array_size.h
>
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +     ret =3D al3000a_init(data);
> > +     if (ret < 0)
>
> > +             return dev_err_probe(&client->dev, ret,
> > +                                  "failed to init ALS\n");
>
> Single line.
>
> > +     ret =3D devm_add_action_or_reset(&client->dev, al3000a_set_pwr_of=
f,
> > +                                    data);
>
> Ditto.
>
> device.h
>
> > +     if (ret < 0)
> > +             return dev_err_probe(&client->dev, ret,
> > +                                  "failed to add action\n");
> > +
> > +     return devm_iio_device_register(&client->dev, indio_dev);
> > +}
>
> ...
>
> > +static const struct of_device_id al3000a_of_match[] =3D {
>
> mod_devicetable.h
>
> > +     { .compatible =3D "dynaimage,al3000a" },
> > +     { /* sentinel */ }
> > +};
>
> ...
>
> > +static struct i2c_driver al3000a_driver =3D {
> > +     .driver =3D {
> > +             .name =3D AL3000A_DRV_NAME,
> > +             .of_match_table =3D al3000a_of_match,
>
> > +             .pm =3D pm_sleep_ptr(&al3000a_pm_ops),
>
> pm.h
>
> > +     },
> > +     .probe =3D al3000a_probe,
> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Everything else is valid, thank you. I will add fixes and try to
switch to regmap.

