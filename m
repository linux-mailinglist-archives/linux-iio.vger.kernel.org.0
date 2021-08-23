Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE973F4961
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhHWLKo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhHWLKn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 07:10:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A979C061575
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:10:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so18441483pjr.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prFTCJwPkuMopTSV8NsCc+PG+lUT87PZtmPHEpO7b8Y=;
        b=fdvV2fkI2WY4D6nPA2QAyWVIXGBLiZKyQ3xYfEY1rlXD4dEEzgZM5z1I1+LE75CYsf
         4eNkaFuRMtsuU0Dmpjbwta5Fx+MNXscuE7RultHsnj2IzxGmJQtI/GoXOn3kEfeCb1Qv
         T6htVTXfln7W9oAj/j7K/TD5uoe1EHYfTRVn8tYqkD2epOBQh6ij+sDjcjkULaVHGaUP
         0B4H3PdlkYi+h4AfLDCqcuvBDGWsbwA8b946RZq74VRi/IJFp/nnZ3cdXoEcrVw8dW0y
         Us8hQbeHhlBCiVRecmNAwLPYjlSS6s9lGXVjWTkzH4i1UfeusrIBN7T8ExWAp/w2s0gd
         f1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prFTCJwPkuMopTSV8NsCc+PG+lUT87PZtmPHEpO7b8Y=;
        b=gQ87PYcAchkTpDLN0ZrWAD8c3aPyIvFGp++YESByZ3ywRMxv3C6c3veKW5PJgmcpm8
         u9OlGare+1C+ZExGkuAJ3xjraDqeSlO8l2vmoe2RDmuG5+PtBAGhVK/OOLXffPUJdgHg
         jT2xNDQ3av6kJW4zol4nM68+x8/pVe7ethnTfNFTwHdsVmzK59brbSsIzPTdlFudMvSu
         91clKF/QxLXrC1f+cSHa2vHQ9fiS9jxGpK4ardxLtRf7iehsVNrGaSfkTKgvTAO98tWs
         sA3Xr/KbRaILj8cw0F7vtZ/HaZeHw81i203eBJ6CfGWYm8q+Elxd/WbQhs1u0r8N30dA
         /spw==
X-Gm-Message-State: AOAM531ucogCEuJQZp1DO44uj7qBZKnE8c4fCkugurIw0TAItNJO0hRc
        6wpqvN5bIZyC59eoM8CUsbUU0c6u202NsbohN4M2rUFOMPs=
X-Google-Smtp-Source: ABdhPJzHcRobolnmLflWn7bqLGZQCBGoLUY66Ir1zxxWrsfGIINgARMZg6II1QlR4swpAfVYNZtUcmXXyD/n4Q9ls3o=
X-Received: by 2002:a17:90a:6502:: with SMTP id i2mr19557502pjj.129.1629717000483;
 Mon, 23 Aug 2021 04:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210822184927.94673-3-jacopo@jmondi.org> <20210823073639.13688-1-jacopo@jmondi.org>
 <YSNdywXOuzYMCbJa@smile.fi.intel.com> <20210823090610.hr6a7wjhkpyuupxv@uno.localdomain>
 <YSNs8Oo+1oMZ5TJS@smile.fi.intel.com> <20210823101911.4kzsdolwxdrpnyxt@uno.localdomain>
In-Reply-To: <20210823101911.4kzsdolwxdrpnyxt@uno.localdomain>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Aug 2021 14:09:21 +0300
Message-ID: <CAHp75Vc4gSEn_3=5ixWr4WFyKwXDMMC8SaoBkZNotZ+GP6wMWA@mail.gmail.com>
Subject: Re: [PATCH v3.1 2/3] iio: chemical: Add Senseair Sunrise 006-0-007 driver
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 23, 2021 at 1:20 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> On Mon, Aug 23, 2021 at 12:40:00PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 23, 2021 at 11:06:10AM +0200, Jacopo Mondi wrote:
> > > On Mon, Aug 23, 2021 at 11:35:23AM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 23, 2021 at 09:36:39AM +0200, Jacopo Mondi wrote:

...

> > > > > +       errors = (const unsigned long *)&value;
> > > >
> > > > Yes, it takes a pointer, but in your case it will oops the kernel quite likely.
> > >
> > > The usage of a pointer kind of puzzled me in first place, and I found
> > > no pattern to copy in the existing code base. I have probbaly not
> > > looked hard enough ?
> > >
> > > >   unsigned long errors;
> > > >
> > > >   ...
> > > >
> > > >   errors = value;
> > > >   for_each_set_bit(..., &errors, ...)
> > >
> > > I can do so but, for my education mostly, why do you think it would
> > > oops ? '*errors' is a pointer to a variable allocated on the stack as
> > > much as 'errors' you suggested is a local stack variable. I might be a
> > > bit slow today, but I'm missing the difference. FWIW I tested the
> > > function, even if there were no error bits set at the moment I tested, but
> > > the for_each_set_bit() macro was indeed run.
> >
> > Because you theoretically access bytes behind 16-bit. That castings just ugly
> > and compiler should warn you about if it is clever enough.
>
> I don't think there's such a risk as I limit the search space to
> ARRAY_SIZE(error_codes), but I agree the cast is ugly and I'll change
> to what you suggested

More for the sake of education. Actually it's not theoretical. Some
architectures may not access longs on unaligned (16-bit) addresses.
So, yes, oops is probable.
Another example is reading the long to the register. This can cross
the page boundary and produce fault (again) oops.

> > If you found it in the existing code, please, fix it there, so quite bad
> > pattern won't spread.
>
> My point was that I was not able to find any pattern to copy from :)
>
> > > > > +       for_each_set_bit(i, errors, ARRAY_SIZE(error_codes))
> > > > > +               len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);

-- 
With Best Regards,
Andy Shevchenko
