Return-Path: <linux-iio+bounces-4986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594CD8C3683
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B141F2166E
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E35720B20;
	Sun, 12 May 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nies3/Wt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4421E894;
	Sun, 12 May 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516967; cv=none; b=PemTS6N3LIhydmalMievdH2FujyRHHk88sP0OFpu6Rubjbfmehi8g58ogET7itOdGE7SF8ppT/jOS7Ptwn0o+1xPZCKhFPwsO3mu+Uu/j/BSufNykwCgc0UkPEGSsHhsl+NcO6G1iApE1/rI87yu0iQTkFabP3YyG/1f57nhzGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516967; c=relaxed/simple;
	bh=GqSzdtPdjPxrsbbL9DPSLfvweQpYlSvauhuw6B9v+yo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldyR+b3WXZ4VrxqVUM365ukmAu2UX+JLc3HQ1Jz2DVsq/WRiCfvFW3gCiJ/vNRtyfInCLOxjdNqeNCyp6JcgE8xMb4+cN0cIpGsdTMnoumllQ0zsiXqn1d7iFyAvZyi05TkAnbFdbmJfgbpVBEX/yBkaa06YSHKWQZZdaR2ztkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nies3/Wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2501DC116B1;
	Sun, 12 May 2024 12:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715516967;
	bh=GqSzdtPdjPxrsbbL9DPSLfvweQpYlSvauhuw6B9v+yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nies3/Wtxm3SMcljBcGmy7hStjB9jUgBV6tu3ji/v/2PZNxhT37L/p9XPGkx/FWZF
	 iXYHG4qYeYgvrb/RmE6nFO1g68luIS0f4zEZRSOSdpFmplQy/XOScfDJh2ZkE5G2tp
	 V+a+hlOdoCWHygju9F+k5/0I0B9uhheHQJRN2Z1Po4/vizbuFpsSDipB06oJ6lATNz
	 r7N7DV07ObnBf4ma6nDxxb2dFV2FeLLvDPnXGeGd0weEIwAHh94iakZ8490PEsIkhx
	 NU6ifkgKGuzuUSI2sNM/lQQB1VACDoM3Pg1HuAh5S/+5CPA8XEJu2L6GZwsN/y+a4N
	 2IVAmFGJsxQ0Q==
Date: Sun, 12 May 2024 13:29:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/9] iio: pressure: bmp280: Add SCALE, RAW values in
 channels and refactorize them
Message-ID: <20240512132914.34f2a571@jic23-huawei>
In-Reply-To: <20240508165207.145554-9-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
	<20240508165207.145554-9-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 18:52:06 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW channels in order
> to be able to calculate the processed value with standard userspace
> IIO tools. Can be used for triggered buffers as well.
> 
> Even though it is not a good design choice to have SCALE, RAW and
> PROCESSED together, the PROCESSED channel is kept for ABI compatibility.
> 
> While at it, separate BMPxxx and BMExxx device channels since BME
> supports also humidity measurements.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
num channels is now ARRAY_SIZE(xxx) for all of these rather than
the previous trick of using the same array and different numbers of channels.

As such I think you can just replace the 2, 3 with ARRAY_SIZE(bmp280_channels)
and ARRAY_SIZE(bme280_channels) which will give more obviously correct
and maintainable code.

Jonathan


> ---
>  drivers/iio/pressure/bmp280-core.c | 86 +++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 70ce37370ac6..3f8144a0355b 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -137,17 +137,45 @@ enum {
>  static const struct iio_chan_spec bmp280_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> +		/* PROCESSED maintained for ABI backwards compatibility */
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  	{
>  		.type = IIO_TEMP,
> +		/* PROCESSED maintained for ABI backwards compatibility */
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +};
> +
> +static const struct iio_chan_spec bme280_channels[] = {
> +	{
> +		.type = IIO_PRESSURE,
> +		/* PROCESSED maintained for ABI backwards compatibility */
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		/* PROCESSED maintained for ABI backwards compatibility */
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
> +		/* PROCESSED maintained for ABI backwards compatibility */
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  };
> @@ -155,21 +183,20 @@ static const struct iio_chan_spec bmp280_channels[] = {
>  static const struct iio_chan_spec bmp380_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> +		/* PROCESSED maintained for ABI backwards compatibility */
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  	},
>  	{
>  		.type = IIO_TEMP,
> +		/* PROCESSED maintained for ABI backwards compatibility */
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> -	},
> -	{
> -		.type = IIO_HUMIDITYRELATIVE,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> @@ -537,6 +564,49 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			ret = data->chip_info->read_humid(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_value;
> +			return IIO_VAL_INT;
> +		case IIO_PRESSURE:
> +			ret = data->chip_info->read_press(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_value;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			ret = data->chip_info->read_temp(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_value;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = data->chip_info->humid_coeffs[0];
> +			*val2 = data->chip_info->humid_coeffs[1];
> +			return data->chip_info->humid_coeffs_type;
> +		case IIO_PRESSURE:
> +			*val = data->chip_info->press_coeffs[0];
> +			*val2 = data->chip_info->press_coeffs[1];
> +			return data->chip_info->press_coeffs_type;
> +		case IIO_TEMP:
> +			*val = data->chip_info->temp_coeffs[0];
> +			*val2 = data->chip_info->temp_coeffs[1];
> +			return data->chip_info->temp_coeffs_type;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> @@ -903,7 +973,7 @@ const struct bmp280_chip_info bme280_chip_info = {
>  	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
>  	.regmap_config = &bmp280_regmap_config,
>  	.start_up_time = 2000,
> -	.channels = bmp280_channels,
> +	.channels = bme280_channels,
>  	.num_channels = 3,
>  
>  	.oversampling_temp_avail = bmp280_oversampling_avail,


