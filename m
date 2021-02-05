Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187A33107FC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 10:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBEJfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 04:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhBEJdB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 04:33:01 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A8C0617A9;
        Fri,  5 Feb 2021 01:32:20 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n14so6386251iog.3;
        Fri, 05 Feb 2021 01:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2rCnDi1EtSFrO0Btr6NuAhZbTFmjhM/2A0Ae9RPYhI=;
        b=ho9fhsMfDksOYLw2FZP7wFwZJD6Tb4zSNRwO481ryAXhDiv4u0EZl67Kbte2X+q6Ub
         NsbpVS1BI3n5efZRSNyt2sfbfJNfxmEZO/5WhotYtmVcec0BQI6cC3+4I6bJmEcaYJxl
         pBifRoFBJKxi30jJOcuPDkMQKwH2edC6ne0BEDSAzOgCV+D8xwcAln0H4aGj11tKjpJD
         gId+Jrd112srDGLQmdm/rgKJiM2bqiJsu+DTZnWBrtyGOJIeXjOX5yp1i415wWHQ5qeY
         bRgG/ROWpvtyNN/xlaJvfaCJ2k2fnnlF7vl0RUcy/oVZkU8GHhB6nisPcPAG8XNP2yXY
         jAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2rCnDi1EtSFrO0Btr6NuAhZbTFmjhM/2A0Ae9RPYhI=;
        b=cbnTRcLZ8/npXyFkj96S1s+lF76txnygmq5jocMuS5fxkQuNEUM2JnqoCek9g4pVmb
         eXAqYuYl37A/sPRjUMLW5+0FKFOX258N2b7zfU1AARC8IgaZr3+c0zePJTWiDKO6KDPo
         hNYijyufb5LHIGGVZo+mRDR633tv6dJl2HWYY2STCKrj8rNxL7E/xq5posyZ+Tbtgiot
         Smv3ZTR8AmwXs4HdOPCW+Uc+NT5gQZDbPxpeVxAeCCOys837Kxsazo+pw+eMMxN8u+yd
         4FdTzutT7hCAPSCFylHDyR+2YrbyVBDUtVABscYpsHmL2LeYmuz30S4q8S+MzT8erfN4
         b5tw==
X-Gm-Message-State: AOAM531nBrjUw8QsK9WAbjnJ82I0v1h12XacrCZh8lEp46KEevFLPzA0
        HFrgP69/LZ4ziK8V0rwcRPeAarUcbk1Xr+hJ2Mmsp9q3ask=
X-Google-Smtp-Source: ABdhPJyBYIircVFSJn7YZIm5tD9Am6CFEOMyUaE6rB/vJ0ouEsfpJIMbgozAtpuqEuZ7EcAT5FpY9MSbg8ZEbn/6eSM=
X-Received: by 2002:a02:778d:: with SMTP id g135mr3984213jac.79.1612517539866;
 Fri, 05 Feb 2021 01:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
 <20210201145105.20459-11-alexandru.ardelean@analog.com> <20210204183433.000079e3@Huawei.com>
In-Reply-To: <20210204183433.000079e3@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 5 Feb 2021 11:32:08 +0200
Message-ID: <CA+U=DsqfyuiLiY2dhFD723VwiL4ABg-cBfg=1tnDWRn=yN-arg@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] iio: buffer: introduce support for attaching
 more IIO buffers
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

On Thu, Feb 4, 2021 at 8:39 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 1 Feb 2021 16:51:04 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > With this change, calling iio_device_attach_buffer() will actually attach
> > more buffers.
> > Right now this doesn't do any validation of whether a buffer is attached
> > twice; maybe that can be added later (if needed). Attaching a buffer more
> > than once should yield noticeably bad results.
> >
> > The first buffer is the legacy buffer, so a reference is kept to it.
> >
> > At this point, accessing the data for the extra buffers (that are added
> > after the first one) isn't possible yet.
> >
> > The iio_device_attach_buffer() is also changed to return an error code,
> > which for now is -ENOMEM if the array could not be realloc-ed for more
> > buffers.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> A few minor comments inline.
>
> Thanks,
>
> J
> > ---
> >  drivers/iio/industrialio-buffer.c | 80 +++++++++++++++++++++++++------
> >  include/linux/iio/buffer.h        |  4 +-
> >  include/linux/iio/buffer_impl.h   |  3 ++
> >  include/linux/iio/iio-opaque.h    |  4 ++
> >  4 files changed, 74 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 692f721588e2..a69bb705d173 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1445,11 +1445,21 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >       return ret;
> >  }
> >
> > +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> > +{
> > +     bitmap_free(buffer->scan_mask);
> > +     kfree(buffer->buffer_group.name);
> > +     kfree(buffer->buffer_group.attrs);
> > +     iio_free_chan_devattr_list(&buffer->buffer_attr_list);
> > +}
> > +
> >  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >  {
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >       struct iio_buffer *buffer = indio_dev->buffer;
> >       const struct iio_chan_spec *channels;
> > -     int i;
> > +     int unwind_idx;
> > +     int ret, i;
> >
> >       channels = indio_dev->channels;
> >       if (channels) {
> > @@ -1463,27 +1473,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >       if (!buffer)
> >               return 0;
> >
> > -     return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
> > -}
> > +     for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
> > +             buffer = iio_dev_opaque->attached_buffers[i];
> > +             ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
> > +             if (ret) {
> > +                     unwind_idx = i;
> Gut feeling would be to use i instead of introducing unwind_idx, but it
> doesn't really matter if you prefer this.

I thought about leaving 'i' here, but then in the next patch a
block/patch is added that makes using 'i' less obvious/clean.
So, unwind_idx is clearer after more code is added after this block.

>
> > +                     goto error_unwind_sysfs_and_mask;
> > +             }
> > +     }
> >
> > -static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> > -{
> > -     bitmap_free(buffer->scan_mask);
> > -     kfree(buffer->buffer_group.name);
> > -     kfree(buffer->buffer_group.attrs);
> > -     iio_free_chan_devattr_list(&buffer->buffer_attr_list);
>
> could you put this move in a precursor patch. It's making a mess
> of the diff and hence this harder to review than it should be.

ack

>
> > +     return 0;
> > +
> > +error_unwind_sysfs_and_mask:
> > +     for (; unwind_idx >= 0; unwind_idx--) {
> > +             buffer = iio_dev_opaque->attached_buffers[unwind_idx];
> > +             __iio_buffer_free_sysfs_and_mask(buffer);
> > +     }
> > +     kfree(iio_dev_opaque->attached_buffers);
> > +     iio_dev_opaque->attached_buffers = NULL;
> > +     return ret;
> >  }
> >
> >  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> >  {
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >       struct iio_buffer *buffer = indio_dev->buffer;
> > +     int i;
> >
> >       if (!buffer)
> >               return;
> >
> >       iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
> >
> > -     __iio_buffer_free_sysfs_and_mask(buffer);
> > +     for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> > +             buffer = iio_dev_opaque->attached_buffers[i];
> > +             __iio_buffer_free_sysfs_and_mask(buffer);
> > +     }
> > +
> > +     kfree(iio_dev_opaque->attached_buffers);
> > +     iio_dev_opaque->attached_buffers = NULL;
>
> For places where we set freed pointers to NULL, I'd like a comment on why.
> Usually it makes me a bit worried we are doing something less than tidy.

ack;
will remove;

>
> >  }
> >
> >  /**
> > @@ -1601,13 +1629,35 @@ EXPORT_SYMBOL_GPL(iio_buffer_put);
> >   * @indio_dev: The device the buffer should be attached to
> >   * @buffer: The buffer to attach to the device
> >   *
> > + * Return 0 if successful, negative if error.
> > + *
> >   * This function attaches a buffer to a IIO device. The buffer stays attached to
> > - * the device until the device is freed. The function should only be called at
> > - * most once per device.
> > + * the device until the device is freed. For legacy reasons, the first attached
> > + * buffer will also be assigned to 'indio_dev->buffer'.
> >   */
> > -void iio_device_attach_buffer(struct iio_dev *indio_dev,
> > -                           struct iio_buffer *buffer)
> > +int iio_device_attach_buffer(struct iio_dev *indio_dev,
> > +                          struct iio_buffer *buffer)
> >  {
> > -     indio_dev->buffer = iio_buffer_get(buffer);
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +     struct iio_buffer **new, **old = iio_dev_opaque->attached_buffers;
> > +     unsigned int cnt = iio_dev_opaque->attached_buffers_cnt;
> > +
> > +     cnt++;
> > +
> > +     new = krealloc(old, sizeof(*new) * cnt, GFP_KERNEL);
> > +     if (!new)
> > +             return -ENOMEM;
> > +     iio_dev_opaque->attached_buffers = new;
> > +
> > +     buffer = iio_buffer_get(buffer);
> > +
> > +     /* first buffer is legacy; attach it to the IIO device directly */
> > +     if (!indio_dev->buffer)
> > +             indio_dev->buffer = buffer;
> > +
> > +     iio_dev_opaque->attached_buffers[cnt - 1] = buffer;
> > +     iio_dev_opaque->attached_buffers_cnt = cnt;
> > +
> > +     return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
> > diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> > index 8febc23f5f26..b6928ac5c63d 100644
> > --- a/include/linux/iio/buffer.h
> > +++ b/include/linux/iio/buffer.h
> > @@ -41,7 +41,7 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
> >  bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
> >                                  const unsigned long *mask);
> >
> > -void iio_device_attach_buffer(struct iio_dev *indio_dev,
> > -                           struct iio_buffer *buffer);
> > +int iio_device_attach_buffer(struct iio_dev *indio_dev,
> > +                          struct iio_buffer *buffer);
> >
> >  #endif /* _IIO_BUFFER_GENERIC_H_ */
> > diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> > index 41044320e581..768b90c64412 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -112,6 +112,9 @@ struct iio_buffer {
> >       /* @demux_bounce: Buffer for doing gather from incoming scan. */
> >       void *demux_bounce;
> >
> > +     /* @attached_entry: Entry in the devices list of buffers attached by the driver. */
> > +     struct list_head attached_entry;
> > +
> >       /* @buffer_list: Entry in the devices list of current buffers. */
> >       struct list_head buffer_list;
> >
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index 3e4c3cd248fd..c909835b6247 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -7,6 +7,8 @@
> >   * struct iio_dev_opaque - industrial I/O device opaque information
> >   * @indio_dev:                       public industrial I/O device information
> >   * @event_interface:         event chrdevs associated with interrupt lines
> > + * @attached_buffers:                array of buffers statically attached by the driver
> > + * @attached_buffers_cnt:    number of buffers in the array of statically attached buffers
> >   * @buffer_list:             list of all buffers currently attached
> >   * @channel_attr_list:               keep track of automatically created channel
> >   *                           attributes
> > @@ -24,6 +26,8 @@
> >  struct iio_dev_opaque {
> >       struct iio_dev                  indio_dev;
> >       struct iio_event_interface      *event_interface;
> > +     struct iio_buffer               **attached_buffers;
> > +     unsigned int                    attached_buffers_cnt;
> >       struct list_head                buffer_list;
> >       struct list_head                channel_attr_list;
> >       struct attribute_group          chan_attr_group;
>
