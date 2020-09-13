Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA3267F44
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgIMKpi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 06:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgIMKpg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 06:45:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B596720723;
        Sun, 13 Sep 2020 10:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599993936;
        bh=bAWR+HfTQ1N7d06HZzD0otQJGmhO6746RzB4Ehxc4Ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WjDMJ6KC1IcRz4YKsyd6mVQ9KWzr3s9tZ1uyMpXZ3RAvDFBXtM5/BjouNj0omDfQU
         BF93MVWB2DCMyHvwdBnfh6MOafvbiDzzBDqwbTwWs0kfjZQDxchq9c1rRO+ruUYw8d
         L35kVc6df2Gk8etVTNFi8fz5L4eG9XGHLsqtGH4c=
Date:   Sun, 13 Sep 2020 11:45:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3] iio: core: Add optional symbolic label to a
 device channel
Message-ID: <20200913114532.57a47bb6@archlinux>
In-Reply-To: <20200911132522.22969-1-cristian.pop@analog.com>
References: <20200911132522.22969-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Sep 2020 16:25:22 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> If a label is defined in the device tree for this channel add that
> to the channel specific attributes. This is useful for userspace to
> be able to identify an individual channel.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

Hi Christian,

You've accidentally picked up a lot of unrelated stuff in here.
I've tried to strip that out for review.  It is very easy to do this
so I suggest always taking a quick manual read of patches before
sending them out for things that shouldn't be there.

As to the actual patch, I'd make one small adjustment and I think
it looks good.

Note though, we need some ABI docs for it.
Documentation/ABI/testing/sysfs-bus-iio is the place for it.
It also needs to go in with changes in one more more drivers to use it.

After that I'd like to let this sit a little longer than a normal
patch to see if anyone else wants to comment.

Thanks,

Jonathan


> ---
>  Changes in V3:
> 	- Add "read_label" callback function
> 
>  drivers/iio/industrialio-core.c | 159 +++++++++++++++++++++++++-------
>  include/linux/iio/iio.h         |  40 +++++++-
>  2 files changed, 160 insertions(+), 39 deletions(-)
> 

...

>  EXPORT_SYMBOL_GPL(iio_enum_write);
> @@ -643,6 +644,21 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
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

As mentioned below, I'd not register the attr if we don't have
the callback.

> +}
> +
>  static ssize_t iio_read_channel_info(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> @@ -1111,6 +1127,25 @@ int __iio_add_chan_devattr(const char *postfix,
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
> @@ -1241,6 +1276,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  		return ret;
>  	attrcount += ret;
>  
> +	ret = iio_device_add_channel_label(indio_dev, chan);
> +	if (ret < 0)
> +		return ret;

I took a bit long to reply to previous thread, but we should definitely be
checking if the driver provides the callback.  If it doesn't
we shouldn't try to add this attr.

We may want to provide finer grained control, or a flag to let drivers
turn it on or off without needing to provide multiple iio_info structures.
Lets not do that for now though.  A global, does the driver provide
a callback is fine.  We can reassess once a we have seen how this gets used.

> +	attrcount += ret;
> +
>  	if (chan->ext_info) {
>  		unsigned int i = 0;
>  		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {

.. 

Lots of unrelated changes...

>  /* Device operating modes */
>  #define INDIO_DIRECT_MODE		0x01
>  #define INDIO_BUFFER_TRIGGERED		0x02
> @@ -362,6 +387,8 @@ struct iio_trigger; /* forward declaration */
>   *			and max. For lists, all possible values are enumerated.
>   * @write_raw:		function to write a value to the device.
>   *			Parameters are the same as for read_raw.
> + * @read_label:		function to request label name for a specified label,
> + *			for better channel identification.
>   * @write_raw_get_fmt:	callback function to query the expected
>   *			format/precision. If not set by the driver, write_raw
>   *			returns IIO_VAL_INT_PLUS_MICRO.
> @@ -420,6 +447,10 @@ struct iio_info {
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

Other seemingly unrelated stuff.

...
