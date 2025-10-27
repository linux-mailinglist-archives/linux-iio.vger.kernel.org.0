Return-Path: <linux-iio+bounces-25459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F4C0D57B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 12:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE24D1887757
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 11:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DE62FF17D;
	Mon, 27 Oct 2025 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSWUjy9M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8602EF66A;
	Mon, 27 Oct 2025 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566130; cv=none; b=iGBOk7J1oH7mfdheF/zSir3Kh9aJwl7G/KvRqG8q7z8CEcs0qeekx2ZtE0pqqargZeJMFkCiSY+1IhHWo7cQrQ477emunz2UES2rqQHMGKo+PEvlquy6Dc/VOOy4I/6trqYSo88TS4Rm3Bns1+zz3Z+mAU7LiRKS6omXV2qP52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566130; c=relaxed/simple;
	bh=NAtU0QBJGB4qkpNyrP6hOV6yXYgOm3g3QcU+ldfi3as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/BsP9BXdOfjrbEztYTG3oq0tnLUX1d356j4b4ktVzCO11YrYDcmX4wevT81FIOUgh8R46ZDNPHtFMMign0/iRG9m4YQyMyRhssDcbJngaS5hBx00GcQbrwWz/LZ+ktOrE2fqC2HFVDTDImjcyWSYfNdskPMU08K2nc73Y91DbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSWUjy9M; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761566128; x=1793102128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NAtU0QBJGB4qkpNyrP6hOV6yXYgOm3g3QcU+ldfi3as=;
  b=gSWUjy9MMZZdqWjIfxHDBD5z0QWBu5KYdhle4qUqlzdRKsIp7IiCkmvE
   m6X2VKBMKxcbiSL4NycDuCWEhptGpB/L0pL1ahdHCIXBolmVRBxaGJMaI
   8wSifKDissyCpBjHwBHTtUZpU/fvnC7FmcJ8E68mmdC6jNWDi57mY8HfJ
   Thl295qL94xdT5wSus8XnAPSHgru23+oYlk5cYFSaIJe0kGaXo3KCgTJm
   pj5Qo0u5mCS5//Mpjd2pPxiLwoNyqNvoe6H6LRqsi2dKUPwC+wQ3zG68I
   B81R0cdPq5ZerpDRqwbPnwmMUDcugR/SV5Yt2FoSz6kVhxHJOsvP4iv4c
   w==;
X-CSE-ConnectionGUID: 1jyl6BEfT7aur2qgnemEyQ==
X-CSE-MsgGUID: pX0BLgf1Tv6nwCF73V4NCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62848294"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="62848294"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:55:27 -0700
X-CSE-ConnectionGUID: 5+U2GBq8QbSgUmCCyn2NwQ==
X-CSE-MsgGUID: A3T40CaPSIa98iIf+2Gc0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="222233287"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:55:25 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDLoo-000000030IO-2NHH;
	Mon, 27 Oct 2025 13:55:22 +0200
Date: Mon, 27 Oct 2025 13:55:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Fix irq assumption regression
Message-ID: <aP9dqnGb_tdWdr7y@smile.fi.intel.com>
References: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 11:18:17AM +0100, Linus Walleij wrote:

Hmm... Isn't this already being discussed somewhere? I have some déjà-vu.

> The code in bmc150-accel-core.c unconditionally calls
> bmc150_accel_set_interrupt() in the iio_buffer_setup_ops,
> such as on the runtime PM resume path giving a kernel
> splat like this if the device has no interrupts:
> 
> Unable to handle kernel NULL pointer dereference at virtual
>   address 00000001 when read
> CPU: 0 UID: 0 PID: 393 Comm: iio-sensor-prox Not tainted
>   6.18.0-rc1-postmarketos-stericsson-00001-g6b43386e3737 #73 PREEMPT
> Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
> PC is at bmc150_accel_set_interrupt+0x98/0x194
> LR is at __pm_runtime_resume+0x5c/0x64
> (...)
> Call trace:
> bmc150_accel_set_interrupt from bmc150_accel_buffer_postenable+0x40/0x108
> bmc150_accel_buffer_postenable from __iio_update_buffers+0xbe0/0xcbc
> __iio_update_buffers from enable_store+0x84/0xc8

> enable_store from kernfs_fop_write_iter+0x154/0x1b4
> kernfs_fop_write_iter from do_iter_readv_writev+0x178/0x1e4
> do_iter_readv_writev from vfs_writev+0x158/0x3f4
> vfs_writev from do_writev+0x74/0xe4
> do_writev from __sys_trace_return+0x0/0x10

I believe the above 5 lines are not needed.

> This bug seems to have been in the driver since the beginning,
> but it only manifests recently, I do not know why.

...

> +	/* We do not always have an IRQ */
> +	if (!data->has_irq)

Wouldn't check for 0 be enough?

	if (!data->irq)

> +		return 0;

This will require to store just an irq (and perhaps we may read of local
variable in ->probe(), who knows?). But size wise it's the same as current
standalone boolean.

-- 
With Best Regards,
Andy Shevchenko



