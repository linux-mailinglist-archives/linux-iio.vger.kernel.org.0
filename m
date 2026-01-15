Return-Path: <linux-iio+bounces-27818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93862D233C4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90BF23020FFF
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264733ADBE;
	Thu, 15 Jan 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXepCoHu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42594229B12;
	Thu, 15 Jan 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466536; cv=none; b=DewPQoSnpsM1A2WA3ng08pJ3wmQJl2d5yjFY5t7ItArX2vzVnsfqPMXFGdswkaRW1lcZbjcr4EPYRuea9HCM3Lw6PWt75n6TNYPtLoApYBHWG5n0JGus32nRmVTVDNdaKsrQMF5CV9WkYFQgGvWQwmSA/na9x/n6jnC6gOuT0u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466536; c=relaxed/simple;
	bh=Pwq3sPCxdOUq71ZvicnfELQF+2gCcUDmXLiFTSWvbdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPQmCTeO/VfZ/jjCH60OBjz/xzbSuJIrQIRq+/+btYlXm49StR2kdnopA9Bo7dJ0+Gc44IZ3HL630UYtGsNO/6PbCzdmhwnzsKbkjR1Kgtrr5VfMMoHphhlKWPmC/E++7PjwaDom7zhh78egxb45HyqCr6+g8pC03fo2n2k1mY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXepCoHu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768466535; x=1800002535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pwq3sPCxdOUq71ZvicnfELQF+2gCcUDmXLiFTSWvbdc=;
  b=TXepCoHujak07zvos88H/bXXK5VGtfhhIvf2xcOiSEMh8dPk9bY/Otmc
   z77BkgFFlYnU0UW9PFiNIRF2eddQURlhXfrt7a117z81BT5ei2oJSx4bp
   wuw0C+dO0Ci2D5Y7uCSpHXb1IjmdXma793+FC1vbtzmO42JUmFOmYg3J1
   f7sSGk6ZDsKvVlWpl1qusbAIi8VW2BXeNR5BW66AuM4/xajV146+ZjXGa
   TFte7w93p7bZeQP9wkel+vL23mL/heZVSY0d11EDznODrvnealBTuc/l1
   Lb/ytRVog4ZHC6MnnPqSs1o/ogn0bEeXNM8r4yH80GBD2bxXUrZx5zQei
   g==;
X-CSE-ConnectionGUID: dnbpMswMSNqGwD5QPwz5vQ==
X-CSE-MsgGUID: tvrOROefQfm8G0VTtS3PuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87348069"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="87348069"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 00:42:15 -0800
X-CSE-ConnectionGUID: VqLRv7qzS6OElzbseGP7NQ==
X-CSE-MsgGUID: YAyUJWKlSBWgTVq8LAiRiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205184891"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.216])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 00:42:13 -0800
Date: Thu, 15 Jan 2026 10:42:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <aWioYpYPAPOGmnHD@smile.fi.intel.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
 <20260115-rfd77402_v5-v5-3-594eb57683e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-rfd77402_v5-v5-3-594eb57683e4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 01:57:39PM +0530, Shrikant Raskar via B4 Relay wrote:

> Add interrupt handling support to enable event-driven data acquisition
> instead of continuous polling. This improves responsiveness, reduces
> CPU overhead, and supports low-power operation by allowing the system
> to remain idle until an interrupt occurs.

...

Also

+ bits.h // although it's preexisting problem, but you add a new user of it

> +#include <linux/completion.h>
>  #include <linux/delay.h>

+ dev_printk.h
+ errno.h

>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>

+ jiffies.h

>  #include <linux/module.h>

+ types.h

All on the same grounds as above,

...

>  	mutex_init(&data->lock);

Conversion to devm_mutext_init() change should be before this patch.

...

> +	i2c_set_clientdata(client, indio_dev);

Is it used?

-- 
With Best Regards,
Andy Shevchenko



