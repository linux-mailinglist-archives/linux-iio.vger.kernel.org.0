Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04B83CDEF4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344870AbhGSPHA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345882AbhGSPFF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 11:05:05 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23807C09F5FE
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 07:56:30 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v26so20389843iom.11
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HuZyqBI8VecIWEXCo/n1pGBHsUOUwnLTjPNhfVWEiOY=;
        b=tvMm++S3Z7x57fvLv2MDf7kScofpvB+ZLhgUm+VbzxvKo4/VVVOK9myCTWZ9QHRI5/
         VAX8lWCy2R8HFUaVZTVTDGVmpvZUKSUARSIKOZhotCYeZn1yKSmK6wieZtYwBV9Bcdaa
         +nqUdzgAf2ra5eMfe5QDzVLWSsJUUWY7oZ/WsQIIUhA8IOOhz+3ccl6DzMRGSZO1vbBq
         mLQgNF5msop7dWuA3gyrbLttIbqedhLh3fvtfyti5/QOeGVsaMlZxV8n8D/RVFs1qbYw
         xiOm99N8ssbZwrNooTj4Nvu9/CmPLSCCFJsbxZJ1c906R5IAvFKz4yslZ31UZocFG6Yz
         uRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HuZyqBI8VecIWEXCo/n1pGBHsUOUwnLTjPNhfVWEiOY=;
        b=lLpSEs4PpVB4zNWMbhUpSig+xgWhYfWK33ISv2A4jRVF+ysW8ITL4G2kIWUJV4zjBC
         /PGrRrQ2L289RdYd0UYXXavtMrC4GVWWuxcGum+eYDNOzbmjxJb6EVbDoNrxFVTFIuxP
         CipaCmWI3dbcCLFkpc2MHGDQ2CXbDtxYRWRZSl0QpuGz7eTVJN2YfoijL55gBG8faXKk
         TP8mAyCOEKDnrPxz5jdJ0MH31furWpNffRVDaT7rZuwP+UMw0YGX7tqtEJQm4eEUgjst
         /II//TfeF2n08Hpjz/FGXlCEaDDGpIsaTGnx+wFLavyCdVlr6/hIk8N3VUgoUsQyXBIZ
         UGVg==
X-Gm-Message-State: AOAM533jjh14idQUgtUK6oHcslRrmrnK6JTKsWWa6xv8PP756ldVrTTd
        GQdQQLOVvq8Gf+I2dsjDnV/2i4d3gOCYi+S3aQOB5SxIzGQze7tY5Ys=
X-Google-Smtp-Source: ABdhPJw8Acogs6CFL1FweALTU6/lOaHkkUc95/HwNpa3qUGS2F5qRxoy90LCQC7l9/cSBxPQUKPYuL9z7gO3afm/eKA=
X-Received: by 2002:a05:6602:2e11:: with SMTP id o17mr10320207iow.55.1626708326696;
 Mon, 19 Jul 2021 08:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210718203746.7159-1-theobf@usp.br> <CA+U=DspWmrWWsQDFPLycS2y-=8Q7TSn5NYMVgbQ42FccAy0=pw@mail.gmail.com>
In-Reply-To: <CA+U=DspWmrWWsQDFPLycS2y-=8Q7TSn5NYMVgbQ42FccAy0=pw@mail.gmail.com>
From:   =?UTF-8?Q?Th=C3=A9o_Bor=C3=A9m_Fabris?= <theobf@usp.br>
Date:   Mon, 19 Jul 2021 12:24:50 -0300
Message-ID: <CAD5vTa8gnQpZ8B4KQkA=-6Oo-YiN4J7pDp0HoUZgpHN99vJK_g@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: max5821: convert device register to device
 managed function
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi, Alexandru.

Em seg., 19 de jul. de 2021 =C3=A0s 04:33, Alexandru Ardelean
<ardeleanalex@gmail.com> escreveu:
>
> On Sun, Jul 18, 2021 at 11:42 PM Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.=
br> wrote:
> >
> > Add a device managed hook, via devm_add_action_or_reset() and
> > max5821_regulator_disable(), to disable voltage regulator on device
> > detach.
> > Replace iio_device_register() by devm_iio_device_register() and remove
> > the max5821_remove() function used to unregister the device and disable=
 the
> > voltage regulator.
> > Remove i2c_set_clientdata() from the probe function, since
> > i2c_get_clientdata() is not used anymore.
>
> Looks good overall.
> A few comments inline.
>
> >
> > Signed-off-by: Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>
> > ---
> >  drivers/iio/dac/max5821.c | 30 ++++++++++++++++--------------
> >  1 file changed, 16 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> > index bd6e75699a63..44c04ae70b32 100644
> > --- a/drivers/iio/dac/max5821.c
> > +++ b/drivers/iio/dac/max5821.c
> > @@ -294,6 +294,13 @@ static const struct iio_info max5821_info =3D {
> >         .write_raw =3D max5821_write_raw,
> >  };
> >
> > +static void max5821_regulator_disable(void *data)
> > +{
> > +       struct regulator *rdata =3D data;
> > +
> > +       regulator_disable(rdata);
>
> This can be simplified a bit:
>
> static void max5821_regulator_disable(void *reg)
> {
>       regulator_disable(reg);
> }
>
> I used to do explicit casting, but then I also figured that it's not nece=
ssary.
>
Ok.

> > +}
> > +
> >  static int max5821_probe(struct i2c_client *client,
> >                         const struct i2c_device_id *id)
> >  {
> > @@ -306,7 +313,6 @@ static int max5821_probe(struct i2c_client *client,
> >         if (!indio_dev)
> >                 return -ENOMEM;
> >         data =3D iio_priv(indio_dev);
> > -       i2c_set_clientdata(client, indio_dev);
> >         data->client =3D client;
> >         mutex_init(&data->lock);
> >
> > @@ -331,6 +337,14 @@ static int max5821_probe(struct i2c_client *client=
,
> >                 goto error_free_reg;
> >         }
> >
> > +       ret =3D devm_add_action_or_reset(&client->dev, max5821_regulato=
r_disable,
> > +                                      data->vref_reg);
> > +       if (ret) {
> > +               dev_err(&client->dev,
> > +                       "Failed to add action to managed regulator: %d\=
n", ret);
> > +               goto error_disable_reg;
>
> return ret;
>
> devm_add_action_or_reset() should call max5821_regulator_disable() in
> case of error
>
Ok.

> > +       }
> > +
> >         ret =3D regulator_get_voltage(data->vref_reg);
> >         if (ret < 0) {
> >                 dev_err(&client->dev,
> > @@ -346,7 +360,7 @@ static int max5821_probe(struct i2c_client *client,
> >         indio_dev->modes =3D INDIO_DIRECT_MODE;
> >         indio_dev->info =3D &max5821_info;
> >
> > -       return iio_device_register(indio_dev);
> > +       return devm_iio_device_register(&client->dev, indio_dev);
> >
> >  error_disable_reg:
>
> This entire goto block should be removed.
> The idea of using only devm_ functions is to not have these goto statemen=
ts.
>
I thought the action added via devm_add_action (and devres_add) was called =
only
on driver detach, thus the error_disable_reg label would be necessary
to handle the
possible error on regulator_get_voltage. Could you please clarify for
me when does
a driver detach happen?

Thanks for your reply,
Th=C3=A9o

> >         regulator_disable(data->vref_reg);
> > @@ -356,17 +370,6 @@ static int max5821_probe(struct i2c_client *client=
,
> >         return ret;
> >  }
> >
> > -static int max5821_remove(struct i2c_client *client)
> > -{
> > -       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > -       struct max5821_data *data =3D iio_priv(indio_dev);
> > -
> > -       iio_device_unregister(indio_dev);
> > -       regulator_disable(data->vref_reg);
> > -
> > -       return 0;
> > -}
> > -
> >  static const struct i2c_device_id max5821_id[] =3D {
> >         { "max5821", ID_MAX5821 },
> >         { }
> > @@ -386,7 +389,6 @@ static struct i2c_driver max5821_driver =3D {
> >                 .pm     =3D &max5821_pm_ops,
> >         },
> >         .probe          =3D max5821_probe,
> > -       .remove         =3D max5821_remove,
> >         .id_table       =3D max5821_id,
> >  };
> >  module_i2c_driver(max5821_driver);
> > --
> > 2.20.1
> >
