Return-Path: <linux-iio+bounces-16883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B2A63204
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 20:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB41897869
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B016194AC7;
	Sat, 15 Mar 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9GtIkOp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470141991B2;
	Sat, 15 Mar 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742065367; cv=none; b=d6vT0unZVZKeZySTq5uoHOmKiK+Wvx0wiy6gbfSEMd3hqIZX2VI94W1Z03xyp+8VVkS3gTwxOL4RSZy44vC+jVD9++XtRptfTR/wtH8r3wYgNyzTJmQJt/bnOMC8v4TWgqHG/ZVR2KXy9QraXjaSbUyOg85WSlO1FyIVcCkSJI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742065367; c=relaxed/simple;
	bh=ytOmYookAztqFRX0GfVO/wzv/kZ/N851rmn9d3pXLM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIem6Ib2rdq2TSBg6ALJZKvL0HrGS070vBrADIL4T9WFQL6L5v9a7AUKr7sIq3ueBZOAjdK4b5kUc6WHmwEkQEOgEHbEsZ0Fmrs4l7F6HA64sS6Oo+muiHrCxCqVAd1wj3+GCb0xwpXuPEy9lf3Zr/hnxqUqlpxqN4rIUnS6G8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9GtIkOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82318C4CEE5;
	Sat, 15 Mar 2025 19:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742065366;
	bh=ytOmYookAztqFRX0GfVO/wzv/kZ/N851rmn9d3pXLM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R9GtIkOp4ZR2os/FCP4vynt9Gy3UVqfTHHF018nuoGjIRt0mBVv/H+VWNx0IJtku3
	 ry+dBg8jcIkGicg7PFwUCWRJe/6g6jszcZGeDPoHTrrCwS+oXw6Y3vyFBIG/I1dKdU
	 UaH6MLmIdSHvH0Z4deO/lWo0bOsAxqh380pr5UImNzb9nqBNBNN1Eo75M4f4FQbe1E
	 SONBXetgFAph8x3ujYabxeE/FTxEazWtu4petlFatGcCdeF1oBtQH/bdc4VucfEGQf
	 +7bhj29dVmCj81GILxeAmQr9qNV2sZGgsv/Sx7X+KN8mKx0EGVWVO3dQAqQ81iZs3k
	 JETXavT3iVywA==
Date: Sat, 15 Mar 2025 19:02:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] iio: adc: ad7606: dynamically allocate channel
 info
Message-ID: <20250315190238.65e9a59d@jic23-huawei>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-10-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
	<20250312-iio-adc-ad7606-improvements-v1-10-d1ec04847aea@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 20:15:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Refactor the ad7606 drivers to dynamically allocate the channel info.
> 
> The channel info was getting a bit unwieldy. In some cases, the
> indio_dev->channels field was getting assigned up to 3 different times,
> each in a different function, making it difficult to see where the info
> was coming from. This problem stemps from the number of permutations of
> the channel array needed to support various modes of operation and data
> buses. We already have 4 per chip (hardware mode, software mode, AXI ADC
> backend and AXI ADC backend with software mode) and we intend to add two
> more per chip when adding SPI offload support.
> 
> To make it easier to read and maintain, move all of the channel setup
> to a single function that dynamically allocates and fills in the channel
> info.
> 
> Additionally, this lets us remove some hacks where we had to compute an
> offset due to the fact that sometimes there was a soft timestamp channel
> at the start of the array. Now the timestamp channel is always at the
> end of the array as is typical in other drivers.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

whilst I like static const channel arrays it is hard to argue with the logic
that it got too complex here so fair enough.

A few trivial things inline.

Jonathan
 
> @@ -1289,29 +1193,84 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
>  	return st->bops->sw_mode_config(indio_dev);
>  }
>  
> -static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
> +static int ad7606_probe_channels(struct iio_dev *indio_dev)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
> -	struct iio_chan_spec *chans;
> -	size_t size;
> -	int ch, ret;
> -
> -	/* Clone IIO channels, since some may be differential */
> -	size = indio_dev->num_channels * sizeof(*indio_dev->channels);
> -	chans = devm_kzalloc(st->dev, size, GFP_KERNEL);
> -	if (!chans)
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *channels;
> +	bool slow_bus;
> +	int ret, i;
> +
> +	slow_bus = !st->bops->iio_backend_config;

Maybe inline with declaration?
	bool slow_bus = !st->...

> +	indio_dev->num_channels = st->chip_info->num_adc_channels;
> +
> +	/* Slow buses also get 1 more channel for soft timestamp */
> +	if (slow_bus)
> +		indio_dev->num_channels++;
> +
> +	channels = devm_kcalloc(dev, indio_dev->num_channels, sizeof(*channels),
> +				GFP_KERNEL);
> +	if (!channels)
>  		return -ENOMEM;
>  
> -	memcpy(chans, indio_dev->channels, size);
> -	indio_dev->channels = chans;
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		struct iio_chan_spec *chan = &channels[i];
>  
> -	for (ch = 0; ch < st->chip_info->num_adc_channels; ch++) {
> -		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset]);
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->channel = i;
> +		chan->scan_index = i;
> +		chan->scan_type.sign = 's';
> +		chan->scan_type.realbits = st->chip_info->bits;
> +		chan->scan_type.storagebits = st->chip_info->bits > 16 ? 32 : 16;
> +		chan->scan_type.endianness = IIO_CPU;
> +
> +		if (indio_dev->modes & INDIO_DIRECT_MODE)
> +			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> +
> +		if (st->sw_mode_en) {
> +			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> +			chan->info_mask_separate_available |=
> +				BIT(IIO_CHAN_INFO_SCALE);
> +
> +			/**
/* probably more appropriate here.

> +			 * All chips with software mode support oversampling,
> +			 * so we skip the oversampling_available check. And the
> +			 * shared_by_type instead of shared_by_all on slow
> +			 * buses is for backward compatibility.
> +			 */
> +			if (slow_bus)
> +				chan->info_mask_shared_by_type |=
> +					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +			else
> +				chan->info_mask_shared_by_all |=
> +					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +
> +			chan->info_mask_shared_by_all_available |=
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +		} else {
> +			chan->info_mask_shared_by_type |=
> +				BIT(IIO_CHAN_INFO_SCALE);
> +
> +			if (st->chip_info->oversampling_avail)
> +				chan->info_mask_shared_by_all |=
> +					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +		}
> +
> +		if (!slow_bus)
> +			chan->info_mask_shared_by_all |=
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +
> +		ret = st->chip_info->scale_setup_cb(indio_dev, chan);
>  		if (ret)
>  			return ret;
>  	}
>  
> +	if (slow_bus)
> +		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
> +
> +	indio_dev->channels = channels;
> +
>  	return 0;
>  }

> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index fd4c0d615a880ac6fdcaad213d4843329c3bd7fe..b67058cd021a3d00ff0f461766d51e46d7998f32 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h

>  typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
> @@ -118,10 +48,9 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
>  
>  /**
>   * struct ad7606_chip_info - chip specific information
> - * @channels:		channel specification
>   * @max_samplerate:	maximum supported sample rate
>   * @name:		device name
> - * @num_channels:	number of channels
> + * @bits:		data width in bits

Hmm. Was previously in the wrong order.  Maybe fix that in your
earlier cleanup then this will look more natural.

>   * @num_adc_channels:	the number of channels the ADC actually inputs.
>   * @scale_setup_cb:	callback to setup the scales for each channel
>   * @sw_setup_cb:	callback to setup the software mode if available.
> @@ -133,11 +62,10 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
>   *			after a restart
>   */
>  struct ad7606_chip_info {
> -	const struct iio_chan_spec	*channels;
>  	unsigned int			max_samplerate;
>  	const char			*name;
> +	unsigned int			bits;
>  	unsigned int			num_adc_channels;
> -	unsigned int			num_channels;
>  	ad7606_scale_setup_cb_t		scale_setup_cb;
>  	ad7606_sw_setup_cb_t		sw_setup_cb;
>  	const unsigned int		*oversampling_avail;



