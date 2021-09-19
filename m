Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD9410C74
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhISRAb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 13:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhISRAa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 13:00:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3F6610FB;
        Sun, 19 Sep 2021 16:59:02 +0000 (UTC)
Date:   Sun, 19 Sep 2021 18:02:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v5 1/6] iio: Add output buffer support
Message-ID: <20210919180244.1f935bcd@jic23-huawei>
In-Reply-To: <20210916182914.1810-2-mihail.chindris@analog.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
        <20210916182914.1810-2-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Sep 2021 18:29:09 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> Currently IIO only supports buffer mode for capture devices like ADCs. Add
> support for buffered mode for output devices like DACs.
> 
> The output buffer implementation is analogous to the input buffer
> implementation. Instead of using read() to get data from the buffer write()
> is used to copy data into the buffer.
> 
> poll() with POLLOUT will wakeup if there is space available.
> 
> Drivers can remove data from a buffer using iio_pop_from_buffer(), the
> function can e.g. called from a trigger handler to write the data to
> hardware.
> 
> A buffer can only be either a output buffer or an input, but not both. So,
> for a device that has an ADC and DAC path, this will mean 2 IIO buffers
> (one for each direction).
> 
> The direction of the buffer is decided by the new direction field of the
> iio_buffer struct and should be set after allocating and before registering
> it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>

A few minor things inline.  I would have expected the missing check
on insert_buffer to have resulted in a nasty deference of a null pointer
though which does make me nervous about whether we have tested this
series enough.

Jonathan

> ---
>  drivers/iio/iio_core.h            |   4 +
>  drivers/iio/industrialio-buffer.c | 120 +++++++++++++++++++++++++++++-
>  drivers/iio/industrialio-core.c   |   1 +
>  include/linux/iio/buffer.h        |   7 ++
>  include/linux/iio/buffer_impl.h   |  11 +++
>  5 files changed, 141 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 8f4a9b264962..61e318431de9 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file *filp,
>  				 struct poll_table_struct *wait);
>  ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
>  				size_t n, loff_t *f_ps);
> +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
> +				 size_t n, loff_t *f_ps);
>  
>  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
>  void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
>  
>  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
>  #define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> +#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
>  
>  void iio_disable_all_buffers(struct iio_dev *indio_dev);
>  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> @@ -83,6 +86,7 @@ void iio_device_detach_buffers(struct iio_dev *indio_dev);
>  
>  #define iio_buffer_poll_addr NULL
>  #define iio_buffer_read_outer_addr NULL
> +#define iio_buffer_write_outer_addr NULL
>  
>  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a95cc2da56be..a2a34c5652a7 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -161,6 +161,62 @@ static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
>  	return ret;
>  }
>  
> +static size_t iio_buffer_space_available(struct iio_buffer *buf)
> +{
> +	if (buf->access->space_available)
> +		return buf->access->space_available(buf);
> +
> +	return SIZE_MAX;
> +}
> +
> +static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
> +				size_t n, loff_t *f_ps)
> +{
> +	struct iio_dev_buffer_pair *ib = filp->private_data;
> +	struct iio_buffer *rb = ib->buffer;
> +	struct iio_dev *indio_dev = ib->indio_dev;
> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> +	int ret;
> +	size_t written;
> +
> +	if (!indio_dev->info)
> +		return -ENODEV;
> +
> +	if (!rb || !rb->access->write)
> +		return -EINVAL;
> +
> +	written = 0;
> +	add_wait_queue(&rb->pollq, &wait);
> +	do {
> +		if (indio_dev->info == NULL)
> +			return -ENODEV;
> +
> +		if (!iio_buffer_space_available(rb)) {
> +			if (signal_pending(current)) {
> +				ret = -ERESTARTSYS;
> +				break;
> +			}
> +
> +			wait_woken(&wait, TASK_INTERRUPTIBLE,
> +					MAX_SCHEDULE_TIMEOUT);
> +			continue;
> +		}
> +
> +		ret = rb->access->write(rb, n - written, buf + written);
> +		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
> +			ret = -EAGAIN;
> +
> +		if (ret > 0) {
> +			written += ret;
> +			if (written != n && !(filp->f_flags & O_NONBLOCK))
> +				continue;
> +		}
> +	} while (ret == 0);
> +	remove_wait_queue(&rb->pollq, &wait);
> +
> +	return ret < 0 ? ret : n;
> +}
> +
>  /**
>   * iio_buffer_poll() - poll the buffer to find out if it has data
>   * @filp:	File structure pointer for device access
> @@ -181,8 +237,18 @@ static __poll_t iio_buffer_poll(struct file *filp,
>  		return 0;
>  
>  	poll_wait(filp, &rb->pollq, wait);
> -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> -		return EPOLLIN | EPOLLRDNORM;
> +
> +	switch (rb->direction) {
> +	case IIO_BUFFER_DIRECTION_IN:
> +		if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> +			return EPOLLIN | EPOLLRDNORM;
> +		break;
> +	case IIO_BUFFER_DIRECTION_OUT:
> +		if (iio_buffer_space_available(rb))
> +			return EPOLLOUT | EPOLLWRNORM;
> +		break;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -199,6 +265,19 @@ ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
>  	return iio_buffer_read(filp, buf, n, f_ps);
>  }
>  
> +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
> +				 size_t n, loff_t *f_ps)
> +{
> +	struct iio_dev_buffer_pair *ib = filp->private_data;
> +	struct iio_buffer *rb = ib->buffer;
> +
> +	/* check if buffer was opened through new API */
> +	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> +		return -EBUSY;
> +
> +	return iio_buffer_write(filp, buf, n, f_ps);
> +}
> +
>  __poll_t iio_buffer_poll_wrapper(struct file *filp,
>  				 struct poll_table_struct *wait)
>  {
> @@ -231,6 +310,15 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
>  	}
>  }
>  
> +int iio_pop_from_buffer(struct iio_buffer *buffer, void *data)
> +{
> +	if (!buffer || !buffer->access || !buffer->access->remove_from)
> +		return -EINVAL;
> +
> +	return buffer->access->remove_from(buffer, data);
> +}
> +EXPORT_SYMBOL_GPL(iio_pop_from_buffer);
> +
>  void iio_buffer_init(struct iio_buffer *buffer)
>  {
>  	INIT_LIST_HEAD(&buffer->demux_list);
> @@ -1156,6 +1244,9 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  	if (insert_buffer == remove_buffer)
>  		return 0;
>  
> +	if (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT)
> +		ret = -EINVAL;
> +

This block is unusual enough that it needs a comment to explain what the intent is.
You are poking in an error code, but then continuing...

I'm fairly sure you need to check
if (insert_buffer && (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT))

The lack of that test makes me thing this will blow up when called to remove an
output buffer.

>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
>  	mutex_lock(&indio_dev->mlock);
>  
> @@ -1277,6 +1368,22 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
>  	return sysfs_emit(buf, "%zu\n", iio_buffer_data_available(buffer));
>  }
>  
> +static ssize_t direction_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> +
> +	switch (buffer->direction) {
> +	case IIO_BUFFER_DIRECTION_IN:
> +		return sprintf(buf, "in\n");
> +	case IIO_BUFFER_DIRECTION_OUT:
> +		return sprintf(buf, "out\n");
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
>  		   iio_buffer_write_length);
>  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> @@ -1289,12 +1396,20 @@ static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
>  	S_IRUGO, iio_buffer_show_watermark, NULL);
>  static DEVICE_ATTR(data_available, S_IRUGO,
>  		iio_dma_show_data_available, NULL);
> +static DEVICE_ATTR_RO(direction);
>  
> +/*
> + * When adding new attributes here, put the at the end, at least until
> + * the code that handles the lengh/length_ro & watermark/watermark_ro

length/length_ro

> + * assignments gets cleaned up. Otherwise these can create some weird
> + * duplicate attributes errors under some setups.
> + */
>  static struct attribute *iio_buffer_attrs[] = {
>  	&dev_attr_length.attr,
>  	&dev_attr_enable.attr,
>  	&dev_attr_watermark.attr,
>  	&dev_attr_data_available.attr,
> +	&dev_attr_direction.attr,
>  };
>  
>  #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> @@ -1397,6 +1512,7 @@ static const struct file_operations iio_buffer_chrdev_fileops = {
>  	.owner = THIS_MODULE,
>  	.llseek = noop_llseek,
>  	.read = iio_buffer_read,
> +	.write = iio_buffer_write,
>  	.poll = iio_buffer_poll,
>  	.release = iio_buffer_chrdev_release,
>  };
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2dbb37e09b8c..537a08549a69 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1822,6 +1822,7 @@ static const struct file_operations iio_buffer_fileops = {
>  	.owner = THIS_MODULE,
>  	.llseek = noop_llseek,
>  	.read = iio_buffer_read_outer_addr,
> +	.write = iio_buffer_write_outer_addr,
>  	.poll = iio_buffer_poll_addr,
>  	.unlocked_ioctl = iio_ioctl,
>  	.compat_ioctl = compat_ptr_ioctl,
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index b6928ac5c63d..fe2e680d9b5e 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -11,8 +11,15 @@
>  
>  struct iio_buffer;
>  
> +enum iio_buffer_direction {
> +	IIO_BUFFER_DIRECTION_IN,
> +	IIO_BUFFER_DIRECTION_OUT,
> +};
> +
>  int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
>  
> +int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
> +
>  /**
>   * iio_push_to_buffers_with_timestamp() - push data and timestamp to buffers
>   * @indio_dev:		iio_dev structure for device.
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 245b32918ae1..e2ca8ea23e19 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -7,6 +7,7 @@
>  #ifdef CONFIG_IIO_BUFFER
>  
>  #include <uapi/linux/iio/buffer.h>
> +#include <linux/iio/buffer.h>
>  
>  struct iio_dev;
>  struct iio_buffer;
> @@ -23,6 +24,10 @@ struct iio_buffer;
>   * @read:		try to get a specified number of bytes (must exist)
>   * @data_available:	indicates how much data is available for reading from
>   *			the buffer.
> + * @remove_from:	remove scan from buffer. Drivers should calls this to
> + *			remove a scan from a buffer.
> + * @write:		try to write a number of bytes
> + * @space_available:	returns the amount of bytes available in a buffer
>   * @request_update:	if a parameter change has been marked, update underlying
>   *			storage.
>   * @set_bytes_per_datum:set number of bytes per datum
> @@ -49,6 +54,9 @@ struct iio_buffer_access_funcs {
>  	int (*store_to)(struct iio_buffer *buffer, const void *data);
>  	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
>  	size_t (*data_available)(struct iio_buffer *buffer);
> +	int (*remove_from)(struct iio_buffer *buffer, void *data);
> +	int (*write)(struct iio_buffer *buffer, size_t n, const char __user *buf);
> +	size_t (*space_available)(struct iio_buffer *buffer);
>  
>  	int (*request_update)(struct iio_buffer *buffer);
>  
> @@ -80,6 +88,9 @@ struct iio_buffer {
>  	/**  @bytes_per_datum: Size of individual datum including timestamp. */
>  	size_t bytes_per_datum;
>  
> +	/* @direction: Direction of the data stream (in/out). */
> +	enum iio_buffer_direction direction;
> +
>  	/**
>  	 * @access: Buffer access functions associated with the
>  	 * implementation.

