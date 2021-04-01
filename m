Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382893510D5
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDAI1v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 1 Apr 2021 04:27:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2754 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhDAI1n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 04:27:43 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F9x4z3z7bz685kg;
        Thu,  1 Apr 2021 16:22:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 10:27:40 +0200
Received: from localhost (10.47.80.95) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 1 Apr 2021
 09:27:39 +0100
Date:   Thu, 1 Apr 2021 09:26:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH v6 14/24] iio: buffer: wrap all buffer attributes into
 iio_dev_attr
Message-ID: <20210401092618.00003912@Huawei.com>
In-Reply-To: <0d532b50-57aa-c8c2-e140-33cd07a63ce3@samsung.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
        <20210215104043.91251-15-alexandru.ardelean@analog.com>
        <CGME20210401073947eucas1p2c7f672475bce79dea00e9398cc562073@eucas1p2.samsung.com>
        <0d532b50-57aa-c8c2-e140-33cd07a63ce3@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.80.95]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Apr 2021 09:39:47 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Hi
> 
> On 15.02.2021 11:40, Alexandru Ardelean wrote:
> > This change wraps all buffer attributes into iio_dev_attr objects, and
> > assigns a reference to the IIO buffer they belong to.
> >
> > With the addition of multiple IIO buffers per one IIO device, we need a way
> > to know which IIO buffer is being enabled/disabled/controlled.
> >
> > We know that all buffer attributes are device_attributes. So we can wrap
> > them with a iio_dev_attr types. In the iio_dev_attr type, we can also hold
> > a reference to an IIO buffer.
> > So, we end up being able to allocate wrapped attributes for all buffer
> > attributes (even the one from other drivers).
> >
> > The neat part with this mechanism, is that we don't need to add any extra
> > cleanup, because these attributes are being added to a dynamic list that
> > will get cleaned up via iio_free_chan_devattr_list().
> >
> > With this change, the 'buffer->scan_el_dev_attr_list' list is being renamed
> > to 'buffer->buffer_attr_list', effectively merging (or finalizing the
> > merge) of the buffer/ & scan_elements/ attributes internally.
> >
> > Accessing these new buffer attributes can now be done via
> > 'to_iio_dev_attr(attr)->buffer' inside the show/store handlers.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> 
> This patch landed recently in linux-next as commit 15097c7a1adc ("iio: 
> buffer: wrap all buffer attributes into iio_dev_attr"). Sadly it causes 
> a regression and triggers the lock debuging warning:
> 
> ak8975 9-000c: mounting matrix not found: using identity...
> ak8975 9-000c: supply vdd not found, using dummy regulator
> ak8975 9-000c: supply vid not found, using dummy regulator
> BUG: key cf40d08c has not been registered!
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1 at kernel/locking/lockdep.c:4686 
> __kernfs_create_file+0x7c/0xfc
> DEBUG_LOCKS_WARN_ON(1)
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2-00153-g15097c7a1adc 
> #2828
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c011170c>] (unwind_backtrace) from [<c010cf74>] (show_stack+0x10/0x14)
> [<c010cf74>] (show_stack) from [<c0b48650>] (dump_stack+0xa4/0xc4)
> [<c0b48650>] (dump_stack) from [<c01274c8>] (__warn+0x118/0x11c)
> [<c01274c8>] (__warn) from [<c0127544>] (warn_slowpath_fmt+0x78/0xbc)
> [<c0127544>] (warn_slowpath_fmt) from [<c038db90>] 
> (__kernfs_create_file+0x7c/0xfc)
> [<c038db90>] (__kernfs_create_file) from [<c038e870>] 
> (sysfs_add_file_mode_ns+0xa0/0x1cc)
> [<c038e870>] (sysfs_add_file_mode_ns) from [<c038f4e0>] 
> (internal_create_group+0x138/0x3f4)
> [<c038f4e0>] (internal_create_group) from [<c038fd64>] 
> (internal_create_groups+0x48/0x88)
> [<c038fd64>] (internal_create_groups) from [<c06a8754>] 
> (device_add+0x2e4/0x7ec)
> [<c06a8754>] (device_add) from [<c02e46a0>] (cdev_device_add+0x48/0x80)
> [<c02e46a0>] (cdev_device_add) from [<c08db1a4>] 
> (__iio_device_register+0x670/0x7c0)
> [<c08db1a4>] (__iio_device_register) from [<c08e2efc>] 
> (ak8975_probe+0x3a4/0x584)
> [<c08e2efc>] (ak8975_probe) from [<c082e120>] (i2c_device_probe+0x234/0x2a4)
> [<c082e120>] (i2c_device_probe) from [<c06abea4>] (really_probe+0x1d4/0x4ec)
> [<c06abea4>] (really_probe) from [<c06ac234>] 
> (driver_probe_device+0x78/0x1d8)
> [<c06ac234>] (driver_probe_device) from [<c06ac74c>] 
> (device_driver_attach+0x58/0x60)
> [<c06ac74c>] (device_driver_attach) from [<c06ac850>] 
> (__driver_attach+0xfc/0x160)
> [<c06ac850>] (__driver_attach) from [<c06a9e58>] 
> (bus_for_each_dev+0x6c/0xb8)
> [<c06a9e58>] (bus_for_each_dev) from [<c06aaf90>] 
> (bus_add_driver+0x170/0x20c)
> [<c06aaf90>] (bus_add_driver) from [<c06ad6c8>] (driver_register+0x78/0x10c)
> [<c06ad6c8>] (driver_register) from [<c082f0d4>] 
> (i2c_register_driver+0x3c/0xac)
> [<c082f0d4>] (i2c_register_driver) from [<c0102434>] 
> (do_one_initcall+0x88/0x430)
> [<c0102434>] (do_one_initcall) from [<c11010d4>] 
> (kernel_init_freeable+0x190/0x1e0)
> [<c11010d4>] (kernel_init_freeable) from [<c0b4c564>] 
> (kernel_init+0x8/0x118)
> [<c0b4c564>] (kernel_init) from [<c010011c>] (ret_from_fork+0x14/0x38)
> Exception stack(0xc1d09fb0 to 0xc1d09ff8)
> 9fa0:                                     00000000 00000000 00000000 
> 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> irq event stamp: 485619
> hardirqs last  enabled at (485619): [<c01a51fc>] console_unlock+0x500/0x648
> hardirqs last disabled at (485618): [<c01a51e0>] console_unlock+0x4e4/0x648
> softirqs last  enabled at (484774): [<c0101790>] __do_softirq+0x528/0x63c
> softirqs last disabled at (484769): [<c0130a38>] irq_exit+0x1f4/0x1fc
> ---[ end trace 21850020cbfb3350 ]---
> 
> The above warning is probably caused by copying struct device_attribute 
> objects in iio_buffer_wrap_attr() without re-initializing 
> spinlocks/mutexes. Locks debuging depends on the spinlock/mutex 
> initializers, which register them (as absolute value of the pointer to 
> them) to the debugging engine. After copying the structures, the objects 
> don't match the pointers they were registered. I didn't have time to 
> analyze it further and find which object/lock is triggering this though.

Thanks, interestingly there aren't any spinlocks or mutexes in attributes,
but there are lock_class_keys. Looks like we need to call sysfs_attr_init()
and I guess we are currently missing it on this path.

Alex, can you take a look?  If not I'll get to it sometime over the weekend
most likely.

Jonathan


> 
> > ---
> >   drivers/iio/industrialio-buffer.c | 76 ++++++++++++++++++++-----------
> >   include/linux/iio/buffer_impl.h   |  4 +-
> >   2 files changed, 52 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index e6edec3bcb73..8dc140f13b99 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -253,8 +253,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
> >   				char *buf)
> >   {
> >   	int ret;
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   
> >   	/* Ensure ret is 0 or 1. */
> >   	ret = !!test_bit(to_iio_dev_attr(attr)->address,
> > @@ -367,8 +366,8 @@ static ssize_t iio_scan_el_store(struct device *dev,
> >   	int ret;
> >   	bool state;
> >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> >   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> > +	struct iio_buffer *buffer = this_attr->buffer;
> >   
> >   	ret = strtobool(buf, &state);
> >   	if (ret < 0)
> > @@ -402,8 +401,7 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
> >   				   struct device_attribute *attr,
> >   				   char *buf)
> >   {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   
> >   	return sprintf(buf, "%d\n", buffer->scan_timestamp);
> >   }
> > @@ -415,7 +413,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
> >   {
> >   	int ret;
> >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   	bool state;
> >   
> >   	ret = strtobool(buf, &state);
> > @@ -448,7 +446,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >   				     IIO_SEPARATE,
> >   				     &indio_dev->dev,
> >   				     buffer,
> > -				     &buffer->scan_el_dev_attr_list);
> > +				     &buffer->buffer_attr_list);
> >   	if (ret)
> >   		return ret;
> >   	attrcount++;
> > @@ -460,7 +458,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >   				     0,
> >   				     &indio_dev->dev,
> >   				     buffer,
> > -				     &buffer->scan_el_dev_attr_list);
> > +				     &buffer->buffer_attr_list);
> >   	if (ret)
> >   		return ret;
> >   	attrcount++;
> > @@ -473,7 +471,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >   					     0,
> >   					     &indio_dev->dev,
> >   					     buffer,
> > -					     &buffer->scan_el_dev_attr_list);
> > +					     &buffer->buffer_attr_list);
> >   	else
> >   		ret = __iio_add_chan_devattr("en",
> >   					     chan,
> > @@ -483,7 +481,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> >   					     0,
> >   					     &indio_dev->dev,
> >   					     buffer,
> > -					     &buffer->scan_el_dev_attr_list);
> > +					     &buffer->buffer_attr_list);
> >   	if (ret)
> >   		return ret;
> >   	attrcount++;
> > @@ -495,8 +493,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
> >   				      struct device_attribute *attr,
> >   				      char *buf)
> >   {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   
> >   	return sprintf(buf, "%d\n", buffer->length);
> >   }
> > @@ -506,7 +503,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
> >   				       const char *buf, size_t len)
> >   {
> >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   	unsigned int val;
> >   	int ret;
> >   
> > @@ -538,8 +535,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
> >   				      struct device_attribute *attr,
> >   				      char *buf)
> >   {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   
> >   	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
> >   }
> > @@ -1154,7 +1150,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
> >   	int ret;
> >   	bool requested_state;
> >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   	bool inlist;
> >   
> >   	ret = strtobool(buf, &requested_state);
> > @@ -1183,8 +1179,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
> >   					 struct device_attribute *attr,
> >   					 char *buf)
> >   {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   
> >   	return sprintf(buf, "%u\n", buffer->watermark);
> >   }
> > @@ -1195,7 +1190,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
> >   					  size_t len)
> >   {
> >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   	unsigned int val;
> >   	int ret;
> >   
> > @@ -1228,8 +1223,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
> >   						struct device_attribute *attr,
> >   						char *buf)
> >   {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > -	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> >   
> >   	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
> >   }
> > @@ -1254,6 +1248,26 @@ static struct attribute *iio_buffer_attrs[] = {
> >   	&dev_attr_data_available.attr,
> >   };
> >   
> > +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> > +
> > +static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
> > +					      struct attribute *attr)
> > +{
> > +	struct device_attribute *dattr = to_dev_attr(attr);
> > +	struct iio_dev_attr *iio_attr;
> > +
> > +	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> > +	if (!iio_attr)
> > +		return NULL;
> > +
> > +	iio_attr->buffer = buffer;
> > +	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
> > +
> > +	list_add(&iio_attr->l, &buffer->buffer_attr_list);
> > +
> > +	return &iio_attr->dev_attr.attr;
> > +}
> > +
> >   static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
> >   						   struct attribute **buffer_attrs,
> >   						   int buffer_attrcount,
> > @@ -1329,7 +1343,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >   	}
> >   
> >   	scan_el_attrcount = 0;
> > -	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> > +	INIT_LIST_HEAD(&buffer->buffer_attr_list);
> >   	channels = indio_dev->channels;
> >   	if (channels) {
> >   		/* new magic */
> > @@ -1376,9 +1390,19 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >   
> >   	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
> >   
> > -	attrn = buffer_attrcount;
> > +	for (i = 0; i < buffer_attrcount; i++) {
> > +		struct attribute *wrapped;
> > +
> > +		wrapped = iio_buffer_wrap_attr(buffer, attr[i]);
> > +		if (!wrapped) {
> > +			ret = -ENOMEM;
> > +			goto error_free_scan_mask;
> > +		}
> > +		attr[i] = wrapped;
> > +	}
> >   
> > -	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> > +	attrn = 0;
> > +	list_for_each_entry(p, &buffer->buffer_attr_list, l)
> >   		attr[attrn++] = &p->dev_attr.attr;
> >   
> >   	buffer->buffer_group.name = kasprintf(GFP_KERNEL, "buffer%d", index);
> > @@ -1412,7 +1436,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >   error_free_scan_mask:
> >   	bitmap_free(buffer->scan_mask);
> >   error_cleanup_dynamic:
> > -	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > +	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
> >   
> >   	return ret;
> >   }
> > @@ -1443,7 +1467,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> >   	bitmap_free(buffer->scan_mask);
> >   	kfree(buffer->buffer_group.name);
> >   	kfree(buffer->buffer_group.attrs);
> > -	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > +	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
> >   }
> >   
> >   void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> > index 3e555e58475b..41044320e581 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -97,8 +97,8 @@ struct iio_buffer {
> >   	/* @scan_timestamp: Does the scan mode include a timestamp. */
> >   	bool scan_timestamp;
> >   
> > -	/* @scan_el_dev_attr_list: List of scan element related attributes. */
> > -	struct list_head scan_el_dev_attr_list;
> > +	/* @buffer_attr_list: List of buffer attributes. */
> > +	struct list_head buffer_attr_list;
> >   
> >   	/*
> >   	 * @buffer_group: Attributes of the new buffer group.  
> 
> Best regards

