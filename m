Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF36376552
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 14:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhEGMlO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 08:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhEGMlN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 May 2021 08:41:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D45C061574;
        Fri,  7 May 2021 05:40:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c17so7524071pfn.6;
        Fri, 07 May 2021 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP+2sJOhJarbu28eKxfaAb5g7ehkupmenZaHEZxQ8Jc=;
        b=h8VxxrRK7k5MkyRjP0vUIPHkppAkl/EGznIjZr6Nc1k8vJZyG7rrsdVRXz4398w3AY
         aSNvE8aW3vAMENrw15BGIVRNYjPFb5+VaSjzFkMGP0WbhWeNA17a21sn/XjE5OhEqylx
         C4TYt273PSoriQAyI7SD6tb2zTZA1K37E2tVacugS5DJLt4ZlRDyaNh0OCl8aDfvGlvU
         2/erZ/kqWsnLs8k/wxrX4x8LBLJA//rfy/HhaifVcy1UR0hG2tzgAjMs8rpy3mqYGt/o
         goN5Sn8HFMRhTaFiOFlq830Y9g0IUUGlAMLax98GT0/Je1zvkUI2mCZLMEax1oySGdLi
         qnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP+2sJOhJarbu28eKxfaAb5g7ehkupmenZaHEZxQ8Jc=;
        b=JeeyjmiO8FXYTde+3kMXVebBcxm2EK43UoEMnVFJUvLohI5Co6McbVyb8NR/V5k3f5
         Qme0LGJ3mK30sxClQoXqW2/igb2ZDel5Kd2fXMTejpzNV0NPnLC8lsOLDVb/WitaLSTE
         sZNHlwjzdo43teDiJy5kkzuBNLZ6sRuMFkSqTFoFJjKkiZ6KWd1HYN6CDhLt5lmIezb1
         CJRILDi4m7PJWWrQEaZX+sJn6LFHrtAT/KpcUcnCCCiavV6n9jOtk/6ZOMAu6aND+9NR
         2b9y3YpJgTJmX8B6FHtWPMFVWs0yyj+50sj0g4lz9sLyYtXGdTjB245MImvC6Yws49Q5
         8VRA==
X-Gm-Message-State: AOAM532gUAnNENoDVY2Odj/vZ7qcdXExZHI/rMFmhMmE0t9AQuxxeg/9
        7w34HpxZAoPjPPKjWnZhhyKK4qzjjAqoekrTkoeDqMJXeeU=
X-Google-Smtp-Source: ABdhPJyYIPjiMCOh3evT3bees6PyL45b1TFlF7ycIYOWfIte9+rCMwvW8tcyMuvcAmr5L3GPBWZ7mabWkTYpuMsPdm8=
X-Received: by 2002:a63:cd11:: with SMTP id i17mr9658198pgg.74.1620391213106;
 Fri, 07 May 2021 05:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210504174019.2134652-1-linux@roeck-us.net> <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net> <20210505093235.00007c38@Huawei.com>
 <20210505093438.00005238@Huawei.com> <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
 <20210507115302.GA20751@amd>
In-Reply-To: <20210507115302.GA20751@amd>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 May 2021 15:39:57 +0300
Message-ID: <CAHp75VcxQYp0V9oM_UYMfwcR1GMo+MTYgurj2qichGgpDzm4SA@mail.gmail.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on CONFIG_ACPI
To:     Pavel Machek <pavel@denx.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 7, 2021 at 2:53 PM Pavel Machek <pavel@denx.de> wrote:
> On Wed 2021-05-05 16:22:07, Andy Shevchenko wrote:
> > On Wed, May 5, 2021 at 11:36 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > > On Wed, 5 May 2021 09:32:35 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > > On Tue, 4 May 2021 11:00:52 -0700
> > > > Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > +Cc: Paul (I hope you are related to coreboot somehow and can
> > communicate this further), Pavel and Jacek (LED subsystem suffered
> > with this as well), Hans, Rafael and linux-acpi@
>
> Thanks for Cc. I prefer @ucw.cz address for the LED work.

Noted!

> > > > Dropping the ones we are fairly sure are spurious is even better!
> > >
> > > If I get bored I'll just do a scrub of all the instances of this that
> > > you haven't already cleaned up.  It's worth noting that we do
> > > know some highly suspicious looking entries are out there in the wild.
> >
> > I have counted ~60 users of acpi_device_id in IIO. Brief looking at
> > the IDs themselves rings an alarm about half of them.
>
> As far as I can tell, this means asking "is this real ID or did you
> just invent it" at patch submission. Okay...

I would put it in a way that "Please, provide an ASL excerpt / ACPI
tables dump" or something alike. Because it may also show some
additional information that would make sense to consider when adding
an ID to the driver.


-- 
With Best Regards,
Andy Shevchenko
