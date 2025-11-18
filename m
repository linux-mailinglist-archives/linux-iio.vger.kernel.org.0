Return-Path: <linux-iio+bounces-26284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE74C68E25
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 11:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38BC34E4CE2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E734889B;
	Tue, 18 Nov 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gx1ZwLJ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAA134A3A2;
	Tue, 18 Nov 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462659; cv=none; b=e4Gmv8su2AfiKIRomYNWIoYtMFJqtS9jQcba+6IDm4B7bwIGUD+zJj0BHSssKzvFwRhcmowV99aFl6+JzRX7T+SsZbPPFbXXUf4g1Iod9J2bfTB2of+b+56D1JAdeoNEx76X+nLOhY/Oj7P9sqD4lJwFhvMNRfU8FG1yaGwfB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462659; c=relaxed/simple;
	bh=clNOr2Xd4p9DVYnvS29sDDYNiO4/b+b2RO/wpk0hZR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT4Z8BXT3fMLa/PycFj51uA9/iVKuCE0dNji3FvxuZC3Y4DMfE5r6xtRtHNTCSSKyWUPWgFd4NRxVPUNmAY8B6Ku1mzBjYL2or5+9/AjlR/qvT8uaZmxEOC8HSu0oYwNRTJjSWohbICvJJO0bVnnktvpMZaYc8MSK758btOwgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gx1ZwLJ2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763462657; x=1794998657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=clNOr2Xd4p9DVYnvS29sDDYNiO4/b+b2RO/wpk0hZR0=;
  b=gx1ZwLJ2aDnIQLoqR9Zu9C/aQCOqgp98ClvZuNyAKcMX0fqUnhBEIUYS
   YmI+LUOJEHKD5tTJeiBxMgsDz0o7TwKDQR9WdCoGKGPD6h0GG9bVl2ZQa
   KkhoDAOPBwA42IVstjnRoZmEEwNYLD3w9wvcKdeKQuTHi+C5kEAAXRUaM
   coTXt6bXSNXGmOI6Nq2GH/RXkkS9ZjdRC2110hLcvVNSVolWQA+nEJ7QQ
   zv7l7Mva0RSYfsg4IxQ+4RQsOYdXB1+Z4kdyGIaEAJ2SL4+4QRVW+ktFN
   8vRc7jO542UNdPlvqESWjQV9q71sAt1M13hO1B/7tyHabdY0Cz9AkiftS
   w==;
X-CSE-ConnectionGUID: yUTWMxCASz6FO0hp37YH8g==
X-CSE-MsgGUID: MJsCcLrlS+Gb66p6HPHF4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69097558"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69097558"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 02:44:16 -0800
X-CSE-ConnectionGUID: 74AnlRqHSuuCMOyqSg8UWg==
X-CSE-MsgGUID: SVwUDHcsSqKR2DjKBIWs0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="214115399"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 18 Nov 2025 02:44:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CB18396; Tue, 18 Nov 2025 11:44:12 +0100 (CET)
Date: Tue, 18 Nov 2025 11:44:12 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on a
 per axis basis
Message-ID: <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-9-flavra@baylibre.com>
 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
 <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
 <aQNueWesrf_vXO06@smile.fi.intel.com>
 <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra wrote:
> On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra wrote:
> > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco Lavra wrote:

...

> > > > > +       old_enable = hw->enable_event[event];
> > > > > +       new_enable = state ? (old_enable | BIT(axis)) : (old_enable
> > > > > &
> > > > > ~BIT(axis));
> > > > > +       if (!!old_enable == !!new_enable)
> > > > 
> > > > This is an interesting check. So, old_enable and new_enable are _not_
> > > > booleans, right?
> > > > So, this means the check test if _any_ of the bit was set and kept
> > > > set or
> > > > none were set
> > > > and non is going to be set. Correct? I think a short comment would be
> > > > good to have.
> > > 
> > > old_enable and new_enable are bit masks, but we are only interested in
> > > whether any bit is set, to catch the cases where the bit mask goes from
> > > zero to non-zero and vice versa. Will add a comment.
> > 
> > If it's a true bitmask (assuming unsigned long type) then all this can be
> > done
> > via bitmap API calls. Otherwise you can also compare a Hamming weights of
> > them
> > (probably that gives even the same size of the object file, but !!
> > instructions
> >  will be changed to hweight() calls (still a single assembly instr on
> > modern
> >  architectures).
> 
> These are u8 variables, so we can't use the bitmap API.

OK. But hweight8() can still be used.

> And I don't
> understand the reason for using hweight(), given that the !! operators
> would still be needed.

No, you won't need !! with that.

-- 
With Best Regards,
Andy Shevchenko



