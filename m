Return-Path: <linux-iio+bounces-7040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438E791CDF0
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F5328211C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A284FAD;
	Sat, 29 Jun 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0qqI8mU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78C1DFE8;
	Sat, 29 Jun 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675430; cv=none; b=VY3QM6SSDDCGq+2zG1NLZ6NGNc3Ymzse/KJU6XwC57ckmDAkASAJrnG1IbFugxaIelG+eCy1q6P/ctz61xR6ovPdS9/E+iwOABEbETbm9mLjYVIzhtLL4bewZg2mbuTTxybN5XYAjkLYTcf02OGWq8PveHpHrvAEyc0PAysYn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675430; c=relaxed/simple;
	bh=uBhS/HMC3Y7Zk7BpvYR/7CveBA8jwnAijIUS2nLxHw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToEOlhbCS74zsdXrSX0/JemfnlvuZwab7lx3+NryA419Wxs0Mz42XzKHbNVIuBvM/LTHjTYSHzJNxF0K2F/Tzhe853Yssnc0pz+jqI5puU3Ejx4IfdPBLICKQwp7uRzYfGaZ9NzlXT/BBK/+KiFlk+tMyfBgj/+7PHSx1w0kOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0qqI8mU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9177C2BBFC;
	Sat, 29 Jun 2024 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719675429;
	bh=uBhS/HMC3Y7Zk7BpvYR/7CveBA8jwnAijIUS2nLxHw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T0qqI8mUBEg9tqTq4BDhabNpItbf4zsvj0adP8N39ALQaSHdILtlyDXfyIJAIRMRs
	 FeudjVkSZd28cUeV0+Z5gnCyVoXxj7anpZgRImZhcAK6pVgVuz91syGKqXz+ccW5Z2
	 g5b73rxsdITFDKPuB5Y3kbraLG5fO4iKYA53cao2fdcHxYBtnrNZRs2hfycGHG9cpu
	 qmIh+Nhct5nMwa4pI90xnKNR+ofCVmk9lVv/q+H6bEJouLcmNyYJiyGj+xu38laEDj
	 07mJbk0XOorWERUng23ga/A03V3w97Rp2liNM0nrYilGlevwY+PLz+JpbV3myGlelE
	 LgQ9rxD2E4DVw==
Date: Sat, 29 Jun 2024 16:36:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v2 10/10] iio: adc: ad7606: switch mutexes to
 scoped_guard
Message-ID: <20240629163659.322954c3@jic23-huawei>
In-Reply-To: <20240628-cleanup-ad7606-v2-10-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
	<20240628-cleanup-ad7606-v2-10-96e02f90256d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 14:48:28 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Switching to scoped_guard simplifies the code and avoids to take care to
> unlock the mutex in case of premature return.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 60 ++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 50ccc245e314..3c439787d130 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -69,19 +69,17 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> +
>  	if (readval) {
>  		ret = st->bops->reg_read(st, reg);
>  		if (ret < 0)
> -			goto err_unlock;
> +			return ret;
>  		*readval = ret;
> -		ret = 0;
> +		return 0;
>  	} else {
> -		ret = st->bops->reg_write(st, reg, writeval);
> +		return st->bops->reg_write(st, reg, writeval);
>  	}
> -err_unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
>  }
>  
>  static int ad7606_read_samples(struct ad7606_state *st)
> @@ -124,18 +122,18 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);

Why not simply a guard(mutex)(&st->lock) ?

Then we avoid the somewhat nasty label in an nested block of code.

> +	scoped_guard(mutex, &st->lock) {
> +		ret = ad7606_read_samples(st);
> +		if (ret)
> +			goto error_ret;
>  
> -	ret = ad7606_read_samples(st);
> -	if (ret == 0)
>  		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>  						   iio_get_time_ns(indio_dev));
> -
> -	iio_trigger_notify_done(indio_dev->trig);
> -	/* The rising edge of the CONVST signal starts a new conversion. */
> -	gpiod_set_value(st->gpio_convst, 1);
> -
> -	mutex_unlock(&st->lock);
> +error_ret:
> +		iio_trigger_notify_done(indio_dev->trig);
> +		/* The rising edge of the CONVST signal starts a new conversion. */
> +		gpiod_set_value(st->gpio_convst, 1);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -259,17 +257,15 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		mutex_lock(&st->lock);
> -		i = find_closest(val2, st->scale_avail, st->num_scales);
> -		if (st->sw_mode_en)
> -			ch = chan->address;
> -		ret = st->write_scale(indio_dev, ch, i);
> -		if (ret < 0) {
> -			mutex_unlock(&st->lock);
> -			return ret;
> +		scoped_guard(mutex, &st->lock) {

The mutex is grabbed in all paths that actually do anything.
Pull it out of the switch and use
guard(mutex)(&st->lock);

That will reduce the changes needed and give the same cleanups.
I doubt we care about potentially slowing down the path that returns an error
as we are writing something unwriteable.

> +			i = find_closest(val2, st->scale_avail, st->num_scales);
> +			if (st->sw_mode_en)
> +				ch = chan->address;
> +			ret = st->write_scale(indio_dev, ch, i);
> +			if (ret < 0)
> +				return ret;
> +			st->range[ch] = i;
>  		}
> -		st->range[ch] = i;
> -		mutex_unlock(&st->lock);
>  
>  		return 0;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> @@ -277,14 +273,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		i = find_closest(val, st->oversampling_avail,
>  				 st->num_os_ratios);
> -		mutex_lock(&st->lock);
> -		ret = st->write_os(indio_dev, i);
> -		if (ret < 0) {
> -			mutex_unlock(&st->lock);
> -			return ret;
> +		scoped_guard(mutex, &st->lock) {
> +			ret = st->write_os(indio_dev, i);
> +			if (ret < 0)
> +				return ret;
> +			st->oversampling = st->oversampling_avail[i];
>  		}
> -		st->oversampling = st->oversampling_avail[i];
> -		mutex_unlock(&st->lock);
>  
>  		return 0;
>  	default:
> 


