Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59FD2147F1
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 20:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGDSbp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgGDSbo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jul 2020 14:31:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB25EC061794
        for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2020 11:31:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so16534161pgq.1
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2020 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DO+/NhSLicJQvJ5BtYZ5vWXxLXlJcZ+s85+o3NNFEJQ=;
        b=Cx0kQHvU/1GGKaAQgLAYgbnbBONMVeYC9efIeRWlIByq8iQoSVXb8tZPxU582Odxr+
         lChqvR6UOExCShEe2Upk0chnbhc1kp9gOvxSiM1hpkzRCybQITITjNw8Fcnu7shqlbLp
         ng0RCuJd1Z13azG3kOmZ/A+2Gqvkctlxh4Gs+2FT9MXdiFfx61eVxELWpy5HXnPAeBWJ
         iQoJPVJKK3U7IB83SJsM8LiwQPqB+vqNEUqSklKmgPOlo1V4yNPlLwt5d2XScsn/ReGv
         sQVg3Tm0dx0EIwejPZU0UmAFt9Q6/fVn6/sAVWTJYISW3L1V161dKDfBF8gxcd2CVveV
         TWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DO+/NhSLicJQvJ5BtYZ5vWXxLXlJcZ+s85+o3NNFEJQ=;
        b=RjIHOdBxn7titHx7rJcccRCNM66X44i715v/05nDracBUfuX9gw+PGET4mFF4Oygsh
         OKk6IRs0h2J8UalC4R6bgaRvqBPVzT/GiaTcVPj2ihxGt2e9O3WJHVDqaXNOXsC4crlK
         xkPJmLlXtoP5dIdu0A+lpCtjcdJScaH6IsAmQyNhhumBWwsrmdpfi75a0A86qOzs1ClJ
         L9IJwMl5xKNuCnkur2RPifBOLovzxBFyKq5bNWVV+7jJbEEjmD8jBd96ScqRJ9I2dm6L
         EpyQkQfIXu2un3f/py8vx07D1aywhsB/6mX4RHzqsE+SqnmLLupOt6S5/PVinev0yxr0
         c+BA==
X-Gm-Message-State: AOAM530RxUEet8QJeJuq+War8UkbhK+i1hZM1bmz2cMs46PPz1z/28yR
        tVHkKewavX38r6rzEVgQgbSSzfUM4E9kXtRsiR3EYZNj
X-Google-Smtp-Source: ABdhPJxKzX1O0x+kcmLBaHAk+rKcA+hLFiTijmz6wxqSkwZaDGSHvZxGZKOxz++BnLYGy13coKYBG0LUFKIr3n9umM0=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr27787395pgn.4.1593887504285;
 Sat, 04 Jul 2020 11:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-16-jic23@kernel.org>
 <CAHp75VfMdv-VzHcbS75psjdWGOnR8bkO3vmE5Z82vAMiGZJYtQ@mail.gmail.com>
 <20200704164505.32b92957@archlinux> <20200704182609.694ef281@archlinux>
In-Reply-To: <20200704182609.694ef281@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Jul 2020 21:31:27 +0300
Message-ID: <CAHp75VfvBbq0OfJgut9gNvMWvyizPMXH5LHr2nje6noV5zopOQ@mail.gmail.com>
Subject: Re: [PATCH 15/23] iio:adc:ti-adc081c: Drop of_match_ptr and change to mod_devicetable.h
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan O'Donovan" <dan@emutex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 4, 2020 at 8:26 PM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On Sat, 4 Jul 2020 16:45:05 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 30 Jun 2020 10:12:51 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > >  #ifdef CONFIG_ACPI
> > > >  static const struct acpi_device_id adc081c_acpi_match[] = {
> > >
> > > These IDs seem to me artificial (and non-official). Perhaps in a
> > > separate patch remove them?
> > > Or do we have confirmation (in writing) from TI that these are okay?
> > +CC Dan O'Donovan,
> >
> > It seems highly unlikely these are 'official'.

+1 here.

> > Dan.  You added them, can you give us some background (admittedly
> > 4 years ago so you may not recall!)
> >
> > Unfortunately I was rather less aware of ACPI than I have become in
> > the meantime, so let these in without questioning them.
> >
> > If we have these out there in in the wild, we can still add a note
> > to make it clear that people should avoid using them in future,
> > or copying the approach in other drivers.
> >
> As this is a separate issue (kind of) I've applied this patch and
> we can address whether to remove the ACPI bindings separately.

Agree. Just to mention one more time that this shouldn't be forgotten.
Also we can ask somebody from TI.

-- 
With Best Regards,
Andy Shevchenko
