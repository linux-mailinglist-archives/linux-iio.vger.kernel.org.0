Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4F541DE6B
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348592AbhI3QK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 12:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348015AbhI3QK0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 12:10:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597CB61353;
        Thu, 30 Sep 2021 16:08:42 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:12:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1363: convert probe to full device-managed
Message-ID: <20210930171237.4b8d36c7@jic23-huawei>
In-Reply-To: <20210926162110.3536436-1-aardelean@deviqon.com>
References: <20210926162110.3536436-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Sep 2021 19:21:10 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> For this conversion, the 2 regulators (being enabled) require each a
> devm_add_action_or_reset() hook registration.
> 
> For the other functions, there are device-managed variants.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Thanks - one of my few drivers so no need for me to poke anyone else on this one :)

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to work it's magic.

Jonathan

> ---
>  drivers/iio/adc/max1363.c | 82 ++++++++++++++-------------------------
>  1 file changed, 30 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index f2b576c69949..eef55ed4814a 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1577,6 +1577,11 @@ static const struct of_device_id max1363_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, max1363_of_match);
>  
> +static void max1363_reg_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
>  static int max1363_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1590,7 +1595,8 @@ static int max1363_probe(struct i2c_client *client,
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
> +	ret = devm_iio_map_array_register(&client->dev, indio_dev,
> +					  client->dev.platform_data);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1598,17 +1604,16 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	mutex_init(&st->lock);
>  	st->reg = devm_regulator_get(&client->dev, "vcc");
> -	if (IS_ERR(st->reg)) {
> -		ret = PTR_ERR(st->reg);
> -		goto error_unregister_map;
> -	}
> +	if (IS_ERR(st->reg))
> +		return PTR_ERR(st->reg);
>  
>  	ret = regulator_enable(st->reg);
>  	if (ret)
> -		goto error_unregister_map;
> +		return ret;
>  
> -	/* this is only used for device removal purposes */
> -	i2c_set_clientdata(client, indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev, max1363_reg_disable, st->reg);
> +	if (ret)
> +		return ret;
>  
>  	st->chip_info = device_get_match_data(&client->dev);
>  	if (!st->chip_info)
> @@ -1622,13 +1627,17 @@ static int max1363_probe(struct i2c_client *client,
>  
>  		ret = regulator_enable(vref);
>  		if (ret)
> -			goto error_disable_reg;
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&client->dev, max1363_reg_disable, vref);
> +		if (ret)
> +			return ret;
> +
>  		st->vref = vref;
>  		vref_uv = regulator_get_voltage(vref);
> -		if (vref_uv <= 0) {
> -			ret = -EINVAL;
> -			goto error_disable_reg;
> -		}
> +		if (vref_uv <= 0)
> +			return -EINVAL;
> +
>  		st->vref_uv = vref_uv;
>  	}
>  
> @@ -1640,13 +1649,12 @@ static int max1363_probe(struct i2c_client *client,
>  		st->send = max1363_smbus_send;
>  		st->recv = max1363_smbus_recv;
>  	} else {
> -		ret = -EOPNOTSUPP;
> -		goto error_disable_reg;
> +		return -EOPNOTSUPP;
>  	}
>  
>  	ret = max1363_alloc_scan_masks(indio_dev);
>  	if (ret)
> -		goto error_disable_reg;
> +		return ret;
>  
>  	indio_dev->name = id->name;
>  	indio_dev->channels = st->chip_info->channels;
> @@ -1655,12 +1663,12 @@ static int max1363_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	ret = max1363_initial_setup(st);
>  	if (ret < 0)
> -		goto error_disable_reg;
> +		return ret;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -		&max1363_trigger_handler, NULL);
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +					      &max1363_trigger_handler, NULL);
>  	if (ret)
> -		goto error_disable_reg;
> +		return ret;
>  
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(&client->dev, st->client->irq,
> @@ -1671,39 +1679,10 @@ static int max1363_probe(struct i2c_client *client,
>  					   indio_dev);
>  
>  		if (ret)
> -			goto error_uninit_buffer;
> +			return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto error_uninit_buffer;
> -
> -	return 0;
> -
> -error_uninit_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -error_disable_reg:
> -	if (st->vref)
> -		regulator_disable(st->vref);
> -	regulator_disable(st->reg);
> -error_unregister_map:
> -	iio_map_array_unregister(indio_dev);
> -	return ret;
> -}
> -
> -static int max1363_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct max1363_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	if (st->vref)
> -		regulator_disable(st->vref);
> -	regulator_disable(st->reg);
> -	iio_map_array_unregister(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct i2c_device_id max1363_id[] = {
> @@ -1756,7 +1735,6 @@ static struct i2c_driver max1363_driver = {
>  		.of_match_table = max1363_of_match,
>  	},
>  	.probe = max1363_probe,
> -	.remove = max1363_remove,
>  	.id_table = max1363_id,
>  };
>  module_i2c_driver(max1363_driver);

