Return-Path: <linux-iio+bounces-9886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D0989661
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 19:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F91C1F21030
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C16017E00F;
	Sun, 29 Sep 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ1XP8LH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903C1C683;
	Sun, 29 Sep 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629474; cv=none; b=dTKlHXuUJ6aHnnC7GKhXWMnXyATaRawQBkHY4FkETyCDVRLJesvtdA1m6KOZHNeyAxV2YWYmUScE4UXwrlHpKdADqbnNVEPrEoM3UYW2Td3Y4iU1MEUQNAzsLGRpfCYaM4X6FDq+73j1fEL4Phoy06ugJyNl1w5gwOOEo9iO4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629474; c=relaxed/simple;
	bh=wOn2rPeUN8zWonwsBPGsPi7lOi2s5OqmICI+BwvwcZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4Ji65ECPyesTcudU1jg4K51iJj0zn2HGXVIX2hcHdNSYeV/NFh02FIPN92bt8Eh1bPVfbZJUf77BJxIdUttloMcI897Y6fXg20fARCd2NkF9PTKSNnhKIa1RwlYRzkJvrL/F1v350IXJajvV5L09QUoqfHU7KuNgafE2xbjW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ1XP8LH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B3DC4CEC5;
	Sun, 29 Sep 2024 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727629474;
	bh=wOn2rPeUN8zWonwsBPGsPi7lOi2s5OqmICI+BwvwcZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DZ1XP8LHkF6oKBkNOMl3GVeJgtBLd3p1fureO1Bg529i56VuyIin+/+pTPU7HrMYz
	 6QhCzWA6B26+uCMK7LNe8Ha1Tbz4D/D2akIW77/muL0G5tu3BZLzclOsgzBZyhYY4r
	 IjK5p6fFIMfC6YHdR7SQB+iwVAeHzWVbakDM+JF7gK+J6VpznHbtRiA0cghNnqUYd9
	 swRu3jr7yVwWNlRiPxlznoXZCQ2g6GHoFTINHAINcbNBMUx5XZ9PKwt35rblbAbv+j
	 E8i3C4lk6+M1m7BLE94+sSjx+aFROp6JQnc4s1Xl1iFfIEV9KqgJxJdx8oCQDx9prX
	 D7/e4BDrEbHmw==
Date: Sun, 29 Sep 2024 18:04:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: pressure: bmp280: Fix type for raw values
Message-ID: <20240929175710.2e101abc@jic23-huawei>
In-Reply-To: <20240929112511.100292-2-vassilisamir@gmail.com>
References: <20240929112511.100292-1-vassilisamir@gmail.com>
	<20240929112511.100292-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 13:25:10 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The adc values coming directly from the sensor in the BM{E,P}{2,3}xx
> sensors are unsigned values so treat them as such.
> 
> Fixes: 80cd23f43ddc ("iio: pressure: bmp280: Add triggered buffer support")
Why is this a fix rather than a cleanup?  Looks to me like all the values
are going to be small enough that they fit either way.
So good to tidy up for consistency etc, but why a fixes tag?

I 

> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6c2606f34ec4..472a6696303b 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1023,7 +1023,8 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -	s32 adc_temp, adc_press, t_fine;
> +	u32 adc_temp, adc_press;
These are filled as part of a get_unaligned_be24() so the value will never
be big enough that signed / unsigned should make any difference.

> +	s32 t_fine;
>  	int ret;
>  
>  	guard(mutex)(&data->lock);
> @@ -1137,7 +1138,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -	s32 adc_temp, adc_press, adc_humidity, t_fine;
> +	u32 adc_temp, adc_press, adc_humidity;
Same with these.
> +	s32 t_fine;
>  	int ret;
>  
>  	guard(mutex)(&data->lock);
> @@ -1616,7 +1618,8 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -	s32 adc_temp, adc_press, t_fine;
These are similar but le24.

> +	u32 adc_temp, adc_press;
> +	s32 t_fine;
>  	int ret;
>  
>  	guard(mutex)(&data->lock);


