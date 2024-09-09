Return-Path: <linux-iio+bounces-9370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B021971328
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124011F2529B
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142521B29DB;
	Mon,  9 Sep 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ckdt45UO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D342AAB;
	Mon,  9 Sep 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873485; cv=none; b=d1nE2V/P6EzkUQ23OUji9puA7lrPoJsz29i7rRA1ZkdYEcS+bmJLgguXiBMwdTD2MRx95JqTRkltWkUIkql03sx9MM5iz65YdzrjVvLCNq9dk2JwUpU59GEw2Gxfs5INCV9keCU3MFc5y7l9P/1yJC3zz3BenLXAB7fCsgLmvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873485; c=relaxed/simple;
	bh=bRUzjcP/zGtQgFprgafmcUwBu2d1rsV/7yCPCxzhatQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxHzJTc2ahaYbQ7m9tje45teDRr4EZ07snDsLNJe9+0H04Z7WoFPNDPMJ1NamcKIb+ri0hr+20cH5WIBnn8KEIncOJy9bMsp1J1GXdQJs/OC3UyBOznxcQQOqdKAp966Vb0EW4BdbK5vsK8LozbBUy2SjJu99NhFIFXqyrOA9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ckdt45UO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725873484; x=1757409484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bRUzjcP/zGtQgFprgafmcUwBu2d1rsV/7yCPCxzhatQ=;
  b=Ckdt45UOl4Jb8TNNZDQZ1TOsqiaDN4QehnCNSs/pG2DX5OfH2UAESLc+
   pO1o7oQ4be+pDNGGC7X46Y4Az5VsTqLbHSEwxFSbxPHitbeHqTW6OPxiU
   /r/adF4PH7i6TEe5zod5tcT+6afD+Vd2oXSKkgeCj6u7l8hRt1F6+0TKe
   gflIlIyDLDfOrX43QUiU89iH4sSYR+9BQhAl+fDBRPYBkaSUQ3bnhZVbn
   2i/ewF+AIwzyranTT+Mbx6F1+JrUeE3ye3cNYIN2+kfCK8uky+/VRTZCb
   DZSfyPsC5RzYAD+3VkswOMGwQAA5QzuX8VVq6pOjGsTD4LETudU9Hfz5x
   w==;
X-CSE-ConnectionGUID: QZ70ElW/QuC2t6pxHa+0kA==
X-CSE-MsgGUID: MFvq/qNITECqoCJ2ZhTkng==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24057265"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24057265"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:18:03 -0700
X-CSE-ConnectionGUID: Y/n4n6tLQfadAoFX+cVdPw==
X-CSE-MsgGUID: nCFIc7inT+WI/Ro6gXl0pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66657799"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:18:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snaWz-00000006jMc-1Pae;
	Mon, 09 Sep 2024 12:17:57 +0300
Date: Mon, 9 Sep 2024 12:17:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 00/22] iio: use dev_get_platdata() to access
 platform_data
Message-ID: <Zt69RYzr5gmCELzw@smile.fi.intel.com>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
 <ZtdOB3VRN0QCGWU9@smile.fi.intel.com>
 <20240907164258.70772206@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907164258.70772206@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 07, 2024 at 04:42:58PM +0100, Jonathan Cameron wrote:
> On Tue, 3 Sep 2024 20:57:27 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 03, 2024 at 01:16:45AM +0300, Andy Shevchenko wrote:
> > > Unify how IIO drivers access platform_data field of struct device.
> > > In simple and straightforward cases constify the local variables.
> > > 
> > > (Not tested)  
> > 
> > Jonathan, in case you are fine with the series, feel free to squash, e.g.,
> > changes against hid-sensor drivers.
> I don't follow, but maybe that will become clear once I've looked
> at rest of the stuff I haven't read yet.

I mean all the patches that starts with "iio: *: hid-sensor-*:" can be squashed
into one with "iio: hid-sensor:"

> Anyhow, applied to the togreg branch of iio.git and pushed out as testing
> for all the normal reasons.  Another series that will probably be 6.13 material.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



