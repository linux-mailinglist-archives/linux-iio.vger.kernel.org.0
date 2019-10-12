Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138DAD501F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfJLNh3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfJLNh3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:37:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E86206CD;
        Sat, 12 Oct 2019 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570887448;
        bh=HNezrJTvANQlWtCUUOHdHEJyKqbKhpwfQ/1hZ51c9kM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sh89hOdO1yIdtQIEJznphsbOXkTS7MRC6F+ea4RHInrvbHdz7zFMosIlc7qQXhsjZ
         mFlVth5YvEFZ2V1DypPBeAzYwD9Asyk5d3ZBEyhkTyHYnhIV/dt0oBZ20JihRm3qgM
         2xEjTRN2i1+pC3gunRSKSe7Xmmf8k4/c5SE4k63I=
Date:   Sat, 12 Oct 2019 14:37:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2] iio: pressure: bmp280: use devm action and remove
 labels from probe
Message-ID: <20191012143722.7cb7015d@archlinux>
In-Reply-To: <20191007024131.22708-1-brgl@bgdev.pl>
References: <20191007024131.22708-1-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Oct 2019 04:41:31 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We can drop some duplicate code if we use devm_action for disabling
> regulators and pm and the managed variant of iio_device_register().
> 
> This allows us to completely remove all remove() callbacks from both
> i2c and spi code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
This is on top of the bulk regulator patch which is awaiting precusors
getting to my upstream.  I'll hold this one as well on that.

If it looks like I've forgotten it then give me a poke.

Thanks,

Jonathan

> ---
> v1 -> v2:
> - squash the patches using devm_iio_device_register() and devm_action
>   to keep the changes bisectable
> 
>  drivers/iio/pressure/bmp280-core.c | 62 +++++++++++++++---------------
>  drivers/iio/pressure/bmp280-i2c.c  |  6 ---
>  drivers/iio/pressure/bmp280-spi.c  |  6 ---
>  drivers/iio/pressure/bmp280.h      |  1 -
>  4 files changed, 30 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index c2988dbdb1a7..79254dd26dfd 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -984,6 +984,22 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
>  	return 0;
>  }
>  
> +static void bmp280_pm_disable(void *data)
> +{
> +	struct device *dev = data;
> +
> +	pm_runtime_get_sync(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +static void bmp280_regulators_disable(void *data)
> +{
> +	struct regulator_bulk_data *supplies = data;
> +
> +	regulator_bulk_disable(BMP280_NUM_SUPPLIES, supplies);
> +}
> +
>  int bmp280_common_probe(struct device *dev,
>  			struct regmap *regmap,
>  			unsigned int chip,
> @@ -1055,6 +1071,11 @@ int bmp280_common_probe(struct device *dev,
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(dev, bmp280_regulators_disable,
> +				       data->supplies);
> +	if (ret)
> +		return ret;
> +
>  	/* Wait to make sure we started up properly */
>  	usleep_range(data->start_up_time, data->start_up_time + 100);
>  
> @@ -1069,17 +1090,16 @@ int bmp280_common_probe(struct device *dev,
>  	data->regmap = regmap;
>  	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
>  	if (ret < 0)
> -		goto out_disable_regulators;
> +		return ret;
>  	if (chip_id != chip) {
>  		dev_err(dev, "bad chip id: expected %x got %x\n",
>  			chip, chip_id);
> -		ret = -EINVAL;
> -		goto out_disable_regulators;
> +		return -EINVAL;
>  	}
>  
>  	ret = data->chip_info->chip_config(data);
>  	if (ret < 0)
> -		goto out_disable_regulators;
> +		return ret;
>  
>  	dev_set_drvdata(dev, indio_dev);
>  
> @@ -1093,14 +1113,14 @@ int bmp280_common_probe(struct device *dev,
>  		if (ret < 0) {
>  			dev_err(data->dev,
>  				"failed to read calibration coefficients\n");
> -			goto out_disable_regulators;
> +			return ret;
>  		}
>  	} else if (chip_id == BMP280_CHIP_ID || chip_id == BME280_CHIP_ID) {
>  		ret = bmp280_read_calib(data, &data->calib.bmp280, chip_id);
>  		if (ret < 0) {
>  			dev_err(data->dev,
>  				"failed to read calibration coefficients\n");
> -			goto out_disable_regulators;
> +			return ret;
>  		}
>  	}
>  
> @@ -1112,7 +1132,7 @@ int bmp280_common_probe(struct device *dev,
>  	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
>  		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
>  		if (ret)
> -			goto out_disable_regulators;
> +			return ret;
>  	}
>  
>  	/* Enable runtime PM */
> @@ -1127,36 +1147,14 @@ int bmp280_common_probe(struct device *dev,
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_put(dev);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_add_action_or_reset(dev, bmp280_pm_disable, dev);
>  	if (ret)
> -		goto out_runtime_pm_disable;
> -
> -	return 0;
> +		return ret;
>  
> -out_runtime_pm_disable:
> -	pm_runtime_get_sync(data->dev);
> -	pm_runtime_put_noidle(data->dev);
> -	pm_runtime_disable(data->dev);
> -out_disable_regulators:
> -	regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
> -	return ret;
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL(bmp280_common_probe);
>  
> -int bmp280_common_remove(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct bmp280_data *data = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	pm_runtime_get_sync(data->dev);
> -	pm_runtime_put_noidle(data->dev);
> -	pm_runtime_disable(data->dev);
> -	regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
> -	return 0;
> -}
> -EXPORT_SYMBOL(bmp280_common_remove);
> -
>  #ifdef CONFIG_PM
>  static int bmp280_runtime_suspend(struct device *dev)
>  {
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index acd9a3784fb4..3109c8e2cc11 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -38,11 +38,6 @@ static int bmp280_i2c_probe(struct i2c_client *client,
>  				   client->irq);
>  }
>  
> -static int bmp280_i2c_remove(struct i2c_client *client)
> -{
> -	return bmp280_common_remove(&client->dev);
> -}
> -
>  static const struct acpi_device_id bmp280_acpi_i2c_match[] = {
>  	{"BMP0280", BMP280_CHIP_ID },
>  	{"BMP0180", BMP180_CHIP_ID },
> @@ -82,7 +77,6 @@ static struct i2c_driver bmp280_i2c_driver = {
>  		.pm = &bmp280_dev_pm_ops,
>  	},
>  	.probe		= bmp280_i2c_probe,
> -	.remove		= bmp280_i2c_remove,
>  	.id_table	= bmp280_i2c_id,
>  };
>  module_i2c_driver(bmp280_i2c_driver);
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 9d57b7a3b134..625b86878ad8 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -86,11 +86,6 @@ static int bmp280_spi_probe(struct spi_device *spi)
>  				   spi->irq);
>  }
>  
> -static int bmp280_spi_remove(struct spi_device *spi)
> -{
> -	return bmp280_common_remove(&spi->dev);
> -}
> -
>  static const struct of_device_id bmp280_of_spi_match[] = {
>  	{ .compatible = "bosch,bmp085", },
>  	{ .compatible = "bosch,bmp180", },
> @@ -118,7 +113,6 @@ static struct spi_driver bmp280_spi_driver = {
>  	},
>  	.id_table = bmp280_spi_id,
>  	.probe = bmp280_spi_probe,
> -	.remove = bmp280_spi_remove,
>  };
>  module_spi_driver(bmp280_spi_driver);
>  
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index eda50ef65706..57ba0e85db91 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -112,7 +112,6 @@ int bmp280_common_probe(struct device *dev,
>  			unsigned int chip,
>  			const char *name,
>  			int irq);
> -int bmp280_common_remove(struct device *dev);
>  
>  /* PM ops */
>  extern const struct dev_pm_ops bmp280_dev_pm_ops;

