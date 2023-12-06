Return-Path: <linux-iio+bounces-683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52EF807737
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 19:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D871F2119F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA916E2B0;
	Wed,  6 Dec 2023 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLmEhiKz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5596A32D
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 18:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFB0C433C8;
	Wed,  6 Dec 2023 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701885805;
	bh=n2K9CCoUK0SLuJxK6jq2YdkGiIS27fpu8+g3CacHWIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZLmEhiKz2RGoZWTdA1X6Q50TML05KdlD59g1VfoVFxvIIPSSsk0lbx5uGp/W4rxrr
	 8jzEvbCb4Xpt9EQROLsqJQqyee7Pd04AWxYj79Y69SZkosD2sXUS5DD3of5oNBXl+Y
	 swY25KD89eIZIVjx3w8l+kjbPyP27CNaEpEQVzXeshXNYzIbBZiObKKPjz3XyIhxs5
	 XbgeNEunBcM09tfDYkzWMmRe0IbKdxw4SJs4c7z2fn3+2+c5dcCffRH2mGzlOUBFcx
	 bnMogZ9Rn8bw2hlQBaJinMGKiMr0GOI51r6ajCgpu8/NFi4hWOCapoodmjarVzzJ8S
	 CfA25IP2b5fhA==
Date: Wed, 6 Dec 2023 18:03:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/8] iio: adc: ad9467: fix reset gpio handling
Message-ID: <20231206180317.5f298685@jic23-huawei>
In-Reply-To: <20231205-iio-backend-prep-v1-1-7c9bc18d612b@analog.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
	<20231205-iio-backend-prep-v1-1-7c9bc18d612b@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Dec 2023 18:06:41 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> The reset gpio was being requested with GPIOD_OUT_LOW which means, not
> asserted. Then it was being asserted but never de-asserted which means
> the devices was left in reset. Fix it by de-asserting the gpio.

If I understand this correctly, it's really just inverted polarity
compared to the expectation?  If so just call it that rather than
discussing what happens in detail.

> 
> While at it, moved the handling to it's own function and dropped
> 'reset_gpio' from the 'struct ad9467_state' as we only need it during
> probe. On top of that, refactored things so that we now request the gpio
> asserted (i.e in reset) and then de-assert it. Also note that we now use
> gpiod_set_value_cansleep() instead of gpiod_direction_output() as we
> already request the pin as output.
> 
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 39eccc28debe..5ecf486bf5d1 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -121,7 +121,6 @@ struct ad9467_state {
>  	unsigned int			output_mode;
>  
>  	struct gpio_desc		*pwrdown_gpio;
> -	struct gpio_desc		*reset_gpio;
>  };
>  
>  static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> @@ -378,6 +377,23 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
>  	return ad9467_outputmode_set(st->spi, st->output_mode);
>  }
>  
> +static int ad9467_reset(struct device *dev)
> +{
> +	struct gpio_desc *gpio;
> +
> +	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
> +	if (!gpio)
> +		return 0;
> +
> +	fsleep(1);
> +	gpiod_set_value_cansleep(gpio, 0);
> +	fsleep(10 * USEC_PER_MSEC);
> +
> +	return 0;
> +}
> +
>  static int ad9467_probe(struct spi_device *spi)
>  {
>  	const struct ad9467_chip_info *info;
> @@ -408,18 +424,9 @@ static int ad9467_probe(struct spi_device *spi)
>  	if (IS_ERR(st->pwrdown_gpio))
>  		return PTR_ERR(st->pwrdown_gpio);
>  
> -	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> -						 GPIOD_OUT_LOW);
> -	if (IS_ERR(st->reset_gpio))
> -		return PTR_ERR(st->reset_gpio);
> -
> -	if (st->reset_gpio) {
> -		udelay(1);
> -		ret = gpiod_direction_output(st->reset_gpio, 1);
> -		if (ret)
> -			return ret;
> -		mdelay(10);
> -	}
> +	ret = ad9467_reset(&spi->dev);
> +	if (ret)
> +		return ret;
>  
>  	conv->chip_info = &info->axi_adc_info;
>  
> 


