Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49233B19A4
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbfIMIaZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:30:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44329 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbfIMIaZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:30:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id i18so480144wru.11
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2019 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BqDiw5DN1az6Q1zSq72ihnxUY+QRltdDYt3MZ9rvTW8=;
        b=hOcIHm7ChFsIVo048Dm+fl6Wj1D6LrGMPqf+n792tESnzwjWWP15HLn4zPpKxLn920
         H4IPcPuo99PZttMdKz/6GYJT4yFEn/wXdUlolqHVqDrJ6ZDqGC8/rxVlCGQkoxyIyUc9
         HWtf/UC6As/syn7takXeXoElBbRDDnKp/A882QP9hN5yaP7gb5xkBdMJ3qOkqw8qOtCI
         cXDWpGc4XnL4a3jjGmrFuwX0tW0tOUcdPJMbiihvdGuRVnnZ1jSxdkrBR17soK69X0ha
         HIK06WELsgvh+TrI8dIEIcROvpztAdHnNE/aShLlL+ocSVIoV2Rd9k3007hg8MSjsUlZ
         9noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BqDiw5DN1az6Q1zSq72ihnxUY+QRltdDYt3MZ9rvTW8=;
        b=fxTWIg1w8qYHWy8zj//CMI3+8P88blugErm5+uZ5Z4BVOVfdvnVnius2GeNULJfC7u
         y4roQIrre+NA4WSzoGFgVVDfoyigjFJJ5lgMydeafSgjSTGpBVHzMfzn9zgyq0KPvaC2
         7VgOGxz3lPVvVNM78VFcxoqGULECMjRf2yQcM2CEDYXKyhmrHNmtujhx73QxVYzjMxaU
         xWX7EM6ayBFefJGWA2wKfhzBI2nLLp8W9FLxC4Y0QlJwvBqZG7mmifVAI4gIcIFGUcoX
         oOYvg3HGp3TrkLUxB+7r7qRBqKTrmmXItw0/LA6VJOC7so5EhcX6Lvopzv54urWFgip5
         NHiw==
X-Gm-Message-State: APjAAAWfXu88VD3MU9UgcMIKO55Yci/H4u7jMr3V6/vigumgkRv8XMRx
        SxxnxY9lXVaLvk0xQGUbYJGUNofYUL2w7lmdoPE=
X-Google-Smtp-Source: APXvYqwAGSvKYhymU2RULFL6+leHLKdRBA1kXXGtMfjVX3qQx+4DIiS43/CljxFn+Il7GXy2Wwx8vAhv3LcCmfam5PQ=
X-Received: by 2002:adf:fe07:: with SMTP id n7mr12234328wrr.90.1568363422542;
 Fri, 13 Sep 2019 01:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <20190912144310.7458-5-andrea.merello@gmail.com> <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
In-Reply-To: <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 13 Sep 2019 10:30:11 +0200
Message-ID: <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
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

Il giorno ven 13 set 2019 alle ore 09:19 Ardelean, Alexandru
<alexandru.Ardelean@analog.com> ha scritto:
>
> On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote:
> > [External]
> >
> > Each time we need to read a sample the driver writes the CFG register
> > (setting the channel to be read in such register) and then it performs
> > another xfer to read the resulting value.
> >
> > This does not work correctly because while writing the CFG register the
> > acquisition phase is ongoing using the _previous_ CFG settings. Then the
> > device performs the conversion during xfer delay on the voltage stored
> > duting the said acquisitaion phase. Finally the driver performs the read
> > (during the next acquisition phase, which is the one done with the right
> > settings) and it gets the last converted value, that is the wrong data.
> >
> > In case the configuration is not actually changed, then we still get
> > correct data, but in case the configuration changes (and this happens e.g.
> > switching the MUX on another channel), we get wrong data (data from the
> > previously selected channel).
> >
> > This patch fixes this by performing one more "dummy" transfer in order to
> > ending up in reading the data when it's really ready.
>
> So, at power-up this chip seems to need 2 dummy reads to discard data.
> Which seems to happen in ad7949_spi_init()
>
> One thing that maybe could be optimized (for the driver), is in `ad7949_spi_read_channel()` to use the current-channel &
> not do a SPI write to change the channel if it doesn't change.
>
> Datasheets (in general) are not always obvious about describing chip behavior for SW (or for writing a driver), but I
> would suspect that if you are reading garbage data, it could be that the channel has changed.
> This is true for some other ADCs.
> And requires testing for this one.

Yes, it's exactly what I've seen here. If the channel does not change
then the AD is already in acquisition phase on the right channel (I
assume it's OK to keep it in such phase indefinitely), then we can
just trigger a new conversion (CNV low->high, that is a dummy xfer)
and then read the result in following xfer, as the driver already did.

I craft a V2 that performs the extra (3rd) spi xfer only if the
channel has to change.

> Added Charles-Antoine, since he wrote the driver.
> Shoud have added him on the other patches as well, but I just remembered.

I tried on my first answer, but apparently mails to his address bounce
back with a failure response..

> Thanks
> Alex
>
> >
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > ---
> >  drivers/iio/adc/ad7949.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 25d1e1b24257..b1dbe2075ca9 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -85,6 +85,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >                                  unsigned int channel)
> >  {
> >       int ret;
> > +     int i;
> >       int bits_per_word = ad7949_adc->resolution;
> >       int mask = GENMASK(ad7949_adc->resolution, 0);
> >       struct spi_message msg;
> > @@ -97,12 +98,19 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> >               },
> >       };
> >
> > -     ret = ad7949_spi_write_cfg(ad7949_adc,
> > -                                channel << AD7949_OFFSET_CHANNEL_SEL,
> > -                                AD7949_MASK_CHANNEL_SEL);
> > -     if (ret)
> > -             return ret;
> > +     /*
> > +      * 1: write CFG for sample 'n' and read garbage (sample n-2)
> > +      * 2: write something and read garbage (sample n-1)
> > +      */
> > +     for (i = 0; i < 2; i++) {
> > +             ret = ad7949_spi_write_cfg(ad7949_adc,
> > +                                        channel << AD7949_OFFSET_CHANNEL_SEL,
> > +                                        AD7949_MASK_CHANNEL_SEL);
> > +             if (ret)
> > +                     return ret;
> > +     }
> >
> > +     /* 3: write something and read data for sample 'n' */
> >       ad7949_adc->buffer = 0;
> >       spi_message_init_with_transfers(&msg, tx, 1);
> >       ret = spi_sync(ad7949_adc->spi, &msg);
