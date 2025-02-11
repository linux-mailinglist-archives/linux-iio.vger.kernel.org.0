Return-Path: <linux-iio+bounces-15344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48393A30E36
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD4C1620B8
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F0E24F5A1;
	Tue, 11 Feb 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLLsAQSA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6AE26BD8C;
	Tue, 11 Feb 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284182; cv=none; b=pO0Ad/OH4B4Ma8nOYLyRb1DYzDwlThMM+kEShepq+pRHGmSJ2vR+NIQWJyhq1FgNKGz6n0A/qPWd/kdR5Kx3sDQoWIshs2ekljK3z3Q7tSfobQZS1Ot83x4115m+jYAupTGXeh/Lp2hpVeSBylHMVHvMJBIbVsaXlOt9udAaarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284182; c=relaxed/simple;
	bh=GX7isxsCQ32DZ3Dm0bollke6lgD0HSw/I+es+Fu11v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZKWXV2gJPR4Fp7fywWWyQ9Re/C22TGscf0swH6sEXxm4N9GQLvSXNOCcMjK1qwYKfG3JZbKUyw8L/Vly5bkzocJ224zumNrbWcmt1bgwT5dKDcZhPoDlEu+nE/Wv3bgExEWPwoZEhZqLKcb7gAGrG5Iyb+qevp+gMvFzFSq8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLLsAQSA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739284181; x=1770820181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GX7isxsCQ32DZ3Dm0bollke6lgD0HSw/I+es+Fu11v8=;
  b=WLLsAQSAvBzm8453wNuPww5ijHcSL6a3mgs7ad9SCEsXRh70LURcUe0H
   LNL9iYeY7zRTSjErYc8CA63BDYKJ/m3tuPJjPRGOvU9oEmVUTEMUASQ3g
   /IsT8xRzO7ZZVPkLgP23FvvdHW8A/obKYy6bKaohx6VIS5dqb1sxJI5S3
   memkh7StOxW/BVRxjoqQsK+ILUVeuMnMU4tKZqv+Jgo6B1H0np1mXaqUo
   kotN/3jMmv7HXuf8wUK30GtXGZNQgSadodZ8VBiPewb6uaZy/mtFV0qla
   PtIRHCFrflPLgZWWqpSdXUlSjIJR/Qh+Qt2KNGGGjQxra8wDbW1MuRLMR
   g==;
X-CSE-ConnectionGUID: cVgKBAl8SimDr+vhASWzmQ==
X-CSE-MsgGUID: +eH0ReMmTeqq8k8E+bcxjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43664759"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="43664759"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 06:29:40 -0800
X-CSE-ConnectionGUID: CALkFnfJSeuryWovraXCwA==
X-CSE-MsgGUID: Syg4yTHdSlGZNXNyFW53NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135775513"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 06:29:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1thrGX-0000000AWot-1o2Z;
	Tue, 11 Feb 2025 16:29:33 +0200
Date: Tue, 11 Feb 2025 16:29:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 01/17] spi: add basic support for SPI offloading
Message-ID: <Z6tezVXVxVCwXuds@smile.fi.intel.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
 <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
 <Z6pim_nLct33LzfN@smile.fi.intel.com>
 <b000d3fd-754a-43e8-ab10-82677eeee1d2@sirena.org.uk>
 <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6tcwg7QgQwytoSb@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 04:20:50PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2025 at 01:00:08PM +0000, Mark Brown wrote:
> > On Mon, Feb 10, 2025 at 10:33:31PM +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 10, 2025 at 05:48:00PM +0000, Mark Brown wrote:
> > > > On Mon, Feb 10, 2025 at 11:11:23AM -0600, David Lechner wrote:
> > 
> > > > > In this case, we specifically split up the headers so that the only time you
> > > > > would ever include this header is if you need to call functions in this
> > > > > namespace (i.e. struct definitions are in linux/spi/offload/types.h which
> > > > > doesn't import the namespace). So this doesn't actually seem like a problem
> > > > > to me.
> > 
> > > > Indeed - I can't see any case where a user would need the header without
> > > > needing the namespace.
> > 
> > > You are looking from the other end. What I'm telling is that anyone who adds
> > > a header, automatically gets a namespace. What's the point to have namespace
> > > if it won't easily prevent from (ab)using it in the code. I consider putting
> > > MODULE_IMPORT_NS() in the headers a bit weird.
> > 
> > Sure, but there's no case where anyone should ever be adding the header
> > without adding the namespace which does rather sound like the sort of
> > thing where you should just move the namespace addition to the header.
> 
> $ git grep -lw MODULE_IMPORT_NS | wc -l
> 651
> 
> $ git grep -lw MODULE_IMPORT_NS | grep '\.h$'
> 
> drivers/base/firmware_loader/sysfs.h
> drivers/iio/adc/ltc2497.h
> drivers/pwm/pwm-dwc.h
> ^^^ These ones are probably fine as they are not in include/
> 
> include/kunit/visibility.h
> include/linux/module.h
> include/linux/pwm.h
> 
> I believe these three are misuses of MODULE_IMPORT_NS(). Because one may add

_Ttwo_, of course, module.h provides the macro :-)

> a header just as a "proxy" one (copy'n'paste, for example) and we know that is
> real as we saw a lot of code that has semi-random header inclusion blocks.

-- 
With Best Regards,
Andy Shevchenko



