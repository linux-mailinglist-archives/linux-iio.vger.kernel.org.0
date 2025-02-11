Return-Path: <linux-iio+bounces-15333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4FAA30825
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 11:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385A8167A86
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524E11F429C;
	Tue, 11 Feb 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNSJepYh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DD1F238B;
	Tue, 11 Feb 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268716; cv=none; b=AtY35BsLbhHsSvPBLoFH8O1zRHfa2hm+e5MQxSxZxlYcuUyUpWUtNAR33Led7gNYF51aSoTvsxYHiI2ecEdmNwks9PLFyfaSPmb4OdJ4v5JjoorotMjFWiPLMwXNkSYEuZh7ZQ9M9LOYNyfvH9WhEugngcmraPLPbRAZr4kyxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268716; c=relaxed/simple;
	bh=9UxzOfozxDl6zQSlPurGbPQQW3VYnw+4If1eY2vVTG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0EINzM2uymbdBCmx0W1CLx1f5PUenRWqy9GAClkz0ng0poria/EamCRqIhQUBeLY1SWPS2+3TBTy/FiLbPNs3VPrPjbVXIFgAsh/34HK+FmF44MF7W03YEShbkHjaRJsfkylbP7sWYKEbaw2yh2Roz3HhRTerE/wCqgiUopj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNSJepYh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739268716; x=1770804716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9UxzOfozxDl6zQSlPurGbPQQW3VYnw+4If1eY2vVTG8=;
  b=aNSJepYhpHpRJa4EWWZKEbGF2R/4ZjmIkDHP65STjvFfw6gFzw/XzJ+o
   hIzr+7eb1J0uB5cwwtIx9WSHZHOTGQbf7XNwOJ5qK+3WGMtZF3MMJb87Q
   vZVJODKaLxdJ5t+dskslonRnIBu7maYroHBeWT0nw1eoPGC8XgHDBzpVc
   R4DjHgEulvCzRF3jAQHTpEPQwV2JSSaASls/ugkFnPHZpItFXfjoPvbqs
   TTucp6gaU4T2ZstUY4+Cz4M6XfaLKkX09in5thLrp3QPuubU2fK1x9p1W
   4IVK5P5Z/iLdHQLs1kSkK1uf63JM2ORDVjakYb+d0TNMNbMYzMuebjDG7
   Q==;
X-CSE-ConnectionGUID: O1l/si9BRfSs4igHXoWabQ==
X-CSE-MsgGUID: zrC0JyUuS0+lwJ4iexL+Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="62350289"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="62350289"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 02:11:54 -0800
X-CSE-ConnectionGUID: Tj+PRwGYTTyFZfHlBwt0dw==
X-CSE-MsgGUID: f0AhNuSQQFuE55W/EyJkfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="117552655"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 02:11:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thnF4-0000000ASzb-3hWk;
	Tue, 11 Feb 2025 12:11:46 +0200
Date: Tue, 11 Feb 2025 12:11:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, Raag Jadav <raag.jadav@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, lgirdwood@gmail.com,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to
 device/devres.h
Message-ID: <Z6siYlWfvfUvNLpX@smile.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com>
 <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
 <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
 <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
 <c1184a91-e216-423d-b956-d4b22116a171@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1184a91-e216-423d-b956-d4b22116a171@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 10:39:16AM +0100, Arnd Bergmann wrote:
> On Tue, Feb 11, 2025, at 10:27, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2025 at 08:36:47AM +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 10, 2025, at 16:23, Andy Shevchenko wrote:
> >> >
> >> > TBH I have no quick idea how to address this. It seems that io.h 
> >> > includes device.h
> >> > for no reason (but I haven't checked that carefully). OTOH, we need only
> >> > IOMEM_IS_ERR() definition which can simply be moved from io.h to err.h 
> >> > as the
> >> > former includes the latter and the definition depends only on 
> >> > compiler_types.h.
> >> >
> >> > Arnd?
> >> 
> >> Removing linux/device.h from asm/io.h is probably the right step,
> >> it really has no business in there and no other architecture
> >> includes it. I don't see an IOMEM_IS_ERR() definition, do you 
> >> mean EEH_POSSIBLE_ERROR?
> >
> > The definition is in the generic header and patch here relies on
> > that definition to fix the sparse warning. The simplest solution
> > is to add another patch that simply moves the macro from
> > linux/io.h to linux/err.h.
> 
> Ah, IOMEM_ERR_PTR(), not IOMEM_IS_ERR().

Oh, yes, sorry for the confusion.

> I don't mind moving that if it helps you, but don't see what
> the problem is here. Is this missing because of a circular
> #include list with linux/device.h including asm/io.h and vice
> versa? If that is the root cause, then I assume there will be
> additional problems either way until the loop can be broken.

I don't see how. io.h already includes err.h, so whoever includes io.h should
have that as previously.

> >> Most of asm/eeh.h probably shouldn't be included by asm/io.h
> >> either, my guess is that we can get away with the
> >> eeh_{s,}{b,w,l,q}{_be} helpers, eeh_memcpy_fromio() and
> >> eeh_check_failure(), which have no dependency on 'struct
> >> device' in the header.
> >> 
> >> Removing a giant header inclusion from another one likely causes
> >> build regressions in drivers that should have included the
> >> header (linux/device.h or something included by that) themselves,
> >> so ideally there should be some separate build testing of
> >> powerpc kernels.
> >
> > I believe this might be far out of scope for this series due to potential
> > fallouts here and there. But would be good to have it separately.
> 
> It certainly gets towards yak-shaving, but it does look like
> the best solution. It really depends on how much breaks -- if there
> are only a couple of missing #include statements, I can see those
> get merged early as a bugfix or as part of another series. If there
> are a lot of them, it is probably not worth it.

-- 
With Best Regards,
Andy Shevchenko



