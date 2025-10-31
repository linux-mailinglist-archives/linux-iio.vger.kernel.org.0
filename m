Return-Path: <linux-iio+bounces-25757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A013C25A25
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 15:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D9544E7D23
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89734C821;
	Fri, 31 Oct 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2H1QM4R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692BA1F4E59;
	Fri, 31 Oct 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921627; cv=none; b=SoNMc7rbDViTDPjFLZCtE1x2EFX2Albxwmn/a4zZcsa0AvovG1olOnlTo3IvtwCBrMAEtMcKNezOl9FfMwAhrUu9o+45q2Rhgbmtfkxs4xYoyF4zVuX//0NvCNAzijO0WOsq2AoQDYmoYmztTPIAgnh3xP0fNq0a2ezWabS4qGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921627; c=relaxed/simple;
	bh=qSbAYqRqstmnBAKgQa7cnMRak8yPgfb70/ahldoOtMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbjPJYTaL4o+KygsGwhR0o/FUG3Jvz1AA8P1+wQF3Veq0ChdOdI657tRJu0ksHiX/Eugi12QZmI7kaMTM/o1XSBiEvbk9SbF7b3wOrWiHsQZGHLy0JPzYeGagCwt26kePyNgvUkNoqqDeq22rhz2/5RUkxbayL0C2qq1E338o6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2H1QM4R; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761921626; x=1793457626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qSbAYqRqstmnBAKgQa7cnMRak8yPgfb70/ahldoOtMI=;
  b=e2H1QM4RA0WKQGdQeW4DRKjIdAGl/GjH5ZYCaenA7IU9p1SfF3j1zj/K
   DLFmPA3JIky7KJkYjhs+nYAFi3okROEqAoMxRN9Wors1r9UI/t6avhJOx
   +qRwxorEOBR2/Dw2CffNl6BMx4WyIvfKJ9a8VA1UrU2dBI5NcNwxRqL1U
   j8bnFcHLtcHd6PMfJdMomgrqRPhj+vfOOV1BaNJCYyIXaBEK0KqyiD5vm
   TZX5W1lXKSijyMLXl3xfll4/txgEBEaNYvTffb2g2bfZIb34vWjMAZh3l
   7akve1Ity6GUBXWcxVy0e2440lE7fBeb8iQkpb6ze95V4ouFuh/VhQqLE
   g==;
X-CSE-ConnectionGUID: maxzgR5ZS32cqZ5mnHM9pg==
X-CSE-MsgGUID: uRVXxvKzTqOYPXnFrV8ZEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="89547095"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="89547095"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:40:25 -0700
X-CSE-ConnectionGUID: wW36B9w0Th65t8SZqQHQaQ==
X-CSE-MsgGUID: yXMFoN25Tt2CBnsYM50VDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185522737"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:40:23 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEqIb-00000004IWb-2VHb;
	Fri, 31 Oct 2025 16:40:17 +0200
Date: Fri, 31 Oct 2025 16:40:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm45600: Initializes
 inv_icm45600_buffer_postdisable sleep
Message-ID: <aQTKUE4Nj77LKfbD@smile.fi.intel.com>
References: <20251031-icm45600_fix_buffer_sleep_init-v2-1-5cdc04e1bcba@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-icm45600_fix_buffer_sleep_init-v2-1-5cdc04e1bcba@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 01:57:06PM +0000, Remi Buisson via B4 Relay wrote:
> 
> The sleep variable in inv_icm45600_buffer_postdisable could be used without
> being assigned in case of error. It must be initialized to 0 by default.

> Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")

This is part of the tag block, needs to go together (on one paragraph, means no
blank lines in between) with your SoB and other tags, if applicable.

> Smatch static checker warning:
> 
> 	drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c:377 inv_icm45600_buffer_postdisable()
> 	error: uninitialized symbol 'sleep'.

Is there a public message / report on this? If so, use Closes: tag to point to
it.

> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>

...

>  	struct device *dev = regmap_get_device(st->map);
>  	unsigned int sensor;
>  	unsigned int *watermark;
> -	unsigned int sleep;
> +	unsigned int sleep = 0;

As I said, the preferred way is to decouple definition and assignment. The best
place for it is just before scope_guard() call.

	sleep = 0;
	scoped_guard(mutex, &st->lock)
		ret = _inv_icm45600_buffer_postdisable(st, sensor, watermark, &sleep);


-- 
With Best Regards,
Andy Shevchenko



