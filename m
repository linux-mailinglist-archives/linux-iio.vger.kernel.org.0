Return-Path: <linux-iio+bounces-9371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FF971353
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 11:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FF01F23020
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0611B29D8;
	Mon,  9 Sep 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdxysrSu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93037172BD0;
	Mon,  9 Sep 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873649; cv=none; b=TF3YsWa9w29rnlg1exkK/EsGSNufxkW2HbElk45JRrKsOV6MlEhRrKsn1wSe2xmVNQlpgmEFRXG8rptD/GyFr5/Otow6tPluIZghoNOraiN9KNzXbt34G8fDvUJIOnfBPcrrRK6oUFGFHurZffWeBs75fDaiHmZHpd+Li1Aw+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873649; c=relaxed/simple;
	bh=hZmEM2eZJrU1S7rE/hRXrfP0Atc4JKeEEEEEj0mN2Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX6pKjQqlQwrMGOXlSgZTcZixZS66Orm9Z/zmBhYDjQGozyepifQYm/XYTrwWwjZzBlXaOKc8BTT/OYGp6kWZbHNa6oSdRwigN2z/WjM/ywonPsYPKVgdAkYPL0x9TLxKJiiTft+5XwXtXjv3a+anzlzvi9Q27BQ95TUknsKYtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdxysrSu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725873647; x=1757409647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hZmEM2eZJrU1S7rE/hRXrfP0Atc4JKeEEEEEj0mN2Ao=;
  b=XdxysrSuBIEhsmJdBXzKvVc45ldasWFNi6vSajbhVcDbOBQZTOEbsbNU
   MC+6VCdUNYpSkfmMv6h/3CIN6n/yyXYmvR42k6WNy9Ic1lZCIPw8vmr4h
   QEaI12byh1nyaHd2amhAUOAi7FxQdUcNAECw1o+NEp+xNrWJufx6HtBNM
   e/83QYScPyyw+r4DtDHj3ooMvH/klKNdUOVviEutDXsZ5L/VbhfoNRBOv
   6HtPpnwOUiiIJ0i4q2Fp9DVwJsIll+neE0XT3UMiqyrh4NnFMyVlNZOXf
   djD8IBYc6B8GqVVsCMhS/ER+nppts9/G2YLlwlC6JwNxGx4xIHActu8Y4
   A==;
X-CSE-ConnectionGUID: ki+l7nZcTBq9qbeYByFHSw==
X-CSE-MsgGUID: XE33DZgFQnGJ2Go7X3irLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="49969732"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="49969732"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:20:44 -0700
X-CSE-ConnectionGUID: 1orrsdTPQwWIvijqGIDG5w==
X-CSE-MsgGUID: HewxhwmmQqSOOnAJQwIkVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66597783"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:20:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snaZa-00000006jPU-2UkH;
	Mon, 09 Sep 2024 12:20:38 +0300
Date: Mon, 9 Sep 2024 12:20:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v2 0/3] iio: Introduce and use aligned_s64 type
Message-ID: <Zt695hJRwiT2RSJT@smile.fi.intel.com>
References: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
 <20240907163752.2eb3be6a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907163752.2eb3be6a@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 07, 2024 at 04:37:52PM +0100, Jonathan Cameron wrote:
> On Tue,  3 Sep 2024 20:59:03 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Instead of having open coded idea of aligned member, use
> > a newly defined type like it's done in, e.g., u64 case.
> > Update a few IIO drivers to show how to use it.
> > 
> > v2 (took only one year from v1, not bad!):
> :)
> 
> Applied with that tweak for patch 2 that you called out.

Please, also do
s/__aligned_s64/aligned_s64/
in the commit message there.

> Will probably be next cycle though before these go upstream
> (so think of this as queuing them up very early for 6.13 :)

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko



