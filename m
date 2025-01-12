Return-Path: <linux-iio+bounces-14197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B39A0A937
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58ED53A1C32
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8191B393C;
	Sun, 12 Jan 2025 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljg/Aly0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7C3C1F;
	Sun, 12 Jan 2025 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685666; cv=none; b=U1ch36xiT61GeXuJXNxuxDxlce3zSy2CuIh7BHscGUHtNcCuoyUFh/t+2KWFs3IiW8tWjEFN0IIS82WbDKZjAdKH1+xc/4AyPw8ikrBsbLHKsCEG31H+BPykwGFIc2u5YDUF63fbyKwkV7uxrMLB9lwEPr5cOIbJachEB0AeKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685666; c=relaxed/simple;
	bh=DcfXM8Ftu6/ZBWMV/o3OjyDLE2DdUgS0OHIae1CIMd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbxjdAptcFfp7dSmiqt7xTQ1wvQDqHkTAH8c0Wdn1GtnrlWBCOi10V5PMaQu0JbfohPi/j0qBF6L6i4vVTBdJgtmvBsDaU4uX1zLsCbcgv7fg5vP0zae8/a+CN4JaN+rR6Hvji+kjNLMVBJkpbnB/Di00M6ttt6hXqm7h1wQdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljg/Aly0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E56C4CEDF;
	Sun, 12 Jan 2025 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736685665;
	bh=DcfXM8Ftu6/ZBWMV/o3OjyDLE2DdUgS0OHIae1CIMd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljg/Aly0U6VfALEIjxjh27clChDmaCskzomrnDOJfsxum2oj2ETxW4clWu5UEh4qX
	 I1Kw3EovDmTxpTmpNkTrCbr3AlEbpk92Mo5CBsDtLlI7OtYthmfSW0P+Nio4h0v7ZE
	 M9hhPdh1YzUl12P3AIkwTbgD7viVXCmxqZ8GLYTKT7RslD3PEPPv8BCteU4Wq8pdxG
	 UiJPlxiwCRraGlwm4uHEfPxIq9y1xGo4zOWhwg+mSU8S8uD67xElYxTK02WvRHoSpO
	 2lP7V9d0Y7N7rRaEECAkKlIQufNNXC8my5Iu3UmzMuiXXeq1An9wZUsNvstUASXYGL
	 8bBjfFRgDG1Fw==
Date: Sun, 12 Jan 2025 12:40:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 09/15] iio: adc: ad7768-1: Move buffer allocation to
 a separate function
Message-ID: <20250112124056.4c933181@jic23-huawei>
In-Reply-To: <319a685855eb4b942e05e456a37319d3f73f7cd4.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<319a685855eb4b942e05e456a37319d3f73f7cd4.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 12:26:05 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change moves the buffer allocation in a separate function, making
> space for adding another type of iio buffer if needed.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 64 ++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index cd1b08053105..eaa9a12737ac 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -163,6 +163,7 @@ struct ad7768_state {
>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
>  	struct gpio_desc *gpio_reset;
> +	int irq;
>  	const char *labels[ARRAY_SIZE(ad7768_channels)];
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -569,6 +570,40 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad7768_trigger_ops;
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret = devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	init_completion(&st->completion);
> +
> +	ret = devm_request_irq(indio_dev->dev.parent, st->irq,
> +			       &ad7768_interrupt,
> +			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			       indio_dev->name, indio_dev);
> +	if (ret)

As with the completion, the interrupt is not just for triggered buffer use
either, so probably doesn't belong in this function.  Again, not
a bug to do so, but hurts readability a little.

> +		return ret;
> +
> +	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					       &iio_pollfunc_store_time,
> +					       &ad7768_trigger_handler,
> +					       &ad7768_buffer_ops);
> +}
> +
>  static int ad7768_probe(struct spi_device *spi)
>  {
>  	struct ad7768_state *st;
> @@ -610,6 +645,7 @@ static int ad7768_probe(struct spi_device *spi)
>  		return PTR_ERR(st->mclk);
>  
>  	st->mclk_freq = clk_get_rate(st->mclk);
> +	st->irq = spi->irq;
>  
>  	mutex_init(&st->lock);
>  
> @@ -625,37 +661,11 @@ static int ad7768_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> -					  indio_dev->name,
> -					  iio_device_id(indio_dev));
> -	if (!st->trig)
> -		return -ENOMEM;
> -
> -	st->trig->ops = &ad7768_trigger_ops;
> -	iio_trigger_set_drvdata(st->trig, indio_dev);
> -	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> -	if (ret)
> -		return ret;
> -
> -	indio_dev->trig = iio_trigger_get(st->trig);
> -
> -	init_completion(&st->completion);
> -
>  	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_request_irq(&spi->dev, spi->irq,
> -			       &ad7768_interrupt,
> -			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -			       indio_dev->name, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad7768_trigger_handler,
> -					      &ad7768_buffer_ops);
> +	ret = ad7768_triggered_buffer_alloc(indio_dev);
>  	if (ret)
>  		return ret;
>  


