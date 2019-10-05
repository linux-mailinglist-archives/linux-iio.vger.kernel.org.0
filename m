Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F2CCC97C
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 12:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJEK54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 06:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJEK54 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 06:57:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AA72133F;
        Sat,  5 Oct 2019 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570273074;
        bh=Zp4+5/huVSv7Bo2LCL7NzS3UvtkmsfpfUBYKvbFy1xA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p0+CTmc1UyIByJ8FC8i88Hk/YXCICLdXDlpaaKO14oM7jsMnTbLAAhWaO9+Dp4V5y
         vvxcd/t6vrucF7XI6opTqbfiOO58HCazDJxztDtsdPud1KF3dk/p69djMl33XctOy3
         o74uXSj7sMyzaksFsbqnxA2J+kRnlC+aPaeQ9CVE=
Date:   Sat, 5 Oct 2019 11:57:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] iio: imu: inv_mpu6050: disable i2c mux for
 MPU925x
Message-ID: <20191005115750.5ba997ce@archlinux>
In-Reply-To: <20190916094128.30122-2-jmaneyrol@invensense.com>
References: <20190916094128.30122-1-jmaneyrol@invensense.com>
        <20190916094128.30122-2-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 09:41:58 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Disable i2c mux for supported 9xxx chips. This is a
> pre-requesite for controling 9xxx magnetometer using the
> i2c master of the chip.
> 
> Check in device-tree that there is no i2c-gate device declared
> for ensuring backward compatibility with existing setups.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

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

