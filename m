Return-Path: <linux-iio+bounces-14824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00433A249ED
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7B11885573
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101B1C3BE1;
	Sat,  1 Feb 2025 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5dGmrwr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83A16F265;
	Sat,  1 Feb 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424150; cv=none; b=gQq/4WQMVly/Arr1g1EvnUw2B3arFcskAei3EryQQU9z1CMYVArMn1OgTn46jQIwWJwmA8mSiTST094O8yj2kdFAQwFW3tEgHCT5Dzl/RgPXxtILJeq2zxjpKs1le4PxE0RZqrktGvm58HZ/v2e/rhxVoGF7A02u6on+dyGF7qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424150; c=relaxed/simple;
	bh=gdaQDzjILI94jdST7ElLYSDSe1zmq6F1j9pYdNHiRh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GB2pTMmvJLzUlG3kYT/QU/Y4gJNsY8pcKMljW7erlBVCXi06oF2lRv28vkV86p1MBzlX5ItqRPgyrYLX9Mvj3SUvhI67A+Snp1Ni5vt1CmLAH+a9Y2RQh9e0Rk6oOyRDuCtgbruLiDWbFZbjb2adFmG9MkfHs7442tPq49gupEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5dGmrwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F6C4CED3;
	Sat,  1 Feb 2025 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738424150;
	bh=gdaQDzjILI94jdST7ElLYSDSe1zmq6F1j9pYdNHiRh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H5dGmrwrVklRSs8FPZElk5LGaETVowTVK+XD01Yq8Ka8rtZTynayTqkLmoyTQUhil
	 I8Pw1YF42M6BLQoRDqa9yvXjQRlDmtEoo+EKYcLb3o00rtn2Jdej6Nd7UlqDYdtq/n
	 4Xt8Cx2D7SFy3DYqeKMq4sEOm2DSaZ9WmT8pveMOsEPJP56cQdX8UDMeGjReECOZGu
	 H3XW3nkmXIKrBDBBSHDziV+layb7BlMm9IrezoQ39dvDRw+z1+/Kw9N1XLroYTAKcW
	 7sU1VlpXilNGqYExsI7PKL1pbF26FWeza5BDEEehrLit4GafKm6O4MrPGccTXg73VP
	 hsdqzuqGxSOlw==
Date: Sat, 1 Feb 2025 15:35:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 10/16] iio: adc: ad7768-1: Move buffer allocation to
 a separate function
Message-ID: <20250201153539.5617b5b8@jic23-huawei>
In-Reply-To: <e39115cee88524f05c8a628b0d3836928c6cc190.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<e39115cee88524f05c8a628b0d3836928c6cc190.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 12:13:19 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change moves the buffer allocation in a separate function, making
> space for adding another type of iio buffer if needed.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Jonathan, this one needs your sign off to reflect that you handled
the patch as part of it's path to upstream.  I can't apply
anything that is missing such SoB.


> ---
> v2 Changes:
> * Interrupt and completion moved out from ad7768_triggered_buffer_alloc(). 
> ---
>  drivers/iio/adc/ad7768-1.c | 44 ++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 5e2093be9b92..8487b9a06609 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -599,6 +599,31 @@ static const struct regmap_config ad7768_regmap_config = {
>  	.max_register = AD7768_REG_MCLK_COUNTER,
>  };
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
> +	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					       &iio_pollfunc_store_time,
> +					       &ad7768_trigger_handler,
> +					       &ad7768_buffer_ops);
> +}
> +
>  static int ad7768_probe(struct spi_device *spi)
>  {
>  	struct ad7768_state *st;
> @@ -669,20 +694,6 @@ static int ad7768_probe(struct spi_device *spi)
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
>  	init_completion(&st->completion);
>  
>  	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
> @@ -696,10 +707,7 @@ static int ad7768_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad7768_trigger_handler,
> -					      &ad7768_buffer_ops);
> +	ret = ad7768_triggered_buffer_alloc(indio_dev);
>  	if (ret)
>  		return ret;
>  


