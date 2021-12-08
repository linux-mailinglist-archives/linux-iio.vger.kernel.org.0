Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A57346D053
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 10:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhLHJw7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 04:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLHJw7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 04:52:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2EC061746
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 01:49:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r5so1609302pgi.6
        for <linux-iio@vger.kernel.org>; Wed, 08 Dec 2021 01:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dnlwwCV6pOM1X+kfXQBag7jYv+hGzXkuEhPSqvu/n4=;
        b=FIB8CE9QkgvtiyDT2nbRoZyox9M+WQVrub4QmUguSv0tt+ckpAla9O2oFn2PPn73G5
         DwooSAkRwRBziDYcbyV4BOFx5MwnqBfHWqZxHnWrNl5KFCqUg0e+xv5C7X4wy6gpb7LN
         fTK9skvzg5yvjFzApZoAVLZAKLAuTSDIJM314NyIoVSOfhcKVuQFwIVf6T9EllbYqXCl
         pWZU/n+ZW9gaeDR2M2srIFWA5d1rR7GR8uo5bU5iK0CfCOJC9HOVJf5vobl4fkV2H+rp
         Ss38cwrMIHFAjHoQ3Qqz7TrlXsdst3L36+yVieMM9Lnmqa38H1Xo8b1ryZtIde8ISV/8
         hPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dnlwwCV6pOM1X+kfXQBag7jYv+hGzXkuEhPSqvu/n4=;
        b=27RaHoZdCZ/dCoADOFB7RIA2skzqNOUlo+E/+ENyPQRtpUsZEQfkQtsXcAKjGKsD+q
         MdhCpv/miyy+ojBNX+yV/Tkb1VqLqllV4p1HpG6kzPiklPInL76qHkvEXr2RmEHqDQsy
         Rp8aYlLedoxCLVyX3T1pBnQOFRuG88HVMN0MMeR0dTIoQG+WWMWaBqLLVqyePNEFd3nA
         9r2ocY/7HwHioVFMe+M5kkJZ19h9eNmoY8yCP18dGMhF3RtAlRjGUcqxeSYaaARJ2rcJ
         763vK7upH3AB0yN3fq76zk0hWaVQZ3hMN6c2Qx+vHK/xiidtsEsoozA5eFEfNtEPJ6N5
         taAg==
X-Gm-Message-State: AOAM53232uWdjh8Wl3R5WsuDzCkI4BbsrdKhVl4tWRo2jcw7RD8WEL/Y
        LyczV/X/AqSYi4ITWvzZMeGt5kLwBx1BPkvqymg=
X-Google-Smtp-Source: ABdhPJxbuRXENI/z4apyIvuqBhaRZbvKk89tW9KrwIOq9xn1GysrKIJbRbPTLAo3xxmO3wKWmStRrLSh5191kedtO78=
X-Received: by 2002:a05:6a00:7cc:b0:49f:9cf1:2969 with SMTP id
 n12-20020a056a0007cc00b0049f9cf12969mr4651254pfu.12.1638956967638; Wed, 08
 Dec 2021 01:49:27 -0800 (PST)
MIME-Version: 1.0
References: <9bd04e6d-7418-9d01-6e80-52fd7e84086f@deathstar2.nl>
 <20211207161338.000012bd@Huawei.com> <CAHp75VdB5vquGKnHSZhkLJDnUTXo68-mvHsRfPg+eqgb8pueTA@mail.gmail.com>
In-Reply-To: <CAHp75VdB5vquGKnHSZhkLJDnUTXo68-mvHsRfPg+eqgb8pueTA@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 8 Dec 2021 11:49:15 +0200
Message-ID: <CA+U=DsrD1S0QMFXgjf4tNUmprS5j40hv2Jhp+ykbYqn70V2mJw@mail.gmail.com>
Subject: Re: iio display large numbers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Henk <yoda@deathstar2.nl>, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 8, 2021 at 11:33 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Dec 8, 2021 at 2:56 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Tue, 7 Dec 2021 13:40:19 +0100
> > Henk <yoda@deathstar2.nl> wrote:
>
> ...
>
> > Two options for this.  If the thing we are controlling is the raw channel then
> > we have the option to provide _scale reflecting the fact that a large value
> > e.g. GHz is not normally controlled at a Hz granularity.
>
> But some sensors can be really high-precision ones, although I
> couldn't imagine a value that requires more than 32-bit for that in
> general engineering. Where one may ask for more is something like very
> precise physics experiments in CERN :-)

Yeah, and this is where IIO and some sensors and clock generators seem to go.
Research and military, 5G networks, aerospace, etc.

It's a bit tricky to pin certain sub-systems (for some of them).
Like, the clock-framework can only represent up to 4 (or 2) billion HZ
(I forget if it's u32 or i32).
So, this creates limitations/discussions with some clock-chips and
where they need to go (IIO or CCF).

On the other end, there was a discussion [a few months back] about
needing lower than nano scales in IIO.

So, this opens up a new set of discussions, like:
1. How should people use Linux for these types of devices?
1a. Should people use Linux for these types of devices?
2. [If 1 is Yes, then] Which sub-system to use?
3. Once a sub-system has been chosen, how to do it?
3a. Extend the common framework (and how?) to support these new sets of devices?
3b. Or do some custom attributes?

On point 3, a lot of times 3b is the chosen route [by chip vendors],
because these new chips seem to come out faster than the ability to
extend these common frameworks.

To me, it has become obvious [a few years ago] that the Linux kernel
has been very good at serving computing needs mostly targeted towards
data-centers (big physical servers, lots of VMs, networking and all).

We're probably going to see more of these specialized devices trying
to slowly pop up.

And it will be an interesting journey to see (after all of it unfolds).

>
> > Where that doesn't apply or the range is really very big we do have the
> > slightly nasty option of IIO_VAL_INT_64
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=6bb835f3d00467c9a5e35f4955afa29df96a404e
> >
> > This is very new, so not in mainline yet, though it is queued up for the
> > next merge window and should be linux-next.
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
