Return-Path: <linux-iio+bounces-27444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC3CEC6D2
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B13B130109BA
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 17:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6B02EA169;
	Wed, 31 Dec 2025 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3iPbJC3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7B2E973F;
	Wed, 31 Dec 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767203961; cv=none; b=rlnzv7keM4ratjZ/HfSbhkvSZfkQliju578/mIxICxrm8ba7MWsO6mSw/0axgoE+dhbvWNv1rmsAONrDc00IgYcxDqswemNy1GBavtyXQS0CJy1YqD7k+Q2Efn8si8c+H65qRQEi0F5ue5OiLo6oW0GGIGTTi38+kOrv3bKsMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767203961; c=relaxed/simple;
	bh=dhObxBO+lfzWN6lSVxaTTF27o9HZ/G424vG2pktRt1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5ck/M/jv3MR5PyXb3cXjhr+sFeHudM6G1wP71UNJZQffvKmZHqJZgKgLM3ISspRYz6tPrSHpl6bamcOdR8nOcu+JfTQ3sTU6Dfz3CnuGRh/vDejoJZT/HvcaqRYrx5Qbor28o82OypM/gJcLi6FVc82XPAwqRdgwol2cfSim8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3iPbJC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CD1C113D0;
	Wed, 31 Dec 2025 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767203960;
	bh=dhObxBO+lfzWN6lSVxaTTF27o9HZ/G424vG2pktRt1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D3iPbJC32riOrMX1LyJEnICghUKyEvHAZPKgiwur5SZIFg9L8FBAcjvALWGNPwaKw
	 v3penQKuh2ljdmcD+ey2xrewyEHeBZgv1jmDcszoeszXJGPRXFSIjqTRvZdlMClhlG
	 Db/B2JihNke73WnaagJM/f4GKZ7ssVYi4qv5DmO7m1xbkRPI6ysssZG7jUo3heS2Dp
	 RvoObPimvVOQfOZ+d2zxntWI9ZM//VPQQug8KdtrbEhdK0nwrW57qlO3hsZEshwnqM
	 UcEQ+Kev6/jUjwdg1CRh/MWRuXP+zlmxOuYiN7PM5VipeL2TaMmX6GbSFq7ebFFgVe
	 dsQ8WDdrdlr8Q==
Date: Wed, 31 Dec 2025 17:59:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: dac: adding support for Microchip
 MCP47FEB02
Message-ID: <20251231175911.43431a45@jic23-huawei>
In-Reply-To: <aVAD13oSRAlj-1VF@smile.fi.intel.com>
References: <20251216-mcp47feb02-v4-0-4b687094ff90@microchip.com>
	<20251216-mcp47feb02-v4-2-4b687094ff90@microchip.com>
	<20251227155245.6a3f5344@jic23-huawei>
	<aVAD13oSRAlj-1VF@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Dec 2025 18:05:43 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Dec 27, 2025 at 03:52:45PM +0000, Jonathan Cameron wrote:
> > On Tue, 16 Dec 2025 14:05:51 +0200
> > Ariana Lazar <ariana.lazar@microchip.com> wrote:  
> 
> > > This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1,
> > > MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series
> > > of buffered voltage output Digital-to-Analog Converters with nonvolatile or
> > > volatile memory and an I2C Interface.
> > > 
> > > The families support up to 8 output channels.
> > > 
> > > The devices can be 8-bit, 10-bit and 12-bit.
> > > 
> > > Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>  
> > Hi Ariana,
> > 
> > One stale bit of documentation and I'd be surprised if the
> > style of text used in Kconfig short help proves sustainable.
> > We often end up over time moving to 'x and similar' to avoid
> > very complex pattern matching as more and more parts end up supported
> > by a given driver.
> > 
> > With those in mind. Applied to the togreg branch of iio.git which I'll initially
> > push out as testing to let 0-day take a poke at it.
> > 
> > Thanks
> > 
> > Jonathan
> >   
> > > diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..c04f3b72b1b1fc303b1bde63c281aade8a67b2f9
> > > --- /dev/null
> > > +++ b/drivers/iio/dac/mcp47feb02.c  
> >   
> > > +/**
> > > + * struct mcp47feb02_data - chip configuration
> > > + * @chdata: options configured for each channel on the device
> > > + * @lock: prevents concurrent reads/writes to driver's state members
> > > + * @chip_features: pointer to features struct
> > > + * @scale_1: scales set on channels that are based on Vref1
> > > + * @scale: scales set on channels that are based on Vref/Vref0
> > > + * @active_channels_mask: enabled channels
> > > + * @client: the i2c-client attached to the device  
> > 
> > Not there. I'll tidy this up whilst applying if nothing else
> > comes up.
> >   
> > > + * @regmap: regmap for directly accessing device register
> > > + * @vref1_buffered: Vref1 buffer is enabled
> > > + * @vref_buffered: Vref/Vref0 buffer is enabled
> > > + * @phys_channels: physical channels on the device
> > > + * @labels: table with channels labels
> > > + * @use_vref1: vref1-supply is defined
> > > + * @use_vref: vref-supply is defined
> > > + */
> > > +struct mcp47feb02_data {
> > > +	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
> > > +	struct mutex lock; /* prevents concurrent reads/writes to driver's state members */
> > > +	const struct mcp47feb02_features *chip_features;
> > > +	int scale_1[2 * MCP47FEB02_MAX_SCALES_CH];
> > > +	int scale[2 * MCP47FEB02_MAX_SCALES_CH];
> > > +	unsigned long active_channels_mask;
> > > +	struct regmap *regmap;
> > > +	bool vref1_buffered;
> > > +	bool vref_buffered;
> > > +	u16 phys_channels;
> > > +	const char *labels[MCP47FEB02_MAX_CH];
> > > +	bool use_vref1;
> > > +	bool use_vref;  
> 
> I would group slightly different these:
> 
> 	...
> 	const char *labels[MCP47FEB02_MAX_CH];
> 	bool vref1_buffered;
> 	bool vref_buffered;
> 	bool use_vref1;
> 	bool use_vref;
> 	u16 phys_channels;
> 
> With this the vref grouped together and not split. A possible variant:
> 
> 	const char *labels[MCP47FEB02_MAX_CH];
> 	u16 phys_channels;
> 	bool vref1_buffered;
> 	bool vref_buffered;
> 	bool use_vref1;
> 	bool use_vref;
> 
> Jonathan, can you also tweak this?
> 
> And I think it's worth to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Sure. Done with the second option.

Jonathan

> 
> > > +};  
> 


