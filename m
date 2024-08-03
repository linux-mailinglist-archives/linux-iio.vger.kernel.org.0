Return-Path: <linux-iio+bounces-8201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49968946A00
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 16:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5241F21750
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9A139D03;
	Sat,  3 Aug 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuRo4WSB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779051DDCE;
	Sat,  3 Aug 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722694240; cv=none; b=Daij3afM8oFKUI9hxlj/wf3Tj6V4ai+kgK8XunCzSIMSF76tm8ygK2AFkdlto++10zTBTGxokVdbbZeRWPSYsxkm+5fkO2v7uQNRnrWZNnlVUKfEHR3Sq59t/+IoJrKCjlmiwk5LKW7pJdNs7pR9bS1PDW2x9xuc2nSS81zt6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722694240; c=relaxed/simple;
	bh=gFXD9UYyUsji0Ga0QlVXFKfXB0dAFxH2u6L3TZIRdds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2pkGxTsgG1dVgv5ky2VPd5n48yl0BR2Cq+LOlX9+8vjhZ4I44YcEIHcYOHex09AyHzFtPcr4E0KohzLRfcyDVVXrJE/K3CKPHekg7H/PRTi8+P9gQZqMpLA3q/7F/4NMJXAifkDy9bubKxS4kJeET+/NVfTco4xuWHRF3O8WcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuRo4WSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0228C116B1;
	Sat,  3 Aug 2024 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722694240;
	bh=gFXD9UYyUsji0Ga0QlVXFKfXB0dAFxH2u6L3TZIRdds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RuRo4WSBNTB5fi4UXM+yiPfxVvdzYeYTEvtZKkc2L5e6ue0cRdlMvXf79AEVm/YoP
	 +EdY92GQ3FGJczpZjKVGpVC88vNSIWhtyDV78OXZqWZrj+ZC2P5WUQfnUzPYo/3U+e
	 O+x56tsYl0pHDArYWZeUN3Wvx1Dyy9TKA15IRZVe5etUpIWWfPLlslbw259XMvtLxC
	 NW9sUiLaLFP8WQFLWTH5sA5VYTTZKkMSZWnZLdK5xLy1Mw5jNjHv1Hwhcj4lrEh8fU
	 dhifpzvyUyHnRyzYa7adSlbJf50BczjJyjZY+hKmxG1IVe/+LGpXVu4CJsgSN0oKmI
	 v2uEGMwpoCaiw==
Date: Sat, 3 Aug 2024 15:10:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
Message-ID: <20240803151033.359e8586@jic23-huawei>
In-Reply-To: <20240731063706.25412-3-abhashkumarjha123@gmail.com>
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
	<20240731063706.25412-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 12:07:04 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Add new ALS channel and allow reading lux and scale values.
> Also provide gain and resolution configuration for ALS channel.
> Add automatic mode switching between the UVS and ALS channel
> based on which channel is being accessed.
> The default mode in which the sensor start is ALS mode.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Hi Abhash, 

I think I managed to confuse things with earlier reviews.

We want a light channel here, but because the scaling is just linear
we want to provide it as in_illuminance_raw and in_illumiance_scale,
not a processed channel.

Sometimes we have no alternative to a processed channel (typically non
linear maths) but when we can present the scaling via _scale (and
if needed _offset) then we do that.  This avoids a bunch of future
problems:
1 - Processed channels are a pain for buffered capture because they
    often need a lot more bits to store.
2 - Any events on this channel tend to require fiddly reverse lookups
    to get from processed to the raw value that needs to be written
    to the device.

Also note we very rarely provide both processed and raw for a channel.
The only exceptions are corner cases such as having to maintain ABI
that we should have never have introduced in the first place.

A few other comments inline.


Jonathan



> ---
>  drivers/iio/light/ltr390.c | 100 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 88 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index ee3d30075..d3ce43f20 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -63,11 +63,17 @@
>   */
>  #define LTR390_WINDOW_FACTOR 1
>  
> +enum ltr390_mode {
> +	LTR390_SET_ALS_MODE,
> +	LTR390_SET_UVS_MODE,
> +};
> +
>  struct ltr390_data {
>  	struct regmap *regmap;
>  	struct i2c_client *client;
>  	/* Protects device from simulataneous reads */
>  	struct mutex lock;
> +	enum ltr390_mode mode;
>  	int gain;
>  	int int_time_us;
>  };
> @@ -95,6 +101,25 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
>  	return get_unaligned_le24(recieve_buffer);
>  }
>  
> +static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
> +{
> +	if (data->mode == mode)
> +		return 0;
> +
> +	switch (mode) {
> +	case LTR390_SET_ALS_MODE:
> +		regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
> +		break;
> +
> +	case LTR390_SET_UVS_MODE:
> +		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
> +		break;
> +	}
> +
> +	data->mode = mode;
> +	return 0;
> +}
> +
>  static int ltr390_read_raw(struct iio_dev *iio_device,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
> @@ -105,16 +130,54 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  	guard(mutex)(&data->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
> +		if (ret < 0)
> +			return ret;
> +
>  		ret = ltr390_register_read(data, LTR390_UVS_DATA);
>  		if (ret < 0)
>  			return ret;
>  		*val = ret;
>  		return IIO_VAL_INT;
> -	case IIO_CHAN_INFO_SCALE:
> -		*val = LTR390_WINDOW_FACTOR;
> -		*val2 = LTR390_COUNTS_PER_UVI;
> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
> +		if (ret < 0)
> +			return ret;
> +		ret = ltr390_register_read(data, LTR390_ALS_DATA);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Converting microseconds to miliseconds */
> +		*val = 1000 * ret;
> +		*val2 = data->gain * data->int_time_us;
>  		return IIO_VAL_FRACTIONAL;

Don't provide this because userspace should be able to
establish it from RAW and SCALE

>  
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_UVINDEX:
> +			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = LTR390_WINDOW_FACTOR;
> +			*val2 = LTR390_COUNTS_PER_UVI;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case IIO_LIGHT:
> +			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
> +			if (ret < 0)
> +				return ret;

Why change the mode to return a fixed scaling?  We don't need the device
to be in the right mode to return the values.


> +
> +			/* scale is 0.6 * WINDOW_FACTOR */
> +			*val = LTR390_WINDOW_FACTOR * 6;
> +			*val2 = 10;

This scale should include the 1000 and data->gain * data->int_time_s
that you are applying in the processed code above.  They are all linear
factors so should be made available to userspace to apply.
			*val = LTR390_WINDOW_FACTOR * 6 * 100;
			*val2 = data->gain * data->int_time_us;
I think. (cancelling the 10).

> +			return IIO_VAL_FRACTIONAL;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
>  	case IIO_CHAN_INFO_INT_TIME:
>  		*val = data->int_time_us;
>  		return IIO_VAL_INT;
> @@ -128,11 +191,23 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
>  static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
>  
> -static const struct iio_chan_spec ltr390_channel = {
> -	.type = IIO_UVINDEX,
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> -	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> -	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
> +static const struct iio_chan_spec ltr390_channels[] = {
> +	/* UV sensor */
> +	{
> +		.type = IIO_UVINDEX,
> +		.scan_index = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
> +	},
> +	/* ALS sensor */
> +	{
> +		.type = IIO_LIGHT,
> +		.scan_index = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
> +	},
>  };


