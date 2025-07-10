Return-Path: <linux-iio+bounces-21531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FEFB00198
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF6B7ADA8D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608042505A9;
	Thu, 10 Jul 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYcvPgv7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A023B611;
	Thu, 10 Jul 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150199; cv=none; b=e/BK9cbOUgbelRITfmidlQNCVD/HXfqMpUCnhvbBTQFhCDrLHMt5PYWqlvF7mIWwme36ab9rcSOI4bWAKizje+iPqF6fjgnGOZ1K8fl9YJbrFxbeBHettXYMIPHWu7x7drmhIRUAXkVmiWd6ZEdgVBtMGmMWbcC1/IwvDh8HRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150199; c=relaxed/simple;
	bh=zVWfpYG3QSkbW5Yv1qC81j5gVYYyu3l5Xtez9jRwgiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhkrxFXbTNgyNJxzbSvPyhY6T40tMDYVCXOf1LcGlJBlcVRlJgJbrln8XuHVQcSxWXf/fb/DsQe/idL/yzocUaXkFcJMchMU07rj1QaDVk5tRKmwHuWp2VOu+ybmj+r6YcGp2ALTm7wqGf4cehnTp7H9rnKc+VrtPwVY+SxNju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYcvPgv7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752150198; x=1783686198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVWfpYG3QSkbW5Yv1qC81j5gVYYyu3l5Xtez9jRwgiM=;
  b=lYcvPgv7C2wt4M/+Yv3+pqDfOT9k0S5zogoHZzxpeILNGbfxm97iQBEf
   dKTQLaGf4bPYTZQV/WkqqtmFOd4webPhxMOM+zmm3sZDEhofPA0HCWVh3
   cPhBPlXbrIKk9fwOa2Q8peFIxlXggWgfTjOOzZQOfhUwpvZPlaJ2cwtcO
   9v3znfz5STOll9JeVd2F2+XKItYTQdrEdsuLrHf6Eol1bRh1RODIxqoxV
   1ckoCfJ6F6neEsBa9hogy0H6inNllHRB9qzdA474Xxfl+LzVc/lM8y1Op
   BGatdTbHyj8UAtx6t6S7Gm/Mo/Fp0IP/C8Ikkdmpgk3nKGEpGzVIbLg0L
   g==;
X-CSE-ConnectionGUID: PZaE5i7gSs6ohphDjNFY5A==
X-CSE-MsgGUID: eld9EvEGRBmPkw3ucP3vnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71877615"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="71877615"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 05:23:15 -0700
X-CSE-ConnectionGUID: sJyY/3A9StGsoBeUBvFUCg==
X-CSE-MsgGUID: 0Lafm1ImQSa5Cp+SAJ8lWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160078745"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 05:23:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZqIv-0000000EC3h-45hw;
	Thu, 10 Jul 2025 15:23:09 +0300
Date: Thu, 10 Jul 2025 15:23:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <aG-wrULBZkMvWZVB@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
 <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com>
 <aG-DGEpZOHqFoIY3@smile.fi.intel.com>
 <p5aiunwdx7vcncsmamq3q7orffrfpmcjzwnrgn2vfczs3y26ak@jxgbwf3bduat>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p5aiunwdx7vcncsmamq3q7orffrfpmcjzwnrgn2vfczs3y26ak@jxgbwf3bduat>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 10:45:43AM +0000, Sean Nyekjaer wrote:
> On Thu, Jul 10, 2025 at 12:08:40PM +0100, Andy Shevchenko wrote:
> > On Wed, Jul 09, 2025 at 02:35:12PM +0200, Sean Nyekjaer wrote:
> > > Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> > > calls during probe. These are not required when the device is marked
> > > active via pm_runtime_set_active() before enabling pm_runtime with
> > > pm_runtime_enable().
> > 
> > Hmm... What will happen if the autosuspend triggers just before going out from
> > the probe when this change is applied?
> 
> Nothing, as pm_runtime is enabled as the last step in probe.

Note, that PM runtime can be enabled by userspace or disabled.

> > > Also remove the redundant pm_runtime_put_sync() call from the cleanup
> > > path, since the core is not incrementing the usage count beforehand.
> > 
> > This is interesting. Have anybody actually tried to see refcount WARN about this?
> > 
> > > This simplifies the PM setup and avoids manipulating the usage counter
> > > unnecessarily.
> > 
> > > Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > 
> > This should be the first, or close to the beginning of the series, patch.
> 
> Ok, but help me understand why?

The commits that are marked as Fixes should be easy to backport. When
the series is started with the refactoring, it's not good as potentially
backporting material might (even undeliberately) get a dependency on the
refactoring.

-- 
With Best Regards,
Andy Shevchenko



