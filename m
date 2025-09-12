Return-Path: <linux-iio+bounces-24031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E92B555D9
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FF21CC3C80
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CF6326D4A;
	Fri, 12 Sep 2025 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIyZ4r01"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFF302CB2;
	Fri, 12 Sep 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700485; cv=none; b=rmEchUMe7G4xPstM9NLnkfL45Uk+yFnIJCoI88sbyjdtIsog7kqWVxVHQNbHY/fnx/fvuVMyLMxqBuxZiP2GeXHsgwb5hgQn6lC/keJoXo5oEkkAcv/YNPpJLQfl/8ZSQGJUad3S3nLZbSzFDD2XKPKXLBAKOTCQrcjgvU/P0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700485; c=relaxed/simple;
	bh=jEwwm4/6zTqKRC8QViHL6oy6KM82ROk+Hgx3bmTXReU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA123GXhZLILd1j0JvaUUu82+QT3auhcQRFThF/rm4opbbC6qHvoNR6X4WXa+HSne694PVFgwlzzie/58LAVQcPJoAg/cBNemFj0gAd5AMs4MIoUpgabz12SYi+rVJt/pFToc9joTk4BedlULQ6n6UpwyjH32o/4LYIqOcrUtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIyZ4r01; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757700484; x=1789236484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jEwwm4/6zTqKRC8QViHL6oy6KM82ROk+Hgx3bmTXReU=;
  b=GIyZ4r016Qn4T3KVfpR2X2bNZ7oHRBV3W7hyAQInLxs2FkwpV+OSwr4i
   lU+oEJbdCJK9fWKUHZVC04tK2SuVZ20G7mOzD7yQ2gdGaZzlywkvlFKdJ
   +uUglW4kEDLCaMz7Tr/1nXN0b47D7DsL14n1Z8elsUXEaT+f9Rvde8tFu
   X4EI5HCA5d6aGXrPb0j9jzRx+vb8Hyfidhc/okmgxVl6gWBQnnAif5oZE
   A8IiQuifmuS5PJV6fdECtcFGLIbRQY54NVatXhqmDNnoxXrzuvjV+MgXw
   Qn7nqOFOm3tV/FhSa8d/f3C01kO9k/f8cZZVuoVcY3KX96daZT8MhsfHG
   A==;
X-CSE-ConnectionGUID: dXIIBNOhTiGGavQyQ5qK6Q==
X-CSE-MsgGUID: zeKMMf3mQO++P2pnsyKL0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="71151563"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="71151563"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:08:03 -0700
X-CSE-ConnectionGUID: 9568HXzwTzeSipFpqvTyZA==
X-CSE-MsgGUID: K68GfwIVRrWfPtQWnvqMYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="204799418"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:08:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ux8Bi-00000002T0S-20K4;
	Fri, 12 Sep 2025 21:07:58 +0300
Date: Fri, 12 Sep 2025 21:07:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
Message-ID: <aMRhfvi88aoWRZao@smile.fi.intel.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
 <CAHp75VdVUOxkKhiheujAK0gjk_GXGqQ0g=LhNDjZr-Of1gH=sQ@mail.gmail.com>
 <d5e53a9c-418c-4c33-bbf4-b7d49d523cf2@baylibre.com>
 <aMRVKZGPv4PwR8-o@smile.fi.intel.com>
 <6dee1849-45f0-47c8-b29e-8057dee44b6a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dee1849-45f0-47c8-b29e-8057dee44b6a@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 12, 2025 at 12:41:08PM -0500, David Lechner wrote:
> On 9/12/25 12:15 PM, Andy Shevchenko wrote:
> > On Fri, Sep 12, 2025 at 09:19:36AM -0500, David Lechner wrote:
> >> On 9/11/25 11:39 PM, Andy Shevchenko wrote:
> >>> On Fri, Sep 12, 2025 at 12:42 AM David Lechner <dlechner@baylibre.com> wrote:
> >>>>
> >>>> Use guard(mutex) in a couple of functions to allow direct returns. This
> >>>> simplifies the code a bit and will make later changes easier.
> >>>
> >>> From this and the patch it's unclear if cleanup.h was already there or
> >>> not. If not, this patch misses it, if yes, the commit message should
> >>> be different.
> >>
> >> cleanup.h is already there. I'm not sure what would need to be different
> >> in the commit message though.
> > 
> > I expect something like "finish converting the driver to use guard()()..."
> 
> cleanup.h was previously included for __free(), so the guard() stuff
> is all new.

Okay, then something like "Cover the lock handling using guard()()..."
The point I'm trying to make is that "Use $FOO API/etc" without new header
being included either:
1) missing inclusion (proxying);
2) start using of a new API from the library/header that we already use for
another API, but without mentioning that.

-- 
With Best Regards,
Andy Shevchenko



