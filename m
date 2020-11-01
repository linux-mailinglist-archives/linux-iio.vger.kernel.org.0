Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86262A1F28
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgKAPiI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgKAPiI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:38:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA89520870;
        Sun,  1 Nov 2020 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604245087;
        bh=8BI6hG3LMiwJ3PyrABZJp+hrFQTYBJwjnj4k1x2xJU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oxaS+SI5bzcOgHlrjLSVKtEGNFloTGoaylbsuDx8MNGefrK7DfKt+OAWG9hvh2Vsk
         /pB6Y08O8LQwj9LR2f18Pj/SYYFwMVM8Kk4Bxm+9Rmm4ECF55K8ffkEiIZxbNOOoxJ
         b/8zqayHsX+nGmPy84hfitqt7RuChyIPBJe9ahv4=
Date:   Sun, 1 Nov 2020 15:38:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] iio: core: Add optional symbolic label to a
 device channel
Message-ID: <20201101153803.471eafa8@archlinux>
In-Reply-To: <20200928090959.88842-1-cristian.pop@analog.com>
References: <20200928090959.88842-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 12:09:55 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> If a label is defined in the device tree for this channel add that
> to the channel specific attributes. This is useful for userspace to
> be able to identify an individual channel.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

Hi Cristian,

I think the DT binding part of this has gotten lost now, so please
repost the whole series making sure to include Rob H and DT list.

I have proposed a conversion of the adc.txt file now.  I'll deal
with merging your changes into there if necessary though.
May be worth mentioning that in the cover letter for the resend.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 40 +++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  6 +++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6e388293c828..b577fff35641 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -669,6 +669,19 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
>  }
>  EXPORT_SYMBOL_GPL(iio_format_value);
>  
> +static ssize_t iio_read_channel_label(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +
> +	if (!indio_dev->info->read_label)
> +		return -EINVAL;
> +
> +	return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
> +}
> +
>  static ssize_t iio_read_channel_info(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> @@ -1137,6 +1150,28 @@ int __iio_add_chan_devattr(const char *postfix,
>  	return ret;
>  }
>  
> +static int iio_device_add_channel_label(struct iio_dev *indio_dev,
> +					 struct iio_chan_spec const *chan)
> +{
> +	int ret;
> +
> +	if (!indio_dev->info->read_label)
> +		return 0;
> +
> +	ret = __iio_add_chan_devattr("label",
> +				     chan,
> +				     &iio_read_channel_label,
> +				     NULL,
> +				     0,
> +				     IIO_SEPARATE,
> +				     &indio_dev->dev,
> +				     &indio_dev->channel_attr_list);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 1;
> +}
> +
>  static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
>  					 struct iio_chan_spec const *chan,
>  					 enum iio_shared_by shared_by,
> @@ -1270,6 +1305,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  		return ret;
>  	attrcount += ret;
>  
> +	ret = iio_device_add_channel_label(indio_dev, chan);
> +	if (ret < 0)
> +		return ret;
> +	attrcount += ret;
> +
>  	if (chan->ext_info) {
>  		unsigned int i = 0;
>  		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 2e45b3ceafa7..9a3cf4815148 100644
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

