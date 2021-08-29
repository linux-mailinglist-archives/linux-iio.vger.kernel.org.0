Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825F43FAC42
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 16:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhH2OdU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 10:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235459AbhH2OdT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 10:33:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5866023D;
        Sun, 29 Aug 2021 14:32:24 +0000 (UTC)
Date:   Sun, 29 Aug 2021 15:35:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Nuno =?UTF-8?B?U8Oh?= <Nuno.Sa@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/5] iio: adc: ad7949: add vref selection support
Message-ID: <20210829153539.3b2cf037@jic23-huawei>
In-Reply-To: <CAHp75VcUhgpxUE4h3YgYaGAsvHstBzSo9QDwe+D4t264uj_21A@mail.gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
        <20210815213309.2847711-4-liambeguin@gmail.com>
        <CAHp75Vd-AfmwMyYyy5ygwmvGfwZLh9VwvBEzSwW3fc99jxFpnQ@mail.gmail.com>
        <CDKXZBW1JDOD.1ZXIT12Y3WK5B@shaak>
        <CAHp75VdC8GFmV-uOHPQpv5q=q0ZwSKFXW6gOL-hK6N4_qS1YJw@mail.gmail.com>
        <CDKYL1RFEMBA.2VURZKBX9F3S@shaak>
        <CAHp75VcUhgpxUE4h3YgYaGAsvHstBzSo9QDwe+D4t264uj_21A@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Aug 2021 16:12:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 16, 2021 at 4:07 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > On Mon Aug 16, 2021 at 8:48 AM EDT, Andy Shevchenko wrote:  
> > > On Mon, Aug 16, 2021 at 3:39 PM Liam Beguin <liambeguin@gmail.com>
> > > wrote:  
> > > > On Mon Aug 16, 2021 at 4:04 AM EDT, Andy Shevchenko wrote:  
> > > > > On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com>
> > > > > wrote:  
> 
> ...
> 
> > > > > > +       tmp = 4096000;
> > > > > > +       ret = device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);  
> > > > >  
> > > > > > +       if (ret < 0 && ret != -EINVAL) {  
> > > >
> > > > Hi Andy,
> > > >  
> > > > >
> > > > > What does this check (second part) is supposed to mean?
> > > > > The first part will make it mandatory, is it the goal?
> > > > >  
> > > >
> > > > device_property_read_u32() will return -EINVAL if the property isn't
> > > > found in the devicetree.
> > > >
> > > > This checks for errors when the property is defined while keeping it
> > > > optional.  
> > >
> > > Don't assign and don't check the error code of the API. As simply as
> > > that.  
> >
> > I'm not against getting rid of it, but I was asked to check for these
> > errors in earlier revisions of the patch.  
> 
> Okay, I leave it to you, guys, to decide, just note that the usual
> pattern for optional stuff
> a) either check for (!ret);
> b) or ignore the returned value completely.

Hmm. My thinking (I suspect I asked for it to be checked, but can't remember :)
was that I'd really like to know if a device tree contains a property but that
property is invalid for some reason. The docs give a bunch of reasons beyond
the property not existing (which is unhelpfully described as just 'invalid parameters'). 

I guess that's a bit far fetched.  Let's drop the check as Andy suggests.

Dropped that check and applied to the togreg branch of iio.git, initially pushed out
as testing for 0-day to poke at it.  + we are about to enter merge window so I don't
want linux-next to pick it up just yet!

Jonathan

> 
> > > > > > +               dev_err(dev, "invalid value for adi,internal-ref-microvolt\n");
> > > > > > +               return ret;
> > > > > > +       }  
> 
> 

