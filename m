Return-Path: <linux-iio+bounces-21149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E33AEDA0C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 12:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D031188D1E4
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DC2586EC;
	Mon, 30 Jun 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erMaPVK+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2825A342
	for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280039; cv=none; b=evY1FOfi5z9lhRrQDyT4YFMn0aHAySAbLQ50RMhV9CwpxnYHppc+kD9VGdHtUKKRIUtDjO4UeiHBLj2di0ZNKDuCsf7Kh4RfL+a6ipnq3RSJ2/iyAbkVV1LD03RoXivWj+pt9zj+LERd1oKyUYI3aWXUYFuCLo72F6UZ76taVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280039; c=relaxed/simple;
	bh=8vF+I7YJcW3cYy+CUkkua5SZ519VJMnlQ5w1Dei5bJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJQ9efE65vR8fXkdSFMHVjYvmYFFFtoq5nUNp3EgDHbai+WpxjjJGlAzj2nTkWtXkATqfRMmcaLRyEzS3rh7w5gTeA9BVQiDtn2l07EIarBpJTdgibX3U5Ik8wKT5imdGiHioqrJ2U+19pzd66/SDsItKqXnC9xWWu3OD4bq5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erMaPVK+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751280038; x=1782816038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vF+I7YJcW3cYy+CUkkua5SZ519VJMnlQ5w1Dei5bJA=;
  b=erMaPVK+WkJvb+lrSj96OdiXebLtxbMcjnsRjkYgBh/pecSQckp/GqI4
   QrMdVryB9EMj68+3Uvekzjm9wmgiuUI9Kw2cNwH24327OADEMlLpfbx0v
   e5DYBRWy50e5d37rU+R6xeJ9tzqswPpGowbmu+yaQsDfcayySNrOt4dRm
   BJLIwEWCvRTq7TFSKHvyqMqtTe4jMUFocW5SUEaSEaUoEzuyi2tGvIQJU
   gPdpU2wAQ5Q7pCOQnBZa07zVjaX01leKaZ4kb4gQuYDBKXQ7xnj2zFxDs
   VgtbeYAfHtLhSRnU3tGm8+sLAls6vFRegKwNfmEC5y7eXJFaJMkoXkd1N
   g==;
X-CSE-ConnectionGUID: hYI5mhGdRoGWpEo3WSG3sg==
X-CSE-MsgGUID: Z6fBSQn9SBixkQvjq/GEng==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53441522"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53441522"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:40:37 -0700
X-CSE-ConnectionGUID: esLfyRBRSk6+iAUFvfiqWg==
X-CSE-MsgGUID: yEebNsuUTiuEXlq9TEujTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153972512"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:40:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWBw8-0000000BHLN-1fXe;
	Mon, 30 Jun 2025 13:40:32 +0300
Date: Mon, 30 Jun 2025 13:40:32 +0300
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
Message-ID: <aGJpoNfSMW_cQ4Ry@smile.fi.intel.com>
References: <20250629183649.184479-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629183649.184479-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 29, 2025 at 07:36:49PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Motivated by the W=1 warning about export.h that was introduced this cycle
> this is an attempt to apply an approximation of the principles of including
> whatever is used in the file directly.
> 
> Helped by the include-what-you-use tool.
> 
> Reasoning:
> - Drop linux/moduleparam.h as completely unused.
> - linux/array_size.h for ARRAY_SIZE()
> - linux/bitmap.h for for_each_set_bit
> - linux/errno.h for error codes.
> - linux/export.h for EXPORT_SYMBOL*()
> - linux/math64.h for do_div - alternative would be asm/div64.h
> - linux/minmax.h for min()
> - linux/sysfs.h for sysfs_emit()
> - linux/time64.h for USEC_PER_MSEC
> - linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
> - asm/byteorder.h for le16_to_cpu()
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
> I picked this one fairly randomly as an example but longer term I'd like
> to look through at least all new drivers with this in mind + all the ones
> that are currently messing up my W=1 build logs.
> 
> Note I've been very descriptive in this patch to allow people to suggest
> better alternatives for some of the ones that aren't entirely obvious.

Thanks for trying it again, very much appreciated!

What we actually miss is the database (in any text-based format, even *.d would
work I suppose) for the guarantees. For example, if code uses ERR_PTR() and at
the same time (very likely) uses something like -EINVAL, the errno.h is implied
(and guaranteed!) by err.h. Explicit errno.h is in two cases: 1) nothing is used
from err.h, but errno.h; 2) Linux special error codes are in use, e.g. EPROBE_DEFER.

Next, what I would really start with is the kernel.h. this is the beast that is
happening in many files and old snippets all over the internet, it would be nice
to clean it sooner than later. Especially if it's in the headers (should not be
as written at the top of that file). So, hence just a priority for these cleanups
first.

-- 
With Best Regards,
Andy Shevchenko



