Return-Path: <linux-iio+bounces-21902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39800B0F4C9
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2135809B5
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863BE2E765C;
	Wed, 23 Jul 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2l3GQ+P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69FF1BF33F;
	Wed, 23 Jul 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279375; cv=none; b=g/polyDJsh4S3CClmgeF20mdxLXnCxUF9ltHoT6uk101Ka743VWcbVf7xzqMBbY4HesXTV131Fv4hFBgS6o+O6k9SGUqYEkHIJcm94IldSmdCadWK7WG7pnPbHBovoDuZCLR40VYTsGu9q8h09nB4/Nwk/Qtw295aktInarh5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279375; c=relaxed/simple;
	bh=8BdW1LBKJhDxXzq6YwSk2fYG+KDRbi+4iNzGslJHjro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwnf1ig8x48bwAwz5VJqSdZtXyGZfjlqqncdMXSgkmqlX2y1BxBVumL/0udP/5Qb4DvftcYm2gTaFCr88vkja/4wCqahjCjNMEEbDJ8MfzroXvlBGe76/mhFWyv5czaDXbWlYnV7/uUjNgYflkvI/zjIGjqoKu/yemVRaGmAd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2l3GQ+P; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753279374; x=1784815374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BdW1LBKJhDxXzq6YwSk2fYG+KDRbi+4iNzGslJHjro=;
  b=Q2l3GQ+PUl5W781L1jq9fWXEr8cU6x+JAvitAAUX8z9S/kheuvYZUU0b
   BlvsS7IHmrj0X/DwWJ99z8184bCMSKxd95LDfVQKT3QXE6BDQoYHP+hWx
   SUPUVMLxHANEoNAvtIfU5ISx+rvyYAdgTAXhREu3n5csn2ZQsWOP8kqBN
   nvO08Wgkn906tuk+5QVMgOAjyolXF2wiW677xSembuBVoTXKxdMnuFgXL
   pqB9uRXQSulhFZ1Jz2A0AjNN6WJP6SblkVQAtJkQotBY2eQNPeLNEuHJQ
   hS6YZxQiwowMj+JWIJI3TadB/9meBDN9bLDeqqkHg24s/lm07z/ax9Pzm
   w==;
X-CSE-ConnectionGUID: ZaHHHV0vS9S1cVNKIXI33g==
X-CSE-MsgGUID: B0G2Ckg6Twi1Cr4khsciDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43182027"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="43182027"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:02:53 -0700
X-CSE-ConnectionGUID: ibXfojsqT6q1I2ur++ZJMg==
X-CSE-MsgGUID: FGKlUjwGSlWE0rOOKSL4IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="160259445"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:02:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uea3U-00000000J7o-1Eyq;
	Wed, 23 Jul 2025 17:02:48 +0300
Date: Wed, 23 Jul 2025 17:02:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report
 data freshness
Message-ID: <aIDriADP9O38eNNT@smile.fi.intel.com>
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 22, 2025 at 01:24:18AM +0530, Akshay Jindal wrote:
> Some IIO sensors provide a status bit indicating whether the current data
> register holds freshly measured data or stale data previously read.
> 
> Expose this status via a new read-only sysfs attribute, 'data_fresh',
> which returns:
>   - 1 if the data is freshly sampled
>   - 0 if the data is stale
> 
> This attribute allows userspace to observe data freshness directly, which
> can be useful for debugging or application-level filtering.
> 
> Document the attribute under Documentation/ABI/testing/sysfs-bus-iio.

> +What:		/sys/.../iio:deviceX/data_fresh
> +KernelVersion:	6.16

No way it can make this version. Neither v6.17 if I understood that this
feature is proposed in this patch.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute indicating whether the sensor data currently
> +		available in the device is freshly measured or stale.
> +
> +		Returns:
> +			1 - Data is freshly measured
> +			0 - Data is stale (previously read or not yet updated)
> +
> +		Provides userspace visibility into data_freshness status which
> +		can be used for debugging and informational use.

...

>  
> +#define LTR390_DATA_STATUS_MASK		BIT(3)

Missing blank line.

>  /*
>   * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
>   * the sensor are equal to 1 UV Index [Datasheet Page#8].

-- 
With Best Regards,
Andy Shevchenko



