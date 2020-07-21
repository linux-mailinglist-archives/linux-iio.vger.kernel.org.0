Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7C228B7E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 23:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGUVjC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 17:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUVjC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 17:39:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F67C061794;
        Tue, 21 Jul 2020 14:39:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so69838pfq.11;
        Tue, 21 Jul 2020 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTa9gHmHdwoQlE0jFaU2QAa0YDNX3n5xs41Oq1h/lv8=;
        b=NFBZKESfiEADDZtL3mGSlNZ/9o8r/icpo8YA+uJCvQx40O4u09JUlxrlAs3H40b4ZI
         0UwLgxddoz1LMQrJ1cSs9lyuzFdJA1LkWHVmq0lqfE7tKOm5G56bQQrV5UKOtiZQRDgC
         7IHwvyJKECMrgarLxS8zsBN9EdX0s4hxcOC3XGspNdY0s0IxW0E9LbNS0b5buvfvP/vu
         gJN3g6DxyTSSRt4vt0dc2Ol4lZltACCu0l3u5e4wogDnAa1QbsYsMp7Bjy6FctEulA2Z
         5XKHJhLMfwBSuTGGQhq2DiFXgyOoo/sQi03aRUksX0ouQKhjRs69QybSEZNXKTxYOWIg
         oWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTa9gHmHdwoQlE0jFaU2QAa0YDNX3n5xs41Oq1h/lv8=;
        b=pRkr1aYpkYEHMdmHLNsu98S6ecVMlpfbgjvsnV6Y25grvoApama5oqhrs85dAmsafI
         TEukPsjx0AATl4WkjASTzLKvE4ASVbKIhH7DO8cWBZzJm4v/rDeXNCOSyly+67bLP/NY
         mTDBbc0AJrmbiIDidj+1LvNOlVoPTutI0f81BfU0yRqR7d8NiXn1Dp5C6+7fZkWASma4
         LSNfG3UhNht9f+ayIBlraJDcwEkv09vik9jH/Aus6n6E3y8DihFwxLgUAI48a4YMArmH
         4uvP5Y1NtZUUEtBK/un7ROKho4zL3Q8uydDsMEpbVfFkJHZc93t7FN8ThVm4If3/26eo
         dAcg==
X-Gm-Message-State: AOAM533JPrdpH2ttRDODnsVl8Zqefk7cq/WjzZFdBD+8RM37RjKd0fCP
        JpxkMe4jrklE/FkPLQmHfPI2kjsT+ZpiCn+EUzY=
X-Google-Smtp-Source: ABdhPJyZBHccCkU23ZzLV8rF6CFIwdzvW4rOxOwpZ53G3KqFEBSv3HjjJICz4l7kO9kcK3XQMDnNRoPvW8yaE8biFmA=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr23471942pgn.4.1595367541025;
 Tue, 21 Jul 2020 14:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200721181926.27046-1-nish.malpani25@gmail.com>
 <CAHp75Vdr+Uo2uw3mzYP+LMRgp-eyi+YjG=O+wGVqyYx-+MRCaw@mail.gmail.com> <7ba8469a-dd8c-1686-6d26-e2a4cbfedce9@gmail.com>
In-Reply-To: <7ba8469a-dd8c-1686-6d26-e2a4cbfedce9@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 00:38:44 +0300
Message-ID: <CAHp75VdYVC9n7-2MH62J46N0p+sNSE9QVwonor5QfdnvL4hoLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: gyro: Add driver support for ADXRS290
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 11:35 PM Nishant Malpani
<nish.malpani25@gmail.com> wrote:
> On 22/07/20 1:16 am, Andy Shevchenko wrote:
> > On Tue, Jul 21, 2020 at 9:20 PM Nishant Malpani
> > <nish.malpani25@gmail.com> wrote:

...

> >> +               *vals = (const int *)adxrs290_lpf_3db_freq_tbl;
> >
> > Why casting?
> >
> adxrs290_lpf_3db_freq_tbl is of type (int *)[2], right? Without the
> casting, an incompatible-pointer-type error is thrown.
>
> > ...
> >
> >> +               *vals = (const int *)adxrs290_hpf_3db_freq_tbl;
> >
> > Ditto.
> >
> See above comment.

Can't you declare table as const int?

...

> >> +       /* max transition time to measurement mode */
> >> +       msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);
> >
> > I'm not sure what the point of interruptible variant here?
> >
> I referred Documentation/timers/timers-howto.rst for this.
> My reasoning was shaped to use the interruptible variant because the
> transition settles in a time *less than* 100ms and since 100ms is quite
> a huge time to sleep, it should be interrupted in case a signal arrives.

This is probe of the device,
What are the expectations here?

-- 
With Best Regards,
Andy Shevchenko
