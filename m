Return-Path: <linux-iio+bounces-17789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD82A7ECE2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56491189EBDB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02DE25DB1C;
	Mon,  7 Apr 2025 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZhOqX0G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B42236F0;
	Mon,  7 Apr 2025 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052793; cv=none; b=FCe95pv/DfZ8VLX/f1/ZxZZhzOV7fRE1bHYZXAmHpBj893dpcWaTqJXXkV/B/HCWoiqR04gjAdBKvH9LpW6FScrApduzkzou69auZLaKcrwJefRmK6eesGh0vjwVDs7/viBQlsF/VRyOvpoXbTmdIBni6dT0vs2y5xr6wSLcUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052793; c=relaxed/simple;
	bh=PxeQOz/KcaCla5gzGAd6vkzJnq9I4Ujj9WxxEWxTyu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfDtUlYwfeeQRXC4MagsOoELahIAZMTr9Yf22WIygsGpg99KiOHpaFiFfLn7kr4Orj/KmjjXb+Pb8ftTZ4Xv0ekiReEp4EByA/p5eUG8fgHX1Hf0zISw/eTqwmFwP3kR32Gl6+JnD5a+YnQOKSylzUq42PHPAxhtnVaqdoIV8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZhOqX0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45543C4CEDD;
	Mon,  7 Apr 2025 19:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052792;
	bh=PxeQOz/KcaCla5gzGAd6vkzJnq9I4Ujj9WxxEWxTyu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZhOqX0G3v2wuV3cnP6gywsZaoQ8zdbOd9pMYYoouQGDRqyzHAfFIhrB1B0WkNuU/
	 0HXq4QqK7s8Pcw/EboUxVl4O11zD48LtV4EjN4T4Fb8H1rmqEE4GJBKQW7OhAryOYI
	 GCFToTc2LweEoZ6dXgKR71eQbxxuk9BQjvuu0BqlNXGNQ8Uaq3RVgsxekF1bZoQLgj
	 zySS+XIb8csMoWQBXn8Sqm7GA9vKoej1zLrE6iaSoyiFixpgfsJKkksIXctYt3/cOV
	 HuW7Mb49/A1mLNLAgdJERVrl276Sq1H7C6Pw+k29XvWFzJq8NZKC5cGBrPTEi252Hp
	 3Y5DPTZ1uW+ag==
Date: Mon, 7 Apr 2025 20:06:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Linus Walleij <linus.walleij@linaro.org>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/7] iio: dac: ad5592r: destroy mutexes in detach paths
Message-ID: <20250407200625.734c02d9@jic23-huawei>
In-Reply-To: <20250407-gpiochip-set-rv-iio-v1-1-8431b003a145@linaro.org>
References: <20250407-gpiochip-set-rv-iio-v1-0-8431b003a145@linaro.org>
	<20250407-gpiochip-set-rv-iio-v1-1-8431b003a145@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Apr 2025 09:18:09 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The locks used here are initialized but never released which causes
> resource leaks with mutex debugging enabled. Add missing calls to
> mutex_destroy() or use devres if applicable.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Hi Bartosz,

> ---
>  drivers/iio/dac/ad5592r-base.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 50d19304bacb..fe4c35689d4d 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -155,6 +155,8 @@ static void ad5592r_gpio_cleanup(struct ad5592r_state *st)
>  {
>  	if (st->gpio_map)
>  		gpiochip_remove(&st->gpiochip);
> +
> +	mutex_destroy(&st->gpio_lock);
>  }
>  
>  static int ad5592r_reset(struct ad5592r_state *st)
> @@ -622,7 +624,9 @@ int ad5592r_probe(struct device *dev, const char *name,
>  	iio_dev->info = &ad5592r_info;
>  	iio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	mutex_init(&st->lock);
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		goto error_disable_reg;

Please don't mix devm and gotos.  That tends to make for complex
logic to review for limited gain.   Devm then gotos is fine though
(i.e. a transition from all devm to gotos only mid way through probe).

Easiest solution would be to move this mutex init before the regulator
is enabled (so up about 10 lines).

Then we finish the devm stuff before starting the non devm part.

A more complex cleanup would be to drop the support for dynamic vref
(as that is almost certainly copied and pasted from elsewhere rather than
a real thing) and then use devm to manage the vref.  That wouldn't
be related to this series though so I'd just move that mutex init up.


>  
>  	ad5592r_init_scales(st, ad5592r_get_vref(st));
>  
> 


