Return-Path: <linux-iio+bounces-14211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BFBA0A9F9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28899165191
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4A1B6D18;
	Sun, 12 Jan 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx1SFdMc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240029CA;
	Sun, 12 Jan 2025 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736691566; cv=none; b=NHbrWXq5e68TEQ3/ehC8XH63xSQ5uidrwOYGX3tGe70CUeuFaHO3vsF4Fwjp6aCjdF8+0C69BjjUFz0c9J+ubhIwSRB+76YmqCwGTR/3DDOTGJqx5eQ585lNIMcVzYSkMorxEwaBTrE/v9LigMjO92rkGfgveqp8pj4zGy7pGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736691566; c=relaxed/simple;
	bh=L9AA6/jykH/tNZp8txUFiMRB5zKkgay0NzmIHBGAK4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtRlIoqej7kNbnhaLQCr7D3bKUMK4Rs3gZmztmcAVLPLlMxjXfEFaTwV0cLcKthpj6dG+erInERuo3nrkLFwhBd3yzp4FSFM09ygQHqqqW4fTrOF08LRfVRbnmf/KdLZtQFT1n8HcVGRaTUO8mosT4l9lMLt08CsuDeT8/jFYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx1SFdMc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso637930566b.2;
        Sun, 12 Jan 2025 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736691563; x=1737296363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVzQGR/K9CTG0nOp4/CmbasnWzQitNHR6m9Rk49s5Mk=;
        b=Mx1SFdMcne0ZF7IkHwxQSFq+w0J3KSZytWLxKvYruI7lUE4uOEpaDQ+9m0ZmduX9bR
         DvkPdu4a3/2hnh+6WMkGUNbWhW3mM5H/YIYr0shuId/UoxmBWdG+wJfyS+X2+brZM+Y4
         RzNfOWOgUZ5i6bNvLgd7/Jk4VPJ1PwI+suZU8AvXGWV6hBhzyHPDRAvGBWGEO3A9kj+S
         Wm+FA5tPuHeN/pYZ2B/R5IzeC3OlZ+jXyCg4hP0+Wz+w6oK2C2KH+0xBkVCNO2wRuRcj
         AaiKKZqjJWydt3WBs/KOqNcXEpug+Pt5amYujX5Xhmx3wHj0VhPnCCPui5n6Fa1g1qnJ
         M3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736691563; x=1737296363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVzQGR/K9CTG0nOp4/CmbasnWzQitNHR6m9Rk49s5Mk=;
        b=Rbzo4Oy/GSBNVMlbbE38Al9Vkb3DtqkosNOvr72266IFfiPycT3HfJQ4VA5agQk21l
         1Pq36o8eSNiAAAyIMbcBRK2aMpk8S7Ijwo7wQFJloXc9jLX2kbvDj+WqJ8Br6neysHm+
         DVvEGonFUB+VbrT7iod/29f8UG9wUwM8hlpW+dG8HGqPkY9B7+oPONvPWX0bvJpB/Nnt
         m/a3WHneoG99kpIlBqpSiX9CJlxPWhgd1lYang52TDTcm+9pUiOl7/ieDRvPeTy3ixEe
         7Y9YZvXAOP7gx4I6czosAqbNksut4IqrocSbtPbdMuPJG+5Wk+xIHjKLYWgsCkUxGd/U
         MkHg==
X-Forwarded-Encrypted: i=1; AJvYcCUZcmb6WiJQlY6pucutAlEndHAX3KLgiGXMpMSXEj8DV+HFt/h95Dsa8ODbb6J3AGSNmi7ecxRobIDd@vger.kernel.org, AJvYcCViv4NJOkmi9UwDHB8PVLd9pyYXVW0g8scRnrzAvjs/Y7bw3u65RjCFi2TOdR0SUYOWv0ygUcMBTRly@vger.kernel.org, AJvYcCXUOCSyKSavmqSUkHt5V9vC7Uth7TeQIGHRmj/BhM1M35b+vBy5e1fdMGhYUSvMqs4Scdyuo4LQJJwuEnQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEySly0wu/b3lGkoE1jqGcAHOaeYwQL8pgcRyCdSL/AsFrQxp
	oFDSr9O3Q+tDRSdb0b01lFdizsDeyCPb9rIq7hwofnwoUK/Bwd5mN0+BZ22hxnbpUJ4IdHIrkHd
	8jGH+hxLTggg4w6haKDnh4P87Xx0=
X-Gm-Gg: ASbGnctYq5DtgF0we9OlxgZ5AN026pVjoQyuC3UC9gBd3YjENbn5Gusjg6dF/tyXXh1
	v/MlNmZ/huzIbD2lP4vW6sRgqE7mDG2qQhoP30w==
X-Google-Smtp-Source: AGHT+IFkjNZggIZ69/FQqmDb6nqEd817YwvR0yW0SaVfPQd53PdKOFqtSYjcEjyfDP+YlCiSiSVf48L0M6npkLMwiBU=
X-Received: by 2002:a17:907:2cc5:b0:aab:cd45:5d3c with SMTP id
 a640c23a62f3a-ab2abdbfa0bmr1737645866b.50.1736691563001; Sun, 12 Jan 2025
 06:19:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112104453.45673-1-apokusinski01@gmail.com> <20250112104453.45673-3-apokusinski01@gmail.com>
In-Reply-To: <20250112104453.45673-3-apokusinski01@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 16:18:46 +0200
X-Gm-Features: AbW1kvaNtTCUnUPdtUiIqWCB9gXQqSaQq930TI80RNEMhVxoxjRIjMco_JQgxhI
Message-ID: <CAHp75VedQvf2xwY3fDWX=FQaHyhaUSVJW3Y6Yt2ecpwru756vw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: magnetometer: si7210: add driver for Si7210
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org, 
	icenowy@aosc.io, megi@xff.cz, danila@jiaxyga.com, 
	javier.carrasco.cruz@gmail.com, andy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 12:45=E2=80=AFPM Antoni Pokusinski
<apokusinski01@gmail.com> wrote:
>
> Silicon Labs Si7210 is an I2C Hall effect magnetic position and
> temperature sensor. The driver supports the following functionalities:
> * reading the temperature measurements
> * reading the magnetic field measurements in a single-shot mode
> * choosing the magnetic field measurement scale (20 or 200 mT)

...

Many header inclusions are being missed.

+ array_size.h

> +#include <linux/bitfield.h>

+ bits.h (it's even mentioned in the top comment of bitfield.h)

+ cleanup.h
+ err.h

> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

+ types.h


+ asm/byteorder.h (or is it already available as linux/byteorder.h?),
but it seems that what you actually wanted is linux/unaligned.h (see
below why).

...

> +static const unsigned int a20_otp_regs[A_REGS_COUNT] =3D {
> +       SI7210_OTPREG_A0_20, SI7210_OTPREG_A1_20, SI7210_OTPREG_A2_20,
> +       SI7210_OTPREG_A3_20, SI7210_OTPREG_A4_20, SI7210_OTPREG_A5_20

Please, leave trailing comma(s) when it's clearly not a terminator entry.

> +};
> +
> +static const unsigned int a200_otp_regs[A_REGS_COUNT] =3D {
> +       SI7210_OTPREG_A0_200, SI7210_OTPREG_A1_200, SI7210_OTPREG_A2_200,
> +       SI7210_OTPREG_A3_200, SI7210_OTPREG_A4_200, SI7210_OTPREG_A5_200

Ditto.

> +};

...

> +struct si7210_data {
> +       struct i2c_client *client;

Do we really need a room for that? Isn't it derivable from the below
regmap? Also note the frequency of use of client vs. regmap. The
result in the object file can be much better if regmap becomes the
first member here. Check it (with bloat-o-meter, for example).

> +       struct regmap *regmap;
> +       struct regulator *vdd;
> +       struct mutex fetch_lock; /* lock for a single measurement fetch *=
/
> +       s8 temp_offset;
> +       s8 temp_gain;
> +       s8 scale_20_a[A_REGS_COUNT];
> +       s8 scale_200_a[A_REGS_COUNT];
> +       u8 curr_scale;
> +};
> +
> +static const struct iio_chan_spec si7210_channels[] =3D {
> +       {
> +               .type =3D IIO_MAGN,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +                       BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFS=
ET),
> +       },
> +       {
> +               .type =3D IIO_TEMP,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> +       }

Leave trailing comma.

> +};
> +
> +static int si7210_fetch_measurement(struct si7210_data *data,
> +                                   struct iio_chan_spec const *chan,
> +                                   __be16 *buf)
> +{
> +       u8 dspsigsel =3D chan->type =3D=3D IIO_MAGN ? 0 : 1;
> +       int ret, result;

Why is the result signed? I believe even regmap APIs have it unsigned
in the prototypes.
Ah, it's even worse... See below.

> +       guard(mutex)(&data->fetch_lock);
> +
> +       ret =3D regmap_update_bits(data->regmap, SI7210_REG_DSPSIGSEL,
> +                                SI7210_MASK_DSPSIGSEL, dspsigsel);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(data->regmap, SI7210_REG_POWER_CTRL,
> +                                SI7210_MASK_ONEBURST | SI7210_MASK_STOP,
> +                                SI7210_MASK_ONEBURST & ~SI7210_MASK_STOP=
);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Read the contents of the registers containing the result: DSPS=
IGM, DSPSIGL */
> +       ret =3D regmap_bulk_read(data->regmap, SI7210_REG_DSPSIGM, &resul=
t, 2);

I stumbled over this...

> +       if (ret < 0)
> +               return ret;
> +
> +       *buf =3D cpu_to_be16(result);

...and this piece and I think you got it wrong. What you should do is
just supply a buf with sizeof one element.

ret =3D ..., buf, sizeof(buf[0]));

Otherwise this needs a very good comment explaining what the heck is done h=
ere.

> +       return 0;
> +}
> +
> +static int si7210_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan,
> +                          int *val, int *val2, long mask)
> +{
> +       struct si7210_data *data =3D iio_priv(indio_dev);
> +       long long temp;
> +       __be16 dspsig;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret =3D si7210_fetch_measurement(data, chan, &dspsig);

Oh, but why...

> +               if (ret < 0)

...then the ' < 0' part? What is the positive ret meaning?

> +                       return ret;
> +
> +               *val =3D dspsig & GENMASK(14, 0);
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               *val =3D 0;
> +               if (data->curr_scale =3D=3D 20)
> +                       *val2 =3D 1250;
> +               else /* data->curr_scale =3D=3D 200 */
> +                       *val2 =3D 12500;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       case IIO_CHAN_INFO_OFFSET:
> +               *val =3D -16384;
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_PROCESSED:
> +               ret =3D si7210_fetch_measurement(data, chan, &dspsig);
> +               if (ret < 0)
> +                       return ret;
> +
> +               temp =3D FIELD_GET(GENMASK(14, 3), dspsig);
> +               temp =3D div_s64(-383 * temp * temp, 100) + 160940 * temp=
 - 279800000;

HECTO/CENTI, but I think in this case it's not needed as it is most
likely in alignment with the datasheet.

> +               temp =3D (1 + (data->temp_gain / 2048)) * temp + (1000000=
 / 16) * data->temp_offset;

But here MICRO? MEGA? would make sense to show the scale.

> +               ret =3D regulator_get_voltage(data->vdd);
> +               if (ret < 0)
> +                       return ret;

> +               temp -=3D 222 * div_s64(ret, 1000);

This is conversion from uV to mV IIUC, so replacing it with MILLI
would make it harder to understand I suppose.

> +               *val =3D div_s64(temp, 1000);

MILLI?

> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +static int si7210_read_otpreg_val(struct si7210_data *data, unsigned int=
 otpreg, u8 *val)
> +{
> +       int ret;
> +       unsigned int otpdata;
> +
> +       ret =3D regmap_write(data->regmap, SI7210_REG_OTP_ADDR, otpreg);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(data->regmap, SI7210_REG_OTP_CTRL,
> +                                SI7210_MASK_OTP_READ_EN, SI7210_MASK_OTP=
_READ_EN);
> +       if (ret < 0)
> +               return ret;

> +       ret =3D regmap_read(data->regmap, SI7210_REG_OTP_DATA, &otpdata);
> +       if (ret < 0)

What are those ' < 0' parts for in many  cases? Does it mean we ignore
positive output? Why is it so?

> +               return ret;
> +
> +       *val =3D (u8)otpdata;

Why casting?

> +       return 0;
> +}

...

> +       /*
> +        * According to the datasheet, the primary method to wake up a
> +        * device is to send an empty write. However this is not feasible
> +        * using current API so we use the other method i.e. read a singl=
e

the current

> +        * byte. The device should respond with 0xFF.
> +        */

> +

Unneeded blank line, and TBH, the comment sounds like it should be
rather for the entire function.

> +       int ret;
> +
> +       ret =3D i2c_smbus_read_byte(data->client);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (ret !=3D 0xFF)
> +               return -EIO;
> +
> +       return 0;

Btw, is this the only reason for having the client member in the
private structure? If so, you can derive it from regmap.

...

> +static int si7210_probe(struct i2c_client *client)
> +{
> +       struct si7210_data *data;
> +       struct iio_dev *indio_dev;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data =3D iio_priv(indio_dev);

> +       data->client =3D client;

(Almost) useless?

> +       mutex_init(&data->fetch_lock);

Why not devm_mutex_init()?

> +       data->regmap =3D devm_regmap_init_i2c(client, &si7210_regmap_conf=
);
> +       if (IS_ERR(data->regmap))
> +               return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +                                    "failed to register regmap\n");
> +
> +       data->vdd =3D devm_regulator_get(&client->dev, "vdd");
> +       if (IS_ERR(data->vdd))
> +               return dev_err_probe(&client->dev, PTR_ERR(data->vdd),
> +                                    "failed to get VDD regulator\n");
> +
> +       ret =3D regulator_enable(data->vdd);
> +       if (ret)
> +               return ret;
> +
> +       indio_dev->name =3D dev_name(&client->dev);
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       indio_dev->info =3D &si7210_info;
> +       indio_dev->channels =3D si7210_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(si7210_channels);
> +
> +       ret =3D si7210_device_init(data);
> +       if (ret)
> +               return dev_err_probe(&client->dev, ret,
> +                                    "device initialization failed\n");
> +
> +       return devm_iio_device_register(&client->dev, indio_dev);
> +}

...

> +static struct i2c_driver si7210_driver =3D {
> +       .driver =3D {
> +               .name =3D "si7210",
> +               .of_match_table =3D si7210_dt_ids,
> +       },
> +       .probe =3D si7210_probe,
> +       .id_table =3D si7210_id,
> +};

> +

Wrong place of this blank line...

> +module_i2c_driver(si7210_driver);

...should be here.

> +MODULE_AUTHOR("Antoni Pokusinski <apokusinski01@gmail.com>");
> +MODULE_DESCRIPTION("Silicon Labs Si7210 Hall Effect sensor I2C driver");
> +MODULE_LICENSE("GPL");

--=20
With Best Regards,
Andy Shevchenko

