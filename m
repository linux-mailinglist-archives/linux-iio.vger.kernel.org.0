Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCCE3D488E
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhGXPgv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 11:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGXPgv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 11:36:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8B860E53;
        Sat, 24 Jul 2021 16:17:19 +0000 (UTC)
Date:   Sat, 24 Jul 2021 17:19:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 3/4] iio: accel: bmc150: Make it possible to configure
 INT2 instead of INT1
Message-ID: <20210724171951.18b349b1@jic23-huawei>
In-Reply-To: <CAHp75Vf56+HpeGcdet61eeQyQfwFKx8x7vEc_G9NXStYy5Gsyw@mail.gmail.com>
References: <20210719112156.27087-1-stephan@gerhold.net>
        <20210719112156.27087-4-stephan@gerhold.net>
        <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
        <CAHp75VcsVFO2Oizpyeh53MNt2v9yD81vXp1xKCVX-U4zb-KTdg@mail.gmail.com>
        <YPWV537oN3gDpAQS@gerhold.net>
        <CAHp75Vdjotgi9RrmKQC4J_QQSYdRWwp+-8aHGkChx6VFLPDh-Q@mail.gmail.com>
        <YPW1xGtLyLNGKqjJ@gerhold.net>
        <CAHp75VcZDSL5u2bP_ZFySmk7cPkHRycyA-+gMqSVWCpgFXhn7Q@mail.gmail.com>
        <YPXGQxPPID1SHOUO@gerhold.net>
        <CAHp75Vf56+HpeGcdet61eeQyQfwFKx8x7vEc_G9NXStYy5Gsyw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Jul 2021 18:04:22 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jul 19, 2021 at 9:37 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Mon, Jul 19, 2021 at 09:05:48PM +0300, Andy Shevchenko wrote:  
> > > On Mon, Jul 19, 2021 at 8:29 PM Stephan Gerhold <stephan@gerhold.net> wrote:  
> > > > On Mon, Jul 19, 2021 at 07:19:05PM +0300, Andy Shevchenko wrote:  
> > > > > On Mon, Jul 19, 2021 at 6:11 PM Stephan Gerhold <stephan@gerhold.net> wrote:  
> > > > > > On Mon, Jul 19, 2021 at 06:01:01PM +0300, Andy Shevchenko wrote:  
> > > > > > > On Mon, Jul 19, 2021 at 5:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:  
> > > > > > > > On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:  
> 
> ...
> 
> > > > > > > > > +       irq_info = bmc150_accel_interrupts_int1;
> > > > > > > > > +       if (irq == of_irq_get_byname(dev->of_node, "INT2"))
> > > > > > > > > +               irq_info = bmc150_accel_interrupts_int2;  
> > > > > > > >
> > > > > > > > This looks a bit DT-specific, but I don't see that ACPI has
> > > > > > > > named IRQs so I don't know what to do about it either.  
> > > > > > >
> > > > > > > Yeah, we only have so far the (de facto) established way of naming
> > > > > > > GPIO based IRQs, and not IOxAPIC ones.
> > > > > > >  
> > > > > > > > What does platform_get_irq_byname() do on ACPI systems?  
> > > > > > >
> > > > > > > See above.
> > > > > > >  
> > > > > > > > If there is no obvious fix I would leave it like this until the
> > > > > > > > first ACPI used needing this comes along, but I think maybe
> > > > > > > > Andy has suggestions.  
> > > > > > >
> > > > > > > The platform_get_irq_byname() should do something similar that has
> > > > > > > been done in platform_get_irq() WRT ACPI.
> > > > > > > Here for sure the platform_get_irq_byname() or its optional variant
> > > > > > > should be used.  
> > > > > >
> > > > > > I don't think there is a platform device here, we only have the
> > > > > > i2c_client or spi_device. That's why I didn't use
> > > > > > platform_get_irq_byname(). :)
> > > > > >
> > > > > > Is there something equivalent for I2C/SPI drivers?  
> > > > >
> > > > > Not yet. You probably need to supply some code there to allow
> > > > > multi-IRQ devices (in resource provider agnostic way).
> > > > >
> > > > > You need to provide fwnode_get_irq_byname() to be similar with
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/base/property.c#L1010
> > > > >
> > > > > Then use it in the drivers.
> > > > >
> > > > > And/or integrate into frameworks somehow (something in between the
> > > > > lines: https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L461).
> > > > >  
> > > >
> > > > Well, I don't think anyone has an ACPI use case for this right now so
> > > > it's probably better if this is done by someone who actually needs this
> > > > and can test it somewhere. :)
> > > >
> > > > I actually just "copied" this approach from some other IIO drivers where
> > > > this is done similarly (and additionally checked the source code to make
> > > > sure this won't break anything for ACPI platforms).  
> > >
> > > I see in today's Linux Next snapshot:
> > >
> > > drivers/iio/accel/fxls8962af-core.c:774:        irq =
> > > of_irq_get_byname(of_node, "INT2");
> > > drivers/iio/accel/mma8452.c:1616:               irq2 =
> > > of_irq_get_byname(client->dev.of_node, "INT2");
> > > drivers/iio/gyro/fxas21002c_core.c:834: irq1 = of_irq_get_byname(np, "INT1");
> > > drivers/iio/imu/adis16480.c:1265:               irq =
> > > of_irq_get_byname(of_node, adis16480_int_pin_names[i]);
> > > drivers/iio/imu/bmi160/bmi160_core.c:655:       irq =
> > > of_irq_get_byname(of_node, "INT1");
> > > drivers/iio/imu/bmi160/bmi160_core.c:661:       irq =
> > > of_irq_get_byname(of_node, "INT2");
> > >
> > > I believe we may stop distributing this and actually start using a
> > > common API. I don't want this to be spread again over all IIO. Btw, I
> > > have LSM9DS0, which supports two INT pins for IMU and currently it
> > > uses hard coded pin mapping.
> > >  
> >
> > Hm, I'm not quite sure how to implement this. Could you prepare a patch
> > that would implement such a common API? I would be happy to test it for
> > the device tree and make use of it in this patch.  
> 
> Unfortunately I have no time to fulfil the required process. The idea
> in general is like this:
> 
> if (is_of_node(...))
>   return of_irq_get_byname(...);
> if (is_acpi_node(...))
>   return acpi_gpio_irq_get_byname(...);
> 
> Everything else is quite similar to fwnode_irq_get().
> 
> > To be honest, I mainly implemented support for the interrupt-names
> > because Jonathan mentioned this would be nice to have [1] and it kind of
> > fit well together with the BMC156 patch that needs the INT2 support.
> > I actually just use the if (data->type == BOSCH_BMC156) part from
> > PATCH 4/4 which does not depend on of_irq_get_byname().  
> 
> Then I leave it to Jonathan and other maintainers.

I'd be rather nervous about this one myself unless I have a test setup where
I can poke all the paths.

My current qemu hack setup doesn't do full enough ACPI so whilst I'd take a
look at this myself it might take me a little while to hack in the ACPI tables needed
to bring up a suitable bus on that device.

I'll get to it if no one else does, but I'm not keen to block any
drivers that just use the of route in the meantime. Should be easier to do
a sweep of the ones Andy has highlighted + this one when we have the support
ready.

The patch looks fine to me otherwise.

Thanks,

Jonathan

> 
> > [1]: https://lore.kernel.org/linux-iio/20210611185941.3487efc6@jic23-huawei/  
> 

