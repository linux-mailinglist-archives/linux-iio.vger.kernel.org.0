Return-Path: <linux-iio+bounces-21751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D2B08FC9
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7468116B611
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23BA2ED144;
	Thu, 17 Jul 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcRglo7+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701A3FE7;
	Thu, 17 Jul 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763666; cv=none; b=L076r5WKizH20NxAa7+VsAvwx/NiE/PnOnRipYsKUTaBD/KepZ2trgkKZvmMaFqEi0Uy4Wv1rMm7UUvB4wCPRNaK4VtkUUJ2alWJ4vJi2Cx7mP0ooI/ADtDQvobW8VwoyKmL2OOgdITZczL+aCZvFlJQ1ff78o/hTKzdIZFXTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763666; c=relaxed/simple;
	bh=+C+9vcqVgzsBmCa938a0VDR36lGy/KurkeFwOeYgYYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRyVuAUgyKYH5dqdJlpibHsDRFjmJxmj6HNHDitu0LlouhFUHd1ruq3Ibgp1w9TFdNgAPsHdSj3Db9WALoOhvu9RARI33Sf1bX4KlqIQrCX7REBE8j8b8KOsvIjvNeKtruy0hICDPg6wTCrKlx5xKxsFkgEgzm2whT7cDqoTk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcRglo7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6711AC4CEE3;
	Thu, 17 Jul 2025 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763666;
	bh=+C+9vcqVgzsBmCa938a0VDR36lGy/KurkeFwOeYgYYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gcRglo7+dkBgUsw2AjFAYwzRxOlAQrVkBmJNHRnAx0sdz3SUrsXKl3LhrBW3NdzhJ
	 JJwi+ITBIoFYXoUhAz3HDIW7VC8ECWGITJofzGqCN3XFT5njl0AOPR2lQkCLMpfB/o
	 ctf5Us0CqeIO1mY7e4EnBDkBHaibcDadEKLKsH2IMhbAEDP4oBUh6v1sCaxndVxnTL
	 +L9RHbE1zNchDi3Pcd60GbL6obfp/YP6c4/5tqk+OBltz9XLrM8rlFPaD43Etudvno
	 blB2mUGumkn8v+AmBuoDfwgaezgiuKy1t56MKHOC61ik767xpMPduU0nA6f+sgSQt5
	 rihVpTor3jMFQ==
Date: Thu, 17 Jul 2025 15:47:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/8] iio: imu: inv_icm45600: add IMU IIO devices
Message-ID: <20250717154738.4df17e26@jic23-huawei>
In-Reply-To: <20250710-add_newport_driver-v2-4-bf76d8142ef2@tdk.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
	<20250710-add_newport_driver-v2-4-bf76d8142ef2@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 08:57:59 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add IIO devices for accelerometer and gyroscope sensors
> with data polling interface and FIFO parsing.
> Attributes: raw, scale, sampling_frequency, calibbias.
> Temperature is available as a processed channel.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>

Hi Remi,

A few comments inline.

Jonathan


> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8ba2e8e54c738a3289726d6f23a46f5307ebdffe
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
> @@ -0,0 +1,809 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Invensense, Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#include "inv_icm45600_buffer.h"
> +#include "inv_icm45600.h"
> +
> +enum inv_icm45600_gyro_scan {
> +	INV_ICM45600_GYRO_SCAN_X,
> +	INV_ICM45600_GYRO_SCAN_Y,
> +	INV_ICM45600_GYRO_SCAN_Z,
> +	INV_ICM45600_GYRO_SCAN_TEMP,
> +	INV_ICM45600_GYRO_SCAN_TIMESTAMP,
> +};
> +
> +static const struct iio_chan_spec_ext_info inv_icm45600_gyro_ext_infos[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm45600_get_mount_matrix),
> +	{ },

No trailing comma on a terminating entry.

> +};
> +
> +#define INV_ICM45600_GYRO_CHAN(_modifier, _index, _ext_info)		\
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
> +			.endianness = IIO_LE,				\
> +		},							\
> +		.ext_info = _ext_info,					\
> +	}

> +static const unsigned long inv_icm45600_gyro_scan_masks[] = {
> +	/* 3-axis gyro + temperature */
> +	BIT(INV_ICM45600_GYRO_SCAN_X) |
> +	BIT(INV_ICM45600_GYRO_SCAN_Y) |
> +	BIT(INV_ICM45600_GYRO_SCAN_Z) |
> +	BIT(INV_ICM45600_GYRO_SCAN_TEMP),
> +	0,

No comma as that's a terminating entry so nothing should come after it.

> +};
> +
> +/* enable gyroscope sensor and FIFO write */
> +static int inv_icm45600_gyro_update_scan_mode(struct iio_dev *indio_dev,
> +					      const unsigned long *scan_mask)
> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
> +	unsigned int fifo_en = 0;
> +	unsigned int sleep;
> +	int ret;
> +
> +	scoped_guard(mutex, &st->lock) {
> +		if (*scan_mask & BIT(INV_ICM45600_GYRO_SCAN_TEMP))
> +			fifo_en |= INV_ICM45600_SENSOR_TEMP;
> +
> +		if (*scan_mask & (BIT(INV_ICM45600_GYRO_SCAN_X) |
> +				 BIT(INV_ICM45600_GYRO_SCAN_Y) |
> +				 BIT(INV_ICM45600_GYRO_SCAN_Z))) {
> +			/* enable gyro sensor */
> +			conf.mode = gyro_st->power_mode;
> +			ret = inv_icm45600_set_gyro_conf(st, &conf, &sleep);
> +			if (ret)
> +				return ret;
> +			fifo_en |= INV_ICM45600_SENSOR_GYRO;
> +		}
> +		/* update data FIFO write */
> +		ret = inv_icm45600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
> +	}
> +	/* sleep required time */
Can we just always sleep?

> +	if (sleep)
> +		msleep(sleep);
> +
> +	return ret;
> +}

> +
> +/* IIO format int + nano */
> +const int inv_icm45600_gyro_scale[][2] = {
> +	/* +/- 2000dps => 0.001065264 rad/s */
> +	[INV_ICM45600_GYRO_FS_2000DPS] = {0, 1065264},
> +	/* +/- 1000dps => 0.000532632 rad/s */
> +	[INV_ICM45600_GYRO_FS_1000DPS] = {0, 532632},
> +	/* +/- 500dps => 0.000266316 rad/s */
> +	[INV_ICM45600_GYRO_FS_500DPS] = {0, 266316},
> +	/* +/- 250dps => 0.000133158 rad/s */
> +	[INV_ICM45600_GYRO_FS_250DPS] = {0, 133158},
> +	/* +/- 125dps => 0.000066579 rad/s */
> +	[INV_ICM45600_GYRO_FS_125DPS] = {0, 66579},
> +	/* +/- 62.5dps => 0.000033290 rad/s */
> +	[INV_ICM45600_GYRO_FS_62_5DPS] = {0, 33290},
> +	/* +/- 31.25dps => 0.000016645 rad/s */
> +	[INV_ICM45600_GYRO_FS_31_25DPS] = {0, 16645},
> +	/* +/- 15.625dps => 0.000008322 rad/s */
> +	[INV_ICM45600_GYRO_FS_15_625DPS] = {0, 8322},
> +};
> +
> +/* IIO format int + nano */
> +const int inv_icm45686_gyro_scale[][2] = {
> +	/* +/- 4000dps => 0.002130529 rad/s */
> +	[INV_ICM45686_GYRO_FS_4000DPS] = {0, 2130529},
{ 0, 2130529 },

preferred for IIO code.  Arbitrary choice I made a while back
in the interests of homogeneous looking code.


> +	/* +/- 2000dps => 0.001065264 rad/s */
> +	[INV_ICM45686_GYRO_FS_2000DPS] = {0, 1065264},
> +	/* +/- 1000dps => 0.000532632 rad/s */
> +	[INV_ICM45686_GYRO_FS_1000DPS] = {0, 532632},
> +	/* +/- 500dps => 0.000266316 rad/s */
> +	[INV_ICM45686_GYRO_FS_500DPS] = {0, 266316},
> +	/* +/- 250dps => 0.000133158 rad/s */
> +	[INV_ICM45686_GYRO_FS_250DPS] = {0, 133158},
> +	/* +/- 125dps => 0.000066579 rad/s */
> +	[INV_ICM45686_GYRO_FS_125DPS] = {0, 66579},
> +	/* +/- 62.5dps => 0.000033290 rad/s */
> +	[INV_ICM45686_GYRO_FS_62_5DPS] = {0, 33290},
> +	/* +/- 31.25dps => 0.000016645 rad/s */
> +	[INV_ICM45686_GYRO_FS_31_25DPS] = {0, 16645},
> +	/* +/- 15.625dps => 0.000008322 rad/s */
> +	[INV_ICM45686_GYRO_FS_15_625DPS] = {0, 8322},
> +};

> +
> +/* IIO format int + micro */
> +static const int inv_icm45600_gyro_odr[] = {
> +	/* 1.5625Hz */
> +	1, 562500,
	1, 562500, /* 1.5625Hz */
	3, 125000, /* 3.125Hz */

etc if you think the comments are needed.

> +	/* 3.125Hz */
> +	3, 125000,
> +	/* 6.25Hz */
> +	6, 250000,
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
> +	/* 400Hz */
> +	400, 0,
> +	/* 800Hz */
> +	800, 0,
> +	/* 1.6kHz */
> +	1600, 0,
> +	/* 3.2kHz */
> +	3200, 0,
> +	/* 6.4kHz */
> +	6400, 0,
> +};

> +/*
> + * Calibration bias values, IIO range format int + nano.
> + * Value is limited to +/-62.5dps coded on 14 bits signed. Step is 7.5mdps.
> + */
> +static int inv_icm45600_gyro_calibbias[] = {
> +	-1, 90830336,	/* min: -1.090830336 rad/s */
> +	0, 133158,	/* step: 0.000133158 rad/s */
> +	1, 90697178,	/* max: 1.090697178 rad/s */
> +};

> +static int inv_icm45600_gyro_write_offset(struct inv_icm45600_state *st,
> +					  struct iio_chan_spec const *chan,
> +					  int val, int val2)
As this is calibbias, it's not really required to be in any particular
units.  Often these are analog front end tweaks where that doesn't matter.
So you could just have this take the integer value you compute instead
of doing all this maths.  Also update the available ranges if you do that.


I don't mind if you want something specific though (like radians) though
as that's also compliant with the ABI.

> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	s64 val64, min, max;
> +	unsigned int reg;
> +	s16 offset;
> +	int ret;
> +
> +	if (chan->type != IIO_ANGL_VEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = INV_ICM45600_IPREG_SYS1_REG_42;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = INV_ICM45600_IPREG_SYS1_REG_56;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = INV_ICM45600_IPREG_SYS1_REG_70;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* inv_icm45600_gyro_calibbias: min - step - max in nano */
> +	min = (s64)inv_icm45600_gyro_calibbias[0] * 1000000000LL -
> +	      (s64)inv_icm45600_gyro_calibbias[1];
> +	max = (s64)inv_icm45600_gyro_calibbias[4] * 1000000000LL +
> +	      (s64)inv_icm45600_gyro_calibbias[5];
> +	val64 = (s64)val * 1000000000LL;
> +	if (val > 0)
> +		val64 += (s64)val2;
> +	else
> +		val64 -= (s64)val2;
> +	if (val64 < min || val64 > max)
> +		return -EINVAL;
> +
> +	/*
> +	 * convert rad/s to dps then to raw value
> +	 * rad to dps: 180 / Pi
> +	 * dps to raw 14 bits signed, max 62.5: 8192 / 62.5
> +	 * val in nano (1000000000)
> +	 * val * 180 * 8192 / (Pi * 1000000000 * 62.5)
> +	 */
> +	val64 = val64 * 180LL * 8192;
> +	/* for rounding, add + or - divisor (314159265 * 625) divided by 2 */
> +	if (val64 >= 0)
> +		val64 += 314159265LL * 625LL / 2LL;
> +	else
> +		val64 -= 314159265LL * 625LL / 2LL;
> +	offset = div64_s64(val64, 314159265LL * 625LL);
> +
> +	/* clamp value limited to 14 bits signed */
> +	if (offset < -8192)
> +		offset = -8192;
> +	else if (offset > 8191)
> +		offset = 8191;
> +
> +	st->buffer.u16 = cpu_to_le16(offset & INV_ICM45600_GYRO_OFFUSER_MASK);
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &st->lock)
> +		ret = regmap_bulk_write(st->map, reg, &st->buffer.u16, sizeof(st->buffer.u16));
> +
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}



> +static int inv_icm45600_gyro_hwfifo_flush(struct iio_dev *indio_dev,
> +					  unsigned int count)
> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	if (count == 0)
> +		return 0;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm45600_buffer_hwfifo_flush(st, count);
> +	if (!ret)
> +		ret = st->fifo.nb.gyro;
	if (ret)
		return ret;

	return s->fifo.nb.gyro;

preferred slightly because it keeps the error path out of line.
When reading a lot of code conventions like that an help.

> +
> +	return ret;
> +}

> +
> +struct iio_dev *inv_icm45600_gyro_init(struct inv_icm45600_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	const char *name;

Pick an ordering.  If nothing else makes sense, reverse xmas tree
isn't too ugly.

> +	struct inv_icm45600_sensor_state *gyro_st;
> +	struct inv_sensors_timestamp_chip ts_chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->chip_info->name);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_st));
> +	if (!indio_dev)
> +		return ERR_PTR(-ENOMEM);
> +	gyro_st = iio_priv(indio_dev);
> +
> +	gyro_st->scales = st->chip_info->gyro_scales;
> +	gyro_st->scales_len = st->chip_info->gyro_scales_len * 2;
> +
> +	/* low-noise by default at init */
> +	gyro_st->power_mode = INV_ICM45600_SENSOR_MODE_LOW_NOISE;
> +
> +	/*
> +	 * clock period is 32kHz (31250ns)
> +	 * jitter is +/- 2% (20 per mille)
> +	 */
> +	ts_chip.clock_period = 31250;
> +	ts_chip.jitter = 20;
> +	ts_chip.init_period = inv_icm45600_odr_to_period(st->conf.gyro.odr);
> +	inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);
> +
> +	iio_device_set_drvdata(indio_dev, st);
> +	indio_dev->name = name;
> +	indio_dev->info = &inv_icm45600_gyro_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = inv_icm45600_gyro_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(inv_icm45600_gyro_channels);
> +	indio_dev->available_scan_masks = inv_icm45600_gyro_scan_masks;
> +	indio_dev->setup_ops = &inv_icm45600_buffer_ops;
> +
> +	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> +					  &inv_icm45600_buffer_ops);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return indio_dev;
> +}
> +
> +int inv_icm45600_gyro_parse_fifo(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &gyro_st->ts;
> +	ssize_t i, size;
> +	unsigned int no;
> +	const struct inv_icm45600_fifo_sensor_data *accel, *gyro;
> +	const __le16 *timestamp;
> +	const s8 *temp;
> +	unsigned int odr;
> +	s64 ts_val;
> +	struct inv_icm45600_gyro_buffer buffer;

I'd push scope of many of these into the for loop.

> +
> +	/* parse all fifo packets */
> +	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
> +		size = inv_icm45600_fifo_decode_packet(&st->fifo.data[i],
> +				&accel, &gyro, &temp, &timestamp, &odr);
> +		/* quit if error or FIFO is empty */
> +		if (size <= 0)
> +			return size;
> +
> +		/* skip packet if no gyro data or data is invalid */
> +		if (gyro == NULL || !inv_icm45600_fifo_is_data_valid(gyro))
> +			continue;
> +
> +		/* update odr */
> +		if (odr & INV_ICM45600_SENSOR_GYRO)
> +			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
> +							st->fifo.nb.total, no);
> +
> +		/* buffer is copied to userspace, zeroing it to avoid any data leak */
> +		memset(&buffer, 0, sizeof(buffer));
> +		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
> +		/* convert 8 bits FIFO temperature in high resolution format */
> +		buffer.temp = temp ? (*temp * 64) : 0;
> +		ts_val = inv_sensors_timestamp_pop(ts);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
> +	}
> +
> +	return 0;
> +}
> 


