Return-Path: <linux-iio+bounces-19632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB9ABB0FC
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D1E1893B88
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F82D21D3D2;
	Sun, 18 May 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMYN4khO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B564B1E73;
	Sun, 18 May 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747587522; cv=none; b=eSoA6oTz4Y5InC4aQ1Z5LRCTH40gL7XLDljFnUI9sqkGZaNQ6sOq9EOZok+nmeHF6HTdeX0oEzAdHm4DZXf7PqT0ACGWTq14fZz0zoJ1OQOiU0lljiO+I//Dno0RH/CQGwokxhui7tDsJ/alghkAKRoqusu4U7FMqWsZxtuvVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747587522; c=relaxed/simple;
	bh=upA6vDnzO3ItMnQAeDPHrxxy+Iz/5wT+uJn7RE9Tnc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZst2vgV/x7EvVelOHsXTOZ5PRJm73fYPCiPukE30kre1f2eSWnHpVU9UkEx4TFwtR9aNm4u4ohjPvKqps5nliCM5jOXPDJyiYuzTnBQdg7l32oSOzigLZ2jtLtlgTwsNCFtYYCqmx8WFXanKn0lIYEd4z74NxbRtp10XCosOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMYN4khO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCC1C4CEE7;
	Sun, 18 May 2025 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747587522;
	bh=upA6vDnzO3ItMnQAeDPHrxxy+Iz/5wT+uJn7RE9Tnc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMYN4khOeOvNBT3mwu8Ga0UV8JIV2nD31vsuWUBr1Hel/aqLUUM09redONZe5DEWW
	 4DHbwQNbFevuXCKNuXIXOgFdDEke3j4puaBN+dsSL5D+czv54QzDi7yyG6nCUdRfZE
	 /VItMYDmabCrrFFNkOOgXY8VFBbaCwluP6TA8N3CyxPa9NtN2BEuqeto7+Gt0bC2HP
	 doW3irzBreJLYM9+uzvLtHST5cdRbyfvmG6N29ztOzNtCRhyG5Ick55lerp11j0vnP
	 GFmF0ICsCcouLGSDZPtF1g5BOpPsnLUZ4GZFUPd778yo1yV40NNRKJelEz3Lttkc9f
	 y/D2DX4oVssoA==
Date: Sun, 18 May 2025 17:58:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v8 08/11] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <20250518175832.77b8d670@jic23-huawei>
In-Reply-To: <aCcFXolH0FVBSP11@smile.fi.intel.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
	<59f45c9af16fa68f2a479f824129f5a9f2cd0997.1747175187.git.Jonathan.Santos@analog.com>
	<aCcFXolH0FVBSP11@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 12:29:02 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, May 15, 2025 at 06:13:56PM -0300, Jonathan Santos wrote:
> > The synchronization method using GPIO requires the generated pulse to be
> > truly synchronous with the base MCLK signal. When it is not possible to
> > do that in hardware, the datasheet recommends using synchronization over
> > SPI, where the generated pulse is already synchronous with MCLK. This
> > requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
> > 
> > Use trigger-sources property to enable device synchronization over SPI
> > and multi-device synchronization while replacing sync-in-gpios property.  
Given some discussion in here I'll not (yet) pick up this series.

It's almost certainly just missed the coming merge window anyway so
we have time.

> 
> ...
> 
> > +static int ad7768_trigger_sources_get_sync(struct device *dev,
> > +					   struct ad7768_state *st)
> > +{
> > +	struct fwnode_reference_args args;
> > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > +	int ret;
> > +
> > +	/*
> > +	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> > +	 * to synchronize one or more devices:
> > +	 * 1. Using an external GPIO.
> > +	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
> > +	 *    synchronization pulse that drives the SYNC_IN pin.
> > +	 */
> > +	if (!fwnode_property_present(fwnode, "trigger-sources")) {  
> 
> I'm wondering if you can split the below to a separate function and do something like
> 
> 	if (fwnode_property_present(...))
> 		return setup_trigger_source(...);
> 
> 	...
> 	en_spi_sync = true;
> 	return 0;
> 
> > +		/*
> > +		 * In the absence of trigger-sources property, enable self
> > +		 * synchronization over SPI (SYNC_OUT).
> > +		 */
> > +		st->en_spi_sync = true;
> > +		return 0;
> > +	}
> > +
> > +	ret = fwnode_property_get_reference_args(fwnode,
> > +						 "trigger-sources",
> > +						 "#trigger-source-cells",
> > +						 0,
> > +						 AD7768_TRIGGER_SOURCE_SYNC_IDX,
> > +						 &args);  
> 
> 
> __free(fwnode_handle) ?

For args.fwnode?

That's fiddly to do and needs a different local variable to...



> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	fwnode = args.fwnode;

this one.

You could wrap it up in a function to make that works cleanly.
So something similar to fwnode_find_reference() but with the
rest of the arguments.  Is there appetite for such a wrapper
in the generic property code?


> > +	/* First, try getting the GPIO trigger source */
> > +	if (fwnode_device_is_compatible(fwnode, "gpio-trigger")) {
> > +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, fwnode,
> > +							       NULL,
> > +							       0,
> > +							       GPIOD_OUT_LOW,
> > +							       "sync-in");
> > +		ret = PTR_ERR_OR_ZERO(st->gpio_sync_in);
> > +		goto out_put_node;
> > +	}
> > +
> > +	/*
> > +	 * TODO: Support the other cases when we have a trigger subsystem to
> > +	 * reliably handle other types of devices as trigger sources.
> > +	 *
> > +	 * For now, return an error message. For self triggering, omit the
> > +	 * trigger-sources property.
> > +	 */
> > +	ret = dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> > +
> > +out_put_node:  
> 
> The above will allow to get rid of this label.
> 
> > +	fwnode_handle_put(args.fwnode);
> > +	return ret;
> > +}  
> 


