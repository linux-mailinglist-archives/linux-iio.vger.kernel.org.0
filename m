Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8553A4817
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFKRvW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:51:22 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:35730 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFKRvW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 13:51:22 -0400
Received: by mail-pj1-f41.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso6296232pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OddsHdgvPGEsYxsk6DZpIUCug5SLjvyNe7Qb3Thp78=;
        b=ndcZUWE6RvKYk0bH/2PWTRFLGSI9sQ3ruhh2ftlCeOqzLw77Wl0xtyvaUSXPOvGSQw
         ta7r2/MgWso2XAD1CKFoFNe6rVGXshQEnW4y2+/+twlNa+1mACSSuaE5YTV2R/VdYf+Y
         5xLpTXMCo7aHO3VRYStTioT+4Qa0jonIor+yOkmAxnpZ6Z1gJ6V5mb8m4fG36Bvn1cAl
         VI8AL8Kct4odUFKSOc0MjtppjB1GHarOZd8mLFGqcdrU0apcR0xuuAra78agOXIhOqek
         IjG8BXqRlYXWQDqUXL+4MpUlovQbqWzLLTqyRqpJoyFb8fniKx+S225VZpgri5pHZL2q
         UfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OddsHdgvPGEsYxsk6DZpIUCug5SLjvyNe7Qb3Thp78=;
        b=UG0q1U5HgdF/Y+xJfqsGwz0i0sXbChNxlOxR0cxkbWpYAjowTQAeYNfXe6ZDmtVd4x
         RrwRY4UG+2PxEpZSGDwILN6NjJXT88ggRFVGiT28RHG2UaT+XpKXQWvNpn7gKrGkUzkV
         FxS/B+661fDXa3qv5BLCwnwvTLEFVJBjHWu17kliycS9ohA3MwfrSPpPT7nzRn319PSH
         GRc/0ehk/TXlenrwuG7ECf3ydcjYMH9OrMjlwIViC2RZ314kq01uWTpMseoTHDyt++G5
         2Kt8QF7WuO+2kG2mCjsyGM26KK1Ewmb9C26nEShd+kEtIR12jYSvEJ/qht+V9ce6PvjU
         vvFA==
X-Gm-Message-State: AOAM530MDdmRqYGo01WF+rLWV/nAgDxGJQCvup+s1okWcWqlvY4awYR2
        oi42B/pdFSxauZj7GFVZQfXptQMDyJFTN6wjf7Y=
X-Google-Smtp-Source: ABdhPJwLSDSVEmISWB5DAb3bxzUaeUHq0nUCCpParH0a5C2jEiNMT50kOtwH4rdunA2ytKRIEQwcL9KycOKi2mH20Yo=
X-Received: by 2002:a17:902:b190:b029:105:cb55:3a7a with SMTP id
 s16-20020a170902b190b0290105cb553a7amr4947090plr.17.1623433704038; Fri, 11
 Jun 2021 10:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210611171355.202903-1-jic23@kernel.org>
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 20:48:08 +0300
Message-ID: <CAHp75VdXBQ6FryYrizD=Aw1PPWpLw=2wE-z3vyvwT1A7Ks-Rsw@mail.gmail.com>
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

On Fri, Jun 11, 2021 at 8:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> 0-day recently started running the include-what-you-use checker with LLVM builds.
> After it identified a header we should have dropped in a particular patch,
> I decided to experiment with it a little and see if it was useful for tidying
> up includes that have gotten rather out of sync with the code over the years.
>
> Note the tool is something I'd only advocate using to give you hints on what
> might want adjusting so each of these was done by hand inspection.
>
> I've grouped them by manufacturer as otherwise we would have a lot of patches.
> Note that the big 'many device / device type' drivers have been done separately
> so you won't see them in this series.
>
> I'm rather hoping this approach may ease getting reviews of these, but we
> shall see.  If people have time to look at ones I haven't directly cc'd them
> on that would be great. There are some drivers touched in here where I don't
> know of a current maintainer.

Same comment as per staging series.

I know that kernel.h provides some crucial everywhere used macros /
helpers which are in the TODO list to be split.

I would recommend dropping kernel.h from the drivers and see what's missed.

These series probably need to be based on splitting out container_of()
and ARRAY_SIZE() first.

So, no tag from me for now (but I like the idea in general, and thanks
for looking into this).

-- 
With Best Regards,
Andy Shevchenko
