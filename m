Return-Path: <linux-iio+bounces-26026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3330C41436
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 19:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14C0B4E7C87
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DA932E131;
	Fri,  7 Nov 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5FGPZ+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A331985D;
	Fri,  7 Nov 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539560; cv=none; b=mfUuWx1x8/XbJZztoh/cSiXkCQmrm57uuOh6rSQPfhyi5eiAzzX47IKWSb6DbqnVcjjC705q+Ya0vnJBdZL5okPm4TBxccFbh6Wo8koYpUwSQs9JiM6Od1jSzrWJG+AcWi+5GzJVHpPAdLa1UjChUy3bed5mJJhDVoXQMkZ6/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539560; c=relaxed/simple;
	bh=mkYsfVEQjaAnNR7HF/dv8lbok/JW0IIU36RYIHbEj4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/9Jsy1OHQcW4Aqs6paOqkdEMYXn1jRAIDlmV6Ha5tAQQvIS+JtmU+gCEVe04UGs2Z5/FysoX1soQZRLHPQSj6EM9rCqVwyxt49KmzDe27lw8aFpfdqxkKYH9DOSL/xvrTmkguIJHyjFmU236mO7qfnNm4hD+n7geu+9mnSK2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5FGPZ+d; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762539559; x=1794075559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mkYsfVEQjaAnNR7HF/dv8lbok/JW0IIU36RYIHbEj4Q=;
  b=e5FGPZ+dbiz2qg3W6E/lDS21t1wvT0ATni66jOzl2dA1kUG3ZmTcQ0nP
   It6cxhIGtRlkE00W/yGeTGE9CJ5aZKUhAzXYr0EK+BJEmuc2TiYXBH/yv
   z4E7J1N+voOUbHPgJyqevUHiRrlN9gr9O5a9Eby9CNaO9oAKVJCcq6rl3
   Lxazf2O2y66i+rqOoWIXEaj5ivO3Bxh3mSQwEsF0cdP8kjEdqLfymEobk
   mwgG9+l+GqhgB0ZfKiTRz3Y6Zt5goQm4x+rlTcU6bWAW4M5B2KCEflEfs
   zblO1iBr4ZcNftU55y+YtHBiteq1IttXoOBuhPKawVFca4Hb2vQToMLEQ
   A==;
X-CSE-ConnectionGUID: pszAQWjQQs+qHwl4N8JqjQ==
X-CSE-MsgGUID: TyeE7XvZTIqqzJWkOrly2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="76143503"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="76143503"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:19:19 -0800
X-CSE-ConnectionGUID: kTJCOPlsTcaVO4hn5KTDEw==
X-CSE-MsgGUID: JtZZqnloSQ6FjZojeunqrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="218840562"
Received: from vpanait-mobl.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.27])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 10:19:15 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vHR3J-00000006XfY-0Ilh;
	Fri, 07 Nov 2025 20:19:13 +0200
Date: Fri, 7 Nov 2025 20:19:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in viio_trigger_alloc
Message-ID: <aQ44IB1b7AXun_qN@smile.fi.intel.com>
References: <20251107020200.6285-1-make24@iscas.ac.cn>
 <9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
 <aQ3NHnL2rF0wkqeo@smile.fi.intel.com>
 <9e96f49f3903f704e16e8dde540507b10a978951.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e96f49f3903f704e16e8dde540507b10a978951.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 07, 2025 at 04:48:03PM +0000, Nuno Sá wrote:
> On Fri, 2025-11-07 at 12:42 +0200, Andy Shevchenko wrote:
> > On Fri, Nov 07, 2025 at 10:26:10AM +0000, Nuno Sá wrote:
> > > On Fri, 2025-11-07 at 10:02 +0800, Ma Ke wrote:
> > > > viio_trigger_alloc() initializes the device with device_initialize()
> > > > but uses kfree() directly in error paths, which bypasses the device's
> > > > release callback iio_trig_release(). This could lead to memory leaks
> > > > and inconsistent device state.

...

> > > > -free_descs:
> > > > -	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > > >  free_trig:
> > > > -	kfree(trig);
> > > > +	put_device(&trig->dev);
> > > 
> > > Yes, device_initialize() docs do say that we should give the reference instead of
> > > freeing the device but I'm not see how that helps in here. Maybe initializing the
> > > device should be done only after all the resources are allocated so the code is a
> > > bit
> > > more clear... But doing it like you're doing just means that we might get into
> > > the
> > > release function with things that might or might not be allocated which is a
> > > pattern
> > > I would prefer to avoid.
> > 
> > The put_device() here is the correct (and must) thing to do independently on
> > the preferences. The problem is that device_initialise() and followed calls
> > may do much more than just some initialisation.
> 
> Well, I would argue against that (at least in the context the function is now
> implemented). To me, the right thing to do would be to move the device initialization
> code to this point:
> 
> https://elixir.bootlin.com/linux/v6.17.7/source/drivers/iio/industrialio-trigger.c#L594
> 
> trig->dev.parent = parent;
> trig->dev.type = &iio_trig_type;
> trig->dev.bus = &iio_bus_type;
> device_initialize(&trig->dev);
> 
> Then we would not even need to think about put_device(). Like it is, using it, it's
> just prone to errors (I did mentioned a couple of things this patch introduced If I'm
> not overseeing it) or we do need to have lots of care in the release function to make
> sure we don't mess up. To me that's a bad sign on how the code is architectured. 
> 
> FWIW, the pattern you find for example in SPI is the natural one for me:
> 
> You have a spi_alloc_device() [1] that initialises struct device right in the end.
> Above it, kfree() as usual. Then the callers, will indeed use put_device() in their
> error paths.
> 
> So the pattern to me is to do device_initialize() after all resources of your device
> are allocated. So that after that point put_device() does not get you into some odd
> handling in the release callback.

Sure, this can be another approach. Whatever you, folks, prefer. But at least
the mutex_destroy() (separate) patch can be issued and accepted independently.

The bottom line is:
1) the current code has an issue;
2) the proposed fix has its own flaws;
3) but the idea in the current approach at least small (if implemented
correctly) and makes sure that any new allocations won't be forgotten in
the error patch, nor in the ->release() callback.

> [1]: https://elixir.bootlin.com/linux/v6.17.7/source/drivers/spi/spi.c#L568

-- 
With Best Regards,
Andy Shevchenko



