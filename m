Return-Path: <linux-iio+bounces-21990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B7B10F39
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 17:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19475664D7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F02EA475;
	Thu, 24 Jul 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE3L3Rrf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E292E041A;
	Thu, 24 Jul 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372572; cv=none; b=UixnNJmBA85ahkoeC3tRScwCAqU0Ezt/bTmKDeL2lKuNd4OPkOBB7jNc9yobuUDQCM6pewwZzkoFO4pPX1dNbPCg2dUDd754baMHh+Zop70ES5XQtPYrYq1lPO2PC7+log1fYHDP8Jvd/caLPPomOlq09Wnvn191VIXWZbOVTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372572; c=relaxed/simple;
	bh=CZ8q0gBxMvXs9EgFgonDcz2pD1xsL8S1lNoStDKE+g0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFBI8JdPpMGz3KSeqA2XfnNThrQvn7acdA8rPCJ4mQnopnTFft42WvkEjq5sFkLoNoAMTOgbCZDxyNT/gqzM4uxvYwrKTxmcVgQfUJfKuzSblfbjCbXfFcsspz0quo6lb+dKMAJfodkARMckox6hNPY/YjrL2aPaHHRZ5QJsYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE3L3Rrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9AAC4CEED;
	Thu, 24 Jul 2025 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372571;
	bh=CZ8q0gBxMvXs9EgFgonDcz2pD1xsL8S1lNoStDKE+g0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JE3L3Rrfd8NHgv4hM6qCsIYxLCMm2J8HhDCmsZrL7aCpxCYvha7W4D7tsnlGrE0RB
	 0BepMiOMvt0syDrRiLsRjaXnlH5F2BS9sZBNediRGCNQNy6qK9DNyb735jSkkWlNZI
	 8XRK8GAC2GE4ct2lxWG5Z70lcHB43oyH9VZLjDIcEO9+RCXPG6aarJfdbwdbGDVXPm
	 0apFZ//eTzjjA26WhDSzD77mReqDQiTLxKLJAtQLzvfRyt+m8D45G8Vt3SaTSApvJs
	 ykSRKewLAJjahAH0ML343Zj9hhcsNZr6epU/p1dg+vnaraaeb/VvmL21QKadRwFlNb
	 LEx1k/RvgEgkg==
Date: Thu, 24 Jul 2025 16:56:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <20250724165605.7bfe9447@jic23-huawei>
In-Reply-To: <20250717-add_newport_driver-v3-2-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
	<20250717-add_newport_driver-v3-2-c6099e02c562@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:25:54 +0000
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

A few minor comments inline.

Thanks,

Jonathan


> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..59aed59b94ca2d4709b0c986ddeda80b33064f90
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h

> +};

> +
> +/* all sensor data are 16 bits (2 registers wide) in big-endian */
> +#define INV_ICM45600_REG_TEMP_DATA			0x000C
> +#define INV_ICM45600_REG_ACCEL_DATA_X			0x0000
> +#define INV_ICM45600_REG_ACCEL_DATA_Y			0x0002
> +#define INV_ICM45600_REG_ACCEL_DATA_Z			0x0004
> +#define INV_ICM45600_REG_GYRO_DATA_X			0x0006
> +#define INV_ICM45600_REG_GYRO_DATA_Y			0x0008
> +#define INV_ICM45600_REG_GYRO_DATA_Z			0x000A
> +#define INV_ICM45600_DATA_INVALID			-32768
That's all Fs.  GENMASK maybe?





> +int inv_icm45600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval);
> +
> +int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chip_info *chip_info,
Very long line.  Try to keep to 80 chars unless readability badly hurt (then it's fine to go a little
above Tthat)

> +				bool reset, inv_icm45600_bus_setup bus_setup);
> +
> +struct iio_dev *inv_icm45600_gyro_init(struct inv_icm45600_state *st);
> +
> +int inv_icm45600_gyro_parse_fifo(struct iio_dev *indio_dev);
> +
> +struct iio_dev *inv_icm45600_accel_init(struct inv_icm45600_state *st);
> +
> +int inv_icm45600_accel_parse_fifo(struct iio_dev *indio_dev);
> +
> +#endif
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b961f774e54d0ad109b4ed19eec1cd9b65803c96
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c

> +
> +int inv_icm45600_set_gyro_conf(struct inv_icm45600_state *st,
> +			       struct inv_icm45600_sensor_conf *conf,
> +			       unsigned int *sleep_ms)
> +{
> +	struct inv_icm45600_sensor_conf *oldconf = &st->conf.gyro;
> +	unsigned int val;
> +	int ret;
> +
> +	/* Sanitize missing values with current values. */
> +	if (conf->mode == U8_MAX)
> +		conf->mode = oldconf->mode;
> +	if (conf->fs == U8_MAX)
> +		conf->fs = oldconf->fs;
> +	if (conf->odr == U8_MAX)
> +		conf->odr = oldconf->odr;
> +	if (conf->filter == U8_MAX)
> +		conf->filter = oldconf->filter;

Maybe worth factoring out this bit of code filling in current values as I think
it's used twice.

> +
> +	/* Force the power mode against ODR when sensor is on. */
> +	if (conf->mode > INV_ICM45600_SENSOR_MODE_STANDBY) {
> +		if (conf->odr >= INV_ICM45600_ODR_6_25HZ_LP) {
> +			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
> +			conf->filter = INV_ICM45600_GYRO_LP_AVG_SEL_8X;
> +		} else {
> +			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_NOISE;
> +		}
> +	}
> +
> +	/* Set GYRO_CONFIG0 register (gyro fullscale & odr). */
> +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
> +		val = FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_FS_MASK, conf->fs) |
> +		      FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_ODR_MASK, conf->odr);
> +		ret = regmap_write(st->map, INV_ICM45600_REG_GYRO_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +		oldconf->fs = conf->fs;
> +		oldconf->odr = conf->odr;
> +	}
> +
> +	/* Set GYRO_LP_AVG_SEL register (gyro low-power average filter). */
> +	if (conf->filter != oldconf->filter) {
> +		val = FIELD_PREP(INV_ICM45600_IPREG_SYS1_170_GYRO_LP_AVG_MASK, conf->filter);
> +		ret = regmap_update_bits(st->map, INV_ICM45600_IPREG_SYS1_REG_170,
> +			INV_ICM45600_IPREG_SYS1_170_GYRO_LP_AVG_MASK, val);
> +		if (ret)
> +			return ret;
> +		oldconf->filter = conf->filter;
> +	}
> +
> +	/* Set PWR_MGMT0 register (gyro sensor mode). */
> +	return inv_icm45600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
> +					  sleep_ms);
> +}
>

> +static int inv_icm45600_enable_regulator_vddio(struct inv_icm45600_state *st)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(st->vddio_supply);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait a little for supply ramp. */
> +	usleep_range(3000, 4000);

fsleep probably appropriate here.

> +
> +	return 0;
> +}
> +
> +static void inv_icm45600_disable_vddio_reg(void *_data)
> +{
> +	regulator_disable((struct regulator *) _data);
> +}
> +
> +int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chip_info *chip_info,
> +				bool reset, inv_icm45600_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct fwnode_handle *fwnode;
> +	struct inv_icm45600_state *st;
> +	struct regmap *regmap_custom;
> +	int irq, irq_type;
> +	bool open_drain;
> +	int ret;
> +
> +	/* Get INT1 only supported interrupt. */
> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode)
> +		return dev_err_probe(dev, -ENODEV, "Missing FW node\n");
> +
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err_probe(dev, irq, "Missing INT1 interrupt\n");
> +		return irq;
> +	}
> +
> +	irq_type = irq_get_trigger_type(irq);

Better to introduce this irq type etc when you use them.  That's probably the next patch?
 

> +
> +	open_drain = device_property_read_bool(dev, "drive-open-drain");
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
> +	ret = devm_add_action_or_reset(dev, inv_icm45600_disable_vddio_reg, st->vddio_supply);

I suspect you'll get an underflow on the vddio regulator enabled count if you remove
the driver in whilst runtime suspended.  Avoiding that may require a dance where
you force it out of runtime suspend at time of disabling runtime pm. 

> +	if (ret)
> +		return ret;
> +
> +	/* Setup chip registers. */
I don't see the comment as adding much - so probably drop it.

> +	ret = inv_icm45600_setup(st, chip_info, reset, bus_setup);
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm45600_timestamp_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup runtime power management. */
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
> +
> +/*
> + * Suspend saves sensors state and turns everything off.
> + * Check first if runtime suspend has not already done the job.
> + */
> +static int inv_icm45600_suspend(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	st->suspended.gyro = st->conf.gyro.mode;
> +	st->suspended.accel = st->conf.accel.mode;

Can you use pm_runtime_force_suspend() here.  That basically calls the
runtime suspend callback (safely) if we are not already runtime suspended.

Pair it with pm_runtime_force_resume()

You will need to be careful with locking though. Probably fine to just
unlock the mutex before calling that.


> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
> +					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
> +	if (ret)
> +		return ret;
> +
> +	regulator_disable(st->vddio_supply);
> +
> +	return 0;
> +}
> +
> +/*
> + * System resume gets the system back on and restores the sensors state.
> + * Manually put runtime power management in system active state.
> + */
> +static int inv_icm45600_resume(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +
> +	ret = inv_icm45600_enable_regulator_vddio(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore sensors state. */
> +	return inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
> +					 st->suspended.accel, NULL);
> +
> +}
> +
> +/* Runtime suspend will turn off sensors that are enabled by iio devices. */
> +static int inv_icm45600_runtime_suspend(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* disable all sensors */
> +	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
> +					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
> +	if (ret)
> +		return ret;
> +
> +	regulator_disable(st->vddio_supply);
> +
> +	return 0;
> +}
> +
> +/* Sensors are enabled by iio devices, no need to turn them back on here. */
> +static int inv_icm45600_runtime_resume(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	return inv_icm45600_enable_regulator_vddio(st);
> +}
> +
> +EXPORT_NS_GPL_DEV_PM_OPS(inv_icm45600_pm_ops, IIO_ICM45600) = {
> +	SET_SYSTEM_SLEEP_PM_OPS(inv_icm45600_suspend, inv_icm45600_resume)
> +	SET_RUNTIME_PM_OPS(inv_icm45600_runtime_suspend,
> +			   inv_icm45600_runtime_resume, NULL)
> +};
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-456xx device driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");
> 


