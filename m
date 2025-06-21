Return-Path: <linux-iio+bounces-20827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E65AE2ADF
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BED03B71F7
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4601D26A08D;
	Sat, 21 Jun 2025 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXtCJC5r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C722F767;
	Sat, 21 Jun 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528559; cv=none; b=DmxAFyKGKefg66jhPhuK166AH7KIne4oM7+h56CTodDq2pulQTCDj7KWSu+TP/vZHPcEVuLdcEwzYuCzH8Xp+dLJlkqqFe79UVZenJPrMrG4vnQLcV3uCTvFdQUQcbLJseBf+qlqjMI14+HVqCS3sNZIl9Kl07lEaEK5O0i7MTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528559; c=relaxed/simple;
	bh=+BFX2a7BuKKhnaYnRgdF8hOlHgDt/kngwMDB7wbUW1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7EyFmBfnb8KaQW1WnQulLYRpCeAsKq1caQMGsXNmf0HR93GgEQe5VjC4BtzfixuXNRecLNyTBi6KMvFnWz33vIEQjPDszLVBukJlGytGrknAXIQR32NppHhIkw6dFM5eA6EAlBNLezerczQ66dp3S5IlSj6aSXrdkYkxKPtodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXtCJC5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33578C4CEEE;
	Sat, 21 Jun 2025 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528558;
	bh=+BFX2a7BuKKhnaYnRgdF8hOlHgDt/kngwMDB7wbUW1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oXtCJC5rBQMyptPqg4V01+r5jpPsro06bgKU0jnmwbb/wqAtgwvHuGZmfe0sZuwPb
	 9CqzVuV71zkjZeXZQrB73e+4UC3PwFd0ll1UUGH+6LfJU+XlkDDeUtJnOO2H8QouY8
	 P4ggHPfdgOmkYRsKH6+eOQUANTWSS1fDhSVU8Hpwu/6s8IWd/cegfM73DFoInAi3+M
	 C1ggNP7GwFTmiduaH/a1vaAS9EUFOtLYpPWjNunZWke6aHDEEYL0j8kI6ZsH28lv0v
	 UHPXRJcJKAgKva1gnQY1yPVmT+GTV8Fs1hgMYd4gHANEnGD3wc1ujBnIcNKIRKjNjO
	 RkXHJ42XkXDQA==
Date: Sat, 21 Jun 2025 18:55:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] iio: accel: sca3000: use lock guards
Message-ID: <20250621185550.64aebefa@jic23-huawei>
In-Reply-To: <20250618031638.26477-4-andrew.lopes@alumni.usp.br>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
	<20250618031638.26477-4-andrew.lopes@alumni.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 00:12:18 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> Use guard() and scoped_guard() for handling mutex lock instead of
> manually locking and unlocking the mutex. This prevents forgotten
> locks due to early exits and remove the need of gotos.

Please add extra description for where you have pushed locks up
a level in the call tree and why that is fine to do.

> 
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

A few comments inline.

Thanks

Jonathan

> @@ -756,28 +747,23 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct sca3000_state *st = iio_priv(indio_dev);
> -	int ret;
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		guard(mutex)(&st->lock);
As below

>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&st->lock);
> -		ret = sca3000_write_raw_samp_freq(st, val);
> -		mutex_unlock(&st->lock);
> -		return ret;
> -	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		return sca3000_write_raw_samp_freq(st, val);
> +	}
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: {
> +		guard(mutex)(&st->lock);
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&st->lock);

You can keep the old ordering here.  It doesn't matter much but
easier to be sure about a patch that makes no functional change.

> -		ret = sca3000_write_3db_freq(st, val);
> -		mutex_unlock(&st->lock);
> -		return ret;
> +		return sca3000_write_3db_freq(st, val);
> +	}

>  
>  /**
> @@ -1021,9 +1001,8 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
>  	 * Could lead if badly timed to an extra read of status reg,
>  	 * but ensures no interrupt is missed.
>  	 */
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);

This is a very large increase in scope.  Use scoped_guard() here instead to avoid
holding the lock over a whole load of code that doesn't need it.

>  	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_ADDR));
> -	mutex_unlock(&st->lock);
>  	if (ret)
>  		goto done;
>  

>  }

>  
>  static inline
> @@ -1247,23 +1211,19 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
>  	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
>  	if (ret)
> -		goto error_ret;
> +		return ret;
> +
>  	if (state) {
>  		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
> -		ret = sca3000_write_reg(st,
> +		return sca3000_write_reg(st,
>  			SCA3000_REG_MODE_ADDR,
>  			ret | SCA3000_REG_MODE_RING_BUF_ENABLE);

This indent was already nasty so as we are touching the code good to clean it up.
For cases like this we can be more relaxed and if it helps readability go a little
over 80 chars (I think this will be 80 ish)

		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
					 ret | SCA3000_REG_MODE_RING_BUF_ENABLE);


> -	} else
> -		ret = sca3000_write_reg(st,
> -			SCA3000_REG_MODE_ADDR,
> -			ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE);
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> +	}
> +	return sca3000_write_reg(st,
> +		SCA3000_REG_MODE_ADDR,
> +		ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE);
>  }
>
>  
>  static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
> @@ -1307,22 +1259,18 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
>  	int ret;
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  
> +	guard(mutex)(&st->lock);

See comment at the top - Making this change is fine but call it out in the patch
description as it isn't simple change to using guards, but instead to holding
the lock for longer.  Change is fine but point it out as it needs
more review than the mechanical changes.

>  	ret = __sca3000_hw_ring_state_set(indio_dev, 0);
>  	if (ret)
>  		return ret;
>  
>  	/* Disable the 50% full interrupt */
> -	mutex_lock(&st->lock);
> -
>  	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
>  	if (ret)
> -		goto unlock;
> -	ret = sca3000_write_reg(st,
> +		return ret;
> +	return sca3000_write_reg(st,
>  				SCA3000_REG_INT_MASK_ADDR,
>  				ret & ~SCA3000_REG_INT_MASK_RING_HALF);

As below.

> -unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
>  }

> @@ -1386,13 +1334,9 @@ static int sca3000_clean_setup(struct sca3000_state *st)
>  	 */
>  	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
>  	if (ret)
> -		goto error_ret;
> -	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> +		return ret;
> +	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
>  				ret & SCA3000_MODE_PROT_MASK);

As below.

> -
> -error_ret:
> -	mutex_unlock(&st->lock);
> -	return ret;
>  }
>  
>  static const struct iio_info sca3000_info = {
> @@ -1470,19 +1414,16 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
>  {
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
>  	if (ret)
> -		goto error_ret;
> +		return ret;
>  
> -	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> +	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
This adds a character to this line which means that either the indent of
the following lines was previously wrong, or it is now.
I think you need to add a space to the following lines.

Check for other similar cases.

>  				ret &
>  				~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
>  				  SCA3000_REG_INT_MASK_RING_HALF |
>  				  SCA3000_REG_INT_MASK_ALL_INTS));

