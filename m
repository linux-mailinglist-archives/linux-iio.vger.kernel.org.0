Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA43E3BA0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhHHQi2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 8 Aug 2021 12:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhHHQi2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 12:38:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 418F860EB9;
        Sun,  8 Aug 2021 16:38:07 +0000 (UTC)
Date:   Sun, 8 Aug 2021 17:40:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?VGjDqW8gQm9yw6lt?= Fabris <theobf@usp.br>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] iio: pressure: hp03: update device probe to register
 with devm functions
Message-ID: <20210808174056.63158f33@jic23-huawei>
In-Reply-To: <20210808122335.4895-1-theobf@usp.br>
References: <20210808122335.4895-1-theobf@usp.br>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  8 Aug 2021 09:23:36 -0300
Théo Borém Fabris <theobf@usp.br> wrote:

> Update device probe to register resources with device-managed functions.
> Further, get rid of device-specific remove callback which is no longer
> needed.
> 
> Signed-off-by: Théo Borém Fabris <theobf@usp.br>

+Cc Marek on a couple of addresses as not sure which currently work.

One tiny cleanup inline, otherwise looks good to me.

> ---
> Could the dev_err() messages be improved? In particular, I don't know if
> it is important to express the usage of the device-managed functions.

I'd leave them as is.  Chance of a devm causing a failure that wouldn't
otherwise happen is nearly 0 as it only requires a tiny allocation extra.

> 
>  drivers/iio/pressure/hp03.c | 35 +++++++----------------------------
>  1 file changed, 7 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
> index e40b1d7dc12..78ea95d9f99 100644
> --- a/drivers/iio/pressure/hp03.c
> +++ b/drivers/iio/pressure/hp03.c
> @@ -242,47 +242,27 @@ static int hp03_probe(struct i2c_client *client,
>  	 * which has it's dedicated I2C address and contains
>  	 * the calibration constants for the sensor.
>  	 */
> -	priv->eeprom_client = i2c_new_dummy_device(client->adapter, HP03_EEPROM_ADDR);
> +	priv->eeprom_client = devm_i2c_new_dummy_device(dev, client->adapter,
> +							HP03_EEPROM_ADDR);
>  	if (IS_ERR(priv->eeprom_client)) {
>  		dev_err(dev, "New EEPROM I2C device failed\n");
>  		return PTR_ERR(priv->eeprom_client);
>  	}
>  
> -	priv->eeprom_regmap = regmap_init_i2c(priv->eeprom_client,
> -					      &hp03_regmap_config);
> +	priv->eeprom_regmap = devm_regmap_init_i2c(priv->eeprom_client,
> +						   &hp03_regmap_config);
>  	if (IS_ERR(priv->eeprom_regmap)) {
>  		dev_err(dev, "Failed to allocate EEPROM regmap\n");
>  		ret = PTR_ERR(priv->eeprom_regmap);
> -		goto err_cleanup_eeprom_client;
> +		return ret;

return PTR_ERR(priv->eeprom_regmap);

>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to register IIO device\n");
> -		goto err_cleanup_eeprom_regmap;
> +		return ret;
>  	}
>  
> -	i2c_set_clientdata(client, indio_dev);
> -
> -	return 0;
> -
> -err_cleanup_eeprom_regmap:
> -	regmap_exit(priv->eeprom_regmap);
> -
> -err_cleanup_eeprom_client:
> -	i2c_unregister_device(priv->eeprom_client);
> -	return ret;
> -}
> -
> -static int hp03_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct hp03_priv *priv = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	regmap_exit(priv->eeprom_regmap);
> -	i2c_unregister_device(priv->eeprom_client);
> -
>  	return 0;
>  }
>  
> @@ -304,7 +284,6 @@ static struct i2c_driver hp03_driver = {
>  		.of_match_table = hp03_of_match,
>  	},
>  	.probe		= hp03_probe,
> -	.remove		= hp03_remove,
>  	.id_table	= hp03_id,
>  };
>  module_i2c_driver(hp03_driver);

