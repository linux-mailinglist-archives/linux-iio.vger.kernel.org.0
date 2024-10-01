Return-Path: <linux-iio+bounces-9974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F1998C603
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 21:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A151F23B26
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00891CCEDD;
	Tue,  1 Oct 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2CVzeZQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC481B5820;
	Tue,  1 Oct 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810889; cv=none; b=RKpAjq6Gq3jA0PmuzN+rC004IRCfSlWQbR0nFGreFC5lKNZJ/awPYrRyD8QUhlL9V0Zkpiow0HgdiYscV1/7u1HPL+uDzaQTCg0UvqTJaEqKDX66xClFrIiwkceQmBCUrqHsGpi0Lnvrw9YQhg3gq1ZQX+EAn2y2+vdO59jNDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810889; c=relaxed/simple;
	bh=o/HXJS2ilbTcUF8Q0y1amV1xf+TNoQP5GmSuaGnEVy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPD7VGkKDT2Ytg3Wtmy3ThdmG00IquGf5SgYZu1bBXy7IYNZ/KcGiY5wv9qBKOtvznZEMNT/iQ3DK+jUXt0G8izddd/1cmr3W+D3blQ9ocFPkS/yftrOFQVqtSwG3sJ4/kadHg6Wzzhs039+S+MgyP1sqomekE7OkKTOq55N+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2CVzeZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A698C4CEC6;
	Tue,  1 Oct 2024 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727810889;
	bh=o/HXJS2ilbTcUF8Q0y1amV1xf+TNoQP5GmSuaGnEVy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2CVzeZQ9mGMwPxu7w2Zh8Z7UIyOyrjb4pxRGdTfvI96l0i2CksdzfWyY/eDmjTOJ
	 6z2aUe6Hus1tadSF6nWMx+bByJN7sRiBwppZu9n1p8KnIE8EpfVUJI37QyO1BjUus2
	 gz1gIc2faoUjM5JwZWHJ/CQfUG8H1QH2WkieneKG1mLQhSOb3GbYR+hQVYzfUyU1lq
	 HjS9g01150CzE+LVpq0fpigdYrsGTNNL3X2JV3C5yjiOBtX4vRgs/SxSmFDfRzG/KH
	 w1vpch4/3ZoM/s3yBcRtYd4IzgYkE4VFdUMSaNKhnegdN7e2ejfxq3XhAmAdt54f6R
	 5A3A4xaDewuqg==
Date: Tue, 1 Oct 2024 20:28:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pac1921: remove unnecessary explicit casts
Message-ID: <20241001202802.65cf41eb@jic23-huawei>
In-Reply-To: <20240930-iio-pac1921-nocast-v2-1-cc349e137f75@gmail.com>
References: <20240930-iio-pac1921-nocast-v2-1-cc349e137f75@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 11:49:01 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Many explicit casts were introduced to address Wconversion and
> Wsign-compare warnings. Remove them to improve readability.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
> Link: https://lore.kernel.org/linux-iio/1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain/
Looks good to me.
I kept this link in the tags block as it's useful background on why
this patch exists

Applied to the togreg branch of iio.git and pushed out as testing
for now.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Reintroduce two necessary explicit casts that avoid 32-bit int overflow.
> - Link to v1: https://lore.kernel.org/r/20240916-iio-pac1921-nocast-v1-1-a0f96d321eee@gmail.com
> ---
>  drivers/iio/adc/pac1921.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index 4c2a1c07bc399028f0334885fc9cd4552d5892b1..a10b87b409c0149c88d7a5ad6e98e7b273c59a1f 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -241,7 +241,7 @@ static inline void pac1921_calc_scale(int dividend, int divisor, int *val,
>  	s64 tmp;
>  
>  	tmp = div_s64(dividend * (s64)NANO, divisor);
> -	*val = (int)div_s64_rem(tmp, NANO, val2);
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
> @@ -400,10 +399,10 @@ static int pac1921_read_raw(struct iio_dev *indio_dev,
>  			s64 tmp = curr_scale[0] * (s64)NANO + curr_scale[1];
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
> @@ -426,7 +425,7 @@ static int pac1921_read_raw(struct iio_dev *indio_dev,
>  		 * 1/(integr_period_usecs/MICRO) = MICRO/integr_period_usecs
>  		 */
>  		*val = MICRO;
> -		*val2 = (int)priv->integr_period_usecs;
> +		*val2 = priv->integr_period_usecs;
>  		return IIO_VAL_FRACTIONAL;
>  
>  	default:
> @@ -503,7 +502,7 @@ static int pac1921_lookup_scale(const int (*const scales_tbl)[2], size_t size,
>  	for (unsigned int i = 0; i < size; i++)
>  		if (scales_tbl[i][0] == scale_val &&
>  		    scales_tbl[i][1] == scale_val2)
> -			return (int)i;
> +			return i;
>  
>  	return -EINVAL;
>  }
> @@ -553,7 +552,7 @@ static int pac1921_update_gain_from_scale(struct pac1921_priv *priv,
>  		if (ret < 0)
>  			return ret;
>  
> -		return pac1921_update_gain(priv, &priv->dv_gain, (u8)ret,
> +		return pac1921_update_gain(priv, &priv->dv_gain, ret,
>  					   PAC1921_GAIN_DV_GAIN_MASK);
>  	case PAC1921_CHAN_VSENSE:
>  		ret = pac1921_lookup_scale(pac1921_vsense_scales,
> @@ -562,7 +561,7 @@ static int pac1921_update_gain_from_scale(struct pac1921_priv *priv,
>  		if (ret < 0)
>  			return ret;
>  
> -		return pac1921_update_gain(priv, &priv->di_gain, (u8)ret,
> +		return pac1921_update_gain(priv, &priv->di_gain, ret,
>  					   PAC1921_GAIN_DI_GAIN_MASK);
>  	case PAC1921_CHAN_CURRENT:
>  		ret = pac1921_lookup_scale(priv->current_scales,
> @@ -571,7 +570,7 @@ static int pac1921_update_gain_from_scale(struct pac1921_priv *priv,
>  		if (ret < 0)
>  			return ret;
>  
> -		return pac1921_update_gain(priv, &priv->di_gain, (u8)ret,
> +		return pac1921_update_gain(priv, &priv->di_gain, ret,
>  					   PAC1921_GAIN_DI_GAIN_MASK);
>  	default:
>  		return -EINVAL;
> @@ -586,7 +585,7 @@ static int pac1921_lookup_int_num_samples(int num_samples)
>  {
>  	for (unsigned int i = 0; i < ARRAY_SIZE(pac1921_int_num_samples); i++)
>  		if (pac1921_int_num_samples[i] == num_samples)
> -			return (int)i;
> +			return i;
>  
>  	return -EINVAL;
>  }
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


