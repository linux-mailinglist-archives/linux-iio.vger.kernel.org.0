Return-Path: <linux-iio+bounces-21819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6DB0C356
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B359542165
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4602BE7A5;
	Mon, 21 Jul 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4L2CXsF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60702BEFF0;
	Mon, 21 Jul 2025 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097931; cv=none; b=pHxNnx1KCY/4mt2Z+cbVGMF49J5RP8GhHM0KXYunaJhT+0l3Ow9XDXoxA9U+eaGLl7goWEyIjrZqOl6uKo/t71P6tRZTkzL2iRXdhPlEuf5ROn3KtYKwhRfoQ8XlGF+W99yZ6kt6s7kGYfDEqjvj2puilvQZHnEfQNppLd2WrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097931; c=relaxed/simple;
	bh=nbJKvdD8YS/DgAYLX0w0/6rkI+TIGv6wB5zV4GbVwgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akmX5klRGHlNXGD2lIw5Mhad5Wa/VpbuP+PZPk7YpX4Qg8Mpfb2i3L+JhrSbN/Q/oKhhnN3r1xOR2rEUq6VSz3IjwTDD2V1T6A2Lxg9dAebontygRUGRLYq0vuQLYGAXrPaVvf49C0fir0P6XvRZVCL0csa9lUcFte7ZOrCnd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4L2CXsF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753097929; x=1784633929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nbJKvdD8YS/DgAYLX0w0/6rkI+TIGv6wB5zV4GbVwgk=;
  b=L4L2CXsFZruyG0ITgyvCwmnVcwi23XrQKCcwt7KcAbd+GOwr/hSjH0J2
   z4YxnzDa95f2VXQfR84P56DFWmlHez90SyRDzuiVoP5KQL3PaohfyLFNk
   JDTD35vV4spwhYEMXEQCMx1+ClNQJBbmpAqX5v93aE+/DL/riEP/h0sz/
   c/RrbboUhnitMUrUxi52MKRwhGBbpLN2RZhuiMaC92cqD4ID23WrTgEaG
   1pLvQ+fnsPAjJwe5sJpqO7oDrGKC2KuhdsE4IB6V+a+j27eLkirUUQfoi
   8jVCmsciTEsZ85Ft/wwRW5GKHiURpxt1FhRRDhgd0XhFf8V4l3/9s4/oW
   A==;
X-CSE-ConnectionGUID: m1kKx2SQRSGjuZKZ73YHAg==
X-CSE-MsgGUID: sELoqRhrQrmZP4qoIVU5dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55459402"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55459402"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:38:49 -0700
X-CSE-ConnectionGUID: 5FjhRQSnT8CEZXbbQX1Ncg==
X-CSE-MsgGUID: va3jMydQT0uELFgUgb26jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="195902731"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:38:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1udoqw-0000000HKMv-38pZ;
	Mon, 21 Jul 2025 14:38:42 +0300
Date: Mon, 21 Jul 2025 14:38:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, lorenzo@kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
	manion05gk@gmail.com
Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Message-ID: <aH4mwkh80TUTNXtS@smile.fi.intel.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wrote:
> Add a shutdown handler for the ST LSM6DSx I3C driver to perform a hardware
> reset during system shutdown. This ensures the sensor is placed in a
> well-defined reset state, preventing issues during subsequent reboots,
> such as kexec, where the device may fail to respond correctly during
> enumeration.

Do you imply that tons of device drivers missing this? I don't think we have
even 5% of the drivers implementing the feature.

> To support this, the previously static st_lsm6dsx_reset_device() function
> is now exported via EXPORT_SYMBOL_NS() under the IIO_LSM6DSX namespace,
> allowing it to be invoked from the I3C-specific driver.

Why system suspend callback can't do this?

-- 
With Best Regards,
Andy Shevchenko



