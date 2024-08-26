Return-Path: <linux-iio+bounces-8787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA495EE30
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4319B20C53
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC1146A6B;
	Mon, 26 Aug 2024 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dT11bOid"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE5146A71;
	Mon, 26 Aug 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667178; cv=none; b=k4+ahsY43v5j8IonwrGTT/zzXwgJ630jDAaATjA2NUM5QrkGFoPgtrey5ejDt8A4Uo4oT3H9CsIhJ6tcj+gnRRm8YAbBOXh2Phs9IctSs+U1gL647//2zmaD+IkZeIjzdSjLyGpUEhJK8S7Fj2Lm0gP/6lsh84wLvK+yXBiSNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667178; c=relaxed/simple;
	bh=Um2oUufsq5SYlu4nyvLw6FGEmfUYMQ4wO8GqEDGg98o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1CII05eN4YDo/OsO97r0fZo8BPETyxzKXf7ov0Cpb1F9LO8ZaV/Bm2izp62y211HYEU5bpdKLQ3DtDhXFVzd3Ab2lTsMfbcBjwJTiNqD2AZWuG4nyFFzPdDp8Kk2xk65JViOZZIvLp6h31ZP+ROnhV1MNzVCu2eXzovUUy0BtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dT11bOid; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724667176; x=1756203176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Um2oUufsq5SYlu4nyvLw6FGEmfUYMQ4wO8GqEDGg98o=;
  b=dT11bOidNbP8M9/p8UUa287IqRJELWvUpCE1WO0PCPydgKC/T7UswU7O
   1ZrCpBd5kCVjIn/PltcYJ92TH6Nf1DrbVAnc93jV01BGhzdyrnljYjuKH
   5BrhqqwllKjCyqMd6lmLCzu9FjE6tPu7ihTtaYLifpYQs8BiE1CF0dCiz
   bYjxwSCgjwqixU8QPjk6KI4tIOVLs0AmugAIFhd1I9f3mt08Bfk7mdfa2
   DpoP65EuiZr7HDdUwBZERtmsX3pW5evihM9DnDwcnqhTR5pLuvCsXzNNH
   ZCMynms3WCzMu8onQZuUGnyWPbFf8tmsz5CtURAKDLNp2SilKG/uxI0ZF
   A==;
X-CSE-ConnectionGUID: 4LYggGndT2u80+ZrZP8PpA==
X-CSE-MsgGUID: yURbHQM7Q3qWk6tn1I7GUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="26844542"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="26844542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:12:56 -0700
X-CSE-ConnectionGUID: nw9oOquMQYG540OfJTKHcA==
X-CSE-MsgGUID: +clD/V5tS2iJW4gq63RHzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62769318"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:12:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siWiN-00000001pOS-3Geq;
	Mon, 26 Aug 2024 13:12:47 +0300
Date: Mon, 26 Aug 2024 13:12:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iio: pressure: bmp280: Remove config error check
 for IIR filter updates
Message-ID: <ZsxVH3TG2vs38Brw@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-4-vassilisamir@gmail.com>
 <Zsjf0bVLZyPqBxru@smile.fi.intel.com>
 <20240824111806.GC9644@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824111806.GC9644@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Aug 24, 2024 at 01:18:06PM +0200, Vasileios Amoiridis wrote:
> On Fri, Aug 23, 2024 at 10:15:29PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 23, 2024 at 08:17:10PM +0200, Vasileios Amoiridis wrote:

...

> > > +	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
> > > +				 BMP580_DSP_IIR_PRESS_MASK |
> > > +				 BMP580_DSP_IIR_TEMP_MASK, reg_val);
> > 
> > Better to split on logical bounds
> > 
> > 	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
> > 				 BMP580_DSP_IIR_PRESS_MASK | BMP580_DSP_IIR_TEMP_MASK,
> > 				 reg_val);
> 
> This goes beyond the 80 char limit. I know that there is the relaxed
> limit of 100 chars but I didn't feel it was more readable like this.
> I could definitely use it though, thanks!

The readability has a priority over that limit. That's even mentioned in
the documentation besides the relaxed limit.

-- 
With Best Regards,
Andy Shevchenko



