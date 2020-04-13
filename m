Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B591A6953
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbgDMQA3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 12:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731188AbgDMQA3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 12:00:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85EFF2072D;
        Mon, 13 Apr 2020 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586793628;
        bh=K2yI55ob0TD8VrNui5vXyRDN6synzQ1NUa4PR66fgc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zHSBv4r2yNPFdPsDbw/q2nAEicKCRczR4HLX6dgnt6CCX0T2s/QtdS/uOPK5dWdSo
         It9Rs9kLDtDj6Gh5islr8zD/SjQ9UT6z0X5k+rZ3paNspPwEkupt8eH7NqDdfiGS4I
         KZ/r8JuEyfoGkc1qM2rohgRlxxSXGfywQ/5hKYNI=
Date:   Mon, 13 Apr 2020 17:00:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v3 4/5] iio: buffer: move sysfs alloc/free in
 industrialio-buffer.c
Message-ID: <20200413170024.56ca6ca2@archlinux>
In-Reply-To: <20200410141729.82834-5-alexandru.ardelean@analog.com>
References: <20200410141729.82834-1-alexandru.ardelean@analog.com>
        <20200410141729.82834-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Apr 2020 17:17:28 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Since we now have the 'iio_device_buffers_{un}init()' entry-points into the
> industrialio-buffer.c we can now move the sysfs alloc & free in there as
> part of that init/uninit.
> 
> This changes the order of iio_device_register()/iio_device_unregister() a
> bit, but overall this shouldn't matter.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Seems fine at first glance.

Thanks,

Jonathan

> ---
>  drivers/iio/iio_core.h            | 10 ----------
>  drivers/iio/industrialio-buffer.c | 29 +++++++++++++++--------------
>  drivers/iio/industrialio-core.c   | 14 +-------------
>  3 files changed, 16 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 4bdadeac2710..1d69071e1426 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -48,9 +48,6 @@ void iio_device_buffers_uninit(struct iio_dev *indio_dev);
>  
>  void iio_device_buffers_put(struct iio_dev *indio_dev);
>  
> -int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> -void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
> -
>  void iio_disable_all_buffers(struct iio_dev *indio_dev);
>  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
>  
> @@ -66,13 +63,6 @@ static inline void iio_device_buffers_uninit(struct iio_dev *indio_dev) {}
>  
>  static inline void iio_device_buffers_put(struct iio_dev *indio_dev) {}
>  
> -static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> -{
> -	return 0;
> -}
> -
> -static inline void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
> -
>  static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
>  static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
>  
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4b5c3baadaab..8ab089a9c3bc 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1284,11 +1284,11 @@ static struct attribute *iio_buffer_attrs[] = {
>  	&dev_attr_data_available.attr,
>  };
>  
> -int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> +static int iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
>  {
> +	struct iio_dev *indio_dev = buffer->indio_dev;
>  	struct iio_dev_attr *p;
>  	struct attribute **attr;
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  	int ret, i, attrn, attrcount, attrcount_orig = 0;
>  	const struct iio_chan_spec *channels;
>  
> @@ -1301,9 +1301,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  		indio_dev->masklength = ml;
>  	}
>  
> -	if (!buffer)
> -		return 0;
> -
>  	attrcount = 0;
>  	if (buffer->attrs) {
>  		while (buffer->attrs[attrcount] != NULL)
> @@ -1395,15 +1392,12 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> +static void iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
>  {
> -	if (!indio_dev->buffer)
> -		return;
> -
> -	bitmap_free(indio_dev->buffer->scan_mask);
> -	kfree(indio_dev->buffer->buffer_group.attrs);
> -	kfree(indio_dev->buffer->scan_el_group.attrs);
> -	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
> +	bitmap_free(buffer->scan_mask);
> +	kfree(buffer->buffer_group.attrs);
> +	kfree(buffer->scan_el_group.attrs);
> +	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
>  }
>  
>  static const struct file_operations iio_buffer_fileops = {
> @@ -1425,13 +1419,19 @@ int iio_device_buffers_init(struct iio_dev *indio_dev, struct module *this_mod)
>  	if (!buffer)
>  		return -ENOTSUPP;
>  
> +	ret = iio_buffer_alloc_sysfs_and_mask(buffer);
> +	if (ret)
> +		return ret;
> +
>  	cdev_init(&buffer->chrdev, &iio_buffer_fileops);
>  
>  	buffer->chrdev.owner = this_mod;
>  
>  	ret = cdev_device_add(&buffer->chrdev, &indio_dev->dev);
> -	if (ret)
> +	if (ret) {
> +		iio_buffer_free_sysfs_and_mask(buffer);
>  		return ret;
> +	}
>  
>  	iio_device_get(indio_dev);
>  	iio_buffer_get(buffer);
> @@ -1457,6 +1457,7 @@ void iio_device_buffers_uninit(struct iio_dev *indio_dev)
>  		return;
>  
>  	cdev_device_del(&buffer->chrdev, &indio_dev->dev);
> +	iio_buffer_free_sysfs_and_mask(buffer);
>  	iio_buffer_put(buffer);
>  	iio_device_put(indio_dev);
>  }
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2158aeab0bd2..794aaa4be832 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1737,18 +1737,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  
>  	iio_device_register_debugfs(indio_dev);
>  
> -	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
> -	if (ret) {
> -		dev_err(indio_dev->dev.parent,
> -			"Failed to create buffer sysfs interfaces\n");
> -		goto error_unreg_debugfs;
> -	}
> -
>  	ret = iio_device_register_sysfs(indio_dev);
>  	if (ret) {
>  		dev_err(indio_dev->dev.parent,
>  			"Failed to register sysfs interfaces\n");
> -		goto error_buffer_free_sysfs;
> +		goto error_free_sysfs;
>  	}
>  	ret = iio_device_register_eventset(indio_dev);
>  	if (ret) {
> @@ -1785,9 +1778,6 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	iio_device_unregister_eventset(indio_dev);
>  error_free_sysfs:
>  	iio_device_unregister_sysfs(indio_dev);
> -error_buffer_free_sysfs:
> -	iio_buffer_free_sysfs_and_mask(indio_dev);
> -error_unreg_debugfs:
>  	iio_device_unregister_debugfs(indio_dev);
>  	return ret;
>  }
> @@ -1818,8 +1808,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  	iio_buffer_wakeup_poll(indio_dev);
>  
>  	mutex_unlock(&indio_dev->info_exist_lock);
> -
> -	iio_buffer_free_sysfs_and_mask(indio_dev);
>  }
>  EXPORT_SYMBOL(iio_device_unregister);
>  

