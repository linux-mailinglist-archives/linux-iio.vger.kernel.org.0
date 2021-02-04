Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3938930F9D9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 18:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhBDRfY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 12:35:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2499 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhBDRdo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 12:33:44 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWlsh2lJTz67k33;
        Fri,  5 Feb 2021 01:29:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 18:33:00 +0100
Received: from localhost (10.47.65.115) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 17:32:59 +0000
Date:   Thu, 4 Feb 2021 17:32:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 04/11] iio: core: rework iio device group creation
Message-ID: <20210204173214.00000fb9@Huawei.com>
In-Reply-To: <20210201145105.20459-5-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
        <20210201145105.20459-5-alexandru.ardelean@analog.com>
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

On Mon, 1 Feb 2021 16:50:58 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Up until now, the device groups that an IIO device had were limited to 6.
> Two of these groups would account for buffer attributes (the buffer/ and
> scan_elements/ directories).
> 
> Since we want to add multiple buffers per IIO device, this number may not
> be enough, when adding a second buffer. So, this change reallocates the
> groups array whenever an IIO device group is added, via a
> iio_device_register_sysfs_group() helper.
> 
> This also means that the groups array should be assigned to
> 'indio_dev.dev.groups' really late, right before {cdev_}device_add() is
> called to do the entire setup.
> And we also must take care to free this array when the sysfs resources are
> being cleaned up.
> 
> With this change we can also move the 'groups' & 'groupcounter' fields to
> the iio_dev_opaque object. Up until now, this didn't make a whole lot of
> sense (especially since we weren't sure how multibuffer support would look
> like in the end).
> But doing it now kills one birds with one stone.
> 
> An alternative, would be to add a configurable Kconfig symbol
> CONFIG_IIO_MAX_BUFFERS_PER_DEVICE (or something like that) and compute a
> static maximum of the groups we can support per IIO device. But that would
> probably annoy a few people since that would make the system less
> configurable.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Nice change irrespective of the rest of the series needing it.

Few comments below.

Jonathan

> ---
>  drivers/iio/iio_core.h             |  3 +++
>  drivers/iio/industrialio-buffer.c  | 12 +++++++++--
>  drivers/iio/industrialio-core.c    | 32 +++++++++++++++++++++++++++---
>  drivers/iio/industrialio-event.c   |  5 ++++-
>  drivers/iio/industrialio-trigger.c |  6 ++----
>  include/linux/iio/iio-opaque.h     |  4 ++++
>  include/linux/iio/iio.h            |  5 -----
>  7 files changed, 52 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index fced02cadcc3..7d5b179c1fe7 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -46,6 +46,9 @@ int __iio_add_chan_devattr(const char *postfix,
>  			   struct list_head *attr_list);
>  void iio_free_chan_devattr_list(struct list_head *attr_list);
>  
> +int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
> +				    const struct attribute_group *group);
> +
>  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
>  
>  /* Event interface flags */
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2f7426a2f47c..cc846988fdb9 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1287,7 +1287,9 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  	buffer->buffer_group.name = "buffer";
>  	buffer->buffer_group.attrs = attr;
>  
> -	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
> +	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
> +	if (ret)
> +		goto error_free_buffer_attrs;
>  
>  	attrcount = 0;
>  	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> @@ -1330,14 +1332,20 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  
>  	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
>  		buffer->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
> -	indio_dev->groups[indio_dev->groupcounter++] = &buffer->scan_el_group;
> +
> +	ret = iio_device_register_sysfs_group(indio_dev, &buffer->scan_el_group);
> +	if (ret)
> +		goto error_free_scan_el_attrs;
>  
>  	return 0;
>  
> +error_free_scan_el_attrs:
> +	kfree(buffer->scan_el_group.attrs);
>  error_free_scan_mask:
>  	bitmap_free(buffer->scan_mask);
>  error_cleanup_dynamic:
>  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> +error_free_buffer_attrs:
>  	kfree(buffer->buffer_group.attrs);
>  
>  	return ret;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0a6fd299a978..ccd7aaff6d13 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1452,6 +1452,25 @@ static ssize_t iio_store_timestamp_clock(struct device *dev,
>  	return len;
>  }
>  
> +int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
> +				    const struct attribute_group *group)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	const struct attribute_group **new, **old = iio_dev_opaque->groups;
> +	unsigned int cnt = iio_dev_opaque->groupcounter;
> +
> +	new = krealloc(old, sizeof(*new) * (cnt + 2), GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	new[iio_dev_opaque->groupcounter++] = group;
> +	new[iio_dev_opaque->groupcounter] = NULL;
> +
> +	iio_dev_opaque->groups = new;
> +
> +	return 0;
> +}
> +
>  static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
>  		   iio_show_timestamp_clock, iio_store_timestamp_clock);
>  
> @@ -1525,8 +1544,10 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  	if (clk)
>  		iio_dev_opaque->chan_attr_group.attrs[attrn++] = clk;
>  
> -	indio_dev->groups[indio_dev->groupcounter++] =
> -		&iio_dev_opaque->chan_attr_group;
> +	ret = iio_device_register_sysfs_group(indio_dev,
> +					      &iio_dev_opaque->chan_attr_group);
> +	if (ret)
> +		goto error_clear_attrs;
>  
>  	return 0;
>  
> @@ -1543,6 +1564,9 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
>  	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
>  	kfree(iio_dev_opaque->chan_attr_group.attrs);
>  	iio_dev_opaque->chan_attr_group.attrs = NULL;
> +	kfree(iio_dev_opaque->groups);
> +	iio_dev_opaque->groups = NULL;
I can see you are matching style above, but right now I can't see why
we set chan_attr_group.attrs = NULL 
or this new case.

> +	iio_dev_opaque->groupcounter = 0;

or indeed groupcounter.

>  }
>  
>  static void iio_dev_release(struct device *device)
> @@ -1592,7 +1616,6 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  		ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
>  
>  	dev->dev.parent = parent;
> -	dev->dev.groups = dev->groups;

Hohum. Nothing to do with this patch but not sure why the iio_dev is called dev here...
I (or someone else) should fix that at somepoint after this is in place as it confused me.


>  	dev->dev.type = &iio_device_type;
>  	dev->dev.bus = &iio_bus_type;
>  	device_initialize(&dev->dev);
> @@ -1853,6 +1876,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  		indio_dev->chrdev.owner = this_mod;
>  	}
>  
> +	/* assign device groups now; they should be all registered now */
> +	indio_dev->dev.groups = iio_dev_opaque->groups;
> +
>  	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
>  	if (ret < 0)
>  		goto error_unreg_eventset;
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 7e532117ac55..ea8947cc21e4 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -544,7 +544,10 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  	/* Add all elements from the list. */
>  	list_for_each_entry(p, &ev_int->dev_attr_list, l)
>  		ev_int->group.attrs[attrn++] = &p->dev_attr.attr;
> -	indio_dev->groups[indio_dev->groupcounter++] = &ev_int->group;
> +
> +	ret = iio_device_register_sysfs_group(indio_dev, &ev_int->group);
> +	if (ret)
> +		goto error_free_setup_event_lines;
>  
>  	ev_int->ioctl_handler.ioctl = iio_event_ioctl;
>  	iio_device_ioctl_handler_register(&iio_dev_opaque->indio_dev,
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 438d5012e8b8..a035d5c2a445 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -694,10 +694,8 @@ EXPORT_SYMBOL(iio_trigger_validate_own_device);
>  
>  int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
>  {
> -	indio_dev->groups[indio_dev->groupcounter++] =
> -		&iio_trigger_consumer_attr_group;
> -
> -	return 0;
> +	return iio_device_register_sysfs_group(indio_dev,
> +					       &iio_trigger_consumer_attr_group);
>  }
>  
>  void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 07c5a8e52ca8..8ba13a5c7af6 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -12,6 +12,8 @@
>   *				attributes
>   * @chan_attr_group:		group for all attrs in base directory
>   * @ioctl_handlers:		ioctl handlers registered with the core handler
> + * @groups:			attribute groups
> + * @groupcounter:		index of next attribute group
>   * @debugfs_dentry:		device specific debugfs dentry
>   * @cached_reg_addr:		cached register address for debugfs reads
>   * @read_buf:			read buffer to be used for the initial reg read
> @@ -24,6 +26,8 @@ struct iio_dev_opaque {
>  	struct list_head		channel_attr_list;
>  	struct attribute_group		chan_attr_group;
>  	struct list_head		ioctl_handlers;
> +	const struct attribute_group	**groups;
> +	int				groupcounter;
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry			*debugfs_dentry;
>  	unsigned			cached_reg_addr;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index e4a9822e6495..f8585d01fc76 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -518,8 +518,6 @@ struct iio_buffer_setup_ops {
>   * @setup_ops:		[DRIVER] callbacks to call before and after buffer
>   *			enable/disable
>   * @chrdev:		[INTERN] associated character device
> - * @groups:		[INTERN] attribute groups
> - * @groupcounter:	[INTERN] index of next attribute group
>   * @flags:		[INTERN] file ops related flags including busy flag.
>   * @priv:		[DRIVER] reference to driver's private information
>   *			**MUST** be accessed **ONLY** via iio_priv() helper
> @@ -556,9 +554,6 @@ struct iio_dev {
>  	struct mutex			info_exist_lock;
>  	const struct iio_buffer_setup_ops	*setup_ops;
>  	struct cdev			chrdev;
> -#define IIO_MAX_GROUPS 6
> -	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
> -	int				groupcounter;
>  
>  	unsigned long			flags;
>  	void				*priv;

