Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A793F3426
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhHTS70 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 14:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHTS70 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 14:59:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E59C061575
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 11:58:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso14433274pjh.5
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YINDw5DGKE8Qx8BxfHkzq9fv8gONkRHjm8zG85pCSIo=;
        b=H3usaMRfhp2v2ITJKcyVO1UflUuLDCAnFOLW+lEUVmWP6X0Cy23EEb52SinJc8KZRr
         v8qU18rBzHOcRF77UULvjCrkOvKPDWz9XI+eV5piCM5Ynr/3QMknFV5SjUpnbCeFAsTO
         qKlQOqszEv3mCER87zkHrXEGVaDFq8pTZh5e9nf7YKMItJSXzQV2Tl+wlnG0s9S/itSQ
         +6RR+sU1LdtmoIvTzd2aOJmx8dMmFbzj0V6pEGsAmqTAW7L9jp4fXyU9pC6aPVV5pJy0
         BeFowDN0hvVKH2AuwVjSFdiW8nyeburKX+mmmPYicxeAhJy3Rxz/XH2c6h8zBDI1qTnP
         G/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YINDw5DGKE8Qx8BxfHkzq9fv8gONkRHjm8zG85pCSIo=;
        b=lH1HL6ArcWsJFcAISpNSOm4em7zdkZt8QRkmQfwSVJYJrbvHJWr2sl55nO8W5J3M3m
         fj1FFywm6oMQ+haX29Ut3hvl4nwnW/3DWXsqtpwuBYJ+l5222dNNn5b84MUzi4xMVJXh
         k9f7xof1bq0u9SpCBW0isZBovRzmHTnXPS82RuMLsBsFkQs0wl91R6lYFtzSUg64RGax
         8sH5ZqWJUKl9SHTxHec+OPIuuaQ0UUh/yvTannNJXYQ9MCcT3PYj2Dl6bkoCNnRerI+K
         dOEOKbvKD6ma23mAEyHEQz8JaDEw2ciBEG4iNqh5yVECdpqHT87gaG+UzzRFwLm7+dyo
         F/5g==
X-Gm-Message-State: AOAM532PHCvk+V8Izwg4odV9tauplIgg4CalM+2sz6mAq3VxMAPIFtWn
        RtPhKGmVYIWlfhecBiSVoKKMO0BqzAxejgcR3aU=
X-Google-Smtp-Source: ABdhPJz5C8lTnB6W8cGoxAmegxd3FnT6viEU3DVf4saKePCxh1gu7IHkPbMMTm7sGRkd79ev4BWOUeOVy+OGVvkJff0=
X-Received: by 2002:a17:90b:46cd:: with SMTP id jx13mr6062141pjb.181.1629485927844;
 Fri, 20 Aug 2021 11:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210820065535.6994-1-nuno.sa@analog.com> <CA+U=Dso61XreVxxz8a3cSO+LJrdQAJAi--3Nuv5nRG=buuVCcQ@mail.gmail.com>
 <SJ0PR03MB6359B7B5B7BF6975590879EC99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB6359B7B5B7BF6975590879EC99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 20 Aug 2021 21:58:36 +0300
Message-ID: <CA+U=Dsr6UevuFcJ9rositNx9hMx_Pwj4AnTHcN_ioEg5tOPueQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 20, 2021 at 12:29 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Sent: Friday, August 20, 2021 10:21 AM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Drew
> > Fustini <drew@pdp7.com>
> > Subject: Re: [PATCH 1/2] iio: ltc2983: add support for optional reset
> > gpio
> >
> > [External]
> >
> > On Fri, Aug 20, 2021 at 9:53 AM Nuno S=C3=A1 <nuno.sa@analog.com>
> > wrote:
> > >
> > > Check if an optional reset gpio is present and if so, make sure to
> > reset
> > > the device.
> > >
> >
> > Just one note/question inline.
> >
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > >  drivers/iio/temperature/ltc2983.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/iio/temperature/ltc2983.c
> > b/drivers/iio/temperature/ltc2983.c
> > > index 3b4a0e60e605..37903e9fb90f 100644
> > > --- a/drivers/iio/temperature/ltc2983.c
> > > +++ b/drivers/iio/temperature/ltc2983.c
> > > @@ -1470,6 +1470,7 @@ static int ltc2983_probe(struct spi_device
> > *spi)
> > >  {
> > >         struct ltc2983_data *st;
> > >         struct iio_dev *indio_dev;
> > > +       struct gpio_desc *gpio;
> > >         const char *name =3D spi_get_device_id(spi)->name;
> > >         int ret;
> > >
> > > @@ -1494,6 +1495,16 @@ static int ltc2983_probe(struct spi_device
> > *spi)
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       gpio =3D devm_gpiod_get_optional(&st->spi->dev, "reset",
> > GPIOD_OUT_HIGH);
> > > +       if (IS_ERR(gpio))
> > > +               return PTR_ERR(gpio);
> > > +
> > > +       if (gpio) {
> > > +               /* bring device out of reset */
> > > +               usleep_range(1000, 1005);
> > > +               gpiod_set_value_cansleep(gpio, 0);
> >
> > Datasheet mentions that it takes up to 100 ms for the device to fully
> > start-up.
> > It also mentions that the (command) status register will be
> > unavailable to the user before this point.
> > Page 16, Conversion State Details section, second paragraph.
> >
> > I think there should probably be a sleep here of 100 ms.
> >
> > Other than that change looks good.
> >
>
> In the setup function we do a polled read on the status register until
> we get the indication we are up. This was actually a fix sent recently
> [1].
>

Yes, I saw that.
But I did not have energy to look at it too in-depth [at that moment in tim=
e].
Apologies.

But the question is: is the statement on page 16 valid?
i.e. do we need to wait 100ms after the reset pin goes low? because it stat=
es:

In the first phase of the start-up state all critical analog circuits
are powered up.
This includes the LDO, reference, charge pump and ADCs.
***During this first phase, the com-mand status register will be
inaccessible to the user.***
***This phase takes a maximum of 100mS to complete. ***
Once this phase completes, the command status register will be
accessible and return
a value of 0x80 until the LTC2983 is completely initialized.

> [1]: https://patchwork.kernel.org/project/linux-iio/patch/20210811133220.=
190264-2-nuno.sa@analog.com/
> - Nuno S=C3=A1
>
> > > +       }
> > > +
> > >         ret =3D ltc2983_setup(st, true);
> > >         if (ret)
> > >                 return ret;
> > > --
> > > 2.33.0
> > >
