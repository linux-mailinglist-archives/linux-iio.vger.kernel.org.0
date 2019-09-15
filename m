Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38657CC9C5
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 13:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfJEL7z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 07:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfJEL7z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:59:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA013222C9;
        Sat,  5 Oct 2019 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570276794;
        bh=TlZW1ecVKP/CrF6GCrvL686P4gNBWgF+dZ95S5E4HRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SbLT+5bEVfACESR0WAUO7a4k2bgxbUAl/vTajZvOcCyGak+Zdkj4cOR82LA39PL9M
         tAzoyZyZzqS/IZP9CcAE2Y7gKs8NZdoGxWGB67Yc3C6p0yThsyTPV/9V3N9RZro2bs
         DOwnr7XjHvbIdyDLEPk8cjlEbgNcNm8fS341+pkA=
Date:   Sun, 15 Sep 2019 14:09:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] iio: imu: inv_mpu6050: disable i2c mux for
 MPU925x
Message-ID: <20190915140936.17cf38fc@archlinux>
In-Reply-To: <20190912105804.15650-1-jmaneyrol@invensense.com>
References: <20190912105804.15650-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Sep 2019 10:58:24 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Disable i2c mux for supported 9xxx chips. This is a
> pre-requesite for controling 9xxx magnetometer using the
> i2c master of the chip.
> 
> Check in device-tree that there is no i2c-gate device declared
> for ensuring backward compatibility with existing setups.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

One trivial inline.

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  7 +--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 60 +++++++++++++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 +
>  3 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index b17f060b52fc..7b2e4d81bbba 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1156,9 +1156,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return result;
>  	}
>  
> -	if (inv_mpu_bus_setup)
> -		inv_mpu_bus_setup(indio_dev);
> -
>  	dev_set_drvdata(dev, indio_dev);
>  	indio_dev->dev.parent = dev;
>  	/* name will be NULL when enumerated via ACPI */
> @@ -1167,6 +1164,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	else
>  		indio_dev->name = dev_name(dev);
>  
> +	/* requires parent device set in indio_dev */
> +	if (inv_mpu_bus_setup)
> +		inv_mpu_bus_setup(indio_dev);
> +
>  	if (chip_type == INV_ICM20602) {
>  		indio_dev->channels = inv_icm20602_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(inv_icm20602_channels);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 4b8b5a87398c..389cc8505e0e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -68,6 +68,56 @@ static const char *inv_mpu_match_acpi_device(struct device *dev,
>  	return dev_name(dev);
>  }
>  
> +static bool inv_mpu_i2c_aux_bus(struct device *dev)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
> +
> +	switch (st->chip_type) {
> +	case INV_ICM20608:
> +	case INV_ICM20602:
> +		/* no i2c auxiliary bus on the chip */
> +		return false;
> +	case INV_MPU9250:
> +	case INV_MPU9255:

	return st->magn_disabled; ?

> +		if (st->magn_disabled)
> +			return true;
> +		else
> +			return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +/*
> + * MPU9xxx magnetometer support requires to disable i2c auxiliary bus support.
> + * To ensure backward compatibility with existing setups, do not disable
> + * i2c auxiliary bus if it used.
> + * Check for i2c-gate node in devicetree and set magnetometer disabled.
> + * Only MPU6500 is supported by ACPI, no need to check.
> + */
> +static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	struct device_node *mux_node;
> +
> +	switch (st->chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		mux_node = of_get_child_by_name(dev->of_node, "i2c-gate");
> +		if (mux_node != NULL) {
> +			st->magn_disabled = true;
> +			dev_warn(dev, "disable internal use of magnetometer\n");
> +		}
> +		of_node_put(mux_node);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   *  inv_mpu_probe() - probe function.
>   *  @client:          i2c client.
> @@ -112,17 +162,12 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	}
>  
>  	result = inv_mpu_core_probe(regmap, client->irq, name,
> -				    NULL, chip_type);
> +				    inv_mpu_magn_disable, chip_type);
>  	if (result < 0)
>  		return result;
>  
>  	st = iio_priv(dev_get_drvdata(&client->dev));
> -	switch (st->chip_type) {
> -	case INV_ICM20608:
> -	case INV_ICM20602:
> -		/* no i2c auxiliary bus on the chip */
> -		break;
> -	default:
> +	if (inv_mpu_i2c_aux_bus(&client->dev)) {
>  		/* declare i2c auxiliary bus */
>  		st->muxc = i2c_mux_alloc(client->adapter, &client->dev,
>  					 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
> @@ -137,7 +182,6 @@ static int inv_mpu_probe(struct i2c_client *client,
>  		result = inv_mpu_acpi_create_mux_client(client);
>  		if (result)
>  			goto out_del_mux;
> -		break;
>  	}
>  
>  	return 0;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index db1c6904388b..cbbb2fb8949a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -125,6 +125,7 @@ struct inv_mpu6050_hw {
>   *  @it_timestamp:	timestamp from previous interrupt.
>   *  @data_timestamp:	timestamp for next data sample.
>   *  @vddio_supply	voltage regulator for the chip.
> + *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
>   */
>  struct inv_mpu6050_state {
>  	struct mutex lock;
> @@ -146,6 +147,7 @@ struct inv_mpu6050_state {
>  	s64 it_timestamp;
>  	s64 data_timestamp;
>  	struct regulator *vddio_supply;
> +	bool magn_disabled;
>  };
>  
>  /*register and associated bit definition*/

