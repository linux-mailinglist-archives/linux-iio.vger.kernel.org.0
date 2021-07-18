Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B13CC995
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhGROdM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 10:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhGROdM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 10:33:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A496100A;
        Sun, 18 Jul 2021 14:30:12 +0000 (UTC)
Date:   Sun, 18 Jul 2021 15:32:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tcs3414: convert probe to device-managed
 routines
Message-ID: <20210718153236.55e1b43a@jic23-huawei>
In-Reply-To: <20210624080534.9209-1-aardelean@deviqon.com>
References: <20210624080534.9209-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jun 2021 11:05:34 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the driver to use only device-managed init routines in
> the probe function of the driver.
> 
> This way, we no longer need the tcs3414_remove() hook.
> We still need to keep the i2c_set_clientdata() call, as that's being used
> for the PM routines.
> 
> And lastly, a devm_add_action_or_reset() hook is added to call the
> powerdown handler when the chip is uninitialized or the probe fails.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
Applied

> ---
>  drivers/iio/light/tcs3414.c | 48 +++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index 0593abd600ec..b87222141429 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -267,6 +267,18 @@ static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
>  	.predisable = tcs3414_buffer_predisable,
>  };
>  
> +static int tcs3414_powerdown(struct tcs3414_data *data)
> +{
> +	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
> +		data->control & ~(TCS3414_CONTROL_POWER |
> +		TCS3414_CONTROL_ADC_EN));
> +}
> +
> +static void tcs3414_powerdown_cleanup(void *data)
> +{
> +	tcs3414_powerdown(data);
> +}
> +
>  static int tcs3414_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> @@ -309,6 +321,11 @@ static int tcs3414_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&client->dev, tcs3414_powerdown_cleanup,
> +				       data);
> +	if (ret < 0)
> +		return ret;
> +
>  	data->timing = TCS3414_INTEG_12MS; /* free running */
>  	ret = i2c_smbus_write_byte_data(data->client, TCS3414_TIMING,
>  		data->timing);
> @@ -320,38 +337,12 @@ static int tcs3414_probe(struct i2c_client *client,
>  		return ret;
>  	data->gain = ret;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
>  		tcs3414_trigger_handler, &tcs3414_buffer_setup_ops);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto buffer_cleanup;
> -
> -	return 0;
> -
> -buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	return ret;
> -}
> -
> -static int tcs3414_powerdown(struct tcs3414_data *data)
> -{
> -	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
> -		data->control & ~(TCS3414_CONTROL_POWER |
> -		TCS3414_CONTROL_ADC_EN));
> -}
> -
> -static int tcs3414_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	tcs3414_powerdown(iio_priv(indio_dev));
> -
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -385,7 +376,6 @@ static struct i2c_driver tcs3414_driver = {
>  		.pm	= &tcs3414_pm_ops,
>  	},
>  	.probe		= tcs3414_probe,
> -	.remove		= tcs3414_remove,
>  	.id_table	= tcs3414_id,
>  };
>  module_i2c_driver(tcs3414_driver);

