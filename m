Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0640C291570
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 05:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgJRDmu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Oct 2020 23:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgJRDmu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Oct 2020 23:42:50 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE40C061755
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2020 20:42:48 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r4so9112498ioh.0
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2020 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkSGQdL943VDrsmdb10J5hX95hPmKoJSkrx0ICPNPW0=;
        b=TCnFUUJA6ByeCjESWJiknlx0A9asFOS/Rh1WDSbB+B2yBoASTB37VGBFuUo+K1ecz1
         qKYaHeW/Hjqf30ZBArkJaoXz9hpEe71q+nupYlxzj0hbl/sJoRs3eyk3cKPEHMdF7kyU
         vmC4KS1HSEPQdkUu9UOksa5ESXscA18ugjLvwgeKPlSMIrS3rigzBGTzaTrUsyiVZslF
         hmD+S2lKxHngwyTEloVWPojBvTyZdD99WTJIQcr3UfUtz8PSwkGlOdJagNRTtD37mUrx
         zP53q1nyPthMXKPwb/Cz7ruklAYlHZyb7vI3PwnMVRU5JhIVVVu7IFVwVBiqpIi0+zz4
         MaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkSGQdL943VDrsmdb10J5hX95hPmKoJSkrx0ICPNPW0=;
        b=Fro+gCObOSjg/ARXmRWc/b6T4vhHhWKQhN7A24/XNV+qlAxTY3lQwtzbxdPlznyfv1
         qdUnx8mZIma//9DwkSRZp5pw1QRrDbtJ2JGcBI9F7eZoqbLDXlw2mZgrmcmixP5MlTTV
         8js5HujJdJ0obUSNx6zAzlOXYZHEzXOBfdWgBBHL+YwSnskbBS3hUFVNUO4nPq9MFaQF
         3Ucq047IauHRINWoDNehPpBHDXgJaCZbUk5mP2obH4V2+DrkzWJTE7G5nF0/3DLp27B7
         jTbeVARJ5lraBJV3x6utln2xH4jOBzUaFJFRvRdVeOevt0rFdkAE3jo4zRmNSAgE9o0n
         tcuA==
X-Gm-Message-State: AOAM530ebB7+VmSabPd3OyRc2WgNBYJ5AbGphbteOZm5lXrkaqUdH5Kj
        O5Uqqa1VlQJE+HYsORPTw38mKy/OKcTelInD7whD
X-Google-Smtp-Source: ABdhPJyKt2vu+UQe7mohE7fpE2xNkZWK/MOsP5aidY1Da89fHr8wu1ssg4rqURcYAKDAs7OIgsG6cerK0+m+hq6WPrw=
X-Received: by 2002:a6b:bfc7:: with SMTP id p190mr7044490iof.121.1602992568129;
 Sat, 17 Oct 2020 20:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201016184002.GA15797@ubuntu> <CAJCx=g=3YczXwHzw4+pvDwiBdx8mo8qf=ss0_KC1W3uOANr0Vw@mail.gmail.com>
In-Reply-To: <CAJCx=g=3YczXwHzw4+pvDwiBdx8mo8qf=ss0_KC1W3uOANr0Vw@mail.gmail.com>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Sun, 18 Oct 2020 09:12:37 +0530
Message-ID: <CALudOK6y9Svb=Mo1gnVyp1eFdPFqy1B0PknigozrAmTWdpjAAw@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: as3935 change of_property_read to device_property_read
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 3:57 AM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> On Fri, Oct 16, 2020 at 11:41 AM Vaishnav M A <vaishnav@beagleboard.org> wrote:
> >
> >
> > This patch aims to replace the of_property_read_u32 for reading
> > the ams,tuning-capacitor-pf, ams,nflwdth properties with
> > device_property_read_u32.
> >
> > Thanks and Regards,
> > Vaishnav M A
>
> Could you explain a bit more in the commit message why this is needed?
>
> Also you pop comments that shouldn't be in the commit message below
> the "---" line :)
>
Thanks for pointing this out, sorry for the mistake, I have updated the commit
message in the new v2 patch:
 https://lore.kernel.org/patchwork/patch/1322170/
> >
> > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> > ---
> >  drivers/iio/proximity/as3935.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> > index c339e7339ec8..7e47ddf89a56 100644
> > --- a/drivers/iio/proximity/as3935.c
> > +++ b/drivers/iio/proximity/as3935.c
> > @@ -355,7 +355,6 @@ static int as3935_probe(struct spi_device *spi)
> >         struct iio_dev *indio_dev;
> >         struct iio_trigger *trig;
> >         struct as3935_state *st;
> > -       struct device_node *np = spi->dev.of_node;
> >         int ret;
> >
> >         /* Be sure lightning event interrupt is specified */
> > @@ -374,7 +373,7 @@ static int as3935_probe(struct spi_device *spi)
> >         spi_set_drvdata(spi, indio_dev);
> >         mutex_init(&st->lock);
> >
> > -       ret = of_property_read_u32(np,
> > +       ret = device_property_read_u32(&spi->dev,
> >                         "ams,tuning-capacitor-pf", &st->tune_cap);
> >         if (ret) {
> >                 st->tune_cap = 0;
> > @@ -390,7 +389,7 @@ static int as3935_probe(struct spi_device *spi)
> >                 return -EINVAL;
> >         }
> >
> > -       ret = of_property_read_u32(np,
> > +       ret = device_property_read_u32(&spi->dev,
> >                         "ams,nflwdth", &st->nflwdth_reg);
> >         if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
> >                 dev_err(&spi->dev,
> > --
> > 2.25.1
> >
