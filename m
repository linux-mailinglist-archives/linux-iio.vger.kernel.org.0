Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3969A373CB7
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhEENyu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhEENyu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 09:54:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A97C061574;
        Wed,  5 May 2021 06:53:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so870138pjb.4;
        Wed, 05 May 2021 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxC8eRm5vZdHLw/CLg5YmBFFYEBES/Rpe8UpmiyOxeg=;
        b=GlF1XPtdG0JmD97NLMV2tGoqxoQEd4zGDApRczjngpfLn6Cp61TvbqgMRKsKHbiRDr
         NYyjRj8uFrga1L4OtcYrofP5/085Gt1oil9WGCF2d5vikjT7YMcKORjBacr7wHDNE7Wh
         Bc/yl/GvRYQ7xrl4XIKhB9y8n2WoUFW0gcArQ4l1W5jbnNiVoXDwOYxXrLuPnEhktKxK
         A7XFIsMmjHCU83Kz9iy7EMTeQXdXILGjoalPxFGzEgyYYyxKxV6FBybPdd8ZGVqO+aBc
         2XSCSy7Ao+OiSFRjLS208I7jQDegZP/J+qYxBfv7vUu6Iw52FajGrKmhtNrasaQPI9dK
         Q8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxC8eRm5vZdHLw/CLg5YmBFFYEBES/Rpe8UpmiyOxeg=;
        b=QLlD39nwvLW+lYF4btTAzgxObTURFfp3LuHYVkRoeMYbLFm1PjbS6LamKMLixnb9lq
         9lsgfEIGcGB4ogyJG584BjRWYbQzGvWCJTBBMdU3fNbK9tl4FFmewjXA+kXaiWVO2OaU
         5P3HxDl9QiF9qjLO+1vhiNkDvqe5QzAiJNCGdp/zLELyHa3Z/UfNO+bE19jLpBvpLuom
         Bska1kxsuPoGB0D3ZibQeVydnJ2tm+IaW69lxG4Q9cp4cnLNi1hnqf8/o2zhr1BjmbGv
         LJ+8+CzVL63qkJp0LjkySO+GTeevgek4bgFZ8S1Cbu/GDf2GDl4qKHe2/uighynhWgex
         PLPw==
X-Gm-Message-State: AOAM531J6uynl2Pv7qEYxsQXBDeUSjQYaSywZuRap3Q5v9ok4UNqyblD
        qNS+K3PDYStQI+0bDur+8RpItlln/C4i6HMbLLU=
X-Google-Smtp-Source: ABdhPJxUZe5dy4K1/6z7/apaLIsLcvhFy2KwMWnRPUMSFYhuGRpUvv6+pftd1DfqtA9soOM7/+BYPrcWp5ZTzrzTwwg=
X-Received: by 2002:a17:902:ecc6:b029:ee:af8f:899e with SMTP id
 a6-20020a170902ecc6b02900eeaf8f899emr25742086plh.21.1620222832276; Wed, 05
 May 2021 06:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210504174019.2134652-1-linux@roeck-us.net> <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net> <20210505093235.00007c38@Huawei.com>
 <20210505093438.00005238@Huawei.com> <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
 <22212bbc-1dc7-c7e7-1954-ebb911754246@redhat.com>
In-Reply-To: <22212bbc-1dc7-c7e7-1954-ebb911754246@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 May 2021 16:53:35 +0300
Message-ID: <CAHp75Vf+2oVttGhAcpcw-ZsAXno01yuKWz0Xiti_7beHCR81ng@mail.gmail.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on CONFIG_ACPI
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@denx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 5, 2021 at 4:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 5/5/21 3:22 PM, Andy Shevchenko wrote:
> > On Wed, May 5, 2021 at 11:36 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> >> On Wed, 5 May 2021 09:32:35 +0100
> >> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >>> On Tue, 4 May 2021 11:00:52 -0700
> >>> Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > +Cc: Paul (I hope you are related to coreboot somehow and can
> > communicate this further), Pavel and Jacek (LED subsystem suffered
> > with this as well), Hans, Rafael and linux-acpi@
> >
> >>> Dropping the ones we are fairly sure are spurious is even better!
> >>
> >> If I get bored I'll just do a scrub of all the instances of this that
> >> you haven't already cleaned up.  It's worth noting that we do
> >> know some highly suspicious looking entries are out there in the wild.
> >
> > I have counted ~60 users of acpi_device_id in IIO. Brief looking at
> > the IDs themselves rings an alarm about half of them.
> >
> > So, here we may have a chicken and egg problem, i.e. somebody has been
> > using (or used) fake IDs from Linux kernel in the real products. What
> > I can consider as a course of action is the following:
> > 1. Clean up (by removing as quickly as possible) the IDs that have no
> > proof to be real from the Linux kernel sources (perhaps marked as
> > stable material)
> > 2. Notify ASWG / UEFI forum about all IDs that abuse ACPI
> > specification and are in Linux kernel, so at least we can keep some
> > kind of "reserved/do not use" list on the official level (Rafael?)
> > 3. Do not accept any IDs without an evidence provided that they are
> > being in use in the real products (this should be done on Linux
> > maintainer level in all subsystems that accept drivers
>
> So my 2 cents on this are that we need to be very careful with
> removing "bogus" ACPI-ids.
>
> A couple of examples from a quick check under drivers/iio/accel:
>
> drivers/iio/accel/bmc150-accel-i2c.c:
>
> static const struct i2c_device_id bmc150_accel_id[] = {
>         {"bmc150_accel",        bmc150},
>         {"bmi055_accel",        bmi055},
>         {"bma255",              bma255},
>         {"bma250e",             bma250e},
>         {"bma222",              bma222},
>         {"bma222e",             bma222e},
>         {"bma280",              bma280},
>         {}
> };
>
> static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>         {"BSBA0150",    bmc150},
>         {"BMC150A",     bmc150},
>         {"BMI055A",     bmi055},
>         {"BMA0255",     bma255},
>         {"BMA250E",     bma250e},
>         {"BMA222",      bma222},
>         {"BMA222E",     bma222e},
>         {"BMA0280",     bma280},
>         {"BOSC0200"},
>         { },
> };
>
> With the exception of the  "BSBA0150" and "BOSC0200"
> ids, these look like they were invented. But at least the
> "BMA250E" one is actually being used! The other BMA###?
> ones are probably fake, but given that the "BMA250E"
> one is actually real ...
>
> drivers/iio/accel/bmc150-accel-spi.c
>
> This uses the same set of ACPI ids as bmc150-accel-i2c.c
> minus the "BOSC0200" one. I'm not aware if these
> being used in spi mode on any x86 devices, but again
> I'm not 100% sure ...
>
> drivers/iio/accel/da280.c
>
> static const struct acpi_device_id da280_acpi_match[] = {
>         {"MIRAACC", da280},
>         {},
> };
> MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
>
> This looks like a fake-id, but it was actually added
> in a separate commit adding ACPI support because the
> chip is used with this id on a Linx 820 Windows tablet.
>
> So figuring out of any ids are real or not is really tricky
> and removing them if they are real will lead to regressions.
>
> So summarizing IMHO we need to be careful and not just
> start removing a whole bunch of these...

That's all true. However, I have a few hints on how to distinguish
them (fake ones):
1. The ID has been added from day 1 with I2C or SPI ID table with just
capitalized name
2. If there are a few drivers by the same author and at least one of
the contributions has confirmed fake ID
3. The ID is single in the list and mimics the part number (capitalized form)
4. Google/DuckDuckGo/etc searches give no meaningful results

Either combination of the above can be a good hint to at least be
sceptical that it's being used.

So, Hans, as you already noticed, drivers with a long list of IDs or
when ID added separately can be considered less fakish, but we really
want evidence of the hardware that has it.

Some big companies sometimes produce fake IDs themselves (and
sometimes for the components they are not even producing) without
following the process (as described on uefi.org) which is a pity part
of the story.

-- 
With Best Regards,
Andy Shevchenko
