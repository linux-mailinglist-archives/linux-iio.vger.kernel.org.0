Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4003A497B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 21:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFKTjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 15:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKTjY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 15:39:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C5C061574
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 12:37:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 69so3336652plc.5
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ubhhqaZh5PyOIZ1mVEqUbjrrypqVHIa7lr604MY/XA=;
        b=IlUmf/57bEDs3ALVORmkV4aqYnVxAGCELMuSL4QLqmaM+K3wH9LUE16OgwkegCuHIe
         yWcrw/fEEnAFa6o9+Z2PMgDExfDsjBjULM+duCavFOnytIrHuMEL4bqysw0RJu9lQNaf
         ufRJZEeqMfZFyBWBDVBiDQb4T5PePve4JnkxzRB6bRIRyJ6DXG6OCTJ9A84CI7wG4u+N
         dv2YFMmHAvFuFeBdfFf93iZhnTeFunJDBPRJsMlNvB6W2tzRLPUgz0TCatFo7S26XaLz
         4UdIhuiIQ3KGz9IYR57rEMnzKE00jRrTXlZWsat/eUwGnJZAMIV8NWmH2qH9fl/jMO9X
         Yptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ubhhqaZh5PyOIZ1mVEqUbjrrypqVHIa7lr604MY/XA=;
        b=bGWMmHmytJbXVkNB6Q+Qy0W79gMpHxnMRZlBtbmGuu/85KYEQFTJvu79LyetnSbkgw
         LYdvXkjocdn6Qebzf8ajPXe45YxMyu7FZBLdL8qFqh9oPTVCb6E3OjUl5+Mqxw8wvKzE
         5HhHkVifsidlvOAaiZbUR7pcyjBxoWb5qo8mV/o79wdWD2SPUWVDBo134jI+JPH7vyoh
         GEvwkGJvtnRZr0h+TjB7M4paAsqRFq89OgbhfdaWhsGbvhy82kdpBlMEpBVlguzy6qhh
         N1J/apw0gdTF1vC/+U2W9CUsESr2bQXJ4LP8aAeJq3m7y1TgCjWG6BreCTdj53geFFsk
         mI2A==
X-Gm-Message-State: AOAM532SCYDj1zoDct2VMhVpznEDl9axmyPH3cgdXPxgpgn9F44G2lXh
        piH0gk/chjkuIXdguydf6mgTvv2OAfRP4PISCV4=
X-Google-Smtp-Source: ABdhPJwAul8dbI2bPJ3dykLSAQZZiDKLdWZ3BT6JIjoPRq9PKgo2EyyKkBPDi7PntM1URuV0+uPwBmQoRirQI5OzXRc=
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr10735051pjw.129.1623440228315;
 Fri, 11 Jun 2021 12:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210611171355.202903-1-jic23@kernel.org> <CAHp75VdXBQ6FryYrizD=Aw1PPWpLw=2wE-z3vyvwT1A7Ks-Rsw@mail.gmail.com>
 <20210611192303.755392d1@jic23-huawei> <CAHp75Vf4DkjGPyneWbOqY-8SC=iSn2V1C3-Vm-batF8wCq=eCw@mail.gmail.com>
 <20210611201903.751cdaf0@jic23-huawei>
In-Reply-To: <20210611201903.751cdaf0@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 22:36:52 +0300
Message-ID: <CAHp75Vfs0GdijtzU=Akw6Am1Cp2fO1=46kt0awBOWVeCAAK=nA@mail.gmail.com>
Subject: Re: [PATCH 00/12] iio:accel: Header Cleanups.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Harinath Nampally <harinath922@gmail.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 10:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 11 Jun 2021 21:35:06 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jun 11, 2021 at 9:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Fri, 11 Jun 2021 20:48:08 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > But I understand you and not insisting that you have to go with it. My
> > point is that...
> >
> > > I 'could' just drop the kernel.h where added on the basis we were clearly
> > > getting it indirectly. I've not included a whole bunch of other suggestions
> > > on that basis.
> >
> > (Which is probably not a good idea, because explicit in this case is
> > better than implicit, i.e. kernel.h is not guaranteed to be included
> > by other headers and I have long standing work to actually make sure
> > that most of the headers won't require kernel.h!)
>
> I think I was unclear, what I was proposing was not to touch includes of
> kernel.h at all. So not make anything worse, but also not make it any better.
> Where added in this set, kernel.h was for things directly in kernel.h,
> not the files it includes.

Ah, that's good! That was my main point of worry.

> > > Note I didn't include a whole bunch of other headers on the basis
> > > they were a bit more esoteric.
> > >
> > > To give an idea of how noisy this is here's the output another file...
> >
> > ...the tool simply doesn't know anything about kernel and header
> > guarantees. That's why it tries play dumb.
> >
> > If you would like to continue with this, please drop the removal of
> > the headers that are not guaranteed to be included by others
> > (excluding kernel.h from the equation).
>
> This is where the confusion lies... I haven't done that (subject to bugs
> of course)
>
> > Otherwise it will become
> > someone else's problem to _reinstantiate_ all those headers, and since
> > I already had a headache with panic.h, I won't repeat it. Still no tag
> > from me, although no explicit NAK (actually opposite, no explicit ACK
> > because of the dependencies), you just really need to spend more time
> > on this.
>
> I've not removed any headers on the basis they were guaranteed to be
> included by others. The tool assumes the opposite model - everything
> should be explicitly included directly in the file where it's used.
> For some files it lists 50+ headers.
> These patches are very conservative on that front.
>
> What I haven't done is included everything under the sun that wasn't
> already included.  e.g. I've not included
> linux/device/driver.h on the basis it is definitely included by
> linux/device.h and that seems very unlikely to change.
>
> There are some corner cases that are more interesting - such as whether
> we can rely on interrupt.h always including irqreturn.h.  Plenty of IIO
> drivers don't call anything in interrupt.h because of various wrappers but
> do use the return values. So in this case we could switch many of them
> to the more specific header, but I haven't done that yet.

I guess you may consider a guarantee there.

Actually what kernel header mess misses right now is the list of those
guarantees.

But you see there cases like

using dev_err() and struct device * in the same C file, what do you include?

Temptation is to go with device.h, but I would go with

#include <linux/dev_printk.h>

struct device;

Not sure if that tool can handle this kind of use.

> So, in short, the headers for which includes are removed in this series are
> not used at all in the files in question (unless I messed up of course!).

Cool! So, let bots and other people have more time on eyeballing this.
Will see how it goes.

-- 
With Best Regards,
Andy Shevchenko
