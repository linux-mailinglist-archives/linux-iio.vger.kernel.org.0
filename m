Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D8B3225FB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 07:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhBWGh6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 01:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhBWGhH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 01:37:07 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB65BC061574;
        Mon, 22 Feb 2021 22:36:27 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id a16so13143741ilq.5;
        Mon, 22 Feb 2021 22:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0hzFkkogd1ohgH5b2AdgPYEAmEMk6gxZMJuXty76/Y=;
        b=LlDJW1KHDVOi0+NUvxKBSkRBrBBfPRBXiJKnPwXYEj1pgeQ0clmTd3d4IY9xVJSuXf
         ehBIYbOG+WXbHAPE8qDf8CmTQ/12BYLHUeC8kcGn3LZ7Q0Big7E8SYc4ciZ8Wsxr8wCQ
         3goZXl46RIH5JuhVG0KVzr/OqXNXlS7QuOUDPJPNM6572JgX89MrzvbS3k31TWBMW+Kd
         vBDJ0Sf5Zjv1S0XihjmrRBJcc6ue19qCMCVoELQUJBjg8kezIdO1UEoibiDEi2A+w4rU
         AtpQbKbGnwhYksmBanxB0SApX7OnfxtqFgv8rFfpbNjfE0980U916i7CPg6ESYwZfaML
         yPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0hzFkkogd1ohgH5b2AdgPYEAmEMk6gxZMJuXty76/Y=;
        b=aDoFWgkDRdLYY0mlhWfcyRUB0fDpCE9uBez5WOup/n8dVmyfYxQwSAGZr0LOE0QMUs
         sfT42kWiHnGgwRCO7kanEa0XZFSaftzWfcZIaLIf6iYRUd6ZxVe/UoDE10R+meM5Jh2P
         uVy+3oW4eK06npZBWXcP846M+IJmFxeTS/0xld5+8fjHSCCjR/Ug5wBneNtl8Vvi+7Vk
         8NGIGauvaMeicsz3h7+3aiPp8zytANXsdCYwERfImDsBxgBca2lgYXtvYPj/M/YgsI9s
         FLESI/tnNmPxrtjxfhE++P+RLFIfv9Dh/S0fo/tbULpEOxAYastOu9iZ37U3cIoLka/l
         rxvA==
X-Gm-Message-State: AOAM533SpLwSNZMxv6+ACTfnoFCEq3Bzwr1m8rQkxW6/BdO5vJhxvfi0
        tT2S+661HE+NYQ+vI9GOhrLaT9ZKCXuEStOky8GsG6vzbKnznA==
X-Google-Smtp-Source: ABdhPJxHAEkr+UYvsr6QaZF7FwWyBe4zLx0GeVFjbvtAI/B9Tt8N2+X07QSYhfzvHAijAlWywP8uGcv8Q3NobvLhj6I=
X-Received: by 2002:a92:d30d:: with SMTP id x13mr18327296ila.217.1614062187233;
 Mon, 22 Feb 2021 22:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20210219085826.46622-1-alexandru.ardelean@analog.com>
 <20210219085826.46622-2-alexandru.ardelean@analog.com> <20210222160157.0000391e@Huawei.com>
In-Reply-To: <20210222160157.0000391e@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 23 Feb 2021 08:36:15 +0200
Message-ID: <CA+U=DsppzH8si6Jd3PryeN=EingGcsRAibE_7ayGA+V-d7e-0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: core: use kfree_const in iio_free_chan_devattr_list()
 to free names
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 22, 2021 at 6:06 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 19 Feb 2021 10:58:25 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > When the buffer attributes were wrapped in iio_dev_attr types, I forgot to
> > duplicate the names, so that when iio_free_chan_devattr_list() gets called
> > on cleanup, these get free'd.
> > I stumbled over this while accidentally breaking a driver doing
> > iio_device_register(), and then the issue appeared.
> >
> > The fix can be just
> > 1. Just use kstrdup() during iio_buffer_wrap_attr()
> > 2. Just use kfree_const() during iio_free_chan_devattr_list
> > 3. Use both kstrdup_const() & kfree_const() (in the places mentioned above)
> >
> > Using kfree_const() should be sufficient, as the attribute names will
> > either be allocated or be stored in rodata.
> >
> > Fixes: a1a11142f66c ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Thinking more on this...  It's fine for the users today, but there is
> nothing stopping a driver passing in names it allocated on the heap.  So
> I think we should revisit this.  Perhaps we need 1 or 3.

Ok.
Will re-send this as 3; that sounds like it gives the best of both worlds.

> > ---
> >  drivers/iio/industrialio-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 0d8c6e88d993..cb2735d2ae4b 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1358,7 +1358,7 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
> >       struct iio_dev_attr *p, *n;
> >
> >       list_for_each_entry_safe(p, n, attr_list, l) {
> > -             kfree(p->dev_attr.attr.name);
> > +             kfree_const(p->dev_attr.attr.name);
> >               list_del(&p->l);
> >               kfree(p);
> >       }
>
