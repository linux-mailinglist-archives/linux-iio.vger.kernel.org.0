Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34E73CE645
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 18:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhGSQDZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352310AbhGSQBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 12:01:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4CC07675C;
        Mon, 19 Jul 2021 08:55:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so319994pju.1;
        Mon, 19 Jul 2021 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rHu41TCHgBj1G4qSAlJzzJb66I8zmrgC/P0rmdS+rE=;
        b=qgPf32jDVVzRY3bExBRt3yOOjBJHa8ezmS2QcV9IQPBfsDgEF69oU4vNYwi2GfhV/8
         o9daDmcO6Gp1d2ha28KleSV+DKQsFmK2IoJfWb6gLZnkK/2FPzIA0hsP6EKU60uSAdVA
         y6lyy562AMkbc1le5Qpl+IAiulnj+XggqXFduIc+nUZmcsbUO0HFbymgPOS5VBW7Ybhg
         0MWnGfRGwk01ayGlm6CNpsYxtOr5RxVsYLNjgsymBohKTpya3CqWENhg2zJr+o+e8CIo
         e6SMp1PgN3kh2tvbaqAV+X6samHn4TdtastpirtaJp0JA2pwgPVJP7dcQekcLOLrEyEI
         a6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rHu41TCHgBj1G4qSAlJzzJb66I8zmrgC/P0rmdS+rE=;
        b=eqIIHqRQWr1p1AmMxDl/5X/weqNJbLg/wY0fMN/WnjgURO2QtsRk0htjpcETOH5FMa
         pqdxTbFvNxoygxjCbNjk1j9N5veIr+RSVQ27hgey/SPlx6L1WkLM6lE3wAd+kKYa/uo8
         mDc+n/fKlIzjG+jqj5TyhOvaOf19npRm9C/uZD+9M5uGrLJxfqC0rEf9Jr8CyolcUJRZ
         PK6/htt9yaP8JHj4N2PnoLZAJA0ndEenQRWTJIXYTSEqGUA82Rv6CFN6tfvmdyggTrhG
         /vqlYz6diXCL0ccKPiiBQFVoFImxPgcZp3yIPgEhHGuPvMQmlxKgCS5BBruQAk7ov+Qt
         IT0g==
X-Gm-Message-State: AOAM532ZKukMBVUMwTcTdoaTVKRYfpBxqkhkxPG7BU7fQype4IypQcLo
        1aLHsQOHjfL52QGhGblyXVla9FcE9NQ+ql10+1Y=
X-Google-Smtp-Source: ABdhPJw/0MLtej1TbBAyye/eiO8r2Eoj38PSFkBhUxuAXDBS5QfgtRlNZQO654JGjKBo9e+N1YJHWLbGu3Xur64GgYE=
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr31502676pjq.129.1626711584809;
 Mon, 19 Jul 2021 09:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210719112156.27087-1-stephan@gerhold.net> <20210719112156.27087-4-stephan@gerhold.net>
 <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
 <CAHp75VcsVFO2Oizpyeh53MNt2v9yD81vXp1xKCVX-U4zb-KTdg@mail.gmail.com> <YPWV537oN3gDpAQS@gerhold.net>
In-Reply-To: <YPWV537oN3gDpAQS@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Jul 2021 19:19:05 +0300
Message-ID: <CAHp75Vdjotgi9RrmKQC4J_QQSYdRWwp+-8aHGkChx6VFLPDh-Q@mail.gmail.com>
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

On Mon, Jul 19, 2021 at 6:11 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> On Mon, Jul 19, 2021 at 06:01:01PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 19, 2021 at 5:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:

...

> > > >  #include <linux/acpi.h>
> > > > +#include <linux/of_irq.h>
> > > (...)
> > > > +       irq_info = bmc150_accel_interrupts_int1;
> > > > +       if (irq == of_irq_get_byname(dev->of_node, "INT2"))
> > > > +               irq_info = bmc150_accel_interrupts_int2;
> > >
> > > This looks a bit DT-specific, but I don't see that ACPI has
> > > named IRQs so I don't know what to do about it either.
> >
> > Yeah, we only have so far the (de facto) established way of naming
> > GPIO based IRQs, and not IOxAPIC ones.
> >
> > > What does platform_get_irq_byname() do on ACPI systems?
> >
> > See above.
> >
> > > If there is no obvious fix I would leave it like this until the
> > > first ACPI used needing this comes along, but I think maybe
> > > Andy has suggestions.
> >
> > The platform_get_irq_byname() should do something similar that has
> > been done in platform_get_irq() WRT ACPI.
> > Here for sure the platform_get_irq_byname() or its optional variant
> > should be used.
>
> I don't think there is a platform device here, we only have the
> i2c_client or spi_device. That's why I didn't use
> platform_get_irq_byname(). :)
>
> Is there something equivalent for I2C/SPI drivers?

Not yet. You probably need to supply some code there to allow
multi-IRQ devices (in resource provider agnostic way).

You need to provide fwnode_get_irq_byname() to be similar with
https://elixir.bootlin.com/linux/latest/source/drivers/base/property.c#L1010

Then use it in the drivers.

And/or integrate into frameworks somehow (something in between the
lines: https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L461).

-- 
With Best Regards,
Andy Shevchenko
