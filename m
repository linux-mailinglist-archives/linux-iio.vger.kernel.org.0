Return-Path: <linux-iio+bounces-21719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50812B07239
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 11:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A03171B53
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE262F2705;
	Wed, 16 Jul 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjKkeIiu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489B2F2700;
	Wed, 16 Jul 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659642; cv=none; b=B2ICx8gfgZkiPPef+MbUGpNyuvG24eoj+nreYL8zDMSOdoMLMnobw3KM3qkGLXTmYIzuGfRrTQvtgKEfV7wBqv6E3qT9xKr4xQQnDGq7EfloYIVerlSm8wUaGtZfFVOoUYUwmvKuyZZXl5nWvd7Xlyvdst3hrbVhF3O+z8SSaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659642; c=relaxed/simple;
	bh=EjKF3AVjBjvCyMapA97KDRJPDBSd+GsQrhby3qnAcio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFYURTM+fsw/aqXPtzLarC8qgO/vANiSgb05fnyJ0r8ReOFzDS/7ak20IY6uvxL8CjZzgF3c+MeNUsIQJmFsgXhApicObuMxLVa0KIoYpb+UaaUdfqVCSeySeou7CZBtSL0rSRs51eV22bXcALcLg9Lf6BB3TpieYwQAjaupjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjKkeIiu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752659641; x=1784195641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EjKF3AVjBjvCyMapA97KDRJPDBSd+GsQrhby3qnAcio=;
  b=bjKkeIiuTKBe6iAsRX6dQ1L8dOpsjm4vlfOGOW5J4QfgHjVrrCBmrRDu
   r+pKPtg52dVe+WPYaISwmd22+shc0nNlDC9npU0NWdt7I21cVA03KBoe5
   lBBoNAIMMmJ/csK2vQ91UXA13lgAbHlCiuaSLhOuyMddZWYMpNGgAqtFT
   geV5oZHQPo5ZMmk74cTNG8C4N+GpfTvm8yAOOThfd+EDfCghGLvdR9VxR
   VC9lAsxB+wRAHLfvFqpmPZMRpRZICaPg46HDL5DTDjuy1u4qxGBqBvYbL
   jLRCGRwVcW92G122O+Y+9nlwePKFUPkx5X7tncy8KqmjNZHxeeeBQ7u7O
   w==;
X-CSE-ConnectionGUID: Qamo6bXcRS+dmGzv2naWYg==
X-CSE-MsgGUID: cQGED2rvSta55DF5zFvsow==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72470814"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="72470814"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:54:00 -0700
X-CSE-ConnectionGUID: mwdRuX1mT/2liMlY0Jcr2w==
X-CSE-MsgGUID: AWubPpgZRkewwN2/8W6ZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="181154085"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:53:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubypn-0000000Fu7O-36QO;
	Wed, 16 Jul 2025 12:53:55 +0300
Date: Wed, 16 Jul 2025 12:53:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <aHd2s987EMCdgdrJ@smile.fi.intel.com>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
 <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
 <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
 <aHYIBReTFqJMtiXW@smile.fi.intel.com>
 <vlpqd3jeszhgpcob7qyzp5vljdowwu26my7xuwuvfftf54zg35@czxhsjejgdkm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vlpqd3jeszhgpcob7qyzp5vljdowwu26my7xuwuvfftf54zg35@czxhsjejgdkm>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 08:55:35PM -0300, Gustavo Silva wrote:
> On Tue, Jul 15, 2025 at 10:49:25AM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 15, 2025 at 10:37:22AM +0300, Andy Shevchenko wrote:
> > > On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:

...

> > > > +/* 9.81 * 1000000 m/s^2 */
> > > > +#define BMI270_G_MEGA_M_S_2				9810000
> > > 
> > > I thought this is MICRO...
> > 
> > Btw, what if we use the device on poles and on equator (or even on orbital
> > station)? I'm wondering if this constant should be defined in units.h or
> > even in uAPI that user space may add a correction if needed.
> > 
> I certainly hadn't thought about these scenarios.
> FWIW, the accelerometer scale values also assume g = 9.81 m/s^2.
> For example, 0.000598 = 2 * 9.81 / 32768

Right, but this should be supplied to user space somehow. OTOH the measure error
may be high enough (what is the precision of the measurements by the way?) that
it will neglect the differences in the 'g' constant.

All the details are given in [1].

[1]: https://en.wikipedia.org/wiki/Gravity_of_Earth#:~:text=The%20precise%20strength%20of%20Earth's,/s2)%20by%20definition.

-- 
With Best Regards,
Andy Shevchenko



