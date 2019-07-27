Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92A977AAC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbfG0RIW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 13:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbfG0RIW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 13:08:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976892084C;
        Sat, 27 Jul 2019 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564247300;
        bh=+5rybbzMCfeUCU9zj0JwT7+RbQ9TvG9+x6KA+ybGIT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C0cvKrxK5hKi33q686/t9d2x8yrKhta7fUwU1RlVrrpZWtrxqr32xShPIrrlHqmxF
         E6XEvwEJeZXkkAWmy2DqW6NYX4v3qZb8WqBoDzo/DGDGs+4E9OFiOGOObSHZZFur6T
         qKF0As8cEfRnvT1z5ewUzr9qwyTP1JWGjOEAXwdM=
Date:   Sat, 27 Jul 2019 18:08:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: Use device-managed APIs
Message-ID: <20190727180815.0c3e655e@archlinux>
In-Reply-To: <20190726090829.16979-1-hslester96@gmail.com>
References: <20190726090829.16979-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 17:08:29 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use device-managed APIs to simplify the code.
> The remove functions are redundant now and can
> be deleted.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Hi,

This should have been split along the lines of the drivers as these
have different authors and hence could be merged at different times.
Not to mention the nature of the changes isn't exactly the same
between the two.

I might have taken the cm3323 one with a small tweak as below if they
had been separate.

Thanks,

Jonathan

> ---
>  drivers/iio/light/cm3323.c | 31 ++++++++++-----------------
>  drivers/iio/light/si1145.c | 44 ++++++++++++++------------------------
>  2 files changed, 27 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 50f3438c2b49..fd352c0a4507 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -101,15 +101,16 @@ static int cm3323_init(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static void cm3323_disable(struct iio_dev *indio_dev)
> +static void cm3323_disable(void *data)
>  {
>  	int ret;
> -	struct cm3323_data *data = iio_priv(indio_dev);
> +	struct iio_dev *indio_dev = data;
> +	struct cm3323_data *cm_data = iio_priv(indio_dev);
>  
> -	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
> +	ret = i2c_smbus_write_word_data(cm_data->client, CM3323_CMD_CONF,
>  					CM3323_CONF_SD_BIT);
>  	if (ret < 0)
> -		dev_err(&data->client->dev, "Error writing reg_conf\n");
> +		dev_err(&cm_data->client->dev, "Error writing reg_conf\n");
>  }
>  
>  static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
> @@ -243,25 +244,16 @@ static int cm3323_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "failed to register iio dev\n");
> -		goto err_init;
> +		return ret;

I'd drop the failed to register message and just
return devm_iio_device_register(...);

Most of the likely paths that can cause that to fail report errors anyway
in the core code.

>  	}
>  
> -	return 0;
> -err_init:
> -	cm3323_disable(indio_dev);
> -	return ret;
> -}
> -
> -static int cm3323_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	cm3323_disable(indio_dev);
> -
>  	return 0;
>  }
>  
> @@ -276,7 +268,6 @@ static struct i2c_driver cm3323_driver = {
>  		.name = CM3323_DRV_NAME,
>  	},
>  	.probe		= cm3323_probe,
> -	.remove		= cm3323_remove,
>  	.id_table	= cm3323_id,
>  };
>  
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 6579d2418814..61867552b27c 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -1271,13 +1271,14 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static void si1145_remove_trigger(struct iio_dev *indio_dev)
> +static void si1145_remove_trigger(void *data)
>  {
> -	struct si1145_data *data = iio_priv(indio_dev);
> +	struct iio_dev *indio_dev = data;
> +	struct si1145_data *si_data = iio_priv(indio_dev);
>  
> -	if (data->trig) {
> -		iio_trigger_unregister(data->trig);
> -		data->trig = NULL;
> +	if (si_data->trig) {
> +		iio_trigger_unregister(si_data->trig);

This doesn't look right.  Why not use the devm trigger
registration directly?

> +		si_data->trig = NULL;

I find it unlikely that we actually need to set this to
NULL, but please check closely in the driver.
The obvious path would be that the interrupt fired
after the trigger was unregistered (shouldn't be possible
unless something odd is going on), however there is no
obviously signs of this being checked there.


>  	}
>  }
>  
> @@ -1332,7 +1333,8 @@ static int si1145_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(&client->dev,
> +		indio_dev, NULL,
>  		si1145_trigger_handler, &si1145_buffer_setup_ops);
>  	if (ret < 0)
>  		return ret;
> @@ -1340,23 +1342,21 @@ static int si1145_probe(struct i2c_client *client,
>  	if (client->irq) {
>  		ret = si1145_probe_trigger(indio_dev);
>  		if (ret < 0)
> -			goto error_free_buffer;
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&client->dev,
> +					si1145_remove_trigger, indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
>  	} else {
>  		dev_info(&client->dev, "no irq, using polling\n");
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret < 0)
> -		goto error_free_trigger;
> +		return ret;
>  
>  	return 0;
> -
> -error_free_trigger:
> -	si1145_remove_trigger(indio_dev);
> -error_free_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
>  }
>  
>  static const struct i2c_device_id si1145_ids[] = {
> @@ -1371,23 +1371,11 @@ static const struct i2c_device_id si1145_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, si1145_ids);
>  
> -static int si1145_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	si1145_remove_trigger(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return 0;
> -}
> -
>  static struct i2c_driver si1145_driver = {
>  	.driver = {
>  		.name   = "si1145",
>  	},
>  	.probe  = si1145_probe,
> -	.remove = si1145_remove,
>  	.id_table = si1145_ids,
>  };
>  

