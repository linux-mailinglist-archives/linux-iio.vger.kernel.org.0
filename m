Return-Path: <linux-iio+bounces-25262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502FCBEDB77
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 22:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78D419A58F0
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 20:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F42857C1;
	Sat, 18 Oct 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ld0lNl8G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2C126BF7;
	Sat, 18 Oct 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818370; cv=none; b=t6CHA3rDOINhHPyG+tdGK3oRKh+zJUz2ItOudDo/G7lM1xR5NUc9/boWXu6hfFa4WKAfs2jbzbR1/IcyAZ/JM+WyvsNF++8fz6PwLUi/nZV/ZsKy8sQbXlG3k2krJJT4hjZKz5eK4FPxTYZfytCcqNLg9lJ9d//DDeraU2fR1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818370; c=relaxed/simple;
	bh=zjfMEN40yxBxgYdbiW3L9ZafDw65ED4ckQ7ShXbibQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO6rK1MaeZl4k7DwSfsC0TImZzGfm7AUZrBJO/SPfIIRxRX8uQlvFKHj7in0yi7Dcws1FDd9ZIpSWJf3iIRsOJzgLplMtjV2DtNfMeQMvjMdKzU4tfgrDk20eDawBzN+kDD02pJ8wbocQ+5TGCwDWS2y4Hqyf3FXCI+YRo9knzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ld0lNl8G; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760818368; x=1792354368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zjfMEN40yxBxgYdbiW3L9ZafDw65ED4ckQ7ShXbibQE=;
  b=ld0lNl8GfGUMFa+Gxqc2RhWz2mdP/ArnHn+d8CFGngDjx1OjiLP6rC4O
   6GIeD6SmCTBgLhopW3HN6mJ5LNR14vSP/EYQ4QcMsLnJpmG89RVtPkNHB
   XOv1HMDy/yhfEriyyNPTyO7E/Qai9AecUghFESf8R48+vpGeM9HEqU2GB
   2fQxPPjTYbiQxm77TTeZ56pjK5A7QuMcsA+7zxDnrt3xK6NvSrSd3/cAD
   vU9TX8ZOXLB6zW79M/PyPJm9uXB0E7pwHSNlwP26GdV0rdkjunh5xl0dC
   MOXA7QTlTC0aEfJ1qw/8z48wlKhR36pXpkUJaBlsSV0MdFrcfNnHEVxU9
   g==;
X-CSE-ConnectionGUID: RziuIPiHSUif5/gkEolBgQ==
X-CSE-MsgGUID: Dt/UfglFRj++z4U5tAK88Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73281478"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="73281478"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 13:12:48 -0700
X-CSE-ConnectionGUID: fvS71f8zQiyxlwE4bM+6kQ==
X-CSE-MsgGUID: qdmKID63QFWBuCMLuNqxlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182824703"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 13:12:45 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vADI9-00000000y3B-26QC;
	Sat, 18 Oct 2025 23:12:41 +0300
Date: Sat, 18 Oct 2025 23:12:41 +0300
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
Message-ID: <aPP0uVZu1T7tTQGo@ashevche-desk.local>
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017164238.1908585-3-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:
> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> 
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
> 
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
> 
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers, while the author refers to
> the initial BSP driver file creator.
> 
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.

...

> +#include <linux/circ_buf.h>

Why not kfifo?

...

> +#define NXP_SAR_ADC_IIO_BUFF_SZ		(NXP_SAR_ADC_NR_CHANNELS + (sizeof(u64) / sizeof(u16)))

Hmm... Don't we have some macros so we can avoid this kind of hard coding?

...

> +	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);

Do you need those 'U':s? clk_get_rate() already returns unsigned value of the
same or higher rank than int. No?

...

> +static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
> +{
> +	u32 mcr;
> +
> +	mcr = readl(NXP_SAR_ADC_MCR(info->regs));
> +
> +	FIELD_MODIFY(NXP_SAR_ADC_MCR_NSTART, &mcr, 0x1);
> +	FIELD_MODIFY(NXP_SAR_ADC_MCR_MODE, &mcr, !raw);

!raw, which is boolean, as a parameter to FIELD_MODIFY() seems a bit odd to me,
perhaps simple

	raw ? 0 : 1

would work better?

(Note, optimizer of the complier will avoid any branching)

> +	writel(mcr, NXP_SAR_ADC_MCR(info->regs));
> +
> +	return 0;
> +}

...

> +	dma_samples = (u32 *)dma_buf->buf;

Is it aligned properly for this type of casting?

...

> +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);

No return value check?

...

> +static const struct nxp_sar_adc_data s32g2_sar_adc_data = {
> +	.vref_mV = 1800,
> +	.model = "s32g2-sar-adc"

Keep a trailing comma as here it's not a termination member.

> +};

-- 
With Best Regards,
Andy Shevchenko



