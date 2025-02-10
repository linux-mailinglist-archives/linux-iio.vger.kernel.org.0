Return-Path: <linux-iio+bounces-15297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 405FBA2FAC0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 21:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BA97A22FA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5624CED8;
	Mon, 10 Feb 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvMPuAJR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A118DF93;
	Mon, 10 Feb 2025 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219621; cv=none; b=MSiiQXoQymmSzgcqFKoerG17UjxLJL3xGaW+9EeVchKQ15UYfb9Pg5xAE/gMNfjl3Yb0HiRu3cPRykXfsOk2czhAdEUTo6CwCg/t0ubZyAce2YYHika+WvKiLFdh9riDx/OADE0r1pyohsLr4w22JDGJAN7afziz9bCfADsN9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219621; c=relaxed/simple;
	bh=lgT0G7o5Dt8OzuR1jekDmhj+5iivZuCrjqm/oRIIbYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo//Ixhp9hBSh49sJoAFSvPGx1Ka4pI7DD1uglDHgqu75OfQ7d+oDgziwEAYxh5MdlFpAPbj1gamGfjcQpBuhh75OBwKVOY8b+amlkFMhV9Wz4maTmFjsArP25mI2v0CRdl6dD9XmxROK26dCUHnY6P+jh7g0Hk1o1BJYgHHNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvMPuAJR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739219619; x=1770755619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lgT0G7o5Dt8OzuR1jekDmhj+5iivZuCrjqm/oRIIbYc=;
  b=XvMPuAJRhdZSTQta7z8qPBHj8zPAH3sQ2Kauppo4nD1ERNhgFTtf4jMI
   KScnLzpb0GyFFkjwaOj4EWZZBCCtLrUiCC7kETIftpclMILmjQVr9EmqC
   ogIoLcDbb71Wyr9y1a5qC2Q1S9z+BZ5mQ8f1KXJ/KROFxny9OPFrINyaP
   A11kQ3APQUMN5w3O50gShucDKgR5iafNN6BX25bWHX12B26KMWXiQe0Z+
   3mxIsl4BWYfLyYLHE40Ob4YnncCZ1xxtw0k5LYCfd43jCvh3fGGIHGx2M
   5ajvWW39a/aU2BkIAdP/Z/1KtzWyyVtH9Qrbl/va6h6Ug7VrJB89cYMb1
   Q==;
X-CSE-ConnectionGUID: p2ploiLsSU25+OiwJ2xr4A==
X-CSE-MsgGUID: CuU+qaHyRca32t8Z8FbOEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="65173738"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="65173738"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 12:33:38 -0800
X-CSE-ConnectionGUID: 4sOAM5SWT0KvjV0QNcbn1w==
X-CSE-MsgGUID: VrWnTj2TRIuOYBuIO+z2ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="143158691"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 12:33:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1thaTD-0000000AIFH-21Z4;
	Mon, 10 Feb 2025 22:33:31 +0200
Date: Mon, 10 Feb 2025 22:33:31 +0200
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
Message-ID: <Z6pim_nLct33LzfN@smile.fi.intel.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
 <Z6otFlsmEikIbI__@black.fi.intel.com>
 <27d2a88c-b44a-4712-b066-b999e41774f0@baylibre.com>
 <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1dcbb19-190a-45e7-8e94-cb5ef65f1f1b@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 10, 2025 at 05:48:00PM +0000, Mark Brown wrote:
> On Mon, Feb 10, 2025 at 11:11:23AM -0600, David Lechner wrote:
> > On 2/10/25 10:45 AM, Andy Shevchenko wrote:
> > > On Fri, Feb 07, 2025 at 02:08:58PM -0600, David Lechner wrote:
> 
> > >> +MODULE_IMPORT_NS("SPI_OFFLOAD");
> 
> > > This diminishes the point of the namespaces. Anybody who includes a (dangling)
> > > header gets namespace imported, which is not good. Same for other globally
> > > visible headers.
> 
> > In this case, we specifically split up the headers so that the only time you
> > would ever include this header is if you need to call functions in this
> > namespace (i.e. struct definitions are in linux/spi/offload/types.h which
> > doesn't import the namespace). So this doesn't actually seem like a problem
> > to me.
> 
> Indeed - I can't see any case where a user would need the header without
> needing the namespace.

You are looking from the other end. What I'm telling is that anyone who adds
a header, automatically gets a namespace. What's the point to have namespace
if it won't easily prevent from (ab)using it in the code. I consider putting
MODULE_IMPORT_NS() in the headers a bit weird.

-- 
With Best Regards,
Andy Shevchenko



