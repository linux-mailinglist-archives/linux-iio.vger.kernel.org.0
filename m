Return-Path: <linux-iio+bounces-6767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F041913C87
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4025B1C21B59
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74560181B97;
	Sun, 23 Jun 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgEFINGP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F6138C;
	Sun, 23 Jun 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157554; cv=none; b=r2tT70iMMMLVfJh83WdB3afGdXvcG5a8eAq0XcD+azS5MPS+eccN35mnAHAFVNLZy+paVf19cdiSDAPkmcyiXrcLDU8x0OWur6hDC9vbKdakOB0k+AlhStKJ709j/jbAAMLOij2j3ulOAE2bTY1suLBxb3tR+SctUl3im234RPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157554; c=relaxed/simple;
	bh=uQe4Enk2M6hfxf4cAkez/EJZ6Q60mIRiKfh6LopyAV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izFdqzZjhh7dT9rWy4AWJXCIgALQI28RqAu0CdmvyaXw+mFYYhRId+LnbWlyUVQUrnK5ppFjdg6OWRZ55IfutbQo+13Upsknt4/xLqipCr/Bid8QS9wRr/L/YW0bvm8n6xeXhaQOprV/7ZESlmWrxxHVYF2NY+V2E0cNAJB+FLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgEFINGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59996C2BD10;
	Sun, 23 Jun 2024 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719157553;
	bh=uQe4Enk2M6hfxf4cAkez/EJZ6Q60mIRiKfh6LopyAV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YgEFINGPHd2RojkLuxivUjkSXxnykqnel7Sd81FKDjpEnmMQvg8GDWGwMl5nP7Ed/
	 3AwtOnBoztc2LjUQSOWSwX3Ofp5y+Rdt67GfUgsBw+MZcEcqhjc5/Z0MnJDkJpkD91
	 CcN9llIQxpSvF8UEL1kGqFH4OLLr76/5ONppIfY7A+rwDFNxOZBT8udbN+HMwKzerN
	 u12agM0hsxF9QpuhCXEd/o4b4Wiu0P5vxJIlwBbi45G4rMlFPPQaGUxuhLUCZ2YiC0
	 T/X+OezZse9zHoYLRr7ZOralYuqH6UJ1p+JaFMM5BDbEUFLaMY5ZDm5JIUDUMbOJ1H
	 52TUICz74cAIw==
Date: Sun, 23 Jun 2024 16:45:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 8/9] iio: adc: ad7606: fix oversampling gpio array
Message-ID: <20240623164542.53a9f2b1@jic23-huawei>
In-Reply-To: <20240618-cleanup-ad7606-v1-8-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
	<20240618-cleanup-ad7606-v1-8-f1854d5c779d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:02:40 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> gpiod_set_array_value was misused here: the implementation relied on the
> assumption that an unsigned long was required for each gpio, while the
> function expects a bit array stored in "as much unsigned long as needed
> for storing one bit per GPIO", i.e it is using a bit field.
> 
> Fixes: d2a415c86c6b ("iio: adc: ad7606: Add support for AD7606B ADC")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Always drag fixes to the start of a series.  Probably doesn't matter
in this case but we want it to be obvious there are no necessary precursors
in this series for anyone backporting.

What is the user visible outcome of this bug?  Superficially the numbers
all end up the same I think even though the code is clearly working
mostly by luck.  So might not warrant a fixes tag?


> ---
>  drivers/iio/adc/ad7606.c     | 4 ++--
>  drivers/iio/adc/ad7606_spi.c | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index e3426287edf6..502344e019e0 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -235,9 +235,9 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	DECLARE_BITMAP(values, 3);
>  
> -	values[0] = val;
> +	values[0] = val & GENMASK(2, 0);
>  
> -	gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
> +	gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
>  			      st->gpio_os->info, values);
>  
>  	/* AD7616 requires a reset to update value */
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 263a778bcf25..287a0591533b 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -249,8 +249,9 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
>  static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -	unsigned long os[3] = {1};
> +	DECLARE_BITMAP(os, 3);
>  
> +	bitmap_fill(os, 3);
>  	/*
>  	 * Software mode is enabled when all three oversampling
>  	 * pins are set to high. If oversampling gpios are defined
> @@ -258,7 +259,7 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
>  	 * otherwise, they must be hardwired to VDD
>  	 */
>  	if (st->gpio_os) {
> -		gpiod_set_array_value(ARRAY_SIZE(os),
> +		gpiod_set_array_value(st->gpio_os->ndescs,
>  				      st->gpio_os->desc, st->gpio_os->info, os);
>  	}
>  	/* OS of 128 and 256 are available only in software mode */
> 


