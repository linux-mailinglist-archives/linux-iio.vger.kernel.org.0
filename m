Return-Path: <linux-iio+bounces-20477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8389AD5D69
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BD5172F30
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE1224AFB;
	Wed, 11 Jun 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVT/t6Ec"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC82222BF
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664107; cv=none; b=msV/HYsF7I1X0R5PfzPGP0QqV8IDS/xyJC4ps1hxD+64xXqqMBCDvteTE/lgs3b6X+pAOL2zVr9rjtTidAiOUMYJAH/lw1ocyUp3NwlenBe+9Di104l09JzyL1w65pfZgpdLpZaE3P7IxJAcpLPBJ1lxjKIjF+Q/oiMGJt3vKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664107; c=relaxed/simple;
	bh=j3LIxy3Yv2cVe4aA8rPJhA064ZzRU3i95jmXBaNuqwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izmxFAYrMkKCI3kobH3En7epYTWG23iioePxFMHyCrkzc+ysa87IoZTYqiVUSZsOYiPm3XE7AkMMlUtnjYgrT6u1+WwFlH80HxvdIHHmUiSzVtjomPocEQ8rS1CVZt2MboyF3U/CALC7uAJ72hsH1HWJnQsRBSE4qxUb3CAHdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVT/t6Ec; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749664105; x=1781200105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j3LIxy3Yv2cVe4aA8rPJhA064ZzRU3i95jmXBaNuqwU=;
  b=LVT/t6Ec1to2zuOsji1wQwxMc+6k5mRs8KoFVc/KiDC3G7Yf0bonnqCw
   jjZGbJQmc/mwbT5/HqJ3RndclLWr4FdUEZpPue27f3MgBY5v5A4bBvQ9W
   8FPzbFfbzDiIXmDCXD2Q5uQbnPU/LlPpbPoG+WtAHbsta3s8tQJCNclb2
   BtSYhdI1cQCfONuz6U84yzka5OHkP8tAn9Jmnu0IuastynnG4Sbxtv6Zg
   +XrRgowigx9vcegVPfMGBt9ICetTuCxbOfE0sTf7pj0dvioJrkRLgXY3A
   XPmtzH5hdQ/oDdq0ZklA4gLoaTvlbwrVBtrUxF/iM8c4rDagw+vqw50hx
   A==;
X-CSE-ConnectionGUID: wU5NCkeOR3aOYstaNhwPlA==
X-CSE-MsgGUID: fq8Z8ngWRn6bdLagShMU/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63225765"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="63225765"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 10:48:25 -0700
X-CSE-ConnectionGUID: zHTMCpDgTLijR6Ug9JbaqQ==
X-CSE-MsgGUID: gp9JJyqSQFSXWEH9vMElwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147756067"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 10:48:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPPYi-00000005iZu-0VHd;
	Wed, 11 Jun 2025 20:48:20 +0300
Date: Wed, 11 Jun 2025 20:48:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] iio: dummy: Drop unused export.h include.
Message-ID: <aEnBYwaBVKqvIJ2s@smile.fi.intel.com>
References: <20250609070616.3923709-1-jic23@kernel.org>
 <20250609070616.3923709-3-jic23@kernel.org>
 <CAHp75Vdovs=REuauj_zU3V_aw+zUjWY-pKV5sEuayJb9By1JkQ@mail.gmail.com>
 <20250609103905.00004bee@huawei.com>
 <20250611173217.270a3696@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611173217.270a3696@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 05:32:17PM +0100, Jonathan Cameron wrote:
> On Mon, 9 Jun 2025 10:39:05 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > On Mon, 9 Jun 2025 12:27:33 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Jun 9, 2025 at 10:06 AM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >

> > > > Resolves:
> > > >   warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present    
> > > 
> > > While this true...
> > >   
> > > >  #include <linux/kernel.h>    
> > > 
> > > ...I prefer a full and not half-baked solution, i.e. revisiting all
> > > headers and esp. replacing kernel.h with what is used.
> > >   
> > > > -#include <linux/export.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/irq.h>    
> > > 
> > > While doing that, the headers may be sorted (in the same or preparatory patch).
> > 
> > Whilst I agree that more work is need, I also don't like the time it might
> > take to get to it and the warnings that might mean more significant issues get
> > missed in the wash in the meantime.
> 
> After I wrote this I remembered that this is our 'reference' code so we
> should hold it to a higher standard.  So I'll try and come back and improve
> this one sometime soon rather than just papering over the cracks.

Right, I would actually add to whatever TODO exists (written or spelled :-)
to replace kernel.h with the respective header(s) in whole IIO subsystem.

> Given I tend to build with W=1 and right now I'm swamped with pages
> of these warnings I'm really keen to get rid of them in IIO anyway
> and I see lots of activity to squash them more generally.

I am frustrated not less than you, but here we are.

> I'm a bit grumpy that this warning got added without (as far as I saw)
> any attempt to first clean up upstream.

This is not the first time something like this happened. Because it's `make
W=1` build, not many complain.

-- 
With Best Regards,
Andy Shevchenko



