Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA4339AA2C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFCSkH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhFCSkG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:40:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25DF613EE;
        Thu,  3 Jun 2021 18:38:19 +0000 (UTC)
Date:   Thu, 3 Jun 2021 19:40:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 3/5] iio: accel: mma9551: Add support to get irqs
 directly from fwnode
Message-ID: <20210603194002.768f558e@jic23-huawei>
In-Reply-To: <20210524102736.00007567@Huawei.com>
References: <20210523162315.1965869-1-jic23@kernel.org>
        <20210523162315.1965869-4-jic23@kernel.org>
        <CAHp75VcPvyOkmv18D4DBxeMdJwcKH8sYjoYPLPrCfsymFGCjfw@mail.gmail.com>
        <20210524102736.00007567@Huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 May 2021 10:27:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 May 2021 09:13:30 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Sun, May 23, 2021 at 7:24 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > The driver previous supported using GPIO requests to retrieve    
> > 
> > previously
> >   
> > > multiple interrupt lines.  As existing firmware may be using
> > > this method, we need to continue to support it.  However, that doesn't
> > > stop us also supporting just getting irqs directly.
> > >
> > > The handling of irqflags has to take into account the fact that using
> > > a GPIO method to identify the interrupt does not convey direction of
> > > the trigger that fwnode_irq_get() will. So we need to set the
> > > IRQF_TRIGGER_RISING in that path but not otherwise, where it will
> > > cause an issue if we reprobe the driver after removal.    
> > 
> > ...
> >   
> > > +               /* fwnode_irq_get() returns 0 for not present on OF, and -EINVAL for ACPI */
> > > +               if (ret == 0 || ret == -EINVAL) {
> > > +                       gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
> > > +                       if (IS_ERR(gpio)) {    
> >   
> > > +                               dev_err(dev, "gpio get index failed\n");
> > > +                               return PTR_ERR(gpio);    
> > 
> > This should be dev_err_probe().
> > (I guess you need to prepend this patch with one that switches to
> > dev_err_probe() API)
> >   
> > > +                       }
> > > +
> > > +                       ret = gpiod_to_irq(gpio);
> > > +                       if (ret < 0)
> > > +                               return ret;    
> >   
> > > +                       /* GPIO interrupt does npt have a specified direction */  
> 
> Gah. What is it with me and spelling in comments...
> 
> > > +                       irqflags |= IRQF_TRIGGER_RISING;    
> > 
> > I'm not sure I understand this part. If we are talking about the ACPI
> > GpioInt() resource, then it should have this flag. If GpioIo() is in
> > use (which is already a sign of either using the line in dual
> > direction mode, but this needs to be described in the data sheet and
> > thus used in the driver, or misdesigned ACPI tables). DT, I suppose,
> > should have all necessary information.  
> 
> Honestly I have no idea.  I didn't want to change the exiting flags without
> any visibility of what the ACPI tables look like (assuming they exist).
> Given I'm proposing killing of the ID, chances are ACPI is broken anyway
> now :)  So, more risky is DT out there that just specifies this as a
> GPIO.
> 
> Plan B would be to just drop the GPIO support entirely.
> 
> Would GpioInt() get picked up by the the fwnode_irq_get() path?
> 
> I'm guessing these were on a dev board 6+ years ago, but whilst I can
> find references to the mma9553 on some freescale platforms, not finding
> much on the mma9551.
> 
> Looking a bit deeper they are both listed as obsolete parts now (according to
> digikey as I can't find status on nxp.com)
> ...  So plan C is just remove the drivers on the basis they are significantly
> odd and we don't know of a platform anyone cares about with them on.
> 
> Mind you, aside from having a lack of documented bindings (which was what was
> annoying me, they aren't doing any harm or causing any real maintenance burden.)
> More than possible someone out there is using them.  The mm9953 appears on the
> warpboard.org reference platform, but seems the sensor was never enabled upstream.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/arch/arm/boot/dts/imx6sl-warp.dts
> https://revotics.com/warp?v=a284e24d5f46
> 
> Also, only some passing references in there, so I'd guess it got dropped in
> later revisions?  Shaun, any ideas?

I'm going to gamble a bit here and just drop the gpio support entirely.
We don't have any known boards out there running this driver so I 'might'
break someones hobby board, but hopefully they'll fix up their DT.

Without a confirmed user I'm not keen to maintain the complexity.

Jonathan

> 
> Jonathan
> 
> 
> >   
> > > +               }    
> > 
> > 
> >   
> 

