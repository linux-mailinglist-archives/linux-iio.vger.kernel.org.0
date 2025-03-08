Return-Path: <linux-iio+bounces-16547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E2A57A7C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3FA3B2FF1
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99231BEF74;
	Sat,  8 Mar 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgrE1vSY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72D4C70;
	Sat,  8 Mar 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741440657; cv=none; b=RrzJ/hZ/hMYXFgV0HnceZIsSLiqIvg446zpOFsIjzAFPAKkOLAHWbkN8XP6pjxQ73v8JLXXgaOYj6pIixlnbGIUn9EOZmxV2ufj66kKtas01FNlNtp+5e5aMB3WiINh1L3C/oMmfkqxzpYPtffGCbXZRENufQQnFo49HGqwKQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741440657; c=relaxed/simple;
	bh=l+KYoPy1W++DpoqS9X+vOEm/qsEB5yFrTh+h6WL1POU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCx0js9m+trwQiyrCq0XX1SHXyBga6jUJt7xe+5yjsWT4RGsHD+VtBI2qu8q9fOYpV5UkAuXFASNSVSZsfB6z9kIVxi//D4hBlIuNU0Yq85dmaxHljK6rKxha+aPxJM2FGe/HfTch81muMjkBLFA2nNHJTjHRY6rvjHAPaVOsdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgrE1vSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF3CC4CEE0;
	Sat,  8 Mar 2025 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741440656;
	bh=l+KYoPy1W++DpoqS9X+vOEm/qsEB5yFrTh+h6WL1POU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HgrE1vSYiLu5agPEnuAuy3fdEJVpcyN8Mjq9nuu1/vGuM5nd7kIb/Zfn2Z/EJfSZ7
	 VxJ1eN/SMHA7qz18h9mpTHnl+x4d5QiUHaXpbSRQpwRmO2LhKEuah3vmbBgEps3Je9
	 CiLAwA389qbcSz0f3QI3LgmBWlsa9Pda7y5xpjM/VoFwdrFBbS1J9/h8KYTWn7JE/6
	 Wjr0kO2FpZfioOjRBGmNh6MtlYgmz1Bq7cUPGLk87V/q8yqWtyS6w2R6hfDdhOrfnM
	 a+hqAHt0bSLfLuD4FNb4XlRoPbjpsmeyfQBjbRsRG85PiCoGY6FSY3weqbeZnHEbY1
	 +b+fiBwnk4B2Q==
Date: Sat, 8 Mar 2025 13:30:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, dlechner@baylibre.com, jonath4nns@gmail.com
Subject: Re: [PATCH v4 09/17] iio: adc: ad7768-1: Add reset gpio
Message-ID: <20250308133045.2b3b2f49@jic23-huawei>
In-Reply-To: <Z8r3sR740CpZfVFr@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<305f0bb4a90aba547de6b46d4c9dcf04a2a4db72.1741268122.git.Jonathan.Santos@analog.com>
	<Z8r3sR740CpZfVFr@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 10:42:09 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 03/06, Jonathan Santos wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > Depending on the controller, the default state of a gpio can vary. This
> > change excludes the probability that the dafult state of the ADC reset
> > gpio will be HIGH if it will be passed as reference in the devicetree.  
> 
> The description doesn't seem to match the changes nor the patch title. You are
> essentinally adding support for hardware reset. Change the commit description to
> reflect that.
> 
> The default state of GPIOs would not impact device reset because (in theory)
> they weren't being connected to the reset pin prevously.
Also possible some other entity was doing appropriate reset (sometimes
it's just how the system is wired - puts appropriate voltage to come out
of reset after some other action - no kernel involvement).

Agreed in general though that this is simpler described as just implementing
hardware reset and not worry about those details.

Jonathan

> 
> > 
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v4 Changes:
> > * None.
> > 
> > v3 Changes:
> > * fixed SoB order.
> > * increased delay after finishing the reset action to 200us, as the
> >   datasheet recommends.
> > 
> > v2 Changes:
> > * Replaced usleep_range() for fsleep() and gpiod_direction_output() for 
> >   gpiod_set_value_cansleep().
> > * Reset via SPI register is performed if the Reset GPIO is not defined. 
> > ---
> >  drivers/iio/adc/ad7768-1.c | 36 ++++++++++++++++++++++++------------
> >  1 file changed, 24 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 04a26e5b7d5c..86f44d28c478 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -166,6 +166,7 @@ struct ad7768_state {
> >  	struct completion completion;
> >  	struct iio_trigger *trig;
> >  	struct gpio_desc *gpio_sync_in;
> > +	struct gpio_desc *gpio_reset;
> >  	const char *labels[ARRAY_SIZE(ad7768_channels)];
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> > @@ -487,19 +488,30 @@ static int ad7768_setup(struct ad7768_state *st)
> >  {
> >  	int ret;
> >  
> > -	/*
> > -	 * Two writes to the SPI_RESET[1:0] bits are required to initiate
> > -	 * a software reset. The bits must first be set to 11, and then
> > -	 * to 10. When the sequence is detected, the reset occurs.
> > -	 * See the datasheet, page 70.
> > -	 */
> > -	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
> > -	if (ret)
> > -		return ret;
> > +	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> > +						 GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->gpio_reset))
> > +		return PTR_ERR(st->gpio_reset);
> >  
> > -	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
> > -	if (ret)
> > -		return ret;
> > +	if (st->gpio_reset) {
> > +		fsleep(10);
> > +		gpiod_set_value_cansleep(st->gpio_reset, 0);
> > +		fsleep(200);
> > +	} else {
> > +		/*
> > +		 * Two writes to the SPI_RESET[1:0] bits are required to initiate
> > +		 * a software reset. The bits must first be set to 11, and then
> > +		 * to 10. When the sequence is detected, the reset occurs.
> > +		 * See the datasheet, page 70.
> > +		 */
> > +		ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
> >  					  GPIOD_OUT_LOW);
> > -- 
> > 2.34.1
> >   


