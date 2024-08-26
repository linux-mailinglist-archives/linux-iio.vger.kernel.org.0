Return-Path: <linux-iio+bounces-8785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCA95EE2B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247911C21635
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE3146A6C;
	Mon, 26 Aug 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqjbEUVw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821B804;
	Mon, 26 Aug 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667104; cv=none; b=Z7I76uj32wBo0igOsuXc4SPC6A6bW4F59cIGIlVpFgoUQkYBH4BKo1Zc3PQgXjrCnD16AM5w04l1pgMYH2SmLUEzUMxu/7f5AZ/2tTBjPeaRpgR9fmTtb6r9gVNQ7NO7F6HekW12+viXoS9mV9agizmGimjU1i4dKV+1+2a+iPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667104; c=relaxed/simple;
	bh=J9pk+6k9D1jPaW+Jut3/nqQGolmc7KHgQB0bSOm8q9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdG/oIB2ShIfiAj/2izMgmXfLzmkkAbGXtqiOshNhdjztGiDQ617pGcCuz+Eo+oHGzlwU9ifotP1ZUhdi+rYXAsluw2DPfcLXHVp3/s7K9Jp9Gwaa4cRSVfJIjLjaore+717OcgMhH/Tpd3eeMO7ox80flxF2sbdp0Iqj2z2iQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqjbEUVw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724667103; x=1756203103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9pk+6k9D1jPaW+Jut3/nqQGolmc7KHgQB0bSOm8q9o=;
  b=cqjbEUVwQxtAU7MDMRju8HDKVHGWlmkVcn7LIU3/uihCHk3jAQo0tJ87
   d7Ow6cpB4FhAZHCC8NekEG9SnTHQMKxf4NZIPTnH8osSF89ypEpqdzj9c
   bNfUsMnt5xnvT2b6O8ihHhUQJngZT16QzYrzBgRk3I2XsI+J0edFIPMDS
   Zl1NVfDcAo6XtX6QNUxv3G+njOOr+KxVL2TkzehE51y3QxqcXxg92zIdY
   nDJh3CLzdYGWwmSZdpdFp67lzkOeIa2Ft8LcgId8HIabseCoqBDTyYdAI
   plmfbb/X486eIYQzLQxZYQJpIkKOzyf1aZsTJoNwywSzSdfrKmFnHFnMf
   A==;
X-CSE-ConnectionGUID: 9HPCl1XCSY6Vs3/QX6LknA==
X-CSE-MsgGUID: 3H6IV8qmRSu+UHJJxEZpuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33646036"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33646036"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:11:42 -0700
X-CSE-ConnectionGUID: IY+5fxbaSCCWVpb1tq6FMg==
X-CSE-MsgGUID: U2gaNkVfSC2FLkb2WhS2Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="85648098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:11:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siWh8-00000001pMz-1yE2;
	Mon, 26 Aug 2024 13:11:30 +0300
Date: Mon, 26 Aug 2024 13:11:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <ZsxU0kA4lxW7ZHi9@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-3-vassilisamir@gmail.com>
 <ZsjfdRWRl4fMJP0Y@smile.fi.intel.com>
 <20240824111614.GB9644@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824111614.GB9644@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 24, 2024 at 01:16:14PM +0200, Vasileios Amoiridis wrote:
> On Fri, Aug 23, 2024 at 10:13:57PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 23, 2024 at 08:17:09PM +0200, Vasileios Amoiridis wrote:

...

> > > +	usleep_range(data->start_up_time, data->start_up_time + 500);
> > 
> > Seems long enough to warrant the comment. Also, why not fsleep()?
> 
> The datasheet of the sensor, and the published API from Bosch [1] 
> require the startup_time for this procedure, it's not something that
> came up from my mind. That's why I didn't add any comment.

The comment usually needed on the basis of how long we have to sleep.
To me ~1ms warrants that as it's long enough timeout on modern (GHz
frequency range) CPUs.

-- 
With Best Regards,
Andy Shevchenko



