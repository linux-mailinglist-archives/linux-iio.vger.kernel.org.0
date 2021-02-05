Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E382C3107A3
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 10:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBEJUX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 04:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBEJR4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 04:17:56 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E23C06178A;
        Fri,  5 Feb 2021 01:17:16 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id y5so5220403ilg.4;
        Fri, 05 Feb 2021 01:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Es0ZVc7YL5iFjJN+BvBAO94889quiBborei6/l2/KNU=;
        b=J/28/+60XbcRmNzEOu04xDWWOxTI69vATNhDBVpfM3CfHod5gL8cSJNC4J/l9oyesS
         JI+Pb6+wehzrQJJlK+i3tQePZKwyPVyMMkIFRFtRksOWGadxtmURAJiWxxRmo9EAeuEa
         QAYwzq6SYeJVo4oFRov8L8PkbOoW7bu3WBQuE3XBnAKpvE5ZjQXbLOzhQ2eIDvmlTws5
         7uh3142QPjHfOtdXzu0QtU61HSd+v4ALy3avPfhjPgKntdwK7P33eKUhYbw8f7n2tpW4
         bOJw5SP7+GBqs4D6kh7XjeEPNz054u8KAol6MIgyGOrwj1yrMPnamtopLK8PYGbNwQZL
         Ya+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Es0ZVc7YL5iFjJN+BvBAO94889quiBborei6/l2/KNU=;
        b=XKMXq1z1oj0gySquf71o4JWYP+NBToN8HcAFhZKIbVFwckBlt3Dz8ycN86Z2OmEcMU
         cb1aY1gaHPKQtIC969tCs+o3opzwFQu5IR95basCW6bl14uHBzF+uDvbnbNdZCtDQd4a
         cw0G7clkPUEd5DUwutrZIs/jQKF1O8bL0L7P9wUUJBmtawqpz/F+fyuDSHmIzSzDVgEO
         dArXWcJehFzrhkiiIlJUv2SrNSbLpzllPRMOK5KldvVKOg8pCCK9djtSQhE76TU/l9Wk
         TyDWeViEjHHU61PO56s/3OFH7cE7R5rYKjYSbMOqqHsR4yphCB5k2d8jG/hwz9l3WmwQ
         pnxg==
X-Gm-Message-State: AOAM533RuQknHFBMwHzlLFyVo9R3/6FzOth/HnC+S3UQJkCYNZl5+AUc
        HkN1AFgamq/2kaTP+rk9IjlfMwkh+obZ4VQRLtU=
X-Google-Smtp-Source: ABdhPJx9xtxmpah1bQGx6vBg82qRD2+qhffXChQlo9bBYMIJ06jr4XcMJOKw5G11/9hg4rZAeAvSKNkDZVy7VxCipig=
X-Received: by 2002:a92:ab10:: with SMTP id v16mr3216427ilh.100.1612516635714;
 Fri, 05 Feb 2021 01:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
 <20210201145105.20459-9-alexandru.ardelean@analog.com> <20210204182340.00005170@Huawei.com>
In-Reply-To: <20210204182340.00005170@Huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 5 Feb 2021 11:17:04 +0200
Message-ID: <CA+U=DsrBMd6LmdO_gq3MT21eO2HoO0mbkZjbig600EJ=d4Q3kg@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] iio: buffer: wrap all buffer attributes into iio_dev_attr
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

On Thu, Feb 4, 2021 at 8:26 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 1 Feb 2021 16:51:02 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This change wraps all buffer attributes into iio_dev_attr objects, and
> > assigns a reference to the IIO buffer they belong to.
> >
> > With the addition of multiple IIO buffers per one IIO device, we need a way
> > to know which IIO buffer is being enabled/disabled/controlled.
> >
> > We know that all buffer attributes are device_attributes. So we can wrap
> > them with a iio_dev_attr types. In the iio_dev_attr type, we can also hold
> > a reference to an IIO buffer.
> > So, we end up being able to allocate wrapped attributes for all buffer
> > attributes (even the one from other drivers).
> >
> > The neat part with this mechanism, is that we don't need to add any extra
> > cleanup, because these attributes are being added to a dynamic list that
> > will get cleaned up via iio_free_chan_devattr_list().
>
>
> >
> > With this change, the 'buffer->scan_el_dev_attr_list' list is being renamed
> > to 'buffer->buffer_attr_list', effectively merging (or finalizing the
> > merge) of the buffer/ & scan_elements/ attributes internally.
> >
> > Accessing these new buffer attributes can now be done via
> > 'to_iio_dev_attr(attr)->buffer' inside the show/store handlers.
>
> That is going to look a bit odd in any drivers that use it given they
> will appear to not be embedded.
>
> There seem to be very few such attributes from a quick grep, so maybe
> we may want to unwind this and change all the types.   Might still need
> to set .buffer for some of them though (only applying to new drivers as
> clearly current ones don't care!)
>
> Looking at what they actually are, some perhaps shouldn't have been in the buffer
> directory in the first place (with hindsight!).
>
> Anyhow, aside from that oddity this looks good to me.

I'm a little vague here.
If there is a suggestion for a change, I may have missed it.

I'm a bit vague on the part of "we may want to unwind this and change
all the types"
Is it referring to something like this patch?
      https://lore.kernel.org/linux-iio/20210122162529.84978-10-alexandru.ardelean@analog.com/
We could do a show/store version that takes an iio_buf_attr or
iio_dev_attr parameter.
But maybe at a later point?
I don't feel it adds much benefit over the current usage of
buffer->attrs, because we need to kmalloc these iio_dev_attr anyways
to store the reference to the iio_buffer.

I would have liked to get rid of these user/external buffer->attrs.
That would have made things easier.

But, it looks like there are several drivers using them.
I usually find them by grepping for iio_triggered_buffer_setup_ext
It's only 5 drivers that provide these attributes.
It used to be a bit easier to find them by grepping
iio_buffer_set_attrs(), but I removed that.


>
> Jonathan
>
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/industrialio-buffer.c | 66 +++++++++++++++++++++----------
> >  include/linux/iio/buffer_impl.h   |  4 +-
> >  2 files changed, 48 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index a525e88b302f..49996bed5f4c 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -448,7 +448,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                    IIO_SEPARATE,
> >                                    &indio_dev->dev,
> >                                    buffer,
> > -                                  &buffer->scan_el_dev_attr_list);
> > +                                  &buffer->buffer_attr_list);
> >       if (ret)
> >               return ret;
> >       attrcount++;
> > @@ -460,7 +460,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                    0,
> >                                    &indio_dev->dev,
> >                                    buffer,
> > -                                  &buffer->scan_el_dev_attr_list);
> > +                                  &buffer->buffer_attr_list);
> >       if (ret)
> >               return ret;
> >       attrcount++;
> > @@ -473,7 +473,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                            0,
> >                                            &indio_dev->dev,
> >                                            buffer,
> > -                                          &buffer->scan_el_dev_attr_list);
> > +                                          &buffer->buffer_attr_list);
> >       else
> >               ret = __iio_add_chan_devattr("en",
> >                                            chan,
> > @@ -483,7 +483,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                            0,
> >                                            &indio_dev->dev,
> >                                            buffer,
> > -                                          &buffer->scan_el_dev_attr_list);
> > +                                          &buffer->buffer_attr_list);
> >       if (ret)
> >               return ret;
> >       attrcount++;
> > @@ -495,8 +495,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
> >                                     struct device_attribute *attr,
> >                                     char *buf)
> >  {
> > -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > +     struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >
> >       return sprintf(buf, "%d\n", buffer->length);
> >  }
> > @@ -506,7 +505,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
> >                                      const char *buf, size_t len)
> >  {
> >       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > +     struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >       unsigned int val;
> >       int ret;
> >
> > @@ -538,8 +537,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
> >                                     struct device_attribute *attr,
> >                                     char *buf)
> >  {
> > -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > +     struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >
> >       return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
> >  }
> > @@ -1154,7 +1152,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
> >       int ret;
> >       bool requested_state;
> >       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > +     struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >       bool inlist;
> >
> >       ret = strtobool(buf, &requested_state);
> > @@ -1185,8 +1183,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
> >                                        struct device_attribute *attr,
> >                                        char *buf)
> >  {
> > -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > +     struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >
> >       return sprintf(buf, "%u\n", buffer->watermark);
> >  }
> > @@ -1197,7 +1194,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
> >                                         size_t len)
> >  {
> >       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > +     struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >       unsigned int val;
> >       int ret;
> >
> > @@ -1230,8 +1227,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
> >                                               struct device_attribute *attr,
> >                                               char *buf)
> >  {
> > -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > +     struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >
> >       return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
> >  }
> > @@ -1256,6 +1252,26 @@ static struct attribute *iio_buffer_attrs[] = {
> >       &dev_attr_data_available.attr,
> >  };
> >
> > +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> > +
> > +static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
> > +                                           struct attribute *attr)
> > +{
> > +     struct device_attribute *dattr = to_dev_attr(attr);
> > +     struct iio_dev_attr *iio_attr;
> > +
> > +     iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> > +     if (!iio_attr)
> > +             return NULL;
> > +
> > +     iio_attr->buffer = buffer;
> > +     memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
> > +
> > +     list_add(&iio_attr->l, &buffer->buffer_attr_list);
> > +
> > +     return &iio_attr->dev_attr.attr;
> > +}
> > +
> >  static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
> >                                                  struct attribute **buffer_attrs,
> >                                                  int buffer_attrcount,
> > @@ -1331,7 +1347,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >       }
> >
> >       scan_el_attrcount = 0;
> > -     INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> > +     INIT_LIST_HEAD(&buffer->buffer_attr_list);
> >       channels = indio_dev->channels;
> >       if (channels) {
> >               /* new magic */
> > @@ -1378,9 +1394,19 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >
> >       buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
> >
> > -     attrn = buffer_attrcount;
> > +     for (i = 0; i < buffer_attrcount; i++) {
> > +             struct attribute *wrapped;
> > +
> > +             wrapped = iio_buffer_wrap_attr(buffer, attr[i]);
> > +             if (!wrapped) {
> > +                     ret = -ENOMEM;
> > +                     goto error_free_scan_mask;
> > +             }
> > +             attr[i] = wrapped;
> > +     }
> >
> > -     list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> > +     attrn = 0;
> > +     list_for_each_entry(p, &buffer->buffer_attr_list, l)
> >               attr[attrn++] = &p->dev_attr.attr;
> >
> >       buffer->buffer_group.name = kasprintf(GFP_KERNEL, "buffer%d", index);
> > @@ -1412,7 +1438,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >  error_free_scan_mask:
> >       bitmap_free(buffer->scan_mask);
> >  error_cleanup_dynamic:
> > -     iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > +     iio_free_chan_devattr_list(&buffer->buffer_attr_list);
> >
> >       return ret;
> >  }
> > @@ -1443,7 +1469,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> >       bitmap_free(buffer->scan_mask);
> >       kfree(buffer->buffer_group.name);
> >       kfree(buffer->buffer_group.attrs);
> > -     iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > +     iio_free_chan_devattr_list(&buffer->buffer_attr_list);
> >  }
> >
> >  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> > index 3e555e58475b..41044320e581 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -97,8 +97,8 @@ struct iio_buffer {
> >       /* @scan_timestamp: Does the scan mode include a timestamp. */
> >       bool scan_timestamp;
> >
> > -     /* @scan_el_dev_attr_list: List of scan element related attributes. */
> > -     struct list_head scan_el_dev_attr_list;
> > +     /* @buffer_attr_list: List of buffer attributes. */
> > +     struct list_head buffer_attr_list;
> >
> >       /*
> >        * @buffer_group: Attributes of the new buffer group.
>
