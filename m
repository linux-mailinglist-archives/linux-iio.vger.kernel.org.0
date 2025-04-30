Return-Path: <linux-iio+bounces-18901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32979AA4EF2
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A021BC13C3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78267B3E1;
	Wed, 30 Apr 2025 14:45:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54B2DC770;
	Wed, 30 Apr 2025 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024323; cv=none; b=pDKy9TouIrMny0nuiG0Wassz4I5AvxIThLsZZZ+5SX8IWMTYZxBCI+qNU1X146wrw0BFjzp/XNXDVpCQn6WRhwE1kZ/cJJ9ufZo+xvjXWnKztYeybhXAYL9e7HcKbl5k4ykgkDLOciqjrBF50AI96eruKD3HnbMr/U9wZSNjx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024323; c=relaxed/simple;
	bh=36OT3QoklzR6oVTmVWYqH45+dqveA3D0pcoW6+LcquY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlMJhuMrM0RwXifpBbk69UXrpGS56CXiAEvd/YJ0isI7/tHhJTO19mK20Uum+jH4A2drv4En1pVJxdfpiQjPbqx8VFbHom18rQykQGwbEjOyv4DzIGPI/4ar1kanZI1OIRQvI2poYF9XGO6AhOXnh0E8M37BthuxrYkpgRqrYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 3db42KlmTuGbl75TJ1ZtDw==
X-CSE-MsgGUID: t81fCUIOTfafqxIW8b1e+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47406996"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47406996"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 07:45:20 -0700
X-CSE-ConnectionGUID: 5ySyaq5XRCy2yXSGoGfJYw==
X-CSE-MsgGUID: oUv2qTAQT86AbRhnb/POFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="139267865"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 07:45:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uA8gT-00000001eVI-2qVG;
	Wed, 30 Apr 2025 17:45:13 +0300
Date: Wed, 30 Apr 2025 17:45:13 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] Documentation: ABI: IIO: add calibphase_delay
 documentation
Message-ID: <aBI3eUPirZEXpZgG@smile.fi.intel.com>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-1-eb4d4821b172@baylibre.com>
 <4645ae3e0c3bb1ada9d4cadce77b64fe5e651596.camel@gmail.com>
 <070b269c-c536-49c5-a11d-7e23653613f9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <070b269c-c536-49c5-a11d-7e23653613f9@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 30, 2025 at 09:21:28AM -0500, David Lechner wrote:
> On 4/30/25 12:40 AM, Nuno Sá wrote:
> > On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
> >> From: Angelo Dureghello <adureghello@baylibre.com>
> >>
> >> Add new IIO calibphase_delay documentation.
> >>
> >> The delay suffix is added to specify that the phase, generally in
> >> radiants, is for this case (needed from ad7606) in nanoseconds.

...

> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibphase_delay
> > 
> > Not sure if I'm too convinced on the _delay suffix
> > 
> Phase is measured in radians, not seconds, so it seems wrong to use it here.
> 
> https://en.wikipedia.org/wiki/Phase_(waves)
> 
> And the delay here is with respect to individual samples in a simultaneous
> conversion without regard for a sampling frequency, so I don't see how we could
> convert the time to radians in any meaningful way.

And how this delay is aplicable to the phase in the hardware? Sounds to me that
HW has some meaningful way of such a conversion?

-- 
With Best Regards,
Andy Shevchenko



