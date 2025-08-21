Return-Path: <linux-iio+bounces-23093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555DAB2F343
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C5D3AF44B
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAC2D374B;
	Thu, 21 Aug 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzVF3klE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCE2D2494;
	Thu, 21 Aug 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766976; cv=none; b=U6jMnb8STwLvJ1cEEanm8oxtWOsK5JX0wTZpr9bo/mh/XALaNHZA5x+iu0x6iOWhdw3TzEp8PmazhoAUCSF/Hv9wxMjQCDQ5ujuBFxr8wteipcITc8JG5p15lSP/qDE6jclmTeSIAjEO8muhuu4v08PJtUff5IrjkgB5dvRQXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766976; c=relaxed/simple;
	bh=5Ct1X/NWDfj1g40enmLEC9nkoZJMpOpO47zVSn/Uc7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3txPh/Bvvks9tyK8A799R0u3PHEDffPTPm+FsKRk8iREgHLYHsXQIvrxouSFGybuqhtmOpfg0Bbf2y3pN9rmd3oh6yXnoSq5YxRXj62jTunEZRCAGdqC4W0gkF1TSAXjUkevS3WEcotQiRe/IwXxzUVzfkykjObUZVPn7E+vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzVF3klE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755766974; x=1787302974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Ct1X/NWDfj1g40enmLEC9nkoZJMpOpO47zVSn/Uc7g=;
  b=bzVF3klES1BShUMJSDgTLxIVQH6e9aN7SZFUd8NLLmVnVZHxp0PCgNm8
   iUc0AtnW2C2qGVH2gCk+umaThQLOi+lfmIU/ozB4YS7asYSRk1ZsZ26wT
   sSX2ytsdQp8LXYDz/+ERGLHRsO7k+DXRFM41IQFZ4Xl4Q8QJ6BEUjhf+g
   3YZSqnZWtCZDniC9wnXvbRM23bwphCpBRIv4gteEE8ykRfzVDKv+9X/MC
   zo8XI3DS5QwtaKctBN4N8vsNxcCsuCB+HQ1JE/1ioJrYD4JiLSXMGbtiX
   YK9MoNgjd+XkGgxtqbHN5iQpyrCWUpojBUVDCTkv703VugAaZzl/RWfk8
   w==;
X-CSE-ConnectionGUID: TgAkPCMPTMmGx0UFM/IfQA==
X-CSE-MsgGUID: wfI7OLeBTvm3ah7wfi9/8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58118527"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58118527"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:02:53 -0700
X-CSE-ConnectionGUID: AHxlsIQWSeyrzXTDwXQGbg==
X-CSE-MsgGUID: gqG2rZ2xTs6EQgOdeBJomw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168279667"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:02:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1up1C4-00000007BCh-0F4P;
	Thu, 21 Aug 2025 12:02:48 +0300
Date: Thu, 21 Aug 2025 12:02:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/9] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <aKbgt_g3FsLMM8-g@smile.fi.intel.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-2-2fc9f13dddee@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add_newport_driver-v5-2-2fc9f13dddee@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 02:24:20PM +0000, Remi Buisson via B4 Relay wrote:
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

...

> +#ifndef INV_ICM45600_H_
> +#define INV_ICM45600_H_
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>
> +#include <linux/types.h>

Please, follow IWYU principle. Also, it's better to split out the IIO group as
it's part of the subsystem this driver is for.

#include <linux/bitfield.h>
#include <linux/bits.h>
#include <linux/types.h>

#include <linux/iio/common/inv_sensors_timestamp.h>
#include <linux/iio/iio.h>

(but again, the list of the headers seems incorrect / incomplete).

...

> +struct inv_icm45600_state {
> +	struct mutex lock;

No header for this.

> +	struct regmap *map;

No forward declaration.

> +	struct regulator *vddio_supply;

Ditto.

> +	struct iio_mount_matrix orientation;



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

...

> +#define INV_ICM45600_FIFO_SIZE_MAX			(8 * 1024)

SZ_8K from sizes.h ?

...

> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>

As per above, please double check for IWYU principle.

...

> +static int inv_icm45600_ireg_read(struct regmap *map, unsigned int reg,
> +				   u8 *data, size_t count)
> +{
> +	const struct device *dev = regmap_get_device(map);
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	unsigned int d;

> +	ssize_t i;

Why signed? Same comment for all similar cases.

> +	int ret;
> +
> +	st->buffer.ireg[0] = FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg);
> +	st->buffer.ireg[1] = FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg);
> +
> +	/* Burst write address. */
> +	ret = regmap_bulk_write(map, INV_ICM45600_REG_IREG_ADDR, st->buffer.ireg, 2);
> +	/* Wait while the device is busy processing the address. */
> +	fsleep(INV_ICM45600_IREG_DELAY_US);
> +	if (ret)
> +		return ret;
> +
> +	/* Read the data. */
> +	for (i = 0; i < count; i++) {
> +		ret = regmap_read(map, INV_ICM45600_REG_IREG_DATA, &d);
> +		/* Wait while the device is busy processing the data. */
> +		fsleep(INV_ICM45600_IREG_DELAY_US);
> +		if (ret)
> +			return ret;
> +		data[i] = d;
> +	}
> +
> +	return 0;
> +}

...

> +	if (FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg) == 0)

Why not using positive conditional?

> +		return regmap_bulk_read(map, FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg),
> +					val_buf, val_size);
> +
> +	return inv_icm45600_ireg_read(map, reg, val_buf, val_size);

	if (FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg))
		return inv_icm45600_ireg_read(map, reg, val_buf, val_size);

Ditto for other similar cases.

...

> +static int inv_icm45600_write(void *context, const void *data,
> +				   size_t count)

This is perfectly 1 line, please, check that the code utilises exactly 80 limit
when there is a room. It's probably a wrapping done by the (mis)configured editor.

...

> +static const struct regmap_config inv_icm45600_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,

No cache?

> +};

...

> +static const struct inv_icm45600_conf inv_icm45600_default_conf = {
> +	.gyro = {
> +		.mode = INV_ICM45600_SENSOR_MODE_OFF,
> +		.fs = INV_ICM45686_GYRO_FS_2000DPS,
> +		.odr = INV_ICM45600_ODR_800HZ_LN,
> +		.filter = INV_ICM45600_GYRO_LP_AVG_SEL_8X,
> +	},
> +	.accel = {
> +		.mode = INV_ICM45600_SENSOR_MODE_OFF,
> +		.fs = INV_ICM45686_ACCEL_FS_16G,
> +		.odr = INV_ICM45600_ODR_800HZ_LN,
> +		.filter = INV_ICM45600_ACCEL_LP_AVG_SEL_4X,
> +	},
> +};

Can you split the patch adding accel or gyro separately? I haven't checked all
the details, so it might be not worth it, just consider it.

...

> +u32 inv_icm45600_odr_to_period(enum inv_icm45600_odr odr)
> +{
> +	static const u32 odr_periods[INV_ICM45600_ODR_MAX] = {
> +		0, 0, 0,	/* reserved values */

Make it one per line as the rest.

> +		156250,		/* 6.4kHz */
> +		312500,		/* 3.2kHz */
> +		625000,		/* 1.6kHz */
> +		1250000,	/* 800kHz */
> +		2500000,	/* 400Hz */
> +		5000000,	/* 200Hz */
> +		10000000,	/* 100Hz */
> +		20000000,	/* 50Hz */
> +		40000000,	/* 25Hz */
> +		80000000,	/* 12.5Hz */
> +		160000000,	/* 6.25Hz */
> +		320000000,	/* 3.125Hz */
> +		640000000,	/* 1.5625Hz */

These seem to be times or so, can you use proper naming instead of _periods?

> +	};
> +
> +	return odr_periods[odr];
> +}

...

> +int inv_icm45600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);

> +	int ret;

Useless, just return directly.

> +	guard(mutex)(&st->lock);

> +	if (readval)
> +		ret = regmap_read(st->map, reg, readval);
> +	else
> +		ret = regmap_write(st->map, reg, writeval);
> +
> +	return ret;
> +}

...

> +/**
> + *  inv_icm45600_setup() - check and setup chip
> + *  @st:	driver internal state
> + *  @chip_info:	detected chip description
> + *  @reset:	define whether a reset is required or not
> + *  @bus_setup:	callback for setting up bus specific registers
> + *
> + *  Returns 0 on success, a negative error code otherwise.

Please, run kernel-doc validator. It's not happy (Return section is missing)

> + */

...

> +	if (val != chip_info->whoami) {
> +		if (val == U8_MAX || val == 0)

Hmm... Perhaps in_range() ?

> +			return dev_err_probe(dev, -ENODEV,
> +					     "Invalid whoami %#02x expected %#02x (%s)\n",
> +					     val, chip_info->whoami, chip_info->name);

> +		else

Redundant 'else'.

> +			dev_warn(dev, "Unexpected whoami %#02x expected %#02x (%s)\n",
> +				 val, chip_info->whoami, chip_info->name);
> +	}

...

> +		ret = regmap_write(st->map, INV_ICM45600_REG_MISC2,
> +				   INV_ICM45600_MISC2_SOFT_RESET);
> +		if (ret)
> +			return ret;
> +		/* IMU reset time: 1ms. */
> +		fsleep(1000);

Use 1 * USEC_PER_MSEC and drop useless comment after that.
You will need time.h for it.

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

...

> +static int inv_icm45600_enable_regulator_vddio(struct inv_icm45600_state *st)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(st->vddio_supply);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait a little for supply ramp. */
> +	fsleep(3000);

As per above.

> +	return 0;
> +}

...

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

There is room for 'regmap' on the previous line.

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

100 * USEC_PER_MSEC

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
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_get_noresume(dev);
> +	/* Suspend after 2 seconds. */
> +	pm_runtime_set_autosuspend_delay(dev, 2000);

2 * MSEC_PER_SEC and drop yet another useless comment.

> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put(dev);
> +
> +	return 0;
> +}

...

> +static int inv_icm45600_resume(struct device *dev)
> +{
> +	struct inv_icm45600_state *st = dev_get_drvdata(dev);
> +	int ret = 0;

Why assignment?

> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &st->lock)
> +		/* Restore sensors state. */
> +		ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
> +						st->suspended.accel, NULL);

With guard()() this whole construction will look better.

> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko



