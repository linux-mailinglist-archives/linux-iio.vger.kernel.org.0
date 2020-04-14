Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D01A87F9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgDNRun (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 13:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730007AbgDNRuj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 13:50:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9467F2074D;
        Tue, 14 Apr 2020 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586886637;
        bh=cn3nP4Hfb5zcXPvCiwVZV8U/Bi0hklOcsJl1jq2LZs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b3CHcoQWuhkSuQsxS2SZix8JWYrOh+dBUq7ooYdNSKecPT2UB2OBQV5S3L8AZbA39
         pjJtBR6821df9XU6r5LvgE80x/Bt23ah975m2pMN+1R3YgW5JCkNfbVNkqUuUl+J0n
         Hydf8eKsy85YByE/3ZlyAarsUdUqN2jGFm5HeLls=
Date:   Tue, 14 Apr 2020 18:50:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v3 3/5] iio: buffer: move iio buffer chrdev in
 industrialio-buffer.c
Message-ID: <20200414185033.7178cba8@archlinux>
In-Reply-To: <f13a7de6698281d510e636a08e907c5f2fbdedb8.camel@analog.com>
References: <20200410141729.82834-1-alexandru.ardelean@analog.com>
        <20200410141729.82834-4-alexandru.ardelean@analog.com>
        <20200413165816.6d372e37@archlinux>
        <f13a7de6698281d510e636a08e907c5f2fbdedb8.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 05:43:40 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2020-04-13 at 16:58 +0100, Jonathan Cameron wrote:
> > [External]
> > 
> > On Fri, 10 Apr 2020 17:17:27 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > This change makes the first jump to move the buffer chardev from indio_dev
> > > to the buffer attached to indio_dev (i.e. indio_dev->buffer).
> > > 
> > > This requires that some functions that are shared between
> > > 'industrialio-core.c' & industrialio-buffer.c be re-shuffled.
> > > The 'iio_buffer_fileops' is now moved to 'industrialio-buffer.c'. It's also
> > > more appropriate to have it here, but the old 'legacy' iio_ioctl() must be
> > > passed to it.
> > > 
> > > What happens now is:
> > > * if IS_ENABLED(CONFIG_IIO_BUFFER) and 'indio_dev->buffer != NULL' the
> > >   indio_dev->buffer->chrdev will be initialized (as the old legacy style
> > >   chardev)
> > > * if -ENOTSUPP is returned for either of the conditions above (not being
> > >   met), the chardev will be created directly via 'indio_dev->chrdev', same
> > >   as before; a new field is required now 'indio_dev->chrdev_initialized' to
> > >   mark it true, so that 'indio_dev->chrdev' gets deleted if initialized;
> > > 
> > > 'indio_dev->chrdev_initialized' is of type 'int', because recently
> > > checkpatch complains that 'bool' types on structs can cause alignment
> > > issues.
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > 
> > I wonder if it would be possible to make the ioctl mess a bit cleaner.
> > Have the buffer ioctl function as here, but have that call a generic
> > iio_device_ioctl function in industrialio-core.c which can in theory
> > handle 'device wide' ioctls.  Then have the events code register into
> > that as a consumer of a particular device wide ioctl.
> > 
> > That way the layering is a violated a little less.
> > 
> > What do you think?  
> 
> I like it.
> Will create a patch for that.
> 
> I'll see if I can make it neat into this series somehow.
> Otherwise, would it be ok to do it on top of this series?
> I currently don't have a clear idea of how clean the patchset would look.

Ideally as part of this series.  I don't 'think' it should be too bad
but if it proves horrible I'll cope with it as patches on top of this series.

Jonathan

> 
> 
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/iio_core.h            |  25 ++++---
> > >  drivers/iio/industrialio-buffer.c | 119 ++++++++++++++++++++++++++++--
> > >  drivers/iio/industrialio-core.c   |  59 ++++++++-------
> > >  include/linux/iio/buffer_impl.h   |   7 ++
> > >  include/linux/iio/iio.h           |   2 +
> > >  5 files changed, 170 insertions(+), 42 deletions(-)
> > > 
> > > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > > index fd9a5f1d5e51..4bdadeac2710 100644
> > > --- a/drivers/iio/iio_core.h
> > > +++ b/drivers/iio/iio_core.h
> > > @@ -40,24 +40,31 @@ ssize_t iio_format_value(char *buf, unsigned int type,
> > > int size, int *vals);
> > >  #ifdef CONFIG_IIO_BUFFER
> > >  struct poll_table_struct;
> > >  
> > > -__poll_t iio_buffer_poll(struct file *filp,
> > > -			     struct poll_table_struct *wait);
> > > -ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
> > > -			      size_t n, loff_t *f_ps);
> > > +long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
> > > +			    unsigned int cmd, unsigned long arg);
> > > +
> > > +int iio_device_buffers_init(struct iio_dev *indio_dev, struct module
> > > *this_mod);
> > > +void iio_device_buffers_uninit(struct iio_dev *indio_dev);
> > > +
> > > +void iio_device_buffers_put(struct iio_dev *indio_dev);
> > >  
> > >  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> > >  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
> > >  
> > > -#define iio_buffer_poll_addr (&iio_buffer_poll)
> > > -#define iio_buffer_read_outer_addr (&iio_buffer_read_outer)
> > > -
> > >  void iio_disable_all_buffers(struct iio_dev *indio_dev);
> > >  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> > >  
> > >  #else
> > >  
> > > -#define iio_buffer_poll_addr NULL
> > > -#define iio_buffer_read_outer_addr NULL
> > > +static inline int iio_device_buffers_init(struct iio_dev *indio_dev,
> > > +					  struct module *this_mod)
> > > +{
> > > +	return -ENOTSUPP;
> > > +}
> > > +
> > > +static inline void iio_device_buffers_uninit(struct iio_dev *indio_dev) {}
> > > +
> > > +static inline void iio_device_buffers_put(struct iio_dev *indio_dev) {}
> > >  
> > >  static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  {
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-
> > > buffer.c
> > > index f9ffc7762f6c..4b5c3baadaab 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -99,11 +99,11 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev,
> > > struct iio_buffer *buf,
> > >   * Return: negative values corresponding to error codes or ret != 0
> > >   *	   for ending the reading activity
> > >   **/
> > > -ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
> > > -			      size_t n, loff_t *f_ps)
> > > +static ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
> > > +				     size_t n, loff_t *f_ps)
> > >  {
> > > -	struct iio_dev *indio_dev = filp->private_data;
> > > -	struct iio_buffer *rb = indio_dev->buffer;
> > > +	struct iio_buffer *rb = filp->private_data;
> > > +	struct iio_dev *indio_dev = rb->indio_dev;
> > >  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > >  	size_t datum_size;
> > >  	size_t to_wait;
> > > @@ -165,11 +165,11 @@ ssize_t iio_buffer_read_outer(struct file *filp, char
> > > __user *buf,
> > >   * Return: (EPOLLIN | EPOLLRDNORM) if data is available for reading
> > >   *	   or 0 for other cases
> > >   */
> > > -__poll_t iio_buffer_poll(struct file *filp,
> > > +static __poll_t iio_buffer_poll(struct file *filp,
> > >  			     struct poll_table_struct *wait)
> > >  {
> > > -	struct iio_dev *indio_dev = filp->private_data;
> > > -	struct iio_buffer *rb = indio_dev->buffer;
> > > +	struct iio_buffer *rb = filp->private_data;
> > > +	struct iio_dev *indio_dev = rb->indio_dev;
> > >  
> > >  	if (!indio_dev->info || rb == NULL)
> > >  		return 0;
> > > @@ -180,6 +180,48 @@ __poll_t iio_buffer_poll(struct file *filp,
> > >  	return 0;
> > >  }
> > >  
> > > +/**
> > > + * iio_buffer_chrdev_open() - chrdev file open for buffer access
> > > + * @inode:	Inode structure for identifying the device in the file system
> > > + * @filp:	File structure for iio device used to keep and later access
> > > + *		private data
> > > + *
> > > + * Return: 0 on success or -EBUSY if the device is already opened
> > > + **/
> > > +static int iio_buffer_chrdev_open(struct inode *inode, struct file *filp)
> > > +{
> > > +	struct iio_buffer *buffer = container_of(inode->i_cdev,
> > > +						 struct iio_buffer, chrdev);
> > > +
> > > +	if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->file_ops_flags))
> > > +		return -EBUSY;
> > > +
> > > +	iio_buffer_get(buffer);
> > > +
> > > +	filp->private_data = buffer;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * iio_buffer_chrdev_release() - chrdev file close for buffer access
> > > + * @inode:	Inode structure pointer for the char device
> > > + * @filp:	File structure pointer for the char device
> > > + *
> > > + * Return: 0 for successful release
> > > + */
> > > +static int iio_buffer_chrdev_release(struct inode *inode, struct file
> > > *filp)
> > > +{
> > > +	struct iio_buffer *buffer = container_of(inode->i_cdev,
> > > +						 struct iio_buffer, chrdev);
> > > +
> > > +	clear_bit(IIO_BUSY_BIT_POS, &buffer->file_ops_flags);
> > > +
> > > +	iio_buffer_put(buffer);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * iio_buffer_wakeup_poll - Wakes up the buffer waitqueue
> > >   * @indio_dev: The IIO device
> > > @@ -1121,6 +1163,14 @@ void iio_disable_all_buffers(struct iio_dev
> > > *indio_dev)
> > >  	iio_buffer_deactivate_all(indio_dev);
> > >  }
> > >  
> > > +long iio_buffer_ioctl(struct file *filep, unsigned int cmd, unsigned long
> > > arg)
> > > +{
> > > +	struct iio_buffer *buffer = filep->private_data;
> > > +	struct iio_dev *indio_dev = buffer->indio_dev;
> > > +
> > > +	return iio_device_event_ioctl(indio_dev, filep, cmd, arg);
> > > +}
> > > +
> > >  static ssize_t iio_buffer_store_enable(struct device *dev,
> > >  				       struct device_attribute *attr,
> > >  				       const char *buf,
> > > @@ -1356,6 +1406,61 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
> > >  }
> > >  
> > > +static const struct file_operations iio_buffer_fileops = {
> > > +	.read = iio_buffer_read_outer,
> > > +	.release = iio_buffer_chrdev_release,
> > > +	.open = iio_buffer_chrdev_open,
> > > +	.poll = iio_buffer_poll,
> > > +	.owner = THIS_MODULE,
> > > +	.llseek = noop_llseek,
> > > +	.unlocked_ioctl = iio_buffer_ioctl,
> > > +	.compat_ioctl = compat_ptr_ioctl,
> > > +};
> > > +
> > > +int iio_device_buffers_init(struct iio_dev *indio_dev, struct module
> > > *this_mod)
> > > +{
> > > +	struct iio_buffer *buffer = indio_dev->buffer;
> > > +	int ret;
> > > +
> > > +	if (!buffer)
> > > +		return -ENOTSUPP;
> > > +
> > > +	cdev_init(&buffer->chrdev, &iio_buffer_fileops);
> > > +
> > > +	buffer->chrdev.owner = this_mod;
> > > +
> > > +	ret = cdev_device_add(&buffer->chrdev, &indio_dev->dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	iio_device_get(indio_dev);
> > > +	iio_buffer_get(buffer);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void iio_device_buffers_put(struct iio_dev *indio_dev)
> > > +{
> > > +	struct iio_buffer *buffer = indio_dev->buffer;
> > > +
> > > +	if (!buffer)
> > > +		return;
> > > +
> > > +	iio_buffer_put(buffer);
> > > +}
> > > +
> > > +void iio_device_buffers_uninit(struct iio_dev *indio_dev)
> > > +{
> > > +	struct iio_buffer *buffer = indio_dev->buffer;
> > > +
> > > +	if (!buffer)
> > > +		return;
> > > +
> > > +	cdev_device_del(&buffer->chrdev, &indio_dev->dev);
> > > +	iio_buffer_put(buffer);
> > > +	iio_device_put(indio_dev);
> > > +}
> > > +
> > >  /**
> > >   * iio_validate_scan_mask_onehot() - Validates that exactly one channel is
> > > selected
> > >   * @indio_dev: the iio device
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-
> > > core.c
> > > index c8c074602709..2158aeab0bd2 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -1475,7 +1475,7 @@ static void iio_dev_release(struct device *device)
> > >  	iio_device_unregister_eventset(indio_dev);
> > >  	iio_device_unregister_sysfs(indio_dev);
> > >  
> > > -	iio_buffer_put(indio_dev->buffer);
> > > +	iio_device_buffers_put(indio_dev);
> > >  
> > >  	ida_simple_remove(&iio_ida, indio_dev->id);
> > >  	kfree(indio_dev);
> > > @@ -1610,7 +1610,7 @@ void devm_iio_device_free(struct device *dev, struct
> > > iio_dev *iio_dev)
> > >  EXPORT_SYMBOL_GPL(devm_iio_device_free);
> > >  
> > >  /**
> > > - * iio_chrdev_open() - chrdev file open for buffer access and ioctls
> > > + * iio_chrdev_open() - chrdev file open for event ioctls
> > >   * @inode:	Inode structure for identifying the device in the file system
> > >   * @filp:	File structure for iio device used to keep and later access
> > >   *		private data
> > > @@ -1633,7 +1633,7 @@ static int iio_chrdev_open(struct inode *inode, struct
> > > file *filp)
> > >  }
> > >  
> > >  /**
> > > - * iio_chrdev_release() - chrdev file close buffer access and ioctls
> > > + * iio_chrdev_release() - chrdev file close for event ioctls
> > >   * @inode:	Inode structure pointer for the char device
> > >   * @filp:	File structure pointer for the char device
> > >   *
> > > @@ -1649,11 +1649,9 @@ static int iio_chrdev_release(struct inode *inode,
> > > struct file *filp)
> > >  	return 0;
> > >  }
> > >  
> > > -/* Somewhat of a cross file organization violation - ioctls here are
> > > actually
> > > - * event related */
> > > -static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long
> > > arg)
> > > +long iio_device_event_ioctl(struct iio_dev *indio_dev, struct file *filp,
> > > +			    unsigned int cmd, unsigned long arg)
> > >  {
> > > -	struct iio_dev *indio_dev = filp->private_data;
> > >  	int __user *ip = (int __user *)arg;
> > >  	int fd;
> > >  
> > > @@ -1671,16 +1669,15 @@ static long iio_ioctl(struct file *filp, unsigned
> > > int cmd, unsigned long arg)
> > >  	return -EINVAL;
> > >  }
> > >  
> > > -static const struct file_operations iio_buffer_fileops = {
> > > -	.read = iio_buffer_read_outer_addr,
> > > -	.release = iio_chrdev_release,
> > > -	.open = iio_chrdev_open,
> > > -	.poll = iio_buffer_poll_addr,
> > > -	.owner = THIS_MODULE,
> > > -	.llseek = noop_llseek,
> > > -	.unlocked_ioctl = iio_ioctl,
> > > -	.compat_ioctl = compat_ptr_ioctl,
> > > -};
> > > +/* Somewhat of a cross file organization violation - ioctls here are
> > > actually
> > > + * event related */
> > > +static long iio_event_ioctl_wrapper(struct file *filp, unsigned int cmd,
> > > +				    unsigned long arg)
> > > +{
> > > +	struct iio_dev *indio_dev = filp->private_data;
> > > +  
> > 
> > Hmm. I wonder if we keep a level of indirection in here.  So actually call
> > something like: 'iio_device_ioctl' in industrialio-core.c and have the
> > event registration register a callback with the core.  Thus no events and
> > nothing is registered so that core function simply returns an error
> > - right now I suspect it returns a chardev that is completely useless
> > (if no events supported by the device).
> >   
> > > +	return iio_device_event_ioctl(indio_dev, filp, cmd, arg);
> > > +}
> > >  
> > >  static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
> > >  {
> > > @@ -1712,7 +1709,7 @@ static const struct file_operations iio_event_fileops
> > > = {
> > >  	.open = iio_chrdev_open,
> > >  	.owner = THIS_MODULE,
> > >  	.llseek = noop_llseek,
> > > -	.unlocked_ioctl = iio_ioctl,
> > > +	.unlocked_ioctl = iio_event_ioctl_wrapper,
> > >  	.compat_ioctl = compat_ptr_ioctl,
> > >  };
> > >  
> > > @@ -1766,16 +1763,21 @@ int __iio_device_register(struct iio_dev *indio_dev,
> > > struct module *this_mod)
> > >  		indio_dev->setup_ops == NULL)
> > >  		indio_dev->setup_ops = &noop_ring_setup_ops;
> > >  
> > > -	if (indio_dev->buffer)
> > > -		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> > > -	else
> > > +	ret = iio_device_buffers_init(indio_dev, this_mod);
> > > +	if (ret) {
> > > +		if (ret != -ENOTSUPP)
> > > +			goto error_unreg_eventset;
> > > +
> > >  		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
> > >  
> > > -	indio_dev->chrdev.owner = this_mod;
> > > +		indio_dev->chrdev.owner = this_mod;
> > >  
> > > -	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
> > > -	if (ret < 0)
> > > -		goto error_unreg_eventset;
> > > +		ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
> > > +		if (ret < 0)
> > > +			goto error_unreg_eventset;
> > > +
> > > +		indio_dev->chrdev_initialized = true;
> > > +	}
> > >  
> > >  	return 0;
> > >  
> > > @@ -1797,7 +1799,12 @@ EXPORT_SYMBOL(__iio_device_register);
> > >   **/
> > >  void iio_device_unregister(struct iio_dev *indio_dev)
> > >  {
> > > -	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> > > +	if (indio_dev->chrdev_initialized)
> > > +		cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> > > +
> > > +	indio_dev->chrdev_initialized = false;
> > > +
> > > +	iio_device_buffers_uninit(indio_dev);
> > >  
> > >  	mutex_lock(&indio_dev->info_exist_lock);
> > >  
> > > diff --git a/include/linux/iio/buffer_impl.h
> > > b/include/linux/iio/buffer_impl.h
> > > index 8fb92250a190..b4a55c3f556b 100644
> > > --- a/include/linux/iio/buffer_impl.h
> > > +++ b/include/linux/iio/buffer_impl.h
> > > @@ -1,6 +1,7 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 */
> > >  #ifndef _IIO_BUFFER_GENERIC_IMPL_H_
> > >  #define _IIO_BUFFER_GENERIC_IMPL_H_
> > > +#include <linux/cdev.h>
> > >  #include <linux/sysfs.h>
> > >  #include <linux/kref.h>
> > >  
> > > @@ -72,6 +73,12 @@ struct iio_buffer {
> > >  	/** @indio_dev: IIO device to which this buffer belongs to. */
> > >  	struct iio_dev *indio_dev;
> > >  
> > > +	/** @chrdev: associated character device. */
> > > +	struct cdev chrdev;
> > > +
> > > +	/** @file_ops_flags: file ops related flags including busy flag. */
> > > +	unsigned long file_ops_flags;
> > > +
> > >  	/** @length: Number of datums in buffer. */
> > >  	unsigned int length;
> > >  
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index e975020abaa6..e93497f483f7 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -517,6 +517,7 @@ struct iio_buffer_setup_ops {
> > >   * @setup_ops:		[DRIVER] callbacks to call before and after
> > > buffer
> > >   *			enable/disable
> > >   * @chrdev:		[INTERN] associated character device
> > > + * @chrdev_initialized:	[INTERN] true if @chrdev device has been
> > > initialized
> > >   * @groups:		[INTERN] attribute groups
> > >   * @groupcounter:	[INTERN] index of next attribute group
> > >   * @flags:		[INTERN] file ops related flags including busy flag.
> > > @@ -560,6 +561,7 @@ struct iio_dev {
> > >  	struct mutex			info_exist_lock;
> > >  	const struct iio_buffer_setup_ops	*setup_ops;
> > >  	struct cdev			chrdev;
> > > +	int				chrdev_initialized;
> > >  #define IIO_MAX_GROUPS 6
> > >  	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
> > >  	int				groupcounter;  

