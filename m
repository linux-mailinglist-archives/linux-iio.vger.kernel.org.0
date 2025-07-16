Return-Path: <linux-iio+bounces-21720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA64B0725F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B85D501A68
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83832F1992;
	Wed, 16 Jul 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4sgSEqN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A454F81;
	Wed, 16 Jul 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660027; cv=none; b=N65jjMOxz20h2pi4MEVDcXWK1kOr5wbu00H5EB0LN1D06SdNbAq+GLc0wSVizHJLVV9Wrz6FwamH9nTl04W3Af6k0F+fPDkJ62Cg9j1UQjmuu3SdBLFxx/5X5o/vC1h/PTWT92h9cPy3uFgQSq5/znMOBkMe2YEvxPidm9c9SLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660027; c=relaxed/simple;
	bh=m21bVXARBRJDLgmYCR6LF4rf6qvhGpQKbtWniYyQMs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGAVxFAX1+nAK7B3Eeik+AVP4BQBZ3ySOGefGWli61w9ZZ4EucJK4zdwGEW7T2D3z+Ot7YC0OUG9sVHkhUSOCHIUCnKeHyhySyQ5B5rqwShg/OxRQb5Lcdx6spQ9+oU3NoAm8uAp4yfwYILlsFgmO1CCMAjplFRZuZXAlSRopCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4sgSEqN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752660026; x=1784196026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m21bVXARBRJDLgmYCR6LF4rf6qvhGpQKbtWniYyQMs4=;
  b=A4sgSEqNZkatRvZ2XVyRPifU79/YpOre5PQ1fOQEVTXOMGEvZtMGcVJc
   nOdgFfX5HaDbEjo4eRR3IBm5Kcus60Qr1gUPB3cmFFS3njHBogv3aRGge
   VSxaVNy2+B7Pc/6CN16p9teRBgWD3Weo5zRaYlKj0yoSbjC5WCrzUd+TL
   D0kdTeFdCUS52yk4ctCIosm6HiZtGplmQGor8byyWj93lnc0ZI6iiYrmI
   GzW3iNpya2D4dKayyBa4/S+nZOagv+d7iy8CwB7akHJ7ESmTgk8CH5ykV
   3IVIt0JOPcXxVEaPqPs+k7rf4cExvecyXmCuWB/eNgzXrUzsXSJw9qHM4
   A==;
X-CSE-ConnectionGUID: DsI8/ESlQLGYl6iQTsEUIA==
X-CSE-MsgGUID: iCacmByeTAuK9xlGk3/j0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66346296"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="66346296"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:00:25 -0700
X-CSE-ConnectionGUID: tYUg+UkaT0uZFphc3BmB0g==
X-CSE-MsgGUID: uWL0H5LBQqmjDrlEVCE6Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157815521"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:00:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubyvw-0000000FuG1-2MEB;
	Wed, 16 Jul 2025 13:00:16 +0300
Date: Wed, 16 Jul 2025 13:00:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 5/7] hwmon: iio: Add helper function for creating
 attributes
Message-ID: <aHd4MIJR4JjJTIWC@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-6-sean.anderson@linux.dev>
 <aHYTcAO7sHsyevDH@smile.fi.intel.com>
 <b72d009a-9d7d-42cd-af2e-80584bba788d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72d009a-9d7d-42cd-af2e-80584bba788d@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 11:55:08AM -0400, Sean Anderson wrote:
> On 7/15/25 04:38, Andy Shevchenko wrote:
> > On Mon, Jul 14, 2025 at 09:20:21PM -0400, Sean Anderson wrote:

...

> >> +static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
> > 
> > This should hint that this is managed:
> > 
> > add_device_managed_attr()
> 
> That just makes it more difficult to format the calling code within 80 columns...

Choose your name, but important that it should hint the caller that it's only
for the ->probe() stages.

...

> >> +			   ssize_t (*show)(struct device *dev,
> >> +					   struct device_attribute *attr,
> >> +					   char *buf),
> >> +			   int i, const char *fmt, ...)
> > 
> > __printf() attribute is missing.
> 
> It's static, so I thought the compiler could infer it but I guess not.

TBH, I haven't checked, but I think it might be the good style to add.

-- 
With Best Regards,
Andy Shevchenko



