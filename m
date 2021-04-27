Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA62336CA35
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhD0RRv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0RRu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 13:17:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3600661029;
        Tue, 27 Apr 2021 17:17:06 +0000 (UTC)
Date:   Tue, 27 Apr 2021 18:17:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 7/9] iio: core: move @chrdev from struct iio_dev to
 struct iio_dev_opaque
Message-ID: <20210427181751.5cf7244b@jic23-huawei>
In-Reply-To: <CA+U=DsoT=2tW0BHpOFbkm3CGTkiFyQf9sfkB0YVoeWV7pE4=gQ@mail.gmail.com>
References: <20210426174911.397061-1-jic23@kernel.org>
        <20210426174911.397061-8-jic23@kernel.org>
        <CA+U=DsoT=2tW0BHpOFbkm3CGTkiFyQf9sfkB0YVoeWV7pE4=gQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Apr 2021 11:06:56 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Apr 26, 2021 at 8:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > No reason for this to be exposed to the drivers, so lets move it to the
> > opaque structure.  
> 
> Even though this looks straightforward, I am paranoid about it.
> Mostly because of all the chardev juggling that I tried.
Yup. Several of these needed to wait for that work to be in place
so could really be done until now (when things are generally
somewhat cleaner than they were!)

Jonathan

> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/industrialio-core.c | 20 +++++++++++---------
> >  include/linux/iio/iio-opaque.h  |  2 ++
> >  include/linux/iio/iio.h         |  2 --
> >  3 files changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index f3b38d69b7e1..6fbe29f0b1de 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1715,8 +1715,9 @@ EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
> >   **/
> >  static int iio_chrdev_open(struct inode *inode, struct file *filp)
> >  {
> > -       struct iio_dev *indio_dev = container_of(inode->i_cdev,
> > -                                               struct iio_dev, chrdev);
> > +       struct iio_dev_opaque *iio_dev_opaque =
> > +               container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
> > +       struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
> >         struct iio_dev_buffer_pair *ib;
> >
> >         if (test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->flags))
> > @@ -1749,8 +1750,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
> >  static int iio_chrdev_release(struct inode *inode, struct file *filp)
> >  {
> >         struct iio_dev_buffer_pair *ib = filp->private_data;
> > -       struct iio_dev *indio_dev = container_of(inode->i_cdev,
> > -                                               struct iio_dev, chrdev);
> > +       struct iio_dev_opaque *iio_dev_opaque =
> > +               container_of(inode->i_cdev, struct iio_dev_opaque, chrdev);
> > +       struct iio_dev *indio_dev = &iio_dev_opaque->indio_dev;
> >         kfree(ib);
> >         clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
> >         iio_device_put(indio_dev);
> > @@ -1901,19 +1903,19 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
> >                 indio_dev->setup_ops = &noop_ring_setup_ops;
> >
> >         if (iio_dev_opaque->attached_buffers_cnt)
> > -               cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> > +               cdev_init(&iio_dev_opaque->chrdev, &iio_buffer_fileops);
> >         else if (iio_dev_opaque->event_interface)
> > -               cdev_init(&indio_dev->chrdev, &iio_event_fileops);
> > +               cdev_init(&iio_dev_opaque->chrdev, &iio_event_fileops);
> >
> >         if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interface) {
> >                 indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), iio_dev_opaque->id);
> > -               indio_dev->chrdev.owner = this_mod;
> > +               iio_dev_opaque->chrdev.owner = this_mod;
> >         }
> >
> >         /* assign device groups now; they should be all registered now */
> >         indio_dev->dev.groups = iio_dev_opaque->groups;
> >
> > -       ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
> > +       ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
> >         if (ret < 0)
> >                 goto error_unreg_eventset;
> >
> > @@ -1940,7 +1942,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
> >         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >         struct iio_ioctl_handler *h, *t;
> >
> > -       cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> > +       cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
> >
> >         mutex_lock(&iio_dev_opaque->info_exist_lock);
> >
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index 538b4b5ef1a9..2f8ef5d15a66 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -24,6 +24,7 @@
> >   * @legacy_scan_el_group:      attribute group for legacy scan elements attribute group
> >   * @legacy_buffer_group:       attribute group for legacy buffer attributes group
> >   * @scan_index_timestamp:      cache of the index to the timestamp
> > + * @chrdev:                    associated character device
> >   * @debugfs_dentry:            device specific debugfs dentry
> >   * @cached_reg_addr:           cached register address for debugfs reads
> >   * @read_buf:                  read buffer to be used for the initial reg read
> > @@ -49,6 +50,7 @@ struct iio_dev_opaque {
> >         struct attribute_group          legacy_buffer_group;
> >
> >         unsigned int                    scan_index_timestamp;
> > +       struct cdev                     chrdev;
> >
> >  #if defined(CONFIG_DEBUG_FS)
> >         struct dentry                   *debugfs_dentry;
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index a12bbd8b1e74..586e2dc4fbf3 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -512,7 +512,6 @@ struct iio_buffer_setup_ops {
> >   * @clock_id:          [INTERN] timestamping clock posix identifier
> >   * @setup_ops:         [DRIVER] callbacks to call before and after buffer
> >   *                     enable/disable
> > - * @chrdev:            [INTERN] associated character device
> >   * @flags:             [INTERN] file ops related flags including busy flag.
> >   * @priv:              [DRIVER] reference to driver's private information
> >   *                     **MUST** be accessed **ONLY** via iio_priv() helper
> > @@ -542,7 +541,6 @@ struct iio_dev {
> >         const struct iio_info           *info;
> >         clockid_t                       clock_id;
> >         const struct iio_buffer_setup_ops       *setup_ops;
> > -       struct cdev                     chrdev;
> >
> >         unsigned long                   flags;
> >         void                            *priv;
> > --
> > 2.31.1
> >  

