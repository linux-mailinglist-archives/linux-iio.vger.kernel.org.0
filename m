Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7296824EA1B
	for <lists+linux-iio@lfdr.de>; Sun, 23 Aug 2020 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgHVWsT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Aug 2020 18:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgHVWsQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2020 18:48:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EAEC061573
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2020 15:48:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so5147490ioe.5
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2020 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuQXF3Z78FnjlKAbtX0UaK1svJGxRlpoN5dcaoLan3I=;
        b=k+DPAuEc13yCtSXpSX+1alYZp9ReRT7JvXwKWL6/XOEBv+r6J7NbR5ldn5o5X/MU8K
         JBrlLdyLafuN7iqG5pKHeQ7QP0Wb4eTmxJ37MVZUPi3+4lnvJ+TmUAUZaR91I/5Zhxhq
         qkS2zotk17bOUkVO8bl3LUeh8MUeIsDh/P2lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuQXF3Z78FnjlKAbtX0UaK1svJGxRlpoN5dcaoLan3I=;
        b=Te7WPx8rtgI7SMhGjjjpB6p/rflO95ZYRZKd0FBzJwrxBE2x5Qnc6biYhzyYQ40raJ
         8YVxt2HK1L8SthbzKHVx9riUPiLCbQV3Q+5lEmKhhW+otdVGX93aGSKt/RqrYXmHne6A
         xMPRvp50CUOKKWW1W8kmMpaCAQMWhXvR2S4BtpYkooiJU+d4cS1fXhBH2Ml7QoYDpQvq
         a4txYwUDp0cpGnXOKlSCtfDKjYYxSY3eN/IJ/GqI4QZMTqnjZqVYejGOCSX+6GGP+tDs
         j1hh2AJQ/JMbUL3srU8UV7qYGO/Qs5Svn1W+bLt4NllwHLPE09qPLKWJxjlb8bSI6NNV
         fwNg==
X-Gm-Message-State: AOAM5316+k8Z0slb/spyNqHa1lWKc22dyqidgcCF+n9KlDxSLngxu+8M
        dpkg+6pJKCSNHJuPvHEk73sCKTWK6enpFZlO6TxlO0EYcA8=
X-Google-Smtp-Source: ABdhPJzhGDfw6se31XpUSnJEmSpEPElT3B2h382dwTVfAbnThOZApz1k7wnuivVgIrUFHa/+YBh5dIDA2xdkoypT2TE=
X-Received: by 2002:a05:6638:1116:: with SMTP id n22mr8284951jal.117.1598136490501;
 Sat, 22 Aug 2020 15:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200817005052.11565-1-matt.ranostay@konsulko.com>
 <20200817005052.11565-3-matt.ranostay@konsulko.com> <20200822120140.0a2c6d0f@archlinux>
In-Reply-To: <20200822120140.0a2c6d0f@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 22 Aug 2020 15:47:58 -0700
Message-ID: <CAJCx=gngQNkwFuG3TtUrOLp04G1gmbsf5+6Js88EbwtRK-wxRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: chemical: atlas-ezo-sensor: add humidity
 sensor support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 22, 2020 at 4:01 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 17 Aug 2020 03:50:52 +0300
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > Add support for atlas,hum-ezo / humidity sensor which with scaling
> > provides respective data in millipercent
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> One comment inline.
>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/chemical/atlas-ezo-sensor.c | 37 ++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> > index 60a0c752fbc5..b1bacfe3c3ce 100644
> > --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> > +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> > @@ -17,10 +17,12 @@
> >
> >  #define ATLAS_EZO_DRV_NAME           "atlas-ezo-sensor"
> >  #define ATLAS_INT_TIME_IN_MS         950
> > +#define ATLAS_INT_HUM_TIME_IN_MS     350
> >
> >  enum {
> >       ATLAS_CO2_EZO,
> >       ATLAS_O2_EZO,
> > +     ATLAS_HUM_EZO,
> >  };
> >
> >  struct atlas_ezo_device {
> > @@ -63,6 +65,21 @@ static const struct iio_chan_spec atlas_o2_ezo_channels[] = {
> >       ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_O2),
> >  };
> >
> > +static const struct iio_chan_spec atlas_hum_ezo_channels[] = {
> > +     {
> > +             .type = IIO_HUMIDITYRELATIVE,
> > +             .info_mask_separate =
> > +                     BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index = 0,
> > +             .scan_type =  {
> > +                     .sign = 'u',
> > +                     .realbits = 32,
> > +                     .storagebits = 32,
> > +                     .endianness = IIO_CPU,
> > +             },
> > +     },
> > +};
> > +
> >  static struct atlas_ezo_device atlas_ezo_devices[] = {
> >       [ATLAS_CO2_EZO] = {
> >               .channels = atlas_co2_ezo_channels,
> > @@ -73,7 +90,12 @@ static struct atlas_ezo_device atlas_ezo_devices[] = {
> >               .channels = atlas_o2_ezo_channels,
> >               .num_channels = 1,
> >               .delay = ATLAS_INT_TIME_IN_MS,
> > -     }
> > +     },
> > +     [ATLAS_HUM_EZO] = {
> > +             .channels = atlas_hum_ezo_channels,
> > +             .num_channels = 1,
> > +             .delay = ATLAS_INT_HUM_TIME_IN_MS,
> > +     },
> >  };
> >
> >  static void atlas_ezo_sanitize(char *buf)
> > @@ -131,6 +153,17 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
> >               return ret ? ret : IIO_VAL_INT;
> >       }
> >       case IIO_CHAN_INFO_SCALE:
> > +             switch (chan->type) {
> > +             case IIO_HUMIDITYRELATIVE:
> > +                     *val = 10;
> > +                     return IIO_VAL_INT;
> > +             case IIO_CONCENTRATION:
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
>
> This structure strikes me as something that might get rather ugly if it
> gets much more complex.
>
> I'll take this one, but keep in mind for any future additions to the driver!

Yeah I agree, and future additions will probably need a much less
hacky switch {} assortment.


- Matt

>
> Jonathan
>
> > +
> > +             /* IIO_CONCENTRATION modifiers */
> >               switch (chan->channel2) {
> >               case IIO_MOD_CO2:
> >                       *val = 0;
> > @@ -153,6 +186,7 @@ static const struct iio_info atlas_info = {
> >  static const struct i2c_device_id atlas_ezo_id[] = {
> >       { "atlas-co2-ezo", ATLAS_CO2_EZO },
> >       { "atlas-o2-ezo", ATLAS_O2_EZO },
> > +     { "atlas-hum-ezo", ATLAS_HUM_EZO },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
> > @@ -160,6 +194,7 @@ MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
> >  static const struct of_device_id atlas_ezo_dt_ids[] = {
> >       { .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
> >       { .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
> > +     { .compatible = "atlas,hum-ezo", .data = (void *)ATLAS_HUM_EZO, },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
>
