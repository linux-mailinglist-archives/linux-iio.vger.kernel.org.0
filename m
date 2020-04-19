Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA901AFD39
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 20:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDSSyw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 14:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgDSSyw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 14:54:52 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2971C061A0C
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2020 11:54:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id 19so8396844ioz.10
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2020 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITvS7qUqIIw42AhwU8Rwqx3H4sOAtCX90U764cHub40=;
        b=Fi+ZPaMcjnKOpu09rv98sd7+SndUYjbzPAW/w5trvFbkup/9szunC8ylWiwqfvS/1A
         tYQ3TSX3Nv+qOWxom8grIXcjWl2KEurOFynwgjtxctSfabhcdBkvGfYexsyzzOoYKIgV
         ysX+QdS1cRrRG7gV1DFardgneHDkSeL5OBEcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITvS7qUqIIw42AhwU8Rwqx3H4sOAtCX90U764cHub40=;
        b=JhO4vcgLCJZXyTJNgLWiLDhEfo91fkcvZmeEr4GcGf1DUvFF1tm/E38u0mThC+GcJz
         amuF6PXilk0UpNP5hNmNia1F/SYp7uZdGiGMAdcIJ8U5EUTn7qI1TjjoR6AFWjKOa+o6
         UPhx9EsatNgvcRPT8yT703zyCCeuw4azS5V+vupaEff7FuO/+1epWVQi3l7w4mF7aPyg
         5ee26880IuXAu+EMUc9VmTJIey+OMJaPxVMLRJWtjSuRnL0y9mcF4f77bhig/s5aEkwt
         8vabR8fnaoSbzfhAaUNG1MjQ8s6ckXiRJAmFbPNSM8I+MsUJFLHadSX9VyWFCer5B2zv
         WApw==
X-Gm-Message-State: AGi0PuZWdxu5AdQCALIgBvUBB0T6e9VFe1GLl1h1Foggk18XKU/gEfQR
        EbU6EGtieP+hYvVMEMujeK9so9jHXVuKAHt5jGo61g==
X-Google-Smtp-Source: APiQypKbn6PKnkN30Jn6mRQe6lHgGCt4GeeDyqR2x8fbEr6N6pkFQUMxMUkL+XhAoCP5Trs22gKOoiZ9Lm+b95Szgm0=
X-Received: by 2002:a02:7611:: with SMTP id z17mr12473200jab.42.1587322490102;
 Sun, 19 Apr 2020 11:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200419060555.14433-1-matt.ranostay@konsulko.com>
 <20200419060555.14433-3-matt.ranostay@konsulko.com> <alpine.DEB.2.21.2004191115080.12852@vps.pmeerw.net>
In-Reply-To: <alpine.DEB.2.21.2004191115080.12852@vps.pmeerw.net>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 19 Apr 2020 11:54:39 -0700
Message-ID: <CAJCx=gmaYqoBD2GKJVhyy6R8hE_KziO2qJxFgnD9tq5=OOhHYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: chemical: atlas-sensor: add RTD-SM module support
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 19, 2020 at 2:18 AM Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
> On Sun, 19 Apr 2020, Matt Ranostay wrote:
>
> > Atlas Scientific RTD-SM OEM sensor reads temperate using
>
> reads temperature?
Typo, will fix.

>
> > resistance temperature detector technology.
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/chemical/atlas-sensor.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> > index 82d470561ad3..c7ed9004cf82 100644
> > --- a/drivers/iio/chemical/atlas-sensor.c
> > +++ b/drivers/iio/chemical/atlas-sensor.c
> > @@ -68,16 +68,20 @@
> >  #define ATLAS_REG_DO_TEMP_DATA               0x12
> >  #define ATLAS_REG_DO_DATA            0x22
> >
> > +#define ATLAS_REG_RTD_DATA           0x0e
>
> maybe keep registers in ascending order
>
> > +
> >  #define ATLAS_PH_INT_TIME_IN_MS              450
> >  #define ATLAS_EC_INT_TIME_IN_MS              650
> >  #define ATLAS_ORP_INT_TIME_IN_MS     450
> >  #define ATLAS_DO_INT_TIME_IN_MS              450
> > +#define ATLAS_RTD_INT_TIME_IN_MS     450
> >
> >  enum {
> >       ATLAS_PH_SM,
> >       ATLAS_EC_SM,
> >       ATLAS_ORP_SM,
> >       ATLAS_DO_SM,
> > +     ATLAS_RTD_SM,
> >  };
> >
> >  struct atlas_data {
> > @@ -206,6 +210,22 @@ static const struct iio_chan_spec atlas_do_channels[] = {
> >       },
> >  };
> >
> > +static const struct iio_chan_spec atlas_rtd_channels[] = {
> > +     {
> > +             .type = IIO_TEMP,
> > +             .address = ATLAS_REG_RTD_DATA,
> > +             .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +             .scan_index = 0,
> > +             .scan_type = {
> > +                     .sign = 'u',
>
> so this thing can't read negative temperature?

Hmm good question. I'll ask Atlas since the datasheet says to -126 C
but doesn't note if it
is in two's complement or not

>
> > +                     .realbits = 32,
> > +                     .storagebits = 32,
> > +                     .endianness = IIO_BE,
>
> _PROCESSED, but still stored as big endian? hm

Ah should be _PROCESSED, but still need a entry in atlas_read_raw i
just noted to
read the value and be16_to_cpu

- Matt

>
> > +             },
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(1),
> > +};
> > +
> >  static int atlas_check_ph_calibration(struct atlas_data *data)
> >  {
> >       struct device *dev = &data->client->dev;
> > @@ -350,6 +370,12 @@ static struct atlas_device atlas_devices[] = {
> >                               .calibration = &atlas_check_do_calibration,
> >                               .delay = ATLAS_DO_INT_TIME_IN_MS,
> >       },
> > +     [ATLAS_RTD_SM] = {
> > +                             .channels = atlas_rtd_channels,
> > +                             .num_channels = 2,
> > +                             .data_reg = ATLAS_REG_RTD_DATA,
> > +                             .delay = ATLAS_RTD_INT_TIME_IN_MS,
> > +     },
> >  };
> >
> >  static int atlas_set_powermode(struct atlas_data *data, int on)
> > @@ -566,6 +592,7 @@ static const struct i2c_device_id atlas_id[] = {
> >       { "atlas-ec-sm", ATLAS_EC_SM},
> >       { "atlas-orp-sm", ATLAS_ORP_SM},
> >       { "atlas-do-sm", ATLAS_DO_SM},
> > +     { "atlas-rtd-sm", ATLAS_RTD_SM},
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(i2c, atlas_id);
> > @@ -575,6 +602,7 @@ static const struct of_device_id atlas_dt_ids[] = {
> >       { .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
> >       { .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
> >       { .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
> > +     { .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(of, atlas_dt_ids);
> >
>
> --
>
> Peter Meerwald-Stadler
> Mobile: +43 664 24 44 418
