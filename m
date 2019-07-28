Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB39177EB0
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfG1Iwa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 04:52:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42460 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfG1Iwa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jul 2019 04:52:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id v15so56710527eds.9;
        Sun, 28 Jul 2019 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lKh5rMewK4RJY3m6/XNHu9JdW8wZ24ygU5BoWkZ52I8=;
        b=Lr7sqEhpfXMJkMVl+7xTavQdDlmv+hMH0ahg3BWjq3vdMFCp4QVW9S4zbZiR68X9Yr
         dDMj3xxJNvyHLf3LtSBWO5B9WLdiZmaIEcnrBKoiwfNQXTFFaXAc+CrJCkrp10fZlamg
         GX0A/YIx30MJMJReLXGF0l4m/9cDhUfCATeo64Kz9TjcQOuqkHYCm/r3OcOc8uzLoz0k
         /fQyabb+3C1VcviY3TvZ8PqZW0piOT5y/ZEpO1kx9OlK0y5xSQBCNsZCrGGvMrgxp+o8
         fMpC+GIBWOeJTkEgV9A2s2VwmzXblM9H1VhdX2W5t+EV2SHbNHtbEZ2owFgQi5k/YFqW
         NiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lKh5rMewK4RJY3m6/XNHu9JdW8wZ24ygU5BoWkZ52I8=;
        b=AxQ5eDXRqS2MlTiyiywT7spUmhuzcLRE7Sxo6A5UJYn2ERQru/n0mEUmnSPVz00VRM
         umFqFWmnq64mZH7G3Wl1hgDvT7bssUKfLehMOfzHSoNtmFfFljMn6df2jcgiORr5FP2M
         SC0OIh026HIiAAhwD33pOAnuNAOkE+7kaFXEVVR8fnqhYkMcg2XDAHNLEBD6yThC1ezn
         waFT+AhyaihaChnm/qVfQy42voxVsZhSBX5VJoVcek02ZHuPUMiCYwIZNUMGdtyJF8YY
         IPRXDSB+T16epcv7jfvYTEN50gtY0nxvqHEY+UuFyxO+2biDZuayMx34SaV20zbj8FA1
         EEqQ==
X-Gm-Message-State: APjAAAWW9yLXzh/T0CLuI6HybaLkjp0lo+rlGtKQ/fGpwO1sRAaj6yWb
        8bLbUkJSWkGm90PujGHU5O98Da9iT7EUCoJEnPW47MgN
X-Google-Smtp-Source: APXvYqwDQhrqAl/+KUbAXxlMaoiWwbEMK2n/rTPRFjFxbVo+NHOSRVNkGqkvCWxz3QgZ93m8ZNCD9+d6oJlURfUJToM=
X-Received: by 2002:a17:906:8317:: with SMTP id j23mr66952676ejx.51.1564303948170;
 Sun, 28 Jul 2019 01:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190726090829.16979-1-hslester96@gmail.com> <20190727180815.0c3e655e@archlinux>
In-Reply-To: <20190727180815.0c3e655e@archlinux>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Sun, 28 Jul 2019 16:52:15 +0800
Message-ID: <CANhBUQ0NW18uFfoPkmecRwZ=EjWedB-ao8nyxfW1NFWg+DpTow@mail.gmail.com>
Subject: Re: [PATCH] iio: light: Use device-managed APIs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=8828=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=881:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 26 Jul 2019 17:08:29 +0800
> Chuhong Yuan <hslester96@gmail.com> wrote:
>
> > Use device-managed APIs to simplify the code.
> > The remove functions are redundant now and can
> > be deleted.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> Hi,
>
> This should have been split along the lines of the drivers as these
> have different authors and hence could be merged at different times.
> Not to mention the nature of the changes isn't exactly the same
> between the two.
>
> I might have taken the cm3323 one with a small tweak as below if they
> had been separate.
>
> Thanks,
>
> Jonathan

I will separate them and resend later.

>
> > ---
> >  drivers/iio/light/cm3323.c | 31 ++++++++++-----------------
> >  drivers/iio/light/si1145.c | 44 ++++++++++++++------------------------
> >  2 files changed, 27 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> > index 50f3438c2b49..fd352c0a4507 100644
> > --- a/drivers/iio/light/cm3323.c
> > +++ b/drivers/iio/light/cm3323.c
> > @@ -101,15 +101,16 @@ static int cm3323_init(struct iio_dev *indio_dev)
> >       return 0;
> >  }
> >
> > -static void cm3323_disable(struct iio_dev *indio_dev)
> > +static void cm3323_disable(void *data)
> >  {
> >       int ret;
> > -     struct cm3323_data *data =3D iio_priv(indio_dev);
> > +     struct iio_dev *indio_dev =3D data;
> > +     struct cm3323_data *cm_data =3D iio_priv(indio_dev);
> >
> > -     ret =3D i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
> > +     ret =3D i2c_smbus_write_word_data(cm_data->client, CM3323_CMD_CON=
F,
> >                                       CM3323_CONF_SD_BIT);
> >       if (ret < 0)
> > -             dev_err(&data->client->dev, "Error writing reg_conf\n");
> > +             dev_err(&cm_data->client->dev, "Error writing reg_conf\n"=
);
> >  }
> >
> >  static int cm3323_set_it_bits(struct cm3323_data *data, int val, int v=
al2)
> > @@ -243,25 +244,16 @@ static int cm3323_probe(struct i2c_client *client=
,
> >               return ret;
> >       }
> >
> > -     ret =3D iio_device_register(indio_dev);
> > +     ret =3D devm_add_action_or_reset(&client->dev, cm3323_disable, in=
dio_dev);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D devm_iio_device_register(&client->dev, indio_dev);
> >       if (ret < 0) {
> >               dev_err(&client->dev, "failed to register iio dev\n");
> > -             goto err_init;
> > +             return ret;
>
> I'd drop the failed to register message and just
> return devm_iio_device_register(...);
>
> Most of the likely paths that can cause that to fail report errors anyway
> in the core code.
>
> >       }
> >
> > -     return 0;
> > -err_init:
> > -     cm3323_disable(indio_dev);
> > -     return ret;
> > -}
> > -
> > -static int cm3323_remove(struct i2c_client *client)
> > -{
> > -     struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > -
> > -     iio_device_unregister(indio_dev);
> > -     cm3323_disable(indio_dev);
> > -
> >       return 0;
> >  }
> >
> > @@ -276,7 +268,6 @@ static struct i2c_driver cm3323_driver =3D {
> >               .name =3D CM3323_DRV_NAME,
> >       },
> >       .probe          =3D cm3323_probe,
> > -     .remove         =3D cm3323_remove,
> >       .id_table       =3D cm3323_id,
> >  };
> >
> > diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> > index 6579d2418814..61867552b27c 100644
> > --- a/drivers/iio/light/si1145.c
> > +++ b/drivers/iio/light/si1145.c
> > @@ -1271,13 +1271,14 @@ static int si1145_probe_trigger(struct iio_dev =
*indio_dev)
> >       return 0;
> >  }
> >
> > -static void si1145_remove_trigger(struct iio_dev *indio_dev)
> > +static void si1145_remove_trigger(void *data)
> >  {
> > -     struct si1145_data *data =3D iio_priv(indio_dev);
> > +     struct iio_dev *indio_dev =3D data;
> > +     struct si1145_data *si_data =3D iio_priv(indio_dev);
> >
> > -     if (data->trig) {
> > -             iio_trigger_unregister(data->trig);
> > -             data->trig =3D NULL;
> > +     if (si_data->trig) {
> > +             iio_trigger_unregister(si_data->trig);
>
> This doesn't look right.  Why not use the devm trigger
> registration directly?
>
> > +             si_data->trig =3D NULL;
>
> I find it unlikely that we actually need to set this to
> NULL, but please check closely in the driver.
> The obvious path would be that the interrupt fired
> after the trigger was unregistered (shouldn't be possible
> unless something odd is going on), however there is no
> obviously signs of this being checked there.
>

Thanks for your advice!
I will check whether data->trig is not needed to be set to NULL
and can devm_iio_trigger_register be used.
If so, I will revise them in version 2.

Regards,
Chuhong

>
> >       }
> >  }
> >
> > @@ -1332,7 +1333,8 @@ static int si1145_probe(struct i2c_client *client=
,
> >       if (ret < 0)
> >               return ret;
> >
> > -     ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
> > +     ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> > +             indio_dev, NULL,
> >               si1145_trigger_handler, &si1145_buffer_setup_ops);
> >       if (ret < 0)
> >               return ret;
> > @@ -1340,23 +1342,21 @@ static int si1145_probe(struct i2c_client *clie=
nt,
> >       if (client->irq) {
> >               ret =3D si1145_probe_trigger(indio_dev);
> >               if (ret < 0)
> > -                     goto error_free_buffer;
> > +                     return ret;
> > +
> > +             ret =3D devm_add_action_or_reset(&client->dev,
> > +                                     si1145_remove_trigger, indio_dev)=
;
> > +             if (ret < 0)
> > +                     return ret;
> > +
> >       } else {
> >               dev_info(&client->dev, "no irq, using polling\n");
> >       }
> >
> > -     ret =3D iio_device_register(indio_dev);
> > +     ret =3D devm_iio_device_register(&client->dev, indio_dev);
> >       if (ret < 0)
> > -             goto error_free_trigger;
> > +             return ret;
> >
> >       return 0;
> > -
> > -error_free_trigger:
> > -     si1145_remove_trigger(indio_dev);
> > -error_free_buffer:
> > -     iio_triggered_buffer_cleanup(indio_dev);
> > -
> > -     return ret;
> >  }
> >
> >  static const struct i2c_device_id si1145_ids[] =3D {
> > @@ -1371,23 +1371,11 @@ static const struct i2c_device_id si1145_ids[] =
=3D {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, si1145_ids);
> >
> > -static int si1145_remove(struct i2c_client *client)
> > -{
> > -     struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > -
> > -     iio_device_unregister(indio_dev);
> > -     si1145_remove_trigger(indio_dev);
> > -     iio_triggered_buffer_cleanup(indio_dev);
> > -
> > -     return 0;
> > -}
> > -
> >  static struct i2c_driver si1145_driver =3D {
> >       .driver =3D {
> >               .name   =3D "si1145",
> >       },
> >       .probe  =3D si1145_probe,
> > -     .remove =3D si1145_remove,
> >       .id_table =3D si1145_ids,
> >  };
> >
>
