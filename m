Return-Path: <linux-iio+bounces-27807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E255D2071D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 18:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1FB0305C43F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1214F2FD681;
	Wed, 14 Jan 2026 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzC1Bxip"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2092F4A16;
	Wed, 14 Jan 2026 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410567; cv=none; b=aJ6AWnqiwPTLHFoIiQP/FIoWK1LLGerlK/OOwPeBlbKCWJkmB6c0sGEXBExulaaY/hNnvUwPj5EvLqB1vgTw6n0E3XwsyRZ76yVRzkcHMtHxz/F1O7b5CeDvMhUI7PHvHgaDxzQHpdnJF2IIn1A1Hb5HnEMLf9ldThMThH+VF2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410567; c=relaxed/simple;
	bh=9tOhNAPDJ/7Tm6w8Sx/2Czh3Uh0PycN27ZIVUZ+Zs10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8lkdwtzGc4MbxWzVHAjs91ufkWb+RYzCG8PFV9gf+AhAIyVCp+adorWISYI8V3c+3R11aAkSxnmY5KJQ/DUrDeDIVty6ereJ0GQUE0/j1yATMyIaI9UJss90BceNUPFYA/HyCw41G3WKZoVmqmUxL6k3/QZZw68zaywCgWDHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzC1Bxip; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768410566; x=1799946566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9tOhNAPDJ/7Tm6w8Sx/2Czh3Uh0PycN27ZIVUZ+Zs10=;
  b=jzC1BxipblCxHzUk6WaXWJ6WEYET2D+Pfw4JBbk+/skfRhTUi9+BEgED
   aKAvHGIH8I3hNyeOHXOMIUyYegmJzDr58ToHG44InYKMkoXEBlgcul2nu
   yFwQKjmrkJ1VEcvjzRK29SNZf3ws5qS+ifnOwQIJR9lxUAmeSErXimUBc
   VwSbMa0GBUBhdzelWR/mcgqfvpznqP8grchqz64Al+LRWYW43fy4jmmhH
   zyi3q/HeG48bA8NKY7sAP8adL9ISMGqEt+ymhmD3OjIpupdMd+0d0PrnV
   sH284ODx9/0hbAWgCl2u1K4b0fudcXfgGIVhdwSTkZr0Xmi/ZXkKy35/x
   g==;
X-CSE-ConnectionGUID: 57bjsxxDSpCMRew+U+jvqw==
X-CSE-MsgGUID: lbDvtNgXSh6L8pnxpOQI0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68724829"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68724829"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:09:25 -0800
X-CSE-ConnectionGUID: 3TjQ9k6eSQ6P4jOo7+FPBg==
X-CSE-MsgGUID: er/D3EwYTtCkyMufETQIUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="208889081"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:09:23 -0800
Date: Wed, 14 Jan 2026 19:09:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 00/13] iio: pressure: mprls0025pa: driver code cleanup
Message-ID: <aWfNwLRi4ftU5LLC@smile.fi.intel.com>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 06:55:29PM +0200, Petre Rodan wrote:
> This series contains a collection of patches to the MPR sensor based
> on feedback I received for other drivers.
> 
> major changes:
>  - trigger flag fix (define edge direction only in the device tree)
>  - fix SPI timing violation
>  - fix scan_type struct
>  - fix pressure calculation
>     (does not affect users that define a sensor via the pressure-triplet)
>  - stricter check for the status byte + better error return levels
>  - drop the use of devm_kzalloc()
>  - stick to the datasheet parameters while performing the measurement
>     sequence
> 
> minor changes:
>  - includes added and removed
>  - rename generic 'buffer' variable to 'rx_buf'
> 
> Tested on two sensors - MPRLS0015PA0000SA and MPRLS0001BA00001A

This version looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

The change I mentioned can be sent as a followup.

-- 
With Best Regards,
Andy Shevchenko



