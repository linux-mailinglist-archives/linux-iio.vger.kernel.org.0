Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5576B3CC50D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhGQRxj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 13:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhGQRxj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:53:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F78761153;
        Sat, 17 Jul 2021 17:50:41 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:53:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: dmard10: convert probe to device-managed
 functions
Message-ID: <20210717185304.6a8b489d@jic23-huawei>
In-Reply-To: <20210630121509.653717-1-aardelean@deviqon.com>
References: <20210630121509.653717-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 15:15:09 +0300
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

> ---
>  drivers/iio/accel/dmard10.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
> index e84bf8db1e89..f9f173eec202 100644
> --- a/drivers/iio/accel/dmard10.c
> +++ b/drivers/iio/accel/dmard10.c
> @@ -170,6 +170,11 @@ static const struct iio_info dmard10_info = {
>  	.read_raw	= dmard10_read_raw,
>  };
>  
> +static void dmard10_shutdown_cleanup(void *client)
> +{
> +	dmard10_shutdown(client);
> +}
> +
>  static int dmard10_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -194,7 +199,6 @@ static int dmard10_probe(struct i2c_client *client,
>  
>  	data = iio_priv(indio_dev);
>  	data->client = client;
> -	i2c_set_clientdata(client, indio_dev);
>  
>  	indio_dev->info = &dmard10_info;
>  	indio_dev->name = "dmard10";
> @@ -206,22 +210,12 @@ static int dmard10_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "device_register failed\n");
> -		dmard10_shutdown(client);
> -	}
> -
> -	return ret;
> -}
> -
> -static int dmard10_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev, dmard10_shutdown_cleanup,
> +				       client);
> +	if (ret)
> +		return ret;
>  
> -	return dmard10_shutdown(client);
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -250,7 +244,6 @@ static struct i2c_driver dmard10_driver = {
>  		.pm = &dmard10_pm_ops,
>  	},
>  	.probe		= dmard10_probe,
> -	.remove		= dmard10_remove,
>  	.id_table	= dmard10_i2c_id,
>  };
>  

