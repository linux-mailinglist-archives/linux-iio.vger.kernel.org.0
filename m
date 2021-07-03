Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB463BA9A5
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhGCRHL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 13:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCRHK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 13:07:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207CF6191F;
        Sat,  3 Jul 2021 17:04:34 +0000 (UTC)
Date:   Sat, 3 Jul 2021 18:06:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: proximity: rfd77402: convert probe to
 device-managed functions
Message-ID: <20210703180658.64867287@jic23-huawei>
In-Reply-To: <20210630131636.1563148-2-aardelean@deviqon.com>
References: <20210630131636.1563148-1-aardelean@deviqon.com>
        <20210630131636.1563148-2-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 16:16:36 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the probe hook to register the IIO device with
> devm_iio_device_register() and register a hook with
> devm_add_action_or_reset() to put the device in powerdown when the driver
> gets unloaded.
> 
> Since the PM suspend/resume functions need only a reference to the
> i2c_client object (which can be obtained from the base device object), the
> i2c_set_clientdata() call can be removed.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Fine as well, but more time on list probably good for it!

J
> ---
>  drivers/iio/proximity/rfd77402.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
> index f349526421f3..8c06d02139b6 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -252,6 +252,11 @@ static int rfd77402_powerdown(struct i2c_client *client)
>  				  RFD77402_STATUS_STANDBY);
>  }
>  
> +static void rfd77402_disable(void *client)
> +{
> +	rfd77402_powerdown(client);
> +}
> +
>  static int rfd77402_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -270,7 +275,6 @@ static int rfd77402_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  	mutex_init(&data->lock);
>  
> @@ -284,25 +288,11 @@ static int rfd77402_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev, rfd77402_disable, client);
>  	if (ret)
> -		goto err_powerdown;
> -
> -	return 0;
> -
> -err_powerdown:
> -	rfd77402_powerdown(client);
> -	return ret;
> -}
> -
> -static int rfd77402_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	rfd77402_powerdown(client);
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -331,7 +321,6 @@ static struct i2c_driver rfd77402_driver = {
>  		.pm     = &rfd77402_pm_ops,
>  	},
>  	.probe  = rfd77402_probe,
> -	.remove = rfd77402_remove,
>  	.id_table = rfd77402_id,
>  };
>  

