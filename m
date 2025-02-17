Return-Path: <linux-iio+bounces-15657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2A3A3849B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946103B5816
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E521C9E8;
	Mon, 17 Feb 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3wGO67j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5875C603;
	Mon, 17 Feb 2025 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798529; cv=none; b=Tva3TIlalO8MI0p77rYkN3sYQxg7modKyT0Azviw1xAtmznfM60ArzJKMiGomg2gmK7XlDaXSSnGeKpX7C7O0dEZYrkgxMnFCTlptieC9P2z7EN7/AKfqj7HZR5zE1aMCRRFbXTxl0rGC8GMIs32nPKeXTuVlhsCqOx1WvYkE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798529; c=relaxed/simple;
	bh=cjkUYj+Oju2fmJ6PA2eSnbPDN38qkYIJI5bmMJeyiWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlDb5DBP9C8Wbz7sgLE4pEUnk0UkIMpkmXuaPp2R1R4oOKOcBDybne1LBTXQTkGZ9cIiJwL1bPjnW5qecpQnR+bw1pfzzFMMmO1tex6WUO0kRY96Fm7m4OGs0y2ksY7VT4jgEAT8GPuJC7465qjpHGfYBHZjGnBqhKYxwNBIVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3wGO67j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AADC4CED1;
	Mon, 17 Feb 2025 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739798528;
	bh=cjkUYj+Oju2fmJ6PA2eSnbPDN38qkYIJI5bmMJeyiWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g3wGO67jesrTUMQ9NbHPL4Bhpj/svCflzd4yqTcLoLH7AKNUOG0EylV1C27g/UrKl
	 upEJkucYnzY4rPkR+sjsENrLTyyPvWpjBATiExB0kt93L5cljGcAxrN2vbyiLb+tLa
	 5uCfuyvDGeYp6+PI/WSQWedNhXelLSlnRN17qxU9IZfYn34qMI7GRowSu8xJy1H6cg
	 MQY2PmB1sRO5qXFoB8qPcAoIrKW4JDA7azhA7XEscNWCyK8ztr0fY9TP6QfdFuXNua
	 BhkWLUeX72OSeKs2oM3tk2CK1k1lixlhuZKTp/OkCSn/Wz2vbujcgzE33RaMJIctAz
	 a/pQSsBWqwaew==
Date: Mon, 17 Feb 2025 13:21:52 +0000
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
 linux-sound@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
Message-ID: <20250217132152.29d86d6c@jic23-huawei>
In-Reply-To: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 16:33:26 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This series was inspired by some minor annoyance I have experienced a
> few times in recent reviews.
> 
> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> having so many parameters. In most cases, we already have a struct
> gpio_descs that contains the first 3 parameters so we end up with 3 (or
> often even 6) pointer indirections at each call site. Also, people have
> a tendency to want to hard-code the first argument instead of using
> struct gpio_descs.ndescs, often without checking that ndescs >= the
> hard-coded value.
> 
> So I'm proposing that we add a gpiod_multi_set_value_cansleep()
> function that is a wrapper around gpiod_set_array_value_cansleep()
> that has struct gpio_descs as the first parameter to make it a bit
> easier to read the code and avoid the hard-coding temptation.
> 
> I've just done gpiod_multi_set_value_cansleep() for now since there
> were over 10 callers of this one. There aren't as many callers of
> the get and atomic variants, but we can add those too if this seems
> like a useful thing to do.
> 
> Maintainers, if you prefer to have this go through the gpio tree, please
> give your Acked-by:. Several maintainers have also requested an
> immutable branch, so I expect that will be made available. And if there
> is anything leftover after the next kernel release, I will resend it.
I've applied 7-10 to the IIO tree after merging the immutable tag with patch 1.

Jonathan

> 
> ---
> Changes in v3:
> - Added IS_ERR_OR_NULL() check to gpiod_multi_set_value_cansleep()
> - Added new patches to clean up accessing bitmap directly (ts-nbus, ad2s1210).
> - Added function prefix for max3191x.
> - Removed unnecessary braces in ad7606 patch.
> - Picked up additional trailers.
> - Link to v2: https://lore.kernel.org/r/20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com
> 
> Changes in v2:
> - Renamed new function from gpiods_multi_set_value_cansleep() to
>   gpiod_multi_set_value_cansleep()
> - Fixed typo in name of replaced function in all commit messages.
> - Picked up trailers.
> - Link to v1: https://lore.kernel.org/r/20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com
> 
> ---
> David Lechner (15):
>       gpiolib: add gpiod_multi_set_value_cansleep()
>       auxdisplay: seg-led-gpio: use gpiod_multi_set_value_cansleep
>       bus: ts-nbus: validate ts,data-gpios array size
>       bus: ts-nbus: use gpiod_multi_set_value_cansleep
>       bus: ts-nbus: use bitmap_get_value8()
>       gpio: max3191x: use gpiod_multi_set_value_cansleep
>       iio: adc: ad7606: use gpiod_multi_set_value_cansleep
>       iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansleep
>       iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
>       iio: resolver: ad2s1210: use bitmap_write
>       mmc: pwrseq_simple: use gpiod_multi_set_value_cansleep
>       mux: gpio: use gpiod_multi_set_value_cansleep
>       net: mdio: mux-gpio: use gpiod_multi_set_value_cansleep
>       phy: mapphone-mdm6600: use gpiod_multi_set_value_cansleep
>       ASoC: adau1701: use gpiod_multi_set_value_cansleep
> 
>  drivers/auxdisplay/seg-led-gpio.c           |  3 +--
>  drivers/bus/ts-nbus.c                       | 15 +++++++++------
>  drivers/gpio/gpio-max3191x.c                | 18 +++++++-----------
>  drivers/iio/adc/ad7606.c                    |  3 +--
>  drivers/iio/adc/ad7606_spi.c                |  7 +++----
>  drivers/iio/amplifiers/hmc425a.c            |  3 +--
>  drivers/iio/resolver/ad2s1210.c             | 13 +++++--------
>  drivers/mmc/core/pwrseq_simple.c            |  3 +--
>  drivers/mux/gpio.c                          |  4 +---
>  drivers/net/mdio/mdio-mux-gpio.c            |  3 +--
>  drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 +---
>  include/linux/gpio/consumer.h               | 11 +++++++++++
>  sound/soc/codecs/adau1701.c                 |  4 +---
>  13 files changed, 43 insertions(+), 48 deletions(-)
> ---
> base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
> change-id: 20250131-gpio-set-array-helper-bd4a328370d3
> 
> Best regards,


