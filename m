Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A72BC19A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgKUSur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:50:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbgKUSur (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 13:50:47 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C7D52100A;
        Sat, 21 Nov 2020 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605984646;
        bh=K2WrYdEUGCQKpizOrDcceJA5DPVDv5LgqSZyqbNFO9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CR2SkCrv8z1Zjvs+Gq6Er5FwCsjmohsRKKVBSoC0dAlTymyUyJ1VAG5EQzABCf70V
         39lh+KuJb//dZZcEX36TCxDsZab3yfpa40j8TkBS+7yuvKsw/BFJh58Xdq817tVPJ5
         CsGHCuJnbB8mAcTfwbhnReeXQzn20IN5p22iTYfI=
Date:   Sat, 21 Nov 2020 18:50:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 12/12] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
Message-ID: <20201121185041.7a0649f7@archlinux>
In-Reply-To: <20201117162340.43924-13-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
        <20201117162340.43924-13-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 18:23:40 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> With this change, an ioctl() call is added to open a character device for a
> buffer.
> The ioctl() will not work for the first buffer, as that buffer is already
> opened/reserved for the IIO device's character device.
> This is also to preserve backwards compatibility.
> 
> For any other extra buffer (after the first buffer) this ioctl() will be
> required.

Silly question, but can we have the ioctl just return the file handle for
the buffer itself if called on index 0? 

Would make for slightly more natural userspace code even though it
doesn't do anything...

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-buffer.c | 111 ++++++++++++++++++++++++++++++
>  drivers/iio/industrialio-core.c   |   8 +++
>  include/linux/iio/buffer_impl.h   |   5 ++
>  include/linux/iio/iio-opaque.h    |   2 +
>  include/uapi/linux/iio/buffer.h   |  16 +++++
>  5 files changed, 142 insertions(+)
>  create mode 100644 include/uapi/linux/iio/buffer.h
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index daa68822cea7..77f02870cd18 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -9,6 +9,7 @@
>   * - Better memory allocation techniques?
>   * - Alternative access techniques?
>   */
> +#include <linux/anon_inodes.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/device.h>
> @@ -1399,6 +1400,99 @@ static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
>  		sysfs_remove_file(kobj, ptr[i]);
>  }
>  
> +static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
> +{
> +	struct iio_dev_buffer_pair *ib = filep->private_data;
> +	struct iio_dev *indio_dev = ib->indio_dev;
> +	struct iio_buffer *buffer = ib->buffer;
> +
> +	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> +	iio_device_put(indio_dev);
> +	kfree(ib);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations iio_buffer_chrdev_fileops = {
> +	.owner = THIS_MODULE,
> +	.llseek = noop_llseek,
> +	.read = iio_buffer_read_outer_addr,
> +	.poll = iio_buffer_poll_addr,
> +	.compat_ioctl = compat_ptr_ioctl,
> +	.release = iio_buffer_chrdev_release,
> +};
> +
> +static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	int __user *ival = (int __user *)arg;
> +	char buf_name[sizeof("iio:buffer:xxx")];
> +	struct iio_dev_buffer_pair *ib;
> +	struct iio_buffer *buffer;
> +	int fd, idx;
> +
> +	if (copy_from_user(&idx, ival, sizeof(idx)))
> +		return -EFAULT;
> +
> +	if (idx >= iio_dev_opaque->attached_buffers_cnt)
> +		return -ENOENT;
> +
> +	fd = mutex_lock_interruptible(&indio_dev->mlock);
> +	if (fd)
> +		return fd;
> +
> +	buffer = iio_dev_opaque->attached_buffers[idx];
> +
> +	if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->flags)) {
> +		fd = -EBUSY;
> +		goto error_unlock;
> +	}
> +
> +	iio_device_get(indio_dev);
> +
> +	ib = kzalloc(sizeof(*ib), GFP_KERNEL);
> +	if (!ib) {
> +		fd = -ENOMEM;
> +		goto error_iio_dev_put;
> +	}
> +
> +	ib->indio_dev = indio_dev;
> +	ib->buffer = buffer;
> +
> +	fd = anon_inode_getfd(buf_name, &iio_buffer_chrdev_fileops,
> +			      ib, O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		goto error_free_ib;
> +
> +	if (copy_to_user(ival, &fd, sizeof(fd))) {
> +		fd = -EFAULT;
> +		goto error_free_ib;
> +	}
> +
> +	mutex_unlock(&indio_dev->mlock);
> +	return fd;
> +
> +error_free_ib:
> +	kfree(ib);
> +error_iio_dev_put:
> +	iio_device_put(indio_dev);
> +	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> +error_unlock:
> +	mutex_unlock(&indio_dev->mlock);
> +	return fd;
> +}
> +
> +static long iio_device_buffer_ioctl(struct iio_dev *indio_dev, struct file *filp,
> +				    unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case IIO_BUFFER_GET_FD_IOCTL:
> +		return iio_device_buffer_getfd(indio_dev, arg);
> +	default:
> +		return IIO_IOCTL_UNHANDLED;
> +	}
> +}
> +
>  static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  					     struct iio_dev *indio_dev,
>  					     unsigned int idx)
> @@ -1549,8 +1643,21 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (ret)
>  		goto error_remove_buffer_dir_link;
>  
> +	i = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));

using i for that isn't particularly readable.  Add a sz or similar local
variable for it.

> +	iio_dev_opaque->buffer_ioctl_handler = kzalloc(i, GFP_KERNEL);
> +	if (!iio_dev_opaque->buffer_ioctl_handler) {
> +		ret = -ENOMEM;
> +		goto error_remove_scan_el_dir;
> +	}
> +
> +	iio_dev_opaque->buffer_ioctl_handler->ioctl = iio_device_buffer_ioctl;
> +	iio_device_ioctl_handler_register(indio_dev,
> +					  iio_dev_opaque->buffer_ioctl_handler);
> +
>  	return 0;
>  
> +error_remove_scan_el_dir:
> +	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
>  error_remove_buffer_dir_link:
>  	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
>  	i = iio_dev_opaque->attached_buffers_cnt - 1;
> @@ -1585,6 +1692,10 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return;
>  
> +	iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
> +	kfree(iio_dev_opaque->buffer_ioctl_handler);
> +	iio_dev_opaque->buffer_ioctl_handler = NULL;
> +
>  	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
>  	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
>  
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 9e7a76723f00..b4f7dd75bef5 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1685,6 +1685,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>  	ib->indio_dev = indio_dev;
>  	ib->buffer = indio_dev->buffer;
>  
> +	if (indio_dev->buffer)
> +		test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->buffer->flags);
> +
>  	filp->private_data = ib;
>  
>  	return 0;
> @@ -1702,6 +1705,11 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
>  	struct iio_dev_buffer_pair *ib = filp->private_data;
>  	struct iio_dev *indio_dev = container_of(inode->i_cdev,
>  						struct iio_dev, chrdev);
> +	struct iio_buffer *buffer = ib->buffer;
> +
> +	if (buffer)
> +		clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> +
>  	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
>  	iio_device_put(indio_dev);
>  	kfree(ib);
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index e25d26a7f601..78da590b5607 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -6,6 +6,8 @@
>  
>  #ifdef CONFIG_IIO_BUFFER
>  
> +#include <uapi/linux/iio/buffer.h>
> +
>  struct iio_dev;
>  struct iio_buffer;
>  
> @@ -75,6 +77,9 @@ struct iio_buffer {
>  	/** @length: Number of datums in buffer. */
>  	unsigned int length;
>  
> +	/** @flags: File ops flags including busy flag. */
> +	unsigned long flags;
> +
>  	/**  @bytes_per_datum: Size of individual datum including timestamp. */
>  	size_t bytes_per_datum;
>  
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 1db0ea09520e..d0429b13afa8 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -9,6 +9,7 @@
>   * @event_interface:		event chrdevs associated with interrupt lines
>   * @attached_buffers:		array of buffers statically attached by the driver
>   * @attached_buffers_cnt:	number of buffers in the array of statically attached buffers
> + * @buffer_ioctl_handler:	ioctl() handler for this IIO device's buffer interface
>   * @buffer_list:		list of all buffers currently attached
>   * @channel_attr_list:		keep track of automatically created channel
>   *				attributes
> @@ -24,6 +25,7 @@ struct iio_dev_opaque {
>  	struct iio_event_interface	*event_interface;
>  	struct iio_buffer		**attached_buffers;
>  	unsigned int			attached_buffers_cnt;
> +	struct iio_ioctl_handler	*buffer_ioctl_handler;
>  	struct list_head		buffer_list;
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;
> diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> new file mode 100644
> index 000000000000..3794eca78dad
> --- /dev/null
> +++ b/include/uapi/linux/iio/buffer.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* industrial I/O buffer definitions needed both in and out of kernel
> + *
> + * Copyright (c) 2020 Alexandru Ardelean
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef _UAPI_IIO_BUFFER_H_
> +#define _UAPI_IIO_BUFFER_H_
> +
> +#define IIO_BUFFER_GET_FD_IOCTL		_IOWR('i', 0xa0, int)
Is it more sensible to just have that alongside the other IOCTLs rather than
defining a new header for it?

If not available I guess we'd just get an -EINVAL response, so harmless.

> +
> +#endif /* _UAPI_IIO_BUFFER_H_ */

