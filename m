Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E22C3F76
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKYMAG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 07:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYMAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 07:00:06 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D8C0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 04:00:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n137so2115058pfd.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 04:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1MZX2kO/lwUt0kjn+/TdOgw3NF82LKzQ4NSzhlbbVdE=;
        b=Zcbb4GwjeIM/avqE1OzzTCnOqj6P+PNihMV6Lce6ywnQKGedzG+xV+Z+LsIfNL41Fi
         Ni6jl4bWcAylXQgax1nZeBZD3c3ceI3Gxn6Ypha6tYXZktxbhEuiWagNi99BQrC2R8/v
         1Xf9TfL0tv+euiCAQrGsVxVAldEniXp+ZZgirIDcseQAQ8Na+MTeCK2QkWaVsLRnDzCA
         gDS0Qj5XBpkUt8JfvkIg24xu2OzQmtsqqwmzC6VNJEbhqbH+ptOb6DofOlbZEUr35W64
         iNZpZdxBtsRAa1S5DgZIoiNCTPVJ4HfTXx0WuIddozF6zg9KW+lRqQQe45Wnaq/92JGh
         n2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MZX2kO/lwUt0kjn+/TdOgw3NF82LKzQ4NSzhlbbVdE=;
        b=byt8ZooVt9PQUoMum6N1BuxP5yOlc+ys90UtLOMFTdSo+KG0PRSeQ5dpzxEHroUKPq
         +p11oARCWns0wwDHxzRT518yM0eLCBG+cuoWb1wlAr1weUqHjzyIF2NsycEVJq7Hpl0h
         rirXl7kgHqCYymKGiYCKss9APURpB2+n40p2NlyOg9nMzHyE+ffBqFnmNVxULhElMhIo
         fJ+vUoUlAw3ARVZjSnPAJ+i6KSbU2BzvlZ86HN/Y6eOQobr/SFS90Ej3rXzFFmEoLHT7
         bUxnZ8QrHUzj+ZXjHLAHJO5/TcyQL3ZV4ICjnc6OB6cAMmR3wWJfBM98HYDHLndH6Cl/
         wgNw==
X-Gm-Message-State: AOAM5327GaG4ioMnkbIPACjDF5fL3yGgNlj4dJ3WETwqeSh2kUJE0RU3
        VXk6kHywad8jHx3oMgRCYB417WoLHWua/GzVl5w=
X-Google-Smtp-Source: ABdhPJyxl7xjT+faASrTZT92qQxNu+we3CS7jBjMesYsIFFmb3ACYEZ2S4xapA1lygSY3vSpKyVZNLIUQF+FSmx2moc=
X-Received: by 2002:a63:4511:: with SMTP id s17mr2852033pga.4.1606305605688;
 Wed, 25 Nov 2020 04:00:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vfz2P=U6CFY4824hPLSSDQNh4wATE_=JjA63fXyYCpsrQ@mail.gmail.com>
 <857bbb6c-1025-df6d-871d-f0fbcafb6ad8@metafoo.de>
In-Reply-To: <857bbb6c-1025-df6d-871d-f0fbcafb6ad8@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 14:00:54 +0200
Message-ID: <CAHp75VdZ1qG1yht_Wa_Npn8jv61ux+mWBeayd5x8uLOj2JarcA@mail.gmail.com>
Subject: Re: fake ACPI IDs in the drivers
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 1:47 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 11/25/20 12:14 PM, Andy Shevchenko wrote:

> > Recent discussion [1] [2] around faking ACPI ID in RTC subsystem and a
> > sudden check [3] (due to last Hans' patches related to ACPI based
> > systems) of IIO makes me wonder if we may start cleaning drivers from
> > faked ACPI IDs and establish a stricter rules for the ID table
> > entries.
> >
> > Thoughts?
>
> The cat is probably out of the bag.
>
> If there are systems shipping with those unregistered ACPI IDs we still
> have to support them.

Yes, but we can do our best to google for them and try other sources
(like contacts with vendor companies who can acknowledge if there were
an ID issued or not).

> I'd assume that most drivers that have a acpi_device_id table do have
> hardware that uses that ID and were not just cargo culted.
>
> For new drivers we should push back on unregistered IDs, but if there is
> hardware that uses them we have to take the patches.

Right. But at the same time we have to push the idea of proper IDs to
the vendor companies, so they won't abuse ACPI specification anymore.

-- 
With Best Regards,
Andy Shevchenko
