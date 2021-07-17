Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66CE3CC511
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhGQRyo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 13:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhGQRyl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:54:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABFE461153;
        Sat, 17 Jul 2021 17:51:43 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:54:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: da311: convert probe to device-managed
 functions
Message-ID: <20210717185407.01d89612@jic23-huawei>
In-Reply-To: <20210630120338.482426-1-aardelean@deviqon.com>
References: <20210630120338.482426-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 15:03:38 +0300
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

J
> ---
>  drivers/iio/accel/da311.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
> index 92593a1cd1aa..04e13487e706 100644
> --- a/drivers/iio/accel/da311.c
> +++ b/drivers/iio/accel/da311.c
> @@ -212,6 +212,11 @@ static const struct iio_info da311_info = {
>  	.read_raw	= da311_read_raw,
>  };
>  
> +static void da311_disable(void *client)
> +{
> +	da311_enable(client, false);
> +}
> +
>  static int da311_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -229,7 +234,6 @@ static int da311_probe(struct i2c_client *client,
>  
>  	data = iio_priv(indio_dev);
>  	data->client = client;
> -	i2c_set_clientdata(client, indio_dev);
>  
>  	indio_dev->info = &da311_info;
>  	indio_dev->name = "da311";
> @@ -245,22 +249,11 @@ static int da311_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "device_register failed\n");
> -		da311_enable(client, false);
> -	}
> -
> -	return ret;
> -}
> -
> -static int da311_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev, da311_disable, client);
> +	if (ret)
> +		return ret;
>  
> -	return da311_enable(client, false);
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -289,7 +282,6 @@ static struct i2c_driver da311_driver = {
>  		.pm = &da311_pm_ops,
>  	},
>  	.probe		= da311_probe,
> -	.remove		= da311_remove,
>  	.id_table	= da311_i2c_id,
>  };
>  

