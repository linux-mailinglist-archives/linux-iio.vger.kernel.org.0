Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960123A48BE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFKSiW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:38:22 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37710 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFKSiV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 14:38:21 -0400
Received: by mail-pf1-f169.google.com with SMTP id y15so5140989pfl.4
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUJ/xZBWi0+o7KXMJRxhVHE2e0Kp2d40e+j1QkoMD9g=;
        b=G7uZSSfrA8wQ7E0AwR8amZVJDx6iDbGbEMBHkOEYazk38cxpEWX+L+c+Mgogg9vait
         VVKUFtuCDcJOPw5v6LoKl1gMDDB82rn0P/FUcTZ/wPz5U8gYfHZp+693gf+RhZfzGK/t
         fTZnwJfgOFcjtaYCP2ELWIhXpSNwFoei5AOaf5bDePcrlzQVBjowjMVYSicRZcKkWTOF
         wFYpQP25cimlj1zXIBcLhPicOyDXA6SxTFNmVXRia0EmIHQPADysFVb3KT19dcEZtiwi
         ILkQSVMBdv+qpb8lDOEJMWhj5Jw3hrs0k0/mZtBJ1xpkbwv584wxG/r4Iyw0hiWwd1FX
         emMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUJ/xZBWi0+o7KXMJRxhVHE2e0Kp2d40e+j1QkoMD9g=;
        b=YuUtNTIMKIJifLtrzXGOonALKZfO/OQvjGx4otT1A39ICT7rEfWHxzJu4ZbTYHkAJF
         ToAH2l9DgFZsYpR+4JAtIt4Klk3sgUrmJDtlBh3tzB80hljFO69zVsdTiwNcipsQv4F2
         ARwZBipjyJINIc2KmsWnJARH+tX0p77s7qlRTiq6f4cH05Cc6INP5RjpSQOValg/soh9
         5PmYQtUy4vY90z1WrBEeQAqqWZ0o4THx27E1rOYc3R3DB2A3KCZCLit4kD1OXzAozLE/
         9pwxU3yhXs2PMyvrZWucpxnUh9wSyRyHIAnjlCjEogkAdXGl1qq1WLw5JeZk7g+f3IAF
         p6UQ==
X-Gm-Message-State: AOAM531hTMP+WhqN/niTqunVKZ1RnyW7E7UbT4wMqCOVFiknSA2ac68x
        z4+YvF3e6G6H3aGKyswXN6FriaViedN1Btdz/srmsSsmmeY=
X-Google-Smtp-Source: ABdhPJye/tyA93T3ZSc+gzhuQqmsbU6p/5til/xgVhY1Q8QycqsRaB+VGNeXmaY3nb394oEmQB1QQ60j9ldTkGfV4Fc=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr9655914pfh.73.1623436523497; Fri, 11
 Jun 2021 11:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210611171355.202903-1-jic23@kernel.org> <CAHp75VdXBQ6FryYrizD=Aw1PPWpLw=2wE-z3vyvwT1A7Ks-Rsw@mail.gmail.com>
 <20210611192303.755392d1@jic23-huawei>
In-Reply-To: <20210611192303.755392d1@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 21:35:06 +0300
Message-ID: <CAHp75Vf4DkjGPyneWbOqY-8SC=iSn2V1C3-Vm-batF8wCq=eCw@mail.gmail.com>
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

On Fri, Jun 11, 2021 at 9:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 11 Jun 2021 20:48:08 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Fri, Jun 11, 2021 at 8:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > 0-day recently started running the include-what-you-use checker with LLVM builds.
> > > After it identified a header we should have dropped in a particular patch,
> > > I decided to experiment with it a little and see if it was useful for tidying
> > > up includes that have gotten rather out of sync with the code over the years.
> > >
> > > Note the tool is something I'd only advocate using to give you hints on what
> > > might want adjusting so each of these was done by hand inspection.
> > >
> > > I've grouped them by manufacturer as otherwise we would have a lot of patches.
> > > Note that the big 'many device / device type' drivers have been done separately
> > > so you won't see them in this series.
> > >
> > > I'm rather hoping this approach may ease getting reviews of these, but we
> > > shall see.  If people have time to look at ones I haven't directly cc'd them
> > > on that would be great. There are some drivers touched in here where I don't
> > > know of a current maintainer.
> >
> > Same comment as per staging series.
> >
> > I know that kernel.h provides some crucial everywhere used macros /
> > helpers which are in the TODO list to be split.
> >
> > I would recommend dropping kernel.h from the drivers and see what's missed.
> >
> > These series probably need to be based on splitting out container_of()
> > and ARRAY_SIZE() first.
>
> Tool obligingly tells me at least one item from kernel.h and you have
> the correct pair (occasionally it's the kernel specific string routines).
> e.g.
>  #include "linux/kernel.h"                         // for kstrtouint, ARRAY_SIZE

Oh yes, kstrtox.h should be born (I have even somewhere in my tree the
preliminary split).

> > So, no tag from me for now (but I like the idea in general, and thanks
> > for looking into this).
> >
>
> The tool is rather a blunderbuss for this job which makes it rather time
> consuming to use.
>
> Splitting kernel.h up is a step beyond where I'm interested in going
> at this stage because it's sure to involve a lot of bike shedding.

Not really. There is a kind of consensus about the mentioned
container_of() and ARRAY_SIZE() and similar to be split out from
kernel.h.

But I understand you and not insisting that you have to go with it. My
point is that...

> I 'could' just drop the kernel.h where added on the basis we were clearly
> getting it indirectly. I've not included a whole bunch of other suggestions
> on that basis.

(Which is probably not a good idea, because explicit in this case is
better than implicit, i.e. kernel.h is not guaranteed to be included
by other headers and I have long standing work to actually make sure
that most of the headers won't require kernel.h!)

> Note I didn't include a whole bunch of other headers on the basis
> they were a bit more esoteric.
>
> To give an idea of how noisy this is here's the output another file...

...the tool simply doesn't know anything about kernel and header
guarantees. That's why it tries play dumb.

If you would like to continue with this, please drop the removal of
the headers that are not guaranteed to be included by others
(excluding kernel.h from the equation). Otherwise it will become
someone else's problem to _reinstantiate_ all those headers, and since
I already had a headache with panic.h, I won't repeat it. Still no tag
from me, although no explicit NAK (actually opposite, no explicit ACK
because of the dependencies), you just really need to spend more time
on this.

-- 
With Best Regards,
Andy Shevchenko
