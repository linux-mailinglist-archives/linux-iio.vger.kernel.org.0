Return-Path: <linux-iio+bounces-16573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32489A57C05
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D0B1890C08
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286241BE871;
	Sat,  8 Mar 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtoFuYjF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809C14A8B;
	Sat,  8 Mar 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451790; cv=none; b=t5Dss6fS5vE8B/bYvq6L/t21sFEgm+AZcyDk2uO/1UF1jqK84a5C61yQ9B/rkf7nJmuTitYi5YoYZXYdGMkMRZDAWj9xgMPCWawhjSRY9BxWuyvq/cZOBsnsFm2qPi0uYwFisz8WjVlcVTiA2iNY1kKJ3paMoeIhogfQw56wSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451790; c=relaxed/simple;
	bh=Qbz8v+nj352/6PhPeuOs4EF4ojbqXVONZYrOp3NaJRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqWeWfLUZTAiMlcoJvRAUOTv/nTRQX1kNYyixTGYnWqFxcR81AgwGfY4eyC4ROtsPVCVaj9XSrEAyM/PhcgnLA/RWaLStN+SGHSnZNUXZGuY4Yw3IBPRqaPoy1wNS8kLAi5Y6lT91mxD29Z4ggkn5ks1gCQZ3oRv+vIBmKXfWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtoFuYjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906B7C4CEE7;
	Sat,  8 Mar 2025 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741451790;
	bh=Qbz8v+nj352/6PhPeuOs4EF4ojbqXVONZYrOp3NaJRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LtoFuYjFQNKp00XKwba9O/KyZ/HDXXwqihqHc3SXvbGnDpqW++1rAL2XHIQeLsr6u
	 ATqWzCJ4mM5Y66XPSZ1mxt8jPh1fhf2kYRoa8ahJ8/orUfRulYIq/iS0n42OM036N2
	 xBTIr2gBnljRQ7mhd9mMIxkEX54XSZhIYVC/djZ1yDbLB+oQLnjSOfCXDnKpHRpw7C
	 fGWop8veXiDMYFT+3lvIerjR9V1M8zhFpqdKa34MRfc55nz6CdZAblDS9BhVyvtPru
	 oI7x81ljZUU6xC78iakqbChczFERh2jWLFzF6wzmejRMxCdb9w3GXwym5EVxr3yqRV
	 KZEKTKAOkDY4w==
Date: Sat, 8 Mar 2025 16:36:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/10] iio: adc: ti-ads7924 Drop unnecessary function
 parameters
Message-ID: <20250308163622.5ebbc1f8@jic23-huawei>
In-Reply-To: <2bb4c61122eca2f3a35f6087e7d9815675013f66.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
	<2bb4c61122eca2f3a35f6087e7d9815675013f66.1740993491.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 13:33:21 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Device pointer is the only variable which is used by the
> ads7924_get_channels_config() and which is declared outside this
> function. Still, the function gets the iio_device and i2c_client as
> parameters. The sole caller of this function (probe) already has the
> device pointer which it can directly pass to the function.
> 
> Simplify code by passing the device pointer directly as a parameter
> instead of digging it from the iio_device's private data.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Now an unrelated change, so I'll pick this up to avoid confusion in
any future versions.

Applied to the togreg branch of iio.git

Thanks,

Jonathan

> 
> ---
> Revision history:
> v4 => No changes
> 
> This commit is compile-tested only! All further testing is appreciated.
> ---
>  drivers/iio/adc/ti-ads7924.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> index 66b54c0d75aa..b1f745f75dbe 100644
> --- a/drivers/iio/adc/ti-ads7924.c
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -251,11 +251,8 @@ static const struct iio_info ads7924_info = {
>  	.read_raw = ads7924_read_raw,
>  };
>  
> -static int ads7924_get_channels_config(struct i2c_client *client,
> -				       struct iio_dev *indio_dev)
> +static int ads7924_get_channels_config(struct device *dev)
>  {
> -	struct ads7924_data *priv = iio_priv(indio_dev);
> -	struct device *dev = priv->dev;
>  	struct fwnode_handle *node;
>  	int num_channels = 0;
>  
> @@ -380,7 +377,7 @@ static int ads7924_probe(struct i2c_client *client)
>  	indio_dev->num_channels = ARRAY_SIZE(ads7924_channels);
>  	indio_dev->info = &ads7924_info;
>  
> -	ret = ads7924_get_channels_config(client, indio_dev);
> +	ret = ads7924_get_channels_config(dev);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret,
>  				     "failed to get channels configuration\n");


