Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5953FAD78
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 19:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhH2RlW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 13:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhH2RlU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Aug 2021 13:41:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF56C061575
        for <linux-iio@vger.kernel.org>; Sun, 29 Aug 2021 10:40:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso8395313pjq.4
        for <linux-iio@vger.kernel.org>; Sun, 29 Aug 2021 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLt53ZEXBTrLsS3UE9fPZZQPFj/477MHua8g8hYE544=;
        b=HJGC0MWaJ6NGHvgg0s3UGoOdGHsRY3hi0+H61e3JcHErwXeZm0qmsVF3u1VVPIiLN7
         HApGk2hzBzifZQ4L8yHiI6P9gGUKRfuwLcT7mMBAIrkqS/NhopEfUrClBRqRgtYHm9ej
         D92v6y9+C/ulHW8ubH8PipfjFyrSbqMnePOK4j6C1S9yTB36gOV5LOASShLZICSI4Ah0
         r7PaEDBm8apjhfNLxQwqJIJUZF7T2hVw1aIzso+5N7/8w7cbYNIRxsXHJ4pZrGujjEj1
         7l7TxG6CFKoD9u1JQZpz8O8gbyIQpMaQehN2pQWsuCNuXetAskadrbadUWlL5UFK4Aqn
         j4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLt53ZEXBTrLsS3UE9fPZZQPFj/477MHua8g8hYE544=;
        b=B7drDAx/N3mLkMtmKTD+cH9njTSH52EjcmnrEqimeQZf051VcKUNW1LHCIJdB4KmyL
         YTV4iHCz4/Bnmt5i0s87X5+aI1wpj4fU03dDSbB3rHkkKyEJTPNy04Pcmwmq8/KogSIV
         b1+xDQtt+trVDJRJ/fyfqlcDCQzid9XHBGAcgVbGCur2xC72bYnsFRzfjNs3MQGZSeyf
         bD/2BiyFlAC6icwaE8Rg5CUcfozVQRPG+gJd4crk5SAdR81zPIvAO9bhqEAZajNdMtbW
         GYf6eQbMA7uXjEpn5VpdYOIs9ZD5eG3k8ZDx+vKbrOtz8JrU6lfsgKzykuVS115kuJ5x
         aGPw==
X-Gm-Message-State: AOAM530qpSHorG64EAC7us8HGygQd0qZjKVfj2Z3pQEoDKb5083cCl+b
        PKShj4oqfRqh2IqD6hh/JpXfQ+nnZdY9npR9sfE=
X-Google-Smtp-Source: ABdhPJw9lJlKgCn1T0dATgRTHR9FYAj6i8S/G0Hp3KGKxTx93EhO288hOsgCt8zb3HzQbRLfGEbU/L+O7xKNJLJBvaY=
X-Received: by 2002:a17:90a:d78d:: with SMTP id z13mr21032084pju.228.1630258827400;
 Sun, 29 Aug 2021 10:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210822184927.94673-3-jacopo@jmondi.org> <20210823073639.13688-1-jacopo@jmondi.org>
 <YSNdywXOuzYMCbJa@smile.fi.intel.com> <20210823090610.hr6a7wjhkpyuupxv@uno.localdomain>
 <YSNs8Oo+1oMZ5TJS@smile.fi.intel.com> <20210823101911.4kzsdolwxdrpnyxt@uno.localdomain>
 <CAHp75Vc4gSEn_3=5ixWr4WFyKwXDMMC8SaoBkZNotZ+GP6wMWA@mail.gmail.com> <20210829172113.10f3cd27@jic23-huawei>
In-Reply-To: <20210829172113.10f3cd27@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Aug 2021 20:39:48 +0300
Message-ID: <CAHp75VeReHQvkWriOMbQxeG-DOj56MkujZvOR-T11-K+S5VoHw@mail.gmail.com>
Subject: Re: [PATCH v3.1 2/3] iio: chemical: Add Senseair Sunrise 006-0-007 driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 29, 2021 at 7:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 23 Aug 2021 14:09:21 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 23, 2021 at 1:20 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> > > On Mon, Aug 23, 2021 at 12:40:00PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 23, 2021 at 11:06:10AM +0200, Jacopo Mondi wrote:
> > > > > On Mon, Aug 23, 2021 at 11:35:23AM +0300, Andy Shevchenko wrote:
> > > > > > On Mon, Aug 23, 2021 at 09:36:39AM +0200, Jacopo Mondi wrote:

...

> > > > > > > +       errors = (const unsigned long *)&value;
> > > > > >
> > > > > > Yes, it takes a pointer, but in your case it will oops the kernel quite likely.
> > > > >
> > > > > The usage of a pointer kind of puzzled me in first place, and I found
> > > > > no pattern to copy in the existing code base. I have probbaly not
> > > > > looked hard enough ?
> > > > >
> > > > > >   unsigned long errors;
> > > > > >
> > > > > >   ...
> > > > > >
> > > > > >   errors = value;
> > > > > >   for_each_set_bit(..., &errors, ...)
> > > > >
> > > > > I can do so but, for my education mostly, why do you think it would
> > > > > oops ? '*errors' is a pointer to a variable allocated on the stack as
> > > > > much as 'errors' you suggested is a local stack variable. I might be a
> > > > > bit slow today, but I'm missing the difference. FWIW I tested the
> > > > > function, even if there were no error bits set at the moment I tested, but
> > > > > the for_each_set_bit() macro was indeed run.
> > > >
> > > > Because you theoretically access bytes behind 16-bit. That castings just ugly
> > > > and compiler should warn you about if it is clever enough.
> > >
> > > I don't think there's such a risk as I limit the search space to
> > > ARRAY_SIZE(error_codes), but I agree the cast is ugly and I'll change
> > > to what you suggested
> >
> > More for the sake of education. Actually it's not theoretical. Some
> > architectures may not access longs on unaligned (16-bit) addresses.
> > So, yes, oops is probable.
> > Another example is reading the long to the register. This can cross
> > the page boundary and produce fault (again) oops.
>
> For extra giggles, (and I'm half asleep today so may have this backwards)
> what it the platform is big endian and you do this?  I'm fairly sure it will
> walk the bits from low to high and so the first access will be off the end
> of your shorter type being as it will be at addr + sizeof (long) - 1 bit 7.

Thanks, I forgot to think about this case.
Maybe being half asleep is not a bad thing after all? :-)

> > > > If you found it in the existing code, please, fix it there, so quite bad
> > > > pattern won't spread.
> > >
> > > My point was that I was not able to find any pattern to copy from :)
> > >
> > > > > > > +       for_each_set_bit(i, errors, ARRAY_SIZE(error_codes))
> > > > > > > +               len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);


-- 
With Best Regards,
Andy Shevchenko
