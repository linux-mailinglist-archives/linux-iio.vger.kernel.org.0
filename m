Return-Path: <linux-iio+bounces-27833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0B7D24CDA
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 14:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D40EC302AF9F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962038A715;
	Thu, 15 Jan 2026 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GT8uJhGp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB6246778;
	Thu, 15 Jan 2026 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484958; cv=none; b=qZTJXcG7QFcxoORqQhsdZ2AaQmckIxRXPRTd/i2UsmKZlW4VNYOhq33QiLIj2hHOyOdgBRsD1l1BKXgkCEWBDgh3a+9/CZmCiHBEOaZg9KQ0gMDE04LsWDRS2ssA/Ee0ytXKctmXvSQ+I+QbzaNwttqp0Y01/WXMJiO9jfNt3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484958; c=relaxed/simple;
	bh=+kpxCNt5+hPFpsbp/hKtC4sgL4cpiWJj4tB0ybHc4Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC2IQp6crrS/RwKvBtMgIhLj1MCpv4PErnAJKyJ7jEQPLxhpCo95YYB+NdAbFXGv9ENT+3Wsp3kaxZMqo/y8PBw9gEDfX0O/LYnZi9yUGAzzG7fgML0KSdBpI+0dlrUNGV1nrvpXFzBMUTtifl/h6QGMFAyrRP61YwdrK0OAdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GT8uJhGp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768484957; x=1800020957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+kpxCNt5+hPFpsbp/hKtC4sgL4cpiWJj4tB0ybHc4Lg=;
  b=GT8uJhGptJJXwNqANy11GhoKMACy/gjFMajhV0bFu58RS0nudm4W9ZH9
   +KBKXMKgRaAYPWuuNghxQeic7RUvFY6pl2x3V8Tda0C3QjeRLC2ewyB3P
   CJq+KhRocklGdyRQ0guuRT694dIpv0KtjE/00VuYs+mjVXRrsuVRUiTbF
   N2br9T0IB+LwQ41TGeFnyk7oA5Jt3iTQramBIfAQIakGUgHc3RWWaOTP6
   wDOh//UF0/6iyiu71yHbQXRiDoeYpehT1b/KegxQfDFcYfjd5bIHkgFZ0
   awv31JR2d4wlZYUARGftEGiRDj3Un9ekMazPQMysNC8uwpSWsvht3t6ar
   g==;
X-CSE-ConnectionGUID: irsHY4iRQKy4DJ3P1jWuXQ==
X-CSE-MsgGUID: UEaEsz+QR5SuEzCz+Iw4XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="81153897"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="81153897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 05:49:16 -0800
X-CSE-ConnectionGUID: dcOU4dm4Thq3jrvYevKGvQ==
X-CSE-MsgGUID: eGokn4vXSL6I6fDsnFsQ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="209819440"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.216])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 05:49:15 -0800
Date: Thu, 15 Jan 2026 15:49:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <aWjwWF2XmXJb-iJI@smile.fi.intel.com>
References: <20260115122431.1014630-1-flavra@baylibre.com>
 <20260115122431.1014630-4-flavra@baylibre.com>
 <aWjsWzo3PXHKsdJX@lore-desk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWjsWzo3PXHKsdJX@lore-desk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 02:32:11PM +0100, Lorenzo Bianconi wrote:
> > Some IMU chips in the LSM6DSX family have sensor fusion features that
> > combine data from the accelerometer and gyroscope. One of these features
> > generates rotation vector data and makes it available in the hardware
> > FIFO as a quaternion (more specifically, the X, Y and Z components of the
> > quaternion vector, expressed as 16-bit half-precision floating-point
> > numbers).
> > 
> > Add support for a new sensor instance that allows receiving sensor fusion
> > data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> > chip-specific details for the sensor fusion functionality), and adding this
> > struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> > populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> > logic to initialize an additional IIO device if this struct is populated
> > for the hardware type being probed.
> > Note: a new IIO device is being defined (as opposed to adding channels to
> > an existing device) because the rate at which sensor fusion data is
> > generated may not match the data rate from any of the existing devices.
> > 
> > Tested on LSMDSV16X.

...

> > +	settings = &sensor->hw->settings->sf_settings;
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > +		u32 odr_mHz;
> > +		u8 odr_val;
> > +
> > +		odr_mHz = val * MILLI + val2 * MILLI / MICRO;
> > +		err = st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
> > +		if (err)
> > +			return err;
> > +
> > +		sensor->hwfifo_odr_mHz = odr_mHz;
> > +		return 0;
> 
> break;
> 
> > +	}
> > +	default:
> > +		return -EINVAL;
> 
> break;
> 
> > +	}
> 
> return err;

Why?

-- 
With Best Regards,
Andy Shevchenko



