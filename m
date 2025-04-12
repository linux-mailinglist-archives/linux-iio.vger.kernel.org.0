Return-Path: <linux-iio+bounces-18003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB3A86CC9
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9FD7B2C76
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96DB1D8DEE;
	Sat, 12 Apr 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1F/+HU6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8E155382;
	Sat, 12 Apr 2025 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744457516; cv=none; b=kagTpx1MZ/NUPUTHtsVRA6CAFVyiBJveN4AWXhdDnEl0E8mtaulDRQqGyYCOKQoKSp1T4tXfsA66YOyphXn3DRI9tKBXuRSWDO50yjV3+R9LMWA1iBUggAlCyM9kJARlUj0Pv06RKr48dCxxzpRtixst6XfMZPNLOaVJH3r3N0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744457516; c=relaxed/simple;
	bh=Q/XDAnnrTFh+gGcYvTYdzvUbJSofwqgwFXv1Q4LryyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+o0S07hIJl5SORFiiQd2ozW+a023C3EbGqjeacMZAuD5xwYNaBJ4htpCM8iGiL4d2ItWfNZYFj8+EiUB4BPX/5IT/m3BaeTGsuQLv79vS1IKeqQrnp5p6n6XkZL/4pPirzNkQcSKRWZJ3+aYqwUh/p24jwK45bjbCuUCLbRIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1F/+HU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADDEC4CEE3;
	Sat, 12 Apr 2025 11:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744457515;
	bh=Q/XDAnnrTFh+gGcYvTYdzvUbJSofwqgwFXv1Q4LryyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U1F/+HU66v4A3k/MfjlGq6viUiOl1nwo2sEzGfIqcqMLjunxFMTzo/D3gLYYoVlAJ
	 2n02EpWP5cxz0L3EF5P1mxoTE9ptEMeN1K9GrmkHdEioGRXjc/r9kFM/ETErSJe/Dm
	 9qNh9ZjDETI7WOyNEuE5X5N3uixS+LSRMPBuQkjTbT95rNTkkxoFPwpeROQwyefpst
	 4ULwEYJQnP4hYBodMOqfaj0BQVlkWJYAgcd5hZj6EUclpFx8t1U5MuvXx9km1kPOW+
	 crJEvJDk8WjOmNo4S4ipKbi8QBkS6Zu8pmlCrRhsh7yBmWmX9suja693aitMlw9NC2
	 SLzZWPhoExI/w==
Date: Sat, 12 Apr 2025 12:31:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Linus Walleij <linus.walleij@linaro.org>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/7] iio: dac: ad5592r: use lock guards
Message-ID: <20250412123148.00124102@jic23-huawei>
In-Reply-To: <20250409-gpiochip-set-rv-iio-v2-2-4b36428f39cb@linaro.org>
References: <20250409-gpiochip-set-rv-iio-v2-0-4b36428f39cb@linaro.org>
	<20250409-gpiochip-set-rv-iio-v2-2-4b36428f39cb@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Apr 2025 10:40:40 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use lock guards from linux/cleanup.h to simplify the code and remove
> some labels.
> 
> Note that we need to initialize some variables even though it's not
> technically required as scoped_guards() are implemented as for loops.
Needed a tweak for my llvm test build to work.
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index ada60f5ff1b6..32e63a159d86 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -414,7 +414,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
                *val2 = chan->scan_type.realbits;
 
                return IIO_VAL_FRACTIONAL_LOG2;
-       case IIO_CHAN_INFO_OFFSET:
+       case IIO_CHAN_INFO_OFFSET: {
                ret = ad5592r_get_vref(st);
 
                guard(mutex)(&st->lock);
@@ -425,6 +425,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
                        *val = (-75365 * 25) / ret;
 
                return IIO_VAL_INT;
+       }
        default:
                return -EINVAL;
        }

Scope gets messy in switch statements.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/iio/dac/ad5592r-base.c | 132 +++++++++++++++++------------------------
>  1 file changed, 54 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index eb85907f61ae..ada60f5ff1b6 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
> @@ -24,16 +25,14 @@ static int ad5592r_gpio_get(struct gpio_chip *chip, unsigned offset)
>  {
>  	struct ad5592r_state *st = gpiochip_get_data(chip);
>  	int ret = 0;
> -	u8 val;
> +	u8 val = 0;
>  
> -	mutex_lock(&st->gpio_lock);
> -
> -	if (st->gpio_out & BIT(offset))
> -		val = st->gpio_val;
> -	else
> -		ret = st->ops->gpio_read(st, &val);
> -
> -	mutex_unlock(&st->gpio_lock);
> +	scoped_guard(mutex, &st->gpio_lock) {
> +		if (st->gpio_out & BIT(offset))
> +			val = st->gpio_val;
> +		else
> +			ret = st->ops->gpio_read(st, &val);
> +	}
>  
>  	if (ret < 0)
>  		return ret;
> @@ -45,7 +44,7 @@ static void ad5592r_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  {
>  	struct ad5592r_state *st = gpiochip_get_data(chip);
>  
> -	mutex_lock(&st->gpio_lock);
> +	guard(mutex)(&st->gpio_lock);
>  
>  	if (value)
>  		st->gpio_val |= BIT(offset);
> @@ -53,8 +52,6 @@ static void ad5592r_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  		st->gpio_val &= ~BIT(offset);
>  
>  	st->ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
> -
> -	mutex_unlock(&st->gpio_lock);
>  }
>  
>  static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
> @@ -62,21 +59,16 @@ static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>  	struct ad5592r_state *st = gpiochip_get_data(chip);
>  	int ret;
>  
> -	mutex_lock(&st->gpio_lock);
> +	guard(mutex)(&st->gpio_lock);
>  
>  	st->gpio_out &= ~BIT(offset);
>  	st->gpio_in |= BIT(offset);
>  
>  	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
>  	if (ret < 0)
> -		goto err_unlock;
> +		return ret;
>  
> -	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
> -
> -err_unlock:
> -	mutex_unlock(&st->gpio_lock);
> -
> -	return ret;
> +	return st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
>  }
>  
>  static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
> @@ -85,7 +77,7 @@ static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
>  	struct ad5592r_state *st = gpiochip_get_data(chip);
>  	int ret;
>  
> -	mutex_lock(&st->gpio_lock);
> +	guard(mutex)(&st->gpio_lock);
>  
>  	if (value)
>  		st->gpio_val |= BIT(offset);
> @@ -97,18 +89,13 @@ static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
>  
>  	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
>  	if (ret < 0)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
>  	if (ret < 0)
> -		goto err_unlock;
> +		return ret;
>  
> -	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
> -
> -err_unlock:
> -	mutex_unlock(&st->gpio_lock);
> -
> -	return ret;
> +	return st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
>  }
>  
>  static int ad5592r_gpio_request(struct gpio_chip *chip, unsigned offset)
> @@ -171,10 +158,9 @@ static int ad5592r_reset(struct ad5592r_state *st)
>  		udelay(1);
>  		gpiod_set_value(gpio, 1);
>  	} else {
> -		mutex_lock(&st->lock);
> -		/* Writing this magic value resets the device */
> -		st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
> -		mutex_unlock(&st->lock);
> +		scoped_guard(mutex, &st->lock)
> +			/* Writing this magic value resets the device */
> +			st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
>  	}
>  
>  	udelay(250);
> @@ -249,46 +235,44 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
>  		}
>  	}
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	/* Pull down unused pins to GND */
>  	ret = ops->reg_write(st, AD5592R_REG_PULLDOWN, pulldown);
>  	if (ret)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = ops->reg_write(st, AD5592R_REG_TRISTATE, tristate);
>  	if (ret)
> -		goto err_unlock;
> +		return ret;
>  
>  	/* Configure pins that we use */
>  	ret = ops->reg_write(st, AD5592R_REG_DAC_EN, dac);
>  	if (ret)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = ops->reg_write(st, AD5592R_REG_ADC_EN, adc);
>  	if (ret)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
>  	if (ret)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
>  	if (ret)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
>  	if (ret)
> -		goto err_unlock;
> +		return ret;
>  
>  	/* Verify that we can read back at least one register */
>  	ret = ops->reg_read(st, AD5592R_REG_ADC_EN, &read_back);
>  	if (!ret && (read_back & 0xff) != adc)
> -		ret = -EIO;
> +		return -EIO;
>  
> -err_unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
> +	return 0;
>  }
>  
>  static int ad5592r_reset_channel_modes(struct ad5592r_state *st)
> @@ -305,7 +289,7 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>  	struct iio_chan_spec const *chan, int val, int val2, long mask)
>  {
>  	struct ad5592r_state *st = iio_priv(iio_dev);
> -	int ret;
> +	int ret = 0;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -316,11 +300,11 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>  		if (!chan->output)
>  			return -EINVAL;
>  
> -		mutex_lock(&st->lock);
> -		ret = st->ops->write_dac(st, chan->channel, val);
> -		if (!ret)
> -			st->cached_dac[chan->channel] = val;
> -		mutex_unlock(&st->lock);
> +		scoped_guard(mutex, &st->lock) {
> +			ret = st->ops->write_dac(st, chan->channel, val);
> +			if (!ret)
> +				st->cached_dac[chan->channel] = val;
> +		}
>  		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type == IIO_VOLTAGE) {
> @@ -335,7 +319,7 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>  			else
>  				return -EINVAL;
>  
> -			mutex_lock(&st->lock);
> +			guard(mutex)(&st->lock);
>  
>  			ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
>  						&st->cached_gp_ctrl);
> @@ -360,11 +344,8 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>  						~AD5592R_REG_CTRL_ADC_RANGE;
>  			}
>  
> -			ret = st->ops->reg_write(st, AD5592R_REG_CTRL,
> -						 st->cached_gp_ctrl);
> -			mutex_unlock(&st->lock);
> -
> -			return ret;
> +			return st->ops->reg_write(st, AD5592R_REG_CTRL,
> +						  st->cached_gp_ctrl);
>  		}
>  		break;
>  	default:
> @@ -379,15 +360,15 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  			   int *val, int *val2, long m)
>  {
>  	struct ad5592r_state *st = iio_priv(iio_dev);
> -	u16 read_val;
> -	int ret, mult;
> +	u16 read_val = 0;
> +	int ret = 0, mult = 0;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (!chan->output) {
> -			mutex_lock(&st->lock);
> -			ret = st->ops->read_adc(st, chan->channel, &read_val);
> -			mutex_unlock(&st->lock);
> +			scoped_guard(mutex, &st->lock)
> +				ret = st->ops->read_adc(st, chan->channel,
> +							&read_val);
>  			if (ret)
>  				return ret;
>  
> @@ -400,9 +381,8 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  			read_val &= GENMASK(11, 0);
>  
>  		} else {
> -			mutex_lock(&st->lock);
> -			read_val = st->cached_dac[chan->channel];
> -			mutex_unlock(&st->lock);
> +			scoped_guard(mutex, &st->lock)
> +				read_val = st->cached_dac[chan->channel];
>  		}
>  
>  		dev_dbg(st->dev, "Channel %u read: 0x%04hX\n",
> @@ -420,16 +400,14 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  			return IIO_VAL_INT_PLUS_NANO;
>  		}
>  
> -		mutex_lock(&st->lock);
> -
> -		if (chan->output)
> -			mult = !!(st->cached_gp_ctrl &
> -				AD5592R_REG_CTRL_DAC_RANGE);
> -		else
> -			mult = !!(st->cached_gp_ctrl &
> -				AD5592R_REG_CTRL_ADC_RANGE);
> -
> -		mutex_unlock(&st->lock);
> +		scoped_guard(mutex, &st->lock) {
> +			if (chan->output)
> +				mult = !!(st->cached_gp_ctrl &
> +					AD5592R_REG_CTRL_DAC_RANGE);
> +			else
> +				mult = !!(st->cached_gp_ctrl &
> +					AD5592R_REG_CTRL_ADC_RANGE);
> +		}
>  
>  		*val *= ++mult;
>  
> @@ -439,15 +417,13 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		ret = ad5592r_get_vref(st);
>  
> -		mutex_lock(&st->lock);
> +		guard(mutex)(&st->lock);
>  
>  		if (st->cached_gp_ctrl & AD5592R_REG_CTRL_ADC_RANGE)
>  			*val = (-34365 * 25) / ret;
>  		else
>  			*val = (-75365 * 25) / ret;
>  
> -		mutex_unlock(&st->lock);
> -
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> 


