Return-Path: <linux-iio+bounces-25659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6AC1F497
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 448314E96EF
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB189340DB8;
	Thu, 30 Oct 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NduRzxun"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464F340A59;
	Thu, 30 Oct 2025 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816497; cv=none; b=Rnf0HeZjNzDER0xySpB/bvbj/Yb0qiHlJUezfNP/0C++BXj/mcQagRcO5ioF3OteNCuqF1SKFI5OFpSZZUPO70XZC/dLy74CjdjbEDXIsnh7RDyUwbLRjo1TOsREvp4XdKiej0dHlh5rGIlEloV0PNhVv2ikFxvp3ucpyUE94UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816497; c=relaxed/simple;
	bh=3uKpmZcVcyDfgPeokSA3YXGsdGowE+EW6/E6D4PyU6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwcW6B3bzlPwZjV0B3pGHTjEPGyib+W3BwRtwxHJvsA32e1FecnF+Nx+8X4E2DC6KsWVIbTO2xZrA4+V+8dJwnzU5KBnmfBx0hu8JmZVLse6VBA1QpIJFxVT+R2Sh0k5B1jrm3GZVbrd5Mewy7kbqDXT8EsReGgr0/fR3f+x9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NduRzxun; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761816496; x=1793352496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3uKpmZcVcyDfgPeokSA3YXGsdGowE+EW6/E6D4PyU6k=;
  b=NduRzxunVzYiFYnC/67wGf1mpqpv9KPI7B7G1dlArazhsaXULNrb305P
   YwnlZyfUS/gP0PLOF3z7QsY/hfvrTubN7zkxmkAYvoxGAbzDJXW1TfMSC
   oEiRMSzOL+U4M17zxW6kAwqE3T4YTiFJVglrdQCtvwzNuHz+NKrNTnhVJ
   b5JhE/FxWaX1bCjfjbXOYR6sNjb9zKuZxRgzSS9GQ8hgTuu9NL50zgARY
   J/x3dO/d9Q0uWGSAkFNJr8Hz3C2T7kguuaW6mFhgSFNVPVpqFV7g0GAB0
   FqifbuSp7ooOjpvckmLklpyzrPbVEpZR6ClGfRu0c1zWt6P4V7dAmBAqd
   A==;
X-CSE-ConnectionGUID: Dt7OVbVDQaKZURNbk5QLtw==
X-CSE-MsgGUID: 1CVglTfSRd+4mpjnuwRC0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64048391"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64048391"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:28:15 -0700
X-CSE-ConnectionGUID: c3zb3I3eRieOVLLjc3wNiw==
X-CSE-MsgGUID: 63dfAW39RvORT7FEd1j5og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190239957"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:28:12 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEOwy-00000003rFz-3nKg;
	Thu, 30 Oct 2025 11:28:08 +0200
Date: Thu, 30 Oct 2025 11:28:08 +0200
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
Message-ID: <aQMvqHGN7r6babgw@smile.fi.intel.com>
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
 <aPP0uVZu1T7tTQGo@ashevche-desk.local>
 <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 09:27:21AM +0100, Daniel Lezcano wrote:
> On 10/18/25 22:12, Andy Shevchenko wrote:
> > On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:

...

> > > +#include <linux/circ_buf.h>
> > 
> > Why not kfifo?
> 
> I'm sorry but I don't get your comment.
> 
> Do you mean why not use kfifo.h or use kfifo API and change all the code
> using the circ_buf by the kfifo ?

Yes, I mean why use circ_buf API and not kfifo API.

...

> > > +#define NXP_SAR_ADC_IIO_BUFF_SZ		(NXP_SAR_ADC_NR_CHANNELS + (sizeof(u64) / sizeof(u16)))
> > 
> > Hmm... Don't we have some macros so we can avoid this kind of hard coding?
> 
> I don't find such a macro, do you have a pointer ?

If I got the use case correctly, I was thinking of IIO_DECLARE_BUFFER_WITH_TS().

...

> > > +	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);
> > 
> > Do you need those 'U':s? clk_get_rate() already returns unsigned value of the
> > same or higher rank than int. No?
> 
> May be not needed, but harmless. I can remove them if you want

I think using them in cases that have no side-effects are not needed.

...

> > > +	dma_samples = (u32 *)dma_buf->buf;
> > 
> > Is it aligned properly for this type of casting?
> 
> TBH, I don't know the answer :/
> 
> How can I check that ?

Is buf defined as a pointer to u32 / int or bigger? or is it just byte buffer?
If the latter, how does the address of it being formed? Does it come from a heap
(memory allocator)? If yes, we are fine, as this is usually the case for all
(k)malloc'ed memory.

...

> > > +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> > 
> > No return value check?
> 
> The return value is not necessary here because the caller of the callback
> will check with dma_submit_error() in case of error which covers the
> DMA_ERROR case and the other cases are not useful because the residue is
> taken into account right after.

In some cases it might return DMA_PAUSE (and actually this is the correct way
to get residue, one needs to pause the channel to read it, otherwise it will
give outdated / incorrect information).

> It could be written differently with the DMA_COMPLETE check but the result
> will be the same. I prefer to keep the current implementation which has been
> tested.

-- 
With Best Regards,
Andy Shevchenko



