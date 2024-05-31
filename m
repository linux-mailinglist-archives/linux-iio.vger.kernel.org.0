Return-Path: <linux-iio+bounces-5551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEBA8D67F2
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B641F25404
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0517176AC0;
	Fri, 31 May 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFepZghH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982E176242;
	Fri, 31 May 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175691; cv=none; b=coloIjIezDcAZqHDux158zVGgGdYvBkgFaL5N0rO7fqri3x/aCqlAN5yads2vqARAY247n3N2CZk7dzUwbXjkDdLXifJwJz+xhOHR5QblgeyQhR8sDRTj/yXtMAp7BnDZePsSYcjWKR2E+a3FsoFLHXo5w8aJ6WGbtyclM6iws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175691; c=relaxed/simple;
	bh=Ra01TUqafQnueHY+6XA0wN/bRJPiiyyn14ikUAWapRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXR3+Xz2cvlz2knfp3hwiYjXpN366MKXadrLjaqBoz/fVqf1weEzYMdHwYCgQMtH1fD8B5cfLdoyKFvJk5JINGM/E10sveiHJVeuX1D6LrEfI7As9Jf/qp6xkwUXfnqLv98325vAFs+3sf3wDu5w29EFcWdw1O8UGMrGgfBqg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFepZghH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717175690; x=1748711690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ra01TUqafQnueHY+6XA0wN/bRJPiiyyn14ikUAWapRE=;
  b=BFepZghHER6q+5lFdMaN/NajI717UvdoFn3DqTmyS4wQdJ7sWj/9gpId
   ds0vjst2Jvmz6LcAhGe1LvfmbLo7SWi4UvXemAyufGoQLZjXvGgLChSHn
   8KRinoHdZJurf4s3/nloS78vkLN865HXaF4n5YzTC8pOtaUyItaPG0N+I
   sftYUghTzUGaMaRZPa2jaF8Vyol76dwCbxBWe3oF4k6ZShadtpWJEtBpH
   YFmkAkRPWJmLOXR9Gh8KmXXtBpPL76k0z9pafWZvJFDsvE8QNxZtOzoxL
   o0GrOxbvUCpGQYfGU5kwXngmKe25tXpz62OiAj6V5WqcFVhOJ2oHrfzYK
   A==;
X-CSE-ConnectionGUID: W53IJRmrTCS91Q69NJz/6Q==
X-CSE-MsgGUID: zd8WgUCpTrafMAaja5jSQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="25132698"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25132698"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:14:50 -0700
X-CSE-ConnectionGUID: E/+p99EhQ9+QCIkTiyw7ew==
X-CSE-MsgGUID: ggGG2oTZQ1WH2UHHIsef6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36149369"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:14:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD5pz-0000000CWxo-0rLw;
	Fri, 31 May 2024 20:14:43 +0300
Date: Fri, 31 May 2024 20:14:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/4] lm3533: Remove the outdated drivers
Message-ID: <ZloFgnKC6S2B_oz0@smile.fi.intel.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 07:56:12PM +0300, Andy Shevchenko wrote:
> Driver is quite outdated from the Linux kernel internal APIs
> perspective. In particular GPIO code is using legacy calls,
> that started being replaced by a new API ca. 2014, i.e. ten
> years ago.
> 
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>

>  drivers/mfd/lm3533-core.c           | 645 -------------------

Oops, still leftovers: one file and Kconfig/Makefile updates...
If needed I'll send a v2, but now I leave it to Lee and Johan to decide
the destiny of the drivers.

-- 
With Best Regards,
Andy Shevchenko



