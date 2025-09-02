Return-Path: <linux-iio+bounces-23639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2A3B401EF
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C866B16384A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3422DCF68;
	Tue,  2 Sep 2025 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvNq3hDF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417882C11D4;
	Tue,  2 Sep 2025 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817964; cv=none; b=rk6CYU53lybBFexvTHgryHsQ5/aQxFbMirOdIjUgeepIbsXW7buGERK1OQ88ZFCxTE+O6j6OiNpGpp5P7v7rwo7mKir0uYc5MMUjxkYJkZkc+M3g1wY0cSdoQJ71+lNmcNrA+OpYDIdOAhpbno+3RK+UeCkDMK0UJ/f7MobKZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817964; c=relaxed/simple;
	bh=lrXuJGoew7/20DuMI3I4U1Q/blFgeVjzOk5OW4cyrDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMzQi6fmEdqk8IgBpENMJ4RCHfxJzzCanjUKG9bKiBR3GxSLGrEmHuu0xa09VUUFxotxp+vW3FtwRff1j9Zew9RMWWXV5QV22kA0gJs5mbp25B6ElN3c/wM4smnYSRaV1wcN1ISgkvqfqEHELHa7GumCGehPHq1w0cwRwaDFe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvNq3hDF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756817964; x=1788353964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lrXuJGoew7/20DuMI3I4U1Q/blFgeVjzOk5OW4cyrDQ=;
  b=RvNq3hDFsebsEXmd14+ODfE7fKPJ6WyoPHqoWNFmCwQAKHhNoJGCW0wj
   S6APph8l5DB+F0Qb9T9kZmAHXbWoQJTagYTuXu6mhS9tN2f/1+NDETFA/
   RLLLsz89EU+PsoDGXhzB6ljdP5nEfX3ian6K1+Lg/nt4go6ctDhsOvg41
   PFTNeiWeGDw9UQwJmRY9pi75Z3IELPOlMixf8Sw1qmaqGeAJPqGU2LOkn
   +Dp5ozTEbWhbbG5GjNNizHnLhP/SnPO73mVbTu57LvoDDHo82aen4SeGm
   wclVF2l63VCAHoyYUg3+ax76qLROwnbaEu/nkKQnzIXSST3dlTzOc/lwD
   Q==;
X-CSE-ConnectionGUID: vQqJ8SW8TQqCN8HQnQr2ww==
X-CSE-MsgGUID: 0PNILCZpREihsothrUAzvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81673155"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81673155"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:59:23 -0700
X-CSE-ConnectionGUID: lAds/XvmQ/msUDGur/e9rA==
X-CSE-MsgGUID: 1bwSlHvrSweky9brJC8f9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="172110180"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:59:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utQbV-0000000AhJh-3mx3;
	Tue, 02 Sep 2025 15:59:17 +0300
Date: Tue, 2 Sep 2025 15:59:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: ltr390: Implement runtime PM support
Message-ID: <aLbqJfGiHWNhXfgx@smile.fi.intel.com>
References: <20250901184238.34335-1-akshayaj.lkd@gmail.com>
 <aLbptFRh9ZvAVfLn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLbptFRh9ZvAVfLn@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 03:57:24PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 02, 2025 at 12:12:36AM +0530, Akshay Jindal wrote:

...

> > +		if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > +					LTR390_LS_INT_EN) < 0)
> 
> Wrong indentation, hard to read line, either one line, or do better. Actually
> why not assign it to ret? The above not only simple style issue, but also makes
> readability much harder as the semantics of '0' is completely hidden. This style
> is discouraged.

Noticing that this is existing style I recommend to have a precursor patch to
fix this and any other place like this first.

-- 
With Best Regards,
Andy Shevchenko



