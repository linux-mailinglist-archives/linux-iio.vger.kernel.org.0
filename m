Return-Path: <linux-iio+bounces-5616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F78D7557
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBFD281E16
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD539FF2;
	Sun,  2 Jun 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbwCNOWN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF6D51A
	for <linux-iio@vger.kernel.org>; Sun,  2 Jun 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331233; cv=none; b=uxPLa07PyGZ0FLudMaRcai/Pj/Skd/CfiWK8ILmGpCv93II4TZntuLmb5zRFnwVOfcn8fTga9ap/Y58BYOD6+Exm6Gn2KT5AK+0KC+IUR1zVDo6DVlMrddBvi3D7nnPGrJGAc5Uwb07SrZJAwCkN14qqNX9EA2JTcg4CNx4ApO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331233; c=relaxed/simple;
	bh=2Nmj7/P66btvB2tcdW3GtMXiLa5SP0WW2HDSUUNQLB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRRUXsNge/gCgkyVXRrZZ6frIPFmfvfc9SHzbYxrlmTZbyWIdn2pIu3Nqi5pO2+M0LEiIssdrrcCIR/CecmOe/apxBekswJXEVJ76L8d4UNsRVhIWIUzWKlTKp8k0MfNbIb0yFHI9/ufY63gCv3p8cIlcTdowo9rAE6BBDEp+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbwCNOWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A84C2BBFC;
	Sun,  2 Jun 2024 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717331232;
	bh=2Nmj7/P66btvB2tcdW3GtMXiLa5SP0WW2HDSUUNQLB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EbwCNOWNG7A/V0050KT3hCzslulzX8Eawd868a/OdcTrvUp6CY8PHOOTJL06ypHde
	 kxoh4NUuYRXblUBARuZlfbuqJPL0Xt9dyWADYfNqCwvGNdPFJ+CREY3emk4vrn94Ty
	 3bd7xOs5visZ5qep7JzjFB++yVMnwVZW3KAPV4faUIod0egtG7L+CR5Ivo2LSdpNy/
	 p9nmIZ3XwgQyTzGPE2bgEQR9smbYCCxNsc3URb1wFc7V6DzZ4qC5tuFUnPT2ZzjkID
	 5/RmKx1GYMMvm7Hzysx/5uPyq8CqQwpTgsE2fm6eVcy1ZES5QiYRyTFi3SPqASXBi1
	 n3qPfof0HyUQA==
Date: Sun, 2 Jun 2024 13:27:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v3] iio: imu: inv_icm42600: add support of accel
 low-power mode
Message-ID: <20240602132701.78f87c3d@jic23-huawei>
In-Reply-To: <20240530142601.666984-1-inv.git-commit@tdk.com>
References: <20240530142601.666984-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 14:26:01 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add ODRs accessible only in low-power mode. Switch automatically to
> low-power or low-noise depending on the mode supported by the ODR.
> 
> Add channel attributes "power_mode" and "power_mode_available" for
> setting the power mode to use (low-noise or low-power) for ODRs
> supporting both modes (500Hz to 12.5Hz).

ABI docs?

> 
> By default, low-power mode is used for all frequencies < 1kHz and
> low-noise is used for the others.

I think the read back needs to reflect the restrictions but right now
I think it will report whatever was set, not what was possible.

> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  4 +
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 95 ++++++++++++++++++-
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 22 +++++
>  3 files changed, 117 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index c4ac91f6bafe..3a07e43e4cf1 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -177,11 +177,15 @@ struct inv_icm42600_state {
>   * struct inv_icm42600_sensor_state - sensor state variables
>   * @scales:		table of scales.
>   * @scales_len:		length (nb of items) of the scales table.
> + * @power_mode:		sensor requested power mode (for common frequencies)
> + * @filter:		sensor filter.
>   * @ts:			timestamp module states.
>   */
>  struct inv_icm42600_sensor_state {
>  	const int *scales;
>  	size_t scales_len;
> +	enum inv_icm42600_sensor_mode power_mode;
> +	enum inv_icm42600_filter filter;
>  	struct inv_sensors_timestamp ts;
>  };
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 83d8504ebfff..6ade0a5d4d1d 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -55,8 +55,79 @@ enum inv_icm42600_accel_scan {
>  	INV_ICM42600_ACCEL_SCAN_TIMESTAMP,
>  };
>  
> +static const char * const inv_icm42600_accel_power_mode_items[] = {
> +	"low-noise",
> +	"low-power",
> +};
> +static const int inv_icm42600_accel_power_mode_values[] = {
> +	INV_ICM42600_SENSOR_MODE_LOW_NOISE,
> +	INV_ICM42600_SENSOR_MODE_LOW_POWER,
> +};
> +static const int inv_icm42600_accel_filter_values[] = {
> +	INV_ICM42600_FILTER_BW_ODR_DIV_2,
> +	INV_ICM42600_FILTER_AVG_16X,
> +};
> +
> +static int inv_icm42600_accel_power_mode_set(struct iio_dev *indio_dev,
> +					     const struct iio_chan_spec *chan,
> +					     unsigned int idx)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
> +		return -EINVAL;
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;
> +
> +	guard(mutex)(&st->lock);
> +
> +	accel_st->power_mode = inv_icm42600_accel_power_mode_values[idx];

Superficially looks like this doesn't check the validity.
At the very least this reading this back should not reflect the wrong
power mode due to those limits.

Obviously this will constrain the ABI a little as it will only be possible
to manually control this if in one of those sampling frequencies where
either option is fine. However I think that is more consistent than
potentially reporting low power mode when running flat out.

> +	accel_st->filter = inv_icm42600_accel_filter_values[idx];
> +
> +	return 0;
> +}
> +
> +static int inv_icm42600_accel_power_mode_get(struct iio_dev *indio_dev,
> +					     const struct iio_chan_spec *chan)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
> +	unsigned int idx;
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +
> +	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_accel_power_mode_values); ++idx) {
> +		if (accel_st->power_mode ==
> +				inv_icm42600_accel_power_mode_values[idx])
> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
> +		return -EINVAL;
> +
> +	return idx;
> +}
> +
> +static const struct iio_enum inv_icm42600_accel_power_mode_enum = {
> +	.items = inv_icm42600_accel_power_mode_items,
> +	.num_items = ARRAY_SIZE(inv_icm42600_accel_power_mode_items),
> +	.set = inv_icm42600_accel_power_mode_set,
> +	.get = inv_icm42600_accel_power_mode_get,
> +};
> +
>  static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
> +	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
> +			   &inv_icm42600_accel_power_mode_enum),
> +	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
> +		 &inv_icm42600_accel_power_mode_enum),
>  	{},
>  };
>  
> @@ -120,7 +191,8 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
>  
>  	if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL_3AXIS) {
>  		/* enable accel sensor */
> -		conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
> +		conf.mode = accel_st->power_mode;
> +		conf.filter = accel_st->filter;
>  		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_accel);
>  		if (ret)
>  			goto out_unlock;
> @@ -144,10 +216,12 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
> +static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
>  					  struct iio_chan_spec const *chan,
>  					  int16_t *val)
>  {
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
>  	struct device *dev = regmap_get_device(st->map);
>  	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
>  	unsigned int reg;
> @@ -175,7 +249,8 @@ static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *st,
>  	mutex_lock(&st->lock);
>  
>  	/* enable accel sensor */
> -	conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
> +	conf.mode = accel_st->power_mode;
> +	conf.filter = accel_st->filter;
>  	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
>  	if (ret)
>  		goto exit;
> @@ -277,6 +352,12 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
>  
>  /* IIO format int + micro */
>  static const int inv_icm42600_accel_odr[] = {
> +	/* 1.5625Hz */
> +	1, 562500,
> +	/* 3.125Hz */
> +	3, 125000,
> +	/* 6.25Hz */
> +	6, 250000,
>  	/* 12.5Hz */
>  	12, 500000,
>  	/* 25Hz */
> @@ -296,6 +377,9 @@ static const int inv_icm42600_accel_odr[] = {
>  };
>  
>  static const int inv_icm42600_accel_odr_conv[] = {
> +	INV_ICM42600_ODR_1_5625HZ_LP,
> +	INV_ICM42600_ODR_3_125HZ_LP,
> +	INV_ICM42600_ODR_6_25HZ_LP,
>  	INV_ICM42600_ODR_12_5HZ,
>  	INV_ICM42600_ODR_25HZ,
>  	INV_ICM42600_ODR_50HZ,
> @@ -581,7 +665,7 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
>  		ret = iio_device_claim_direct_mode(indio_dev);
>  		if (ret)
>  			return ret;
> -		ret = inv_icm42600_accel_read_sensor(st, chan, &data);
> +		ret = inv_icm42600_accel_read_sensor(indio_dev, chan, &data);
>  		iio_device_release_direct_mode(indio_dev);
>  		if (ret)
>  			return ret;
> @@ -754,6 +838,9 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
>  		accel_st->scales_len = ARRAY_SIZE(inv_icm42600_accel_scale);
>  		break;
>  	}
> +	/* low-power by default at init */
> +	accel_st->power_mode = INV_ICM42600_SENSOR_MODE_LOW_POWER;
> +	accel_st->filter = INV_ICM42600_FILTER_AVG_16X;
>  
>  	/*
>  	 * clock period is 32kHz (31250ns)
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 96116a68ab29..b14ff58d8a9d 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -248,6 +248,18 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
>  	if (conf->filter < 0)
>  		conf->filter = oldconf->filter;
>  
> +	/* force power mode against ODR when sensor is on */
> +	if (conf->mode != INV_ICM42600_SENSOR_MODE_OFF) {
> +		if (conf->odr <= INV_ICM42600_ODR_1KHZ_LN) {
> +			conf->mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
> +			conf->filter = INV_ICM42600_FILTER_BW_ODR_DIV_2;
> +		} else if (conf->odr >= INV_ICM42600_ODR_6_25HZ_LP &&
> +			   conf->odr <= INV_ICM42600_ODR_1_5625HZ_LP) {
> +			conf->mode = INV_ICM42600_SENSOR_MODE_LOW_POWER;
> +			conf->filter = INV_ICM42600_FILTER_AVG_16X;
> +		}
> +	}
> +
>  	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
>  	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
>  		val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
> @@ -441,6 +453,16 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Use RC clock for accel low-power to fix glitches when switching
> +	 * gyro on/off while accel low-power is on.
> +	 */
> +	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG1,
> +				 INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC,
> +				 INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC);
> +	if (ret)
> +		return ret;
> +
>  	return inv_icm42600_set_conf(st, hw->conf);
>  }
>  


