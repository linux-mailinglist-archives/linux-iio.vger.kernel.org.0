Return-Path: <linux-iio+bounces-12906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CE9DF340
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD42B21464
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388291A2C3A;
	Sat, 30 Nov 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqIgCHkY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28E1A4F01;
	Sat, 30 Nov 2024 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733000426; cv=none; b=qhJAEzYD5dYyu5cD/1h+opALjOwe15cYbaQ8R6iq4lcppsQ5TLS+fG5baiDI6s7T7VNByllTBZCe464UKisFpsY6bAuFgw5gDeAouaxxZIUOx4vUNBwiUT8iwX+KKFZc06dobmbs1Mz23XWIC6au+4lYUo15AkWQi2v8gT+Y3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733000426; c=relaxed/simple;
	bh=Twjwxj+blaTXYS5DuzPEYWptVgbEwjG1QW2UqPx76bA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDkQIN9n5FW6fgVUGL9BzCHGxc6bVWoV6xKqitlapg7m+e9wyU1/PasJVi+m1LsenrAG0dvyIlEpGt+682rpEiECV+9HW4dmfs/C/s8VRDeh23UGjv2CEVmb7FG/lk5EfWcnFZAbBADyjjRkt/lugmtigBsN0UIXG7nLhs5zN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqIgCHkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA388C4CECC;
	Sat, 30 Nov 2024 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733000425;
	bh=Twjwxj+blaTXYS5DuzPEYWptVgbEwjG1QW2UqPx76bA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OqIgCHkYM00fmuOn6q/Gunj4MBH3/yWHKnoYJM1isBZRhfOLVnH0Vpn0PZuOEt0jU
	 q0JBdysrhnkn+kG1K4cQ99QTA9tyXPANclasQpWxETSwPKC64lQIlf/neyXMjj1oNc
	 ZwIvd800K7AkdnAP4lUMNLK4YvAFDWPyp+mAu+EsXlS1DsTq3A4QhxQZnt8lKBy1UQ
	 nHod0/gle+JOfMNhkqDCMOuEWPkgS0Ra3aLURbQ1Pxjtgqbd9l8wQfIlKdvA4Y6pGC
	 4KTwR8VK4cLJ/6bgB64JTXiFiyegKISsSgn//2i6ltzCrIQ05oBMHqSSVA4+DX5UVV
	 +5HiZYlXDTWmg==
Date: Sat, 30 Nov 2024 21:00:16 +0000
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
Subject: Re: [PATCH 02/11] iio: adc: ti-ads1119: fix information leak in
 triggered buffer
Message-ID: <20241130210010.1b9c7bed@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:10 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'scan' local struct is used to push data to user space from a
> triggered buffer, but it has a hole between the sample (unsigned int)
> and the timestamp. This hole is never initialized.
> 
> Initialize the struct to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.
> ---
>  drivers/iio/adc/ti-ads1119.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index e9d9d4d46d38..2615a275acb3 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -506,6 +506,8 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
>  	unsigned int index;
>  	int ret;
>  
> +	memset(&scan, 0, sizeof(scan));
> +
>  	if (!iio_trigger_using_own(indio_dev)) {
>  		index = find_first_bit(indio_dev->active_scan_mask,
>  				       iio_get_masklength(indio_dev));
> 


