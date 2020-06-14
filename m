Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0401F8AA0
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 22:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFNUYd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 16:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNUYd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2020 16:24:33 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7D6C08C5C2
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2020 13:24:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e11so13425623ilr.4
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2020 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIHQL3bA+IBo54uxKD+KcZzvnk9YLC2isaj8aUTmha4=;
        b=sH2308qqzTvp7UojKJsB13yFoyWXTXgeyCsviVKcCAmoiMDDo/2SnonS6va5KGg+vh
         jGZuY1N6/xXG1W0jQYN9WnRH/cV6TSIVmG3N0zJI0QKRLk7CaMLgkLF7BmHfmgiK/X7x
         CWxp6cxi/1ugOc75nYcKLH6P8rObwplRaOrUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIHQL3bA+IBo54uxKD+KcZzvnk9YLC2isaj8aUTmha4=;
        b=jvdIuRdj2veMXlNfsE4waZ+YN4lfxLdfq2lfGAExxO/eU1p5l1NHssVcHAgEtyhuUh
         a4XKtBAR73azHq/mEZWzPSU/7OeXht7q/Hc/PkDiDr+OB8hdHNn8BnSkCed3rLbyYMos
         hILdvumrZHM2dqr1gNNlx3xSR2fjkJOYU19o8HwzzeIpOcLn757+XTQdA4MWcLnyHhRa
         HG4utqn6NaAKBmLTTd7UnGCxsa1AH77psssHtKQ0HSswoZhDh8kwAo/j1KwRbKhkx+i/
         EbyEAtXWoSi176Ti0bc2IV+R4JUu0vojAXHPzLoFlCdDeQjnZC78jYSWpWkq1wZ7m44k
         VTqQ==
X-Gm-Message-State: AOAM5327VXzXdLFBfYtfm7CPIruwpVw9H6uNw0BeHfCo10V0IsZ20ghB
        w40yj0txucU1jsKgpRs2Aql6jnNKjCULukDvfrJqRKTJnFk=
X-Google-Smtp-Source: ABdhPJxlyN9HZx6gYfGR9u1oQFVI2Zoja6FcJkfVKI4puBYcOoPJuWF91/e3vq4hUEgtefZYSwfWZdBaZHtEcnB1PIo=
X-Received: by 2002:a92:dccd:: with SMTP id b13mr22706534ilr.98.1592166271638;
 Sun, 14 Jun 2020 13:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200609194117.5837-1-matt.ranostay@konsulko.com>
 <20200609194117.5837-4-matt.ranostay@konsulko.com> <20200614143921.24e1ce15@archlinux>
In-Reply-To: <20200614143921.24e1ce15@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 14 Jun 2020 13:24:20 -0700
Message-ID: <CAJCx=gnd8vUR1SOqBcsAvAB9rG2iBGXN97Ow3H01S9DEmax3bQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: chemical: atlas-ezo-sensor: add support for O2 sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 14, 2020 at 6:39 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue,  9 Jun 2020 12:41:17 -0700
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > Add support for the Atlas EZO O2 chemical sensor which required
> > some refactoring of the driver and parsing of i2c transfer.
> >
> > Sensor data is converted by the scaling value from percent to
> > IIO_CONCENTRATION.
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> Hohum.  I could just apply this series today (looks good) but
> given you just fixed that missing strings problem, that will make
> for a messy merge for Greg when I send this via togreg and the
> fix via fixes-togreg.
>
> As such I'm going to sit on this one until that fix ends up in my
> upstream then pick this up.
>
> Do remind me if I seem to have lost it though once that's true!

Will do!

- Matt

>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/chemical/atlas-ezo-sensor.c | 74 ++++++++++++++++++-------
> >  1 file changed, 55 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> > index a94eb8a6bf32..94188c84e65f 100644
> > --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> > +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> > @@ -16,10 +16,11 @@
> >  #include <linux/iio/iio.h>
> >
> >  #define ATLAS_EZO_DRV_NAME           "atlas-ezo-sensor"
> > -#define ATLAS_CO2_INT_TIME_IN_MS     950
> > +#define ATLAS_INT_TIME_IN_MS         950
> >
> >  enum {
> >       ATLAS_CO2_EZO,
> > +     ATLAS_O2_EZO,
> >  };
> >
> >  struct atlas_ezo_device {
> > @@ -38,31 +39,54 @@ struct atlas_ezo_data {
> >       u8 buffer[8];
> >  };
> >
> > +#define ATLAS_CONCENTRATION_CHANNEL(_modifier) \
> > +     { \
> > +             .type = IIO_CONCENTRATION, \
> > +             .modified = 1,\
> > +             .channel2 = _modifier, \
> > +             .info_mask_separate = \
> > +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE), \
> > +             .scan_index = 0, \
> > +             .scan_type =  { \
> > +                     .sign = 'u', \
> > +                     .realbits = 32, \
> > +                     .storagebits = 32, \
> > +                     .endianness = IIO_CPU, \
> > +             }, \
> > +     }
> > +
> >  static const struct iio_chan_spec atlas_co2_ezo_channels[] = {
> > -     {
> > -             .type = IIO_CONCENTRATION,
> > -             .modified = 1,
> > -             .channel2 = IIO_MOD_CO2,
> > -             .info_mask_separate =
> > -                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > -             .scan_index = 0,
> > -             .scan_type = {
> > -                     .sign = 'u',
> > -                     .realbits = 32,
> > -                     .storagebits = 32,
> > -                     .endianness = IIO_CPU,
> > -             },
> > -     },
> > +     ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_CO2),
> > +};
> > +
> > +static const struct iio_chan_spec atlas_o2_ezo_channels[] = {
> > +     ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_O2),
> >  };
> >
> >  static struct atlas_ezo_device atlas_ezo_devices[] = {
> >       [ATLAS_CO2_EZO] = {
> >               .channels = atlas_co2_ezo_channels,
> >               .num_channels = 1,
> > -             .delay = ATLAS_CO2_INT_TIME_IN_MS,
> > +             .delay = ATLAS_INT_TIME_IN_MS,
> >       },
> > +     [ATLAS_O2_EZO] = {
> > +             .channels = atlas_o2_ezo_channels,
> > +             .num_channels = 1,
> > +             .delay = ATLAS_INT_TIME_IN_MS,
> > +     }
> >  };
> >
> > +static void atlas_ezo_sanitize(char *buf)
> > +{
> > +     char *ptr = strchr(buf, '.');
> > +
> > +     if (!ptr)
> > +             return;
> > +
> > +     for (; *ptr; ptr++)
> > +             *ptr = *(ptr + 1);
> > +}
> > +
> >  static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
> >                         struct iio_chan_spec const *chan,
> >                         int *val, int *val2, long mask)
> > @@ -96,6 +120,9 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
> >                       return -EBUSY;
> >               }
> >
> > +             /* removing floating point for fixed number representation */
> > +             atlas_ezo_sanitize(data->buffer + 2);
> > +
> >               ret = kstrtol(data->buffer + 1, 10, &tmp);
> >
> >               *val = tmp;
> > @@ -105,9 +132,16 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
> >               return ret ? ret : IIO_VAL_INT;
> >       }
> >       case IIO_CHAN_INFO_SCALE:
> > -             *val = 0;
> > -             *val2 = 100; /* 0.0001 */
> > -             return IIO_VAL_INT_PLUS_MICRO;
> > +             switch (chan->channel2) {
> > +             case IIO_MOD_CO2:
> > +                     *val = 0;
> > +                     *val2 = 100; /* 0.0001 */
> > +                     return IIO_VAL_INT_PLUS_MICRO;
> > +             case IIO_MOD_O2:
> > +                     *val = 100;
> > +                     return IIO_VAL_INT;
> > +             }
> > +             return -EINVAL;
> >       }
> >
> >       return 0;
> > @@ -119,12 +153,14 @@ static const struct iio_info atlas_info = {
> >
> >  static const struct i2c_device_id atlas_ezo_id[] = {
> >       { "atlas-co2-ezo", ATLAS_CO2_EZO },
> > +     { "atlas-o2-ezo", ATLAS_O2_EZO },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
> >
> >  static const struct of_device_id atlas_ezo_dt_ids[] = {
> >       { .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
> > +     { .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
>
