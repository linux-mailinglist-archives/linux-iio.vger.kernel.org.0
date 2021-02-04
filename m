Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE5D30FBAB
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 19:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbhBDSho (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 13:37:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2503 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbhBDSgH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 13:36:07 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWnFb4ny9z67hHQ;
        Fri,  5 Feb 2021 02:31:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 4 Feb 2021 19:35:19 +0100
Received: from localhost (10.47.65.115) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 18:35:18 +0000
Date:   Thu, 4 Feb 2021 18:34:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 10/11] iio: buffer: introduce support for attaching
 more IIO buffers
Message-ID: <20210204183433.000079e3@Huawei.com>
In-Reply-To: <20210201145105.20459-11-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
        <20210201145105.20459-11-alexandru.ardelean@analog.com>
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

On Mon, 1 Feb 2021 16:51:04 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> With this change, calling iio_device_attach_buffer() will actually attach
> more buffers.
> Right now this doesn't do any validation of whether a buffer is attached
> twice; maybe that can be added later (if needed). Attaching a buffer more
> than once should yield noticeably bad results.
> 
> The first buffer is the legacy buffer, so a reference is kept to it.
> 
> At this point, accessing the data for the extra buffers (that are added
> after the first one) isn't possible yet.
> 
> The iio_device_attach_buffer() is also changed to return an error code,
> which for now is -ENOMEM if the array could not be realloc-ed for more
> buffers.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
A few minor comments inline.

Thanks,

J
> ---
>  drivers/iio/industrialio-buffer.c | 80 +++++++++++++++++++++++++------
>  include/linux/iio/buffer.h        |  4 +-
>  include/linux/iio/buffer_impl.h   |  3 ++
>  include/linux/iio/iio-opaque.h    |  4 ++
>  4 files changed, 74 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 692f721588e2..a69bb705d173 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1445,11 +1445,21 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  	return ret;
>  }
>  
> +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> +{
> +	bitmap_free(buffer->scan_mask);
> +	kfree(buffer->buffer_group.name);
> +	kfree(buffer->buffer_group.attrs);
> +	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
> +}
> +
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_buffer *buffer = indio_dev->buffer;
>  	const struct iio_chan_spec *channels;
> -	int i;
> +	int unwind_idx;
> +	int ret, i;
>  
>  	channels = indio_dev->channels;
>  	if (channels) {
> @@ -1463,27 +1473,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return 0;
>  
> -	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
> -}
> +	for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
> +		buffer = iio_dev_opaque->attached_buffers[i];
> +		ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
> +		if (ret) {
> +			unwind_idx = i;
Gut feeling would be to use i instead of introducing unwind_idx, but it
doesn't really matter if you prefer this.

> +			goto error_unwind_sysfs_and_mask;
> +		}
> +	}
>  
> -static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> -{
> -	bitmap_free(buffer->scan_mask);
> -	kfree(buffer->buffer_group.name);
> -	kfree(buffer->buffer_group.attrs);
> -	iio_free_chan_devattr_list(&buffer->buffer_attr_list);

could you put this move in a precursor patch. It's making a mess
of the diff and hence this harder to review than it should be.

> +	return 0;
> +
> +error_unwind_sysfs_and_mask:
> +	for (; unwind_idx >= 0; unwind_idx--) {
> +		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
> +		__iio_buffer_free_sysfs_and_mask(buffer);
> +	}
> +	kfree(iio_dev_opaque->attached_buffers);
> +	iio_dev_opaque->attached_buffers = NULL;
> +	return ret;
>  }
>  
>  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_buffer *buffer = indio_dev->buffer;
> +	int i;
>  
>  	if (!buffer)
>  		return;
>  
>  	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
>  
> -	__iio_buffer_free_sysfs_and_mask(buffer);
> +	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> +		buffer = iio_dev_opaque->attached_buffers[i];
> +		__iio_buffer_free_sysfs_and_mask(buffer);
> +	}
> +
> +	kfree(iio_dev_opaque->attached_buffers);
> +	iio_dev_opaque->attached_buffers = NULL;

For places where we set freed pointers to NULL, I'd like a comment on why.
Usually it makes me a bit worried we are doing something less than tidy.

>  }
>  
>  /**
> @@ -1601,13 +1629,35 @@ EXPORT_SYMBOL_GPL(iio_buffer_put);
>   * @indio_dev: The device the buffer should be attached to
>   * @buffer: The buffer to attach to the device
>   *
> + * Return 0 if successful, negative if error.
> + *
>   * This function attaches a buffer to a IIO device. The buffer stays attached to
> - * the device until the device is freed. The function should only be called at
> - * most once per device.
> + * the device until the device is freed. For legacy reasons, the first attached
> + * buffer will also be assigned to 'indio_dev->buffer'.
>   */
> -void iio_device_attach_buffer(struct iio_dev *indio_dev,
> -			      struct iio_buffer *buffer)
> +int iio_device_attach_buffer(struct iio_dev *indio_dev,
> +			     struct iio_buffer *buffer)
>  {
> -	indio_dev->buffer = iio_buffer_get(buffer);
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_buffer **new, **old = iio_dev_opaque->attached_buffers;
> +	unsigned int cnt = iio_dev_opaque->attached_buffers_cnt;
> +
> +	cnt++;
> +
> +	new = krealloc(old, sizeof(*new) * cnt, GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +	iio_dev_opaque->attached_buffers = new;
> +
> +	buffer = iio_buffer_get(buffer);
> +
> +	/* first buffer is legacy; attach it to the IIO device directly */
> +	if (!indio_dev->buffer)
> +		indio_dev->buffer = buffer;
> +
> +	iio_dev_opaque->attached_buffers[cnt - 1] = buffer;
> +	iio_dev_opaque->attached_buffers_cnt = cnt;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 8febc23f5f26..b6928ac5c63d 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -41,7 +41,7 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
>  bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>  				   const unsigned long *mask);
>  
> -void iio_device_attach_buffer(struct iio_dev *indio_dev,
> -			      struct iio_buffer *buffer);
> +int iio_device_attach_buffer(struct iio_dev *indio_dev,
> +			     struct iio_buffer *buffer);
>  
>  #endif /* _IIO_BUFFER_GENERIC_H_ */
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 41044320e581..768b90c64412 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -112,6 +112,9 @@ struct iio_buffer {
>  	/* @demux_bounce: Buffer for doing gather from incoming scan. */
>  	void *demux_bounce;
>  
> +	/* @attached_entry: Entry in the devices list of buffers attached by the driver. */
> +	struct list_head attached_entry;
> +
>  	/* @buffer_list: Entry in the devices list of current buffers. */
>  	struct list_head buffer_list;
>  
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 3e4c3cd248fd..c909835b6247 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -7,6 +7,8 @@
>   * struct iio_dev_opaque - industrial I/O device opaque information
>   * @indio_dev:			public industrial I/O device information
>   * @event_interface:		event chrdevs associated with interrupt lines
> + * @attached_buffers:		array of buffers statically attached by the driver
> + * @attached_buffers_cnt:	number of buffers in the array of statically attached buffers
>   * @buffer_list:		list of all buffers currently attached
>   * @channel_attr_list:		keep track of automatically created channel
>   *				attributes
> @@ -24,6 +26,8 @@
>  struct iio_dev_opaque {
>  	struct iio_dev			indio_dev;
>  	struct iio_event_interface	*event_interface;
> +	struct iio_buffer		**attached_buffers;
> +	unsigned int			attached_buffers_cnt;
>  	struct list_head		buffer_list;
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;

