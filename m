Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3C42AB65
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhJLSBo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 14:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhJLSBl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 14:01:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67274C061570;
        Tue, 12 Oct 2021 10:59:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p13so2934268edw.0;
        Tue, 12 Oct 2021 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hS9qJ9AatfdQFF4mk+ZRgzUfmFxTo6yE/0hIoMmMRzs=;
        b=MeHSkvx7mBGmHzavi3U1hFUnT0W29ZtBzuqEiAkmVWGXZrBusUUeNQUUofibKIU0bp
         MfcvACNnoGVKv5Or1TMmCzk6YZYjluCgy0fJc0vYJEbBb7EhhcQhzkzLhaI6JB2SKZ8A
         rc3wQ9k8YrsVT5a3tfSOSiaqlBcU4gT/oZRtOhrDysBsacaStD9eSICGC16vfk5Mr+6T
         PHbhq2YRjbRv6K0VV6JGBcZcEVZ6bl5zzmrVHH4nSJH2RQFzTRPekIFbURmYMyIVpYDc
         Qt42Q/tqUFWEhxqil4bCaUjdvWO+4ClhIa5X/BF2VqU2kk1CRtesCYh7NCg0IYh9anpQ
         kQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hS9qJ9AatfdQFF4mk+ZRgzUfmFxTo6yE/0hIoMmMRzs=;
        b=YQPNQvkL9l9dWsSfC0pUYUGjpBlVeyCISbqEBA3Zo/uUtWVw1b5dB9PTPi3ZICnAp3
         rteQewWtbU4vIijQaZ04Hl9QZglCHjxxJYYEgnTpwQhgqP1OPAOI3f2tauSpMVAD7nfR
         NG3zF0oFb6J6zsHKc9RTofpoX4QYh/R3oOFjENbV1WDWrfgQJvP9BOJGkLIHK1JjPfLY
         KEbv4aY+u9wAV6PivfWlmrzovyuAEYosX5Nrdw/JmWmNCwwBq48y2BJik7hGpE04EBV7
         +4HEWRcFq0CkJGopGv/OmplmoImp4Qpy/E4bHHzL7qmLv7PFY+/O/Q8zAiI8Ju4zN1E2
         BjuQ==
X-Gm-Message-State: AOAM531jj3maLUbtsbu74h3a42DQe5Y2vx/T0jNHbHMBXMBnwpQLfed9
        BPhWwovDVOC5m4GGPwXHwdVZ/rDA3jPqBfN1q20eAZ+UvsIeUqdU
X-Google-Smtp-Source: ABdhPJw06os74rPCOxcLsZ5/hWcLvpc6Occ2K4ALoJrx80qHW9GAstffak23oyIWp0YCx0yvabsfU50sUsnwS6Wuvp8=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr35429987ejc.69.1634061578020;
 Tue, 12 Oct 2021 10:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
 <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
 <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
 <61c28865036cd40a96f2d1bb4c27fbbb08c2d3a5.camel@perches.com>
 <CAHp75VfBXuMboFr6czRipXKfBpBNj8Syo9cvhiMXD7VaVaka+Q@mail.gmail.com> <fe8a022750e911159abcac979bada51940c03d72.camel@perches.com>
In-Reply-To: <fe8a022750e911159abcac979bada51940c03d72.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Oct 2021 23:58:50 +0300
Message-ID: <CAHp75Vdx1=q=5sNkn9o=mqnufxYiXnssmMJtXw9goFskGijc1w@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
To:     Joe Perches <joe@perches.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 12, 2021 at 8:55 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2021-10-12 at 23:48 +0300, Andy Shevchenko wrote:
> > On Tue, Oct 12, 2021 at 8:43 PM Joe Perches <joe@perches.com> wrote:
> > > On Tue, 2021-10-12 at 23:30 +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 12, 2021 at 2:37 PM Alexandru Ardelean
> > > > <ardeleanalex@gmail.com> wrote:
> > > > > On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
> > > > > <yangyingliang@huawei.com> wrote:

...

> > > > I prefer to see
> > > >
> > > > - for (; unwind_idx >= 0; unwind_idx--) {
> > > > + while (unwind_idx--)
> > >
> > > Not the same code as unwind_idx would be decremented before entering
> > > the code block.
> >
> > It's kinda cryptic what you are pointing out.
>
> Not really,

It's. It lacks the very same "additional" words to explain what you
meant and why.

> > What's needed additionally is to change
> >
> > - unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
> > + unwind_idx = i;
>
> You left out that 'additional change' above from your reply.

Yes, that's true, but it took some time to decrypt your message.

> > Of course not. See above. The usual pattern is
> >
> >   while (i--)
> >     do_clean_item(i);
>
> Of course, but that's not what you replied.
> I was merely pointing out that your reply included a logic change
> converting a loop from for to while.

I expect that developers actually think about the changes they do and
double check what's proposed by reviewers. If they just copy'n'paste
whatever others propose, I wouldn't take any patch from such a
developer.

-- 
With Best Regards,
Andy Shevchenko
