Return-Path: <linux-iio+bounces-13268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B49E88C0
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 01:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFB71884F65
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62431AD31;
	Mon,  9 Dec 2024 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ga2FWLTx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C6AD2C;
	Mon,  9 Dec 2024 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705153; cv=none; b=hlGA4BDMUfO1EfBnpTohoW0HQz5A1iP3Ms9JV1o9Mq9q7eJDjdutJQ2/PPqOutty31FjvjOazqM/XU3LOB3aSTqA1pDcC5qtTfEZb2heMAwIJC5Sunqj06YkZzQPmrjfra4SRYCBhxA4CjXMcAumd4dLrLRz1AGcN0VngLy6Z0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705153; c=relaxed/simple;
	bh=tl5+QzW02aPfcWPQ4ZaRaqsdhZPSr3X+EeSyvSoi8n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi7bzEVMluy8KH1P4e4EI7Zh1QmSLk7b/IddWWeutPZKM5ifm1KNSjWPKiSxicBuRZNd0FboYxNr139pt1IUfpBIGGCIGSoc5nGaS7zaj70COcNdolMTrtbH7Kr+t79nXWq7TKF6qfbjYlWJUBTEldGT1eMObsbOQ5IKZFX4Lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ga2FWLTx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733705152; x=1765241152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tl5+QzW02aPfcWPQ4ZaRaqsdhZPSr3X+EeSyvSoi8n4=;
  b=ga2FWLTxrq97Nw2Qgp0CSfNQFeP8eYgrgdUGzdRMPMN0Zqnt74nCHrO6
   e0wuUsjcqwPoVWuHAtfyNOWjRJJLD+JEQf3NbTOglov2ACy6GTx+U3Ar+
   s1CLzDbsDiotYihrsTOKP/8q1kp5NlgvJS3enQvj3S7cJvHTqLXIg91I8
   HaXxgkqcM9UI4rhcQHxGyRQhgP31TEY75nUH95nax1PSh+DUZJSG9f0Z1
   18W7iLKuBGm5wqNSNmk0nXrISgJanUCdi/E+COLt+ynBrtes8nUgUj5Gc
   n4zQ6qeN/iLrquzO0BH0QtLxL+a4/zTHjuoJEP49WL1lzQ0w7VLxxx9lE
   w==;
X-CSE-ConnectionGUID: TVJcwnFlQF6nzrT4O97Ykg==
X-CSE-MsgGUID: IkZMFu4CRB2V4bCaC9QpFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34048644"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34048644"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 16:45:51 -0800
X-CSE-ConnectionGUID: sH/fy2TtSmmEgI/pyk1sRg==
X-CSE-MsgGUID: pJnad/ZET2+wdpbC0Hg8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99866497"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 16:45:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tKRuE-00000005WSS-1dA3;
	Mon, 09 Dec 2024 02:45:46 +0200
Date: Mon, 9 Dec 2024 02:45:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, gregkh@linuxfoundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Split devres APIs to device/devres.h
Message-ID: <Z1Y9uqGyq-yuxoEe@smile.fi.intel.com>
References: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
 <20241203195340.855879-2-andriy.shevchenko@linux.intel.com>
 <20241208171001.4994e749@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208171001.4994e749@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 08, 2024 at 05:10:01PM +0000, Jonathan Cameron wrote:
> On Tue,  3 Dec 2024 21:48:51 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > device.h is a huge header which is hard to follow and easy to miss
> > something. Improve that by splitting devres APIs to device/devres.h.
> > 
> > In particular this helps to speedup the build of the code that includes
> > device.h solely for a devres APIs.

...

> > -#include <linux/overflow.h>
> > +
> Unrelated change.

Which one? Blank line?

...

> > -#include <linux/cleanup.h>
> This header movement is unrelated.

No problem to let it stay at the same place.

> I agree both are good but probably want to be a separate patch.
> 
> Otherwise this seems sensible to me, but your cc list seems a little short!
> 
> Greg and Rafael seems a good starting point so I've added them.

Thanks! I need to check why they were not included into the original
submission. Perhpas I need to amend MAINTAINERS,

-- 
With Best Regards,
Andy Shevchenko



