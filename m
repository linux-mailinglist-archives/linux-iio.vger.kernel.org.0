Return-Path: <linux-iio+bounces-26946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE23CADBD4
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 17:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0460A305A122
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3AC2E62DC;
	Mon,  8 Dec 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1VR9hAK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4391E832A;
	Mon,  8 Dec 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210993; cv=none; b=lGAhPjrVO6Mj3Qqq/hNZYwfuZ9eq1z+84TkDIds9mxRyA5cZPboceNC+8sqv9ISXTf9ubA4W8Q/3m0Nw4ae4GPDFKlCRFvHbuWP+zFi6S/mIuAQxI3Ehb2RX0KfVGhnHaysE4ubg9ib+73eMHFKilt9F2LX56dJZz7qw3bJf74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210993; c=relaxed/simple;
	bh=YHaPhBjVZyrDLC4wOyU9I47VL2HJA5p0l0dQ6jXjxOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVSLA4pAtVXqtHmBZ7yXCmyBtNuZVsu19z/nZeLo/pbBK+27juUdie3hIdbjDL25Qcy5YuiCxESNdaVAEoq7S3QqN0zlfdg5eImR7+R4QaJ58R/M4SbGLemCYeQ6AY1c0P/scmlySPT860Iwi88WztTp22muCiVJnWh0d15n5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1VR9hAK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765210992; x=1796746992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YHaPhBjVZyrDLC4wOyU9I47VL2HJA5p0l0dQ6jXjxOc=;
  b=Y1VR9hAKNBPid9K7FW3cCzwQcYmW7vtq8/+jjhPTwyTc5Rq3203y/Fl7
   jsqqrIfd3A4OC3ZDWkp/4h7qpu/xbLvGFM/lYalYrOQYgVgBB6BaDoW1B
   csi/EIJBXvFb/wTwXl3CCLXCCbLHcCHQqUjCV8OE2oClXaD2YCpIJhOEI
   xpsDWVRXI8EfADNIPuDHOgBModUlsP5+0iRG15GNLRQr16kL4ojSXLvOm
   u3B1NoX4TxWxsNBPQVlPOj+7rlAZtRQTKeU4okCDPFQwyBrXJ6236swTT
   ulFQfUyQoE/iGSNjv5iXsqDdQv8qxD37IZjjzRVTZczwT9grcZAgUgpzy
   Q==;
X-CSE-ConnectionGUID: 4wPFPVVgQY2wXqb7B1hXag==
X-CSE-MsgGUID: o7N+euajSoSzLAIJvsBuBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67234434"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="67234434"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 08:23:11 -0800
X-CSE-ConnectionGUID: YnMc16itTIudMiyToPaY/Q==
X-CSE-MsgGUID: WHgwaL+eQhWDDWNQzFQvTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="200420731"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 08:23:08 -0800
Date: Mon, 8 Dec 2025 18:23:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: ad9467: drop kernel.h in favor of
 array_size.h
Message-ID: <aTb7al6d5SBQBp1P@smile.fi.intel.com>
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
 <20251208-add-ad9211-v3-3-c49897fa91c4@vaisala.com>
 <aTbQmOpMfQnYkeLT@smile.fi.intel.com>
 <1467f6e5-9d50-4b51-a283-aec19c031470@vaisala.com>
 <aTb1vEEJRY6Uom2l@smile.fi.intel.com>
 <905d3a14-1e78-469f-99f1-4c1d2299d97c@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905d3a14-1e78-469f-99f1-4c1d2299d97c@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 06:21:25PM +0200, Tomas Melin wrote:
> On 08/12/2025 17:58, Andy Shevchenko wrote:
> > On Mon, Dec 08, 2025 at 05:41:20PM +0200, Tomas Melin wrote:
> >> On 08/12/2025 15:20, Andy Shevchenko wrote:
> >>> On Mon, Dec 08, 2025 at 12:30:59PM +0000, Tomas Melin wrote:

...

> > If you don't feel going that deep, than it's a (small) problem.
> > 
> > As the author of a driver feature one should understand slightly more about
> > this (yeah, currently mess) header stuff. So, your first patch should add
> > missed headers, if any, that's required to your changes, this one can be
> > omitted after all.
> Well, I think reworking the headers is a sane idea, but it is not the
> topic of this series.
> 
> > But on some day you will still need to understand a bit more about headers...
> > 
> > TL;DR: make sure you have all needed headers for your changes in the previous
> > patch and drop this one.
> 
> Hope we mean the same thing, I was thinking more like
>    1. sort current headers
>    2. add feature which adds the new header in correct location

Sure, it's even better!

-- 
With Best Regards,
Andy Shevchenko



