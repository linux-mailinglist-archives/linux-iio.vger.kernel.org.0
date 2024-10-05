Return-Path: <linux-iio+bounces-10187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB4F9918A6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2224B21429
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DEF158853;
	Sat,  5 Oct 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DABUvmgp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21913C836;
	Sat,  5 Oct 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147818; cv=none; b=SJAoMjSgG4CJGA2WisZukJ/YwWPyNGbegeJsNLRwvoeEqEwc1w//vj4xkBEnPhXsbSVnEKhUGCMrG/fh2zJ/JEFlgRKM0WO8lOgqDDfN/6iG55TKlhTLwtJ+7v06GjXTZ+r+kVGpyMQZCO2L11ZbIllxHeBcVRV9PNZp/5C571k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147818; c=relaxed/simple;
	bh=Q2Hc5JYcMQmk35SmPtUW/B3tp6EWkzzfUkPIU18A1eI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeRNXBYSLtAwg+WDP3LeWwzpWlhE4Pnflu7fZMYt0Kjs2sAKSbLKLjslXXhvaK8zeRw1R3g5+ZQ3GXNUIZjGfYF45MGmtcUNYzuH+49QHEKtWWJro22QwwdGenQGhv5ujYzC56rL1LBluWaCDjj1Ro4SJfdrTNamrU9EgREKr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DABUvmgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3DAC4CEC2;
	Sat,  5 Oct 2024 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728147818;
	bh=Q2Hc5JYcMQmk35SmPtUW/B3tp6EWkzzfUkPIU18A1eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DABUvmgpfm2euluYnLVYRWp3jWXFYgb4/3iR7PkGPDofxhukoRy7p3KWrL+4AGF4R
	 rCOHALiVkuCv1qcY+50ROV6EjMnJ9z1pXc9Qav8qfnlx1TSMNvH62g2LrXDQtgTuf1
	 lgq7q70rkVXC53TrC/P0XkwfxlzQk9IBpoWAU/rcDLbF6KhazhoTT4JUUkqEby7GUl
	 mEj3MJWm4JphE8fCZ1HGTU8qO9hvzZ6roYA4GcYwj1aQrt/QK318spHYMZk6IYXhK0
	 ot3Rm4S8Fxmydr8S2xGlJIWpYDnwZhZ3RwndtKWO/MB3G8bW/k4hJVul6nc3wKIFem
	 WNZTPqs44QgMg==
Date: Sat, 5 Oct 2024 18:03:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: vl6180: Add configurable
 inter-measurement period support
Message-ID: <20241005180319.2c9e8eab@jic23-huawei>
In-Reply-To: <CAG=0RqKM8HJ-rV54mCjo1-J6FOsed8zoHSWaVJ1YErSNNZDX1w@mail.gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
	<20241004150148.14033-2-abhashkumarjha123@gmail.com>
	<20241005174151.4bcd55f6@jic23-huawei>
	<CAG=0RqKM8HJ-rV54mCjo1-J6FOsed8zoHSWaVJ1YErSNNZDX1w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 22:26:09 +0530
Abhash jha <abhashkumarjha123@gmail.com> wrote:

> > Hi Abhash,
> >
> > Sampling frequency must be in Hz and reflect how often the channel
> > is sampled (not just the inter measurement period.  So this sounds wrong.
> > It is sometimes complex to compute but we have to stick to the documented
> > ABI.  
> Got it. I thought of skipping out the complex computation in the
> driver and assumed
> the user would give me pre-computed ms values.
> 
> Just one thing, Is it better to just use IIO_CHAN_INFO_SAMP_FREQ for
> "inter-measurement period"
> and get the input in HZ (converting HZ to ms in driver)
This one.   
> Or
> Define a custom sysfs attribute like `inter_measurement_period` to get
> ms values? for this driver.
Always best to avoid custom attributes where at all possible because
standard userspace has no way to know how to use them.

Jonathan

> 
> Thanks,
> Abhash


