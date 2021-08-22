Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2393F404A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Aug 2021 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhHVPli (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Aug 2021 11:41:38 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58187 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhHVPli (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Aug 2021 11:41:38 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8F95940004;
        Sun, 22 Aug 2021 15:40:54 +0000 (UTC)
Date:   Sun, 22 Aug 2021 17:41:43 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: chemical: Add Sensteair Sunrise 006-0-007
 driver
Message-ID: <20210822154143.bglo7ldwtr4kbesg@uno.localdomain>
References: <20210820133821.159239-1-jacopo@jmondi.org>
 <20210820133821.159239-3-jacopo@jmondi.org>
 <CAHp75Vej52puQ6jTvxoMDnfJc82Sg1u53Y=2_qquvkZf8Khpxg@mail.gmail.com>
 <20210820144331.h6kfsdr6d6tskoon@uno.localdomain>
 <CAHp75VdCVr1tz0p2eu6jP36ox7YgOV6OGwXYYQthx9QEoXFLog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VdCVr1tz0p2eu6jP36ox7YgOV6OGwXYYQthx9QEoXFLog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Fri, Aug 20, 2021 at 05:56:48PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 20, 2021 at 5:42 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> ...
>
> > > > +#include <linux/i2c.h>
> > >
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/iio/sysfs.h>
> > >
> > > Can you move this as a separate group...
> > >
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/sysfs.h>
> > >
> > > ...here ?
> >
> > Ah, is this customary in the subsystem ?
>
> When it's a group of headers for a certain subsystem it makes it clear
> that the driver belongs to it.

Ack, I'll move

>
> ...
>
> > > > +static void sunrise_wakeup(struct sunrise_dev *sunrise)
> > > > +{
> > > > +       struct i2c_client *client = sunrise->client;
> > > > +
> > > > +       /*
> > > > +        * Wake up sensor by sending sensor address: START, sensor address,
> > > > +        * STOP. Sensor will not ACK this byte.
> > > > +        *
> > > > +        * The chip returns in low power state after 15msec without
> > > > +        * communications or after a complete read/write sequence.
> > > > +        */
> > >
> > > I'm wondering if there is a better way to perform this.
> >
> > Do you mean using a different API instead of i2c_smbus_xfer()?
>
> I meant on hw level.

That doesn't seem to be possible, I'm afraid.

The chip manual clearly reports that the chip needs to be waken up as
it enters low power state automatically after 15ms without
communications or after a completed transaction

Quoting TDE5531 which is now referenced in the commit message:

----
Senseair Sunrise spend most of its time in deep sleep mode to minimize
power consumption, this have the effect that it is necessary to wake
up the sensor before it is possible to communicate with it.  Sensor
will wake up on a falling edge on SDA, it is recommended to send
sensors address to wake it up. When sensors address is used to wake up
the sensor the sensor will not acknowledge this byte.

Communication sequence:
1) Wake up sensor by sending sensor address (START, sensor address,
STOP). Sensor will not ACK this byte.

2) Normal I2C read/write operations. I2C communication must be started
within 15ms after the wake-up byte, each byte sent to or from the
sensor sets the timeout to 15 ms. After a complete read or write
sequence sensor will enter sleep mode immediately.
---

> ...
>
> > > > +               dev_err(sunrise->dev, "Read word failed: reg 0x%2x (%d)\n",
> > > > +                       reg, ret);
> > >
> > > One line?
> >
> > Goes over 80, as all the other identical comments below.
>
> It's still less than 90, so go for it!

Where does the 90 cols limit comes from ? :)

Anyway, I guess that's up to the subsystem, so I'll re-arrange lines
close to 80 cols

>
> ...
>
> > > > +       ret = sunrise_calibrate(sunrise);
> > > > +
> > > > +       return ret ?: len;
> > >
> > > In this case
> > >
> > >   if (ret)
> > >     return ret;
> > >
> > > return len;
> > >
> > > will look more natural.
> >
> > I had this and I switched before sending. Matter of tastes I guess.
> > I actually changed this as I thought it would have pleased you :)
>
> Use your common sense. Not every place where you can put it really needs it.
> Either way you choose is okay because of style, but to be sure ask the
> maintainer :-)

It's a really minor detail, and I also prefer the style you suggested
so I'll go for it.

>
> ...
>
> > > > +       for (i = 0; i < ARRAY_SIZE(error_codes); ++i) {
> > > > +               if (!(value & BIT(error_codes[i])))
> > > > +                       continue;
> > >
> > > for_each_set_bit()
> >
> > only 12 bits are valid, the top 4 are undocumented. They -should- be
> > zeroed but who knows.
>
> I didn't get your answer. The limit for the for-loop in both cases
> will be the same, but for_each_set_bit() is what you open-coded. Why
> do you need the open-coded variant, what is the benefit?
>

I should have looked at the for_each_set_bit() definition to find out
that it supports a size argument. I assumed it ranged on the full size
of the variable to inspect. Sorry for being sloppy ;)

> ...
>
> > > > +       /* Error statuses. */
> > > > +       {
> > > > +               .name = "error_status",
> > > > +               .read = sunrise_error_status_read,
> > > > +               .shared = IIO_SEPARATE,
> > > > +       },
> > > > +       IIO_ENUM_AVAILABLE("error_status", &sunrise_error_statuses_enum),
> > >
> > > > +       {},
> > >
> > > No comma for terminator entries.
>
> I assume non-commented ones are agreed on.
>

Ack

> ...
>
> > > > +
> > > > +       return 0;
> > >
> > > Dead code?
> >
> > It is, but it seems nicer :) Should I drop it ?
>
> We don't need dead code in the kernel.

Nobody does actually, so I'll drop this.

Thanks
   j

>
> --
> With Best Regards,
> Andy Shevchenko
