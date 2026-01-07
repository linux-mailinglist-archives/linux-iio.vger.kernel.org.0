Return-Path: <linux-iio+bounces-27532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B0ECFEEAA
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 17:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB10432B2CB3
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3F388061;
	Wed,  7 Jan 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyZ3d3Nl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4C37C119;
	Wed,  7 Jan 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802966; cv=none; b=hDBmOmsVlcMc7ganAqHJeiH4nfoYqPyGVCOry7HpUbC2a7AhPGiZo16g/31dqZI6NoYvj7PkDzgqSU0tEXPSfY/gElkwU9SsTwdh+DwDC/QeBh46yU7hrAbzr9YalbzaU3qBNZmS5eymD3kIEYuHe3CbuJEk2T1N+uxA3B2CUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802966; c=relaxed/simple;
	bh=jq0QEywoTnzpVD2zdLE2JdG+q/baB33yw7lWGEVqPoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGZ6ajhhtxaCGYQ4dVVEVxLu4VNyL8NKLZTbvd7jGIcL7X8FIimvpgj7ilKRTLCQYah2msf7Bs6zAVqIEI1G1XQV0cObcAVZrp1igHQZuLIkWIOfKTsGis2riuZHYj7/+f6bX6TEZlZMEamfEaVuHUOuU1OG9vtmZPcy57o+GuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyZ3d3Nl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767802955; x=1799338955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jq0QEywoTnzpVD2zdLE2JdG+q/baB33yw7lWGEVqPoI=;
  b=EyZ3d3NlkrU3NfB0PL/Ft+CzDGLk02sjqMl/Gdd45He3KxMohYrqkYzN
   38fDUlMXwoIyGIJr3tzQfwqi4f+fJdjt35H7iTtN1jXwOLtiZb9x766Ij
   kkb1+Q3g4Uftr1feqZmcb+THUUVPXeMEJ8ta82DSr/JIbUv4MmWOtOsRL
   +KHxQxIiCt7ZUe840pWKxAH6H1XFXD4bIkdBKraOaXRaNBNLe1Ibk6E5N
   ZUxQ7RvK+GkS9McYlQppB76g0fg0FapDS5qht01t26XsJWKg0pQi821cX
   nppqoX/kQGmx33XdGY9t84SS6a+HXFGnrPyLghi7wHBorF8TBen86FCxw
   Q==;
X-CSE-ConnectionGUID: tXHAnheySWSQjb8cCT/NCw==
X-CSE-MsgGUID: B6cSSCVzR/2NCjRp+NwmIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86592549"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86592549"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 08:22:29 -0800
X-CSE-ConnectionGUID: RP5w7t7WSsGmOLpz6X5W8w==
X-CSE-MsgGUID: OcEnbIIuQ9OMzuB4HNKMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="202746645"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 08:22:27 -0800
Date: Wed, 7 Jan 2026 18:22:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, tomas.melin@vaisala.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 2/2] iio: adc: Initial support for AD4134
Message-ID: <aV6IP3T3Q3z3aTVa@smile.fi.intel.com>
References: <cover.1767795849.git.marcelo.schmitt@analog.com>
 <6ae8e203f6fb6e9718271132bd35daef790ab574.1767795849.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae8e203f6fb6e9718271132bd35daef790ab574.1767795849.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 07, 2026 at 11:47:59AM -0300, Marcelo Schmitt wrote:
> AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
> analog-to-digital converter (ADC). The device can be managed through SPI or
> direct control of pin logical levels (pin control mode). The AD4134 design
> also features a dedicated bus for ADC sample data output. Though, this
> initial driver for AD4134 only supports usual SPI connections.
> 
> Add basic support for AD4134 that enables single-shot ADC sample read.

I have been on a few weeks leave and do not remember much, but it looks like
this version has all my previous comments being addressed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>

> +#include <linux/bitops.h>

> +#include <linux/bits.h>

No need, as bitops.h implies (and guarantees) that BIT()/GENMASK() are provided
with it.

> +#include <linux/clk.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

-- 
With Best Regards,
Andy Shevchenko



