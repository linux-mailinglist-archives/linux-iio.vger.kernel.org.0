Return-Path: <linux-iio+bounces-15162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD2DA2D646
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82370188D265
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D12475E1;
	Sat,  8 Feb 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YooG0lsD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38018246335;
	Sat,  8 Feb 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020973; cv=none; b=JI/9vtGd5PJeo10Jbp2sdW2HNAR2hIb5gnSe9zXEbcsyRWhHjalohRD1c6thCZv5SHL4Oz1gXdzZAiloYNnXo5xPUJgfoHaUeXPA+iCrSzXX+2sg5oyoMJ2fqZI5ZzNpZ83oLip1b0YS1pFVsQHSoWgbmej4uboiTKWj1YGc38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020973; c=relaxed/simple;
	bh=ojenjl2TOOXMH1n1g02fuLQBKwZVi3ZrnouzCMKji6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljuvEbejVdNUQqx4IbcAfpPlyXyytOHdiQUMIZERnTbTwhEl2cXUJoQPj9DakNFmIIudPCW+cE4EcPaCCBw+aR/0kn7pYhb+h2tXMCKZDnEF9luCqzibnqzfrxEYQxUtnExfsSCRQXL3yebaean0vi6r5zP8yzUYHLsZDRH+cj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YooG0lsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D02C4CED6;
	Sat,  8 Feb 2025 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739020972;
	bh=ojenjl2TOOXMH1n1g02fuLQBKwZVi3ZrnouzCMKji6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YooG0lsDGwowoGFiTayI1bEM7oj2dmbC7j957GRinvghGX+R2Wwb6D5opUyRhER7f
	 Sp1TVi2PgmEA6n7eU8CEhSY+DW9Q7a3HdWvIFU81wto1N0YXKmTgV7Z4uYVXFfbTYK
	 7lC70ybLWbHTSVy/joIdF9yDccHtjG19z5Qzg3vJUJVeexBppd6F3FXtdl2WqGhXcU
	 5WIcdPrrGSgzWZ8C5WUYl5/fp34wmWW1WWePhPpHRo+3YbHI7Jvr9V8t7FCwQ1rwH0
	 yO0EPPME5K6MST3m3/3Bz4SRiVutNdeFZr/iv67e2R+fbzkGsevTSGtykYR96a/s37
	 GrN4Dz90GtdRg==
Date: Sat, 8 Feb 2025 13:22:32 +0000
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
Subject: Re: [PATCH v2 08/13] iio: resolver: ad2s1210: use
 gpiod_multi_set_value_cansleep
Message-ID: <20250208132232.47b848e9@jic23-huawei>
In-Reply-To: <20250206-gpio-set-array-helper-v2-8-1c5f048f79c3@baylibre.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
	<20250206-gpio-set-array-helper-v2-8-1c5f048f79c3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Feb 2025 16:48:22 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value().
> 
> These are not called in an atomic context, so changing to the cansleep
> variant is fine.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
If this goes through GPIO
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/resolver/ad2s1210.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
> index b681129a99b6cf399668bf01a1f5a15fbc4f95b8..7f18df790157f1e411fb70de193a49f0677c999f 100644
> --- a/drivers/iio/resolver/ad2s1210.c
> +++ b/drivers/iio/resolver/ad2s1210.c
> @@ -182,8 +182,7 @@ static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
>  
>  	bitmap[0] = mode;
>  
> -	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
> -				     bitmap);
> +	return gpiod_multi_set_value_cansleep(gpios, bitmap);
>  }
>  
>  /*
> @@ -1473,10 +1472,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  
>  		bitmap[0] = st->resolution;
>  
> -		ret = gpiod_set_array_value(resolution_gpios->ndescs,
> -					    resolution_gpios->desc,
> -					    resolution_gpios->info,
> -					    bitmap);
> +		ret = gpiod_multi_set_value_cansleep(resolution_gpios, bitmap);
>  		if (ret < 0)
>  			return dev_err_probe(dev, ret,
>  					     "failed to set resolution gpios\n");
> 


