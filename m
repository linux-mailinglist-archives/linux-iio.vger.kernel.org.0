Return-Path: <linux-iio+bounces-27635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8FD1215A
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 11:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE7AC3088B7D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E134F279;
	Mon, 12 Jan 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcjrtNdc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF00D34E777;
	Mon, 12 Jan 2026 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215303; cv=none; b=DFFyteVasOVB1WlYNrVB0aydtn/2DUk+OdRkrmeA4QtT59iF3F+3nSmKlXR5sTB9z6aeX69bx20PALTctO9QinLYIJ+PUBhCuyrZazS2gjpHBNJS6j3bbMmoWtSY8iCsopgHs6+RJyAhAfvmoMaqJ7BtxDtZmzBASwyyqwiYyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215303; c=relaxed/simple;
	bh=Vv/PPNGS6q6bKRa/Az08ZY2Cdmp6pDO3vX/BIw0L5Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcKc+Y5IQTEJw+XEd4EFrvN7vn1s0wRzxmZGUW7fAi7Z+FaZ82hQb5elWFFDr2IyqlfsiW7ODk1VG+NNNc5SVuZBRAyDObFMTYl/bdFEGhey/knpLBw8/zNV6tunkHE8/2kh+4R2Z0ARQeEhdYOMk1PK6gBKvio/6nWSWZbgrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcjrtNdc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768215301; x=1799751301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vv/PPNGS6q6bKRa/Az08ZY2Cdmp6pDO3vX/BIw0L5Yo=;
  b=UcjrtNdcq6kMZ9+MBPnyWhuWZEbx04bKEQtLgiKpzB5S+kWONUuj7oRk
   Ovo+zTqzPv5uNArVkw2JrmyXH49uD9UG0YP7kGEUMkvsv1bOcyuBg9o+M
   VZ5pAFNFUw73OpmmhYs1ag1uC+ueV7sFpRHwFOA77XEqdSAgdOgqouiez
   n6JuZDJFONNYRfH5GIYvXuTBmylvdjc3+Bmxp8SdTO7CzgaNuA3SW/07+
   UM4mjRiNd+Vtg+Y2lNMjSkSXUwNmN88qElAaMKMIJoDb/ZQqz+oc/Sx0y
   bJUmo2UGTHQpsGV8E72ltQr3ZInVX62T3/QhUSAjaOT81xzJGymTZMdzX
   g==;
X-CSE-ConnectionGUID: AhI4H01lRzeD1qyHMX2mfQ==
X-CSE-MsgGUID: MjCxqDj2SDmE3K53vPDRLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69471122"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69471122"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 02:54:56 -0800
X-CSE-ConnectionGUID: ChwuihwYQAyOfpO3PSdl0g==
X-CSE-MsgGUID: rl0UD2RgR9GmvugXip6kZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204079030"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 02:54:52 -0800
Date: Mon, 12 Jan 2026 12:54:50 +0200
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
Subject: Re: [PATCH v3 4/6] iio: frequency: adf41513: features on frequency
 change
Message-ID: <aWTS-npPY6yPARZH@smile.fi.intel.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-4-23d1371aef48@analog.com>
 <aWFR2wTSWLydGN5O@smile.fi.intel.com>
 <ptyn5x7qkmbakkompmijo6xeego2xrhjoeyomkgrytwgwcsaid@heiq3ilnx5ky>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ptyn5x7qkmbakkompmijo6xeego2xrhjoeyomkgrytwgwcsaid@heiq3ilnx5ky>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 09:45:49AM +0000, Rodrigo Alencar wrote:
> On 26/01/09 09:07PM, Andy Shevchenko wrote:
> > On Thu, Jan 08, 2026 at 12:14:53PM +0000, Rodrigo Alencar via B4 Relay wrote:

First of all, remove the things you are agree with.

...

A side note: based on this discussion one may want to add a clarification
on how to use the unit-based multipliers to the documentation (top comment
on units.h also will work).

...

> > > +	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * bleed_value,
> > > +				1600ULL * HZ_PER_MHZ * MICROHZ_PER_HZ);

You multiply Hz * Hz. One of them should be simply SI multiplier.
To me it sounds like one of

				1600ULL * MEGA * MICROHZ_PER_HZ);
				1600ULL * HZ_PER_MHZ * MICRO);

will be the correct one (and I lean towards the first one as you want units
to match).

The same is done in the definitions above somewhere.

> > > +	u16 ld_window_p1ns = div64_u64(10ULL * NANO * MICROHZ_PER_HZ,
> > > +				       st->settings.pfd_frequency_uhz << 1);
> > 
> > These multiplications (here and elsewhere) are (very) confusing.
> > 
> > I believe you want to have a frequency in Hz in µHz resolution. The second one
> > can be close to this if used GIGA instead of NANO. But I think the better way
> > to have something like the first one but with MICRO instead of MICROHZ_PER_HZ.
> > 
> > Please, put an order in these.
> 
> The first one: the numerator is in µHz, so the denominator is also in µHz so to
> cancel the units.
> 
> The second one: window size is nanoseconds with 0.1 precision in the datasheet.
> The numerator contains  MICROHZ_PER_HZ to convert µHz -> Hz = 1/s, and then
> 10ULL * NANO to convert 1/s into 0.1 ns.
> 
> How is that confusing? I am not sure GIGA is the right choice, as NANO shows
> that I am targeting nanoseconds, no? 

So, You wanted then one of

	u16 ld_window_p1ns = div64_u64(10ULL * NSEC_PER_SEC * MICROHZ_PER_HZ,
	u16 ld_window_p1ns = div64_u64(10ULL * NANO * MICRO,

(and I lean towards the first one as it may hint about the scale and resulting
 units).

Also make units in the name to be delimited with _.

	u16 ld_window_p1_ns = ...

...

> > > +	/* assuming both clock dividers hold similar values */
> > > +	total_div = mul_u64_u64_div_u64(st->settings.pfd_frequency_uhz,
> > > +					st->data.phase_resync_period_ns,
> > > +					1ULL * MICRO * NANO);
> > 
> > This sounds good as we multiply Hz by ns.
> 
> the numerator has a time in nanoseconds, so NANO 'cancels' that, as MICRO 'cancels'
> the micro under µHz.

Exactly, that's why I replied it sounds good.

-- 
With Best Regards,
Andy Shevchenko



