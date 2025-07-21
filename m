Return-Path: <linux-iio+bounces-21820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB0B0C369
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382533A2C73
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF912D3A7B;
	Mon, 21 Jul 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQ8w+mgj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E42BD597;
	Mon, 21 Jul 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097980; cv=none; b=YaNOev9Zctrsi0V3EHSi8tlGXOcgqGMH5mNXolQXRxHXKRaYhFE7ODGPVfw9+2IU2e6b7adzAL3UtzShMqni+QZdw3j3XKriUPhpFtLYjaYn2EYwaw6CvsjmMe90Eg1aBrCDgmqZfPqrW+2MJvfKd1Yf8/hyleIK4H4gLod5Mgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097980; c=relaxed/simple;
	bh=7k7FIu9l8kyl4/XCWul7mElZtxHz78j3JA01FFPu7KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3VUzlbnMps/IwaJBziPzR0/533QW325gpcdzXl9esr1DrchfFBpXhTDiQvNTJyZSXudMbnrEnNXArsUah6IE0RkrIBGJjNctksNs6y3TluMXdumrSy+Dt9PBuJzYUoSR7aZwxGHiHV1OektETVOOdYb5wLMC0FgB0EiKq13MaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQ8w+mgj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753097979; x=1784633979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7k7FIu9l8kyl4/XCWul7mElZtxHz78j3JA01FFPu7KI=;
  b=hQ8w+mgjiZII5FuFYaACTjrrEha1y4bqNNugQnyuTWM6zMadj+VUqTWX
   TEf9Uwdwru/+iQoH4Lx2ZH31g12YGxOhvPb6BR/oynwZ6/0XBR7nyJ5AX
   Um7R0bF4DEoKv2IkpgS8fbNDDXiYcP7fikPQE/b/XgOE6bWy9TkV6J9Gp
   uNlABabxdf5GdNXbMGA9ZlVdIcgEragw5hv/ygeh4uipwKbLga/xeI5cT
   ego1Af4mohjlSSz3NxmDlvOSYJcWR/8yUP+hN6kNu7g3/SKSbvEjkAcaO
   dwOqOzmyhoCcBAPS6vhDtZEY94pPYGzaHnLV1J8EPIbNuNGaMzRl5Rbwd
   A==;
X-CSE-ConnectionGUID: KC+unSYcTea3M1KOst7cmw==
X-CSE-MsgGUID: pFdmo3rPRr64p6YT/4Dd3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="65569076"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="65569076"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:39:38 -0700
X-CSE-ConnectionGUID: 08BeZg13QaiAd8iWiSkVqg==
X-CSE-MsgGUID: 77qTiqY2QfWse4mCosciBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158474759"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:39:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1udork-0000000HKNb-08Wq;
	Mon, 21 Jul 2025 14:39:32 +0300
Date: Mon, 21 Jul 2025 14:39:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, lorenzo@kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
	manion05gk@gmail.com
Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C
 interface
Message-ID: <aH4m84n5UbCsktCM@smile.fi.intel.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH4mwkh80TUTNXtS@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 21, 2025 at 02:38:42PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wrote:
> > Add a shutdown handler for the ST LSM6DSx I3C driver to perform a hardware
> > reset during system shutdown. This ensures the sensor is placed in a
> > well-defined reset state, preventing issues during subsequent reboots,
> > such as kexec, where the device may fail to respond correctly during
> > enumeration.
> 
> Do you imply that tons of device drivers missing this? I don't think we have
> even 5% of the drivers implementing the feature.
> 
> > To support this, the previously static st_lsm6dsx_reset_device() function
> > is now exported via EXPORT_SYMBOL_NS() under the IIO_LSM6DSX namespace,
> > allowing it to be invoked from the I3C-specific driver.
> 
> Why system suspend callback can't do this?

Ah, and why only I3C is important? Doesn't I2C or SPI also broken in this sense?

-- 
With Best Regards,
Andy Shevchenko



