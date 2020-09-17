Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A026E2AC
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 19:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgIQRl3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgIQRlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 13:41:23 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A59C061788;
        Thu, 17 Sep 2020 10:41:20 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id s17so752791ooe.6;
        Thu, 17 Sep 2020 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ay7jsk8o+Eqah3J51yvrWMQYd0dtmSWP1P2mdx9VXhI=;
        b=jmXdxy2RlxPMrYvZua5LpdZ+7Z6dQ9pL3oNt+iDFrDNUbjf90IB/VdCyQBgGxTu903
         ACGRDw5Us4/6CRgvJrgFNuPUysoVD8S/hmjLRxffphCq8c3EaZVLuNn7CoT5sxS5dwNO
         NJlYl9GIxA4+Rb1nhLHun5DUzirJTq5YkNnChOgtB5E2F5ObcurDtVfjGdjcAPkhzyzq
         m4fDysTaZPvkBLL2+X4tPdNQ84Ywc4MvxPRGNCuz7jENNeyUjq51saM797XFL//sqVG5
         aCqrrGHhVUd4y1IPwvgSDJu8rR/YlDaivDdxGVynLdNMQGUJiOuToyMkoAhmvMUVr9Hi
         lpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ay7jsk8o+Eqah3J51yvrWMQYd0dtmSWP1P2mdx9VXhI=;
        b=ofF+yReofE4yR56eVOR02c1FBZ/AqFI476mh+dkERaykhVPK4e7sagggO8SmDd1nGT
         rehzWKf5seW/BWLPDG8bU1tDJ/Ly/Ii0BXNTOFo0gNpz7oNBd1ryoGEPs6JF0cuD4+yd
         l8kG7O/ngyTM7UaA1cyxf3NM76dvWhSjkQU9lZ1hgq3u9KEkOjFFtKYpelrUWgGqopAe
         ZgmOW88+eJrZAQ5T50zUouAj9PKnLHXMJX65BJQahNd7LK4Z2iWvTR778WIdPAs2OTbk
         d45YHtqNAhBsERUF6oKBVZ5UsMvh+h9U9m1dqDXW7nXNfQQDJvAWcDChH4BsqllkaIe5
         hQBQ==
X-Gm-Message-State: AOAM533hhzDGruNjEDQiOYg7Rt4qkx/+7ZWwOx717iT5w4nJFD6KJROu
        9JpLTM+bJc28W8Xa+O+iMKvdansiH8aEPOJav/g=
X-Google-Smtp-Source: ABdhPJxHUMXwOFUpKkCNjq4rEsKcM54Nh06EjfpPz5bYVqYmfmE3lbHZVp3fBSeUGLfbk9Drt+dKfUhJVGsNHSuz8wI=
X-Received: by 2002:a4a:e616:: with SMTP id f22mr8522398oot.11.1600364479815;
 Thu, 17 Sep 2020 10:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200917125951.861-1-alexandru.ardelean@analog.com> <20200917181626.59eb84c8@archlinux>
In-Reply-To: <20200917181626.59eb84c8@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 17 Sep 2020 20:41:08 +0300
Message-ID: <CA+U=DspN3WYX5_1MZpRPzUcC5NV4=iSekQ9jNSehad1jfi2bQw@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: split buffer sysfs creation to take buffer
 as primary arg
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 17, 2020 at 8:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 17 Sep 2020 15:59:51 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > Currently the iio_buffer_{alloc,free}_sysfs_and_mask() take 'indio_dev' as
> > primary argument. This change splits the main logic into a private function
> > that takes an IIO buffer as primary argument.
> >
> > That way, the functions can be extended to configure the sysfs for multiple
> > buffers.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> One comment inline.  Whilst I think it is safe as you have it, I'd
> rather avoid the minor change in logic if we don't need to make it.
>
> Thanks,
>
> Jonathan
>
>
> > ---
> >  drivers/iio/industrialio-buffer.c | 46 ++++++++++++++++++++-----------
> >  1 file changed, 30 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index a7d7e5143ed2..a4f6bb96d4f4 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1264,26 +1264,14 @@ static struct attribute *iio_buffer_attrs[] = {
> >       &dev_attr_data_available.attr,
> >  };
> >
> > -int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > +static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> > +                                          struct iio_dev *indio_dev)
> >  {
> >       struct iio_dev_attr *p;
> >       struct attribute **attr;
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> >       int ret, i, attrn, attrcount;
> >       const struct iio_chan_spec *channels;
> >
> > -     channels = indio_dev->channels;
> > -     if (channels) {
> > -             int ml = indio_dev->masklength;
> > -
> > -             for (i = 0; i < indio_dev->num_channels; i++)
> > -                     ml = max(ml, channels[i].scan_index + 1);
> > -             indio_dev->masklength = ml;
> > -     }
> > -
> > -     if (!buffer)
> > -             return 0;
> > -
> >       attrcount = 0;
> >       if (buffer->attrs) {
> >               while (buffer->attrs[attrcount] != NULL)
> > @@ -1367,19 +1355,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >       return ret;
> >  }
> >
> > -void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > +int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >  {
> >       struct iio_buffer *buffer = indio_dev->buffer;
> > +     const struct iio_chan_spec *channels;
> > +     int i;
> > +
> > +     channels = indio_dev->channels;
> > +     if (channels) {
> > +             int ml = indio_dev->masklength;
> > +
> > +             for (i = 0; i < indio_dev->num_channels; i++)
> > +                     ml = max(ml, channels[i].scan_index + 1);
> > +             indio_dev->masklength = ml;
> > +     }
>
> I've not really figured out if it matters, but this is a logic change.
> Previously we didn't compute masklength if there was no buffer provided.
> Now we do.  It's probably better to move the if (!buffer) check above
> this block or at least mention this change in the patch description.
>

Umm, are you referring that this patch is a logic change or you are
suggesting a logic change?
The "if (!buffer)" check was positioned after the masklength
computation even in the old code.

>
> >
> >       if (!buffer)
> > -             return;
> > +             return 0;
> > +
> > +     return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
> > +}
> >
> > +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> > +{
> >       bitmap_free(buffer->scan_mask);
> >       kfree(buffer->buffer_group.attrs);
> >       kfree(buffer->scan_el_group.attrs);
> >       iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> >  }
> >
> > +void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > +{
> > +     struct iio_buffer *buffer = indio_dev->buffer;
> > +
> > +     if (!buffer)
> > +             return;
> > +
> > +     __iio_buffer_free_sysfs_and_mask(buffer);
> > +}
> > +
> >  /**
> >   * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
> >   * @indio_dev: the iio device
>
