Return-Path: <linux-iio+bounces-27368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF91CDFEF0
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC9903009868
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E5A3168E3;
	Sat, 27 Dec 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iY2qdeSU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07DB1A3164;
	Sat, 27 Dec 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766851550; cv=none; b=mVx65QdWTUMPYayDBPFPG0bnTJonzkQ8LpSx/vKBimcTi+aTH1swGT7TcWdV4m+nw1KpBieJHHJTfvPN425sb0qnJwojhISLM1UDNarr9swMY9id9AfPLfkkmI+QjNzi1rFACpK2q/8/L2AL+cNiUqY7stbmg3hK4zKYRQrVpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766851550; c=relaxed/simple;
	bh=XCX/KbtLe6SeKCyI7TFADoY3oPq/avkmtJqfy1yIAuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1e0UUG8EzsXdR6QZpc4HohGEjfdVmuPGy21GZoXtSx/FRcjsKPCBrUxyWt9nEpC9WQtglyuBddHAMsLFTCk6Hjedi9T4tx6VcyZLQDnt+jBgxHqimQK79PmEoqshpHvLPmalt/cH0pOZd/gqmseOxEfoNtzmSnR+Q0GaTjj3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iY2qdeSU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766851549; x=1798387549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XCX/KbtLe6SeKCyI7TFADoY3oPq/avkmtJqfy1yIAuY=;
  b=iY2qdeSU3OqaRneUNR06L6DGpNvmhrjpaHk91ATtFw7ZcXYsuHNttZL0
   3SQpXAtY/k6ZYCLidSHdLaw9RlcPIb9x9il0FZFevNLnSOw1bWdqAIq2C
   7ZNgBv/cuGvCBXSn+PGGnOVZgp8frunRo9xUgWEnRIseAovhbtHiXSATL
   rInKa3aRoNri3G4C7fNnbKUudnvosqhp5YpuJbfz9GFu30hDW+/0Zu7Ei
   oTKgRN58c5+AbeqxuAvFxZ+BzHDdjZ7CdyhuaJjbkIHrXt3hY9WWs6e56
   BKHEMlvTWfeyIa5CTZX17xCIq3a9nHCyFY+f2pshHTm/amfXrBpjsz1pJ
   w==;
X-CSE-ConnectionGUID: l2OsDtjqQh+hksA2V5jwbg==
X-CSE-MsgGUID: x6C5NJ2wScW+5OtsTcfMbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="72400236"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="72400236"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 08:05:49 -0800
X-CSE-ConnectionGUID: AnEYM+IES9q6Cpv91whsng==
X-CSE-MsgGUID: IJDuBZbEQ4eCTZ64FEzG+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="199802696"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 08:05:46 -0800
Date: Sat, 27 Dec 2025 18:05:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <aVAD13oSRAlj-1VF@smile.fi.intel.com>
References: <20251216-mcp47feb02-v4-0-4b687094ff90@microchip.com>
 <20251216-mcp47feb02-v4-2-4b687094ff90@microchip.com>
 <20251227155245.6a3f5344@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227155245.6a3f5344@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Dec 27, 2025 at 03:52:45PM +0000, Jonathan Cameron wrote:
> On Tue, 16 Dec 2025 14:05:51 +0200
> Ariana Lazar <ariana.lazar@microchip.com> wrote:

> > This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1,
> > MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series
> > of buffered voltage output Digital-to-Analog Converters with nonvolatile or
> > volatile memory and an I2C Interface.
> > 
> > The families support up to 8 output channels.
> > 
> > The devices can be 8-bit, 10-bit and 12-bit.
> > 
> > Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> Hi Ariana,
> 
> One stale bit of documentation and I'd be surprised if the
> style of text used in Kconfig short help proves sustainable.
> We often end up over time moving to 'x and similar' to avoid
> very complex pattern matching as more and more parts end up supported
> by a given driver.
> 
> With those in mind. Applied to the togreg branch of iio.git which I'll initially
> push out as testing to let 0-day take a poke at it.
> 
> Thanks
> 
> Jonathan
> 
> > diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..c04f3b72b1b1fc303b1bde63c281aade8a67b2f9
> > --- /dev/null
> > +++ b/drivers/iio/dac/mcp47feb02.c
> 
> > +/**
> > + * struct mcp47feb02_data - chip configuration
> > + * @chdata: options configured for each channel on the device
> > + * @lock: prevents concurrent reads/writes to driver's state members
> > + * @chip_features: pointer to features struct
> > + * @scale_1: scales set on channels that are based on Vref1
> > + * @scale: scales set on channels that are based on Vref/Vref0
> > + * @active_channels_mask: enabled channels
> > + * @client: the i2c-client attached to the device
> 
> Not there. I'll tidy this up whilst applying if nothing else
> comes up.
> 
> > + * @regmap: regmap for directly accessing device register
> > + * @vref1_buffered: Vref1 buffer is enabled
> > + * @vref_buffered: Vref/Vref0 buffer is enabled
> > + * @phys_channels: physical channels on the device
> > + * @labels: table with channels labels
> > + * @use_vref1: vref1-supply is defined
> > + * @use_vref: vref-supply is defined
> > + */
> > +struct mcp47feb02_data {
> > +	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
> > +	struct mutex lock; /* prevents concurrent reads/writes to driver's state members */
> > +	const struct mcp47feb02_features *chip_features;
> > +	int scale_1[2 * MCP47FEB02_MAX_SCALES_CH];
> > +	int scale[2 * MCP47FEB02_MAX_SCALES_CH];
> > +	unsigned long active_channels_mask;
> > +	struct regmap *regmap;
> > +	bool vref1_buffered;
> > +	bool vref_buffered;
> > +	u16 phys_channels;
> > +	const char *labels[MCP47FEB02_MAX_CH];
> > +	bool use_vref1;
> > +	bool use_vref;

I would group slightly different these:

	...
	const char *labels[MCP47FEB02_MAX_CH];
	bool vref1_buffered;
	bool vref_buffered;
	bool use_vref1;
	bool use_vref;
	u16 phys_channels;

With this the vref grouped together and not split. A possible variant:

	const char *labels[MCP47FEB02_MAX_CH];
	u16 phys_channels;
	bool vref1_buffered;
	bool vref_buffered;
	bool use_vref1;
	bool use_vref;

Jonathan, can you also tweak this?

And I think it's worth to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> > +};

-- 
With Best Regards,
Andy Shevchenko



