Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4B39F769
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhFHNRQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 09:17:16 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34359 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhFHNRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 09:17:15 -0400
Received: by mail-pf1-f172.google.com with SMTP id g6so15680852pfq.1
        for <linux-iio@vger.kernel.org>; Tue, 08 Jun 2021 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3AFOZX638kziIwrTxiPdGPupqQZsS8bSUlfUaxlpIk=;
        b=XhDVrC37nV/vV83Lrjm8TEkVnswVHW54ircC59jGqSpvnklXMRrkKPgGYBNcmNP7ot
         Zsc+mKuCWnAjKM6fnbd20f4ZaSxNkKhzln5LVjuP1F9qRcAoR3V/HmxKk2FsQlS2Hx5U
         Hq4l2FpsKcxGu3ST00GlJoExdDYwxOIOHuVTX2A/ZYPPo4YXyKKWAK8MKyGHIrtsTqPN
         jqmLNRLz62URzed0QFVSzg+tcXDww/laiBJTPBnMbzwWJYRGpChPTgbvpfBaMX0vwxBz
         /q1XP3dBKeGwfjGjHqwzxaktHYWhmbkFe3Xu0gfyUyHObeg8TSwxZKuP+f+OIdsmBFAa
         8zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3AFOZX638kziIwrTxiPdGPupqQZsS8bSUlfUaxlpIk=;
        b=tpN/7ypcFV6DW6wbTXw65fypXd+FT8PuVTfoMxGg8USh2E1xzz54Ezvio8KM8U6zp3
         LnEjHK5Rn6tCTRwPRjiCMEMYm3s6lpA2BemAa42qWsa4Fg6vMS3SEsuMkatjxX3F+4Jy
         v+1dSPkXww7dP9NnY7Jp3mdJfqQ03h6aCRIN0UpvSfTwn2G8ogMCnsMLv59lsxvs04bI
         SFvtIUq10reUuyLFZiLy4H+/kBgqqgXoRmXn4teQYUqPnfe7uruNMgnEHSTWWFt1HOLP
         3dari5Hg8V6Yl+ZjQD9uHB802YLlw8w3cVYeSdFr59LwaRTntxp5aiqW/DNfzx//qrgV
         6Yxw==
X-Gm-Message-State: AOAM53289KzlSk5hYPZeQ9d6Sw6OBRan4Ok/GztOddZsuwl9PmeEQE/n
        tXaQOD1YQCNFe37DfDweLKEUQ6sq4FCitLQKcSXrCFRCZZg=
X-Google-Smtp-Source: ABdhPJyVF8wUHxMvdDM1I8M0gPqzHWVnTZ4DAS7M0nDCsmivHHMq6oXSUjGiiQV+f/G/CE2cc2xV0orWC9PsFYPQqBc=
X-Received: by 2002:a63:4145:: with SMTP id o66mr22819631pga.4.1623158063027;
 Tue, 08 Jun 2021 06:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfuoWi72b1wAYoJD_mF6+s-h7k7JCU3CFbEzuGtYBuCZA@mail.gmail.com>
 <eb9f9c75-98c9-0f93-7fd9-565061c78cf0@metafoo.de>
In-Reply-To: <eb9f9c75-98c9-0f93-7fd9-565061c78cf0@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Jun 2021 16:14:06 +0300
Message-ID: <CAHp75VeC=trDNkhYbMpeCOYVRK124HPJNVX=tWmfy1Jh5akOzw@mail.gmail.com>
Subject: Re: atomic use is not atomic?
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 8, 2021 at 3:44 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 6/8/21 2:35 PM, Andy Shevchenko wrote:
> > Hi!
> >
> > Can anybody explain this code [1] in terms of atomicity?
> >
> >    if (!atomic_read(&trig->use_count)) {
> >      atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> >      ...
> >    }
> >
> > AFAIU how atomics are supposed to work the above doesn't do anything
> > atomically. I.o.w. use_count may be simple int with the same effect.
> >
> The operations here do not require atomic access, it is just operating
> on a atomic type. The atomic access is the atomic_dec_and_test() in
> iio_trigger_notify_done().

So, between atomic_read and atomic_set somebody can call
atomic_dec_and_test(), for example. Is it a problem to actually lose
the value?
Why are atomic types being used here when there is no atomicity guaranteed?

-- 
With Best Regards,
Andy Shevchenko
