Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C988415FF80
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgBORaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 12:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgBORaJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 12:30:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7915F2083B;
        Sat, 15 Feb 2020 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581787808;
        bh=lFwQimlpVgjgJUKpbtrih3gifr+TaZ4o1pKbwukC/y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+0XIObsubVROgGZggt55kQktRSnJ8iEYlY153HZccI5kfYTTxRdHEAcDV0CIkRTG
         4FqwXxGo5XtjUF0WXA6QPTDfYMqUBb3OZr9M0U5+CxVZZgUKB8VqC2pd6xREalYO9h
         FkR1n2FQ/cP8UwYmR8HOR9ykzgMFWetVMctXvsfU=
Date:   Sat, 15 Feb 2020 17:30:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 01/13] iio: imu: inv_mpu6050: enable i2c aux mux bypass
 only once
Message-ID: <20200215173004.7569c210@archlinux>
In-Reply-To: <20200212174048.1034-2-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
        <20200212174048.1034-2-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Feb 2020 18:40:36 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> i2c auxiliary mux is done by analog switches. You do not need to
> set them for every i2c transfer.
> Just set i2c bypass bit at init and do noting in i2c de/select.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Fair enough.  Given we are making the decision based on DT and that
can't change on reprobing etc so this change makes sense to me I think.

It does leave us making rather odd use of the mux code, so I'd
just like Peter to take a quick look at this before I apply it.

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 71 +++++++++--------------
>  1 file changed, 28 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 1363d3776523..24df880248f2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -20,38 +20,6 @@ static const struct regmap_config inv_mpu_regmap_config = {
>  
>  static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  {
> -	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
> -	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->lock);
> -
> -	ret = inv_mpu6050_set_power_itg(st, true);
> -	if (ret)
> -		goto error_unlock;
> -
> -	ret = regmap_write(st->map, st->reg->int_pin_cfg,
> -			   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
> -
> -error_unlock:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> -}
> -
> -static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
> -{
> -	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
> -	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->lock);
> -
> -	/* It doesn't really matter if any of the calls fail */
> -	regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
> -	inv_mpu6050_set_power_itg(st, false);
> -
> -	mutex_unlock(&st->lock);
> -
>  	return 0;
>  }
>  
> @@ -79,19 +47,20 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
>  	}
>  }
>  
> -/*
> - * MPU9xxx magnetometer support requires to disable i2c auxiliary bus support.
> - * To ensure backward compatibility with existing setups, do not disable
> - * i2c auxiliary bus if it used.
> - * Check for i2c-gate node in devicetree and set magnetometer disabled.
> - * Only MPU6500 is supported by ACPI, no need to check.
> - */
> -static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
> +static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
>  	struct device_node *mux_node;
> +	int ret;
>  
> +	/*
> +	 * MPU9xxx magnetometer support requires to disable i2c auxiliary bus.
> +	 * To ensure backward compatibility with existing setups, do not disable
> +	 * i2c auxiliary bus if it used.
> +	 * Check for i2c-gate node in devicetree and set magnetometer disabled.
> +	 * Only MPU6500 is supported by ACPI, no need to check.
> +	 */
>  	switch (st->chip_type) {
>  	case INV_MPU9150:
>  	case INV_MPU9250:
> @@ -107,7 +76,24 @@ static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
>  		break;
>  	}
>  
> +	/* enable i2c bypass when using i2c auxiliary bus */
> +	if (inv_mpu_i2c_aux_bus(dev)) {
> +		ret = inv_mpu6050_set_power_itg(st, true);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(st->map, st->reg->int_pin_cfg,
> +				   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
> +		if (ret)
> +			goto error;
> +		ret = inv_mpu6050_set_power_itg(st, false);
> +		if (ret)
> +			goto error;
> +	}
> +
>  	return 0;
> +error:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return ret;
>  }
>  
>  /**
> @@ -151,7 +137,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	}
>  
>  	result = inv_mpu_core_probe(regmap, client->irq, name,
> -				    inv_mpu_magn_disable, chip_type);
> +				    inv_mpu_i2c_aux_setup, chip_type);
>  	if (result < 0)
>  		return result;
>  
> @@ -160,8 +146,7 @@ static int inv_mpu_probe(struct i2c_client *client,
>  		/* declare i2c auxiliary bus */
>  		st->muxc = i2c_mux_alloc(client->adapter, &client->dev,
>  					 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
> -					 inv_mpu6050_select_bypass,
> -					 inv_mpu6050_deselect_bypass);
> +					 inv_mpu6050_select_bypass, NULL);
>  		if (!st->muxc)
>  			return -ENOMEM;
>  		st->muxc->priv = dev_get_drvdata(&client->dev);

