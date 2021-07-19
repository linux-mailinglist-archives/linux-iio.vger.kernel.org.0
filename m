Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE953CE8C7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348191AbhGSQsS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 12:48:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:34755 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349697AbhGSQqH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 12:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626715597;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JSDTqVTfXpY/nkps/4WQBQ4jmhTTXlWkA4xD144AOWs=;
    b=VzhonegltXxBQblRm+I2i3+wdNeJ59FCjpOXH5aNtm7V6tWkDT6Vowdxs0RcETQYkH
    qKJ7dQxHR5dsi+lxnxYSN1K7ftAe+QbWn0/HqXyqrw+9lZAInuyhR4CcMJbuDG0+VJsf
    /9tHo5sLO2WhF1L1lkOeov9AXODw7nkDeM0N9P6E4hN+S/Xth/nP4QX1Ba+N2voPYbmQ
    ez4JlhBXGTvvjeVYAjhfwMzLEgZy2JzdzyAgky+cQLY2ji+9aG7oBXedr2QXJsk5qI9J
    OXwx1P/oYAp3sTG9bWmN/fVaUDYgBvU+KISM70Xe743zKauK/IU1LpdyiODbkhRAhC0B
    t88Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j4IczAa4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id g02a44x6JHQa5o9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jul 2021 19:26:36 +0200 (CEST)
Date:   Mon, 19 Jul 2021 19:26:28 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH 3/4] iio: accel: bmc150: Make it possible to configure
 INT2 instead of INT1
Message-ID: <YPW1xGtLyLNGKqjJ@gerhold.net>
References: <20210719112156.27087-1-stephan@gerhold.net>
 <20210719112156.27087-4-stephan@gerhold.net>
 <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
 <CAHp75VcsVFO2Oizpyeh53MNt2v9yD81vXp1xKCVX-U4zb-KTdg@mail.gmail.com>
 <YPWV537oN3gDpAQS@gerhold.net>
 <CAHp75Vdjotgi9RrmKQC4J_QQSYdRWwp+-8aHGkChx6VFLPDh-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdjotgi9RrmKQC4J_QQSYdRWwp+-8aHGkChx6VFLPDh-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 07:19:05PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 19, 2021 at 6:11 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Mon, Jul 19, 2021 at 06:01:01PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 19, 2021 at 5:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> ...
> 
> > > > >  #include <linux/acpi.h>
> > > > > +#include <linux/of_irq.h>
> > > > (...)
> > > > > +       irq_info = bmc150_accel_interrupts_int1;
> > > > > +       if (irq == of_irq_get_byname(dev->of_node, "INT2"))
> > > > > +               irq_info = bmc150_accel_interrupts_int2;
> > > >
> > > > This looks a bit DT-specific, but I don't see that ACPI has
> > > > named IRQs so I don't know what to do about it either.
> > >
> > > Yeah, we only have so far the (de facto) established way of naming
> > > GPIO based IRQs, and not IOxAPIC ones.
> > >
> > > > What does platform_get_irq_byname() do on ACPI systems?
> > >
> > > See above.
> > >
> > > > If there is no obvious fix I would leave it like this until the
> > > > first ACPI used needing this comes along, but I think maybe
> > > > Andy has suggestions.
> > >
> > > The platform_get_irq_byname() should do something similar that has
> > > been done in platform_get_irq() WRT ACPI.
> > > Here for sure the platform_get_irq_byname() or its optional variant
> > > should be used.
> >
> > I don't think there is a platform device here, we only have the
> > i2c_client or spi_device. That's why I didn't use
> > platform_get_irq_byname(). :)
> >
> > Is there something equivalent for I2C/SPI drivers?
> 
> Not yet. You probably need to supply some code there to allow
> multi-IRQ devices (in resource provider agnostic way).
> 
> You need to provide fwnode_get_irq_byname() to be similar with
> https://elixir.bootlin.com/linux/latest/source/drivers/base/property.c#L1010
> 
> Then use it in the drivers.
> 
> And/or integrate into frameworks somehow (something in between the
> lines: https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L461).
> 

Well, I don't think anyone has an ACPI use case for this right now so
it's probably better if this is done by someone who actually needs this
and can test it somewhere. :)

I actually just "copied" this approach from some other IIO drivers where
this is done similarly (and additionally checked the source code to make
sure this won't break anything for ACPI platforms).

Stephan
