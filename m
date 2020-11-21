Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908752BC16F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKUSeD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:34:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgKUSeD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 13:34:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DF3221FE;
        Sat, 21 Nov 2020 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605983641;
        bh=HijR34Fv9UplDCzw3ex7MhAHQhixu2LpWMdZ97U3b0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZXnXHQauzW5BGMydy1dTiY86gehC9dyJpW7O/16pkgQd5ClL3GdgvtyGhXxPN7c/U
         SHU/SgZ2TPIeu/8Gr5wQkq/K3UnGlapYeFspBbWytPsf048LHnRI+3JwwOMBVJ2Z8S
         JCHIwiQb6s6PA3zLm5MyxYl2KmLiLKpHJXyR6id4=
Date:   Sat, 21 Nov 2020 18:33:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 06/12] iio: buffer: re-route scan_elements via it's
 kobj_type
Message-ID: <20201121183357.254682d5@archlinux>
In-Reply-To: <20201117162340.43924-7-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
        <20201117162340.43924-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 18:23:34 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The scan_elements attributes are solely located inside
> 'industrialio-buffer-sysfs.c'. In order to support more than one buffer per
> IIO device, we need to expand scan_elements attributes directly to IIO
> buffer object, and not the IIO device.
> 
> This also requires that a new 'iio_buffer_attr' type be added which is
> mostly a copy of 'iio_dev_attr', but this expands to an IIO buffer object.
> 
> The 'iio_dev_attr' type could have been re-used here, but managing 'device'
> objects is a bit more tricky (than it looks at first). A 'device' object
> needs to be initialized & managed and we only need to the 'kobj' to expand
> from the 'bufferX' directory back to an IIO buffer.
> kobjects are simpler to manage.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
One trivial thing inline but otherwise looks fine to me.

Jonathan

> ---
>  drivers/iio/iio_core.h            |   5 +
>  drivers/iio/industrialio-buffer.c | 162 +++++++++++++++++++++++-------
>  drivers/iio/industrialio-core.c   |   1 -
>  3 files changed, 129 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index fced02cadcc3..43d44ec92781 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -31,6 +31,11 @@ void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
>  				       struct iio_ioctl_handler *h);
>  void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
>  
> +int iio_attr_init(struct attribute *attr,
> +		  const char *postfix,
> +		  struct iio_chan_spec const *chan,
> +		  enum iio_shared_by shared_by);
> +
>  int __iio_add_chan_devattr(const char *postfix,
>  			   struct iio_chan_spec const *chan,
>  			   ssize_t (*func)(struct device *dev,
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 62c8bd6b67cd..445709ef245c 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -26,6 +26,26 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>
>  
> +/**
> + * struct iio_buf_attr - iio buffer specific attribute
> + * @attr:	underlying attribute
> + * @address:	associated register address
> + * @l:		list head for maintaining list of dynamically created attrs
> + * @c:		specification for the underlying channel
> + * @show:	sysfs show hook for this attribute
> + * @store:	sysfs store hook for this attribute
> + */
> +struct iio_buf_attr {
> +	struct attribute attr;
> +	u64 address;
> +	struct list_head l;
> +	struct iio_chan_spec const *c;
> +	ssize_t (*show)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
> +			char *buf);
> +	ssize_t (*store)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
> +			 const char *buf, size_t count);
> +};
> +
>  static const char * const iio_endian_prefix[] = {
>  	[IIO_BE] = "be",
>  	[IIO_LE] = "le",
> @@ -210,18 +230,17 @@ void iio_buffer_init(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL(iio_buffer_init);
>  
> -static ssize_t iio_show_scan_index(struct device *dev,
> -				   struct device_attribute *attr,
> +static ssize_t iio_show_scan_index(struct iio_buffer *buffer,
> +				   struct iio_buf_attr *attr,
>  				   char *buf)
>  {
> -	return sprintf(buf, "%u\n", to_iio_dev_attr(attr)->c->scan_index);
> +	return sprintf(buf, "%u\n", attr->c->scan_index);
>  }
>  
> -static ssize_t iio_show_fixed_type(struct device *dev,
> -				   struct device_attribute *attr,
> +static ssize_t iio_show_fixed_type(struct iio_buffer *buffer,
> +				   struct iio_buf_attr *this_attr,
>  				   char *buf)
>  {
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	u8 type = this_attr->c->scan_type.endianness;
>  
>  	if (type == IIO_CPU) {
> @@ -248,17 +267,14 @@ static ssize_t iio_show_fixed_type(struct device *dev,
>  		       this_attr->c->scan_type.shift);
>  }
>  
> -static ssize_t iio_scan_el_show(struct device *dev,
> -				struct device_attribute *attr,
> +static ssize_t iio_scan_el_show(struct iio_buffer *buffer,
> +				struct iio_buf_attr *attr,
>  				char *buf)
>  {
>  	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  
>  	/* Ensure ret is 0 or 1. */
> -	ret = !!test_bit(to_iio_dev_attr(attr)->address,
> -		       buffer->scan_mask);
> +	ret = !!test_bit(attr->address, buffer->scan_mask);
>  
>  	return sprintf(buf, "%d\n", ret);
>  }
> @@ -359,16 +375,14 @@ static int iio_scan_mask_query(struct iio_dev *indio_dev,
>  	return !!test_bit(bit, buffer->scan_mask);
>  };
>  
> -static ssize_t iio_scan_el_store(struct device *dev,
> -				 struct device_attribute *attr,
> +static ssize_t iio_scan_el_store(struct iio_buffer *buffer,
> +				 struct iio_buf_attr *this_attr,
>  				 const char *buf,
>  				 size_t len)
>  {
> +	struct iio_dev *indio_dev = buffer->indio_dev;
>  	int ret;
>  	bool state;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = strtobool(buf, &state);
>  	if (ret < 0)
> @@ -398,24 +412,20 @@ static ssize_t iio_scan_el_store(struct device *dev,
>  
>  }
>  
> -static ssize_t iio_scan_el_ts_show(struct device *dev,
> -				   struct device_attribute *attr,
> +static ssize_t iio_scan_el_ts_show(struct iio_buffer *buffer,
> +				   struct iio_buf_attr *attr,
>  				   char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> -
>  	return sprintf(buf, "%d\n", buffer->scan_timestamp);
>  }
>  
> -static ssize_t iio_scan_el_ts_store(struct device *dev,
> -				    struct device_attribute *attr,
> +static ssize_t iio_scan_el_ts_store(struct iio_buffer *buffer,
> +				    struct iio_buf_attr *attr,
>  				    const char *buf,
>  				    size_t len)
>  {
> +	struct iio_dev *indio_dev = buffer->indio_dev;
>  	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
>  	bool state;
>  
>  	ret = strtobool(buf, &state);
> @@ -434,13 +444,88 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> +static int __iio_add_chan_bufattr(const char *postfix,
> +				  struct iio_chan_spec const *chan,
> +				  ssize_t (*readfunc)(struct iio_buffer *buffer,
> +						      struct iio_buf_attr *attr,
> +						      char *buf),
> +				  ssize_t (*writefunc)(struct iio_buffer *buffer,
> +						       struct iio_buf_attr *attr,
> +						       const char *buf,
> +						       size_t len),
> +				  u64 mask,
> +				  enum iio_shared_by shared_by,
> +				  struct device *dev,
> +				  struct list_head *attr_list)
> +{
> +	struct iio_buf_attr *iio_attr, *t;
> +	int ret;
> +
> +	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> +	if (iio_attr == NULL)
> +		return -ENOMEM;
> +
> +	ret = iio_attr_init(&iio_attr->attr, postfix, chan, shared_by);
> +	if (ret)
> +		goto error_iio_buf_attr_free;
> +
> +	iio_attr->c = chan;
> +	iio_attr->address = mask;
> +	list_for_each_entry(t, attr_list, l) {
> +		if (strcmp(t->attr.name, iio_attr->attr.name) == 0) {
> +			if (shared_by == IIO_SEPARATE)
> +				dev_err(dev, "tried to double register : %s\n",
> +					t->attr.name);
> +			ret = -EBUSY;
> +			goto error_iio_buf_attr_deinit;
> +		}
> +	}
> +	list_add(&iio_attr->l, attr_list);
> +
> +	if (readfunc) {
> +		iio_attr->attr.mode |= S_IRUGO;
> +		iio_attr->show = readfunc;
> +	}
> +
> +	if (writefunc) {
> +		iio_attr->attr.mode |= S_IWUSR;
> +		iio_attr->store = writefunc;
> +	}
> +
> +	return 0;
> +
> +error_iio_buf_attr_deinit:
> +	kfree(iio_attr->attr.name);
> +error_iio_buf_attr_free:
> +	kfree(iio_attr);
> +	return ret;
> +}
> +
> +/**
> + * iio_free_chan_bufattr_list() - Free a list of IIO buffer attributes
> + * @attr_list: List of IIO buffer attributes
> + *
> + * This function frees the memory allocated for each of the IIO buffer
> + * attributes in the list.
> + */
> +static void iio_free_chan_bufattr_list(struct list_head *attr_list)
> +{
> +	struct iio_buf_attr *p, *n;
> +
> +	list_for_each_entry_safe(p, n, attr_list, l) {
> +		kfree(p->attr.name);

Trivial but ordering in here seems a bit odd.  Take it off
list before doing the name free makes more sense to me.

> +		list_del(&p->l);
> +		kfree(p);
> +	}
> +}
> +
>  static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  					struct iio_buffer *buffer,
>  					const struct iio_chan_spec *chan)
>  {
>  	int ret, attrcount = 0;
>  
> -	ret = __iio_add_chan_devattr("index",
> +	ret = __iio_add_chan_bufattr("index",
>  				     chan,
>  				     &iio_show_scan_index,
>  				     NULL,
> @@ -451,7 +536,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  	attrcount++;
> -	ret = __iio_add_chan_devattr("type",
> +	ret = __iio_add_chan_bufattr("type",
>  				     chan,
>  				     &iio_show_fixed_type,
>  				     NULL,
> @@ -463,7 +548,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  		return ret;
>  	attrcount++;
>  	if (chan->type != IIO_TIMESTAMP)
> -		ret = __iio_add_chan_devattr("en",
> +		ret = __iio_add_chan_bufattr("en",
>  					     chan,
>  					     &iio_scan_el_show,
>  					     &iio_scan_el_store,
> @@ -472,7 +557,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  					     &indio_dev->dev,
>  					     &buffer->scan_el_dev_attr_list);
>  	else
> -		ret = __iio_add_chan_devattr("en",
> +		ret = __iio_add_chan_bufattr("en",
>  					     chan,
>  					     &iio_scan_el_ts_show,
>  					     &iio_scan_el_ts_store,
> @@ -1251,6 +1336,7 @@ static struct attribute *iio_buffer_attrs[] = {
>  };
>  
>  #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> +#define to_iio_buf_attr(_attr) container_of(_attr, struct iio_buf_attr, attr)
>  
>  static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
>  					struct attribute *attr,
> @@ -1291,9 +1377,9 @@ static ssize_t iio_scan_el_dir_attr_show(struct kobject *kobj,
>  					 char *buf)
>  {
>  	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> -	struct device_attribute *dattr = to_dev_attr(attr);
> +	struct iio_buf_attr *battr = to_iio_buf_attr(attr);
>  
> -	return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> +	return battr->show(buffer, battr, buf);
>  }
>  
>  static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
> @@ -1302,9 +1388,9 @@ static ssize_t iio_scan_el_dir_attr_store(struct kobject *kobj,
>  					  size_t len)
>  {
>  	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, scan_el_dir);
> -	struct device_attribute *dattr = to_dev_attr(attr);
> +	struct iio_buf_attr *battr = to_iio_buf_attr(attr);
>  
> -	return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
> +	return battr->store(buffer, battr, buf, len);
>  }
>  
>  static const struct sysfs_ops iio_scan_el_dir_sysfs_ops = {
> @@ -1349,7 +1435,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  					     struct iio_dev *indio_dev,
>  					     unsigned int idx)
>  {
> -	struct iio_dev_attr *p;
> +	struct iio_buf_attr *p;
>  	struct attribute **attr;
>  	int ret, i, attrn, attrcount;
>  	const struct iio_chan_spec *channels;
> @@ -1430,7 +1516,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  
>  	attrn = 0;
>  	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> -		buffer->scan_el_attrs[attrn++] = &p->dev_attr.attr;
> +		buffer->scan_el_attrs[attrn++] = &p->attr;
>  
>  	ret = iio_sysfs_add_attrs(&buffer->scan_el_dir, buffer->scan_el_attrs);
>  	if (ret)
> @@ -1446,7 +1532,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  	bitmap_free(buffer->scan_mask);
>  error_cleanup_dynamic:
>  	iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> -	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> +	iio_free_chan_bufattr_list(&buffer->scan_el_dev_attr_list);
>  error_buffer_kobject_put:
>  	kobject_put(&buffer->buffer_dir);
>  error_buffer_free_attrs:
> @@ -1507,7 +1593,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
>  	kfree(buffer->scan_el_attrs);
>  	bitmap_free(buffer->scan_mask);
>  	iio_sysfs_del_attrs(&buffer->buffer_dir, buffer->buffer_attrs);
> -	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> +	iio_free_chan_bufattr_list(&buffer->scan_el_dev_attr_list);
>  	kobject_put(&buffer->buffer_dir);
>  	kfree(buffer->buffer_attrs);
>  }
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e9aa84f5b05a..28830e87e8cb 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -972,7 +972,6 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  	return len;
>  }
>  
> -static
>  int iio_attr_init(struct attribute *attr,
>  		  const char *postfix,
>  		  struct iio_chan_spec const *chan,

