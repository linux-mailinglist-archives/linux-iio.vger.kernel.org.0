Return-Path: <linux-iio+bounces-11384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618E9B1D05
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D451F21256
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AEF139D0A;
	Sun, 27 Oct 2024 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeucYOb5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4151136341;
	Sun, 27 Oct 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023187; cv=none; b=sN5b65aDGZl/93LNARbNfdOaZOSHUquqIoCgkmFT+t0WT/3qtiTkYMnYgANbJ/3RL/kS99Q7jBXAWkpnflLEKVq9Gmt6BdefDrY002AaD1v4vRa89OJEZ+maOx9F9l57upya9zC5wGNOCAn5cPLJ+W1JgGTKEK0YjX5HrR12kNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023187; c=relaxed/simple;
	bh=O0hQM6KZERMVy3uoZ3O8dy8KKqfCMHfwWruV3FnzCdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6p3XbBBYZonL+VXhgqa4vTzPRMaurFMS+bwXaWUUlmuVjUyZbShsmPdrwU6cPI2H2szXZEw88I/w6NG3APdY8KKfxsvOWANSLuoAbqOrQCCZwnbXeRpZ3enLvnEHY2BwLcAd1vkVmUWNJapT6229F8uGcqer6qPTz/5aDdC4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeucYOb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3F4C4CEC3;
	Sun, 27 Oct 2024 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730023187;
	bh=O0hQM6KZERMVy3uoZ3O8dy8KKqfCMHfwWruV3FnzCdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GeucYOb59Q6XO4PXaFUYbfKWcWW5S2P+eZ884WbHzF4/IqLzMQHBIgk+qJwiwljWc
	 Gu1HdvHg4H9y8FaW7sYs4Z9Yo2A6vS6jPhfLdbOuMY1B/pdyw7r0yiIEp84zzHXyxw
	 yahKxWZhzFf9Q+lK0yXelCFb/tdrrhAdAxxAiYE6hdJX2qkAoEobtFO5z/zN0mGvZX
	 OZUFdsKsslzaSxXkYomtgbn49nTAdkdbLx6Znhh/45DRnCi4ccHZrFmmtRc0vkgiGJ
	 vn6M9YjJR5DoWI2OKesfsH8pcrhGzjjPbMA+SxgWGfExv5FFkXMGMG2OxgXSPp9i56
	 LKm7ag9KmMnsw==
Date: Sun, 27 Oct 2024 09:59:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] iio: chemical: bme680: refactorize set_mode()
 mode
Message-ID: <20241027095939.5ad376ad@jic23-huawei>
In-Reply-To: <20241021195316.58911-5-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:07 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Refactorize the set_mode() function to use an external enum that
> describes the possible modes of the BME680 device instead of using
> true/false variables for selecting SLEEPING/FORCED mode.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
I changed my mind on this one...

> ---
>  drivers/iio/chemical/bme680_core.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index d228f90b4dc6..9002519d2c33 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -95,6 +95,11 @@ struct bme680_calib {
>  	s8  range_sw_err;
>  };
>  
> +enum bme680_op_mode {
> +	BME680_SLEEP,
> +	BME680_FORCED,
Use this enum to replace the existing BME680_MODE_SLEEP etc definitions
rather than adding another one.
Also assign explicit values as you are going to write this into a register
so they matter.


> +};
> +
>  struct bme680_data {
>  	struct regmap *regmap;
>  	struct bme680_calib bme680;
> @@ -502,23 +507,16 @@ static u8 bme680_calc_heater_dur(u16 dur)
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
> +	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +				BME680_MODE_MASK, mode);
This is the problematic code.  No obvious reason the enum should match the original
values. It does, but that should be made true by only having an enum, not definitions
and an enum.

> +	if (ret < 0) {
> +		dev_err(dev, "failed to set ctrl_meas register\n");
> +		return ret;
>  	}
>  
>  	return ret;
> @@ -615,8 +613,7 @@ static int bme680_gas_config(struct bme680_data *data)
>  	int ret;
>  	u8 heatr_res, heatr_dur;
>  
> -	/* Go to sleep */
> -	ret = bme680_set_mode(data, false);
> +	ret = bme680_set_mode(data, BME680_SLEEP);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -756,8 +753,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  
>  	guard(mutex)(&data->lock);
>  
> -	/* set forced mode to trigger measurement */
> -	ret = bme680_set_mode(data, true);
> +	ret = bme680_set_mode(data, BME680_FORCED);
>  	if (ret < 0)
>  		return ret;
>  


