Return-Path: <linux-iio+bounces-15930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E8A40816
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3152D19C6387
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65C20ADEF;
	Sat, 22 Feb 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1MnTsDy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A0207E18;
	Sat, 22 Feb 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225110; cv=none; b=dk6WsQaVHxULKJxMuEcbHhhAj4VDCQzmqtATicjsLx6KyswiVv7lHney3N+hNZgO9bva8FE4CjbskxhrvT5TGL8F942kmCdRLuJVxuKverHqqjn2KgGHYAFZMtMT0kyL/23d1aJ3uMCA2Wkcl4rXz0JMa/bQdc2h/zWHJeotLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225110; c=relaxed/simple;
	bh=sifDgvYlQN5FrcMLya3et5Zf5/0nSv8Le44LEJPVOBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shNkUiBwM7bgvrzzsNqRxg64nN8kBD60uOhi6zD3gD6zYalEittS98h9akF7uXtGeQYm/nw85HAXlO7gOmdr/zP/WAzMnk4rjFBhOzfXMU2kf5Wv1YQw1azZsuR5w4bAvPnn519gDKTmhP+56C3VLm59Zz4twBxqTRDabPWlnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1MnTsDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD18CC4CED1;
	Sat, 22 Feb 2025 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740225110;
	bh=sifDgvYlQN5FrcMLya3et5Zf5/0nSv8Le44LEJPVOBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o1MnTsDy7B2ADdlQeonDeLn/bPpPFyOtYvttzKdblxFD2XxoY7ShPnHXf3XPJ2Cxd
	 tPSR6pQspqTlbXMcbM3c5gCwkD2tdh3CkJhCc1Kk++fCG0bVcIYy1qIKjN7s/IpaZk
	 9WZyTjucoFNU8hg+r8vAs9hSg6cXKhyQiY/REj9Qkb9Q0zfp2in7aegcZpi/HtRKUl
	 OAeM5BZnhLowo6McrOfKl45uhs4OlzKy4EiIbQsXV0rEu+57oXYB5WdDWtaXP+K672
	 x5kmB5UkDMg7YZEDbIpRlZVdnMG5xUYcEWVbedH7CkU08KVsQ9fuNt7cehavP1i9Tl
	 MiXi1OF+BQ3/Q==
Date: Sat, 22 Feb 2025 11:51:34 +0000
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
Subject: Re: [PATCH v3 10/15] iio: resolver: ad2s1210: use bitmap_write
Message-ID: <20250222115134.7379f785@jic23-huawei>
In-Reply-To: <4052fd7b-dd8c-4a5a-8f82-dd515de14d20@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
	<20250210-gpio-set-array-helper-v3-10-d6a673674da8@baylibre.com>
	<4052fd7b-dd8c-4a5a-8f82-dd515de14d20@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 14:54:53 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/10/25 4:33 PM, David Lechner wrote:
> > Replace bitmap array access with bitmap_write.
> > 
> > Accessing the bitmap array directly is not recommended and now there is
> > a helper function that can be used.
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/resolver/ad2s1210.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
> > index 7f18df790157f1e411fb70de193a49f0677c999f..04879e6d538bce664469c5f6759d8b1cedea16e9 100644
> > --- a/drivers/iio/resolver/ad2s1210.c
> > +++ b/drivers/iio/resolver/ad2s1210.c
> > @@ -46,6 +46,7 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/bitmap.h>
> >  #include <linux/bits.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/clk.h>
> > @@ -180,7 +181,7 @@ static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
> >  	if (!gpios)
> >  		return mode == st->fixed_mode ? 0 : -EOPNOTSUPP;
> >  
> > -	bitmap[0] = mode;
> > +	bitmap_write(bitmap, mode, 0, 2);
> >  
> >  	return gpiod_multi_set_value_cansleep(gpios, bitmap);
> >  }
> > @@ -1470,7 +1471,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> >  			return dev_err_probe(dev, -EINVAL,
> >  				      "requires exactly 2 resolution-gpios\n");
> >  
> > -		bitmap[0] = st->resolution;
> > +		bitmap_write(bitmap, st->resolution, 0, 2);
> >  
> >  		ret = gpiod_multi_set_value_cansleep(resolution_gpios, bitmap);
> >  		if (ret < 0)
> >   
> 
> There is actually a bug here pointed out in a similar patch. bitmap_write()
> only modifies the bitmap, so this introduces an unintialized use bug. [1]
> Here, we only use the bits that we set, so runtime behavior would not actually
> be buggy but still best to fully initialize the memory.
> 
> I'm a bit surprised that my local compiler and iio/testing both didn't catch that
> since GCC 14 caught it in the other driver.
> 
> [1]: https://lore.kernel.org/linux-gpio/20250217132152.29d86d6c@jic23-huawei/T/#m3163d2c5db5b7376504d8ad6f23716f1119de761
> 
> The fix is simple, we can zero-initialize the bitmap.
Ignore previous. I'm looking at wrong branch. I can tweak this just fine.
Done so and tree pushed out.

> 
> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
> index 04879e6d538b..ab860cedecd1 100644
> --- a/drivers/iio/resolver/ad2s1210.c
> +++ b/drivers/iio/resolver/ad2s1210.c
> @@ -176,7 +176,7 @@ struct ad2s1210_state {
>  static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
>  {
>  	struct gpio_descs *gpios = st->mode_gpios;
> -	DECLARE_BITMAP(bitmap, 2);
> +	DECLARE_BITMAP(bitmap, 2) = { };
>  
>  	if (!gpios)
>  		return mode == st->fixed_mode ? 0 : -EOPNOTSUPP;
> @@ -1427,7 +1427,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  	struct device *dev = &st->sdev->dev;
>  	struct gpio_descs *resolution_gpios;
>  	struct gpio_desc *reset_gpio;
> -	DECLARE_BITMAP(bitmap, 2);
> +	DECLARE_BITMAP(bitmap, 2) = { };
>  	int ret;
>  
>  	/* should not be sampling on startup */
> 


