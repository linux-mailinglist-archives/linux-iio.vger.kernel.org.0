Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90B74107F3
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbhIRR66 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 13:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhIRR65 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 13:58:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82626101B;
        Sat, 18 Sep 2021 17:57:32 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:01:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad7303: convert probe to full device-managed
Message-ID: <20210918190112.7fa9df50@jic23-huawei>
In-Reply-To: <20210913115121.300082-1-aardelean@deviqon.com>
References: <20210913115121.300082-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 14:51:21 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> For this conversion, the regulators need to have some cleanup hooks
> registered with devm_add_action_or_reset() and then the
> devm_io_device_register() call can be used.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Nice simple case.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad7303.c | 47 +++++++++++++++-------------------------
>  1 file changed, 17 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index e1b6a92df12f..91eaaf793b3e 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -198,6 +198,11 @@ static const struct iio_chan_spec ad7303_channels[] = {
>  	AD7303_CHANNEL(1),
>  };
>  
> +static void ad7303_reg_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
>  static int ad7303_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -210,7 +215,6 @@ static int ad7303_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	st->spi = spi;
>  
> @@ -224,18 +228,27 @@ static int ad7303_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&spi->dev, ad7303_reg_disable, st->vdd_reg);
> +	if (ret)
> +		return ret;
> +
>  	st->vref_reg = devm_regulator_get_optional(&spi->dev, "REF");
>  	if (IS_ERR(st->vref_reg)) {
>  		ret = PTR_ERR(st->vref_reg);
>  		if (ret != -ENODEV)
> -			goto err_disable_vdd_reg;
> +			return ret;
>  		st->vref_reg = NULL;
>  	}
>  
>  	if (st->vref_reg) {
>  		ret = regulator_enable(st->vref_reg);
>  		if (ret)
> -			goto err_disable_vdd_reg;
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7303_reg_disable,
> +					       st->vref_reg);
> +		if (ret)
> +			return ret;
>  
>  		st->config |= AD7303_CFG_EXTERNAL_VREF;
>  	}
> @@ -246,32 +259,7 @@ static int ad7303_probe(struct spi_device *spi)
>  	indio_dev->channels = ad7303_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad7303_channels);
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto err_disable_vref_reg;
> -
> -	return 0;
> -
> -err_disable_vref_reg:
> -	if (st->vref_reg)
> -		regulator_disable(st->vref_reg);
> -err_disable_vdd_reg:
> -	regulator_disable(st->vdd_reg);
> -	return ret;
> -}
> -
> -static int ad7303_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ad7303_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	if (st->vref_reg)
> -		regulator_disable(st->vref_reg);
> -	regulator_disable(st->vdd_reg);
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id ad7303_spi_of_match[] = {
> @@ -292,7 +280,6 @@ static struct spi_driver ad7303_driver = {
>  		.of_match_table = ad7303_spi_of_match,
>  	},
>  	.probe = ad7303_probe,
> -	.remove = ad7303_remove,
>  	.id_table = ad7303_spi_ids,
>  };
>  module_spi_driver(ad7303_driver);

