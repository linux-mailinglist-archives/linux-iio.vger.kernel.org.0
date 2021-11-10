Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F282944C5B4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 18:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhKJRHs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 12:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhKJRHs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Nov 2021 12:07:48 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A8BC061764;
        Wed, 10 Nov 2021 09:05:00 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 13so6560053ljj.11;
        Wed, 10 Nov 2021 09:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZ1Zl46xEZQDGHVO4B1TxjrGhlKCxJ4w4SjGu0D6fHk=;
        b=gMl53kRifDnyOXBEmqc2rS3j2CJi4CTk6mbenQ2nClx/ZrA3OMyT8RpLruWFfHGXt8
         cjvacfW0ZBNqM9QNV5JiD/dlzNXo4bYZSVQDYYr5IpQIXc7nm4xJm5tu/+w5H9bO9/je
         hY6RmnYaRiZyyl23ifJd6iS7tNGk7LUcJrVjwvWy9A/14rroSUVARFqp/ELbRHyTMAyF
         VyzKUQ+3Qu/vwiK6xcfg4sVvHHjWMeX5bR6FkFDUzIVGpic/CL7gyAOfnfEeHROK5Q8w
         V62sVYF2/ddX/JTwGK7en6LtNEFMtgI1Cfri/L2kFD5GxN5C3euxdGQAuOrxNTwSDbZb
         c0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZ1Zl46xEZQDGHVO4B1TxjrGhlKCxJ4w4SjGu0D6fHk=;
        b=QzQ/d1uk68FZcEUvuMBSbyhY5VnQ16+dT3mFj+KFy3YO3Yu3ANOoRn3r4tXiCyBaIk
         QWeO/tVp/Asj6AxWrtjvzA96SLXjnMpj+Agk7aR50xM4Nr6yqnhbD6U7YOTWh8M0Y8Wg
         UVQqlMTHOpL/oVs0Qo8n9WOMo1V5AjdMsarH4E21OmXou3D3Zod4kzrazAS8XfKg4tcX
         3h3VicJ/b5DATWg/caTFgALatjIXdVIfyswSaSy4BRGd1AyteBR6mMrrpojp821KQGGh
         fLtJ0ZrputC4Dhf2TtFCHuoojrmNUF33f4+O9qusa9/2mrdZ9XeTnKHYLDqzWYCBp7r0
         f8gw==
X-Gm-Message-State: AOAM533RV9lfmMOJty1YqxWUtTrsVDWzAKLOVimUEHLeKXEmHaQWTr98
        Ojy4nKvP6TTqlb1jFQDaqDg17kveU7xt2nuMpT8=
X-Google-Smtp-Source: ABdhPJwJnmkr6d7fuImEGD4NV4cjsFo+YJ+wFedBnB1RYFcqsr4CHdHdYFy6pl1MpKliBr7HkZG3kfmpGYcXmGcPcxI=
X-Received: by 2002:a2e:2f1d:: with SMTP id v29mr410304ljv.439.1636563898700;
 Wed, 10 Nov 2021 09:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20211109200840.135019-1-puranjay12@gmail.com> <20211109200840.135019-2-puranjay12@gmail.com>
 <YYuIcPLx0uoUZ88B@smile.fi.intel.com>
In-Reply-To: <YYuIcPLx0uoUZ88B@smile.fi.intel.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 10 Nov 2021 22:34:43 +0530
Message-ID: <CANk7y0jRKVrTRZCzq0W1G7_Ef1QqF5yqKs==DwsR+xuhra3b4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] device property: Add fwnode_irq_get_byname()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, kuba@kernel.org,
        saravanak@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 10, 2021 at 2:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 10, 2021 at 01:38:39AM +0530, Puranjay Mohan wrote:
> > The fwnode framework did not have means to obtain the IRQ number from
> > the name of a node.
> > Add that now, in form of the fwnode_irq_get_byname() function.
>
> ...
>
> > +int fwnode_irq_get_byname(struct fwnode_handle *fwnode, const char *name)
> > +{
> > +     int index;
> > +
> > +     if (unlikely(!name))
> > +             return -EINVAL;
>
> > +     index = fwnode_property_match_string(fwnode, "interrupt-names", name);
> > +     if (index < 0)
> > +             return index;
>
> It won't work like this. The ACPI table quite likely won't have this in them.
> Also it doesn't cover the GPIO interrupts in ACPI case.
>
> > +     return fwnode_irq_get(fwnode, index);
>
> Neither this covers GPIO IRQs.
>
> > +}
> > +EXPORT_SYMBOL(fwnode_irq_get_byname);
>
> So, first you need to provide a design for this how ACPI cases can be handled.
>
> Imagine these cases (at least) for _CRS method in ACPI:
>   1/ Single GSI
>
>         Interrupt()
>
>   2/ Single GPIO IRQ
>
>         GpioInt()
>
>   3/ Both in different orders
>     a)
>         Interrupt()
>         GpioInt()
>
>     b)
>         GpioInt()
>         Interrupt()
>
>   4/ Mixed (complicated cases)
>
>         Interrupt()
>         Interrupt()
>         GpioInt()
>         Interrupt()
>         GpioInt()
>
> Obvious question, what does the index mean in all these cases?
>
> Next one is, how can we quirk out the platforms with the old ACPI tables
> where no properties are provided? For GPIO there is struct acpi_gpio_params
> which goes deep into ACPI glue layer.
>
> Luckily, the GPIO IRQ case has already available APIs for indexing and naming
> match: acpi_dev_gpio_irq_get_by().
>
> Hence, the main task is to define index in cases like 4 and see what can be
> done for the GSI cases.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Hi Andy,
I wrote this function keeping the device tree in mind. I will have to
look into ACPI and see how the cases you mentioned can be implemented.
Let's see how far I can get with understanding the ACPI.

-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
