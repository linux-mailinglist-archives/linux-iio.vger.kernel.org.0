Return-Path: <linux-iio+bounces-12901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF62C9DF331
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B9FB21033
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B61AAE1B;
	Sat, 30 Nov 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyF4NiCv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30238468;
	Sat, 30 Nov 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733000121; cv=none; b=QwzHz+WjT4Lxe0c/66hZnbqSVHkwSxviayC37yTxYhno5Zg2zoo9DehRq51FZZSZWBnJqeaU+5JCtM1gkOTJjdx+cKzyVizTPl/2McsSS1FKKYHYCogsSwmqcApXghqW/A80HJcsgByE+7fV1O4TYjT1Z0ZSUev/ZFFe4UvZdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733000121; c=relaxed/simple;
	bh=M2PqRRL2ZesIf48j3Fj9dOolxQkHXdImTgsGfIzkYMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCwkFdRSIvSKiHoEX72bi5Xpg5u0VQx4IYoWrULC+3jBATiGUm5WpnvGPNxsvVjuDKrsyFJjD8oGdNqc1vp4HaBOgbDPVzWdQHzNgcQS5HEnkXHFLBuW3RmlBldqkzd4e66BLTCvLBRuOz7SySliu51Wwbhnjfdk+5Vk4+XRMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyF4NiCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943BFC4CECC;
	Sat, 30 Nov 2024 20:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733000121;
	bh=M2PqRRL2ZesIf48j3Fj9dOolxQkHXdImTgsGfIzkYMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YyF4NiCvxqWKqvK8nybDQkRU/6tXz5IK6el35hxB15+SPvD7OZwvZhW6drV836TI5
	 Esd5HJFUd07TXkkaRQv4jL7U29LqYz5eFQhxL1fI1lbpENr821FewzGwPUQgZjDrcY
	 hr9E3o1JFvConKcPuYnyEMdy7whDN0eiSEhPRN7mNCH5P0vVZ36Bt1LlyULCIBsq40
	 arJ8A6T9lAWFlnZKksvSwgQmgwy5PElD5+1i3K2UCAiYjGSgEW8Nt8T+299lc2+HMf
	 s60EvgwJvcbDQL8xhdrrfmfc5dW/aVU/BbbnPJNGW5tlDIpOUuRMcAoSRp/jFWNEX+
	 g4s5AoDUTlvQQ==
Date: Sat, 30 Nov 2024 20:55:12 +0000
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
Subject: Re: [PATCH 06/11] iio: light: vcnl4035: fix information leak in
 triggered buffer
Message-ID: <20241130205512.7a29ce90@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-6-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-6-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:14 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'buffer' local array is used to push data to userspace from a
> triggered buffer, but it does not set an initial value for the single
> data element, which is an u16 aligned to 8 bytes. That leaves at least
> 4 bytes uninitialized even after writing an integer value with
> regmap_read().
> 
> Initialize the array to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: ec90b52c07c0 ("iio: light: vcnl4035: Fix buffer alignment in iio_push_to_buffers_with_timestamp()")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.
> ---
>  drivers/iio/light/vcnl4035.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 337a1332c2c6..67c94be02018 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -105,7 +105,7 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct vcnl4035_data *data = iio_priv(indio_dev);
>  	/* Ensure naturally aligned timestamp */
> -	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8);
> +	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
>  	int ret;
>  
>  	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
> 


