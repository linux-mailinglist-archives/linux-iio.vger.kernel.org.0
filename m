Return-Path: <linux-iio+bounces-21150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8481AEDA24
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AAE188FC64
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF712550AF;
	Mon, 30 Jun 2025 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoPX7GZe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA1248F4F
	for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280127; cv=none; b=VmPnb9yjYSXiaLjtAsp+JsTk0f9JOhRa1JUTUB8QqhGe+tCn4RwO2rKJ6rLtsFU/BFZ7N41YcbZQS2rFNZsXihOZY/EHZVrMtnS9gsUlqIjcYhHfIplqBKBq+lmU+mvhXxmIUkFnp5vNekE8WYP4Dx0bkpmXC16VTSCGCO13BLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280127; c=relaxed/simple;
	bh=oKIxQNwW/V3Jw3puppt1pyca0OBMOIWOyPHMlPoWihU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXqiAuyNAib0c6svIb31a8SrwjNZffqBFATa3NSZo0XEYWy5FP1C0bn4mAKL8rEf57PeL0bxttd2AIH1VJuSt1zyeEOhzjLIysd2Xd0V78LneYLJ2e2E/jSHzfRIxnmj48RtkbpAv76Ah82cHdnrotyAS3k/BS+Ck7lU5My5c0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoPX7GZe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751280126; x=1782816126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oKIxQNwW/V3Jw3puppt1pyca0OBMOIWOyPHMlPoWihU=;
  b=VoPX7GZe52xwS4qWTHZvJD4DuOXxcOq1/QE66Oiun0mMl+yA7Lok9gEz
   Ui7VYJG42NyeA/VIvXS/kuDpYDN/vRSlfUcLlUbkpABQ+pPwPqHJqlKlN
   uT+FI5VrMdIp1tKJ89Q4fxNoWqZ6+9uwrX2Pd0DJngDCmBn/Ak5kCif++
   29vdxxXioQmz+q2n8ZjJURCrx56MhGb8W7kK7Ojy3X5Lxrl3UJqhY6tee
   6JuZg/R6v6SJrpBF4g1sFq8Gwf2k3G6xnDh2rNmsiBVHhuhCJJ4WjG2Gk
   TBFFlN+jQ7YU0wSuqWIqkXxOMUDFCzgoTO9IdYSAhyGbSeSNf+T0yM4XD
   w==;
X-CSE-ConnectionGUID: KpEOqCNSRk6rCijqSzoHrA==
X-CSE-MsgGUID: gXCAH6wFTyGHbsx7Yk/quA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53363107"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53363107"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:42:06 -0700
X-CSE-ConnectionGUID: xwPhC/XuQ3O+4qY3uxqw0g==
X-CSE-MsgGUID: hdDfEBHkSBqLJwj1hW44Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="157449764"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:42:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWBxY-0000000BHMM-2oD0;
	Mon, 30 Jun 2025 13:42:00 +0300
Date: Mon, 30 Jun 2025 13:42:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu
 principles to includes
Message-ID: <aGJp-NYffceeX8bi@smile.fi.intel.com>
References: <20250629183649.184479-1-jic23@kernel.org>
 <20250629194336.34a03946@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629194336.34a03946@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 29, 2025 at 07:43:36PM +0100, Jonathan Cameron wrote:
> On Sun, 29 Jun 2025 19:36:49 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Motivated by the W=1 warning about export.h that was introduced this cycle
> > this is an attempt to apply an approximation of the principles of including
> > whatever is used in the file directly.
> > 
> > Helped by the include-what-you-use tool.
> > 
> > Reasoning:
> > - Drop linux/moduleparam.h as completely unused.
> > - linux/array_size.h for ARRAY_SIZE()
> > - linux/bitmap.h for for_each_set_bit
> > - linux/errno.h for error codes.
> > - linux/export.h for EXPORT_SYMBOL*()
> > - linux/math64.h for do_div - alternative would be asm/div64.h
> > - linux/minmax.h for min()
> > - linux/sysfs.h for sysfs_emit()
> > - linux/time64.h for USEC_PER_MSEC
> > - linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
> > - asm/byteorder.h for le16_to_cpu()
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > 
> > I picked this one fairly randomly as an example but longer term I'd like
> > to look through at least all new drivers with this in mind + all the ones
> > that are currently messing up my W=1 build logs.
> > 
> > Note I've been very descriptive in this patch to allow people to suggest
> > better alternatives for some of the ones that aren't entirely obvious.
> > 
> Helpfully I had a script lying around from 2021:
> https://lore.kernel.org/all/20211003153306.391766-1-jic23@kernel.org/
> 
> Just for reference I used iwyu with: 
> 
> make LLVM=1 LOCALVERSION= W=1 -j12 C=1 CHECK=include-what-you-use CHECKFLAGS="-Xiwyu --no_default_mappings -Xiwyu --mapping_file=iio.imp"
> 
> where iio.imp is from a few years ago and contains:
> 	{ include: ["\"linux/sizes.h\"", "private", <linux/sizes.h>, "public"] },
> 	{ include: ["\"linux/slab.h\"", "private", <linux/slab.h>, "public"] },
> 	{ include: ["\"linux/spinlock.h\"", "private", <linux/spinlock.h>, "public"] },
> 	{ include: ["\"linux/spinlock_types.h\"", "private", <linux/spinlock.h>, "public"] },
> 	{ include: ["\"linux/spi/spi.h\"", "private", <linux/spi/spi.h>, "public"] },
> 	{ include: ["\"linux/stat.h\"", "private", <linux/stat.h>, "public"] },
> 	{ include: ["\"linux/stdarg.h\"", "private", <linux/stdarg.h>, "public"] },
> 	{ include: ["\"linux/stddef.h\"", "private", <linux/stddef.h>, "public"] },
> 	{ include: ["\"linux/string.h\"", "private", <linux/string.h>, "public"] },
> 	{ include: ["\"linux/stringify.h\"", "private", <linux/stringify.h>, "public"] },
> 	{ include: ["\"linux/sysfs.h\"", "private", <linux/sysfs.h>, "public"] },
> 	{ include: ["\"linux/types.h\"", "private", <linux/types.h>, "public"] },
> 	{ include: ["\"linux/uuid.h\"", "private", <linux/uuid.h>, "public"] },
> 	{ include: ["\"linux/sched.h\"", "private", <linux/sched.h>, "public"] },
> 	{ include: ["\"linux/wait.h\"", "private", <linux/wait.h>, "public"] },
> 	{ include: ["\"linux/workqueue.h\"", "private", <linux/workqueue.h>, "public"] },
> 	{ include: ["\"asm-generic/int-ll64.h\"", "private", <linux/types.h>, "public"] },	
> 	{ include: ["\"linux/device.h\"", "private", <linux/device.h>, "public"] },
> 	{ include: ["\"linux/dev_printk.h\"", "private", <linux/device.h>, "public"] },
> 	{ include: ["\"linux/device/bus.h\"", "private", <linux/device.h>, "public"] },
> 	{ include: ["\"linux/device/driver.h\"", "private", <linux/device.h>, "public"] },
> 	{ include: ["\"linux/bits.h\"", "private", <linux/bits.h>, "public"] },	
> 	{ include: ["\"vdso/bits.h\"", "private", <linux/bits.h>, "public"] },
> 	{ include: ["\"vdso/limits.h\"", "private", <linux/limits.h>, "public"] },
> 	{ include: ["\"linux/limits.h\"", "private", <linux/limits.h>, "public"] },
> 	{ include: ["\"vdso/ktime.h\"", "private", <linux/ktime.h>, "public"] },
> 	{ include: ["\"linux/ktime.h\"", "private", <linux/ktime.h>, "public"] },
> 	{ include: ["\"vdso/time64.h\"", "private", <linux/time64.h>, "public"] },
> 	{ include: ["\"linux/time.h\"", "private", <linux/time.h>, "public"] },
> 	{ include: ["\"linux/timer.h\"", "private", <linux/timer.h>, "public"] }
> ]
> 
> Clear this needs a few upates, like mutex_types.h -> mutex.h and
> probably devres.h->device.h

Right, we got a lot of new *_types.h headers.
This is a database (kind of) I was talking about in previous reply.
Can we actually start it as .iwyu or so in the kernel source tree?

-- 
With Best Regards,
Andy Shevchenko



