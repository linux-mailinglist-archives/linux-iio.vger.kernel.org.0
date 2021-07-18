Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0B3CC997
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhGROfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 10:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhGROfU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 10:35:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5927A611AB;
        Sun, 18 Jul 2021 14:32:21 +0000 (UTC)
Date:   Sun, 18 Jul 2021 15:34:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl345: convert probe to device-managed
 functions
Message-ID: <20210718153445.5e4570ba@jic23-huawei>
In-Reply-To: <20210624080441.8710-1-aardelean@deviqon.com>
References: <20210624080441.8710-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jun 2021 11:04:40 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This driver has two parts, one for i2c and one for spi, since the chip can
> operate with both wire protocols.
> 
> The core file has a common adxl345_core_remove() function which puts the
> chip into a powerdown state. This can be implemented with a
> devm_add_action_or_reset() hook.
> 
> Doing that means we can register the IIO device with
> devm_iio_device_register() and get rid of the adxl345_core_remove()
> function.
> 
> The dev_set_drvdata() call can be removed as there is no other user of this
> private data anymore.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Applied to the togreg branch of iio.git and pushed out as testing for all
the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl345.h      |  1 -
>  drivers/iio/accel/adxl345_core.c | 29 +++++++++--------------------
>  drivers/iio/accel/adxl345_i2c.c  |  6 ------
>  drivers/iio/accel/adxl345_spi.c  |  6 ------
>  4 files changed, 9 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 384497776b67..af0fdd02c4f2 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -15,6 +15,5 @@ enum adxl345_device_type {
>  
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		       enum adxl345_device_type type, const char *name);
> -int adxl345_core_remove(struct device *dev);
>  
>  #endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 312866530065..4b275051ef61 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -208,6 +208,11 @@ static const struct iio_info adxl345_info = {
>  	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
>  };
>  
> +static void adxl345_powerdown(void *regmap)
> +{
> +	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
> +}
> +
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		       enum adxl345_device_type type, const char *name)
>  {
> @@ -233,7 +238,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> -	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
>  	data->type = type;
>  	/* Enable full-resolution mode */
> @@ -260,29 +264,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(dev, "iio_device_register failed: %d\n", ret);
> -		regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> -			     ADXL345_POWER_CTL_STANDBY);
> -	}
> +	ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
> +	if (ret < 0)
> +		return ret;
>  
> -	return ret;
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(adxl345_core_probe);
>  
> -int adxl345_core_remove(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct adxl345_data *data = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> -			    ADXL345_POWER_CTL_STANDBY);
> -}
> -EXPORT_SYMBOL_GPL(adxl345_core_remove);
> -
>  MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
>  MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer core driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 1561364ae296..a431cba216e6 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -38,11 +38,6 @@ static int adxl345_i2c_probe(struct i2c_client *client,
>  				  id->name);
>  }
>  
> -static int adxl345_i2c_remove(struct i2c_client *client)
> -{
> -	return adxl345_core_remove(&client->dev);
> -}
> -
>  static const struct i2c_device_id adxl345_i2c_id[] = {
>  	{ "adxl345", ADXL345 },
>  	{ "adxl375", ADXL375 },
> @@ -65,7 +60,6 @@ static struct i2c_driver adxl345_i2c_driver = {
>  		.of_match_table = adxl345_of_match,
>  	},
>  	.probe		= adxl345_i2c_probe,
> -	.remove		= adxl345_i2c_remove,
>  	.id_table	= adxl345_i2c_id,
>  };
>  
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index da4591c7ef23..ea559ac2e87d 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -42,11 +42,6 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
>  }
>  
> -static int adxl345_spi_remove(struct spi_device *spi)
> -{
> -	return adxl345_core_remove(&spi->dev);
> -}
> -
>  static const struct spi_device_id adxl345_spi_id[] = {
>  	{ "adxl345", ADXL345 },
>  	{ "adxl375", ADXL375 },
> @@ -69,7 +64,6 @@ static struct spi_driver adxl345_spi_driver = {
>  		.of_match_table = adxl345_of_match,
>  	},
>  	.probe		= adxl345_spi_probe,
> -	.remove		= adxl345_spi_remove,
>  	.id_table	= adxl345_spi_id,
>  };
>  

