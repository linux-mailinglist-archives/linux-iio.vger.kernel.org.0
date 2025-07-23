Return-Path: <linux-iio+bounces-21912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4323B0F6BA
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFD71CC5ED6
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7529B229;
	Wed, 23 Jul 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhBIk8rv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0172F5C3A;
	Wed, 23 Jul 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283220; cv=none; b=RjO5/l60rkK3SxbtDp9UGvMV1ZFi97pv71MpMZ91eOLqcdXghRFrzz5Rzo8Wf7mjAhvV223hSdqk90HC6yo5FYvkCNVs6COkBnsR7I6xQ78al1RJCfv4nK9nhOw+/5CWgX4YnmoaTP7UvWuDVp4y6WYmjbpNJP2vh9IJ2J1eUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283220; c=relaxed/simple;
	bh=agOo8ZBroL3mtiD2jfVo5EtCx/bGD1VZ9154xsRVElo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkklY0hQ0cfILgYbaXZGC0uwJ5ToCGZWVNUuS3tpuRxp2r1Jk4Yt8rPTCoPY9qsXv0XQxDns1k2oQIPsxqOEKpiaXLDYvqmryVeeS554OqOj4eCvmUP4xCtUwweRuYOe8Yixnif4OC7gSteelpnN1v0/un1ytaJvdWAuQNuXaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhBIk8rv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753283219; x=1784819219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=agOo8ZBroL3mtiD2jfVo5EtCx/bGD1VZ9154xsRVElo=;
  b=EhBIk8rvFdX2GqC6GbJqHugHAGXc2aE0ADExiEqyCd6kfBKwjzSkDqFX
   OcmNPo2F3JQbx62ai6UIJxUZyxBicicOqfuZZ4Ws/bA+W9i6kaaHR5bOJ
   r8SUQgUKEthQip9Xz0+cG2FSDr3dgJxKMd8la1F+YihFsfy5x7geQiAy2
   qxGkWw7Jemz7SE9ZVQx7RFmc9Y8Fx/jkvDMTt77FwSfsNQxAprD5xbAEz
   Fww8XNEJRolIXZKG5m45Rhe2C94c9BW1JFiv8ldrMPRFbRek9TzSYok/e
   HSs/g4xGTs9T1W1NpAemPrDW36xxGtrDI+ZR08whT3RH2M9NBzXp0A2YY
   A==;
X-CSE-ConnectionGUID: r9tx4JPyT3a7D7K9sa24Og==
X-CSE-MsgGUID: uap0d/B9Q5mU7CktZ3RMWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55275337"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55275337"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:06:58 -0700
X-CSE-ConnectionGUID: Ybv6nt42SvmKUiIFOlNfrQ==
X-CSE-MsgGUID: q1kceILWQKm9OlufQ567dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159597115"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:06:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueb3V-00000000Jyy-1Uzo;
	Wed, 23 Jul 2025 18:06:53 +0300
Date: Wed, 23 Jul 2025 18:06:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
Message-ID: <aID6jfjULn2kvvQJ@smile.fi.intel.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
 <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
 <aIDuEcHhaGtz2klP@smile.fi.intel.com>
 <795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
 <aIDzvNYIaJnSuzOa@smile.fi.intel.com>
 <7ca7e0b9-a77d-4de8-92b1-fea3250e8155@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca7e0b9-a77d-4de8-92b1-fea3250e8155@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 23, 2025 at 09:57:58AM -0500, David Lechner wrote:
> On 7/23/25 9:37 AM, Andy Shevchenko wrote:
> > On Wed, Jul 23, 2025 at 09:29:37AM -0500, David Lechner wrote:
> >> On 7/23/25 9:13 AM, Andy Shevchenko wrote:
> >>> On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:
> >>>> On 7/22/25 6:07 PM, David Lechner wrote:
> >>>>> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
> >>>>> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
> >>>>> the data before pushing it to the IIO buffer.
> >>>
> >>>> It is odd to have data already in CPU-endian and convert it to LE
> >>>> before pushing to buffers. So I'm a bit tempted to do this instead
> >>>> since it probably isn't likely anyone is using this on a big-endian
> >>>> system:
> >>>
> >>> I can say that first of all, we need to consult with the datasheet for the
> >>> actual HW endianess. And second, I do not believe that CPU endianess may be
> >>> used, 
> >>
> >> Why not? Lot's of IIO drivers use IIO_CPU in their scan buffers.
> >>
> >>> I can't imagine when this (discrete?) component can be integrated in such
> >>> a way. That said, I think your second approach even worse.
> >>
> >> hx9023s_sample() is calling get_unaligned_le16() on all of the data
> >> read over the bus, so in the driver, all data is stored CPU-endian
> >> already rather than passing actual raw bus data to the buffer.
> > 
> > I see, now it makes a lot of sense. Thanks for clarifying this to me.
> > 
> >> So it seems a waste of CPU cycles to convert it back to little-endian
> >> to push to the buffer only for consumers to have to convert it back
> >> to CPU-endian again. But since most systems are little-endian already
> >> this doesn't really matter since no actual conversion is done in this
> >> case.
> > 
> > Right, but it's buggy on BE, isn't it?
> > 
> 
> Right now, the driver is buggy everywhere. The scan info says that the
> scan data is BE, but in reality, it is LE (no matter the CPU-endianness).
> 
> With the simple patch, it fixes the scan info to reflect reality that
> the data is LE in the buffer. This works on BE systems. They just have
> an extra conversion from BE to LE in the kernel when pushing to the
> buffer and userspace would have to convert back to BE to do math on it.
> 
> With the alternate patch you didn't like, the forced conversion to LE
> when pushing to buffers is dropped, so nothing would change on LE
> systems but BE systems wouldn't have the extra order swapping.

But do they need that? If you supply CPU order (and it is already in a such
after get_unaligned_*() calls) then everything would be good, no?

-- 
With Best Regards,
Andy Shevchenko



