Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844B01E9762
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 13:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgEaLyV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 07:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgEaLyV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 07:54:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B87120707;
        Sun, 31 May 2020 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590926059;
        bh=IEb59yziyS1B74H3nWuGhnnebaL6ZwpeA642O+iTnmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zi0Nl3NnNXXTh47z9ol4wewoEF+XhsvzF5zOtbORL3FgiZ/nC3Oijc08a9F/rVHQI
         d5IgU8X9nsrkvzb1XxTFCYtHS4FpDmoZydv0KfoabOzULLpDHPuC4bTVd98vvMtgxD
         x5sQQy7Ffm6SwxHfDDuQ7DPmYtupyIh337Y9BkLg=
Date:   Sun, 31 May 2020 12:54:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     robh+dt@kernel.org, robh@kernel.org, mchehab+huawei@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] iio: imu: inv_icm42600: add gyroscope IIO
 device
Message-ID: <20200531125415.6904a94d@archlinux>
In-Reply-To: <20200527185711.21331-5-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-5-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 May 2020 20:57:03 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add IIO device for gyroscope sensor with data polling interface.
> Attributes: raw, scale, sampling_frequency, calibbias.
> 
> Gyroscope in low noise mode.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Unusual to have a calibration offset specified in output units,
which contributes a lot of the complexity in here.
Normally those are strictly front end (output of some calibration DAC).
So if they have units (and often they don't) I'd expect them to be
the same as _raw.

We need to tidy up the docs on this though as it doesn't express
any sort of preference.  It's hard to be specific as often the calibration
scales are defined - they are just like tweaking a POT on an analog
sensor board.

A few trivial other things inline, including a suggestion to modify
the layering of the driver a tiny bit during probe.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   6 +
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   4 +
>  .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 600 ++++++++++++++++++
>  3 files changed, 610 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index 14c8ef152418..c1023d59b37b 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -120,6 +120,8 @@ struct inv_icm42600_suspended {
>   *  @orientation:	sensor chip orientation relative to main hardware.
>   *  @conf:		chip sensors configurations.
>   *  @suspended:		suspended sensors configuration.
> + *  @indio_gyro:	gyroscope IIO device.
> + *  @buffer:		data transfer buffer aligned for DMA.
>   */
>  struct inv_icm42600_state {
>  	struct mutex lock;
> @@ -131,6 +133,8 @@ struct inv_icm42600_state {
>  	struct iio_mount_matrix orientation;
>  	struct inv_icm42600_conf conf;
>  	struct inv_icm42600_suspended suspended;
> +	struct iio_dev *indio_gyro;
> +	uint8_t buffer[2] ____cacheline_aligned;
>  };
>  
>  /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
> @@ -369,4 +373,6 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  			    inv_icm42600_bus_setup bus_setup);
>  
> +int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
> +
>  #endif
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 81b171d6782c..dccb7bcc782e 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -510,6 +510,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  	if (ret)
>  		return ret;
>  
> +	ret = inv_icm42600_gyro_init(st);
> +	if (ret)
> +		return ret;
> +
>  	/* setup runtime power management */
>  	ret = pm_runtime_set_active(dev);
>  	if (ret)
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> new file mode 100644
> index 000000000000..9d9672989b23
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> @@ -0,0 +1,600 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 Invensense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/delay.h>
> +#include <linux/math64.h>
> +#include <linux/iio/iio.h>
> +
> +#include "inv_icm42600.h"
> +
> +#define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)		\
> +	{								\
> +		.type = IIO_ANGL_VEL,					\
> +		.modified = 1,						\
> +		.channel2 = _modifier,					\
> +		.info_mask_separate =					\
> +			BIT(IIO_CHAN_INFO_RAW) |			\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> +		.info_mask_shared_by_type =				\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
> +		.info_mask_shared_by_type_available =			\
> +			BIT(IIO_CHAN_INFO_SCALE) |			\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> +		.info_mask_shared_by_all =				\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.info_mask_shared_by_all_available =			\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.scan_index = _index,					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 16,					\
> +			.storagebits = 16,				\
> +			.endianness = IIO_BE,				\
> +		},							\
> +		.ext_info = _ext_info,					\
> +	}
> +
> +enum inv_icm42600_gyro_scan {
> +	INV_ICM42600_GYRO_SCAN_X,
> +	INV_ICM42600_GYRO_SCAN_Y,
> +	INV_ICM42600_GYRO_SCAN_Z,
> +};
> +
> +static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
> +	{},
> +};
> +
> +static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
> +	INV_ICM42600_GYRO_CHAN(IIO_MOD_X, INV_ICM42600_GYRO_SCAN_X,
> +			       inv_icm42600_gyro_ext_infos),
> +	INV_ICM42600_GYRO_CHAN(IIO_MOD_Y, INV_ICM42600_GYRO_SCAN_Y,
> +			       inv_icm42600_gyro_ext_infos),
> +	INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
> +			       inv_icm42600_gyro_ext_infos),
> +};
> +
> +static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
> +					 struct iio_chan_spec const *chan,
> +					 int16_t *val)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> +	unsigned int reg;
> +	__be16 *data;
> +	int ret;
> +
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = INV_ICM42600_REG_GYRO_DATA_X;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = INV_ICM42600_REG_GYRO_DATA_Y;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = INV_ICM42600_REG_GYRO_DATA_Z;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&st->lock);
> +
> +	/* enable gyro sensor */
> +	conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
> +	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
> +	if (ret)
> +		goto exit;
> +
> +	/* read gyro register data */
> +	data = (__be16 *)&st->buffer[0];
> +	ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
> +	if (ret)
> +		goto exit;
> +
> +	*val = (int16_t)be16_to_cpup(data);
> +	if (*val == INV_ICM42600_DATA_INVALID)
> +		ret = -EINVAL;
> +exit:
> +	mutex_unlock(&st->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}
> +
> +/* IIO format int + nano */
> +static const int inv_icm42600_gyro_scale[] = {
> +	/* +/- 2000dps => 0.001065264 rad/s */
> +	[2 * INV_ICM42600_GYRO_FS_2000DPS] = 0,
> +	[2 * INV_ICM42600_GYRO_FS_2000DPS + 1] = 1065264,
> +	/* +/- 1000dps => 0.000532632 rad/s */
> +	[2 * INV_ICM42600_GYRO_FS_1000DPS] = 0,
> +	[2 * INV_ICM42600_GYRO_FS_1000DPS + 1] = 532632,
> +	/* +/- 500dps => 0.000266316 rad/s */
> +	[2 * INV_ICM42600_GYRO_FS_500DPS] = 0,
> +	[2 * INV_ICM42600_GYRO_FS_500DPS + 1] = 266316,
> +	/* +/- 250dps => 0.000133158 rad/s */
> +	[2 * INV_ICM42600_GYRO_FS_250DPS] = 0,
> +	[2 * INV_ICM42600_GYRO_FS_250DPS + 1] = 133158,
> +	/* +/- 125dps => 0.000066579 rad/s */
> +	[2 * INV_ICM42600_GYRO_FS_125DPS] = 0,
> +	[2 * INV_ICM42600_GYRO_FS_125DPS + 1] = 66579,
> +	/* +/- 62.5dps => 0.000033290 rad/s */
> +	[2 * INV_ICM42600_GYRO_FS_62_5DPS] = 0,
> +	[2 * INV_ICM42600_GYRO_FS_62_5DPS + 1] = 33290,
> +	/* +/- 31.25dps => 0.000016645 rad/s */
> +	[2 * INV_ICM42600_GYRO_FS_31_25DPS] = 0,
> +	[2 * INV_ICM42600_GYRO_FS_31_25DPS + 1] = 16645,
> +	/* +/- 15.625dps => 0.000008322 rad/s */
> +	[2 * INV_ICM42600_GYRO_FS_15_625DPS] = 0,
> +	[2 * INV_ICM42600_GYRO_FS_15_625DPS + 1] = 8322,
> +};
> +
> +static int inv_icm42600_gyro_read_scale(struct inv_icm42600_state *st,
> +					int *val, int *val2)
> +{
> +	unsigned int idx;
> +
> +	idx = st->conf.gyro.fs;
> +
> +	*val = inv_icm42600_gyro_scale[2 * idx];
> +	*val2 = inv_icm42600_gyro_scale[2 * idx + 1];
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static int inv_icm42600_gyro_write_scale(struct inv_icm42600_state *st,
> +					 int val, int val2)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_gyro_scale); idx += 2) {
> +		if (val == inv_icm42600_gyro_scale[idx] &&
> +		    val2 == inv_icm42600_gyro_scale[idx + 1])
> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42600_gyro_scale))
> +		return -EINVAL;
> +
> +	conf.fs = idx / 2;
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&st->lock);
> +
> +	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
> +
> +	mutex_unlock(&st->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +/* IIO format int + micro */
> +static const int inv_icm42600_gyro_odr[] = {
> +	/* 12.5Hz */
> +	12, 500000,
> +	/* 25Hz */
> +	25, 0,
> +	/* 50Hz */
> +	50, 0,
> +	/* 100Hz */
> +	100, 0,
> +	/* 200Hz */
> +	200, 0,
> +	/* 1kHz */
> +	1000, 0,
> +	/* 2kHz */
> +	2000, 0,
> +	/* 4kHz */
> +	4000, 0,
> +};
> +
> +static const int inv_icm42600_gyro_odr_conv[] = {
> +	INV_ICM42600_ODR_12_5HZ,
> +	INV_ICM42600_ODR_25HZ,
> +	INV_ICM42600_ODR_50HZ,
> +	INV_ICM42600_ODR_100HZ,
> +	INV_ICM42600_ODR_200HZ,
> +	INV_ICM42600_ODR_1KHZ_LN,
> +	INV_ICM42600_ODR_2KHZ_LN,
> +	INV_ICM42600_ODR_4KHZ_LN,
> +};
> +
> +static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state *st,
> +				      int *val, int *val2)
> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	odr = st->conf.gyro.odr;
> +
> +	for (i = 0; i < ARRAY_SIZE(inv_icm42600_gyro_odr_conv); ++i) {
> +		if (inv_icm42600_gyro_odr_conv[i] == odr)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(inv_icm42600_gyro_odr_conv))
> +		return -EINVAL;
> +
> +	*val = inv_icm42600_gyro_odr[2 * i];
> +	*val2 = inv_icm42600_gyro_odr[2 * i + 1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
> +				       int val, int val2)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_gyro_odr); idx += 2) {
> +		if (val == inv_icm42600_gyro_odr[idx] &&
> +		    val2 == inv_icm42600_gyro_odr[idx + 1])
> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42600_gyro_odr))
> +		return -EINVAL;
> +
> +	conf.odr = inv_icm42600_gyro_odr_conv[idx / 2];
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&st->lock);
> +
> +	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
> +
> +	mutex_unlock(&st->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +/*
> + * Calibration bias values, IIO range format int + nano.
> + * Value is limited to +/-64dps coded on 12 bits signed. Step is 1/32 dps.
> + */
> +static int inv_icm42600_gyro_calibbias[] = {
> +	-1, 117010721,		/* min: -1.117010721 rad/s */
> +	0, 545415,		/* step: 0.000545415 rad/s */
> +	1, 116465306,		/* max: 1.116465306 rad/s */
> +};
> +
> +static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
> +					 struct iio_chan_spec const *chan,
> +					 int *val, int *val2)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	int64_t val64;
> +	int32_t bias;
> +	unsigned int reg;
> +	int16_t offset;
> +	uint8_t data[2];
> +	int ret;
> +
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = INV_ICM42600_REG_OFFSET_USER0;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = INV_ICM42600_REG_OFFSET_USER1;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = INV_ICM42600_REG_OFFSET_USER3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_bulk_read(st->map, reg, st->buffer, sizeof(data));
> +	memcpy(data, st->buffer, sizeof(data));
> +
> +	mutex_unlock(&st->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* 12 bits signed value */
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
> +		break;
> +	case IIO_MOD_Y:
> +		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
> +		break;
> +	case IIO_MOD_Z:
> +		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * convert raw offset to dps then to rad/s
> +	 * 12 bits signed raw max 64 to dps: 64 / 2048
> +	 * dps to rad: Pi / 180
> +	 * result in nano (1000000000)
> +	 * (offset * 64 * Pi * 1000000000) / (2048 * 180)
> +	 */
> +	val64 = (int64_t)offset * 64LL * 3141592653LL;
> +	/* for rounding, add + or - divisor (2048 * 180) divided by 2 */
> +	if (val64 >= 0)
> +		val64 += 2048 * 180 / 2;
> +	else
> +		val64 -= 2048 * 180 / 2;
> +	bias = div_s64(val64, 2048 * 180);
> +	*val = bias / 1000000000L;
> +	*val2 = bias % 1000000000L;
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
> +					  struct iio_chan_spec const *chan,
> +					  int val, int val2)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	int64_t val64, min, max;
> +	unsigned int reg, regval;
> +	int16_t offset;
> +	int ret;
> +
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = INV_ICM42600_REG_OFFSET_USER0;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = INV_ICM42600_REG_OFFSET_USER1;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = INV_ICM42600_REG_OFFSET_USER3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* inv_icm42600_gyro_calibbias: min - step - max in nano */
> +	min = (int64_t)inv_icm42600_gyro_calibbias[0] * 1000000000LL +
> +	      (int64_t)inv_icm42600_gyro_calibbias[1];
> +	max = (int64_t)inv_icm42600_gyro_calibbias[4] * 1000000000LL +
> +	      (int64_t)inv_icm42600_gyro_calibbias[5];
> +	val64 = (int64_t)val * 1000000000LL + (int64_t)val2;
> +	if (val64 < min || val64 > max)
> +		return -EINVAL;
> +
> +	/*
> +	 * convert rad/s to dps then to raw value
> +	 * rad to dps: 180 / Pi
> +	 * dps to raw 12 bits signed, max 64: 2048 / 64
> +	 * val in nano (1000000000)
> +	 * val * 180 * 2048 / (Pi * 1000000000 * 64)
> +	 */
> +	val64 = val64 * 180LL * 2048LL;
> +	/* for rounding, add + or - divisor (3141592653 * 64) divided by 2 */
> +	if (val64 >= 0)
> +		val64 += 3141592653LL * 64LL / 2LL;
> +	else
> +		val64 -= 3141592653LL * 64LL / 2LL;
> +	offset = div64_s64(val64, 3141592653LL * 64LL);
> +
> +	/* clamp value limited to 12 bits signed */
> +	if (offset < -2048)
> +		offset = -2048;
> +	else if (offset > 2047)
> +		offset = 2047;
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&st->lock);
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		/* OFFSET_USER1 register is shared */
> +		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER1,
> +				  &regval);
> +		if (ret)
> +			goto out_unlock;
> +		st->buffer[0] = offset & 0xFF;
> +		st->buffer[1] = (regval & 0xF0) | ((offset & 0xF00) >> 8);
> +		break;
> +	case IIO_MOD_Y:
> +		/* OFFSET_USER1 register is shared */
> +		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER1,
> +				  &regval);
> +		if (ret)
> +			goto out_unlock;
> +		st->buffer[0] = ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		st->buffer[1] = offset & 0xFF;
> +		break;
> +	case IIO_MOD_Z:
> +		/* OFFSET_USER4 register is shared */
> +		ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER4,
> +				  &regval);
> +		if (ret)
> +			goto out_unlock;
> +		st->buffer[0] = offset & 0xFF;
> +		st->buffer[1] = (regval & 0xF0) | ((offset & 0xF00) >> 8);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = regmap_bulk_write(st->map, reg, st->buffer, 2);
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}
> +
> +static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      int *val, int *val2, long mask)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	int16_t data;
> +	int ret;
> +
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		ret = inv_icm42600_gyro_read_sensor(st, chan, &data);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		*val = data;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		return inv_icm42600_gyro_read_scale(st, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return inv_icm42600_gyro_read_odr(st, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return inv_icm42600_gyro_read_offset(st, chan, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int inv_icm42600_gyro_read_avail(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					const int **vals,
> +					int *type, int *length, long mask)
> +{
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = inv_icm42600_gyro_scale;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = ARRAY_SIZE(inv_icm42600_gyro_scale);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = inv_icm42600_gyro_odr;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(inv_icm42600_gyro_odr);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals = inv_icm42600_gyro_calibbias;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
> +				       struct iio_chan_spec const *chan,
> +				       int val, int val2, long mask)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		ret = inv_icm42600_gyro_write_scale(st, val, val2);
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return inv_icm42600_gyro_write_odr(st, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		ret = inv_icm42600_gyro_write_offset(st, chan, val, val2);
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int inv_icm42600_gyro_write_raw_get_fmt(struct iio_dev *indio_dev,
> +					       struct iio_chan_spec const *chan,
> +					       long mask)
> +{
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info inv_icm42600_gyro_info = {
> +	.read_raw = inv_icm42600_gyro_read_raw,
> +	.read_avail = inv_icm42600_gyro_read_avail,
> +	.write_raw = inv_icm42600_gyro_write_raw,
> +	.write_raw_get_fmt = inv_icm42600_gyro_write_raw_get_fmt,
> +	.debugfs_reg_access = inv_icm42600_debugfs_reg,
> +};
> +
> +int inv_icm42600_gyro_init(struct inv_icm42600_state *st)

This feels like the layering would be clearer if this
returned the struct iio_dev * and the assignment happened in the
core driver.

Then state parameter can be const and it'll be obvious it has
no side effects on the state structure.

> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	const char *name;
> +	struct iio_dev *indio_dev;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	indio_dev = devm_iio_device_alloc(dev, 0);
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	iio_device_set_drvdata(indio_dev, st);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = name;
> +	indio_dev->info = &inv_icm42600_gyro_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = inv_icm42600_gyro_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_gyro_channels);
> +
> +	st->indio_gyro = indio_dev;
> +	return devm_iio_device_register(dev, st->indio_gyro);
> +}

