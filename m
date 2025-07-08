Return-Path: <linux-iio+bounces-21445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F39AFCBA8
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 15:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E93188FB60
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB67B2DE1ED;
	Tue,  8 Jul 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRAXHFpu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281FC2DCBF7;
	Tue,  8 Jul 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980499; cv=none; b=W9KMH3z2i9WtETIns6w3Lvc17wfCHVCvLB7DX3ayoupgURFSfu246J3Uw8f43sAUVOQ4JQgGLzLAuRnHhQEa9CcwrOmX0IozolmG1VrmkssPTHxOHJiuB1jtERLBsP/f4HLp9V1fxApc3B0PFwU6EggXZ3pFg0Pr/dDewXF2/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980499; c=relaxed/simple;
	bh=cU5ByOgwbuwKNQiNsdNv4TRrDApyVT56CFWQGxdiUP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToGI+qP9FmNyqcS/JIuX11GqPpqXFHTdINudc4qbr+69kRULTAWNFDmHE/oKf5K2yp4TNDBY6WcXUl0jgE2ddlM8z07UpshDwz0JTB8mJp+haQtJ96XiR1jDK9/UrnSbeA4ViT9IOlyHXaiu/FtkocGCnb8JWGaJow65bCxug3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRAXHFpu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751980498; x=1783516498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cU5ByOgwbuwKNQiNsdNv4TRrDApyVT56CFWQGxdiUP0=;
  b=lRAXHFpuvL2VGnvcE6Bo66yUerp+RmvYvQLlYbdUratVqxlYxwxK9Dfd
   rGSHJM9mvymRbLL6gF4Hmdc01krGsXGq4Z33DMhrx3W51sjG6yFP00nfE
   KAKuZyIgyWdGnlWcWo8bSzxKByQX3mR1EUBXHYdxs7LpRluzkKXb5pGgZ
   IvOaAEAvrbvhrN7CvZZavRvdN6PJpPvk2/3J7+VexQrTxBoYREe6Pm7US
   G/XBk+PTi8EkS2LauWtPGLc3queIu/6DJiRZJB0H5BZJDlCsmi3TpxHBn
   cL2KGV2oTLNelnFWIFQQlqzWJ0pKBvrOytIP0Z1VT3rwl959uD/YLxj9A
   Q==;
X-CSE-ConnectionGUID: 9IBMOM4LTZaWjjOjWvkjhg==
X-CSE-MsgGUID: bZbHR59NRO+59Mq8AckSog==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53334773"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="53334773"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:14:57 -0700
X-CSE-ConnectionGUID: 7UxPEPlTTWahGYoQ/ql4JQ==
X-CSE-MsgGUID: 95M+uA/cSfut1PFofi4xew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="186514106"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:14:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZ89s-0000000DZv7-0a3g;
	Tue, 08 Jul 2025 16:14:52 +0300
Date: Tue, 8 Jul 2025 16:14:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix temperature reading if
 accel/gyro is off
Message-ID: <aG0Zyxno62z1eMXx@smile.fi.intel.com>
References: <20250708-icm42temp-v1-1-81af60aab82a@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-icm42temp-v1-1-81af60aab82a@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 08, 2025 at 02:09:17PM +0200, Sean Nyekjaer wrote:
> Avoid return invalid argument if one tries to read the temperature,.

returning

(Stray period at the end)

> if both the accelerometer and gyro are off. Power the accelerometer on
> before reading the temperature.
> The original state will be restored by runtine_suspend() or the next
> reading of the accelerometer.

Why don't you use the room on the previous lines, the formatting looks ugly.

...

Does it need a Fixes tag?

...

Code wise LGTM, though.

-- 
With Best Regards,
Andy Shevchenko



