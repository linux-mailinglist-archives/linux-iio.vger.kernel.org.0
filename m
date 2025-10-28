Return-Path: <linux-iio+bounces-25553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A8AC137B8
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E10050804D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399CC2D46D9;
	Tue, 28 Oct 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyC2WDhE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAC29E11E;
	Tue, 28 Oct 2025 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639032; cv=none; b=KVP4+VKrXkqSgLLvnyazUHcFoAk7xO03kQNA0E2WFt/EI4k7K6ke5dOE/3srn8jBN6F8YsJuVTel6Z9wC69srCKwITbnHB7/qBxCagQa17oUAYEOEvv34rn0XaabMOFM9FnUPwWtgUXrAlpGItErnbJgpKXlzQgdbFVZpK4mNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639032; c=relaxed/simple;
	bh=CCWns77OmOt4vjojJJ4+7pxoDkV1iHGduGsfXfkZa1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxEBHQV8RvYg6gD8hdCamD1JX+ys+VlkbD8RkkIHdghUc5sIYl4f5/eMyW2v2686BMMnX6hw7pQmJ/rsx2Mml8Vu9ZdSji9r70QXQQoP/279to+qWoNXt0EGcKpX9tSwKoG8Mi67Cxe7k+j3OLMYQVUYi5OC6eLaYRFeV5AgMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyC2WDhE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761639030; x=1793175030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CCWns77OmOt4vjojJJ4+7pxoDkV1iHGduGsfXfkZa1g=;
  b=ZyC2WDhEtTf3dy11f6dOSj/lRbLgLmdUmn0enlouZiUZlsZQ5EvxEIHz
   LzSbIR+QFBHCr340drKs3Fse6UL/vsYxioGce9Wb2OUb7apzYrKj+o9H0
   9bpt07w9KpiRC5sNy4qZtMybW4ZBxxEK/yUWk2wTQH5HjgvxW/xdlbBu7
   YU3a5Fl/IX+hB+7B5YwVnJ/IngFIGDpIkRgz76D60NANhCMq3s1qKAhmb
   i8GQ4yI1F0kWZUEOJPxkC9fElrKoPxZUwA4TN6zbwk4QyXEr7tdmctTkL
   FhCf5R0KzGErsv42C5Hw9N9x8qp8Ulyfdu6DuD0koXtij/AnBfvfpx0X+
   g==;
X-CSE-ConnectionGUID: NvEL/5+8TjKCiNSECvdTPA==
X-CSE-MsgGUID: 1vrPLTUnRKGgD3tdixyGyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63769181"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63769181"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:10:30 -0700
X-CSE-ConnectionGUID: /VdNS5MmR4eLlYiGyoT2Ew==
X-CSE-MsgGUID: lWLXbDHWSW+9gYBHKRgDSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185366413"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:10:28 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDeme-00000003FJ4-1WAR;
	Tue, 28 Oct 2025 10:10:24 +0200
Date: Tue, 28 Oct 2025 10:10:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gary =?utf-8?B?Q2h1KOalmuWFieW6hik=?= <chuguangqing@inspur.com>,
	lars <lars@metafoo.de>,
	"Michael.Hennerich" <Michael.Hennerich@analog.com>,
	dlechner <dlechner@baylibre.com>, "nuno.sa" <nuno.sa@analog.com>,
	andy <andy@kernel.org>,
	"subhajit.ghosh" <subhajit.ghosh@tweaklogic.com>,
	"javier.carrasco.cruz" <javier.carrasco.cruz@gmail.com>,
	linux-iio <linux-iio@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: light: apds9960: convert to use maple tree
 register cache
Message-ID: <aQB6cFpTsBssGej3@smile.fi.intel.com>
References: <abf45488369cbcce6298cc0ea19c0b3a24-10-25intel.com@sslemail.net>
 <aPs9HdeTZKoqFqdk@smile.fi.intel.com>
 <68fc4591.1.gk94qBPVZajhk94q@inspur.com>
 <aP8tvj_IPbv65m0T@smile.fi.intel.com>
 <20251027133806.5e4368bc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027133806.5e4368bc@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 01:38:06PM +0000, Jonathan Cameron wrote:
> On Mon, 27 Oct 2025 10:30:54 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Sat, Oct 25, 2025 at 11:36:45AM +0800, Gary Chu(楚光庆) wrote:
> > > >On Fri, Oct 24, 2025 at 03:38:23PM +0800, Chu Guangqing wrote:  
> > > >> The maple tree register cache is based on a much more modern data structure
> > > >> than the rbtree cache and makes optimisation choices which are probably
> > > >> more appropriate for modern systems than those made by the rbtree cache.  

...

> > > >>   .reg_defaults = apds9960_reg_defaults,
> > > >>   .num_reg_defaults = ARRAY_SIZE(apds9960_reg_defaults),  
> > > >
> > > >^^^^ Be careful with such cases, the cache implementations may behave
> > > >differently. Have you tested this on the actual HW?
> > > >  
> > > We have conducted tests on some hardware, and performance improvements were observed,
> > >  though tests have not been carried out on all hardware models.
> > > Neither rbtree nor maple tree directly depends on hardware types (such as CPU or peripheral
> > >  models). Instead, they rely on the address distribution characteristics (discrete/continuous)
> > >  of hardware registers. The optimal cache type is determined by the hardware layout.
> > > Red-black trees excel at individual operations on discrete addresses, while Maple Trees are
> > >  proficient in range operations on contiguous addresses.  
> > 
> > It's not about the low-level cache implementation, it's about regmap
> > abstraction implementation that might differ from cache to cache
> > implementations. This all in regard how the cold cache is getting filled up.
> > There is a separate discussion (unrelated to the topic of your series) where
> > this was brought up.
> 
> I appreciate these things can be hard to track down with lots of threads in flight
> but any chance of a reference for that? I'd be a little surprised if these uses
> are complicated enough to hit corner cases but would like to know more.
> I've taken a few similar changes in the past thinking there would be no
> practical difference.

Sure, it appeared in the discussion of v2 of the following patch:
https://lore.kernel.org/linux-gpio/20251009132651.649099-2-bigunclemax@gmail.com/

> > That's why I asked how this was tested.
> > 
> > In any case, up to Jonathan, but I had to rise a potential misbehave, so in my
> > opinion this kind of corner cases needs to be tested on real HW.
> > 
> > > >>   .max_register = APDS9960_REG_GFIFO_DIR(RIGHT),
> > > >> - .cache_type = REGCACHE_RBTREE,
> > > >> + .cache_type = REGCACHE_MAPLE,
> > > >>  };  

-- 
With Best Regards,
Andy Shevchenko



