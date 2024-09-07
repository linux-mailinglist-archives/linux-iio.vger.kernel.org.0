Return-Path: <linux-iio+bounces-9286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2562A9702DD
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5A41C21A1C
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27615ECDF;
	Sat,  7 Sep 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2vcelRK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FF47A62;
	Sat,  7 Sep 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725721446; cv=none; b=I2IMVykn5nubB7Sp7ftG3X4qEQkhWNuIP9bIueCBgeuaXJNHvPQoZS7M3e4obkQJOVUdroi0kqMgZlagm9KSSaZ5n6UQUOg3tkLGRGpS/jlQmCxgJz5XvJT8ccmF5Nj8Nv6HNtRC14CQ4l0+/tf2pEL0XAYCmm2MvcqBKVTJ2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725721446; c=relaxed/simple;
	bh=C2JL5JYyA3dX1N3lJgluYOQJSZsuatAOAKCH7Imu35g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTqyCLOHXFo95s8VyaSGK1Ob90uMmjiAe3/DJh9J0TLiv8QzZSN45jax9FKcpJpOk4lRXgPiQWeG4asF38TffO8PddnsUiM6WDxIeHaQrSZpHcWX3MFn1y+FModaBSzIOr3VUxXYtSLnm7AVNXJggPDAuA+QSDpUfL/1gc0gZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2vcelRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220C6C4CEC2;
	Sat,  7 Sep 2024 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725721445;
	bh=C2JL5JYyA3dX1N3lJgluYOQJSZsuatAOAKCH7Imu35g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p2vcelRKvaQ1nwcie6fgclIbAe3775WNELUi4OQcfiXd8e0NGmVnu2VIUavJHE07i
	 wRgMyAVN5vPv85/VsIZi7sGbiUIKaPE5b1rMHuIPezUX+YiEtGbuVOaNjwZFm8B0lL
	 /3Jy67pYHvhhxj+zGH/am4rFOFg+GgHZTPmboc1eqboxD4jbyXtsQvKYXLw7I+TBAq
	 dohzX26xg7gHVKtwEpTac5jAXp6elva0afK4RFSLfOtxy3f135wHdx7a7OEs5flGwn
	 fdzp0QSrXR2VkNNkWY5kekoy9vNFhq5BidL4tDaax2nr9JG6nhX5csJWO75GjkpV8b
	 p76knnirGkcqg==
Date: Sat, 7 Sep 2024 16:03:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v5 6/9] iio: adc: ad7606: rework available attributes
 for SW channels
Message-ID: <20240907160356.3de047b0@jic23-huawei>
In-Reply-To: <20240907065043.771364-7-aardelean@baylibre.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
	<20240907065043.771364-7-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Sep 2024 09:50:39 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> For SW mode, the oversampling and scales attributes are always present.
> So, they can be implemented via a 'read_avail' hook in iio_info.
> 
> For HW mode, it's a bit tricky, as these attributes get assigned based on
> GPIO definitions.
> 
> So, for SW mode, we define a separate AD7606_SW_CHANNEL() macro, and use
> that for the SW channels.
> And 'ad7606_info_os_range_and_debug' can be renamed to
> 'ad7606_info_sw_mode' as it is only used for SW mode.
> 
> For the 'read_avail' hook, we'll need to allocate the SW scales, so that
> they are just returned userspace without any extra processing.
> The allocation will happen when then ad7606_state struct is allocated.
> The oversampling available parameters don't need any extra processing; they
> can just be passed back to userspace (as they are).
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>

One question inline.

>  
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 635407c2acc0..fa175cff256c 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h

>  #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
>  
>  /**
> @@ -65,11 +84,15 @@ struct ad7606_chip_info {
>  /**
>   * struct ad7606_chan_scale - channel scale configuration
>   * @scale_avail		pointer to the array which stores the available scales
> + * @scale_avail_show	a duplicate of 'scale_avail' which is readily formatted
> + *			such that it can be read via the 'read_avail' hook
>   * @num_scales		number of elements stored in the scale_avail array
>   * @range		voltage range selection, selects which scale to apply
>   */
>  struct ad7606_chan_scale {
> +#define AD760X_MAX_SCALE_SHOW		(AD760X_MAX_CHANNELS * 2)

Why is the number of scales dependent on the number of channels?

>  	const unsigned int		*scale_avail;
> +	int				scale_avail_show[AD760X_MAX_SCALE_SHOW];
>  	unsigned int			num_scales;
>  	unsigned int			range;
>  };


