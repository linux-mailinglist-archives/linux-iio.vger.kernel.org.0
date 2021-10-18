Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A631F4310F4
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhJRHFs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 03:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRHFr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 03:05:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EFAC06161C;
        Mon, 18 Oct 2021 00:03:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l6so10547224plh.9;
        Mon, 18 Oct 2021 00:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WKS3UWTvHLltEevv16ivDfoiU4SB6jGAHtOvmnbIXY=;
        b=kDrIC2srxuZa87Qhh22XaAV+r/5Lj7GxtBPY2LhSj9gHO8/euF+1dXwPCjQhU5GiIl
         GTEqwE1ViBOtkU49iwrUJMEgxD1ALCYB/nLU99ASOKfWQI2+UQqjGkr5toeMDMC+Xt7E
         YFoXM69CX7K3DYwIIJcvFbyymg3Q6B7HUIDhB5+JLd8OISYNdGaGhjaT1Sv1dBeeocdW
         qDRFmdHBTfNQ38/+YGm7HkG8OM2OyJw8S3w8VxZBscY9umeZsnz+ms8HKH/SF0UVBSk7
         EUemL2WeKLoYmPsBtFBaAD5bWN3c0j94zcbRnbQ+xha/Fs5YRpFG7ljax/vH8fuohEFh
         bBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WKS3UWTvHLltEevv16ivDfoiU4SB6jGAHtOvmnbIXY=;
        b=5M1+esjNuJMfYJJI75MFYOgfZot4VkIrnLRUhR1BH3NGcNUo004tDjdgb7QfkQ0Zic
         pI+KbVeKN872u35ma7WJJxmjEH/Qq6xlpitLAeSuyXLIKEySA7WeQZscse7KUSbAxp5v
         5OssJMExcD+lrGeEuvWQFzG9SItRZGauTg2K4JiRUbwTjyJauiOIDYM2K1bZ1D/fzDN3
         H/uMSI1RZg4lqyMEaRYrRBcD/UNcPKzCMiD3bsOHjZgF3iyaafSYBCkP/jLNWEfxAeRY
         FcLNcyM/DenHQyKFxYue6d4ZidodS3/ZAgacFZDfWThFp7RRFV4TiJikrSzgzd7VFN+0
         uCqw==
X-Gm-Message-State: AOAM530qyyDT5RGB+8cmFEVui51HQRB626XpOf9g4OgcontSeVxDiOx8
        2AEuvH63zw4Goz+OvukgEZzFBbaZ2EWfISf1YSY=
X-Google-Smtp-Source: ABdhPJxYDgbrokDoO5rLtqxq6J2hLyCUG+O60Qpp4BAQ7IgO/ryoW41n26ljrDT3KpL1wzinTdnTDnQ+GnmxPeOLEwE=
X-Received: by 2002:a17:90a:7d11:: with SMTP id g17mr31658613pjl.150.1634540616425;
 Mon, 18 Oct 2021 00:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211013094343.315275-1-yangyingliang@huawei.com> <20211017151623.47a66ea9@jic23-huawei>
In-Reply-To: <20211017151623.47a66ea9@jic23-huawei>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 18 Oct 2021 10:03:25 +0300
Message-ID: <CA+U=DspGn7m8wz=a3Dr6VdD57DNc=+tS-fGZmr7m_JcEYADwdg@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix memory leak in __iio_buffer_alloc_sysfs_and_mask()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 17, 2021 at 5:12 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 13 Oct 2021 17:43:43 +0800
> Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> > When iio_buffer_wrap_attr() returns NULL or buffer->buffer_group.name alloc
> > fails, the 'attr' which is allocated in __iio_buffer_alloc_sysfs_and_mask()
> > is not freed, and cause memory leak.
> >
> > unreferenced object 0xffff888014882a00 (size 64):
> >   comm "i2c-adjd_s311-8", pid 424, jiffies 4294907737 (age 44.396s)
> >   hex dump (first 32 bytes):
> >     00 0f 8a 15 80 88 ff ff 00 0e 8a 15 80 88 ff ff  ................
> >     80 04 8a 15 80 88 ff ff 80 05 8a 15 80 88 ff ff  ................
> >   backtrace:
> >     [<0000000021752e67>] __kmalloc+0x1af/0x3c0
> >     [<0000000043e8305c>] iio_buffers_alloc_sysfs_and_mask+0xe73/0x1570 [industrialio]
> >     [<00000000b7aa5a17>] __iio_device_register+0x483/0x1a30 [industrialio]
> >     [<000000003fa0fb2f>] __devm_iio_device_register+0x23/0x90 [industrialio]
> >     [<000000003ab040cf>] adjd_s311_probe+0x19c/0x200 [adjd_s311]
> >     [<0000000080458969>] i2c_device_probe+0xa31/0xbe0
> >     [<00000000e20678ad>] really_probe+0x299/0xc30
> >     [<000000006bea9b27>] __driver_probe_device+0x357/0x500
> >     [<00000000e1df10d4>] driver_probe_device+0x4e/0x140
> >     [<0000000003661beb>] __device_attach_driver+0x257/0x340
> >     [<000000005bb4aa26>] bus_for_each_drv+0x166/0x1e0
> >     [<00000000272c5236>] __device_attach+0x272/0x420
> >     [<00000000d52a96ae>] bus_probe_device+0x1eb/0x2a0
> >     [<00000000129f7737>] device_add+0xbf0/0x1f90
> >     [<000000005eed4e52>] i2c_new_client_device+0x622/0xb20
> >     [<00000000b85a9c43>] new_device_store+0x1fa/0x420
> >
> > This patch fix to free it before the error return.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> > Fixes: d9a625744ed0 ("iio: core: merge buffer/ & scan_elements/ attributes")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>
> Good find.  This function is clearly trying to do too many things and hence has become
> rather error prone.  Still fixing that is a job for another day.
>
> Alex, if you have a chance to take a look at this as well it would be great.
> In the meantime I've queued it up in the fixes-togreg branch of iio.git

Yeah, this fix looks good.
It took me a while to follow the change.

No need to add my tag [anywhere] since this was sent already.

Looking at all these leak fixes coming in, I'm wondering where my head
was at, when doing these changes.

Thanks
Alex

>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/industrialio-buffer.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 547a92d469ae..ae0912a14578 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1536,6 +1536,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >                      sizeof(struct attribute *) * buffer_attrcount);
> >
> >       buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
> > +     buffer->buffer_group.attrs = attr;
> >
> >       for (i = 0; i < buffer_attrcount; i++) {
> >               struct attribute *wrapped;
> > @@ -1543,7 +1544,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >               wrapped = iio_buffer_wrap_attr(buffer, attr[i]);
> >               if (!wrapped) {
> >                       ret = -ENOMEM;
> > -                     goto error_free_scan_mask;
> > +                     goto error_free_buffer_attrs;
> >               }
> >               attr[i] = wrapped;
> >       }
> > @@ -1558,8 +1559,6 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >               goto error_free_buffer_attrs;
> >       }
> >
> > -     buffer->buffer_group.attrs = attr;
> > -
> >       ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
> >       if (ret)
> >               goto error_free_buffer_attr_group_name;
>
