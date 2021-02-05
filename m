Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E35310872
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 10:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBEJyL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 04:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhBEJwF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 04:52:05 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5857C0617A9;
        Fri,  5 Feb 2021 01:51:24 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n201so6359235iod.12;
        Fri, 05 Feb 2021 01:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUO8isFjuw3ZGLk4KSC36XJuPWmWE9uo4+eXMMrY708=;
        b=d7lRx8FlSsh/lRwdykiC6rsbyaeImgoVERnVIHKRWigGL6D1HsBLxRTAHNzIQx3iDr
         cofZ9qlLYdtmt907ihabN5Qutsj+aq0RTKLqDNPvGhwHEke6edRV4V7dkHjyzzxZLDzE
         afNbml9c3tsa1vvPVXffyCRuVy0fwdRsBLWlw8+ZGqM9xYL4HRojbpUIMjFlGc2sXL4T
         62zpGlIV9xqVv+RuzFuLOW/eZyNMDFkh/ki5Pjjyf6f2tfOaXybebVKOopFcVQNb439o
         eOxvpxaqwSYKN+nSBHBX67RlHXcfmTDnWbpVF6GypwVOoXbwLKrPmM6qIEJKEp9cVNQ8
         Tscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUO8isFjuw3ZGLk4KSC36XJuPWmWE9uo4+eXMMrY708=;
        b=Osx9iciHmOXx2OUfv9tLNNDNuaJa4Qm11UchV5n0oTrGwiqqJq90ZeVK9M+WH0Hkpl
         fmwh4Wa/ReXBTa6FAwDZ3tIosfWpJqX450UL5nyM6tXe96pRGJ5F4Lw0umdfaQD2lgYN
         VvKSvurkART0/JSytXmLrYs1d+lNw7tPvLM795bNYhk4A5apa+g/H1wVk3DkXCSYI2Po
         xtLulo90GTyts8d/ZgOJmocx7vSOXMBemg4wrwEcmstaAt7BwZzKKcoqB1AxUQz1apNp
         V3y5d3x2lVFeiH7BinXGBTMCzR4NFBryQBxTNWorAPUHzigNEb4+Dbek57FaGYJ34LQ7
         cygQ==
X-Gm-Message-State: AOAM530lACZP13rMKMgFQ+S2oIYUsk1TN/B2Xjm3k85QThSIz9OJ7huX
        jTxNh6qcyh9QjMjKfYqoAxo0PZEdDRXMyj2liz0=
X-Google-Smtp-Source: ABdhPJzib1DAJu51pHz/vzbfPuIC8MBfAsXdzoC007rQerwidj59iCNbIRLIQvcoxIHH6MvY1rUmJhmyNE7FveRUoc8=
X-Received: by 2002:a02:3b6c:: with SMTP id i44mr3992463jaf.91.1612518684306;
 Fri, 05 Feb 2021 01:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
 <20210201145105.20459-12-alexandru.ardelean@analog.com> <20210204190041.0000623a@Huawei.com>
In-Reply-To: <20210204190041.0000623a@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 5 Feb 2021 11:51:13 +0200
Message-ID: <CA+U=Dsp7ivJk7vhnW6xB=6JSTNThny-2J7iOmTTxJ7PXM4SSqA@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 4, 2021 at 9:06 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 1 Feb 2021 16:51:05 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > With this change, an ioctl() call is added to open a character device for a
> > buffer. The ioctl() number is 'i' 0x91, which follows the
> > IIO_GET_EVENT_FD_IOCTL ioctl.
> >
> > The ioctl() will return a 0 FD for the first buffer, as that FD for buffer0
> > is the same FD as the one used for this ioctl().
>
> That sounds dangerous as code might just use it without checking properly.
> Perhaps take a leaf out of open() and return negative?

So, initially this returned -EBUSY.
But that is also confusing.
And returning 0 isn't great either.

I've been thinking about this for the last few days.
Would it be too bad if return another FD for the same buffer0 ?
Admittedly, you'd be able to access the same buffer0 via 2 FDs, but
coming back to the idea of creating a new API and having to live with
the old one as well, it feels like these 2 FDs for buffer0 are falling
under the same principle.

>
> What would happen if we just returned an error in this path?

We need to find a good error code [if we return an error].
-EBUSY would sound the closest to something correct.

>
> >
> > For any other extra buffer, this ioctl() will return an anon inode FD that
> > would access any extra buffer.
> >
> > Right now, there doesn't seem to be (or I couldn't find) a way for this
> > ioctl() to return the FD for buffer0 (i.e. to return the same FD as used
> > for the ioctl()).
> > So, usespace would need to know that  ioctl(fd,
> > IIO_GET_EVENT_FD_IOCTL, 0) will return FD 0.
> > We could also return another FD for buffer 0, but duplicating FDs for the
> > same IIO buffer sounds problematic.
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
> >  #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0x91, int)
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
> If you get a chance to add a parameter to the tools/iio/ buffer
> program that does much the same as above that would be great.

will take a look

>
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Otherwise a few trivials inline.
>
> Good work on bringing this new approach together so quickly.
>
> It's a lot simpler which is good and still gives us a reasonable interface.
>
> If you can update the example code in tree and perhaps add something to
> the main IIO docs that would be great.
> Documentation/driver-api/iio/buffers.rst I think.
>
> We'll also  (at somepoint) want to do a scrub of the ABI docs to
> either include the new paths or make them less specific to incorporate
> both.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/industrialio-buffer.c | 118 ++++++++++++++++++++++++++++++
> >  drivers/iio/industrialio-core.c   |   8 ++
> >  include/linux/iio/buffer_impl.h   |   5 ++
> >  include/linux/iio/iio-opaque.h    |   2 +
> >  include/uapi/linux/iio/buffer.h   |  10 +++
> >  5 files changed, 143 insertions(+)
> >  create mode 100644 include/uapi/linux/iio/buffer.h
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index a69bb705d173..119c2b5aa863 100644
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
> > @@ -1333,6 +1334,106 @@ void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
> >       kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
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
>
> Why mlock?  Might be fine, but this doesn't feel like it is in the normal scope
> of that lock.  So perhaps a comment on why it makes sense here.

Copy+paste from iio_event_getfd()
It does the same thing.
So, I'm a bit vague on this mlock being used here.
Will take a look.

>
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
> >  static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >                                            struct iio_dev *indio_dev,
> >                                            int index)
> > @@ -1460,6 +1561,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >       const struct iio_chan_spec *channels;
> >       int unwind_idx;
> >       int ret, i;
> > +     size_t sz;
> >
> >       channels = indio_dev->channels;
> >       if (channels) {
> > @@ -1481,6 +1583,18 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >                       goto error_unwind_sysfs_and_mask;
> >               }
> >       }
> > +     unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
> > +
> > +     sz = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));
> > +     iio_dev_opaque->buffer_ioctl_handler = kzalloc(sz, GFP_KERNEL);
>
> > +     if (!iio_dev_opaque->buffer_ioctl_handler) {
> > +             ret = -ENOMEM;
> > +             goto error_unwind_sysfs_and_mask;
> > +     }
> > +
> > +     iio_dev_opaque->buffer_ioctl_handler->ioctl = iio_device_buffer_ioctl;
> > +     iio_device_ioctl_handler_register(indio_dev,
> > +                                       iio_dev_opaque->buffer_ioctl_handler);
> >
> >       return 0;
> >
> > @@ -1503,6 +1617,10 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> >       if (!buffer)
> >               return;
> >
> > +     iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
> > +     kfree(iio_dev_opaque->buffer_ioctl_handler);
> > +     iio_dev_opaque->buffer_ioctl_handler = NULL;
> > +
> >       iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
> >
> >       for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 8af85838d1c2..78807b62ff52 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1722,6 +1722,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
> >       ib->indio_dev = indio_dev;
> >       ib->buffer = indio_dev->buffer;
> >
> > +     if (indio_dev->buffer)
> > +             test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->buffer->flags);
> > +
>
> What is this test preventing?  I guess it's keeping the flag for the first
> buffer in sync with what other buffers will look at, but does anything check those?
> We'll not be able to open this one twice anyway due to the check above.
>
> Perhaps a comment on why this is here?

Hmm, I admit this is a bit sloppy.
This should technically be an impossible condition, so maybe just
set_bit() would have been enough.
It's making sure that the ioctl() on buffer 0 would have return
-EBUSY; but that was on an older version.

>
> >       filp->private_data = ib;
> >
> >       return 0;
> > @@ -1739,6 +1742,11 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
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
> > index 768b90c64412..245b32918ae1 100644
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
> > @@ -72,6 +74,9 @@ struct iio_buffer {
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
> > index c909835b6247..2c3374d465da 100644
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
> > @@ -28,6 +29,7 @@ struct iio_dev_opaque {
> >       struct iio_event_interface      *event_interface;
> >       struct iio_buffer               **attached_buffers;
> >       unsigned int                    attached_buffers_cnt;
> > +     struct iio_ioctl_handler        *buffer_ioctl_handler;
> >       struct list_head                buffer_list;
> >       struct list_head                channel_attr_list;
> >       struct attribute_group          chan_attr_group;
> > diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> > new file mode 100644
> > index 000000000000..de571c83c9f2
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
> > +#define IIO_BUFFER_GET_FD_IOCTL              _IOWR('i', 0x91, int)
> > +
> > +#endif /* _UAPI_IIO_BUFFER_H_ */
>
