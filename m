Return-Path: <linux-iio+bounces-14903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1BA2571E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542AE3A23D9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338042010E1;
	Mon,  3 Feb 2025 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gM+Fjjto"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142320101A;
	Mon,  3 Feb 2025 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579232; cv=none; b=H5/P5PXticwq61jpdzq23ij+8JjAKsY780L2IZAruZyMBOhQk2pDWtRzieA5BxqYSEw1lRVg2bL85kH1KTJVCDnrwBVaXbkoQaFWzG8/Yi7friZjJmcPap4x4UkkKvv3DYketkfPD3dE/zvtK8ihYZuXc3/C1Va7M0Mr8tNQKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579232; c=relaxed/simple;
	bh=qnslBWaZeqQQpwo++gsxeqSnYoVVmXUnGg9io0rc32w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8cERXfpV3XWA5WGoDhzjXgtZHROdlaDDQxp+sJ1K8ix6RAfpHmvCpaU3zM5bSM4kRcbL03Z4ejxEF+mM2twNUZDVWA6sE8qjV3azv3YzScLZePptCed7GGwXma8YZdg+Ac83g79vgDkX9EnSCp/kncNv6KqduXDKkjIbsBTDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gM+Fjjto; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738579231; x=1770115231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qnslBWaZeqQQpwo++gsxeqSnYoVVmXUnGg9io0rc32w=;
  b=gM+FjjtoV6B0llJOepB9E7TOA8da11Z8O+gcGsH8NVkwD5OhRJ2xKQWV
   S+pMPXpmoRZ3V2IlmRZpVAEdEzcQyW79SLoeGx386zocHyWvQzYWQAc89
   TIQEqvr8Dc2Q63Ft8tLZ8VawkPNQZOU4zj0Eenf+/tJFvsv+95kOniQj1
   ZB4Ku527Ulx1aM2Hw0qFXBoHoELh/K3j3GaxGiVSo2fJW3F4OpxN8ctCU
   sOVKoo27roNvdp0zxPFcprgQasF5AX40JJn3KslrLdJP0WeVYFGzV0yJi
   Qx0SxFc7B0HvHzfBzwwIrvG5ZdXGQQ1rrYpqV5xJWWnNBuGerBMXMCvhH
   Q==;
X-CSE-ConnectionGUID: iI0hg5t8QZikAur2h9eYqA==
X-CSE-MsgGUID: UhhuajpTR9STAszyXGGHlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="50454088"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="50454088"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 02:40:30 -0800
X-CSE-ConnectionGUID: KtBXeEhdTSmO3z2kcycosA==
X-CSE-MsgGUID: xtRZ+1+ySPeFMY1rCkZGSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110822347"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 02:40:26 -0800
Date: Mon, 3 Feb 2025 12:40:23 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 12/20] regulator: cros-ec: use devm_kmemdup_array()
Message-ID: <Z6CdF2OQQcP76_bi@black.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-13-raag.jadav@intel.com>
 <Z6CRjgG7y7YOiGpV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CRjgG7y7YOiGpV@smile.fi.intel.com>

On Mon, Feb 03, 2025 at 11:51:10AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 03, 2025 at 01:38:54PM +0530, Raag Jadav wrote:
> > Convert to use devm_kmemdup_array() which is more robust.
> 
> ...
> 
> >  	data->voltages_mV =
> > -		devm_kmemdup(dev, resp.voltages_mv,
> > -			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
> > +		devm_kmemdup_array(dev, resp.voltages_mv, data->num_voltages,
> > +				   sizeof(u16), GFP_KERNEL);
> 
> Wondering if this can be sizeof(*data->voltages_mV) that makes code robust
> against type changes.

True, but I opted for a blind treewide conversion that is consistent with
existing driver conventions. Perhaps a better place for it is a separate
filewide series?

Raag

