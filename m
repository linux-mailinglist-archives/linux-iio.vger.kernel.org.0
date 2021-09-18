Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19650410800
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhIRSGU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 14:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238237AbhIRSGU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 14:06:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8154461100;
        Sat, 18 Sep 2021 18:04:55 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:08:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: max44000: use device-managed functions in
 probe
Message-ID: <20210918190834.66d6fbce@jic23-huawei>
In-Reply-To: <20210913120002.306280-1-aardelean@deviqon.com>
References: <20210913120002.306280-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 15:00:02 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This is a simple conversion. Both iio_device_register() and
> iio_triggered_buffer_setup() functions have device-managed variants.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Applied to the togreg branch of iio.git and pushed out as testing
as per normal.

Thanks,

Jonathan

> ---
>  drivers/iio/light/max44000.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index b8e721bced5b..85689dffbcbf 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -540,7 +540,6 @@ static int max44000_probe(struct i2c_client *client,
>  		return PTR_ERR(data->regmap);
>  	}
>  
> -	i2c_set_clientdata(client, indio_dev);
>  	mutex_init(&data->lock);
>  	indio_dev->info = &max44000_info;
>  	indio_dev->name = MAX44000_DRV_NAME;
> @@ -589,23 +588,14 @@ static int max44000_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL, max44000_trigger_handler, NULL);
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +					      max44000_trigger_handler, NULL);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "iio triggered buffer setup failed\n");
>  		return ret;
>  	}
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int max44000_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct i2c_device_id max44000_id[] = {
> @@ -628,7 +618,6 @@ static struct i2c_driver max44000_driver = {
>  		.acpi_match_table = ACPI_PTR(max44000_acpi_match),
>  	},
>  	.probe		= max44000_probe,
> -	.remove		= max44000_remove,
>  	.id_table	= max44000_id,
>  };
>  

