Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EAF3CFD01
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhGTO04 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 10:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbhGTOZh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 10:25:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66297C0613DB;
        Tue, 20 Jul 2021 08:05:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 70so19394904pgh.2;
        Tue, 20 Jul 2021 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTofV/w1u1zqupSScBuDhwvPxpe9jLm+00fbYmuCH3I=;
        b=GsFhBOqy9i4opw8UehrI3XO5G0++mxG4jRYDN213tAqPDMsuYvPxBTePL0iVdWHfmj
         uD9n4nJxap58kYBy/foqqlQOf5Tz+6z4y9Tj7YsZe2q0lfro5dmCgjmbbd7pIWJFX3WX
         EYGdpBfxZ2ztwDpx93YbF10KhIEAGeRFxhUJ/IJ7NqDlG2Y2//xnNcXwAtUMqkgB5Aml
         h0rbJxDJppi4NEIfckMcm06PsJucuyaHNbZGm5KSk980ouGNrerRPX8/x0iMR9Ry+084
         95BK5pyI7GqlUjxMTzAhNSBPCqLAvNzPrnNV8DhW+eJ5/2fBuNesrx8PoCa2fL+ohiA7
         XFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTofV/w1u1zqupSScBuDhwvPxpe9jLm+00fbYmuCH3I=;
        b=QAtSXwuhrQ/L+BGy5c7LvL3cnPslO+2arHIKGWdc1Wyk+M6z1EdMkXXQauM/6UF2sT
         vCthcMf8wZIU5Kq/GDWU3Z/0WiKzduv0d7G2cvwPIZBcClqNaxq+DV4SK8TEPVmLgau+
         lVDmy7MChvJl0FsTJ16jQi/ef22fyk2U/42agoQVBX5ndk49gA7jn5nENOxfFvSPzRC0
         SNLuBMyAlsXjNEZdaCpG2DqGBGSb2T0ljC5n60ebQkRYqBhsrmoa1cW7xpJ9biRB1IFR
         6iTHlP3VyBBKDbOZX9DYjkF5Y4aDlkIsQbX5HLaRSWUI7ud9+4VP4YrYAGdqEwDm4OED
         3HgQ==
X-Gm-Message-State: AOAM533zEZs8b3+1PIlxi+mW8splOLr8dzwVJw+fZK6IEbnaqmbDrCyU
        KNjuUcgzvPEWzrjrnX3B1cRQtHq20B6wFTEeYqE=
X-Google-Smtp-Source: ABdhPJz4qPpoabdtDqQ1TSajcom54g6DSdMpm36JCONeSFjYE34GJyBTw0onY4q4xSWU60EhLjXJOfnYvTHz9/AvsoM=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr31307813pfi.7.1626793502828; Tue, 20
 Jul 2021 08:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210719112156.27087-1-stephan@gerhold.net> <20210719112156.27087-4-stephan@gerhold.net>
 <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
 <CAHp75VcsVFO2Oizpyeh53MNt2v9yD81vXp1xKCVX-U4zb-KTdg@mail.gmail.com>
 <YPWV537oN3gDpAQS@gerhold.net> <CAHp75Vdjotgi9RrmKQC4J_QQSYdRWwp+-8aHGkChx6VFLPDh-Q@mail.gmail.com>
 <YPW1xGtLyLNGKqjJ@gerhold.net> <CAHp75VcZDSL5u2bP_ZFySmk7cPkHRycyA-+gMqSVWCpgFXhn7Q@mail.gmail.com>
 <YPXGQxPPID1SHOUO@gerhold.net>
In-Reply-To: <YPXGQxPPID1SHOUO@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jul 2021 18:04:22 +0300
Message-ID: <CAHp75Vf56+HpeGcdet61eeQyQfwFKx8x7vEc_G9NXStYy5Gsyw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: accel: bmc150: Make it possible to configure
 INT2 instead of INT1
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 9:37 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> On Mon, Jul 19, 2021 at 09:05:48PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 19, 2021 at 8:29 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Mon, Jul 19, 2021 at 07:19:05PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Jul 19, 2021 at 6:11 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > > > > On Mon, Jul 19, 2021 at 06:01:01PM +0300, Andy Shevchenko wrote:
> > > > > > On Mon, Jul 19, 2021 at 5:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > > > > On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:

...

> > > > > > > > +       irq_info = bmc150_accel_interrupts_int1;
> > > > > > > > +       if (irq == of_irq_get_byname(dev->of_node, "INT2"))
> > > > > > > > +               irq_info = bmc150_accel_interrupts_int2;
> > > > > > >
> > > > > > > This looks a bit DT-specific, but I don't see that ACPI has
> > > > > > > named IRQs so I don't know what to do about it either.
> > > > > >
> > > > > > Yeah, we only have so far the (de facto) established way of naming
> > > > > > GPIO based IRQs, and not IOxAPIC ones.
> > > > > >
> > > > > > > What does platform_get_irq_byname() do on ACPI systems?
> > > > > >
> > > > > > See above.
> > > > > >
> > > > > > > If there is no obvious fix I would leave it like this until the
> > > > > > > first ACPI used needing this comes along, but I think maybe
> > > > > > > Andy has suggestions.
> > > > > >
> > > > > > The platform_get_irq_byname() should do something similar that has
> > > > > > been done in platform_get_irq() WRT ACPI.
> > > > > > Here for sure the platform_get_irq_byname() or its optional variant
> > > > > > should be used.
> > > > >
> > > > > I don't think there is a platform device here, we only have the
> > > > > i2c_client or spi_device. That's why I didn't use
> > > > > platform_get_irq_byname(). :)
> > > > >
> > > > > Is there something equivalent for I2C/SPI drivers?
> > > >
> > > > Not yet. You probably need to supply some code there to allow
> > > > multi-IRQ devices (in resource provider agnostic way).
> > > >
> > > > You need to provide fwnode_get_irq_byname() to be similar with
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/base/property.c#L1010
> > > >
> > > > Then use it in the drivers.
> > > >
> > > > And/or integrate into frameworks somehow (something in between the
> > > > lines: https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L461).
> > > >
> > >
> > > Well, I don't think anyone has an ACPI use case for this right now so
> > > it's probably better if this is done by someone who actually needs this
> > > and can test it somewhere. :)
> > >
> > > I actually just "copied" this approach from some other IIO drivers where
> > > this is done similarly (and additionally checked the source code to make
> > > sure this won't break anything for ACPI platforms).
> >
> > I see in today's Linux Next snapshot:
> >
> > drivers/iio/accel/fxls8962af-core.c:774:        irq =
> > of_irq_get_byname(of_node, "INT2");
> > drivers/iio/accel/mma8452.c:1616:               irq2 =
> > of_irq_get_byname(client->dev.of_node, "INT2");
> > drivers/iio/gyro/fxas21002c_core.c:834: irq1 = of_irq_get_byname(np, "INT1");
> > drivers/iio/imu/adis16480.c:1265:               irq =
> > of_irq_get_byname(of_node, adis16480_int_pin_names[i]);
> > drivers/iio/imu/bmi160/bmi160_core.c:655:       irq =
> > of_irq_get_byname(of_node, "INT1");
> > drivers/iio/imu/bmi160/bmi160_core.c:661:       irq =
> > of_irq_get_byname(of_node, "INT2");
> >
> > I believe we may stop distributing this and actually start using a
> > common API. I don't want this to be spread again over all IIO. Btw, I
> > have LSM9DS0, which supports two INT pins for IMU and currently it
> > uses hard coded pin mapping.
> >
>
> Hm, I'm not quite sure how to implement this. Could you prepare a patch
> that would implement such a common API? I would be happy to test it for
> the device tree and make use of it in this patch.

Unfortunately I have no time to fulfil the required process. The idea
in general is like this:

if (is_of_node(...))
  return of_irq_get_byname(...);
if (is_acpi_node(...))
  return acpi_gpio_irq_get_byname(...);

Everything else is quite similar to fwnode_irq_get().

> To be honest, I mainly implemented support for the interrupt-names
> because Jonathan mentioned this would be nice to have [1] and it kind of
> fit well together with the BMC156 patch that needs the INT2 support.
> I actually just use the if (data->type == BOSCH_BMC156) part from
> PATCH 4/4 which does not depend on of_irq_get_byname().

Then I leave it to Jonathan and other maintainers.

> [1]: https://lore.kernel.org/linux-iio/20210611185941.3487efc6@jic23-huawei/

-- 
With Best Regards,
Andy Shevchenko
