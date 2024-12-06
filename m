Return-Path: <linux-iio+bounces-13155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0DA9E7360
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 16:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20EA28AA82
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7065D154449;
	Fri,  6 Dec 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myf39t88"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C014EC60;
	Fri,  6 Dec 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498381; cv=none; b=djySgTSWBNbwqjWDNwaOr6RTvTa5J6rnF0vOJTz/Qh4q6yX8hGinXKrv6V5dZgJVFX5E7pbLy+tEWe1kCCCxSNdSt6exMSOCWHG+dV//G6J0UapXYqaw1jB0r+d9Bq1f+V7GlTE+apHqejeXDuCoaDb/0v9Ur4dG2mzgl36NU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498381; c=relaxed/simple;
	bh=LMGPQdOE6e9xggsZ3nlIr5eFjaaZxIvp7E6XwHaEefU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCecVNPCgANUyiuf6/phQw02bTOwRTyfi1IVrBrAWFwOrUs8GY6I5Prsi2NchtioIzed+HlJ0yPFjoi3G1zpg2ZoZV8rjxqyhz+CR/ahhn9ct41LNMRMJW0RKygF6IqZYsH4lOCKBYfHEPFBTrXU1QimWyKybV0wGe6Plren3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myf39t88; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733498379; x=1765034379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LMGPQdOE6e9xggsZ3nlIr5eFjaaZxIvp7E6XwHaEefU=;
  b=myf39t88+QqdBfd1pMBavWg13TI7wiqdpHMFAw8G1JM/Lk7HEUvXE8yv
   huTOAfK+DSFIAjJ7VGH/Zbffoh0wlAQxb/R8gLQT8HZ0v5FyEsgkVDhgq
   n57O8s2P5+okjsDT1OnbW/AyKSesznuXk+MJ6Gdev0xciTjo1UG5FiJ30
   K04xVFfUBjxf4/b1HTWN5elhGPBZarkM2D9NDEbHiU8VmzTK7ZJ5RzmNJ
   xsW7snxOj0JzeJ71LpU5CddJy+O5rRPhyc3/sdpRieDlhyPp1vS3jM7/i
   VTtaqy/eofZq27HPiDdNQKNjq2s1Y6ypH2c+ZuL/C0SZVBh681ASz+NOC
   A==;
X-CSE-ConnectionGUID: b7VJ7LJGSqO+OQ98IOcjMA==
X-CSE-MsgGUID: 6lTzXl07QbaX6wZBmkhEZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37639463"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="37639463"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:19:39 -0800
X-CSE-ConnectionGUID: 87SriRu7T2qfOYeej+hQaA==
X-CSE-MsgGUID: jPCl2P0nTimN89zmwYEYbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="98892396"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 07:19:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tJa7C-00000004Y82-31jm;
	Fri, 06 Dec 2024 17:19:34 +0200
Date: Fri, 6 Dec 2024 17:19:34 +0200
From: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/4] iio: afe: rescale: Don't use ^ for booleans
Message-ID: <Z1MWBsCJsTHsqNey@smile.fi.intel.com>
References: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
 <20241204013620.862943-2-andriy.shevchenko@linux.intel.com>
 <88f281a31d8342c691b2a6b2666d4e91@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88f281a31d8342c691b2a6b2666d4e91@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 06, 2024 at 01:24:09PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 04 December 2024 01:33
> > 
> > There are two (non-critical) issues with the code. First of all,
> > the eXclusive OR is not defined for booleans, so boolean to integer
> > promotion is required, Second, the u32 variable is used to keep
> > boolean value, so boolean is converted implicitly to the integer.
> 
> Except there is no such thing as 'boolean' they are all integers.

I believe this is an exercise in linguistics as I'm not native speaker
but I am very well aware of the promotions to the integer values.

> And the compiler has to have some set of rules to handle the cases
> where the memory that hold the 'boolean' doesn't have the value 0 or 1.

No doubts.

...

> >  		 * If only one of the rescaler elements or the schan scale is
> >  		 * negative, the combined scale is negative.
> >  		 */
> > -		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
> > +		if (neg != (rescale->numerator < 0 || rescale->denominator < 0)) {
> 
> That is wrong, the || would also need to be !=.

Why do you think so? Maybe it's comment(s) that is(are) wrong?

> Which will all generate real pile of horrid code.
> (I think the x86 version will stun you.)

I think your remark is based on something, can you show the output to elaborate
what exactly becomes horrible in this case?

> I'm guessing that somewhere there is a:
> 	neg = value < 0;

Nope.

> Provided all the values are the same size (eg int/s32), in which case:
> 	neg = value;
> ...
> 	if ((neg ^ rescale->numerator ^ rescale->denominator) < 0)
> will be the desired test.

-- 
With Best Regards,
Andy Shevchenko



