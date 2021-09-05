Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82283400F21
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhIEKfH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 5 Sep 2021 06:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233851AbhIEKfG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 06:35:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778D461004;
        Sun,  5 Sep 2021 10:34:01 +0000 (UTC)
Date:   Sun, 5 Sep 2021 11:37:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210905113723.0cee38bb@jic23-huawei>
In-Reply-To: <CAHp75VdsMFAx2rb22oyf6NrewomgEdEJOUkuf6g-RONfxARgjw@mail.gmail.com>
References: <20210903144828.497166-1-jacopo@jmondi.org>
        <20210903144828.497166-3-jacopo@jmondi.org>
        <CAHp75VdX0=JCGDQaqCU5fDGe7vJBNTDTJHu=QOqd_YtGK4Rgdg@mail.gmail.com>
        <20210903164324.5n7xfo2qw5etwm3c@uno.localdomain>
        <CAHp75VdsMFAx2rb22oyf6NrewomgEdEJOUkuf6g-RONfxARgjw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Sep 2021 23:21:05 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 3, 2021 at 7:42 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> > On Fri, Sep 03, 2021 at 06:36:44PM +0300, Andy Shevchenko wrote:  
> > > On Fri, Sep 3, 2021 at 5:50 PM Jacopo Mondi <jacopo@jmondi.org> wrote:  
> 
> ...
> 
> > > > +       mutex_lock(&sunrise->wakeup_lock);
> > > > +       sunrise_wakeup(sunrise);
> > > > +       ret = regmap_read(sunrise->regmap, reg, &val);
> > > > +       mutex_unlock(&sunrise->wakeup_lock);  
> > >
> > > Seems to me that you may redefine ->read() for regmap (but double
> > > check this, esp. in regard to bulk transfers) with wakeup implied and
> > > in that case you probably can use regmap's lock only.  
> >
> > Can you point me to an example where regmap's read is redefined ? I
> > failed to find one at a quick look.  
> 
> Any when struct regmap_config is defined with devm_regmap_i2c_init() call.
> 
> This one is not I²C, but gives you an idea.
> https://elixir.bootlin.com/linux/latest/source/drivers/mfd/intel_soc_pmic_mrfld.c#L98
> 
> ...
> 
> > Ugh! I initially had a *dev pointer for the sake of line length in
> > error messages in the driver's struct, then I'm asked to remove it,
> > then I'm asked to take a pointer to re-shorten the lines.  
> 
> Up to maintainers then.

Andy is requesting something different here by asking for a local
struct device *dev = sunrise->client->dev;

but personally I wouldn't bother when there is only one use in a given
function. I wouldn't mind if you did do it either - this one is very much
personal taste and so I tend to not worry about it!

Having the extra pointer in iio_priv() was a case of architecture being
a bit 'fuzzy' for convenience which is a different matter.

> 
> ...
> 
> > > > +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> > > > +{
> > > > +       __be16 be_data = cpu_to_be16(data);
> > > > +       int ret;
> > > > +
> > > > +       mutex_lock(&sunrise->wakeup_lock);
> > > > +       sunrise_wakeup(sunrise);
> > > > +       ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, 2);
> > > > +       mutex_unlock(&sunrise->wakeup_lock);
> > > > +       if (ret) {
> > > > +               dev_err(&sunrise->client->dev,
> > > > +                       "Write word failed: reg 0x%2x (%d)\n", reg, ret);  
> > >  
> > > > +               return ret;
> > > > +       }
> > > > +
> > > > +       return 0;  
> > >
> > > return ret;
> > >  
> >
> > I can return a positive value for success and change the checks around
> > return code to if (ret < 0) but that's driver internal stuff after
> > all, does it really matter ? Is this more consistent with the Linux
> > i2c API maybe ?  I can change it if it's the case.  
> 
> I didn't get what this comment has with what I have proposed.
> 
> Maybe it wasn't obvious, so I have proposed to change 4 LOCs by 1 LOC, so
> 
> if (ret)
>   dev_err(...);
> return ret;

one of the checking scripts tends to moan about this so it's nice to clean it
out at the start and avoid the inevitable follow up patch :)

> 
> > > > +}  
> 
> ...
> 
> > > > +static ssize_t sunrise_cal_read(const char *buf, size_t len)
> > > > +{
> > > > +       bool enable;
> > > > +       int ret;
> > > > +
> > > > +       ret = kstrtobool(buf, &enable);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       if (!enable)
> > > > +               return len;
> > > > +
> > > > +       return 0;  
> > >
> > > Why is this a separate function to begin with?  
> >
> > Because it is called from two places where I should have duplicated
> > the code otherwise ?  
> 
> I think what you think about duplication is not and will get even LOC
> benefit. Using kstrtobool() directly in the callers is better than
> hiding like this.

Part of the issue here is that the naming perhaps suggests a hardware rad
whereas it's just a bit of string handling.

Whilst it's shared code, there is only a rather tangential connection between
the two call sites and the function itself ended up a bit weird.

I'd go with what Andy is suggesting and just have this handling inline.


> 
> > > Not sure I have got the logic behind. If enable is true you return 0?!  
> >
> > Yes, so I can
> >         if (ret)
> >                 return ret;
> > in the caller.
> >  
> > > > +}  
> 
> 

