Return-Path: <linux-iio+bounces-18079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F5AA88458
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1D81902229
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA302DFA35;
	Mon, 14 Apr 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJwNylCd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CA24729D;
	Mon, 14 Apr 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638104; cv=none; b=N1WRCM+DDEGMSvWo3LFBbPSCmevlpBT8ndqrzJkq9BRAyjiaFgst6NmcR39ANvoFBlUI661e5UtLJbxhA68X/4EXagfL+wmXOyJ3ghe4+iDW16h99VC/nQh82fFTN8n4hlN0TzzjmqJ7+lV6BYjDBQcixawZgArUfODaBRtuvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638104; c=relaxed/simple;
	bh=VFIZ8IUvl6sQu41G6YkpR8xVraIpjUX1phEG6i0UBh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVtyu7ims0GRtdnu63wNbDS3CgWN0HSo9Gc7Pqg3A/OvsmOXmxjFqgWQZjxKyOqEp9avB3J1Ox9hrjgLHBQ2OcnQ2Quq7bboWAa9ECPk9dGya+rAn17Xo4pwRoK3Fn5PJkiOC6RzS6zmP6pzGDztQvcPT0BYaoo/dMavjV4dfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJwNylCd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso684032266b.1;
        Mon, 14 Apr 2025 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744638100; x=1745242900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73xHJ9IYiHIaK02xaTMdK7NbfrF6WDOxYWmZYyt7is4=;
        b=dJwNylCdCqAMh9rhlRUpmT2FEWjZTvZ3PzEdy9z8ZrzOEAyvdtJTOZV+7Bw7kkFH7d
         QfqtDEZEGC2K54GJBvh043i40Xx9A5pOagaznc2MYeZQUfqPutG5a4/ZHcbkWtlQnuug
         jNOQqgOoWK5S5mNf/BtXrtFuhLHa++p7yRghcFnysiF7MaoYxk5honll9FQHRgGXfm7W
         XQwHuES2/WzjCrP4wNeIXWbc+iQiPi6K40UUDG0/rnWAeZrWxqhqCMbxb2fm8IOEVIPL
         GoTyw15D+px2kCX+OcMaEiR1iGyN/KfFDtgcLBNiqZJTN+14dW1u1SK5An1RiHWQcoc/
         WrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638100; x=1745242900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73xHJ9IYiHIaK02xaTMdK7NbfrF6WDOxYWmZYyt7is4=;
        b=kXwBBToDa9a/9JQVBdvCTVHpUrwnQ9cslx17JGRWVo6TdX6+tPgPqOIBXPCWMxbx1N
         RdVr1tL/UdrOy8zsqJw0exg7F0H2ZPcp9yQU8s1DFTWNTkxOPOeh5iZXK0OL2vKlJ/XN
         XF38U0FTI+b7DL47sitq8G7lLQmKFFgOZ0CnaRUGL+J7InVwYwxuOW4YmALOD+216LGR
         O7Dz7LrYn7oWpxz6EP7M5o4r8Y6Zn1Nw7zRNMglX+z+bO/Mm2NpVx7i2g9c5OJP/VvzB
         vxthz8rlysucz0JmMUJKLJJdF8e/2ZZivYsIz4F9O4AT7Y7gEGvRd5Dx6UTb/42T8/pH
         R/iw==
X-Forwarded-Encrypted: i=1; AJvYcCU4WjMXcS3kUSK1jNZb/dEFMkMKrANxbbdBgHzVhWtO9fUjYBWhPZruAdRW22W+I9ZPx1/EUEV5UmuW@vger.kernel.org, AJvYcCUjQfSOcrLuU8SPqbItUoE9KmHuUQmI26Lh0oOuD570HxtUFUI4vZwLPJQcmLvBe2AML3RJfFwAyV3W9YGO@vger.kernel.org, AJvYcCXUTcqJ0GFPdMOgAgkLhFgD9JBkIdwTH1SJ4FTT/DgnlUAkwfRyAnzbbIoujLCgU0APUB5U5nDWLotp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqk3mi7lDbytJkI4OddnHA7rcYZq5H7be5JYjSYF2punu5j7rD
	W22pGSnG3WbZSuoNIsWnm4ocyWHXgmAIxY0XDZadLbYFvY1416npYjJSgzOvajGOEi36vrC1DCW
	Bm4lT+nEDZOHuh+7wyiUeaQtM6nY=
X-Gm-Gg: ASbGncsAS4gawhGZKp0vlIVIyLK5gs0h/BXKq7mJ4bG+MLixPF9Fc4XqA+UCgAmmipx
	LXsIqoIbTS0o7pnBYeu/Yk7i/MaWJGryWTpPT3j4F57pzaC+WmrfzTKW31HnO/fTff+ca5Z5EuU
	914caiG6oOFW9vLH3zGgPlsQ==
X-Google-Smtp-Source: AGHT+IEUBXB+ktsYxUFxin7yI8JSpLsDLbeEGr6D25mEE6RXhiuDW8CRdDgitNFauJwognP5bX/GANHUvSy3sHEAg7Q=
X-Received: by 2002:a17:907:944e:b0:ac7:81b2:c6e5 with SMTP id
 a640c23a62f3a-acad36d04fdmr1043991366b.55.1744638099971; Mon, 14 Apr 2025
 06:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409012351.2543450-1-j2anfernee@gmail.com>
 <20250409012351.2543450-3-j2anfernee@gmail.com> <Z_aeEuIk9brES6dM@smile.fi.intel.com>
In-Reply-To: <Z_aeEuIk9brES6dM@smile.fi.intel.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Mon, 14 Apr 2025 21:40:35 +0800
X-Gm-Features: ATxdqUG2e8O27VtT5a1XgBKf9cFzDJdly9huEPojacM_h6OgLdhDriMAHMCYe70
Message-ID: <CA+4VgcKG2EEsicysds0zu7y1xDhg88m3heGUBaQZ7-MVWanCaw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: add support for Nuvoton NCT7201
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	javier.carrasco.cruz@gmail.com, gstols@baylibre.com, tgamblin@baylibre.com, 
	alisadariana@gmail.com, antoniu.miclaus@analog.com, eblanc@baylibre.com, 
	jstephan@baylibre.com, matteomartelli3@gmail.com, 
	angelogioacchino.delregno@collabora.com, herve.codina@bootlin.com, 
	marcelo.schmitt@analog.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Andy,

Thanks for the review and the comments.
Will fix all.

Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E6=96=BC 2025=E5=B9=B4=
4=E6=9C=8810=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:19=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Wed, Apr 09, 2025 at 09:23:51AM +0800, Eason Yang wrote:
> > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> >
> > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up =
to
> > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins fo=
r
> > independent alarm signals, and all the threshold values could be set fo=
r
> > system protection without any timing delay. It also supports reset inpu=
t
> > RSTIN# to recover system from a fault condition.
> >
> > Currently, only single-edge mode conversion and threshold events are
> > supported.
>
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
>
> ...
>
> > +#define NCT7201_VIN_MAX                              12
>
> Is this in volts? Can you add a unit suffix?

Rename it as
#define NCT7201_MAX_CHANNEL 12

>
> ...
>
> > +#define NCT7201_IN_SCALING                           4995
> > +#define NCT720X_IN_SCALING_FACTOR         10000
> Interesting number, just want to confirm it's indeed 4995 and not 4095.
>

These definitions are for real voltage calculations,
the formula is Voltage(V) =3D 13bitCountValue * 0.0004995
However, the definitions are not used anymore.
So remove them.

> ...
>
> > +static int nct7201_read_event_value(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 enum iio_event_info info,
> > +                                 int *val, int *val2)
> > +{
> > +     struct nct7201_chip_info *chip =3D iio_priv(indio_dev);
> > +     unsigned int value;
> > +     int err;
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (info !=3D IIO_EV_INFO_VALUE)
> > +             return -EINVAL;
>
> > +     if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > +             err =3D regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_L=
IMIT(chan->address),
> > +                               &value);
> > +             if (err < 0)
> > +                     return err;
> > +     } else {
> > +             err =3D regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_=
LIMIT(chan->address),
> > +                               &value);
> > +             if (err < 0)
> > +                     return err;
> > +     }
>
>         if (dir =3D=3D IIO_EV_DIR_FALLING) {
>                 err =3D regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_L=
IMIT(chan->address),
>                                   &value);
>         } else {
>                 err =3D regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_=
LIMIT(chan->address),
>                                   &value);
>         }
>         if (err)
>                 return err;
>
> Here and elsewhere why ' < 0' is used? Do you expect positive return valu=
es
> from those?
>

In regmap_read function, A value of zero will be returned on success,
a negative errno will be returned in error cases.
We don't have a positive return case.


> > +     *val =3D FIELD_GET(NCT7201_REG_VIN_MASK, value);
> > +
> > +     return IIO_VAL_INT;
> > +}
>
> ...
>
> > +static int nct7201_write_event_value(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir,
> > +                                  enum iio_event_info info,
> > +                                  int val, int val2)
> > +{
> > +     struct nct7201_chip_info *chip =3D iio_priv(indio_dev);
>
> > +     int  err =3D 0;
>
> Useless assignment.
>

> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (info !=3D IIO_EV_INFO_VALUE)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (dir =3D=3D IIO_EV_DIR_FALLING) {
> > +             err =3D regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_=
LIMIT(chan->address),
> > +                                FIELD_PREP(NCT7201_REG_VIN_MASK, val))=
;
> > +             if (err < 0)
> > +                     return err;
> > +     } else {
> > +             err =3D regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH=
_LIMIT(chan->address),
> > +                                FIELD_PREP(NCT7201_REG_VIN_MASK, val))=
;
> > +             if (err < 0)
> > +                     return err;
> > +     }
> > +
> > +     return 0;
>
>         if (dir =3D=3D IIO_EV_DIR_FALLING) {
>                 err =3D regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_=
LIMIT(chan->address),
>                                    FIELD_PREP(NCT7201_REG_VIN_MASK, val))=
;
>         } else {
>                 err =3D regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH=
_LIMIT(chan->address),
>                                    FIELD_PREP(NCT7201_REG_VIN_MASK, val))=
;
>         }
>         return err;
>
>
> > +}
>
> ...
>
> > +static int nct7201_write_event_config(struct iio_dev *indio_dev,
> > +                                   const struct iio_chan_spec *chan,
> > +                                   enum iio_event_type type,
> > +                                   enum iio_event_direction dir,
> > +                                   bool state)
> > +{
> > +     struct nct7201_chip_info *chip =3D iio_priv(indio_dev);
> > +     unsigned int mask;
> > +     int err;
> > +
> > +     if (chan->type !=3D IIO_VOLTAGE)
> > +             return -EOPNOTSUPP;
> > +
> > +     mask =3D BIT(chan->address);
> > +
> > +     if (state)
> > +             chip->vin_mask |=3D mask;
> > +     else
> > +             chip->vin_mask &=3D ~mask;
>
> > +     if (chip->num_vin_channels <=3D 8) {
> > +             err =3D regmap_write(chip->regmap, NCT7201_REG_CHANNEL_EN=
ABLE_1,
> > +                                chip->vin_mask);
> > +             if (err < 0)
> > +                     return err;
> > +     } else {
> > +             err =3D regmap_bulk_write(chip->regmap, NCT7201_REG_CHANN=
EL_ENABLE_1,
> > +                                     &chip->vin_mask, sizeof(chip->vin=
_mask));
> > +             if (err < 0)
> > +                     return err;
> > +     }
> > +
> > +     return 0;
>
> Same as above.
>
> > +}
>
> ...
>
> > +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> > +{
> > +     u8 data[2] =3D {0};
>
> '0' is not needed. Shouldn't this be __le16 or __be16 instead?
>

+ __be16 data =3D NCT7201_REG_CHANNEL_ENABLE_MASK;

> > +     unsigned int value;
> > +     int err;
> > +
> > +     err =3D regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> > +                        NCT7201_BIT_CONFIGURATION_RESET);
> > +     if (err < 0)
> > +             return dev_err_probe(&chip->client->dev, -EIO,
>
>         struct device *dev =3D &chip->client->dev;
>
> at the top of the function will help a lot in tiding up the below code.
>
> Shadowed error code, why?
>

Do not shadow the return code by -EIO and let the regmap API caller decide.

> > +                                  "Failed to write NCT7201_REG_CONFIGU=
RATION\n");
> > +
> > +     /*
> > +      * After about 25 msecs, the device should be ready and then the =
Power
> > +      * Up bit will be set to 1. If not, wait for it.
> > +      */
> > +     mdelay(25);
>
> No sleep? Why? Can't you use fsleep()?
>

+ msleep(25);

> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value=
);
> > +     if (err < 0)
> > +             return err;
> > +     if (!(value & NCT7201_BIT_PWR_UP))
> > +             return dev_err_probe(&chip->client->dev, -EIO,
>
> Shadowed error code, why?

Do not shadow the return code by -EIO and let the regmap API caller decide.

>
> > +                                  "Failed to power up after reset\n");
> > +
> > +     /* Enable Channel */
> > +     if (chip->num_vin_channels <=3D 8) {
> > +             data[0] =3D NCT7201_REG_CHANNEL_ENABLE_1_MASK;
> > +             err =3D regmap_write(chip->regmap, NCT7201_REG_CHANNEL_EN=
ABLE_1, data[0]);
> > +             if (err < 0)
> > +                     return dev_err_probe(&chip->client->dev, -EIO,
>
> Why error code is shadowed?
>

Do not shadow the return code by -EIO and let the regmap API caller decide.

> > +                                          "Failed to write NCT7201_REG=
_CHANNEL_ENABLE_1\n");
> > +     } else {
> > +             data[0] =3D NCT7201_REG_CHANNEL_ENABLE_1_MASK;
> > +             data[1] =3D NCT7201_REG_CHANNEL_ENABLE_2_MASK;
> > +             err =3D regmap_bulk_write(chip->regmap, NCT7201_REG_CHANN=
EL_ENABLE_1,
> > +                                     data, ARRAY_SIZE(data));
> > +             if (err < 0)
> > +                     return dev_err_probe(&chip->client->dev, -EIO,
>
> Ditto.
>
> > +                                          "Failed to write NCT7201_REG=
_CHANNEL_ENABLE_1 and NCT7201_REG_CHANNEL_ENABLE_2\n");
> > +     }
>
> Just make it 16-bit type, define one value and use just simple English
> in the error message: "Failed to write channel enable mask\n");
>
> Same to all your error messages.
>

We would examine all the error messages in simple English.

> > +     chip->vin_mask =3D get_unaligned_le16(data);
> > +
> > +     /* Start monitoring if needed */
> > +     err =3D regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &val=
ue);
> > +     if (err < 0)
> > +             return dev_err_probe(&chip->client->dev, -EIO,
> > +                                  "Failed to read NCT7201_REG_CONFIGUR=
ATION\n");
>
> > +     regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION, NCT7201_=
BIT_CONFIGURATION_START);
>
> > +     return 0;
>
> No error check? Why?
>

+ err =3D regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION,
+       NCT7201_BIT_CONFIGURATION_START);
+ if (err)
+ return dev_err_probe(dev, err, "Failed to start monitoring\n");


> > +}
>
> ...
>
> > +static int nct7201_probe(struct i2c_client *client)
> > +{
> > +     const struct nct7201_adc_model_data *model_data;
>
>         struct device *dev =3D &client->dev;
>
> > +     struct nct7201_chip_info *chip;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     model_data =3D i2c_get_match_data(client);
> > +     if (!model_data)
> > +             return -EINVAL;
>
> ENODEV is more suitable here.
>
+ return -ENODEV

> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +     chip =3D iio_priv(indio_dev);
> > +
> > +     chip->regmap =3D devm_regmap_init_i2c(client, &nct7201_regmap8_co=
nfig);
> > +     if (IS_ERR(chip->regmap))
> > +             return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
> > +                                  "Failed to init regmap\n");
> > +
> > +     chip->regmap16 =3D devm_regmap_init_i2c(client, &nct7201_regmap16=
_config);
> > +     if (IS_ERR(chip->regmap16))
> > +             return dev_err_probe(&client->dev, PTR_ERR(chip->regmap16=
),
> > +                                  "Failed to init regmap16\n");
> > +
> > +     chip->num_vin_channels =3D model_data->num_vin_channels;
>
> > +     chip->client =3D client;
>
> How exactly is _client_ used elsewhere? Shouldn't it be just a struct dev=
ice
> pointer?

Yes, it is just a struct device pointer.
In nct7201_init_chip(chip), we would use the chip->client->dev as
dev_err_probe() parameter
>
> > +     ret =3D nct7201_init_chip(chip);
> > +     if (ret < 0)
>
> Do you expect positive returned values? What is their meaning?
> Why do you skip them?
>

No, we don't expect positive return values.

> > +             return ret;
> > +
> > +     indio_dev->name =3D model_data->model_name;
> > +     indio_dev->channels =3D model_data->channels;
> > +     indio_dev->num_channels =3D model_data->num_channels;
> > +     if (client->irq)
> > +             indio_dev->info =3D &nct7201_info;
> > +     else
> > +             indio_dev->info =3D &nct7201_info_no_irq;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +     return devm_iio_device_register(&client->dev, indio_dev);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

