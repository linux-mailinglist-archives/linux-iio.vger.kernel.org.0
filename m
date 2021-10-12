Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F142AB1A
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 19:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhJLRvi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLRvh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 13:51:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E9C061570;
        Tue, 12 Oct 2021 10:49:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p13so2830187edw.0;
        Tue, 12 Oct 2021 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11bwNe2+F48KthW6TCzMCLhbY7ty428AnAz5bOQsr34=;
        b=oSNloqaM6CESIFbiqQWkAHdLvqg1CDTN46iitH5sWC+tW0qBFRetcQXr4gtK6a9G3v
         WFOk0gE7PVv4tQOlNw/F0uZofjFTJvdmRSWoLW1xq1aYUlT6Y7qSJf1Op6VFwQewU+m8
         YYKGSi7r8BstULxp6iansr+DUBhmMJx/nf6cJry48EwBxat+76hN6LYLqeT5bfSqnN95
         zGaBZNhBnFjuSLa6za1lEcX2/FAxigcxqYWvzjSFEXJbW+TelJj/tg/pOEoIqQ+49/vf
         KM7XGOJw8d+TxN7SgTl7lrvQNUXqoz0kCS7GyJ7elX767qbcwzi5BPqZLm34hEyzqkbW
         3Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11bwNe2+F48KthW6TCzMCLhbY7ty428AnAz5bOQsr34=;
        b=Ezru54kVpQmOOKuyC0M2YI1SIW5R0FHV5evGkuG/xsyaBk+g8KHbGwERNYrEBcXBpA
         cmdFnYoA9RU/XcvzYhkNb48mTQ+yXKlXQUESbgPQfcXIK92vBAJ6ypcVf/LEGVm5DFrV
         sXw4U0hcRIA+my6Paf4IKPuhEu8b79gLkerBYod185DoHumHiQBVt8sUuaEV481Al4qO
         XfFNsQQuUnbktyggLmv4PGWhhBhyc7lLy1P8rvs40Yo8aT84H/21SrIymm+GRTS7AEzG
         WzGmcjs9Rd3UVj2EB9urWnqZpfZDKycmXkRrQB/0g5ANiS6Z7w5PV4wb/EGmEQBl1Py8
         bVjA==
X-Gm-Message-State: AOAM530FFDaKOoDEspO5nb0Gsuc7SJ6eVkye+jT+nkIIRcny3g63PU2b
        X0ctlfjZb6yxCPzxQ2toDz5gSlaYpKb5+NRbBr4=
X-Google-Smtp-Source: ABdhPJwn29IO3PbqjZY1xNMc0eLVUZRDvmMTwIuaipgdjA0QWxJMdEmfMTvkqQwUtyt/mAOoFXJapR7Ex21pm2pX6s4=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr1580110edu.283.1634060974214;
 Tue, 12 Oct 2021 10:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
 <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
 <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com> <61c28865036cd40a96f2d1bb4c27fbbb08c2d3a5.camel@perches.com>
In-Reply-To: <61c28865036cd40a96f2d1bb4c27fbbb08c2d3a5.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Oct 2021 23:48:46 +0300
Message-ID: <CAHp75VfBXuMboFr6czRipXKfBpBNj8Syo9cvhiMXD7VaVaka+Q@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 8:43 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2021-10-12 at 23:30 +0300, Andy Shevchenko wrote:
> > On Tue, Oct 12, 2021 at 2:37 PM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
> > > <yangyingliang@huawei.com> wrote:
> > > >
> > > > When __iio_buffer_alloc_sysfs_and_mask() failed, 'unwind_idx' should be
> > > > set to 'i - 1' to prevent double-free when cleanup resources.
> []
> >
> > I prefer to see
> >
> > - for (; unwind_idx >= 0; unwind_idx--) {
> > + while (unwind_idx--)
>
> Not the same code as unwind_idx would be decremented before entering
> the code block.

It's kinda cryptic what you are pointing out.

What's needed additionally is to change

- unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
+ unwind_idx = i;

> You'd want
>
>         do {
>                 ...
>         } while (unwind_idx--);

Of course not. See above. The usual pattern is

  while (i--)
    do_clean_item(i);

-- 
With Best Regards,
Andy Shevchenko
