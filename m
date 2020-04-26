Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B071B8EE3
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDZKk1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 06:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgDZKk1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 06:40:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE952070A;
        Sun, 26 Apr 2020 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587897625;
        bh=vd5M8T5ONx5j8ft0M/zgNs6EngpiOfWbybLUfRNa+20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j+UZHsFwscDC76O62g6RLhh71ZXQ+HGrlKVOck38INnEcGBD0Pd+I4btFI0U37S+P
         LPg2oejZB0Il8ItovGKBR4axsZyfOiRUaX+PKgW9CtZWFvzN97gf/LC+dTc4MobbfX
         zacEiXi888J2nZO5iha/71LzhaKxOTMvTlgkVaSA=
Date:   Sun, 26 Apr 2020 11:40:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 4/4] iio: Track enabled channels on a per channel
 basis
Message-ID: <20200426114021.014d795e@archlinux>
In-Reply-To: <20200424051818.6408-5-alexandru.ardelean@analog.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
        <20200424051818.6408-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Apr 2020 08:18:18 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Now that we support multiple channels with the same scan index we can no
> longer use the scan mask to track which channels have been enabled.
> Otherwise it is not possible to enable channels with the same scan index
> independently.
> 
> Introduce a new channel mask which is used instead of the scan mask to
> track which channels are enabled. Whenever the channel mask is changed a
> new scan mask is computed based on it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hmm. This does seem to handle the demux so that concern is addressed.
Perhaps merge this with previous patch or reorder them.  The sanity check
should only be removed once it's is safe to do so.

This comes in the category of 'clever' but I'm worried it makes the
interface rather less obvious.   Definitely want a lot of inputs from
others on this.

At first glance I rather like it as it solves some of the special cases
we had last time we looked a single bit channels.

Note I'm still far from sold on metadata unless it maps to a 'real' channel
in some sense.  It's really hard to define ABI around the sort of meta
data these devices tend to hide in those unused bits.


Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 62 +++++++++++++++++++++----------
>  drivers/iio/inkern.c              | 19 +++++++++-
>  include/linux/iio/buffer_impl.h   |  3 ++
>  include/linux/iio/consumer.h      |  2 +
>  4 files changed, 64 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index c06691281287..1821a3e32fb3 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -216,12 +216,20 @@ int iio_buffer_alloc_scanmask(struct iio_buffer *buffer,
>  	if (buffer->scan_mask == NULL)
>  		return -ENOMEM;
>  
> +	buffer->channel_mask = bitmap_zalloc(indio_dev->num_channels,
> +					     GFP_KERNEL);
> +	if (buffer->channel_mask == NULL) {
> +		bitmap_free(buffer->scan_mask);
> +		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_alloc_scanmask);
>  
>  void iio_buffer_free_scanmask(struct iio_buffer *buffer)
>  {
> +	bitmap_free(buffer->channel_mask);
>  	bitmap_free(buffer->scan_mask);
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_free_scanmask);
> @@ -285,7 +293,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
>  
>  	/* Ensure ret is 0 or 1. */
>  	ret = !!test_bit(to_iio_dev_attr(attr)->address,
> -		       indio_dev->buffer->scan_mask);
> +		       indio_dev->buffer->channel_mask);
>  
>  	return sprintf(buf, "%d\n", ret);
>  }
> @@ -330,11 +338,12 @@ static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
>   * buffers might request, hence this code only verifies that the
>   * individual buffers request is plausible.
>   */
> -static int iio_scan_mask_set(struct iio_dev *indio_dev,
> -		      struct iio_buffer *buffer, int bit)
> +static int iio_channel_mask_set(struct iio_dev *indio_dev,
> +				struct iio_buffer *buffer, int bit)
>  {
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
> +	unsigned int ch;
>  
>  	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
>  	if (trialmask == NULL)
> @@ -343,8 +352,11 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  		WARN(1, "Trying to set scanmask prior to registering buffer\n");
>  		goto err_invalid_mask;
>  	}
> -	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
> -	set_bit(bit, trialmask);
> +
> +	set_bit(bit, buffer->channel_mask);
> +
> +	for_each_set_bit(ch, buffer->channel_mask, indio_dev->num_channels)
> +		set_bit(indio_dev->channels[ch].scan_index, trialmask);
>  
>  	if (!iio_validate_scan_mask(indio_dev, trialmask))
>  		goto err_invalid_mask;
> @@ -363,28 +375,37 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	return 0;
>  
>  err_invalid_mask:
> +	clear_bit(bit, buffer->channel_mask);
>  	bitmap_free(trialmask);
>  	return -EINVAL;
>  }
>  
> -static int iio_scan_mask_clear(struct iio_buffer *buffer, int bit)
> +static int iio_channel_mask_clear(struct iio_dev *indio_dev,
> +				  struct iio_buffer *buffer, int bit)
>  {
> -	clear_bit(bit, buffer->scan_mask);
> +	unsigned int ch;
> +
> +	clear_bit(bit, buffer->channel_mask);
> +
> +	bitmap_clear(buffer->scan_mask, 0, indio_dev->masklength);
> +
> +	for_each_set_bit(ch, buffer->channel_mask, indio_dev->num_channels)
> +		set_bit(indio_dev->channels[ch].scan_index, buffer->scan_mask);
>  	return 0;
>  }
>  
> -static int iio_scan_mask_query(struct iio_dev *indio_dev,
> -			       struct iio_buffer *buffer, int bit)
> +static int iio_channel_mask_query(struct iio_dev *indio_dev,
> +				 struct iio_buffer *buffer, int bit)
>  {
> -	if (bit > indio_dev->masklength)
> +	if (bit > indio_dev->num_channels)
>  		return -EINVAL;
>  
> -	if (!buffer->scan_mask)
> +	if (!buffer->channel_mask)
>  		return 0;
>  
>  	/* Ensure return value is 0 or 1. */
> -	return !!test_bit(bit, buffer->scan_mask);
> -};
> +	return !!test_bit(bit, buffer->channel_mask);
> +}
>  
>  static ssize_t iio_scan_el_store(struct device *dev,
>  				 struct device_attribute *attr,
> @@ -405,15 +426,15 @@ static ssize_t iio_scan_el_store(struct device *dev,
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> -	ret = iio_scan_mask_query(indio_dev, buffer, this_attr->address);
> +	ret = iio_channel_mask_query(indio_dev, buffer, this_attr->address);
>  	if (ret < 0)
>  		goto error_ret;
>  	if (!state && ret) {
> -		ret = iio_scan_mask_clear(buffer, this_attr->address);
> +		ret = iio_channel_mask_clear(indio_dev, buffer, this_attr->address);
>  		if (ret)
>  			goto error_ret;
>  	} else if (state && !ret) {
> -		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
> +		ret = iio_channel_mask_set(indio_dev, buffer, this_attr->address);
>  		if (ret)
>  			goto error_ret;
>  	}
> @@ -459,7 +480,8 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>  }
>  
>  static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
> -					const struct iio_chan_spec *chan)
> +					const struct iio_chan_spec *chan,
> +					unsigned int address)
>  {
>  	int ret, attrcount = 0;
>  	struct iio_buffer *buffer = indio_dev->buffer;
> @@ -491,7 +513,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  					     chan,
>  					     &iio_scan_el_show,
>  					     &iio_scan_el_store,
> -					     chan->scan_index,
> +					     address,
>  					     0,
>  					     &indio_dev->dev,
>  					     &buffer->scan_el_dev_attr_list);
> @@ -500,7 +522,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  					     chan,
>  					     &iio_scan_el_ts_show,
>  					     &iio_scan_el_ts_store,
> -					     chan->scan_index,
> +					     address,
>  					     0,
>  					     &indio_dev->dev,
>  					     &buffer->scan_el_dev_attr_list);
> @@ -1313,7 +1335,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  				continue;
>  
>  			ret = iio_buffer_add_channel_sysfs(indio_dev,
> -							 &channels[i]);
> +							 &channels[i], i);
>  			if (ret < 0)
>  				goto error_cleanup_dynamic;
>  			attrcount += ret;
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index f35cb9985edc..57cf4b01c403 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -150,6 +150,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
>  	if (index < 0)
>  		goto err_put;
>  	channel->channel = &indio_dev->channels[index];
> +	channel->channel_index = index;
>  
>  	return 0;
>  
> @@ -861,14 +862,28 @@ EXPORT_SYMBOL_GPL(iio_write_channel_raw);
>  void iio_buffer_channel_enable(struct iio_buffer *buffer,
>  			       const struct iio_channel *chan)
>  {
> -	set_bit(chan->channel->scan_index, buffer->scan_mask);
> +	unsigned int ch;
> +
> +	set_bit(chan->channel_index, buffer->channel_mask);
> +

This seems overkill.  Can enabling a channel ever result in a bitmap
that doesn't contain all the bits that were previously set.
Feels like we should be able to just set the one matching the channel
we added to the channel_mask.

I guess the advantage of this is it clearly matches with the disable below
where we do have to walk the channel mask to find out if we have any
overlapping bits.

> +	bitmap_clear(buffer->scan_mask, 0, chan->indio_dev->masklength);
> +
> +	for_each_set_bit(ch, buffer->channel_mask, chan->indio_dev->num_channels)
> +		set_bit(chan->indio_dev->channels[ch].scan_index, buffer->scan_mask);
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_channel_enable);
>  
>  void iio_buffer_channel_disable(struct iio_buffer *buffer,
>  				const struct iio_channel *chan)
>  {
> -	clear_bit(chan->channel->scan_index, buffer->scan_mask);
> +	unsigned int ch;
> +
> +	clear_bit(chan->channel_index, buffer->channel_mask);
> +
> +	bitmap_clear(buffer->scan_mask, 0, chan->indio_dev->masklength);
> +
> +	for_each_set_bit(ch, buffer->channel_mask, chan->indio_dev->num_channels)
> +		set_bit(chan->indio_dev->channels[ch].scan_index, buffer->scan_mask);
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_channel_disable);
>  
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index a63dc07b7350..801e6ffa062c 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -84,6 +84,9 @@ struct iio_buffer {
>  	/** @scan_mask: Bitmask used in masking scan mode elements. */
>  	long *scan_mask;
>  
> +	/** @channel_mask: Bitmask used in masking scan mode elements (per channel). */
> +	long *channel_mask;
> +
>  	/** @demux_list: List of operations required to demux the scan. */
>  	struct list_head demux_list;
>  
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index dbc87c26250a..6efd7091d3dd 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -19,11 +19,13 @@ struct device;
>   * struct iio_channel - everything needed for a consumer to use a channel
>   * @indio_dev:		Device on which the channel exists.
>   * @channel:		Full description of the channel.
> + * @channel_index:	Offset of the channel into the devices channel array.
>   * @data:		Data about the channel used by consumer.
>   */
>  struct iio_channel {
>  	struct iio_dev *indio_dev;
>  	const struct iio_chan_spec *channel;
> +	unsigned int channel_index;
>  	void *data;
>  };
>  

