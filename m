Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6651368DC4
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 09:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhDWHSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 03:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHSa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 03:18:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB74C061574;
        Fri, 23 Apr 2021 00:17:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w10so34620579pgh.5;
        Fri, 23 Apr 2021 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEJFE5Us5nPbS8VEWlQXC5wzvw+D+TXLK0GefcXaYv8=;
        b=IKJ1RG5vaecp/cGk3HvxViaKDRbwmInxDthboLi0jjhj1Moh3I0uDZmW8OtgsfzNLn
         n4YJ60nUjpcFMaTRw0f6W751yPVU10vzbc4GWvjKOpliftZWj+gL0hvb/GsoElK3ZVZn
         f3+eglf1GJ2f1UotOqoMjW+oVt1Mn9Hg2qZf9DE9/kVqeExmaNgDbMrKJHuIinp2Exzi
         jY0DXrb3Fd8hrL2ldFxflaPQdQ4RRtvpXp+VQp7R3vVASmkiIU2FuIGyfJvOEFxMa//F
         9AMWbedbp4Y3M5FRG62VcmNDn/+7jDbC9VqEKaWafNltJf4PaMvZsIxZyMsFnfELz7GN
         zTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEJFE5Us5nPbS8VEWlQXC5wzvw+D+TXLK0GefcXaYv8=;
        b=gEoIKZftyrXHcT2Dq0xmbRBn2EVL80R2SbDRD03uuUDc8dd7OFi2baAb6aBGR1ummf
         v1Q9B6OOXhInAna6+WskvYfecCbwsCgB0RJW2cknntgwYylzTXtnqucFF2jTfiIt0prC
         IeUdWcvemq3tWEXQjQnv5cIzrSXg/PNKnywKTviwZ6MMnLsIf7TyKUNKBN9rgQ++PEB4
         OUk0tTu8RSFkMT4dphBRslUpIANH6W21KyLooLBDHaT/+DV/Qa/GPL4xohOTC2XLkPju
         pQGtVj/xlNf3SFRoNILIHpzCGxAwpASuAgyLypJHvP/Rc6nCvLqK+FlU8gdM2qpLbLMy
         IuBg==
X-Gm-Message-State: AOAM531TMR9p2BmEsvai4aMarkmVqKklgnsVrK2FdhiGhWGCVq3kQgaC
        vlSYJN/doILVhb3tztHyDZW6NJVKhEgMsNLDjrY=
X-Google-Smtp-Source: ABdhPJwRSC/hxnwubvl2jfYUaac1hIOjGjhJik/8DBca7tBqZTA2Xsl+AB55dAhz8nmdx5m0S5MExRZ6G39RmGSAs5Y=
X-Received: by 2002:a63:b515:: with SMTP id y21mr2513563pge.253.1619162273587;
 Fri, 23 Apr 2021 00:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210422201415.46378-1-tomasz.duszynski@octakon.com>
In-Reply-To: <20210422201415.46378-1-tomasz.duszynski@octakon.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 10:17:42 +0300
Message-ID: <CA+U=DsqQUse-cP7k+42reHPYfbAUMTsqLst5--BHKg53FhNbxg@mail.gmail.com>
Subject: Re: [PATCH] iio: core: fix ioctl handlers removal
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 22, 2021 at 11:26 PM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> Currently ioctl handlers are removed twice. For the first time during
> iio_device_unregister() then later on inside
> iio_device_unregister_eventset() and iio_buffers_free_sysfs_and_mask().
> Double free leads to kernel panic.
>
> Fix this by not touching ioctl handlers list directly but rather
> letting code responsible for registration call the matching cleanup
> routine itself.
>

This change is missing this tag:

Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")

With that tag added:
Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Apologies for the breakage.
Also, I wasn't sure if Jonathan or anyone else wanted to do this change.

Thanks for the patch
Alex

> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  drivers/iio/industrialio-core.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d92c58a94fe4..98944cfc7331 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1939,9 +1939,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>
>         indio_dev->info = NULL;
>
> -       list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
> -               list_del(&h->entry);
> -
>         iio_device_wakeup_eventset(indio_dev);
>         iio_buffer_wakeup_poll(indio_dev);
>
> --
> 2.31.1
>
