Return-Path: <linux-iio+bounces-25820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047FC2A800
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 09:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EC83B5166
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743992D77FF;
	Mon,  3 Nov 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLzwhkf6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA462C0F93;
	Mon,  3 Nov 2025 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157033; cv=none; b=BIcZhcMMu41I3jiBRXRSsTgmZEpy/b6PQoeNw4DKXRUzPubCeQCryt4AEt5OhDCWfDSsibpvr+W+jmzao6jRB3r9bEXiq+pL2P3D0hlg+IyMCzuvuetEFt9vkVbtToOsp/AW5YwPIyaXT+ur6QbU8FC+367WgNDctRQCmtU9iWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157033; c=relaxed/simple;
	bh=5pXyRXIxVt0Iau8mWou9oXadjFJmaZdgpbKlkoLVbSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPJQLlRv2LRrMvstj1ujmLNCKpjNotUtkSH3u2kIYfIP1GZTE+965kEt5oI5jPMpUkTE6t3itqMiB3oOhMPvNyMUoK8SfRWlO4u5zd7ZOvaYC/5sqgX9lKsj/KbRE6jpeXg0e4RRgdelPEbkHq6IipaJbOdfmOadLW8cAnXZ2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLzwhkf6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762157032; x=1793693032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5pXyRXIxVt0Iau8mWou9oXadjFJmaZdgpbKlkoLVbSU=;
  b=DLzwhkf6JVtn5aygnbhHB9zYbfO9dnSoPkNSp1SpCq4UGOTRGGCPwhGH
   U2ux0/j0ZbeBeaOv3AdzrxHACPQP65Vwsxq+CZhR6l0QkHoHTzicNrhXR
   shg3KEjxQ6cuSwt8em6lMjP9nt1sbLhx3SchVWNi0m3no/95/y5zsAqey
   bn6O2BFEt0KWmd5ugh7mpZWFy9zWlyh0nifVBezZfupI0/VURnXo5z1S8
   Ok+YdKx8t9xue71f8yLwPfjTVBHP5+EydkDgOodmgCd0oDrx6LrASTTvK
   riiEeWGsS6MDPj/Qrm4/CTpeAJfQQEyIkRP/KktXa1+yldfeoi9CjZGl9
   A==;
X-CSE-ConnectionGUID: SPCZY5OwSkOq7K/DCRYatw==
X-CSE-MsgGUID: YeJtQbERSquAGV3oIPwKAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="74518682"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="74518682"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:03:51 -0800
X-CSE-ConnectionGUID: W2KynLE4QPibqsxiZlCTFg==
X-CSE-MsgGUID: x44oWC41SpWrm2y4Xsghpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186042022"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:03:47 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFpXQ-000000055GF-3PTd;
	Mon, 03 Nov 2025 10:03:40 +0200
Date: Mon, 3 Nov 2025 10:03:39 +0200
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
	devicetree@vger.kernel.org, linux@roeck-us.net,
	Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v9 4/6] i3c: master: svc: Add basic HDR mode support
Message-ID: <aQhh2zZVxh1oVuJz@smile.fi.intel.com>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
 <20251031-i3c_ddr-v9-4-f1e523ebaf78@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-i3c_ddr-v9-4-f1e523ebaf78@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 12:39:16PM -0400, Frank Li wrote:
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

>  static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
>  {
> -	return rnw_cmd;
> +	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;

This seems confusing. Either !! is redundant (which is actually the case) or
I don't know what the idea behind this.

> +}

...

> +static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
> +{
> +	u32 reg;
> +
> +	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
> +
> +	/*
> +	 * Not need check error here because it is never happen at hardware. IP

If you move 'IP' to the next line it will be better to read.

> +	 * just wait for few fclk cycle to complete DDR exit pattern. Even
> +	 * though fclk stop, timeout happen here, the whole data actually
> +	 * already finish transfer. The next command will be timeout because
> +	 * wrong hardware state.
> +	 */
> +	readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
> +				  SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
> +
> +	/*
> +	 * This delay is necessary after the emission of a stop, otherwise eg.
> +	 * repeating IBIs do not get detected. There is a note in the manual
> +	 * about it, stating that the stop condition might not be settled
> +	 * correctly if a start condition follows too rapidly.
> +	 */
> +	udelay(1);
>  }

-- 
With Best Regards,
Andy Shevchenko



