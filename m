Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544463D4A84
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 00:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGXWI2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 18:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGXWI1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 18:08:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B98C061757
        for <linux-iio@vger.kernel.org>; Sat, 24 Jul 2021 15:48:57 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u7so1856968ilj.8
        for <linux-iio@vger.kernel.org>; Sat, 24 Jul 2021 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCrrNcNUSHZs7eKX83SErrWSVU6f5qqYgMuHGf7P0Ok=;
        b=r/pruy2u20940BeYmZ+Y+0Rjavpht9PiBL7dRNIxRJVjIq8DGpCJ7Hr2B2o7CbAe2s
         Y9eoNWTkYAxGkiStyzIxBsHjSMlxepCHGOSPgRqDAngzjxf4FIUiPI1CNvHV8n/r74N2
         y1QI9NHd7oupj/RVZ9wf8orHGeDRkzaQDSJN2vLT9qUgYRavj7PCv48tOyiDJuaRtqHt
         F5udZen8vivSd1/alWOnqw7G3xfrJz5PPyn1Hawu6J96bQBj251IxEKFC2kcGSFncqxt
         wJ+rhRVkKAD6P6g9Eyu9Gphz6Iakpie5zJNHZHZyJe/d9GsAq45jZIyw6Tjp2x9eDvs8
         t/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCrrNcNUSHZs7eKX83SErrWSVU6f5qqYgMuHGf7P0Ok=;
        b=GFq4i4yZBBMh2zIgOumu+fBCHeXUOl+C8sKeSDrVmnz2MInb23KKS51exGY7ax/XJU
         j2nJJIBHAiRGf++P28cnz7beclrrQo5Kv+3Bhb7ibVw88IdXkiFIy3WClpoztxSC4M6Y
         vXXLGRx+SF9IvOM2TiCX3TffWXafe701sjlhg+oJ1qKpz/z2YnGyXrQSiTP0e7mlAfk8
         yMngB71SGZhNW7cyp97YX4u3pgQNb6pp48MSLIS91dR38WvtpF/+QG1gE+jtOJJ+SvOS
         y1cfNTgmCN0PAXfREM6AGW84UGsg/sngkWVSmZn4RU8GQw6dm5pXV99hfdWeoYmMFL8N
         BXDw==
X-Gm-Message-State: AOAM5313m3UIrEEdoEmOvZVj4x5kw41vhZ717RDS/RpKEpc0KIeDUgsT
        T121IRA8+xG/0r9DiFSD2myaqJkoAdkaVKoMBRPGXw==
X-Google-Smtp-Source: ABdhPJzCClchEiYKv7C25OAe1yyT4wJKheEBmbUjsTWG2mVCYvvFLtuqAnh+dZ6VC9m+8Ln5szfPpJlP4geX3UKOPU4=
X-Received: by 2002:a05:6e02:dcd:: with SMTP id l13mr7957651ilj.300.1627166936785;
 Sat, 24 Jul 2021 15:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210718203746.7159-1-theobf@usp.br> <CA+U=DspWmrWWsQDFPLycS2y-=8Q7TSn5NYMVgbQ42FccAy0=pw@mail.gmail.com>
 <CAD5vTa8gnQpZ8B4KQkA=-6Oo-YiN4J7pDp0HoUZgpHN99vJK_g@mail.gmail.com>
 <CA+U=DsrU5iPBRexdUK3fx-PG3CbSoKouGWENVLJ5+h8L5-y_Og@mail.gmail.com>
 <CAD5vTa_cR0da4qZ2JTB7G-QgZrSeZr3e8fp92S6WGMaCoUr15g@mail.gmail.com> <CA+U=Dspk0G+b-M3k1m7SCCPfAoFxksqzHxCSs8BWnsrSr_afOw@mail.gmail.com>
In-Reply-To: <CA+U=Dspk0G+b-M3k1m7SCCPfAoFxksqzHxCSs8BWnsrSr_afOw@mail.gmail.com>
From:   =?UTF-8?Q?Th=C3=A9o_Bor=C3=A9m_Fabris?= <theobf@usp.br>
Date:   Sat, 24 Jul 2021 19:48:20 -0300
Message-ID: <CAD5vTa-Cs9DA9icvU4AYPGTDCG2fQOJhM5TJ9h1nnk_9B17vNA@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: max5821: convert device register to device
 managed function
To:     Alexandru Ardelean <ardeleanalex@gmail.com>, Nuno.Sa@analog.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you, Alexandru and Numo, for your help. I have submitted the
second version.

Th=C3=A9o

Em qua., 21 de jul. de 2021 =C3=A0s 04:23, Alexandru Ardelean
<ardeleanalex@gmail.com> escreveu:
>
> On Wed, Jul 21, 2021 at 3:11 AM Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.b=
r> wrote:
> >
> > Em ter., 20 de jul. de 2021 =C3=A0s 04:22, Alexandru Ardelean
> > <ardeleanalex@gmail.com> escreveu:
> > >
> > > On Mon, Jul 19, 2021 at 6:25 PM Th=C3=A9o Bor=C3=A9m Fabris <theobf@u=
sp.br> wrote:
> > > >
> > > > Hi, Alexandru.
> > > >
> > > > Em seg., 19 de jul. de 2021 =C3=A0s 04:33, Alexandru Ardelean
> > > > <ardeleanalex@gmail.com> escreveu:
> > > > >
> > > > > On Sun, Jul 18, 2021 at 11:42 PM Th=C3=A9o Bor=C3=A9m Fabris <the=
obf@usp.br> wrote:
> > > > > >
> > > > > > Add a device managed hook, via devm_add_action_or_reset() and
> > > > > > max5821_regulator_disable(), to disable voltage regulator on de=
vice
> > > > > > detach.
> > > > > > Replace iio_device_register() by devm_iio_device_register() and=
 remove
> > > > > > the max5821_remove() function used to unregister the device and=
 disable the
> > > > > > voltage regulator.
> > > > > > Remove i2c_set_clientdata() from the probe function, since
> > > > > > i2c_get_clientdata() is not used anymore.
> > > > >
> > > > > Looks good overall.
> > > > > A few comments inline.
> > > > >
> > > > > >
> > > > > > Signed-off-by: Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>
> > > > > > ---
> > > > > >  drivers/iio/dac/max5821.c | 30 ++++++++++++++++--------------
> > > > > >  1 file changed, 16 insertions(+), 14 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max582=
1.c
> > > > > > index bd6e75699a63..44c04ae70b32 100644
> > > > > > --- a/drivers/iio/dac/max5821.c
> > > > > > +++ b/drivers/iio/dac/max5821.c
> > > > > > @@ -294,6 +294,13 @@ static const struct iio_info max5821_info =
=3D {
> > > > > >         .write_raw =3D max5821_write_raw,
> > > > > >  };
> > > > > >
> > > > > > +static void max5821_regulator_disable(void *data)
> > > > > > +{
> > > > > > +       struct regulator *rdata =3D data;
> > > > > > +
> > > > > > +       regulator_disable(rdata);
> > > > >
> > > > > This can be simplified a bit:
> > > > >
> > > > > static void max5821_regulator_disable(void *reg)
> > > > > {
> > > > >       regulator_disable(reg);
> > > > > }
> > > > >
> > > > > I used to do explicit casting, but then I also figured that it's =
not necessary.
> > > > >
> > > > Ok.
> > > >
> > > > > > +}
> > > > > > +
> > > > > >  static int max5821_probe(struct i2c_client *client,
> > > > > >                         const struct i2c_device_id *id)
> > > > > >  {
> > > > > > @@ -306,7 +313,6 @@ static int max5821_probe(struct i2c_client =
*client,
> > > > > >         if (!indio_dev)
> > > > > >                 return -ENOMEM;
> > > > > >         data =3D iio_priv(indio_dev);
> > > > > > -       i2c_set_clientdata(client, indio_dev);
> > > > > >         data->client =3D client;
> > > > > >         mutex_init(&data->lock);
> > > > > >
> > > > > > @@ -331,6 +337,14 @@ static int max5821_probe(struct i2c_client=
 *client,
> > > > > >                 goto error_free_reg;
> > > > > >         }
> > > > > >
> > > > > > +       ret =3D devm_add_action_or_reset(&client->dev, max5821_=
regulator_disable,
> > > > > > +                                      data->vref_reg);
> > > > > > +       if (ret) {
> > > > > > +               dev_err(&client->dev,
> > > > > > +                       "Failed to add action to managed regula=
tor: %d\n", ret);
> > > > > > +               goto error_disable_reg;
> > > > >
> > > > > return ret;
> > > > >
> > > > > devm_add_action_or_reset() should call max5821_regulator_disable(=
) in
> > > > > case of error
> > > > >
> > > > Ok.
> > > >
> > > > > > +       }
> > > > > > +
> > > > > >         ret =3D regulator_get_voltage(data->vref_reg);
> > > > > >         if (ret < 0) {
> > > > > >                 dev_err(&client->dev,
> > > > > > @@ -346,7 +360,7 @@ static int max5821_probe(struct i2c_client =
*client,
> > > > > >         indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > > >         indio_dev->info =3D &max5821_info;
> > > > > >
> > > > > > -       return iio_device_register(indio_dev);
> > > > > > +       return devm_iio_device_register(&client->dev, indio_dev=
);
> > > > > >
> > > > > >  error_disable_reg:
> > > > >
> > > > > This entire goto block should be removed.
> > > > > The idea of using only devm_ functions is to not have these goto =
statements.
> > > > >
> > > > I thought the action added via devm_add_action (and devres_add) was=
 called only
> > > > on driver detach, thus the error_disable_reg label would be necessa=
ry
> > > > to handle the
> > >
> > > devm_add_action() yes
> > > this is devm_add_action_or_reset() which looks like this:
> > >
> > > static inline int devm_add_action_or_reset(struct device *dev,
> > >                        void (*action)(void *), void *data)
> > > {
> > >     int ret;
> > >
> > >     ret =3D devm_add_action(dev, action, data);
> > >     if (ret)
> > >         action(data);
> > >
> > >     return ret;
> > > }
> > >
> > > it can be found in "include/linux/device.h"
> > >
> > > > possible error on regulator_get_voltage. Could you please clarify f=
or
> > > > me when does
> > > > a driver detach happen?
> > >
> > > a driver detach happens when:
> > > * the kmod is unloaded (assuming the driver is running as a kmod)
> > > * manually unbinding the driver from sysfs ;
> > >    a quick article about this [it's for USB, but other interfaces use
> > >    the same mechanism]:
> > >    https://lwn.net/Articles/143397/
> > >    there should be something under /sys/bus/spi/drivers/xxxx/unbind
> > > * when the system powers down (reboots)
> > > * maybe there is some other new method to do this [that I don't know =
about]
> > >
> > Thank you so much.
> >
> > So, should this goto error_disable_reg be replaced by
> > "regulator_disable(.); return ret;"?
> > ret =3D regulator_get_voltage(data->vref_reg);
> >     if (ret < 0) {
> >         dev_err(&client->dev,
> >              "Failed to get voltage on regulator: %d\n", ret);
> >         goto error_disable_reg;
> >     }
>
>
> This is sufficient:
> [ No extra regulator_disable() is required; regulator_disable() gets
> called via max5821_regulator_disable() on the error path ]
>
>        ret =3D devm_add_action_or_reset(&client->dev, max5821_regulator_d=
isable,
>                                       data->vref_reg);
>        if (ret) {
>                dev_err(&client->dev,
>                        "Failed to add action to managed regulator: %d\n",=
 ret);
>                return ret;
>        }
>
> >
> > > >
> > > > Thanks for your reply,
> > > > Th=C3=A9o
> > > >
> > > > > >         regulator_disable(data->vref_reg);
> > > > > > @@ -356,17 +370,6 @@ static int max5821_probe(struct i2c_client=
 *client,
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > -static int max5821_remove(struct i2c_client *client)
> > > > > > -{
> > > > > > -       struct iio_dev *indio_dev =3D i2c_get_clientdata(client=
);
> > > > > > -       struct max5821_data *data =3D iio_priv(indio_dev);
> > > > > > -
> > > > > > -       iio_device_unregister(indio_dev);
> > > > > > -       regulator_disable(data->vref_reg);
> > > > > > -
> > > > > > -       return 0;
> > > > > > -}
> > > > > > -
> > > > > >  static const struct i2c_device_id max5821_id[] =3D {
> > > > > >         { "max5821", ID_MAX5821 },
> > > > > >         { }
> > > > > > @@ -386,7 +389,6 @@ static struct i2c_driver max5821_driver =3D=
 {
> > > > > >                 .pm     =3D &max5821_pm_ops,
> > > > > >         },
> > > > > >         .probe          =3D max5821_probe,
> > > > > > -       .remove         =3D max5821_remove,
> > > > > >         .id_table       =3D max5821_id,
> > > > > >  };
> > > > > >  module_i2c_driver(max5821_driver);
> > > > > > --
> > > > > > 2.20.1
> > > > > >
