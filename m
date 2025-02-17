Return-Path: <linux-iio+bounces-15656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF8A3846F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D41416910E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8835621C9F0;
	Mon, 17 Feb 2025 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrhKH2/t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B25C603;
	Mon, 17 Feb 2025 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798342; cv=none; b=SLy3q+JfP/GCRmTEEQUFa3gqc/yUS81j1nkx7U0hzaS98LL0mkcS4//Zeya0pgOhNco2P0dhhI0+7yzZewVi4CjS14iyYtoCSUIJS1/sNz6cecEy30/53TK392aOTJl2EkMiREcBTL4vcN6DJeQ4ltEgK6oNSskGQtR4HLPwpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798342; c=relaxed/simple;
	bh=vDp+ULcTmetlszpVsMoQh+ubngAgcM3/x1bls2GBlOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWxZhq0LamXtonEWQVBGwLP7t/p2xWxNd0e0/FLg0ouDotQ03HOCWWMhilExFruAmnE9KmEUw41p+XJbp22W1sr96X12rhhYVrizne3dFVYYR2WpAqA5/Ax0oPrBaYTkXJfAtzcXXkVNdX8EiiPtv8VQsb3OlDc+SkuZb7i/eBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrhKH2/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CA1C4CED1;
	Mon, 17 Feb 2025 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739798341;
	bh=vDp+ULcTmetlszpVsMoQh+ubngAgcM3/x1bls2GBlOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YrhKH2/tVMa0FpWO9g0XO8hxtLgH2+w1OP5sZmMti3kJjl78lgCth7DBm7pW2h98z
	 HbWBNm+qq1WpHwTsvUlAr4+bMCqsSLdulE6yiJIrMIWdoZR2SOF+QcrPL18m8WgP0A
	 N4zFFQX+GkCUy+ojnMRGLmyX+nU0vNhPH0ElHrCE8yi44Ad1pTCoNJnwMGhmqYwqLM
	 aVEj4WrgfH5ILXv+2CrMW+rYZFJd83Ii58SIxKT3HSvrSiLRU0BmtkPwgBz7izJfsV
	 6rP/ppMNzEsRhPAXu0wsSntZua6mcERaf44vE2XBTinKcNShc8pyt8/cMPowZfJD2q
	 tYOuPGLYzqABg==
Date: Mon, 17 Feb 2025 13:18:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 07/15] iio: adc: ad7606: use
 gpiod_multi_set_value_cansleep
Message-ID: <20250217131845.17af66a4@jic23-huawei>
In-Reply-To: <20250210-gpio-set-array-helper-v3-7-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
	<20250210-gpio-set-array-helper-v3-7-d6a673674da8@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 16:33:33 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value().
> 
> These are not called in an atomic context, so changing to the cansleep
> variant is fine.
> 
> Also drop unnecessary braces while we are at it.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I've applied this to the IIO tree now but won't push out as anything other than
testing until Bartosz has dropped it. (thanks for doing that btw!)

Due to code movement it ends up being all in ad7606.c

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 1e8b03a518b8..87908cc51e48 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -828,8 +828,7 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 
        values[0] = val & GENMASK(2, 0);
 
-       gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
-                             st->gpio_os->info, values);
+       gpiod_multi_set_value_cansleep(st->gpio_os, values);
 
        /* AD7616 requires a reset to update value */
        if (st->chip_info->os_req_reset)
@@ -1260,10 +1259,9 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
         * in the device tree, then they need to be set to high,
         * otherwise, they must be hardwired to VDD
         */
-       if (st->gpio_os) {
-               gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
-                                     st->gpio_os->info, os);
-       }
+       if (st->gpio_os)
+               gpiod_multi_set_value_cansleep(st->gpio_os, os);
+
        /* OS of 128 and 256 are available only in software mode */
        st->oversampling_avail = ad7606b_oversampling_avail;
        st->num_os_ratios = ARRAY_SIZE(ad7606b_oversampling_avail);


> ---
>  drivers/iio/adc/ad7606.c     | 3 +--
>  drivers/iio/adc/ad7606_spi.c | 7 +++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index d8e3c7a43678c57470a5118715637a68b39125c1..9a124139924e4a4fbbbd234a8514eb77024442b3 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -818,8 +818,7 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
>  
>  	values[0] = val & GENMASK(2, 0);
>  
> -	gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
> -			      st->gpio_os->info, values);
> +	gpiod_multi_set_value_cansleep(st->gpio_os, values);
>  
>  	/* AD7616 requires a reset to update value */
>  	if (st->chip_info->os_req_reset)
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index e2c1475257065c98bf8e2512bda921d6d88a3002..091f31edb6604da3a8ec4d2d5328ac6550faa22c 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -296,10 +296,9 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
>  	 * in the device tree, then they need to be set to high,
>  	 * otherwise, they must be hardwired to VDD
>  	 */
> -	if (st->gpio_os) {
> -		gpiod_set_array_value(st->gpio_os->ndescs,
> -				      st->gpio_os->desc, st->gpio_os->info, os);
> -	}
> +	if (st->gpio_os)
> +		gpiod_multi_set_value_cansleep(st->gpio_os, os);
> +
>  	/* OS of 128 and 256 are available only in software mode */
>  	st->oversampling_avail = ad7606B_oversampling_avail;
>  	st->num_os_ratios = ARRAY_SIZE(ad7606B_oversampling_avail);
> 


