Return-Path: <linux-iio+bounces-26293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4F2C69EE8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A6B0D2B1F1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022135F8A4;
	Tue, 18 Nov 2025 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMKpwumA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396935E546;
	Tue, 18 Nov 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475759; cv=none; b=VFXjt/KwNbN4aRK5HD0hJVb8EUlBCUpCwmQ2lD97OlKbnm9EnWjRgaHGT42mU3Q00Hvd9bvjQe3RrH5CqGJPYC5yG/5VlUWgvk2u5+7t94B6BdX7sFTjqJZVnQcwPPeeyUVY/PQ1teT2A1NHvZ1fiknACxHJIwzSvcAPDU9lWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475759; c=relaxed/simple;
	bh=fwWsMZA40ndxBike93FRIIJct3hr38w4a3KFs5WIip0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz5MY8l8QtzSta30OYjZADA/5aFWwTAnW6U4eybzpJaW6pmCtu75UkxMBQqcZ+mvaPy31ZwWgG9pbpBU0SBXTn/cIlo1K/3fZJw9MZBob+t7tkkD/wdfjgowF/9XaAfiGmq8pYuCAmV+GXARihpRoKpzJfF6TPxvW5UN/gx5kD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMKpwumA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763475757; x=1795011757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fwWsMZA40ndxBike93FRIIJct3hr38w4a3KFs5WIip0=;
  b=MMKpwumAbz1HdmWwPTtpdXSxbKJQRn9XcNzYEi5zCC4YUi9IJkNDwIbP
   f05QYlO6ync0z3lqqSFe4p9CONDfbPLagOn5j4b/OPSau2WTDc8TT5p7+
   0DSGPPGgvK1BKAy1N9fS4pjdFQHYkz4Js3hOIHsu4+arUUBbKBGA1c2uL
   N0Azzv3RT06WWO1ZAkpTTcGfLqmxYicDOXKJTwrOPvmDWPRjdMSREu0BA
   Nrg0jocho3wHcZ3VbxKdZ9xjCces4JjS6e8H5ODgRLCNH0uhOYKQ8PSuD
   bW17jmeNh40sABnmFYBUl6lUUnOFbY6KMlUoUliD0nQXzzdPVqlaVt7mj
   w==;
X-CSE-ConnectionGUID: HkkXJjMDQmCLqu8G9apQBQ==
X-CSE-MsgGUID: MyBQusoSRmaWCHutba/W/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65587149"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65587149"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 06:22:37 -0800
X-CSE-ConnectionGUID: 1B2Da2WtSui7d3FCBL1WAA==
X-CSE-MsgGUID: XqS35Pd+RA6FwyfvZ+OeLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="214167862"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 18 Nov 2025 06:22:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9578F98; Tue, 18 Nov 2025 15:22:32 +0100 (CET)
Date: Tue, 18 Nov 2025 15:22:32 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, s32@nxp.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, Vinod Koul <vinod.koul@linaro.org>
Subject: Re: [PATCH v5 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <aRyBKH4KOQ1L8lA4@black.igk.intel.com>
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
 <aPP0uVZu1T7tTQGo@ashevche-desk.local>
 <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
 <aQMvqHGN7r6babgw@smile.fi.intel.com>
 <c4c14051-2ba2-4d80-a22d-4deb3709f727@linaro.org>
 <aQSvZT73NBWZFVfk@smile.fi.intel.com>
 <bb985484-dc67-42ba-bbc4-94bab89f72b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb985484-dc67-42ba-bbc4-94bab89f72b1@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 18, 2025 at 02:57:41PM +0100, Daniel Lezcano wrote:
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
> I discussed with Vinod about this change and he suggested to use the
> callback_result() to get the residue as a parameter so the
> dmaengine_txstatus() call won't be needed anymore.
> 
> Unfortunately, it does not work. I had a look in the DMA driver and the
> internals but my knowledge is limited in this area so I was unable to find
> out what is going on. Moreover there are no so many driver using this API I
> can use as an example. The best I was able to do was propagating the residue
> to the result in the vchan_complete() but it does not work.
> 
> Then I stepped back by not using the callback_result() and used
> dmaengine_pause(), read the residue, dmaengine_resume() but there are no
> result after these calls. I don't know why.
> 
> The issue you are mentioning above should be handled in other drivers doing
> the same kind of acquisition but the routine is similar to the one proposed
> here (eg. stm32).
> 
> The NXP SAR acquisition routine is running since several years in production
> AFAICT.
> 
> I investigated the different solutions without success, while I can run the
> acquisition routine without problem here with my hardware. A signal
> generator captured by the ADC, plotted and compared with the oscilloscope
> display.
> 
> The circ buffer is working well here and no bug was spotted with the current
> routine. I think I did my best to make the driver better from its initial
> submission. The best is the enemy of the good, and I would like to make some
> progress here in the driver acceptance. Changing the entire driver for the
> sake of replacing the circ_buffer by the kfifo and change the code for a
> scenario which is not happening is not really worth. Especially that the DMA
> engine is being modified to take into the cyclic DMA in its API, thus the
> circ_buffer and the routine will go away once the driver is changed to take
> into account this new API.
> 
> IOW, can we keep this routine as it is for now as it works fine and go
> forward for a v6 ?

Thanks for trying and getting to this. Please, make a summary of the research
and pack it into a paragraph in the commit message, so we will have this in
the history. Maybe even a short comment in the code.

-- 
With Best Regards,
Andy Shevchenko



