Return-Path: <linux-iio+bounces-23205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1DB33CDD
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5ED189973A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547E288C25;
	Mon, 25 Aug 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjs5xRN4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3F1F1518;
	Mon, 25 Aug 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118095; cv=none; b=JqyAlrtc4/MslKToCx1WkuWC3eP1vCblBiIrMmFsymk7MbCmCPzDwmbpvx/1yhM+sn+w/hQRfxYDsVdamsPODkJ4b5IGebiv8gsxsvfm75tm37E+3ydD2gFCDOWdK9+2HXvw0F+Hzl6ob1ZASKw7FfwW9YgE9wILkH7cMbHQgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118095; c=relaxed/simple;
	bh=bGAcKz0z6RUwbs47gGnkgaJhEJT/enlzxgI0uGAh3HY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ky24kvQGNCD3sthvsGb8eBFEN7Xu/sbkq5b9GD5U9JcT5mvnAEeVm81bGACDoqSPEdRD6ILUd+3hnWcmEjFKEFNX0n5xhTQqNu2awdXeuslsW7MiqKRpKWYvGygsuYn4MQed0OQKvUOZiYjp97aO0wJwnTXn2gnprXgq4SP+VsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjs5xRN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0893BC4CEED;
	Mon, 25 Aug 2025 10:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756118095;
	bh=bGAcKz0z6RUwbs47gGnkgaJhEJT/enlzxgI0uGAh3HY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pjs5xRN4K1PZ7dyAzDYLSvgxyKD1Jo6I+3sVAQ3+oavIwYDp+6ENHIEOi0AtDgn6O
	 1+MmGywNwMLYA1iQyMEWlGi5ZqELyuA5ADzI8M/SeMXxRzusDLRAzpPVfgT3dFVb37
	 uThCQBH126arOoBFMUwWIGyT8sGQHJpKQ3sQQjDKJjoVJFTH+NfdnFK4YIhusybB8g
	 cxuu2ou9C9cX4paXfKG9qmQZppRk0AmsnYPVeBnnR4nktJAlR5G9GmzyIqac0OuEzu
	 sy8ePstYn9MJRkDgIgfZXMX/C9kK8VJE1BT6Ryoe/28eLFbCZ0QjfD+C6RYeY/mJM3
	 2vh1pLyGXEC/Q==
Date: Mon, 25 Aug 2025 11:34:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/9] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <20250825113445.005f815b@jic23-huawei>
In-Reply-To: <20250820-add_newport_driver-v5-2-2fc9f13dddee@tdk.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
	<20250820-add_newport_driver-v5-2-2fc9f13dddee@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 14:24:20 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Core component of a new driver for InvenSense ICM-45600 devices.
> It includes registers definition, main probe/setup, and device
> utility functions.
> 
> ICM-456xx devices are latest generation of 6-axis IMU,
> gyroscope+accelerometer and temperature sensor. This device
> includes a 8K FIFO, supports I2C/I3C/SPI, and provides
> intelligent motion features like pedometer, tilt detection,
> and tap detection.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
Hi Remi,

A few additional comments from me.  I tried to avoid duplicating
anything Andy pointed out, but might have done so a few times.

Main comment in here is to take a look at the inline comments
and perhaps simplify or remove them if the code that follows
is basically self documenting.  Sometimes the comment can be
more confusing than the code!

Jonathan

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..94ef0ff3ccda85583101f2eaca3bc3771141505a
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h

> +/**
> + *  struct inv_icm45600_state - driver state variables
> + *  @lock:		lock for serializing multiple registers access.
> + *  @chip:		chip identifier.

run kernel-doc over the files.  It would have moaned there is no 'chip'
in here.

> + *  @map:		regmap pointer.
> + *  @vddio_supply:	I/O voltage regulator for the chip.
> + *  @orientation:	sensor chip orientation relative to main hardware.
> + *  @conf:		chip sensors configurations.
> + *  @suspended:		suspended sensors configuration.
> + *  @indio_gyro:	gyroscope IIO device.
> + *  @indio_accel:	accelerometer IIO device.
> + *  @timestamp:		interrupt timestamps.
> + *  @buffer:		data transfer buffer aligned for DMA.
> + */
> +struct inv_icm45600_state {
> +	struct mutex lock;
> +	struct regmap *map;
> +	struct regulator *vddio_supply;
> +	struct iio_mount_matrix orientation;
> +	struct inv_icm45600_conf conf;
> +	struct inv_icm45600_suspended suspended;
> +	struct iio_dev *indio_gyro;
> +	struct iio_dev *indio_accel;
> +	const struct inv_icm45600_chip_info *chip_info;
> +	struct {
> +		s64 gyro;
> +		s64 accel;
> +	} timestamp;
> +	union {
> +		u8 buff[2];
> +		__le16 u16;
> +		u8 ireg[3];
> +	} buffer __aligned(IIO_DMA_MINALIGN);
> +};

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4b8f3dad8984cfa6642b1b4c94acbb0674084f3f
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c

> +int inv_icm45600_set_accel_conf(struct inv_icm45600_state *st,
> +				struct inv_icm45600_sensor_conf *conf,
> +				unsigned int *sleep_ms)
> +{
> +	struct inv_icm45600_sensor_conf *oldconf = &st->conf.accel;
> +	unsigned int val;
> +	int ret;
> +
> +	inv_icm45600_set_default_conf(conf, oldconf);
> +
> +	/* Force the power mode against the ODR when sensor is on. */
> +	if (conf->mode > INV_ICM45600_SENSOR_MODE_STANDBY) {
> +		if (conf->odr <= INV_ICM45600_ODR_800HZ_LN) {
> +			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_NOISE;
> +		} else {
> +			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
> +			/* sanitize averaging value depending on ODR for low-power mode */
> +			/* maximum 1x @400Hz */
> +			if (conf->odr == INV_ICM45600_ODR_400HZ)
> +				conf->filter = INV_ICM45600_ACCEL_LP_AVG_SEL_1X;
> +			else
> +				conf->filter = INV_ICM45600_ACCEL_LP_AVG_SEL_4X;
> +		}
> +	}
> +
> +	/* Set ACCEL_CONFIG0 register (accel fullscale & odr). */
> +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
> +		val = FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_FS_MASK, conf->fs) |
> +		      FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_ODR_MASK, conf->odr);
> +		ret = regmap_write(st->map, INV_ICM45600_REG_ACCEL_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +		oldconf->fs = conf->fs;
> +		oldconf->odr = conf->odr;
> +	}
> +
> +	/* Set ACCEL_LP_AVG_SEL register (accel low-power average filter). */
> +	if (conf->filter != oldconf->filter) {
> +		ret = regmap_write(st->map, INV_ICM45600_IPREG_SYS2_REG_129,
> +				   conf->filter);
> +		if (ret)
> +			return ret;
> +		oldconf->filter = conf->filter;
> +	}
> +
> +	/* Set PWR_MGMT0 register (accel sensor mode). */

This is a confusing comment. I would say instead  "update the
accel sensor mode".  It actually sets both just that the gyro one is
the version we already have cached internally.

> +	return inv_icm45600_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
> +					  sleep_ms);
> +}

> +
> +static int inv_icm45600_set_conf(struct inv_icm45600_state *st,
> +				 const struct inv_icm45600_conf *conf)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* Set PWR_MGMT0 register (gyro & accel sensor mode, temp enabled). */
The registers in these comments are explicit in the code.  Perhaps focus
on the 'what' rather than the 'why'
	/* Set gyro & accel sensor modes, with temp enabled */

I'm not totally sure how temperature comes into this given no field relevant
to it is set, so maybe some more on that?

> +	val = FIELD_PREP(INV_ICM45600_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode) |
> +	      FIELD_PREP(INV_ICM45600_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
> +	ret = regmap_write(st->map, INV_ICM45600_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Set GYRO_CONFIG0 register (gyro fullscale & odr). */
Similar to above, simplify to
	/* Set gyro fullscale and odr */

Though perhaps this isn't even necessary given the obvious named fields
being set.  Basic rule of thumb is only add inline comments if they are telling
us something not trivially obvious from the code.
With that in mind, take another look at the comments throughout.


> +	val = FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_FS_MASK, conf->gyro.fs) |
> +	      FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
> +	ret = regmap_write(st->map, INV_ICM45600_REG_GYRO_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Set ACCEL_CONFIG0 register (accel fullscale & odr). */
> +	val = FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_FS_MASK, conf->accel.fs) |
> +	      FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
> +	ret = regmap_write(st->map, INV_ICM45600_REG_ACCEL_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Update the internal configuration. */

This is a bit misleading as I'd kind of expect 'internal configuration' to be
the config in the device.  Perhaps "Update cache of configuration".

> +	st->conf = *conf;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_icm45600_setup() - check and setup chip
> + *  @st:	driver internal state
> + *  @chip_info:	detected chip description
> + *  @reset:	define whether a reset is required or not
> + *  @bus_setup:	callback for setting up bus specific registers
> + *
> + *  Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm45600_setup(struct inv_icm45600_state *st,
> +				const struct inv_icm45600_chip_info *chip_info,
> +				bool reset, inv_icm45600_bus_setup bus_setup)
> +{
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	/* Set chip bus configuration if specified. */
> +	if (bus_setup) {
> +		ret = bus_setup(st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Check chip self-identification value. */
> +	ret = regmap_read(st->map, INV_ICM45600_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +	if (val != chip_info->whoami) {
> +		if (val == U8_MAX || val == 0)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "Invalid whoami %#02x expected %#02x (%s)\n",
> +					     val, chip_info->whoami, chip_info->name);
> +		else

Drop else given previous leg returned.

> +			dev_warn(dev, "Unexpected whoami %#02x expected %#02x (%s)\n",
> +				 val, chip_info->whoami, chip_info->name);
> +	}
> +
> +	st->chip_info = chip_info;
> +
> +	if (reset) {
> +		/* Reset to make sure previous state are not there. */
> +		ret = regmap_write(st->map, INV_ICM45600_REG_MISC2,
> +				   INV_ICM45600_MISC2_SOFT_RESET);
> +		if (ret)
> +			return ret;
> +		/* IMU reset time: 1ms. */
> +		fsleep(1000);
> +
> +		if (bus_setup) {
> +			ret = bus_setup(st);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = regmap_read(st->map, INV_ICM45600_REG_INT_STATUS, &val);
> +		if (ret)
> +			return ret;
> +		if (!(val & INV_ICM45600_INT_STATUS_RESET_DONE)) {
> +			dev_err(dev, "reset error, reset done bit not set\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return inv_icm45600_set_conf(st, chip_info->conf);
> +}


> +int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chip_info *chip_info,
> +				bool reset, inv_icm45600_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct fwnode_handle *fwnode;
> +	struct inv_icm45600_state *st;
> +	struct regmap *regmap_custom;
> +	int ret;
> +
> +	regmap_custom = devm_regmap_init(dev, &inv_icm45600_regmap_bus,
> +					 regmap, &inv_icm45600_regmap_config);
> +	if (IS_ERR(regmap_custom))
> +		return dev_err_probe(dev, PTR_ERR(regmap_custom), "Failed to register regmap\n");
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return dev_err_probe(dev, -ENOMEM, "Cannot allocate memory\n");
> +
> +	dev_set_drvdata(dev, st);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->map = regmap_custom;
> +
> +	ret = iio_read_mount_matrix(dev, &st->orientation);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to retrieve mounting matrix\n");
> +
> +	st->vddio_supply = devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(st->vddio_supply))
> +		return PTR_ERR(st->vddio_supply);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get vdd regulator\n");
> +
> +	/* IMU start-up time. */
> +	fsleep(100000);
> +
> +	ret = inv_icm45600_enable_regulator_vddio(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, inv_icm45600_disable_vddio_reg, st);
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm45600_setup(st, chip_info, reset, bus_setup);
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm45600_timestamp_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup runtime power management. */

Given the call that follows I'd say that comment doesn't add much. Probably drop it.

> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_get_noresume(dev);
> +	/* Suspend after 2 seconds. */
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(inv_icm45600_core_probe, "IIO_ICM45600");


