Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5A3273BC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 19:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhB1SFj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 13:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhB1SFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 13:05:39 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B4C06174A;
        Sun, 28 Feb 2021 10:04:58 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g9so12694815ilc.3;
        Sun, 28 Feb 2021 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTiJ+SSPzsh7FFfy/EXsqQv5iHSzQI6Qmwot/3GX6qo=;
        b=TKTjpSoZGt8vOzS7Yocmq/ZEOtJCObqU+JvvM1hp024NKuCyNN5tKOiJ3k474pQhuN
         fx3cbHEsH9iVZ6KYistXDNiXD4AZJQAPNsxIeGe45X9BQLwWA9O3KQ+5i5NDJKuPl6HR
         lOsVvZYCGf1C3Gg0jZuVQupoixWMtlvZS5ikJ3Mi+5RIQYsTujsxjJM02Mq3zNLRbZmQ
         iol+YpWGGsVyjGdQo0HFYWpXiBZkRGQ6XJG2FKOiFjBbyF4ezHTo77I1UJAdVHITA5qm
         Gkvo4tvNDqPkCFj/dFqdw3n6qHHoAcfO2vD8Z8LT40Muw66mhovtd6efiHGpgW5TVDpF
         Bz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTiJ+SSPzsh7FFfy/EXsqQv5iHSzQI6Qmwot/3GX6qo=;
        b=GydbrZ8Uk8uCKLua+mRsYqo4muhFaT7eqEZoaIps6ZaKUlrH6Abs8LCyn1X1wIi4df
         zuyWQBnX6syOHQVRE7a4D7zeqhUdSXaWh0YoC/WsGy94eFdA3WWbiz4TVf1p5SJWAThN
         2gBFUwPaW+IZNurTTY50FLQFhToJ7NyAPhiKC3GEWt4zTqSHwU7xSxj+HKBx49E+VfOo
         Jpfj20lENy8Tkvyk+KVbOpWdXGgVcocoEsI2cbixLCsvoDlsbT5rx52Di9vUNpO8Nx8K
         qeY1X/Jw8ws9LhklwfnasShAN1IaYF8zX40v3EcLCySUR8Tj062dO4q5n85Rdmtfgowu
         8AhA==
X-Gm-Message-State: AOAM530GRpz38w8lQ3vIbJL1DQPt2QQcsyTn8fKxizGuE4km+yvkiThR
        5wZzcjlspCTXNlz0VPCvsukDS7T74IjIvjNizaI=
X-Google-Smtp-Source: ABdhPJxCZaClIHuK2Ils9sgxBmvT1U48hSTMWgKaoJkmBICknIcMISjMWW+TWxjrapdZC1kzrJi0cbbHneoulIpsCNk=
X-Received: by 2002:a92:d0c3:: with SMTP id y3mr10108711ila.303.1614535497737;
 Sun, 28 Feb 2021 10:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-21-alexandru.ardelean@analog.com> <d0d2aece-e333-bd87-ad0a-60cf3e387ae4@metafoo.de>
In-Reply-To: <d0d2aece-e333-bd87-ad0a-60cf3e387ae4@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 28 Feb 2021 20:04:45 +0200
Message-ID: <CA+U=DsouFQbPtwfmVXojcm=QhxOqSdEBtm1dTux49ob0YEBcWg@mail.gmail.com>
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 28, 2021 at 9:58 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
> > [...]
> >   /**
> >    * iio_buffer_wakeup_poll - Wakes up the buffer waitqueue
> >    * @indio_dev: The IIO device
> > @@ -1343,6 +1371,96 @@ static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
> >       kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
> >   }
> >
> > [...]
> > +static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg)
> > +{
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +     int __user *ival = (int __user *)arg;
> > +     struct iio_dev_buffer_pair *ib;
> > +     struct iio_buffer *buffer;
> > +     int fd, idx, ret;
> > +
> > +     if (copy_from_user(&idx, ival, sizeof(idx)))
> > +             return -EFAULT;
>
> If we only want to pass an int, we can pass that directly, no need to
> pass it as a pointer.
>
> int fd = arg;

I guess I can simplify this a bit.

>
> > +
> > +     if (idx >= iio_dev_opaque->attached_buffers_cnt)
> > +             return -ENODEV;
> > +
> > +     iio_device_get(indio_dev);
> > +
> > +     buffer = iio_dev_opaque->attached_buffers[idx];
> > +
> > +     if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->flags)) {
> > +             ret = -EBUSY;
> > +             goto error_iio_dev_put;
> > +     }
> > +
> > +     ib = kzalloc(sizeof(*ib), GFP_KERNEL);
> > +     if (!ib) {
> > +             ret = -ENOMEM;
> > +             goto error_clear_busy_bit;
> > +     }
> > +
> > +     ib->indio_dev = indio_dev;
> > +     ib->buffer = buffer;
> > +
> > +     fd = anon_inode_getfd("iio:buffer", &iio_buffer_chrdev_fileops,
> > +                           ib, O_RDWR | O_CLOEXEC);
>
> I wonder if we need to allow to pass flags, like e.g. O_NONBLOCK.
>
> Something like
> https://elixir.bootlin.com/linux/latest/source/fs/signalfd.c#L288

Umm, no idea.
I guess we could.
Would a syscall make more sense than an ioctl() here?
I guess for the ioctl() case we would need to change the type (of the
data) to some sort of

struct iio_buffer_get_fd {
      unsigned int buffer_idx;
      unsigned int fd_flags;
};

Or do we just let userspace use fcntl() to change flags to O_NONBLOCK ?

>
> > +     if (fd < 0) {
> > +             ret = fd;
> > +             goto error_free_ib;
> > +     }
> > +
> > +     if (copy_to_user(ival, &fd, sizeof(fd))) {
> > +             put_unused_fd(fd);
> > +             ret = -EFAULT;
> > +             goto error_free_ib;
> > +     }
>
> Here we copy back the fd, but also return it. Just return is probably
> enough.

Hmm.
Yes, it is a bit duplicate.
But it is a good point. Maybe we should return 0 to userspace.

>
> > +
> > +     return fd;
> > +
> > +error_free_ib:
> > +     kfree(ib);
> > +error_clear_busy_bit:
> > +     clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> > +error_iio_dev_put:
> > +     iio_device_put(indio_dev);
> > +     return ret;
> > +}
> > [...]
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index b6ebc04af3e7..32addd5e790e 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -9,6 +9,7 @@
> >    * @event_interface:                event chrdevs associated with interrupt lines
> >    * @attached_buffers:               array of buffers statically attached by the driver
> >    * @attached_buffers_cnt:   number of buffers in the array of statically attached buffers
> > + * @buffer_ioctl_handler:    ioctl() handler for this IIO device's buffer interface
> >    * @buffer_list:            list of all buffers currently attached
> >    * @channel_attr_list:              keep track of automatically created channel
> >    *                          attributes
> > @@ -28,6 +29,7 @@ struct iio_dev_opaque {
> >       struct iio_event_interface      *event_interface;
> >       struct iio_buffer               **attached_buffers;
> >       unsigned int                    attached_buffers_cnt;
> > +     struct iio_ioctl_handler        *buffer_ioctl_handler;
>
> Can we just embedded this struct so we do not have to
> allocate/deallocate it?

Unfortunately we can't.
The type of ' struct iio_ioctl_handler ' is stored in iio_core.h.
So, we don't know the size here. So we need to keep it as a pointer
and allocate it.
It is a bit of an unfortunate consequence of the design of this
generic ioctl() registering.

>
> >       struct list_head                buffer_list;
> >       struct list_head                channel_attr_list;
> >       struct attribute_group          chan_attr_group;
>
>
