Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E642BB8C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhJMJbF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbhJMJbE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 05:31:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4814C061714;
        Wed, 13 Oct 2021 02:29:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so7497049edt.7;
        Wed, 13 Oct 2021 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dMbP0xPNMCvpEaUY/4vh8kRyTAXiYO7rdt5PxP5MSk=;
        b=k2c/B/pWuaCErxpybv+Z0F89u4ao68vQPUXx4RNine1YegMf4YEvDIdfoMouC900Ia
         ZsIKRmF3RL/EOTLhY1yfRaIzGVxyCdd2g7XvKBIbZcWSCuj3JhHapDLLKTOUEei1kFVi
         LFmClhYqgugHVxbcb/p+plO4C1RnB6ASNDSSvBcMxWSySaNZjiU7YJ/vS3tknmhsBRIO
         wvV0UwLJYVkT8MhytaBueN4l9q/71VjUZB8YtNYhikmDOsAKB+ViOVutwOFJ4gYFYVlo
         11a0fZtJFTxUCu4bIKyl3i76ODEYH/M56YkoCirXrFdElK/Lw+moi7s8ap7Waa6BzodF
         U7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dMbP0xPNMCvpEaUY/4vh8kRyTAXiYO7rdt5PxP5MSk=;
        b=EE/xRmHdgcv6hv81/d+UnnklfBSeMFW8PhSX+PtsFz6z4cU1ljTTPvsLS7w2MBkV/R
         hw/Xr0ATzjC/9s3hPq3Bz4FEyA1q1zHvHnRD4Uxt7wmU5ccf/xUFMgleLa8kONmBEX7G
         UI3VSu6o2th/dA74Hx34iEYkNImpaUC/6SDDof8DIkaPqN8D9RLRISTeF8jmxUoYVdRf
         FB0c5NHYdyKewfmLykkDcOZ2ZvLV5wkRYXeu16v4GW+tBvaTg/mmGazNrhzukVJQth6y
         eqVbId7vlPSVrx+d7AgmfuM5mHurz7H5aGqLzZoqfOaHytNxDADY1zO8Xo4YJFFhaP7L
         lvNg==
X-Gm-Message-State: AOAM530HfBDoh+pc1NgYnFYAPc9Jaqtk7vS7QPsOwaG14rQVrdngYGfg
        39/Z8S4asw18nX+d+lumu8iyrXJPOfxY0iXH+XY=
X-Google-Smtp-Source: ABdhPJyaMIVNuw3tZME99QJywyosrjmqfDvQ2/M3IaIPIkPkWc7agXA2Ol9fGek6uvnyOFGVwJzMGDrS7Imp7TSX0Y4=
X-Received: by 2002:a17:906:1707:: with SMTP id c7mr37678150eje.377.1634117340330;
 Wed, 13 Oct 2021 02:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
 <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
 <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
 <61c28865036cd40a96f2d1bb4c27fbbb08c2d3a5.camel@perches.com>
 <CAHp75VfBXuMboFr6czRipXKfBpBNj8Syo9cvhiMXD7VaVaka+Q@mail.gmail.com>
 <fe8a022750e911159abcac979bada51940c03d72.camel@perches.com>
 <CAHp75Vdx1=q=5sNkn9o=mqnufxYiXnssmMJtXw9goFskGijc1w@mail.gmail.com> <04c752b5-3814-34d0-82e4-9d0d46af433f@huawei.com>
In-Reply-To: <04c752b5-3814-34d0-82e4-9d0d46af433f@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Oct 2021 12:28:24 +0300
Message-ID: <CAHp75VeoOj0bvGBO3PaMMD4sQTRF=rpxxLQXKeyFucpvofbV1w@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix double-free in iio_buffers_alloc_sysfs_and_mask()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 13, 2021 at 12:17 PM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> On 2021/10/13 4:58, Andy Shevchenko wrote:
> > On Tue, Oct 12, 2021 at 8:55 PM Joe Perches <joe@perches.com> wrote:
> >> On Tue, 2021-10-12 at 23:48 +0300, Andy Shevchenko wrote:
> >>> On Tue, Oct 12, 2021 at 8:43 PM Joe Perches <joe@perches.com> wrote:
> >>>> On Tue, 2021-10-12 at 23:30 +0300, Andy Shevchenko wrote:
> >>>>> On Tue, Oct 12, 2021 at 2:37 PM Alexandru Ardelean
> >>>>> <ardeleanalex@gmail.com> wrote:
> >>>>>> On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
> >>>>>> <yangyingliang@huawei.com> wrote:
> > ...
> >
> >>>>> I prefer to see
> >>>>>
> >>>>> - for (; unwind_idx >= 0; unwind_idx--) {
> >>>>> + while (unwind_idx--)
> >>>> Not the same code as unwind_idx would be decremented before entering
> >>>> the code block.
> >>> It's kinda cryptic what you are pointing out.
> >> Not really,
> > It's. It lacks the very same "additional" words to explain what you
> > meant and why.
> >
> >>> What's needed additionally is to change
> >>>
> >>> - unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
> >>> + unwind_idx = i;
> >> You left out that 'additional change' above from your reply.
> > Yes, that's true, but it took some time to decrypt your message.
> >
> >>> Of course not. See above. The usual pattern is
> >>>
> >>>    while (i--)
> >>>      do_clean_item(i);
> >> Of course, but that's not what you replied.
> >> I was merely pointing out that your reply included a logic change
> >> converting a loop from for to while.
> > I expect that developers actually think about the changes they do and
> > double check what's proposed by reviewers. If they just copy'n'paste
> > whatever others propose, I wouldn't take any patch from such a
> > developer.
> I think in alloc path is using for loop, and in error/free path also
> using for loop is better to read the code.

I don't think so.

  while(idx--)

is kinda idiom which is really easy to read.

I could send a v2 on your behalf.

-- 
With Best Regards,
Andy Shevchenko
