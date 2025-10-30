Return-Path: <linux-iio+bounces-25651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B86C1EE58
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F1114E83BD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C12D6621;
	Thu, 30 Oct 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gy/Swgzw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463A2F12C4;
	Thu, 30 Oct 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811318; cv=none; b=cWNCdD2TIcZW4WZJp4gSvBuUdkRDVCksy940mWnCdsvCAJI3zr8pwYf9JocM52deXOdKVZR7JjSdmFkt4ChO+fgj+MP8dJHYq/0ImWrRHZAf9dpE2hNXqpA4NE3yRzEWJF8+alWVUjAXi/924VPxbwGlBjyouRvQp+xo78ajB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811318; c=relaxed/simple;
	bh=n7Qqfgj+rQT+Jh2BZlXaQF3sxTbKPl3C7VVMoYSKvzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk4PTREHvvkjDd5aU7UgxUmXDDSGDV+CI45Ey/6ZRWuweOIPcSzKjelSqTfQQOebSKfI0weO3rYU1BiYWgL0o2/GoarSzIAFyXBdeuvFZQt7WhRCpTBo4nb9G1PShutFAnJveAtSbfm9PO638dbK4tsp/Cj+WWOiCr+mloEX4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gy/Swgzw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761811317; x=1793347317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n7Qqfgj+rQT+Jh2BZlXaQF3sxTbKPl3C7VVMoYSKvzM=;
  b=Gy/Swgzw9CXp5vGnuzxoBD+Ub028JE2yPkIgWB53x7/pR0ORNHnrKeuN
   9mtshZfY4cyMuUd7Htys2+XSIBifPqmOP3oMmpZikRQ0fN5l8vintJAWo
   zwN1mpmjzUHRWrDv2K2WwzgY6zvmFI008ypNlq9S6LE3zqVabgIzCW5sd
   atI1L4dv1zNIag5qD2Y7XFB9JnmxzZ41IwUZjlUB/ZGU1VMtVwuDgjw2B
   UsTdZLKejJ6X+TBZtIhYna3px9swZhSgrr7JeX8AyMKYXGgQoyk5rb7MD
   unfswnzaxqGNWOk1Z/QL8du5iGjFXRJSwvafwOIZom4Uoi/jiZyE6dxLT
   A==;
X-CSE-ConnectionGUID: UE+viay0SGq66E37/q94XA==
X-CSE-MsgGUID: rQFGNYH2TR2ZiVcXOvXC4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75292082"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="75292082"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:01:56 -0700
X-CSE-ConnectionGUID: FnZCSWSMT3azCtSa2/wvJw==
X-CSE-MsgGUID: IhL1YlJUQrmaDAE1YXVXBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190250405"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 01:01:54 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vENbT-00000003pzk-2HzG;
	Thu, 30 Oct 2025 10:01:51 +0200
Date: Thu, 30 Oct 2025 10:01:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
Message-ID: <aQMbb6BUBHQUXX9y@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
 <20251030072752.349633-7-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030072752.349633-7-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote:
> This field is used to store the wakeup event detection threshold
> value. When adding support for more event types, some of which may
> have different threshold values for different axes, storing all
> threshold values for all event sources would be cumbersome. Thus,
> remove this field altogether, and read the currently configured
> value from the sensor when requested by userspace.

...

> +	*val = (data & reg->mask) >> __ffs(reg->mask);

Seems like yet another candidate for field_get() macro.

-- 
With Best Regards,
Andy Shevchenko



