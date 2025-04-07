Return-Path: <linux-iio+bounces-17790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83671A7ED0D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7AD426A04
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CDC2566CE;
	Mon,  7 Apr 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spvac6wQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF62561CC;
	Mon,  7 Apr 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053130; cv=none; b=V2pHD5g8IpJZ4jahysUjc6VTmSOiwxbw92S3HbebdmUWTxjz0AbnBmovgKEWKLF3quIZ/uaq/gyHHjyeDgMZkvgE5viHWa7q8Bg1kVvJ5jzns6AoUy8oOC2wWhyu7IG48dM2mwi3OE2Tu2Q05vI3+N1wTwDeIfhXDy0edQfigUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053130; c=relaxed/simple;
	bh=eRwcNqwW7+h4lJEE4g3DMP42LSVphf2gVF3zYxnzX8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKg/LAAqXlPUIE8fuyz6g5xRgag36Ty6Ji2M+0Jbd5hCHBT9PdtryVPsjMwsD/r2AA6gUY2neA9smqUTMH+UmrbjJnn4iuSgDvDlUuwzQdYhSZVGjpyxXhOqlFnGoncR7WgZDLKJmZAGBnkgHYqMDB5Xhl8+OsML93ju4U8hOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spvac6wQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652AAC4CEE7;
	Mon,  7 Apr 2025 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744053129;
	bh=eRwcNqwW7+h4lJEE4g3DMP42LSVphf2gVF3zYxnzX8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=spvac6wQ9Eduo+A6D/vNhaDzpye9yxUDTHzLDPDBF5MgU9G+UkGAADJZTtGuKkQ10
	 5wVqzPlcRg8y/MQiJySK7wMm62Es/rpXjYsbM3dbe44z/hPUo7AQFcf+zVQb7NpQcM
	 q7ygkNQeIbNF8EBJP+UbMrbQbVajBC+SR4IwBoN5JPllrWX7/eTB0D2igbnH7x0Nx2
	 kQQsPf9d4I0HuOBK0vnmOhi5fCdCg1Dfv9qORhLHIfJa5eoe0RdzOEb0kd5JsY9j4C
	 GmF/nWIrrebrrf3s+OBeMJfPU1ASxRq0ml7X9RtXX0EvRnaMc4LBF7HoGLRqP6kPgB
	 olE6QZdT8na4Q==
Date: Mon, 7 Apr 2025 20:12:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Linus Walleij <linus.walleij@linaro.org>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/7] iio: dac: ad5592r: use lock guards
Message-ID: <20250407201202.7c74a39d@jic23-huawei>
In-Reply-To: <20250407-gpiochip-set-rv-iio-v1-2-8431b003a145@linaro.org>
References: <20250407-gpiochip-set-rv-iio-v1-0-8431b003a145@linaro.org>
	<20250407-gpiochip-set-rv-iio-v1-2-8431b003a145@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Apr 2025 09:18:10 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use lock guards from linux/cleanup.h to simplify the code and remove
> some labels.
> 
> Note that we need to initialize some variables even though it's not
> technically required as scoped_guards() are implemented as for loops.
That is always a tiny bit irritating. Thanks for calling it out.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/iio/dac/ad5592r-base.c | 119 ++++++++++++++++-------------------------
>  1 file changed, 47 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index fe4c35689d4d..bbe3b52c6a12 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c

Just one case I'd prefer done a tiny bit differently so as to alway do
early returns rather than very nearly always.


>  	udelay(250);
> @@ -249,45 +235,43 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
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
>  		ret = -EIO;
		return -EIO; 
for this one.

>  
> -err_unlock:
> -	mutex_unlock(&st->lock);
>  	return ret;
return 0; here

>  }

