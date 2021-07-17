Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8293CC514
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhGQR6p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 13:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhGQR6p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:58:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8276113D;
        Sat, 17 Jul 2021 17:55:47 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:58:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: da280: convert probe to device-managed
 functions
Message-ID: <20210717185809.181d38ca@jic23-huawei>
In-Reply-To: <20210628141709.80534-1-aardelean@deviqon.com>
References: <20210628141709.80534-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Jun 2021 17:17:09 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This is another simple conversion to device-managed functions, requiring
> the use of devm_iio_device_register() and moving the disabling of the
> device on a devm_add_action_or_reset() hook.
> 
> The i2c_set_clientdata() can be removed, as the PM functions can work with
> just the device object, to obtain the i2c_client object.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/accel/da280.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 5edff9ba72da..9633bdae5fd4 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -100,6 +100,11 @@ static enum da280_chipset da280_match_acpi_device(struct device *dev)
>  	return (enum da280_chipset) id->driver_data;
>  }
>  
> +static void da280_disable(void *client)
> +{
> +	da280_enable(client, false);
> +}
> +
>  static int da280_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -118,7 +123,6 @@ static int da280_probe(struct i2c_client *client,
>  
>  	data = iio_priv(indio_dev);
>  	data->client = client;
> -	i2c_set_clientdata(client, indio_dev);
>  
>  	indio_dev->info = &da280_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -142,22 +146,11 @@ static int da280_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "device_register failed\n");
> -		da280_enable(client, false);
> -	}
> -
> -	return ret;
> -}
> -
> -static int da280_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev, da280_disable, client);
> +	if (ret)
> +		return ret;
>  
> -	return da280_enable(client, false);
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -194,7 +187,6 @@ static struct i2c_driver da280_driver = {
>  		.pm = &da280_pm_ops,
>  	},
>  	.probe		= da280_probe,
> -	.remove		= da280_remove,
>  	.id_table	= da280_i2c_id,
>  };
>  

