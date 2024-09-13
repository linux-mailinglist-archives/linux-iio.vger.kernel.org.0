Return-Path: <linux-iio+bounces-9485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34663977C9E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B75B290D7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78351D798F;
	Fri, 13 Sep 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UE+DQN/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD151D6DB1;
	Fri, 13 Sep 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221308; cv=none; b=qSvgpchDfP1PMXglGbrpzwUj3LsXBdr9cpbn51A3B8EJpKnetW3o5CGVU1LP0nV/lq/KDb9oGkCTzw5yvGstb3/jdwgVHaP1b0vn0r/SI3zbPpyAtxXSNaGK1AibAgCPKL8i59XxjmdinQKpiJ0f8N1+vuZYNHaggOeeP+0VxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221308; c=relaxed/simple;
	bh=7DGEWBjAfWkhNbt5jQHZrOkSIxaz2Tu237bLh6tN8O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQKZZSW90K9jl39HT9/9fVugvRW5xhkpI3ke86JtrvYYbNhkB+f1VtpI98ZIEtuRNDdALgQsdYxASS1d16rssUe6swY3QBMjUwtPS9x7v2UN2vww+V7R+5BxWg89PR/U7MOuAH/bnrWd/H4unzqLZAO51amg7qFtiKOwxYflkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UE+DQN/p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726221307; x=1757757307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7DGEWBjAfWkhNbt5jQHZrOkSIxaz2Tu237bLh6tN8O8=;
  b=UE+DQN/pf+YR/hLJRUgtsogBT/NlsgJ67isoj2yS2e6kB5s4a/vPzhWY
   DrkNgKySn6/cTe9kcOgRH+6jg1PH20B5pdGUU8cmjhvU1RnE4spNVwOFM
   IafINnbGsKJyoHaLCH41DDSM50aCF9J2P0sKLMvq+r1oPz6hwxDIWoJvs
   1OqhoX70wmLG9BYLAkTGcGU0q01ipmW9Tm7IVzb/lrKV+oYXTx3IIitn/
   kEGDRMjeKMxiKCOWBlPfImTWMquUJ8dig61DeMNM9Wem8olGWu7SyNHXy
   4rVN/fTuZJIqKPLFPHfuBCrIQolK/muS+lP8h0EPlLUOqNV/zM2SEN+1K
   A==;
X-CSE-ConnectionGUID: F/pFF9lwSiq+ZymzXOZadA==
X-CSE-MsgGUID: 31e/M6zsRDuFsYoR0pXudA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36250966"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="36250966"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:55:07 -0700
X-CSE-ConnectionGUID: Phe9HHwZRZmetMAb9Xy8XA==
X-CSE-MsgGUID: fewlj8mcQr2v4yh/3X2cUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67709659"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:55:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp311-00000008FZv-2Kdb;
	Fri, 13 Sep 2024 12:54:59 +0300
Date: Fri, 13 Sep 2024 12:54:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 0/4] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <ZuQL845_lQhpNpSR@smile.fi.intel.com>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912233234.45519-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 01:32:30AM +0200, Vasileios Amoiridis wrote:
> Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for patches 1 & 3.
Dunno if a couple of nit-picks warrants the v7, so I leave it to Jonathan to
decide.

-- 
With Best Regards,
Andy Shevchenko



