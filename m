Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698392BC18E
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKUSou (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgKUSou (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 13:44:50 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED71520867;
        Sat, 21 Nov 2020 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605984289;
        bh=Pw3yjazdRYfGLN04zKeb1ThaolM5swK0XcV1YK7oiVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rSvxAxHO2qqYSnkTadedEtQcY9/Bf2NiQhcLMdN3S/aPKDdePFjvKqgUbji/iHH/a
         cMxvJpGqnZ30Uq2wvVZZvOfBFZZpI2sC7khNeN3GzW3V6l+UEY7Q8HNu58ZbtGo7Dx
         TbUL9/12G8lxymaBE7ciTsCNt005A7rrqN0fTlNU=
Date:   Sat, 21 Nov 2020 18:44:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 11/12] iio: buffer: introduce support for attaching
 more IIO buffers
Message-ID: <20201121184445.12ec2d92@archlinux>
In-Reply-To: <20201117162340.43924-12-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
        <20201117162340.43924-12-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 18:23:39 +0200
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
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
A couple of minor things in here..

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 58 +++++++++++++++++++++++++------
>  include/linux/iio/buffer_impl.h   |  3 ++
>  include/linux/iio/iio-opaque.h    |  4 +++
>  3 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index c83cec89eddf..daa68822cea7 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1513,6 +1513,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer);
>  
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_buffer *buffer = indio_dev->buffer;
>  	const struct iio_chan_spec *channels;
>  	int i, ret;
> @@ -1529,15 +1530,18 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return 0;
>  
> -	ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
> -	if (ret)
> -		return ret;
> +	for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
> +		buffer = iio_dev_opaque->attached_buffers[i];
> +		ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
> +		if (ret)
> +			goto error_unwind_sysfs_and_mask;
> +	}
>  
>  	ret = sysfs_create_link(&indio_dev->dev.kobj,
>  				&indio_dev->buffer->buffer_dir,
>  				"buffer");
>  	if (ret)
> -		goto error_free_sysfs_and_mask;
> +		goto error_unwind_sysfs_and_mask;
>  
>  	ret = sysfs_create_link(&indio_dev->dev.kobj,
>  				&indio_dev->buffer->scan_el_dir,
> @@ -1549,8 +1553,14 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  
>  error_remove_buffer_dir_link:
>  	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
> -error_free_sysfs_and_mask:
> -	__iio_buffer_free_sysfs_and_mask(buffer);
> +	i = iio_dev_opaque->attached_buffers_cnt - 1;

Perhaps just use a counter variable that is only for this then you won't need
to set it again in this error path.

> +error_unwind_sysfs_and_mask:
> +	for (; i >= 0; i--) {
> +		buffer = iio_dev_opaque->attached_buffers[i];
> +		__iio_buffer_free_sysfs_and_mask(buffer);
> +	}
> +	kfree(iio_dev_opaque->attached_buffers);
> +	iio_dev_opaque->attached_buffers = NULL;
>  	return ret;
>  }
>  
> @@ -1568,7 +1578,9 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
>  
>  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_buffer *buffer = indio_dev->buffer;
> +	int i;
>  
>  	if (!buffer)
>  		return;
> @@ -1576,7 +1588,13 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
>  	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
>  
> -	__iio_buffer_free_sysfs_and_mask(buffer);
> +	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> +		buffer = iio_dev_opaque->attached_buffers[i];
> +		__iio_buffer_free_sysfs_and_mask(buffer);
> +	}
> +
> +	kfree(iio_dev_opaque->attached_buffers);
> +	iio_dev_opaque->attached_buffers = NULL;
>  }
>  
>  /**
> @@ -1709,14 +1727,32 @@ EXPORT_SYMBOL_GPL(iio_buffer_get_iio_dev);
>   * @buffer: The buffer to attach to the device
>   *
>   * This function attaches a buffer to a IIO device. The buffer stays attached to
> - * the device until the device is freed. The function should only be called at
> - * most once per device.
> + * the device until the device is freed. For legacy reasons, the first attached
> + * buffer will also be assigned to 'indio_dev->buffer'.
>   */
>  void iio_device_attach_buffer(struct iio_dev *indio_dev,
>  			      struct iio_buffer *buffer)
>  {
> -	indio_dev->buffer = iio_buffer_get(buffer);
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct iio_buffer **new, **old = iio_dev_opaque->attached_buffers;
> +	unsigned int cnt = iio_dev_opaque->attached_buffers_cnt;
> +
> +	cnt++;
> +
> +	new = krealloc(old, sizeof(*new) * cnt, GFP_KERNEL);
> +	if (!new) {
> +		kfree(old);

Need a comment on why freeing old makes sense.

> +		return;
> +	}
> +	iio_dev_opaque->attached_buffers = new;
> +
> +	/* first buffer is legacy; attach it to the IIO device directly */
> +	if (!indio_dev->buffer)
> +		indio_dev->buffer = iio_buffer_get(buffer);
> +
> +	buffer->indio_dev = indio_dev;
>  
> -	indio_dev->buffer->indio_dev = indio_dev;
> +	iio_dev_opaque->attached_buffers[cnt - 1] = buffer;
> +	iio_dev_opaque->attached_buffers_cnt = cnt;
>  }
>  EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 77e169e51434..e25d26a7f601 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -124,6 +124,9 @@ struct iio_buffer {
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
> index 07c5a8e52ca8..1db0ea09520e 100644
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
> @@ -20,6 +22,8 @@
>  struct iio_dev_opaque {
>  	struct iio_dev			indio_dev;
>  	struct iio_event_interface	*event_interface;
> +	struct iio_buffer		**attached_buffers;
> +	unsigned int			attached_buffers_cnt;
>  	struct list_head		buffer_list;
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;

