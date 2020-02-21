Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB6167CD4
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBULyv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBULyv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 06:54:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7CD208C4;
        Fri, 21 Feb 2020 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582286089;
        bh=4x1JlcNSLGYZ7j7h+prbtR3vrM3Rv6CZYecZG4sZkT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IyD7pFaFgO9/oELit7jKoY3r75O/xQiTSDQeJOXtlto7y6NmCAu0NbZuzZMGp8K0a
         /85hVGMroQUKyXNbwqWCOiuM1qpXrIkgN9hFxGuoRpR00AA7Wxx43sEQHSy6TGO04n
         7MkI6D5ZQ6ATCoqwE/VMxneIBlcoShSeAQWiWWbU=
Date:   Fri, 21 Feb 2020 11:54:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
Message-ID: <20200221115445.6a535ead@archlinux>
In-Reply-To: <20200219143958.3548-13-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-13-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 15:39:57 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Use runtime power management for handling chip power and
> sensor engines on/off. Simplifies things a lot since pm
> runtime already has reference counter.
> Usage of autosuspend reduces the number of power on/off. This
> makes polling interface now usable to get data at low
> frequency.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Missing static marking after reducing scope of one function.
See inline. I've fixed that up and applied.

Thanks,


Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 267 ++++++++++++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   5 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  33 ++-
>  3 files changed, 194 insertions(+), 111 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 9076b6bb099c..750fbc2614f0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -16,6 +16,8 @@
>  #include <linux/acpi.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include "inv_mpu_iio.h"
>  #include "inv_mpu_magn.h"
>  
> @@ -400,26 +402,13 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  {
>  	int result;
>  
> -	if (power_on) {
> -		if (!st->powerup_count) {
> -			result = inv_mpu6050_pwr_mgmt_1_write(st, false, -1, -1);
> -			if (result)
> -				return result;
> -			usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> -				     INV_MPU6050_REG_UP_TIME_MAX);
> -		}
> -		st->powerup_count++;
> -	} else {
> -		if (st->powerup_count == 1) {
> -			result = inv_mpu6050_pwr_mgmt_1_write(st, true, -1, -1);
> -			if (result)
> -				return result;
> -		}
> -		st->powerup_count--;
> -	}
> +	result = inv_mpu6050_pwr_mgmt_1_write(st, !power_on, -1, -1);
> +	if (result)
> +		return result;
>  
> -	dev_dbg(regmap_get_device(st->map), "set power %d, count=%u\n",
> -		power_on, st->powerup_count);
> +	if (power_on)
> +		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> +			     INV_MPU6050_REG_UP_TIME_MAX);
>  
>  	return 0;
>  }
> @@ -563,6 +552,7 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  					 int *val)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
>  	unsigned int freq_hz, period_us, min_sleep_us, max_sleep_us;
>  	int result;
>  	int ret;
> @@ -571,92 +561,85 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
>  	period_us = 1000000 / freq_hz;
>  
> -	result = inv_mpu6050_set_power_itg(st, true);
> -	if (result)
> +	result = pm_runtime_get_sync(pdev);
> +	if (result < 0) {
> +		pm_runtime_put_noidle(pdev);
>  		return result;
> +	}
>  
>  	switch (chan->type) {
>  	case IIO_ANGL_VEL:
> -		result = inv_mpu6050_switch_engine(st, true,
> -				INV_MPU6050_SENSOR_GYRO);
> -		if (result)
> -			goto error_power_off;
> -		/* need to wait 2 periods to have first valid sample */
> -		min_sleep_us = 2 * period_us;
> -		max_sleep_us = 2 * (period_us + period_us / 2);
> -		usleep_range(min_sleep_us, max_sleep_us);
> +		if (!st->chip_config.gyro_en) {
> +			result = inv_mpu6050_switch_engine(st, true,
> +					INV_MPU6050_SENSOR_GYRO);
> +			if (result)
> +				goto error_power_off;
> +			/* need to wait 2 periods to have first valid sample */
> +			min_sleep_us = 2 * period_us;
> +			max_sleep_us = 2 * (period_us + period_us / 2);
> +			usleep_range(min_sleep_us, max_sleep_us);
> +		}
>  		ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
>  					      chan->channel2, val);
> -		result = inv_mpu6050_switch_engine(st, false,
> -				INV_MPU6050_SENSOR_GYRO);
> -		if (result)
> -			goto error_power_off;
>  		break;
>  	case IIO_ACCEL:
> -		result = inv_mpu6050_switch_engine(st, true,
> -				INV_MPU6050_SENSOR_ACCL);
> -		if (result)
> -			goto error_power_off;
> -		/* wait 1 period for first sample availability */
> -		min_sleep_us = period_us;
> -		max_sleep_us = period_us + period_us / 2;
> -		usleep_range(min_sleep_us, max_sleep_us);
> +		if (!st->chip_config.accl_en) {
> +			result = inv_mpu6050_switch_engine(st, true,
> +					INV_MPU6050_SENSOR_ACCL);
> +			if (result)
> +				goto error_power_off;
> +			/* wait 1 period for first sample availability */
> +			min_sleep_us = period_us;
> +			max_sleep_us = period_us + period_us / 2;
> +			usleep_range(min_sleep_us, max_sleep_us);
> +		}
>  		ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
>  					      chan->channel2, val);
> -		result = inv_mpu6050_switch_engine(st, false,
> -				INV_MPU6050_SENSOR_ACCL);
> -		if (result)
> -			goto error_power_off;
>  		break;
>  	case IIO_TEMP:
> -		result = inv_mpu6050_switch_engine(st, true,
> -				INV_MPU6050_SENSOR_TEMP);
> -		if (result)
> -			goto error_power_off;
> -		/* wait 1 period for first sample availability */
> -		min_sleep_us = period_us;
> -		max_sleep_us = period_us + period_us / 2;
> -		usleep_range(min_sleep_us, max_sleep_us);
> +		if (!st->chip_config.temp_en) {
> +			result = inv_mpu6050_switch_engine(st, true,
> +					INV_MPU6050_SENSOR_TEMP);
> +			if (result)
> +				goto error_power_off;
> +			/* wait 1 period for first sample availability */
> +			min_sleep_us = period_us;
> +			max_sleep_us = period_us + period_us / 2;
> +			usleep_range(min_sleep_us, max_sleep_us);
> +		}
>  		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
>  					      IIO_MOD_X, val);
> -		result = inv_mpu6050_switch_engine(st, false,
> -				INV_MPU6050_SENSOR_TEMP);
> -		if (result)
> -			goto error_power_off;
>  		break;
>  	case IIO_MAGN:
> -		result = inv_mpu6050_switch_engine(st, true,
> -				INV_MPU6050_SENSOR_MAGN);
> -		if (result)
> -			goto error_power_off;
> -		/* frequency is limited for magnetometer */
> -		if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX) {
> -			freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
> -			period_us = 1000000 / freq_hz;
> +		if (!st->chip_config.magn_en) {
> +			result = inv_mpu6050_switch_engine(st, true,
> +					INV_MPU6050_SENSOR_MAGN);
> +			if (result)
> +				goto error_power_off;
> +			/* frequency is limited for magnetometer */
> +			if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX) {
> +				freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
> +				period_us = 1000000 / freq_hz;
> +			}
> +			/* need to wait 2 periods to have first valid sample */
> +			min_sleep_us = 2 * period_us;
> +			max_sleep_us = 2 * (period_us + period_us / 2);
> +			usleep_range(min_sleep_us, max_sleep_us);
>  		}
> -		/* need to wait 2 periods to have first valid sample */
> -		min_sleep_us = 2 * period_us;
> -		max_sleep_us = 2 * (period_us + period_us / 2);
> -		usleep_range(min_sleep_us, max_sleep_us);
>  		ret = inv_mpu_magn_read(st, chan->channel2, val);
> -		result = inv_mpu6050_switch_engine(st, false,
> -				INV_MPU6050_SENSOR_MAGN);
> -		if (result)
> -			goto error_power_off;
>  		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
>  	}
>  
> -	result = inv_mpu6050_set_power_itg(st, false);
> -	if (result)
> -		goto error_power_off;
> +	pm_runtime_mark_last_busy(pdev);
> +	pm_runtime_put_autosuspend(pdev);
>  
>  	return ret;
>  
>  error_power_off:
> -	inv_mpu6050_set_power_itg(st, false);
> +	pm_runtime_put_autosuspend(pdev);
>  	return result;
>  }
>  
> @@ -795,6 +778,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  				 int val, int val2, long mask)
>  {
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
>  	int result;
>  
>  	/*
> @@ -806,9 +790,11 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  		return result;
>  
>  	mutex_lock(&st->lock);
> -	result = inv_mpu6050_set_power_itg(st, true);
> -	if (result)
> +	result = pm_runtime_get_sync(pdev);
> +	if (result < 0) {
> +		pm_runtime_put_noidle(pdev);
>  		goto error_write_raw_unlock;
> +	}
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -846,7 +832,8 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  		break;
>  	}
>  
> -	result |= inv_mpu6050_set_power_itg(st, false);
> +	pm_runtime_mark_last_busy(pdev);
> +	pm_runtime_put_autosuspend(pdev);
>  error_write_raw_unlock:
>  	mutex_unlock(&st->lock);
>  	iio_device_release_direct_mode(indio_dev);
> @@ -903,6 +890,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	int result;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
>  
>  	if (kstrtoint(buf, 10, &fifo_rate))
>  		return -EINVAL;
> @@ -920,9 +908,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  		result = 0;
>  		goto fifo_rate_fail_unlock;
>  	}
> -	result = inv_mpu6050_set_power_itg(st, true);
> -	if (result)
> +	result = pm_runtime_get_sync(pdev);
> +	if (result < 0) {
> +		pm_runtime_put_noidle(pdev);
>  		goto fifo_rate_fail_unlock;
> +	}
>  
>  	result = regmap_write(st->map, st->reg->sample_rate_div, d);
>  	if (result)
> @@ -938,8 +928,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	if (result)
>  		goto fifo_rate_fail_power_off;
>  
> +	pm_runtime_mark_last_busy(pdev);
>  fifo_rate_fail_power_off:
> -	result |= inv_mpu6050_set_power_itg(st, false);
> +	pm_runtime_put_autosuspend(pdev);
>  fifo_rate_fail_unlock:
>  	mutex_unlock(&st->lock);
>  	if (result)
> @@ -1385,6 +1376,14 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
>  	inv_mpu_core_disable_regulator_vddio(st);
>  }
>  
> +static void inv_mpu_pm_disable(void *data)
> +{
> +	struct device *dev = data;
> +
> +	pm_runtime_put_sync_suspend(dev);
> +	pm_runtime_disable(dev);
> +}
> +
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
>  {
> @@ -1409,7 +1408,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
>  	st->chip_type = chip_type;
> -	st->powerup_count = 0;
>  	st->irq = irq;
>  	st->map = regmap;
>  
> @@ -1521,8 +1519,16 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  			goto error_power_off;
>  	}
>  
> -	/* chip init is done, turning off */
> -	result = inv_mpu6050_set_power_itg(st, false);
> +	/* chip init is done, turning on runtime power management */
> +	result = pm_runtime_set_active(dev);
> +	if (result)
> +		goto error_power_off;
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put(dev);
> +	result = devm_add_action_or_reset(dev, inv_mpu_pm_disable, dev);
>  	if (result)
>  		return result;
>  
> @@ -1590,11 +1596,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  }
>  EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
>  
> -#ifdef CONFIG_PM_SLEEP
> -
> -static int inv_mpu_resume(struct device *dev)
> +static int __maybe_unused inv_mpu_resume(struct device *dev)
>  {
> -	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  	int result;
>  
>  	mutex_lock(&st->lock);
> @@ -1603,27 +1608,101 @@ static int inv_mpu_resume(struct device *dev)
>  		goto out_unlock;
>  
>  	result = inv_mpu6050_set_power_itg(st, true);
> +	if (result)
> +		goto out_unlock;
> +
> +	result = inv_mpu6050_switch_engine(st, true, st->suspended_sensors);
> +	if (result)
> +		goto out_unlock;
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		result = inv_mpu6050_prepare_fifo(st, true);
> +
>  out_unlock:
>  	mutex_unlock(&st->lock);
>  
>  	return result;
>  }
>  
> -static int inv_mpu_suspend(struct device *dev)
> +static int __maybe_unused inv_mpu_suspend(struct device *dev)
>  {
> -	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  	int result;
>  
>  	mutex_lock(&st->lock);
> +
> +	if (iio_buffer_enabled(indio_dev)) {
> +		result = inv_mpu6050_prepare_fifo(st, false);
> +		if (result)
> +			goto out_unlock;
> +	}
> +
> +	st->suspended_sensors = 0;
> +	if (st->chip_config.accl_en)
> +		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
> +	if (st->chip_config.gyro_en)
> +		st->suspended_sensors |= INV_MPU6050_SENSOR_GYRO;
> +	if (st->chip_config.temp_en)
> +		st->suspended_sensors |= INV_MPU6050_SENSOR_TEMP;
> +	if (st->chip_config.magn_en)
> +		st->suspended_sensors |= INV_MPU6050_SENSOR_MAGN;
> +	result = inv_mpu6050_switch_engine(st, false, st->suspended_sensors);
> +	if (result)
> +		goto out_unlock;
> +
>  	result = inv_mpu6050_set_power_itg(st, false);
> +	if (result)
> +		goto out_unlock;
> +
>  	inv_mpu_core_disable_regulator_vddio(st);
> +out_unlock:
>  	mutex_unlock(&st->lock);
>  
>  	return result;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
> -SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
> +static int __maybe_unused inv_mpu_runtime_suspend(struct device *dev)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
> +	unsigned int sensors;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	sensors = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO |
> +			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN;
> +	ret = inv_mpu6050_switch_engine(st, false, sensors);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = inv_mpu6050_set_power_itg(st, false);
> +	if (ret)
> +		goto out_unlock;
> +
> +	inv_mpu_core_disable_regulator_vddio(st);
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static int __maybe_unused inv_mpu_runtime_resume(struct device *dev)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	ret = inv_mpu_core_enable_regulator_vddio(st);
> +	if (ret)
> +		return ret;
> +
> +	return inv_mpu6050_set_power_itg(st, true);
> +}
> +
> +const struct dev_pm_ops inv_mpu_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(inv_mpu_suspend, inv_mpu_resume)
> +	SET_RUNTIME_PM_OPS(inv_mpu_runtime_suspend, inv_mpu_runtime_resume, NULL)
> +};
>  EXPORT_SYMBOL_GPL(inv_mpu_pmops);
>  
>  MODULE_AUTHOR("Invensense Corporation");
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index e328c98e362c..cd38b3fccc7b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -164,6 +164,7 @@ struct inv_mpu6050_hw {
>   *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
>   *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
>   *  @magn_orient:       magnetometer sensor chip orientation if available.
> + *  @suspended_sensors:	sensors mask of sensors turned off for suspend
>   */
>  struct inv_mpu6050_state {
>  	struct mutex lock;
> @@ -174,7 +175,6 @@ struct inv_mpu6050_state {
>  	enum   inv_devices chip_type;
>  	struct i2c_mux_core *muxc;
>  	struct i2c_client *mux_client;
> -	unsigned int powerup_count;
>  	struct inv_mpu6050_platform_data plat_data;
>  	struct iio_mount_matrix orientation;
>  	struct regmap *map;
> @@ -189,6 +189,7 @@ struct inv_mpu6050_state {
>  	bool magn_disabled;
>  	s32 magn_raw_to_gauss[3];
>  	struct iio_mount_matrix magn_orient;
> +	unsigned int suspended_sensors;
>  };
>  
>  /*register and associated bit definition*/
> @@ -312,6 +313,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_ACCEL_UP_TIME            20
>  #define INV_MPU6050_GYRO_UP_TIME             35
>  #define INV_MPU6050_GYRO_DOWN_TIME           150
> +#define INV_MPU6050_SUSPEND_DELAY_MS         2000
>  
>  /* delay time in microseconds */
>  #define INV_MPU6050_REG_UP_TIME_MIN          5000
> @@ -439,7 +441,6 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable);
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
>  			      unsigned int mask);
>  int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
> -int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
Having done this, function should be marked static in _core.c

I've done so.

>  int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
>  void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index f53f50d08b9e..f7b5a70be30f 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -3,6 +3,7 @@
>  * Copyright (C) 2012 Invensense, Inc.
>  */
>  
> +#include <linux/pm_runtime.h>
>  #include "inv_mpu_iio.h"
>  
>  static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
> @@ -156,41 +157,43 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
>  static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
>  	unsigned int scan;
>  	int result;
>  
> -	scan = inv_scan_query(indio_dev);
> -
>  	if (enable) {
> -		result = inv_mpu6050_set_power_itg(st, true);
> -		if (result)
> +		scan = inv_scan_query(indio_dev);
> +		result = pm_runtime_get_sync(pdev);
> +		if (result < 0) {
> +			pm_runtime_put_noidle(pdev);
>  			return result;
> +		}
> +		/*
> +		 * In case autosuspend didn't trigger, turn off first not
> +		 * required sensors.
> +		 */
> +		result = inv_mpu6050_switch_engine(st, false, ~scan);
> +		if (result)
> +			goto error_power_off;
>  		result = inv_mpu6050_switch_engine(st, true, scan);
>  		if (result)
>  			goto error_power_off;
>  		st->skip_samples = inv_compute_skip_samples(st);
>  		result = inv_mpu6050_prepare_fifo(st, true);
>  		if (result)
> -			goto error_sensors_off;
> +			goto error_power_off;
>  	} else {
>  		result = inv_mpu6050_prepare_fifo(st, false);
> -		if (result)
> -			goto error_sensors_off;
> -		result = inv_mpu6050_switch_engine(st, false, scan);
> -		if (result)
> -			goto error_power_off;
> -
> -		result = inv_mpu6050_set_power_itg(st, false);
>  		if (result)
>  			goto error_power_off;
> +		pm_runtime_mark_last_busy(pdev);
> +		pm_runtime_put_autosuspend(pdev);
>  	}
>  
>  	return 0;
>  
> -error_sensors_off:
> -	inv_mpu6050_switch_engine(st, false, scan);
>  error_power_off:
> -	inv_mpu6050_set_power_itg(st, false);
> +	pm_runtime_put_autosuspend(pdev);
>  	return result;
>  }
>  

poer
