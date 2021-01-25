Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FB304830
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbhAZFtW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbhAYT3z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Jan 2021 14:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BAE421D79;
        Mon, 25 Jan 2021 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611602953;
        bh=qHiYOWHjeIXbQ3CUtTVmNxAKcTg8yEbTJW9SkT3WzL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BglOBpE78scZqL1KcTqvKXGjLNLK6ryIa/RXsISrpzNxZPBHMWxoJnXqC90k+YvPk
         vQKd/kj5ya0yP4Dn1LFyukjOzAZuxgfD8Vye5em3G+yn59R9SD6bcU/e5r/cg04tw0
         ePV9fWlIk+LKeX6rf47ZxrxJq48uxmXlIl7ZYPEw=
Date:   Mon, 25 Jan 2021 20:29:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 03/12][RESEND] iio: buffer: rework buffer &
 scan_elements dir creation
Message-ID: <YA8cB9eISVjW0UYI@kroah.com>
References: <20210122162529.84978-1-alexandru.ardelean@analog.com>
 <20210122162529.84978-4-alexandru.ardelean@analog.com>
 <20210124181126.07c100a5@archlinux>
 <CA+U=DsrN9F204364-hR==xW_0qesJe68cCCqgYe0L2Ok2ygN7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsrN9F204364-hR==xW_0qesJe68cCCqgYe0L2Ok2ygN7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 24, 2021 at 09:07:52PM +0200, Alexandru Ardelean wrote:
> On Sun, Jan 24, 2021 at 8:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 22 Jan 2021 18:25:20 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >
> > > When adding more than one IIO buffer per IIO device, we will need to create
> > > a buffer & scan_elements directory for each buffer.
> > > We also want to move the 'scan_elements' to be a sub-directory of the
> > > 'buffer' folder.
> > >
> > > The format we want to reach is, for a iio:device0 folder, for 2 buffers
> > > [for example], we have a 'buffer0' and a 'buffer1' subfolder, and each with
> > > it's own 'scan_elements' subfolder.
> > >
> > > So, for example:
> > >    iio:device0/buffer0
> > >       scan_elements/
> > >
> > >    iio:device0/buffer1
> > >       scan_elements/
> > >
> > > The other attributes under 'bufferX' would remain unchanged.
> > >
> > > However, we would also need to symlink back to the old 'buffer' &
> > > 'scan_elements' folders, to keep backwards compatibility.
> > >
> > > Doing all these, require that we maintain the kobjects for each 'bufferX'
> > > and 'scan_elements' so that we can symlink them back. We also need to
> > > implement the sysfs_ops for these folders.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >
> > +CC GregKH and Rafael W for feedback on various things inline.
> >
> > It might be that this is the neatest solution that we can come up with but
> > more eyes would be good!
> >
> > Whilst I think this looks fine, I'm less confident than I'd like to be.
> >
> > Jonathan
> >
> > > ---
> > >  drivers/iio/industrialio-buffer.c | 195 +++++++++++++++++++++++++++---
> > >  drivers/iio/industrialio-core.c   |  24 ++--
> > >  include/linux/iio/buffer_impl.h   |  14 ++-
> > >  include/linux/iio/iio.h           |   2 +-
> > >  4 files changed, 200 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > > index 0412c4fda4c1..0f470d902790 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -1175,8 +1175,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
> > >       return (ret < 0) ? ret : len;
> > >  }
> > >
> > > -static const char * const iio_scan_elements_group_name = "scan_elements";
> > > -
> > >  static ssize_t iio_buffer_show_watermark(struct device *dev,
> > >                                        struct device_attribute *attr,
> > >                                        char *buf)
> > > @@ -1252,6 +1250,124 @@ static struct attribute *iio_buffer_attrs[] = {
> > >       &dev_attr_data_available.attr,
> > >  };
> > >
> > > +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> > > +
> > > +static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
> > > +                                     struct attribute *attr,
> > > +                                     char *buf)
> > > +{
> > > +     struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> > > +     struct device_attribute *dattr;
> > > +
> > > +     dattr = to_dev_attr(attr);
> > > +
> > > +     return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> > > +}
> > > +
> > > +static ssize_t iio_buffer_dir_attr_store(struct kobject *kobj,
> > > +                                      struct attribute *attr,
> > > +                                      const char *buf,
> > > +                                      size_t len)
> > > +{
> > > +     struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> > > +     struct device_attribute *dattr;
> > > +
> > > +     dattr = to_dev_attr(attr);
> > > +
> > > +     return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> > > +}
> > > +
> > > +static const struct sysfs_ops iio_buffer_dir_sysfs_ops = {
> > > +     .show = iio_buffer_dir_attr_show,
> > > +     .store = iio_buffer_dir_attr_store,
> > > +};
> > > +
> > > +static struct kobj_type iio_buffer_dir_ktype = {
> > > +     .sysfs_ops = &iio_buffer_dir_sysfs_ops,
> > > +};
> > > +
> > > +static ssize_t iio_scan_el_dir_attr_show(struct kobject *kobj,
> > > +                                      struct attribute *attr,
> > > +                                      char *buf)
> > > +{
> > > +     struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> > > +     struct device_attribute *dattr = to_dev_attr(attr);
> > > +
> > > +     return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> > > +}
> > > +
> > > +static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
> > > +                                       struct attribute *attr,
> > > +                                       const char *buf,
> > > +                                       size_t len)
> > > +{
> > > +     struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> > > +     struct device_attribute *dattr = to_dev_attr(attr);
> > > +
> > > +     return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> > > +}
> > > +
> > > +static const struct sysfs_ops iio_scan_el_dir_sysfs_ops = {
> > > +     .show = iio_scan_el_dir_attr_show,
> > > +     .store = iio_scan_el_dir_attr_store,
> > > +};
> > > +
> > > +static struct kobj_type iio_scan_el_dir_ktype = {
> > > +     .sysfs_ops = &iio_scan_el_dir_sysfs_ops,
> > > +};
> > > +
> > > +/*
> > > + * These iio_sysfs_{add,del}_attrs() are essentially re-implementations of
> > > + * sysfs_create_files() & sysfs_remove_files(), but they are meant to get
> > > + * around the const-pointer mismatch situation with using them.
> > > + *
> > > + * sysfs_{create,remove}_files() uses 'const struct attribute * const *ptr',
> > > + * while these are happy with just 'struct attribute **ptr'
> > > + */
> >
> > Then to my mind the question becomes why sysfs_create_files() etc requires
> > the second level of const.  If there is justification for that relaxation here
> > we should make it more generally.
> >
> > > +static int iio_sysfs_add_attrs(struct kobject *kobj, struct attribute **ptr)
> > > +{
> > > +     int err = 0;
> > > +     int i;
> > > +
> > > +     for (i = 0; ptr[i] && !err; i++)
> > > +             err = sysfs_create_file(kobj, ptr[i]);
> > > +     if (err)
> > > +             while (--i >= 0)
> > > +                     sysfs_remove_file(kobj, ptr[i]);
> > > +     return err;
> > > +}
> > > +
> > > +static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
> > > +{
> > > +     int i;
> > > +
> > > +     for (i = 0; ptr[i]; i++)
> > > +             sysfs_remove_file(kobj, ptr[i]);
> > > +}
> > > +
> > > +/**
> > > + * __iio_buffer_alloc_sysfs_and_mask() - Allocate sysfs attributes to an attached buffer
> > > + * @buffer: the buffer object for which the sysfs attributes are created for
> > > + * @indio_dev: the iio device to which the iio buffer belongs to
> > > + *
> > > + * Return 0, or negative for error.
> > > + *
> > > + * This function must be called for each single buffer. The sysfs attributes for that
> > > + * buffer will be created, and the IIO device object will be the parent kobject of that
> > > + * the kobjects created here.
> > > + * Because we need to redirect sysfs attribute to it's IIO buffer object, we need to
> > > + * implement our own sysfs_ops, and each IIO buffer will keep a kobject for the
> > > + * 'bufferX' directory and one for the 'scan_elements' directory.
> > > + * And in order to do this, this function must be called after the IIO device object
> > > + * has been added via device_add(). This fundamentally changes how sysfs attributes
> > > + * were created before (with one single IIO buffer per IIO device), where the
> > > + * sysfs attributes for the buffer were mapped as attribute groups on the IIO device
> > > + * groups object list.
> >
> > Been a while, so I can't recall the exact reasons this can cause problems.
> > I've +CC Greg and Rafael for comments.
> >
> > For their reference, the aim of this set is undo an old restriction on IIO that devices
> > only had one buffer.  To do that we need to keep a iio:deviceX/buffer0 directory
> > also exposed as iio:deviceX/buffer/* and
> > iio:deviceX/buffer0/scan_elements/ as iio:deviceX/scan_elements.
> > to maintain backwards compatibility.
> >
> >
> > > + * Using kobjects directly for the 'bufferX' and 'scan_elements' directories allows
> > > + * us to symlink them back to keep backwards compatibility for the old sysfs interface
> > > + * for IIO buffers while also allowing us to support multiple IIO buffers per one
> > > + * IIO device.
> > > + */
> > >  static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> > >                                            struct iio_dev *indio_dev)
> > >  {
> > > @@ -1282,12 +1398,16 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> > >               memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
> > >                      sizeof(struct attribute *) * attrcount);
> > >
> > > -     attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
> > > +     buffer->buffer_attrs = attr;
> > >
> > > -     buffer->buffer_group.name = "buffer";
> > > -     buffer->buffer_group.attrs = attr;
> > > +     ret = kobject_init_and_add(&buffer->buffer_dir, &iio_buffer_dir_ktype,
> > > +                                &indio_dev->dev.kobj, "buffer");
> > > +     if (ret)
> > > +             goto error_buffer_free_attrs;
> > >
> >
> > Do we potentially want kobject_uevent calls for these?
> > (based on looking at similar code in edac).

Never use edac as a good example of how to use sysfs or the driver model
please.  It's just not right, but can't really be changed as it has been
there for too long...

And yes, the edac maintainer agrees with me :)

thanks,

greg k-h
