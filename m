Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7C2147E3
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 20:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGDSQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDSQ5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jul 2020 14:16:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A0C061794
        for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2020 11:16:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so5816361pfc.6
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2020 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M76eKsFZBwycsP24RmvuJcGcxoR/QkLcAbrqdZ0YCRA=;
        b=HW+7lFth0vwmzQu/N5jbwpkBbnj3wp/Axs4NztDK82RYiEKGuf3mJT/1kvXxH0Vqlq
         Cmc9UxpjwLbtDyZw4tkySU0IAAucyLVtP0hUx9Oxdi0Zsdd/82kCrLMqnQamB/2J1ytJ
         4bKphXWbQFNY7pTGFjP3hhXdqKeo4NqUy8k6XLVdJLBIprJ3K5c93fKmZ6aGmGA00XV8
         Ckx1aGi76/Nijd1mLDEf/UkAoCr1AJqo47rCG6jXL+IkDUWvR901Xy8ypFVV9SW4kuuJ
         3VONKTAVIiRsWmfLM/7GPDhRLisQ9GLCMhEo3aSVdpcnv1+Mi4JsjENMgtXUK9esH0kQ
         7HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M76eKsFZBwycsP24RmvuJcGcxoR/QkLcAbrqdZ0YCRA=;
        b=ZuxVWQMJf9aFk++tw9tmD0BQ80NPUdGTt/FO3yVxkqulgT28BBQ3Yw3g5VSfX6/EQm
         pWfPnZDBlVlryHGg86NKKw2bTnnCNa+bWvWjzWKbG+kn6ZOSBGuW6Xt4Ix+8qjqcesQ2
         5KIAFvTMEug290zXn60ACaJXCuDsbiwSJH9Ixd3Ldu7XBBwMtt7vcXd94w3HH8qcJQXI
         u71I3Gf2ID/jv4h3BycZuTkEYOBxYAMncNADjALQRw2xxbMwViz3gnKTc1xOdeljUO1M
         8ArjwgRCGnxdheB0cslodi4WvAgwwhSOZc7B6h+P3kYqxFO2PhOLA5HTE0bRL/vIEyEj
         S1rw==
X-Gm-Message-State: AOAM533onwQ61yKfjd2QMcFbtK5/bW7Q72rubpFqJQI87OR0u9M0LXoT
        695OPmSeQxsimxVPU5jpVA5nVuHiEpI0tAsilKU=
X-Google-Smtp-Source: ABdhPJyJIW2GlM7NRSDwkxD/8qmDemFW++BbOb32S0hDY3JCXtNhS1KlEN37z30CMqagbMer5bxn7Q+0fic1J9uXwKg=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr10488769pgi.203.1593886616354;
 Sat, 04 Jul 2020 11:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-19-jic23@kernel.org>
 <CAHp75VeUqMHpF29RYwpRFACcs73pmtvpBt+nQL7V+J-_BJD0Tg@mail.gmail.com> <20200704165458.0fac4009@archlinux>
In-Reply-To: <20200704165458.0fac4009@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Jul 2020 21:16:40 +0300
Message-ID: <CAHp75VekF4y_f7S5JD7YwScrs_9a-yqGVBEAfaGM3s9W==5xuQ@mail.gmail.com>
Subject: Re: [PATCH 18/23] iio:adc:ti-adc108s102: Drop CONFIG_OF and
 of_match_ptr protections
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 4, 2020 at 6:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 30 Jun 2020 10:20:55 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Although this driver has an explicit ACPI binding it is good to also
> > > allow for PRP0001 use of the of_match_id table.
> > >
> > > I'm also trying to clean this (now) anti-pattern out of IIO to avoid
> > > cut and paste into new drivers.
> > >
> > > Also add an include of mod_devicetable.h as the driver directly uses
> > > struct of_device_id which is defined in there.
> > >
> >
> > I think this is not needed. At least the commit message in this case
> > is misleading.
> > We have only one ID and ACPI already has it. So, there is no need for
> > this patch from that perspective.
>
> It would be a bit odd if non Intel boards used an Intel ID for a TI
> part.  Particularly I as can't immediately find any public docs
> of the ID.  Do you know if these are documented publicly anywhere?

Unfortunately it's vendor specific stuff, only vendor prefixes are
documented on uefi.org.
And it's fine to use an already existing ID for the component from the
same company.
The thing is that this is a really discrete component from TI on Intel
Galileo board.

> I know we don't do this in an ideal fashion as we have an internal
> registry but I don't think we publish it anywhere, but then we don't
> really expect anyone else to use them. I'm not aware of us having
> issued IDs for parts made by anyone other than ourselves.
>
> So in general I'd rather we gave the option for using the dt binding
> PRP0001 route in addition to the intel ACPI ID.

I'm not against the clean up in code, but I don't think it is good to
encourage users to use PRP0001 when the ACPI ID is already allocated
(doesn't matter by whom).

So, I would recommend to leave the change, but rephrase the commit
message to avoid PRP0001 mentioning.

-- 
With Best Regards,
Andy Shevchenko
