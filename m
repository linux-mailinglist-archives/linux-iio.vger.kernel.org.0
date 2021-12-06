Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD146A56F
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 20:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347367AbhLFTRB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 14:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348323AbhLFTRB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 14:17:01 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626BC061746
        for <linux-iio@vger.kernel.org>; Mon,  6 Dec 2021 11:13:32 -0800 (PST)
Received: from [81.101.6.87] (port=48014 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1muJQT-0002fT-Ll; Mon, 06 Dec 2021 19:13:30 +0000
Date:   Mon, 6 Dec 2021 19:18:29 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 3/5] iio: accel: mma9551: Add support to get irqs
 directly from fwnode
Message-ID: <20211206191804.443def0b@jic23-huawei>
In-Reply-To: <CAHp75VfGLaTnV67uNf2_n7203_viC6wmayMNk2+gCHAQ2=tnBw@mail.gmail.com>
References: <20211205200250.2840902-1-jic23@kernel.org>
        <20211205200250.2840902-4-jic23@kernel.org>
        <CAHp75VfGLaTnV67uNf2_n7203_viC6wmayMNk2+gCHAQ2=tnBw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Dec 2021 22:39:07 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Dec 5, 2021 at 9:57 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Note the interrupt type should be specified by firmware, not the driver
> > so that is also dropped.
> >
> > Drop previous gpio based retrieval method. Whilst in theory this
> > might cause problems with direction if anyone is using ACPI GioIo().  
> 
> GpioIo()

My proofreading fails me again...

> 
> > As Andy described in v1, such a situation would typically reflect
> > a pin that is actually used in both directions (not true here)
> > or missdesigned ACPI tables.  
> 
> ...
> 
> > -               gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
> > -               if (IS_ERR(gpio)) {
> > -                       dev_err(dev, "acpi gpio get index failed\n");
> > -                       return PTR_ERR(gpio);
> > -               }
> > -
> > -               ret = gpiod_to_irq(gpio);
> > -               if (ret < 0)  
> 
> > +               ret = fwnode_irq_get(dev_fwnode(dev), i);
> > +               if (ret)
> >                         return ret;  
> 
> I don't remember why we decided that this gonna work, because
> fwnode_irq_get() is not an equivalent to the above, more precisely in
> ACPI case it only covers the GSIs (Global System Interrupts) which in
> such case may or may not be GPIOs. On x86 it's usually direct IOxAPIC
> ones.

This isn't accessed as a GPIO, but I kind of assume someone was using
it with one given this code.

I think I misread what you'd written in reply to v1.
Thanks for the explanation.

> 
> So, this conversion would probably make it impossible to use this
> device in the ACPI case.

oops :)


> 
> See also this discussion:
> https://lore.kernel.org/lkml/20211109200840.135019-1-puranjay12@gmail.com/T/#u
> 

I'd not made the connection that the non named one was also missing most
of the ways it could be specified.  Ah well, this will take a little while
to get a test framework in place to poke at it properly.  Maybe one for
a bored moment over the festive season.

Jonathan

