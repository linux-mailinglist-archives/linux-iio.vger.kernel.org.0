Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8156414173D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgARL3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 06:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgARL3L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 06:29:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B0F24690;
        Sat, 18 Jan 2020 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579346950;
        bh=D8x+g+unQ8xBuwJgPT/oCsHR7+dsGc9bZHovonk0mNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jxc4Izx3rLBVGIqHKSFZ/VaLeRokaFHkHuFG+PFLz/cfYs0Jk3jSnvMjYq2HgFCl2
         4eFvcvqlfcrCavpKfr6mecy55lyYOH6WD+KIPq+VcG4YLCZ5wMujGOIzszeZTTFDM8
         WLhaabbzboOtLcluufTtvS7Ah11zkYr3TZaNdvdM=
Date:   Sat, 18 Jan 2020 11:29:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc:     "Bia, Beniamin" <Beniamin.Bia@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "biabeniamin@outlook.com" <biabeniamin@outlook.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: frequency: adf4371: Fix divide by zero exception
 bug
Message-ID: <20200118112906.0ad6dd6b@archlinux>
In-Reply-To: <BN6PR03MB25966D74469371C11AFC4E4C8E340@BN6PR03MB2596.namprd03.prod.outlook.com>
References: <20200107131559.17772-1-beniamin.bia@analog.com>
        <20200111110848.7c45a4f3@archlinux>
        <BN6PR03MB25966D74469371C11AFC4E4C8E340@BN6PR03MB2596.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jan 2020 16:19:28 +0000
"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Samstag, 11. Januar 2020 12:09
> > To: Bia, Beniamin <Beniamin.Bia@analog.com>
> > Cc: lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > pmeerw@pmeerw.net; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; biabeniamin@outlook.com; knaack.h@gmx.de
> > Subject: Re: [PATCH] iio: frequency: adf4371: Fix divide by zero exception bug
> > 
> > On Tue, 7 Jan 2020 15:15:59 +0200
> > Beniamin Bia <beniamin.bia@analog.com> wrote:
> >   
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > >
> > > During initialization adf4371_pll_fract_n_get_rate() is called on all
> > > output channels to determine if the device was setup. In this case
> > > mod2 is zero which can cause a divide by zero exception.
> > > Return before that can happen.  
> > I'm confused by this description vs the code.
> > 
> > As far as I can see fract_n_get_rate is only called on a sysfs read of the
> > frequency.  
> 
> That's not the case. The failure mechanism comes via adf4371_channel_config().
> It calls adf4371_pll_fract_n_get_rate() prior adf4371_set_freq() which initializes 
> st->mod2 via adf4371_pll_fract_n_compute(). This only happens the first time 
> during probe and setup. So the solution was to return 0 if st->mod2 == 0.

Not in mainline it doesn't.   I took a look at the ADI git hub and I see it does
there.  I think we are missing a precursor patch.

Probably this one from blame...

https://github.com/analogdevicesinc/linux/commit/c8e6b341abf749f78e00326cb92b365d90d9de1f

Jonathan

> 
> -Michael
> 
> > 
> > mod2 is set when fract_n_compute is called in the relevant set_freq calls.
> > This seems to occur on a sysfs set frequency call.
> > 
> > So the issue here is that a sysfs read before a write of the frequency will cause a
> > div zero?  If so, is there a sane set of initial values we can put in mod2 and
> > friends before exposing them via the device register?
> > 
> > If mod2==0 is a valid value and indicates for example that the channel is turned
> > off, then the description should make that clear.
> > 
> > Jonathan
> >   
> > >
> > > Fixes: 7f699bd149134 ("iio: frequency: adf4371: Add support for
> > > ADF4371 PLL")
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> > > ---
> > >  drivers/iio/frequency/adf4371.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/iio/frequency/adf4371.c
> > > b/drivers/iio/frequency/adf4371.c index e2a599b912e5..c21462238314
> > > 100644
> > > --- a/drivers/iio/frequency/adf4371.c
> > > +++ b/drivers/iio/frequency/adf4371.c
> > > @@ -191,6 +191,9 @@ static unsigned long long  
> > adf4371_pll_fract_n_get_rate(struct adf4371_state *st,  
> > >  	unsigned long long val, tmp;
> > >  	unsigned int ref_div_sel;
> > >
> > > +	if (st->mod2 == 0)
> > > +		return 0;
> > > +
> > >  	val = (((u64)st->integer * ADF4371_MODULUS1) + st->fract1) * st-
> > >fpfd;
> > >  	tmp = (u64)st->fract2 * st->fpfd;
> > >  	do_div(tmp, st->mod2);  
> 

