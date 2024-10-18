Return-Path: <linux-iio+bounces-10744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4667B9A45C1
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00526285D26
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CDE2038DF;
	Fri, 18 Oct 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yuk1t5Be"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D1168488;
	Fri, 18 Oct 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275704; cv=none; b=quFz0EmdpKWjfNy+bHVvE+lnZFxaA3VjgAEgWWdn2SiXEZCcG1TF9ezivGEojBgvdFsxIxSQiJjM8k8F+ECNtZtXCNU421Hk6Ifn2mhk8iTmz3HaCiczyvQQeLg1X2/EUSqBKSklilxCSZEIxOnDnvFBrsttjyr/0p9OPYeg+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275704; c=relaxed/simple;
	bh=gl39e5XMiuaV3vjNzR8IeZRB7zmMZrSilDNVwY2LOPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXhoitF3V8elFuIznhcuPccVtIoUlJObRAVJbs7tVDhM8POmdQ1jYd3TcsVlpZ462+77I0l1Vzu7/lh7JiDw5hg0k1ftzZxZlojbQaBN5Ual3InPa5fPbAFTFRJifg8Sc0mi1E/KoEJTc9qCT881SPyHAlofBiZBHJzrHErZdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yuk1t5Be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83391C4CEC3;
	Fri, 18 Oct 2024 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729275703;
	bh=gl39e5XMiuaV3vjNzR8IeZRB7zmMZrSilDNVwY2LOPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yuk1t5BeqLkIrfS2tfLuGyIJLggpv0Pt+Yb7ob0URwIkKgPta6iNyAhJ5Xh076KZU
	 j5CZcELZHHmvpm3y3imr5mwr8Nu+eEYv4yNI8S81INem+l5cpJqHt/U2y+HtbAwgeA
	 nqDjLBsYTdDY5REnR8Rgh7Ly781hy8w4LCutvKRhAwqGLlv7xBnfmKbgzapkCmUugk
	 6ovVXTMLcoiyJhIUzXYiVyA3jpxiE5U2pRyz06OLDIgICPCc7cgSf6o5dsZm+T6FZu
	 Y7xyqPFTwQAgtvcB6gX4PTqlz20ucTLGD6XhSNRFdX/dEibEnEJcwvjLSDpLRXvjX1
	 pgub1GelUc6EA==
Date: Fri, 18 Oct 2024 19:21:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: jmaneyrol@invensense.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality
Message-ID: <20241018192137.0ff44c23@jic23-huawei>
In-Reply-To: <20241015092035.10482-1-hardevsinh.palaniya@siliconsignals.io>
References: <20241015092035.10482-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 14:50:03 +0530
Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io> wrote:

> Enables pedometer functionality in the ICM42605 IMU sensor.
> 
> The pedometer feature allows for step counting, which is accessible through
> a new sysfs entry. Interrupts are triggered when a step event occurs, enabling
> step event detection.
> 
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Some additional comments from a quick read.

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  16 ++
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 165 ++++++++++++++++++
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  36 +++-
>  3 files changed, 211 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index 3a07e43e4cf1..c3471b73152e 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -122,6 +122,7 @@ struct inv_icm42600_sensor_conf {
>  	int filter;
>  };
>  #define INV_ICM42600_SENSOR_CONF_INIT		{-1, -1, -1, -1}
> +#define INV_ICM42600_SENSOR_CONF_APEX		{ 2, 0, 9, 6}
>  
>  struct inv_icm42600_conf {
>  	struct inv_icm42600_sensor_conf gyro;
> @@ -141,6 +142,8 @@ struct inv_icm42600_suspended {
>   *  @chip:		chip identifier.
>   *  @name:		chip name.
>   *  @map:		regmap pointer.
> + *  @pedometer_enable	status of pedometer function
> + *  @pedometer_value	status of steps event occurnce
Check the kernel-doc style.  Even better run the script over the
files you are touching.

You are missing : here.

>   *  @vdd_supply:	VDD voltage regulator for the chip.
>   *  @vddio_supply:	I/O voltage regulator for the chip.
>   *  @orientation:	sensor chip orientation relative to main hardware.
> @@ -157,6 +160,8 @@ struct inv_icm42600_state {
>  	enum inv_icm42600_chip chip;
>  	const char *name;
>  	struct regmap *map;
> +	bool pedometer_enable;
> +	bool pedometer_value;
>  	struct regulator *vdd_supply;
>  	struct regulator *vddio_supply;
>  	struct iio_mount_matrix orientation;
> @@ -301,6 +306,15 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(_f)	\
>  		FIELD_PREP(GENMASK(3, 0), (_f))
>  
> +/* Pedometer functionality */
> +#define INV_ICM42600_REG_APEX_CONFIG0                  0x0056
> +#define INV_ICM42600_DMP_ODR_50Hz                      BIT(1)
> +#define INV_ICM42600_PED_ENABLE                        BIT(5)
> +#define INV_ICM42600_REG_INT_STATUS3                   0x0038
> +#define INV_ICM42600_STEP_DET_INT                      BIT(5)
> +#define INV_ICM42600_REG_APEX_DATA                     0x0031 // 2 Byte little-endian

/* */ for comments in IIO (and most of the kernel)
Also, put it on the line above rather than making such a long line.
> +
one blank line is enough.
> +
>  #define INV_ICM42600_REG_TMST_CONFIG			0x0054
>  #define INV_ICM42600_TMST_CONFIG_MASK			GENMASK(4, 0)
>  #define INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN	BIT(4)
> @@ -373,6 +387,8 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN		BIT(0)
>  
>  /* User bank 4 (MSB 0x40) */
> +#define INV_ICM42600_REG_INT_SOURCE6                    0x404D
> +#define INV_ICM42600_STEP_DET_INT1_EN              	BIT(5)
>  #define INV_ICM42600_REG_INT_SOURCE8			0x404F
>  #define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN		BIT(5)
>  #define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN		BIT(4)
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 56ac19814250..90fe4c9e15ab 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -160,6 +160,13 @@ static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
>  	{},
>  };

> +static int inv_icm42600_steps_read_raw(struct iio_dev *indio_dev,
> +                               struct iio_chan_spec const *chan,
> +                               int *val, int *val2, long mask)
> +{
> +       struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +       __le16 steps;
> +       int ret;
> +
> +       if (mask == IIO_CHAN_INFO_PROCESSED) {
> +               ret = iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +               ret = regmap_bulk_read(st->map, INV_ICM42600_REG_APEX_DATA, &steps, sizeof(steps));
> +               if (ret)
> +                       return ret;
> +               iio_device_release_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +               *val = steps;
As the bot pointed out, you need an endian conversion here.
le16_to_cpu()

> +               return IIO_VAL_INT;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
>  				       struct iio_chan_spec const *chan,
>  				       int *val, int *val2, long mask)
> @@ -681,6 +721,8 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_TEMP:
>  		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2, mask);
> +	case IIO_STEPS:
> +		return inv_icm42600_steps_read_raw(indio_dev, chan, val, val2, mask);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -824,6 +866,126 @@ static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +/*****************Pedometer Functionality**************/

No to structure comments like this. They add little to readability and have
a habit of rapidly becoming wrong.

> +static int inv_icm42600_step_en(struct inv_icm42600_state *st, int state)
> +{
> +	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_APEX;
> +	int ret, value;
> +
> +	if (state) {
> +
> +		ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0,
> +		                        INV_ICM42600_DMP_ODR_50Hz);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
> +		                        INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET);
> +		if (ret)
> +			return ret;
> +		msleep(1);
Document the reason for this value.

> +
> +		ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
> +		                        INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->map, INV_ICM42600_REG_INT_SOURCE6,
> +		                        INV_ICM42600_STEP_DET_INT1_EN);
> +		if (ret)
> +			return ret;
> +
> +		value = INV_ICM42600_DMP_ODR_50Hz | INV_ICM42600_PED_ENABLE;
> +		ret = regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0, value);
> +		if (ret)
> +			return ret;
> +
> +		st->pedometer_enable = true;
	return here.
Then can drop the else.

With two such different paths, even better would be two little functions
to handle the two operations (enable + disable) as will make each individually
easier to read.
> +
> +	} else {
> +
> +		ret = regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0, 0);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->map, INV_ICM42600_REG_INT_SOURCE6, 0);
> +		if (ret)
> +			return ret;
> +
> +		st->pedometer_enable = false;
> +	 }
> +
> +	return 0;
> +}
> +
> +static int inv_icm42600_write_event_config(struct iio_dev *indio_dev,
> +                                     const struct iio_chan_spec *chan,
> +                                     enum iio_event_type type,
> +                                     enum iio_event_direction dir, int state)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	if(chan->type != IIO_STEPS)
> +	        return -EINVAL;
> +
> +	mutex_lock(&st->lock);

guard() is useful in cases like this.

> +
> +	ret = inv_icm42600_step_en(st, state);
> +
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static int inv_icm42600_read_event_config(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	int value;
> +
> +	if (chan->type != IIO_STEPS)
> +	        return -EINVAL;
> +
> +	regmap_read(st->map, INV_ICM42600_REG_APEX_CONFIG0, &value);
check return value.

> +
> +	if (value & INV_ICM42600_PED_ENABLE)
> +	        return 1;
> +	else
> +	        return 0;
> +}
> +
> +static int inv_icm42600_read_event_value(struct iio_dev *indio_dev,
This isn't to get if the event happened, it's for reading thresholds
etc. Not relevant for a pedometer.

> +                                   const struct iio_chan_spec *chan,
> +                                   enum iio_event_type type,
> +                                   enum iio_event_direction dir,
> +                                   enum iio_event_info info,
> +                                   int *val, int *val2)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +
> +	mutex_lock(&st->lock);
guard()

> +
> +	if (type == IIO_EV_TYPE_CHANGE) {

flip logic and can test that before taking the lock

> +		if (st->pedometer_value == true) {
> +			*val = 1;
> +		        st->pedometer_value = false;
> +		} else {
> +		        *val = 0;
> +		}
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +	}
> +
> +	mutex_unlock(&st->lock);
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info inv_icm42600_accel_info = {
>  	.read_raw = inv_icm42600_accel_read_raw,
>  	.read_avail = inv_icm42600_accel_read_avail,
> @@ -833,6 +995,9 @@ static const struct iio_info inv_icm42600_accel_info = {
>  	.update_scan_mode = inv_icm42600_accel_update_scan_mode,
>  	.hwfifo_set_watermark = inv_icm42600_accel_hwfifo_set_watermark,
>  	.hwfifo_flush_to_buffer = inv_icm42600_accel_hwfifo_flush,
> +	.write_event_config = inv_icm42600_write_event_config,
> +	.read_event_config  = inv_icm42600_read_event_config,
> +	.read_event_value   = inv_icm42600_read_event_value,
>  };
>  
>  struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index c3924cc6190e..4d78cb5ca396 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -15,7 +15,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> -
Keep the blank line and keep the iio headers in their own section.

> +#include <linux/iio/events.h>
> +#include <linux/of_irq.h>
hmm. Can we not use the generic property accessors?
Also you aren't using any interrupt related new stuff in here so I think
this is just spurious.

>  #include <linux/iio/iio.h>
>  
>  #include "inv_icm42600.h"
> @@ -533,6 +534,19 @@ static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
>  
>  	mutex_lock(&st->lock);
Probably worth considering use of guard() in here as a precursor patch.

>  
> +	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS3, &status);
> +	if (ret)
> +	        goto out_unlock;
> +
> +	if (status & INV_ICM42600_STEP_DET_INT) {
> +	        iio_push_event(st->indio_accel, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
> +	                                                     IIO_NO_MOD,
> +	                                                     IIO_EV_TYPE_CHANGE,
> +	                                                     IIO_EV_DIR_NONE),
> +	                                                        st->timestamp.accel);
> +	        st->pedometer_value = true;
> +	}
> +
>  	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &status);
>  	if (ret)
>  		goto out_unlock;
> @@ -860,12 +876,20 @@ static int inv_icm42600_runtime_suspend(struct device *dev)
>  	mutex_lock(&st->lock);
>  
>  	/* disable all sensors */
> -	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
> -					 INV_ICM42600_SENSOR_MODE_OFF, false,
> -					 NULL);
> -	if (ret)
> -		goto error_unlock;
> +	if (st->pedometer_enable) {
> +		ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
> +						 INV_ICM42600_SENSOR_MODE_LOW_POWER,
> +						false, NULL);
> +		if (ret)
> +			goto error_unlock;
> +	} else {
>  
> +		ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
> +						 INV_ICM42600_SENSOR_MODE_OFF,
> +						 false, NULL);
> +		if (ret)
> +			goto error_unlock;
> +	}
>  	regulator_disable(st->vddio_supply);
>  
>  error_unlock:


