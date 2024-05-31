Return-Path: <linux-iio+bounces-5555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970C8D683A
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAC21F21DF5
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8AE17C233;
	Fri, 31 May 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uo4fDUfI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86452E3F2;
	Fri, 31 May 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177055; cv=none; b=qXzBx6EAf4hOkHhn9gavMImPPTC6gmq+KdsrKuGlmH1E0HK7jahIBog/NxPmlGmfLYj2XjfuRXHmMJLUgsYlz1i9Jy2nvuBW3bx/sguKrCNDycI+1jfElz8vlAQ/X8aoz4xlWPahC/53bomTAevPrjG2s1DMX41XNIAOG1fMMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177055; c=relaxed/simple;
	bh=GuxYQS0FYJYGWg1QSsJxVdpzacr59Qf7Z2wjinF8MLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2yzBYT+oeEOUGfS2oaNPSULUml6kfj8E4hnF0KJxundjJxPvPyBSjzjqR78+S4z0gEBgZV4WI7/rA1wqWfXP6WzKSIJtLDNRw7ZhJsTwHFGeVCbvJSifjrHb1u0GDNNdrmSYowmXZDPuRzHEyUORvUsxSE5d0v4AAbuBlphHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uo4fDUfI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717177055; x=1748713055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GuxYQS0FYJYGWg1QSsJxVdpzacr59Qf7Z2wjinF8MLU=;
  b=Uo4fDUfIvMmC2oPYDfruR42U3LQwSFWEI1ryjryOsSUvLm9X0nc0yg1s
   uySMnFn1bxmOTQswR8vXV2xv3GHthJ4JDNcQy3yLg2ebma2fKdniLo9Qr
   80xzbzOhiSr4YZmGWWzXuGd6JECGjUcC3tXpAQhQF/3ro6q8Pn1oy22S9
   tudIGPQ/eXcTeGgsrW9fqUWMuG5aDXhYe0wGmp5TrE2CyQOH2KNWbPAkq
   9+dY7f+cvx8wRwKZYo3iM8IiAqas280POeFkjCml1da+LfcLPed5K1am5
   5CzOQRn2DOvFXJ64JkP9OeUGa7wLspkM81MfoI3D5+mobS0RYoQAoN1vf
   A==;
X-CSE-ConnectionGUID: +abyWSyuTq2ZpXtadCdbDQ==
X-CSE-MsgGUID: 9suSetSTS/i5Ydj1m/paCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13550960"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13550960"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:37:34 -0700
X-CSE-ConnectionGUID: xJGeshXWRVCTzV+VtBlg9Q==
X-CSE-MsgGUID: 6nVCfv0IT5WQ29ga8RtdLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36335914"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:37:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sD6Bz-0000000CXWw-08Pg;
	Fri, 31 May 2024 20:37:27 +0300
Date: Fri, 31 May 2024 20:37:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/4] lm3533: Remove the outdated drivers
Message-ID: <ZloK1hooJ0Wdh0G9@smile.fi.intel.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
 <ZloFgnKC6S2B_oz0@smile.fi.intel.com>
 <20240531171546.GF1204315@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531171546.GF1204315@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 06:15:46PM +0100, Lee Jones wrote:
> On Fri, 31 May 2024, Andy Shevchenko wrote:
> > On Fri, May 31, 2024 at 07:56:12PM +0300, Andy Shevchenko wrote:
> > > Driver is quite outdated from the Linux kernel internal APIs
> > > perspective. In particular GPIO code is using legacy calls,
> > > that started being replaced by a new API ca. 2014, i.e. ten
> > > years ago.
> > > 
> > > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > >  drivers/mfd/lm3533-core.c           | 645 -------------------
> > 
> > Oops, still leftovers: one file and Kconfig/Makefile updates...
> > If needed I'll send a v2, but now I leave it to Lee and Johan to decide
> > the destiny of the drivers.
> 
> Let's not rush into it.  Take your time.

Exactly, excellente fin de semaine!

-- 
With Best Regards,
Andy Shevchenko



