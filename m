Return-Path: <linux-iio+bounces-25983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA744C3C641
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 17:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037C04271A0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE134DB59;
	Thu,  6 Nov 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORCjZQG+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614881A9FBD;
	Thu,  6 Nov 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445618; cv=none; b=PDUT4vvJGWN7jTMVboTm+DXc51Bb0PZWBix0rV3D1EuR9Yjbyi+px31GLH4JaHcy3LOOIeoyLT0KBVksn7/5kz0d1r6R1+HvIiTg8BwbW7GCdUy4Z5c+5WS/4x39+hkIEOVkcOHv5tZ9CGQU9+tTbsyyKa+/hzhJN9IkuyTrs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445618; c=relaxed/simple;
	bh=4P/OM5L9DaGMXoSCYTxiPEDFIdx2bg4DKmyihPridNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+OVACQUvKtFKLLwZgWg8ibwWyquWAEGzbLxS4qc5grjoOKFdNJJDLdk1+t95BvincUbgY4B+HyTZvOzQ3h9A6c+wxunl5fxyUuVGP1+HL/L+n4lb4vxK43sgpHn8iwo0SIzocYGHA41Yc+rQ1GloDBVI7yVAcjoj5tvpC6FT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORCjZQG+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445617; x=1793981617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4P/OM5L9DaGMXoSCYTxiPEDFIdx2bg4DKmyihPridNY=;
  b=ORCjZQG+pU4MLQBB8RwvJ15cpt5+TOEcFGD2ew7UufmLm1nzX377hQVr
   I/4zOYE+31kzs/56ZpXmFcIMtmYhICs0iQ8KU5809mep+OGoDnNcb+3vW
   7gD/YxuQaKD3d5+xR2ZjY45MXWKfjStwkMSvmv1ioJtsOEWZz00wd9Qz6
   jbZXFwtZQF9QGYSw6CxLH110sITOhxJA2et+4aZdokUa4XssNXAABAM73
   MOar/n8hxYagImaACSJVMmS0nwu1huy5B7YY/qKH0hrINNSCSWh5T352b
   mqC9W7NlVU5kJlK3xGF/p0aL27U0IMB3dVkcBa5cYOnnFDwxX7Z886/9H
   A==;
X-CSE-ConnectionGUID: AAd9uNP0Q5qG4tlsurWYBw==
X-CSE-MsgGUID: E+v8NQXdSMCI12bgwZkI2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64502499"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64502499"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:13:37 -0800
X-CSE-ConnectionGUID: 5530So3TSH+OCCoUbNzAXQ==
X-CSE-MsgGUID: KYs+0bp7S9mUBDC9ayOn8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187512666"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:13:35 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH2c7-00000006Bug-1R3H;
	Thu, 06 Nov 2025 18:13:31 +0200
Date: Thu, 6 Nov 2025 18:13:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Message-ID: <aQzJK0i5WBrk0VQf@smile.fi.intel.com>
References: <20251106-icm45600_fix_buffer_sleep_init-v3-1-ea3af68a3e61@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-icm45600_fix_buffer_sleep_init-v3-1-ea3af68a3e61@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 03:31:07PM +0000, Remi Buisson via B4 Relay wrote:
> From: Remi Buisson <remi.buisson@tdk.com>
> 
> The sleep variable in inv_icm45600_buffer_postdisable could be used without
> being assigned in case of error. It must be initialized to 0 by default.

> Closes:https://lore.kernel.org/linux-iio/aPi6Xw-ZoUkW76zR@stanley.mountain/

Missing space.

> 

Redundant blank line.

> Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---
> Changes in v3:
> - Fix commit message: fix and closes moved to SoB

Not really.

...

Code wise is good to me.

-- 
With Best Regards,
Andy Shevchenko



