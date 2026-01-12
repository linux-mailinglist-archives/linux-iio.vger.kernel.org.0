Return-Path: <linux-iio+bounces-27636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 688C0D121DF
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D85930F3EDB
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E142354AE3;
	Mon, 12 Jan 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndGEgoYK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC325350A2D;
	Mon, 12 Jan 2026 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215487; cv=none; b=YGVQnjLHryq2cJ++su+4Ns6KM+HjEDgwbJ2Rhzienm1n7/jZKa1ywT5VUluqKicvHlvv6LzbtudA+Xl3cGr8nT5JOaydPXYwMmLf8Olpq0Df3q23ZwhjUjPHj97Md94ob/p0tpPVnizS+13t1f56Wvq/EcSmt0ox2mRsYGoJcPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215487; c=relaxed/simple;
	bh=2CxAOQdm9pfGqDTstJ8atlI08gE5e3UXHrQse7CP0Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW43uYLUg7O8+uvxLWOYiKHL5YL7i/PUld0DgjyL/B6O1R+O9fU6ghfzn6noGETWCMKEJsi1DW4gS/6LHXef/v5No19E2+ETtKQwdlefgFIypnxbdsC1dbPGNBmW+wGvsbXePcUaT+p7UdYsQJ5U6VxlV2AAjXXJEglx6xSNI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndGEgoYK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768215484; x=1799751484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2CxAOQdm9pfGqDTstJ8atlI08gE5e3UXHrQse7CP0Zw=;
  b=ndGEgoYKWyNSqTWYgUyVrEA0ObTO/XyBYAYqZw92K8E45tSgibAWw2Dv
   h+b9PFnEtGUl1Cw9HgOA5ZvcQZi5AT1xRR2J/x65Qr+wcRvZ5nh+VxJBz
   0vtGWt6lVgU5R2yZ3xNPsV3fGgjtf62ORktgB/vF/5z5I5Zn10oSbNVXP
   2mFRJDgy8nQ6mCMGwFjxbJz00eVqZ23Kja98sNwkcl56YyrgVHc1IWdyO
   4pwstHeMRGEufwLgmGGVIEB+IZNrCP66hR5s2eh48DkbZ5+/lJsdMQiVj
   kgIyQls5W/5G0YhN3zFL0azfDPyvvXCThiMS6/GLqQNH4+089YSFklO6u
   w==;
X-CSE-ConnectionGUID: +sKY7mYSSJ63GcAo/z8ugQ==
X-CSE-MsgGUID: jXpcU17eS9uKZ7ZfuOc/9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69539637"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69539637"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 02:58:01 -0800
X-CSE-ConnectionGUID: 4mhKBSP3SFSJa1yd0GqT+A==
X-CSE-MsgGUID: v4/FUKHxT9ab2jMUfkyIJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203219426"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 02:57:57 -0800
Date: Mon, 12 Jan 2026 12:57:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 2/6] iio: frequency: adf41513: driver implementation
Message-ID: <aWTTs1n_N0dVjpbV@smile.fi.intel.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-2-23d1371aef48@analog.com>
 <aWFPEa9HI4wmYLpn@smile.fi.intel.com>
 <6hcqrcy3meskddrklb3jtlpca2snrs4upwms56lhq7mkes7krm@vdiaqkfc6lgg>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6hcqrcy3meskddrklb3jtlpca2snrs4upwms56lhq7mkes7krm@vdiaqkfc6lgg>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 09:56:25AM +0000, Rodrigo Alencar wrote:
> On 26/01/09 08:55PM, Andy Shevchenko wrote:
> > On Thu, Jan 08, 2026 at 12:14:51PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > +/* Specifications */
> > > +#define ADF41510_MAX_RF_FREQ			(10000ULL * HZ_PER_MHZ)
> > > +#define ADF41513_MIN_RF_FREQ			(1000ULL * HZ_PER_MHZ)
> > > +#define ADF41513_MAX_RF_FREQ			(26500ULL * HZ_PER_MHZ)
> > 
> > We need HZ_PER_GHZ. I think it's easy to have one be present in units.h.
> 
> 26.5 GHz is not going to use HZ_PER_GHZ, so for consistency I think it makes
> sense to keep HZ_PER_MHZ for the others.

It's about readability and less error prone numbers (anything with 3+ 0:s is
already prone to mistakes).

...

> > > +#define ADF41513_MIN_INT_4_5			20
> > > +#define ADF41513_MAX_INT_4_5			511
> > > +#define ADF41513_MIN_INT_8_9			64
> > > +#define ADF41513_MAX_INT_8_9			1023
> > 
> > Not sure if we want (BIT(x) - 1) for the limits as we have non-0 minimums.

Any comment on this?

...

> > > +#define ADF41513_MAX_CLK_DIVIDER		4095
> > 
> > Sounds like a candidate for (BIT(12) - 1).
> 
> limits for INT are taken from the datasheet as is, so I think it makes to leave them
> like this, as for CLK1/CLK2 max divider, indeed I can make it (BIT(12) - 1) as it
> refers to a 12-bit register field.

...

> > > +#define ADF41513_MAX_PHASE_MICRORAD		6283185UL
> > 
> > Basically I'm replying to this just for this line. 180° is PI radians, which is
> > something like 31415926... Can we use here (2 * 314...) where PI is provided in
> > one of the used form? This will help to grep and replace in case we will have a
> > common PI constant defined in the kernel (units.h).

Any comment on this?

-- 
With Best Regards,
Andy Shevchenko



