Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1BF24572C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgHPJ61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgHPJ6X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 05:58:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6211620716;
        Sun, 16 Aug 2020 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597571903;
        bh=QnHTXx401ayk0kWF64NLTZDKz1Hyfdzc0Lv/PfNoce4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wDyVEXSjqO3Fp45TYisTVKfnVFOiHriR+s+QYkjrEo9QylJQP+pryktp+/1L5OxE0
         gjJPdE1jVb7eS5uXZov6N/shGXjiDOtmup4DzEkZxussH9wnAzk8QwEZ3ST3g3sXjK
         h7nOi4fbYTrxWcIvvVMW5eyJFOWaI9+RqqnyaeXE=
Date:   Sun, 16 Aug 2020 10:58:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] iio: core: Add optional symbolic label to a device
 channel
Message-ID: <20200816105819.7661e268@archlinux>
In-Reply-To: <20200812093829.7354-1-cristian.pop@analog.com>
References: <20200812093829.7354-1-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Aug 2020 12:38:29 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> If a label is defined in the device tree for this channel add that
> to the channel specific attributes. This is useful for userspace to
> be able to identify an individual channel.
> 
Hi Christian.

As you know we've discussed this a lot of times, but no one ever
actually did it, so great to see this patch.

I think the implementation approach needs to change however.

> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

Needs documentation in Documentation/ABI/testing/sysfs-bus-iio
Binding also needs documenting.

> ---
>  drivers/iio/industrialio-core.c | 45 +++++++++++++++++++++++++++++++--
>  include/linux/iio/iio.h         |  2 ++
>  include/linux/iio/types.h       |  1 +
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 1527f01a44f1..d7c2405bc905 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -135,6 +135,7 @@ static const char * const iio_modifier_names[] = {
>  /* relies on pairs of these shared then separate */
>  static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_RAW] = "raw",
> +	[IIO_CHAN_INFO_LABEL] = "label",
>  	[IIO_CHAN_INFO_PROCESSED] = "input",
>  	[IIO_CHAN_INFO_SCALE] = "scale",
>  	[IIO_CHAN_INFO_OFFSET] = "offset",
> @@ -653,14 +654,18 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  	int ret;
>  	int val_len = 2;
>  
> -	if (indio_dev->info->read_raw_multi)
> +	if (indio_dev->info->read_raw_multi) {
>  		ret = indio_dev->info->read_raw_multi(indio_dev, this_attr->c,
>  							INDIO_MAX_RAW_ELEMENTS,
>  							vals, &val_len,
>  							this_attr->address);
> -	else
> +	} else {
>  		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
>  				    &vals[0], &vals[1], this_attr->address);
> +		if (ret < 0 && this_attr->address == IIO_CHAN_INFO_LABEL &&
> +			this_attr->c->label_name)

I think we should be checking this before running the read_raw call.
Some drivers take the view they know what they registered and hence don't always
sanity check for invalid values of this_attr->address being passed in there.

> +			return sprintf(buf, "%s\n", this_attr->c->label_name);
> +	}
>  
>  	if (ret < 0)
>  		return ret;
> @@ -1383,6 +1388,37 @@ static ssize_t iio_store_timestamp_clock(struct device *dev,
>  	return len;
>  }
>  
> +static int iio_device_add_channel_label(struct iio_dev *indio_dev,
> +					struct device_node *np)
> +{
> +	unsigned int num_child;
> +	struct iio_chan_spec *chan;
> +	struct device_node *child;
> +	const char *label;
> +	int crt_ch = 0;
> +

Do we need protections in here on whether np actually exists?
Looking at this I'm not sure we protect the existing device level label
code correctly.  If we do an ACPI based probe there is no np.

> +	num_child = of_get_available_child_count(np);
> +	if (!num_child)
> +		return 0;
> +
> +	for_each_available_child_of_node(np, child) {
> +		if (of_property_read_u32(child, "reg", &crt_ch))
> +			continue;
> +
> +		if (crt_ch >= indio_dev->num_channels)
> +			continue;
> +
> +		if (of_property_read_string(child, "label", &label))
> +			continue;
> +
> +		chan = (struct iio_chan_spec *)&indio_dev->channels[crt_ch];

Can't do that. chan_spec is almost always static const and shared
across multiple instances of the driver if you have more than one part
supported by the driver.

So this string needs separate storage allocated at parsing time.

Several options occur for how to implement this functionality.

1) Actually move responsibility to the drivers.  Probably involves a new
   callback function.   That lets the drivers do this parsing alongside
   any other parsing they need to do for the channels.  It also lets
   drivers with older bindings that aren't necessarily of this form provide
   labels.  + should provide options for ACPI based methods of doing the
   same sort of things.  We can provide utility functions to help with
   the parsing etc if it makes sense.  I'm not convinced it does though.

2) Keep it in the core, but have a translation callback in the driver to
   allow more complex mappings of reg to chan_spec.  Those are not
   always straight forward.  The fact they aren't straight forward makes
   me think this should be opt in a the driver level.
   I also don't want to encourage inappropriate labels.  If you have
   some sensor types, per channel labels make little sense.

> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_LABEL);
> +		chan->label_name = label;
> +	}
> +
> +	return 0;
> +}
> +
>  static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
>  		   iio_show_timestamp_clock, iio_store_timestamp_clock);
>  
> @@ -1399,6 +1435,11 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  			attrcount_orig++;
>  	}
>  	attrcount = attrcount_orig;
> +
> +	ret = iio_device_add_channel_label(indio_dev, indio_dev->dev.parent->of_node);

That isn't necessarily the right node (though it normally is).  We have
code setting indio_dev->dev.of_node so should be using that.  It may be necessary to
move that code earlier though, I haven't checked.

> +	if (ret < 0)
> +		return ret;
> +
>  	/*
>  	 * New channel registration method - relies on the fact a group does
>  	 * not need to be initialized if its name is NULL.
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a1be82e74c93..39209f3b62be 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -223,6 +223,7 @@ struct iio_event_spec {
>   *			correspond to the first name that the channel is referred
>   *			to by in the datasheet (e.g. IND), or the nearest
>   *			possible compound name (e.g. IND-INC).
> + * @label_name:		Unique name to identify which channel this is.
>   * @modified:		Does a modifier apply to this channel. What these are
>   *			depends on the channel type.  Modifier is set in
>   *			channel2. Examples are IIO_MOD_X for axial sensors about
> @@ -260,6 +261,7 @@ struct iio_chan_spec {
>  	const struct iio_chan_spec_ext_info *ext_info;
>  	const char		*extend_name;
>  	const char		*datasheet_name;
> +	const char		*label_name;
>  	unsigned		modified:1;
>  	unsigned		indexed:1;
>  	unsigned		output:1;
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index e6fd3645963c..c8f65f476eb2 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -34,6 +34,7 @@ enum iio_available_type {
>  
>  enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_RAW = 0,
> +	IIO_CHAN_INFO_LABEL,
>  	IIO_CHAN_INFO_PROCESSED,
>  	IIO_CHAN_INFO_SCALE,
>  	IIO_CHAN_INFO_OFFSET,

