Return-Path: <linux-iio+bounces-27862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A1D332DE
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B638230B76E4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7D2D661C;
	Fri, 16 Jan 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1W0SgWy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694021DE8AE;
	Fri, 16 Jan 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577225; cv=none; b=beC3mONKyJX8McCg8N83xUf4sOKoJD0pA6pj3/nABYz8F4xxdaouzSJpyjcSoj9IWRPGhgZn9WFvGzZb4qa+sYOXlz6+XWE0uP8Qf/SAHXt1QIewYyj8CPEmWOvpgjukN+1YhTIo2GCKLLmUgI/n8kLznhlAV2FsuVTr4DnvMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577225; c=relaxed/simple;
	bh=TBPjZir6bRs6F1JSnlKvHlYgPS6tOywkmB/+jwYMEVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4hR+dn/piZbotnDChmljUZ/SNbPfjWaJ2CW612z8sPNBmD/YAJLdAvZWO+165TDQA4YphveUXuEdn0IvvHTidEENOz08o8mzl5vK5Q/KsFt5LXAharyJrJpdgy8lpzRHMrW/e7n503sLdk7wEKJUj5MayLlLYAZs0EMvKOizdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1W0SgWy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768577223; x=1800113223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TBPjZir6bRs6F1JSnlKvHlYgPS6tOywkmB/+jwYMEVo=;
  b=Y1W0SgWy+GtJbvROS35k7FuEdyMBT22Mpd9hSDe1CBWVLj2LtddKOPyG
   t5DNvJGcVNQw9cgFmbDR77yFCrGryLHujzbPuwgWFGXxGUrWPP4iyBYfG
   Fs5U6acFWDcugFBDg3X4Lh5ERcusSJOHNy81oR3v2U09Y3/nUt9ftyLZs
   JgigYaLTyul5BwIklCdnr50J5MWqeJY/CkphJlSFwZRJmYxuLzmbh8ZC5
   ad76IAqgt0irEUZv+FppLkirZLfQfdriedIhhxBLUvKS+Y3tnzDV2FA4L
   wxrTFYdO+28lglL6qqD/Uw/wnPp/JoxVTg5Ck7pSMJeQAUCXcbSve4/y6
   A==;
X-CSE-ConnectionGUID: +lhqlhzkROi6Ka6USiuZdA==
X-CSE-MsgGUID: /iC+QTChQXe6hOBUNm8Rqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="81261523"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="81261523"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:27:02 -0800
X-CSE-ConnectionGUID: OucHfsTVR76B2OFG0b0wKQ==
X-CSE-MsgGUID: 1bEJyYIJRtaGhsfODJFX6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="205684651"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:26:58 -0800
Date: Fri, 16 Jan 2026 17:26:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 2/7] units: Add HZ_PER_GHZ definition
Message-ID: <aWpYwJUp7Wl0s_Qe@smile.fi.intel.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-2-dbb7d6782217@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116-adf41513-iio-driver-v4-2-dbb7d6782217@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Andi

On Fri, Jan 16, 2026 at 02:32:21PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> New PLL IIO driver supports output frequency of several GHz.
> The new define helps to constraint DT properties and frequency
> calculation parameters.

There is already pending patch to add this in I²C host controller subsystem.
On one hand the conflict, if any, is easy to resolve (the other patch adds
a couple of comments). On the other we are at almost rc6 and it seems DT people
are not happy about something, which would mean that the series most likely
will miss next merge window.

So, the solutions are:
- do nothing and resolve conflicts, if any
- define this constant locally in the respective IIO driver and drop it after merge
- postpone this series to the next cycle (effectively drop this patch)
- ask Andi to provide an immutable branch / tag with I²C host patches
- ask Andi to provide the only that patch in immutable tag / branch, but it
  will require him to rebase his tree

I'm skeptical about last two options on the grounds on how the IIO works and
possible rebase requirement (which is not good to have).

I leave it to you and the respective maintainers to make a final decision.

> diff --git a/include/linux/units.h b/include/linux/units.h
> index 00e15de33eca..06870e9e90b8 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -27,6 +27,7 @@
>  
>  #define HZ_PER_KHZ		1000UL
>  #define HZ_PER_MHZ		1000000UL
> +#define HZ_PER_GHZ		1000000000UL
>  
>  #define KHZ_PER_MHZ		1000UL
>  #define KHZ_PER_GHZ		1000000UL

-- 
With Best Regards,
Andy Shevchenko



