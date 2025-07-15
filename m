Return-Path: <linux-iio+bounces-21661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBCEB05408
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731244A1A5B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF121272E43;
	Tue, 15 Jul 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7aud48H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344818CC13;
	Tue, 15 Jul 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566633; cv=none; b=isN2SykURTZXOhCjrIbfEd4K7qeo3aDmebqrd556kP30Vk4TvCY2pNiIVrodF2Wyr8kbXZsv+G3jedxUaSQy5vnxvId39mSuhXGNALXYaOdoOs+8VFm0OIxxpxJGCcfKt58nykbBxQZ6DMrcyLtpUk4bBFErsiI8F6Fn6rwDbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566633; c=relaxed/simple;
	bh=ccB3g1i+FlT6Refbk3kbcc1DCT4Lzxwfp0JaKJHF5Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub8qNPbVN0dVLhqAlpp7Wn4al5YwhHUh2QfFZbPWAP9DzCqMfwyu6+0E3riepwgFewBFpX2cytBHSLD2ffNoAUNZ7wEhh8kFibs+3qtCf3WGPDljgvrTv5uz+skpV32v+3czMwf2DYq/vPX26CWDL4r80xZoFmEwM6HlqSj0DhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7aud48H; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752566632; x=1784102632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ccB3g1i+FlT6Refbk3kbcc1DCT4Lzxwfp0JaKJHF5Ew=;
  b=U7aud48HZ1iQ/aogQ/Et5aGNEFZq/41/7UxlIa4NLxAv2puxBzsFB1yl
   6aqrHg6aOxoZiXC/hzKhjUNAZvVVrZEvwq9YilzT81Vi1l+KuIAxjSzyo
   V++b5qPjNmnKuSfoNw18SM4nE3dG+9aGwPlvUbnsxAxubJKAa6PNGDdOV
   mueUsYZOhqnmWpZxuF31SJvR/7zwOy2vkgB8HFetXWUx4cHRe6gEScpRH
   516/CAs2zTAW648Zdccsa29E0RAevH7ANhsuHmfhPlvYsvecdqqTZupSO
   44RAMW/VfhWtRzm4XNJ9X+k5Lk6SPnea3QWTJWS8aVuJwOTCw9gr7ZGMn
   g==;
X-CSE-ConnectionGUID: IaMx8ktFTlqT5dNEZNYgiQ==
X-CSE-MsgGUID: bGmL7oZHR0CVHLyBYM0FyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57386373"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="57386373"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:03:51 -0700
X-CSE-ConnectionGUID: ebpOT1OfQk64zDmY82ECKg==
X-CSE-MsgGUID: N+wbQ80uT8SLCep1GK2cKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="161179286"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:03:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubade-0000000Fai5-0CiP;
	Tue, 15 Jul 2025 11:03:46 +0300
Date: Tue, 15 Jul 2025 11:03:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 1/7] math64: Add div64_s64_rem
Message-ID: <aHYLYT57eF6UhLvC@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012023.2050178-2-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 09:20:17PM -0400, Sean Anderson wrote:
> Add a function to do signed 64-bit division with remainder. This is
> implemented using div64_u64_rem in the same way that div_s64_rem is
> implemented using div_u64_rem.

LGTM, but one important Q. Can we (start to) add the test cases, please?

-- 
With Best Regards,
Andy Shevchenko



