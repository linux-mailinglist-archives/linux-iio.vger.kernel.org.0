Return-Path: <linux-iio+bounces-27346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117FCDB5E1
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 06:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A04D4302278F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 05:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD79329E61;
	Wed, 24 Dec 2025 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWcodOK4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938F261B96
	for <linux-iio@vger.kernel.org>; Wed, 24 Dec 2025 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766552799; cv=none; b=QdcaTCfHFM9m4OnA9ltk2NuMYCMBchGVNsifUqaF0mpOqRsT70vmS/05JYMlsdC650i5AhYut+0bRmpf9V0piuoAF8PqcY+BXBqdBL83Y4XmWcVKHYA4pm5V45gvtwB4FsQUQN9Sp1dXbDmouqbkV4xUBYNj06huU+KEWU96v6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766552799; c=relaxed/simple;
	bh=ZRjHbzQRwdXirfqeW3uAuukkeUm8Tr5pjB3gFk/86hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feFCmfk8z4aecLm250Bdk3gkwBL9Jv+Bn9Za0UOnZv3Pd3imMDbp6QmOEbwdomnmjMLu7wYfYsHtD0tOXwYVL4BWTGiUSQZ4o7vgnBTiYsZR0D+AxPCSeooZ3YhXAYBsg6OMatS1t40AC2FCAk8OPnRwPoK+oHiITR85CQ1WuEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWcodOK4; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso4809293137.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 21:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766552797; x=1767157597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0Z+vSnUInEBE0+F7cGpFX124Y59xnHr9Fzvp2HHfTQ=;
        b=QWcodOK4g+WrqyTbDP7GYPTRHxHIukOCm3CZfOhBE0+Clmm0qDmZhOdxWEjWpNkUAL
         gjfD2z4I8kf4oyeAK4k2M8/U7OEkk/B0t7jU0yg3mcLU8nsKart/UM/lBkqCBwFcvF0e
         vmkyu0jeTocKECvFwadjY04OaEWf7WCDPTYJDvXOai6P86f9uCJSZT7vX0MMRCD9jJ84
         n2SEVDE0lux/8+wzR7uPNUsZjNuG3IWfsisZHB3+yHNBcdJgYiMO0QR76IpU4UkOmkwE
         dR7U2IqagMRJdJxQraUDpISLVXUjNCamFK1tKoYCV5sKJjOwKdSiOBxoVoZhyHNZ7QVG
         G6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766552797; x=1767157597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0Z+vSnUInEBE0+F7cGpFX124Y59xnHr9Fzvp2HHfTQ=;
        b=MAEN9nfB1zPw7BE7FJIXvCwX/JSd8CUm595ywXe2cM5+oC3c5ouOvd8brEMJO/sI/Q
         oHVVdkNpZwTAeGLO0c06aegbv12dNLmrQVv9js5869HMemJPmBf6xObjUmGUURImV5xz
         tA8uwfbHOgkmL13LJMIxX+dw7ap1kSG4Bin9Id2+fSlfe8Unr3UBt+qP4c0MmAQskVq/
         77FOMAHEcCV0NzqCRo3NSR6gCIzBsHxM+xTliO9tpHgIS/5E/coizxgVrPJ87hQ4XXwh
         rfsrNei5WUDpFsCLpLQrbvnmstToRwc1Z6WvK3KjYfl5gKUAG1ysr9hn6mHzPcjMPrVT
         VF/w==
X-Forwarded-Encrypted: i=1; AJvYcCUu3NFCkgLociIkw/dOA3vBbt1P5EdMaESCmlWBTrwaEWkoZiDz8+oT1vWWqOJNA5R7nH1p3cc81BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNwGWVwd+1YWMK6hCGx41H44szmlU1WhX/+k6TXuuen81idtK
	kOAzDoItCqhiShQKVWy6rqjHytM3scEe+dH7bdqdyUmFTygr8TVLnMc9nkkN1yHH5I4sBUI1aSD
	GNPZJ4tsGDvoS56YV0EczIZQtC1OzNPg=
X-Gm-Gg: AY/fxX73DOyP/9OBgThJn8gJ8ZAHK8iYb2P2Ssx5Ru9HA0EaYaaER49q7vzuJLZi7j7
	cr41xprOIUzZmwaDvjI1kU9BRedq53+yhHxDGap5U2z1WhH0M0nlG+mlELBrX8JqYRhC2Bg3WTa
	t4iglUnqV/kq/gurHM01wIrHSqllp9pw5v05irMo7iI8UDytMVw3ZG/vsLOzI+1EtrDEg8q0WrX
	z798KHnx27U9EHI9tu0tY5KIs0dtSn1NTQH/WhsDjY6N9lOGc+eXnn5MLhgRr0WwYekD3PF
X-Google-Smtp-Source: AGHT+IGPQMgNuAtcAYNTlmeTpGcoEmpCSbtFP0CzsmKPk4izscQPSZ4InBAXpBr6spXJQ9Bd9T1LEtEwoxcP/dAxRU4=
X-Received: by 2002:a05:6102:5689:b0:5db:d07c:21a8 with SMTP id
 ada2fe7eead31-5eb1a7d5994mr6132285137.25.1766552796723; Tue, 23 Dec 2025
 21:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com>
 <20251223-add_ltc2305_driver-v1-2-dfa0827fd620@gmail.com> <1a257edd-2179-4653-be22-10e44681bb60@baylibre.com>
In-Reply-To: <1a257edd-2179-4653-be22-10e44681bb60@baylibre.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 24 Dec 2025 13:06:25 +0800
X-Gm-Features: AQt7F2pJA3gjYj60zXo9Wthq4BNM91AdaTlXvSk_cK8jIQ_GV2_u-YfD1NDtAsM
Message-ID: <CAF7HswPByuLXZuHPdfvcXAZRSZkH0BYyy+PjbD7g3Sk97r+UvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ltc2309: add support for ltc2305
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 2:38=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 12/23/25 3:12 AM, Kyle Hsieh wrote:
> > Add support for the 2-channel LTC2305 ADC in the existing LTC2309 drive=
r.
> > The LTC2305 and LTC2309 share similar features: both are 12-bit,
> > low-noise, low-power SAR ADCs with an I2C interface.
> > The main difference is the number of channels: LTC2305 has 2 channels,
> > while LTC2309 has 8 channels.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  drivers/iio/adc/ltc2309.c | 50 +++++++++++++++++++++++++++++++++++++++=
++++----
> >  1 file changed, 46 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> > index 5f0d947d0615..7a611ddd00d2 100644
> > --- a/drivers/iio/adc/ltc2309.c
> > +++ b/drivers/iio/adc/ltc2309.c
> > @@ -1,9 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> > + * The LTC2305 is a  2-Channel, 12-Bit SAR ADC with an I2C Interface.
>
> Would be more conventional to list things in low to high order like in th=
e
> dt-bindings. (same applies throughout this patch)
>
I will reorder descriptions and definitions to list devices in
low-to-high order.
> >   *
> >   * Datasheet:
> >   * https://www.analog.com/media/en/technical-documentation/data-sheets=
/2309fd.pdf
> > + * https://www.analog.com/media/en/technical-documentation/data-sheets=
/23015fb.pdf
> >   *
> >   * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
> >   */
> > @@ -60,6 +62,13 @@ enum ltc2309_channels {
> >       LTC2309_CH7,
> >  };
> >
> > +enum ltc2305_channels {
> > +     LTC2305_CH0_CH1 =3D 0,
>
> Initializer is not strictly needed. I guess it is consistent with the
> existing code though, so OK.
>
> > +     LTC2305_CH1_CH0,
> > +     LTC2305_CH0,
> > +     LTC2305_CH1,
> > +};
> > +
> >  #define LTC2309_CHAN(_chan, _addr) {                         \
> >       .type =3D IIO_VOLTAGE,                                    \
> >       .indexed =3D 1,                                           \
> > @@ -99,6 +108,31 @@ static const struct iio_chan_spec ltc2309_channels[=
] =3D {
> >       LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
> >  };
> >
> > +static const struct iio_chan_spec ltc2305_channels[] =3D {
> > +     LTC2309_CHAN(0, LTC2305_CH0),
> > +     LTC2309_CHAN(1, LTC2305_CH1),
> > +     LTC2309_DIFF_CHAN(0, 1, LTC2305_CH0_CH1),
> > +     LTC2309_DIFF_CHAN(1, 0, LTC2305_CH1_CH0),
> > +};
> > +
> > +struct ltc230x_chip_info {
>
> We avoid putting "x" in names like this because the pattern breaks too of=
ten.
> Just use the main driver prefix of ltc2309.
>
Got it, I will replace this 'ltc203x' with 'ltc2309'.
> > +     const char *name;
> > +     const struct iio_chan_spec *channels;
> > +     int num_channels;
> > +};
> > +
> > +static const struct ltc230x_chip_info ltc2309_chip_info =3D {
> > +     .name =3D "ltc2309",
> > +     .channels =3D ltc2309_channels,
> > +     .num_channels =3D ARRAY_SIZE(ltc2309_channels),
> > +};
> > +
> > +static const struct ltc230x_chip_info ltc2305_chip_info =3D {
> > +     .name =3D "ltc2305",
> > +     .channels =3D ltc2305_channels,
> > +     .num_channels =3D ARRAY_SIZE(ltc2305_channels),
> > +};
> > +
> >  static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
> >                                   unsigned long address, int *val)
> >  {
> > @@ -158,6 +192,8 @@ static const struct iio_info ltc2309_info =3D {
> >
> >  static int ltc2309_probe(struct i2c_client *client)
> >  {
> > +     const struct of_device_id *match;
>
> Unused?
>
I will remove in v2.
> > +     const struct ltc230x_chip_info *chip_info;
> >       struct iio_dev *indio_dev;
> >       struct ltc2309 *ltc2309;
> >       int ret;
> > @@ -167,13 +203,17 @@ static int ltc2309_probe(struct i2c_client *clien=
t)
> >               return -ENOMEM;
> >
> >       ltc2309 =3D iio_priv(indio_dev);
> > +     chip_info =3D device_get_match_data(&client->dev);
>
> Why not i2c_get_match_data()?
>
I will switch from device_get_match_data() to i2c_get_match_data() in v2
> > +     if (!chip_info)
> > +             return -EINVAL;
> > +
> >       ltc2309->dev =3D &indio_dev->dev;
> >       ltc2309->client =3D client;
> >
> > -     indio_dev->name =3D "ltc2309";
> > +     indio_dev->name =3D chip_info->name;
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > -     indio_dev->channels =3D ltc2309_channels;
> > -     indio_dev->num_channels =3D ARRAY_SIZE(ltc2309_channels);
> > +     indio_dev->channels =3D chip_info->channels;
> > +     indio_dev->num_channels =3D chip_info->num_channels;
> >       indio_dev->info =3D &ltc2309_info;
> >
> >       ret =3D devm_regulator_get_enable_read_voltage(&client->dev, "vre=
f");
> > @@ -189,13 +229,15 @@ static int ltc2309_probe(struct i2c_client *clien=
t)
> >  }
> >
> >  static const struct of_device_id ltc2309_of_match[] =3D {
> > -     { .compatible =3D "lltc,ltc2309" },
> > +     { .compatible =3D "lltc,ltc2309", .data =3D &ltc2309_chip_info },
> > +     { .compatible =3D "lltc,ltc2305", .data =3D &ltc2305_chip_info },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(of, ltc2309_of_match);
> >
> >  static const struct i2c_device_id ltc2309_id[] =3D {
> >       { "ltc2309" },
> > +     { "ltc2305" },
>
> Also need to add chip_infos here.
>
Thanks reminder, I will add.
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ltc2309_id);
> >
>

