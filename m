Return-Path: <linux-iio+bounces-25860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D78D1C2DEBD
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 20:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A284E1E4E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 19:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49193320390;
	Mon,  3 Nov 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhjrjM6b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052D1D63F3;
	Mon,  3 Nov 2025 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199034; cv=none; b=iiH02qIAV6qvu/iKahd0rFLrjlcfIxw+EwacUuGjDIom2ULvxLo73Mh1KD91msyYkahrSw1Yj3+m1cYognIbH1fh2huffI0SinnmMOsOPmf1apxm72ewAgR0WM0dJhrU4pDeJw5Xrjvyu870bBxZBGr6iNlhh8kli9+OrznPsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199034; c=relaxed/simple;
	bh=q/4OWKXfixl0s8ySl+tIgtHerJ1V2sbsB5qpc67S7Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE/EIZ89CiE0QubxlzyW/p34UjfUDyBTQm2OuuFgQorCB0V09yU8ljqw5sQTe5x/1Wx5U2gS2wMgnBU1HsDFHrmYD91xSrfbUH2Jnhn6gon4OTNyyQOc9VLTwvhTTSbWojFoD374JJJH+otIfawxWRv1hy5VaaCmC84erfXNZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhjrjM6b; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762199032; x=1793735032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q/4OWKXfixl0s8ySl+tIgtHerJ1V2sbsB5qpc67S7Yg=;
  b=XhjrjM6bHGB3v1Jh6CgijyKwovL89vo15Doc3bWbUQbrFolpMjsfQcVk
   uNxnsYCr4abzUlMRgeC4mHZK7gkfnQzefv0K9I1j+c5v5wxdzrlMAfhDG
   E6gL66i7CO8V734c20INCQWoaaGTvnyAtCPdMALHoFXWZ615OmvhnuNcx
   9XB5V1Pizu6PQ598nrlGV7p6VLG2V0rxJcm4eO8/SxOTvdldx7XmJ8BoF
   5bqpUNL/h2VU/oNmhZTHRf7g/RAXJOvkgpXEcYKRohA0Fymp8lAgjiKKw
   05Bv+Y8BK+b1BwXUZ5mAFtGWFZZ/buy4h2zUfdZS5K88FOQjjmBRSpXuH
   A==;
X-CSE-ConnectionGUID: o5rXlLe3T86+/vmnDkjlsA==
X-CSE-MsgGUID: 20mY27KzRNCjioGlckYlEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75635350"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75635350"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:43:52 -0800
X-CSE-ConnectionGUID: uGCxjjoZTu2f8crq7O9LqA==
X-CSE-MsgGUID: ++B0sV0/SESfA+dB/4p6Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="192117771"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:43:49 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vG0Su-00000005Fjd-1HzY;
	Mon, 03 Nov 2025 21:43:44 +0200
Date: Mon, 3 Nov 2025 21:43:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: Fix irq assumption regression
Message-ID: <aQkF7_beMRiAOR_1@smile.fi.intel.com>
References: <20251103-fix-bmc150-v2-1-0811592259df@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-fix-bmc150-v2-1-0811592259df@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:36:18AM +0100, Linus Walleij wrote:
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

These 3 lines are not important.


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

As Submitting Patches recommends the commit message is better when it has less
(unrelated) lines in traceback(s). I already mentioned that those 4 lines and
more are not needed (important), and maybe removed. I leave it to Jonathan to
tweak whilst applying.

> This bug seems to have been in the driver since the beginning,
> but it only manifests recently, I do not know why.
> 
> Store the IRQ number in the state struct, as this is a common
> pattern in other drivers, then use this to determine if we have
> IRQ support or not.

I would just assign the returned value of irq to the data field and hence drop
the '=' in ' <= 0', but I am not going to pursue this. Up to you.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



