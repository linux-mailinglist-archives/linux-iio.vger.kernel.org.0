Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC7C359902
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhDIJU1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIJU1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 05:20:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED66AC061761
        for <linux-iio@vger.kernel.org>; Fri,  9 Apr 2021 02:20:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bg21so2613866pjb.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Apr 2021 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzjlnOnw44FWBMM8EDOSpIxkRee5ET556dyL93pZo3g=;
        b=HwvlCBJ00hIoXL5OYz5uGAkKjbq5z2sy3z6kUwdfj5wsBZu72oZAlDZrp2+5d8oNmm
         6NgyIGV73JiXSZpqq1VAWx6xSZBtwlyYSkkC7i8cCwjB29tDhU22PhLV4VYgGfu4wDNX
         gd7RCgupbf2XFrljwoQ92+L1H/AcYeGMtxfDMXspCWSqfslPunbchyRKZRTYYGwQKhaF
         bNDvqQXxWRxIc4HFRTJm432p2FzGiRZhyoKOdsUhkziFiCjY68OUEe+b0sG8KT2fgBA7
         KsOF2LgJ7IGmPI9lYhG8KNsu1sAWsRWdY+c7HS/qb8SJFKCegybrRN8QXDgWXwr4CG7Z
         uhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzjlnOnw44FWBMM8EDOSpIxkRee5ET556dyL93pZo3g=;
        b=dk2qgVHe1ag1HT+6qEGNgNOtuvSmzqM5KfBgEYtbKf0JlcQeTxXaHbfFxQ3JHM3+L9
         kX8C34ZmLfRhXrhLewn/xzug0ldeL9IaU5lNwFH16t2gHefOH4OCdoMJr8F0GI+b82yN
         CpsqiMewArvuh/ASbH3IjfH+9dRnRitbRdeqdi3hyfkBcqtwDARW2f5EICVrp7EXBvRB
         sTuWrzWD2yhzJRf8mjlKDkOLimVP63KVLaKnWjxANr4gRHnx97C61WVhXS+8bXHfvalV
         +BMOkCx8YJZSngXqgcgUQhUFvgDRspIYoIQBGTRpCSgjIpsur2167R17yz+8cqPaFtO+
         UOiw==
X-Gm-Message-State: AOAM531LZXJGBUOQ3YMr36ZLnp0tHOjSAop5IPJDxds0ZeP1yLtI0PIc
        Qsxoh+ddkfBmId3ZwNRaAyJ/YEvwNllgR/rjrkc=
X-Google-Smtp-Source: ABdhPJzLpY7ZjD3m0Ns8DL1lyEkKLHnLyOOEy2DTLXBoXd1U7buiEnoBuA3T72fcoFkLUutFJl50wPYo8RjWkr/Y7GE=
X-Received: by 2002:a17:90a:5407:: with SMTP id z7mr13266664pjh.228.1617960012284;
 Fri, 09 Apr 2021 02:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
 <1617881896-3164-6-git-send-email-yangyicong@hisilicon.com>
 <CA+U=DspZCGVjFxB0YH7OAPBKhFAKz=a9Q=O7xW-Xu4BPZKC=pA@mail.gmail.com> <9f1257a2-a69e-acbc-8c0a-2d2157274225@hisilicon.com>
In-Reply-To: <9f1257a2-a69e-acbc-8c0a-2d2157274225@hisilicon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Apr 2021 12:19:56 +0300
Message-ID: <CAHp75Ve_JwGeruZeZnVk3pXXmETVERQTdR2+MSPX=Y75+nQLcw@mail.gmail.com>
Subject: Re: [PATCH 5/7] iio: core: simplify some devm functions
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        prime.zeng@huawei.com, Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 9, 2021 at 10:22 AM Yicong Yang <yangyicong@hisilicon.com> wrote:
> On 2021/4/8 21:09, Alexandru Ardelean wrote:
> > On Thu, Apr 8, 2021 at 2:41 PM Yicong Yang <yangyicong@hisilicon.com> wrote:

...

> >> -       if (!ptr)
> >> -               return NULL;

> >> +       if (!iio_dev)
> >> +               return iio_dev;
> >
> > This is correct.
> > But the preference is usually:
> >         if (!iio_dev)
> >             return NULL;
> >
>
> since it returned iio_dev when failure before, so i just keep as is

Actually Alexandru has a good point. Compare the pieces I left above.

-- 
With Best Regards,
Andy Shevchenko
