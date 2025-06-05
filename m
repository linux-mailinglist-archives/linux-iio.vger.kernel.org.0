Return-Path: <linux-iio+bounces-20232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E187DACE9C2
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 08:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480F91898BB0
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 06:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C31DE8A0;
	Thu,  5 Jun 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V68yeE4u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628E1C8601;
	Thu,  5 Jun 2025 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103583; cv=none; b=j5d+UsQpJp3QdG6VrVhGeQQqozevDRRRVtWFWYrGjhfxuZ5KKO4M2I677n1yvb6GA6J6H/Cw6hXL7BhCrkBkPf6LvVLd7Aw3O512t/dlvCmIDjjYa4RcCwG+8M56awu9+Cu5U6QPJ8AmdMx4URYU3T/pRxU+TaqOn3ALwiUaHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103583; c=relaxed/simple;
	bh=Ktzhq4fVsKEWiMOkF+2uTaOey3+lr5ajT6Ebq/4uTXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXlfCMKmWcUoVBMVeHsg5ORSU9Lkzgf4OCdw4Kc6dPMamIo2jzfc44VjvHw877bTYZrkM+4GvaKsxJwc3q6F4Ag2JEx6N8VLcPRR6RoilrmTEyTlL49dMQezU8fru72X01R1QJdnkYUGJkWoSKUlrl/b1actyKtlPO1glommmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V68yeE4u; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749103581; x=1780639581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ktzhq4fVsKEWiMOkF+2uTaOey3+lr5ajT6Ebq/4uTXo=;
  b=V68yeE4ugat7mogncat/GEpX+xZyAFxifnAyBxikt1kPPNchKW8vcVS/
   u9YkVwGKYgZLd2sW7yXGkyC5KcXh7Kcpv7Z1tWUFOkvU1Yss38wc2NJl0
   hlkYBpzZAxNMpaV1fAUTRHC0j+F/0tlH92sKkbBfEyP/0rpgFYvlGMATG
   y2xd0qrjjcI3qOJMLubgJxAONpy//JTlNDgABJnR8E9upI5BtZD0ctZJz
   oDSqoSyDxfcqgHRGhlusgBNUo73MmkmZYagbiSgUqulZOlBQ8eHNXPx21
   fNsbzK5u93xqHA8iZenc48667Tc4hjrRE2uGkVh88ZP3zzJzfoIYpVR2T
   g==;
X-CSE-ConnectionGUID: h9QS89yfS/m0Ggk8jIBNLQ==
X-CSE-MsgGUID: VjaRtC8eQ/KMbs5PNqQOCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="68645220"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="68645220"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:06:21 -0700
X-CSE-ConnectionGUID: gTM/7DNhT4+4yuad8s9pUQ==
X-CSE-MsgGUID: sS81EJFBR/SKefZQkVYCMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="145749493"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:06:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uN3jx-00000003mCp-0RIo;
	Thu, 05 Jun 2025 09:06:13 +0300
Date: Thu, 5 Jun 2025 09:06:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 08/12] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
Message-ID: <aEEz1ORQAUBDGHoF@smile.fi.intel.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
 <badd5aafc1be4a264dc5d7c46bfc9e502d6b37db.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <badd5aafc1be4a264dc5d7c46bfc9e502d6b37db.1749063024.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 04, 2025 at 04:36:56PM -0300, Jonathan Santos wrote:
> When the device is configured to decimation x8, only possible in the
> sinc5 filter, output data is reduced to 16-bits in order to support

16-bit

...OR...

16 bits

> 1 MHz of sampling frequency due to clock limitation.
> 
> Use multiple scan types feature to enable the driver to switch
> scan type at runtime, making it possible to support both 24-bit and
> 16-bit resolution.

-- 
With Best Regards,
Andy Shevchenko



