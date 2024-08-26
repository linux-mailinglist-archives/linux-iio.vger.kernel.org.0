Return-Path: <linux-iio+bounces-8792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EDF95EE73
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BBE1F22E07
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F211487FF;
	Mon, 26 Aug 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2AMVLze"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DB142E67;
	Mon, 26 Aug 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668005; cv=none; b=MnJdPJOY2+0cJ0yVR0rxKKBGQCxhYj8YcIvR/r67Q6z8STsUpXistH5T90v1gSq53XfLB+23QltHj7qXpRiVUCLhDhLSoS6ZGpvPbHD3JfXvVnA7hJDNNZgaMVtgEwVAqTZCyDqUCKZBoZTLavQIEMdgta8tfWTnbzQs+mfjyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668005; c=relaxed/simple;
	bh=E2EVLfqg8B+gRGm5PmIrhLBiMdMG7xF7LLPpViapmaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdKeHKlk7caS03WSAg2TGLME0FhUpm0qF46y53MKAqq6FJERTV3CeUbwsEdC+dakMz76i8JwDUYg3SRy2AW3EHabGvFroHdBjI0MWtlItOcUS6/sZGkE9UMEEjfVhSBMySK4ZhORgXuxM5ZsXD+5zq8OAF7JnPyY6ONaCm3BE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2AMVLze; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724668004; x=1756204004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2EVLfqg8B+gRGm5PmIrhLBiMdMG7xF7LLPpViapmaM=;
  b=g2AMVLzek8D5uOTjiyvM/tU9e+8e09rMpzwRiXJKt/QUAnSZcQFkPNr/
   oshbawyX0maScyotPhzLuwmCYePwVNgxREgdW8go3i8108sKCe6VFZ/8u
   1gHKlk5ijYxnqVkrswP2Ioy1rukbAtzENUmjI1OQb97OjXl1r79ZLu52n
   Vw3pLBdooJYrelf4XsesGSM6c0zy8uxXbJC1QMdD/Qp0U/mTjtNBZRdH2
   lhK+Z3LgJ8y3R1D5tPnwdsvMWEj7h1qqqc+1YFjuY02gHGLQL7hRPmTUj
   hb2/HkB+rsI+UL/hSuLDscbeTg/bOhF9ifm3Y3cKsjSu8GQKR7oayuaUA
   w==;
X-CSE-ConnectionGUID: umjmUsCORkiZgZG2QSc67Q==
X-CSE-MsgGUID: Bq56zMJXQVqEILREKxDJbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33702420"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33702420"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:26:43 -0700
X-CSE-ConnectionGUID: VK9kzEA2SlqkEQ2skkneEw==
X-CSE-MsgGUID: MTojxkx/QgmS2RPgKQzzzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="66640113"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 03:26:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siWva-00000001pbI-0IVY;
	Mon, 26 Aug 2024 13:26:26 +0300
Date: Mon, 26 Aug 2024 13:26:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <ZsxYUV_GhYHNtyCk@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-7-vassilisamir@gmail.com>
 <ZsjrxLlhmx-TzwXF@smile.fi.intel.com>
 <20240824120222.GG9644@vamoiridPC>
 <20240826110150.5f2e5c72@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826110150.5f2e5c72@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 11:01:50AM +0100, Jonathan Cameron wrote:
> On Sat, 24 Aug 2024 14:02:22 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > On Fri, Aug 23, 2024 at 11:06:28PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 23, 2024 at 08:17:13PM +0200, Vasileios Amoiridis wrote:  

...

> > > > +	fwnode = dev_fwnode(data->dev);
> > > > +	if (!fwnode)
> > > > +		return -ENODEV;  
> > > 
> > > Why do you need this? The below will fail anyway.  
> > 
> > Because If I don't make this check then fwnode might be garbage and I will
> > pass garbage to the fwnode_irq_get() function. Or do I miss something?
> It checks for NULL which is all it can actually be and returns a suitable
> error code if it is.

Actually not. It may be NULL, error pointer, or valid. So, for a bare minimum
this check is not full (and again, fwnode APIs should validate fwnode before
accessing them where it makes sense; if fwnode_irq_get() does not do that or
misses the case(s), it has to be improved).

-- 
With Best Regards,
Andy Shevchenko



