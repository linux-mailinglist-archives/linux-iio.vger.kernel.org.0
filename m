Return-Path: <linux-iio+bounces-23723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B741FB44540
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B90C1CC1431
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 18:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E23634165E;
	Thu,  4 Sep 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot5JOORl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132531A54C;
	Thu,  4 Sep 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010076; cv=none; b=JJuG8FJLGxpz3CiT6MtNzVQ0BdtfZaWM+gkHjJ4bfGGb2fmTU7wrkX7z+Har+ukGq1WEZDfDEuiC8oNogFtW+Hf+nJ6juACGmO7i72qVyDeHOGk96ES+OEjI/mC7Hs5tzwDhJjX32T0OfqCSfSjN9v+sZJyOuFNto/nQPt5DPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010076; c=relaxed/simple;
	bh=oWzvywWktWhzJsp0F5tCpXdiwFL7jrcYj/ogPZsDT04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRuiCUevVMAvxTvXcUVIZl8aMp1M07k/qbemOjI5szzj77L0jOnZsBRoprJhTSbLZDhBMz7r4PZHNge8rp0wOGlwNZVWUTw9yxPPlo8yKv29M5YM4jTQauRxsGgtgVJM+bAqLUWyntR29UbHAn9SOy76SiqHg1LwEmOtuyQMhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ot5JOORl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757010074; x=1788546074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oWzvywWktWhzJsp0F5tCpXdiwFL7jrcYj/ogPZsDT04=;
  b=Ot5JOORlAOBSRIB9X1PI1qPTf6RwrqaynRCxaJN6wNBJqMZxR7gfObmp
   JbYpwQiZQ+MMFcBnAAAqBU1klNoNfgi/qHCDXGlYyNijEpXkpV35dL9VP
   j881KjNREfY/Khzha8Lp4dw45OVIXHj2zapYaP/lUoZ666ral4Ff8y1zU
   CiDxrg2ByQB6KykQqIKtv0F8z2LvYLa9riUi3Vppt3mWQOa0x9h8wO4wk
   TjntrbPFmEY0AbGe7ZUTvuplDwLdGLHUbHvd57rwNwwRceJEGFxLiJN8t
   fRx3N01YuDgsR4mSA8kZPv2TZeRDwUNvhGIwAAz+69RNsawVZ6KiaVbC/
   w==;
X-CSE-ConnectionGUID: XN3GCBSCTMaKGCO9gshnRw==
X-CSE-MsgGUID: u0a3H/PLRA+9vVi9WaBHUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59429296"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="59429296"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:21:13 -0700
X-CSE-ConnectionGUID: RR7jI4NwTQqgA2P7PdZBBQ==
X-CSE-MsgGUID: nQaesdJVQkuyyxPl7EfGpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="171250240"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:21:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uuEa4-0000000BMzq-0YmQ;
	Thu, 04 Sep 2025 21:21:08 +0300
Date: Thu, 4 Sep 2025 21:21:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7124: fix sample rate for multi-channel
 use
Message-ID: <aLnYk6RPePeACmex@smile.fi.intel.com>
References: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 04, 2025 at 11:19:56AM -0500, David Lechner wrote:
> Change how the FS[10:0] field of the FILTER register is calculated to
> get consistent sample rates when only one channel is enabled vs when
> multiple channels are enabled in a buffered read.
> 
> By default, the AD7124 allows larger sampling frequencies when only one
> channel is enabled. It assumes that you will discard the first sample or
> so to allow for settling time and then no additional settling time is
> needed between samples because there is no multiplexing due to only one
> channel being enabled. The conversion formula to convert between the
> sampling frequency and the FS[10:0] field is:
> 
>     fADC = fCLK / (FS[10:0] x 32)
> 
> which is what the driver has been using.
> 
> On the other hand, when multiple channels are enabled, there is
> additional settling time needed when switching between channels so the
> calculation to convert between becomes:
> 
>     fADC = fCLK / (FS[10:0] x 32 x (4 + AVG - 1))
> 
> where AVG depends on the filter type selected and the power mode.
> 
> The FILTER register has a SINGLE_CYCLE bit that can be set to force the
> single channel case to use the same timing as the multi-channel case.
> 
> Before this change, the first formula was always used, so if all of the
> in_voltageY_sampling_frequency attributes were set to 10 Hz, then doing
> a buffered read with 1 channel enabled would result in the requested
> sampling frequency of 10 Hz. But when more than one channel was
> enabled, the actual sampling frequency would be 2.5 Hz per channel,
> which is 1/4 of the requested frequency.
> 
> After this change, the SINGLE_CYCLE flag is now always enabled and the
> multi-channel formula is now always used. This causes the sampling
> frequency to be consistent regardless of the number of channels enabled.
> 
> Technically, the sincx+sinc1 filter modes can't currently be selected
> so there is some temporarily dead code in ad7124_get_avg() until filter
> support is added.
> 
> The AD7124_FILTER_FS define is moved while we are touching this to
> keep the bit fields in descending order to be consistent with the rest
> of the file.

...

>  	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
> +		AD7124_FILTER_SINGLE_CYCLE |
>  		FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits);

Seems to me that this is not indented correctly, with that in mind I would

	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
	      FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits) |
	      AD7124_FILTER_SINGLE_CYCLE;


-- 
With Best Regards,
Andy Shevchenko



