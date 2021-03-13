Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB61D33A011
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 19:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhCMSuU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 13:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233635AbhCMSt5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 13:49:57 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637FB64ECE;
        Sat, 13 Mar 2021 18:49:56 +0000 (UTC)
Date:   Sat, 13 Mar 2021 18:49:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        manivannanece23@gmail.com, linux@deviqon.com
Subject: Re: [PATCH] iio: temperature: tmp007: use device-managed functions
 in probe
Message-ID: <20210313184952.671b01b1@archlinux>
In-Reply-To: <20210310093800.45822-1-aardelean@deviqon.com>
References: <20210310093800.45822-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Mar 2021 11:38:00 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the driver to use device-managed functions in the
> probe function. The power-down call is handled now via a
> devm_add_action_or_reset() hook, and then devm_iio_device_register() can be
> used to register the IIO device.
> 
> The final aim here would be for IIO to export only the device-managed
> functions of it's API. That's a long way to go and this a small step in
> that direction.
I'm not sure it makes sense in all cases!  However this particular one
is clear cut.

Applied to the togreg branch of iio.git and pushed out as testing.
Manivannan, I won't be pushing this out as a non rebasing tree for
a few days if you want to take a look.

thanks,

Jonathan

> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>  drivers/iio/temperature/tmp007.c | 36 +++++++++++++-------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
> index ad2b35c65548..b422371a4674 100644
> --- a/drivers/iio/temperature/tmp007.c
> +++ b/drivers/iio/temperature/tmp007.c
> @@ -439,6 +439,13 @@ static bool tmp007_identify(struct i2c_client *client)
>  	return (manf_id == TMP007_MANUFACTURER_MAGIC && dev_id == TMP007_DEVICE_MAGIC);
>  }
>  
> +static void tmp007_powerdown_action_cb(void *priv)
> +{
> +	struct tmp007_data *data = priv;
> +
> +	tmp007_powerdown(data);
> +}
> +
>  static int tmp007_probe(struct i2c_client *client,
>  			const struct i2c_device_id *tmp007_id)
>  {
> @@ -489,6 +496,10 @@ static int tmp007_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&client->dev, tmp007_powerdown_action_cb, data);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Only the following flags can activate ALERT pin. Data conversion/validity flags
>  	 * flags can still be polled for getting temperature data
> @@ -502,7 +513,7 @@ static int tmp007_probe(struct i2c_client *client,
>  
>  	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
>  	if (ret < 0)
> -		goto error_powerdown;
> +		return ret;
>  
>  	data->status_mask = ret;
>  	data->status_mask |= (TMP007_STATUS_OHF | TMP007_STATUS_OLF
> @@ -510,7 +521,7 @@ static int tmp007_probe(struct i2c_client *client,
>  
>  	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK, data->status_mask);
>  	if (ret < 0)
> -		goto error_powerdown;
> +		return ret;
>  
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
> @@ -519,27 +530,11 @@ static int tmp007_probe(struct i2c_client *client,
>  				tmp007_id->name, indio_dev);
>  		if (ret) {
>  			dev_err(&client->dev, "irq request error %d\n", -ret);
> -			goto error_powerdown;
> +			return ret;
>  		}
>  	}
>  
> -	return iio_device_register(indio_dev);
> -
> -error_powerdown:
> -	tmp007_powerdown(data);
> -
> -	return ret;
> -}
> -
> -static int tmp007_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct tmp007_data *data = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	tmp007_powerdown(data);
> -
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -582,7 +577,6 @@ static struct i2c_driver tmp007_driver = {
>  		.pm	= &tmp007_pm_ops,
>  	},
>  	.probe		= tmp007_probe,
> -	.remove		= tmp007_remove,
>  	.id_table	= tmp007_id,
>  };
>  module_i2c_driver(tmp007_driver);

