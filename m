Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324592C78CF
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 12:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgK2L0t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 06:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2L0s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 06:26:48 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3E620771;
        Sun, 29 Nov 2020 11:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606649167;
        bh=wQ4xuVWe1Q1vzd6BmGwvZghUC2t1M+6PQepfBviAL6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E1pkTzc/PdcQ4TDaM5arR/avXs0TcNWMomMFbMa+MZuBCLQy2PtP1zJazBqfMfqct
         4Mi3uT3Vi05V+hGElp/eEMvN7HhuN+htxv7EGhBS/50dB5wDVVII6loi+fsdkESxqL
         Y+S8u1x0lM9PnJaN3y04+5S9p2nwIKsReo4oADo4=
Date:   Sun, 29 Nov 2020 11:26:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: Add driver for Yamaha YAS5xx
Message-ID: <20201129112603.1644e5a5@archlinux>
In-Reply-To: <CACRpkdYvkV0Xrw9fseQneHwhJ-EkcX+RQKVcCF8hhidE479AmQ@mail.gmail.com>
References: <20201128004038.883289-1-linus.walleij@linaro.org>
        <20201128004038.883289-2-linus.walleij@linaro.org>
        <20201128122153.44c1052c@archlinux>
        <CACRpkdYvkV0Xrw9fseQneHwhJ-EkcX+RQKVcCF8hhidE479AmQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 22:04:56 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> Hi Jonathan!
> 
> I fixed most things, some elaboration inline:
> 
> On Sat, Nov 28, 2020 at 1:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > The 'interesting' nature of the packing in those calibration registers
> > is unfortunate.  I'm not really sure how we make that code more readable
> > but using overlapping unaligned big endian reads definitely doesn't make
> > it easier for me to follow!  
> 
> Yeah I am experimenting to find a good way. Maybe I will try to extract
> u64 and chop out the bits from there to make it clearer.
> 
> I think a lot of clock drivers have this problem already.
> 
> > > +       This driver can also be compiled as a module.
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called yamaha-yas.
> > > +  
> 
> > One line only  
> 
> Please clarify what you want the end result to look like, I don't
> quite get it... Looking a the latest committed drivers in linux-next
> didn't give a clue either.

Sorry - totally trivial one I should have expressed better.
Seems to be 2 blank lines after this block when one will do fine from
a readability point of view.

> 
> > > + * YAS530 MS-3E (2011 Samsung Galaxy S Advance)
> > > + * YAS532 MS-3R (2011 Samsung Galaxy S4)
> > > + * YAS533 MS-3F (Vivo 1633, 1707, V3, Y21L)
> > > + * (YAS534 is a magnetic switch, not handled)  
> >
> > And there is your reason not to use wild cards in the dt file name etc!  
> 
> It's pretty safe as we definately account for all magnetometers
> of the naming scheme YAS53x. The YAS534 would be in another
> subsystem (proximity, I guess) so the path to the file gives the
> right info: this covers all magnetometers named yas53x, goes
> for both the bindings and the driver I think?

I'd just name it after a specific part.

> 
> > > +static void yas53x_extract_calibration(u8 *data, struct yas5xx_calibration *c)
> > > +{  
> >
> > As below.  I'm not sure how you make this clearer, but right now it's
> > really hard to follow.  Perhaps detailed comment on what the data packing
> > in here is?  
> 
> OK I try to detail a bit.
> 
> > > +     c->a2 = yas5xx_extract_bits(&data[3], 10, 15) - 32;
> > > +     c->a3 = yas5xx_extract_bits(&data[3], 6, 9) - 8;
> > > +     c->a4 = yas5xx_extract_bits(&data[4], 8, 13) - 32;
> > > +     c->a5 = yas5xx_extract_bits(&data[5], 10, 15) + 38;
> > > +     c->a6 = yas5xx_extract_bits(&data[5], 4, 9) - 32;
> > > +     c->a7 = yas5xx_extract_bits(&data[6], 5, 11) - 64;
> > > +     c->a8 = yas5xx_extract_bits(&data[7], 7, 12) - 32;
> > > +     c->a9 = yas5xx_extract_bits(&data[8], 7, 14);
> > > +     c->k = yas5xx_extract_bits(&data[9], 10, 14) + 10;  
> 
> Since this segment easily fits in a u64 I thought about
> extracing a u64 and then use FIELD_GET on that.

Could do, but to a degree what makes sense here is dependent on what
aligns well with the datasheet as that's what people will check against.
Is there a public datasheet with this in?


> 
> > As below, I wonder if you'd be better just constructing these directly from
> > the 8 bit register pairs. The overlapping unaligned 16 bit reads are
> > rather confusing.  
> 
> I already tried that but it looks even worse :/
> 
> I will try to put them into a bigger word instead.
> 
> > > +     /* Extract linearization */  
> >
> > Could you add a comment on the data layout here. It seems rather
> > non obvious given the overlapping 16 bit reads you are doing.
> > Whilst the maths might correspond to extracting bits from be16 registers
> > that looks more like coincidence than design and only makes any
> > useful difference to the bit 7,8 pair.  The bit 9-14 could just have
> > been gotten from the next 8 bit register directly.  
> 
> It sadly doesn't look any better if I operate on u8 chars. :/
> I'll try to think of something.
> 
> > > +             snprintf(yas5xx->name, sizeof(yas5xx->name),
> > > +                      "YAS530 MS-3E %s",  
> >
> > Name tends to be lowercase. Also, not sure we've had one with spaces
> > in it before.  I guess our userspace code is fine with it though
> > as presumably you've tested that.  
> 
> Yeah oddly it turns it into just "YAS530":
> 
> skomer:/home/linus# lsiio
> Device 003: bma222
> Device 001: current-sense-amplifier
> Device 004: gp2ap002
> Device 002: mpu3050
> Device 000: ab8500-gpadc
> Device 005: YAS530
> Trigger 000: mpu3050-dev2
> 
> But it doesn't look nice, I will rename it lowercase.

Cool.

> 
> Yours,
> Linus Walleij

