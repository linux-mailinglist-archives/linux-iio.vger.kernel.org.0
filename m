Return-Path: <linux-iio+bounces-17362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B657BA75B3F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DA3188C301
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577CE1DC745;
	Sun, 30 Mar 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okHXyUDp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1289935973;
	Sun, 30 Mar 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354272; cv=none; b=q3/bmXVnOJpUrEscV1VCUnLbok1nu8mPfeOokBiW0RZGM0EOmsnTZKRTW0oK45e4uzfvxB28Ojo6KH1cv3xhIgO13xyIP6UaxgGuDRS5psF9YkxcO+QHivBndCnuCsPZH0h2b8Yj7fdR245Jb8tg8GatMNeUxs7Ee8M+8tgdNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354272; c=relaxed/simple;
	bh=43r6bjUcx0YTEMqsvYoJzkSo/VOX3GnZ0DuinvEwGuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDtWRRK1AZGXd3UbSMAZl9IwUf+RlTl/N5+SXMxAuZEhhw4YijTN+e3E8ejhmN9Ymopv9mU2wRLqETqq8NNdJv/qtiE9Adw79g31fDA3AWM7P8SMs5cOXwTf7fZryF0TE6BsCs/imNfLxUxZ5mlBihmJoX0Ol8zvYlKswcOli3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okHXyUDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAC0C4CEDD;
	Sun, 30 Mar 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743354271;
	bh=43r6bjUcx0YTEMqsvYoJzkSo/VOX3GnZ0DuinvEwGuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=okHXyUDpmKsRWgFeB3wV5Bc+7lpg19jdh3jDfuviISvYSDfbh3c0xza/5dht57nPd
	 LNPILV24e+ZTsF+mduCuu8NMzuyN3TOvMEDEX7PLBA9OZTqC3CudIY8jZuUCYm5LBP
	 1MoJfnSe51JAJ4iC4DCawQpMoROzvGXIOJQ0OvrOq0gNCL9AQ9X5Tcdsuw9t6TfAOU
	 a0f627OJN0qFHQBZ2gkZQYozL61p1EYaUUmGi5NvCuBf7zt0JwGm7vwensW4GaBZDC
	 IhzWGq6+cXo4Cw3WrbX3I/FRUmFoURB9gO5vpOXPhnC8cMya6vX9IhDrPHW3SEuIwp
	 XoBSOzEKcXIjg==
Date: Sun, 30 Mar 2025 18:04:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7380: disable offload before using SPI bus
Message-ID: <20250330180424.0949ebb6@jic23-huawei>
In-Reply-To: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>
References: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 11:21:52 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Move disabling of the SPI offload before attempting to use the SPI bus
> to write a register in ad7380_offload_buffer_predisable().
> 
> This caused a crash in the spi_engine_irq() interrupt handler due to
> being in an invalid state.
> 
> Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hmm.  I've cheated a bit and created a temporary branch called
fixes-togreg-testing that's based on char-misc-next

That will all unwind once Linus (hopefully) takes Greg's pull request
and I'll rebase on that or rc1.

Anyhow, applied this patch to that magic branch.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7380.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..a2b41980c942e4cd1575bfe4f3846e297ad5d01d 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -1211,6 +1211,9 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
>  	struct ad7380_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +	spi_unoptimize_message(&st->offload_msg);
> +
>  	if (st->seq) {
>  		ret = regmap_update_bits(st->regmap,
>  					 AD7380_REG_ADDR_CONFIG1,
> @@ -1222,10 +1225,6 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
>  		st->seq = false;
>  	}
>  
> -	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> -
> -	spi_unoptimize_message(&st->offload_msg);
> -
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
> change-id: 20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-a801dcfb9c00
> 
> Best regards,


