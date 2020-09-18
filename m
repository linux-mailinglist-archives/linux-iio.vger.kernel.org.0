Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A926F7C2
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIRINK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 04:13:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2885 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbgIRINK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Sep 2020 04:13:10 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 04:13:09 EDT
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C1FF77F51F395616E139;
        Fri, 18 Sep 2020 09:13:08 +0100 (IST)
Received: from localhost (10.52.125.116) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 09:13:08 +0100
Date:   Fri, 18 Sep 2020 09:11:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Pop <cristian.pop@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH v4 1/3] iio: core: Add optional symbolic label to a
 device channel
Message-ID: <20200918091130.0000282c@Huawei.com>
In-Reply-To: <20200916132115.81795-1-cristian.pop@analog.com>
References: <20200916132115.81795-1-cristian.pop@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.116]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 16:21:15 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> If a label is defined in the device tree for this channel add that
> to the channel specific attributes. This is useful for userspace to
> be able to identify an individual channel.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
Hi Cristian.

I (and lore.kernel.org) only received patch 1 so guess docs and example were
in patches 2 and 3?  Something odd is perhaps going on with Analog's email
vs vger as there was only a partial set of Nuno's series last night as well
so I couldn't pick it up with b4.

This patch looks good to me.  Thanks for your hard work on this.
Given timing it may slip into the next cycle. 

Jonathan

> ---
> Change in V4:
> 	- Check for callback before generating file system for label
> 	- Add documentation in: Documentation/ABI/testing/sysfs-bus-iio


> 	- Add example of usage for channel label attribute
>  drivers/iio/industrialio-core.c | 41 +++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  6 +++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 1527f01a44f1..49868e080840 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -643,6 +643,21 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
>  }
>  EXPORT_SYMBOL_GPL(iio_format_value);
>  
> +static ssize_t iio_read_channel_label(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +
> +	if (indio_dev->info->read_label)
> +		return indio_dev->info->read_label(indio_dev,
> +							this_attr->c,
> +							buf);
> +	else
> +		return -EINVAL;
> +}
> +
>  static ssize_t iio_read_channel_info(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> @@ -1111,6 +1126,25 @@ int __iio_add_chan_devattr(const char *postfix,
>  	return ret;
>  }
>  
> +static int iio_device_add_channel_label(struct iio_dev *indio_dev,
> +					 struct iio_chan_spec const *chan)
> +{
> +	int ret;
> +
> +	ret = __iio_add_chan_devattr("label",
> +					chan,
> +					&iio_read_channel_label,
> +					NULL,
> +					0,
> +					IIO_SEPARATE,
> +					&indio_dev->dev,
> +					&indio_dev->channel_attr_list);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 1;
> +}
> +
>  static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
>  					 struct iio_chan_spec const *chan,
>  					 enum iio_shared_by shared_by,
> @@ -1241,6 +1275,13 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  		return ret;
>  	attrcount += ret;
>  
> +	if (indio_dev->info->read_label) {
> +		ret = iio_device_add_channel_label(indio_dev, chan);
> +		if (ret < 0)
> +			return ret;
> +		attrcount += ret;
> +	}
> +
>  	if (chan->ext_info) {
>  		unsigned int i = 0;
>  		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a1be82e74c93..58b151f5321d 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -362,6 +362,8 @@ struct iio_trigger; /* forward declaration */
>   *			and max. For lists, all possible values are enumerated.
>   * @write_raw:		function to write a value to the device.
>   *			Parameters are the same as for read_raw.
> + * @read_label:		function to request label name for a specified label,
> + *			for better channel identification.
>   * @write_raw_get_fmt:	callback function to query the expected
>   *			format/precision. If not set by the driver, write_raw
>   *			returns IIO_VAL_INT_PLUS_MICRO.
> @@ -420,6 +422,10 @@ struct iio_info {
>  			 int val2,
>  			 long mask);
>  
> +	int (*read_label)(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 char *label);
> +
>  	int (*write_raw_get_fmt)(struct iio_dev *indio_dev,
>  			 struct iio_chan_spec const *chan,
>  			 long mask);


