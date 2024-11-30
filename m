Return-Path: <linux-iio+bounces-12881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08A9DF291
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E102811F7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301301A9B4E;
	Sat, 30 Nov 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1yAdpZJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7C1DFF7;
	Sat, 30 Nov 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991199; cv=none; b=dz/iTPDmWxL1SejoREhVkcAXEu565MHEvset+81QUxxQQGt5SXpqiqat2D2SoeH4MK9nAiLDHMOS9uqBZcAy2smMYlPUlA8sVEPnxkHLDiixhXiV7GcCnraIdHBMfk7gKhsx4MJrMOtI0MNYjwZSYndNAwAMMh4Dha2qDsygCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991199; c=relaxed/simple;
	bh=UzuY+8ESGGJXDkWdvBN0logfSHYVgFf/GHn0SF5b6fE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtSwVmTG7Y/EPM1LnrLLYbM91n5wCTl9vszkVdNcKcYVvq0DaMb+IaK3XIwa64Si+qul7MuI/zUKUJOwYPT7n8uLkfvNYMkpBUGrdVcNlUumcfs2rcOvGU7apln/yQ/QTqo0kp5ye/0X/FX5FzMwg3c8+SH7xW/xPiPDoXOoU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1yAdpZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1AC4CECC;
	Sat, 30 Nov 2024 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991198;
	bh=UzuY+8ESGGJXDkWdvBN0logfSHYVgFf/GHn0SF5b6fE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D1yAdpZJwj+hl9KdAOg1fknHqRHgeJMsv0d4Yy9KfXccIO2pDU1OCC7GK/GAaCxjh
	 tSURKD3Ze70vMhShB4GjrHYA5O/hhxYCjQb2CHiz1sWuhW+W/Fj74Zc2wY0sngp85N
	 qmJZyfnweRYxAOQY3U/Fu42RxhIUPxbBcNa+6lR0hLpY5F/K4UQcLCXZH0Q/fdCUt3
	 SoY/ME72nmycDaZMd7WwY+l6El5j6P40FyodAXPO5y/DV30g6UZZNQx3hGpBtylN0m
	 lNQHjCADZpvLoRDhM/xhFxFyL4ifZBKyC7BdYMnoNJiQX3rdnUNTE6XAj8Gs1+sX+K
	 X5xVP/6HSNaGA==
Date: Sat, 30 Nov 2024 18:26:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
Message-ID: <20241130182628.3d35817b@jic23-huawei>
In-Reply-To: <20241130181506.27d0c72a@jic23-huawei>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
	<9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount@gmail.com>
	<20241130181506.27d0c72a@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 18:15:06 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 28 Nov 2024 11:03:40 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > Many of the Kionix/ROHM accelerometers have a "PC1 - bit" which enables
> > the accelerometer. While a sensor configuration like ODR, g-range, FIFO
> > status etc. are changed, the PC1 bit must be cleared (sensor must be
> > disabled). (See the description for different CNTL registers [1])
> > 
> > In order to ensure this the kx022a driver uses a mutex, which is locked
> > when the PC1 bit is cleared, and held for the duration of the
> > configuration, and released after PC1 bit is set again (enabling the
> > sensor).
> > 
> > The locking and PC1 bit toggling was implemented using functions:
> > kx022a_turn_off_lock() and kx022a_turn_on_unlock().
> > 
> > Based on a discussions [2], the IIO subsystem prefers open-coding the
> > locking with scoped_guard() over these functions.
> > 
> > Drop the kx022a_turn_off_lock() and kx022a_turn_on_unlock() and use
> > scoped_guard() instead.
> > 
> > [1]: https://fscdn.rohm.com/kionix/en/datasheet/kx022acr-z-e.pdf
> > [2]: https://lore.kernel.org/all/20241126175550.4a8bedf3@jic23-huawei/
> > 
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > ---
> > Revision history:
> > v2 => v3:
> >  - New patch
> > 
> > NOTE: This patch uses the if_not_cond_guard() which is currently missing
> > the iio_testing.
> > https://lore.kernel.org/all/20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com/T/#m69982b23da9f71e72d84855b34e9b142cb3a1920  
> 
> Looks good to me.  If no one else comments, I'll pick this up when
> I have the precursor available (so hopefully just after rc1)
or maybe not.
https://lore.kernel.org/all/CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com/

Seems Linus is unconvinced.  
Hmmm. We might have to roll back the uses of cond_guard() entirely.
Which will be a pain.  Ah well. Sometimes an idea turns out to not be as useful
as it initially seemed. 
46 instances to get rid of in the tree today...

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 


