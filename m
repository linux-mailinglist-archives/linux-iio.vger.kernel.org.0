Return-Path: <linux-iio+bounces-17423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A25A764D2
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55BE161E6B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B61E2312;
	Mon, 31 Mar 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdzXXBSe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475871E1E13;
	Mon, 31 Mar 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419703; cv=none; b=OdNStPAWKmXWMzutdNseG/VAYM9kNk1uJYXeQtMZuX60xXH5FNN5GzvgkGD91un3eYPR1qL8CgwUIABjPYbHhUlPxkbKHnj9aN4FTxfXsl3ToMImcg3M9hQ0XTIB+gwXXIU5IU5MCBptQk7+b78DxELoBgDGkFjxetnnZGxJqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419703; c=relaxed/simple;
	bh=nLlydRF7GjIqMiKieOsgcX9xT9XN72KxiEV9LmXP8N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syPQUBuC8Rm7lGYsmr4dzYOpdSw8QPNVMtddsxWSaji0/bsLJj7xjnNd5tIz5SuYvq40MP7GYdUewOElP6LXIqmG38H9N1QxNQX5odnwC4XxubLvqKBAO/Wi4Oz8MsRiMskFJi7+tc9miEqmV4Ap2tgpbQN4rNJkGDrMpum4/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdzXXBSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2554AC4CEE3;
	Mon, 31 Mar 2025 11:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743419702;
	bh=nLlydRF7GjIqMiKieOsgcX9xT9XN72KxiEV9LmXP8N4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rdzXXBSeHugK1gkHaEL3OjX2zNy9EStsQbhroiPL4OTd/3N58y2VCflDcku+iOdw/
	 OLijwlfMjBt6GJ7VOMshJFAfzGDsSTRWoURff4E3LgkyUw/uoJwKwlAySMaWLKvwJL
	 kOut+N2bodGxnDcBQzTHRx+WkERZcrypJKijk7wQ3rI7qY9+HSD4vlJyJwmHOPi0XM
	 dgI/fWwNnfBVH53xKO/KkRSPLWJcwztSmlQ9p2KME7J2bGBPaRaEx8J/k82q2ttT9I
	 CgcfnTEI8Y0ZooJMWRS4H5m/CaZPBLlI2Y7bt7WpN5wl9O1ucXVsLZFIOkETv8J3Wk
	 RrLRdG44En05g==
Date: Mon, 31 Mar 2025 12:14:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio: adc: ti-adc128s052: Simplify using
 guard(mutex)
Message-ID: <20250331121453.690642f7@jic23-huawei>
In-Reply-To: <93a9d7ab74cd045949a2e2b6301f29c7d83d72ea.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
	<93a9d7ab74cd045949a2e2b6301f29c7d83d72ea.1742474322.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:03:44 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Error path in ADC reading function can be slighly simplified using the
> guard(mutex). Do just that.
> 
> Also, document the mutex purpose while at it.
Ah. I should have read on before earlier comment!

That's what I get for an efficient linear pass of patches :)
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 90b23c68daea..c68ee4e17a03 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -9,6 +9,7 @@
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/iio/iio.h>
>  #include <linux/mod_devicetable.h>
> @@ -26,6 +27,7 @@ struct adc128 {
>  	struct spi_device *spi;
>  
>  	struct regulator *reg;
> +	/* Serialize the SPI 'write-channel + read data' accesses */
>  	struct mutex lock;
>  
>  	__be16 buffer __aligned(IIO_DMA_MINALIGN);
> @@ -39,18 +41,13 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  	msg[0] = channel << 3;
>  	msg[1] = 0;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
As per earlier comment, I think you need to protect msg as well.

>  
>  	ret = spi_write(adc->spi, msg, 2);
> -	if (ret < 0) {
> -		mutex_unlock(&adc->lock);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	ret = spi_read(adc->spi, &adc->buffer, 2);
> -
> -	mutex_unlock(&adc->lock);
> -
>  	if (ret < 0)
>  		return ret;
>  


