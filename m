Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7C5F8C55
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJIQck (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJIQck (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 12:32:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9272125E
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 09:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFC46B80D42
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 16:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9780BC433C1;
        Sun,  9 Oct 2022 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665333156;
        bh=VbK5Ybc2PncdoYw16H/phMBXBTcX2Cf7toQwHyHAl2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XYh58ji8kiTYW9yYgVbp9gjYNM2+V+hUdYMTOobmDTSHBwyGnggv4/cY4QXb/Slvd
         sgGB4IFcGcuxLrAk8Tgiqe/wnVsUSQhvChof7LldGz44xrubXQ6FZCM3t0jEbL6GzU
         GQfYDRN0GswwmiYWWNqcSAmfZNLRh7wJqE+9X823jzLanJcQokGX0ytxtYV2sVl9Hd
         c8W2mAlXEhkIRQfl4p3nPN/pGrCRZV8j7tA5hOgxj9f3q4djfwF02+nJrMXZlAetdd
         3US5p80F0kPNWc5bLNSlpIbwhFQEZzTRE/jZ9/7P2giSFRaT3Ww+cJtUb4uBHZTt2w
         3qKqjAmys/bcw==
Date:   Sun, 9 Oct 2022 17:32:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     william.gray@linaro.org, linux-iio@vger.kernel.org,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH resend] iio: dac: add support for max5522
Message-ID: <20221009173259.44df9f45@jic23-huawei>
In-Reply-To: <CALJHbkBPg=+N_6q+cVpFbmwM0mJbUhuH3wwWKma7GzaR1r1owQ@mail.gmail.com>
References: <20221001221225.668378-1-angelo.dureghello@timesys.com>
        <20221002125625.661b118d@jic23-huawei>
        <CALJHbkBPg=+N_6q+cVpFbmwM0mJbUhuH3wwWKma7GzaR1r1owQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 Oct 2022 22:32:59 +0200
Angelo Dureghello <angelo.dureghello@timesys.com> wrote:

> Hi Jonathan,
> 
> thanks a lot for all the feedbacks,
> 
> On Sun, Oct 2, 2022 at 1:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sun,  2 Oct 2022 00:12:25 +0200
> > Angelo Dureghello <angelo.dureghello@timesys.com> wrote:
> >  
> > > Add initial support for dac max5522.  
> >
> > DAC preferred for comments.
> >  
> ok, fixed
Hi Angelo,

To cut down a little on reading time, it's helpful to crop out anything
where you agree.  That way we can focus in on remaining questions with
less scrolling!

...

> > > +config MAX5522
> > > +     tristate "Maxim MAX5522 DAC driver"
> > > +     depends on SPI  
> > Hmm. We only have one instance of the pattern and that's more complex because
> > it's a driver that supports both SPI and I2C. Simpler to have (unless I'm missing
> > something!)
> >
> >         depends on SPI_MASTER
> >         select REGMAP_SPI
> >  
> Not sure i am understanding this point, device is SPI only.
> Anyway, ok, i changed as you are suggesting.

Ah I was less clear than I could have been.
You have the depends refering to SPI, and the select
based on the more specific SPI_MASTER.

There is some SPI code that will be built with SPI that is not sufficient here,
so we should depend on SPI_MASTER.

The driver only supports SPI, thus we can unconditionally select REGMAP_SPI if
we are building it at all.

I was trying to figure out where you found this pattern on assumption it was
copied from existing code and only similar example supported multiple buses
and hence needed more complex logic that wasn't relevant here.

> 
> >  
> > > +     select REGMAP_SPI if SPI_MASTER
> > > +     help
> > > +       Say Y here if you want to build a driver for the Maxinm MAX5522.  


...
> > > +struct max5522_state {
> > > +     struct regmap *regmap;
> > > +     const struct max5522_chip_info *chip_info;
> > > +     unsigned short dac_cache[2];
> > > +     unsigned int vrefin_mv;  
> >
> > In theory voltages can change and sensible userspace software will only read them
> > in a slow path anyway, so I'd just move the voltage readback into the
> > read_raw() callback and drop this cache of the value.
> >  
> Sorry, not clear. This device does not provide read operations.
> There is only write operation and DIN spi pin.

The regulator supplying the reference voltage is queried for the reference.
That is currently done at probe() then cached.  You could do it later when
calling read_raw() to get the scale - that would avoid need to cache it
within the driver and handle later reference voltage changes.

Reading scale should never be a latency sensitive path, so no need to
cache the value when we can read it directly when we need it.


> > > +
> > > +enum max5522_type {
> > > +     ID_MAX5522,
> > > +};
> > > +
> > > +static const struct max5522_chip_info max5522_chip_info_tbl[] = {  
> >
> > Unless you are going to follow this patch very soon with support for more devices,
> > I'd prefer seeing this indirection only when it becomes necessary.
> > For now, it just leads to less readable and longer code.
> >  
> idea is to follow up with MAX5523/5524/5525,
> not sure when right now, since i cannot test them, but code was ready
> for addition

Great if you do or if anyone else can test those parts and hence
help you get these upstream. (Nuno:  Not sure how combine things are between
different parts of ADI family, but are these parts you have access to?)

If they are very similar then I'd be fine taking support tested against some
unit tests or emulation.  For some of these families we only ever manage
to test a subset when developing.

Add a note to the patch description to say that these are on their way
as reasoning behind the flexibility.

> 
> > > +     [ID_MAX5522] = {
> > > +             .channels = max5522_channels,
> > > +             .num_channels = 2,
> > > +     },
> > > +};

> > > +     indio_dev->info = &max5522_info;
> > > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > > +     indio_dev->channels = max5522_channels;
> > > +     indio_dev->num_channels = ARRAY_SIZE(max5522_channels);
> > > +     indio_dev->name = id->name;  
> >
> > Hard code the name preferred as it makes it easier to be sure it's exactly what
> > we expect when reading the code and does rely on the fallback compatible matching
> > in the spi core for dt described devices.
> >  
> Ok, if possible i would keep the id table for next additions.

Keep the id table. Just don't get the name from it. In fact we have to keep the
ID table because it's used for module alias generation needed to autoload
modules.


Instead get the name from the chip_info_tbl[] so that you definitely get what
you expect independent of the probe mechanism.

Jonathan



