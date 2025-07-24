Return-Path: <linux-iio+bounces-21970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90323B10AC1
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0031C26B76
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997E2D4B5C;
	Thu, 24 Jul 2025 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTvtEbZ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C202836BF;
	Thu, 24 Jul 2025 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361697; cv=none; b=N0yQRq7TLqPSkE0UQz7FhhSPTEiSwZCcUprtEUczi4RTE8qNxhFgyW+SdqDrrYcYMhnk673h4NGGcTNxcqDFldi2FEGneZ4vIfMsS9GSnhGdYdA8SZXBTPNn2VZGI2IdG9qxClYQBjAGWhdrNMlhBlSkITQOkrM61RmGHdy+Wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361697; c=relaxed/simple;
	bh=sp5ZCZ1GPq3m4+63AHbRNpdon7xPTVdteDhqlssT8mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rd2cvo/6F+c2t6FmFULNNf+qTDbj94tYEAp8+2I9vkz3QHHVMxmBjL/FTh4ilc8aS1CKKu9qxJmqVdDBUuybHmPw4uKMDk0gFvV0Ym8Z7CwR0sFSCRYeji7MdThdZszdA/qKDEef+4SQej7jd8TkK6LqZuZom/fI+Z2oTHywAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTvtEbZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5534EC4CEED;
	Thu, 24 Jul 2025 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361696;
	bh=sp5ZCZ1GPq3m4+63AHbRNpdon7xPTVdteDhqlssT8mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HTvtEbZ4fVPI63NBgAzGc6Z/SeUE2W6+iCih6OS5w0LbYA9Swv+Fx6hsdCW/0ltCJ
	 EHTX96h00Sm0t0szqBO2OH4kcxWWttCkjn6vxoPkB2m0PkyHXc8gZaPt7YN5EG9NqK
	 zvWVmlSpmij4ilZokkjNeny7eFk1sUhVpL69OSrQfq49dI5tGLDwRWbGdOeeCvG7Cq
	 pn8yY+BUdswSUpk12PIrudCj1BVpq5iK/6NH1J3IPeT4FNgZm8+gMRSPcUPul1KjP9
	 Oe2r3YptT/lB/aBCOeNI5m9Wj0HjQxMkQsXmRUShhxyrBKAjSGCLcU1HFwQZrP03yX
	 CPwe1Iptj6I1g==
Date: Thu, 24 Jul 2025 13:54:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: ti-adc12138: Simplify with
 devm_clk_get_enabled()
Message-ID: <20250724135450.36f9a65f@jic23-huawei>
In-Reply-To: <20250713-iio-clk-get-enabled-v1-1-70abc1f9ce6c@linaro.org>
References: <20250713-iio-clk-get-enabled-v1-0-70abc1f9ce6c@linaro.org>
	<20250713-iio-clk-get-enabled-v1-1-70abc1f9ce6c@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 17:59:55 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Driver is getting clock and almost immediately enabling it, with the
> devm_request_irq() as the only relevant code executed between, thus the
> probe path and cleanups can be simplified with devm_clk_get_enabled().
> 
> Move devm_request_irq() earlier, so the interrupt handler will be
> registered before clock is enabled.  This might be important in case
> regulator supplies are enabled by other device driver and this device
> raises interrupt immediately after clock sarts ticking.
> 
> The change does not reverse cleanup paths - first regulator will be
> disabled, then clock and finally interrupt handler freed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Seems no one cares (or is paying attention) about the ordering change
and we both think it is fine so applied to the testing branch of iio.git
for 6.18. I'll rebase on rc1 once available

Thanks,

Jonathan

> 
> ---
> 
> Not tested on hardware.
> ---
>  drivers/iio/adc/ti-adc12138.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
> index 9dc465a10ffc8d9f596e34215af685999235d690..e5ec4b073daae33d0e51cf21a3520f0ab2184828 100644
> --- a/drivers/iio/adc/ti-adc12138.c
> +++ b/drivers/iio/adc/ti-adc12138.c
> @@ -38,15 +38,13 @@ enum {
>  struct adc12138 {
>  	struct spi_device *spi;
>  	unsigned int id;
> -	/* conversion clock */
> -	struct clk *cclk;
>  	/* positive analog voltage reference */
>  	struct regulator *vref_p;
>  	/* negative analog voltage reference */
>  	struct regulator *vref_n;
>  	struct mutex lock;
>  	struct completion complete;
> -	/* The number of cclk periods for the S/H's acquisition time */
> +	/* The number of conversion clock periods for the S/H's acquisition time */
>  	unsigned int acquisition_time;
>  	/*
>  	 * Maximum size needed: 16x 2 bytes ADC data + 8 bytes timestamp.
> @@ -400,6 +398,7 @@ static int adc12138_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct adc12138 *adc;
> +	struct clk *cclk;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> @@ -435,9 +434,14 @@ static int adc12138_probe(struct spi_device *spi)
>  	if (ret)
>  		adc->acquisition_time = 10;
>  
> -	adc->cclk = devm_clk_get(&spi->dev, NULL);
> -	if (IS_ERR(adc->cclk))
> -		return PTR_ERR(adc->cclk);
> +	ret = devm_request_irq(&spi->dev, spi->irq, adc12138_eoc_handler,
> +			       IRQF_TRIGGER_RISING, indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	cclk = devm_clk_get_enabled(&spi->dev, NULL);
> +	if (IS_ERR(cclk))
> +		return PTR_ERR(cclk);
>  
>  	adc->vref_p = devm_regulator_get(&spi->dev, "vref-p");
>  	if (IS_ERR(adc->vref_p))
> @@ -454,18 +458,9 @@ static int adc12138_probe(struct spi_device *spi)
>  			return ret;
>  	}
>  
> -	ret = devm_request_irq(&spi->dev, spi->irq, adc12138_eoc_handler,
> -			       IRQF_TRIGGER_RISING, indio_dev->name, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(adc->cclk);
> -	if (ret)
> -		return ret;
> -
>  	ret = regulator_enable(adc->vref_p);
>  	if (ret)
> -		goto err_clk_disable;
> +		return ret;
>  
>  	if (!IS_ERR(adc->vref_n)) {
>  		ret = regulator_enable(adc->vref_n);
> @@ -496,8 +491,6 @@ static int adc12138_probe(struct spi_device *spi)
>  		regulator_disable(adc->vref_n);
>  err_vref_p_disable:
>  	regulator_disable(adc->vref_p);
> -err_clk_disable:
> -	clk_disable_unprepare(adc->cclk);
>  
>  	return ret;
>  }
> @@ -512,7 +505,6 @@ static void adc12138_remove(struct spi_device *spi)
>  	if (!IS_ERR(adc->vref_n))
>  		regulator_disable(adc->vref_n);
>  	regulator_disable(adc->vref_p);
> -	clk_disable_unprepare(adc->cclk);
>  }
>  
>  static const struct of_device_id adc12138_dt_ids[] = {
> 


