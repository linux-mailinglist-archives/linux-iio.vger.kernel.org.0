Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BF31B068
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 13:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBNM5x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 07:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhBNM5w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 07:57:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6E064E52;
        Sun, 14 Feb 2021 12:57:10 +0000 (UTC)
Date:   Sun, 14 Feb 2021 12:57:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 05/17] iio: buffer: group attr count and attr alloc
Message-ID: <20210214125706.088c9c02@archlinux>
In-Reply-To: <20210211122452.78106-6-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
        <20210211122452.78106-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Feb 2021 14:24:40 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> If we want to merge the attributes of the buffer/ and scan_elements/
> directories, we'll need to count all attributes first, then (depending on
> the attribute group) either allocate 2 attribute groups, or a single one.
> Historically an IIO buffer was described by 2 subdirectories under
> /sys/bus/iio/iio:devicesX (i.e. buffer/ and scan_elements/); these subdirs
> were actually 2 separate attribute groups on the iio_buffer object.
> 
> Moving forward, if we want to allow more than one buffer per IIO device,
> keeping 2 subdirectories for each IIO buffer is a bit cumbersome
> (especially for userpace ABI). So, we will merge the attributes of these 2
> subdirs under a /sys/bus/iio/iio:devicesX/bufferY subdirectory. To do this,
> we need to count all attributes first, and then distribute them based on
> which buffer this is. For the first buffer, we'll need to also allocate the
> legacy 2 attribute groups (for buffer/ and scan_elements/), and also a
> /sys/bus/iio/iio:devicesX/buffer0 attribute group.
> 
> For buffer1 and above, just a single attribute group will be allocated (the
> merged one).
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
One totally trivial thing noticed in here.  If we happen to respin
please tidy it up, if I take these as is I 'might' tweak it, or I might
not bother depending on what mood I'm in later today.

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 71 ++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index cc846988fdb9..23f22be62cc7 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1257,41 +1257,16 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  {
>  	struct iio_dev_attr *p;
>  	struct attribute **attr;
> -	int ret, i, attrn, attrcount;
> +	int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
>  	const struct iio_chan_spec *channels;
>  
> -	attrcount = 0;
> +	buffer_attrcount = 0;
>  	if (buffer->attrs) {
> -		while (buffer->attrs[attrcount] != NULL)
> -			attrcount++;
> +		while (buffer->attrs[buffer_attrcount] != NULL)
> +			buffer_attrcount++;
>  	}
>  
> -	attr = kcalloc(attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
> -		       sizeof(struct attribute *), GFP_KERNEL);
> -	if (!attr)
> -		return -ENOMEM;
> -
> -	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
> -	if (!buffer->access->set_length)
> -		attr[0] = &dev_attr_length_ro.attr;
> -
> -	if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
> -		attr[2] = &dev_attr_watermark_ro.attr;
> -
> -	if (buffer->attrs)
> -		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
> -		       sizeof(struct attribute *) * attrcount);
> -
> -	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
> -
> -	buffer->buffer_group.name = "buffer";
> -	buffer->buffer_group.attrs = attr;
> -
> -	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
> -	if (ret)
> -		goto error_free_buffer_attrs;
> -
> -	attrcount = 0;
> +	scan_el_attrcount = 0;
>  	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
>  	channels = indio_dev->channels;
>  	if (channels) {
> @@ -1304,7 +1279,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  							 &channels[i]);
>  			if (ret < 0)
>  				goto error_cleanup_dynamic;
> -			attrcount += ret;
> +			scan_el_attrcount += ret;
>  			if (channels[i].type == IIO_TIMESTAMP)
>  				indio_dev->scan_index_timestamp =
>  					channels[i].scan_index;
> @@ -1319,9 +1294,37 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  		}
>  	}
>  
> +	attr = kcalloc(buffer_attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
> +		       sizeof(struct attribute *), GFP_KERNEL);

nitpick, I'd have made that sizeof(*attr) 
 
> +	if (!attr) {
> +		ret = -ENOMEM;
> +		goto error_free_scan_mask;
> +	}
> +
> +	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
> +	if (!buffer->access->set_length)
> +		attr[0] = &dev_attr_length_ro.attr;
> +
> +	if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
> +		attr[2] = &dev_attr_watermark_ro.attr;
> +
> +	if (buffer->attrs)
> +		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
> +		       sizeof(struct attribute *) * buffer_attrcount);
> +
> +	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
> +	attr[buffer_attrcount] = NULL;
> +
> +	buffer->buffer_group.name = "buffer";
> +	buffer->buffer_group.attrs = attr;
> +
> +	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
> +	if (ret)
> +		goto error_free_buffer_attrs;
> +
>  	buffer->scan_el_group.name = iio_scan_elements_group_name;
>  
> -	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
> +	buffer->scan_el_group.attrs = kcalloc(scan_el_attrcount + 1,
>  					      sizeof(buffer->scan_el_group.attrs[0]),
>  					      GFP_KERNEL);
>  	if (buffer->scan_el_group.attrs == NULL) {
> @@ -1341,12 +1344,12 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  
>  error_free_scan_el_attrs:
>  	kfree(buffer->scan_el_group.attrs);
> +error_free_buffer_attrs:
> +	kfree(buffer->buffer_group.attrs);
>  error_free_scan_mask:
>  	bitmap_free(buffer->scan_mask);
>  error_cleanup_dynamic:
>  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> -error_free_buffer_attrs:
> -	kfree(buffer->buffer_group.attrs);
>  
>  	return ret;
>  }

