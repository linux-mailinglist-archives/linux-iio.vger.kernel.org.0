Return-Path: <linux-iio+bounces-15161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0FCA2D643
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052997A3E25
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4C2475DE;
	Sat,  8 Feb 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdRDYhww"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776181D8A0D;
	Sat,  8 Feb 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020948; cv=none; b=A2MR0xYtdaEPi/8I7nAIEY2/TaJEeHDe5e+pm+1TRbu9tpWkfs16eUhPYqftejyLtOD/E9TaoV/uYVPWM32ucx/l+8ernjhpK47nREbcaWUd2NZZrzLaNIwcRH+Nd7nZJIwgfiaSsTSySXbQv0o1CjeliJQSwttNwlKwprsB+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020948; c=relaxed/simple;
	bh=1cUfUnnzPkSdrT1BvYm7O95VixubILLavQwSf9m20To=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpCw3GyhGFAADgwcC62AP2tUwBwATM/MIiOS1ne5TuSh92SNLGGjFFUyRP/fJ/BnyZ6yF5Ex7X/OB+tlzlJjnROPIZi+VzX/IZNq665B7/LIiJGgrEH0top3HlwdHnDV+FC2manqhfe15fqlYXg4YbmsmaLfTzUgLW00GMhQo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdRDYhww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1978FC4CED6;
	Sat,  8 Feb 2025 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739020947;
	bh=1cUfUnnzPkSdrT1BvYm7O95VixubILLavQwSf9m20To=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QdRDYhwwbY9vABNWN9TC+jkJ1dj+PKkgmoeyjRzSGaTaO4ypPrIP6ADmDo05RMi3j
	 hKejsHUowRJ78SXsYHrAHMXltXUHm0LHZuHOz7gpB5X/DIO0n3gE4KnO/EZhnNl7NL
	 wQ4ojKCuj3Cmq42okjlKXbq4LRTxAIZvXZA+/SyBbZzGPmL26MIEzH8H8UBBrb6yo9
	 b9E/rldcVCBOtIQma+UIw1J+Vihnd29SwWeVS6rMBwWzRru+jsI9igvo85jt1kA4uu
	 bgCenS7ZlUwUEH7j5PGmcZNQ/SY/WuWQpx92ddbvuqljUu41lZbZfl1ZgWgv03TWSR
	 o0BL4CO6gxUCQ==
Date: Sat, 8 Feb 2025 13:22:11 +0000
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
 linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 07/13] iio: amplifiers: hmc425a: use
 gpiod_multi_set_value_cansleep
Message-ID: <20250208132211.794c6f87@jic23-huawei>
In-Reply-To: <20250206-gpio-set-array-helper-v2-7-1c5f048f79c3@baylibre.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
	<20250206-gpio-set-array-helper-v2-7-1c5f048f79c3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Feb 2025 16:48:21 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value_cansleep().
> 
> Passing NULL as the 3rd argument to gpiod_set_array_value_cansleep()
> only needs to be done if the array was constructed manually, which is
> not the case here. This change effectively replaces that argument with
> st->gpios->array_info. The possible side effect of this change is that
> it could make setting the GPIOs more efficient.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
If it goes through the gpio tree
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/amplifiers/hmc425a.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index 2ee4c0d70281e24c1c818249b86d89ebe06d4876..d9a359e1388a0f3eb5909bf668ff82102286542b 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -161,8 +161,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
>  
>  	values[0] = value;
>  
> -	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
> -				       NULL, values);
> +	gpiod_multi_set_value_cansleep(st->gpios, values);
>  	return 0;
>  }
>  
> 


