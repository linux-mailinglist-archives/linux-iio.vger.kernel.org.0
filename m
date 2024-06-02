Return-Path: <linux-iio+bounces-5620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C88D8D756E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5661F222C6
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266338DF2;
	Sun,  2 Jun 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HspO+oaX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60617C7C;
	Sun,  2 Jun 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717332647; cv=none; b=nSlS+8EpmsR9bbOOcZ0PXP6cVX55bfvbVzma4J7zyjAsYmXU4hvhqMycd4HwQbSM66DVdDCHz/dsgg9c3g+KtYypy/TfBPsFmpM6ImsbAMBYwn09R8JM23tsfHP2CsubtSXwkYdSl1IiAPcS8LY3Ldqsg6Hq6pz0bc8AjkeBMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717332647; c=relaxed/simple;
	bh=ZzrJSXC2KX0xVuIkGuX0b53uOU8xn9fAxt0LCjbRsfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kinKn7rNZ1Lz2pOri8kMYBg91WDbJh0qDOx3U/5zrow0E8hlO9uGgDZBnqEAq/EqtEUUvNFcxEcAWvVftuSZpDfQxuwSF7tZ34IOO7cFHtYjbxbFsharLO7fEBkSS6GG7g5qofzcMZwSLaRvtKYFeOL3rgzs4rxXX1O3hODV3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HspO+oaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4AEC2BBFC;
	Sun,  2 Jun 2024 12:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717332646;
	bh=ZzrJSXC2KX0xVuIkGuX0b53uOU8xn9fAxt0LCjbRsfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HspO+oaXCW/ii0XPseip0y6mCEOtkis+KCYTrlP98nKCYyybpxnfHLGHYVFIQo3Gk
	 Q+O6ojoFDTu9iMIs0CXyjwBhwhhcKP2zbUzj1xqZgIWqV4eoP/7uFTzbRtySJ/1RWS
	 rFJSgYVKsG88mCZw1Wi7CcgzsxvNBeSj5RES246EfdjyNZmzdHxos3Zym2fvTEpNIW
	 TOoa2+//hsAlqoTIunJ8UpneHg3OY05MU39UODY+T1GpVpdK4OzjmqN1dnyDoGv6JG
	 UYfzwO+Ky5QbaPV4q3lLhSJMUVfTNFKxQ2t2VwXKcO90Rydj1pWctc4tVgs++MrKCY
	 cNy2fONTM5hFA==
Date: Sun, 2 Jun 2024 13:50:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/17] iio: chemical: bme680: Remove duplicate
 register read
Message-ID: <20240602135036.27b0ee9a@jic23-huawei>
In-Reply-To: <20240527183805.311501-11-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-11-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 20:37:58 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The LSB of the gas register was read first to check if the following
> check was correct and then the MSB+LSB were read together. Simplify
> this by reading together the MSB+LSB immediately.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
A few trivial things. I wrote a nice comment on dma safe buffers then
noticed this does a custom regmap using spi_write_then_read() so despite
not looking like it from this code, DMA safe buffers are used.
Just thought I'd mention it for any other reviewers!

> ---
>  drivers/iio/chemical/bme680_core.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 96423861c79a..681f271f9b06 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -748,7 +748,7 @@ static int bme680_read_gas(struct bme680_data *data,
>  	int ret;
>  	__be16 tmp = 0;
>  	unsigned int check;
> -	u16 adc_gas_res;
> +	u16 adc_gas_res, gas_regs_val;
>  	u8 gas_range;
>  
>  	/* Set heater settings */
> @@ -771,11 +771,14 @@ static int bme680_read_gas(struct bme680_data *data,
>  		return -EBUSY;
>  	}
>  
> -	ret = regmap_read(data->regmap, BME680_REG_GAS_R_LSB, &check);
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
> +			       &tmp, sizeof(tmp)); 
>  	if (ret < 0) {
> -		dev_err(dev, "failed to read gas_r_lsb register\n");
> +		dev_err(dev, "failed to read gas resistance\n");
>  		return ret;
>  	}
> +	gas_regs_val = be16_to_cpu(tmp);
> +	adc_gas_res = gas_regs_val >> BME680_ADC_GAS_RES_SHIFT;
I'd rather see this as a FIELD_GET() but given this was what was originally
here I guess I can cope with keeping it a little longer!

>  
>  	/*
>  	 * occurs if either the gas heating duration was insuffient
> @@ -783,20 +786,12 @@ static int bme680_read_gas(struct bme680_data *data,
>  	 * heater temperature was too high for the heater sink to
>  	 * reach.
>  	 */
> -	if ((check & BME680_GAS_STAB_BIT) == 0) {
> +	if ((gas_regs_val & BME680_GAS_STAB_BIT) == 0) {
>  		dev_err(dev, "heater failed to reach the target temperature\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
> -			       &tmp, sizeof(tmp));
> -	if (ret < 0) {
> -		dev_err(dev, "failed to read gas resistance\n");
> -		return ret;
> -	}
> -
> -	gas_range = check & BME680_GAS_RANGE_MASK;
> -	adc_gas_res = be16_to_cpu(tmp) >> BME680_ADC_GAS_RES_SHIFT;
> +	gas_range = gas_regs_val & BME680_GAS_RANGE_MASK;

Whilst you are here, may this a FIELD_GET() so we don't have to go
check that it includes the LSB.

>  
>  	*val = bme680_compensate_gas(data, adc_gas_res, gas_range);
>  	return IIO_VAL_INT;


