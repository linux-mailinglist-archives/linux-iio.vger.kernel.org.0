Return-Path: <linux-iio+bounces-15567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A411A374E6
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC803AF270
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDCB1991AE;
	Sun, 16 Feb 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boAdKouQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50C481B6;
	Sun, 16 Feb 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718042; cv=none; b=CgA2dmhXiSVlmojZFJ+1ZBFMR3Lh5kNUWlYMbRPzT1pLAeHTNJzEitISbO1nYAigP2RDnSU+EOEi49tI6zgSmB9w6lPzzHENVqYBc7eCtLZ/+bB5drz0vd8tlKdhxSdBvdmSzB8uEbv8/zJnLCi5PGKZH3HaTy+8G0wJVZj2ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718042; c=relaxed/simple;
	bh=xWu5AMDcB/b1rlBeAaHe2jTry3zxNH8L9O7xE/k+aOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FophooCFYy0294CjiMkL8uw5bCHUS3sMy+IAGAK/ApOw4XZf2OyVWnOYWXX4qHUv0N5Q/CDaJGckotWDv/oXmvyz4qzgkt/vD56wetqJf/ehUJA8l3O30xpguq1t8Xkw+yrZHVf6JtLSa/vA7DmSPegHsCead1XCsZLk1RF5HFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boAdKouQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43967004304so14631145e9.2;
        Sun, 16 Feb 2025 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739718038; x=1740322838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYc8zE2dH/HQVe/SrTqs+pYMIPfy617kKGj1N+1qpYs=;
        b=boAdKouQTFua4/pYABv19eW3FRsEtvKqOiBQ0uAWoEN3yopOIzcbhY1JJG7l2kfapk
         3Vp8xDjZcJpvvEqQEZmD1cJqtRcOdNpK2GavJ8oxKzGuZXma5CmjZkWjtdRF5frD3F8T
         rMhDBwOWoHviZE34Q1Pfydq+XEYCLhrT42xwJXqG3uYSVrH50+OmyKplXSqEJ4V4tOMs
         8DjpSQus2ofxefmLMFpOoZKQiu8weOlZbKcR/VOeHLFI7qkO2ju4hrrhRr3H8BtFTKSz
         wvPizyQu5tMn04pMqRAvH3ZIiqtwfw/axim1esVmOLzQKQu1M2glXucn+sA2lcPW07Mw
         Vitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739718038; x=1740322838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYc8zE2dH/HQVe/SrTqs+pYMIPfy617kKGj1N+1qpYs=;
        b=gmwtAopoa4eRl7lR5nCRJVNUzh1q0y6ONz3ib3R9M8WnFH3o0HYqQ+ICHE3J/roDD2
         Sv46qr8b6BpHtDNOQjzcHTwBeCZP/1k21E5sV0cPGpDj2nkTV/ef3aDqSd4fn+57aTue
         juSvtfqeNJHHd5N+HkpWFVk2uEpKePnDVUuO/SmBL0tINbnN+RLJgnm2D3kCsNi/tU7R
         +SmbtiWAT8BnWjkeYaiyqvoOva/XDKOrjqkS0oaXancX9TP6FlJGTSFmwx7dVZAOz4fS
         erPRXwibWQjvVp5UfjmZcR8dDcr5QyzqS7edBX5rCluKEOoyWIfsWAbX7SkKBkZVbIl1
         XQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+qVyPX3EKxnLd6MOeCSQ0ofvPlXys60jNHlQhagpWLJ7o/vr21O3tePCd98jUtToMAb+xZUoAYmDnK0=@vger.kernel.org, AJvYcCWRsGileGj38dbL0ETRHAmW0RZBk0oeC25n2B4Ngdcr1n9pcq0Hw3qedjyBLqwN/mnxNJsxK4OmNel3gveK@vger.kernel.org, AJvYcCWpYPtogiUOaYyXPeNw/SbklK81wok5Z/3yWWvZE4dEB2RQHKKCfcdLD+rC/VrM8ubJ33eBcuaZ1x2A@vger.kernel.org, AJvYcCX72XmddJbNmHdSTDov69AsqXpiDGYFnesLQwTdqq23wJXVMx6l+HcRA8OtHWb0Vw5PcwQ7kp6N26nD@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPvxpVDq1e9n0nuk/orQc6s3JeedDYvr6LJjLgDhEwI/BDd+h
	Yl3VwcCodUC6rA27jDvc565JYGUifkgZpxQenP1MOQkZBn/dJzhlE72GhL58NcQG4yJnmj9u8dW
	5SyHmbAROL9NXEGmYVMtnVQhetsM=
X-Gm-Gg: ASbGnctjLrlinyv9q8IU4JMi2tH0A1R8miS7I6OSGpSppEJpTueRPUuF9XRqGHIw/8X
	M/qGIQHWpa1hVYIj7XbetVRJ2WHkaAP9PaOXFA/J1brfhdNcIIJMoJ2GgG2fdc4vrFMwAdCQNzw
	==
X-Google-Smtp-Source: AGHT+IGMFN6PDlWv2aXvF+GdUDrJHQv5I/i33JVGy1lwTBeYCGtRdoin6I2fUp0vPIqKxudIOgXmNxl9m6ihZTjPiLo=
X-Received: by 2002:a05:600c:510c:b0:439:5573:933c with SMTP id
 5b1f17b1804b1-4396e739c67mr49080025e9.20.1739718038044; Sun, 16 Feb 2025
 07:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215103159.106343-1-clamor95@gmail.com> <20250215103159.106343-3-clamor95@gmail.com>
 <20250216145445.1278b6ae@jic23-huawei>
In-Reply-To: <20250216145445.1278b6ae@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 16 Feb 2025 17:00:26 +0200
X-Gm-Features: AWEUYZlPB9PR963HkziPQ5GEqBhqUTPZc-qjUUsRkmxsSP1AlZjKiXhEneBJjOM
Message-ID: <CAPVz0n1529ydFRHn9N3jEsS8Rhdf-c4xECkMd9TDczzBTNuJzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 16 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:54 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, 15 Feb 2025 12:31:58 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > AL3000a is a simple I2C-based ambient light sensor, which is
> > closely related to AL3010 and AL3320a, but has significantly
> > different way of processing data generated by the sensor.
> >
> > Tested-by: Robert Eckelmann <longnoserob@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> Hi,
>
> A few really minor comments inline.  A nice small driver :)
>
> Jonathan
>
>
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
> The iio/sysfs.h header is a bit of a legacy thing.  Ideally we will
> eventually get rid of it.  In this driver, you are correctly not using
> anything it provides so drop this include.
>
> > +
> > +static const struct iio_chan_spec al3000a_channels[] =3D {
> > +     {
> > +             .type =3D IIO_LIGHT,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> As below. I'm a little confused on units, but this may want to just
> be BIT(IIO_CHAN_INFO_PROCESSED)
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
>
> The two flows are different enough I'd split this into power on and power
> off functions.  Will be a few lines longer but slightly easier to read.
>
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
>
> regmap functions return <=3D 0 in all cases. So you can just do if (ret)
> or in cases like this save a few lines with
>
>         return regmap_write();
>
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
> I may have misinterpreted the other thread.  IS this value in lux?
> If it is make this channel IIO_CHAN_INFO_PROCESSED instead.
>

This is actually a really good hint, I will check if this works out
and if yes, then definitely will use it. Thank you.

> > +
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val =3D 1;
>
> Either way, default scale is 1 so this should not be expressed at all.
>
> > +
> > +             return IIO_VAL_INT;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static const struct iio_info al3000a_info =3D {
> > +     .read_raw       =3D al3000a_read_raw,
>
> I'd not put a tab in the middle.  Single space is fine.
> This sort of alignment is a pain for long term maintenance anyway
> as we get very noisy patches realigning things.
> It makes even less sense with only one item!
>
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
>
> As there is no actual reason why this name should necessarily match the
> name of the driver I'd prefer to see the string expressed directly in bot=
h
> places.  That avoids giving the wrong impression as the driver gains supp=
ort
> for additional devices and generally makes things slightly easier to revi=
ew.
>
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
>
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(al3000a_pm_ops, al3000a_suspend, al300=
0a_resume);
> > +
> > +static const struct of_device_id al3000a_of_match[] =3D {
> > +     { .compatible =3D "dynaimage,al3000a" },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, al3000a_of_match);
>
> Also provide the i2c_device_id table as it's used for autoprobing of the
> driver (long story for why we still need that!)
>
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

Everything else, acknowledged and accepted. Thank you.

