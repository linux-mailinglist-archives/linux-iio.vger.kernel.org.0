Return-Path: <linux-iio+bounces-18566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849FFA99575
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3910E9244C1
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118CA28368C;
	Wed, 23 Apr 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4QHybd0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F427F75E;
	Wed, 23 Apr 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426055; cv=none; b=CuTlSsg+BTX4yx/C5YneD9YLL4cVHIv6JNF+9GqZwJR4GRak40xWaTcyn+9IkWICyt0BxoOhGeXRGZpA096U6xduG0IATeduDBOufZc0zbLcXaDzdc4YeeIFpX2fAqq6IG8wLXw2MzBEfebM4tnla5P9OM1a37OctU5EaZaWVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426055; c=relaxed/simple;
	bh=4IABLfHu/yqmZlVKCfx0mHLz4kNwMyvzzMrqaMMK+yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPSDpAxOP//Gaeh0Rd5vMw0/doEz7Twi5hXuQt7ZCdfm1GrrbJ0L0WQP+wHBPZeq58Ny6+yZu/lGIRkYqURaWjRxkzDGoKwV8qc2xl7dwB15xUie/mXu8YneVmWJWAFb5NJdCWJIp6F5r/pOebl0HreWbqPmyEfVmbFEhvxr9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4QHybd0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745426054; x=1776962054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IABLfHu/yqmZlVKCfx0mHLz4kNwMyvzzMrqaMMK+yM=;
  b=C4QHybd0vlTWYDDsFGK6/VRSgju95FxEJJFsaRQePzPyw7ZfDAqNdpv4
   8+rRt77QZy0BBKBxyCjuJ1B2BxJx1UBgLw5S3XTv/5tzpxTA4LCVCvtUJ
   ef0XDMmM43UsOwICFnvhmUZgIWpX+j0N/3JIoSuFxIHL6NvWOsNMIPc2g
   Ea7E9jO9EwBT2gX8hYGV7wytUiNGbnbptvXDcmyBFHNSxb+pVvFhr5HaD
   KQDmpPu5xZOiAohlomu7rO8dMvd34NLAE+XFA+BS4VRWa0pGHk56eFacZ
   MbF/6nxozEIkSf/1rOFqOP+ocQ2Ov7x6OzDtuPKZ0MLiI3gT2keWp81MQ
   w==;
X-CSE-ConnectionGUID: 2WaW1sc3SpmkdzPglUYIJw==
X-CSE-MsgGUID: pQrqnXPaRKyECEJxpKqufQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50692769"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="50692769"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:34:14 -0700
X-CSE-ConnectionGUID: xprhH5xZQjG6bqcRwUBynw==
X-CSE-MsgGUID: URoCKcguQf+EJCQQFo3lew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132884532"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:34:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u7d32-0000000F7IV-0t3M;
	Wed, 23 Apr 2025 19:34:08 +0300
Date: Wed, 23 Apr 2025 19:34:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org,
	Lukas Rauber <lukas.rauber@janitza.de>
Subject: Re: [PATCH 1/3] iio: adc: mcp3911: fix device dependent mappings for
 conversion result registers
Message-ID: <aAkWfw_csgBpU6w_@smile.fi.intel.com>
References: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
 <20250423-mcp3911-fixes-v1-1-5bd0b68ec481@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-mcp3911-fixes-v1-1-5bd0b68ec481@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 23, 2025 at 04:46:49PM +0200, Marcus Folkesson wrote:
> The conversion result registers differs between devices. Make sure the
> mapping is correct by using a device dependent .get_raw() callback function.
> 
> Fixes: 732ad34260d3 ("iio: adc: mcp3911: add support for the whole MCP39xx family")

> 

Shouldn't be blank line(s) in the tag block.

> Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
> Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

...

> +	*val = sign_extend32(uval, 23);

With that, replace bits.h by bitops.h at the top of the file.

-- 
With Best Regards,
Andy Shevchenko



