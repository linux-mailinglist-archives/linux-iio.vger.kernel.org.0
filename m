Return-Path: <linux-iio+bounces-11388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6F39B1D29
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E86281F2F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECE713B2B8;
	Sun, 27 Oct 2024 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRrT8wl3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391E13B288;
	Sun, 27 Oct 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023924; cv=none; b=P5HaXzfPRfyMFbQpWwJL48p+OxQL63Qv/+JBqIvr3r0yO+qkRz1GMW5RGumdGsG6HCnx+0G4eHBbTh3wVT63IK6YzZ/W2rtbUb4V58lEVy6yZD5aXrvdkEmDvR0gbR05YaOkMtFFcWqE3Ry4YPA3zNjhVjtzxOfFh2pI/Z92BSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023924; c=relaxed/simple;
	bh=/msXb7RDPyymc/+WoSkCjSBx4mLDlP2AeOLExiLzfmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjfOZppdW9F3diEk3kSdUtkmyIEV2ihj/LSC7gINdAuiiSsWMblcFGLyI2O6IfF8SoY4n3J0/GYCVMDBZnL1XT9yPpoJG7O/SBX2m31m9JMwjsz4X0/86NWnxSAGLgnW+kCQc9VnRgcwe90IHmGA+rN3/K45x66THTgdDJA0a9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRrT8wl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF67CC4CEC3;
	Sun, 27 Oct 2024 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730023923;
	bh=/msXb7RDPyymc/+WoSkCjSBx4mLDlP2AeOLExiLzfmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qRrT8wl30OyHpF03x2kmZ5si4C97xjdr8RJszK362ub0oz+mK8LIO8rQ7Dri2nr58
	 3pHzBDh0tx7VYUrc4Mzd8HIUvB1sXk/KiFAXl/oIa7YKD2yMumEDJru9dE2vvi2Q8Y
	 NIddczqwb8SdRZRXzGwNDxYVm6ffiVWeGH5UgDNnv8hkYsqpDXxHn2yHzidBe1Pt1Q
	 DVfaE477O/tIlYPz6HR+buzOMux09sJLaHOxefqpE/ZBHYwF3YAen3Qx93DYwNeikY
	 CKYYRrZkCOVfdU8OMNO24RCjjpu8aaPeRAaGRmseBRD8W8GSfI1uhqNhTjHlKjVExt
	 f0lJJ2LKINV4A==
Date: Sun, 27 Oct 2024 10:11:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/13] iio: chemical: bme680: generalize read_*()
 functions
Message-ID: <20241027101157.79969c0b@jic23-huawei>
In-Reply-To: <20241021195316.58911-8-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-8-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:10 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Remove the IIO specific scaling measurement units from the read functions
> and add them inside the ->read_raw() function to keep the read_*() generic.
> This way they can be used in other parts of the driver.
Applied.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 68 ++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 2ad427f5deb4..c79ba6d1ece8 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -644,23 +644,20 @@ static int bme680_gas_config(struct bme680_data *data)
>  	return ret;
>  }
>  
> -static int bme680_read_temp(struct bme680_data *data, int *val)
> +static int bme680_read_temp(struct bme680_data *data, s16 *comp_temp)
>  {
>  	int ret;
>  	u32 adc_temp;
> -	s16 comp_temp;
>  
>  	ret = bme680_read_temp_adc(data, &adc_temp);
>  	if (ret)
>  		return ret;
>  
> -	comp_temp = bme680_compensate_temp(data, adc_temp);
> -	*val = comp_temp * 10; /* Centidegrees to millidegrees */
> -	return IIO_VAL_INT;
> +	*comp_temp = bme680_compensate_temp(data, adc_temp);
> +	return 0;
>  }
>  
> -static int bme680_read_press(struct bme680_data *data,
> -			     int *val, int *val2)
> +static int bme680_read_press(struct bme680_data *data, u32 *comp_press)
>  {
>  	int ret;
>  	u32 adc_press;
> @@ -674,16 +671,14 @@ static int bme680_read_press(struct bme680_data *data,
>  	if (ret)
>  		return ret;
>  
> -	*val = bme680_compensate_press(data, adc_press, t_fine);
> -	*val2 = 1000;
> -	return IIO_VAL_FRACTIONAL;
> +	*comp_press = bme680_compensate_press(data, adc_press, t_fine);
> +	return 0;
>  }
>  
> -static int bme680_read_humid(struct bme680_data *data,
> -			     int *val, int *val2)
> +static int bme680_read_humid(struct bme680_data *data, u32 *comp_humidity)
>  {
>  	int ret;
> -	u32 adc_humidity, comp_humidity;
> +	u32 adc_humidity;
>  	s32 t_fine;
>  
>  	ret = bme680_get_t_fine(data, &t_fine);
> @@ -694,15 +689,11 @@ static int bme680_read_humid(struct bme680_data *data,
>  	if (ret)
>  		return ret;
>  
> -	comp_humidity = bme680_compensate_humid(data, adc_humidity, t_fine);
> -
> -	*val = comp_humidity;
> -	*val2 = 1000;
> -	return IIO_VAL_FRACTIONAL;
> +	*comp_humidity = bme680_compensate_humid(data, adc_humidity, t_fine);
> +	return 0;
>  }
>  
> -static int bme680_read_gas(struct bme680_data *data,
> -			   int *val)
> +static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
> @@ -737,9 +728,8 @@ static int bme680_read_gas(struct bme680_data *data,
>  	}
>  
>  	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
> -
> -	*val = bme680_compensate_gas(data, adc_gas_res, gas_range);
> -	return IIO_VAL_INT;
> +	*comp_gas_res = bme680_compensate_gas(data, adc_gas_res, gas_range);
> +	return 0;
>  }
>  
>  static int bme680_read_raw(struct iio_dev *indio_dev,
> @@ -747,7 +737,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  			   int *val, int *val2, long mask)
>  {
>  	struct bme680_data *data = iio_priv(indio_dev);
> -	int ret;
> +	int chan_val, ret;
>  
>  	guard(mutex)(&data->lock);
>  
> @@ -763,13 +753,35 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			return bme680_read_temp(data, val);
> +			ret = bme680_read_temp(data, (s16 *)&chan_val);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_val * 10;
> +			return IIO_VAL_INT;
>  		case IIO_PRESSURE:
> -			return bme680_read_press(data, val, val2);
> +			ret = bme680_read_press(data, &chan_val);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_val;
> +			*val2 = 1000;
> +			return IIO_VAL_FRACTIONAL;
>  		case IIO_HUMIDITYRELATIVE:
> -			return bme680_read_humid(data, val, val2);
> +			ret = bme680_read_humid(data, &chan_val);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_val;
> +			*val2 = 1000;
> +			return IIO_VAL_FRACTIONAL;
>  		case IIO_RESISTANCE:
> -			return bme680_read_gas(data, val);
> +			ret = bme680_read_gas(data, &chan_val);
> +			if (ret)
> +				return ret;
> +
> +			*val = chan_val;
> +			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
>  		}


