Return-Path: <linux-iio+bounces-28044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF55D3C190
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 09:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB398504090
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289233BC4C5;
	Tue, 20 Jan 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmVZCUJL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E93BBA10
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895938; cv=none; b=YvZ+QHJ9IHTizoqADFGARzF0cVkE6D3VVTiTSy6CWAL9MA5zzFavy0Y3HqErhdHWno72IiydHPidquUP1mE05aOur48Z2DDAaE4DXGltzVVVk6r/6zFA5iC5i5/AY7mwRRB+jKJ6eFYydRcnrg6xsZs9OFi+uRSnHZo5XxtAgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895938; c=relaxed/simple;
	bh=zyf5OurWtwa02A6696+SjYrOMCtyt0rnCh6InYCsdaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJhBvv1x2T07FT0k+zXc8eCItZAqqjlYGu9+uByH5ePp/PO4CeC4vamSv+xT870X3N8fo/U0zXflJdsAPYvdMC20MDsb7sszgLQlgefIzX5fo4E+K3Ap8QoW2S324hRcLzxqn3ABxNtOVsFVZvg+PJaCR6fIqVWoUgamruWfxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmVZCUJL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768895938; x=1800431938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zyf5OurWtwa02A6696+SjYrOMCtyt0rnCh6InYCsdaI=;
  b=mmVZCUJL6JQhWQTuAPWD08HE3oH9blr4NMxBtlYP9ioVuA7oJX0aO3bE
   fPGDGW/7XmtouMHQRKz50GDuVAb5sbZ/Y5Vc70khksnQR1VNgkvXVoCC9
   ZBRcuZPXKF0Q4nF64Q47EUTPBQPbTo7/OI/na+RzErVsirwhNS/G5NFUk
   AFr4OvwZLDzdcsjzpIfD85T7am3U504GKLu6Xw+1I8MC1ABUXtSqwU8Zm
   P91KeafUd00UsC7PEk0WVloFZhSHhWsCg117NaIRy4S8Mx8PJwK+WdD7r
   9Np6rlBx1RbY+kqSXJ/FrFwJtwUkqyG3JMOQB4w1hO9YUBxAUHQYg5HP/
   w==;
X-CSE-ConnectionGUID: zFAazWi9QQ2BMpNZknn4sg==
X-CSE-MsgGUID: 4OT5hF/vTBqAvyfSilcYxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81207316"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81207316"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:58:57 -0800
X-CSE-ConnectionGUID: Oy/owHJYTVyehrYJGd/Tpg==
X-CSE-MsgGUID: xRcXbG+rRGmnsnF+Dl86fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206401355"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:58:54 -0800
Date: Tue, 20 Jan 2026 09:58:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/11] iio: adc: Improve include relevance for some ADCs.
Message-ID: <aW81vM2hglzIOVF-@smile.fi.intel.com>
References: <20260119212110.726941-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119212110.726941-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 09:20:59PM +0000, Jonathan Cameron wrote:

> So this is a continuation of experimenting with IWYU to ensure that we
> follow what I consider best practice in driver by including all
> headers that are used (subject to some slightly fuzzy rules for some
> of them standard kernel headers).
> 
> I was focusing on cases where kernel.h was included and moving from that
> to the more specific headers. That partly explains why there were so
> many headers to add. However, it is also clear that many standard
> headers (mutex.h for example) were missing from these drivers.
> 
> There are a few notes and questions in the individual patch descriptions,
> typically where I have either decided to ignore a recommendation or
> conversely have broken things down more finely than IWYU was doing with
> my config files.
> 
> All comments welcome.  Whilst I don't consider this particular high
> priority (much of it was done in a train where I couldn't access my
> email)m I would like to provide more examples in tree of what I consider

"m"? Bump on the rail that makes your finger slip over keyboard? :-)

> to the right way to do things!

I commented 4 patches, but seems the set of issues I found is repetitive,
So, please address those in all patches and I will look into v2.

-- 
With Best Regards,
Andy Shevchenko



