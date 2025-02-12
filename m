Return-Path: <linux-iio+bounces-15440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9376DA32428
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 12:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3301A3A7AAF
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031FC209F3C;
	Wed, 12 Feb 2025 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyVrQVTc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59592271839;
	Wed, 12 Feb 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358065; cv=none; b=frC7spwVwm0xu+r5WZZdQ+4MdYF/Zmq5BATr3aIDPPsYuH8m17LQ1nDRWhY69AXF0e55P88PNYbjCN0hsYbaHLoQy9aYuSXYDcfszNs74BmIri/MFok23GW1rWYoQ2tzShOlucD1CgSZP24/PRxkonloRS0laq3zpG7yWN8tY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358065; c=relaxed/simple;
	bh=kCj1fZ9/HIObnoCleBmU/52edJybLBDJpC1Fuqu6hLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM5KIyfv/8Hplg82h19O3CznBjprGcgk6doSojTL05rdmRKgXxcn/wZdUwIOcbV/7dOVt8DwNORohHdkQ8HlpNLPr3tcQul/UrYGG8KHWyeJy2dqQZShBVLdivDXuoOC8/sCPeNsx0y+/pVhaWRmYj6LC4Ngg/aJwwbHiKdtRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyVrQVTc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739358061; x=1770894061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kCj1fZ9/HIObnoCleBmU/52edJybLBDJpC1Fuqu6hLs=;
  b=UyVrQVTcDTmWRZU3UcfByPFRYAd2hQJv4/1N0SaKEjdp8YZwhUxLj428
   PSSJM3U34Yy1eY8D7POHNYMG70VarPGQTnlIl10D+Zjd8pRn/g68EdZTi
   D/FQLH6IoyTEtdiP2DUTbz9A26m8yb3GnWkMCkLTh/8zmM1Ds77lXxmxy
   vAnk5xm+SJ1c56bwHOXyoLya4ZCmWmxtOK8aMChtDKk/YG35vTgr+v8er
   TPCQ0XHFJRhw3gp5kgj0fsStLSeob64MnNQ3r172gBxmhWoFMbQ49LXu/
   Yr5rACZTKB1fmm0yzj5ph4RgL7kurNsqnn+P4BFQmGBaIlQoT5BJuAAa6
   A==;
X-CSE-ConnectionGUID: 0AgIhbA/R46aEaECUcMjQg==
X-CSE-MsgGUID: HC5K0Z/5Tvm7CFZHEg7Rlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43663913"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43663913"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:01:00 -0800
X-CSE-ConnectionGUID: Oyomb5cqTAWeA1qFlcKwZg==
X-CSE-MsgGUID: BKrLDwDqQSaPZ5CL/DRBUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117969054"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:00:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiAUA-0000000AoOC-3Sz2;
	Wed, 12 Feb 2025 13:00:54 +0200
Date: Wed, 12 Feb 2025 13:00:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Raag Jadav <raag.jadav@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 02/12] driver core: Split devres APIs to
 device/devres.h
Message-ID: <Z6x_Zrt6byWCo1I9@smile.fi.intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
 <20250212062513.2254767-3-raag.jadav@intel.com>
 <4ea5bd29-3d42-440b-bbea-203479116b48@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea5bd29-3d42-440b-bbea-203479116b48@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 07:41:47AM +0100, Arnd Bergmann wrote:
> On Wed, Feb 12, 2025, at 07:25, Raag Jadav wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > device.h is a huge header which is hard to follow and easy to miss
> > something. Improve that by splitting devres APIs to device/devres.h.
> >
> > In particular this helps to speedup the build of the code that includes
> > device.h solely for a devres APIs.
> >
> > While at it, cast the error pointers to __iomem using IOMEM_ERR_PTR()
> > and fix sparse warnings.

...

> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thank you!

> Splitting this out makes a lot of sense conceptually, though
> I don't think it will actually help with build speed: In order
> to see real benefits, we'd need to remove the linux/device.h
> inclusion from other headers that are frequently included,
> but those don't really rely on the devres interfaces.

Yeah, that's just yet another baby step to the right direction, but it won't
change picture if being alone. I already did a number of patches to split
kernel.h and removing it from other headers, but a lot of work is still ahead
and it's not my hight priority task...

-- 
With Best Regards,
Andy Shevchenko



