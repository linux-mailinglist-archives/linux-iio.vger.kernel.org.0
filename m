Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0D291812
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 17:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgJRPgC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJRPgC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 11:36:02 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E0C061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 08:36:00 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y20so10073411iod.5
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0nW91KAKtHqqih47wMzMhuIwlI+DPugrQO5DPU/EGE=;
        b=I+1HrpYqiUXYxR5WJIusD1mNhg/B2ZFyy48DPEO4imoGXFsFGBIUQHogwH+gUkHzNN
         a9wDlzOrJ6cympE25UEdCve+0FG6cpshm6+oxvhdWvF1dBRh0eKjDbEta8UKb3Q2rs1Y
         EaYzHVFFH6u5tJJVHaFsWhccSvxItBn9j90xedecoEBLecUyav/NilhUaOvf3E8wEQdj
         3TkaQtyFa8XEY3SnP2X3lDrPVxCyn1Yqu3tK2oRq3BvZBy9kmvXmWqFUVIxFwzzGIOCm
         8ZPS8hZl2kYwAvC9f/yhZgo9fL/RNrV46dSZKgrKvR0GDKSZD3wdhep/ClN5MEXchUuI
         Z0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0nW91KAKtHqqih47wMzMhuIwlI+DPugrQO5DPU/EGE=;
        b=QfKePE8eQw4Weld32mlXeqdAYu571SXVF0o9vwWx7wH+fZOWlHKedWTpOyHa7dv9yk
         4SowZYXHO/ZoHJmtqe+yareMpWNyxOLEosG3wBEmU31dAwPl/XsURYNi0+SRGuvU/Nip
         /XDBcOQF7/YgT89FTtLsDZtva/bKmNR3DfFwknR1+3CxvFP1FskLr5l3cNAMecEx2fDd
         4MpyfDGznD6K08/ML19LJEQacHjNDsEnyXuwrA9YMEJ97rmd8cfRrJhLKcUIkFn/SX3f
         qsbEPWF09aANUIjVJRlnO/NGpILJfsvAbHh6xcxRDN0LrNyblLC9E0eXDr7ccyNAQFTB
         U4hA==
X-Gm-Message-State: AOAM532TU3NN0VFCC5eKc+T72q9WM9jgQ5m4X7M1NNNhC1FRyV3o1vAI
        JCb6mBliH+cj4Ezxm1n8Dn3nwmVIQJsGJJ0yHzDU
X-Google-Smtp-Source: ABdhPJyjJAqraG8PMHzOE7BQ8rKSJvFKw0VuEtg5QIB3vpi6Onl98uCxAQC2fjGRx6haTSmaBs5jocGjcB/+BIWZIic=
X-Received: by 2002:a02:6cd0:: with SMTP id w199mr8617688jab.121.1603035360160;
 Sun, 18 Oct 2020 08:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201018031732.GA27204@ubuntu> <20201018121712.0393cab9@archlinux>
In-Reply-To: <20201018121712.0393cab9@archlinux>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Sun, 18 Oct 2020 21:05:49 +0530
Message-ID: <CALudOK7dPNsGJXaCjFQ=gujs8Mt+sN9ZXUQ=9BF80K8cw4E_SA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: as3935 change of_property_read to device_property_read
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
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

On Sun, Oct 18, 2020 at 4:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 18 Oct 2020 08:47:32 +0530
> Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> A very similar change was made recently in
> 00fa493b9989 ("iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=00fa493b99894b930e431c05a9dba294c5189120
>
Sorry for missing that, happy to see this change.

Thanks,
Vaishnav M A
> Review follows for reference as I wrote it before remembering the above!
>
> > replace the of_property_read_u32 for reading
> > the ams,tuning-capacitor-pf, ams,nflwdth properties with
> > device_property_read_u32, allows the driver to get the properties
> > information using the more generic device_property_* helpers and opens
> > the possibility of passing the properties during platform instantiation
> > of the device by a suitably populated struct property_entry
>
> Please format this to aid readability.
>
> Replace of_property_read_u32() with device_property_read_u32,
> when reading the ams,tuning-capacitor-pf and ams,nflwdth properties.
> This opens up the possibility of passing the properties during platform
> instantiation of the device by a suitable populated struct property_entry.
>
>
> As in your other patch, please add the header property.h.
>
> >
> > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> > ---
> >  v2:
> >       - fix commit message
> >  drivers/iio/proximity/as3935.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> > index c339e7339ec8..7e47ddf89a56 100644
> > --- a/drivers/iio/proximity/as3935.c
> > +++ b/drivers/iio/proximity/as3935.c
> > @@ -355,7 +355,6 @@ static int as3935_probe(struct spi_device *spi)
> >       struct iio_dev *indio_dev;
> >       struct iio_trigger *trig;
> >       struct as3935_state *st;
> > -     struct device_node *np = spi->dev.of_node;
> >       int ret;
> >
> >       /* Be sure lightning event interrupt is specified */
> > @@ -374,7 +373,7 @@ static int as3935_probe(struct spi_device *spi)
> >       spi_set_drvdata(spi, indio_dev);
> >       mutex_init(&st->lock);
> >
> > -     ret = of_property_read_u32(np,
> > +     ret = device_property_read_u32(&spi->dev,
> >                       "ams,tuning-capacitor-pf", &st->tune_cap);
> >       if (ret) {
> >               st->tune_cap = 0;
> > @@ -390,7 +389,7 @@ static int as3935_probe(struct spi_device *spi)
> >               return -EINVAL;
> >       }
> >
> > -     ret = of_property_read_u32(np,
> > +     ret = device_property_read_u32(&spi->dev,
> >                       "ams,nflwdth", &st->nflwdth_reg);
> >       if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
> >               dev_err(&spi->dev,
>
