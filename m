Return-Path: <linux-iio+bounces-27842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F353DD28694
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 21:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27613301E934
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 20:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EC5322B90;
	Thu, 15 Jan 2026 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbKCne4e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865F324B34;
	Thu, 15 Jan 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508897; cv=none; b=cD8/d15/Ft32+jquJjl31ZZjufWsdvb9epN46FuNPRG10xeerz5HK1Y7EfPRSZiFWzyVXALtMuTu68lpa9GZaI7lAqhDr3t781VFWGz7hVuiUKqKawE4WbjYBG7RsCenfS5fhBbLc63jDen2JWjZdksRiEP2pz0FTnb19s24ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508897; c=relaxed/simple;
	bh=rsu+Q1MEYa0fVExpHShU5BvPYoHIj793qOYiQjyOHzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZPDPzIJKPMQZwmLllS4ewKzGHY7vyYKleIi0bbkmJY9HCUPzd773dxzXX1iyjYD+mZTyZHOCO2OYcOkFijYPlIBrXDNBaW2KNZmttloWby8IMf8YU10gG1OuRGcb/Ux1MIacoClKzfMYYWLSR1Nau/6yFvNxHapsiPnbdlB2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbKCne4e; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768508895; x=1800044895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rsu+Q1MEYa0fVExpHShU5BvPYoHIj793qOYiQjyOHzE=;
  b=kbKCne4eAqhvL4XtnpR0WbUVX9C2QP3MG93iHoVn3wbbF8ghEJmSxiOB
   cnoR5JW/3/dj3NImK8B2KTFU16KmRtvX/Km+nFMYqgbVsErDMP0BzmdQh
   cMcx3AoZNf/5yjgUEamm7azILUFETVbpfVAJOhYrRCoEnx28GDdYQzLu9
   XLvqDwBCyVJr6relv38wtHonzPKMXNAuJ49xumBvlcJzqDXIyAia8BjRq
   1XDupYQ/98DyIVEBtp856olkxPUdIjxoubTo2kRp5wHterU17LOx3zBmO
   s+YoJRZvlBpQLsg7InD2KXNZ4UqNOcEjoK9vAtwXiUqEwEYlpgBqS25UO
   w==;
X-CSE-ConnectionGUID: SwXf0R3aTEijxJVfTQoenQ==
X-CSE-MsgGUID: R6Kzd8X0Tw2w1WO8vPp+0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69027695"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69027695"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:28:11 -0800
X-CSE-ConnectionGUID: Bm+Ug0xaTjCbn6gOJOR9IQ==
X-CSE-MsgGUID: EoiS8F5HRMWjJ4B97YFx2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204246416"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.216])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:28:08 -0800
Date: Thu, 15 Jan 2026 22:28:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: accel: adxl380: Introduce helper function
 for activity detection
Message-ID: <aWlN1c4miwb94mOZ@smile.fi.intel.com>
References: <20260115175350.1045887-1-flavra@baylibre.com>
 <20260115175350.1045887-3-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115175350.1045887-3-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 06:53:49PM +0100, Francesco Lavra wrote:
> Motion detection functionalities (such as activity and inactivity
> detection) are only available when the chip is in a low-power mode; this
> affects the available sampling frequency values.
> In preparation for adding support for a new frequency value, introduce a
> helper function that checks whether activity/inactivity detection is
> currently enabled; this function will be reused in a future commit to
> determine what frequency values are available at any given time.
> No functional changes.

...

> +static int adxl380_act_inact_enabled(struct adxl380_state *st, bool *enabled)
> +{
> +	unsigned int act_inact_ctl;
> +	int ret;
> +
> +	if (!st->chip_info->has_low_power) {
> +		*enabled = false;
> +		return 0;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADXL380_ACT_INACT_CTL_REG, &act_inact_ctl);

> +	if (!ret)

What's wrong with the standard pattern?

	if (ret)
		return ret;

> +		*enabled = FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
> +			   FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl);
> +
> +	return ret;

	return 0;

> +}


-- 
With Best Regards,
Andy Shevchenko



