Return-Path: <linux-iio+bounces-8736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A6395D5F3
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 21:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C0B1F23B7E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 19:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFDA18EFE0;
	Fri, 23 Aug 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLEgD+zV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AD8488;
	Fri, 23 Aug 2024 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440538; cv=none; b=WHE+y6FGvaZl9E/40eeCwqzMAGtSyxe66c4p4PGCVzvW5p56LwbxvpdGX0SHI/8gNkl8lHYrzXjR5GE0rPp1vc0o30WkfU2cq/G5zjgn1L/VefP15Cv6O7nGHDKUFbqsYgaU/NpsigoXCIWu2KKCDJg7cjti+9QiY3nbRzZXJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440538; c=relaxed/simple;
	bh=PXkZuUaq2x+pGgvspK0w5ccETV5xXYujuHjG+kAk6Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrWrBzCwDXDNuTGeG2xpAD3Mh75iO8G9QAMkAFml2yCrsSYrScwad0QPZn4flUX4D6kjTNsvTKOvQzNUpjRRY4UnvxNF8ZZQ6uuxVHpcAtDIWMbRMJJVD/r+tcvr33kh9s+7/eYxmRuP68ZfVleXhpbXLb79IYzz7Kt9KtKRI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLEgD+zV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724440537; x=1755976537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PXkZuUaq2x+pGgvspK0w5ccETV5xXYujuHjG+kAk6Oc=;
  b=WLEgD+zVIJy/jioafasXc81gmUo+Rup96en3HB+b8zdK2L41pkCY+7Va
   V0491xNHuB/Q00qpb5RonWygbHMJvkBjJcyqU/WSzZQ1R9+BQPW3kLZIt
   k78VRwAS1FtI/MDariVVHTxdFHNFzopUVsD1z0gHx4T3R5w2PI/FEp2M2
   CJo/WrWvnKcgd2AxAR6wng2C25ss6TKctTCWWVQ+tHJjEzD4yByzE+4ia
   qzUUPFvXmyx4EWYM0akihAchvZVyNjdc82s4ds92rVd9TQAogC0OVxkdv
   aZ+0fMvXrEH88TEvIvwQX30WhjMpDCB4GpcRfI3hwKjAhO9vdZrq6+I9r
   A==;
X-CSE-ConnectionGUID: gL8E4xQPRheicRFR6Z6qaw==
X-CSE-MsgGUID: dYAJu/CEQGOOkQXsF1Ql9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33549611"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33549611"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:15:36 -0700
X-CSE-ConnectionGUID: zz7piIwJSTaL4/cV1w36gA==
X-CSE-MsgGUID: a1UQ8ZlKQROjWxapnjrwMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="92682297"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:15:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shZkv-0000000109A-1vqG;
	Fri, 23 Aug 2024 22:15:29 +0300
Date: Fri, 23 Aug 2024 22:15:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iio: pressure: bmp280: Remove config error check
 for IIR filter updates
Message-ID: <Zsjf0bVLZyPqBxru@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-4-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181714.64545-4-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 08:17:10PM +0200, Vasileios Amoiridis wrote:
> When there is a change in the configuration of the BMP3xx device, several
> steps take place. These steps include:
> 
> 1) Update the OSR settings and check if there was an update
> 2) Update the ODR settings and check if there was an update
> 3) Update the IIR settings and check if there was an update
> 4) Check if there was an update with the following procedure:
> 	a) Set sensor to SLEEP mode and after to NORMAL mode to trigger
> 	   a new measurement.
> 	b) Wait the maximum amount possible depending on the OSR settings
> 	c) Check the configuration error register if there was an error
> 	   during the configuration of the sensor.
> 
> This check is necessary, because there could be a case where the OSR is
> too high for the requested ODR so either the ODR needs to be slower or the
> OSR needs to be less. This is something that is checked internally by the
> sensor when it runs in NORMAL mode.
> 
> In the BMP58x devices the previous steps are done internally by the sensor.
> 
> The IIR filter settings do not depend on the OSR or ODR settings, and there
> is no need to run a check in case they change.

...

> +	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
> +				 BMP580_DSP_IIR_PRESS_MASK |
> +				 BMP580_DSP_IIR_TEMP_MASK, reg_val);

Better to split on logical bounds

	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
				 BMP580_DSP_IIR_PRESS_MASK | BMP580_DSP_IIR_TEMP_MASK,
				 reg_val);

-- 
With Best Regards,
Andy Shevchenko



