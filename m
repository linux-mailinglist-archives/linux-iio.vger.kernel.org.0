Return-Path: <linux-iio+bounces-28039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BDD3C077
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68395408187
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D733A0B3C;
	Tue, 20 Jan 2026 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhKzMoSh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A6397ADA
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893828; cv=none; b=agCLprS1vM8bDxD2CW9csgV7Va3dzlFkIQPPCq0NB8d8thb0p4FGG1s2AXf2rR2iiD3erCGiCrGbekMkDV2vP/wLf5Iz3aiyukHbb4NTmv217VkV8a2TF4/Pf4GRFinAN3jnFj/sCa73ipiIcm25WMCmixOO3Rmiz/xFtji0MkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893828; c=relaxed/simple;
	bh=ToB9JC3di8WQ0mOGsAW330xpBU+T4LeN1r1CTZ9MVfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjFwOk/EK1GPJ0AA4EzkG2avoU+secpc9UP0nFLjQ+uBb274LBjz3uk94OJJ3W/PF7ZGWju5jmcxk2yXGWfLzo0SvEx9hjZ4K6kZIX/aS3aFG3eZw+x9tYbGA3S1nKJZo2nd6quIhtP7AzaPcNJqQegYiniAhbFjDYNPcukMa0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhKzMoSh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768893823; x=1800429823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ToB9JC3di8WQ0mOGsAW330xpBU+T4LeN1r1CTZ9MVfE=;
  b=ZhKzMoSh2jkIrAJTQJMMn9xDoKu0dCrfuuf0b1snHvrFcNbFaCGpuXXI
   wLqd0R9Sk4n1csZhYpzu+VA/9w4nAr4cUTPG252wdROFC1WYr26vLdYSq
   /DlvddyRISMNlfegOql6G/TiryJdRGjC77ANo+ZAL0fx8oFsDOvn+cUSo
   nG8Rqqz3LZoIf96TjdSiusAdm7Q3WCihGylJu3n5yyPLSpmmlsHj/RN8q
   w3OWFl6AkJYEaJ8ZL7pm9qtXficiXq6F3TOQWM5ByPr4hB0kAFi5O0vbQ
   sukRvxyAg564msYBUYQjpvpPRP3J1zxfbdUC7ikjI3M5FfaB2oUCgTUQy
   Q==;
X-CSE-ConnectionGUID: fkROeQz7Smq1ZMt5Do0S2A==
X-CSE-MsgGUID: DhS6v/2NRJKv6RvPKcBTDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73960702"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73960702"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:23:39 -0800
X-CSE-ConnectionGUID: FZmwv9mzR5+2VmJkzx9rQQ==
X-CSE-MsgGUID: ++kLjiHQQU25qEbJWhtO+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="228975020"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:23:37 -0800
Date: Tue, 20 Jan 2026 09:23:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: magn: mmc5633: Ensure REGMAP_I2C / I3C not
 build if I2C / I3C is not.
Message-ID: <aW8td75ZhKd1mIMW@smile.fi.intel.com>
References: <20260119221736.804825-1-jic23@kernel.org>
 <20260119221736.804825-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119221736.804825-2-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 10:17:35PM +0000, Jonathan Cameron wrote:

> Fixes the following build warning (and equivalent I2C one)
> WARNING: unmet direct dependencies detected for REGMAP_I3C
>   Depends on [n]: I3C [=n]
>   Selected by [m]:
>   - MMC5633 [=m] && IIO [=y] && (I2C [=y] || I3C [=n])

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



