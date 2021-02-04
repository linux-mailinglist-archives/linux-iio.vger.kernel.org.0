Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52030FC2B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhBDTDs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 14:03:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2504 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbhBDTCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 14:02:10 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWnpP1tMYz67kg6;
        Fri,  5 Feb 2021 02:56:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 20:01:28 +0100
Received: from localhost (10.47.65.115) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 19:01:27 +0000
Date:   Thu, 4 Feb 2021 19:00:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 11/11] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
Message-ID: <20210204190041.0000623a@Huawei.com>
In-Reply-To: <20210201145105.20459-12-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
        <20210201145105.20459-12-alexandru.ardelean@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.65.115]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Feb 2021 16:51:05 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> With this change, an ioctl() call is added to open a character device for a
> buffer. The ioctl() number is 'i' 0x91, which follows the
> IIO_GET_EVENT_FD_IOCTL ioctl.
> 
> The ioctl() will return a 0 FD for the first buffer, as that FD for buffer0
> is the same FD as the one used for this ioctl().

That sounds dangerous as code might just use it without checking properly.
Perhaps take a leaf out of open() and return negative?

What would happen if we just returned an error in this path?

> 
> For any other extra buffer, this ioctl() will return an anon inode FD that
> would access any extra buffer.
> 
> Right now, there doesn't seem to be (or I couldn't find) a way for this
> ioctl() to return the FD for buffer0 (i.e. to return the same FD as used
> for the ioctl()).
> So, usespace would need to know that  ioctl(fd,
> IIO_GET_EVENT_FD_IOCTL, 0) will return FD 0.
> We could also return another FD for buffer 0, but duplicating FDs for the
> same IIO buffer sounds problematic.
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
>  Got FD 0
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
If you get a chance to add a parameter to the tools/iio/ buffer
program that does much the same as above that would be great.

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Otherwise a few trivials inline.

Good work on bringing this new approach together so quickly.

It's a lot simpler which is good and still gives us a reasonable interface.

If you can update the example code in tree and perhaps add something to
the main IIO docs that would be great.
Documentation/driver-api/iio/buffers.rst I think.

We'll also  (at somepoint) want to do a scrub of the ABI docs to 
either include the new paths or make them less specific to incorporate
both.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 118 ++++++++++++++++++++++++++++++
>  drivers/iio/industrialio-core.c   |   8 ++
>  include/linux/iio/buffer_impl.h   |   5 ++
>  include/linux/iio/iio-opaque.h    |   2 +
>  include/uapi/linux/iio/buffer.h   |  10 +++
>  5 files changed, 143 insertions(+)
>  create mode 100644 include/uapi/linux/iio/buffer.h
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a69bb705d173..119c2b5aa863 100644
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
> @@ -1333,6 +1334,106 @@ void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
>  	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
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
> +	if (idx == 0) {
> +		fd = 0;
> +		if (copy_to_user(ival, &fd, sizeof(fd)))
> +			return -EFAULT;
> +		return 0;
> +	}
> +
> +	if (idx >= iio_dev_opaque->attached_buffers_cnt)
> +		return -ENOENT;
> +
> +	fd = mutex_lock_interruptible(&indio_dev->mlock);

Why mlock?  Might be fine, but this doesn't feel like it is in the normal scope
of that lock.  So perhaps a comment on why it makes sense here.

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
>  					     int index)
> @@ -1460,6 +1561,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	const struct iio_chan_spec *channels;
>  	int unwind_idx;
>  	int ret, i;
> +	size_t sz;
>  
>  	channels = indio_dev->channels;
>  	if (channels) {
> @@ -1481,6 +1583,18 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
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
> @@ -1503,6 +1617,10 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return;
>  
> +	iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
> +	kfree(iio_dev_opaque->buffer_ioctl_handler);
> +	iio_dev_opaque->buffer_ioctl_handler = NULL;
> +
>  	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
>  
>  	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8af85838d1c2..78807b62ff52 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1722,6 +1722,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>  	ib->indio_dev = indio_dev;
>  	ib->buffer = indio_dev->buffer;
>  
> +	if (indio_dev->buffer)
> +		test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->buffer->flags);
> +

What is this test preventing?  I guess it's keeping the flag for the first
buffer in sync with what other buffers will look at, but does anything check those?
We'll not be able to open this one twice anyway due to the check above.

Perhaps a comment on why this is here?

>  	filp->private_data = ib;
>  
>  	return 0;
> @@ -1739,6 +1742,11 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
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
> index 000000000000..de571c83c9f2
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
> +#define IIO_BUFFER_GET_FD_IOCTL		_IOWR('i', 0x91, int)
> +
> +#endif /* _UAPI_IIO_BUFFER_H_ */

