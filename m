Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B602A31B06B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 14:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhBNNDM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 08:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhBNNDM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 08:03:12 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B9F64E52;
        Sun, 14 Feb 2021 13:02:28 +0000 (UTC)
Date:   Sun, 14 Feb 2021 13:02:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 06/17] iio: core: merge buffer/ & scan_elements/
 attributes
Message-ID: <20210214130225.75c4d7f1@archlinux>
In-Reply-To: <20210211122452.78106-7-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
        <20210211122452.78106-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Feb 2021 14:24:41 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> With this change, we create a new directory for the IIO device called
> buffer0, under which both the old buffer/ and scan_elements/ are stored.
> 
> This is done to simplify the addition of multiple IIO buffers per IIO
> device. Otherwise we would need to add a bufferX/ and scan_elementsX/
> directory for each IIO buffer.
> With the current way of storing attribute groups, we can't have directories
> stored under each other (i.e. scan_elements/ under buffer/), so the best
> approach moving forward is to merge their attributes.
> 
> The old/legacy buffer/ & scan_elements/ groups are not stored on the opaque
> IIO device object. This way the IIO buffer can have just a single
> attribute_group object, saving a bit of memory when adding multiple IIO
> buffers.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Two trivial things inline.

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 115 +++++++++++++++++++++++-------
>  include/linux/iio/buffer_impl.h   |   9 +--
>  include/linux/iio/iio-opaque.h    |   4 ++
>  3 files changed, 95 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 23f22be62cc7..fcbbffb904bf 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1175,8 +1175,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
>  	return (ret < 0) ? ret : len;
>  }
>  
> -static const char * const iio_scan_elements_group_name = "scan_elements";
> -
>  static ssize_t iio_buffer_show_watermark(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -1252,8 +1250,68 @@ static struct attribute *iio_buffer_attrs[] = {
>  	&dev_attr_data_available.attr,
>  };
>  
> +static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
> +						   struct attribute **buffer_attrs,
> +						   int buffer_attrcount,
> +						   int scan_el_attrcount)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	struct attribute_group *group;
> +	int ret;
> +
> +	group = &iio_dev_opaque->legacy_buffer_group;
> +
> +	group->attrs = kcalloc(buffer_attrcount + 1,
> +			       sizeof(struct attribute *), GFP_KERNEL);
> +	if (!group->attrs)
> +		return -ENOMEM;
> +
> +	memcpy(group->attrs, buffer_attrs,
> +	       buffer_attrcount * sizeof(struct attribute *));
> +	group->name = "buffer";
> +
> +	ret = iio_device_register_sysfs_group(indio_dev, group);
> +	if (ret)
> +		goto error_free_buffer_attrs;
> +
> +	group = &iio_dev_opaque->legacy_scan_el_group;
> +
> +	group->attrs = kcalloc(scan_el_attrcount + 1,
> +			       sizeof(struct attribute *), GFP_KERNEL);
> +	if (!group->attrs) {
> +		ret = -ENOMEM;
> +		goto error_free_buffer_attrs;
> +	}
> +
> +	memcpy(group->attrs, &buffer_attrs[buffer_attrcount],
> +	       scan_el_attrcount * sizeof(struct attribute *));
> +	group->name = "scan_elements";
> +
> +	ret = iio_device_register_sysfs_group(indio_dev, group);
> +	if (ret)
> +		goto error_free_scan_el_attrs;
> +
> +	return 0;
> +
> +error_free_buffer_attrs:
> +	kfree(iio_dev_opaque->legacy_buffer_group.attrs);
> +error_free_scan_el_attrs:
> +	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
> +
> +	return ret;
> +}
> +
> +static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	kfree(iio_dev_opaque->legacy_buffer_group.attrs);
> +	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
> +}
> +
>  static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> -					     struct iio_dev *indio_dev)
> +					     struct iio_dev *indio_dev,
> +					     int index)
>  {
>  	struct iio_dev_attr *p;
>  	struct attribute **attr;
> @@ -1294,8 +1352,8 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  		}
>  	}
>  
> -	attr = kcalloc(buffer_attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
> -		       sizeof(struct attribute *), GFP_KERNEL);
> +	attrn = buffer_attrcount + scan_el_attrcount + ARRAY_SIZE(iio_buffer_attrs);
> +	attr = kcalloc(attrn + 1, sizeof(struct attribute *), GFP_KERNEL);
>  	if (!attr) {
>  		ret = -ENOMEM;
>  		goto error_free_scan_mask;
> @@ -1313,37 +1371,38 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  		       sizeof(struct attribute *) * buffer_attrcount);
>  
>  	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
> -	attr[buffer_attrcount] = NULL;
> -
> -	buffer->buffer_group.name = "buffer";
> -	buffer->buffer_group.attrs = attr;
>  
> -	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
> -	if (ret)
> -		goto error_free_buffer_attrs;
> +	attrn = buffer_attrcount;
>  
> -	buffer->scan_el_group.name = iio_scan_elements_group_name;
> +	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> +		attr[attrn++] = &p->dev_attr.attr;
>  
> -	buffer->scan_el_group.attrs = kcalloc(scan_el_attrcount + 1,
> -					      sizeof(buffer->scan_el_group.attrs[0]),
> -					      GFP_KERNEL);
> -	if (buffer->scan_el_group.attrs == NULL) {
> +	buffer->buffer_group.name = kasprintf(GFP_KERNEL, "buffer%d", index);
> +	if (!buffer->buffer_group.name) {
>  		ret = -ENOMEM;
> -		goto error_free_scan_mask;
> +		goto error_free_buffer_attrs;
>  	}
> -	attrn = 0;
>  
> -	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> -		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
> +	buffer->buffer_group.attrs = attr;
>  
> -	ret = iio_device_register_sysfs_group(indio_dev, &buffer->scan_el_group);
> +	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
>  	if (ret)
> -		goto error_free_scan_el_attrs;
> +		goto error_free_buffer_attr_group_name;
> +
> +	/* we only need to link the legacy buffer groups for the first buffer */

Not linking as such any more so comment could do with an update.

> +	if (index > 0)
> +		return 0;
> +
> +	ret = iio_buffer_register_legacy_sysfs_groups(indio_dev, attr,
> +						      buffer_attrcount,
> +						      scan_el_attrcount);
> +	if (ret)
> +		goto error_free_buffer_attr_group_name;
>  
>  	return 0;
>  
> -error_free_scan_el_attrs:
> -	kfree(buffer->scan_el_group.attrs);
> +error_free_buffer_attr_group_name:
> +	kfree(buffer->buffer_group.name);
>  error_free_buffer_attrs:
>  	kfree(buffer->buffer_group.attrs);
>  error_free_scan_mask:
> @@ -1372,14 +1431,14 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return 0;
>  
> -	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
> +	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
>  }
>  
>  static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
>  {
>  	bitmap_free(buffer->scan_mask);
> +	kfree(buffer->buffer_group.name);
>  	kfree(buffer->buffer_group.attrs);
> -	kfree(buffer->scan_el_group.attrs);
>  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
>  }
>  
> @@ -1390,6 +1449,8 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
>  	if (!buffer)
>  		return;
>  
> +	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
> +
>  	__iio_buffer_free_sysfs_and_mask(buffer);
>  }
>  
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index a63dc07b7350..3e555e58475b 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -100,14 +100,11 @@ struct iio_buffer {
>  	/* @scan_el_dev_attr_list: List of scan element related attributes. */
>  	struct list_head scan_el_dev_attr_list;
>  
> -	/* @buffer_group: Attributes of the buffer group. */
> -	struct attribute_group buffer_group;
> -
>  	/*
> -	 * @scan_el_group: Attribute group for those attributes not
> -	 * created from the iio_chan_info array.
> +	 * @buffer_group: Attributes of the new buffer group.
> +	 * Includes scan elements attributes.
>  	 */
> -	struct attribute_group scan_el_group;
> +	struct attribute_group buffer_group;
>  
>  	/* @attrs: Standard attributes of the buffer. */
>  	const struct attribute **attrs;
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 8ba13a5c7af6..3e4c3cd248fd 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -14,6 +14,8 @@
>   * @ioctl_handlers:		ioctl handlers registered with the core handler
>   * @groups:			attribute groups
>   * @groupcounter:		index of next attribute group
> + * @legacy_scan_el_group:	attribute group for legacy scan elements attribute group
> + * @legacy_buffer_el_group:	attribute group for legacy buffer attributes group

Wrong name

>   * @debugfs_dentry:		device specific debugfs dentry
>   * @cached_reg_addr:		cached register address for debugfs reads
>   * @read_buf:			read buffer to be used for the initial reg read
> @@ -28,6 +30,8 @@ struct iio_dev_opaque {
>  	struct list_head		ioctl_handlers;
>  	const struct attribute_group	**groups;
>  	int				groupcounter;
> +	struct attribute_group		legacy_scan_el_group;
> +	struct attribute_group		legacy_buffer_group;
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry			*debugfs_dentry;
>  	unsigned			cached_reg_addr;

