Return-Path: <linux-iio+bounces-25364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45CBFFEE9
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D77214F01E5
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761072FF173;
	Thu, 23 Oct 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNaj6o+I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ACC2FE04E;
	Thu, 23 Oct 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208205; cv=none; b=mfpVtDcNSLKuBnkgvFTUu+Ayw+TZD7gA64VjvI0wV6gEI1jeBn1ixSgzJi3n3M1JciiJHVVsVH2gJwnPyqJEymBWsiKrWLql4uIVmNdsDd3CEb7NhtbiM2luXmCIJvyZGviWMJ/btWBkEQ30knWIASEcchTqKMr2pTT5o9+iClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208205; c=relaxed/simple;
	bh=Ch5XHan7n+TFh9cqXyKAmWNWnMzChVHFasLvrJE4wkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLG0Lfs6VWBAUks3sKieEDAFW96zyeX5Z6tTQZ9Ea88X1abJ2KZtzS9Ahi71FFeIOlTmCvqkF5UYo0nPh9xMEBpq2paKet3I9eKTFCWXRBsGtJC3u/UmjFs1I9CfuCFG8ymR2FHAwbrHIclvp03hCuV3YR7mNDIrYZCqb3P2sHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNaj6o+I; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761208204; x=1792744204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ch5XHan7n+TFh9cqXyKAmWNWnMzChVHFasLvrJE4wkg=;
  b=dNaj6o+IlM/YDqFXRGIUlxJBbQIwgEPo1XWwb+ApcZL2gtjgbqJmKbs4
   4/oIopg0TjunBPHPC8z8Mtho7f5UryT0/PJoox+D/6Jf2QDsOyUbfcPyd
   D2gV/FT49tZJXZjPBF/E5v8OQoULZuWAQYqNPkipPrI4GMckxM6vyxQ04
   Vc2xMoapuj+zLDIejcP91tCnccbfjiVHkliGGIHsB7ByO17GixWlemZ9f
   ycLgQyUGu/jDrr77DMpJZGUDERm0jVG5YTIBbMXx5AGhEwr7S6O+QT3uf
   iWuuM71QxYRQd3itlvj+WEVGrDlULyZjjbUEi6U5PrvN/aMpy6yAc2vBm
   g==;
X-CSE-ConnectionGUID: Sbr5hshARCeqjnv0rgXCmA==
X-CSE-MsgGUID: oJ/L3cWQRnOOGa1mRI6Ycw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73975917"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="73975917"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:30:01 -0700
X-CSE-ConnectionGUID: rzmiWePRQC+B9dJ+/YBtZA==
X-CSE-MsgGUID: Nd/VzcadQXedqM1wJPyvdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="221289795"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:29:57 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBqhl-00000001tb8-3zNP;
	Thu, 23 Oct 2025 11:29:53 +0300
Date: Thu, 23 Oct 2025 11:29:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v6 3/5] i3c: master: svc: Add basic HDR mode support
Message-ID: <aPnngQdwEqHgPc7R@smile.fi.intel.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-3-3afe49773107@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-i3c_ddr-v6-3-3afe49773107@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 14, 2025 at 12:40:02PM -0400, Frank Li wrote:
> Add basic HDR mode support for the svs I3C master driver.
> 
> Only support for private transfers and does not support sending CCC
> commands in HDR mode.
> 
> Key differences:
> - HDR uses commands (0x00-0x7F for write, 0x80-0xFF for read) to
> distinguish transfer direction.
> - HDR read/write commands must be written to FIFO before issuing the I3C
> address command. The hardware automatically sends the standard CCC command
> to enter HDR mode.
> - HDR exit pattern must be sent instead of send a stop after transfer
> completion.
> - Read/write data size must be an even number.

...

> +static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
> +{
> +	u32 reg = 0;

Useless.

> +	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
> +	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> +			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);

No error checks? Why is it okay?
Why is the first parameter 0 while it's not an _atomic() call?

> +	udelay(1);

No explanations given. Also is it really need to be atomic? If not, use
fsleep() and it will choose the best suitable API under the hood.

>  }

...

> +	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
> +		/* DDR command need prefill into FIFO */
> +		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
> +		if (!rnw) {
> +			/* write data also need prefill into FIFO */
> +			ret = svc_i3c_master_write(master, out, xfer_len);
> +		if (ret)
> +			goto emit_stop;
> +		}

The indentation here is a mess.

> +	}

-- 
With Best Regards,
Andy Shevchenko



