Return-Path: <linux-iio+bounces-27276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C6CD4330
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E77530073DA
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB942FC007;
	Sun, 21 Dec 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uei3E3cl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829C224FA;
	Sun, 21 Dec 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766336479; cv=none; b=ulA9lttwMfnrOyzni2HgJEzGp2dcZssplNYJ3YljexmK4OniHaF8cZ1OoQTxntVrlHyWtllVTS4asSoiT9ETijJdM/G55aZoB7/LaF/vlIk7MK8MLVmZQNszz5CAvVsVHTZ2OgharwQCBQu13JLlwifBm5KAsBJ0FVKBUjANBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766336479; c=relaxed/simple;
	bh=G2mRXvigJay8RlsrPhb2Naa8W5cCx5gRTTHrrEzcwp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTWgeHCyJBA52ugdFKC1klWt7B1jjL0gPpRM4eic/CkRP1Qxa6rW665nyRxmguv5RilZZ5etcDcbbiC+3qiKjaemTb6R/AlBAxLGDSkYD99M+c7hIdrxvcM51BPzl8v9+RiZYGYvHquYmKzhRk2Hq1hDxgPpq7TxutvmhG7QCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uei3E3cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D62AC4CEFB;
	Sun, 21 Dec 2025 17:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766336478;
	bh=G2mRXvigJay8RlsrPhb2Naa8W5cCx5gRTTHrrEzcwp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uei3E3clg9KwX+4bC2gYYFeCcK3cSrQbjL/zov1Vy8GltvF3hvROhZwvcTlKixfpK
	 vsG9/14saU5VXs5D/LCZeuUn08e453PHer6Y93jAwZPvGsOLhrskegyEKbpSYvCEpv
	 iwJJvbGyRX3BEyLyfO7D5cLPoWLA4Pmekaq080hqcyNIj7DSuwB1RVe8dxXu09rJdh
	 TzDM1cS9o/gmb5Z8jrVnki3UihXJwFIxhy4JWDqcI6CYIJE7ewhxBn28jdcm5bz+Yt
	 lEnVaznkcjpi1DSs+gqyhSylFjFTzpg20fFBsyHW3a1t9ilyTLUN/ElB5IaAgHzWJx
	 dvodN1AgWgo0A==
Date: Sun, 21 Dec 2025 17:01:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: exynos_adc: fix OF populate on driver rebind
Message-ID: <20251221170110.35ba6e8e@jic23-huawei>
In-Reply-To: <20251219110545.23813-1-johan@kernel.org>
References: <20251219110545.23813-1-johan@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 12:05:45 +0100
Johan Hovold <johan@kernel.org> wrote:

> Since commit c6e126de43e7 ("of: Keep track of populated platform
> devices") child devices will not be created by of_platform_populate()
> if the devices had previously been deregistered individually so that the
> OF_POPULATED flag is still set in the corresponding OF nodes.
> 
> Switch to using of_platform_depopulate() instead of open coding so that
> the child devices are created if the driver is rebound.
> 
> Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
> Cc: stable@vger.kernel.org	# 3.16
> Signed-off-by: Johan Hovold <johan@kernel.org>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/exynos_adc.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 1484adff00df..f2400897818c 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -540,15 +540,6 @@ static const struct iio_chan_spec exynos_adc_iio_channels[] = {
>  	ADC_CHANNEL(9, "adc9"),
>  };
>  
> -static int exynos_adc_remove_devices(struct device *dev, void *c)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -
> -	platform_device_unregister(pdev);
> -
> -	return 0;
> -}
> -
>  static int exynos_adc_probe(struct platform_device *pdev)
>  {
>  	struct exynos_adc *info = NULL;
> @@ -660,8 +651,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_of_populate:
> -	device_for_each_child(&indio_dev->dev, NULL,
> -				exynos_adc_remove_devices);
> +	of_platform_depopulate(&indio_dev->dev);
>  	iio_device_unregister(indio_dev);
>  err_irq:
>  	free_irq(info->irq, info);
> @@ -681,8 +671,7 @@ static void exynos_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct exynos_adc *info = iio_priv(indio_dev);
>  
> -	device_for_each_child(&indio_dev->dev, NULL,
> -				exynos_adc_remove_devices);
> +	of_platform_depopulate(&indio_dev->dev);
>  	iio_device_unregister(indio_dev);
>  	free_irq(info->irq, info);
>  	if (info->data->exit_hw)


