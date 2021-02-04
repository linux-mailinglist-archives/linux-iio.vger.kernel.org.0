Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5830FA64
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 18:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbhBDRz6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 12:55:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2500 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbhBDRvL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 12:51:11 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWmBg0gjyz67ktp;
        Fri,  5 Feb 2021 01:44:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 18:50:28 +0100
Received: from localhost (10.47.65.115) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 17:50:27 +0000
Date:   Thu, 4 Feb 2021 17:49:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 05/11] iio: buffer: group attr count and attr alloc
Message-ID: <20210204174942.000013b3@Huawei.com>
In-Reply-To: <20210201145105.20459-6-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
        <20210201145105.20459-6-alexandru.ardelean@analog.com>
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

On Mon, 1 Feb 2021 16:50:59 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> If we want to merge the attributes of the buffer/ and scan_elements/
> directories, we'll need to count all attributes first, then (depending on
> the attribute group) either allocate 2 attribute groups, or a single one.

Probably want to note why we might want to do 2 or 1 group here as it
sounds weird without knowing where this is going.

> 
> This change moves the allocation of the buffer/ attributes closer to the
> allocation of the scan_elements/ attributes to make grouping easier.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
This is fine, but one comment on a possible tidy up for another day inline.

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

Again a comment for the future  rather than now, but when we are copying
4 items and then looking at whether to change 2 of them it might be cleaner
to just set them directly!  Touch of bit rot here :)

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

