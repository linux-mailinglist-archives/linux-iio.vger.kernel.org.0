Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E152D8DFB
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 15:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbgLMOcc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 09:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730956AbgLMOcZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 09:32:25 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B304922D2B;
        Sun, 13 Dec 2020 14:31:43 +0000 (UTC)
Date:   Sun, 13 Dec 2020 14:31:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
Message-ID: <20201213143140.58af94a0@archlinux>
In-Reply-To: <CA+U=DspEg=XpOUKqtammKqOoLXoXEDKWQHqSauM1xna_Y+eqjA@mail.gmail.com>
References: <20201203095342.73591-1-alexandru.ardelean@analog.com>
        <CAHp75VffjpFyh0G3F6v0j5tXrURA2pCtWsSztC7KejhBFuLTvw@mail.gmail.com>
        <CA+U=DsoNHebsuGDhGnJOwFbkYtGY+1Gs_mhCssH+FYk3Y05eZA@mail.gmail.com>
        <CAHp75VcxZd1xW+ayi_km3zCYKV3aC1VRJ5bwyVpevZkvgg_ipw@mail.gmail.com>
        <CA+U=DspEg=XpOUKqtammKqOoLXoXEDKWQHqSauM1xna_Y+eqjA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Dec 2020 17:55:22 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Wed, Dec 9, 2020 at 5:53 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, Dec 9, 2020 at 5:45 PM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:  
> > > On Wed, Dec 9, 2020 at 5:37 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:  
> > > > On Thu, Dec 3, 2020 at 11:55 AM Alexandru Ardelean
> > > > <alexandru.ardelean@analog.com> wrote:  
> >
> > ...
> >  
> > > > Are you sure there is no user space application that doesn't rely on
> > > > character device to be always present?  
> > >
> > > Nope.
> > > I'm not sure.
> > > I'm also not completely sure how Jonathan feels about this patch being
> > > added now [so late].
> > >
> > > Though, technically if the chardev was already there, without all the
> > > control in place [to enable IIO buffers and other stuff through the
> > > chardev] then it's technically just a "marker" file.
> > > Which arguably is a lot to have (i.e. chardev that should be unusable).
> > >
> > > If it is usable with no control in place for buffers or other stuff
> > > (i.e. I missed something), then I also don't know.
> > >
> > > So, this patch on it's own can still be interpreted as an RFC.
> > > See:
> > > https://lore.kernel.org/linux-iio/20201121180246.772ad299@archlinux/  
> >
> > Don't take me wrong, I'm not against a good change (I doesn't like
> > dangling files), but it might break some use cases.  
> 
> Yeah I know.
> But how else do you know if a dangling file might break some use cases?
> 
> The worst that would happen is that we get a report and create a Fixes
> tag and we know.
> But if we don't try it, we're stuck with it, and will never know.
> 
It's definitely a high risk change.  I'd 'hope' it's not a problem
but we should do a bit more due diligence. 

I hope we can assume the ADI software is all fine with dropping this.
Bastien can you see any issues with dropping chrdev for IIO devices
that don't actually support using it for anything (sysfs interface only).

What other stacks are people aware of that we should enquire about?

Thanks,

Jonathan
> >
> > --
> > With Best Regards,
> > Andy Shevchenko  

