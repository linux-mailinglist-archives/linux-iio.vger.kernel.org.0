Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2298B22DEF8
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGZM3S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGZM3S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:29:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A218206D8;
        Sun, 26 Jul 2020 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595766558;
        bh=NWWwfaoZ6AUNEaTZmM6euvtlqvgNc4CIO0W2ZVyvmrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kzzso9V4H+uPm2auZOqNNjYH1ZtRUbx5zXi6ikdPaC3PCdYlJTeodawkq42802Uc3
         6c0wML4e/cf513IYFNl2oMMlWmcWuCNuSvGKhl5Fhc3lEOI4I7MePxm0v/os3lQeTT
         F8aR8VtxgA9EEYPktPXZdB5a+7B1xjQS3bJRZVhI=
Date:   Sun, 26 Jul 2020 13:29:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: frequency: ad9523: convert rest of driver to
 device managed functions
Message-ID: <20200726132914.240c7788@archlinux>
In-Reply-To: <20200722072201.64127-1-alexandru.ardelean@analog.com>
References: <20200721112409.220536-1-alexandru.ardelean@analog.com>
        <20200722072201.64127-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 10:22:01 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The driver pretty much uses device managed functions. The only left-over is
> the iio_device_register() function, which also requires an action-or-reset
> hook to disable the regulator on the remove and error path.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * removed 'probed' message at the end of probe; mostly log spam
> 
>  drivers/iio/frequency/ad9523.c | 60 ++++++++++++----------------------
>  1 file changed, 20 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 334e1d779d6d..bdb0bc3b12dd 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -969,6 +969,13 @@ static int ad9523_setup(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static void ad9523_reg_disable(void *data)
> +{
> +	struct regulator *reg = data;
> +
> +	regulator_disable(reg);
> +}
> +
>  static int ad9523_probe(struct spi_device *spi)
>  {
>  	struct ad9523_platform_data *pdata = spi->dev.platform_data;
> @@ -994,21 +1001,22 @@ static int ad9523_probe(struct spi_device *spi)
>  		ret = regulator_enable(st->reg);
>  		if (ret)
>  			return ret;
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad9523_reg_disable,
> +					       st->reg);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
>  		GPIOD_OUT_HIGH);
> -	if (IS_ERR(st->pwrdown_gpio)) {
> -		ret = PTR_ERR(st->pwrdown_gpio);
> -		goto error_disable_reg;
> -	}
> +	if (IS_ERR(st->pwrdown_gpio))
> +		return PTR_ERR(st->pwrdown_gpio);
>  
>  	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
>  		GPIOD_OUT_LOW);
> -	if (IS_ERR(st->reset_gpio)) {
> -		ret = PTR_ERR(st->reset_gpio);
> -		goto error_disable_reg;
> -	}
> +	if (IS_ERR(st->reset_gpio))
> +		return PTR_ERR(st->reset_gpio);
>  
>  	if (st->reset_gpio) {
>  		udelay(1);
> @@ -1017,10 +1025,8 @@ static int ad9523_probe(struct spi_device *spi)
>  
>  	st->sync_gpio = devm_gpiod_get_optional(&spi->dev, "sync",
>  		GPIOD_OUT_HIGH);
> -	if (IS_ERR(st->sync_gpio)) {
> -		ret = PTR_ERR(st->sync_gpio);
> -		goto error_disable_reg;
> -	}
> +	if (IS_ERR(st->sync_gpio))
> +		return PTR_ERR(st->sync_gpio);
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
> @@ -1035,34 +1041,9 @@ static int ad9523_probe(struct spi_device *spi)
>  
>  	ret = ad9523_setup(indio_dev);
>  	if (ret < 0)
> -		goto error_disable_reg;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_disable_reg;
> -
> -	dev_info(&spi->dev, "probed %s\n", indio_dev->name);
> -
> -	return 0;
> -
> -error_disable_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> -
> -	return ret;
> -}
> -
> -static int ad9523_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ad9523_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad9523_id[] = {
> @@ -1076,7 +1057,6 @@ static struct spi_driver ad9523_driver = {
>  		.name	= "ad9523",
>  	},
>  	.probe		= ad9523_probe,
> -	.remove		= ad9523_remove,
>  	.id_table	= ad9523_id,
>  };
>  module_spi_driver(ad9523_driver);

