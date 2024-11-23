Return-Path: <linux-iio+bounces-12539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF79D69C1
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25415B21E70
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A62E64A;
	Sat, 23 Nov 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaPG9gd2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCD29D05;
	Sat, 23 Nov 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377050; cv=none; b=Blr9aw+HAPKBgUTOPFYGVC43zBl4itIpngHA3o6nizpoWog+xAzB6VRSJjVYc+Qjb+7mhipQn/AVvPd1OMOFV2fulqUcqcZ5ZkYws4u+yazgWOj5vE0PEdJeD1C/xYlw3B4h3B0A4n0mzStDlKLL0AXjzpqjQFpL6MCbKeKk8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377050; c=relaxed/simple;
	bh=Z0qzCu+t9u3i1RTjkQ2qiydNaXY5HYvUO3tLB339vK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtUdnF8Zyo8nK6061ospi9fiqA3O5DFgAHrW1LpkFBJ/4HgnbNaroDzHo+184GTnorcNp8N4QNdyhVU+5EAjSMgnvgZxmJpJeePsCkf6yMJOAiCG1/Ap3Oneq1jasb3vajRatMLrUyzVC3mxi3qHIq1OB3zf6rI8DEgeJjBMcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaPG9gd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37238C4CECD;
	Sat, 23 Nov 2024 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377050;
	bh=Z0qzCu+t9u3i1RTjkQ2qiydNaXY5HYvUO3tLB339vK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jaPG9gd29XcNnwocfNB2GsTPtgbepy24H2YSYbbTkFQlHESaKSD6XMt/CTrlb39rQ
	 fxiAol1/Y84wajamNXgtFEn4chUsIXWL0wz0usxSmLDclfQ3OsDZFp8F9x7Y8S4G6d
	 /gOprKV0Qf31t15DJS5QsjgT0MVZUmCbaXhAQiiCU4l2x1LjMTOp2MZWGwmCk3j1mX
	 CHJbQDlqzR7S6xZz9ekaRwHL8zruypyT9V9trvJXFym/XWYjYoRKDPa20hBPQ2HqF7
	 ISmjQnqgJrMNsTqugGcZTIj8BDs1UQBau3lVjqbRDMPFASF09t26mr2yEK3GkkldmL
	 umBmbFZpx4rWg==
Date: Sat, 23 Nov 2024 15:50:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] iio: dac: ad7293: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20241123155043.45a4313b@jic23-huawei>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-5-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
	<20241120-iio-regulator-cleanup-round-6-v1-5-d5a5360f7ec3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 15:33:28 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Simplify the code by using devm_regulator_get_enable_read_voltage().
> 
> A small change in behavior here due to moving the enable to the same
> place as the get: supplies now are enabled before the reset GPIO is
> toggled (which is arguably the correct order).
Agreed ordering is weird before this change so that should be fine.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

This raises some questions for me (about the original code)
My gut feeling is drop the reading of the regulator voltage but
maybe I'm missing something.

> ---
>  drivers/iio/dac/ad7293.c | 66 ++++++++----------------------------------------
>  1 file changed, 11 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
> index 1d4032670482..58f7926ec3f3 100644
> --- a/drivers/iio/dac/ad7293.c
> +++ b/drivers/iio/dac/ad7293.c
> @@ -141,8 +141,6 @@ struct ad7293_state {
>  	/* Protect against concurrent accesses to the device, page selection and data content */
>  	struct mutex lock;
>  	struct gpio_desc *gpio_reset;
> -	struct regulator *reg_avdd;
> -	struct regulator *reg_vdrive;
>  	u8 page_select;
>  	u8 data[3] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -777,6 +775,7 @@ static int ad7293_reset(struct ad7293_state *st)
>  static int ad7293_properties_parse(struct ad7293_state *st)
>  {
>  	struct spi_device *spi = st->spi;
> +	int ret;
>  
>  	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
>  						 GPIOD_OUT_HIGH);
> @@ -784,24 +783,23 @@ static int ad7293_properties_parse(struct ad7293_state *st)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_reset),
>  				     "failed to get the reset GPIO\n");
>  
> -	st->reg_avdd = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(st->reg_avdd))
> -		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_avdd),
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
>  				     "failed to get the AVDD voltage\n");
> +	if (ret > 5500000 || ret < 4500000)
> +		return -EINVAL;

Why is this a driver problem?


>  
> -	st->reg_vdrive = devm_regulator_get(&spi->dev, "vdrive");
> -	if (IS_ERR(st->reg_vdrive))
> -		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_vdrive),
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vdrive");
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
>  				     "failed to get the VDRIVE voltage\n");
> +	if (ret > 5500000 || ret < 1700000)
> +		return -EINVAL;
Likewise.

Regulators might be fine and we can't read the voltages. If they are out
of spec, that's a design or board configuration problem.

To keep these in place rather than just dropping them, I'd like more
info on why!  May well be in the history but I'm busy / lazy  (take
your pick) so won't look today.



>  	return 0;
>  }
>  
> -static void ad7293_reg_disable(void *data)
> -{
> -	regulator_disable(data);
> -}
> -
>  static int ad7293_init(struct ad7293_state *st)
>  {
>  	int ret;
> @@ -816,48 +814,6 @@ static int ad7293_init(struct ad7293_state *st)
>  	if (ret)
>  		return ret;
>  
> -	ret = regulator_enable(st->reg_avdd);
> -	if (ret) {
> -		dev_err(&spi->dev,
> -			"Failed to enable specified AVDD Voltage!\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
> -				       st->reg_avdd);
> -	if (ret)
> -		return ret;
> -
> -	ret = regulator_enable(st->reg_vdrive);
> -	if (ret) {
> -		dev_err(&spi->dev,
> -			"Failed to enable specified VDRIVE Voltage!\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
> -				       st->reg_vdrive);
> -	if (ret)
> -		return ret;
> -
> -	ret = regulator_get_voltage(st->reg_avdd);
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "Failed to read avdd regulator: %d\n", ret);
> -		return ret;
> -	}
> -
> -	if (ret > 5500000 || ret < 4500000)
> -		return -EINVAL;
> -
> -	ret = regulator_get_voltage(st->reg_vdrive);
> -	if (ret < 0) {
> -		dev_err(&spi->dev,
> -			"Failed to read vdrive regulator: %d\n", ret);
> -		return ret;
> -	}
> -	if (ret > 5500000 || ret < 1700000)
> -		return -EINVAL;
> -
>  	/* Check Chip ID */
>  	ret = __ad7293_spi_read(st, AD7293_REG_DEVICE_ID, &chip_id);
>  	if (ret)
> 


