Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91B373D81
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 16:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhEEOUN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhEEOUM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 10:20:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC57CC061574;
        Wed,  5 May 2021 07:19:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m124so1862216pgm.13;
        Wed, 05 May 2021 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWkO/UpBF119LkK0U37r/dwgW6nyqtPlk2NsTHGNllY=;
        b=D4VfmULjM9tH+A79UuUXH4Z+j/+a1k0f07kdvHN2EkybL2csk5m+Z0goZ8tvYo9ooj
         CF8coMKGIFldb+RovgzPiepuzeQEtkAlSbYRabG54N9Htzey1g1BXoysRXlaIN8HH//W
         PI//Eufs26KkvDS62mxY6SIYXZP7/4VlneYNaTXEHj1PvTQ6kzTiPqY8bRyAEoFxSCfX
         v/1q8zVVJutY9EAvXHGfWxxhj6qm4NHuIGNQbmFDazIsqMiNkGMWvumsFgX3yWG611GH
         ZNtKQAtEAOgvD9un0Qwh88zj/OaJ7B3PXExqR5G1s8zDCy1tX9jLUPSW/BEx6LWFifbW
         rI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWkO/UpBF119LkK0U37r/dwgW6nyqtPlk2NsTHGNllY=;
        b=kAZ3+2yQhu2wQkDICbTptP6YQGInLRdribqAR6Jir2Zl8DGCJiZ2ds6zGCcvveM4Tp
         MDqGqhFpSUolBRQTa6KLZnkVH5qR45hTCKB5O3r5gSLKrDGVkz5Ej8eMaC7r4HO6fgOC
         IkgpaTlycB/MIHzE2dAjoEYDERp2C02jS0bdhx4cPZYcMvBWKDJ1ZKhkpGkEfoevmBQ4
         j0KkhWbwuz9qJ727jjMIc7ViH3d02Y8ZgQqS7EcYkLb6cuEYkEVx1VNuDvDVHsg0jTBH
         /D5B3EjU3qD95dcC4pCs8ZrhQH0R9lvBNb2ZOqhRBcf0d7XWsN4pjfmeMEoK8PKNztSY
         z7jg==
X-Gm-Message-State: AOAM530JsIphtDLqsHNu0dBCOdoE5SVjL8Rsl3itL9YxpBqfozvA3afl
        0FAP24nifhqHfKD9fTEuMlSVqdcakvFa6pQLDec=
X-Google-Smtp-Source: ABdhPJzKKtCe/LcivyDrNiITHmfuut1Oj0cIr/JSGtMqZx325hOyYryMDqXosTm3de9A3HSyaT7VA+71UjMuEMIf5Jw=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr28671640pgs.4.1620224354132;
 Wed, 05 May 2021 07:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210504174019.2134652-1-linux@roeck-us.net> <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net> <20210505093235.00007c38@Huawei.com>
 <20210505093438.00005238@Huawei.com> <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
 <22212bbc-1dc7-c7e7-1954-ebb911754246@redhat.com> <CAHp75Vf+2oVttGhAcpcw-ZsAXno01yuKWz0Xiti_7beHCR81ng@mail.gmail.com>
 <ede732cb-4a23-e5bc-6802-0280dc232876@redhat.com>
In-Reply-To: <ede732cb-4a23-e5bc-6802-0280dc232876@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 May 2021 17:18:57 +0300
Message-ID: <CAHp75VciMKfxPvKmY349327FcoUcUMeFnvqkniw2erCyb71BoQ@mail.gmail.com>
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

On Wed, May 5, 2021 at 5:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 5/5/21 3:53 PM, Andy Shevchenko wrote:
> > On Wed, May 5, 2021 at 4:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >> On 5/5/21 3:22 PM, Andy Shevchenko wrote:
> >>> On Wed, May 5, 2021 at 11:36 AM Jonathan Cameron
> >>> <Jonathan.Cameron@huawei.com> wrote:
> >>>> On Wed, 5 May 2021 09:32:35 +0100
> >>>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >>>>> On Tue, 4 May 2021 11:00:52 -0700
> >>>>> Guenter Roeck <linux@roeck-us.net> wrote:
> >>>
> >>> +Cc: Paul (I hope you are related to coreboot somehow and can
> >>> communicate this further), Pavel and Jacek (LED subsystem suffered
> >>> with this as well), Hans, Rafael and linux-acpi@
> >>>
> >>>>> Dropping the ones we are fairly sure are spurious is even better!
> >>>>
> >>>> If I get bored I'll just do a scrub of all the instances of this that
> >>>> you haven't already cleaned up.  It's worth noting that we do
> >>>> know some highly suspicious looking entries are out there in the wild.
> >>>
> >>> I have counted ~60 users of acpi_device_id in IIO. Brief looking at
> >>> the IDs themselves rings an alarm about half of them.
> >>>
> >>> So, here we may have a chicken and egg problem, i.e. somebody has been
> >>> using (or used) fake IDs from Linux kernel in the real products. What
> >>> I can consider as a course of action is the following:
> >>> 1. Clean up (by removing as quickly as possible) the IDs that have no
> >>> proof to be real from the Linux kernel sources (perhaps marked as
> >>> stable material)
> >>> 2. Notify ASWG / UEFI forum about all IDs that abuse ACPI
> >>> specification and are in Linux kernel, so at least we can keep some
> >>> kind of "reserved/do not use" list on the official level (Rafael?)
> >>> 3. Do not accept any IDs without an evidence provided that they are
> >>> being in use in the real products (this should be done on Linux
> >>> maintainer level in all subsystems that accept drivers
> >>
> >> So my 2 cents on this are that we need to be very careful with
> >> removing "bogus" ACPI-ids.
> >>
> >> A couple of examples from a quick check under drivers/iio/accel:
> >>
> >> drivers/iio/accel/bmc150-accel-i2c.c:
> >>
> >> static const struct i2c_device_id bmc150_accel_id[] = {
> >>         {"bmc150_accel",        bmc150},
> >>         {"bmi055_accel",        bmi055},
> >>         {"bma255",              bma255},
> >>         {"bma250e",             bma250e},
> >>         {"bma222",              bma222},
> >>         {"bma222e",             bma222e},
> >>         {"bma280",              bma280},
> >>         {}
> >> };
> >>
> >> static const struct acpi_device_id bmc150_accel_acpi_match[] = {
> >>         {"BSBA0150",    bmc150},
> >>         {"BMC150A",     bmc150},
> >>         {"BMI055A",     bmi055},
> >>         {"BMA0255",     bma255},
> >>         {"BMA250E",     bma250e},
> >>         {"BMA222",      bma222},
> >>         {"BMA222E",     bma222e},
> >>         {"BMA0280",     bma280},
> >>         {"BOSC0200"},
> >>         { },
> >> };
> >>
> >> With the exception of the  "BSBA0150" and "BOSC0200"
> >> ids, these look like they were invented. But at least the
> >> "BMA250E" one is actually being used! The other BMA###?
> >> ones are probably fake, but given that the "BMA250E"
> >> one is actually real ...
> >>
> >> drivers/iio/accel/bmc150-accel-spi.c
> >>
> >> This uses the same set of ACPI ids as bmc150-accel-i2c.c
> >> minus the "BOSC0200" one. I'm not aware if these
> >> being used in spi mode on any x86 devices, but again
> >> I'm not 100% sure ...
> >>
> >> drivers/iio/accel/da280.c
> >>
> >> static const struct acpi_device_id da280_acpi_match[] = {
> >>         {"MIRAACC", da280},
> >>         {},
> >> };
> >> MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
> >>
> >> This looks like a fake-id, but it was actually added
> >> in a separate commit adding ACPI support because the
> >> chip is used with this id on a Linx 820 Windows tablet.
> >>
> >> So figuring out of any ids are real or not is really tricky
> >> and removing them if they are real will lead to regressions.
> >>
> >> So summarizing IMHO we need to be careful and not just
> >> start removing a whole bunch of these...
> >
> > That's all true. However, I have a few hints on how to distinguish
> > them (fake ones):
> > 1. The ID has been added from day 1 with I2C or SPI ID table with just
> > capitalized name
> > 2. If there are a few drivers by the same author and at least one of
> > the contributions has confirmed fake ID
> > 3. The ID is single in the list and mimics the part number (capitalized form)
> > 4. Google/DuckDuckGo/etc searches give no meaningful results
> >
> > Either combination of the above can be a good hint to at least be
> > sceptical that it's being used
> May I suggest for accelerometers to also grep for the id in
> 60-sensors.hwdb from systemd ?  E.g. the BMA250E id can be found
> there.

Right, it's a very good suggestion! It will definitely tell us what
may not be removed even if we don't see any evidence otherwise.

> > So, Hans, as you already noticed, drivers with a long list of IDs or
> > when ID added separately can be considered less fakish, but we really
> > want evidence of the hardware that has it.
>
> If you want to move ahead with pruning some of these please Cc me
> on the patches, then I'll check them against my collection of
> Bay and Cherry Trail DSDTs, which are devices where these sensors
> are often found.

Currently the scope is of
AOS2315
BME0680
STK8312


-- 
With Best Regards,
Andy Shevchenko
