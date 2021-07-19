Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31FF3CD9B2
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbhGSObQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 10:31:16 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:23458 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244804AbhGSOaE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 10:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626707436;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CeLe4nMSuv4dtb/BgLdchSA8c1s8roiEPj5qOSak9rI=;
    b=MgUSanFxps8dM0m9jDfz5e2zGaUJH2BkR1ep3btvN1hoodwnC1is9j3tbm3onEFFW7
    7pPPqh8iRyUyXUZnkUJJnTF22yR5CpTXQdNt1btunm2QSlNeoewggCzPngSX4pNbf9bX
    wXer2Jq8zms8yg1TiAWJ693DU4EqEXkQ3CK2ArFl5t2aOhYcoKzKr2dcsAuvJCCKSbT6
    2LUGM/hCQhDJyFgRMnXDaHTfZkyuoo3/FaNKAWQXo/9qaerfzJg7TpPdcgmg2sTmk1Nd
    w1DWKPSI8iVJmtnHEe+WtCJ1Y7C0RnN4oEZPbR8stYA1+/bAoU4Qe+9TKnBN/47t9Wy5
    bFJw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j4IczAa4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id g02a44x6JFAa50r
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jul 2021 17:10:36 +0200 (CEST)
Date:   Mon, 19 Jul 2021 17:10:31 +0200
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
Message-ID: <YPWV537oN3gDpAQS@gerhold.net>
References: <20210719112156.27087-1-stephan@gerhold.net>
 <20210719112156.27087-4-stephan@gerhold.net>
 <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
 <CAHp75VcsVFO2Oizpyeh53MNt2v9yD81vXp1xKCVX-U4zb-KTdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcsVFO2Oizpyeh53MNt2v9yD81vXp1xKCVX-U4zb-KTdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 06:01:01PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 19, 2021 at 5:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > > Some Bosch accelerometers have two interrupt pins (INT1 and INT2).
> > > At the moment, the driver uses only the first one, which is fine for
> > > most situations. However, some boards might only have INT2 connected
> > > for some reason.
> > >
> > > Add the necessary bits and configuration to set up INT2. Then try
> > > to detect this situation at least for device tree setups by checking
> > > if the first interrupt (the one picked by the I2C/SPI core) is actually
> > > named "INT2" using the interrupt-names property.
> > >
> > > of_irq_get_byname() returns either 0 or some error code in case
> > > the driver probed without device tree, so in all other cases we fall
> > > back to configuring INT1 as before.
> > >
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> >
> > >  #include <linux/acpi.h>
> > > +#include <linux/of_irq.h>
> > (...)
> > > +       irq_info = bmc150_accel_interrupts_int1;
> > > +       if (irq == of_irq_get_byname(dev->of_node, "INT2"))
> > > +               irq_info = bmc150_accel_interrupts_int2;
> >
> > This looks a bit DT-specific, but I don't see that ACPI has
> > named IRQs so I don't know what to do about it either.
> 
> Yeah, we only have so far the (de facto) established way of naming
> GPIO based IRQs, and not IOxAPIC ones.
> 
> > What does platform_get_irq_byname() do on ACPI systems?
> 
> See above.
> 
> > If there is no obvious fix I would leave it like this until the
> > first ACPI used needing this comes along, but I think maybe
> > Andy has suggestions.
> 
> The platform_get_irq_byname() should do something similar that has
> been done in platform_get_irq() WRT ACPI.
> Here for sure the platform_get_irq_byname() or its optional variant
> should be used.
> 

I don't think there is a platform device here, we only have the
i2c_client or spi_device. That's why I didn't use
platform_get_irq_byname(). :)

Is there something equivalent for I2C/SPI drivers?

Thanks!
Stephan
