Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD54E3CD9B0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbhGSObP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243384AbhGSO2y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 10:28:54 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF4C0617A6;
        Mon, 19 Jul 2021 07:30:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y17so19210841pgf.12;
        Mon, 19 Jul 2021 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdrBvN6KgpslFeTTeHrxK2c0CP6V1JmbD0RP39VrpGQ=;
        b=T+VRamOUx2J1Ix+6/rwuqLTgyBL9wRD4OTofxsHjBp/a5DG3RzaXYQnrY3yvQvtAk8
         Mf4ri6iwd36GOUfYfJPGjG1/aOEBkA8s6aDCnpNdsUF+sNRZmEasMr2YwHmETcDhV/ku
         fDhYS+cpIsvpClTdSkMyY62U5a+xiFhy1cdYb4jYwoSgJkPZUjFYRlfm/7NrseZOPRbD
         wCoY/MMrVxh0nk5cv8suVWskGgBUjc+l1smAukXmE0W0tUbI+WhLJYvPfqg/OFAp1gSV
         L5OC5UZh1rxjKZewDPq3iX0TvbnYeo/Y8abOfdaJkra6QHsZr+S6Kp21sV1yRI+HsT9z
         3Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdrBvN6KgpslFeTTeHrxK2c0CP6V1JmbD0RP39VrpGQ=;
        b=Hxs40XwyZQ3eAHw4fKaUeZhwf8yZrxuS6UWsYGkRObPYl5sTOwlEZycHu2KzZPIqjj
         cbPJI18QxnH59JfQ0dFu7H07VIj4lYV+h00rc9lYO+K7Z6vq7xjB8sdaB6XWfJHkvdFu
         +PZcP0AMkpMpHG4aDYyRCX6muY2CLvt2QkixBZTOXk3PQXmtUFiEc453A0rYc/EpIMkl
         +BqeWQiK7NnKR8rPBf+7dUCMXQSoVN0Xd+OVDqfGb8800ktTOZjDSml505CFDVxOYGFg
         PxnsCpeQdN67HAcoAFTipr7Ostzr94gNXnqYd7rIkmEEs99kGTBhwMtdopLCYmAemOre
         B9Vg==
X-Gm-Message-State: AOAM532m099xPK++gMcORPS/GOvhUe+UGIjkkaeAfU+cFG+v14uNfPBi
        nj5tek7oWi9cVNMPXgixhwH5hjvXFIvcikWfQlQ=
X-Google-Smtp-Source: ABdhPJwspJQh5QPrBysOLPL3RMxOTHGXTBgMV2d8/Ipncc8gfGsaVBWkPlWWhlLBwcRUSxFG2VBSabD8subgB5pOso0=
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr25929651pgm.74.1626706900991;
 Mon, 19 Jul 2021 08:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210719112156.27087-1-stephan@gerhold.net> <20210719112156.27087-4-stephan@gerhold.net>
 <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
In-Reply-To: <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Jul 2021 18:01:01 +0300
Message-ID: <CAHp75VcsVFO2Oizpyeh53MNt2v9yD81vXp1xKCVX-U4zb-KTdg@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: accel: bmc150: Make it possible to configure
 INT2 instead of INT1
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
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

On Mon, Jul 19, 2021 at 5:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> > Some Bosch accelerometers have two interrupt pins (INT1 and INT2).
> > At the moment, the driver uses only the first one, which is fine for
> > most situations. However, some boards might only have INT2 connected
> > for some reason.
> >
> > Add the necessary bits and configuration to set up INT2. Then try
> > to detect this situation at least for device tree setups by checking
> > if the first interrupt (the one picked by the I2C/SPI core) is actually
> > named "INT2" using the interrupt-names property.
> >
> > of_irq_get_byname() returns either 0 or some error code in case
> > the driver probed without device tree, so in all other cases we fall
> > back to configuring INT1 as before.
> >
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>
> >  #include <linux/acpi.h>
> > +#include <linux/of_irq.h>
> (...)
> > +       irq_info = bmc150_accel_interrupts_int1;
> > +       if (irq == of_irq_get_byname(dev->of_node, "INT2"))
> > +               irq_info = bmc150_accel_interrupts_int2;
>
> This looks a bit DT-specific, but I don't see that ACPI has
> named IRQs so I don't know what to do about it either.

Yeah, we only have so far the (de facto) established way of naming
GPIO based IRQs, and not IOxAPIC ones.

> What does platform_get_irq_byname() do on ACPI systems?

See above.

> If there is no obvious fix I would leave it like this until the
> first ACPI used needing this comes along, but I think maybe
> Andy has suggestions.

The platform_get_irq_byname() should do something similar that has
been done in platform_get_irq() WRT ACPI.
Here for sure the platform_get_irq_byname() or its optional variant
should be used.

-- 
With Best Regards,
Andy Shevchenko
