Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD302C056F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 13:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgKWMV4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 07:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgKWMV4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 07:21:56 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51FFC0613CF;
        Mon, 23 Nov 2020 04:21:54 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id t13so15711255ilp.2;
        Mon, 23 Nov 2020 04:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bt7RW8tesctK1xmjAkgVszIlLX3IXHJkMOc4XyKly3c=;
        b=Mej9gtAHmigb/muFkZljF620dpm1VAIpj3v/yxbPL04Wb/K73bzItpgk2l0gbx4fBD
         ptYFUdvY4uW1GFh1d99I885sJb14RVMvMSbXz3eAzMVkOP1Qss6VHZN9xjMTT+bTm1qo
         muMhKmh70nOgzEyMQenRIBcFT2ETkq2EZ68imEwZtYVxiwUtGGAg7qDrXDIYzzbzKeeo
         eOXmgN9KkufeEyhJNwG9gm2slzoq8pH0clW6S6lYQI81nHEHz0Rgr7W//v8YkmO8Zrwu
         bSElgdhv0uGtL00/Vu96cvl3Qq1b4hpqvuTFYDs+MS+7nFKDpVwFCRgZt2xZZn0z/AqY
         NZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bt7RW8tesctK1xmjAkgVszIlLX3IXHJkMOc4XyKly3c=;
        b=ZFpXc0tQwzEajH5xPqgjni4+YzSST8wlJFw1JXQxK9fz7kCGotja7rJKfemnJX8lLy
         dXnsk9Anmz29o6zEPeR3r3V3H10szHQ7NcSvcGea29Q3lH+axMVeXyThm88u5LkcWP8E
         2hA85eIKmUBiWh5odSq94v884wNc+nuXriEvcF7geX/vYkwK7+B3LTPgd/IDOHiIf7HV
         NFAEWEGxW4iFQ5gaHlJeqVElfu0hEAKEmwaG1QgvLg1RYOuF9rJX4/VR+WazGVvW8kMj
         swhSgZCFLUmrF18s8vnpxB8cy9iBxbm5N/4i4En2AvyFu+ZvDo6IfX9s6C5gPv0HBJSl
         lWFQ==
X-Gm-Message-State: AOAM531lrumkFsm44tWlnQ45bHMjMu5H/9QhBPAZJi1U8j2WtxdvvEh/
        kFg6ESPRuKuPdYd/bY7bxUcso9JR4xZHLJ9Ms60=
X-Google-Smtp-Source: ABdhPJw31r1DU+cSRep2WbAidzAuU4MLjrHDjqbtUMQQwExYlyVQknqhG0eSV54HT0hBsveuTlurWLe6VJpf/q20Dx0=
X-Received: by 2002:a92:d90c:: with SMTP id s12mr37040949iln.100.1606134113956;
 Mon, 23 Nov 2020 04:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
 <20201117162340.43924-4-alexandru.ardelean@analog.com> <20201121182435.54c61758@archlinux>
In-Reply-To: <20201121182435.54c61758@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 23 Nov 2020 14:21:42 +0200
Message-ID: <CA+U=Dsq0e4ytf81QeX0iQOeyxV6TSFFx9VZW5TQXH6OC7e9wng@mail.gmail.com>
Subject: Re: [RFC PATCH 03/12] iio: buffer: rework buffer & scan_elements dir creation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 8:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 18:23:31 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > When adding more than one IIO buffer per IIO device, we will need to create
> > a buffer & scan_elements directory for each buffer.
> > We also want to move the 'scan_elements' to be a sub-directory of the
> > 'buffer' folder.
> >
> > The format we want to reach is, for a iio:device0 folder, for 2 buffers
> > [for example], we have a 'buffer0' and a 'buffer1' subfolder, and each with
> > it's own 'scan_elements' subfolder.
> >
> > So, for example:
> >    iio:device0/buffer0
> >       scan_elements/
> >
> >    iio:device0/buffer1
> >       scan_elements/
> >
> > The other attributes under 'bufferX' would remain unchanged.
> >
> > However, we would also need to symlink back to the old 'buffer' &
> > 'scan_elements' folders, to keep backwards compatibility.
> >
> > Doing all these, require that we maintain the kobjects for each 'bufferX'
> > and 'scan_elements' so that we can symlink them back. We also need to
> > implement the sysfs_ops for these folders.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Hmm. This ended up a bit nasty.  It could do with a few more comments
> in the code to make it clear what is going on.

I'll take a look at these comments.

>
> > ---
> >  drivers/iio/industrialio-buffer.c | 151 ++++++++++++++++++++++++++----
> >  drivers/iio/industrialio-core.c   |  24 ++---
> >  include/linux/iio/buffer_impl.h   |  14 ++-
> >  include/linux/iio/iio.h           |   2 +-
> >  4 files changed, 156 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 08aa8e0782ce..8b31faf049a5 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1175,8 +1175,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
> >       return (ret < 0) ? ret : len;
> >  }
> >
> > -static const char * const iio_scan_elements_group_name = "scan_elements";
> > -
> >  static ssize_t iio_buffer_show_watermark(struct device *dev,
> >                                        struct device_attribute *attr,
> >                                        char *buf)
> > @@ -1252,6 +1250,101 @@ static struct attribute *iio_buffer_attrs[] = {
> >       &dev_attr_data_available.attr,
> >  };
> >
> > +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> > +
> > +static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
> > +                                     struct attribute *attr,
> > +                                     char *buf)
> > +{
> > +     struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> > +     struct device_attribute *dattr;
> > +
> > +     dattr = to_dev_attr(attr);
> > +
> > +     return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> > +}
> > +
> > +static ssize_t iio_buffer_dir_attr_store(struct kobject *kobj,
> > +                                      struct attribute *attr,
> > +                                      const char *buf,
> > +                                      size_t len)
> > +{
> > +     struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> > +     struct device_attribute *dattr;
> > +
> > +     dattr = to_dev_attr(attr);
> > +
> > +     return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> > +}
> > +
> > +static const struct sysfs_ops iio_buffer_dir_sysfs_ops = {
> > +     .show = iio_buffer_dir_attr_show,
> > +     .store = iio_buffer_dir_attr_store,
> > +};
> > +
> > +static struct kobj_type iio_buffer_dir_ktype = {
> > +     .sysfs_ops = &iio_buffer_dir_sysfs_ops,
> > +};
> > +
> > +static ssize_t iio_scan_el_dir_attr_show(struct kobject *kobj,
> > +                                      struct attribute *attr,
> > +                                      char *buf)
> > +{
> > +     struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> > +     struct device_attribute *dattr = to_dev_attr(attr);
> > +
> > +     return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> > +}
> > +
> > +static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
> > +                                       struct attribute *attr,
> > +                                       const char *buf,
> > +                                       size_t len)
> > +{
> > +     struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> > +     struct device_attribute *dattr = to_dev_attr(attr);
> > +
> > +     return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> > +}
> > +
> > +static const struct sysfs_ops iio_scan_el_dir_sysfs_ops = {
> > +     .show = iio_scan_el_dir_attr_show,
> > +     .store = iio_scan_el_dir_attr_store,
> > +};
> > +
> > +static struct kobj_type iio_scan_el_dir_ktype = {
> > +     .sysfs_ops = &iio_scan_el_dir_sysfs_ops,
> > +};
> > +
> > +/*
> > + * This iio_sysfs_{add,del}_attrs() are essentially re-implementations of
> > + * sysfs_create_files() & sysfs_remove_files(), but they are meant to get
> > + * around the const-pointer mismatch situation with using them.
> > + *
> > + * sysfs_{create,remove}_files() uses 'const struct attribute * const *ptr',
> > + * while these are happy with just 'struct attribute **ptr'
>
> Ouch.  This definitely doesn't feel like a great thing to do.

Yep.
I'm still not 100% sure that this is needed.
But it may be that this is the best option.

>
> > + */
> > +static int iio_sysfs_add_attrs(struct kobject *kobj, struct attribute **ptr)
> > +{
> > +     int err = 0;
> > +     int i;
> > +
> > +     for (i = 0; ptr[i] && !err; i++)
> > +             err = sysfs_create_file(kobj, ptr[i]);
> > +     if (err)
> > +             while (--i >= 0)
> > +                     sysfs_remove_file(kobj, ptr[i]);
> > +     return err;
> > +}
> > +
> > +static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; ptr[i]; i++)
> > +             sysfs_remove_file(kobj, ptr[i]);
> > +}
> > +
> >  static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>
> Definitely add some docs to this to say why we have this complexity..

Ack.

>
> >                                            struct iio_dev *indio_dev)
> >  {
> > @@ -1282,12 +1375,16 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >               memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
> >                      sizeof(struct attribute *) * attrcount);
> >
> > -     attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
> > +     buffer->buffer_attrs = attr;
> >
> > -     buffer->buffer_group.name = "buffer";
> > -     buffer->buffer_group.attrs = attr;
> > +     ret = kobject_init_and_add(&buffer->buffer_dir, &iio_buffer_dir_ktype,
> > +                                &indio_dev->dev.kobj, "buffer");
> > +     if (ret)
> > +             goto error_buffer_free_attrs;
> >
> > -     indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
> > +     ret = iio_sysfs_add_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> > +     if (ret)
> > +             goto error_buffer_kobject_put;
> >
> >       attrcount = 0;
> >       INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> > @@ -1317,28 +1414,42 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >               }
> >       }
> >
> > -     buffer->scan_el_group.name = iio_scan_elements_group_name;
> > -
> > -     buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
> > -                                           sizeof(buffer->scan_el_group.attrs[0]),
> > -                                           GFP_KERNEL);
> > -     if (buffer->scan_el_group.attrs == NULL) {
> > +     buffer->scan_el_attrs = kcalloc(attrcount + 1,
> > +                                     sizeof(buffer->scan_el_attrs[0]),
> > +                                     GFP_KERNEL);
> > +     if (buffer->scan_el_attrs == NULL) {
> >               ret = -ENOMEM;
> >               goto error_free_scan_mask;
> >       }
> > -     attrn = 0;
> >
> > +     ret = kobject_init_and_add(&buffer->scan_el_dir, &iio_scan_el_dir_ktype,
> > +                                &indio_dev->dev.kobj, "scan_elements");
> > +     if (ret)
> > +             goto error_free_scan_attrs;
> > +
> > +     attrn = 0;
> >       list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> > -             buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
> > -     indio_dev->groups[indio_dev->groupcounter++] = &buffer->scan_el_group;
> > +             buffer->scan_el_attrs[attrn++] = &p->dev_attr.attr;
> > +
> > +     ret = iio_sysfs_add_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
> > +     if (ret)
> > +             goto error_scan_kobject_put;
> >
> >       return 0;
> >
> > +error_scan_kobject_put:
> > +     kobject_put(&buffer->scan_el_dir);
> > +error_free_scan_attrs:
> > +     kfree(buffer->scan_el_attrs);
> >  error_free_scan_mask:
> >       bitmap_free(buffer->scan_mask);
> >  error_cleanup_dynamic:
> > +     iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> >       iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > -     kfree(buffer->buffer_group.attrs);
> > +error_buffer_kobject_put:
> > +     kobject_put(&buffer->buffer_dir);
> > +error_buffer_free_attrs:
> > +     kfree(buffer->buffer_attrs);
> >
> >       return ret;
> >  }
> > @@ -1366,10 +1477,14 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >
> >  static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> >  {
> > +     iio_sysfs_del_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
> > +     kobject_put(&buffer->scan_el_dir);
> > +     kfree(buffer->scan_el_attrs);
> >       bitmap_free(buffer->scan_mask);
> > -     kfree(buffer->buffer_group.attrs);
> > -     kfree(buffer->scan_el_group.attrs);
> > +     iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> >       iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > +     kobject_put(&buffer->buffer_dir);
> > +     kfree(buffer->buffer_attrs);
> >  }
> >
> >  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index ca8b11541477..f389d8feacb0 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1819,18 +1819,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
> >
> >       iio_device_register_debugfs(indio_dev);
> >
> > -     ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
> > -     if (ret) {
> > -             dev_err(indio_dev->dev.parent,
> > -                     "Failed to create buffer sysfs interfaces\n");
> > -             goto error_unreg_debugfs;
> > -     }
> > -
> >       ret = iio_device_register_sysfs(indio_dev);
> >       if (ret) {
> >               dev_err(indio_dev->dev.parent,
> >                       "Failed to register sysfs interfaces\n");
> > -             goto error_buffer_free_sysfs;
> > +             goto error_unreg_debugfs;
> >       }
> >       ret = iio_device_register_eventset(indio_dev);
> >       if (ret) {
> > @@ -1859,14 +1852,21 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
> >       if (ret < 0)
> >               goto error_unreg_eventset;
> >
> > +     ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
>
> There are some races around late creation of sysfs files (IIRC) but
> I'm not sure what else could be done here.

Yep, I was also thinking about these potential races a bit.
I'll need to think a bit more about handling them somehow.

Maybe there's a split I can try to do somewhere. Maybe the device
doesn't need to be added, but rather initialized somehow before it can
be referenced to add these directories dynamically.

Otherwise, we may try to temporarily set the 'indio_dev->info' to
NULL, and re-initialize it after the sysfs is completely initialized.
Under lock of course.

> Looking at device_add it is probably to do with the various notifiers being
> called before we have put everything in place.
>
> > +     if (ret) {
> > +             dev_err(indio_dev->dev.parent,
> > +                     "Failed to create buffer sysfs interfaces\n");
> > +             goto error_device_del;
> > +     }
> > +
> >       return 0;
> >
> > +error_device_del:
> > +     cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> >  error_unreg_eventset:
> >       iio_device_unregister_eventset(indio_dev);
> >  error_free_sysfs:
> >       iio_device_unregister_sysfs(indio_dev);
> > -error_buffer_free_sysfs:
> > -     iio_buffer_free_sysfs_and_mask(indio_dev);
> >  error_unreg_debugfs:
> >       iio_device_unregister_debugfs(indio_dev);
> >       return ret;
> > @@ -1882,6 +1882,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
> >       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >       struct iio_ioctl_handler *h, *t;
> >
> > +     iio_buffer_free_sysfs_and_mask(indio_dev);
> > +
> >       cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> >
> >       mutex_lock(&indio_dev->info_exist_lock);
> > @@ -1899,8 +1901,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
> >       iio_buffer_wakeup_poll(indio_dev);
> >
> >       mutex_unlock(&indio_dev->info_exist_lock);
> > -
> > -     iio_buffer_free_sysfs_and_mask(indio_dev);
> >  }
> >  EXPORT_SYMBOL(iio_device_unregister);
> >
> > diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> > index 67d73d465e02..77e169e51434 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -103,14 +103,20 @@ struct iio_buffer {
> >       /* @scan_el_dev_attr_list: List of scan element related attributes. */
> >       struct list_head scan_el_dev_attr_list;
> >
> > -     /* @buffer_group: Attributes of the buffer group. */
> > -     struct attribute_group buffer_group;
> > +     /* @buffer_dir: kobject for the 'buffer' directory of this buffer */
> > +     struct kobject buffer_dir;
> > +
> > +     /* @buffer_attrs: Attributes of the buffer group. */
> > +     struct attribute **buffer_attrs;
> > +
> > +     /* @scan_el_dir: kobject for the 'scan_elements' directory of this buffer */
> > +     struct kobject scan_el_dir;
> >
> >       /*
> > -      * @scan_el_group: Attribute group for those attributes not
> > +      * @scan_el_attrs: Array of attributes for those attributes not
> >        * created from the iio_chan_info array.
> >        */
> > -     struct attribute_group scan_el_group;
> > +     struct attribute **scan_el_attrs;
> >
> >       /* @attrs: Standard attributes of the buffer. */
> >       const struct attribute **attrs;
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 9a3cf4815148..2ea185340a3a 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -556,7 +556,7 @@ struct iio_dev {
> >       struct mutex                    info_exist_lock;
> >       const struct iio_buffer_setup_ops       *setup_ops;
> >       struct cdev                     chrdev;
> > -#define IIO_MAX_GROUPS 6
> > +#define IIO_MAX_GROUPS 4
> >       const struct attribute_group    *groups[IIO_MAX_GROUPS + 1];
> >       int                             groupcounter;
> >
>
