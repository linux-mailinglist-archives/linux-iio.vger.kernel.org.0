Return-Path: <linux-iio+bounces-14202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C0A0A962
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D08D7A1511
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E71B4148;
	Sun, 12 Jan 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h45FQaKR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC0D3C1F;
	Sun, 12 Jan 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736686762; cv=none; b=KrDNkCJ6w99X1AiEV2zoMkbVZ+IjDrNW9l2Qm6W2jYJtR7JWniWxaGpJDygkCwpvjyaR0rHkC7aFFy/hQ2lNhn5kPl/cBcLPgGIIkPC+6+ZR7WjQz8mg6eReqdLZTaGqHeFDPC5DnYJIBrHHO1dHeHF+yQIoHRpAfP+urz7mncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736686762; c=relaxed/simple;
	bh=WkrHIGdtR5ZdYcpXZgxkITmKXrAiqITdKKOcQ66HBCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DS6gauJneoL4mZWc/pfws7be/xYf/xiqmEDZZwizEmV8C8JaZl5s+Pp6SiXAp3OydxEndK9YiKdTuwza2vostedtivNWKM3LmieVNFr3e+dLVLB8AzFsWmv+5yO0n2xyRpJeUBUV/cqn71KhvWkvXbfZ31jaljmHaL4qQHXW22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h45FQaKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A46C4CEE2;
	Sun, 12 Jan 2025 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736686762;
	bh=WkrHIGdtR5ZdYcpXZgxkITmKXrAiqITdKKOcQ66HBCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h45FQaKRzrf0dToOgmhgUDBtGTtvAA43FP58SHlm8DvDnaByPLv3ulTMrdGJ7G2fo
	 cfckFfrvQHdmjd0s6rY9PZUV+8Gglf5Yh0etnNEYcTScmL5NeXM7+RvR95ywP0r84w
	 3iWV7J7WpvXNe/85vYUHL8G0A/0SIdu9o8GOkktEClJXV2QlWq/c61qo+b1Y4G5a0q
	 RkDh4SIvAqbK1C/sdFxxJOmibjFnwAtSZke516olbiDmU3Fza+0Q98CzBCJBUfUwoD
	 SZPfnZAD3dKjgl/+Jh8XOAlfBTmCQNd9gt6ti/6c904gHchwyFa+XxYCpN305SikTG
	 wARvMsXbB8rjA==
Date: Sun, 12 Jan 2025 12:59:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 14/15] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <20250112125913.3ea9c71b@jic23-huawei>
In-Reply-To: <c0981545-5e0e-4b6e-93d9-cb2871b583e8@baylibre.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<0f9a15e6e2e6b7b2c82ef79d8cb883d9eb6c55dd.1736201898.git.Jonathan.Santos@analog.com>
	<c0981545-5e0e-4b6e-93d9-cb2871b583e8@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 17:50:29 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/7/25 9:27 AM, Jonathan Santos wrote:
> > The synchronization method using GPIO requires the generated pulse to be
> > truly synchronous with the base MCLK signal. When it is not possible to
> > do that in hardware, the datasheet recommends using synchronization over
> > SPI, where the generated pulse is already synchronous with MCLK. This
> > requires the SYNC_OUT pin to be connected to SYNC_IN pin.
> > 
> > Add the option to handle device synchronization over SPI.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---  
> 
> ...
> 
> >  static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> > @@ -697,11 +708,21 @@ static int ad7768_setup(struct ad7768_state *st)
> >  	if (ret)
> >  		return ret;
> >  
> > -	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
> > -					  GPIOD_OUT_LOW);
> > +	st->gpio_sync_in = devm_gpiod_get_optional(&st->spi->dev, "adi,sync-in",
> > +						   GPIOD_OUT_LOW);
> >  	if (IS_ERR(st->gpio_sync_in))
> >  		return PTR_ERR(st->gpio_sync_in);
> >  
> > +	if (device_property_present(&st->spi->dev, "adi,sync-in-spi"))
> > +		st->en_spi_sync = true;
> > +
> > +	/*
> > +	 * GPIO and SPI Synchronization are mutually exclusive.
> > +	 * Return error if both are enabled  
> 
> Should it also be an error if we have neither? Otherwise it sounds like
> decimation won't work correctly since there is a comment that says we have
> to toggle this after updating the decimation rate register.

I'm not quite sure how this interacts with potential future support
for daisy chaining but for now, if we have no GPIO specified why can't
we assume spi sync is the way to go?

If no GPIO is provided and for a single device SYNC_OUT is not wired
to SYNC_IN I think the board is broken anyway and we don't have to care.

Jonathan

> 
> > +	 */
> > +	if (st->gpio_sync_in && st->en_spi_sync)
> > +		return -EINVAL;  
> 
> A dev_err_probe() message would be helpful here when creating a new DT and
> bringing up a new system since it is easy to forget a property or make a typo
> that could lead to this error.
> 
> > +
> >  	ret = ad7768_gpio_init(st);
> >  	if (ret < 0)
> >  		return ret;  
> 
> 


