Return-Path: <linux-iio+bounces-11359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71859B1A0A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 19:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1472CB2178F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851413B286;
	Sat, 26 Oct 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij+mOZt9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539953BBD8;
	Sat, 26 Oct 2024 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729963303; cv=none; b=qd3EPyXTj0y1U0aDVpQWJS22xl8AuzbuBoRsuoxl39odrC7z2CFZL7RHzdD3JaNB7sjXTz9lI+gbmNh2hkNBr1VM48hhwfES4ZiTw44Ys3RvKVd+YMMM/F4WHCC2IT4blB0FqOokXJIegF6zQh8x0I3neQq7ucgn4ssAlT/5wBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729963303; c=relaxed/simple;
	bh=WK1VLVpGK8zbKx9v6ZjvFchh32hBkFjWGCosFKSMLyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DI2M2fc6v8zDWHYPfi4TdTVw7QX618stZoYIzD6iOCV43ZMVt3mqbDS4ygccRbTJbcwyluNlHsHkrfYKA/EukX1OGJIEl50tQfpeiF1Kf74AUIAmxWbnM0sCSqoKODtKrijNpdFGUJLkxYM0Oaa0loKmND7cm57UUx0s+j12FzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij+mOZt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18663C4CEC6;
	Sat, 26 Oct 2024 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729963302;
	bh=WK1VLVpGK8zbKx9v6ZjvFchh32hBkFjWGCosFKSMLyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ij+mOZt9nmJtaLrL9fyEYRQAt5roZsH3fRMvxg/vQBh2nolY/hJzasBYy/tcPqZJ4
	 +s1gZ/wyqIvbWty6XZghLFwR9+HBDcXlV7SKK6eEnmBEjejQlvoWybOLEV2/SP83r/
	 nOqgdwEs4P1yzPEt4dxA/wMz9BbGC49Ty96EldvAChgH/mPNeYF2K+YNJjS+qrIUHe
	 yvrd17g3DWpf1NT6JpQ5FomPL+DX1owu6kpL+htUQOXqQkUEj3V70k2Tlia+1X+z6Q
	 Pqdl+hFVRebl4v6Dq4ol/HZ1E7JTH21foU7ZWv1Xuy9aAVS4g9f6+Jc2GPiLzBtjsf
	 XVj2vd2RX8rFw==
Date: Sat, 26 Oct 2024 18:21:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rayyan Ansari <rayyan@ansari.sh>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 07/24] iio: accel: kxcjk-1013: Revert "Add support
 for KX022-1020"
Message-ID: <20241026182104.01086e41@jic23-huawei>
In-Reply-To: <fc87c8d8-db22-41f8-9594-4687f89881f9@ansari.sh>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-8-andriy.shevchenko@linux.intel.com>
	<20241026121619.668d07d7@jic23-huawei>
	<fc87c8d8-db22-41f8-9594-4687f89881f9@ansari.sh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 15:58:52 +0100
Rayyan Ansari <rayyan@ansari.sh> wrote:

> On 26/10/2024 12:16, Jonathan Cameron wrote:
> > On Thu, 24 Oct 2024 22:04:56 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> >> The mentioned change effectively broke the ODR startup timeouts
> >> settungs for KX023-1025 case. Let's revert it for now and see
> >> how we can handle it with the better approach after switching
> >> the driver to use data structure instead of enum.
> >>
> >> This reverts commit d5cbe1502043124ff8af8136b80f93758c4a61e0.
> >>
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > I'll take this the slow way as I don't think there is time to chase the revert
> > through the various trees and still get the dependent patches in.
> > Hopefully we will fairly quickly get the missing table data and can
> > bring this back again.
> > 
> > For now, applied to the togreg branch of iio.git.
> > I have tagged it as a fix though. and +CC Rayyan
> > (I'm guessing maybe that will bounce as you rarely miss people you should
> > CC!)  
> Hi,
> Sorry for not replying earlier, I've just caught up with the discussion.
> 
> I don't fully understand why this is breaking KX023-1025, but you know 
> more than I do here.
> Does this not mean that the use of KX022-1020 in the 3 devices (Lumia 
> 640, 640 XL, 735) using this from qcom-msm8226-microsoft-common.dtsi 
> will now be broken?
> 
Yes.  The issues in the currently driver is here
https://elixir.bootlin.com/linux/v6.12-rc4/source/drivers/iio/accel/kxcjk-1013.c#L321

This array is indexed using the enum
https://elixir.bootlin.com/linux/v6.12-rc4/source/drivers/iio/accel/kxcjk-1013.c#L176
and the new entry for the KX022-1020 mean we are one short of those startup
time definitions.

Without that the values retrieved for the KX022-1025 are all 0.

It should be a relatively easy fix if we have those times.
One side effect of this series of Andy's is that it makes it much harder to have
similar bugs in future. 

Jonathan

> Thanks,
> Rayyan


