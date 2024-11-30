Return-Path: <linux-iio+bounces-12902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BE9DF333
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C682810F6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F91AAE37;
	Sat, 30 Nov 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N40pQPFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803368468;
	Sat, 30 Nov 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733000191; cv=none; b=SSKvc8Y1ndZIsrn9CB339EHncNP2xhwfsajWwT/9laKYs5+b3oBp6r7ip5k09DV/IefeWcCfLAUu3xeHm5FqNJMMYpHJIWnHJ/TkTzTeBzUHK8qxXXoGomTuBOaze9GBcxRjm5B0zlpOZgu6IrI6qzknJsrC6c28SawyEatwcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733000191; c=relaxed/simple;
	bh=AuoCNRh1zJIBYYjOrPQovumijuE60CAF61F+tC5WQAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDWa2wMF//HqEjYzwxTKOlxDiKMrXkbz8uicVtsD8MJBj0nTaXW8mU7g+FGp+aLo1bY/XhnlibOLTwh8/aXHLc54HPJ8eRlXkA7sWuVkofF6OSWOv3pmEgKqG9jnmXMW006M99H6l3NX87Gj4DPfwgX6Ny0MCCRii0WZ2gTvA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N40pQPFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171EFC4CECC;
	Sat, 30 Nov 2024 20:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733000191;
	bh=AuoCNRh1zJIBYYjOrPQovumijuE60CAF61F+tC5WQAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N40pQPFvEA4Yt6n5U+ITE4SK65/9YK7o/+d8MSgKacZqLCSQ45c9/h2RVSHBpRfoE
	 TaSHJ4XmxjuwiRkSkjU1G2yhZZErifyVvOIhkxGOBPeNfK2IkDCwcV4I/DZjtNfffi
	 m06mQ+QCj98pzq9UKPNHZRl0RIz6J8AC/BNd6lczqLezYFhGf1YSNHkyeIv5A/1amQ
	 pKsWAKMtMSdBKjnlgkctXc0xegeDdHYHgYFgm8oQidcf0SWYXW+i76RMCcTOfQ5Fu3
	 BLb1aff7QfWpPQfiq65K8dzVid/rygHQaspTpBbqHHz/PLzNqguJ/A6ucxsTXW80Nn
	 UlX2vWAzdkbIQ==
Date: Sat, 30 Nov 2024 20:56:22 +0000
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
Subject: Re: [PATCH 05/11] iio: imu: kmx61: fix information leak in
 triggered buffer
Message-ID: <20241130205622.6bc2339e@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-5-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-5-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:13 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'buffer' local array is used to push data to user space from a
> triggered buffer, but it does not set values for inactive channels, as
> it only uses iio_for_each_active_channel() to assign new values.
> 
> Initialize the array to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: c3a23ecc0901 ("iio: imu: kmx61: Add support for data ready triggers")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.
> ---
>  drivers/iio/imu/kmx61.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 324c38764656..e19c5d3137c6 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -1193,7 +1193,7 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
>  	struct kmx61_data *data = kmx61_get_data(indio_dev);
>  	int bit, ret, i = 0;
>  	u8 base;
> -	s16 buffer[8];
> +	s16 buffer[8] = { };
>  
>  	if (indio_dev == data->acc_indio_dev)
>  		base = KMX61_ACC_XOUT_L;
> 


