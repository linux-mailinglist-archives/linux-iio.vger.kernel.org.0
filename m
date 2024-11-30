Return-Path: <linux-iio+bounces-12882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386B9DF29C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A802814BA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D351AA1F4;
	Sat, 30 Nov 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjSwTHqO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D11AA1E2;
	Sat, 30 Nov 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991930; cv=none; b=Y8zQlbgZ3uNueTELIuNuB2CA8rC7SJLeYZIn1tJQL/pAKCQ3uwLc9Aego0NiYQHthzoNvrdip0FFbs4Ep082BTsS8hlUgjZ/tuz6B1V+5GjDl+SQtr+SM6u42htLAWPt5KbJXrZVPvvRa0l/PiCo/TbBTxFnx4V83G3R+faXSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991930; c=relaxed/simple;
	bh=DZpg1x2kzkyruGc7zDK9ya8CbERy6DEqz4wV7j57D6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7/XRGi4XqYGWUST7efwp1sAMFk/W8+JUUZ70fQ2B4y3EJIll6B4W2AcLKAvZokz0H4p+6cQBAeD2L2DZcvLEkPRF81Lo1E7Kgl3BIm+bNfILMB63Ar5D8hxjMxJrbM1lc2la5Wqy9OfrcyFY9N9I3XgBwnooYhqOG5Dhmhejh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjSwTHqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAC3C4CECC;
	Sat, 30 Nov 2024 18:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991929;
	bh=DZpg1x2kzkyruGc7zDK9ya8CbERy6DEqz4wV7j57D6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gjSwTHqOe7D38RgDr6jKi75NHVLQiVS0ClfSAoI+iigmscVAD2K87xoYQPKlKAoW6
	 LUh+unMzuxn0RSe4TY9tcwdK9RrV4EJumfI9VmKNIaqa16Yxttb4guxgLzHjf4ijUE
	 1dKKvsPrY2tx6lQATc0T5VxtEL1t693wcunl6oTEYUWYWGAlgXAG6Vu7d3C9Pp8z//
	 eguo8tRg9dlJ904U2gnuqXtXo2qV3+9qjbh4Fl8GQDCNGkNi0FNh6Vfw32AW7Qj0OI
	 dUQwZU3u+x8eIKDU/l3yJOAVXUxr1sdy3XX+F0AhhR9AyKimlWL8MOAa27tcaNLgLe
	 2yIwUQS5BEWGA==
Date: Sat, 30 Nov 2024 18:38:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 3/3] iio: adc: ad7192: Add sync gpio
Message-ID: <20241130183839.1fd5884f@jic23-huawei>
In-Reply-To: <20241128125811.11913-4-alisa.roman@analog.com>
References: <20241128125811.11913-1-alisa.roman@analog.com>
	<20241128125811.11913-4-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 14:55:03 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Add support for the SYNC pin of AD719x devices. This pin is controlled
> through a GPIO. The pin allows synchronization of digital filters and
> analog modulators when using multiple devices.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Hi.

Like all userspace ABI, this needs documentation.

It's an unusual feature, so some usecases would help.

It is also cross multiple devices which makes this odd as only one device
can presumably acquire the gpio?

An alternative would be to look at how to do this with a 'wrapper' sort of device
so that we have one instance to which this applies.

I'm not sure that helps that much though as we'd still need some for of
'I'm setup for all channels, now you can go' ABI.

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 112 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 955e9eff0099..542db7280e99 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/device.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> @@ -196,6 +197,7 @@ struct ad7192_chip_info {
>  	u8				num_channels;
>  	const struct ad_sigma_delta_info	*sigma_delta_info;
>  	const struct iio_info		*info;
> +	const struct iio_info		*info_sync;
>  	int (*parse_channels)(struct iio_dev *indio_dev);
>  };
>  
> @@ -216,6 +218,8 @@ struct ad7192_state {
>  	struct mutex			lock;	/* protect sensor state */
>  	u8				syscalib_mode[8];
>  
> +	struct gpio_desc		*sync_gpio;
> +
>  	struct ad_sigma_delta		sd;
>  };
>  
> @@ -783,6 +787,36 @@ static void ad7192_update_filter_freq_avail(struct ad7192_state *st)
>  	st->filter_freq_avail[3][0] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
>  }
>  
> +static ssize_t sync_gpio_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%d\n", gpiod_get_value(st->sync_gpio));
> +}
> +
> +static ssize_t sync_gpio_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf,
> +			       size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	int val;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (st->sync_gpio)
> +		gpiod_set_value(st->sync_gpio, val);
> +
> +	return len;
> +}



