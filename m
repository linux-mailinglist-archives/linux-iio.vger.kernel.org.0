Return-Path: <linux-iio+bounces-12914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C639DF59B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F47216204E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5041C32FD;
	Sun,  1 Dec 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjKm+X5T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8F18A932;
	Sun,  1 Dec 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057728; cv=none; b=ME+hZ4HBvWkLQHOHoaAdGYtHRx83c59hNy5tjWcnCWtUBI3h6LPqNWzYe4MxKOCwWDjXT5f/FrAtJHtQbPLcZVdUKRjPx00oorPQ/drbh9alrrKbyM8PmSUFvkOtfekZNSc1eS76nF7PmfasAGPtO3pKg06nKVIeziaBPDfpZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057728; c=relaxed/simple;
	bh=+wExzTFQM8nAve73xnTS4Dc8Iv9ma5WmvnqKO14ZKkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbckjBQSE2HJkf1UiCxif8MFPgBlje2Vx7V6g6v6MT9WLy5QPTIKRhLUQV/kIcQzHdWU9/2plnGtkHd30zYRyER09rsbaMjYotLpPaGsYldIEfmv285iTLlE9AhdJVn+3Xqeb011/xtJ6n03RtomLN3QM5oGwbE83yxSykJgKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjKm+X5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29958C4CECF;
	Sun,  1 Dec 2024 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733057728;
	bh=+wExzTFQM8nAve73xnTS4Dc8Iv9ma5WmvnqKO14ZKkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EjKm+X5TsDeRu2LYkynq7HbezMY9D1Jk2/dOPBpl6uEJBT1tzmMNhIhhegG+hJv9u
	 DAlafUYOu0MoHnwTMutTGPsYZIWDeyxBl3jZ+wugs3WZlf8bfSnedW8Hfu2WhhnP3m
	 ydKWaRVxMLcnw5rRpW808yU0ijQ0lwjfbxHIxiVQ2zEpecJoJibgbL6uVhEvA5mh48
	 88Gx67Fa/PI26uGXTcEa6klm4/OUi+JKGe4OOkXcVoxdvU855bxs6YSyua9HY+6liM
	 Ya8cgOu1xCPZem0yE9MDAc/GBg/VB3pDI8SevKl6WqwEmWU+MRc34/mMGfhNt0apLz
	 fbFYs6Bhf9UkA==
Date: Sun, 1 Dec 2024 12:55:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: dlechner@baylibre.com, lars@metafoo.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tgamblin@baylibre.com, fabrice.gasnier@st.com,
 benjamin.gaignard@linaro.org, lee@kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
Message-ID: <20241201125518.29373281@jic23-huawei>
In-Reply-To: <20241123220149.30655-1-jiashengjiangcool@gmail.com>
References: <20241123220149.30655-1-jiashengjiangcool@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Nov 2024 22:01:49 +0000
Jiasheng Jiang <jiashengjiangcool@gmail.com> wrote:

> Add check for the return value of clk_enable() in order to catch the
> potential exception.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Applied.

thanks,

Jonathan

> ---
> Changelog:
> 
> v4 -> v5:
> 
> 1. Add a default in the switch.
> 
> v3 -> v4:
> 
> 1. Place braces around the case body.
> 
> v2 -> v3:
> 
> 1. Use guard() to simplify the resulting code.
> 
> v1 -> v2:
> 
> 1. Remove unsuitable dev_err_probe().
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 49 ++++++++++++++---------
>  1 file changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 0684329956d9..67528ec7d0a5 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -119,7 +119,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  			     unsigned int frequency)
>  {
>  	unsigned long long prd, div;
> -	int prescaler = 0;
> +	int prescaler = 0, ret;
>  	u32 ccer;
>  
>  	/* Period and prescaler values depends of clock rate */
> @@ -150,10 +150,12 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  	if (ccer & TIM_CCER_CCXE)
>  		return -EBUSY;
>  
> -	mutex_lock(&priv->lock);
> +	guard(mutex)(&priv->lock);
>  	if (!priv->enabled) {
>  		priv->enabled = true;
> -		clk_enable(priv->clk);
> +		ret = clk_enable(priv->clk);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	regmap_write(priv->regmap, TIM_PSC, prescaler);
> @@ -173,7 +175,6 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  
>  	/* Enable controller */
>  	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> -	mutex_unlock(&priv->lock);
>  
>  	return 0;
>  }
> @@ -307,7 +308,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	u32 mask, shift, master_mode_max;
> -	int i;
> +	int i, ret;
>  
>  	if (stm32_timer_is_trgo2_name(trig->name)) {
>  		mask = TIM_CR2_MMS2;
> @@ -322,15 +323,16 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  	for (i = 0; i <= master_mode_max; i++) {
>  		if (!strncmp(master_mode_table[i], buf,
>  			     strlen(master_mode_table[i]))) {
> -			mutex_lock(&priv->lock);
> +			guard(mutex)(&priv->lock);
>  			if (!priv->enabled) {
>  				/* Clock should be enabled first */
>  				priv->enabled = true;
> -				clk_enable(priv->clk);
> +				ret = clk_enable(priv->clk);
> +				if (ret)
> +					return ret;
>  			}
>  			regmap_update_bits(priv->regmap, TIM_CR2, mask,
>  					   i << shift);
> -			mutex_unlock(&priv->lock);
>  			return len;
>  		}
>  	}
> @@ -482,6 +484,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  				   int val, int val2, long mask)
>  {
>  	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -491,12 +494,14 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  		/* fixed scale */
>  		return -EINVAL;
>  
> -	case IIO_CHAN_INFO_ENABLE:
> -		mutex_lock(&priv->lock);
> +	case IIO_CHAN_INFO_ENABLE: {
> +		guard(mutex)(&priv->lock);
>  		if (val) {
>  			if (!priv->enabled) {
>  				priv->enabled = true;
> -				clk_enable(priv->clk);
> +				ret = clk_enable(priv->clk);
> +				if (ret)
> +					return ret;
>  			}
>  			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>  		} else {
> @@ -506,11 +511,12 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  				clk_disable(priv->clk);
>  			}
>  		}
> -		mutex_unlock(&priv->lock);
> +
>  		return 0;
>  	}
> -
> -	return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static int stm32_counter_validate_trigger(struct iio_dev *indio_dev,
> @@ -601,7 +607,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>  				 unsigned int mode)
>  {
>  	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> -	int sms = stm32_enable_mode2sms(mode);
> +	int sms = stm32_enable_mode2sms(mode), ret;
>  
>  	if (sms < 0)
>  		return sms;
> @@ -609,12 +615,15 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>  	 * Triggered mode sets CEN bit automatically by hardware. So, first
>  	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
>  	 */
> -	mutex_lock(&priv->lock);
> -	if (sms == 6 && !priv->enabled) {
> -		clk_enable(priv->clk);
> -		priv->enabled = true;
> +	scoped_guard(mutex, &priv->lock) {
> +		if (sms == 6 && !priv->enabled) {
> +			ret = clk_enable(priv->clk);
> +			if (ret)
> +				return ret;
> +
> +			priv->enabled = true;
> +		}
>  	}
> -	mutex_unlock(&priv->lock);
>  
>  	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
>  


