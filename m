Return-Path: <linux-iio+bounces-21521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78217AFFD96
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 11:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5937BE2CA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B36A28CF77;
	Thu, 10 Jul 2025 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aX5LsSC3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360C22FE02;
	Thu, 10 Jul 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138551; cv=none; b=DW4viqEEEnZLD2Jkw57x7Amuts415uGyRXDZLpyQjnrSJloZpj0g5hrHJaGnzDFAGNyE7+6G5lWQD56s9BfbmCJaDuQwG0wT9fs7CHTITGKqxZle+RK/9kohgMD2WgnyAOpVudCRp6smGYcvH7v0KO5joF2HGy7gomY4QggV2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138551; c=relaxed/simple;
	bh=dTEvyc8XjqLqCRnqx2ZNkumTcTOQ7Wgz7rECYVf3C/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3m77nPRI+mO54aNCX2HuIUrKHBTtzu9yt5fv1vXXSZePUlQ3bORTs8Lhg+Pa2uagv96q5Da9wD1/MGDYMrLLEW0MDkQkXsFYReNx17BS6vCYnPczg1bOOCGVXk8VrnubW55zlIWGi1id1U+hD7VW0dPbtCVmvzrCTWtnFo91Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aX5LsSC3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752138550; x=1783674550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dTEvyc8XjqLqCRnqx2ZNkumTcTOQ7Wgz7rECYVf3C/M=;
  b=aX5LsSC3t5kAPs6YlWA1ZQK17EpiMWw9tbeLtQiHjNECimB2tFD2OGSI
   rU0fRaccY3Rakb9fDWbsKH4BurkOqZR7Sy7bHG3hlF8mZpcEEzFSl8aZM
   PjC5MVo1iWyVHznBH98WO51y27NXclDbP0NTj++jYGgRyehFwvILIRbg+
   J2FGO3zeqbDa/ItgOenoDvUL2y7Rrhqtwximb9NITqt/gGwRL0ew43NEn
   TFdqdUU9cUT9ENf8uHUmviezxLm0K339J2D4Wn7/7N5bzv2oeQVjqB7eL
   iyKlhhmJc4fTwsB4ztlnvLxsa1npvzDmslzf+54wUN/v0Jd/6LIjEqa9o
   w==;
X-CSE-ConnectionGUID: F5quj+RiQKqR9tXdmewWOw==
X-CSE-MsgGUID: m3qWPlk8T9OGLX1pWQSPfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71860966"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="71860966"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:08:46 -0700
X-CSE-ConnectionGUID: MsqMwOSyQ5abXVtMm2pmIg==
X-CSE-MsgGUID: tNU+O4b4T6u6/JSXi2wluw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="187023624"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:08:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZnGj-0000000E9Sm-0DRE;
	Thu, 10 Jul 2025 12:08:41 +0300
Date: Thu, 10 Jul 2025 12:08:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <aG-DGEpZOHqFoIY3@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
 <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 09, 2025 at 02:35:12PM +0200, Sean Nyekjaer wrote:
> Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> calls during probe. These are not required when the device is marked
> active via pm_runtime_set_active() before enabling pm_runtime with
> pm_runtime_enable().

Hmm... What will happen if the autosuspend triggers just before going out from
the probe when this change is applied?

> Also remove the redundant pm_runtime_put_sync() call from the cleanup
> path, since the core is not incrementing the usage count beforehand.

This is interesting. Have anybody actually tried to see refcount WARN about this?

> This simplifies the PM setup and avoids manipulating the usage counter
> unnecessarily.

> Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

This should be the first, or close to the beginning of the series, patch.

-- 
With Best Regards,
Andy Shevchenko



