Return-Path: <linux-iio+bounces-12896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32659DF321
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160F828111B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730B31AA1CD;
	Sat, 30 Nov 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPuirFpd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E717741;
	Sat, 30 Nov 2024 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732999769; cv=none; b=W98RBDwBXPONRq2jUKRQ9DLaeIIonENoeqJlIUgEQGeQmUYbJ+u72mk2mbham+P7Vmk3/8nT/T7KVm6aeKA8NBfdhes1qAJISOjH4X2cv8jFpRyQK98+IxYoLCCHoeXaX6bA66GJ7pP7VJqdLh6YMmBPqy8d3RayiYzJJBACNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732999769; c=relaxed/simple;
	bh=gObW6/DphjkWINxbkQ5lX1lAeobeYEyaexCD5b0jj0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yt5wjJFrIvCT/PwYUlR9qxZUWjAr7wbtAqnYwBcVPrD7xDj8bCqQKWohRv8UliZ2lRgSyGnCUtM6yKrOmhW+8niXKZRRAfMXhPKKIRwqEotNW9fs0zaItFIhl18c0OuTj1SHIOW4tNWC+oYtjAWoSQRGCbMRzNARhO7DKn9L4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPuirFpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DDCC4CECC;
	Sat, 30 Nov 2024 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732999768;
	bh=gObW6/DphjkWINxbkQ5lX1lAeobeYEyaexCD5b0jj0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oPuirFpdQJbcN8Co004/JNRNsm6hNEvUo+31lwVnb639HbOQ4zYQbTdBfIKwUTABK
	 TkcnYx7VwnzPah8FsF2rdF7f0VDNmToFiZNBy28eaCKQTFv+JekpkP7Cuet/7iQ9oF
	 lYDsVqFmV3hy2PcTbIsudMgaGMvp6Un0bnp6VGaIOPnoKh6z2QnH4R28c7+DWqaYYm
	 tghN+7QxYYSFyjV5SePDeZo38WbOrkxU/UNKsmDTxFsAmVG1pWF/zj8oMMj6mzxsXo
	 khF8GB4HyfUwtpSNnwDUCSIrpm+VLvQ4z83ZhwjqHx+La9zcHRT/KFXBtcaTXSJxd3
	 IN0rca2FVssiQ==
Date: Sat, 30 Nov 2024 20:49:23 +0000
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
Subject: Re: [PATCH 10/11] iio: light: as73211: fix information leak in
 triggered buffer
Message-ID: <20241130204923.45d71fa4@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-10-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-10-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:18 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'scan' local struct is used to push data to userspace from a
> triggered buffer, but it leaves the first channel uninitialized if
> AS73211_SCAN_MASK_ALL is not set. That is used to optimize color channel
> readings.
> 
> Set the temperature channel to zero if only color channels are
> relevant to avoid pushing uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: 403e5586b52e ("iio: light: as73211: New driver")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Huh.

If the temperature channel is turned off the data should shift. So should be read
into scan.chan[0] and [1] and [2], but not [3].

Not skipping [0] as here.

So this code path currently doesn't work as far as I can tell.

Jonathan

> ---
>  drivers/iio/light/as73211.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index be0068081ebb..99679b686146 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -675,6 +675,9 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>  				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
>  		if (ret < 0)
>  			goto done;
> +
> +		/* Avoid leaking uninitialized data */
> +		scan.chan[0] = 0;
>  	}
>  
>  	if (data_result) {
> 


