Return-Path: <linux-iio+bounces-27941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F930D3A133
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 09:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD80B303AE9E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF633C50B;
	Mon, 19 Jan 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGpNniyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D23382EA;
	Mon, 19 Jan 2026 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810543; cv=none; b=T4Ly/6avDZzloUri8rPpUa9V/cbX5Idc9EMdKFq4vkVH9oTR7xwgEb7X/M7Fb5p+lU9krw4KvTusoGXIOjynhJxwd/bwcpLUbqDSysMp6UZL3F/49zh0CtazD0VPjFGc4MzJCW8j288pORi9Mz1kveo0qONAfll1/ZgGwJGNiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810543; c=relaxed/simple;
	bh=BAh9RkU38ILfYGgssh5yy6TO9wxffHa3l1z8FGXmvDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMAThHB8ZNhapRnhMOehNaLtFN/Y9TxSXyKJZDBLIZdpr4KoiqHMuGQNAqRstLM2myvfluJm5Kj30FEUNRAhJz1uzeUlZd0KQNtl7jzxfD/n+XL3T7WExg/M+oARgaYEiAo9Syjcg0guC/sFk9HJT6Jw/PvQHNa27eTB0mVsfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGpNniyW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768810542; x=1800346542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BAh9RkU38ILfYGgssh5yy6TO9wxffHa3l1z8FGXmvDU=;
  b=RGpNniyWcS10XQOsQOmG9VClvMOCtSpFZ4t8gKkTQHsKgQvspEq3Hfj9
   DG2BNMWUBsCFaI11lJSuPMI2YAdnVwhmGFA1WBAkhlnVN84QekNlzsGnf
   64mjAnFD6S09s4ekWC/GFOkX2NDzks0o/QC9BFq1kMnirWJ96drjI7XPB
   rXnqfEG1ErG+kS1IQBwJ9dB6mqILUhzDUmrqQUU3ejXkK7ziDqugFbHcH
   YZ9fsnWoplJ3RyejhsLnFSKQiDJZQYiBgOjyjf96WdAH4J0+Vtf3KfFKD
   r+lphlZTPz1apHZbwZ5uYzTYZOSKieAswf1vxywq2XIN7ugiaJrG3ZXyj
   A==;
X-CSE-ConnectionGUID: M+Chl0s1QFKHc4+RwXSNKw==
X-CSE-MsgGUID: PhxQu1kKQjmYcDE/m8Yh3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="73875684"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="73875684"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:15:40 -0800
X-CSE-ConnectionGUID: l3ndoJghTCSmoVRUDrE4IQ==
X-CSE-MsgGUID: rQqMWTNLT8ezc67gIarp7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205709435"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:15:15 -0800
Date: Mon, 19 Jan 2026 10:15:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Message-ID: <aW3oEZ2WSp0JGl90@smile.fi.intel.com>
References: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
 <20260118-lock-impr-v4-4-6c8d0aee8ed2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-lock-impr-v4-4-6c8d0aee8ed2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 18, 2026 at 10:44:31AM -0500, Kurt Borja wrote:
> Add guard classes for iio_device_claim_*() conditional locks. This will
> aid drivers write safer and cleaner code when dealing with some common
> patterns.
> 
> These classes are not meant to be used directly by drivers (hence the
> __priv__ prefix). Instead, documented wrapper macros are provided to
> enforce the use of ACQUIRE() or guard() semantics and avoid the
> problematic scoped guard.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



