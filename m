Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBDD3CF53C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhGTGmP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 02:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhGTGmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 02:42:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1463C061574;
        Tue, 20 Jul 2021 00:22:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y4so18793374pfi.9;
        Tue, 20 Jul 2021 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=czroiAAHyiLricTn382zGuj+7ArxacObZ2z97treVVI=;
        b=goqNHO/ywWkfysZY2Ks+Uc1jQVpnXfpQTB7jeSvjNiTLdN6fjlr5XYYL0Rv9J3N1RU
         3I8zgMSlUytHmiRiVacZVIY4eP8kFDv3aDIeqJHcpjQZfa1KEDZjUMHG/AVkZRuywKEi
         O7u1XkwgQw1IDhrPCRSBoprYXwEIqbKLmLdEofucdmPtonCT7woecUCc7RwDXpcsFjtD
         PP1hQBUURa2pED9hS532pbi3lWJfsM3xNvimNWn7MSig1/xs1nhk+0DR/UAUaer7IynW
         h9YRBRPuPO1m3u4O/vWpxZTfFObJVTK3FvPCeVcDG+OdlGPVwyTvrxMITMYRNsW98wTQ
         oT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=czroiAAHyiLricTn382zGuj+7ArxacObZ2z97treVVI=;
        b=Y5AK5o6WQXcebsKdz/Yo17g4guqNaShBGQ2/0wwF0moGY6/aozXA6WSxY0ODLd2Ew2
         4GZgaIWLI7CEe0Vdvn6JfHzxjPyR8ZQGcn2oLHKnfIcCzJsq2jbQjc9e2bM2t5hzjRag
         6GXE8HOANqLTj/ag48kOJUjVeN1bXBP70zKILppQY+6/j24uAxdOP2PmPD/qMDkLDXXU
         gwQZT4dpCdHAaevwKq55UJWWux+RslBFj9ake+5vahxiiyeX8a2ht7jaRjY2F5wN9L9P
         YUUP42py6zBWcM7E7LVBDOdr0GcC+PHT6PBeKug2bNcho0uKe74byukAy3bCDj1IiAWs
         w+4g==
X-Gm-Message-State: AOAM530MSOHFKQ4BhrWQJEDQSb2WkUdi2hd67OszPrb18AwuoLcXIut/
        BVQXosiNZXIE+W2dHSsFW79Df0fOvA5FpyJgs64=
X-Google-Smtp-Source: ABdhPJwOtbGEmplIaAGdH14LMTrIabWM9ZPFl/u9J8RPc1XkXcIcK99bUvmxt7ivNiC0ACIPWB9EirkHeerOJYYMsHk=
X-Received: by 2002:a63:170b:: with SMTP id x11mr29438326pgl.253.1626765771343;
 Tue, 20 Jul 2021 00:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210718203746.7159-1-theobf@usp.br> <CA+U=DspWmrWWsQDFPLycS2y-=8Q7TSn5NYMVgbQ42FccAy0=pw@mail.gmail.com>
 <CAD5vTa8gnQpZ8B4KQkA=-6Oo-YiN4J7pDp0HoUZgpHN99vJK_g@mail.gmail.com>
In-Reply-To: <CAD5vTa8gnQpZ8B4KQkA=-6Oo-YiN4J7pDp0HoUZgpHN99vJK_g@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 20 Jul 2021 10:22:40 +0300
Message-ID: <CA+U=DsrU5iPBRexdUK3fx-PG3CbSoKouGWENVLJ5+h8L5-y_Og@mail.gmail.com>
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

On Mon, Jul 19, 2021 at 6:25 PM Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>=
 wrote:
>
> Hi, Alexandru.
>
> Em seg., 19 de jul. de 2021 =C3=A0s 04:33, Alexandru Ardelean
> <ardeleanalex@gmail.com> escreveu:
> >
> > On Sun, Jul 18, 2021 at 11:42 PM Th=C3=A9o Bor=C3=A9m Fabris <theobf@us=
p.br> wrote:
> > >
> > > Add a device managed hook, via devm_add_action_or_reset() and
> > > max5821_regulator_disable(), to disable voltage regulator on device
> > > detach.
> > > Replace iio_device_register() by devm_iio_device_register() and remov=
e
> > > the max5821_remove() function used to unregister the device and disab=
le the
> > > voltage regulator.
> > > Remove i2c_set_clientdata() from the probe function, since
> > > i2c_get_clientdata() is not used anymore.
> >
> > Looks good overall.
> > A few comments inline.
> >
> > >
> > > Signed-off-by: Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>
> > > ---
> > >  drivers/iio/dac/max5821.c | 30 ++++++++++++++++--------------
> > >  1 file changed, 16 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> > > index bd6e75699a63..44c04ae70b32 100644
> > > --- a/drivers/iio/dac/max5821.c
> > > +++ b/drivers/iio/dac/max5821.c
> > > @@ -294,6 +294,13 @@ static const struct iio_info max5821_info =3D {
> > >         .write_raw =3D max5821_write_raw,
> > >  };
> > >
> > > +static void max5821_regulator_disable(void *data)
> > > +{
> > > +       struct regulator *rdata =3D data;
> > > +
> > > +       regulator_disable(rdata);
> >
> > This can be simplified a bit:
> >
> > static void max5821_regulator_disable(void *reg)
> > {
> >       regulator_disable(reg);
> > }
> >
> > I used to do explicit casting, but then I also figured that it's not ne=
cessary.
> >
> Ok.
>
> > > +}
> > > +
> > >  static int max5821_probe(struct i2c_client *client,
> > >                         const struct i2c_device_id *id)
> > >  {
> > > @@ -306,7 +313,6 @@ static int max5821_probe(struct i2c_client *clien=
t,
> > >         if (!indio_dev)
> > >                 return -ENOMEM;
> > >         data =3D iio_priv(indio_dev);
> > > -       i2c_set_clientdata(client, indio_dev);
> > >         data->client =3D client;
> > >         mutex_init(&data->lock);
> > >
> > > @@ -331,6 +337,14 @@ static int max5821_probe(struct i2c_client *clie=
nt,
> > >                 goto error_free_reg;
> > >         }
> > >
> > > +       ret =3D devm_add_action_or_reset(&client->dev, max5821_regula=
tor_disable,
> > > +                                      data->vref_reg);
> > > +       if (ret) {
> > > +               dev_err(&client->dev,
> > > +                       "Failed to add action to managed regulator: %=
d\n", ret);
> > > +               goto error_disable_reg;
> >
> > return ret;
> >
> > devm_add_action_or_reset() should call max5821_regulator_disable() in
> > case of error
> >
> Ok.
>
> > > +       }
> > > +
> > >         ret =3D regulator_get_voltage(data->vref_reg);
> > >         if (ret < 0) {
> > >                 dev_err(&client->dev,
> > > @@ -346,7 +360,7 @@ static int max5821_probe(struct i2c_client *clien=
t,
> > >         indio_dev->modes =3D INDIO_DIRECT_MODE;
> > >         indio_dev->info =3D &max5821_info;
> > >
> > > -       return iio_device_register(indio_dev);
> > > +       return devm_iio_device_register(&client->dev, indio_dev);
> > >
> > >  error_disable_reg:
> >
> > This entire goto block should be removed.
> > The idea of using only devm_ functions is to not have these goto statem=
ents.
> >
> I thought the action added via devm_add_action (and devres_add) was calle=
d only
> on driver detach, thus the error_disable_reg label would be necessary
> to handle the

devm_add_action() yes
this is devm_add_action_or_reset() which looks like this:

static inline int devm_add_action_or_reset(struct device *dev,
                       void (*action)(void *), void *data)
{
    int ret;

    ret =3D devm_add_action(dev, action, data);
    if (ret)
        action(data);

    return ret;
}

it can be found in "include/linux/device.h"

> possible error on regulator_get_voltage. Could you please clarify for
> me when does
> a driver detach happen?

a driver detach happens when:
* the kmod is unloaded (assuming the driver is running as a kmod)
* manually unbinding the driver from sysfs ;
   a quick article about this [it's for USB, but other interfaces use
   the same mechanism]:
   https://lwn.net/Articles/143397/
   there should be something under /sys/bus/spi/drivers/xxxx/unbind
* when the system powers down (reboots)
* maybe there is some other new method to do this [that I don't know about]

>
> Thanks for your reply,
> Th=C3=A9o
>
> > >         regulator_disable(data->vref_reg);
> > > @@ -356,17 +370,6 @@ static int max5821_probe(struct i2c_client *clie=
nt,
> > >         return ret;
> > >  }
> > >
> > > -static int max5821_remove(struct i2c_client *client)
> > > -{
> > > -       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > > -       struct max5821_data *data =3D iio_priv(indio_dev);
> > > -
> > > -       iio_device_unregister(indio_dev);
> > > -       regulator_disable(data->vref_reg);
> > > -
> > > -       return 0;
> > > -}
> > > -
> > >  static const struct i2c_device_id max5821_id[] =3D {
> > >         { "max5821", ID_MAX5821 },
> > >         { }
> > > @@ -386,7 +389,6 @@ static struct i2c_driver max5821_driver =3D {
> > >                 .pm     =3D &max5821_pm_ops,
> > >         },
> > >         .probe          =3D max5821_probe,
> > > -       .remove         =3D max5821_remove,
> > >         .id_table       =3D max5821_id,
> > >  };
> > >  module_i2c_driver(max5821_driver);
> > > --
> > > 2.20.1
> > >
