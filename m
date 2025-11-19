Return-Path: <linux-iio+bounces-26319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B6C703CA
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5B624EF04D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2A33A6E4;
	Wed, 19 Nov 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOfXmahm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D02FD1AE;
	Wed, 19 Nov 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568898; cv=none; b=XFZcPe44m5B7JBUOEqr29SCDyjSN35BbFJOe629kCQBwhmwx4gRqOOH0axWtUGs3ZqOpk7gutxNYIFA3E0m6jiW1Jkj0rSxltvnTbnyviifMFf/n9Bi1Yp19lgZKSCGGCeyUFI8dSsgyabiZ/EZqgSPdv9/St84RHIVQoqCgP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568898; c=relaxed/simple;
	bh=PikyI1XUgD2dRPESOHTI4nKICevnLr+NOjrgaGi0tBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcwhIIZbHvNm6QPeL5UOUry6jQ/zNPfJ2ISromsXQUzIjbmcx3rgF4Qw0mbpYPngMiqg1SfWD5VRLHGyi6FP7ejnI8/PkqvN/7iyccWD14LksGZ3JAN5XknSuyk+uwwX/6TFLu6ErwPBnXyihZAUMJ8MCFrBYoFYKx5QMn0csbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOfXmahm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763568898; x=1795104898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PikyI1XUgD2dRPESOHTI4nKICevnLr+NOjrgaGi0tBI=;
  b=YOfXmahmlWLORtXujOQx/Ir0B2diUXmh3J0lFVaifOUfFvVc+l9ImByQ
   vxF2cVtDfVgN1b7O3XigYO8x9qyIwojW7GQCDzradP1p+eK2N/K9mOTx0
   YPutPi2c8WjyPSMjIifk8K4xNFDuyC4+uclK/2tTBiDQvtv5/hSh9NvTq
   n6eC2BY/rIWBHgynyeofpOAT1+tyGdOKK2dwI8hGmM64htn7ZDmkQgpe/
   YQ4F+TyOarn/z3Mqds7Vk2Vgp7owRzOJg+j9560qlGaiyV3uP97RiiXda
   q1fal5lZythOMpygOjLksQ8pK+JkaSiLvBxtsHT2lxiwTsx256BQL2+sq
   w==;
X-CSE-ConnectionGUID: 97ux116wTW6L0Oez0tUuNw==
X-CSE-MsgGUID: QAQZlDAlTt+fHLSNeBXuCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65649475"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65649475"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 08:14:57 -0800
X-CSE-ConnectionGUID: tglGIuuNTNScrHbo4oA2yw==
X-CSE-MsgGUID: TTWFkKCbQA6HO7I3E+xYQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="195406485"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 08:14:52 -0800
Date: Wed, 19 Nov 2025 18:14:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, s32@nxp.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, vkoul@kernel.org
Subject: Re: [PATCH v6 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <aR3s-gFf76mXN_uZ@smile.fi.intel.com>
References: <20251118203305.3834987-1-daniel.lezcano@linaro.org>
 <20251118203305.3834987-3-daniel.lezcano@linaro.org>
 <CAHp75Ve=CU8ecXk5sgkHPJbYA_K+sa+Lyys+cdpCm=QHOw2ytg@mail.gmail.com>
 <ac85d16d-7d9d-41eb-9b1c-08df9a61f672@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac85d16d-7d9d-41eb-9b1c-08df9a61f672@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 03:44:04PM +0100, Daniel Lezcano wrote:
> On 11/19/25 10:27, Andy Shevchenko wrote:
> > On Tue, Nov 18, 2025 at 10:34 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:

[ ... ]

> > > +#define NXP_SAR_ADC_EOC_CH(c)          BIT((c) % 32)
> > 
> > Do you expect "c" to be bigger than 31? In which circumstances?
> 
> No, it should be always lesser than 32. We can drop the modulo.

Yep, please avoid adding a code that is never needed. It complicates reading,
reviewing, and understanding the flow.

[ ... ]

> > > +       /*
> > > +        * Ensure there are at least three cycles between the
> > > +        * configuration of NCMR and the setting of NSTART.
> > > +        */
> > > +       if (enable)
> > > +               ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3));
> > 
> > I'm wondering how low the clock rate can be? With low enough clock
> > rates this becomes a 100% CPU busyloop and in atomic context (is this
> > the case?) without even the possibility to schedule.
> 
> I believe this question was already addressed in v1:
> 
> https://lore.kernel.org/all/a34efc36-0100-4a7f-b131-566413ab88ae@linaro.org/
> 
> right ?

Right, so the bottom line is that we miss the one-two phrases in the comments
above to summarize that.

[ ... ]

> > > +       /* FIELD_GET() can not be used here because EOC_CH is not constant */
> > > +       if (!(NXP_SAR_ADC_EOC_CH(chan) & ceocfr))
> > > +               return -EIO;
> > 
> > [nxp_sar_adc_]field_get() may be defined and used. There is a series
> > pending to bring field_get() to bitfield.h next release.
> 
> TBH I don't have an infinite bandwidth to write temporary helpers. So if it
> is ok, I would prefer to keep it as is

Sure, perhaps just add a TODO line instead of the comment above:

	/* TODO: Switch to field_get() when it will be available */

[ ... ]

> > > +       nxp_sar_adc_channels_disable(info, *indio_dev->active_scan_mask);
> > 
> > Wondering why this can't take a pointer to a mask.
> nxp_sar_adc_channels_disable() is also called with BIT(x) parameter in other
> places. So in the function is much easier to do val |= mask;

OK!

> > > +       ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
> > > +                              dev_name(dev), indio_dev);
> > > +       if (ret < 0)
> > > +               return dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
> > 
> > No error code duplication in the message, please.
> 
> Given devm_request will print the "request_irq(%u) %ps %ps %s\n" error
> message. Would you suggest to just return ret here ?

Yes!

-- 
With Best Regards,
Andy Shevchenko



