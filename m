Return-Path: <linux-iio+bounces-25918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B7C36382
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 16:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A801A2002D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1E32E14C;
	Wed,  5 Nov 2025 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j57Zi0tD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AF261586;
	Wed,  5 Nov 2025 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355266; cv=none; b=tsijsxN/H2mc5PVinKMD9SyVheTuf4egR/lW3Re/7UXdTL6Bzwv+sa4MiqFDKqBjR1jedpgJL8w0FyzzDj79jYvPy4SwUwcgRopbMvDdm0QWJtPFSd+qugJNHlQP1qR/BVeDXLycnBhIeU/w1NyCDr1G4L0Vx6rVsP1pCuRdk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355266; c=relaxed/simple;
	bh=nUUs4jhKwwCK1L3CytSuHrkC1iNzMvTnzVOytdS56OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn7mKj4mx1apfiQbo6Rov1qalgloaWDmryMfnnCtyoI8fAyTfeX62N0yF7X1DqRZoq5azeQhUMJQSsSju4rLW7EmuRPQaAL1vHmne0ILaI5ccMXV+It3aioV+N3y+4/avXFATnh/zZvxNbrlVkziq3g6nec6KAecSEunVUZTWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j57Zi0tD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762355265; x=1793891265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nUUs4jhKwwCK1L3CytSuHrkC1iNzMvTnzVOytdS56OM=;
  b=j57Zi0tDx3guibTKwWjztcTrxpb695m3rvgUKQVunh0p5ln0zn2lCck9
   tdar+tUuRkzfaiHYkjeHGN00sjE7t0HRAyvEyDZvHxRx9gpKbzhuu/xh8
   UMRF5x1+fFQ17iuPm+cHG7RT7qA57eWVTnuAr3WTny+uGhUQomg5ErEQM
   GDYhzdnFBo4tB4dWt8WzSY/jFyNauzE2sQVKnCPMuhSvwzYqUhqfsZsuY
   gJuLCeunfZ/dTUg8Lx0yQNDnEvzzi6WFPGwFNfAZg98fwLKiKuNxs4hFJ
   VsUOfDrljZjUMXaBDOoO/9MVfcdMC1sCqb6oJvfmq2f9JCUO8eODgSa5k
   w==;
X-CSE-ConnectionGUID: EQDVgzQRQzOrM0kgogBdHQ==
X-CSE-MsgGUID: 9PRV8MPLS2iKVJOln9/tSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75921624"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75921624"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:07:44 -0800
X-CSE-ConnectionGUID: kf0gm5hjQveOWN6t/wMl0Q==
X-CSE-MsgGUID: Z1I4Gq+BS8i3ehDCq6fqyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="191837469"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:07:41 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGf6m-00000005ow3-3Lz7;
	Wed, 05 Nov 2025 17:07:36 +0200
Date: Wed, 5 Nov 2025 17:07:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, error27@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix error handling in viio_trigger_alloc
Message-ID: <aQtoNxBstUI-c6qp@smile.fi.intel.com>
References: <20251105094714.28117-1-make24@iscas.ac.cn>
 <aQtnfzUKHc0fY52_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtnfzUKHc0fY52_@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 05:04:32PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 05, 2025 at 05:47:14PM +0800, Ma Ke wrote:
> > viio_trigger_alloc() initializes the device with device_initialize()
> > but uses kfree() directly in error paths, which bypasses the device's
> > release callback iio_trig_release(). This could lead to memory leaks
> > and inconsistent device state.
> > 
> > Replace kfree(trig) with put_device(&trig->dev) in error paths to
> > ensure proper cleanup through the device's release callback.
> 
> Now when irq_alloc_descs() fails, trig->subirq_base becomes negative and
> in the release callback it will pass the
> 
>         if (trig->subirq_base) {
> 
> Is it a problem?
> 
> The release function also misses mutex_destroy().

Ah, and if kvasprintf() fails, the error path will call irq_free_descs() and
then one more time in the release callback.

You finding is good, but the fix needs to be crafted thoughtfully.

-- 
With Best Regards,
Andy Shevchenko



