Return-Path: <linux-iio+bounces-14468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE57A15E41
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622AB7A2C0C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D914719FA8D;
	Sat, 18 Jan 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBWo+mIM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3A19C558;
	Sat, 18 Jan 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220179; cv=none; b=r+jpWd7Pv8NeVJlj7angWCn9++0Xa9pIdUnmPc8AQezWVt9nVJ2IwEAAtZo2saz5+zXru+A1dVEhW9h7jlbt7r+mpKV+t0xk1AIMJMP6tI1qmoT9LdTn2HA8vaGk1UyX1O8Y9oSl14mrenNPWAjqpgbo/9nqEcv/NdGhX7p76o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220179; c=relaxed/simple;
	bh=AleCP7eQDX3+zlFFyT4miNCpVAixhcx2/kkx0eWIDTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9oaumHPr67twmSfkpuQ2GKOzZl1udlQ0AYBcX9gh0HXgs2LAq/0lxXpx1SV10p9mOAQSUyWhPBKfgssvI+6BK7xi0Z+DSTF8YT7ubT2NzoAoX+nhbAgxhqz7R6ZvlGPMeWKTTTKPEpHlenJjS/ppA3Oy7uG85NCcqdR79KJ7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBWo+mIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD4CC4CED1;
	Sat, 18 Jan 2025 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737220179;
	bh=AleCP7eQDX3+zlFFyT4miNCpVAixhcx2/kkx0eWIDTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JBWo+mIMPaq5kdQcItUemO+J1tkQevCpHsx52ttK9grtdEZNdakvovU4loOxouFVj
	 Cf6JkE8XVTRXBYmgp63u3yUe7z5C+mYCWuh20MpjFrXasxQEv0nNqyMlKXkPox34A7
	 fI0rXvLZOjxMuAPktWp6cWhT07eJyU9k14Go8VVP9WFtyXxrCvVMZZELWW7jywfCux
	 KmqYNu0Ri4aWEpOdlDhB4+bX9u3zqAiVVMAcpAUg4g/3IjGI5jTogfOw0BV8J9hIz8
	 jmUtaf58THH15GVRZq5/vATi6th77AGbeAbnNPgPa4fUr3G9KBgG/bCzmTBnqEBvPC
	 4h5eByy0Ne/zg==
Date: Sat, 18 Jan 2025 17:09:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/2] iio: adc: ad7173: add openwire detection
 support for single conversions
Message-ID: <20250118170930.3a2ad381@jic23-huawei>
In-Reply-To: <20250116-ad4111_openwire-v3-2-ea9ebf29bd1d@baylibre.com>
References: <20250116-ad4111_openwire-v3-0-ea9ebf29bd1d@baylibre.com>
	<20250116-ad4111_openwire-v3-2-ea9ebf29bd1d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 16:01:47 +0100
Guillaume Ranquet <granquet@baylibre.com> wrote:

> Some chips of the ad7173 family supports open wire detection.
> 
> Generate a level fault event whenever an external source is disconnected
> from the system input on single conversions.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Hi Guillaume.

In general this series looks fine to me.
A few things inline + maybe drop the RFC for v4.
There are some reviewers who will not take a close look until after that.
Not sure that applies to any of our regulars in IIO but it is appropriate
to drop it anyway at this point I think!

Jonathan

> ---
>  drivers/iio/adc/ad7173.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa..d1cba93722673d2f7fd9239074d36e5274527557 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -35,6 +35,7 @@

> +/*
> + * Associative array of channel pairs for open wire detection
> + * The array is indexed by ain and gives the associated channel pair
> + * to perform the open wire detection with
> + * the channel pair [0] is for non differential and pair [1]
> + * is for differential inputs
> + */
> +static int openwire_ain_to_channel_pair[][2][2] = {
> +/*	AIN     Single    Differential */
> +	[0] = { {0, 15},  {1, 2}   },
> +	[1] = { {1, 2},   {2, 1}   },
> +	[2] = { {3, 4},   {5, 6}   },
> +	[3] = { {5, 6},   {6, 5}   },
> +	[4] = { {7, 8},   {9, 10}  },
> +	[5] = { {9, 10},  {10, 9}  },
> +	[6] = { {11, 12}, {13, 14} },
> +	[7] = { {13, 14}, {14, 13} },
> +};
> +
> +/*
> + * Openwire detection on ad4111 works by running the same input measurement
> + * on two different channels and compare if the difference between the two
> + * measurements exceeds a certain value (typical 300mV)
> + */
> +static int ad4111_openwire_event(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *adchan = &st->channels[chan->address];
> +	struct ad7173_channel_config *cfg = &adchan->cfg;
> +	int ret, val1, val2;
> +
> +	ret = regmap_set_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);

Given you need to do a v4 for some issues below, please also rewrap to sub 80 chars
where it doesn't hurt readability.


> +	if (ret)
> +		return ret;
> +
> +	adchan->cfg.openwire_comp_chan =
> +		openwire_ain_to_channel_pair[chan->channel][chan->differential][0];
> +
> +	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val1);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Error running ad_sigma_delta single conversion: %d", ret);
> +		goto out;
> +	}
> +
> +	adchan->cfg.openwire_comp_chan =
> +		openwire_ain_to_channel_pair[chan->channel][chan->differential][1];
> +
> +	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val2);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Error running ad_sigma_delta single conversion: %d", ret);
> +		goto out;
> +	}
> +
> +	if (abs(val1 - val2) > cfg->openwire_thrsh_raw)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
> +						    IIO_EV_TYPE_FAULT, IIO_EV_DIR_OPENWIRE),
> +			       iio_get_time_ns(indio_dev));
> +
> +out:
> +	adchan->cfg.openwire_comp_chan = -1;
> +	regmap_clear_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
> +	return ret;
> +}

...

> @@ -1112,12 +1201,58 @@ static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
>  }
>  
> +static int ad7173_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *adchan = &st->channels[chan->address];
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_FAULT:
> +		adchan->openwire_det_en = state;

Fall through looks unlikely to be intended and if it were would
need marking.

		return 0; here and drop the return below.
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7173_read_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +				     enum iio_event_type type, enum iio_event_direction dir)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *adchan = &st->channels[chan->address];
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_FAULT:
> +		return adchan->openwire_det_en;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
Unreachable so drop this.

> +}


