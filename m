Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C11B198C
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbfIMIXp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:23:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46317 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIMIXp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:23:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so18374064wrq.13
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2019 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+sse2o0oVpVQRokQaERVZ/vj13UyRiej9RTM77KOWVk=;
        b=vNrWp+5lcujPhuGzv+ZhlIcjbSjuiQL/uTjRCBwIzg5BcodXCz6XuyOhAN1OVLXusq
         n0fZjUpJJCRGEul7M1/aCd7o1qRs9BdzOA9fsqxjjxmIiYbYG9vOQGjb364iYyAnKYUI
         KghnTT8jbc1n9viG9SuO0SlpAvaZtoDAyjIuKYucghdFjFIDsKz7kMfnBrH/TtimEfWl
         awEGucOigbJT0fIjncRBWtRDaJawwe5QbmH5RsWJ0VIcYeyztgykLk2lqdpkgZCoT+3F
         LOMBVVpm8RikmK1oOc6M+dqpu0PpD0iU2Hds6skl7yobJxtwD5qTboQ9qfXB5IpQn1c7
         61ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+sse2o0oVpVQRokQaERVZ/vj13UyRiej9RTM77KOWVk=;
        b=LWGvgttaOTkRGsmHZ2Om6EDA4En16ZFA6JmZ22EsQYdrtffVfE738zEK+GZ0vzkRx1
         Wkfz/zi/04ZvG/bKz5yzs1Ysipn70qGJ0Bb5H658MTOVKUe/ywcXgkyrsWzNPlQRXgGU
         QH1I7FFJkrPoVXotTS7amuEjD0JwUXMfEWys64Z4OsMGXyxFYQKALaH4dQAevjr90M9M
         NrNUKTRA03JeV4TVYGfyOaducgCcEmCNQkEKWqec0UplCwy7ClQuDk4eLJ9P19LSOyOo
         KeIGHqVGwuLlVwMRGrGBVGT8xKYupKi4qy0teBBIbTYAT1+fdHVH/9dCW8odJuakHl0l
         eSjQ==
X-Gm-Message-State: APjAAAXmyGUcULey2etnS/kXNM6UoyUVq0DksV5XtjMoHnUQiry1lnWp
        d50EUJZdt+YdChqOqu+e5SSWN66/shJ9fiz3HCWsvGQG
X-Google-Smtp-Source: APXvYqx+0l6yFugEuKI5ffb0bRpix9jqhd0zhQhgbKMN3sED3Ops5kOmC9La/bFPSaC4WHnjjXBDkfSAxCZgAk2I+iQ=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr6724787wrv.339.1568363022353;
 Fri, 13 Sep 2019 01:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <20190912144310.7458-4-andrea.merello@gmail.com> <794eb574e4bc9cb4f0b2723d72baeb8f63c07283.camel@analog.com>
In-Reply-To: <794eb574e4bc9cb4f0b2723d72baeb8f63c07283.camel@analog.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 13 Sep 2019 10:23:30 +0200
Message-ID: <CAN8YU5MBKsFyjbpWw5w41kerQwkOois_AU1OuV6aNX1_3LmSBQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: ad7949: fix SPI xfer delays
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno ven 13 set 2019 alle ore 09:00 Ardelean, Alexandru
<alexandru.Ardelean@analog.com> ha scritto:
>
> On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote:
> > [External]
> >
> > The driver calls udelay(2) after each SPI xfer. However, according to
> > the specifications, the SPI timing should be as follows:
> >
> > 1- The end of SPI xfer (CNV/CS rising edge) causes the device to initiate
> >    the conversion phase, which takes up to 2.2uS.
>
> Yes, but there does not seem to be a minimum time for conversion.
> ( 2.2 uS is the max value )
>
> This can be confusing a bit (I know).
> If you do see issues with 2 uS, we can probably try 3 uS (+1 uS which is roughly half the max value).
> Though, we are already gaining min 200 nS from the fact that the acquisition time is 1.8 uS and the delay is 2 uS.
>
> But if there aren't any visible issues, I would leave 2 uS.
> Increasing this delay can annoy people that would like to have some speed when reading samples.

I admit that I got some hard time trying to fully understand the
timing specifications; so it's perfectly possible that I've got
something wrong here.. My interpretation was that the HW takes up to
2.2uS (thus it's a max value, as you said) and, since we are not using
the busy indication to check when the HW really finished, I stayed on
the safe side.

I've done this change while I was searching for the cause of some
reading issues that turned out to be actually fixed with the last
patch of the series, so I have no real evidence of  issues caused by
the 2uS delay. However, if I understood correctly the datasheet, the
effect of performing an early SPI xfer during the conversion phase -
specifically if it happens after tDATA and before EndOfConversion -
might be mild, so not it might be not obvious to notice (maybe affects
just LSBs) it with my basic testing. Quoting the datasheet: "The time
between tDATA and tCONV is a safe time when digital activity should
not occur, or sensitive bit decisions may be corrupted. "..

> I know 1-2 uS isn't much of a performance killer, but if there aren't reasons to change it, I wouldn't.

I guess you know the HW by far better than me, so if you say that 2uS
is OK then I will not insist anymore here :)

>
> >
> > 2- At the end of the conversion phase, the device starts the acquisition
> >    phase for the next conversion automatically (regardless to the state of
> >    CNV pin); the conversion phase should last at least 1.8 uS
> >
> > The whole cycle timing is thus 4uS long. The SPI data is read during the
> > acquisition phase (RAC mode, no need to worry about "Tdata").
> >
> > In order to be compliant wrt these timing specifications we should wait
> > 4uS after each SPI xfer (that is conservative, because there is also the
> > SPI xfer duration itself - which at the maximum supported clock should be
> > about 320nS).
> >
> > This patch enlarges the delay up to 4uS and it also removes the explicit
> > calls to udelay(), relying on spi_transfer->delay_usecs.
> >
>
> I like the switch from explicit udelay() to spi_transfer->delay_usecs.
> The code looks cleaner.
>
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > ---
> >  drivers/iio/adc/ad7949.c | 13 ++-----------
> >  1 file changed, 2 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 5c2b3446fa4a..25d1e1b24257 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -69,6 +69,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> >                       .tx_buf = &ad7949_adc->buffer,
> >                       .len = 2,
> >                       .bits_per_word = bits_per_word,
> > +                     .delay_usecs = 4,
> >               },
> >       };
> >
> > @@ -77,11 +78,6 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
> >       spi_message_init_with_transfers(&msg, tx, 1);
> >       ret = spi_sync(ad7949_adc->spi, &msg);
> >
> > -     /*
> > -      * This delay is to avoid a new request before the required time to
> > -      * send a new command to the device
> > -      */
> > -     udelay(2);
> >       return ret;
> >  }
> >
> > @@ -97,6 +93,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >                       .rx_buf = &ad7949_adc->buffer,
> >                       .len = 2,
> >                       .bits_per_word = bits_per_word,
> > +                     .delay_usecs = 4,
> >               },
> >       };
> >
> > @@ -112,12 +109,6 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >       if (ret)
> >               return ret;
> >
> > -     /*
> > -      * This delay is to avoid a new request before the required time to
> > -      * send a new command to the device
> > -      */
> > -     udelay(2);
> > -
> >       ad7949_adc->current_channel = channel;
> >
> >       *val = ad7949_adc->buffer & mask;
