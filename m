Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3860D301E74
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 20:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbhAXTdV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 14:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbhAXTdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2021 14:33:17 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8611C06174A;
        Sun, 24 Jan 2021 11:32:33 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h11so22208242ioh.11;
        Sun, 24 Jan 2021 11:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPd8O21ZZOvbjEYgBWnetiFxWUh+0m8AANloaGXhJqc=;
        b=c2Xrerhss+vhA2ZqEfcEIuPrV/BMLGTlGdwUoBp5RcMZmTR5I+HcbmP3aFJgFG4ZiE
         zBHKt2ZJA6sTq18UlISReZ5oy723fVhAWahWTS5MWJzY+Zvtlyy/s0PgIIWeks8nVRYT
         oCbvE4cP3RsusG0jiAkhDFhQSsvmICjdaFvgTBuGU/TiayqGpMPV1LAuwHryTDs9a6dx
         542fpsSWQhboUK3LM3voYJ/ybHfSCJmiruLX9oCFjj/rp+UdAVWU95x9dDUVb2RG8cOC
         dMNQCKnknd7tmWI0z4Ox+6Ip3zJKJQisdykIXdemQCLxycmwIdk6icbNoqNO+PCn3KF0
         J1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPd8O21ZZOvbjEYgBWnetiFxWUh+0m8AANloaGXhJqc=;
        b=GLiJU3kE0oHDagZkn7XcZnUZohi1bkIZOyAJdOJf0rKIHpwXXs9kle/CEJei39yWdy
         R05QkJgGONwTOxb2z3bRNM4/SjguvKx6tEVDCDNn2ucsfdD77wK+JX6xMghU5ttMmZCN
         t4FO/rCIjzklMtRckMrv2lkcOU+SrBJxnlp5kJ32EN1T6zjTElhafiSFdO/pEeFP2SQV
         cObyVyAkp+zeSf3BljIPjERVkqwDmTzdJyaekKleakrZaXGlgYnUPtTlYPo9Xist+Ta3
         CX4pWJfoFhjGPtPtbPbKW7Vm8GMXNToHuxesJa+yeAb7XptnjH5bgFPTkPWRGo2FESaP
         zTLg==
X-Gm-Message-State: AOAM530Xpn1u3YOr9uoLLyDVSPwx3BmtqKbHNshyQmhH1vVKbj3sTfKU
        A7EcEzxlsSVWctzmWuaGYRDRqDI0vXTQyuz95mk=
X-Google-Smtp-Source: ABdhPJxBiPQ/x7ORrcgc/ySQwBlHPOnjI/pTVnSlQ97MUp4/v7KprLXulTHX87OGAwZEf+J00Rvy/TuuXHnmZaNR+nI=
X-Received: by 2002:a05:6638:d0b:: with SMTP id q11mr779595jaj.88.1611516753037;
 Sun, 24 Jan 2021 11:32:33 -0800 (PST)
MIME-Version: 1.0
References: <20210122162529.84978-1-alexandru.ardelean@analog.com>
 <20210122162529.84978-13-alexandru.ardelean@analog.com> <20210124183845.77b7e927@archlinux>
In-Reply-To: <20210124183845.77b7e927@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 24 Jan 2021 21:32:22 +0200
Message-ID: <CA+U=DsqpgtgmEUT+A=ywnab7y=3p+UwV9TLGc=Y8wykQK4XkBg@mail.gmail.com>
Subject: Re: [PATCH v2 12/12][RESEND] iio: buffer: add ioctl() to support
 opening extra buffers for IIO device
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 24, 2021 at 8:41 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 22 Jan 2021 18:25:29 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > With this change, an ioctl() call is added to open a character device for a
> > buffer.
> > The ioctl() will return a 0 FD for the first buffer, as that FD for buffer0
> > is the same FD as the one used for this ioctl().
> >
> > For any other extra buffer, this ioctl() will return an anon inode FD that
> > would access any extra buffer.
> >
> > Right now, there doesn't seem to be (or I couldn't find) a way for this
> > ioctl() to return the FD for buffer0 (i.e. to return the same FD as used
> > for the ioctl()).
> > So, usespace would need to know that  ioctl(fd,
> > IIO_BUFFER_GET_BUFFER_COUNT, 0) will return FD 0.

Just noticed a copy+paste error here.
This should be IIO_BUFFER_GET_FD_IOCTL

> > We could also return another FD for buffer 0, but duplicating FDs for the
> > same IIO buffer sounds problematic.
>
> Agreed. For now this is fine.  Userspace doing that request is a bit
> odd in general even if I can see it might be convenient.

I fully agree that this would make userspace convenient.
It was my initial thought when doing the v1 (or RFC) but I could not
find a sane way to do it.

>
> Hohum. Now in theory ioctl numbers should be added to
> Documentation/userspace-api/ioctl/ioctl-number.rst but oops
> seems I never added the one we already use.
>
> Seems no one is using the block we are though so should be fine.
> If you fancy adding this one and the event one we already have that would be great.

Normally I don't shy away from doing requests, but I may defer this one.
Will see if I can squeeze in this one though.

> Perhaps we are allowing a bit too much space though given the
> event one is down at 'i', 0x90 and this is 'i', 0xB0

So, the only reason for jumping to 0xb0 is because internally ADI, is
using 0xa0 (and a few) for some non-upstream buffer ioctls:
See
https://github.com/analogdevicesinc/linux/blob/master/include/linux/iio/buffer_impl.h#L12
and
https://github.com/analogdevicesinc/libiio/blob/master/local.c#L51

So, libiio is dependent on these non-mainline ioctls.
I am fine to change these addresses to anything else that doesn't
overlap with 0xa0.
GNU Radio is using those ioctls (0xa0) for some AD9361 stuff.
As well as other ADI customers using other high-speed
ADC/DAC/transceiver boards (usually from ADI, because they're using
the ADI kernel).
Well, bringing up GNU Radio makes for a stronger case :)

>
> We'll probably hit something undocumented anyway ;)
>
> So from a fairly light level of read through this seems to have come together
> nicely. I'm a bit nervous about the sysfs kobject stuff, but it seems there
> are other places where similar stuff happens so if Rafael and Greg don't come
> back with major comments that should be fine.

[1] My preference would have been to have a "/dev/iio/deviceX/bufferY"
similar to the input subsystem.
I think I am with Lars (on this; well, I hope I am not wrong) that
using dd/cat/echo directly on the buffer chardev would be interesting.

I am also fine with this.
And from a backwards compatibility perspective this is pretty good (a
bit better than [1]).
I agree that the sysfs kobject stuff is tricky; and also the stuff
about getting the FD for buffer 0 via this new ioctl() is also quirky.
But I heard an interesting quote from a colleague (it may be his or
maybe he also heard it from somewhere else):
"Darn compromises... but that's engineering. If you don't want to make
compromises in your career - theology or pure mathematics are better
choices :)"  - Mark Thoren

[i enjoyed that comment when i first heard it :) ]

>
> Jonathan
>
> >
> > Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl() implemented, as the
> > index for each buffer (and the count) can be deduced from the
> > '/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the number of
> > bufferY folders).
> >
> > Used following C code to test this:
> > -------------------------------------------------------------------
> >
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <unistd.h>
> >  #include <sys/ioctl.h>
> >  #include <fcntl.h"
> >  #include <errno.h>
> >
> >  #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0xb0, int)
> >
> > int main(int argc, char *argv[])
> > {
> >         int fd;
> >         int fd1;
> >         int ret;
> >
> >         if ((fd = open("/dev/iio:device0", O_RDWR))<0) {
> >                 fprintf(stderr, "Error open() %d errno %d\n",fd, errno);
> >                 return -1;
> >         }
> >
> >         fprintf(stderr, "Using FD %d\n", fd);
> >
> >         fd1 = atoi(argv[1]);
> >
> >         ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
> >         if (ret < 0) {
> >                 fprintf(stderr, "Error for buffer %d ioctl() %d errno %d\n", fd1, ret, errno);
> >                 close(fd);
> >                 return -1;
> >         }
> >
> >         fprintf(stderr, "Got FD %d\n", fd1);
> >
> >         close(fd1);
> >         close(fd);
> >
> >         return 0;
> > }
> > -------------------------------------------------------------------
> >
> > Results are:
> > -------------------------------------------------------------------
> >  # ./test 0
> >  Using FD 3
> >  Got FD 0
> >
> >  # ./test 1
> >  Using FD 3
> >  Got FD 4
> >
> >  # ./test 2
> >  Using FD 3
> >  Got FD 4
> >
> >  # ./test 3
> >  Using FD 3
> >  Got FD 4
> >
> >  # ls /sys/bus/iio/devices/iio\:device0
> >  buffer  buffer0  buffer1  buffer2  buffer3  dev
> >  in_voltage_sampling_frequency  in_voltage_scale
> >  in_voltage_scale_available
> >  name  of_node  power  scan_elements  subsystem  uevent
> > -------------------------------------------------------------------
> >
> > iio:device0 has some fake kfifo buffers attached to an IIO device.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/industrialio-buffer.c | 119 ++++++++++++++++++++++++++++++
> >  drivers/iio/industrialio-core.c   |   8 ++
> >  include/linux/iio/buffer_impl.h   |   5 ++
> >  include/linux/iio/iio-opaque.h    |   2 +
> >  include/uapi/linux/iio/buffer.h   |  10 +++
> >  5 files changed, 144 insertions(+)
> >  create mode 100644 include/uapi/linux/iio/buffer.h
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 2f429616e998..e619ec35c431 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -9,6 +9,7 @@
> >   * - Better memory allocation techniques?
> >   * - Alternative access techniques?
> >   */
> > +#include <linux/anon_inodes.h>
> >  #include <linux/kernel.h>
> >  #include <linux/export.h>
> >  #include <linux/device.h>
> > @@ -1399,6 +1400,106 @@ static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
> >               sysfs_remove_file(kobj, ptr[i]);
> >  }
> >
> > +static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
> > +{
> > +     struct iio_dev_buffer_pair *ib = filep->private_data;
> > +     struct iio_dev *indio_dev = ib->indio_dev;
> > +     struct iio_buffer *buffer = ib->buffer;
> > +
> > +     clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> > +     iio_device_put(indio_dev);
> > +     kfree(ib);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct file_operations iio_buffer_chrdev_fileops = {
> > +     .owner = THIS_MODULE,
> > +     .llseek = noop_llseek,
> > +     .read = iio_buffer_read_outer_addr,
> > +     .poll = iio_buffer_poll_addr,
> > +     .compat_ioctl = compat_ptr_ioctl,
> > +     .release = iio_buffer_chrdev_release,
> > +};
> > +
> > +static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg)
> > +{
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +     int __user *ival = (int __user *)arg;
> > +     char buf_name[sizeof("iio:buffer:xxx")];
> > +     struct iio_dev_buffer_pair *ib;
> > +     struct iio_buffer *buffer;
> > +     int fd, idx;
> > +
> > +     if (copy_from_user(&idx, ival, sizeof(idx)))
> > +             return -EFAULT;
> > +
> > +     if (idx == 0) {
> > +             fd = 0;
> > +             if (copy_to_user(ival, &fd, sizeof(fd)))
> > +                     return -EFAULT;
> > +             return 0;
> > +     }
> > +
> > +     if (idx >= iio_dev_opaque->attached_buffers_cnt)
> > +             return -ENOENT;
> > +
> > +     fd = mutex_lock_interruptible(&indio_dev->mlock);
> > +     if (fd)
> > +             return fd;
> > +
> > +     buffer = iio_dev_opaque->attached_buffers[idx];
> > +
> > +     if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->flags)) {
> > +             fd = -EBUSY;
> > +             goto error_unlock;
> > +     }
> > +
> > +     iio_device_get(indio_dev);
> > +
> > +     ib = kzalloc(sizeof(*ib), GFP_KERNEL);
> > +     if (!ib) {
> > +             fd = -ENOMEM;
> > +             goto error_iio_dev_put;
> > +     }
> > +
> > +     ib->indio_dev = indio_dev;
> > +     ib->buffer = buffer;
> > +
> > +     fd = anon_inode_getfd(buf_name, &iio_buffer_chrdev_fileops,
> > +                           ib, O_RDWR | O_CLOEXEC);
> > +     if (fd < 0)
> > +             goto error_free_ib;
> > +
> > +     if (copy_to_user(ival, &fd, sizeof(fd))) {
> > +             fd = -EFAULT;
> > +             goto error_free_ib;
> > +     }
> > +
> > +     mutex_unlock(&indio_dev->mlock);
> > +     return fd;
> > +
> > +error_free_ib:
> > +     kfree(ib);
> > +error_iio_dev_put:
> > +     iio_device_put(indio_dev);
> > +     clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> > +error_unlock:
> > +     mutex_unlock(&indio_dev->mlock);
> > +     return fd;
> > +}
> > +
> > +static long iio_device_buffer_ioctl(struct iio_dev *indio_dev, struct file *filp,
> > +                                 unsigned int cmd, unsigned long arg)
> > +{
> > +     switch (cmd) {
> > +     case IIO_BUFFER_GET_FD_IOCTL:
> > +             return iio_device_buffer_getfd(indio_dev, arg);
> > +     default:
> > +             return IIO_IOCTL_UNHANDLED;
> > +     }
> > +}
> > +
> >  /**
> >   * __iio_buffer_alloc_sysfs_and_mask() - Allocate sysfs attributes to an attached buffer
> >   * @buffer: the buffer object for which the sysfs attributes are created for
> > @@ -1565,6 +1666,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >       struct iio_buffer *buffer = indio_dev->buffer;
> >       const struct iio_chan_spec *channels;
> >       int i, cnt, ret;
> > +     size_t sz;
> >
> >       channels = indio_dev->channels;
> >       if (channels) {
> > @@ -1597,8 +1699,21 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >       if (ret)
> >               goto error_remove_buffer_dir_link;
> >
> > +     sz = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));
> > +     iio_dev_opaque->buffer_ioctl_handler = kzalloc(sz, GFP_KERNEL);
> > +     if (!iio_dev_opaque->buffer_ioctl_handler) {
> > +             ret = -ENOMEM;
> > +             goto error_remove_scan_el_dir;
> > +     }
> > +
> > +     iio_dev_opaque->buffer_ioctl_handler->ioctl = iio_device_buffer_ioctl;
> > +     iio_device_ioctl_handler_register(indio_dev,
> > +                                       iio_dev_opaque->buffer_ioctl_handler);
> > +
> >       return 0;
> >
> > +error_remove_scan_el_dir:
> > +     sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
> >  error_remove_buffer_dir_link:
> >       sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
> >       cnt = iio_dev_opaque->attached_buffers_cnt - 1;
> > @@ -1627,6 +1742,10 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> >       if (!buffer)
> >               return;
> >
> > +     iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
> > +     kfree(iio_dev_opaque->buffer_ioctl_handler);
> > +     iio_dev_opaque->buffer_ioctl_handler = NULL;
> > +
> >       sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
> >       sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 0d1880837776..898992fd33c3 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1683,6 +1683,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
> >       ib->indio_dev = indio_dev;
> >       ib->buffer = indio_dev->buffer;
> >
> > +     if (indio_dev->buffer)
> > +             test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->buffer->flags);
> > +
> >       filp->private_data = ib;
> >
> >       return 0;
> > @@ -1700,6 +1703,11 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
> >       struct iio_dev_buffer_pair *ib = filp->private_data;
> >       struct iio_dev *indio_dev = container_of(inode->i_cdev,
> >                                               struct iio_dev, chrdev);
> > +     struct iio_buffer *buffer = ib->buffer;
> > +
> > +     if (buffer)
> > +             clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> > +
> >       clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
> >       iio_device_put(indio_dev);
> >       kfree(ib);
> > diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> > index e25d26a7f601..78da590b5607 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -6,6 +6,8 @@
> >
> >  #ifdef CONFIG_IIO_BUFFER
> >
> > +#include <uapi/linux/iio/buffer.h>
> > +
> >  struct iio_dev;
> >  struct iio_buffer;
> >
> > @@ -75,6 +77,9 @@ struct iio_buffer {
> >       /** @length: Number of datums in buffer. */
> >       unsigned int length;
> >
> > +     /** @flags: File ops flags including busy flag. */
> > +     unsigned long flags;
> > +
> >       /**  @bytes_per_datum: Size of individual datum including timestamp. */
> >       size_t bytes_per_datum;
> >
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index 1db0ea09520e..d0429b13afa8 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -9,6 +9,7 @@
> >   * @event_interface:         event chrdevs associated with interrupt lines
> >   * @attached_buffers:                array of buffers statically attached by the driver
> >   * @attached_buffers_cnt:    number of buffers in the array of statically attached buffers
> > + * @buffer_ioctl_handler:    ioctl() handler for this IIO device's buffer interface
> >   * @buffer_list:             list of all buffers currently attached
> >   * @channel_attr_list:               keep track of automatically created channel
> >   *                           attributes
> > @@ -24,6 +25,7 @@ struct iio_dev_opaque {
> >       struct iio_event_interface      *event_interface;
> >       struct iio_buffer               **attached_buffers;
> >       unsigned int                    attached_buffers_cnt;
> > +     struct iio_ioctl_handler        *buffer_ioctl_handler;
> >       struct list_head                buffer_list;
> >       struct list_head                channel_attr_list;
> >       struct attribute_group          chan_attr_group;
> > diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> > new file mode 100644
> > index 000000000000..5455f7ff143d
> > --- /dev/null
> > +++ b/include/uapi/linux/iio/buffer.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/* industrial I/O buffer definitions needed both in and out of kernel
> > + */
> > +
> > +#ifndef _UAPI_IIO_BUFFER_H_
> > +#define _UAPI_IIO_BUFFER_H_
> > +
> > +#define IIO_BUFFER_GET_FD_IOCTL              _IOWR('i', 0xb0, int)
> > +
> > +#endif /* _UAPI_IIO_BUFFER_H_ */
>
