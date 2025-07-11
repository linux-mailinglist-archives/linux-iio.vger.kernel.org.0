Return-Path: <linux-iio+bounces-21587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865A5B0241B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 20:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3633F3BD7E9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA101D88D7;
	Fri, 11 Jul 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFgFuuUR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011A42A9D;
	Fri, 11 Jul 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259856; cv=none; b=AW+JKS0+Kg40OVK/v2JHpimcEl4y5T8ZC5Qwzh5fRir+iKF+HdvplWtYUtaFMGHbwbz5O3nsAVdX873tosaWswlVzAYbPeNc5JeXVhuHR2uuANgpVasU/veGTzlfvkw+TfI6GcHmyFi3n/u0g2KqSC5JxVid5HUVMy52QWvftBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259856; c=relaxed/simple;
	bh=wtp/a/NrJctPTE/lPv3KvPB67di8uviIwusYH+ddavg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lifWUOI1HfxN14Bcyo7mTgzCyfy0b7mBWQDD0dmh8vdSRsq6XGBCJsPJDAemjTdL6t/Q+CGEKobQ18BSKc2IVFjy2MDpxbxLJCNYg923PjO3D7tF1szelLtwWrPij6TK+rHE2T5+sJ9UcVziwdmLcztEAwhzra6GyAONwAgHfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFgFuuUR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752259855; x=1783795855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wtp/a/NrJctPTE/lPv3KvPB67di8uviIwusYH+ddavg=;
  b=IFgFuuURDaM8Wl5jnzXI3GuHa/zziqz2BGzhUGjRjqr/k8yjpxc10zrY
   Gfsylxr4MJWPsHB2ZzQZsPd2cjt7TEF2oT23Z6pn7dy56wXXDV25Sn9Rd
   0lvCZayLCxz/6Kt1j1xoUAvEQm98Sfili4y9jNn5m8M5nSLWfXsuKYllA
   qEym9CpI01ITAC2Qy52NDuuOeobG9rr9QXyRAP2DoBxo2vQWqxbMBfLNH
   MgO1K/mJADsDdt4k1PRIU75AMVCJMPMkicZXNUH0NkPpWcxfomA/J92i/
   OEvfPtY/V9XmBZKB42Hmn+je4t/hDmYmOIEKTJKnSs9fnbAmpyrPRHvx7
   A==;
X-CSE-ConnectionGUID: AjiX14FhQ7GV+VzJPv66FQ==
X-CSE-MsgGUID: 4hILPWRFQpysrKw6Wu9GgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58327717"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="58327717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:50:54 -0700
X-CSE-ConnectionGUID: 2WAds0giQxCPMO4Qd3EDOg==
X-CSE-MsgGUID: mRJD4d+tSsy1HigTxa0eeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="160765823"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:50:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uaIpd-0000000Ec7Z-0ifj;
	Fri, 11 Jul 2025 21:50:49 +0300
Date: Fri, 11 Jul 2025 21:50:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
Message-ID: <aHFdCBGWDs-IRMTC@smile.fi.intel.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
 <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
 <aHFO7LhWXOuglaoz@smile.fi.intel.com>
 <4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 01:38:17PM -0500, David Lechner wrote:
> On 7/11/25 12:50 PM, Andy Shevchenko wrote:
> > On Fri, Jul 11, 2025 at 12:04:03PM -0500, David Lechner wrote:
> >> On 7/11/25 11:41 AM, Andy Shevchenko wrote:
> >>> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:

...

> >>>> +#include <asm/byteorder.h>
> >>>
> >>> Hmm... I see nothing about this change in the commit message.
> >>
> >> It is for __be16. I kind of assumed that would be obvious, but sure,
> >> better to be explicit about it.
> > 
> > Isn't it in types.h?
> 
> No, only CPU-endian types are in types.h. The actual #define for
>  __be16 is in include/uapi/linux/byteorder/big_endian.h.

Huh?!

> This is
> included in one driver in staging, otherwise it is only included
> in arch/*/include/uapi/asm/byteorder.h. And asm/byteorder.h is what
> Jonathan used for similar in some of his recent IWYU patches as well,
> so I assume that is the preferred way to do it.

include/uapi/linux/types.h:37:typedef __u16 __bitwise __be16;

-- 
With Best Regards,
Andy Shevchenko



