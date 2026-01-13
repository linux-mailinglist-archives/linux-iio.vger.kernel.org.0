Return-Path: <linux-iio+bounces-27680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20342D1B57D
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 22:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA673031A3A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 21:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C82FDC35;
	Tue, 13 Jan 2026 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWUZyxkN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0375727EFE9;
	Tue, 13 Jan 2026 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338290; cv=none; b=E4ur2sBv/0DgrL0+2oo1AKtvKwo4bR7dHHzLY6KgNceEOSi8B3l2cWYpnDIR5lZ41+9kiV2BU2HNF+OXP6ux7Sbppwl47189t1Z1qNJoif5KJ/Mhz7N44VzIdh5pPvAdrZj2HeVf5K2WDpc7agucrnqJjK+qyqi1xd6hPaU2O60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338290; c=relaxed/simple;
	bh=boZoVT4+mCWWpRpzLj2Z1pctQ32lyBjzaMK108g/Wwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWWAdL9KU4CeY8wrymucBfi4BqGfnruOKemUrQBWJamewFtuNqsZbDY3woI5OpZuLNAQ+aTRMh0bGy9/BlAA2t4JSDNmuYAo+3OcFS32pnOi0bEkgMxoYx1Izc8ICwVQRN/av6u4/j6Lo1Mqm7wXM4+seTLI6DaEwzPmZ2k4fGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWUZyxkN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768338289; x=1799874289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=boZoVT4+mCWWpRpzLj2Z1pctQ32lyBjzaMK108g/Wwo=;
  b=FWUZyxkNDK5p4iMgkfgzpR4qZNDBUzHa2ZsSQakcBgcUoqz8LLhmBtO6
   BM3ha+7k1+bxbVXeg59JZq4dkH66kepZURFEfOSEv1Y+tkp7R85x4yOzM
   y7kJFmOE6bCndmEqE9MXmLg3zJWzpOurX799sMifub3DSYuoqPlYd+AAT
   Im27idj4WiUqkPoAt+/Qw5gkMRnvwAjLLd4nIMzNtLB4kK8FrkFRu5Clo
   CDcMyWrA/TyOtxztS6/hir9bbJdPqs6zkZdvwzPhsCxpxvGKQC11tgH06
   jzsBjETglbTz6/x752LHMwUVKMjTGtuyJCO90M2hdP3AJ6jmSlfA97wRq
   g==;
X-CSE-ConnectionGUID: veQOVReATlukZwU86GShWQ==
X-CSE-MsgGUID: rKbjbPaTR+auRV+qCGUBJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80282235"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80282235"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:04:48 -0800
X-CSE-ConnectionGUID: 9UoUCc8mQgWn2+TJvwHlag==
X-CSE-MsgGUID: br2VLYV5SmacBgTeT6rAfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="209538598"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:04:46 -0800
Date: Tue, 13 Jan 2026 23:04:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ad9467: include two's complement in
 default mode
Message-ID: <aWaza9cRb0kpsE0w@smile.fi.intel.com>
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
 <20260113-b4-ad9467-optional-backend-v2-1-0a27e7e72f41@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-b4-ad9467-optional-backend-v2-1-0a27e7e72f41@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 13, 2026 at 12:12:47PM +0000, Tomas Melin wrote:
> All supported drivers currently implicitly use two's complement mode.
> Make this clear by declaring two's complement in the default
> output mode. Calibration mode uses offset binary, so change the output
> mode only when running the calibration or other test mode.

...

>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>

Side note: bitmap.h implies and guarantees all bit ops to be provided. No need
to include bitops.h when bitmap.h is present.

...

>  #define CHIPID_AD9652                   0xC1
> +#define AD9652_DEF_OUTPUT_MODE		0x01
>  #define AD9652_REG_VREF_MASK            0xC0

Another side note: The other definitions around (mistakenly) have been indented
with spaces. You can see the problem in the diff.

-- 
With Best Regards,
Andy Shevchenko



