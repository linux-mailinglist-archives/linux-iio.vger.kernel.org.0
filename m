Return-Path: <linux-iio+bounces-26075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5FDC4412B
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 16:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EDF1886FDC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAB2FB094;
	Sun,  9 Nov 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzxhYaBe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D02D8DDB;
	Sun,  9 Nov 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700531; cv=none; b=Netqca3Dz6B83U7+Fl4mKRNUxN6XgG1DYzO3e+65toOkBq1giFSNn8hRSH8TNybxTwnfKMLraqfyKXL79MncxSVRJQjZq9905P8cZjxvxSmZETxrRAnQxIAY0+RZHUySMo9SY0mdOf22/3uoqZ9OtqfPGIzT7B0Nzj8/0gcvlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700531; c=relaxed/simple;
	bh=7TnX8P67TNlQSsw6iI2FLXwdhuCVC+1pAv9T9zXO/to=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/5ZCNIulBmOMkNlHDLQ6uDa7aFp3X66QeQrf3yiL9r8VNYo5G/Hp3oq8KKf3DzqU/sTUcj8F1AyxkRdpnxGT6ErWCZlKyVzPsBv2AMqu+Osyl0i9xSKbkYR6dRXIWdDve29Cf9DEIOKqgN+/xepRgkPSJ6bWC85sz41itu1Jro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzxhYaBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B13C19424;
	Sun,  9 Nov 2025 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762700529;
	bh=7TnX8P67TNlQSsw6iI2FLXwdhuCVC+1pAv9T9zXO/to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QzxhYaBeJTqAK5uwlC8+KPsEmpOOCYS0uPWzbeKNIGcA2isL/ER9WzmKzq8ceEdUb
	 pmKln9d781O5FaSxuCNXg9ZeeCh2EqOCLcmgNCtJNSKCXvd/2HvxA82nzFs9qCDixF
	 19Drnl1LY6hzqei5e/1RzDcHFC94KwovNkloojdKXrBrIuJhULn2I6WRVobUh0Iyv6
	 2MdT4Jhuf3PF4KIC0YL4wk61OgBYrGB3ZJhlZ3e6iVHdE41XnzDzlcVpqMDi1FW+3F
	 H6BYkI/TM5k77n/IE9TuMnoe8XZpA7StPvT1Mreco+5+xBnS8GTbMD8eiITdpFloWW
	 kfg5ekIgcx9BQ==
Date: Sun, 9 Nov 2025 15:02:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: Fix irq assumption regression
Message-ID: <20251109150203.56ece278@jic23-huawei>
In-Reply-To: <aQkF7_beMRiAOR_1@smile.fi.intel.com>
References: <20251103-fix-bmc150-v2-1-0811592259df@linaro.org>
	<aQkF7_beMRiAOR_1@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 21:43:43 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 03, 2025 at 10:36:18AM +0100, Linus Walleij wrote:
> > The code in bmc150-accel-core.c unconditionally calls
> > bmc150_accel_set_interrupt() in the iio_buffer_setup_ops,
> > such as on the runtime PM resume path giving a kernel
> > splat like this if the device has no interrupts:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual
> >   address 00000001 when read  
> 
> > CPU: 0 UID: 0 PID: 393 Comm: iio-sensor-prox Not tainted
> >   6.18.0-rc1-postmarketos-stericsson-00001-g6b43386e3737 #73 PREEMPT
> > Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)  
> 
> These 3 lines are not important.
> 
> 
> > PC is at bmc150_accel_set_interrupt+0x98/0x194
> > LR is at __pm_runtime_resume+0x5c/0x64
> > (...)
> > Call trace:
> > bmc150_accel_set_interrupt from bmc150_accel_buffer_postenable+0x40/0x108
> > bmc150_accel_buffer_postenable from __iio_update_buffers+0xbe0/0xcbc
> > __iio_update_buffers from enable_store+0x84/0xc8
> > enable_store from kernfs_fop_write_iter+0x154/0x1b4  
> 
> > kernfs_fop_write_iter from do_iter_readv_writev+0x178/0x1e4
> > do_iter_readv_writev from vfs_writev+0x158/0x3f4
> > vfs_writev from do_writev+0x74/0xe4
> > do_writev from __sys_trace_return+0x0/0x10  
> 
> As Submitting Patches recommends the commit message is better when it has less
> (unrelated) lines in traceback(s). I already mentioned that those 4 lines and
> more are not needed (important), and maybe removed. I leave it to Jonathan to
> tweak whilst applying.
I trimmed them out.

Applied to the fixes-togreg branch of iio.git.

thanks,

Jonathan

> 
> > This bug seems to have been in the driver since the beginning,
> > but it only manifests recently, I do not know why.
> > 
> > Store the IRQ number in the state struct, as this is a common
> > pattern in other drivers, then use this to determine if we have
> > IRQ support or not.  
> 
> I would just assign the returned value of irq to the data field and hence drop
> the '=' in ' <= 0', but I am not going to pursue this. Up to you.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 


