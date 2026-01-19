Return-Path: <linux-iio+bounces-27959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EAD3AA37
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00C23147B3A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D09369215;
	Mon, 19 Jan 2026 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bz7JOsVT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854DC368278;
	Mon, 19 Jan 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828749; cv=none; b=pWLwIEkjgOqZjKD3Y+ZagQtHmO6LqzimkxZe4++32QA1SZkju+IzlLDcvFAhjSQ6OQW4rRQMPyeXXILNokHXIG+lD8URz4pV5abFoaIDyWydVTX6YiGt+0P8FzHNq4URSZPIlJYNOZOW2UFiE+bgZ/BM2WwbryNLy1QNwVWL8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828749; c=relaxed/simple;
	bh=geLWWR5O/79l0LAq/8oG1NHH7E0gtlmrS3XUTDenxfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK9pB61zKyEa63M9ZF3t6cq64hXx7iBPtF7E4hENFu/qkxuj6/Cl22ni4h+wSCGIG4bwS4EZWf1z4FBf62p1z6drsJ9Y5jWGiVX/2+dma4IJB3LI0s/HoIjby5iPgfjbyrYvzKWO448NUUF9Fo7zOpDUtTPUkr34qdQJwwrD8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bz7JOsVT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768828746; x=1800364746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=geLWWR5O/79l0LAq/8oG1NHH7E0gtlmrS3XUTDenxfs=;
  b=bz7JOsVTvDuf23eAj1VlV5YI6uBXHtAUOPRIG1UJ6lhBXR7e0b3hLsyd
   WcqQ5+yD/u4UfGdgPlEFh4n7Xt91Etssku/Kx48/lp+/R2R7BdBGAV5qd
   NtPntPXXg2WmK/GxZLcolpJqd6kk1+IFifpTuCe1qIG3zQF4gMMiCmbMV
   Q0iA9yW/s+RRm8bVrS6ZidvcICCaz6rqidBeQKpsIlQB5soQ/DrLk5Qhe
   ovTEcoHwmWQsqFcn5p7Oa1NFxV8BxT8QRRdQAlR3afhCLNe2/dXyWFTss
   0wBZqFpt3PaPouPCtLSmN2n5avTVKb7HQxsh9wuUcTycmrcC6H10hG3tE
   A==;
X-CSE-ConnectionGUID: dt+8qVniTdWoooympd7ToA==
X-CSE-MsgGUID: KQEraSVLTqGc64KG80mrMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="92708614"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="92708614"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 05:19:01 -0800
X-CSE-ConnectionGUID: g0R4WhEHTwyDAkWXnPx4JA==
X-CSE-MsgGUID: G7JDR3ZdTEupzEdAdl1pUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="210351539"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 05:18:57 -0800
Date: Mon, 19 Jan 2026 15:18:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 4/6] iio: frequency: adf41513: features on frequency
 change
Message-ID: <aW4vPpE8CRL5yI2u@smile.fi.intel.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-4-23d1371aef48@analog.com>
 <aWFR2wTSWLydGN5O@smile.fi.intel.com>
 <ptyn5x7qkmbakkompmijo6xeego2xrhjoeyomkgrytwgwcsaid@heiq3ilnx5ky>
 <aWTS-npPY6yPARZH@smile.fi.intel.com>
 <20260116175743.169eb595@jic23-huawei>
 <aW3fYYK4ywhwOZv9@smile.fi.intel.com>
 <20260119104159.000025f7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119104159.000025f7@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 10:41:59AM +0000, Jonathan Cameron wrote:
> On Mon, 19 Jan 2026 09:38:09 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Jan 16, 2026 at 05:57:43PM +0000, Jonathan Cameron wrote:
> > > On Mon, 12 Jan 2026 12:54:50 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Mon, Jan 12, 2026 at 09:45:49AM +0000, Rodrigo Alencar wrote:  
> > > > > On 26/01/09 09:07PM, Andy Shevchenko wrote:    
> > > > > > On Thu, Jan 08, 2026 at 12:14:53PM +0000, Rodrigo Alencar via B4 Relay wrote:    

...

> > > > > > > +	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * bleed_value,
> > > > > > > +				1600ULL * HZ_PER_MHZ * MICROHZ_PER_HZ);    
> > > > 
> > > > You multiply Hz * Hz. One of them should be simply SI multiplier.
> > > > To me it sounds like one of
> > > > 
> > > > 				1600ULL * MEGA * MICROHZ_PER_HZ);
> > > > 				1600ULL * HZ_PER_MHZ * MICRO);
> > > > 
> > > > will be the correct one (and I lean towards the first one as you want units
> > > > to match).  
> > > 
> > > I don't really care, but... They are Hz * Hz / Hz * Hz / Hz = HZ
> > > if we assume the first number is in Hz.  The others are all ratios.
> > >  
> > > So original is fine as far as I can tell.  
> > 
> > I don't see it like this. I consider that we should have only one meaningful
> > units as the rest is just a value. What you wrote above has a little sense
> > to me, sorry.
> > 
> 
> I agree, but none of those XHZ PER HZ is mathematically valid way of applying a unit.
> This is because the per means divide so the units cancel out.
> Literally it's  (0.0000001Hz / 1Hz) 
> So using them to assign a unit is meaningless.  All they are doing is hinting
> that we are manipulating values already in some scaling of Hz.

My understanding is that they give a hint about units and used scale (which is
also provided by the unit suffix in the respective variable name in this case).
In some cases the variables do not have suffixes and having a named multiplier
helps that.

> Personally I'm not sure there is value in the unit specific defines given
> this. They kind of hint we are dealing with frequencies, but that's it.


-- 
With Best Regards,
Andy Shevchenko



