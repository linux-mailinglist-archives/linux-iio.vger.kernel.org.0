Return-Path: <linux-iio+bounces-25414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD150C052A1
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 10:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACA51AA1AC0
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 08:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEE1305958;
	Fri, 24 Oct 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtKgrNZC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3B2D640D;
	Fri, 24 Oct 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295653; cv=none; b=ISehAI5fRO6Brce10LogGXMjclQRE7DtzR5sYmXEVU4qZzXoO6LeOUPCDtr75hMtZ+sG0armN0Rmq7kxsL00Qbj50zDDV61NXzBIFLhR3+qs8x5QRgZHH1ml/t2isgrtdcWsrUGP2HdXjHJwe8V2la0H/oiGv0B7OtD9+ZkQvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295653; c=relaxed/simple;
	bh=ItL3HwUX3mQOlR0jmO7bG+3JhJbzVE20bcx4/PFrwe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPvpA5hkQ6Ji7I0Auo5/8aSf+kE7034aFoDeuYT7lB0BDJBFj0G8+hwtXcCaGBIbKd3eStviAQKzjUs+opioaKqgrvoMsz40gmJKqzEk2UAaaFiWU4HcYaaEDKU5v+dwkBjF6kpWhW++lfu4vC0fwatARrKnHop2IQMdlrsCQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtKgrNZC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761295653; x=1792831653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ItL3HwUX3mQOlR0jmO7bG+3JhJbzVE20bcx4/PFrwe4=;
  b=CtKgrNZCeJgd9JfeJbH66Y7dlbEvka59UIpdqvo18ICU8GqoOqWFYvPT
   8gSzs8dgw3zfUe6+cwWSrdETzybMBZvXZ7IpzRLtueS3zgdS68bwKllY4
   6M0MDtVy0dU03cDbeCHK8gg28MZz4RHky3H0C66rbtehLE7kRrIjUriSs
   P+kBrDEjrOBhmKgycTzfaTfYIRibNtP+tjx4eYwcbJlqXfIMlHZJs6+N6
   4+HcDroURKQCdKBz5qao6K5LkhNdtqZfKPYcr6uMytQXArEPDLp6Gqkmc
   Qi93bQJVISIHuGLNr1C4piK6w6jgjSwmSfBRuNrDqmDxxGFG4GbvBLU8i
   g==;
X-CSE-ConnectionGUID: ldijfceWS/m2qeLyjnbvgg==
X-CSE-MsgGUID: xvR+EfYvTKOjfcTj1Y0sLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67120439"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="67120439"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:47:32 -0700
X-CSE-ConnectionGUID: Vq3kYvgSReaaTsSq7YMbQg==
X-CSE-MsgGUID: yV2kuODqQvCiRogo7q4h6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="183986609"
Received: from opintica-mobl1 (HELO ashevche-desk.local) ([10.245.245.60])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:47:29 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vCDSH-000000026dm-2uGy;
	Fri, 24 Oct 2025 11:47:25 +0300
Date: Fri, 24 Oct 2025 11:47:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	subhajit.ghosh@tweaklogic.com, javier.carrasco.cruz@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: light: apds9960: convert to use maple tree
 register cache
Message-ID: <aPs9HdeTZKoqFqdk@smile.fi.intel.com>
References: <20251024073823.35122-1-chuguangqing@inspur.com>
 <20251024073823.35122-5-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024073823.35122-5-chuguangqing@inspur.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 24, 2025 at 03:38:23PM +0800, Chu Guangqing wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.

...

>  	.reg_defaults = apds9960_reg_defaults,
>  	.num_reg_defaults = ARRAY_SIZE(apds9960_reg_defaults),

^^^^ Be careful with such cases, the cache implementations may behave
differently. Have you tested this on the actual HW?

>  	.max_register = APDS9960_REG_GFIFO_DIR(RIGHT),
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  };

-- 
With Best Regards,
Andy Shevchenko



