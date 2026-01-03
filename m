Return-Path: <linux-iio+bounces-27473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03717CF001B
	for <lists+linux-iio@lfdr.de>; Sat, 03 Jan 2026 14:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551C430084EF
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jan 2026 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178021D3CC;
	Sat,  3 Jan 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAdUsgVU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAB22424C;
	Sat,  3 Jan 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767446512; cv=none; b=dwdL9Xh24YzCbwjPKsWCBYewwMl9AdoaTCm3quffocKw05VYPytFgTf1RbS52sMule4OR8+fn7Gkbe/vU9UG78bo8IQDbqOzSEleSpeuI7X9M49TwD9gFtG1LUK2mMDR+tqqUZIVOiXQitzwFYspfPrwlH7HX31B5hGK9kgNQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767446512; c=relaxed/simple;
	bh=LVG7gOaNjtZhVTGcvJRYj/Jf17AG7P64LCM6nPMv7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfT3wNhIpovchFZzI6hmCWPG8fSLra2PmzcyrTVKp8R1o8PfkkZkSsWXWqRe12vJincwm/iovWnepTOEiIllW3YGx0sv4L97vZEfLwWjoltcIGjDTERp0OFUSLduQi0HMcRgxzAADHPWF2s+RZDLYuopdeAa5MYXemBcdjUVJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAdUsgVU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767446511; x=1798982511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVG7gOaNjtZhVTGcvJRYj/Jf17AG7P64LCM6nPMv7yI=;
  b=fAdUsgVUqtrL77fKndHZwWFXS/pNViVr1H4oPzzKdgENiq26MWz5eilE
   PqpKkZ/AjxohViur2//PzgNAi0r+Enx7rSr0jnGEeOINFBDD69B9lQVvl
   AmLCnsE3EFza9lU98FYyMPc/+KWwxqGWjf1d55Jmf73JMBBlsmp2VDL4+
   QlZoSc93tP1O6DulDDwBP5IgFS1bsUe9Q1cZ0Jls7WyEvJKFx+BY4Ea3B
   gWKrH51tfEJxSChzsY1kypYEGkA6dlmljFMDcJtyIGmoXO7sMxtGa4/yI
   k30Q8Gvl4IHDWzR2iUwZpx9yD2csEPPzqOS/tc+er373AtiM3ocKx+6Q7
   g==;
X-CSE-ConnectionGUID: y4kWOxaWQ5iAjZ/x1CfKkg==
X-CSE-MsgGUID: PWrJlMT5QZKxa+jjDOrSSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="80017700"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="80017700"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 05:21:50 -0800
X-CSE-ConnectionGUID: mrBD+vEJTdegk7BbygcoNA==
X-CSE-MsgGUID: 3XU5gBEGT+mN4DcYvXbbsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="201886402"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.75])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 05:21:47 -0800
Date: Sat, 3 Jan 2026 15:21:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aVkX6bCR8nkoUwQI@smile.fi.intel.com>
References: <20260103-honeywell_abp2_driver-v5-0-0435afcf306d@subdimension.ro>
 <20260103-honeywell_abp2_driver-v5-2-0435afcf306d@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103-honeywell_abp2_driver-v5-2-0435afcf306d@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 03, 2026 at 06:35:17AM +0200, Petre Rodan wrote:
> Adds driver for digital Honeywell ABP2 series of board mount
> pressure and temperature sensors.
> 
> This driver covers 113 different pressure ranges and units on
> both i2c and SPI buses.
> 
> The communication protocol involves sending two simple commands
> to the sensor and there is no register access or a memory map.
> For this reason the regmap API was not used.
> 
> The i2c address is hardcoded and depends on the part number.
> 
> Optional end of conversion interrupt control is present on the
> i2c variants of the chips.
> The EOC can also be defined for the SPI variants if a non-ABP2
> but compatible chip is to be driven.
> 
> Tested on two sensors (ABP2MRRT001PDSA3 and ABP2DANT001BA2A3).

> ocuments/sps-siot-abp2-series-datasheet-32350268-en.pdf

Broken link now.

> Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/d

Should be in this line, but do *not* resend just for this, I hope if everything
else is okay, Jonathan will fix the above issue.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

-- 
With Best Regards,
Andy Shevchenko



