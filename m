Return-Path: <linux-iio+bounces-12919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967609DF5C2
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 14:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5208C2817A7
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60461CC8BD;
	Sun,  1 Dec 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDfg1AA6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8C2CA8;
	Sun,  1 Dec 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733059263; cv=none; b=FpQ5QpYErCBrtcwOcSkS6iL8t3WaqCLwiA2nk+7psMWUeqgIuS7MXwpwfNRZGu2pFvw+3GlpCflgYn+1P+H36jLai+DRx+lBInNFRpZpcmPIowOm180qHhtAT56ed4qWMHzg87jzWpDSdqI8Q5vSI6WCgSkLJTqoofdtjeCK7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733059263; c=relaxed/simple;
	bh=ztB5yIm9DtiaC8R6vn7o/JGvks6oHXhp3FH7dLKnQ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFW8sWELEz5RnCqlSfhgN80RXZ8+JEuNnXpwKTCi21kBMyU9n19sfDHptfEu+OxZLpkwAFI6AIEVaBUQ8zBPqsQZaCGkFcu9tMuVK7efvTAiIffDaputiqF/EAlCxkdcMRySySKiYDrKMfIBMwCOMymBsNSIVK+YM376AvN4KI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDfg1AA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3066EC4CED2;
	Sun,  1 Dec 2024 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733059263;
	bh=ztB5yIm9DtiaC8R6vn7o/JGvks6oHXhp3FH7dLKnQ4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gDfg1AA6hjrimr5xEpEcdiOBniAytM82NBmbx8GepfFzwLCjjtNg9uajDh3kYVlO4
	 r/OnYQAGF13mcYGK9hDaohp4x8hAMOS921pIhxjb/QdKX1DxgqxKiwDy6avhmB7HkR
	 CWTYo3L9BWCxk6TyfL2nHDLKLIoGNFGmfkC8EMcrQVzKLMDTwA+l6t63U5V8ESPm5m
	 ifdUQeUXv0m4y4J9TsHE6+fUIJeczjo8zb+prIfLwgr1HSlHMPRtkMA4pq2WFtY44Y
	 N/ejWeQ1im6g839TjcrtYj8K9p41fz0JLzITZcwf0s0zz1ssez4NH90SZB5yrJsOMi
	 95yqZGphHoVPA==
Date: Sun, 1 Dec 2024 13:20:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Cc: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Mikael
 Gonella-Bolduc <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <20241201132054.0c063a11@jic23-huawei>
In-Reply-To: <Z0eY+1X1ZSkNui9U@uva.nl>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
	<20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>
	<20241124211545.194a9f87@jic23-huawei>
	<Z0eY+1X1ZSkNui9U@uva.nl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +};
> > > +MODULE_DEVICE_TABLE(of, apds9160_of_match);
> > > +
> > > +static struct i2c_driver apds9160_driver = {
> > > +	.driver	  = {
> > > +		.name	= APDS9160_DRIVER_NAME,
> > > +		.owner = THIS_MODULE,
> > > +		.of_match_table = apds9160_of_match,
> > > +	},
> > > +	.probe    = apds9160_probe,
> > > +	.remove	  = apds9160_remove,
> > > +	.id_table = apds9160_id,
> > > +};  
> 
> Hi Jonathan,
> 

Hi Mikael,

One quick process thing first.  Please crop replies. It is far too easy to miss comments
inline (I don't think there were any?) and reviewers aren't fond of scrolling through lots
of context that isn't relevant to a particular discussion.

> Thank you for the feedback. I'm currently in the process of integrating the comments from all the reviewers for a rev 2.
> However, there's still some things that are not clear for me that I'm not sure on how to handle properly.
> 
> First, regarding the integration time/gain/scale parameters. I took a look at the datasheet again as there is a table
> provided to get lux/count (scale?) for the ALS sensor depending on gain and integration time. 
> 
> It looks like the correlation in the table is almost linear but it's not as there is a loss of precision.
> For example, at 1x gain with integration time 100ms the lux/count is 0.819 but at 3x the table is stating 0.269 instead of exepected 0.273.
> 
> Is it still possible to use the gts helpers in that case?

Ah. Probably not if it goes non linear.  Matti? (+CC)

> 
> Second, regarding the use of the IIO_CHAN_INFO_HARDWAREGAIN channel info.
> I took a look at a couple of recent drivers, some use the IIO_CHAN_INFO_SCALE to ajust gain type registers.
> 
> In my use case, it feels like the scale is read-only as it is affected by the gain and integration time and both can be set independently
> with their respective available values. How should I handle this?
The general preference is for the scale to be the primary control. 
For a light sensor assuming the device doesn't support very long integration times, the
trade off is normally set the integration time as high as possible (as that gives lowest
noise) then tune the gain as necessary.

Another model is to let the integration time be controllable and then try and adjust
the gain to keep as close as possible to a requested scale.  Matti has spent more
brain power on this than anyone so I'll over to him for more precise suggestions!

> 
> Finally, you mention to use a dma safe buffer when calling regmap_bulk_read. 
> I took a look at other recent drivers and I don't see any differences on how they are handling this. 
> Could you provide an example of how to ensure the buffer allocated on the stack is dma safe?
Gah. Before going on, I'd failed to notice this was an I2C device and I2C transports
don't need DMA safe buffers (whether or not accessed through regmap). So that comment
was spurious.  Not sure why I thought it was an SPI device :(

Anyhow for future reference:
The only way to do a safe buffer on the stack is to allocate a huge buffer and then
find an appropriate aligned padding.  We simply don't do that.  So reality is you can't use a buffer
on the stack for transfers that require DMA safe buffers.  Either kzalloc the buffer
or look at the many examples where the driver has __aligned(IIO_DMA_MINALIGN) data in iio_priv()
accessed structure.

The regmap case is a little less than clear though.  Last time I checked the reality was
that regmap always bounce buffered anyway as part of it's handling for weird register
formats.  It doesn't need to though and when I asked the maintainer a few years back the
response was that we should continue to use dma safe buffers for bulk transfers if
the underlying transport (e.g. SPI) requires them.

Jonathan



> 
> Best regards,
> Mikael


