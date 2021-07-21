Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAF3D09A5
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhGUGo7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 02:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbhGUGnV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 02:43:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC6FC061574;
        Wed, 21 Jul 2021 00:23:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t9so1060127pgn.4;
        Wed, 21 Jul 2021 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ydkJlc724kwXsUpN3BSvwuYbuIWDBKSNrdzJHlTB4dg=;
        b=QV8tmvG1f5nGOCiYaPpvN577MOZIUnFq+9CDSiKuT8UF9gmzVWeSSBrOvtrHn2Tl2D
         OH35CgOT2ss/VYTG9MKMwJ3OOwJbX5nPDTxO/RoCUw+u2es8oORSOty/8XQQTaH1PArp
         aK1vsKqWhZM3jBzThFJp6PgVJIgnlLZjiCEbXaj+Jcz06r9EwR4M+fXQPEGiHpwexnnO
         Dfz83tg2wcEYfZxnfo89JbdxNJZrJGBZZmrd/hy0UwEHYgsXJJUhkDwu4pMqtsXvIJyv
         sZHVFyzA8gj1s9WT6I0HhsSVHVYncpS1OhLevRH+Af0LDNENjYddYEJ3Vg5eziLqKBXf
         O/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ydkJlc724kwXsUpN3BSvwuYbuIWDBKSNrdzJHlTB4dg=;
        b=GtYPB76Y6MB7gL7sH+hLjAFEA17qQKljOxlirOAsF7P8YSCqOKpFsAiNTlr0o6Oj+R
         y5HXK106zTl2lG2UcEyz11BcRa4/LkOS5WA5o8pOGPkWzIW3VE9Yc45eJIB+5GVbRKj+
         ZGN1+Hily4+i2fsuYYiKEzTMlp9q13EvfMOEdLpyqzOmRwvCYZVaIFLUZiYWa19z+eXy
         9qP3TiEAVOqZ/ponMOLtdtgpixDeg9bYmCLNRbkZisSvc8a8oJ6AGjWtUADKR4CHJMDr
         wB4e9PWvONWMz/iz0Fw5H+qPYHVO+gziB7yonPxiSLEkzbBeeV1c5XfZOqd4HORNsVlt
         Xb2w==
X-Gm-Message-State: AOAM533n6gv3qcRvRMX8E5Owvl2so6e7x01+ooGlE2KGK+HxtKNQm2V6
        se6kyKtSbOYdEC5TsKrjN0tlBhS6TF+VW4kEQkM=
X-Google-Smtp-Source: ABdhPJzI1alxGT5Ta6mjR2fCf4gmdjxGE/CT9VNiV2j7IeCLysveMNRPCjRVhCQgyP7qj4xYgKbChA6e/nonKV6ubuU=
X-Received: by 2002:a05:6a00:1ac7:b029:32b:a408:939b with SMTP id
 f7-20020a056a001ac7b029032ba408939bmr35220244pfv.58.1626852238208; Wed, 21
 Jul 2021 00:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210718203746.7159-1-theobf@usp.br> <CA+U=DspWmrWWsQDFPLycS2y-=8Q7TSn5NYMVgbQ42FccAy0=pw@mail.gmail.com>
 <CAD5vTa8gnQpZ8B4KQkA=-6Oo-YiN4J7pDp0HoUZgpHN99vJK_g@mail.gmail.com>
 <CA+U=DsrU5iPBRexdUK3fx-PG3CbSoKouGWENVLJ5+h8L5-y_Og@mail.gmail.com> <CAD5vTa_cR0da4qZ2JTB7G-QgZrSeZr3e8fp92S6WGMaCoUr15g@mail.gmail.com>
In-Reply-To: <CAD5vTa_cR0da4qZ2JTB7G-QgZrSeZr3e8fp92S6WGMaCoUr15g@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 21 Jul 2021 10:23:45 +0300
Message-ID: <CA+U=Dspk0G+b-M3k1m7SCCPfAoFxksqzHxCSs8BWnsrSr_afOw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: max5821: convert device register to device
 managed function
To:     =?UTF-8?Q?Th=C3=A9o_Bor=C3=A9m_Fabris?= <theobf@usp.br>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 21, 2021 at 3:11 AM Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>=
 wrote:
>
> Em ter., 20 de jul. de 2021 =C3=A0s 04:22, Alexandru Ardelean
> <ardeleanalex@gmail.com> escreveu:
> >
> > On Mon, Jul 19, 2021 at 6:25 PM Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp=
.br> wrote:
> > >
> > > Hi, Alexandru.
> > >
> > > Em seg., 19 de jul. de 2021 =C3=A0s 04:33, Alexandru Ardelean
> > > <ardeleanalex@gmail.com> escreveu:
> > > >
> > > > On Sun, Jul 18, 2021 at 11:42 PM Th=C3=A9o Bor=C3=A9m Fabris <theob=
f@usp.br> wrote:
> > > > >
> > > > > Add a device managed hook, via devm_add_action_or_reset() and
> > > > > max5821_regulator_disable(), to disable voltage regulator on devi=
ce
> > > > > detach.
> > > > > Replace iio_device_register() by devm_iio_device_register() and r=
emove
> > > > > the max5821_remove() function used to unregister the device and d=
isable the
> > > > > voltage regulator.
> > > > > Remove i2c_set_clientdata() from the probe function, since
> > > > > i2c_get_clientdata() is not used anymore.
> > > >
> > > > Looks good overall.
> > > > A few comments inline.
> > > >
> > > > >
> > > > > Signed-off-by: Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>
> > > > > ---
> > > > >  drivers/iio/dac/max5821.c | 30 ++++++++++++++++--------------
> > > > >  1 file changed, 16 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.=
c
> > > > > index bd6e75699a63..44c04ae70b32 100644
> > > > > --- a/drivers/iio/dac/max5821.c
> > > > > +++ b/drivers/iio/dac/max5821.c
> > > > > @@ -294,6 +294,13 @@ static const struct iio_info max5821_info =
=3D {
> > > > >         .write_raw =3D max5821_write_raw,
> > > > >  };
> > > > >
> > > > > +static void max5821_regulator_disable(void *data)
> > > > > +{
> > > > > +       struct regulator *rdata =3D data;
> > > > > +
> > > > > +       regulator_disable(rdata);
> > > >
> > > > This can be simplified a bit:
> > > >
> > > > static void max5821_regulator_disable(void *reg)
> > > > {
> > > >       regulator_disable(reg);
> > > > }
> > > >
> > > > I used to do explicit casting, but then I also figured that it's no=
t necessary.
> > > >
> > > Ok.
> > >
> > > > > +}
> > > > > +
> > > > >  static int max5821_probe(struct i2c_client *client,
> > > > >                         const struct i2c_device_id *id)
> > > > >  {
> > > > > @@ -306,7 +313,6 @@ static int max5821_probe(struct i2c_client *c=
lient,
> > > > >         if (!indio_dev)
> > > > >                 return -ENOMEM;
> > > > >         data =3D iio_priv(indio_dev);
> > > > > -       i2c_set_clientdata(client, indio_dev);
> > > > >         data->client =3D client;
> > > > >         mutex_init(&data->lock);
> > > > >
> > > > > @@ -331,6 +337,14 @@ static int max5821_probe(struct i2c_client *=
client,
> > > > >                 goto error_free_reg;
> > > > >         }
> > > > >
> > > > > +       ret =3D devm_add_action_or_reset(&client->dev, max5821_re=
gulator_disable,
> > > > > +                                      data->vref_reg);
> > > > > +       if (ret) {
> > > > > +               dev_err(&client->dev,
> > > > > +                       "Failed to add action to managed regulato=
r: %d\n", ret);
> > > > > +               goto error_disable_reg;
> > > >
> > > > return ret;
> > > >
> > > > devm_add_action_or_reset() should call max5821_regulator_disable() =
in
> > > > case of error
> > > >
> > > Ok.
> > >
> > > > > +       }
> > > > > +
> > > > >         ret =3D regulator_get_voltage(data->vref_reg);
> > > > >         if (ret < 0) {
> > > > >                 dev_err(&client->dev,
> > > > > @@ -346,7 +360,7 @@ static int max5821_probe(struct i2c_client *c=
lient,
> > > > >         indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > >         indio_dev->info =3D &max5821_info;
> > > > >
> > > > > -       return iio_device_register(indio_dev);
> > > > > +       return devm_iio_device_register(&client->dev, indio_dev);
> > > > >
> > > > >  error_disable_reg:
> > > >
> > > > This entire goto block should be removed.
> > > > The idea of using only devm_ functions is to not have these goto st=
atements.
> > > >
> > > I thought the action added via devm_add_action (and devres_add) was c=
alled only
> > > on driver detach, thus the error_disable_reg label would be necessary
> > > to handle the
> >
> > devm_add_action() yes
> > this is devm_add_action_or_reset() which looks like this:
> >
> > static inline int devm_add_action_or_reset(struct device *dev,
> >                        void (*action)(void *), void *data)
> > {
> >     int ret;
> >
> >     ret =3D devm_add_action(dev, action, data);
> >     if (ret)
> >         action(data);
> >
> >     return ret;
> > }
> >
> > it can be found in "include/linux/device.h"
> >
> > > possible error on regulator_get_voltage. Could you please clarify for
> > > me when does
> > > a driver detach happen?
> >
> > a driver detach happens when:
> > * the kmod is unloaded (assuming the driver is running as a kmod)
> > * manually unbinding the driver from sysfs ;
> >    a quick article about this [it's for USB, but other interfaces use
> >    the same mechanism]:
> >    https://lwn.net/Articles/143397/
> >    there should be something under /sys/bus/spi/drivers/xxxx/unbind
> > * when the system powers down (reboots)
> > * maybe there is some other new method to do this [that I don't know ab=
out]
> >
> Thank you so much.
>
> So, should this goto error_disable_reg be replaced by
> "regulator_disable(.); return ret;"?
> ret =3D regulator_get_voltage(data->vref_reg);
>     if (ret < 0) {
>         dev_err(&client->dev,
>              "Failed to get voltage on regulator: %d\n", ret);
>         goto error_disable_reg;
>     }


This is sufficient:
[ No extra regulator_disable() is required; regulator_disable() gets
called via max5821_regulator_disable() on the error path ]

       ret =3D devm_add_action_or_reset(&client->dev, max5821_regulator_dis=
able,
                                      data->vref_reg);
       if (ret) {
               dev_err(&client->dev,
                       "Failed to add action to managed regulator: %d\n", r=
et);
               return ret;
       }

>
> > >
> > > Thanks for your reply,
> > > Th=C3=A9o
> > >
> > > > >         regulator_disable(data->vref_reg);
> > > > > @@ -356,17 +370,6 @@ static int max5821_probe(struct i2c_client *=
client,
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > -static int max5821_remove(struct i2c_client *client)
> > > > > -{
> > > > > -       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > > > > -       struct max5821_data *data =3D iio_priv(indio_dev);
> > > > > -
> > > > > -       iio_device_unregister(indio_dev);
> > > > > -       regulator_disable(data->vref_reg);
> > > > > -
> > > > > -       return 0;
> > > > > -}
> > > > > -
> > > > >  static const struct i2c_device_id max5821_id[] =3D {
> > > > >         { "max5821", ID_MAX5821 },
> > > > >         { }
> > > > > @@ -386,7 +389,6 @@ static struct i2c_driver max5821_driver =3D {
> > > > >                 .pm     =3D &max5821_pm_ops,
> > > > >         },
> > > > >         .probe          =3D max5821_probe,
> > > > > -       .remove         =3D max5821_remove,
> > > > >         .id_table       =3D max5821_id,
> > > > >  };
> > > > >  module_i2c_driver(max5821_driver);
> > > > > --
> > > > > 2.20.1
> > > > >
