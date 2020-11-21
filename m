Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504D82BC16A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgKUS1w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgKUS1w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 13:27:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C8522202;
        Sat, 21 Nov 2020 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605983271;
        bh=7lt63X1rrAa65RoyzuKKWmk8dw5q5FvCsJSgulEN+YY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cUIwzgZHr3VvJwvhJwNVT5QzOjgJCmRoI4ULgsgW7gMbDl8H3gM+pXJrXgvm3cC6V
         RqPbJQ1HIQIpT0FbSRz344QTGRiXLHYnOd7+v3bYKBAKbnPecmEfrxKv0kKXAIBWnm
         CUutXvt+U6rk553jo3XZD5GDn+o4hdzvUxm17V9w=
Date:   Sat, 21 Nov 2020 18:27:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 04/12] iio: buffer: add index to the first IIO
 buffer dir and symlink it back
Message-ID: <20201121182747.28b8d576@archlinux>
In-Reply-To: <20201117162340.43924-5-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
        <20201117162340.43924-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 18:23:32 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change makes it so that the first buffer directory is named 'buffer0'
> and moves the 'scan_elements' under it.
> 
> For backwards compatibility these folders are symlinked back to the
> original folders.
Well done on your patch breakdown here.  Makes the actual switch nice
and simple in this patch.

Looks good to me.

Thanks,

Jonathan

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-buffer.c | 38 +++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 8b31faf049a5..62c8bd6b67cd 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1346,7 +1346,8 @@ static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
>  }
>  
>  static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> -					     struct iio_dev *indio_dev)
> +					     struct iio_dev *indio_dev,
> +					     unsigned int idx)
>  {
>  	struct iio_dev_attr *p;
>  	struct attribute **attr;
> @@ -1378,7 +1379,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  	buffer->buffer_attrs = attr;
>  
>  	ret = kobject_init_and_add(&buffer->buffer_dir, &iio_buffer_dir_ktype,
> -				   &indio_dev->dev.kobj, "buffer");
> +				   &indio_dev->dev.kobj, "buffer%u", idx);
>  	if (ret)
>  		goto error_buffer_free_attrs;
>  
> @@ -1423,7 +1424,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  	}
>  
>  	ret = kobject_init_and_add(&buffer->scan_el_dir, &iio_scan_el_dir_ktype,
> -				   &indio_dev->dev.kobj, "scan_elements");
> +				   &buffer->buffer_dir, "scan_elements");
>  	if (ret)
>  		goto error_free_scan_attrs;
>  
> @@ -1454,11 +1455,13 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  	return ret;
>  }
>  
> +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer);
> +
>  int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  {
>  	struct iio_buffer *buffer = indio_dev->buffer;
>  	const struct iio_chan_spec *channels;
> -	int i;
> +	int i, ret;
>  
>  	channels = indio_dev->channels;
>  	if (channels) {
> @@ -1472,7 +1475,29 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return 0;
>  
> -	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
> +	ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = sysfs_create_link(&indio_dev->dev.kobj,
> +				&indio_dev->buffer->buffer_dir,
> +				"buffer");
> +	if (ret)
> +		goto error_free_sysfs_and_mask;
> +
> +	ret = sysfs_create_link(&indio_dev->dev.kobj,
> +				&indio_dev->buffer->scan_el_dir,
> +				"scan_elements");
> +	if (ret)
> +		goto error_remove_buffer_dir_link;
> +
> +	return 0;
> +
> +error_remove_buffer_dir_link:
> +	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
> +error_free_sysfs_and_mask:
> +	__iio_buffer_free_sysfs_and_mask(buffer);
> +	return ret;
>  }
>  
>  static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> @@ -1494,6 +1519,9 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return;
>  
> +	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
> +	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
> +
>  	__iio_buffer_free_sysfs_and_mask(buffer);
>  }
>  

