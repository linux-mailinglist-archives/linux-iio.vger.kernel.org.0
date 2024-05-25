Return-Path: <linux-iio+bounces-5304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317768CF073
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6972C1C20BDF
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08F84FAC;
	Sat, 25 May 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSK0qtjT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A275179B7;
	Sat, 25 May 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716658247; cv=none; b=j8x+4MEI4VEl782+zeI2APEIpTBRPJ8em8NcnsehOkDEvIAydk+Wu5js0EjQYbBc8lKyuqTvoq1z96qwRcU5orcj/LulI9xQ938MLVJC1InW+TWB6ovOFnFXkdV+HJOxLTtqYIcuyOwok5ljwZ+EmQGn8szhT5Nh2fBr+vTsh0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716658247; c=relaxed/simple;
	bh=Zp52KC1rxjlnpiRNoN7pXv0vNQ8Xzy52LHj6t0MDM8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfzI4+Hd1L8v1zf+DTdaiH0It3Dvdc+1ZwIO0t0Qge8CJR/NqoRuOiPiuJ15XOztHaq3suqlxidMtW+UsvRH5qsv0dtqC1+nkx0Sr40y8sjjsSFy1K7CAD82d9/U+kGurmbBSYUS23ra8fxM3yEZFHFCNoK6qTOImuIXMPO7H6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSK0qtjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990B5C2BD11;
	Sat, 25 May 2024 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716658246;
	bh=Zp52KC1rxjlnpiRNoN7pXv0vNQ8Xzy52LHj6t0MDM8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSK0qtjTLU9QgAbpOfvFzFgpwlS7dPkzgVdALJvracLJK1sZSoIAV8wzBGNMmRH85
	 CdQBiIPUz1KSiPZP/iYWD2lWNBpVBh1C93k8oKWHxinxShfrpyWvFdOGml/lc7BqGD
	 RfYdn0862zZWmDKn/GhLAFz4V/Oei4MMjSzckYdtCSPz86gJjzVtedKjT22D9S3YzF
	 ROhY4fI9o4sTP5lWKPKNwQF66V51i6zpNEC/TI2eApVA4wQ7EFYV2mOrnLoRDc4h9W
	 4k9gzmVDlEzM2+RVYFW6r557kxdOclcm10mDRmI/PVQ0SSZrCh+05sEsia1GzYQpfM
	 fGGrZGzCcA2EA==
Date: Sat, 25 May 2024 18:30:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7944: remove unused parameter
Message-ID: <20240525183035.0faf0de7@jic23-huawei>
In-Reply-To: <20240524-iio-ad7944-remove-unused-parameter-v1-1-fd824d7122a0@baylibre.com>
References: <20240524-iio-ad7944-remove-unused-parameter-v1-1-fd824d7122a0@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 15:38:04 -0500
David Lechner <dlechner@baylibre.com> wrote:

> In the ad7944 driver, the ad7944_convert_and_acquire() had an unused
> `chan` parameter. This patch removes the parameter.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied
> ---
>  drivers/iio/adc/ad7944.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index 4602ab5ed2a6..e2cb64cef476 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -259,7 +259,6 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
>  /**
>   * ad7944_convert_and_acquire - Perform a single conversion and acquisition
>   * @adc: The ADC device structure
> - * @chan: The channel specification
>   * Return: 0 on success, a negative error code on failure
>   *
>   * Perform a conversion and acquisition of a single sample using the
> @@ -268,8 +267,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
>   * Upon successful return adc->sample.raw will contain the conversion result
>   * (or adc->chain_mode_buf if the device is using chain mode).
>   */
> -static int ad7944_convert_and_acquire(struct ad7944_adc *adc,
> -				      const struct iio_chan_spec *chan)
> +static int ad7944_convert_and_acquire(struct ad7944_adc *adc)
>  {
>  	int ret;
>  
> @@ -291,7 +289,7 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
>  {
>  	int ret;
>  
> -	ret = ad7944_convert_and_acquire(adc, chan);
> +	ret = ad7944_convert_and_acquire(adc);
>  	if (ret)
>  		return ret;
>  
> @@ -361,7 +359,7 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
>  	struct ad7944_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = ad7944_convert_and_acquire(adc, &indio_dev->channels[0]);
> +	ret = ad7944_convert_and_acquire(adc);
>  	if (ret)
>  		goto out;
>  
> 
> ---
> base-commit: 6c46802cc0c4ff878f07139f7b7b8774fd43ce3d
> change-id: 20240524-iio-ad7944-remove-unused-parameter-d814bb7e1a28


