Return-Path: <linux-iio+bounces-21625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76374B031FC
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF5D189B1BE
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3127FD4B;
	Sun, 13 Jul 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGYRc409"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52D27978B;
	Sun, 13 Jul 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422425; cv=none; b=XgBPh0svDRWaWJI9CPFMx9QB7eWfh3j5WPTSmcO7ee3s6JsmUbqAwUT2fn9VFOYKxpplchON3WTaGbY0UfjKDoQUj9TxtV/EIboXhUIma8/jrq50Sv2p3hChEkVwrIWj1OiSmeRKbLbK6A63C5mQ9iU+o8bMlb7QBkQk2MM5tMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422425; c=relaxed/simple;
	bh=QVpgt7ejP/68Fji1tYkihxdSQit1eMmvTCjE0UwVnNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSvof+wfM5TIpenT7cM075vvQgsTb+Ycd+DdiC1/D3NzPT7IC/mkcHCkKF+bCGRI7vtsGIyLJ5vwMQZs03SYxOlhRhphOtPyeEJgXWuTeRYKqBaz54BP6gEL/PZu2HCacEBmMVZCaRoco2vTr52QYiiytpw5fn2W3ahseHQu/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGYRc409; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D7CC4CEE3;
	Sun, 13 Jul 2025 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752422425;
	bh=QVpgt7ejP/68Fji1tYkihxdSQit1eMmvTCjE0UwVnNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JGYRc409LCl3uj00A7KIASInqqZdM0hiOx4f37cpaul9KWPw0eB+uXKXEEg2npmBz
	 03lQFtqfOUYhXGTOphkLaegP0iJ4eYjIOYa4E1NoUxl2OGsd1NvsYXBaaVxNgVMJSS
	 tD5Ob7ICwaH8N2id6LRQRRZRbM9YGkqaWb7nk1/ATiUvMRtamXlolUpXMJg0f1oTJ0
	 TvvAuXRzVRcLm5FFhGQiO83IYk0Nscvn73JSgzw5u+03vwyUTr8GjBk9oJ0q4USMME
	 RCclqy6X02OzhVS5yuE/xqcaKdofxKp/gu4ZHAVwQWl98MkNKGjDdD7IQv7BjJs2ui
	 2WgJaO15rnTuw==
Date: Sun, 13 Jul 2025 17:00:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Sean Nyekjaer
 <sean@geanix.com>
Subject: Re: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <20250713170017.3e4ad51c@jic23-huawei>
In-Reply-To: <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
	<20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 08:57:57 +0000
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

A few minor things inline.  Given Sean has been looking at a closely
related driver and you have some of the things he's been fixing up
I +CC Sean on off chance he has time to take a look at this.

> ---
>  drivers/iio/imu/Kconfig                          |   1 +
>  drivers/iio/imu/Makefile                         |   1 +
>  drivers/iio/imu/inv_icm45600/Kconfig             |   5 +
>  drivers/iio/imu/inv_icm45600/Makefile            |   4 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h      | 364 +++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 734 +++++++++++++++++++++++
>  6 files changed, 1109 insertions(+)
>
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..d56de75ab7f2168f22e25b5816cb361bef457c0d
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> @@ -0,0 +1,364 @@

> +struct inv_icm45600_sensor_conf {
> +	int mode;
> +	int fs;
> +	int odr;
> +	int filter;
> +};
> +#define INV_ICM45600_SENSOR_CONF_INIT		{-1, -1, -1, -1}

+#define INV_ICM45600_SENSOR_CONF_INIT		{ -1, -1, -1, -1, }

Though I'm not sure the define is that useful vs pushing this down into the code.


> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..022eb9180b5a750e8fba4a1cd873041c27f59880
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c

> +static int inv_icm45600_read(void *context, const void *reg_buf, size_t reg_size,
> +			  void *val_buf, size_t val_size)
> +{
> +	unsigned int reg = (unsigned int) be16_to_cpup(reg_buf);

Why is the cast needed? It's a u16 so why not keep it like that?

> +	struct regmap *map = context;
> +
> +	if (FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg) == 0)
> +		return regmap_bulk_read(map, FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg),
> +						val_buf, val_size);
> +
> +	return inv_icm45600_ireg_read(map, reg, val_buf, val_size);
> +}
> +
> +static int inv_icm45600_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	u8 *d = (u8 *)data;
	const u8 *d = data;
should be fine.

> +	unsigned int reg = (unsigned int) be16_to_cpup(data);

u16

> +	struct regmap *map = context;
> +
> +	if (FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg) == 0)
> +		return regmap_bulk_write(map, FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg),
> +					d + 2, count - 2);
> +
> +	return inv_icm45600_ireg_write(map, reg, d + 2, count - 2);
> +}

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
> +		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",

This should be relaxed to a dev_info and carry on anyway. The reasoning
for this is fallback compatibles in DT.  If a new compatible chip
with a different whoami value comes along we still want it to run
with older kernels so we use fallback compatibles.  Unfortunately the
ID won't match.

> +			val, chip_info->whoami, chip_info->name);
> +		return -ENODEV;
> +	}
> +
> +	st->chip_info = chip_info;
> +
> +	if (reset) {
> +		/* Reset to make sure previous state are not there. */
> +		ret = regmap_write(st->map, INV_ICM45600_REG_MISC2,
> +				INV_ICM45600_MISC2_SOFT_RESET);
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

> +
> +static void inv_icm45600_disable_vddio_reg(void *_data)
> +{
> +	struct inv_icm45600_state *st = _data;
> +	const struct device *dev = regmap_get_device(st->map);
> +	int ret;
> +
> +	ret = regulator_disable(st->vddio_supply);
> +	if (ret)
> +		dev_err(dev, "failed to disable vddio error %d\n", ret);

As per Sean's set - is this useful given such failures are already noisy.


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
> +		return ret;
> +	/* IMU start-up time. */
> +	msleep(100);
> +
> +	ret = inv_icm45600_enable_regulator_vddio(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, inv_icm45600_disable_vddio_reg, st);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup chip registers. */
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

See below. Sean also reworks this. + I suggested he look at
devm_pm_runtime_enable but the set active version seems even better.
 
I'm not setting the gets and puts I'd expect for working runtime PM though.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(inv_icm45600_core_probe, "IIO_ICM45600");

> +
> +/*
> + * System resume gets the system back on and restores the sensors state.
> + * Manually put runtime power management in system active state.
> + */
> +static int inv_icm45600_resume(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm45600_enable_regulator_vddio(st);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
Take a look at 
https://lore.kernel.org/all/20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com/

It would be good if you an review Sean's series as well as applying anything
you agree with here.  For example he got rid of the 3 lines above.

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

