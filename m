Return-Path: <linux-iio+bounces-12898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193E9DF326
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC98B20D1F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC7E1AA7BA;
	Sat, 30 Nov 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP1zxkMW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B551AA1CD;
	Sat, 30 Nov 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732999870; cv=none; b=Iv4s+z+Q9OklV7eUm3B8z4NegHGKxhzb4p/6AoYnRYxGw7lGOJ6pxGKaeRH1tPsYn+4IY2BT5ypQ+QtyiGqvXm2h07RHRQgW7fBuJwm3P+9WPQUPiM+DaeuiMVZrSAKVuwzcXomRJX8u/WCwRttLXoDkc0PlZ0+xV9lRis1cxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732999870; c=relaxed/simple;
	bh=l5HTMxOvV+HOmgGEwOj7jUljAwXcKy+LbuXtcSZrJQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uY5LFenusZhF53WEER8StGQ/v8eBLGjhLwn6NAhk7tuQtHo6fH12hPzasOZSF1Gca1JexCHJTHDlIuJqSKg18A92TIzIZKWWUhTBv0KhjJqLIB/LnrjbPyZLCtX7+O3cB1/rZtr8tmkebBC807A6c0ZT8zNCw/EpvLq4hgXawUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP1zxkMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCB5C4CECC;
	Sat, 30 Nov 2024 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732999870;
	bh=l5HTMxOvV+HOmgGEwOj7jUljAwXcKy+LbuXtcSZrJQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nP1zxkMWGb09LyjE524QqbGvp1XArWCmGuvg8PKZDn825vlSe2taI8R7uc120W1MU
	 pGc9balBNdMJE3ePiEk1M3MLDNts+qRouR0sjiLx8ElTo6roHMLeC5cPVMtDyMwgOh
	 cGd0WiMiFycD7FmByMGWAzMtukqAgtRz0cGU1jYUyCVaKYajEgQAneABd3HdnUFkfx
	 EQALmgVRt58IsQkO46kg5PEz+NR0HxHIi5Vo8QIz1bgFrD2hLBVtrYxs2cmA4dGnL3
	 kcXKjxCge0lMHXPZS0PM8b37CeCi7O6+qy5aqrzYTLg2PBEEI3sZ9WPwCqnUSfTnIP
	 dRYvDfT8W7/Nw==
Date: Sat, 30 Nov 2024 20:50:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Antoni Pokusinski
 <apokusinski01@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH 09/11] iio: dummy: iio_simply_dummy_buffer: fix
 information leak in triggered buffer
Message-ID: <20241130205059.20790814@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-9-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-9-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:17 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'data' array is allocated via kmalloc() and it is used to push data
> to user space from a triggered buffer, but it does not set values for
> inactive channels, as it only uses iio_for_each_active_channel()
> to assign new values.
> 
> Use kzalloc for the memory allocation to avoid pushing uninitialized
> information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: 415f79244757 ("iio: Move IIO Dummy Driver out of staging")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Oops. Got it wrong even in the example driver.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/dummy/iio_simple_dummy_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index 4ca3f1aaff99..288880346707 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -48,7 +48,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  	int i = 0, j;
>  	u16 *data;
>  
> -	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  	if (!data)
>  		goto done;
>  
> 


