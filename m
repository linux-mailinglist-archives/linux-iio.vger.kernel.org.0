Return-Path: <linux-iio+bounces-5554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EAB8D680E
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4457FB266F8
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3E178CEA;
	Fri, 31 May 2024 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myDf/3Yp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46976176242;
	Fri, 31 May 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175863; cv=none; b=Ude9eOCiZm8bUzfnWZoA2zwkqxYjU2aQYDUfddGoCvB/CAuYrIwL5bYkaX3Hts+eLsPPmxVYVxfhj4fcdKDQsL72ELf4NBKZXMmbWwj8IvC+BDM5jzlwkNNEJKfRom1DxzfmEKaAR4t60fb6C4xTFzJ46k8DcLDt13kTiyT+N48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175863; c=relaxed/simple;
	bh=J9gDH3bKlwWrZve8Rr8EmXrmd2I73nnMrlBHNuPI7IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR8lCDEb7JFqo7BC2twi6dwKxnZ0LTrSFhmYLkthxULghzdM4IrY3A56IdxNsBHRKc8efZz5wrJFv9Ydtf1FurKvxqFJ64D0dM1K7awBX19KnKZSjzMpqHu79UlxXeczgcUWzZb5yyOB4NOsFjCeIXwuq/tW7RpAzNEadA66ROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myDf/3Yp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717175862; x=1748711862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9gDH3bKlwWrZve8Rr8EmXrmd2I73nnMrlBHNuPI7IM=;
  b=myDf/3YppPN/Rtadcg4DzBemmcGTOyAr49fgjauw9IXeqV306312HNgT
   IfeLEBv+HXWeYx7MUt6A+WMB62CdmzHipLfJ7UiJQyT7PslrO7aXWpZMz
   pw3v2pcwCVRGAEx4Bfo/sZL55SyNoUjvox6BA0yCs+9o5zlwL1vt4A3ct
   Y4KX2lSYihA2vhhS7gcq+bfdvEtJgbmpyhXCvNNip1mDcOPV+46IfEIUp
   PVK53XK5UqNmjngWNgDbYAGj82Mm7KjtWNxqc1LvjH72S4AMQ6JxrnZWU
   E91fKszq7X2pwfPukFPp4QWhNw/tm2kJLwvdb9fbkqkWQxOM+E2ofdu4+
   Q==;
X-CSE-ConnectionGUID: vD3bxf57QPWL/X8eT1uuTw==
X-CSE-MsgGUID: Coxu/zwDRcqYWL1hX5YX/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="16681466"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="16681466"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:17:41 -0700
X-CSE-ConnectionGUID: bTIUQv84QRGUIQbKOV3/7A==
X-CSE-MsgGUID: VFQalBeHT6e9S7cQurApGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36682890"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:17:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD5sk-0000000CX1u-1qfC;
	Fri, 31 May 2024 20:17:34 +0300
Date: Fri, 31 May 2024 20:17:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, johan@kernel.org,
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
Message-ID: <ZloGLmlfHIfWfWV9@smile.fi.intel.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
 <ZloFgnKC6S2B_oz0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZloFgnKC6S2B_oz0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Johan (via kernel.org)

On Fri, May 31, 2024 at 08:14:43PM +0300, Andy Shevchenko wrote:
> On Fri, May 31, 2024 at 07:56:12PM +0300, Andy Shevchenko wrote:
> > Driver is quite outdated from the Linux kernel internal APIs
> > perspective. In particular GPIO code is using legacy calls,
> > that started being replaced by a new API ca. 2014, i.e. ten
> > years ago.
> > 
> > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> >  drivers/mfd/lm3533-core.c           | 645 -------------------
> 
> Oops, still leftovers: one file and Kconfig/Makefile updates...
> If needed I'll send a v2, but now I leave it to Lee and Johan to decide
> the destiny of the drivers.

-- 
With Best Regards,
Andy Shevchenko



