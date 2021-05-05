Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1506373C48
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 15:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhEENXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhEENXV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 09:23:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7592C061574;
        Wed,  5 May 2021 06:22:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v191so1949929pfc.8;
        Wed, 05 May 2021 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3vwVar5r+329ocJFJtfF9oqnquOLoNIqbVI02ZlfTo=;
        b=GQRy1x6UIBCNNz8QwfoLVp65/PY7M7t/WpP5uhwcU452xq3blR4aBJ/ss+dgfMN3Bj
         5NI9FOqD584Z8NobAn57rdZJJn2JIkPcAkJd7YXts4h5Ken3GFjuwIIH5Z3EH3Ird4vu
         gwg10SSHRKgfB5rbLEI0mkgs8v0H5VEJLbhG59vGvai+NYHEvslRFaQiReW3QR50+ENm
         3XeAscwmjTTdH0N1Cpzcn+LO2KsWXkGEnXi67TaeahW30Kp2wBQnjIf8XiJBEH3saYeR
         u8NkkydXhmCLSOeAnn+zEDVayAeb3HTMfdUlp80aTiykIBd0VGF9Q4Pv78yjQ8XyaIUh
         5piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3vwVar5r+329ocJFJtfF9oqnquOLoNIqbVI02ZlfTo=;
        b=lQQ01rlEylNPoxd58BDLpl4d4UZg0bHuZV7s/aXLDs1Ywt5kjSwtmFMhxJlwG1VTAt
         PMhy4zbpRTiiOuLC3y6M6iQTW4gT0B/s9niwYPLSukIkObhJSDx4knVTdKuz9ENk89+i
         Xh5KFnwldBWBCMiLKC5oJ+gbkwxsDkizKyCTNenFVQvLz+nrj9nC7E9RGTd6thOuCoyv
         PeRKRV7hyxAN2AZ6nSHinJiAL1rwT1bLj1NpnPaRyWGmaeeFCrredCaS/L5qBtQCql5m
         F3rUf/4ueFl+flu5h1qMbtRYq+vnVGfqRcS9rgiHmLWxwd1NQO+KufKc6watS30kdETz
         a71g==
X-Gm-Message-State: AOAM533J1J7vHiUIaCrXLeJiKcALdcN5+E6thQz0+Vv+3qChMWSvTkNL
        FWypn3Lgi8Mb7aoce9DZ1oMQg1TZaZF/dCYbSOU=
X-Google-Smtp-Source: ABdhPJybaRX5evQllBiQhhyYB9nkofqWM3vZiIV4K6O32QwQjTOatu1GxVGoE8o6fdzpFN0bJ5EpUR0Ij4COagGF+yk=
X-Received: by 2002:a63:a847:: with SMTP id i7mr28056425pgp.203.1620220943413;
 Wed, 05 May 2021 06:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210504174019.2134652-1-linux@roeck-us.net> <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net> <20210505093235.00007c38@Huawei.com>
 <20210505093438.00005238@Huawei.com>
In-Reply-To: <20210505093438.00005238@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 May 2021 16:22:07 +0300
Message-ID: <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on CONFIG_ACPI
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 5, 2021 at 11:36 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Wed, 5 May 2021 09:32:35 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > On Tue, 4 May 2021 11:00:52 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:

+Cc: Paul (I hope you are related to coreboot somehow and can
communicate this further), Pavel and Jacek (LED subsystem suffered
with this as well), Hans, Rafael and linux-acpi@

> > Dropping the ones we are fairly sure are spurious is even better!
>
> If I get bored I'll just do a scrub of all the instances of this that
> you haven't already cleaned up.  It's worth noting that we do
> know some highly suspicious looking entries are out there in the wild.

I have counted ~60 users of acpi_device_id in IIO. Brief looking at
the IDs themselves rings an alarm about half of them.

So, here we may have a chicken and egg problem, i.e. somebody has been
using (or used) fake IDs from Linux kernel in the real products. What
I can consider as a course of action is the following:
1. Clean up (by removing as quickly as possible) the IDs that have no
proof to be real from the Linux kernel sources (perhaps marked as
stable material)
2. Notify ASWG / UEFI forum about all IDs that abuse ACPI
specification and are in Linux kernel, so at least we can keep some
kind of "reserved/do not use" list on the official level (Rafael?)
3. Do not accept any IDs without an evidence provided that they are
being in use in the real products (this should be done on Linux
maintainer level in all subsystems that accept drivers


-- 
With Best Regards,
Andy Shevchenko
