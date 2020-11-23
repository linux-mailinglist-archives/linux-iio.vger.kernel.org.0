Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFEB2C0A9D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 14:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgKWMXH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 07:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbgKWMXH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 07:23:07 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00984C0613CF;
        Mon, 23 Nov 2020 04:23:06 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id i18so17916604ioa.3;
        Mon, 23 Nov 2020 04:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gel8nq8NlFy0mqpmkAyhzEp0wHlK83EywG0rqJQGJUA=;
        b=snWrt0zYHj/KrdpKT3OWqRsdRWeMC4T9XEk88pwZd/chqt568mcJVeilIrEMiZ6IrC
         uSw/nBNmOpWd9yDLagC4HvUNA/BQq43JaRRm38+8neEtJ1t1wLnbnm198QRe5IkPCaHZ
         7DFhrOqTJXPdl9ZYa3nqeIO0MP/sMZIrFWqTMXiBitfWiamGahF6Fl3gluImXa5bFfRt
         QOQziqUpB3gW35THTZEspofTEqS2YVd3kjgCb+dM4w+SnPa8YDsIA8q7IRf721zdQojk
         LlRNV824clroGrHAaJqlGYUpAh6j4kvvj1J0wXequaad6sSJnYBere3ZDsQ57pPdhWA+
         E/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gel8nq8NlFy0mqpmkAyhzEp0wHlK83EywG0rqJQGJUA=;
        b=aOnmXIKeKG/RMUL8Uk9axTQHYJIvGrZoBjK36jQKT7vwCnOr4mI8nUybZakjxEmX0j
         h3Ptp/fC6LXlfWT12MTXqwjtQmn2PUFL31yMz2gf74L+Ea1NpRVVlJA16kNGl0X1wc8s
         pQPhQh+8Qil4UR2d7X2gKGRZNdI3YbfllmaP+ZNKE/KSW7Bv53UedJulQaF3DiTQGg7l
         r7hQmJCQV5EtoJgQhNBL06tPbr+Mn0fZOUMDIvM7zFFzCJfsptm71Rs+yprM5OsYyHEG
         goZBA1+/y+Kpi+fl7FxNhkPSKsux0ggcslv1Uaig5RbQ/u8ZLmwe3Nsg4zMMpKvwjThA
         +dew==
X-Gm-Message-State: AOAM531ucZbpHfAfOHE19xNhs856UR/j6i+2MD7WsBOuly3hDVdgHzqx
        +tA22HIogLTtMN5+/oMwlEBinI9+FP6fBxtpX14=
X-Google-Smtp-Source: ABdhPJy5K6Meu7rVC95DTwF82z+gwNh2FYgL8NNIvf74cWQfAxRpKK9cc6FwR0ioK/VBXHIHPiN0REKm2ENyz5/qtSA=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr24276381jac.69.1606134181074;
 Mon, 23 Nov 2020 04:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
 <20201117162340.43924-7-alexandru.ardelean@analog.com> <20201121183357.254682d5@archlinux>
In-Reply-To: <20201121183357.254682d5@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 23 Nov 2020 14:22:49 +0200
Message-ID: <CA+U=DsptGGBGNEkaYNfXEyowKBPfUX6vNzn19q-UgZG7XZWqWA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/12] iio: buffer: re-route scan_elements via it's kobj_type
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 8:34 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 18:23:34 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > The scan_elements attributes are solely located inside
> > 'industrialio-buffer-sysfs.c'. In order to support more than one buffer per
> > IIO device, we need to expand scan_elements attributes directly to IIO
> > buffer object, and not the IIO device.
> >
> > This also requires that a new 'iio_buffer_attr' type be added which is
> > mostly a copy of 'iio_dev_attr', but this expands to an IIO buffer object.
> >
> > The 'iio_dev_attr' type could have been re-used here, but managing 'device'
> > objects is a bit more tricky (than it looks at first). A 'device' object
> > needs to be initialized & managed and we only need to the 'kobj' to expand
> > from the 'bufferX' directory back to an IIO buffer.
> > kobjects are simpler to manage.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> One trivial thing inline but otherwise looks fine to me.
>
> Jonathan
>
> > ---
> >  drivers/iio/iio_core.h            |   5 +
> >  drivers/iio/industrialio-buffer.c | 162 +++++++++++++++++++++++-------
> >  drivers/iio/industrialio-core.c   |   1 -
> >  3 files changed, 129 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index fced02cadcc3..43d44ec92781 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -31,6 +31,11 @@ void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
> >                                      struct iio_ioctl_handler *h);
> >  void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
> >
> > +int iio_attr_init(struct attribute *attr,
> > +               const char *postfix,
> > +               struct iio_chan_spec const *chan,
> > +               enum iio_shared_by shared_by);
> > +
> >  int __iio_add_chan_devattr(const char *postfix,
> >                          struct iio_chan_spec const *chan,
> >                          ssize_t (*func)(struct device *dev,
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 62c8bd6b67cd..445709ef245c 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -26,6 +26,26 @@
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/buffer_impl.h>
> >
> > +/**
> > + * struct iio_buf_attr - iio buffer specific attribute
> > + * @attr:    underlying attribute
> > + * @address: associated register address
> > + * @l:               list head for maintaining list of dynamically created attrs
> > + * @c:               specification for the underlying channel
> > + * @show:    sysfs show hook for this attribute
> > + * @store:   sysfs store hook for this attribute
> > + */
> > +struct iio_buf_attr {
> > +     struct attribute attr;
> > +     u64 address;
> > +     struct list_head l;
> > +     struct iio_chan_spec const *c;
> > +     ssize_t (*show)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
> > +                     char *buf);
> > +     ssize_t (*store)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
> > +                      const char *buf, size_t count);
> > +};
> > +
> >  static const char * const iio_endian_prefix[] = {
> >       [IIO_BE] = "be",
> >       [IIO_LE] = "le",
> > @@ -210,18 +230,17 @@ void iio_buffer_init(struct iio_buffer *buffer)
> >  }
> >  EXPORT_SYMBOL(iio_buffer_init);
> >
> > -static ssize_t iio_show_scan_index(struct device *dev,
> > -                                struct device_attribute *attr,
> > +static ssize_t iio_show_scan_index(struct iio_buffer *buffer,
> > +                                struct iio_buf_attr *attr,
> >                                  char *buf)
> >  {
> > -     return sprintf(buf, "%u\n", to_iio_dev_attr(attr)->c->scan_index);
> > +     return sprintf(buf, "%u\n", attr->c->scan_index);
> >  }
> >
> > -static ssize_t iio_show_fixed_type(struct device *dev,
> > -                                struct device_attribute *attr,
> > +static ssize_t iio_show_fixed_type(struct iio_buffer *buffer,
> > +                                struct iio_buf_attr *this_attr,
> >                                  char *buf)
> >  {
> > -     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> >       u8 type = this_attr->c->scan_type.endianness;
> >
> >       if (type == IIO_CPU) {
> > @@ -248,17 +267,14 @@ static ssize_t iio_show_fixed_type(struct device *dev,
> >                      this_attr->c->scan_type.shift);
> >  }
> >
> > -static ssize_t iio_scan_el_show(struct device *dev,
> > -                             struct device_attribute *attr,
> > +static ssize_t iio_scan_el_show(struct iio_buffer *buffer,
> > +                             struct iio_buf_attr *attr,
> >                               char *buf)
> >  {
> >       int ret;
> > -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> >
> >       /* Ensure ret is 0 or 1. */
> > -     ret = !!test_bit(to_iio_dev_attr(attr)->address,
> > -                    buffer->scan_mask);
> > +     ret = !!test_bit(attr->address, buffer->scan_mask);
> >
> >       return sprintf(buf, "%d\n", ret);
> >  }
> > @@ -359,16 +375,14 @@ static int iio_scan_mask_query(struct iio_dev *indio_dev,
> >       return !!test_bit(bit, buffer->scan_mask);
> >  };
> >
> > -static ssize_t iio_scan_el_store(struct device *dev,
> > -                              struct device_attribute *attr,
> > +static ssize_t iio_scan_el_store(struct iio_buffer *buffer,
> > +                              struct iio_buf_attr *this_attr,
> >                                const char *buf,
> >                                size_t len)
> >  {
> > +     struct iio_dev *indio_dev = buffer->indio_dev;
> >       int ret;
> >       bool state;
> > -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > -     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> >
> >       ret = strtobool(buf, &state);
> >       if (ret < 0)
> > @@ -398,24 +412,20 @@ static ssize_t iio_scan_el_store(struct device *dev,
> >
> >  }
> >
> > -static ssize_t iio_scan_el_ts_show(struct device *dev,
> > -                                struct device_attribute *attr,
> > +static ssize_t iio_scan_el_ts_show(struct iio_buffer *buffer,
> > +                                struct iio_buf_attr *attr,
> >                                  char *buf)
> >  {
> > -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> > -
> >       return sprintf(buf, "%d\n", buffer->scan_timestamp);
> >  }
> >
> > -static ssize_t iio_scan_el_ts_store(struct device *dev,
> > -                                 struct device_attribute *attr,
> > +static ssize_t iio_scan_el_ts_store(struct iio_buffer *buffer,
> > +                                 struct iio_buf_attr *attr,
> >                                   const char *buf,
> >                                   size_t len)
> >  {
> > +     struct iio_dev *indio_dev = buffer->indio_dev;
> >       int ret;
> > -     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -     struct iio_buffer *buffer = indio_dev->buffer;
> >       bool state;
> >
> >       ret = strtobool(buf, &state);
> > @@ -434,13 +444,88 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
> >       return ret ? ret : len;
> >  }
> >
> > +static int __iio_add_chan_bufattr(const char *postfix,
> > +                               struct iio_chan_spec const *chan,
> > +                               ssize_t (*readfunc)(struct iio_buffer *buffer,
> > +                                                   struct iio_buf_attr *attr,
> > +                                                   char *buf),
> > +                               ssize_t (*writefunc)(struct iio_buffer *buffer,
> > +                                                    struct iio_buf_attr *attr,
> > +                                                    const char *buf,
> > +                                                    size_t len),
> > +                               u64 mask,
> > +                               enum iio_shared_by shared_by,
> > +                               struct device *dev,
> > +                               struct list_head *attr_list)
> > +{
> > +     struct iio_buf_attr *iio_attr, *t;
> > +     int ret;
> > +
> > +     iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> > +     if (iio_attr == NULL)
> > +             return -ENOMEM;
> > +
> > +     ret = iio_attr_init(&iio_attr->attr, postfix, chan, shared_by);
> > +     if (ret)
> > +             goto error_iio_buf_attr_free;
> > +
> > +     iio_attr->c = chan;
> > +     iio_attr->address = mask;
> > +     list_for_each_entry(t, attr_list, l) {
> > +             if (strcmp(t->attr.name, iio_attr->attr.name) == 0) {
> > +                     if (shared_by == IIO_SEPARATE)
> > +                             dev_err(dev, "tried to double register : %s\n",
> > +                                     t->attr.name);
> > +                     ret = -EBUSY;
> > +                     goto error_iio_buf_attr_deinit;
> > +             }
> > +     }
> > +     list_add(&iio_attr->l, attr_list);
> > +
> > +     if (readfunc) {
> > +             iio_attr->attr.mode |= S_IRUGO;
> > +             iio_attr->show = readfunc;
> > +     }
> > +
> > +     if (writefunc) {
> > +             iio_attr->attr.mode |= S_IWUSR;
> > +             iio_attr->store = writefunc;
> > +     }
> > +
> > +     return 0;
> > +
> > +error_iio_buf_attr_deinit:
> > +     kfree(iio_attr->attr.name);
> > +error_iio_buf_attr_free:
> > +     kfree(iio_attr);
> > +     return ret;
> > +}
> > +
> > +/**
> > + * iio_free_chan_bufattr_list() - Free a list of IIO buffer attributes
> > + * @attr_list: List of IIO buffer attributes
> > + *
> > + * This function frees the memory allocated for each of the IIO buffer
> > + * attributes in the list.
> > + */
> > +static void iio_free_chan_bufattr_list(struct list_head *attr_list)
> > +{
> > +     struct iio_buf_attr *p, *n;
> > +
> > +     list_for_each_entry_safe(p, n, attr_list, l) {
> > +             kfree(p->attr.name);
>
> Trivial but ordering in here seems a bit odd.  Take it off
> list before doing the name free makes more sense to me.

Ack.

>
> > +             list_del(&p->l);
> > +             kfree(p);
> > +     }
> > +}
> > +
> >  static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                       struct iio_buffer *buffer,
> >                                       const struct iio_chan_spec *chan)
> >  {
> >       int ret, attrcount = 0;
> >
> > -     ret = __iio_add_chan_devattr("index",
> > +     ret = __iio_add_chan_bufattr("index",
> >                                    chan,
> >                                    &iio_show_scan_index,
> >                                    NULL,
> > @@ -451,7 +536,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >       if (ret)
> >               return ret;
> >       attrcount++;
> > -     ret = __iio_add_chan_devattr("type",
> > +     ret = __iio_add_chan_bufattr("type",
> >                                    chan,
> >                                    &iio_show_fixed_type,
> >                                    NULL,
> > @@ -463,7 +548,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >               return ret;
> >       attrcount++;
> >       if (chan->type != IIO_TIMESTAMP)
> > -             ret = __iio_add_chan_devattr("en",
> > +             ret = __iio_add_chan_bufattr("en",
> >                                            chan,
> >                                            &iio_scan_el_show,
> >                                            &iio_scan_el_store,
> > @@ -472,7 +557,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >                                            &indio_dev->dev,
> >                                            &buffer->scan_el_dev_attr_list);
> >       else
> > -             ret = __iio_add_chan_devattr("en",
> > +             ret = __iio_add_chan_bufattr("en",
> >                                            chan,
> >                                            &iio_scan_el_ts_show,
> >                                            &iio_scan_el_ts_store,
> > @@ -1251,6 +1336,7 @@ static struct attribute *iio_buffer_attrs[] = {
> >  };
> >
> >  #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> > +#define to_iio_buf_attr(_attr) container_of(_attr, struct iio_buf_attr, attr)
> >
> >  static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
> >                                       struct attribute *attr,
> > @@ -1291,9 +1377,9 @@ static ssize_t iio_scan_el_dir_attr_show(struct kobject *kobj,
> >                                        char *buf)
> >  {
> >       struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> > -     struct device_attribute *dattr = to_dev_attr(attr);
> > +     struct iio_buf_attr *battr = to_iio_buf_attr(attr);
> >
> > -     return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> > +     return battr->show(buffer, battr, buf);
> >  }
> >
> >  static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
> > @@ -1302,9 +1388,9 @@ static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
> >                                         size_t len)
> >  {
> >       struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> > -     struct device_attribute *dattr = to_dev_attr(attr);
> > +     struct iio_buf_attr *battr = to_iio_buf_attr(attr);
> >
> > -     return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> > +     return battr->store(buffer, battr, buf, len);
> >  }
> >
> >  static const struct sysfs_ops iio_scan_el_dir_sysfs_ops = {
> > @@ -1349,7 +1435,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >                                            struct iio_dev *indio_dev,
> >                                            unsigned int idx)
> >  {
> > -     struct iio_dev_attr *p;
> > +     struct iio_buf_attr *p;
> >       struct attribute **attr;
> >       int ret, i, attrn, attrcount;
> >       const struct iio_chan_spec *channels;
> > @@ -1430,7 +1516,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >
> >       attrn = 0;
> >       list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> > -             buffer->scan_el_attrs[attrn++] = &p->dev_attr.attr;
> > +             buffer->scan_el_attrs[attrn++] = &p->attr;
> >
> >       ret = iio_sysfs_add_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
> >       if (ret)
> > @@ -1446,7 +1532,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >       bitmap_free(buffer->scan_mask);
> >  error_cleanup_dynamic:
> >       iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> > -     iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > +     iio_free_chan_bufattr_list(&buffer->scan_el_dev_attr_list);
> >  error_buffer_kobject_put:
> >       kobject_put(&buffer->buffer_dir);
> >  error_buffer_free_attrs:
> > @@ -1507,7 +1593,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> >       kfree(buffer->scan_el_attrs);
> >       bitmap_free(buffer->scan_mask);
> >       iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> > -     iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > +     iio_free_chan_bufattr_list(&buffer->scan_el_dev_attr_list);
> >       kobject_put(&buffer->buffer_dir);
> >       kfree(buffer->buffer_attrs);
> >  }
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index e9aa84f5b05a..28830e87e8cb 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -972,7 +972,6 @@ static ssize_t iio_write_channel_info(struct device *dev,
> >       return len;
> >  }
> >
> > -static
> >  int iio_attr_init(struct attribute *attr,
> >                 const char *postfix,
> >                 struct iio_chan_spec const *chan,
>
