Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C19310667
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 09:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhBEINE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 03:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhBEIMz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 03:12:55 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A5C0613D6;
        Fri,  5 Feb 2021 00:12:15 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f67so4369670ioa.1;
        Fri, 05 Feb 2021 00:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZB1j7ExK4A7ZTcSGpsFbDsbAtl+Rf3XIZReIJAzrP/E=;
        b=XXtOOo8b9F7DbnLhdt7eNZyb8z9yhPFsCDrLpHphzl4vaB23xFgJ3GZmf7ZEHhEvgS
         1jd9OKJ2Fe4xkMM3CRxzb2yiKwG9MJO6vgSThmqNI0ih7o5nV5TXJ+DdQWpXD1HeTSVm
         XJLRWems/uI5ZtWtNoogLkbkJXt5xxTRb/Vi/BYfe9H+bChyZ7evfs4uTtC3eJhA6fvv
         ustbNwKcHotkvk82Dm+Irb+8ut84W/Ey7IU07rjuw3T9OgCDnlex+wwnL4tFBx4qwXBP
         XIB4IsV1CW7tA1jmUkQ5pv0ko0GjbNF5Pplte7OJhTbmmqkUTveewySRDjS7VLs7tov+
         1Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZB1j7ExK4A7ZTcSGpsFbDsbAtl+Rf3XIZReIJAzrP/E=;
        b=eFoWk5nMcGQj88nCPNNOXvFC3mxNtcls8Uf24ieIiXfAVrzSQr7y32bDYLLPBID0Hq
         MTcxaF/k9Sdg879nbYnVAH1MaAXeSaqryhG3U5UODJ6x8CxqKXvV9dqm9T0TtORprqKE
         P8sIEGntYoHtEXC/r5mDIBDqMSCZ3K5+O2KkaHlHoPUFh2ja7RUr9yzVKc7ZMWDu9SmY
         XnJ+XzGxNN33SgNSgxSg2lJWLmW2Kz9GRtdhmWiOn4ohtbkIDiDz9rXaGkOFwwr8tDvl
         P0FY6uhVc61MnH5GIqkNyRC4Wou406YBc6yZnOLY6DoZ7fa+cPkPvCk9OHSOO0S9XBqj
         3uAQ==
X-Gm-Message-State: AOAM530a1sPsxTFH9+83Uan4dG4q0bgS8XfmjZQlEdTeWAe8WYLQdh/k
        NpC+FtboCrjkgSjZpKRmz6eifIXAKeszDko6SvA=
X-Google-Smtp-Source: ABdhPJyHrvMyfOaJbsmql5Jla41bhRts2VhleUawSB3WvJ0q9gvCQh4kjJCdC/CI8Ab9+JXIkXlRhOP46V/vbsFfMJo=
X-Received: by 2002:a02:3f62:: with SMTP id c34mr3836497jaf.16.1612512735120;
 Fri, 05 Feb 2021 00:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
 <20210201145105.20459-6-alexandru.ardelean@analog.com> <20210204174942.000013b3@Huawei.com>
In-Reply-To: <20210204174942.000013b3@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 5 Feb 2021 10:12:03 +0200
Message-ID: <CA+U=DsotfJ5A44CWtdXW=QYzz3ApvLaUK2PqH=Cs3FdqFJVLEQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] iio: buffer: group attr count and attr alloc
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

On Thu, Feb 4, 2021 at 7:57 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 1 Feb 2021 16:50:59 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > If we want to merge the attributes of the buffer/ and scan_elements/
> > directories, we'll need to count all attributes first, then (depending on
> > the attribute group) either allocate 2 attribute groups, or a single one.
>
> Probably want to note why we might want to do 2 or 1 group here as it
> sounds weird without knowing where this is going.

ack

>
> >
> > This change moves the allocation of the buffer/ attributes closer to the
> > allocation of the scan_elements/ attributes to make grouping easier.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> This is fine, but one comment on a possible tidy up for another day inline.
>
> Jonathan
>
> > ---
> >  drivers/iio/industrialio-buffer.c | 71 ++++++++++++++++---------------
> >  1 file changed, 37 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index cc846988fdb9..23f22be62cc7 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1257,41 +1257,16 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >  {
> >       struct iio_dev_attr *p;
> >       struct attribute **attr;
> > -     int ret, i, attrn, attrcount;
> > +     int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
> >       const struct iio_chan_spec *channels;
> >
> > -     attrcount = 0;
> > +     buffer_attrcount = 0;
> >       if (buffer->attrs) {
> > -             while (buffer->attrs[attrcount] != NULL)
> > -                     attrcount++;
> > +             while (buffer->attrs[buffer_attrcount] != NULL)
> > +                     buffer_attrcount++;
> >       }
> >
> > -     attr = kcalloc(attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
> > -                    sizeof(struct attribute *), GFP_KERNEL);
> > -     if (!attr)
> > -             return -ENOMEM;
> > -
> > -     memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
> > -     if (!buffer->access->set_length)
> > -             attr[0] = &dev_attr_length_ro.attr;
> > -
> > -     if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
> > -             attr[2] = &dev_attr_watermark_ro.attr;
> > -
> > -     if (buffer->attrs)
> > -             memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
> > -                    sizeof(struct attribute *) * attrcount);
> > -
> > -     attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
> > -
> > -     buffer->buffer_group.name = "buffer";
> > -     buffer->buffer_group.attrs = attr;
> > -
> > -     ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
> > -     if (ret)
> > -             goto error_free_buffer_attrs;
> > -
> > -     attrcount = 0;
> > +     scan_el_attrcount = 0;
> >       INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> >       channels = indio_dev->channels;
> >       if (channels) {
> > @@ -1304,7 +1279,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >                                                        &channels[i]);
> >                       if (ret < 0)
> >                               goto error_cleanup_dynamic;
> > -                     attrcount += ret;
> > +                     scan_el_attrcount += ret;
> >                       if (channels[i].type == IIO_TIMESTAMP)
> >                               indio_dev->scan_index_timestamp =
> >                                       channels[i].scan_index;
> > @@ -1319,9 +1294,37 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >               }
> >       }
> >
> > +     attr = kcalloc(buffer_attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
> > +                    sizeof(struct attribute *), GFP_KERNEL);
> > +     if (!attr) {
> > +             ret = -ENOMEM;
> > +             goto error_free_scan_mask;
> > +     }
> > +
> > +     memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
> > +     if (!buffer->access->set_length)
> > +             attr[0] = &dev_attr_length_ro.attr;
> > +
> > +     if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
> > +             attr[2] = &dev_attr_watermark_ro.attr;
>
> Again a comment for the future  rather than now, but when we are copying
> 4 items and then looking at whether to change 2 of them it might be cleaner
> to just set them directly!  Touch of bit rot here :)

So, I've been on-and-off about how to deal with this one.
I wanted to clean it in various ways using new kernel sysfs APIs.
Maybe, also remove the readonly variants and use the is_visible()
property to set RO/RW modes.
But I also came to the conclusion that this is an idea to address later.
Trying to address this early-on confused me with other overlapping changes.

>
> > +
> > +     if (buffer->attrs)
> > +             memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
> > +                    sizeof(struct attribute *) * buffer_attrcount);
> > +
> > +     buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
> > +     attr[buffer_attrcount] = NULL;
> > +
> > +     buffer->buffer_group.name = "buffer";
> > +     buffer->buffer_group.attrs = attr;
> > +
> > +     ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
> > +     if (ret)
> > +             goto error_free_buffer_attrs;
> > +
> >       buffer->scan_el_group.name = iio_scan_elements_group_name;
> >
> > -     buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
> > +     buffer->scan_el_group.attrs = kcalloc(scan_el_attrcount + 1,
> >                                             sizeof(buffer->scan_el_group.attrs[0]),
> >                                             GFP_KERNEL);
> >       if (buffer->scan_el_group.attrs == NULL) {
> > @@ -1341,12 +1344,12 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >
> >  error_free_scan_el_attrs:
> >       kfree(buffer->scan_el_group.attrs);
> > +error_free_buffer_attrs:
> > +     kfree(buffer->buffer_group.attrs);
> >  error_free_scan_mask:
> >       bitmap_free(buffer->scan_mask);
> >  error_cleanup_dynamic:
> >       iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > -error_free_buffer_attrs:
> > -     kfree(buffer->buffer_group.attrs);
> >
> >       return ret;
> >  }
>
