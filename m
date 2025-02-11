Return-Path: <linux-iio+bounces-15339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CFA30B62
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 13:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B862718828EB
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74832214A92;
	Tue, 11 Feb 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTmtaVyF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EE2010E6;
	Tue, 11 Feb 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275865; cv=none; b=iWnvs5MPcHUfNuitYfeUL8H6GA2wfv0iRqdYh8BPlxlqJXpUA65ZC9gBctBXLIH71a696ACv6jHKQ+zAQU58RuP4PotNDpdy9pKxBnQrXHfQDSAXTDjigzfVorATPusRZTF5M6ZOGwzRNQQ9DT472d1iq17zUoYq7fawkbpbrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275865; c=relaxed/simple;
	bh=dVa1v4FEnhdEcRKHgQOjoXmm0Uba3dBOZT5OrGPkID0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGrF8EvVrQGhV9sDYG/15CNszsF0/+P5oHjZUC7HzV88pia+ItMmdkAhWlJhM9Zl4mHMTvWBF8fY9GyXHM9o4xNDabWTexp6BFgXLLJiWXo1PgR4CCO/9I76ax9xr/8z+CEeRhmWs2nBxM00Vn9DkeCVBOwTkT6YRM3PbiqkbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTmtaVyF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739275862; x=1770811862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dVa1v4FEnhdEcRKHgQOjoXmm0Uba3dBOZT5OrGPkID0=;
  b=UTmtaVyFUY97Ydf7r/N8wWj92mNEZd4ajF/ZcIFPGNYOmYSu/fiZzXlT
   nZ471/QyuD7sWsWD6Dtq0Axi+wfNCs9BPD8jVweJUK7Qao1B0qK22YEBU
   9CzxVZB8CsRrD9sBAwPSQ2s7MnlLKv5/gtOLCKdGg6kc6u/4kVfYz1lIz
   3ELumAaOQB10LpV1wcCSt7NUZrw5xWB2DMPX4NNE1UC+cP0hy3Y/z6fQ2
   9cTR0e/h1xma7mmOQuMPLI3FRqWuVJ8JaYhGs+ElJxVhP8bUf2HhySuwy
   mMXRdcKSETK2QVB5MUQWQknGtm0j5wovkcou2tTj00nu0Y2lSB1ZWjveq
   w==;
X-CSE-ConnectionGUID: vNd8oQahQmujvx4TI3s46Q==
X-CSE-MsgGUID: TQLBJ/26RwS3V/2x8hAdcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40009046"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40009046"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:11:01 -0800
X-CSE-ConnectionGUID: 1c0JZ1woQzWllJevK0qSYw==
X-CSE-MsgGUID: vEphLevZRnyj2ZPdgjfSpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113390239"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:10:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thp6K-0000000AUm6-18UE;
	Tue, 11 Feb 2025 14:10:52 +0200
Date: Tue, 11 Feb 2025 14:10:51 +0200
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
Message-ID: <Z6s-S67MdpVrXRji@smile.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com>
 <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
 <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
 <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
 <c1184a91-e216-423d-b956-d4b22116a171@app.fastmail.com>
 <Z6siYlWfvfUvNLpX@smile.fi.intel.com>
 <279d9f32-a1c9-41aa-b15a-e1485877b2d5@app.fastmail.com>
 <Z6s2cGMM9R6SZ9Le@smile.fi.intel.com>
 <49396042-31f0-4d8e-aa54-d89093ab5709@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49396042-31f0-4d8e-aa54-d89093ab5709@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 12:56:11PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 11, 2025, at 12:37, Andy Shevchenko wrote:
> >
> > The problem this series solves at the beginning is that not all the consumers
> > of device.h needs it, in many cases the device/devres.h (or subset of
> > device/*.h) is enough to include. While solving this, it appears that
> > the current code uses ERR_PTR() instead of IOMEM_ERR_PTR() in devm_*io*() APIs
> > and kernel test robot found this and complained about. While solving
> > this new issue, LKP found another issue that is circular dependency.
> > But the original code only wants to have an access to IOMEM_ERR_PTR() which
> > is in io.h and can be moved to err.h AFAICS. Does this sound reasonable?
> 
> Yes, that sounds fine to me. I agree that not including linux/io.h
> from device/devres.h is a good idea, same as no longer including
> linux/device.h from asm/io.h. Moving IOMEM_ERR_PTR() as you
> describe is the right idea.

Thank you for confirming the idea. Raag, please follow as suggested:

Move IOMEM_ERR_PTR() to err.h (perhaps in a separate patch),
and drop io.h from devres.h as it will be not needed.

> Side note: I looked at large-scale header file cleanups in the past,
> and in general the result of that was that the best way to reduce the
> indirect inclusions is by splitting data structure definitions from
> inline functions that use those data structures. The definition of
> "struct device" clearly has too many dependencies, and to make
> this one better. There has actually been some good preparatory work
> done by Kent Overstreet a while ago that moves structures out
> (e.g. work_struct and mutex), but not yet struct device and
> struct kobject, which are needed in many other headers. The tricky
> part that needs to happen to actually make it useful later on is
> to replace all the unnecessary indirect includes with the minimal
> ones, and that is a huge amount of work.

Good to hear that somebody is working on the dependency hell untangling.

-- 
With Best Regards,
Andy Shevchenko



