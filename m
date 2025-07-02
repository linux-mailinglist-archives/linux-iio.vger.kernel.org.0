Return-Path: <linux-iio+bounces-21246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F97AF5BF9
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A41890CE2
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C62D0C6B;
	Wed,  2 Jul 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU5G0CkO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0512D0C61;
	Wed,  2 Jul 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468357; cv=none; b=XONjlfpHhVEo9mYUow/eb6U5KBshTO9CiemRRYjVYbam5nbhaISyR7AzGIsuveayceUuZ9UCmveGFlx7WpUECAaCz98qPUaKIavE7MzdLp5PKmQl07zIPpawP6uPZsKaIcUUCBRmu6R5JB1/P/vNnQYySljpMeaSz54N1wgI0tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468357; c=relaxed/simple;
	bh=XFa+RbN1hYeARCxpBewJM5HGG95dllp0td/+8jL6cQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsU581jdwkZWDiZlMcjH6BXTl/q5XoQ+lpPJn7sqxN+h+oe98XlciNCTjGTcqcVr9AZSMCtplPeSjjc90/SME17Q+0Y+R6mDQ4PIysMc1sFFIRrieYHH/4DjOH/W9hdqauMxDEqUhEZPI+478cBP1Xe1h6EVdWu2s/nDnWaeR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU5G0CkO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751468356; x=1783004356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XFa+RbN1hYeARCxpBewJM5HGG95dllp0td/+8jL6cQI=;
  b=bU5G0CkOtkAKmDjlb2IsHyrRypZqegm9MKUPYT79nTNc+p0PgHhXCzxN
   jszLnbkIp8hiAUqBxdJxOuTtATU4zdH6/rEmSsWgaZRjy8rg7U4QLYjZd
   pQJcfj9Bqg9WOQ5GVefeJi9eWCh4wfkRDe1Lhl31UVsypXH5gfWnqe5GN
   N1oaUkS0F9m3FUzkWEVPBDCZ2NliHEsgHRorpP9RcrVrU+UL60OADx+nS
   SRycY6wvQ6hwwNgXndsx856G5HoucsuS+qqOzFpm+ytqSKSTJH22B9AWq
   sR+vEFzIQHGj3yk5LznMeX0rB2sDNm5BrFJORRGITtYmPQkIs1UOy62ww
   w==;
X-CSE-ConnectionGUID: +uGABI7ZStqFUn03FnrU3g==
X-CSE-MsgGUID: NzPsRIfiRyWM8ZdffKtw1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65116366"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="65116366"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:59:15 -0700
X-CSE-ConnectionGUID: L3cqo9yRRX+jnk+l4X0ISw==
X-CSE-MsgGUID: XamOdK7qS1CjdsZZxHNgLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158477248"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:59:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWyvV-0000000BwqV-3Ldk;
	Wed, 02 Jul 2025 17:59:09 +0300
Date: Wed, 2 Jul 2025 17:59:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Robert Budai <robert.budai@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16550: rework clock range test
Message-ID: <aGVJPRmn1-HUBb40@smile.fi.intel.com>
References: <20250702-iio-imu-adis16550-rework-clock-range-test-v1-1-b45f3a3b0dc1@baylibre.com>
 <aGVIBVsFPcVw3lN6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGVIBVsFPcVw3lN6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 05:53:57PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 09:27:45AM -0500, David Lechner wrote:
> > Rework the clock rate range test to test if sync_mode_data != NULL
> > instead of testing if the for loop index variable. This makes it easier
> > for static analyzers to see that we aren't using an uninitialized
> > sync_mode_data [1].
> 
> But at the same time it makes it not to be the usual pattern.,,

Reading the static analyser output I think the first hunk is only what we need,
but this is still false positive and it's problem of that static
analyser. Have you filed a bug there? (My point is that modifying the code for
the advantage of false positives of some static analyser is wrong road to go
in my opinion.)

-- 
With Best Regards,
Andy Shevchenko



