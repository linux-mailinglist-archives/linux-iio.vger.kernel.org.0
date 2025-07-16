Return-Path: <linux-iio+bounces-21723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1BB072F5
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 12:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74721C24AC7
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6792F2C7E;
	Wed, 16 Jul 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQvsfulS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABD215F6B;
	Wed, 16 Jul 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660923; cv=none; b=sgNZZKPNr5qkKbxV6z+urzM+I8oTUiowrXhEu1SJKHL+IrAMVy2NoJ6Q+9QQ07LM0L8PF0mkmIeNx30rtMGPgqkFInSrjF2aZD10hsi6hsfD71buGDkJuL8c0BG7I/Lrw0ayHxq4YD+4OHo85rPv+5OavN7EjJqmM/ReT6WGm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660923; c=relaxed/simple;
	bh=lmGfU8wWODLkZGjJ6sglTKQUADi2ca1DLoWmuG6Wju0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUbc2hrRmbVLaN/PFtVoeBnK5stUwTDLmTTKhfUHl9IJyH31UV+otQadDCQlEXLl02S1pzidRO2Jpvv8E2IK52ZbzhEYTPqokZ49NjWH1vNo8JPV7h+LWHNR8Pa5+w+dRMjgBfSjX4wo3Z9xOTLV9nmZ04WDIzxH86p80jfl05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQvsfulS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752660922; x=1784196922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lmGfU8wWODLkZGjJ6sglTKQUADi2ca1DLoWmuG6Wju0=;
  b=ZQvsfulSOpasmyyTtzz9SGaG6++KL8ucdWKhhezOAYHU7ZD75I7OsZFm
   8mEy3oKHzFxbuFuUEPt9P7za7FSX74S5xGhrIYwl10bzaeuAXdS1oHaCx
   avkCrdAAWzBuqXHAdQYpPVVJPXdyRiuSYEtk+UBNe357/Lib2QFb6aGdN
   be+RN7mWwrw9z7dEs9oo+XA+WYGonmnpaV1TivmixZV0VfAxlapgeg6Cn
   oC2dIL9A9oRm8DHPhuN7bt26bD/mQtU6l4WAQ5ZUbUNOoH0NDfy0ZSSn/
   L555cRnywoX4tVyJ1lTCW7TCWD+BxX80AjjJSQVvtj+04XMTTXR9st7Ew
   w==;
X-CSE-ConnectionGUID: O2iLzlDmRm6dU4NdhD7MGA==
X-CSE-MsgGUID: 3e88Gur/QO2dx1qTB3vRHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65470966"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="65470966"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:15:21 -0700
X-CSE-ConnectionGUID: GpsEWWQjTQeexJIg+v77+w==
X-CSE-MsgGUID: vmjHwrM+QguGpaCiAUgbqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="194609623"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:15:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubzAQ-0000000FuSK-4ATe;
	Wed, 16 Jul 2025 13:15:14 +0300
Date: Wed, 16 Jul 2025 13:15:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 1/7] math64: Add div64_s64_rem
Message-ID: <aHd7srtaK9O-O73a@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-2-sean.anderson@linux.dev>
 <aHYLYT57eF6UhLvC@smile.fi.intel.com>
 <7225a8ed-8502-48b5-a39f-870b444d069c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7225a8ed-8502-48b5-a39f-870b444d069c@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 01:36:33PM -0400, Sean Anderson wrote:
> On 7/15/25 04:03, Andy Shevchenko wrote:
> > On Mon, Jul 14, 2025 at 09:20:17PM -0400, Sean Anderson wrote:
> >> Add a function to do signed 64-bit division with remainder. This is
> >> implemented using div64_u64_rem in the same way that div_s64_rem is
> >> implemented using div_u64_rem.
> > 
> > LGTM, but one important Q. Can we (start to) add the test cases, please?
> 
> Well, this just calls div64_u64_rem. So I am inclined to make the test something
> like
> 
> #define test(n, d, q, r) ({ \
> 	u64 _q, _r; \
> 	_q = div64_u64_rem(n, d, &r); \
> 	assert(_q == q); \
> 	assert(_r == r); \
> })
> 
> test( 3,  2,  1,  1);
> test( 3, -2, -1,  1);
> test(-3,  2, -1, -1);
> test(-3, -2,  1, -1);

Perhaps, but it should be done somewhere in lib/tests/...

-- 
With Best Regards,
Andy Shevchenko



