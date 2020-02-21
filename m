Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6E5167C3F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgBULez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgBULez (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 06:34:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCE8208C4;
        Fri, 21 Feb 2020 11:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582284894;
        bh=BvbaluHs8Au59w6UnFI4Jw6x6kFSUGyaXA6cG3C5KNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jK8aWxjSGza71nWsqgpMgQw+HgiZWNQAuV4ue4C54CmmTlNE0cEyVsOEOxaS2Qp+N
         7hhSMdGXMH9i1SpMgL7vSG0h02weEUIPYxw9KbkrjHZb35S/CgpU3CeWw8GNfOdCTE
         QVhIEtN0ij1YkiR8N3treywCrnetz+NjC6TkA/T8=
Date:   Fri, 21 Feb 2020 11:34:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/13] iio: imu: inv_mpu6050: fix data polling
 interface
Message-ID: <20200221113450.379fe556@archlinux>
In-Reply-To: <20200219143958.3548-10-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-10-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 15:39:54 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> When reading data with the polling interface, we need to wait
> at 1 sampling period to have a sample.
> For gyroscope and magnetometer, we need to wait for 2 periods
> before having a correct sample.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

I should have raised this before, but is this something we might want to
backport? I don't really want this whole cleanup series getting backported,
so is there a more minimal change for older kernels? (probably just sleep too
long in all cases!)

Applied,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 36 ++++++++++++++++++++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 21 -------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h |  3 ++
>  3 files changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index a51efc4c941b..aeee39696d3a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -563,9 +563,14 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  					 int *val)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	unsigned int freq_hz, period_us, min_sleep_us, max_sleep_us;
>  	int result;
>  	int ret;
>  
> +	/* compute sample period */
> +	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
> +	period_us = 1000000 / freq_hz;
> +
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
>  		return result;
> @@ -576,6 +581,10 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  				INV_MPU6050_SENSOR_GYRO);
>  		if (result)
>  			goto error_power_off;
> +		/* need to wait 2 periods to have first valid sample */
> +		min_sleep_us = 2 * period_us;
> +		max_sleep_us = 2 * (period_us + period_us / 2);
> +		usleep_range(min_sleep_us, max_sleep_us);
>  		ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
>  					      chan->channel2, val);
>  		result = inv_mpu6050_switch_engine(st, false,
> @@ -588,6 +597,10 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  				INV_MPU6050_SENSOR_ACCL);
>  		if (result)
>  			goto error_power_off;
> +		/* wait 1 period for first sample availability */
> +		min_sleep_us = period_us;
> +		max_sleep_us = period_us + period_us / 2;
> +		usleep_range(min_sleep_us, max_sleep_us);
>  		ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
>  					      chan->channel2, val);
>  		result = inv_mpu6050_switch_engine(st, false,
> @@ -600,8 +613,10 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  				INV_MPU6050_SENSOR_TEMP);
>  		if (result)
>  			goto error_power_off;
> -		/* wait for stablization */
> -		msleep(INV_MPU6050_TEMP_UP_TIME);
> +		/* wait 1 period for first sample availability */
> +		min_sleep_us = period_us;
> +		max_sleep_us = period_us + period_us / 2;
> +		usleep_range(min_sleep_us, max_sleep_us);
>  		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
>  					      IIO_MOD_X, val);
>  		result = inv_mpu6050_switch_engine(st, false,
> @@ -610,7 +625,24 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  			goto error_power_off;
>  		break;
>  	case IIO_MAGN:
> +		result = inv_mpu6050_switch_engine(st, true,
> +				INV_MPU6050_SENSOR_MAGN);
> +		if (result)
> +			goto error_power_off;
> +		/* frequency is limited for magnetometer */
> +		if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX) {
> +			freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
> +			period_us = 1000000 / freq_hz;
> +		}
> +		/* need to wait 2 periods to have first valid sample */
> +		min_sleep_us = 2 * period_us;
> +		max_sleep_us = 2 * (period_us + period_us / 2);
> +		usleep_range(min_sleep_us, max_sleep_us);
>  		ret = inv_mpu_magn_read(st, chan->channel2, val);
> +		result = inv_mpu6050_switch_engine(st, false,
> +				INV_MPU6050_SENSOR_MAGN);
> +		if (result)
> +			goto error_power_off;
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> index 3f402fa56d95..f282e9cc34c5 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -44,9 +44,6 @@
>  #define INV_MPU_MAGN_REG_ASAY		0x11
>  #define INV_MPU_MAGN_REG_ASAZ		0x12
>  
> -/* Magnetometer maximum frequency */
> -#define INV_MPU_MAGN_FREQ_HZ_MAX	50
> -
>  static bool inv_magn_supported(const struct inv_mpu6050_state *st)
>  {
>  	switch (st->chip_type) {
> @@ -321,7 +318,6 @@ int inv_mpu_magn_read(struct inv_mpu6050_state *st, int axis, int *val)
>  	unsigned int status;
>  	__be16 data;
>  	uint8_t addr;
> -	unsigned int freq_hz, period_ms;
>  	int ret;
>  
>  	/* quit if chip is not supported */
> @@ -344,23 +340,6 @@ int inv_mpu_magn_read(struct inv_mpu6050_state *st, int axis, int *val)
>  	}
>  	addr += INV_MPU6050_REG_EXT_SENS_DATA;
>  
> -	/* compute period depending on current sampling rate */
> -	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
> -	if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX)
> -		freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
> -	period_ms = 1000 / freq_hz;
> -
> -	ret = inv_mpu6050_switch_engine(st, true, INV_MPU6050_SENSOR_MAGN);
> -	if (ret)
> -		return ret;
> -
> -	/* need to wait 2 periods + half-period margin */
> -	msleep(period_ms * 2 + period_ms / 2);
> -
> -	ret = inv_mpu6050_switch_engine(st, false, INV_MPU6050_SENSOR_MAGN);
> -	if (ret)
> -		return ret;
> -
>  	/* check i2c status and read raw data */
>  	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
>  	if (ret)
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> index f7ad50ca6c1b..185c000c697c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> @@ -10,6 +10,9 @@
>  
>  #include "inv_mpu_iio.h"
>  
> +/* Magnetometer maximum frequency */
> +#define INV_MPU_MAGN_FREQ_HZ_MAX	50
> +
>  int inv_mpu_magn_probe(struct inv_mpu6050_state *st);
>  
>  /**

