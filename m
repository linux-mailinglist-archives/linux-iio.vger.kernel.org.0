Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED501327179
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 08:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhB1H5o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 02:57:44 -0500
Received: from www381.your-server.de ([78.46.137.84]:35738 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhB1H5o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 02:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=nmIbkkhf+o7kJW3VQaKaK+N69i+9dSr/K7LC5ORBH5g=; b=lJhwr0AmsFyMIAl7JAgPHaOE5I
        4c3nQLSA5pgTizQFb/ZSyiRkVyvaLmHg5sVVMEpwTVPLwBwhHhuwez+odJxUsGcXBcivablkr9+I3
        +NModMG50RSvHe1WNO8AkPi2RjjP7OMP+/03f/WkuyHAr86orR5QlSi6YZJ0+NPwABFP9m/VgBsCQ
        1YtjZMOFv6AxzRuh4E7qxal+A90zP4U0YuybrcYqaewqaqJwBYggVbWIa8HW7+ovGJNSLbu96ipU7
        gFI8BufU6oc7d24qfwP0SmJtBtWHl6pkvKsBX78fLz4KSM1AoNj9T1/Wc6Aes4QMUp9fKdqqolXeW
        +yTMYvbg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lGGwm-0001GI-Ri; Sun, 28 Feb 2021 08:57:00 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lGGwm-000G0I-NA; Sun, 28 Feb 2021 08:57:00 +0100
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
        dragos.bogdan@analog.com
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-21-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d0d2aece-e333-bd87-ad0a-60cf3e387ae4@metafoo.de>
Date:   Sun, 28 Feb 2021 08:57:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215104043.91251-21-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26093/Sat Feb 27 13:05:31 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
> [...]
>   /**
>    * iio_buffer_wakeup_poll - Wakes up the buffer waitqueue
>    * @indio_dev: The IIO device
> @@ -1343,6 +1371,96 @@ static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
>   	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
>   }
>   
> [...]
> +static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	int __user *ival = (int __user *)arg;
> +	struct iio_dev_buffer_pair *ib;
> +	struct iio_buffer *buffer;
> +	int fd, idx, ret;
> +
> +	if (copy_from_user(&idx, ival, sizeof(idx)))
> +		return -EFAULT;

If we only want to pass an int, we can pass that directly, no need to 
pass it as a pointer.

int fd = arg;

> +
> +	if (idx >= iio_dev_opaque->attached_buffers_cnt)
> +		return -ENODEV;
> +
> +	iio_device_get(indio_dev);
> +
> +	buffer = iio_dev_opaque->attached_buffers[idx];
> +
> +	if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->flags)) {
> +		ret = -EBUSY;
> +		goto error_iio_dev_put;
> +	}
> +
> +	ib = kzalloc(sizeof(*ib), GFP_KERNEL);
> +	if (!ib) {
> +		ret = -ENOMEM;
> +		goto error_clear_busy_bit;
> +	}
> +
> +	ib->indio_dev = indio_dev;
> +	ib->buffer = buffer;
> +
> +	fd = anon_inode_getfd("iio:buffer", &iio_buffer_chrdev_fileops,
> +			      ib, O_RDWR | O_CLOEXEC);

I wonder if we need to allow to pass flags, like e.g. O_NONBLOCK.

Something like 
https://elixir.bootlin.com/linux/latest/source/fs/signalfd.c#L288

> +	if (fd < 0) {
> +		ret = fd;
> +		goto error_free_ib;
> +	}
> +
> +	if (copy_to_user(ival, &fd, sizeof(fd))) {
> +		put_unused_fd(fd);
> +		ret = -EFAULT;
> +		goto error_free_ib;
> +	}

Here we copy back the fd, but also return it. Just return is probably 
enough.

> +
> +	return fd;
> +
> +error_free_ib:
> +	kfree(ib);
> +error_clear_busy_bit:
> +	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
> +error_iio_dev_put:
> +	iio_device_put(indio_dev);
> +	return ret;
> +}
> [...]
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index b6ebc04af3e7..32addd5e790e 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -9,6 +9,7 @@
>    * @event_interface:		event chrdevs associated with interrupt lines
>    * @attached_buffers:		array of buffers statically attached by the driver
>    * @attached_buffers_cnt:	number of buffers in the array of statically attached buffers
> + * @buffer_ioctl_handler:	ioctl() handler for this IIO device's buffer interface
>    * @buffer_list:		list of all buffers currently attached
>    * @channel_attr_list:		keep track of automatically created channel
>    *				attributes
> @@ -28,6 +29,7 @@ struct iio_dev_opaque {
>   	struct iio_event_interface	*event_interface;
>   	struct iio_buffer		**attached_buffers;
>   	unsigned int			attached_buffers_cnt;
> +	struct iio_ioctl_handler	*buffer_ioctl_handler;

Can we just embedded this struct so we do not have to 
allocate/deallocate it?

>   	struct list_head		buffer_list;
>   	struct list_head		channel_attr_list;
>   	struct attribute_group		chan_attr_group;


