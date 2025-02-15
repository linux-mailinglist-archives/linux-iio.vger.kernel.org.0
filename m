Return-Path: <linux-iio+bounces-15552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BDCA36EC7
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 15:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E683170E6A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556A1D79A9;
	Sat, 15 Feb 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcom4IAP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ECE13DDAE;
	Sat, 15 Feb 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629340; cv=none; b=FK92E8LyjsoZ9WIoBpcwSSIehdKvbySgMTkp/Uczu3wUNw1a/H68/zcELolGKBGdts7sauSAvNfRg6a/qkd5sAYsU4+1Nv6K438i8VsHeIQZbpvE6XJje8o+oIa0Grm7+w4vMFiEKz/xnsavGFHwqBOj5LL/X1pbT/7Wgu3a8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629340; c=relaxed/simple;
	bh=6fJ8zHaER+DuRqytlQHjD9/7h0lZh1Y1voiqfDeb9Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCkNn81hXTJP8iHlPmXuz9tG3s/6zebzDt+p3kqaAKg25K/zvS/3BBpf17svoFlWLf0nFcnriPEaFYlxgQ/7CY2Lc34lvtz+r2/jJTrwcRo7K59LSFNICsyoNd9iQdSPyjGkwNFhHYdk5HzbHx9WsTx+Bs4uf+7PD/E6O58PnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcom4IAP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f325ddbc2so777557f8f.1;
        Sat, 15 Feb 2025 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739629337; x=1740234137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mA/QXoXjm/VEX8mtdfBVbYH7PcUqVqZV/G4AVhQ0KM=;
        b=Gcom4IAPmYWMv7KMo9A59kW98xhgQK0AbBw9gZTNXJTmqM9MsNl/eIYs2SUm2/Tfkz
         vve4EWipxzyJ14NdfZuDPBuiC8xVb6B2SOuoSv7xhT7DNJMx2f9vUF6XfOWZPUqCTqy/
         LxaspLtN7tnsm2Ym8mi8pqHDAwq8Z2Agf2sEu52xfVkRctkK9R/VxQgnP7LWUjPkjHCB
         2g76NtGxLGn5SoodEvILlnWIZYbTy7qhTdBU1Yix3aedIBFud7bAf3qnU2Q1lB1ELi7r
         Vqu0Lx0IM9f2k1S3e9EHlN7256ck05Z1VGmDVO9HzhCTJ5Z+TkTKkC3WH6XBMvkLmCzS
         LJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739629337; x=1740234137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mA/QXoXjm/VEX8mtdfBVbYH7PcUqVqZV/G4AVhQ0KM=;
        b=bPNfVYovZyIf6thztw5yJtC/QW33yBAc15p1gPb+mlPcufTfeCgBZuVbcSA7CNk/Nb
         Rym3zcTwIF+VTgmNr+Ve9Bbksb9K8KEMtxKxnVUi1HLng0RpI/TTcNovKxWop3D77p9f
         tmXdctNlveJvgcLAeB4yZPt/4oROAhhJd0uV9w8yrSSnSb4aS7Rx6p/HcLsxesqoP0Mi
         Gf6BL4dPIJO/VQ9DWiHc9oqBvdRlnYzM8GlF0WpDuzDMSmG97yVrc+/P073zC6uytgh6
         C21CjChS7swAeIXsnmKI7XbfJt90EOvDf+SCX+S1IGIGAVE6n32SNQHowQ77wXdvyoZ9
         sEzw==
X-Forwarded-Encrypted: i=1; AJvYcCUeNS6QRKpoFIVE4IaME8O0fwqyRxsaTNmadiTvirPJj9EY/uBcLdSP+VeBOrfPxGaLpS4rTtWVoiHN@vger.kernel.org, AJvYcCUx89O2KRzguRH9WxnYIzUivHX8K4QAqTmEQfoSlTYvRgjg6SOAFhlPaUK+G/nxN5YL5u5OLL8C3lwV8MdT@vger.kernel.org, AJvYcCVLjcin3ign28OiZcu8iPX152BFIuZJ3xHf38Fj8kunTbwbSUQsrWDlyZ2clSzrsXUm2zrKpzxITu5H@vger.kernel.org, AJvYcCW2YWrdGxnBbX351nNHO/q/a1eTwjXY5fe2s5E5/sjO+TOPu2LfoHmvn96cSYbxVgYeUDz+7uUyH3GJsac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZc93e07re9KBP1+DiggfY1R76z+ctOyDj10zUtwpACmVk+8Q9
	9hYtr+iR4VUy91Y9Tc91EH0puvgD5r9T4rTjVWNxFke0RDEJSmREoeXMoUgeOZFc6mvEW8P2Ptq
	EJyL4lRkWVCTXuhqFi4vwtdI49PM=
X-Gm-Gg: ASbGncuQYbycFJVpKhbSWWLRkuUgE38K93X9d4NXFgEvBA3GkC9lxwqYyVbv9M6QUIY
	Ls7BfXUP5oSbGTZGJskGFSGbTR15qtvz5rhIo3s2EYeV24Ojy1AhXrsItjg0VvRIqNHptP/YnaQ
	==
X-Google-Smtp-Source: AGHT+IGgTNm98v+pbR9qnQiZnlt235288hQCip6r7Wkf15mQLQvOkt8aXUuMnlWWa78TqdHhIEIDsPKpPq16dRYTZKE=
X-Received: by 2002:a05:6000:4007:b0:38f:2b59:b550 with SMTP id
 ffacd0b85a97d-38f34167df2mr2768661f8f.50.1739629336414; Sat, 15 Feb 2025
 06:22:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215103159.106343-1-clamor95@gmail.com> <20250215103159.106343-3-clamor95@gmail.com>
 <1597453a-31fc-49eb-8b69-efeb8805c67a@ixit.cz>
In-Reply-To: <1597453a-31fc-49eb-8b69-efeb8805c67a@ixit.cz>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 15 Feb 2025 16:22:05 +0200
X-Gm-Features: AWEUYZmHa9pO9VfnLmYNuUWHpXt4I13oLrd7sTGxxt-V__hdk_gySc6k3867mqw
Message-ID: <CAPVz0n1T_jXXDhm6gF7gDDqZ=b6abR1Tqk=5kLo=Ws4FF2EVJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance sensor
To: David Heidelberg <david@ixit.cz>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:12 Davi=
d Heidelberg <david@ixit.cz> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> On 15/02/2025 11:31, Svyatoslav Ryhel wrote:
> > AL3000a is a simple I2C-based ambient light sensor, which is
> > closely related to AL3010 and AL3320a, but has significantly
> > different way of processing data generated by the sensor.
> >
> > Tested-by: Robert Eckelmann <longnoserob@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   drivers/iio/light/Kconfig   |  10 ++
> >   drivers/iio/light/Makefile  |   1 +
> >   drivers/iio/light/al3000a.c | 221 +++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 232 insertions(+)
> >   create mode 100644 drivers/iio/light/al3000a.c
> >
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index e34e551eef3e..142f7f7ef0ec 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -43,6 +43,16 @@ config ADUX1020
> >        To compile this driver as a module, choose M here: the
> >        module will be called adux1020.
> >
> > +config AL3000A
> > +     tristate "AL3000a ambient light sensor"
> > +     depends on I2C
> > +     help
> > +       Say Y here if you want to build a driver for the Dyna Image AL3=
000a
> > +       ambient light sensor.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called al3000a.
> > +
> >   config AL3010
> >       tristate "AL3010 ambient light sensor"
> >       depends on I2C
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index 11a4041b918a..17030a4cc340 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -7,6 +7,7 @@
> >   obj-$(CONFIG_ACPI_ALS)              +=3D acpi-als.o
> >   obj-$(CONFIG_ADJD_S311)             +=3D adjd_s311.o
> >   obj-$(CONFIG_ADUX1020)              +=3D adux1020.o
> > +obj-$(CONFIG_AL3000A)                +=3D al3000a.o
> >   obj-$(CONFIG_AL3010)                +=3D al3010.o
> >   obj-$(CONFIG_AL3320A)               +=3D al3320a.o
> >   obj-$(CONFIG_APDS9300)              +=3D apds9300.o
> > diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
> > new file mode 100644
> > index 000000000000..58d4336dd081
> > --- /dev/null
> > +++ b/drivers/iio/light/al3000a.c
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/types.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define AL3000A_DRV_NAME             "al3000a"
> > +#define AL3000A_REG_SYSTEM           0x00
> > +#define AL3000A_REG_DATA             0x05
> > +
> > +#define AL3000A_CONFIG_ENABLE                0x00
> > +#define AL3000A_CONFIG_DISABLE               0x0b
> > +#define AL3000A_CONFIG_RESET         0x0f
> > +#define AL3000A_GAIN_MASK            GENMASK(5, 0)
> > +
> > +/*
> > + * This are pre-calculated lux values based on possible output of sens=
or
> > + * (range 0x00 - 0x3F)
> > + */
> > +static const u32 lux_table[] =3D {
> > +     1, 1, 1, 2, 2, 2, 3, 4,                                 /* 0 - 7 =
*/
> > +     4, 5, 6, 7, 9, 11, 13, 16,                              /* 8 - 15=
 */
> > +     19, 22, 27, 32, 39, 46, 56, 67,                         /* 16 - 2=
3 */
> > +     80, 96, 116, 139, 167, 200, 240, 289,                   /* 24 - 3=
1 */
> > +     347, 416, 499, 600, 720, 864, 1037, 1245,               /* 32 - 3=
9 */
> > +     1495, 1795, 2155, 2587, 3105, 3728, 4475, 5373,         /* 40 - 4=
7 */
> > +     6450, 7743, 9296, 11160, 13397, 16084, 19309, 23180,    /* 48 - 5=
5 */
> > +     27828, 33408, 40107, 48148, 57803, 69393, 83306, 100000 /* 56 - 6=
3 */
> > +};
> > +
> > +static const struct regmap_config al3000a_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D AL3000A_REG_DATA,
> > +};
> > +
> > +struct al3000a_data {
> > +     struct regmap *regmap;
> > +     struct regulator *vdd_supply;
> > +};
> > +
> > +static const struct iio_chan_spec al3000a_channels[] =3D {
> > +     {
> > +             .type =3D IIO_LIGHT,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +     },
> > +};
> > +
> > +static int al3000a_set_pwr(struct al3000a_data *data, bool pwr)
> > +{
> > +     struct device *dev =3D regmap_get_device(data->regmap);
> > +     u8 val =3D pwr ? AL3000A_CONFIG_ENABLE : AL3000A_CONFIG_DISABLE;
> > +     int ret;
> > +
> > +     if (pwr) {
> > +             ret =3D regulator_enable(data->vdd_supply);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "failed to enable vdd power supply\n=
");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     ret =3D regmap_write(data->regmap, AL3000A_REG_SYSTEM, val);
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
> > +
> > +static void al3000a_set_pwr_off(void *_data)
> > +{
> > +     struct al3000a_data *data =3D _data;
> > +
> > +     al3000a_set_pwr(data, false);
> > +}
> > +
> > +static int al3000a_init(struct al3000a_data *data)
> > +{
> > +     int ret;
> > +
> > +     ret =3D al3000a_set_pwr(data, true);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CO=
NFIG_RESET);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CO=
NFIG_ENABLE);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan, int *val,
> > +                         int *val2, long mask)
> > +{
> > +     struct al3000a_data *data =3D iio_priv(indio_dev);
> > +     int ret, gain;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D regmap_read(data->regmap, AL3000A_REG_DATA, &gain=
);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             *val =3D lux_table[gain & AL3000A_GAIN_MASK];
>
> Why did you chosen to do post-processing in the RAW channel instead
> doing it in INFO_SCALE (same as al3010 does)?
>

From my observation INFO_SCALE will just perform multiplication of RAW
to SCALE. In this case values which are read are not actual raw values
of illumination. Next is my assumption (since there is no datasheet),
but values obtained from register are similar to values from adc
thermal sensors, they need be converted via reference table to get
actual data.

> Except this, LGTM.
>
> Documentation and DT patch:
>
> Reviewed-by: David Heidelberg <david@ixit.cz>
> > +
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val =3D 1;
> > +
> > +             return IIO_VAL_INT;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static const struct iio_info al3000a_info =3D {
> > +     .read_raw       =3D al3000a_read_raw,
> > +};
> > +
> > +static int al3000a_probe(struct i2c_client *client)
> > +{
> > +     struct al3000a_data *data;
> > +     struct device *dev =3D &client->dev;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data =3D iio_priv(indio_dev);
> > +     i2c_set_clientdata(client, indio_dev);
> > +
> > +     data->regmap =3D devm_regmap_init_i2c(client, &al3000a_regmap_con=
fig);
> > +     if (IS_ERR(data->regmap))
> > +             return dev_err_probe(dev, PTR_ERR(data->regmap),
> > +                                  "cannot allocate regmap\n");
> > +
> > +     data->vdd_supply =3D devm_regulator_get(dev, "vdd");
> > +     if (IS_ERR(data->vdd_supply))
> > +             return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> > +                                  "failed to get vdd regulator\n");
> > +
> > +     indio_dev->info =3D &al3000a_info;
> > +     indio_dev->name =3D AL3000A_DRV_NAME;
> > +     indio_dev->channels =3D al3000a_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(al3000a_channels);
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +     ret =3D al3000a_init(data);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "failed to init ALS\n");
> > +
> > +     ret =3D devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "failed to add action\n");
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static int al3000a_suspend(struct device *dev)
> > +{
> > +     struct al3000a_data *data =3D iio_priv(dev_get_drvdata(dev));
> > +
> > +     return al3000a_set_pwr(data, false);
> > +}
> > +
> > +static int al3000a_resume(struct device *dev)
> > +{
> > +     struct al3000a_data *data =3D iio_priv(dev_get_drvdata(dev));
> > +
> > +     return al3000a_set_pwr(data, true);
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(al3000a_pm_ops, al3000a_suspend, al300=
0a_resume);
> > +
> > +static const struct of_device_id al3000a_of_match[] =3D {
> > +     { .compatible =3D "dynaimage,al3000a" },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, al3000a_of_match);
> > +
> > +static struct i2c_driver al3000a_driver =3D {
> > +     .driver =3D {
> > +             .name =3D AL3000A_DRV_NAME,
> > +             .of_match_table =3D al3000a_of_match,
> > +             .pm =3D pm_sleep_ptr(&al3000a_pm_ops),
> > +     },
> > +     .probe =3D al3000a_probe,
> > +};
> > +module_i2c_driver(al3000a_driver);
> > +
> > +MODULE_AUTHOR("Svyatolsav Ryhel <clamor95@gmail.com>");
> > +MODULE_DESCRIPTION("al3000a Ambient Light Sensor driver");
> > +MODULE_LICENSE("GPL");
>
> --
> David Heidelberg
>

