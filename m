Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC902BC168
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKUSYl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgKUSYk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 13:24:40 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7DA22202;
        Sat, 21 Nov 2020 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605983079;
        bh=5Q6QQM0Ez82sPzdLVXr9yo1pD0sIJOLZn09LUXuevKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GEi/UY2tJzgIeLsyQlxV5BfIuSFcDP+ByY5qk2Vx6aRJ1Xs8gc4FST++HNlUMcHbR
         v60OLiuHDc8sarrb4mJDxxHdqw5/PbyGTCKj+U2m3yOZ9PNGvucx4spiQNN2vJHI5I
         X9ferPtomlI0WVd0SpxxwkdMUGW2FHOwZnrjIbBQ=
Date:   Sat, 21 Nov 2020 18:24:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 03/12] iio: buffer: rework buffer & scan_elements
 dir creation
Message-ID: <20201121182435.54c61758@archlinux>
In-Reply-To: <20201117162340.43924-4-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
        <20201117162340.43924-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 18:23:31 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> When adding more than one IIO buffer per IIO device, we will need to create
> a buffer & scan_elements directory for each buffer.
> We also want to move the 'scan_elements' to be a sub-directory of the
> 'buffer' folder.
> 
> The format we want to reach is, for a iio:device0 folder, for 2 buffers
> [for example], we have a 'buffer0' and a 'buffer1' subfolder, and each with
> it's own 'scan_elements' subfolder.
> 
> So, for example:
>    iio:device0/buffer0
>       scan_elements/
> 
>    iio:device0/buffer1
>       scan_elements/
> 
> The other attributes under 'bufferX' would remain unchanged.
> 
> However, we would also need to symlink back to the old 'buffer' &
> 'scan_elements' folders, to keep backwards compatibility.
> 
> Doing all these, require that we maintain the kobjects for each 'bufferX'
> and 'scan_elements' so that we can symlink them back. We also need to
> implement the sysfs_ops for these folders.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hmm. This ended up a bit nasty.  It could do with a few more comments
in the code to make it clear what is going on. 

> ---
>  drivers/iio/industrialio-buffer.c | 151 ++++++++++++++++++++++++++----
>  drivers/iio/industrialio-core.c   |  24 ++---
>  include/linux/iio/buffer_impl.h   |  14 ++-
>  include/linux/iio/iio.h           |   2 +-
>  4 files changed, 156 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 08aa8e0782ce..8b31faf049a5 100644
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
> @@ -1252,6 +1250,101 @@ static struct attribute *iio_buffer_attrs[] = {
>  	&dev_attr_data_available.attr,
>  };
>  
> +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> +
> +static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
> +					struct attribute *attr,
> +					char *buf)
> +{
> +	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> +	struct device_attribute *dattr;
> +
> +	dattr = to_dev_attr(attr);
> +
> +	return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> +}
> +
> +static ssize_t iio_buffer_dir_attr_store(struct kobject *kobj,
> +					 struct attribute *attr,
> +					 const char *buf,
> +					 size_t len)
> +{
> +	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> +	struct device_attribute *dattr;
> +
> +	dattr = to_dev_attr(attr);
> +
> +	return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> +}
> +
> +static const struct sysfs_ops iio_buffer_dir_sysfs_ops = {
> +	.show = iio_buffer_dir_attr_show,
> +	.store = iio_buffer_dir_attr_store,
> +};
> +
> +static struct kobj_type iio_buffer_dir_ktype = {
> +	.sysfs_ops = &iio_buffer_dir_sysfs_ops,
> +};
> +
> +static ssize_t iio_scan_el_dir_attr_show(struct kobject *kobj,
> +					 struct attribute *attr,
> +					 char *buf)
> +{
> +	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> +	struct device_attribute *dattr = to_dev_attr(attr);
> +
> +	return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> +}
> +
> +static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
> +					  struct attribute *attr,
> +					  const char *buf,
> +					  size_t len)
> +{
> +	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> +	struct device_attribute *dattr = to_dev_attr(attr);
> +
> +	return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> +}
> +
> +static const struct sysfs_ops iio_scan_el_dir_sysfs_ops = {
> +	.show = iio_scan_el_dir_attr_show,
> +	.store = iio_scan_el_dir_attr_store,
> +};
> +
> +static struct kobj_type iio_scan_el_dir_ktype = {
> +	.sysfs_ops = &iio_scan_el_dir_sysfs_ops,
> +};
> +
> +/*
> + * This iio_sysfs_{add,del}_attrs() are essentially re-implementations of
> + * sysfs_create_files() & sysfs_remove_files(), but they are meant to get
> + * around the const-pointer mismatch situation with using them.
> + *
> + * sysfs_{create,remove}_files() uses 'const struct attribute * const *ptr',
> + * while these are happy with just 'struct attribute **ptr'

Ouch.  This definitely doesn't feel like a great thing to do. 

> + */
> +static int iio_sysfs_add_attrs(struct kobject *kobj, struct attribute **ptr)
> +{
> +	int err = 0;
> +	int i;
> +
> +	for (i = 0; ptr[i] && !err; i++)
> +		err = sysfs_create_file(kobj, ptr[i]);
> +	if (err)
> +		while (--i >= 0)
> +			sysfs_remove_file(kobj, ptr[i]);
> +	return err;
> +}
> +
> +static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
> +{
> +	int i;
> +
> +	for (i = 0; ptr[i]; i++)
> +		sysfs_remove_file(kobj, ptr[i]);
> +}
> +
>  static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,

Definitely add some docs to this to say why we have this complexity..

>  					     struct iio_dev *indio_dev)
>  {
> @@ -1282,12 +1375,16 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
>  		       sizeof(struct attribute *) * attrcount);
>  
> -	attr[attrcount + ARRAY_SIZE(iio_buffer_attrs)] = NULL;
> +	buffer->buffer_attrs = attr;
>  
> -	buffer->buffer_group.name = "buffer";
> -	buffer->buffer_group.attrs = attr;
> +	ret = kobject_init_and_add(&buffer->buffer_dir, &iio_buffer_dir_ktype,
> +				   &indio_dev->dev.kobj, "buffer");
> +	if (ret)
> +		goto error_buffer_free_attrs;
>  
> -	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
> +	ret = iio_sysfs_add_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> +	if (ret)
> +		goto error_buffer_kobject_put;
>  
>  	attrcount = 0;
>  	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> @@ -1317,28 +1414,42 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  		}
>  	}
>  
> -	buffer->scan_el_group.name = iio_scan_elements_group_name;
> -
> -	buffer->scan_el_group.attrs = kcalloc(attrcount + 1,
> -					      sizeof(buffer->scan_el_group.attrs[0]),
> -					      GFP_KERNEL);
> -	if (buffer->scan_el_group.attrs == NULL) {
> +	buffer->scan_el_attrs = kcalloc(attrcount + 1,
> +					sizeof(buffer->scan_el_attrs[0]),
> +					GFP_KERNEL);
> +	if (buffer->scan_el_attrs == NULL) {
>  		ret = -ENOMEM;
>  		goto error_free_scan_mask;
>  	}
> -	attrn = 0;
>  
> +	ret = kobject_init_and_add(&buffer->scan_el_dir, &iio_scan_el_dir_ktype,
> +				   &indio_dev->dev.kobj, "scan_elements");
> +	if (ret)
> +		goto error_free_scan_attrs;
> +
> +	attrn = 0;
>  	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> -		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
> -	indio_dev->groups[indio_dev->groupcounter++] = &buffer->scan_el_group;
> +		buffer->scan_el_attrs[attrn++] = &p->dev_attr.attr;
> +
> +	ret = iio_sysfs_add_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
> +	if (ret)
> +		goto error_scan_kobject_put;
>  
>  	return 0;
>  
> +error_scan_kobject_put:
> +	kobject_put(&buffer->scan_el_dir);
> +error_free_scan_attrs:
> +	kfree(buffer->scan_el_attrs);
>  error_free_scan_mask:
>  	bitmap_free(buffer->scan_mask);
>  error_cleanup_dynamic:
> +	iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
>  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> -	kfree(buffer->buffer_group.attrs);
> +error_buffer_kobject_put:
> +	kobject_put(&buffer->buffer_dir);
> +error_buffer_free_attrs:
> +	kfree(buffer->buffer_attrs);
>  
>  	return ret;
>  }
> @@ -1366,10 +1477,14 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  
>  static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
>  {
> +	iio_sysfs_del_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
> +	kobject_put(&buffer->scan_el_dir);
> +	kfree(buffer->scan_el_attrs);
>  	bitmap_free(buffer->scan_mask);
> -	kfree(buffer->buffer_group.attrs);
> -	kfree(buffer->scan_el_group.attrs);
> +	iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
>  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> +	kobject_put(&buffer->buffer_dir);
> +	kfree(buffer->buffer_attrs);
>  }
>  
>  void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ca8b11541477..f389d8feacb0 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1819,18 +1819,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
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
> +		goto error_unreg_debugfs;
>  	}
>  	ret = iio_device_register_eventset(indio_dev);
>  	if (ret) {
> @@ -1859,14 +1852,21 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	if (ret < 0)
>  		goto error_unreg_eventset;
>  
> +	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);

There are some races around late creation of sysfs files (IIRC) but
I'm not sure what else could be done here.
Looking at device_add it is probably to do with the various notifiers being
called before we have put everything in place.

> +	if (ret) {
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to create buffer sysfs interfaces\n");
> +		goto error_device_del;
> +	}
> +
>  	return 0;
>  
> +error_device_del:
> +	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>  error_unreg_eventset:
>  	iio_device_unregister_eventset(indio_dev);
>  error_free_sysfs:
>  	iio_device_unregister_sysfs(indio_dev);
> -error_buffer_free_sysfs:
> -	iio_buffer_free_sysfs_and_mask(indio_dev);
>  error_unreg_debugfs:
>  	iio_device_unregister_debugfs(indio_dev);
>  	return ret;
> @@ -1882,6 +1882,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_ioctl_handler *h, *t;
>  
> +	iio_buffer_free_sysfs_and_mask(indio_dev);
> +
>  	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
>  
>  	mutex_lock(&indio_dev->info_exist_lock);
> @@ -1899,8 +1901,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  	iio_buffer_wakeup_poll(indio_dev);
>  
>  	mutex_unlock(&indio_dev->info_exist_lock);
> -
> -	iio_buffer_free_sysfs_and_mask(indio_dev);
>  }
>  EXPORT_SYMBOL(iio_device_unregister);
>  
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 67d73d465e02..77e169e51434 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -103,14 +103,20 @@ struct iio_buffer {
>  	/* @scan_el_dev_attr_list: List of scan element related attributes. */
>  	struct list_head scan_el_dev_attr_list;
>  
> -	/* @buffer_group: Attributes of the buffer group. */
> -	struct attribute_group buffer_group;
> +	/* @buffer_dir: kobject for the 'buffer' directory of this buffer */
> +	struct kobject buffer_dir;
> +
> +	/* @buffer_attrs: Attributes of the buffer group. */
> +	struct attribute **buffer_attrs;
> +
> +	/* @scan_el_dir: kobject for the 'scan_elements' directory of this buffer */
> +	struct kobject scan_el_dir;
>  
>  	/*
> -	 * @scan_el_group: Attribute group for those attributes not
> +	 * @scan_el_attrs: Array of attributes for those attributes not
>  	 * created from the iio_chan_info array.
>  	 */
> -	struct attribute_group scan_el_group;
> +	struct attribute **scan_el_attrs;
>  
>  	/* @attrs: Standard attributes of the buffer. */
>  	const struct attribute **attrs;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 9a3cf4815148..2ea185340a3a 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -556,7 +556,7 @@ struct iio_dev {
>  	struct mutex			info_exist_lock;
>  	const struct iio_buffer_setup_ops	*setup_ops;
>  	struct cdev			chrdev;
> -#define IIO_MAX_GROUPS 6
> +#define IIO_MAX_GROUPS 4
>  	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
>  	int				groupcounter;
>  

