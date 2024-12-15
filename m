Return-Path: <linux-iio+bounces-13528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB4E9F2634
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D0D1884CB3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 21:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A5146A66;
	Sun, 15 Dec 2024 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiv5kYvw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF4A41
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297501; cv=none; b=gF/vu4m784CGtCjYgo5EcBOqaOTxp2prCGPDroz2p83elfdvOHP+bNlDPJikCCBl+TOtYiaQQxSOXn2nPLXz5isFJDpI8uYc9iDyA3VgXVoX/VE4DVx2MhNzgTxW81vHl1rAx8FOTKckA/vu+ftNEn+MgHmDfW1Q98hjGrHw+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297501; c=relaxed/simple;
	bh=rMDoMBQKzRWblzSITZW0tDccCotraLc/I6HeIUjV8Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdx3cfBy+UO3ZP6udF3qd42Duba1tJnHF4AKzV2WIOKLAEBE/UKzM6em/MpUGfLj2MjWmtAfv7julxiYRfflkhMKuSK+6DG0pI1zUWmY+aZb2fm9L+kGSZwbrsOxGWPEUJd8j8u0uL1tG3udHe3DG/Bah5bve63ckUJFkQtf5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiv5kYvw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734297499; x=1765833499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMDoMBQKzRWblzSITZW0tDccCotraLc/I6HeIUjV8Uc=;
  b=jiv5kYvwDMMwc4m7dOcMw63dbgEXgXbNE1apEDh9X633mY8MSULxo81v
   4aqtTxKN0Q+ekVLrGfuMWUdIpcmQZqbqjASyBqY2VZH7rNP0dZY6HqeOl
   uIamGvPbJzdEyOyzrnXoLvw6e08bVmW2uFzVS19/OdNreneiDVF5aOGMZ
   JRce+2UT/cz8BOFeE+8PJ3itfpi6/2OBvPXgt5Z+0C9fhHQqwACadPUKl
   JgDQD8YyvPqRy8Vmp0escSv1c69kgLKIdVNRzfgNbhDzJOm5u/8mUAa7s
   RNKLLr6SWUA+9b2eqeN34GZ7L71aeEx2cXcUePA8YUb4hitYvyS6EYmyH
   w==;
X-CSE-ConnectionGUID: AgcT3l2NQaeKgyLgs+8HUA==
X-CSE-MsgGUID: v+WTse+fSMW/RM6fo3mJPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="38362676"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="38362676"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 13:18:19 -0800
X-CSE-ConnectionGUID: Pab2DI6LSMe7TUTgFSBQhg==
X-CSE-MsgGUID: IuvifyThT9CnJidKvyiS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="97255492"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 13:18:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tMw0E-00000008KHk-2sks;
	Sun, 15 Dec 2024 23:18:14 +0200
Date: Sun, 15 Dec 2024 23:18:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/20] IIO: Tidying up timestamp alignment markings.
Message-ID: <Z19HlhLWNqH_alRY@smile.fi.intel.com>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 15, 2024 at 06:28:51PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I haven't +CC everyone relevant as that would be too long a list
> and these are mostly entirely mechanical changes that just need
> someone to sanity check I didn't do anything stupid.
> 
> This combines several related types of change:
> 
> - Some 'fixes'. These aren't actual bugs but more places where
>   the code relies on factors it shouldn't such as what architecture
>   the driver is running on, or padding of the wrong element happening
>   to always make enough room.
> - Now we have aligned_s64, use that to replace all the remaining
>   s64 timestamp __aligned(8) instances in IIO.
>   This is both cleaner and hopefully less prone to confusing static
>   analysis tools.
> - Change the timestamp type in iio_push_to_buffers_with_timestamp() to s64.
>   This is an entirely in kernel interface. It's data is pushed to user space
>   in many case but by a rather indirect route, so I think it is more
>   appropriate to switch this to s64 which is the type of almost all the
>   values passed into it. Note a follow up series may tidy up some
>   local variables that are of the int64_t type.
> - Change the few int64_t timestamp __aligned(8) cases to aligned_s64.
>   This is mostly a consistency thing to avoid confusion if a new author
>   is trying to figure out what types they should use.  Better to have
>   one answer than a mixture.
> 
> There is one other IIO driver hiding over in media that will be modified
> by a separate patch because I want to add some more info to that and
> a more specific CC list.

I briefly looked at most of the patches and haven't noticed any potential
issues, all seems like a straightforward conversion. Hence
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for all, except 15 and 19.

Patch 15 has got a few minor comments (and to accent on that I'm not sure about
my offer for sizeof(), using direct variable might make it inconsistent in this
case, because the following line uses explicit type instead of typeof(), and
using the latter makes the code unreadable).

Patch 19 seems correct to me, but I'm not going to give a tag to be on the safe
side.

-- 
With Best Regards,
Andy Shevchenko



