Return-Path: <linux-iio+bounces-10117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB949904B7
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87021F22CEA
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A433212F04;
	Fri,  4 Oct 2024 13:45:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3812101BF
	for <linux-iio@vger.kernel.org>; Fri,  4 Oct 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049558; cv=none; b=EuPWIKci//4jhCW/XGiwMyIw/PIeWcFu05ZrjyGLlAWzJJiI5jGfPrs6/W0nBWuY2/JE8AqDyHpAVIquVdUHEBxrccHWr9KaKGdJABkQoB3/LJdS1RDyDEjMcTzASPW+uTFX9WNEUKATQFvCsBUGd0bjwfOX+W0WpQXl+kqIPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049558; c=relaxed/simple;
	bh=o8GBdUIebl9kZpHDYST3Rtnqv7j7bSfJzvVlr6cJa/w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HghFk+w1oCOLrKtxrlPPKmmojzv4D4BLDX3Yh/jff9KgL7ZuD+Jns45mCoLpLBNBZGR0h5jotsCl/LWtk6CzKWkjBoXYb2UP6jvhBcXbC0d5n1moBV3+JUH++u5JxhNkDX7dbnJMPtBSNj+zzlEKZqKR1ud3/gON60l/aj6QcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XKqZ32vyWz6HJTY;
	Fri,  4 Oct 2024 21:45:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F2C881404A6;
	Fri,  4 Oct 2024 21:45:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Oct
 2024 15:45:50 +0200
Date: Fri, 4 Oct 2024 14:45:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 19/51] iio: Switch to __pm_runtime_put_autosuspend()
Message-ID: <20241004144549.00004913@Huawei.com>
In-Reply-To: <20241004094123.113674-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
	<20241004094123.113674-1-sakari.ailus@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri,  4 Oct 2024 12:41:23 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend() will soon be changed to include a call to
> pm_runtime_mark_last_busy(). This patch switches the current users to
> __pm_runtime_put_autosuspend() which will continue to have the
> functionality of old pm_runtime_put_autosuspend().

Similar to some of the other feedback you've had, there is no
obvious point in this churn.  Given mark_last_busy()
should be non destructive, just call it twice, then remove
the unnecessary calls after you have added on in autosuspend.

Jonathan

> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/iio/accel/bmc150-accel-core.c         |  2 +-
>  drivers/iio/accel/bmi088-accel-core.c         |  6 +++---
>  drivers/iio/accel/fxls8962af-core.c           |  2 +-
>  drivers/iio/accel/kxcjk-1013.c                |  2 +-
>  drivers/iio/accel/kxsd9.c                     |  6 +++---
>  drivers/iio/accel/mma8452.c                   |  2 +-
>  drivers/iio/accel/mma9551_core.c              |  2 +-
>  drivers/iio/accel/msa311.c                    | 12 +++++------
>  drivers/iio/adc/ab8500-gpadc.c                |  2 +-
>  drivers/iio/adc/at91-sama5d2_adc.c            | 20 +++++++++----------
>  drivers/iio/adc/rcar-gyroadc.c                |  2 +-
>  drivers/iio/adc/stm32-adc-core.c              |  2 +-
>  drivers/iio/adc/stm32-adc.c                   | 12 +++++------
>  drivers/iio/adc/sun4i-gpadc-iio.c             |  4 ++--
>  drivers/iio/adc/ti-ads1015.c                  |  2 +-
>  drivers/iio/adc/ti-ads1100.c                  |  2 +-
>  drivers/iio/adc/ti-ads1119.c                  |  4 ++--
>  drivers/iio/chemical/atlas-sensor.c           |  4 ++--
>  .../common/hid-sensors/hid-sensor-trigger.c   |  2 +-
>  drivers/iio/dac/stm32-dac.c                   |  6 +++---
>  drivers/iio/gyro/bmg160_core.c                |  2 +-
>  drivers/iio/gyro/fxas21002c_core.c            |  2 +-
>  drivers/iio/gyro/mpu3050-core.c               |  6 +++---
>  drivers/iio/gyro/mpu3050-i2c.c                |  2 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 10 +++++-----
>  .../imu/inv_icm42600/inv_icm42600_buffer.c    |  2 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 10 +++++-----
>  .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 14 ++++++-------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  4 ++--
>  drivers/iio/imu/kmx61.c                       |  2 +-
>  drivers/iio/light/apds9306.c                  |  6 +++---
>  drivers/iio/light/apds9960.c                  |  4 ++--
>  drivers/iio/light/bh1780.c                    |  2 +-
>  drivers/iio/light/gp2ap002.c                  |  4 ++--
>  drivers/iio/light/isl29028.c                  |  2 +-
>  drivers/iio/light/ltrf216a.c                  |  2 +-
>  drivers/iio/light/pa12203001.c                |  2 +-
>  drivers/iio/light/rpr0521.c                   |  2 +-
>  drivers/iio/light/tsl2583.c                   |  2 +-
>  drivers/iio/light/tsl2591.c                   |  4 ++--
>  drivers/iio/light/us5182d.c                   |  2 +-
>  drivers/iio/light/vcnl4000.c                  |  2 +-
>  drivers/iio/light/vcnl4035.c                  |  2 +-
>  drivers/iio/magnetometer/af8133j.c            |  4 ++--
>  drivers/iio/magnetometer/ak8974.c             |  4 ++--
>  drivers/iio/magnetometer/ak8975.c             |  2 +-
>  drivers/iio/magnetometer/bmc150_magn.c        |  2 +-
>  drivers/iio/magnetometer/tmag5273.c           |  4 ++--
>  drivers/iio/magnetometer/yamaha-yas530.c      |  4 ++--
>  drivers/iio/pressure/bmp280-core.c            | 10 +++++-----
>  drivers/iio/pressure/icp10100.c               |  2 +-
>  drivers/iio/pressure/mpl115.c                 |  4 ++--
>  drivers/iio/pressure/zpa2326.c                |  4 ++--
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c |  2 +-
>  drivers/iio/proximity/srf04.c                 |  2 +-
>  drivers/iio/temperature/mlx90614.c            |  4 ++--
>  drivers/iio/temperature/mlx90632.c            |  4 ++--
>  drivers/iio/temperature/mlx90635.c            |  4 ++--
>  59 files changed, 122 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 0f32c1e92b4d..da02727c8626 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -339,7 +339,7 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> +		ret = __pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	if (ret < 0) {
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index fc1c1613d673..f57960509c7f 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -375,7 +375,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>  
>  out_read_raw_pm_put:
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -419,7 +419,7 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>  
>  		ret = bmi088_accel_set_scale(data, val, val2);
>  		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> +		__pm_runtime_put_autosuspend(dev);
>  		return ret;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = pm_runtime_resume_and_get(dev);
> @@ -428,7 +428,7 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>  
>  		ret = bmi088_accel_set_sample_freq(data, val);
>  		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> +		__pm_runtime_put_autosuspend(dev);
>  		return ret;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 37f33c29fb4b..50e1b2575af0 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -219,7 +219,7 @@ static int fxls8962af_power_off(struct fxls8962af_data *data)
>  	int ret;
>  
>  	pm_runtime_mark_last_busy(dev);
> -	ret = pm_runtime_put_autosuspend(dev);
> +	ret = __pm_runtime_put_autosuspend(dev);
>  	if (ret)
>  		dev_err(dev, "failed to power off\n");
>  
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index b76df8816323..01c6bc9b0f99 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -625,7 +625,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> +		ret = __pm_runtime_put_autosuspend(&data->client->dev);
>  	}
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 70dfd6e354db..41dcf80784f1 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -151,7 +151,7 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
>  	}
>  
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  
>  	return ret;
>  }
> @@ -199,7 +199,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  
>  error_ret:
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  
>  	return ret;
>  };
> @@ -251,7 +251,7 @@ static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 62e6369e2269..17786868855b 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -227,7 +227,7 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
>  		ret = pm_runtime_resume_and_get(&client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&client->dev);
> -		ret = pm_runtime_put_autosuspend(&client->dev);
> +		ret = __pm_runtime_put_autosuspend(&client->dev);
>  	}
>  
>  	if (ret < 0) {
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index b898f865fb87..d97cac6cc4da 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -673,7 +673,7 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
>  		ret = pm_runtime_resume_and_get(&client->dev);
>  	else {
>  		pm_runtime_mark_last_busy(&client->dev);
> -		ret = pm_runtime_put_autosuspend(&client->dev);
> +		ret = __pm_runtime_put_autosuspend(&client->dev);
>  	}
>  
>  	if (ret < 0) {
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index 57025354c7cd..21ec55dc1c5a 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -608,7 +608,7 @@ static int msa311_read_raw_data(struct iio_dev *indio_dev,
>  	iio_device_release_direct_mode(indio_dev);
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	if (err) {
>  		dev_err(dev, "can't get axis %s (%pe)\n",
> @@ -740,7 +740,7 @@ static int msa311_write_scale(struct iio_dev *indio_dev, int val, int val2)
>  		}
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	if (err)
>  		dev_err(dev, "can't update scale (%pe)\n", ERR_PTR(err));
> @@ -781,7 +781,7 @@ static int msa311_write_samp_freq(struct iio_dev *indio_dev, int val, int val2)
>  	iio_device_release_direct_mode(indio_dev);
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	if (err)
>  		dev_err(dev, "can't update frequency (%pe)\n", ERR_PTR(err));
> @@ -830,7 +830,7 @@ static int msa311_debugfs_reg_access(struct iio_dev *indio_dev,
>  	mutex_unlock(&msa311->lock);
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	if (err)
>  		dev_err(dev, "can't %s register %u from debugfs (%pe)\n",
> @@ -853,7 +853,7 @@ static int msa311_buffer_postdisable(struct iio_dev *indio_dev)
>  	struct device *dev = msa311->dev;
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  }
> @@ -1231,7 +1231,7 @@ static int msa311_probe(struct i2c_client *i2c)
>  		return err;
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	err = devm_iio_device_register(dev, indio_dev);
>  	if (err)
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
> index 59f66e9cb0e8..f2d1b06bac44 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -608,7 +608,7 @@ static int ab8500_gpadc_read(struct ab8500_gpadc *gpadc,
>  
>  	/* This eventually drops the regulator */
>  	pm_runtime_mark_last_busy(gpadc->dev);
> -	pm_runtime_put_autosuspend(gpadc->dev);
> +	__pm_runtime_put_autosuspend(gpadc->dev);
>  
>  	return (high_data << 8) | low_data;
>  
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index d7fd21e7c6e2..628e6e3c667c 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -893,7 +893,7 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
>  	at91_adc_writel(st, EMR, emr);
>  
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  
>  	st->oversampling_ratio = oversampling_ratio;
>  
> @@ -968,7 +968,7 @@ static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
>  		at91_adc_writel(st, TSMR, 0);
>  
>  		pm_runtime_mark_last_busy(st->dev);
> -		pm_runtime_put_autosuspend(st->dev);
> +		__pm_runtime_put_autosuspend(st->dev);
>  		return 0;
>  	}
>  	/*
> @@ -1140,7 +1140,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  
>  	if (!state) {
>  		pm_runtime_mark_last_busy(st->dev);
> -		pm_runtime_put_autosuspend(st->dev);
> +		__pm_runtime_put_autosuspend(st->dev);
>  	}
>  
>  	return 0;
> @@ -1333,7 +1333,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
>  
>  pm_runtime_put:
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  	return ret;
>  }
>  
> @@ -1391,7 +1391,7 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
>  		dmaengine_terminate_sync(st->dma_st.dma_chan);
>  
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  
>  	return 0;
>  }
> @@ -1600,7 +1600,7 @@ static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq,
>  	at91_adc_writel(st, MR, mr);
>  
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  
>  	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u, tracktim=%u\n",
>  		freq, startup, prescal, tracktim);
> @@ -1806,7 +1806,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
>  
>  pm_runtime_put:
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  	return ret;
>  }
>  
> @@ -1899,7 +1899,7 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
>  	/* Revert previous settings. */
>  	at91_adc_temp_sensor_configure(st, false);
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  unlock:
>  	mutex_unlock(&st->lock);
>  	iio_device_release_direct_mode(indio_dev);
> @@ -2467,7 +2467,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		 readl_relaxed(st->base + st->soc_info.platform->layout->VERSION));
>  
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  
>  	return 0;
>  
> @@ -2569,7 +2569,7 @@ static int at91_adc_resume(struct device *dev)
>  	}
>  
>  	pm_runtime_mark_last_busy(st->dev);
> -	pm_runtime_put_autosuspend(st->dev);
> +	__pm_runtime_put_autosuspend(st->dev);
>  
>  	return 0;
>  
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index 15a21d2860e7..d2a4557a5c07 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -167,7 +167,7 @@ static int rcar_gyroadc_set_power(struct rcar_gyroadc *priv, bool on)
>  		return pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		return pm_runtime_put_autosuspend(dev);
> +		return __pm_runtime_put_autosuspend(dev);
>  	}
>  }
>  
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 616dd729666a..a67e972bcc5d 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -798,7 +798,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 32ca26ed59f7..50c3651413d2 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1456,7 +1456,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  	stm32_adc_conv_irq_disable(adc);
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -1623,7 +1623,7 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
>  
>  	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -1672,7 +1672,7 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
>  		*readval = stm32_adc_readl(adc, reg);
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  }
> @@ -1816,7 +1816,7 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	stm32_adc_set_trig(indio_dev, NULL);
>  err_pm_put:
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -1839,7 +1839,7 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  		dev_err(&indio_dev->dev, "Can't clear trigger\n");
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  }
> @@ -2473,7 +2473,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		stm32_adc_debugfs_init(indio_dev);
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 00a3a4db0fe0..43746e026042 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -248,7 +248,7 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
>  	pm_runtime_mark_last_busy(indio_dev->dev.parent);
>  
>  err:
> -	pm_runtime_put_autosuspend(indio_dev->dev.parent);
> +	__pm_runtime_put_autosuspend(indio_dev->dev.parent);
>  	disable_irq(irq);
>  	mutex_unlock(&info->mutex);
>  
> @@ -273,7 +273,7 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
>  		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
>  
>  		pm_runtime_mark_last_busy(indio_dev->dev.parent);
> -		pm_runtime_put_autosuspend(indio_dev->dev.parent);
> +		__pm_runtime_put_autosuspend(indio_dev->dev.parent);
>  
>  		return 0;
>  	}
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 052d2124b215..380aeabc8a72 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -377,7 +377,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> +		ret = __pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	return ret < 0 ? ret : 0;
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index 1e46f07a9ca6..038901c93b7d 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -105,7 +105,7 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>  	ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
>  
>  	pm_runtime_mark_last_busy(&data->client->dev);
> -	pm_runtime_put_autosuspend(&data->client->dev);
> +	__pm_runtime_put_autosuspend(&data->client->dev);
>  
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index 1c7606375149..52e20c4ed8bb 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -292,7 +292,7 @@ static int ads1119_single_conversion(struct ads1119_state *st,
>  	ret = IIO_VAL_INT;
>  pdown:
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  	return ret;
>  }
>  
> @@ -466,7 +466,7 @@ static int ads1119_triggered_buffer_postdisable(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index baf93e5e3ca7..d0ab2656919e 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -427,7 +427,7 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	pm_runtime_mark_last_busy(&data->client->dev);
> -	ret = pm_runtime_put_autosuspend(&data->client->dev);
> +	ret = __pm_runtime_put_autosuspend(&data->client->dev);
>  	if (ret)
>  		return ret;
>  
> @@ -492,7 +492,7 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
>  	ret = regmap_bulk_read(data->regmap, reg, val, sizeof(*val));
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index ad8910e6ad59..e6bf7eb4e23c 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -165,7 +165,7 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  		atomic_dec(&st->user_requested_state);
>  		pm_runtime_mark_last_busy(&st->pdev->dev);
>  		pm_runtime_use_autosuspend(&st->pdev->dev);
> -		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
> +		ret = __pm_runtime_put_autosuspend(&st->pdev->dev);
>  	}
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index 5a722f307e7e..8dadf90546b4 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -97,7 +97,7 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  
>  	if (!enable) {
>  		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> +		__pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	return 0;
> @@ -105,7 +105,7 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  err_put_pm:
>  	if (enable) {
>  		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> +		__pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	return ret;
> @@ -350,7 +350,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  		goto err_pm_put;
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 10728d5ccae3..97f3045dc2a9 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -314,7 +314,7 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
>  		ret = pm_runtime_get_sync(dev);
>  	else {
>  		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> +		ret = __pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	if (ret < 0) {
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index 688966129f70..f6263187f6c7 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -375,7 +375,7 @@ static int  fxas21002c_pm_put(struct fxas21002c_data *data)
>  
>  	pm_runtime_mark_last_busy(dev);
>  
> -	return pm_runtime_put_autosuspend(dev);
> +	return __pm_runtime_put_autosuspend(dev);
>  }
>  
>  static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index b6883e8b2a8b..93d9d0e4626b 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -371,7 +371,7 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
>  out_read_raw_unlock:
>  	mutex_unlock(&mpu3050->lock);
>  	pm_runtime_mark_last_busy(mpu3050->dev);
> -	pm_runtime_put_autosuspend(mpu3050->dev);
> +	__pm_runtime_put_autosuspend(mpu3050->dev);
>  
>  	return ret;
>  }
> @@ -663,7 +663,7 @@ static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)
>  	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>  
>  	pm_runtime_mark_last_busy(mpu3050->dev);
> -	pm_runtime_put_autosuspend(mpu3050->dev);
> +	__pm_runtime_put_autosuspend(mpu3050->dev);
>  
>  	return 0;
>  }
> @@ -977,7 +977,7 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
>  			dev_err(mpu3050->dev, "error resetting FIFO\n");
>  
>  		pm_runtime_mark_last_busy(mpu3050->dev);
> -		pm_runtime_put_autosuspend(mpu3050->dev);
> +		__pm_runtime_put_autosuspend(mpu3050->dev);
>  		mpu3050->hw_irq_trigger = false;
>  
>  		return 0;
> diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
> index 29ecfa6fd633..49256fc6c6ad 100644
> --- a/drivers/iio/gyro/mpu3050-i2c.c
> +++ b/drivers/iio/gyro/mpu3050-i2c.c
> @@ -28,7 +28,7 @@ static int mpu3050_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)
>  	struct mpu3050 *mpu3050 = i2c_mux_priv(mux);
>  
>  	pm_runtime_mark_last_busy(mpu3050->dev);
> -	pm_runtime_put_autosuspend(mpu3050->dev);
> +	__pm_runtime_put_autosuspend(mpu3050->dev);
>  	return 0;
>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 56ac19814250..4e43deadf02f 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -292,7 +292,7 @@ static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
>  exit:
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  	return ret;
>  }
>  
> @@ -370,7 +370,7 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -474,7 +474,7 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
>  out_unlock:
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -526,7 +526,7 @@ static int inv_icm42600_accel_read_offset(struct inv_icm42600_state *st,
>  
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  	if (ret)
>  		return ret;
>  
> @@ -664,7 +664,7 @@ static int inv_icm42600_accel_write_offset(struct inv_icm42600_state *st,
>  out_unlock:
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  	return ret;
>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index aae7c56481a3..acc141657d3f 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -440,7 +440,7 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
>  		msleep(sleep);
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> index 938af5b640b0..3784b1719433 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> @@ -188,7 +188,7 @@ static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
>  exit:
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  	return ret;
>  }
>  
> @@ -287,7 +287,7 @@ static int inv_icm42600_gyro_write_scale(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -382,7 +382,7 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
>  out_unlock:
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -434,7 +434,7 @@ static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
>  
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  	if (ret)
>  		return ret;
>  
> @@ -571,7 +571,7 @@ static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
>  out_unlock:
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  	return ret;
>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> index 213cce1c3111..4c2f2d6dfff9 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> @@ -38,7 +38,7 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, int16_t *temp)
>  exit:
>  	mutex_unlock(&st->lock);
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index fdb48c5e5686..8fb35f37e5d2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -708,12 +708,12 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  	}
>  
>  	pm_runtime_mark_last_busy(pdev);
> -	pm_runtime_put_autosuspend(pdev);
> +	__pm_runtime_put_autosuspend(pdev);
>  
>  	return ret;
>  
>  error_power_off:
> -	pm_runtime_put_autosuspend(pdev);
> +	__pm_runtime_put_autosuspend(pdev);
>  	return result;
>  }
>  
> @@ -913,7 +913,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  	}
>  
>  	pm_runtime_mark_last_busy(pdev);
> -	pm_runtime_put_autosuspend(pdev);
> +	__pm_runtime_put_autosuspend(pdev);
>  error_write_raw_unlock:
>  	mutex_unlock(&st->lock);
>  	iio_device_release_direct_mode(indio_dev);
> @@ -1121,14 +1121,14 @@ static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool en)
>  		}
>  
>  		pm_runtime_mark_last_busy(pdev);
> -		pm_runtime_put_autosuspend(pdev);
> +		__pm_runtime_put_autosuspend(pdev);
>  	}
>  
>  	return result;
>  
>  error_suspend:
>  	pm_runtime_mark_last_busy(pdev);
> -	pm_runtime_put_autosuspend(pdev);
> +	__pm_runtime_put_autosuspend(pdev);
>  	return result;
>  }
>  
> @@ -1227,7 +1227,7 @@ static int inv_mpu6050_write_event_value(struct iio_dev *indio_dev,
>  	result = inv_mpu6050_set_wom_threshold(st, value, INV_MPU6050_FREQ_DIVIDER(st));
>  
>  	pm_runtime_mark_last_busy(pdev);
> -	pm_runtime_put_autosuspend(pdev);
> +	__pm_runtime_put_autosuspend(pdev);
>  
>  	return result;
>  }
> @@ -1336,7 +1336,7 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  
>  	pm_runtime_mark_last_busy(pdev);
>  fifo_rate_fail_power_off:
> -	pm_runtime_put_autosuspend(pdev);
> +	__pm_runtime_put_autosuspend(pdev);
>  fifo_rate_fail_unlock:
>  	mutex_unlock(&st->lock);
>  	if (result)
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 3bfeabab0ec4..e501ac9276d4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -196,13 +196,13 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  		if (result)
>  			goto error_power_off;
>  		pm_runtime_mark_last_busy(pdev);
> -		pm_runtime_put_autosuspend(pdev);
> +		__pm_runtime_put_autosuspend(pdev);
>  	}
>  
>  	return 0;
>  
>  error_power_off:
> -	pm_runtime_put_autosuspend(pdev);
> +	__pm_runtime_put_autosuspend(pdev);
>  	return result;
>  }
>  
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index c61c012e25bb..75942b0b95d7 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -753,7 +753,7 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> +		ret = __pm_runtime_put_autosuspend(&data->client->dev);
>  	}
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 079e02be1005..ade25e461397 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -538,7 +538,7 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
>  	*val = get_unaligned_le24(&buff);
>  
>  	pm_runtime_mark_last_busy(data->dev);
> -	pm_runtime_put_autosuspend(data->dev);
> +	__pm_runtime_put_autosuspend(data->dev);
>  
>  	return 0;
>  }
> @@ -1119,7 +1119,7 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
>  				return ret;
>  
>  			pm_runtime_mark_last_busy(data->dev);
> -			pm_runtime_put_autosuspend(data->dev);
> +			__pm_runtime_put_autosuspend(data->dev);
>  
>  			return 0;
>  		}
> @@ -1315,7 +1315,7 @@ static int apds9306_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed iio device registration\n");
>  
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 3c14e4c30805..13db160be094 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -497,7 +497,7 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
>  				     APDS9960_MAX_INT_TIME_IN_US);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> +		ret = __pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	mutex_unlock(&data->lock);
> @@ -910,7 +910,7 @@ static int apds9960_buffer_predisable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	pm_runtime_put_autosuspend(&data->client->dev);
> +	__pm_runtime_put_autosuspend(&data->client->dev);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
> index 475f44954f61..d22bf5f684b1 100644
> --- a/drivers/iio/light/bh1780.c
> +++ b/drivers/iio/light/bh1780.c
> @@ -112,7 +112,7 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
>  			if (value < 0)
>  				return value;
>  			pm_runtime_mark_last_busy(&bh1780->client->dev);
> -			pm_runtime_put_autosuspend(&bh1780->client->dev);
> +			__pm_runtime_put_autosuspend(&bh1780->client->dev);
>  			*val = value;
>  
>  			return IIO_VAL_INT;
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index f8b1d7dd6f5f..aeaba841dbb4 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -272,7 +272,7 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
>  
>  out:
>  	pm_runtime_mark_last_busy(gp2ap002->dev);
> -	pm_runtime_put_autosuspend(gp2ap002->dev);
> +	__pm_runtime_put_autosuspend(gp2ap002->dev);
>  
>  	return ret;
>  }
> @@ -354,7 +354,7 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
>  		gp2ap002->enabled = true;
>  	} else {
>  		pm_runtime_mark_last_busy(gp2ap002->dev);
> -		pm_runtime_put_autosuspend(gp2ap002->dev);
> +		__pm_runtime_put_autosuspend(gp2ap002->dev);
>  		gp2ap002->enabled = false;
>  	}
>  
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 95bfb3ffa519..63b6fdda25ed 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -342,7 +342,7 @@ static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> +		ret = __pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	return ret;
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index 37eecff571b9..228f03c7f192 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -209,7 +209,7 @@ static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
>  		}
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> +		__pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	return ret;
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index b920bf82c102..38313e712e65 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -190,7 +190,7 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
>  
>  	} else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> +		ret = __pm_runtime_put_autosuspend(&data->client->dev);
>  	}
>  
>  	return ret;
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 78c08e0bd077..2010b6387be7 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -363,7 +363,7 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> +		ret = __pm_runtime_put_autosuspend(&data->client->dev);
>  	}
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 02ad11611b9c..d41fd79e724c 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -647,7 +647,7 @@ static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
>  		ret = pm_runtime_resume_and_get(&chip->client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&chip->client->dev);
> -		ret = pm_runtime_put_autosuspend(&chip->client->dev);
> +		ret = __pm_runtime_put_autosuspend(&chip->client->dev);
>  	}
>  
>  	return ret;
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index 850c2465992f..43adaffe1400 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c
> @@ -773,7 +773,7 @@ static int tsl2591_read_raw(struct iio_dev *indio_dev,
>  	mutex_unlock(&chip->als_mutex);
>  
>  	pm_runtime_mark_last_busy(&client->dev);
> -	pm_runtime_put_autosuspend(&client->dev);
> +	__pm_runtime_put_autosuspend(&client->dev);
>  
>  	return ret;
>  }
> @@ -996,7 +996,7 @@ static int tsl2591_write_event_config(struct iio_dev *indio_dev,
>  	} else if (!state && chip->events_enabled) {
>  		chip->events_enabled = false;
>  		pm_runtime_mark_last_busy(&client->dev);
> -		pm_runtime_put_autosuspend(&client->dev);
> +		__pm_runtime_put_autosuspend(&client->dev);
>  	}
>  
>  	return 0;
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index de6967ac3b0b..901288236d38 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -370,7 +370,7 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
> -		ret = pm_runtime_put_autosuspend(&data->client->dev);
> +		ret = __pm_runtime_put_autosuspend(&data->client->dev);
>  	}
>  
>  	return ret;
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 4e3641ff2ed4..2877880897e4 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -582,7 +582,7 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> +		ret = __pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	return ret;
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 337a1332c2c6..a7393255f6ac 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -150,7 +150,7 @@ static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> +		ret = __pm_runtime_put_autosuspend(dev);
>  	}
>  
>  	return ret;
> diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
> index d81d89af6283..f0530854698d 100644
> --- a/drivers/iio/magnetometer/af8133j.c
> +++ b/drivers/iio/magnetometer/af8133j.c
> @@ -235,7 +235,7 @@ static int af8133j_read_measurement(struct af8133j_data *data, __le16 buf[3])
>  
>  out_rpm_put:
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	return ret;
>  }
> @@ -454,7 +454,7 @@ static int af8133j_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	indio_dev->info = &af8133j_info;
>  	indio_dev->name = "af8133j";
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index 8306a18706ac..eed25cd701f0 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -584,7 +584,7 @@ static int ak8974_measure_channel(struct ak8974 *ak8974, unsigned long address,
>  out_unlock:
>  	mutex_unlock(&ak8974->lock);
>  	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
> -	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
> +	__pm_runtime_put_autosuspend(&ak8974->i2c->dev);
>  
>  	return ret;
>  }
> @@ -679,7 +679,7 @@ static void ak8974_fill_buffer(struct iio_dev *indio_dev)
>   out_unlock:
>  	mutex_unlock(&ak8974->lock);
>  	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
> -	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
> +	__pm_runtime_put_autosuspend(&ak8974->i2c->dev);
>  }
>  
>  static irqreturn_t ak8974_handle_trigger(int irq, void *p)
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 18077fb463a9..b637385f9d26 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -776,7 +776,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  	mutex_unlock(&data->lock);
>  
>  	pm_runtime_mark_last_busy(&data->client->dev);
> -	pm_runtime_put_autosuspend(&data->client->dev);
> +	__pm_runtime_put_autosuspend(&data->client->dev);
>  
>  	/* Swap bytes and convert to valid range. */
>  	buff = le16_to_cpu(rval);
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 06d5a1ef1fbd..26dc68e4270d 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -268,7 +268,7 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
>  		ret = pm_runtime_resume_and_get(data->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(data->dev);
> -		ret = pm_runtime_put_autosuspend(data->dev);
> +		ret = __pm_runtime_put_autosuspend(data->dev);
>  	}
>  
>  	if (ret < 0) {
> diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
> index 4187abe12784..bec579b7c6c6 100644
> --- a/drivers/iio/magnetometer/tmag5273.c
> +++ b/drivers/iio/magnetometer/tmag5273.c
> @@ -296,7 +296,7 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
>  		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle, &magnitude);
>  
>  		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> +		__pm_runtime_put_autosuspend(data->dev);
>  
>  		if (ret)
>  			return ret;
> @@ -669,7 +669,7 @@ static int tmag5273_probe(struct i2c_client *i2c)
>  	indio_dev->num_channels = ARRAY_SIZE(tmag5273_channels);
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put_autosuspend(dev);
> +	__pm_runtime_put_autosuspend(dev);
>  
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 65011a8598d3..62df8b91df3a 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -623,7 +623,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
>  		pm_runtime_get_sync(yas5xx->dev);
>  		ret = ci->get_measure(yas5xx, &t, &x, &y, &z);
>  		pm_runtime_mark_last_busy(yas5xx->dev);
> -		pm_runtime_put_autosuspend(yas5xx->dev);
> +		__pm_runtime_put_autosuspend(yas5xx->dev);
>  		if (ret)
>  			return ret;
>  		switch (chan->address) {
> @@ -664,7 +664,7 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
>  	pm_runtime_get_sync(yas5xx->dev);
>  	ret = ci->get_measure(yas5xx, &t, &x, &y, &z);
>  	pm_runtime_mark_last_busy(yas5xx->dev);
> -	pm_runtime_put_autosuspend(yas5xx->dev);
> +	__pm_runtime_put_autosuspend(yas5xx->dev);
>  	if (ret) {
>  		dev_err(yas5xx->dev, "error refilling buffer\n");
>  		return;
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index ca4915c9a394..806933baeffd 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -729,7 +729,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	pm_runtime_get_sync(data->dev);
>  	ret = bmp280_read_raw_impl(indio_dev, chan, val, val2, mask);
>  	pm_runtime_mark_last_busy(data->dev);
> -	pm_runtime_put_autosuspend(data->dev);
> +	__pm_runtime_put_autosuspend(data->dev);
>  
>  	return ret;
>  }
> @@ -904,7 +904,7 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
>  	pm_runtime_get_sync(data->dev);
>  	ret = bmp280_write_raw_impl(indio_dev, chan, val, val2, mask);
>  	pm_runtime_mark_last_busy(data->dev);
> -	pm_runtime_put_autosuspend(data->dev);
> +	__pm_runtime_put_autosuspend(data->dev);
>  
>  	return ret;
>  }
> @@ -1960,7 +1960,7 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
>  	pm_runtime_get_sync(data->dev);
>  	ret = bmp580_nvmem_read_impl(priv, offset, val, bytes);
>  	pm_runtime_mark_last_busy(data->dev);
> -	pm_runtime_put_autosuspend(data->dev);
> +	__pm_runtime_put_autosuspend(data->dev);
>  
>  	return ret;
>  }
> @@ -2035,7 +2035,7 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
>  	pm_runtime_get_sync(data->dev);
>  	ret = bmp580_nvmem_write_impl(priv, offset, val, bytes);
>  	pm_runtime_mark_last_busy(data->dev);
> -	pm_runtime_put_autosuspend(data->dev);
> +	__pm_runtime_put_autosuspend(data->dev);
>  
>  	return ret;
>  }
> @@ -2641,7 +2641,7 @@ static int bmp280_buffer_postdisable(struct iio_dev *indio_dev)
>  	struct bmp280_data *data = iio_priv(indio_dev);
>  
>  	pm_runtime_mark_last_busy(data->dev);
> -	pm_runtime_put_autosuspend(data->dev);
> +	__pm_runtime_put_autosuspend(data->dev);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
> index 3e0bf5d31ad7..866381bb1452 100644
> --- a/drivers/iio/pressure/icp10100.c
> +++ b/drivers/iio/pressure/icp10100.c
> @@ -267,7 +267,7 @@ static int icp10100_get_measures(struct icp10100_state *st,
>  
>  	pm_runtime_mark_last_busy(&st->client->dev);
>  error_measure:
> -	pm_runtime_put_autosuspend(&st->client->dev);
> +	__pm_runtime_put_autosuspend(&st->client->dev);
>  	return ret;
>  }
>  
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 02ea38c8a3e4..70b711b16e52 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -109,7 +109,7 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> +		__pm_runtime_put_autosuspend(data->dev);
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_RAW:
> @@ -119,7 +119,7 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> +		__pm_runtime_put_autosuspend(data->dev);
>  		*val = ret >> 6;
>  
>  		return IIO_VAL_INT;
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 950f8dee2b26..7274855d0297 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -698,7 +698,7 @@ static void zpa2326_suspend(struct iio_dev *indio_dev)
>  	zpa2326_sleep(indio_dev);
>  
>  	pm_runtime_mark_last_busy(parent);
> -	pm_runtime_put_autosuspend(parent);
> +	__pm_runtime_put_autosuspend(parent);
>  }
>  
>  static void zpa2326_init_runtime(struct device *parent)
> @@ -709,7 +709,7 @@ static void zpa2326_init_runtime(struct device *parent)
>  	pm_runtime_set_autosuspend_delay(parent, 1000);
>  	pm_runtime_use_autosuspend(parent);
>  	pm_runtime_mark_last_busy(parent);
> -	pm_runtime_put_autosuspend(parent);
> +	__pm_runtime_put_autosuspend(parent);
>  }
>  
>  static void zpa2326_fini_runtime(struct device *parent)
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 5c959730aecd..6be27497d6e3 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -192,7 +192,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>  		ret = -EIO;
>  	}
>  	pm_runtime_mark_last_busy(&client->dev);
> -	pm_runtime_put_autosuspend(&client->dev);
> +	__pm_runtime_put_autosuspend(&client->dev);
>  
>  	return ret;
>  }
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 86c57672fc7e..ecea2671ce62 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -119,7 +119,7 @@ static int srf04_read(struct srf04_data *data)
>  
>  	if (data->gpiod_power) {
>  		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> +		__pm_runtime_put_autosuspend(data->dev);
>  	}
>  
>  	/* it should not take more than 20 ms until echo is rising */
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 740018d4b3df..22bed79589d1 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -212,7 +212,7 @@ static int mlx90614_power_get(struct mlx90614_data *data, bool startup)
>  		if (time_before(now, data->ready_timestamp) &&
>  		    msleep_interruptible(jiffies_to_msecs(
>  				data->ready_timestamp - now)) != 0) {
> -			pm_runtime_put_autosuspend(&data->client->dev);
> +			__pm_runtime_put_autosuspend(&data->client->dev);
>  			return -EINTR;
>  		}
>  	}
> @@ -226,7 +226,7 @@ static void mlx90614_power_put(struct mlx90614_data *data)
>  		return;
>  
>  	pm_runtime_mark_last_busy(&data->client->dev);
> -	pm_runtime_put_autosuspend(&data->client->dev);
> +	__pm_runtime_put_autosuspend(&data->client->dev);
>  }
>  #else
>  static inline int mlx90614_power_get(struct mlx90614_data *data, bool startup)
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index ae4ea587e7f9..c8cea6a4f390 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -1044,7 +1044,7 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>  
>  mlx90632_read_raw_pm:
>  	pm_runtime_mark_last_busy(&data->client->dev);
> -	pm_runtime_put_autosuspend(&data->client->dev);
> +	__pm_runtime_put_autosuspend(&data->client->dev);
>  	return ret;
>  }
>  
> @@ -1273,7 +1273,7 @@ static int mlx90632_probe(struct i2c_client *client)
>  
>  	pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_put_autosuspend(&client->dev);
> +	__pm_runtime_put_autosuspend(&client->dev);
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> index f7f88498ba0e..77ea81aa5c9e 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -750,7 +750,7 @@ static int mlx90635_read_raw(struct iio_dev *indio_dev,
>  
>  mlx90635_read_raw_pm:
>  	pm_runtime_mark_last_busy(&data->client->dev);
> -	pm_runtime_put_autosuspend(&data->client->dev);
> +	__pm_runtime_put_autosuspend(&data->client->dev);
>  	return ret;
>  }
>  
> @@ -1023,7 +1023,7 @@ static int mlx90635_probe(struct i2c_client *client)
>  
>  	pm_runtime_set_autosuspend_delay(&client->dev, MLX90635_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_put_autosuspend(&client->dev);
> +	__pm_runtime_put_autosuspend(&client->dev);
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }


