Return-Path: <linux-iio+bounces-28040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B7D3C13D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E0568896
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D98392C32;
	Tue, 20 Jan 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cd2OpcXr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1E138BF67
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895489; cv=none; b=ZywlQcK9XS/MRn+NhJS6CZw6e+WDFuGX54XDae7ImOrz7vX2UteEWTynfwhypsUpRy7mCbJXO6Y2USMjo9PSrZAGJtZnj9/o5eFp6Hezqc5ZwUqW3czPtp8RM0PmPxsROL0Ib5y/M39tm2E6uYbHfXoNC+qu5qcpSXZdfHO6xu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895489; c=relaxed/simple;
	bh=KTIrQKoqYbuEaTSacPtwtDeJa0r+lqpTrAyIRVKygJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvZPdHXXXAHTZQ285eCBmEY/rIOyh5bpJseDU63ENVuR/J1OWdJJt3DxVpkBSw2+7HTt4UDhPSxufn6DzHtrSkYOPRPOJbXqVLj8z4R1zPgFDwjpmUqVC1Cwt1Op70zC/v0wiUSgatq1tsu7uU28R4caypcTVGxWisIMokUAyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cd2OpcXr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768895488; x=1800431488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KTIrQKoqYbuEaTSacPtwtDeJa0r+lqpTrAyIRVKygJg=;
  b=cd2OpcXr/fb4Xf4BL5TqYslsOoJReJBX5FKhikx+4PCWY4MwrvRGMKDS
   69oEkaVZe/9x+T8RzoQYcra6UFzagv+72aNxzjdQIOEvQzdaRmJJw3JrV
   +iEkb56JxmQhJLhOBR5Q1NS+19pdkmMejzr3iCKf430m0m12Zj/1DCv5j
   wzwzkk6NFFHhs6cZhCizZFcgHiTvK7Ht/7NwRNYKTJ+oi8jfO1tPF/ssf
   j+E987ovrusONiBoXmFL/rJh0NsIG5icswsJTV+OpG/v9cUBt2lbBlSsa
   JoYDGBGAhfMkYs9BvZmHH4w8/uRcnTwTuMLTvM47TO4g+t7dJYjEO1ntS
   Q==;
X-CSE-ConnectionGUID: nP3P0mjmRbCsYOdxYFcFHA==
X-CSE-MsgGUID: almkRo7TTLCKNJJUBTxzkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81535472"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81535472"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:51:28 -0800
X-CSE-ConnectionGUID: y74VkrjYQA28ObzO2+dvsg==
X-CSE-MsgGUID: 11tR3oJLTOGMoxD/8qARWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205958064"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:51:24 -0800
Date: Tue, 20 Jan 2026 09:51:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/11] iio: adc: ltc2471: Improve include relevance
Message-ID: <aW8z-qdbHM5hYd2C@smile.fi.intel.com>
References: <20260119212110.726941-1-jic23@kernel.org>
 <20260119212110.726941-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119212110.726941-2-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 09:21:00PM +0000, Jonathan Cameron wrote:

> Based on output of iwyu drop unused iio/sysfs.h and replace kernel.h with
> more appropriate includes. Add some other includes that were relying on
> being indirectly included from other headers.
> 
> Justification for added includes:
>   #include <asm/byteorder.h>          // for be16_to_cpu
>   #include <linux/bits.h>             // for BIT
>   #include <linux/dev_printk.h>       // for dev_err
>   #include <linux/mod_devicetable.h>  // for i2c_device_id
>   #include <linux/types.h>            // for __be16

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
with below comments to be considered.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Cc: Mike Looijmans <mike.looijmans@topic.nl>

Move Cc below '---'

> ---
>  drivers/iio/adc/ltc2471.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/types.h>

+ blank line here, otherwise it might be recognised as unordered piece.

>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>

-- 
With Best Regards,
Andy Shevchenko



