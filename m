Return-Path: <linux-iio+bounces-21544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D8EB00BD8
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 21:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9505C37E3
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68572FCFE0;
	Thu, 10 Jul 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aG8U5k44"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A92FCFE4
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174554; cv=none; b=mFgCkiGgy86NB9+BAZtARfOaFMefyNwmLiXRfzCjoqvNhREfPqs00UzOQmy0oo2vmjks5/i1CXB18uy047C0Yo/4GKeQovJDxC4JvfvUCL2/iosbQsQDMHnrDmylFN2A55JrK3Qp2qr54TE3wjBpqQqU8ZvOmNSvY6SV0qzhw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174554; c=relaxed/simple;
	bh=rsJgETqujF6d+yXQeVMGpkZjijHOkU+3mnHBQL9sJjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtjiFPTBpFopZEqRwDHEW+RQZnPCGYOsUUWALCLtW6xG4VIV+tGtpRf1IO+EzsozrvBN2QjDPE1J2dT3NVeY15LAoRcvgIaVbMiCwWHb7QRxbp5pPa2AspdqY6RxZMuOHj7d0AzcbWM6M63324Lz24xbV6AcTf+c8RSuDtxifkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aG8U5k44; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752174553; x=1783710553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rsJgETqujF6d+yXQeVMGpkZjijHOkU+3mnHBQL9sJjQ=;
  b=aG8U5k44bnMW1Yr5qw/pL6b8i4kKSwIhJ2hPqrnsUSqBEX/ZfSExVmuv
   2x1tcSk6I6+PQKzBF5qS2XdbwtRi7I3eqV5uDNcgIJrdNY/kxphShU2G6
   4SMMtaDgzWEwVHlR2DMhHT4EHNg7rh5CWb6Bm2jQe9xTcLNkmqIiTYygD
   3m5xlwlxivvRImeJyYJqNtIspxWVQ9WRq69paTNLh/rSiqp4Vbh9o3hby
   flRyy7Ut3mAJV7jnINi4FZWAsnxCvg12MhsGW5U9mpAxZEj0MlppNA34L
   p3FrK7ywdw9lnZBjVmNCNC1RWgx+9o5STwC05pzYvqwNSVcF7LAidy/41
   A==;
X-CSE-ConnectionGUID: /ZITfYgsQw6QAfQw996uDw==
X-CSE-MsgGUID: TA2/TrulQZqDZbVmeOv0Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54623010"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54623010"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 12:09:12 -0700
X-CSE-ConnectionGUID: Vb70YZpjQ4WTJAx8AcEBZg==
X-CSE-MsgGUID: xDe9VYqJQSeRuyB4mFSJhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160727377"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 12:09:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZwdm-0000000EJ6W-2Zh8;
	Thu, 10 Jul 2025 22:09:06 +0300
Date: Thu, 10 Jul 2025 22:09:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/7] IIO: More application of IWYU principles to includes.
Message-ID: <aHAP0rr1VQX8hWC9@smile.fi.intel.com>
References: <20250710171107.443790-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710171107.443790-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 06:11:00PM +0100, Jonathan Cameron wrote:
> 
> I decided to look at a slightly larger set to continue trying to come
> up with consistent rules (for IIO anyway) on what we want to include
> direclty and what assumptions we can make about a header always including
> another.
> 
> As the series goes on reduce the amount of info on particular choices made
> just because the commit descriptions were getting very long.
> 
> A few open questions.
> - linux/stddef.h - do we want to included this directly?

Only if not types.h included.

> - linux/types.h - do we want to include this directly?

Yes.

> - linux/dev_printk.h - include even if device.h is needed for other reasons
>   or rely on that as a grouping header if present and only use dev_printk
>   where we don't need device.h.

I slightly tend to include both as strictly speaking the dev_printk.h should be
device/printk.h, but that boat already sailed long time ago...

> I'll share a refreshed IWYU config once we come to firmer conclusions
> on the various choices.  I haven't yet figured out now to not include
> anything at all for things like CONFIG*

PAGE_SIZE is in asm/page.h.

-- 
With Best Regards,
Andy Shevchenko



