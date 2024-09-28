Return-Path: <linux-iio+bounces-9827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB84C98900F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812C8B213F7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C1923774;
	Sat, 28 Sep 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxm2onWz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E82282EA;
	Sat, 28 Sep 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727537331; cv=none; b=jusJmzba3r834/fcApAwrLwfzsj5nv7l6dowk6FUN4fd93dAjUzlhfAokAGOQHw4S1gIpt3M0a+o4iNLpUb+1DHM41GEIqq0MY60e6eOSRnVip6KtLrPXArasKnHHLPZZ80fEQuf08se/ovtdFDVijlKr2ahAQ+1Kz00Qzes5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727537331; c=relaxed/simple;
	bh=QXAydQx6KHSQ7jClR6YD5k/TAcfpS6PqpYpDhQCGplw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDflydREwPFLeSFwpXf5UyX78bU2FlZXmjufPpEZLmikwZij+lJVRLazspvbI07X1gzKRsrwkGFeJVlsNnP7ZABV5Xdr8q8Gaos80magB9QPFvch4FGTDd39JWGmgC1QHCTAPkbTjJvLFX9A8P+JgTv0fio4g5dM8hGHW4dTsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxm2onWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09903C4CEC3;
	Sat, 28 Sep 2024 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727537330;
	bh=QXAydQx6KHSQ7jClR6YD5k/TAcfpS6PqpYpDhQCGplw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pxm2onWzCAXPiIOqpuPBPMTyF7arc97fTpsC55Mydki24/lvRdHaWqAhjtaDT6z/H
	 +uMwbvYLMEay1eXw2AN7EiP0nS4O3HChxMQK6GWrdIDOfq5MNGioZJV62X87EUHAeB
	 E1uFUQ6wRkc3CEmLH0wcqR58juUB9N3yzqBtJr4YGxwc50wrzdc4QGJp16UcMEUh1E
	 b1UBLvQk6lyhcrjBIPa2LQN5Y2W57xbXKhDJh8ZDqGWR4/QmdnGFFkedv21EdDbWJr
	 bjFDXQinza41AYgwEmMt/k2+MgowSJqcSn3qNfzg46z1iU/D/S8AZKUjUXObXVhmft
	 SM7PhCIQEUuIA==
Date: Sat, 28 Sep 2024 16:28:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pac1921: remove unnecessary explicit casts
Message-ID: <20240928162843.4eb63f29@jic23-huawei>
In-Reply-To: <20240916-iio-pac1921-nocast-v1-1-a0f96d321eee@gmail.com>
References: <20240916-iio-pac1921-nocast-v1-1-a0f96d321eee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 14:00:05 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Many explicit casts were introduced to address Wconversion and
> Wsign-compare warnings. Remove them to improve readability.
> 
> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")

No fixes tag on this one. Its not a bug, just a readability improvement.

> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
There are a few cases in here where I think the cast is about ensuring
we don't overflow in the maths rather than for warning suppression.

We all love 32 bit architectures after all ;)

Jonathan

> ---
> Link: https://lore.kernel.org/linux-iio/1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain/
> ---
>  drivers/iio/adc/pac1921.c | 43 +++++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index 4c2a1c07bc39..de69a1619a9e 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -240,8 +240,8 @@ static inline void pac1921_calc_scale(int dividend, int divisor, int *val,
>  {
>  	s64 tmp;
>  
> -	tmp = div_s64(dividend * (s64)NANO, divisor);
> -	*val = (int)div_s64_rem(tmp, NANO, val2);
> +	tmp = div_s64(dividend * NANO, divisor);

For this one, NANO is an unsigned long and dividend just an int.
Either the s64 cast is needed because dividend * NANO might go out of
unsigned long range which might (I think) be 32 bit on a 32bit machine
or it doesn't.  If it does, then you need the cast, if not you don't
need to use div_s64 as it's not that large.

> +	*val = div_s64_rem(tmp, NANO, val2);
>  }
>  
>  /*
> @@ -260,7 +260,7 @@ static void pac1921_calc_current_scales(struct pac1921_priv *priv)
>  		int max = (PAC1921_MAX_VSENSE_MV * MICRO) >> i;
>  		int vsense_lsb = DIV_ROUND_CLOSEST(max, PAC1921_RES_RESOLUTION);
>  
> -		pac1921_calc_scale(vsense_lsb, (int)priv->rshunt_uohm,
> +		pac1921_calc_scale(vsense_lsb, priv->rshunt_uohm,
>  				   &priv->current_scales[i][0],
>  				   &priv->current_scales[i][1]);
>  	}
> @@ -314,7 +314,7 @@ static int pac1921_check_push_overflow(struct iio_dev *indio_dev, s64 timestamp)
>  			       timestamp);
>  	}
>  
> -	priv->prev_ovf_flags = (u8)flags;
> +	priv->prev_ovf_flags = flags;
>  
>  	return 0;
>  }
> @@ -329,8 +329,7 @@ static int pac1921_check_push_overflow(struct iio_dev *indio_dev, s64 timestamp)
>  static int pac1921_read_res(struct pac1921_priv *priv, unsigned long reg,
>  			    u16 *val)
>  {
> -	int ret = regmap_bulk_read(priv->regmap, (unsigned int)reg, val,
> -				   sizeof(*val));
> +	int ret = regmap_bulk_read(priv->regmap, reg, val, sizeof(*val));
>  	if (ret)
>  		return ret;
>  
> @@ -366,7 +365,7 @@ static int pac1921_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		*val = (int)res_val;
> +		*val = res_val;
>  
>  		return IIO_VAL_INT;
>  	}
> @@ -397,13 +396,13 @@ static int pac1921_read_raw(struct iio_dev *indio_dev,
>  			int *curr_scale = priv->current_scales[priv->di_gain];
>  
>  			/* Convert current_scale from INT_PLUS_NANO to INT */
> -			s64 tmp = curr_scale[0] * (s64)NANO + curr_scale[1];
> +			s64 tmp = curr_scale[0] * NANO + curr_scale[1];
Same potential issue as above. NANO and curr_scale might be 32 bit in which
case I believe this can overflow?

>  
>  			/* Multiply by max_vbus (V) / dv_gain */
> -			tmp *= PAC1921_MAX_VBUS_V >> (int)priv->dv_gain;
> +			tmp *= PAC1921_MAX_VBUS_V >> priv->dv_gain;
>  
>  			/* Convert back to INT_PLUS_NANO */
> -			*val = (int)div_s64_rem(tmp, NANO, val2);
> +			*val = div_s64_rem(tmp, NANO, val2);
>  
>  			return IIO_VAL_INT_PLUS_NANO;
>  		}
...

> @@ -607,7 +606,7 @@ static int pac1921_update_int_num_samples(struct pac1921_priv *priv,
>  	if (ret < 0)
>  		return ret;
>  
> -	n_samples = (u8)ret;
> +	n_samples = ret;
>  
>  	if (priv->n_samples == n_samples)
>  		return 0;
> @@ -770,7 +769,7 @@ static ssize_t pac1921_read_shunt_resistor(struct iio_dev *indio_dev,
>  
>  	guard(mutex)(&priv->lock);
>  
> -	vals[0] = (int)priv->rshunt_uohm;
> +	vals[0] = priv->rshunt_uohm;
>  	vals[1] = MICRO;
>  
>  	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
> @@ -793,13 +792,13 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	rshunt_uohm = (u32)val * MICRO + (u32)val_fract;
> +	rshunt_uohm = val * MICRO + val_fract;
>  	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
>  		return -EINVAL;
>  
>  	guard(mutex)(&priv->lock);
>  
> -	priv->rshunt_uohm = (u32)rshunt_uohm;
> +	priv->rshunt_uohm = rshunt_uohm;
>  
>  	pac1921_calc_current_scales(priv);
>  
> @@ -1168,7 +1167,7 @@ static int pac1921_probe(struct i2c_client *client)
>  
>  	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
>  	if (IS_ERR(priv->regmap))
> -		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
>  				     "Cannot initialize register map\n");
>  
>  	devm_mutex_init(dev, &priv->lock);
> @@ -1191,7 +1190,7 @@ static int pac1921_probe(struct i2c_client *client)
>  
>  	priv->vdd = devm_regulator_get(dev, "vdd");
>  	if (IS_ERR(priv->vdd))
> -		return dev_err_probe(dev, (int)PTR_ERR(priv->vdd),
> +		return dev_err_probe(dev, PTR_ERR(priv->vdd),
>  				     "Cannot get vdd regulator\n");
>  
>  	ret = regulator_enable(priv->vdd);
> 
> ---
> base-commit: fec496684388685647652ab4213454fbabdab099
> change-id: 20240911-iio-pac1921-nocast-5c98cdeec059
> 
> Best regards,


