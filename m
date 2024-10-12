Return-Path: <linux-iio+bounces-10497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CDB99B49A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B999B23F8E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4819D081;
	Sat, 12 Oct 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmmNXMtp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B2161310;
	Sat, 12 Oct 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733732; cv=none; b=h4yYehQ6kyFw6zVMb43zgM/rAmiS5MZNQD2Z+1/n6Xh78iETTx4uVrIwOuTIdIjUOHvasNzWbxKdXeB5p3+LxvbzNNZaDfgc7THzESXPCNdAoM/V+PrZUQd+mQkItzyKCATtl2+n2dRqe3nixFS3t61wRZEjXvBdoiWO826qCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733732; c=relaxed/simple;
	bh=St8PdnurIlPGKo2cMXY48AEAM4yJRD/mF3SjGRaLnCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYFpnhl7mmm3WOUV3FhvfQyHbv8i6FFcxZF/MM4AE/x47OIMgLujNntV1rAb7jnYRd9xLyP5pjT/KjYpJhLm4DSFWI5sOEMXQtgcMieiTwONBP1np4Com1hYp+ph6/hXoELn6Rt5TkMZEHvGY1sUr72XzFGvabdV0dv+tyCGX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmmNXMtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AB9C4CEC6;
	Sat, 12 Oct 2024 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728733732;
	bh=St8PdnurIlPGKo2cMXY48AEAM4yJRD/mF3SjGRaLnCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmmNXMtp4rowjQ9QGdP+wMcXwKZPO+Mct8oR5NiYNnaVpXdrfUHg2dgt8CAMWxLVp
	 llySiZa4J36xyOf5len7xHdxIcSJpW17JGE9OGC9P1jaAUHjEjshiAz8d8vNhZejq7
	 uwwreKgG/p2tbeVb8ToPSjpdxtgB9KCb6FUskd5ArxJd83rAOM2bhL1vBoQbQRSfza
	 ta68HtQtlyTY9iPj8nyxu0M7NGdG1ADhw0dGX785E6FuFqZCtQBchq6/pdSI91lesJ
	 1IYRd9pwH/SbLNUCJLw/CL1IS2hlYUfiRFM6jyr3Zo1EgVkrMr0NdqDYJr1lMzzhPq
	 hsfk/J40i83Fw==
Date: Sat, 12 Oct 2024 12:48:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: vamoirid <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
 andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/13] iio: chemical: bme680: refactorize set_mode()
 mode
Message-ID: <20241012124838.24f6ab8d@jic23-huawei>
In-Reply-To: <20241010210030.33309-6-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 23:00:22 +0200
vamoirid <vassilisamir@gmail.com> wrote:

> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Refactorize the set_mode() function to use an external enum that
> describes the possible modes of the BME680 device instead of using
> true/false variables for selecting SLEEPING/FORCED mode.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 36 ++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 9e843e463502..dedb7edaf43d 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -95,6 +95,11 @@ struct bme680_calib {
>  	s8  range_sw_err;
>  };
>  
> +enum bme680_op_mode {
> +	BME680_SLEEP,
> +	BME680_FORCED,
> +};
> +
>  struct bme680_data {
>  	struct regmap *regmap;
>  	struct bme680_calib bme680;
> @@ -501,25 +506,24 @@ static u8 bme680_calc_heater_dur(u16 dur)
>  	return durval;
>  }
>  
> -static int bme680_set_mode(struct bme680_data *data, bool mode)
> +static int bme680_set_mode(struct bme680_data *data, enum bme680_op_mode mode)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
> -	if (mode) {
> -		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> -					BME680_MODE_MASK, BME680_MODE_FORCED);
> -		if (ret < 0)
> -			dev_err(dev, "failed to set forced mode\n");
> -
> -	} else {
> -		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> -					BME680_MODE_MASK, BME680_MODE_SLEEP);
> -		if (ret < 0)
> -			dev_err(dev, "failed to set sleep mode\n");
> -
> +	switch (mode) {
> +	case BME680_SLEEP:
> +	case BME680_FORCED:
You are passing in an enum that currently has no other values.
The compiler should complain if it isn't one of these (and it can tell)

So unless I'm missing you adding another enum value later, this switch
should be unnecessary.


> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> +	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +				BME680_MODE_MASK, mode);
> +	if (ret < 0)
> +		dev_err(dev, "failed to set ctrl_meas register\n");
> +
>  	return ret;
>  }
>  
> @@ -612,8 +616,7 @@ static int bme680_gas_config(struct bme680_data *data)
>  	int ret;
>  	u8 heatr_res, heatr_dur;
>  
> -	/* Go to sleep */
> -	ret = bme680_set_mode(data, false);
> +	ret = bme680_set_mode(data, BME680_SLEEP);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -750,8 +753,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  
>  	guard(mutex)(&data->lock);
>  
> -	/* set forced mode to trigger measurement */
> -	ret = bme680_set_mode(data, true);
> +	ret = bme680_set_mode(data, BME680_FORCED);
>  	if (ret < 0)
>  		return ret;
>  


