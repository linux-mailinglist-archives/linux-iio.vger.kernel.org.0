Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6F300862
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 17:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbhAVQNm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 11:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbhAVQNT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 11:13:19 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9CC061786;
        Fri, 22 Jan 2021 08:12:39 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q2so12042249iow.13;
        Fri, 22 Jan 2021 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+f31h8JPRbEoCi/d8mHQzBlwJkNkVENlbHhuyvKA2M=;
        b=V5MsCPkvOv2igpotn62Ru1TpiQIQU/XWtG/KlffHiwNIZUXBHnqIhapLmPHNqE9Egs
         i2HtR0L8d3y1H/6Elv5UDRs+fmFuJy+HMvNwXwUNkRcl+nvAsh/jXJrmvBJQOeozAry8
         9dEmq6uRZGUnQq3xFxalk0fk/4vfgtFNCU03gBMJM5G9P32DIOyg5Qf6HYYXx3/PzPdR
         ootr7aMSJeN3E1xnm418lCUm0IcmsB+yRYE9CwDePgdn7BT3ckJzddWBNyWQnI7rVg/k
         xy6rgm039qtR6wEtXnvgmkkCqhqLLnOn+U0ifOzfabtI6kD/ppwZaw1V2na6DwFZx5Ak
         ZM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+f31h8JPRbEoCi/d8mHQzBlwJkNkVENlbHhuyvKA2M=;
        b=eyjEUQR4Q8ixeORSnDBg2VeXH4FEMr1SyYLiIV7xGmv1FoDua7hg1MRQUr1sqwR5cx
         dA3SNhSE1hyMverh2rltjHqlG9ojRpCGJyI0t6wvWOuOkEgT4vHqN8xoc+eJQQUiarxG
         Z5vZXTSADjGCgGuBdBDwxRIuDUnrnr+ck4tTKL0MpBGPqDQdOYAQ7tNXfayrlWCWwF14
         0/HdzAyS0OBkWW2t3z+Np+tJnMkmKMkBYDJHgDhYMAjHavfocua326Tu1UFIHl9IJkAb
         shKyCdnwGbXcDmLBuoz5VYfaMiMXzvzyHKuSPv0ZoqcAVK9sDJwakEkBPhRzS1s4U3fB
         72iQ==
X-Gm-Message-State: AOAM530g4Eq8TXGs/IAM3qXw+1CvHnSZNt+nhzLkybk9XcCMDOc3I1nS
        KpvhphhIsGuX6CWswMpb3STQuMzyMtifMq++lD0=
X-Google-Smtp-Source: ABdhPJyH1D2ky6Bdcbg6s+cDpNRSYOaDkGcBjk76LG/Cp2agNhy2PL54IvqYPxhdH6aZg8Sb95Qy4RWwBW72Y1Sjez8=
X-Received: by 2002:a92:d082:: with SMTP id h2mr1919551ilh.292.1611331958651;
 Fri, 22 Jan 2021 08:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20210122155805.83012-1-alexandru.ardelean@analog.com> <20210122155805.83012-7-alexandru.ardelean@analog.com>
In-Reply-To: <20210122155805.83012-7-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 22 Jan 2021 18:12:27 +0200
Message-ID: <CA+U=DsrLYYvu0yQfoA-+yGRMaW3Z5G0zPWvEtq3W9vqhhieNtw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] iio: buffer: re-route scan_elements via it's kobj_type
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 22, 2021 at 5:57 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The scan_elements attributes are solely located inside
> 'industrialio-buffer-sysfs.c'. In order to support more than one buffer per
> IIO device, we need to expand scan_elements attributes directly to IIO
> buffer object, and not the IIO device.
>
> This also requires that a new 'iio_buffer_attr' type be added which is
> mostly a copy of 'iio_dev_attr', but this expands to an IIO buffer object.
>
> The 'iio_dev_attr' type could have been re-used here, but managing 'device'
> objects is a bit more tricky (than it looks at first). A 'device' object
> needs to be initialized & managed and we only need to the 'kobj' to expand
> from the 'bufferX' directory back to an IIO buffer.
> kobjects are simpler to manage.

Something odd happened here.
I'm only seeing half the patches.
No idea if the others will show.
I'll leave this here for a while, and if they don't show up tomorrow
I'll re-send.
In the meantime, the set is visible here:
https://github.com/analogdevicesinc/linux/commits/iio-multibuffer3

>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/iio_core.h            |   5 +
>  drivers/iio/industrialio-buffer.c | 160 +++++++++++++++++++++++-------
>  drivers/iio/industrialio-core.c   |   1 -
>  3 files changed, 128 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index fced02cadcc3..43d44ec92781 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -31,6 +31,11 @@ void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
>                                        struct iio_ioctl_handler *h);
>  void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
>
> +int iio_attr_init(struct attribute *attr,
> +                 const char *postfix,
> +                 struct iio_chan_spec const *chan,
> +                 enum iio_shared_by shared_by);
> +
>  int __iio_add_chan_devattr(const char *postfix,
>                            struct iio_chan_spec const *chan,
>                            ssize_t (*func)(struct device *dev,
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 628d78125126..524b897a1877 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -26,6 +26,26 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>
>
> +/**
> + * struct iio_buf_attr - iio buffer specific attribute
> + * @attr:      underlying attribute
> + * @address:   associated register address
> + * @l:         list head for maintaining list of dynamically created attrs
> + * @c:         specification for the underlying channel
> + * @show:      sysfs show hook for this attribute
> + * @store:     sysfs store hook for this attribute
> + */
> +struct iio_buf_attr {
> +       struct attribute attr;
> +       u64 address;
> +       struct list_head l;
> +       struct iio_chan_spec const *c;
> +       ssize_t (*show)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
> +                       char *buf);
> +       ssize_t (*store)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
> +                        const char *buf, size_t count);
> +};
> +
>  static const char * const iio_endian_prefix[] = {
>         [IIO_BE] = "be",
>         [IIO_LE] = "le",
> @@ -210,18 +230,17 @@ void iio_buffer_init(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL(iio_buffer_init);
>
> -static ssize_t iio_show_scan_index(struct device *dev,
> -                                  struct device_attribute *attr,
> +static ssize_t iio_show_scan_index(struct iio_buffer *buffer,
> +                                  struct iio_buf_attr *attr,
>                                    char *buf)
>  {
> -       return sprintf(buf, "%u\n", to_iio_dev_attr(attr)->c->scan_index);
> +       return sprintf(buf, "%u\n", attr->c->scan_index);
>  }
>
> -static ssize_t iio_show_fixed_type(struct device *dev,
> -                                  struct device_attribute *attr,
> +static ssize_t iio_show_fixed_type(struct iio_buffer *buffer,
> +                                  struct iio_buf_attr *this_attr,
>                                    char *buf)
>  {
> -       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>         u8 type = this_attr->c->scan_type.endianness;
>
>         if (type == IIO_CPU) {
> @@ -248,17 +267,14 @@ static ssize_t iio_show_fixed_type(struct device *dev,
>                        this_attr->c->scan_type.shift);
>  }
>
> -static ssize_t iio_scan_el_show(struct device *dev,
> -                               struct device_attribute *attr,
> +static ssize_t iio_scan_el_show(struct iio_buffer *buffer,
> +                               struct iio_buf_attr *attr,
>                                 char *buf)
>  {
>         int ret;
> -       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -       struct iio_buffer *buffer = indio_dev->buffer;
>
>         /* Ensure ret is 0 or 1. */
> -       ret = !!test_bit(to_iio_dev_attr(attr)->address,
> -                      buffer->scan_mask);
> +       ret = !!test_bit(attr->address, buffer->scan_mask);
>
>         return sprintf(buf, "%d\n", ret);
>  }
> @@ -359,16 +375,14 @@ static int iio_scan_mask_query(struct iio_dev *indio_dev,
>         return !!test_bit(bit, buffer->scan_mask);
>  };
>
> -static ssize_t iio_scan_el_store(struct device *dev,
> -                                struct device_attribute *attr,
> +static ssize_t iio_scan_el_store(struct iio_buffer *buffer,
> +                                struct iio_buf_attr *this_attr,
>                                  const char *buf,
>                                  size_t len)
>  {
> +       struct iio_dev *indio_dev = buffer->indio_dev;
>         int ret;
>         bool state;
> -       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -       struct iio_buffer *buffer = indio_dev->buffer;
> -       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>
>         ret = strtobool(buf, &state);
>         if (ret < 0)
> @@ -398,24 +412,20 @@ static ssize_t iio_scan_el_store(struct device *dev,
>
>  }
>
> -static ssize_t iio_scan_el_ts_show(struct device *dev,
> -                                  struct device_attribute *attr,
> +static ssize_t iio_scan_el_ts_show(struct iio_buffer *buffer,
> +                                  struct iio_buf_attr *attr,
>                                    char *buf)
>  {
> -       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -       struct iio_buffer *buffer = indio_dev->buffer;
> -
>         return sprintf(buf, "%d\n", buffer->scan_timestamp);
>  }
>
> -static ssize_t iio_scan_el_ts_store(struct device *dev,
> -                                   struct device_attribute *attr,
> +static ssize_t iio_scan_el_ts_store(struct iio_buffer *buffer,
> +                                   struct iio_buf_attr *attr,
>                                     const char *buf,
>                                     size_t len)
>  {
> +       struct iio_dev *indio_dev = buffer->indio_dev;
>         int ret;
> -       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -       struct iio_buffer *buffer = indio_dev->buffer;
>         bool state;
>
>         ret = strtobool(buf, &state);
> @@ -434,13 +444,88 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>         return ret ? ret : len;
>  }
>
> +static int __iio_add_chan_bufattr(const char *postfix,
> +                                 struct iio_chan_spec const *chan,
> +                                 ssize_t (*readfunc)(struct iio_buffer *buffer,
> +                                                     struct iio_buf_attr *attr,
> +                                                     char *buf),
> +                                 ssize_t (*writefunc)(struct iio_buffer *buffer,
> +                                                      struct iio_buf_attr *attr,
> +                                                      const char *buf,
> +                                                      size_t len),
> +                                 u64 mask,
> +                                 enum iio_shared_by shared_by,
> +                                 struct device *dev,
> +                                 struct list_head *attr_list)
> +{
> +       struct iio_buf_attr *iio_attr, *t;
> +       int ret;
> +
> +       iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> +       if (iio_attr == NULL)
> +               return -ENOMEM;
> +
> +       ret = iio_attr_init(&iio_attr->attr, postfix, chan, shared_by);
> +       if (ret)
> +               goto error_iio_buf_attr_free;
> +
> +       iio_attr->c = chan;
> +       iio_attr->address = mask;
> +       list_for_each_entry(t, attr_list, l) {
> +               if (strcmp(t->attr.name, iio_attr->attr.name) == 0) {
> +                       if (shared_by == IIO_SEPARATE)
> +                               dev_err(dev, "tried to double register : %s\n",
> +                                       t->attr.name);
> +                       ret = -EBUSY;
> +                       goto error_iio_buf_attr_deinit;
> +               }
> +       }
> +       list_add(&iio_attr->l, attr_list);
> +
> +       if (readfunc) {
> +               iio_attr->attr.mode |= S_IRUGO;
> +               iio_attr->show = readfunc;
> +       }
> +
> +       if (writefunc) {
> +               iio_attr->attr.mode |= S_IWUSR;
> +               iio_attr->store = writefunc;
> +       }
> +
> +       return 0;
> +
> +error_iio_buf_attr_deinit:
> +       kfree(iio_attr->attr.name);
> +error_iio_buf_attr_free:
> +       kfree(iio_attr);
> +       return ret;
> +}
> +
> +/**
> + * iio_free_chan_bufattr_list() - Free a list of IIO buffer attributes
> + * @attr_list: List of IIO buffer attributes
> + *
> + * This function frees the memory allocated for each of the IIO buffer
> + * attributes in the list.
> + */
> +static void iio_free_chan_bufattr_list(struct list_head *attr_list)
> +{
> +       struct iio_buf_attr *p, *n;
> +
> +       list_for_each_entry_safe(p, n, attr_list, l) {
> +               list_del(&p->l);
> +               kfree(p->attr.name);
> +               kfree(p);
> +       }
> +}
> +
>  static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>                                         struct iio_buffer *buffer,
>                                         const struct iio_chan_spec *chan)
>  {
>         int ret, attrcount = 0;
>
> -       ret = __iio_add_chan_devattr("index",
> +       ret = __iio_add_chan_bufattr("index",
>                                      chan,
>                                      &iio_show_scan_index,
>                                      NULL,
> @@ -451,7 +536,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>         if (ret)
>                 return ret;
>         attrcount++;
> -       ret = __iio_add_chan_devattr("type",
> +       ret = __iio_add_chan_bufattr("type",
>                                      chan,
>                                      &iio_show_fixed_type,
>                                      NULL,
> @@ -463,7 +548,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>                 return ret;
>         attrcount++;
>         if (chan->type != IIO_TIMESTAMP)
> -               ret = __iio_add_chan_devattr("en",
> +               ret = __iio_add_chan_bufattr("en",
>                                              chan,
>                                              &iio_scan_el_show,
>                                              &iio_scan_el_store,
> @@ -472,7 +557,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>                                              &indio_dev->dev,
>                                              &buffer->scan_el_dev_attr_list);
>         else
> -               ret = __iio_add_chan_devattr("en",
> +               ret = __iio_add_chan_bufattr("en",
>                                              chan,
>                                              &iio_scan_el_ts_show,
>                                              &iio_scan_el_ts_store,
> @@ -1251,6 +1336,7 @@ static struct attribute *iio_buffer_attrs[] = {
>  };
>
>  #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> +#define to_iio_buf_attr(_attr) container_of(_attr, struct iio_buf_attr, attr)
>
>  static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
>                                         struct attribute *attr,
> @@ -1291,9 +1377,9 @@ static ssize_t iio_scan_el_dir_attr_show(struct kobject *kobj,
>                                          char *buf)
>  {
>         struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> -       struct device_attribute *dattr = to_dev_attr(attr);
> +       struct iio_buf_attr *battr = to_iio_buf_attr(attr);
>
> -       return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> +       return battr->show(buffer, battr, buf);
>  }
>
>  static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
> @@ -1302,9 +1388,9 @@ static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
>                                           size_t len)
>  {
>         struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> -       struct device_attribute *dattr = to_dev_attr(attr);
> +       struct iio_buf_attr *battr = to_iio_buf_attr(attr);
>
> -       return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> +       return battr->store(buffer, battr, buf, len);
>  }
>
>  static const struct sysfs_ops iio_scan_el_dir_sysfs_ops = {
> @@ -1372,7 +1458,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>                                              struct iio_dev *indio_dev,
>                                              unsigned int idx)
>  {
> -       struct iio_dev_attr *p;
> +       struct iio_buf_attr *p;
>         struct attribute **attr;
>         int ret, i, attrn, attrcount;
>         const struct iio_chan_spec *channels;
> @@ -1453,7 +1539,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>
>         attrn = 0;
>         list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> -               buffer->scan_el_attrs[attrn++] = &p->dev_attr.attr;
> +               buffer->scan_el_attrs[attrn++] = &p->attr;
>
>         ret = iio_sysfs_add_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
>         if (ret)
> @@ -1469,7 +1555,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>         bitmap_free(buffer->scan_mask);
>  error_cleanup_dynamic:
>         iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> -       iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> +       iio_free_chan_bufattr_list(&buffer->scan_el_dev_attr_list);
>  error_buffer_kobject_put:
>         kobject_put(&buffer->buffer_dir);
>  error_buffer_free_attrs:
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index b8f7261945f5..088e59042226 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -967,7 +967,6 @@ static ssize_t iio_write_channel_info(struct device *dev,
>         return len;
>  }
>
> -static
>  int iio_attr_init(struct attribute *attr,
>                   const char *postfix,
>                   struct iio_chan_spec const *chan,
> --
> 2.17.1
>
