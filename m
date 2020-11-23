Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C072C0BCE
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 14:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgKWNbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 08:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgKWM1d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 07:27:33 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D059C0613CF;
        Mon, 23 Nov 2020 04:27:33 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id m9so17894688iox.10;
        Mon, 23 Nov 2020 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DaTE6ucAwKHboKQ477UK1JxZudD+u75fJNWS41TfPw=;
        b=F8vooV+64b1R6XdaPNScWiXqMPAgTfFvuB+eXgf85IVPVeBa5IIJAqPN1i5L2rigGg
         rgFAIssk2nqKCZTWm6jXWklhaEaoxWw0GjxrZ/5XH5C1K2f6HLoLwCDf9jAzrIw4rCXH
         X/JsovH5CyfEgYFwUj2Tv5Hy0pYuzAFljAgcFSM2jEeoFFmRvCoxMHKlpdCYR4AytYvM
         YU+PcojjSFzFXMNM6FeiBjuQoRrc7E8s6ImBOWXJOY1F/QGbCYOevlqv7APh/XZHsKk1
         O729sXHwTBrxh+0sp6QW0XG1Kj+wz0ZCa0v/lAlzh1WlXyCLBdZbZaCwuf8OKHPaRlPT
         HE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DaTE6ucAwKHboKQ477UK1JxZudD+u75fJNWS41TfPw=;
        b=NKSoBW+2qZMFvzQFg44fgXU19uTMUTCusmHmX+HqC6Z+R9gPRwpMq5tCMHzRYUnai/
         QZRSOzVgqrtEGX8Jl7n8bZU9ee66S5r00/x89PvRgKcWnX9VDxOUJgr3BG2IoyLvWaaP
         MAuP2MBiIV2uT/+gdZJkwjQBtmAzNb2G9TKN1zU1dcfMtOuN7XLYlsnVBJSjPofYBBRh
         ROVsRU0Qp6nwhVOBQ2s1F8nv+2tj89dE4rQS9CLggLqgcxUQ57vkP3Eg98OX3I2pAhDM
         H3jvBUERH0imN5kzrJIav9DBajumDIcEkamHEfXd00n27/gLrM69WinrfNlx2rQNwpva
         ESFA==
X-Gm-Message-State: AOAM53141HopHmCPgaGV2+kkqz7AFK4ADxdhrWQXa1yS+9Y/NRM++2V3
        T2QLH4H+rilCvrvF1cAdBMvz5RpkfEDXN2aowDl35tBa
X-Google-Smtp-Source: ABdhPJynvcUZ7VF87TSywMORtIsedhvH9bTiHIn3h9krTL3CaRMAamRLFQAHW9xFK4ALmizxDsGPCOFuvu4Cz4Gzl88=
X-Received: by 2002:a6b:fa1a:: with SMTP id p26mr33849205ioh.70.1606134452097;
 Mon, 23 Nov 2020 04:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
 <20201117162340.43924-12-alexandru.ardelean@analog.com> <20201121184445.12ec2d92@archlinux>
In-Reply-To: <20201121184445.12ec2d92@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 23 Nov 2020 14:27:20 +0200
Message-ID: <CA+U=DspJg4039Jf60DO00gr0Eegp8j5dUx=R4hinL5B+Vix-Fw@mail.gmail.com>
Subject: Re: [RFC PATCH 11/12] iio: buffer: introduce support for attaching
 more IIO buffers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 8:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 18:23:39 +0200
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
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> A couple of minor things in here..
>
> Jonathan
>
> > ---
> >  drivers/iio/industrialio-buffer.c | 58 +++++++++++++++++++++++++------
> >  include/linux/iio/buffer_impl.h   |  3 ++
> >  include/linux/iio/iio-opaque.h    |  4 +++
> >  3 files changed, 54 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index c83cec89eddf..daa68822cea7 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1513,6 +1513,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer);
> >
> >  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >  {
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >       struct iio_buffer *buffer = indio_dev->buffer;
> >       const struct iio_chan_spec *channels;
> >       int i, ret;
> > @@ -1529,15 +1530,18 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >       if (!buffer)
> >               return 0;
> >
> > -     ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
> > -     if (ret)
> > -             return ret;
> > +     for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
> > +             buffer = iio_dev_opaque->attached_buffers[i];
> > +             ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
> > +             if (ret)
> > +                     goto error_unwind_sysfs_and_mask;
> > +     }
> >
> >       ret = sysfs_create_link(&indio_dev->dev.kobj,
> >                               &indio_dev->buffer->buffer_dir,
> >                               "buffer");
> >       if (ret)
> > -             goto error_free_sysfs_and_mask;
> > +             goto error_unwind_sysfs_and_mask;
> >
> >       ret = sysfs_create_link(&indio_dev->dev.kobj,
> >                               &indio_dev->buffer->scan_el_dir,
> > @@ -1549,8 +1553,14 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >
> >  error_remove_buffer_dir_link:
> >       sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
> > -error_free_sysfs_and_mask:
> > -     __iio_buffer_free_sysfs_and_mask(buffer);
> > +     i = iio_dev_opaque->attached_buffers_cnt - 1;
>
> Perhaps just use a counter variable that is only for this then you won't need
> to set it again in this error path.

Ack.

>
> > +error_unwind_sysfs_and_mask:
> > +     for (; i >= 0; i--) {
> > +             buffer = iio_dev_opaque->attached_buffers[i];
> > +             __iio_buffer_free_sysfs_and_mask(buffer);
> > +     }
> > +     kfree(iio_dev_opaque->attached_buffers);
> > +     iio_dev_opaque->attached_buffers = NULL;
> >       return ret;
> >  }
> >
> > @@ -1568,7 +1578,9 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> >
> >  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> >  {
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >       struct iio_buffer *buffer = indio_dev->buffer;
> > +     int i;
> >
> >       if (!buffer)
> >               return;
> > @@ -1576,7 +1588,13 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> >       sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
> >       sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
> >
> > -     __iio_buffer_free_sysfs_and_mask(buffer);
> > +     for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> > +             buffer = iio_dev_opaque->attached_buffers[i];
> > +             __iio_buffer_free_sysfs_and_mask(buffer);
> > +     }
> > +
> > +     kfree(iio_dev_opaque->attached_buffers);
> > +     iio_dev_opaque->attached_buffers = NULL;
> >  }
> >
> >  /**
> > @@ -1709,14 +1727,32 @@ EXPORT_SYMBOL_GPL(iio_buffer_get_iio_dev);
> >   * @buffer: The buffer to attach to the device
> >   *
> >   * This function attaches a buffer to a IIO device. The buffer stays attached to
> > - * the device until the device is freed. The function should only be called at
> > - * most once per device.
> > + * the device until the device is freed. For legacy reasons, the first attached
> > + * buffer will also be assigned to 'indio_dev->buffer'.
> >   */
> >  void iio_device_attach_buffer(struct iio_dev *indio_dev,
> >                             struct iio_buffer *buffer)
> >  {
> > -     indio_dev->buffer = iio_buffer_get(buffer);
> > +     struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +     struct iio_buffer **new, **old = iio_dev_opaque->attached_buffers;
> > +     unsigned int cnt = iio_dev_opaque->attached_buffers_cnt;
> > +
> > +     cnt++;
> > +
> > +     new = krealloc(old, sizeof(*new) * cnt, GFP_KERNEL);
> > +     if (!new) {
> > +             kfree(old);
>
> Need a comment on why freeing old makes sense.

Hmm, maybe here I'd need to change this a bit.
I'm seeing a few potential issues.

>
> > +             return;
> > +     }
> > +     iio_dev_opaque->attached_buffers = new;
> > +
> > +     /* first buffer is legacy; attach it to the IIO device directly */
> > +     if (!indio_dev->buffer)
> > +             indio_dev->buffer = iio_buffer_get(buffer);
> > +
> > +     buffer->indio_dev = indio_dev;
> >
> > -     indio_dev->buffer->indio_dev = indio_dev;
> > +     iio_dev_opaque->attached_buffers[cnt - 1] = buffer;
> > +     iio_dev_opaque->attached_buffers_cnt = cnt;
> >  }
> >  EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
> > diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> > index 77e169e51434..e25d26a7f601 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -124,6 +124,9 @@ struct iio_buffer {
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
> > index 07c5a8e52ca8..1db0ea09520e 100644
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
> > @@ -20,6 +22,8 @@
> >  struct iio_dev_opaque {
> >       struct iio_dev                  indio_dev;
> >       struct iio_event_interface      *event_interface;
> > +     struct iio_buffer               **attached_buffers;
> > +     unsigned int                    attached_buffers_cnt;
> >       struct list_head                buffer_list;
> >       struct list_head                channel_attr_list;
> >       struct attribute_group          chan_attr_group;
>
