Return-Path: <linux-iio+bounces-12532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE4C9D698E
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171ED281B65
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80041F957;
	Sat, 23 Nov 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbSj3ip+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE5BA42;
	Sat, 23 Nov 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732374500; cv=none; b=tj3EbCqlJf+SrnFzrQsSBPmxP5JgjT8FlgCIyeQniCJ5u57uOMBiV4FDpfPXzEERhPcyoP1sKQamuTpEPojnUmgmBpOUnsBvjJJvKLi/vsGqU3DHC1vGPxWpOGtnhzMNT7597f1l+/jAcXgf4zIEjuORIwFnZ+tposiURiaATE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732374500; c=relaxed/simple;
	bh=mV0DYgkf1CnqnfVd7iq3ygJgMJskcY+V1ypQ6J1wbnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faORcVus7d4yPIQypssh9mLR1x5+bxuaIhAiZ97BZjFg9Qzjacl28H7pOyQrBSqiKYsnOYd9MMemw1f6x/uu4MiJAMC25v9nXKhr64b0VbFmBOdf/pJrq6HGAaipWb3592lsbs0uoLuRqku3ZuVW/RP3Y1nRFpq6tJ3UFszYQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbSj3ip+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548DFC4CECD;
	Sat, 23 Nov 2024 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732374496;
	bh=mV0DYgkf1CnqnfVd7iq3ygJgMJskcY+V1ypQ6J1wbnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kbSj3ip+kaRWJybPm0YerFXgRKWPbUxyNOlWqPF9hZucBq4TIwJ1pJODwn42DZBAQ
	 kTUbAWtjGmM3e270KmKubkZ0b4a9JH6G+OEp8AKzbxeszA/zdjM4BKNqhALK5EzhUp
	 /SpKx9XRX3e7ll2dFaIbyzx91/fs2BBy5u5p8MPR2ANlYnAvyljVsHP91nAYoAZOKK
	 0SzQEYwyUKxMXGPMtzLtfMclJ+MYQcKh58QSZYfVOLthrvFWdahA2+eCXLpZOuJt8K
	 3oSOkbKWFsoWWnpyteSqBaajD7mI9SFOC1GhoodDzggAsqQLG6hOoys32PtkqI3eJr
	 gNCxUFVt5qjSA==
Date: Sat, 23 Nov 2024 15:08:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: dlechner@baylibre.com, lars@metafoo.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tgamblin@baylibre.com, fabrice.gasnier@st.com,
 benjamin.gaignard@linaro.org, lee@kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
Message-ID: <20241123150808.1426c6f8@jic23-huawei>
In-Reply-To: <20241111222310.12339-1-jiashengjiangcool@gmail.com>
References: <20241111222310.12339-1-jiashengjiangcool@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 22:23:10 +0000
Jiasheng Jiang <jiashengjiangcool@gmail.com> wrote:

> Add check for the return value of clk_enable() in order to catch the
> potential exception.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Hi Jiasheng,


Should definitely mention the changes to use guard() to simplify
the resulting code.

One minor comment on the code inline. Otherwise looks good to me.

Thanks,

Jonathan

> ---
> Changelog:
> 
> v3 -> v4:
> 
> 1. Place braces around the case body.
> 
> v2 -> v3:
> 
> 1. Simplify code with cleanup helpers.
> 
> v1 -> v2:
> 
> 1. Remove unsuitable dev_err_probe().

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
> @@ -506,9 +511,10 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  				clk_disable(priv->clk);
>  			}
>  		}
> -		mutex_unlock(&priv->lock);
> +
>  		return 0;
>  	}
Add a default for reasons David mentioned and it also makes it visually clear
that we expect to get in here for other cases but they are all errors.
	default:
		return -EINVAL;
> +	}
>  
And drop this return as unreachable.

>  	return -EINVAL;
>  }

