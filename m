Return-Path: <linux-iio+bounces-12903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD29DF335
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214C32810C3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E61AAE2B;
	Sat, 30 Nov 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeEqf/Ak"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6578468;
	Sat, 30 Nov 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733000386; cv=none; b=Eske5aucARa3B89FJOUvU5kGQ1570tAeN5HoMx2T1KX84EdQMztAKp9o5RmARyqxvnL/AK6QPZ2yvFBiMM/xQUUVsLPQnJGUX6hn6TIU4qQ6gx4M4KmfvuyYL3VFZaWP3PWPbWzCJzwxMXlzJqMGAR4mC9lnTVtE6C9n5RXj324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733000386; c=relaxed/simple;
	bh=nL3v8itbGOexhyHoVUPezrnkQf2GpaPcNziJY3pGiOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzwtzwCDyUNu3Y4XRSfaHfCUm2WMNS1hgF4pl0MS/FGPv+R+kyQa0H9s+6brdK6zymJtT00QEVg9HpKOHLvc1C8Q+bSw8NQundQFjkMc5Dw1rdlg4pD4NyNm5DnsJODAq4P7Mpy5E0T1DFJeVJ80rXrNTyACqz+TxgZ39I7NQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeEqf/Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7813CC4CECC;
	Sat, 30 Nov 2024 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733000386;
	bh=nL3v8itbGOexhyHoVUPezrnkQf2GpaPcNziJY3pGiOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NeEqf/AkzZeVRGrtZgn7c44YJLWVldor+K4G1lEWact0hOs9+3wREbINoNhZ2zG7K
	 ybN72C06zUUHRFdXRjxh5FyiuE0HcNxNcu3eFm7HcZNzqjqdXMuUDLLr2gSfe17JFW
	 rfeD6/MiePBhfQ9FjfsJsB8roqryrpp/OTZq5KTeNTfCmyhHnaJYXyalUUu9ZDGicX
	 wbsS/EQ0VZTs7cPClERG+la9VgSDR8IJeOmqSFpJli4AFtsxjM4ycuP47IyW/jqQhR
	 FC9mM4VIQLr3EKVDXUqr8eDX659RLlW1IpdxZU3LHNLEF6hT/7BoFcArqfbTiHVJyz
	 6biNzsLAvFh5Q==
Date: Sat, 30 Nov 2024 20:59:37 +0000
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
Subject: Re: [PATCH 04/11] iio: adc: rockchip_saradc: fix information leak
 in triggered buffer
Message-ID: <20241130205937.19a24818@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:12 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'data' local struct is used to push data to user space from a
> triggered buffer, but it does not set values for inactive channels, as
> it only uses iio_for_each_active_channel() to assign new values.
> 
> Initialize the struct to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.
> ---
>  drivers/iio/adc/rockchip_saradc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 240cfa391674..dfd47a6e1f4a 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -368,6 +368,8 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
>  	int ret;
>  	int i, j = 0;
>  
> +	memset(&data, 0, sizeof(data));
> +
>  	mutex_lock(&info->lock);
>  
>  	iio_for_each_active_channel(i_dev, i) {
> 


