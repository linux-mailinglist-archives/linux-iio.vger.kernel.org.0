Return-Path: <linux-iio+bounces-25749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A0DC25143
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CEF734D8B4
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240C34C819;
	Fri, 31 Oct 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UelD8j+/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05904348889;
	Fri, 31 Oct 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914739; cv=none; b=D9qtHHbrU8htqNWaMB62Bv38Rb8ECExvwgzGjqZAGSMrh6sZoPSthV9ADP6MDhRVPvR/ruAqV4jsn0thMibW0uVNw7zvGQ/0aghyNwOEeGdmwuo/wWkVhtmyM63qp1EdlSvVnOtbp8pGwlq7JCiFCkMj81zEFk0ORIqzF/HIX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914739; c=relaxed/simple;
	bh=Z3DtaplncQCwf1eaBkhUb+bWO6Ge80YXZRoSm6Dj8vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1VEi4XZaLB6neQTxhZz2HjSDK0iqmEPILbD7qqXdhQdz8gqPMF9rmFo/D3Kvd7pbGST2gZlZ8Ko5dnqM9YYQrnLQ0YJcwsBeM4RP3Bls2AbrJug7oMON3GaR8DmjNsSVlMZWx8rOvFmQP5LVlOoFTGqukTWdamrPLuhmrpkTLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UelD8j+/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761914738; x=1793450738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z3DtaplncQCwf1eaBkhUb+bWO6Ge80YXZRoSm6Dj8vA=;
  b=UelD8j+/gdTSDY/JcKBA38nFGcyCiZ86Ndv6ZLtKoQosAvvKDgIKzSSy
   iaeymij9smCz83piXizgpiHIS8vj+tJg8JydGeO/643iftflmiRKHq3vI
   eNk1EbgMwmC46bsSQPRqAX+Gn7+siWi/5d8ObVP1t54EbbFA/RsqdDf5f
   EH65NxcLP/sYvDyS4hXMoT4SZ6H48+u3X64yWjgf093Fum8mJaLnJg1Kl
   uPVbMev4amxvpA9nbskYDocBD0pk65l9CBwjVDvvPnORKNraFRry8wb78
   ngFjXAKIy4aAYE0nbWxPjduAkG3pOjf2sDogH65BY3ukbg+kl0B25TqI4
   Q==;
X-CSE-ConnectionGUID: GMCwTKQhTiCRpezPs0YyIg==
X-CSE-MsgGUID: UCch8fogQzGC/67X/EKF8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67729988"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="67729988"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:45:36 -0700
X-CSE-ConnectionGUID: nALomowwSlS9F5TSN9uSXA==
X-CSE-MsgGUID: YQ/DdgXgS7aMgSwnPC7IBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190575543"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:45:32 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEoVS-00000004GOn-265I;
	Fri, 31 Oct 2025 14:45:26 +0200
Date: Fri, 31 Oct 2025 14:45:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, linux-iio@vger.kernel.org, s32@nxp.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v5 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <aQSvZT73NBWZFVfk@smile.fi.intel.com>
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
 <aPP0uVZu1T7tTQGo@ashevche-desk.local>
 <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
 <aQMvqHGN7r6babgw@smile.fi.intel.com>
 <c4c14051-2ba2-4d80-a22d-4deb3709f727@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c14051-2ba2-4d80-a22d-4deb3709f727@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 12:32:03PM +0100, Daniel Lezcano wrote:
> On 10/30/25 10:28, Andy Shevchenko wrote:
> > On Thu, Oct 30, 2025 at 09:27:21AM +0100, Daniel Lezcano wrote:
> > > On 10/18/25 22:12, Andy Shevchenko wrote:
> > > > On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:

[ ... ]

> > > > > +	dma_samples = (u32 *)dma_buf->buf;
> > > > 
> > > > Is it aligned properly for this type of casting?
> > > 
> > > TBH, I don't know the answer :/
> > > 
> > > How can I check that ?
> > 
> > Is buf defined as a pointer to u32 / int or bigger? or is it just byte buffer?
> > If the latter, how does the address of it being formed? Does it come from a heap
> > (memory allocator)? If yes, we are fine, as this is usually the case for all
> > (k)malloc'ed memory.
> 
> buf is a byte buffer allocated with dmam_alloc_coherent(..., GFP_KERNEL)

We are fine :-)

...

> > > > > +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> > > > 
> > > > No return value check?
> > > 
> > > The return value is not necessary here because the caller of the callback
> > > will check with dma_submit_error() in case of error which covers the
> > > DMA_ERROR case and the other cases are not useful because the residue is
> > > taken into account right after.
> > 
> > In some cases it might return DMA_PAUSE (and actually this is the correct way
> > to get residue, one needs to pause the channel to read it, otherwise it will
> > give outdated / incorrect information).
> 
> But if the residue is checked in the callback routine without checking
> DMA_PAUSED, the result is the same no ?

DMA in some corner cases might have already be charged for the next transfer.
Do you have a synchronisation between DMA start and residue check?

I.o.w. this may work for your case, but in general it's not guaranteed. The proper
read of residue is to: pause DMA --> read residue --> resume DMA.

-- 
With Best Regards,
Andy Shevchenko



