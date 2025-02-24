Return-Path: <linux-iio+bounces-15992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D297DA41A3C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC573BC5B9
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E52512E3;
	Mon, 24 Feb 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0bkq428"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684E250BFD;
	Mon, 24 Feb 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391407; cv=none; b=ChIu1/tz4+JjPAW8Gk84dX2kHOey1WfrUHKeFZ1nlRzXjL/UUeBb3QcwReS6OXuO02js+HHtCytIGEPHaYfNUGyhzp7JJpSqp+p3Tp3NfmrtB3K1lsfe8CAux0pcfsTy8+9buonvG1GMpYnFuExJTufzFPa+/VQ18WiYmL2Kj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391407; c=relaxed/simple;
	bh=KQ22hIAPpKO2ylb4LULSdWfYR5KIsCrd+boJQZ3jYNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg9NPp7gB+AC/m9FrhJzhV8Nu6LDRQbL+wXFpBjqiRsI68BjmmPkA2S9a9/zOS6aT5aNgl+M4yIQ+wl/RAzcGoZbhhjGulM8CkL6FotCcmPoWPJG/YqdMFAgx2Mb9t0L3DK0JIlWqXbWCx8iIQ+a9erOwi0dNilThMWkm0a33FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0bkq428; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740391407; x=1771927407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KQ22hIAPpKO2ylb4LULSdWfYR5KIsCrd+boJQZ3jYNA=;
  b=d0bkq428NtGl3DzqDa3Cs7O2849pUhkY7dPojf8SlBxakyx/tey5vf1f
   USQ1vb00lVPac5WY+PYOhb45jdvP2dKLmfzrANpimbD6K3q8Zb5XEgizI
   cOLtWWKms2xrPkceHxzNmfyR/yC8nsR5xIqd7MLLAtANb6jGXKGTeK0og
   ObFTzb6LuudBgkLb+YKeyP3EYulJHiiLMD+207f7fdlNBS9W+e8LITUoE
   1pzMZhjpEmDN93RksuMo6VSIvPWYMkUkhZ8dAtWVVblPOTytMtP6WmCcP
   KGtpLeesnOE73x03zvjnOc9jqL4usnCy0dLsXgr07+Wfy08qlzYfXG6qs
   g==;
X-CSE-ConnectionGUID: KJjfjTDBQWCcHOysW09lcw==
X-CSE-MsgGUID: iAUwRwQ/QH6hAbXyvxLfWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41050692"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41050692"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:03:26 -0800
X-CSE-ConnectionGUID: uj88UQdMR8SCvxpT/Z2gzQ==
X-CSE-MsgGUID: Cb3A/5pxTMGR+phwiX1iIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121284335"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:03:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmVJ2-0000000Eevo-0M9z;
	Mon, 24 Feb 2025 12:03:20 +0200
Date: Mon, 24 Feb 2025 12:03:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linux pin control <linux-gpio@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] devres-iio-input-pinctrl-v6.15
Message-ID: <Z7xD57sjj4sbwMv5@smile.fi.intel.com>
References: <Z7cqCaME4LxTTBn6@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7cqCaME4LxTTBn6@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 03:11:37PM +0200, Andy Shevchenko wrote:
> 
> Hi Linux kernel maintainers,
> 
> Here is an immutable tag of the "Split devres APIs to device/devres.h and
> introduce devm_kmemdup_array()" series [1], please pull if needed.
> 
> Link: https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com [1]

Stephen reported that some of the commits miss my SoB tag (as the committer).
I will issue another tag with than being fixed.

-- 
With Best Regards,
Andy Shevchenko



