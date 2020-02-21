Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648BE167C48
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgBULhm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBULhl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 06:37:41 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B8F222C4;
        Fri, 21 Feb 2020 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285060;
        bh=j60MImPhlIwqp7wQlGWKPEoCLAET1Tc2ZfIluIZ1U9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sbI+AqvkdpPNlGd3kZoEZzSUqssrxNq5uxlIoTDGlAdSGQ77JXaqZi/7bK5BcTpsK
         pu9KRbIiG197AvcMOGA9dVTgIi9FVHWgGscSeVu4wmLSSUc/iDa2iqfPgNGy0g7ofX
         7MiBvw4JVrFFof+z4HDWVCSBmTsy/TjGZHdinhMc=
Date:   Fri, 21 Feb 2020 11:37:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 10/13] iio: imu: inv_mpu6050: factorize fifo
 enable/disable
Message-ID: <20200221113737.3b32ae06@archlinux>
In-Reply-To: <20200219143958.3548-11-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-11-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 15:39:55 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Rework fifo enable/disable in a separate function.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 54 ++-------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 66 ++++++++++++++-----
>  3 files changed, 55 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index a578789c9210..e328c98e362c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -435,7 +435,7 @@ enum inv_mpu6050_clock_sel_e {
>  
>  irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
>  int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
> -int inv_reset_fifo(struct iio_dev *indio_dev);
> +int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable);
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
>  			      unsigned int mask);
>  int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index d7397705974e..9511e4715e2c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -90,60 +90,14 @@ static s64 inv_mpu6050_get_timestamp(struct inv_mpu6050_state *st)
>  	return ts;
>  }
>  
> -int inv_reset_fifo(struct iio_dev *indio_dev)
> +static int inv_reset_fifo(struct iio_dev *indio_dev)
>  {
>  	int result;
> -	u8 d;
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>  
> -	/* reset it timestamp validation */
> -	st->it_timestamp = 0;
> -
> -	/* disable interrupt */
> -	result = regmap_write(st->map, st->reg->int_enable, 0);
> -	if (result) {
> -		dev_err(regmap_get_device(st->map), "int_enable failed %d\n",
> -			result);
> -		return result;
> -	}
> -	/* disable the sensor output to FIFO */
> -	result = regmap_write(st->map, st->reg->fifo_en, 0);
> -	if (result)
> -		goto reset_fifo_fail;
> -	/* disable fifo reading */
> -	result = regmap_write(st->map, st->reg->user_ctrl,
> -			      st->chip_config.user_ctrl);
> -	if (result)
> -		goto reset_fifo_fail;
> -
> -	/* reset FIFO*/
> -	d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
> -	result = regmap_write(st->map, st->reg->user_ctrl, d);
> -	if (result)
> -		goto reset_fifo_fail;
> -
> -	/* enable interrupt */
> -	result = regmap_write(st->map, st->reg->int_enable,
> -			      INV_MPU6050_BIT_DATA_RDY_EN);
> -	if (result)
> -		return result;
> -
> -	/* enable FIFO reading */
> -	d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_EN;
> -	result = regmap_write(st->map, st->reg->user_ctrl, d);
> -	if (result)
> -		goto reset_fifo_fail;
> -	/* enable sensor output to FIFO */
> -	d = 0;
> -	if (st->chip_config.gyro_fifo_enable)
> -		d |= INV_MPU6050_BITS_GYRO_OUT;
> -	if (st->chip_config.accl_fifo_enable)
> -		d |= INV_MPU6050_BIT_ACCEL_OUT;
> -	if (st->chip_config.temp_fifo_enable)
> -		d |= INV_MPU6050_BIT_TEMP_OUT;
> -	if (st->chip_config.magn_fifo_enable)
> -		d |= INV_MPU6050_BIT_SLAVE_0;
> -	result = regmap_write(st->map, st->reg->fifo_en, d);
> +	/* disable fifo and reenable it */
> +	inv_mpu6050_prepare_fifo(st, false);
> +	result = inv_mpu6050_prepare_fifo(st, true);
>  	if (result)
>  		goto reset_fifo_fail;
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index cfd7243159f6..f53f50d08b9e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -100,6 +100,54 @@ static unsigned int inv_compute_skip_samples(const struct inv_mpu6050_state *st)
>  	return skip_samples;
>  }
>  
> +int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
> +{
> +	uint8_t d;
> +	int ret;
> +
> +	if (enable) {
> +		st->it_timestamp = 0;
> +		/* reset FIFO */
> +		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
> +		ret = regmap_write(st->map, st->reg->user_ctrl, d);
> +		if (ret)
> +			return ret;
> +		/* enable sensor output to FIFO */
> +		d = 0;
> +		if (st->chip_config.gyro_fifo_enable)
> +			d |= INV_MPU6050_BITS_GYRO_OUT;
> +		if (st->chip_config.accl_fifo_enable)
> +			d |= INV_MPU6050_BIT_ACCEL_OUT;
> +		if (st->chip_config.temp_fifo_enable)
> +			d |= INV_MPU6050_BIT_TEMP_OUT;
> +		if (st->chip_config.magn_fifo_enable)
> +			d |= INV_MPU6050_BIT_SLAVE_0;
> +		ret = regmap_write(st->map, st->reg->fifo_en, d);
> +		if (ret)
> +			return ret;
> +		/* enable FIFO reading */
> +		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_EN;
> +		ret = regmap_write(st->map, st->reg->user_ctrl, d);
> +		if (ret)
> +			return ret;
> +		/* enable interrupt */
> +		ret = regmap_write(st->map, st->reg->int_enable,
> +				   INV_MPU6050_BIT_DATA_RDY_EN);
> +	} else {
> +		ret = regmap_write(st->map, st->reg->int_enable, 0);
> +		if (ret)
> +			return ret;
> +		ret = regmap_write(st->map, st->reg->fifo_en, 0);
> +		if (ret)
> +			return ret;
> +		/* restore user_ctrl for disabling FIFO reading */
> +		ret = regmap_write(st->map, st->reg->user_ctrl,
> +				   st->chip_config.user_ctrl);
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   *  inv_mpu6050_set_enable() - enable chip functions.
>   *  @indio_dev:	Device driver instance.
> @@ -121,24 +169,13 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  		if (result)
>  			goto error_power_off;
>  		st->skip_samples = inv_compute_skip_samples(st);
> -		result = inv_reset_fifo(indio_dev);
> +		result = inv_mpu6050_prepare_fifo(st, true);
>  		if (result)
>  			goto error_sensors_off;
>  	} else {
> -		result = regmap_write(st->map, st->reg->fifo_en, 0);
> -		if (result)
> -			goto error_fifo_off;
> -
> -		result = regmap_write(st->map, st->reg->int_enable, 0);
> -		if (result)
> -			goto error_fifo_off;
> -
> -		/* restore user_ctrl for disabling FIFO reading */
> -		result = regmap_write(st->map, st->reg->user_ctrl,
> -				      st->chip_config.user_ctrl);
> +		result = inv_mpu6050_prepare_fifo(st, false);
>  		if (result)
>  			goto error_sensors_off;
> -
>  		result = inv_mpu6050_switch_engine(st, false, scan);
>  		if (result)
>  			goto error_power_off;
> @@ -150,9 +187,6 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  
>  	return 0;
>  
> -error_fifo_off:
> -	/* always restore user_ctrl to disable fifo properly */
> -	regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
>  error_sensors_off:
>  	inv_mpu6050_switch_engine(st, false, scan);
>  error_power_off:

