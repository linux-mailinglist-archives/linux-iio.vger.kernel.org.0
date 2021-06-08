Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4268E39F7DD
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhFHNc0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhFHNc0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 09:32:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A6C061574
        for <linux-iio@vger.kernel.org>; Tue,  8 Jun 2021 06:30:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ei4so11920628pjb.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Jun 2021 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbaBmNNNSP5ScQR93PBmptz3s6O4ET0LzqIsfmBoK5s=;
        b=Ngf3wE1Cuzn3TmNDXzeierS1G6HgCYh46CywqV15XAx/k6HHH+hK54aQMF9lwJzo93
         rUAExhUArKd7mvPK2eeGQfoY20bSqx+z6UmtVNqXuV4HBmEVjhVOXyjrX75/dzJa5tLn
         KsAZCUSvtWNo4YqMfX2y4qTNmrEZ3KpQHAEQSck6Kfdq83rrCQAOI/W9xxb9Scw0CA5y
         evxUDLdYOhfZyk1570ecUyS/m/BTkO9hedw0hCemZXfwrjhGwrRkdXfRnGvepRprtF3O
         NbaW0tKVmBPPCAHzLlujIdHeN9EQ8KLlOO1Xiv3Hqvi7wqLTBa3hcr11mmA64QD5wkNN
         GqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbaBmNNNSP5ScQR93PBmptz3s6O4ET0LzqIsfmBoK5s=;
        b=kKL2PkG3xnZLfAY8nZBn9Rwta1uTJmFFkjOGRbRxFh6bzUGei9SN8mGCd7iPvZmJ0Q
         eK39m2wNy//T/K6WMrKbrLSKvAqOKcW96T2h/nH5vTG5pUP3HLJc2Q1UmOc9Ip8vRgos
         54sRVbtn99cUyWMsHT3xVxeEr216zFT7NCMh0hfyFSYPrSQfu+HjpjQE+/2f+9dBTj6N
         lNdyeznhLQdWDI8ZNGRrL3VO4uy0capd0VuoqddXU+iJbIb4CIPanpnGU1ZBWuIR/AP4
         hO4KDEiAAURYrOabRziKhCTJiy3DbeIialhyWOlkwHZA2nJPRfYcM+ayAAmr7A7hEwqV
         I/jQ==
X-Gm-Message-State: AOAM533V0RC0SIeux3hDnOGy8c/4JBVn+yzAgPs4dJfvWWXOU3osEnQw
        DuzqIf5OqEIV348borsO+GCGfnYlZJa/MCMThhI=
X-Google-Smtp-Source: ABdhPJxS9reXNskAE9Jh8yzF1WFGmshcgPK2GHo11zGxwK8lkhlHlH9fUlN1DRpMyMX2r2PK4SiZc/dsJN070jik1co=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr4996969pja.181.1623159032868;
 Tue, 08 Jun 2021 06:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfuoWi72b1wAYoJD_mF6+s-h7k7JCU3CFbEzuGtYBuCZA@mail.gmail.com>
 <eb9f9c75-98c9-0f93-7fd9-565061c78cf0@metafoo.de> <CAHp75VeC=trDNkhYbMpeCOYVRK124HPJNVX=tWmfy1Jh5akOzw@mail.gmail.com>
 <b79edabf-593f-81d3-0954-0557a7f73e57@metafoo.de>
In-Reply-To: <b79edabf-593f-81d3-0954-0557a7f73e57@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Jun 2021 16:30:16 +0300
Message-ID: <CAHp75VfAxduG91vu6uCt5VxN-AHRkZROCtXXo06wS74QnBgDqg@mail.gmail.com>
Subject: Re: atomic use is not atomic?
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 8, 2021 at 4:22 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 6/8/21 3:14 PM, Andy Shevchenko wrote:
> > On Tue, Jun 8, 2021 at 3:44 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >> On 6/8/21 2:35 PM, Andy Shevchenko wrote:
> >>> Hi!
> >>>
> >>> Can anybody explain this code [1] in terms of atomicity?
> >>>
> >>>     if (!atomic_read(&trig->use_count)) {
> >>>       atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> >>>       ...
> >>>     }
> >>>
> >>> AFAIU how atomics are supposed to work the above doesn't do anything
> >>> atomically. I.o.w. use_count may be simple int with the same effect.
> >>>
> >> The operations here do not require atomic access, it is just operating
> >> on a atomic type. The atomic access is the atomic_dec_and_test() in
> >> iio_trigger_notify_done().
> > So, between atomic_read and atomic_set somebody can call
> > atomic_dec_and_test(), for example. Is it a problem to actually lose
> > the value?
> > Why are atomic types being used here when there is no atomicity guaranteed?
>
> We know that if the value is zero that there are no more active
> consumers. Then we set the value to the number of consumers, and then
> launch the consumers, which will decrement the counter once they are done.

So, why atomic type?

I can see various races with this code.

For example, we have two CPUs calling the same function (because it's
hardware driven model)

Imagine that one goes into counter 0 (just after the last notify done)
followed by the atomic_set to something non-zero followed by a
skipping trigger notification. Next time the loop won't be called,
because nobody will reduce atomic to 0, right?
Is it a possible scenario?


-- 
With Best Regards,
Andy Shevchenko
