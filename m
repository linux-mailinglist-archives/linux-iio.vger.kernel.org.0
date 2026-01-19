Return-Path: <linux-iio+bounces-28002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F0D3B6B8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 20:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C761A308CCDD
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96F38F946;
	Mon, 19 Jan 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/Rt8u/c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169C31D366;
	Mon, 19 Jan 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849193; cv=none; b=Ce2BkxX4ocxXG3CZgjYUvasrz+cHeQdrf2qYcQHFUu1ZebGTO4Y7skAq44La5Qb7jCxO6X2KEN2uqFXUe1UzrzYKpfZ2Nr6Oe1/rb6MX0rQjZsVlW6Us5/xMnLR8SacWsASNNGdOtOLlAJ3Yf7WtLkcQl3rTB7ETQfiYZppJIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849193; c=relaxed/simple;
	bh=lBHtbBnOYSJYDBWdV6tJMGIcJ+/UmiSMdJtvU/Q9FDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL36jk33AzaB0bA5W+NjBmrGKgjJnRWqKsJWW4twy6+IBVSaDx4rHdEiRYjHMbgU0akypTUCbonpVHyGMfenmZXxGfTBxbi+7V/r6WlIevxhiBJ4wEW/tfJBHtSzzefZ6TkiLbUPlu7DidhM5kC1Y4w1dKK9xp6d7VK3FVe3Znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/Rt8u/c; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768849192; x=1800385192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lBHtbBnOYSJYDBWdV6tJMGIcJ+/UmiSMdJtvU/Q9FDA=;
  b=N/Rt8u/cYk5rtvwhOnaZXGmXXKLrY00MUaHAA+33Ms09pOWIE5nj4FTo
   U5vdYdd2q2Itqg8XqtYdpM3pGSotZ4Wsu+OCmIPqYwD9Mqf+mpVS8Y0+T
   6NyO8lZSJ2XVERgR/QhvSTTuDjl4V3RgZ5BhZaGEbIkDJRoQDeND/7aDJ
   5kDt5ldILEUnX436NfQN8hogYKTjly9S86p6drAhVYG0vfwavHeTyKqKI
   jepDK+NKUTaeRh+F4wmB7QXq+lcnCuvVpkaWt/Tj0wSWKvRuQaXiZsFQn
   fKgMSQpDeAgwsLYdMGPSRmxW6jxfjn4BJmmvdUpysSzsyRm1Ych7LFN4L
   Q==;
X-CSE-ConnectionGUID: adgDLksoSZ6SnOinyD/awQ==
X-CSE-MsgGUID: MBMRvtKNSIynV+UNlIgiUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="87644380"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="87644380"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 10:59:52 -0800
X-CSE-ConnectionGUID: i3RpKs4sRAiHsVGsFMYaxA==
X-CSE-MsgGUID: cDyuWNLgTKSfX2n6r7ANeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205559722"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 10:59:49 -0800
Date: Mon, 19 Jan 2026 20:59:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shrikant <raskar.shree97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <aW5_I7KuiVGg0v_O@smile.fi.intel.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
 <20260115-rfd77402_v5-v5-3-594eb57683e4@gmail.com>
 <aWioYpYPAPOGmnHD@smile.fi.intel.com>
 <CAHc1_P6Cv3fAKjSnPKgagi8t1R1RHsavSHGns3veXNynoTghLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc1_P6Cv3fAKjSnPKgagi8t1R1RHsavSHGns3veXNynoTghLw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 12:18:03AM +0530, Shrikant wrote:

...

> > > +     i2c_set_clientdata(client, indio_dev);
> >
> > Is it used?
> Yes, it is used in rfd77402_init().

Can it be passed directly?

In other words, can we refactor code to get rid of the i2c_set_clientdata() and
respective getter calls?

-- 
With Best Regards,
Andy Shevchenko



