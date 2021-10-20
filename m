Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD8B435447
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 22:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhJTUGy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhJTUGw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 16:06:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C55C06161C;
        Wed, 20 Oct 2021 13:04:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so977103edj.1;
        Wed, 20 Oct 2021 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vctbSAw/IP0V1ejcWDqOoNVj610mv9Dqq5/zVucqksY=;
        b=DDcmMsEBtK1/HIwB6EBvLSabR1qGCsrQz2NgoP8SPh4fl4YKB5GwN+ufGQiw9x+D++
         wH2zX91p6PzByawote7YkWOtv7J91Mm1eiV0cXJkj8c5RPs15o3qUeagSIZ2JdxfBvUH
         c1LN7TWTL68bvsvwl9cwR8Kg8TNCuzCk0R2n/f0tDOdMEGjXyLsna2yC6XPHyqukds4n
         AU/Qxs4KKH8uVVckhug471/OKwRt+NIlYdgndsO6OJ5jGoBql77UAGCYsakwpGm56udA
         xWU4fW5MWwN25Mi3rJ1CYiJZEzjpvhm5coLGPUu45jYu9j+u6Wst5nFkGVLF4kMCaD81
         y3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vctbSAw/IP0V1ejcWDqOoNVj610mv9Dqq5/zVucqksY=;
        b=54SVcnJNX5CogXxUJcjsa78eJnv15Q7xz52ON/xHZEKbrwdRy4QPC6VKilCikcAbeY
         UaYwxN1Iqx4KEUHMRVY2AlWhsuWt4Q+mXC5cQxkrVRFRub+buDgYoxT7SwzPQU0b+N+D
         zWBJ7XJGGnV2Re0sJi/zqtV4AvCDzdMRbGIKIY0AldcPpoXeEVYc+dHIMB0yktcug77J
         05MXYolEIPW+blTby8JvyOnHXAQpQf4ue+slC8vSEBXMfeaPNcIG1wt5AakOpXMdSQRG
         wvJ0TfNxBwiMx1zVcCnq37TBr5/PjdKDh+kSLTok714SdMTGHhFIPu90nr+GvHJBbRoO
         SGxA==
X-Gm-Message-State: AOAM531Jj4jprJ9SyHpDdEEXXAge1J+0ElnXjygaGQuTRMLyGnJrNX17
        hYpmcGci2FVqIfxPF+6U6ZE8hpbHTmEv4vfun/k=
X-Google-Smtp-Source: ABdhPJw/vDpD2FXHCBSjCJE6xbA6bV33fdGQf8QNJ7w9sgh5O7nldolEscEdxA8MevZkR5Oe2f4Bn9nKmJ5y0j7+Qbw=
X-Received: by 2002:a17:906:1707:: with SMTP id c7mr1654521eje.377.1634760275948;
 Wed, 20 Oct 2021 13:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
 <YW3ErLKGtmyhSFd3@smile.fi.intel.com> <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
 <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com> <20211020183739.6a045ccc@jic23-huawei>
In-Reply-To: <20211020183739.6a045ccc@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Oct 2021 23:03:59 +0300
Message-ID: <CAHp75Vf=tXsDd_mDDGtNF-TD3SAK0BycvZonoKq---Ucp79s=Q@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-realtek-soc@lists.infradead.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        nic_swsd <nic_swsd@realtek.com>,
        Derek Fang <derek.fang@realtek.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Kailang Yang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        LKML <linux-kernel@vger.kernel.org>, info@ayaneo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 20, 2021 at 8:33 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 19 Oct 2021 12:58:53 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Oct 18, 2021 at 11:42 PM Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> > > On Mon, Oct 18, 2021 at 10:02 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Oct 18, 2021 at 09:02:40PM +0300, Maxim Levitsky wrote:

...

> > > > This is done by the commit 8a0672003421 ("iio: accel: bmc150: Get
> > > > mount-matrix from ACPI") which needs to be amended to take care about
> > > > more devices, somewhere in drivers/iio/industialio-acpi.c ? Jonathan,
> > > > Hans, what do you think?
> > >
> > > If you like to, I can probably volunteer to prepare a patch for this myself next
> > > weekend, using this pointer as a reference.
>
> Hmm. This isn't part of the ACPI spec but seems to be a microsoft addition.
> The webpage google feeds me says this is windows 10 mobile specific...
> https://docs.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries

So, it means it is at least a standard de facto on Windows machines.
We have to support it whether we want it or not. Same happened with
USB (wired) devices and many other things (SPCR, DBG2, CSRT, ...).

> Whilst I haven't been paying particularly close attention, I haven't noticed
> any attempt to add this to a future ACPI spec. If anyone happens to have
> convenient Microsoft contacts to verify the status of this method that would
> be a good step before we in any way imply it is standard.  Until then my inclination
> is to keep this in the few drivers in which we know it is useful.

-- 
With Best Regards,
Andy Shevchenko
