Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C913F2E73
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbhHTO6H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhHTO6G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 10:58:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE3C061575
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 07:57:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q2so9410804pgt.6
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INg51S7qQ/ZFRdaIjlUvfqWSN9DoxDhEcfce9eDyUlk=;
        b=ggdPi4Nl8cIJV1rOIk+Ut7D2TRWzqnEC+bAXXrdm9vOkwnmcZkPoaTOJ04UzuwQtdq
         MYruAMFDx4y4cpvdoDKdYs1uk5KNWfyMf6s2rgADgwfuu8NAbAdplDs083X12wse8Nrp
         5Cn9aoUNRUQJHSyaJ0PEoW9TSOOu862rB1LnhAvTKzed0ddD1KY+eo38lZe/0Rujs/qu
         CKSWjaaQBekZsiB4wmd6XOwfXm6X+oevlfgBKUIRwX8ofvFI453yOLMwliU0yT1bsTYV
         S0C7ZfU1ukIQKODbgVZTHsuM2lGUIqamkn1F+hg+MRUSPU8tKp8PK22oHZctSQ9Ok1X8
         bjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INg51S7qQ/ZFRdaIjlUvfqWSN9DoxDhEcfce9eDyUlk=;
        b=f0Rf7qcDU4r27VGj5wB2YfI2+V9PTsBHC5cuMxrZ0A8jn5fLmGCjO0YdHA8ZRb0bA3
         7QGTd8hfQX1VrkJzjkUJzs1OJNvahblm3/12K+3B7xflIvIfQZ7Cj7N87H9Bw2aNO2FI
         N0Wsh8DXDoGEg5HsVm3E3MUCd0BKCXT+AtRNq0KluZuJUlWqcB6NZAUdIb4yLgHVlzCy
         zw4YUopC3wpEmoHW00RgdxufIMCvbVD/uM6U38G4taxor9GAzANabzu4KAxcfSYhtoBC
         rYd9xVY5aS4Xe4uQfk3Fn5gBf5FWQW7wZTZrlrhG+oXkBJe/YlVIKPKpVGiljslQ2WBq
         kiDA==
X-Gm-Message-State: AOAM533+/vppC7WMXjIgWrmFV2j9y3+IiFrhhf1F3R0xdWAyTuLSU6le
        tb3pjCmFBRG7qHGDJpBD2+bkqyDuj9tXZ7X5DGE=
X-Google-Smtp-Source: ABdhPJxnlVSINFfQBo7U11uf6dZpsq/5ngbE/W0KZU64zNCvt3yGyr7c1PGapAaWOqPGt209Ui887UD5jVHTO4p50JA=
X-Received: by 2002:aa7:9618:0:b0:3e2:1bc3:aa93 with SMTP id
 q24-20020aa79618000000b003e21bc3aa93mr20323172pfg.73.1629471447751; Fri, 20
 Aug 2021 07:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210820133821.159239-1-jacopo@jmondi.org> <20210820133821.159239-3-jacopo@jmondi.org>
 <CAHp75Vej52puQ6jTvxoMDnfJc82Sg1u53Y=2_qquvkZf8Khpxg@mail.gmail.com> <20210820144331.h6kfsdr6d6tskoon@uno.localdomain>
In-Reply-To: <20210820144331.h6kfsdr6d6tskoon@uno.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Aug 2021 17:56:48 +0300
Message-ID: <CAHp75VdCVr1tz0p2eu6jP36ox7YgOV6OGwXYYQthx9QEoXFLog@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: chemical: Add Sensteair Sunrise 006-0-007 driver
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 20, 2021 at 5:42 PM Jacopo Mondi <jacopo@jmondi.org> wrote:

...

> > > +#include <linux/i2c.h>
> >
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> >
> > Can you move this as a separate group...
> >
> > > +#include <linux/kernel.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/sysfs.h>
> >
> > ...here ?
>
> Ah, is this customary in the subsystem ?

When it's a group of headers for a certain subsystem it makes it clear
that the driver belongs to it.

...

> > > +static void sunrise_wakeup(struct sunrise_dev *sunrise)
> > > +{
> > > +       struct i2c_client *client = sunrise->client;
> > > +
> > > +       /*
> > > +        * Wake up sensor by sending sensor address: START, sensor address,
> > > +        * STOP. Sensor will not ACK this byte.
> > > +        *
> > > +        * The chip returns in low power state after 15msec without
> > > +        * communications or after a complete read/write sequence.
> > > +        */
> >
> > I'm wondering if there is a better way to perform this.
>
> Do you mean using a different API instead of i2c_smbus_xfer()?

I meant on hw level.

...

> > > +               dev_err(sunrise->dev, "Read word failed: reg 0x%2x (%d)\n",
> > > +                       reg, ret);
> >
> > One line?
>
> Goes over 80, as all the other identical comments below.

It's still less than 90, so go for it!

...

> > > +       ret = sunrise_calibrate(sunrise);
> > > +
> > > +       return ret ?: len;
> >
> > In this case
> >
> >   if (ret)
> >     return ret;
> >
> > return len;
> >
> > will look more natural.
>
> I had this and I switched before sending. Matter of tastes I guess.
> I actually changed this as I thought it would have pleased you :)

Use your common sense. Not every place where you can put it really needs it.
Either way you choose is okay because of style, but to be sure ask the
maintainer :-)

...

> > > +       for (i = 0; i < ARRAY_SIZE(error_codes); ++i) {
> > > +               if (!(value & BIT(error_codes[i])))
> > > +                       continue;
> >
> > for_each_set_bit()
>
> only 12 bits are valid, the top 4 are undocumented. They -should- be
> zeroed but who knows.

I didn't get your answer. The limit for the for-loop in both cases
will be the same, but for_each_set_bit() is what you open-coded. Why
do you need the open-coded variant, what is the benefit?

...

> > > +       /* Error statuses. */
> > > +       {
> > > +               .name = "error_status",
> > > +               .read = sunrise_error_status_read,
> > > +               .shared = IIO_SEPARATE,
> > > +       },
> > > +       IIO_ENUM_AVAILABLE("error_status", &sunrise_error_statuses_enum),
> >
> > > +       {},
> >
> > No comma for terminator entries.

I assume non-commented ones are agreed on.

...

> > > +
> > > +       return 0;
> >
> > Dead code?
>
> It is, but it seems nicer :) Should I drop it ?

We don't need dead code in the kernel.

-- 
With Best Regards,
Andy Shevchenko
