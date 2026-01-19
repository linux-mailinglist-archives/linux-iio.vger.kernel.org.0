Return-Path: <linux-iio+bounces-27934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CBD3A031
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746FE3058A26
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D343375CB;
	Mon, 19 Jan 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORQW/WBI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB2336EC5;
	Mon, 19 Jan 2026 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808297; cv=none; b=uLKFodL4d3NkXril6qxPBn62IGJlHsGMjs0Rrka9KptBwkHl1iJvHlIXJFbM/2IzyHQ9SmaSZLNyn1XgC9Q1hwf8pNvkVbQfznuR/FiZ1QKrDYZI5PkTafZQB8Y/U7GjMICYHRbuGi/R5IV4F0kozR0vRebirk0QGjFl73yrmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808297; c=relaxed/simple;
	bh=a5lHipFNUn/jV7ARrL+zhJDX3F8c0siT0CsaxuKR1l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVinEIGT9L0lONqxg4Dben+vVGX0toBEpvELC2c6gBkDs3kqXSJcZ5mQRxU13POYMXFsz+0VSaG2gpy17lehvMkjRRClZ/sEWRLRBGmMvruAG0QD/ysxIZD2x8hMwqeW3AxOVuwrADqAaKSIXtwKzShA58oacyeSUKOZMYCHRJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORQW/WBI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768808296; x=1800344296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a5lHipFNUn/jV7ARrL+zhJDX3F8c0siT0CsaxuKR1l4=;
  b=ORQW/WBIoDLBiMAqtPA2yl/Cl392E8uDrPFtL05hKpPKSEUgQMJ5etfi
   0tJwbYmjfCNu6kdqWCoLDPG0Y1+93+z1xK4o8eEGj/enaBysqWEIffDXg
   Kq/nd3Kd6jyKrlKbZHN190izFfjyvmsVxqpw8Z2QlGx5hXGjntlZMGn1A
   XYIAh40NlepHvbrbSxG+0yca5LSbP7jw+MbqviFMyydxmTEodm6j69O3h
   If4r1TyRwKoaeDyAcyOUKoKHmvLzAdRrDFxk3JEt4/W/JvjvpPDSBcbCY
   CPA8lKouGzHK5VeNSMdwxMyjR5tzuRtf+Qpqup9Pgp88fEKdSPjVV2Xut
   Q==;
X-CSE-ConnectionGUID: S/eFUp/SRHu/BQe4aNpouw==
X-CSE-MsgGUID: SpHMkpETRla7V1t1F5yygw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="73868408"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="73868408"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:38:15 -0800
X-CSE-ConnectionGUID: Zy9fxzyKTjWSBwCf+vGCvQ==
X-CSE-MsgGUID: YTdiy6fIS4OrZ+oIOF9wFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205700808"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:38:11 -0800
Date: Mon, 19 Jan 2026 09:38:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
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
Message-ID: <aW3fYYK4ywhwOZv9@smile.fi.intel.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-4-23d1371aef48@analog.com>
 <aWFR2wTSWLydGN5O@smile.fi.intel.com>
 <ptyn5x7qkmbakkompmijo6xeego2xrhjoeyomkgrytwgwcsaid@heiq3ilnx5ky>
 <aWTS-npPY6yPARZH@smile.fi.intel.com>
 <20260116175743.169eb595@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116175743.169eb595@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 16, 2026 at 05:57:43PM +0000, Jonathan Cameron wrote:
> On Mon, 12 Jan 2026 12:54:50 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Jan 12, 2026 at 09:45:49AM +0000, Rodrigo Alencar wrote:
> > > On 26/01/09 09:07PM, Andy Shevchenko wrote:  
> > > > On Thu, Jan 08, 2026 at 12:14:53PM +0000, Rodrigo Alencar via B4 Relay wrote:  

...

> > > > > +	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * bleed_value,
> > > > > +				1600ULL * HZ_PER_MHZ * MICROHZ_PER_HZ);  
> > 
> > You multiply Hz * Hz. One of them should be simply SI multiplier.
> > To me it sounds like one of
> > 
> > 				1600ULL * MEGA * MICROHZ_PER_HZ);
> > 				1600ULL * HZ_PER_MHZ * MICRO);
> > 
> > will be the correct one (and I lean towards the first one as you want units
> > to match).
> 
> I don't really care, but... They are Hz * Hz / Hz * Hz / Hz = HZ
> if we assume the first number is in Hz.  The others are all ratios.
>  
> So original is fine as far as I can tell.

I don't see it like this. I consider that we should have only one meaningful
units as the rest is just a value. What you wrote above has a little sense
to me, sorry.

-- 
With Best Regards,
Andy Shevchenko



