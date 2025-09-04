Return-Path: <linux-iio+bounces-23696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52388B43419
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EA8585DAC
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 07:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B32BDC3D;
	Thu,  4 Sep 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G93hqpCp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977F29D27F;
	Thu,  4 Sep 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971205; cv=none; b=tVhEtZoRHr7o1VG2wE9VFv2jnmdxBLFPljMfUssnN2CnO40fOXmXf/ubx+nNRk6kXfFWZ09H5kPaFoewf5/7IYUMCxtv8UzwR4nOrDln15tXh+am7DIYh2CS4fiZ8PA1ZXuiRpVqcVmj9dn112pnR43boX31VFcGMvXjdmGjCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971205; c=relaxed/simple;
	bh=cXJUlEC+sK546VLltjJSXzal14Out0qsO9EqICM0M94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huKMHzm7cH2WHGyD0zpem8i0t/yebfMM5o3KhJiov3Iph8VeEs1E1lbbGqcbVVpnJloKvAqAOTcJAXJ2kti4tZx1PKIVN9Wjl1/tLdGCjqYJBu8Mq5LpTpPtRYblIQ6DxmH/1pA41Om5ti5CJYkNfisSPYNI+paBwny6W4///hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G93hqpCp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756971204; x=1788507204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cXJUlEC+sK546VLltjJSXzal14Out0qsO9EqICM0M94=;
  b=G93hqpCpMkDhoDOBVOMG5KPtP2KN7yJVSDR1UxL3dFzIm4+gM3yhkF1s
   OMLttppSwIycaIQHzXL7G+4l9dlDtj7iV0EHN7NsbENbu66xNcEnyZbsf
   fR+CsTlBrL0u1wC6nER7QrrcCYdCgwF/USyacpHMgdWUoXwXrPbGIy2j/
   3edq4TrJ57JiePEWVfx49vZP5830jb1ixeAis6TvQzqobqlm0jyZE+rxf
   SJiDjvHFEo6nuQnQQnjZscEyoqY6ollSuwV4pZ1jqYGYzqdKgwRP+9hmS
   Syp9df9fWFWTdraosrDMXs1YDAGvLDI3P8JhexWZ3jljwNAU70QPwuFXQ
   Q==;
X-CSE-ConnectionGUID: 0b0FIOs4TleVJjSP/sSusw==
X-CSE-MsgGUID: shcQJgJWTDm5n7S8pLqTLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59369793"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="59369793"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 00:33:21 -0700
X-CSE-ConnectionGUID: eMMfcbkqRCOWVV2RjKkbtQ==
X-CSE-MsgGUID: X75BcxkyRTG4FAFe4GGqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="171693241"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 00:33:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uu4T4-0000000BCO3-13Ek;
	Thu, 04 Sep 2025 10:33:14 +0300
Date: Thu, 4 Sep 2025 10:33:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, linux-iio@vger.kernel.org, s32@nxp.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <aLlAugdr-hwMNIje@smile.fi.intel.com>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <aLgrGlpNrDTC5LAd@smile.fi.intel.com>
 <a34efc36-0100-4a7f-b131-566413ab88ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a34efc36-0100-4a7f-b131-566413ab88ae@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 05:28:09PM +0200, Daniel Lezcano wrote:
> On 03/09/2025 13:48, Andy Shevchenko wrote:
> > On Wed, Sep 03, 2025 at 12:27:56PM +0200, Daniel Lezcano wrote:

...

> > > +#include <linux/circ_buf.h>
> > 
> > Why not kfifo?
> 
> Are you suggesting to use kfifo instead of the circular buffer in the code ?

Asking, due to relatively recent move in the whole serial subsystem.

...

> > > +#define NXP_SAR_ADC_CAL_TIMEOUT_US	100000
> > 
> > (100 * USEC_PER_MSEC)
> > 
> > > +#define NXP_SAR_ADC_WAIT_US		2000
> > 
> > (2 * USEC_PER_MSEC)
> 
> Why is this more understandable than the raw value ?

Because instead of counting 0:s and checking the suffix, I can immediately read
from the value like:

"This is 2 milliseconds in microseconds units."

It's more understandable and robust against possible typos.

...

> > > +#define NXP_SAR_ADC_DMA_BUFF_SZ		(PAGE_SIZE * NXP_SAR_ADC_DMA_SAMPLE_SZ)
> > 
> > Oh, PAGE_SIZE is not good to use. I believe this HW is not tolerant to any page size.
> > (Note, we made similar mistake in Intel IPU3 camera driver, which is now fixed)
> 
> Is it acceptable to put a hardcoded 4096 value ?

Sure, define it like HW page size

/* This ADC relies on the page size to be 4kB */
NXP_SAR_PAGE_SIZE		0x1000 // or SZ_4K, or ...

...

> > > +	ret = read_poll_timeout(readl, msr, !(msr & REG_ADC_MSR_CALBUSY),
> > 
> > Why not readl_poll_timeout()?
> > 
> > > +				NXP_SAR_ADC_WAIT_US,
> > > +				NXP_SAR_ADC_CAL_TIMEOUT_US,
> > > +				true, REG_ADC_MSR(base));
> > > +	if (ret)
> > > +		return ret;
> > 
> > > +	if (!(msr & REG_ADC_MSR_CALFAIL))
> > > +		return 0;
> > 
> > I would expect standard pattern — "errors first", but here either works.
> 
> Does it mean this chunk of code can be preserved or do you prefer an error
> block followed with a return 0 ?

Up to you. Only the question above (readl_poll_timeout() use) stays unanswered
so far.

...

> > > +	/*
> > > +	 * On disable, we have to wait for the transaction to finish.
> > > +	 * ADC does not abort the transaction if a chain conversion
> > > +	 * is in progress.
> > > +	 * Wait for the worst case scenario - 80 ADC clk cycles.
> > > +	 */
> > > +	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);
> > 
> > Could it possible go wrong and with low rate clocks (kHz:ish) this will go into
> > lo-o-o-o-ng *atomic* delay?
> 
> It is the ADC clock where we need to wait for 80 cycles. The lowest clock
> rate is 40MHz, but on this platform it is 80MHz IIRC. This routine is called
> only when the capture finishes. Except I'm missing something, this scenario
> should not happen.

So, you guarantee that clk_get_rate() never returns, let's say 1000, right?
(Personally I don't see how it's possible to guarantee...)

...

> > > +		nxp_sar_adc_channels_enable(info, 1 >> chan->channel);
> > 
> > 1 >> ?!? Did you want BIT(channel)? Or simply channel != 0?
> 
> Yeah, BIT(chan->channel) is better

But is the above a bug in the original proposal or not? I mean one wanted left
instead of right shift.

...

> > > +	dmaengine_tx_status(info->dma_chan,
> > > +			    info->cookie, &state);
> > 
> > Perfectly one line. No return check?
> 
> Ok, will see if the IIO DMA API has an impact on this portion of code before
> checking the return code. However, the status is often ignored in the other
> drivers.

...which doesn't mean it's a good example to follow.

-- 
With Best Regards,
Andy Shevchenko



