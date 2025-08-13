Return-Path: <linux-iio+bounces-22657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D39B2474E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488611AA179F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4F2F49ED;
	Wed, 13 Aug 2025 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PURmZRTq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E050212556;
	Wed, 13 Aug 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081194; cv=none; b=HFwruRm2lFKQeQQ+TuNKEuw5EWtTxoaIlYwyKLUZCd2oXWdvaxS/N8MQLLZVziYVyIhvvYDEuDkUddAXKk15tl61nnk+DS89bYicctfymlrXxc/PAk3KjMkO1FyjNCOMMjAjaIC7eM02Gb+YN7zGpfHG9+YfiqgHE47VpeLKsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081194; c=relaxed/simple;
	bh=Z1Hn4HXV90z37zqkBIruZmJ7JA38MhBLP+Edi7CtcUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rM/wQ2P1DTkMorQjm/ZossR34lCEmCE9oie+aUEY7ev2b0sT31Ps6mksxQc9stiLaCUjVHJbHZCddzBk2HHM+nzuFrAsod4nKE88Fyq4HWbf+mK/ao0FJLTliGcw8BHphDqed1iwNwYiw28ts7R2uVQRVmuqSoWqYvDhi3LxDKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PURmZRTq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af968aa2de4so1142146566b.1;
        Wed, 13 Aug 2025 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755081191; x=1755685991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoHPULbI5wuoZ1YdxWM5wh2d8cLuaTCdw6lqxODddaw=;
        b=PURmZRTqog/cIVHAOeOxuykFR11oojVFi1hPKlUBnYH0wyRpMH6wbfGDjdf3Tl4XuV
         4uGHx2mlWx6jMy1Jtvz0qef8nkK1ZMZi6VRV1iWgETiTBKCR9bA7tawnxrUF496ehIZS
         +2JY499ggDKQ2QfOSTkqGbG7bcOaB1u2ct00GgaDpqZX5Tq9JvxguaQou4ocussxVnKK
         M0IkYD56J21rRg73xgALswUFXKghGn/gb/YIIkAi88uhCzzlPYb7TuVwMVdvakFgUAL2
         P4qnOWOcceYEWhN7j7aVWGPGtVeEhVpTKOwTQ5n4dpIUHHdtkn1Jk0Dqnz5kEAfIUxme
         QEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081191; x=1755685991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoHPULbI5wuoZ1YdxWM5wh2d8cLuaTCdw6lqxODddaw=;
        b=Bt8RQCxQ9w/higwoy9zFs2v37cBM77AZVxz0bGs+2gUhejy4/FyQiUgh0No0v98UaI
         F6oi9E8JiRi5pIFriIMxV2tYVaSwdjYgIbDnFKzmrnxjPCmyLadnnUBWy0KOlrTVFLJH
         aNx74o55wt86dskc8lQjfiP70WQWqv+GJUhEiHgGAOXCCmJoidbqqV7Kc3PV8IKQyxTC
         PJ+zE+M1TfZg0M5WNTW/Q914NOHoOfZBmahhinF9yEmBnKdphiS0qkEfTd6WbR20S5zg
         LhBBOGYhTFYAhaOY/ODP7tRAsKfds2ByxKOWNlXcj/WGU/czN+iLdNKez0qi0DXMUhv6
         dQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaZrWZydrww+VSVtaZMOzxWZPQQiBFMVn7IFRupD1F/QK+pLuoF/H4aEIsK1QJ12kuNSPq04FXAuR1@vger.kernel.org, AJvYcCWbNeM8R4VP26SiLTmiyjhp6muRgT/VE5XAT99K2AUN3jxtIpRse9XOUPOkWd9Zuq4DoO3WLDhZ0uKHZbVP@vger.kernel.org, AJvYcCXFpr6uAQ/4vezB62b4AvuSFMK0EF5c4W9jljY1lYFnh6qL3wk5KQ2VBAeKv9s4u5i9t+h3VECcPaDC@vger.kernel.org
X-Gm-Message-State: AOJu0YxzoxjutqhuTW7tsryNONFdYfloOCXmOLxNE/A47fvWtbGID9fH
	ea/UWmQyHH3D/wMBNmadJOOQD0FubMyMQbwqQoKDVEfQbI0+/p56ARPeU/Y0rGrSLAOjKm2a4AJ
	cH8j8qC4J2dGiEFR4KkyGgvkExf0MErs=
X-Gm-Gg: ASbGnctwsqiCc99PP6gSSCyja7urljuTUaxy2qZYOpRMElbGV9J6oQQZBkMeQeEqPkD
	aGBZtSv4WpMgl6/5HRFmlF57eBRXDOLXroMuBMWfCx3QSXhyAmziWvQ1u4vlJXMcgCxUaKaxUtV
	ZvOfz0m//i+bHO86F4Ru6BW8RQF0w9eQbIO0weWL7Hi9Hx3Z/vZWe3GCNdGBRG73a+t1X8QT48x
	o+6XmHItQ==
X-Google-Smtp-Source: AGHT+IHvBEa00ScGrDIDnQYMzvTcURv3pXbGkzyXKZy9fjPacKMzA5Dy8/GaLaod0q+nPnUakcE+zaBDQ0e49cQdG4M=
X-Received: by 2002:a17:907:94c6:b0:af9:c31c:eeca with SMTP id
 a640c23a62f3a-afca4f03214mr260708266b.48.1755081190989; Wed, 13 Aug 2025
 03:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com> <20250812-ltc2495-v1-3-7bf4c6feec2e@gmail.com>
In-Reply-To: <20250812-ltc2495-v1-3-7bf4c6feec2e@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 12:32:34 +0200
X-Gm-Features: Ac12FXxjxkaJujszOO8N7Lcd-0HGt-KfpmhgX0vJ-9qifttuWJ9Lxc72e0FKIU4
Message-ID: <CAHp75Vd-3OwHfyDSH_+GtbD8zNaz8qi2WQZD1kHM0GfUnRXRnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ltc2497: add temperature sensor support
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 7:09=E2=80=AFPM Yusuf Alper Bilgin
<y.alperbilgin@gmail.com> wrote:
>
> The LTC2495 and LTC2499 include an internal temperature sensor. This
> patch adds support for reading it via a standard IIO temperature
> channel.

..

>  static const struct ltc2497_chip_info ltc2496_info =3D {
>         .resolution =3D 16,
>         .name =3D NULL,
> +       .has_temp_channel =3D false,
>  };

Unneeded change.

...

>  static int ltc2497core_read_raw(struct iio_dev *indio_dev,
> -                           struct iio_chan_spec const *chan,
> -                           int *val, int *val2, long mask)
> +                               struct iio_chan_spec const *chan,
> +                               int *val, int *val2, long mask)

Unrelated change.

...

> +               switch (chan->type) {
> +               case IIO_VOLTAGE:
> +                       *val =3D ret / 1000;

Don't remember if we have something like MICROVOLT_PER_MILLIVOLT.

> +                       *val2 =3D ddata->chip_info->resolution + 1;
> +
> +                       return IIO_VAL_FRACTIONAL_LOG2;
> +
> +               case IIO_TEMP:
> +                       if (!ddata->chip_info->has_temp_channel)
> +                               return -EINVAL;
> +
> +                       /*
> +                        * The datasheet formula to get Temperature in Ce=
lsius is:
> +                        * Temp_C =3D (Conversion * Vref / temp_scale) - =
273
> +                        *
> +                        * To match the IIO framework's model of (raw + o=
ffset) * scale,
> +                        * and to get the final result in millidegrees Ce=
lsius:
> +                        *
> +                        * =3D ((Conversion * Vref / temp_scale) - 273) *=
 1000
> +                        * =3D (Conversion - (273 * temp_scale / Vref)) *=
 1000 * Vref / temp_scale

 * Temp_mC =3D ... =3D
 *                      ...

I.o.w. make it more explicit, otherwise those dangling equal signs are
not helpful.

> +                        *
> +                        * This gives us if the Vref is in mV:
> +                        * scale  =3D Vref * 1000 / temp_scale
> +                        * offset =3D -273 * temp_scale / Vref
> +                        */
> +                       *val =3D ret;
> +                       *val2 =3D ddata->chip_info->temp_scale;
> +
> +                       return IIO_VAL_FRACTIONAL;
> +
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_OFFSET:
> +               if (chan->type !=3D IIO_TEMP)
> +                       return -EINVAL;
> +
> +               /* see the calculation above. Offset with (-273 * temp_sc=
ale / Vref) */
> +               ret =3D regulator_get_voltage(ddata->ref);
> +               if (ret < 0)
> +                       return ret;
>
> -               return IIO_VAL_FRACTIONAL_LOG2;
> +               *val =3D -273 * ddata->chip_info->temp_scale;
> +               *val2 =3D ret / 1000;

I remember we have some constants in units.h for degrees, but don't
remember if they are for Kelvin only or Celsius also included. Please,
check and use, if available.

> +               return IIO_VAL_FRACTIONAL;
>
>         default:
>                 return -EINVAL;
>  }

...

> +#define LTC2497_T_CHAN() {                                              =
                       \

Why parentheses?

> +       .type =3D IIO_TEMP,                                              =
                         \
> +       .channel =3D 0,                                                  =
                         \
> +       .address =3D (LTC2497_TEMP_CMD_ADDR),                            =
                         \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),                  =
                         \
> +       .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_=
CHAN_INFO_OFFSET),       \
> +}

...

> +       /* Dynamically create the channel list */
> +       if (ddata->chip_info->has_temp_channel) {
> +               /* Allocate space for common channels + 1 temp channel */
> +               indio_dev->num_channels =3D ARRAY_SIZE(ltc2497core_channe=
l) + 1;
> +               indio_dev->channels =3D devm_kmemdup(dev, ltc2497core_cha=
nnel,

Why not devm_kmemdup_array() ?

> +                                                  sizeof(ltc2497core_cha=
nnel), GFP_KERNEL);

sizeof(*...)

> +               if (!indio_dev->channels)
> +                       return -ENOMEM;
> +
> +               memcpy((void *)&indio_dev->channels[ARRAY_SIZE(ltc2497cor=
e_channel)],

This is a strange style, can you improve it?

> +                      &ltc2497_temp_channel, sizeof(ltc2497_temp_channel=
));
> +       } else {
> +               indio_dev->channels =3D ltc2497core_channel;
> +               indio_dev->num_channels =3D ARRAY_SIZE(ltc2497core_channe=
l);
> +       }

...

> +       if (ddata->chip_info->has_temp_channel) {
> +               if (address =3D=3D LTC2497_TEMP_CMD_ADDR)
> +                       ret =3D i2c_smbus_write_byte_data(st->client, LTC=
2497_ENABLE,
> +                                                       LTC2497_TEMP_CMD_=
ADDR);
> +               else
> +                       ret =3D i2c_smbus_write_byte_data(st->client, LTC=
2497_ENABLE | address,
> +                                                       LTC2497_EN2);

> +

Stray blank line.

> +       } else {
> +               ret =3D i2c_smbus_write_byte(st->client, LTC2497_ENABLE |=
 address);
> +       }
> +
>         if (ret)
> -               dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
> -                       ERR_PTR(ret));
> +               dev_err(&st->client->dev, "i2c transfer failed: %pe\n", E=
RR_PTR(ret));
>         return ret;

...

>         [TYPE_LTC2497] =3D {
>                 .resolution =3D 16,
>                 .name =3D NULL,
> +               .has_temp_channel =3D false,
>         },

Unneeded change.

...

>         [TYPE_LTC2499] =3D {
>                 .resolution =3D 24,
>                 .name =3D "ltc2499",
> +               .has_temp_channel =3D true,
> +               .temp_scale =3D 1570000, /* 1570 V per degree C -> 157000=
0 mV */

1570V ?! Hmm...

>         },

...

> +#define LTC2497_ENABLE         0xA0
> +#define LTC2497_EN2            0x80
> +#define LTC2497_IM             0x40

Are those bit masks / bits in the register? Offsets?

> +#define LTC2497_TEMP_CMD_ADDR  (LTC2497_EN2 | LTC2497_IM)

This is really strange naming for... what exactly? Can a comment be added?


...

>  struct ltc2497_chip_info {
>         u32 resolution;
>         const char *name;
> +       bool has_temp_channel;
> +       u32 temp_scale; /* in mV, for temp conversion */

Then simply add a (mV, yes, with capital V) suffix to the field name.

>  };

Have you run `pahole`? Does it agree with the proposed layout?

--=20
With Best Regards,
Andy Shevchenko

