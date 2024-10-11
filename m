Return-Path: <linux-iio+bounces-10449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5142499A1BC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09F3286C39
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D54A216A33;
	Fri, 11 Oct 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHa8dkLX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7478216437;
	Fri, 11 Oct 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643331; cv=none; b=NmSNGTqLM2IsEwWLohGAYhUrWuf4GY6BTviqYETwBSUqqtMm0ogF9Pov90WeaG2D4PC3+0FZUdtGQ1Nxgih7LihMFWLq92a4fxLsUVYLgkzOjlOvEYm8BCKe13ec+zEzPkVCuvMno42q4xBowogYytwwxNYm+yrIqiL/QysGoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643331; c=relaxed/simple;
	bh=8oNXqdznljnXVxSrIhnhjZsB8+PHRWcyNeEXqNTFp5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH9rMbOVblYcNe3nHPLlztynZ3iZgJYCTr1+yeXKMHoaMgDWz7G6tpiqr2vDXWuIfBVs69KkeFrMsTSn9IaaUNE9GdBitb5tte6VRgCE16YulFIIeIxay8XyasWLNeHKLxreSAVEwY7mqaBFKXVy4WGeOFdWNSvKrdTwPnLWwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHa8dkLX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728643330; x=1760179330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8oNXqdznljnXVxSrIhnhjZsB8+PHRWcyNeEXqNTFp5M=;
  b=bHa8dkLX0G83PuldQeBu1dRJs89SyQc7EpPPXKZ2W6Vr+1DxlTFG6Mzd
   oSO8mkMpEERlfqXAB/QEIoGxlbOj/bRl+mZEwGvLvt/gqaKVgNHK0/Lqh
   9CHU8rpa4uXgwuCLtDzk0amU0+DdC/WPwUO0Mosu900RGuXv43N9ZLBCQ
   uH1sRWwscpoaUmjSqME+j0T8CeqtqWclJpEwjASogPSa6kB2yDVaXfLPg
   zBeTXdQp1Tl9WKohwJYvNerqaT7RGAmAtdvCW5Nfq9M8ylpZYrMtwKfks
   /YmZ3WIHo4iekgfSUkcXs3fC+QRWejj6JBJkMCFA9Lh44eR5aqALE52fm
   A==;
X-CSE-ConnectionGUID: V8roMGsgSM6+5WMZBlGH4g==
X-CSE-MsgGUID: 9RSe+39YQBezkEOyOl0puQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28179666"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28179666"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:42:09 -0700
X-CSE-ConnectionGUID: jKnUvbYTRaC+GGPdJaPf+w==
X-CSE-MsgGUID: 4YVanIJ4R0ODcb1kcbf2MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76983028"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:42:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szD5w-00000001rWt-1Wi8;
	Fri, 11 Oct 2024 13:42:04 +0300
Date: Fri, 11 Oct 2024 13:42:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/13]: chemical: bme680: 2nd set of clean and add
Message-ID: <ZwkA_NW3xLi3dxMb@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:17PM +0200, vamoirid wrote:
> This patch series is continuing the work that started on [1] by
> improving some small issues of the driver in the commits 1,2,3.
> 
> Commits 4,5 are refactorizing existing code.
> 
> Commits 6,7,8 are adding DT, regulator and PM support.
> 
> Commit 9 is refactorizing one macro to attribute.
> 
> Commit 10,11,12 are refactorizing the read/compensate functions
> to become generic and add triggered buffer support.
> 
> Finally, commit 13 adds support for an *output* channel of type
> IIO_CURRENT in order to preheat the plate that is used to measure the
> quality of the air.
> 
> This and the previous series [1] started with the idea to add support
> for the new bme688 device but due to the structure of the driver I
> decided that it is better to restructure and improve some things before
> adding extra funcitonalities.

Besides the small comments here and there I think you need to rearrange the
patches layout in the series.

In general it should go in these blocks:
1) bug fixes (if any);
2) cleanups (note, whitespace-cleanup-like are the last);
3) new feature.

Note that PM runtime belongs to the last group quite close to the patches
where you more or less start using it more.

-- 
With Best Regards,
Andy Shevchenko



