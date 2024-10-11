Return-Path: <linux-iio+bounces-10445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE499A0EC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3C7B2545D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3395A210C07;
	Fri, 11 Oct 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jv4etrwU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26663210182;
	Fri, 11 Oct 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641551; cv=none; b=uKT4qJs9MKVI/P8NuXQjBg8/kD+WBBvL8YxzBmjdWRYJygO0q2n5P1iMBbngaRHt+DPeLR8yqPEE0Tna20KGpgT/RZ+S6vPG3meGQOwac7zNWe6cDoDxewMGOXtNkZV1QD9Fpubo2zO3x0N2wBoTXxVrullDwLpX0T9lg2Btg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641551; c=relaxed/simple;
	bh=knVAo+b/lJS34xtrgQP01JcZx5fc22uyIO2k7QFKYG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLOI8aHzheSQhev50cRmBribTnsX7yNQSLNeEkd56fr5jhCRcvGbjAO3gz2Lbfox/Uk41T+2HBpavwJjjhm4KmAUHYiBcEmF9OQAX2bCmOkvSW0YgPPa5/pXP+PVO2N8rOVD5OGcK/k78qkBVdeIJnHTczdR2f99eo/JboUTRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jv4etrwU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728641550; x=1760177550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=knVAo+b/lJS34xtrgQP01JcZx5fc22uyIO2k7QFKYG0=;
  b=Jv4etrwUDaEF4A4RCiBQ8cbQGK52iUrdaUjinjIf7toIIivTAdpZbauo
   9jeu9i3klxidf6SJbHlTuz2Ug3nKt5DRelwIQRtK3n71x/yGAt/aUE5Gk
   oPbaiSkp1Y8PwP+XeukF9i8TDeyq5WJSNwc8ZvJUh4oBUHl2sVjynJeqo
   ngk1KkznRwGB239jl9jvXE/Vgk1tYMw8oB93UeJWnKoSFGVrMKGrzWfw3
   cN1nZC1Lq1tgQUSF/8qvEXu+nwyOvr4gpQowDvnSHo6jdGjIuHibRmVg7
   46vgrI9ZzMDVoqD5NSoPinDTIoj34ipE2gU1uazj2is++q5lX/fuy1IWn
   w==;
X-CSE-ConnectionGUID: hmKjz+bmT6aOERVdbULzvw==
X-CSE-MsgGUID: +Kwlo+tmTcGGnvXEDEfqfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="30911655"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="30911655"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:12:28 -0700
X-CSE-ConnectionGUID: fOhO5L/GRYi5DupXQr+Vmw==
X-CSE-MsgGUID: MugWOdI4SOqFoZhH6vHrJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="107722257"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:12:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szCdC-00000001qyw-0iQC;
	Fri, 11 Oct 2024 13:12:22 +0300
Date: Fri, 11 Oct 2024 13:12:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] iio: chemical: bme680: Move ambient temperature
 to attributes
Message-ID: <Zwj6BQNhyRp_oN2M@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-10-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-10-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:26PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Remove the ambient temperature from being a macro and implement it as
> an attribute. This way, it is possible to dynamically configure the
> ambient temperature of the environment to improve the accuracy of the
> measurements.

...

> -	var1 = (((s32)BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
> +	var1 = (((s32)data->ambient_temp * calib->par_gh3) / 1000) * 256;

MILLI? KILO?

...

>  static struct attribute *bme680_attributes[] = {
>  	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> +	&iio_dev_attr_ambient_temp.dev_attr.attr,
>  	NULL,

Side note: Perhaps a patch or an additional change in the existing one to drop
the trailing comma here.

>  };

-- 
With Best Regards,
Andy Shevchenko



