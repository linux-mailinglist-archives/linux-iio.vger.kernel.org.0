Return-Path: <linux-iio+bounces-25932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA16C39C13
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 10:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF78618962EF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC230B519;
	Thu,  6 Nov 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fe4pQVrs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C8309DCD;
	Thu,  6 Nov 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420175; cv=none; b=OigQARNaUF1seaFQ0doFX3Z0gAYD5fWTY+09isqOhh6xOBiBsDjUPl5w6iiU+JGK75aMeu3pwRDpicGArvHTo+fFnyLDEGDipUrRhk28avTqML88L/+h8D38nyXdmVFEBQlxRn9ZYoivUsP42WRCzqtVECEGW72tCu3lwGWTs3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420175; c=relaxed/simple;
	bh=1xoEFGyLdYCbzgR/mVDatimumQJnCI1/RQddMt9KI0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io5gvqzYB7Pdw9WuWA93E70+wE1TXY4lMjG9i1SQqODKIfKksL5ouavCPM/HHcWYBsXMWY5dOOvkFK/kgjUlLj4gxIPBc4P+PWy8yaB36P5eZpsCEKwMilE0UKbKitYYzKQEM7zwXIfzPFuImpfejr/xPsD002Bcjma6urPTsog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fe4pQVrs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762420174; x=1793956174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1xoEFGyLdYCbzgR/mVDatimumQJnCI1/RQddMt9KI0M=;
  b=fe4pQVrsIzESqanmhiwe4OGTvixqgjaHfV62/HXZUfirC158fCbO4y9v
   iAOeP3orC1qy86xZd8Y+zEKKwFIrFUw3w2x44AyByopesbCwOy+kwFPbo
   tK+jlghgTpyLGKxxf1OTR4dIXxesdOGPLKwed/OcZYDXx1fMdMZyOnAPB
   UZofGfmHM/gHsk+ef6f1EycESJVt5ljHqCmtWRibwY8kxssE1pODYggou
   v8IYSnScG9E4j9xWWCCwYP1J9SI1sKb9A/dbP0rxkP1VXnza+vx8WnAWu
   OxyDSfP3Lk0B0wkbpMKHFztQEUBpHGhjbrRpGYFXXRpuAfY0qPvxmgwub
   w==;
X-CSE-ConnectionGUID: Wew85tWLQ3Kt1CmgleZyyw==
X-CSE-MsgGUID: Fv59igFNS8+rqGwO0eQccg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64702402"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64702402"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 01:09:33 -0800
X-CSE-ConnectionGUID: t4cXAYLeQBygry4nYTjgYQ==
X-CSE-MsgGUID: 4YSN0rZrTeuWgvw94vin8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="186958588"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.229])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 01:09:31 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGvzh-000000062aI-44dw;
	Thu, 06 Nov 2025 11:09:25 +0200
Date: Thu, 6 Nov 2025 11:09:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, error27@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: Fix error handling in viio_trigger_alloc
Message-ID: <aQxlxTiq59zynioS@smile.fi.intel.com>
References: <20251106082923.32688-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106082923.32688-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 04:29:23PM +0800, Ma Ke wrote:
> viio_trigger_alloc() initializes the device with device_initialize()
> but uses kfree() directly in error paths, which bypasses the device's
> release callback iio_trig_release(). This could lead to memory leaks
> and inconsistent device state.
> 
> Additionally, the current error handling has the following issues:
> 1. Potential double-free of IRQ descriptors when kvasprintf fails.

kvasprintf()

> 2. The release function may attempt to free negative subirq_base.
> 3. Missing mutex_destroy in release function.

mutex_destroy()

> Fix these issues by:
> 1. Replacing kfree(trig) with put_device(&trig->dev) in error paths.
> 2. Setting subirq_base to 0 after freeing IRQ descriptors in error
> path to prevent double-free in release callback.
> 3. Modifying release function to properly handle negative subirq_base.
> 4. Adding missing mutex_destroy().
> 
> Found by code review.

This is better now, but giving a nature of the issue and the fix I would really
appreciate some CIs and syzkaller (or alike) fuzzers to go with this first.

...

>  free_descs:
>  	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> +	trig->subirq_base = 0;

Why not getting rid of this label and accompanied code altogether?

-- 
With Best Regards,
Andy Shevchenko



