Return-Path: <linux-iio+bounces-22798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D92B28D7D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CC217D105
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 11:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B427147D;
	Sat, 16 Aug 2025 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KocMUYbU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62B1E86E;
	Sat, 16 Aug 2025 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755344804; cv=none; b=e75HCrCA2EojxkFJEknQtEy/D7LiCDY5O7Lmcbdj+o0fF8+Wz7TJXxdjAvLU6T+Vueo12+l9Xopq1c7Hxo6y7i6BByxjRH25CpA+iOAE6q/v3i4oA2OzSqS9SkdZ5H88kWKLVPzWFLMI8D4pDs0f7vQ4f9COqx+xGv1iJkH0Qq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755344804; c=relaxed/simple;
	bh=1FVmfOCJ+0AHBlBlpMw9ZwYRde40J1MucEDpJcZAeqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqcykiRbIhxS/SyYUpi7x2yafbDxj1FiWl1fXcclkNE7Z9p3kFtgDAAzyVVoKGWMGsaQ5thR0IBhsMxJEwVAlCedBqY/xbrBh2/I4DlEirtJar925/ulfDWK5g4bQsp1Vvqs51oMrxazGrm4EHYEZgWHmHn5LEyAHKSdN/4G/ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KocMUYbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A42C4CEEF;
	Sat, 16 Aug 2025 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755344803;
	bh=1FVmfOCJ+0AHBlBlpMw9ZwYRde40J1MucEDpJcZAeqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KocMUYbUBptZAskemnUDG75AaIgs/NyHHwE5xX5GY5q+NyrEtsfRE1aUdLMQ9KW2e
	 ujmhXWf5kJIQ9M2Q022D/x/PVx0VgWeJkxKA2v/iPfJqbe3Y81otESobw+AKdk+lTp
	 WlpY+eUGWau+i4tDpEMpgXm7FAc5GDRw9NrVkUYTK4g3BKGOX7gClD2TIwPw8nBZ6H
	 mV7Zbsrzt8D5VJh0k/H/84tlctF5gmG9pNGmcHIRFjd2SiAPo5AQEhW6fz2ErmSieI
	 nN0jWymgDRaDBxU7ldVT+BChO4wk0JqpxZOM6noaSdtGhyEd9RMnskUuZsd/mkuhVV
	 SzMJrjZEZOVhQ==
Date: Sat, 16 Aug 2025 12:46:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <20250816124634.692e1b55@jic23-huawei>
In-Reply-To: <20250814-add_newport_driver-v4-2-4464b6600972@tdk.com>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
	<20250814-add_newport_driver-v4-2-4464b6600972@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 08:57:16 +0000
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

Coming together well.  A few additional comments inline from a fresh read.

Jonathan

> ---
>  drivers/iio/imu/Kconfig                          |   1 +
>  drivers/iio/imu/Makefile                         |   1 +
>  drivers/iio/imu/inv_icm45600/Kconfig             |   5 +
>  drivers/iio/imu/inv_icm45600/Makefile            |   4 +
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h      | 364 ++++++++++++
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 702 +++++++++++++++++++++++
>  6 files changed, 1077 insertions(+)


> diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..4f442b61896e91647c7947a044949792bae06a30
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +obj-$(CONFIG_INV_ICM45600) += inv-icm45600.o
> +inv-icm45600-y += inv_icm45600_core.o
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..e0304f35d32a078d4b9c260b2c6c29601583a429
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> @@ -0,0 +1,364 @@

> +struct iio_dev *inv_icm45600_gyro_init(struct inv_icm45600_state *st);
> +
> +int inv_icm45600_gyro_parse_fifo(struct iio_dev *indio_dev);
> +
> +struct iio_dev *inv_icm45600_accel_init(struct inv_icm45600_state *st);
> +
> +int inv_icm45600_accel_parse_fifo(struct iio_dev *indio_dev);

Some of this stuff isn't defined yet. Move the definitions to the patch where they are.

> +
> +#endif
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..0fdf86cdfe547357d2b74d9c97092e9a1e5722a8
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> @@ -0,0 +1,702 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (C) 2025 Invensense, Inc. */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>

Bring headers in as they are used during the patch set.
Not seeing an irqs yet.

> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +
> +#include "inv_icm45600.h"
> +
> +static int inv_icm45600_ireg_read(struct regmap *map, unsigned int reg,
> +				   u8 *data, size_t count)
> +{
> +	int ret;
> +	u8 addr[2];
> +	ssize_t i;
> +	unsigned int d;
> +
> +	addr[0] = FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg);
> +	addr[1] = FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg);
> +
> +	/* Burst write address. */
> +	ret = regmap_bulk_write(map, INV_ICM45600_REG_IREG_ADDR, addr, sizeof(addr));

addr is on the stack, so not DMA safe for the bulk write.  I haven't checked
though if you have it bounced in the regmap implementation.

> +	/* Wait while the device is busy processing the address. */
> +	fsleep(INV_ICM45600_IREG_DELAY_US);
> +	if (ret)
> +		return ret;



> +u32 inv_icm45600_odr_to_period(enum inv_icm45600_odr odr)
> +{
> +	static u32 odr_periods[INV_ICM45600_ODR_MAX] = {
> +		/* reserved values */
> +		0, 0, 0,
> +		/* 6.4kHz */

Given very short comments, perhaps
		0, 0, 0, /* reserved */
		156250, /* 6.4kHz */
etc, just to reduce screen scrolling.

Also, might as well mark it const.


> +		156250,
> +		/* 3.2kHz */
> +		312500,
> +		/* 1.6kHz */
> +		625000,
> +		/* 800kHz */
> +		1250000,
> +		/* 400Hz */
> +		2500000,
> +		/* 200Hz */
> +		5000000,
> +		/* 100Hz */
> +		10000000,
> +		/* 50Hz */
> +		20000000,
> +		/* 25Hz */
> +		40000000,
> +		/* 12.5Hz */
> +		80000000,
> +		/* 6.25Hz */
> +		160000000,
> +		/* 3.125Hz */
> +		320000000,
> +		/* 1.5625Hz */
> +		640000000,
> +	};
> +
> +	return odr_periods[odr];
> +}
> +
> +static int inv_icm45600_set_pwr_mgmt0(struct inv_icm45600_state *st,
> +				      enum inv_icm45600_sensor_mode gyro,
> +				      enum inv_icm45600_sensor_mode accel,
> +				      unsigned int *sleep_ms)
> +{
> +	enum inv_icm45600_sensor_mode oldgyro = st->conf.gyro.mode;
> +	enum inv_icm45600_sensor_mode oldaccel = st->conf.accel.mode;
> +	unsigned int sleepval;
> +	unsigned int val;
> +	int ret;
> +
> +	/* if nothing changed, exit */
> +	if (gyro == oldgyro && accel == oldaccel)
> +		return 0;
> +
> +	val = FIELD_PREP(INV_ICM45600_PWR_MGMT0_GYRO_MODE_MASK, gyro) |
> +	      FIELD_PREP(INV_ICM45600_PWR_MGMT0_ACCEL_MODE_MASK, accel);
> +	ret = regmap_write(st->map, INV_ICM45600_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	st->conf.gyro.mode = gyro;
> +	st->conf.accel.mode = accel;
> +
> +	/* Compute the required wait time for sensors to stabilize. */
> +	sleepval = 0;
> +
> +	/* Accel startup time. */
> +	if (accel != oldaccel && oldaccel == INV_ICM45600_SENSOR_MODE_OFF) {
> +		if (sleepval < INV_ICM45600_ACCEL_STARTUP_TIME_MS)
> +			sleepval = INV_ICM45600_ACCEL_STARTUP_TIME_MS;

		sleepval = max(sleepval, INV_ICM...

> +	}
> +	if (gyro != oldgyro) {
> +		/* Gyro startup time. */
> +		if (oldgyro == INV_ICM45600_SENSOR_MODE_OFF) {
> +			if (sleepval < INV_ICM45600_GYRO_STARTUP_TIME_MS)
> +				sleepval = INV_ICM45600_GYRO_STARTUP_TIME_MS;
similar
> +		/* Gyro stop time. */
> +		} else if (gyro == INV_ICM45600_SENSOR_MODE_OFF) {
> +			if (sleepval < INV_ICM45600_GYRO_STOP_TIME_MS)
> +				sleepval =  INV_ICM45600_GYRO_STOP_TIME_MS;
and here as well.

> +		}
> +	}
> +
> +	/* Deferred sleep value if sleep pointer is provided or direct sleep */
> +	if (sleep_ms)
> +		*sleep_ms = sleepval;
> +	else if (sleepval)
> +		msleep(sleepval);
> +
> +	return 0;
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
> +	/* Get INT1 only supported interrupt. */

Not seeing relevance of comment to this code.

> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode)

Why do you need to check this here, rather than just letting it fail later?

> +		return dev_err_probe(dev, -ENODEV, "Missing FW node\n");
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
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);

You may need to enforce runtime PM being enabled / built or add some fallback code.
I think right now vddio will never be turned on if we have runtime PM disabled.

That then leads into annoyingly fiddly code to turn it off again as we have
to verify it isn't already off due to runtime pm in the path that is only there
for non runtime pm.

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
No explicit 'check' any more.  force suspend is dealing with that
for you, so probably drop this doc or maybe update it.
> + */
> +static int inv_icm45600_suspend(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	scoped_guard(mutex, &st->lock) {
> +
drop this blank line.

> +		st->suspended.gyro = st->conf.gyro.mode;
> +		st->suspended.accel = st->conf.accel.mode;
> +	}
> +
> +	return pm_runtime_force_suspend(dev);
> +}
> +
> +/*
> + * System resume gets the system back on and restores the sensors state.
> + * Manually put runtime power management in system active state.
> + */
> +static int inv_icm45600_resume(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> +	struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);

Bring these in when they are needed.  Probably next patch but I haven't checked.

> +	int ret = 0;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &st->lock)
> +		/* Restore sensors state. */
> +		ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
> +						st->suspended.accel, NULL);
> +
> +	return ret;
> +}


