Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BFE4107FB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbhIRSDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 14:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238237AbhIRSDg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 14:03:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75AF0610E9;
        Sat, 18 Sep 2021 18:02:11 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:05:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5064: convert probe to full device-managed
Message-ID: <20210918190550.62a321ce@jic23-huawei>
In-Reply-To: <20210913115237.301310-1-aardelean@deviqon.com>
References: <20210913115237.301310-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 14:52:37 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the probe of the AD5064 driver to use only
> device-managed functions.
> 
> The regulator_bulk_disable() is passed on a devm_add_action_or_reset() hook
> and the devm_iio_device_register() can be used to register the IIO device.
> 
> The driver has both I2C and SPI hooks inside, so all these can be removed.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Applied to the togreg branch of iio.git and pushed out as testing for all the normal
tedious reasons about the fact we should actually build test it on lots of architectures
etc :)

Jonathan

> ---
>  drivers/iio/dac/ad5064.c | 49 ++++++++++------------------------------
>  1 file changed, 12 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index dff623b65e4f..fd9cac4f6321 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -843,6 +843,13 @@ static int ad5064_request_vref(struct ad5064_state *st, struct device *dev)
>  	return ret;
>  }
>  
> +static void ad5064_bulk_reg_disable(void *data)
> +{
> +	struct ad5064_state *st = data;
> +
> +	regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
> +}
> +
>  static int ad5064_probe(struct device *dev, enum ad5064_type type,
>  			const char *name, ad5064_write_func write)
>  {
> @@ -858,7 +865,6 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
>  
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
> -	dev_set_drvdata(dev, indio_dev);
>  
>  	st->chip_info = &ad5064_chip_info_tbl[type];
>  	st->dev = dev;
> @@ -872,6 +878,10 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
>  		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
>  		if (ret)
>  			return ret;
> +
> +		ret = devm_add_action_or_reset(dev, ad5064_bulk_reg_disable, st);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	indio_dev->name = name;
> @@ -887,30 +897,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
>  		st->dac_cache[i] = midscale;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_disable_reg;
> -
> -	return 0;
> -
> -error_disable_reg:
> -	if (!st->use_internal_vref)
> -		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
> -
> -	return ret;
> -}
> -
> -static int ad5064_remove(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct ad5064_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	if (!st->use_internal_vref)
> -		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
> -
> -	return 0;
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  #if IS_ENABLED(CONFIG_SPI_MASTER)
> @@ -932,11 +919,6 @@ static int ad5064_spi_probe(struct spi_device *spi)
>  				ad5064_spi_write);
>  }
>  
> -static int ad5064_spi_remove(struct spi_device *spi)
> -{
> -	return ad5064_remove(&spi->dev);
> -}
> -
>  static const struct spi_device_id ad5064_spi_ids[] = {
>  	{"ad5024", ID_AD5024},
>  	{"ad5025", ID_AD5025},
> @@ -963,7 +945,6 @@ static struct spi_driver ad5064_spi_driver = {
>  		   .name = "ad5064",
>  	},
>  	.probe = ad5064_spi_probe,
> -	.remove = ad5064_spi_remove,
>  	.id_table = ad5064_spi_ids,
>  };
>  
> @@ -1019,11 +1000,6 @@ static int ad5064_i2c_probe(struct i2c_client *i2c,
>  						ad5064_i2c_write);
>  }
>  
> -static int ad5064_i2c_remove(struct i2c_client *i2c)
> -{
> -	return ad5064_remove(&i2c->dev);
> -}
> -
>  static const struct i2c_device_id ad5064_i2c_ids[] = {
>  	{"ad5625", ID_AD5625 },
>  	{"ad5625r-1v25", ID_AD5625R_1V25 },
> @@ -1081,7 +1057,6 @@ static struct i2c_driver ad5064_i2c_driver = {
>  		   .name = "ad5064",
>  	},
>  	.probe = ad5064_i2c_probe,
> -	.remove = ad5064_i2c_remove,
>  	.id_table = ad5064_i2c_ids,
>  };
>  

