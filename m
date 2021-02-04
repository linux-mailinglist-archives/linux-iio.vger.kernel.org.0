Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8680030FAF7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 19:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhBDSMb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 13:12:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2501 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbhBDSKz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 13:10:55 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DWmdR52nBz67ktp;
        Fri,  5 Feb 2021 02:03:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 19:10:13 +0100
Received: from localhost (10.47.65.115) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 18:10:12 +0000
Date:   Thu, 4 Feb 2021 18:09:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 07/11] iio: add reference to iio buffer on
 iio_dev_attr
Message-ID: <20210204180926.00005e4c@Huawei.com>
In-Reply-To: <20210201145105.20459-8-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
        <20210201145105.20459-8-alexandru.ardelean@analog.com>
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

On Mon, 1 Feb 2021 16:51:01 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds a reference to a 'struct iio_buffer' object on the
> iio_dev_attr object. This way, we can use the created iio_dev_attr objects
> on per-buffer basis (since they're allocated anyway).
> 
> A minor downside of this change is that the number of parameters on
> __iio_add_chan_devattr() grows by 1. This looks like it could do with a bit
> of a re-think.

Could use a bit of macro magic or static inline to keep the old
version set of parameter and have __iio_add_chan_devattr_with_buf 
or similar.  I'm not sure I'd bother given we don't have that many callers.

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/iio_core.h            | 2 ++
>  drivers/iio/industrialio-buffer.c | 4 ++++
>  drivers/iio/industrialio-core.c   | 6 ++++++
>  drivers/iio/industrialio-event.c  | 1 +
>  include/linux/iio/sysfs.h         | 3 +++
>  5 files changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 7d5b179c1fe7..731f5170d5b9 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  
> +struct iio_buffer;
>  struct iio_chan_spec;
>  struct iio_dev;
>  
> @@ -43,6 +44,7 @@ int __iio_add_chan_devattr(const char *postfix,
>  			   u64 mask,
>  			   enum iio_shared_by shared_by,
>  			   struct device *dev,
> +			   struct iio_buffer *buffer,
>  			   struct list_head *attr_list);
>  void iio_free_chan_devattr_list(struct list_head *attr_list);
>  
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index f82decf92b7c..a525e88b302f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c

> @@ -447,6 +447,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  				     0,
>  				     IIO_SEPARATE,
>  				     &indio_dev->dev,
> +				     buffer,
>  				     &buffer->scan_el_dev_attr_list);
>  	if (ret)
>  		return ret;
> @@ -458,6 +459,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  				     0,
>  				     0,
>  				     &indio_dev->dev,
> +				     buffer,
>  				     &buffer->scan_el_dev_attr_list);
>  	if (ret)
>  		return ret;
> @@ -470,6 +472,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  					     chan->scan_index,
>  					     0,
>  					     &indio_dev->dev,
> +					     buffer,
>  					     &buffer->scan_el_dev_attr_list);
>  	else
>  		ret = __iio_add_chan_devattr("en",
> @@ -479,6 +482,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  					     chan->scan_index,
>  					     0,
>  					     &indio_dev->dev,
> +					     buffer,
>  					     &buffer->scan_el_dev_attr_list);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ccd7aaff6d13..c68130885d83 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1114,6 +1114,7 @@ int __iio_add_chan_devattr(const char *postfix,
>  			   u64 mask,
>  			   enum iio_shared_by shared_by,
>  			   struct device *dev,
> +			   struct iio_buffer *buffer,
>  			   struct list_head *attr_list)
>  {
>  	int ret;
> @@ -1129,6 +1130,7 @@ int __iio_add_chan_devattr(const char *postfix,
>  		goto error_iio_dev_attr_free;
>  	iio_attr->c = chan;
>  	iio_attr->address = mask;
> +	iio_attr->buffer = buffer;
>  	list_for_each_entry(t, attr_list, l)
>  		if (strcmp(t->dev_attr.attr.name,
>  			   iio_attr->dev_attr.attr.name) == 0) {
> @@ -1165,6 +1167,7 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
>  				     0,
>  				     IIO_SEPARATE,
>  				     &indio_dev->dev,
> +				     NULL,
>  				     &iio_dev_opaque->channel_attr_list);
>  	if (ret < 0)
>  		return ret;
> @@ -1190,6 +1193,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
>  					     i,
>  					     shared_by,
>  					     &indio_dev->dev,
> +					     NULL,
>  					     &iio_dev_opaque->channel_attr_list);
>  		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
>  			continue;
> @@ -1226,6 +1230,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
>  					     i,
>  					     shared_by,
>  					     &indio_dev->dev,
> +					     NULL,
>  					     &iio_dev_opaque->channel_attr_list);
>  		kfree(avail_postfix);
>  		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
> @@ -1322,6 +1327,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  					i,
>  					ext_info->shared,
>  					&indio_dev->dev,
> +					NULL,
>  					&iio_dev_opaque->channel_attr_list);
>  			i++;
>  			if (ret == -EBUSY && ext_info->shared)
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index ea8947cc21e4..a30e289fc362 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -385,6 +385,7 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>  
>  		ret = __iio_add_chan_devattr(postfix, chan, show, store,
>  			 (i << 16) | spec_index, shared_by, &indio_dev->dev,
> +			 NULL,
>  			&iio_dev_opaque->event_interface->dev_attr_list);
>  		kfree(postfix);
>  
> diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> index b532c875bc24..e51fba66de4b 100644
> --- a/include/linux/iio/sysfs.h
> +++ b/include/linux/iio/sysfs.h
> @@ -9,6 +9,7 @@
>  #ifndef _INDUSTRIAL_IO_SYSFS_H_
>  #define _INDUSTRIAL_IO_SYSFS_H_
>  
> +struct iio_buffer;
>  struct iio_chan_spec;
>  
>  /**
> @@ -17,12 +18,14 @@ struct iio_chan_spec;
>   * @address:	associated register address
>   * @l:		list head for maintaining list of dynamically created attrs
>   * @c:		specification for the underlying channel
> + * @buffer:	the IIO buffer to which this attribute belongs to (if any)
>   */
>  struct iio_dev_attr {
>  	struct device_attribute dev_attr;
>  	u64 address;
>  	struct list_head l;
>  	struct iio_chan_spec const *c;
> +	struct iio_buffer *buffer;
>  };
>  
>  #define to_iio_dev_attr(_dev_attr)				\

