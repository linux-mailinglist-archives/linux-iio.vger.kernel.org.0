Return-Path: <linux-iio+bounces-26292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A0C6A006
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABE584F956B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE71035A93E;
	Tue, 18 Nov 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FN7bx3RC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BA23BCFF;
	Tue, 18 Nov 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475647; cv=none; b=iye0lS/KZWCZzQEQY95EseXuk+CW+AI4BbSGIXUzhM8owzO0IaiwG601PvUPoSegwXDGQ2kr243dzJzO6jSwu/WoNZxrCGcm4d4l1FFrSgESH/WjWx33pUT75ic2SttTqgiur5G7tvjYnLOSTVh/Ig1ofJZp7ZqroNfuLhwVy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475647; c=relaxed/simple;
	bh=mJkAfe+a2xUbKCMfjufIaZ3xUygcsmfN3dcDG2C5oCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGHtdt9RYf/3zTq3CmJOeGamD41CcE/+yNAfFVCn7a7dJnRTEVkBo9Q3TN2e+JLUgtidA2+ZcIorb0jqZAm1TSJyxNPH8KmWmlrP/hfP/qpMz4RuNxydW6+tc04Wdtq1M+LckZHythkoWib1cqV7nk2cPm4dwIqSJkJ2wScxuUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FN7bx3RC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763475645; x=1795011645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mJkAfe+a2xUbKCMfjufIaZ3xUygcsmfN3dcDG2C5oCE=;
  b=FN7bx3RCL9D317cGU4OmdyQZMDFSV8qXGLiPZzpCRA3SwwLKtnVZP00R
   IP8Kr44FddiTQ8agmpr4Ww+w4+i5fDYAfdKslxt4jdfOC5B6RzmLVYPbS
   Yw+u6UnHV2LXcLn6+y0684fcogjgs3TuzIZjTDA1PNqh4ZKVTdb2agMvc
   SSemXf9zpQvKt43ypUR5f/3dFfzpr3iI9sZVYqDWKPrudCik89tpa/tLD
   5Jn+WwCzVLcx4/V11NN6U7YYB2G5ocBIwdSP6Nl3geEV/d3dZqkba2slJ
   eZSopoqjrq553ARJCkEca8MOtOoMvh/HMyE7LVUO1Rgm40TOXlBDj5QkP
   A==;
X-CSE-ConnectionGUID: 4PchgOGATnaG/+9SbIenFw==
X-CSE-MsgGUID: BaJlcxAmQjKIT9TFpHRRpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="83124912"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="83124912"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 06:20:44 -0800
X-CSE-ConnectionGUID: TA1a3Ao/TjSsn8nADB4aEQ==
X-CSE-MsgGUID: E45H2IXkQl20KjNi/6Dq9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190430001"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 18 Nov 2025 06:20:42 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 353F898; Tue, 18 Nov 2025 15:20:41 +0100 (CET)
Date: Tue, 18 Nov 2025 15:20:41 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, s32@nxp.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v5 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <aRyAuTZEi_xHkn9G@black.igk.intel.com>
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
 <aPP0uVZu1T7tTQGo@ashevche-desk.local>
 <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
 <aQMvqHGN7r6babgw@smile.fi.intel.com>
 <c4c14051-2ba2-4d80-a22d-4deb3709f727@linaro.org>
 <aQSvZT73NBWZFVfk@smile.fi.intel.com>
 <d783184f-6598-479a-99f3-e142e83bbb81@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d783184f-6598-479a-99f3-e142e83bbb81@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 07, 2025 at 12:36:14PM +0100, Daniel Lezcano wrote:
> On 10/31/25 13:45, Andy Shevchenko wrote:
> > On Fri, Oct 31, 2025 at 12:32:03PM +0100, Daniel Lezcano wrote:
> > > On 10/30/25 10:28, Andy Shevchenko wrote:
> > > > On Thu, Oct 30, 2025 at 09:27:21AM +0100, Daniel Lezcano wrote:
> > > > > On 10/18/25 22:12, Andy Shevchenko wrote:
> > > > > > On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:

[ ... ]

> > > > > > > +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> > > > > > 
> > > > > > No return value check?
> > > > > 
> > > > > The return value is not necessary here because the caller of the callback
> > > > > will check with dma_submit_error() in case of error which covers the
> > > > > DMA_ERROR case and the other cases are not useful because the residue is
> > > > > taken into account right after.
> > > > 
> > > > In some cases it might return DMA_PAUSE (and actually this is the correct way
> > > > to get residue, one needs to pause the channel to read it, otherwise it will
> > > > give outdated / incorrect information).
> > > 
> > > But if the residue is checked in the callback routine without checking
> > > DMA_PAUSED, the result is the same no ?
> > 
> > DMA in some corner cases might have already be charged for the next transfer.
> > Do you have a synchronisation between DMA start and residue check?
> > 
> > I.o.w. this may work for your case, but in general it's not guaranteed. The proper
> > read of residue is to: pause DMA --> read residue --> resume DMA.
> 
> I'll use the new callback function dma_async_tx_callback_result() which
> should prevent that and allows to remove the spinlock at the same time

So, AFAIU this doesn't work for you.


-- 
With Best Regards,
Andy Shevchenko



