Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17C2C053E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgKWMLL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgKWMLL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 07:11:11 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EF1C0613CF;
        Mon, 23 Nov 2020 04:11:11 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id z14so13904442ilm.10;
        Mon, 23 Nov 2020 04:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkwXoscxfVMgFXW8sU2dhVSQq0DaKU8Mtd8+I+xSo1Y=;
        b=B5TCWop1RL+yamQ8mVo9tic4SCD4duvpxcX2JYlFI0uj2nMthitwsACCXsXI3E5MEz
         CF/IJum1gQP4eZ9x3GlyX6PCi1/N2o7zs1KpjHCQIk2YoWMkTO0Lj+TMqnH60YCNmn8r
         x/og0ESbgvTXf/aTVTKlhLqO7h7+CSS0Z0jkJzqCZ0DFcKDDI4KOGLlDmPVeez7bIeh5
         N4/CQTdJ38Cwa8uTtvAITeUMYRCshCD5Z+0MfIdmYaRMMZ1O3B7UOuSWr2vS9BFAdaJr
         zAkkgwqwwgsNT/lv0kf9CvOPOPKMIJU0ewRkgAfgLnbuq8T5YSc3K1QUJrPWqGm6uGFK
         +snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkwXoscxfVMgFXW8sU2dhVSQq0DaKU8Mtd8+I+xSo1Y=;
        b=VKLRzKwU2iG91jYVzIsk96dzD2E0o56cbobNBAPJjPCh/TtKPSpNTCe8Y6FNQpPdHG
         oomgJkCF1jLz1lMf9kR0bOUqUs0q17Bt1Sp4HELgQVUAMCG4e/PrN4ERs91fkkYJhbv7
         lEu74GIirRjrDI14YrdyfAKTdNAUAGrP/BEh10je/ddsmDdklIvdOI8qSIlsWngXMbbt
         0m7RSxiTP83H8gnEatbzhT3efwc9qKA/oaw7hTRGW5fMRrSwVajm0MgoKuSzSF/tVCC+
         TL3WWVD+B0vg+8/6UpC55GTiz9hmJgZ6qgFNkozMkNMyOqblry7kQmUTreaaFFQjmL7M
         ZSzw==
X-Gm-Message-State: AOAM531v06iTcnBJFXppTxXKWvnTaZOxaD5SyEaQhMCaoACL8oNBkkf3
        zHhVEvhsd9oNtYj19sqsYkYYu4WqKJGImtDxABg=
X-Google-Smtp-Source: ABdhPJzx7jUWDZF5m5Jg6CRSYyy7tMHfMeDsrT0H23MmIS0MTkI5xTkALmFsArN8RNH8jlGSkiKMNZRMwSlbAo4KPZs=
X-Received: by 2002:a92:8707:: with SMTP id m7mr34089725ild.217.1606133470524;
 Mon, 23 Nov 2020 04:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
 <20201117162340.43924-2-alexandru.ardelean@analog.com> <20201121180246.772ad299@archlinux>
In-Reply-To: <20201121180246.772ad299@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 23 Nov 2020 14:10:59 +0200
Message-ID: <CA+U=DsqPARWnGo4cvfN+dLTmcoP0eNtRxvF41bysuPgWAMd=sA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/12] iio: core: register chardev only if needed
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 8:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 18:23:29 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > We only need a chardev if we need to support buffers and/or events.
> >
> > With this change, a chardev will be created only if an IIO buffer is
> > attached OR an event_interface is configured.
> >
> > Otherwise, no chardev will be created, and the IIO device will get
> > registered with the 'device_add()' call.
> >
> > Quite a lot of IIO devices don't really need a chardev, so this is a minor
> > improvement to the IIO core, as the IIO device will take up (slightly)
> > fewer resources.
> >
> > In order to not create a chardev, we mostly just need to not initialize the
> > indio_dev->dev.devt field. If that is un-initialized, cdev_device_add()
> > behaves like device_add().
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> I'll be honest. I have no idea why I didn't do this in first place!
>
> I 'think' we are safe dropping this but I suppose it's possible some
> odd code checks for the chrdev presence?

So, libiio at least doesn't rely on this being there for any odd things.
But yeah, who knows what else is out there that might.
I was also thinking of sending this separately to have this earlier
out there in case it bothers other people.
I guess I got a little mixed by other patches and re-ordered things a
few times and this remained in this series.

>
> Hopefully not though.
>
> Jonathan
>
> > ---
> >  drivers/iio/industrialio-core.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 419d6f8acc13..ca8b11541477 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1763,6 +1763,15 @@ static const struct file_operations iio_buffer_fileops = {
> >       .compat_ioctl = compat_ptr_ioctl,
> >  };
> >
> > +static const struct file_operations iio_event_fileops = {
> > +     .owner = THIS_MODULE,
> > +     .llseek = noop_llseek,
> > +     .unlocked_ioctl = iio_ioctl,
> > +     .compat_ioctl = compat_ptr_ioctl,
> > +     .open = iio_chrdev_open,
> > +     .release = iio_chrdev_release,
> > +};
> > +
> >  static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
> >  {
> >       int i, j;
> > @@ -1790,6 +1799,7 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
> >
> >  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
> >  {
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >       int ret;
> >
> >       if (!indio_dev->info)
> > @@ -1807,9 +1817,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
> >       if (ret < 0)
> >               return ret;
> >
> > -     /* configure elements for the chrdev */
> > -     indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
> > -
> >       iio_device_register_debugfs(indio_dev);
> >
> >       ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
> > @@ -1838,9 +1845,15 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
> >               indio_dev->setup_ops == NULL)
> >               indio_dev->setup_ops = &noop_ring_setup_ops;
> >
> > -     cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> > +     if (indio_dev->buffer)
> > +             cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> > +     else if (iio_dev_opaque->event_interface)
> > +             cdev_init(&indio_dev->chrdev, &iio_event_fileops);
> >
> > -     indio_dev->chrdev.owner = this_mod;
> > +     if (indio_dev->buffer || iio_dev_opaque->event_interface) {
> > +             indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
> > +             indio_dev->chrdev.owner = this_mod;
> > +     }
> >
> >       ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
> >       if (ret < 0)
>
