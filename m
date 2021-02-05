Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA153106A2
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 09:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBEI1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 03:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBEI1a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 03:27:30 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1328C0613D6;
        Fri,  5 Feb 2021 00:26:50 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n14so6228166iog.3;
        Fri, 05 Feb 2021 00:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0Gm8u2TMhBz/YCAe+pp9wro9BJ8jYFwFo8FlNQSJoI=;
        b=oMNVSNOZyGvv07CcK+taZmULiang1+bklyyyewwT198brr7qyEZbmo24VeU7rC0LfY
         oo1t2KP3oKiXaAOKPttUlo+Qh0uiZ1JOoRyZuAgwFJYIX9jaKnb/f/FhqhNwhZ3NO+KI
         nlsLpqfSWHmad4vHGGsgNWGV1MQngDWvri4yjWNOtCd+ZOn20zldzc27fOfPFr6LJTPZ
         XssBMf7mHvFmCml0MF3YgcKdL8IucT9BAJj6A6sVFkvaBksjNTR2lIi110yruPesd1by
         U+vXTcPV5gAZEjgWcZ4AdkG8q03QGAJiAwgcZY7qm31AciDMAOUi228tGbC+vTSnwchB
         W1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0Gm8u2TMhBz/YCAe+pp9wro9BJ8jYFwFo8FlNQSJoI=;
        b=X+4x3WW8c6Lrb72+9tiMYlLsjRGStvZPF/y8T6dhKtOugLMH2n3b/rD/V7cfJPFrMB
         UXPXFvyaICQSK/h7kguiO4YyFWjdiei9PQkWUaKng9gC37QSasUfF1HRtKedcla9vWTo
         jBaIJ97STTWF+8T7Ubq6nZuAoViXjfyAalN4TQfCJlPGOnaeB2heH/WKhUJHETLTu5pY
         Mv6wXVTZLpgMUvmn1EW6HPnYtrt31RjXwd7yBvWY3smIlWQnvWUFHeyEQs6j+7AXaa+a
         aX4lGfNsmGc5L8g1e6lSfQ/NUsVDBWqq/LrvYZlDcyPYQTUayTmWZzQXc8nV14ksMfa4
         Xapg==
X-Gm-Message-State: AOAM532P2LROdeMYH6lGk1RbBhbHQW79lyuU+XTC5ejjq9ZuLmDLG2Fy
        bQ6aJ6DjjjUdSaKW5nSkOY6Z9QSiJADyUb7lQeM=
X-Google-Smtp-Source: ABdhPJx/7S6ngUSZt+lhev2lxyfban1H04P3gyM5ctHEpKB7iEd1QnjQwA/cAK/IAK5dVcXtBF6hW5yVJkAuXRZ3y5U=
X-Received: by 2002:a02:3f62:: with SMTP id c34mr3877574jaf.16.1612513608749;
 Fri, 05 Feb 2021 00:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
 <20210201145105.20459-8-alexandru.ardelean@analog.com> <20210204180926.00005e4c@Huawei.com>
In-Reply-To: <20210204180926.00005e4c@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 5 Feb 2021 10:26:32 +0200
Message-ID: <CA+U=Dsq34ixRT71qD8ZTR7MQ7NDgDZV2EJ+3gT=QQ8wBz4GiGA@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] iio: add reference to iio buffer on iio_dev_attr
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

On Thu, Feb 4, 2021 at 8:16 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 1 Feb 2021 16:51:01 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This change adds a reference to a 'struct iio_buffer' object on the
> > iio_dev_attr object. This way, we can use the created iio_dev_attr objects
> > on per-buffer basis (since they're allocated anyway).
> >
> > A minor downside of this change is that the number of parameters on
> > __iio_add_chan_devattr() grows by 1. This looks like it could do with a bit
> > of a re-think.
>
> Could use a bit of macro magic or static inline to keep the old
> version set of parameter and have __iio_add_chan_devattr_with_buf
> or similar.  I'm not sure I'd bother given we don't have that many callers.

If there isn't a strong opinion to add the
__iio_add_chan_devattr_with_buf() version + macro/inline magic, I'd
probably not do it.
In terms of patch-noise, it's not considerably better, and not
necessarily worse.

When I was thinking about the re-think of __iio_add_chan_devattr, I
was thinking of a way to maybe re-architect this.
Maybe, add some {device_}attribute that act as template [at least for
the R/W functions].
This definitely needs some thinking to make it clean and nice.

>
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/iio_core.h            | 2 ++
> >  drivers/iio/industrialio-buffer.c | 4 ++++
> >  drivers/iio/industrialio-core.c   | 6 ++++++
> >  drivers/iio/industrialio-event.c  | 1 +
> >  include/linux/iio/sysfs.h         | 3 +++
> >  5 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index 7d5b179c1fe7..731f5170d5b9 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/device.h>
> >
> > +struct iio_buffer;
> >  struct iio_chan_spec;
> >  struct iio_dev;
> >
> > @@ -43,6 +44,7 @@ int __iio_add_chan_devattr(const char *postfix,
> >                          u64 mask,
> >                          enum iio_shared_by shared_by,
> >                          struct device *dev,
> > +                        struct iio_buffer *buffer,
> >                          struct list_head *attr_list);
> >  void iio_free_chan_devattr_list(struct list_head *attr_list);
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index f82decf92b7c..a525e88b302f 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
>
> > @@ -447,6 +447,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                    0,
> >                                    IIO_SEPARATE,
> >                                    &indio_dev->dev,
> > +                                  buffer,
> >                                    &buffer->scan_el_dev_attr_list);
> >       if (ret)
> >               return ret;
> > @@ -458,6 +459,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                    0,
> >                                    0,
> >                                    &indio_dev->dev,
> > +                                  buffer,
> >                                    &buffer->scan_el_dev_attr_list);
> >       if (ret)
> >               return ret;
> > @@ -470,6 +472,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                            chan->scan_index,
> >                                            0,
> >                                            &indio_dev->dev,
> > +                                          buffer,
> >                                            &buffer->scan_el_dev_attr_list);
> >       else
> >               ret = __iio_add_chan_devattr("en",
> > @@ -479,6 +482,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                            chan->scan_index,
> >                                            0,
> >                                            &indio_dev->dev,
> > +                                          buffer,
> >                                            &buffer->scan_el_dev_attr_list);
> >       if (ret)
> >               return ret;
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index ccd7aaff6d13..c68130885d83 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1114,6 +1114,7 @@ int __iio_add_chan_devattr(const char *postfix,
> >                          u64 mask,
> >                          enum iio_shared_by shared_by,
> >                          struct device *dev,
> > +                        struct iio_buffer *buffer,
> >                          struct list_head *attr_list)
> >  {
> >       int ret;
> > @@ -1129,6 +1130,7 @@ int __iio_add_chan_devattr(const char *postfix,
> >               goto error_iio_dev_attr_free;
> >       iio_attr->c = chan;
> >       iio_attr->address = mask;
> > +     iio_attr->buffer = buffer;
> >       list_for_each_entry(t, attr_list, l)
> >               if (strcmp(t->dev_attr.attr.name,
> >                          iio_attr->dev_attr.attr.name) == 0) {
> > @@ -1165,6 +1167,7 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
> >                                    0,
> >                                    IIO_SEPARATE,
> >                                    &indio_dev->dev,
> > +                                  NULL,
> >                                    &iio_dev_opaque->channel_attr_list);
> >       if (ret < 0)
> >               return ret;
> > @@ -1190,6 +1193,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
> >                                            i,
> >                                            shared_by,
> >                                            &indio_dev->dev,
> > +                                          NULL,
> >                                            &iio_dev_opaque->channel_attr_list);
> >               if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
> >                       continue;
> > @@ -1226,6 +1230,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
> >                                            i,
> >                                            shared_by,
> >                                            &indio_dev->dev,
> > +                                          NULL,
> >                                            &iio_dev_opaque->channel_attr_list);
> >               kfree(avail_postfix);
> >               if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
> > @@ -1322,6 +1327,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                       i,
> >                                       ext_info->shared,
> >                                       &indio_dev->dev,
> > +                                     NULL,
> >                                       &iio_dev_opaque->channel_attr_list);
> >                       i++;
> >                       if (ret == -EBUSY && ext_info->shared)
> > diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> > index ea8947cc21e4..a30e289fc362 100644
> > --- a/drivers/iio/industrialio-event.c
> > +++ b/drivers/iio/industrialio-event.c
> > @@ -385,6 +385,7 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
> >
> >               ret = __iio_add_chan_devattr(postfix, chan, show, store,
> >                        (i << 16) | spec_index, shared_by, &indio_dev->dev,
> > +                      NULL,
> >                       &iio_dev_opaque->event_interface->dev_attr_list);
> >               kfree(postfix);
> >
> > diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> > index b532c875bc24..e51fba66de4b 100644
> > --- a/include/linux/iio/sysfs.h
> > +++ b/include/linux/iio/sysfs.h
> > @@ -9,6 +9,7 @@
> >  #ifndef _INDUSTRIAL_IO_SYSFS_H_
> >  #define _INDUSTRIAL_IO_SYSFS_H_
> >
> > +struct iio_buffer;
> >  struct iio_chan_spec;
> >
> >  /**
> > @@ -17,12 +18,14 @@ struct iio_chan_spec;
> >   * @address: associated register address
> >   * @l:               list head for maintaining list of dynamically created attrs
> >   * @c:               specification for the underlying channel
> > + * @buffer:  the IIO buffer to which this attribute belongs to (if any)
> >   */
> >  struct iio_dev_attr {
> >       struct device_attribute dev_attr;
> >       u64 address;
> >       struct list_head l;
> >       struct iio_chan_spec const *c;
> > +     struct iio_buffer *buffer;
> >  };
> >
> >  #define to_iio_dev_attr(_dev_attr)                           \
>
