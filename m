Return-Path: <linux-iio+bounces-15847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2CA3D9BE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4518D19C06A9
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801AD1F540C;
	Thu, 20 Feb 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4jcDhdd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C561F4639;
	Thu, 20 Feb 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053944; cv=none; b=ox9EfaH2g1+luCMFonnTV2zbEznaKcYuPP1U13poucBq5cSP8TS8q3A0vhi/ZNHniQ214lYIEe18q24eppe5owiIGVg4+au8NHNnj1NT5gEN3ZRPgb1QaBpEYOWQEuY8KgRfG/NLzDpF/MY+cDy4SN9f4ZFNXqyJY3qfJC/2JGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053944; c=relaxed/simple;
	bh=sZUjGnExDTVfIvz3lRvCEq/FudeDOEOaGVJNu1lQZD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCiz89bEl6QufkxnL40jyoIHwc3N8Ptu9OImVYrYjOh5zkLwb+yh4ooKoxuumz221lLuy7njOyNEbX9ql9fB63UEoBkYcVd1n4cEIhzsaEKF1+3/18uIFLIEv1M8svjYcY2d2QgDgDWq5Ip/9ucjWf0QvRNxnut/W3xKnKG81+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4jcDhdd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740053943; x=1771589943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZUjGnExDTVfIvz3lRvCEq/FudeDOEOaGVJNu1lQZD0=;
  b=K4jcDhddRoMNKkkZ+Q6K591CiP07cxq7f468lu3UYO8xqOSPPXtoYAhN
   Bp5m8kAN594hE37AuSZON73+uj7mXbUbC4vS/G1JPFxzHCQ+hItP98BYA
   edbYuRrHdjJvfJr4l63stUY6PBMLFrWP8FVKIBPPVUEJ+UOzCwjwzmq/y
   rIEqJ47M3dXh5IhoNOa6e4pseHp+x4REoC6aS04Lhyv/aMk5+ESjzid0U
   gGRTCD4XfodegXp6rCs5/h9gj9gMfOLYIAFIde65f+RWIswl9dZV0uUHz
   XLaNBgZW9Vh2jqYXUxwFtXFJ4zte19dMFztPqQT3byIQvUtHkmDEhZGSz
   A==;
X-CSE-ConnectionGUID: 6zEvwnK/RqmSr29dreOiIw==
X-CSE-MsgGUID: vo46nBO8QyW+8HoRpoTHJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="41085465"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="41085465"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:19:01 -0800
X-CSE-ConnectionGUID: WYndzkaDRlSpaV5SUfuEfA==
X-CSE-MsgGUID: 7tDPC/dMSw+GORmCOwv1Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115517959"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:18:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl5W2-0000000DKHo-3w7W;
	Thu, 20 Feb 2025 14:18:54 +0200
Date: Thu, 20 Feb 2025 14:18:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Raag Jadav <raag.jadav@intel.com>, arnd@arndb.de, rafael@kernel.org,
	linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
	dmitry.torokhov@gmail.com, jic23@kernel.org,
	przemyslaw.kitszel@intel.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 02/12] driver core: Split devres APIs to
 device/devres.h
Message-ID: <Z7cdrlNjquI_fuFW@smile.fi.intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
 <20250212062513.2254767-3-raag.jadav@intel.com>
 <2025022052-profound-barmaid-dfe0@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022052-profound-barmaid-dfe0@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 12:59:02PM +0100, Greg KH wrote:
> On Wed, Feb 12, 2025 at 11:55:03AM +0530, Raag Jadav wrote:
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
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



