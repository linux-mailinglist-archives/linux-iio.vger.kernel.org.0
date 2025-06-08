Return-Path: <linux-iio+bounces-20321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1DAD141D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 22:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CA1188AFB1
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A81D47B4;
	Sun,  8 Jun 2025 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iubu/FfH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A29D1519A6;
	Sun,  8 Jun 2025 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749413004; cv=none; b=sCSqUUcIlgzMvupxLrj/OUTNlIlHBQmg0Pf7L4JYScEVa8DHdhNupCyjhmYH4hgxBrlyMidi/Vo+NP51ZqvphjVkgtzjVi4bsFpbbm6q32tjbytBgM7qhAAsEEDOPis3S18/WoxTR3s1EmXoYfgdc85X7sPpH3XYrZ9+QSx9gd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749413004; c=relaxed/simple;
	bh=OeZ6xbcvogfmPu5nXcqXy3BwJeFRU/9mf3HJ/785B3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5U117AyYmDqNbwfmmzfreEXZ+YY0vTqNGuX/4/Np/W3r8LHqUkMoqfbVFmIte0qUAbJJ+SR7UdZP0HihWyBx1vXKiQrx0BZ5egOQ4R1C8ixwQGs3P6t0DHMiNJmQjK8cRc+ArcuyFgV4GypDi1rDL3VthftRFs8PtXCuuTdcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iubu/FfH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749413003; x=1780949003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OeZ6xbcvogfmPu5nXcqXy3BwJeFRU/9mf3HJ/785B3g=;
  b=iubu/FfHghOn5SJ9xvkL2YMPxmzaOuN5vj5GLmaf73zleZ6Fh+KPK/u6
   rKNVpyYasXZ7zaYRt+m21Ylzvr9rFTmudKu+vK/K0gTZ7P2Wpy844+jDZ
   c8blgX6s8yloYLeEDMMFidThkzzfEz2t2tmRMqXXzTk2eWy8bRi8PDAKj
   MsBKJeugh+xZ7ppDf5K5V3HkV9aXshxU8Jupnxp4gkWS9qSDsBgANLU9L
   3NNAz+GZj1kMBJgRr0DcDr2Zdl/Snm2wT3qflBrCixc7023P2vHxUBiLU
   zhtDpJ4gxm7dMNqVs0tQc7VtlAhTQr0jzzpEpDtSGpEdARruFE98DTqTy
   A==;
X-CSE-ConnectionGUID: Ax4VrffYSlyUnNg+bFs5Mw==
X-CSE-MsgGUID: IUPmRpu3QrSjkQmgBfufUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51352758"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="51352758"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 13:03:22 -0700
X-CSE-ConnectionGUID: r3bJTbIKSByB1u6+roiOPQ==
X-CSE-MsgGUID: RecwGYQRTTOLlZ3lcy/9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="151197343"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 13:03:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uOMEg-00000004qfp-1WM1;
	Sun, 08 Jun 2025 23:03:18 +0300
Date: Sun, 8 Jun 2025 23:03:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gustavo Silva <gustavograzs@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <aEXshsLK0JLUp37s@smile.fi.intel.com>
References: <20250605-bmi270-events-v2-0-8b2c07d0c213@gmail.com>
 <20250605-bmi270-events-v2-1-8b2c07d0c213@gmail.com>
 <aEKxhPFDQEIN1xnm@smile.fi.intel.com>
 <20250607165004.4673e9f5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607165004.4673e9f5@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Jun 07, 2025 at 04:50:04PM +0100, Jonathan Cameron wrote:
> On Fri, 6 Jun 2025 12:14:44 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jun 05, 2025 at 07:05:01PM -0300, Gustavo Silva wrote:

...

> > > +	set_mask_bits(&regval, mask, val);  
> > 
> > You can't do this on the 16-bit values on some architectures.
> > Maybe it's easy to implement cmpxchg() for 16-bit values there,
> > though.
> 
> It doesn't need to be atomic, so stick to traditional
> 
> 	regval &= ~mask;
> 	regval |= bits;
> 
> And avoid the fun of architectural corner cases entirely.

Standard pattern is

	regval = (regval & ~mask) | (val & mask);

this will be robust against any changes in the val.

-- 
With Best Regards,
Andy Shevchenko



