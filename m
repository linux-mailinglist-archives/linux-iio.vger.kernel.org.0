Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4303D2B2E82
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNQp0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:45:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKNQp0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:45:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200FD20709;
        Sat, 14 Nov 2020 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605372325;
        bh=lqmUdGXvXeFpV1VchJqGcV78YmFZYTBbB0Vd5Oq4PhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=smiogYkvmgXcLweGt9e6gO4uAkR4UsBxjNbzwoIKSNGjnBV/qrRB8TeXQOVTcdjkP
         gxIMZEFdbCZbIKJvOQQjYpEZLBlvo7dd9TeeQUwMdnffqgQqvN7cDSBu3Wk1cm9JGg
         6uprmVUZTsEc+KKJ39pcQUpkuMwEz2r9nWibQ6a8=
Date:   Sat, 14 Nov 2020 16:45:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7887: convert probe to device-managed
 functions
Message-ID: <20201114164517.31796bef@archlinux>
In-Reply-To: <20201113091648.148589-1-alexandru.ardelean@analog.com>
References: <20201113091648.148589-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 11:16:48 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This is conversion of the driver to use device-managed functions.
> The IIO registration and triggered buffer setup both have device-managed
> versions.
> The regulator disable needs to be handled via an action_or_reset handler.
> 
> With these changes, the remove hook is removed, and the error path is
> cleaned up in probe.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7887.c | 43 ++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 99a480ad3985..4f6f0e0e03ee 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -232,6 +232,13 @@ static const struct iio_info ad7887_info = {
>  	.read_raw = &ad7887_read_raw,
>  };
>  
> +static void ad7887_reg_disable(void *data)
> +{
> +	struct regulator *reg = data;
> +
> +	regulator_disable(reg);
> +}
> +
>  static int ad7887_probe(struct spi_device *spi)
>  {
>  	struct ad7887_platform_data *pdata = spi->dev.platform_data;
> @@ -258,6 +265,10 @@ static int ad7887_probe(struct spi_device *spi)
>  		ret = regulator_enable(st->reg);
>  		if (ret)
>  			return ret;
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7887_reg_disable, st->reg);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	st->chip_info =
> @@ -316,36 +327,13 @@ static int ad7887_probe(struct spi_device *spi)
>  		indio_dev->num_channels = st->chip_info->num_channels;
>  	}
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +			&iio_pollfunc_store_time,
>  			&ad7887_trigger_handler, &ad7887_ring_setup_ops);
>  	if (ret)
> -		goto error_disable_reg;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_unregister_ring;
> -
> -	return 0;
> -error_unregister_ring:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -error_disable_reg:
> -	if (st->reg)
> -		regulator_disable(st->reg);
> -
> -	return ret;
> -}
> -
> -static int ad7887_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ad7887_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	if (st->reg)
> -		regulator_disable(st->reg);
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad7887_id[] = {
> @@ -359,7 +347,6 @@ static struct spi_driver ad7887_driver = {
>  		.name	= "ad7887",
>  	},
>  	.probe		= ad7887_probe,
> -	.remove		= ad7887_remove,
>  	.id_table	= ad7887_id,
>  };
>  module_spi_driver(ad7887_driver);

