Return-Path: <linux-iio+bounces-26731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E32CA3939
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 13:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8E0D300D721
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427E2F0685;
	Thu,  4 Dec 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KorREY45"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750E14B08A;
	Thu,  4 Dec 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850610; cv=none; b=N8gQP/Ncgcpxrq2CiKIw7wccBQFRrw82ChLcgayqvSat6Pk2CSWkRMG0FTWK8J8Tv9Jnqv/it+qkC5rtZqSRo1Kwf/vo7cENxFlGJFnrpLIgeObzhZI3fJuR1VV+aCnIIu03aXXQPX2hakW+QqHhGnBkwPNyD2PWqNUTuE83M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850610; c=relaxed/simple;
	bh=6inq0e2FmKKkP3KPdRjhc30FMHV2FgnbAtWIjjVg8q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZxE0D/a13MLBn+ssHwGpMdZE03oAI2FRO1E+3TXgXjXkn6BKhqicbKji8e1XWu4UQC5quRmiiBHLg6mlSNxKcx8hCNHUZIFYhMpZMkYuRRsKBi/D66RZD/D7mcbXhxJZi4SEHNGQebUZH7PCkDylOZa0Fm9ICfR/OQ8MkfCUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KorREY45; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764850609; x=1796386609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6inq0e2FmKKkP3KPdRjhc30FMHV2FgnbAtWIjjVg8q0=;
  b=KorREY45TIX4YfsR1p0P+ieHjId/QP3k0PNIGVhFLf1E1sAFMYt4DANo
   har0EQRJnUEq87JnJSDjGNPq3iVevlNSFT/OlDEM6J0aBrdgCbZPynQ0U
   r6C2EGml9B8HlrWmvQY/PZvHvT47pv7eVcOtKQPHn2iUbYKMeH42Hox8b
   OKDc6MH7RGGdceTBs2C+J4aab830rAaMZ+9U2xRm1O1xg+MdfgBflMquJ
   1Qg08Cm+H5GdN22YBcCajS7yV7Ks+rT4z+uuMbN0p9VXljnIA2NBULOpt
   ld6nN/Kn/aUz0esV7O8gHqGfBEboFey2bp2lptrEhh7ZDdSwL29kZ5i7J
   A==;
X-CSE-ConnectionGUID: SJZUlX1GTr+jIQCgOVVORw==
X-CSE-MsgGUID: XoVC0nTiQHKhoHlyXJDoDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66905053"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="66905053"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 04:16:48 -0800
X-CSE-ConnectionGUID: T5lJqA2bQ9iHQ2mu6lBXog==
X-CSE-MsgGUID: g9V6bSamQB6zwT2cQ7wQ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="225642441"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 04:16:44 -0800
Date: Thu, 4 Dec 2025 14:16:41 +0200
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
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: add support for ad9211
Message-ID: <aTF7qbjbtYqZCR95@smile.fi.intel.com>
References: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
 <20251204-add-ad9211-v2-2-a1561f977ee5@vaisala.com>
 <aTF7M7NAFJM1OpWl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTF7M7NAFJM1OpWl@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 04, 2025 at 02:14:49PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 04, 2025 at 08:01:04AM +0000, Tomas Melin wrote:
> > The AD9211 is a 10-bit monolithic sampling analog-to-digital
> > converter optimized for high performance, low power, and ease

Also just noticed that this paragraph is visible shorter than the last one,
can you make them approximately the same line length?

> > of use. The product operates at up to a 300 MSPS conversion

Is it megasamples? Then MSps?

> > rate and is optimized for outstanding dynamic performance
> > in wideband carrier and broadband systems.

> > The scale table implemented here is not an exact match with the
> > datasheet as the table presented there is missing some information.
> > The reference presents these values as being linear,
> > but that does not add up. There is information missing in the table.
> > Implemented scale table matches values at the middle and at the ends,
> > smoothing the curve towards middle and end.
> > Impact on end result from deviation in scale factor affects only software
> > using it for scaling. All the possible hw-settings are also available with
> > this implementation.
> 
> 
> Some amendment in the headers would be nice to have,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> + array_size.h
> 
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/of.h>
> > +#include <linux/units.h>
> >  
> 
> You can drop one blank line here.

-- 
With Best Regards,
Andy Shevchenko



