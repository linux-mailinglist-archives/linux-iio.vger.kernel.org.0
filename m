Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7392831B0CC
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 15:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBNOh5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 09:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhBNOh5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 09:37:57 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 575E764DC3;
        Sun, 14 Feb 2021 14:37:13 +0000 (UTC)
Date:   Sun, 14 Feb 2021 14:37:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 13/17] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
Message-ID: <20210214143708.030091d5@archlinux>
In-Reply-To: <20210211122452.78106-14-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
        <20210211122452.78106-14-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Feb 2021 14:24:48 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> With this change, an ioctl() call is added to open a character device for a
> buffer. The ioctl() number is 'i' 0x91, which follows the
> IIO_GET_EVENT_FD_IOCTL ioctl.
> 
> The ioctl() will return an FD for the requested buffer index. The indexes
> are the same from the /sys/iio/devices/iio:deviceX/bufferY (i.e. the Y
> variable).
> 
> Since there doesn't seem to be a sane way to return the FD for buffer0 to
> be the same FD for the /dev/iio:deviceX, this ioctl() will return another
> FD for buffer0 (or the first buffer). This duplicate FD will be able to
> access the same buffer object (for buffer0) as accessing directly the
> /dev/iio:deviceX chardev.
> 
> Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl() implemented, as the
> index for each buffer (and the count) can be deduced from the
> '/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the number of
> bufferY folders).
> 
> Used following C code to test this:
> -------------------------------------------------------------------
> 
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <sys/ioctl.h>
>  #include <fcntl.h"
>  #include <errno.h>
> 
>  #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0x91, int)
> 
> int main(int argc, char *argv[])
> {
>         int fd;
>         int fd1;
>         int ret;
> 
>         if ((fd = open("/dev/iio:device0", O_RDWR))<0) {
>                 fprintf(stderr, "Error open() %d errno %d\n",fd, errno);
>                 return -1;
>         }
> 
>         fprintf(stderr, "Using FD %d\n", fd);
> 
>         fd1 = atoi(argv[1]);
> 
>         ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
>         if (ret < 0) {
>                 fprintf(stderr, "Error for buffer %d ioctl() %d errno %d\n", fd1, ret, errno);
>                 close(fd);
>                 return -1;
>         }
> 
>         fprintf(stderr, "Got FD %d\n", fd1);
> 
>         close(fd1);
>         close(fd);
> 
>         return 0;
> }
> -------------------------------------------------------------------
> 
> Results are:
> -------------------------------------------------------------------
>  # ./test 0
>  Using FD 3
>  Got FD 4
> 
>  # ./test 1
>  Using FD 3
>  Got FD 4
> 
>  # ./test 2
>  Using FD 3
>  Got FD 4
> 
>  # ./test 3
>  Using FD 3
>  Got FD 4
> 
>  # ls /sys/bus/iio/devices/iio\:device0
>  buffer  buffer0  buffer1  buffer2  buffer3  dev
>  in_voltage_sampling_frequency  in_voltage_scale
>  in_voltage_scale_available
>  name  of_node  power  scan_elements  subsystem  uevent
> -------------------------------------------------------------------
> 
> iio:device0 has some fake kfifo buffers attached to an IIO device.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

There are a few corners of this that I'm not quite confident enough to just
'fix up' whilst applying.


> ---
>  drivers/iio/iio_core.h            |  12 +--
>  drivers/iio/industrialio-buffer.c | 138 ++++++++++++++++++++++++++++--
>  drivers/iio/industrialio-core.c   |   1 +
>  include/linux/iio/buffer_impl.h   |   5 ++
>  include/linux/iio/iio-opaque.h    |   2 +
>  include/uapi/linux/iio/buffer.h   |  10 +++
>  6 files changed, 157 insertions(+), 11 deletions(-)
>  create mode 100644 include/uapi/linux/iio/buffer.h
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 4690c3240a5d..88db1feb5857 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -64,16 +64,16 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
>  #ifdef CONFIG_IIO_BUFFER
>  struct poll_table_struct;
>  
> -__poll_t iio_buffer_poll(struct file *filp,
> -			     struct poll_table_struct *wait);
> -ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
> -			      size_t n, loff_t *f_ps);
> +__poll_t iio_buffer_poll_wrapper(struct file *filp,
> +				 struct poll_table_struct *wait);
> +ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> +				size_t n, loff_t *f_ps);
>  
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
>  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
>  
> -#define iio_buffer_poll_addr (&iio_buffer_poll)
> -#define iio_buffer_read_outer_addr (&iio_buffer_read_outer)
> +#define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
> +#define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
>  
>  void iio_disable_all_buffers(struct iio_dev *indio_dev);
>  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 1e8e4c2ff00e..3aa6702a5811 100644
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
> @@ -89,7 +90,7 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
>  }
>  
>  /**
> - * iio_buffer_read_outer() - chrdev read for buffer access
> + * iio_buffer_read() - chrdev read for buffer access
>   * @filp:	File structure pointer for the char device
>   * @buf:	Destination buffer for iio buffer read
>   * @n:		First n bytes to read
> @@ -101,8 +102,8 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
>   * Return: negative values corresponding to error codes or ret != 0
>   *	   for ending the reading activity
>   **/
> -ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
> -			      size_t n, loff_t *f_ps)
> +static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
> +			       size_t n, loff_t *f_ps)
>  {
>  	struct iio_dev_buffer_pair *ib = filp->private_data;
>  	struct iio_buffer *rb = ib->buffer;
> @@ -168,8 +169,8 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
>   * Return: (EPOLLIN | EPOLLRDNORM) if data is available for reading
>   *	   or 0 for other cases
>   */
> -__poll_t iio_buffer_poll(struct file *filp,
> -			     struct poll_table_struct *wait)
> +static __poll_t iio_buffer_poll(struct file *filp,
> +				struct poll_table_struct *wait)
>  {
>  	struct iio_dev_buffer_pair *ib = filp->private_data;
>  	struct iio_buffer *rb = ib->buffer;
> @@ -184,6 +185,32 @@ __poll_t iio_buffer_poll(struct file *filp,
>  	return 0;
>  }
>  
> +ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> +				size_t n, loff_t *f_ps)
> +{
> +	struct iio_dev_buffer_pair *ib = filp->private_data;
> +	struct iio_buffer *rb = ib->buffer;
> +
> +	/* check if buffer was opened through new API */
> +	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> +		return -EBUSY;
> +
> +	return iio_buffer_read(filp, buf, n, f_ps);
> +}
> +
> +__poll_t iio_buffer_poll_wrapper(struct file *filp,
> +				 struct poll_table_struct *wait)
> +{
> +	struct iio_dev_buffer_pair *ib = filp->private_data;
> +	struct iio_buffer *rb = ib->buffer;
> +
> +	/* check if buffer was opened through new API */
> +	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> +		return 0;
> +
> +	return iio_buffer_poll(filp, wait);
> +}
> +
>  /**
>   * iio_buffer_wakeup_poll - Wakes up the buffer waitqueue
>   * @indio_dev: The IIO device
> @@ -1343,6 +1370,91 @@ static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
>  	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
>  }
>  
> +static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
> +{
> +	struct iio_dev_buffer_pair *ib = filep->private_data;
> +	struct iio_dev *indio_dev = ib->indio_dev;
> +	struct iio_buffer *buffer = ib->buffer;
> +
> +	wake_up(&buffer->pollq);
> +	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> +	iio_device_put(indio_dev);

Ordering here isn't quite the reverse of that done in _getfd()
below.  Good to tidy that up, probably by swapping the test_and_set_bit()
and iio_device_get below (with additional goto needed I think).

> +	kfree(ib);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations iio_buffer_chrdev_fileops = {
> +	.owner = THIS_MODULE,
> +	.llseek = noop_llseek,
> +	.read = iio_buffer_read,
> +	.poll = iio_buffer_poll,
> +	.compat_ioctl = compat_ptr_ioctl,
> +	.release = iio_buffer_chrdev_release,
> +};
> +
> +static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	int __user *ival = (int __user *)arg;
> +	char buf_name[sizeof("iio:buffer:xxx")];

I'm missing where this is assigned.  Also not immediately sure, but I think
this can just be a string used directly in anon_inode_getfd().
I don't think we need to be unique for the different buffers as it's
a 'class name' rather than needing to be specific.

> +	struct iio_dev_buffer_pair *ib;
> +	struct iio_buffer *buffer;
> +	int fd, idx;
> +
> +	if (copy_from_user(&idx, ival, sizeof(idx)))
> +		return -EFAULT;
> +
> +	if (idx >= iio_dev_opaque->attached_buffers_cnt)
> +		return -ENODEV;
> +
> +	buffer = iio_dev_opaque->attached_buffers[idx];
> +
> +	if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->flags))
> +		return -EBUSY;
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

I suspect the iio_events equivalent of this is wrong, as we should be
tidying up the fd and we aren't.

put_unused_fd() I think, but not 100% sure on what the right handling is here.


> +		goto error_free_ib;
> +	}
> +
> +	return fd;
> +
> +error_free_ib:
> +	kfree(ib);
> +error_iio_dev_put:
> +	iio_device_put(indio_dev);
> +	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
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
>  					     int index)
> @@ -1472,6 +1584,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	struct iio_buffer *buffer;
>  	int unwind_idx;
>  	int ret, i;
> +	size_t sz;
>  
>  	channels = indio_dev->channels;
>  	if (channels) {
> @@ -1493,6 +1606,18 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  			goto error_unwind_sysfs_and_mask;
>  		}
>  	}
> +	unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
> +
> +	sz = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));
> +	iio_dev_opaque->buffer_ioctl_handler = kzalloc(sz, GFP_KERNEL);
> +	if (!iio_dev_opaque->buffer_ioctl_handler) {
> +		ret = -ENOMEM;
> +		goto error_unwind_sysfs_and_mask;
> +	}
> +
> +	iio_dev_opaque->buffer_ioctl_handler->ioctl = iio_device_buffer_ioctl;
> +	iio_device_ioctl_handler_register(indio_dev,
> +					  iio_dev_opaque->buffer_ioctl_handler);
>  
>  	return 0;
>  
> @@ -1514,6 +1639,9 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!iio_dev_opaque->attached_buffers_cnt)
>  		return;
>  
> +	iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
> +	kfree(iio_dev_opaque->buffer_ioctl_handler);
> +
>  	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
>  
>  	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 26b05dddfa71..febb3a0d91f3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1737,6 +1737,7 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
>  	struct iio_dev_buffer_pair *ib = filp->private_data;
>  	struct iio_dev *indio_dev = container_of(inode->i_cdev,
>  						struct iio_dev, chrdev);
> +

Stray change that doesn't belong in here.


>  	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
>  	iio_device_put(indio_dev);
>  	kfree(ib);
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 768b90c64412..245b32918ae1 100644
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
> @@ -72,6 +74,9 @@ struct iio_buffer {
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
> index c909835b6247..2c3374d465da 100644
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
> @@ -28,6 +29,7 @@ struct iio_dev_opaque {
>  	struct iio_event_interface	*event_interface;
>  	struct iio_buffer		**attached_buffers;
>  	unsigned int			attached_buffers_cnt;
> +	struct iio_ioctl_handler	*buffer_ioctl_handler;
>  	struct list_head		buffer_list;
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;
> diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> new file mode 100644
> index 000000000000..13939032b3f6
> --- /dev/null
> +++ b/include/uapi/linux/iio/buffer.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* industrial I/O buffer definitions needed both in and out of kernel
> + */
> +
> +#ifndef _UAPI_IIO_BUFFER_H_
> +#define _UAPI_IIO_BUFFER_H_
> +
> +#define IIO_BUFFER_GET_FD_IOCTL			_IOWR('i', 0x91, int)
> +
> +#endif /* _UAPI_IIO_BUFFER_H_ */

