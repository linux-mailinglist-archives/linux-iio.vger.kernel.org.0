Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EEA400F35
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhIELGS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhIELGP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:06:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B13260F45;
        Sun,  5 Sep 2021 11:05:10 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:08:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, hdegoede@redhat.com, wens@csie.org
Subject: Re: [PATCH 1/5] iio: inkern: introduce
 devm_iio_map_array_register() short-hand function
Message-ID: <20210905120832.6566219d@jic23-huawei>
In-Reply-To: <CAASAkoa0D7++CW6ua0_-9LWxhtchG_dKDOih6Ho2NH2gGdtvrQ@mail.gmail.com>
References: <20210903072917.45769-1-aardelean@deviqon.com>
        <20210903072917.45769-2-aardelean@deviqon.com>
        <YTIlv9MR2wG9AzSe@smile.fi.intel.com>
        <CAASAkoa0D7++CW6ua0_-9LWxhtchG_dKDOih6Ho2NH2gGdtvrQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Sep 2021 16:56:43 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> On Fri, 3 Sept 2021 at 16:40, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Sep 03, 2021 at 10:29:13AM +0300, Alexandru Ardelean wrote:  
> > > This change introduces a device-managed variant to the
> > > iio_map_array_register() function. It's a simple implementation of calling
> > > iio_map_array_register() and registering a callback to
> > > iio_map_array_unregister() with the devm_add_action_or_reset().
> > >
> > > The function uses an explicit 'dev' parameter to bind the unwinding to. It
> > > could have been implemented to implicitly use the parent of the IIO device,
> > > however it shouldn't be too expensive to callers to just specify to which
> > > device object to bind this unwind call.
> > > It would make the API a bit more flexible.  
> >
> > AFAIU this dev pointer is kinda discussable thing. What scenario do you expect
> > (have in mind) when it shouldn't use parent?  
> 
> So, this brings me back to an older discussion about devm_ when I
> thought about making some devm_ function that implicitly takes uses
> the parent of the IIO device.
> 
> Jonathan mentioned that if we go that route, maybe we should prefix it
> with iiom_ .
> But we weren't sure at the time if that makes sense.
> The idea was to bind the management of the unwinding to either the
> parent of the IIO device, or the IIO device itself (indio_dev->dev).

I'm not keen on playing the same games that say pcim does where it
effectively combines all cleanup into one devres call because that
can end up doing things in an order that isn't strict reversal if
the setup path isn't carefully organised.  It's 'clever' but to my mind
doing something similar in IIO would need to subtle bugs.

So we would simply be using iiom_ as a shortcut to say bind to the parent
device.  Might be worth considering long term but I'm not keen to do
it for a random little used function first!

Series looks good to me, but I'll let it sit a little longer before applying.

Jonathan


> 
> We kind of concluded that it may probably not be a good to hide
> anything and make standard a devm_ function with an explicit 'dev'
> object parameter.
> 
> I found a recent mention here (while searching for iiom_  on linux-iio):
> https://lore.kernel.org/linux-iio/20210313192150.74c0a91b@archlinux/
> 
> 
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >  

