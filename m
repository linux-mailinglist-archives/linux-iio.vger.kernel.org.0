Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10331F610
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSIuM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 03:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSIuL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 03:50:11 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B96C061756;
        Fri, 19 Feb 2021 00:49:30 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i8so4852162iog.7;
        Fri, 19 Feb 2021 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1m2t+2Cr5XW59fZQXL2Ptf07zXdD3ynAJLB/90q3UY=;
        b=pKskMy6XCjr2RzlkaFO3Bnw1I0duXwJE5uoawrowZ4/nGSfePBbqhSngbf1NH6tgBR
         SC6NawJIXCDqwiXWqUinfhBrd+OxPhsODUqVzgLDL9TKeOaisnqWa8EsUEnSfqjP1cRC
         qdUEfuNhq0DAMdZljZBqkYNso8UB82gJf5kyy62kRXjof6DInAwsMWXraZVhU1bm5y9C
         t3v3G4hvb6fgfsclQWd8YhEwkuLvoqsjbogFSYRYNcJglaA1xXnVmDBRUO9+7+sy91BQ
         l0D1AcVzZGB5r1CGRV63/cRI2BGKcOTMD1x0RI1hPjHsxzzIN8uMx8zRq9A/1eXCxMgS
         WLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1m2t+2Cr5XW59fZQXL2Ptf07zXdD3ynAJLB/90q3UY=;
        b=S3AyJ1mRfCLY3BM8pisZThN20MiVPiJW2/7x7p5gFmDKdz03nD3CRCQCW56T9ofv4h
         7T3AkV2kOK6NvEt/Yqa0xe1u1uMVfChPEM1tVOU9+2/uGVXdii5RcmLhYEddvemGeTBE
         1thupk/eviqG1OWSqDaafD4PFycWTy+xMC0q20cfFaOftGPPpBwaUzEyHr1W1UdYXHcd
         yufQpGhIKXwRJPPMwSqP+XY9kLvHb3SDD1ecXogMg5D81C7aeMgJPTVyXC8HTFHJ7y2J
         Wj7thk/o/T8JQr6WdkMd1fYrRJGTtsnqa4dJUxY+8zWq7vkupmuxZYBPHCfyFdqd7WoA
         JCDw==
X-Gm-Message-State: AOAM533XWfC06EpaBavDw5CXDUS0vwSbwM5PmzeCzR+A1ZTaZ4Hb/cs9
        H+l3pXiTbDqxi0wHZDT97RtV96oy8NDJ81qu0YkkuysfQIQ=
X-Google-Smtp-Source: ABdhPJxKWMQ2Qbbihq9Ol9+OAaAEKBVHrHMjfkI45lUIjAMR/7S/8oQxX72sHe2L1l8dTzH8zB9+NCuulwCec6AOY0s=
X-Received: by 2002:a5d:854b:: with SMTP id b11mr2969967ios.105.1613724570261;
 Fri, 19 Feb 2021 00:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
 <20210217083438.37865-6-alexandru.ardelean@analog.com> <20210218140506.02b28d8a@archlinux>
 <CAL_Jsq+_HYQ1KT7L34nuM2RENnX1A5J8LCazCV2aeNFmkeskGw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+_HYQ1KT7L34nuM2RENnX1A5J8LCazCV2aeNFmkeskGw@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 19 Feb 2021 10:49:19 +0200
Message-ID: <CA+U=Dsrt8bJgLJ_tvsf9p07-7kG4rEWvYBa02movJkWU6sfZ_w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: dac: ad5686: Add PWM as a trigger source
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Mihail Chindris <Mihail.Chindris@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 18, 2021 at 5:31 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Feb 18, 2021 at 8:05 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 17 Feb 2021 10:34:38 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >
> > > From: Mircea Caprioru <mircea.caprioru@analog.com>
> > >
> > > A PWM signal will be used as a trigger source to have a deterministic
> > > sampling frequency since this family of DAC has no hardware interrupt
> > > source.
> > >
> > > This feature is made optional however, as there are some board setups where
> > > this isn't used.
> > >
> >
> > So this is taking a very generic setup, but then implementing it
> > as a bit of a hack within the driver.
> >
> > It's effectively a PWM connected up to an instance
> > of iio/triggers/iio-trig-interrupt.c
> >
> > Now, I've not looked at that trigger driver for a while, so you may well
> > need to figure out how to add a binding to instantiate it.
> > (looks like no one has used it since board file days, or via instantiation
> > from another driver).
> >
> > It's a slightly odd corner case as what it reflects is that we have
> > an interrupt available that is intended to drive some sort of data
> > capture or output (it's a trigger signal) - but exactly what is done
> > is a runtime configurable.  In this particular case that interrupt
> > is hooked up to a PWM and we also want to represent that.
> >
> > The fact it's being driven via a PWM is interesting but we should be
> > able to extend that trigger driver to optionally accept a pwm provider
> > and if it has one provide frequency control.
> >

So, the main intent here was to provide a user for this new output kfifo.
I don't think I have time to re-spin this into a proper solution.
Someone else may come about and do it.

I'll drop this from the series [for now].

> > Binding might look something like the following..
> >
> > interrupt-trigger {
> >    interrupts = <>;
> >    pwms = <&pwm 0 4000 PWM_POLARITY_INVERTED>;
> > };
> >
> > @Rob, what do you think of this odd beast?
>
> So a PWM routed back to a GPIO interrupt? It needs a compatible, but
> otherwise I wouldn't object to the binding if that's what the h/w
> looks like. But from an OS perspective, I don't think you need it.
>
> > So all in all, this generic facility needs a generic implementation, not
> > one buried in a driver.
> >
> > Another open question here is whether you really can't just use an hrtimer
> > to get similar precision?  Way back at the dawn of time in IIO we had
> > code to use the RTC periodic ticks as a trigger with the theory that they
> > would give very precise and even timing.  In the end it turned out that
> > hrtimers worked just as well (and RTCs drivers emulated the periodic
> > ticks via hrtimers, dropping their use of the hardware periodic timers).
>
> +100
>
> A hrtimer is likely going to be more precise. IIRC, timers are
> serviced first. Either way, you're going to have some amount of
> interrupt service latency, so any precision you think you are gaining
> by 'doing it in h/w' isn't really there.
>
> Rob
