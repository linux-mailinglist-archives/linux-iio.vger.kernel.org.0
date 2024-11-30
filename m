Return-Path: <linux-iio+bounces-12905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F19DF33B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC8328110B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D21AA783;
	Sat, 30 Nov 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNx44Pda"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A641A42C4;
	Sat, 30 Nov 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733000407; cv=none; b=HyxLrx+uVy9J8KNUt070SA7N0rPsOR/pSWZaho8OwDc41WCMi/gqQlumpxBp6wf/k6rHUDjpxep6AQOpYIaEGy+9PacIsZ/oAC/rDW5fBi4r5q8IP+/AuS10fWxH/jthKQqj30KpWNX6CsvukqHQQsErGtuaK/xUtezd4YRjvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733000407; c=relaxed/simple;
	bh=/5XdPhuvZbG2a1ohfg5ITn9YumfnKU2khzTA3AiMzRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7l+UR2bCGFh2ZA0kHEOHvs8yw1oHQIptKwUK0EUfRTNmuHhkjT4fgZUKeZSfGapkDYUugtOgorRvnMCePqwumnQhm8/bH2LWC91VsmZ6FfUYwvEZxAx6hdMN8pwnpwwazshFEXpr1H+YQRgiN4UIcnrEy17xSlVHIJMU69m1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNx44Pda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FEFC4CECC;
	Sat, 30 Nov 2024 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733000406;
	bh=/5XdPhuvZbG2a1ohfg5ITn9YumfnKU2khzTA3AiMzRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNx44PdaxccKkmmpntCmnedpjteDWGuvJP/qJOCQ/k8Cs/vSDbkAuaD/XbDQdeuz6
	 2AMlZIZ8QeE9uSLkihar0mkfRIvVtNKTBXJub/zwJOx3FNut3Y7GCx6/QTIyrKZZqw
	 QcjENuMADJahxxE+OtLiv+SUWLW383inwsIzKUxh0ZZPC4acJmiVbxcNwDm98FOI4W
	 EN+y9PxXdMFOzVIh2m40YqL6ZqMXCPoPS+D6FknuGcLClKaKXGgd4847ofW7qt0VNm
	 49CspZvIKLuKbJuAIDwheLF6sELH03kbRUNoqUJNUhTVHs/csEhdhyrQ8Zr/rY5GlE
	 Crp4bhgq46ciQ==
Date: Sat, 30 Nov 2024 20:59:57 +0000
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
Subject: Re: [PATCH 03/11] iio: pressure: zpa2326: fix information leak in
 triggered buffer
Message-ID: <20241130205948.389689b1@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-3-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-3-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:11 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'sample' local struct is used to push data to user space from a
> triggered buffer, but it has a hole between the temperature and the
> timestamp (u32 pressure, u16 temperature, GAP, u64 timestamp).
> This hole is never initialized.
> 
> Initialize the struct to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.
> ---
>  drivers/iio/pressure/zpa2326.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 950f8dee2b26..b4c6c7c47256 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -586,6 +586,8 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
>  	}   sample;
>  	int err;
>  
> +	memset(&sample, 0, sizeof(sample));
> +
>  	if (test_bit(0, indio_dev->active_scan_mask)) {
>  		/* Get current pressure from hardware FIFO. */
>  		err = zpa2326_dequeue_pressure(indio_dev, &sample.pressure);
> 


