Return-Path: <linux-iio+bounces-19949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87506AC442F
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 21:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376981899492
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1D23E34D;
	Mon, 26 May 2025 19:58:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574E1C8639;
	Mon, 26 May 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289495; cv=none; b=VkKfG9m99Ret1v1s6BxY+7Mr+1hzRkd7f5ItZUVBR/6Exh7+oGj0ljllTddjj/XGFgJ3gCRRSwMOZzWqMzNvJUluN5hsmREcVgfXPdRrp7BbYiHSOLc1Rf+LfYBTN8lh9tlW10m8dsg1aDEZ3y2p+Fao0E0ciXTdwX7cQkMZRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289495; c=relaxed/simple;
	bh=xgDRotCIsPUnISKHDB9ItQyJoq4SJ6NqR8XbydMpiVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLdfqLEfu/Bv28p0kflKZAk39B7OB8331tQfFmb/wNBg8lrW3ZUMUjy1swlS3jyyqGH4czkt8RePVnIMB2LQ+59RSmWrCxcC+a0uXxnVMsOJ2A/xO8qZ7uI1XGQxEyU2SoH8LRcPfWZe+XB10hjcqReJxb9mX+i/fZpERflzxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 6S8oVnuVRniHBXmrTudRIw==
X-CSE-MsgGUID: e/Cjf9y5Q4q9ghMWRuNLDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50152893"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="50152893"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 12:58:14 -0700
X-CSE-ConnectionGUID: p8yZzFBwTIq8xpmAGp/Mlg==
X-CSE-MsgGUID: oXh91ldlTWWmTaoBUo5wSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="142507423"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 12:58:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uJdxW-00000000yJq-3oMm;
	Mon, 26 May 2025 22:58:06 +0300
Date: Mon, 26 May 2025 22:58:06 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: fix suspend and resume triggering for bmi160
 and bmi270
Message-ID: <aDTHzs5AtiNmYIAF@smile.fi.intel.com>
References: <20250525142530.71955-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525142530.71955-1-benato.denis96@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 25, 2025 at 04:25:28PM +0200, Denis Benato wrote:
> Two imu devices bmi160 and bmi270 are similar to bmi323, with the same bug and
> a common usecase: fix the aforementioned bug about triggering not resuming
> after sleep in the same way it was solved for the bmi323 device driver.
> 
> The bmi270 patch has been tested on a device where the device irq pin
> is connected to the CPU ensuring it doesn't cause harm to devices that
> do not use hrtimer or other external triggers.
> 
> Changelog from v1 [1]
> - include linux/pm.h where needed
> - used "Closed" to reference the solved issue for each driver
> - merged two lines into one (on both drivers)

I got this series twice without any (?) difference in the versions. Care to
explain what's going on?


-- 
With Best Regards,
Andy Shevchenko



