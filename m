Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66F93F46B2
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhHWIgZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 04:36:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:8425 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235651AbhHWIgY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Aug 2021 04:36:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="217087674"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="217087674"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 01:35:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="574577002"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 01:35:29 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mI5QR-00CiGX-Cn; Mon, 23 Aug 2021 11:35:23 +0300
Date:   Mon, 23 Aug 2021 11:35:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3.1 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <YSNdywXOuzYMCbJa@smile.fi.intel.com>
References: <20210822184927.94673-3-jacopo@jmondi.org>
 <20210823073639.13688-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823073639.13688-1-jacopo@jmondi.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 23, 2021 at 09:36:39AM +0200, Jacopo Mondi wrote:
> Add support for the Senseair Sunrise 006-0-0007 driver through the
> IIO subsystem.

Thanks for this intermediate update, looks much better.
So, there are a few comments below and we are almost ready.

> Datasheet: https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
> v3->v3.1
> - Remove debug leftover
> - Re-add commas at the end of arrays declarations
> ---
>  MAINTAINERS                        |   6 +
>  drivers/iio/chemical/Kconfig       |  13 +
>  drivers/iio/chemical/Makefile      |   1 +
>  drivers/iio/chemical/sunrise_co2.c | 448 +++++++++++++++++++++++++++++
>  4 files changed, 468 insertions(+)
>  create mode 100644 drivers/iio/chemical/sunrise_co2.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90ca9df1d3c3..43f5bba46673 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16544,6 +16544,12 @@ S:	Maintained
>  F:	drivers/misc/phantom.c
>  F:	include/uapi/linux/phantom.h
> 
> +SENSEAIR SUNRISE 006-0-0007
> +M:	Jacopo Mondi <jacopo@jmondi.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> +F:	drivers/iio/chemical/sunrise_co2.c
> +
>  SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
>  M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
>  S:	Maintained
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 10bb431bc3ce..ee8562949226 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -144,6 +144,19 @@ config SPS30
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called sps30.
> 
> +config SENSEAIR_SUNRISE_CO2
> +	tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
> +	depends on OF
> +	depends on I2C
> +	depends on SYSFS
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
> +	  sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sunrise_co2.
> +
>  config VZ89X
>  	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
>  	depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index fef63dd5bf92..d5e2a3331d57 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -17,4 +17,5 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
>  obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
>  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
>  obj-$(CONFIG_SPS30) += sps30.o
> +obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
>  obj-$(CONFIG_VZ89X)		+= vz89x.o
> diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
> new file mode 100644
> index 000000000000..84f19df6fc00
> --- /dev/null
> +++ b/drivers/iio/chemical/sunrise_co2.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Senseair Sunrise 006-0-0007 CO2 sensor driver.
> + *
> + * Copyright (C) 2021 Jacopo Mondi
> + *
> + * List of features not yet supported by the driver:
> + * - controllable EN pin
> + * - single-shot operations using the nDRY pin.
> + * - ABC/target calibration
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/time64.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

> +#define DRIVER_NAME "sunrise"

I would expect "sunrise_co2" here.

Also, since it's one time use, please drop the definition completely and use
literal in-place.

> +#define SUNRISE_ERROR_STATUS_REG		0x00
> +#define SUNRISE_CO2_FILTERED_COMP_REG		0x06
> +#define SUNRISE_CHIP_TEMPERATURE_REG		0x08
> +#define SUNRISE_CALIBRATION_STATUS_REG		0x81
> +#define SUNRISE_CALIBRATION_COMMAND_REG		0x82
> +#define SUNRISE_CALIBRATION_FACTORY_CMD		0x7c02
> +#define SUNRISE_CALIBRATION_BACKGROUND_CMD	0x7c06
> +/*
> + * The calibration timeout is not characterized in the datasheet.
> + * Use 30 seconds as a reasonable upper limit.
> + */
> +#define SUNRISE_CALIBRATION_TIMEOUT_US		(30 * USEC_PER_SEC)
> +
> +enum sunrise_calib {
> +	SUNRISE_CALIBRATION_FACTORY,
> +	SUNRISE_CALIBRATION_BACKGROUND,
> +};
> +
> +struct sunrise_dev {
> +	struct device *dev;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct mutex lock;
> +	enum sunrise_calib calibration;
> +};
> +
> +static void sunrise_wakeup(struct sunrise_dev *sunrise)
> +{
> +	struct i2c_client *client = sunrise->client;
> +
> +	/*
> +	 * Wake up sensor by sending sensor address: START, sensor address,
> +	 * STOP. Sensor will not ACK this byte.
> +	 *
> +	 * The chip returns in low power state after 15msec without
> +	 * communications or after a complete read/write sequence.
> +	 */
> +	i2c_smbus_xfer(client->adapter, client->addr, I2C_M_IGNORE_NAK,
> +		       I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> +}
> +
> +static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
> +{
> +	__be16 be_val;
> +	int ret;
> +
> +	sunrise_wakeup(sunrise);
> +	ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, 2);
> +	if (ret) {
> +		dev_err(sunrise->dev, "Read word failed: reg 0x%2x (%d)\n", reg, ret);
> +		return ret;
> +	}
> +
> +	*val = be16_to_cpu(be_val);
> +
> +	return 0;
> +}
> +
> +static int sunrise_write_byte(struct sunrise_dev *sunrise, u8 reg, u8 val)
> +{
> +	int ret;
> +
> +	sunrise_wakeup(sunrise);
> +	ret = regmap_write(sunrise->regmap, reg, val);
> +	if (ret) {
> +		dev_err(sunrise->dev, "Write byte failed: reg 0x%2x (%d)\n", reg, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> +{
> +	__be16 be_data = cpu_to_be16(data);
> +	int ret;
> +
> +	sunrise_wakeup(sunrise);
> +	ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, 2);
> +	if (ret) {
> +		dev_err(sunrise->dev, "Write word failed: reg 0x%2x (%d)\n", reg, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + *  --- Calibration ---
> + *
> + *  Enumerate and select calibration modes, trigger a calibration cycle.
> + */
> +static const char * const sunrise_calibration_modes[] = {
> +	[SUNRISE_CALIBRATION_FACTORY] = "factory_calibration",
> +	[SUNRISE_CALIBRATION_BACKGROUND] = "background_calibration",
> +};
> +
> +static const struct sunrise_calibration_data {
> +	u16 calibration_cmd;
> +	u8 calibration_bit;
> +} sunrise_calibrations[] = {
> +	[SUNRISE_CALIBRATION_FACTORY] = {
> +		SUNRISE_CALIBRATION_FACTORY_CMD,
> +		BIT(2),
> +	},
> +	[SUNRISE_CALIBRATION_BACKGROUND] = {
> +		SUNRISE_CALIBRATION_BACKGROUND_CMD,
> +		BIT(5),
> +	},
> +};
> +
> +static int sunrise_calibrate(struct sunrise_dev *sunrise)
> +{
> +	const struct sunrise_calibration_data *data;
> +	unsigned int status;
> +	int ret;
> +
> +	/* Reset the calibration status reg. */
> +	ret = sunrise_write_byte(sunrise, SUNRISE_CALIBRATION_STATUS_REG, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	/* Write a calibration command and poll the calibration status bit. */
> +	data = &sunrise_calibrations[sunrise->calibration];
> +	ret = sunrise_write_word(sunrise, SUNRISE_CALIBRATION_COMMAND_REG,
> +				 data->calibration_cmd);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(sunrise->dev, "%s in progress\n",
> +		sunrise_calibration_modes[sunrise->calibration]);
> +
> +	return regmap_read_poll_timeout(sunrise->regmap,
> +					SUNRISE_CALIBRATION_STATUS_REG,
> +					status, status & data->calibration_bit,
> +					100, SUNRISE_CALIBRATION_TIMEOUT_US);
> +}
> +
> +static ssize_t sunrise_calibration_write(struct iio_dev *iiodev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> +	bool calibrate;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &calibrate);
> +	if (ret)
> +		return ret;
> +
> +	if (!calibrate)
> +		return 0;
> +
> +	ret = sunrise_calibrate(sunrise);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static int sunrise_set_calibration_mode(struct iio_dev *iiodev,
> +					const struct iio_chan_spec *chan,
> +					unsigned int mode)
> +{
> +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> +
> +	mutex_lock(&sunrise->lock);
> +	sunrise->calibration = mode;
> +	mutex_unlock(&sunrise->lock);
> +
> +	return 0;
> +}
> +
> +static int sunrise_get_calibration_mode(struct iio_dev *iiodev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> +	int mode;
> +
> +	mutex_lock(&sunrise->lock);
> +	mode = sunrise->calibration;
> +	mutex_unlock(&sunrise->lock);
> +
> +	return mode;
> +}
> +
> +static const struct iio_enum sunrise_calibration_modes_enum = {
> +	.items = sunrise_calibration_modes,
> +	.num_items = ARRAY_SIZE(sunrise_calibration_modes),
> +	.set = sunrise_set_calibration_mode,
> +	.get = sunrise_get_calibration_mode,
> +};
> +
> +/* --- Error status---
> + *
> + * Enumerate and retrieve the chip error status.
> + */
> +enum {
> +	SUNRISE_ERROR_FATAL,
> +	SUNRISE_ERROR_I2C,
> +	SUNRISE_ERROR_ALGORITHM,
> +	SUNRISE_ERROR_CALIBRATION,
> +	SUNRISE_ERROR_SELF_DIAGNOSTIC,
> +	SUNRISE_ERROR_OUT_OF_RANGE,
> +	SUNRISE_ERROR_MEMORY,
> +	SUNRISE_ERROR_NO_MEASUREMENT,
> +	SUNRISE_ERROR_LOW_VOLTAGE,
> +	SUNRISE_ERROR_MEASUREMENT_TIMEOUT,
> +};
> +
> +static const char * const sunrise_error_statuses[] = {
> +	[SUNRISE_ERROR_FATAL] = "error_fatal",
> +	[SUNRISE_ERROR_I2C] = "error_i2c",
> +	[SUNRISE_ERROR_ALGORITHM] = "error_algorithm",
> +	[SUNRISE_ERROR_CALIBRATION] = "error_calibration",
> +	[SUNRISE_ERROR_SELF_DIAGNOSTIC] = "error_self_diagnostic",
> +	[SUNRISE_ERROR_OUT_OF_RANGE] = "error_out_of_range",
> +	[SUNRISE_ERROR_MEMORY] = "error_memory",
> +	[SUNRISE_ERROR_NO_MEASUREMENT] = "error_no_measurement",
> +	[SUNRISE_ERROR_LOW_VOLTAGE] = "error_low_voltage",
> +	[SUNRISE_ERROR_MEASUREMENT_TIMEOUT] = "error_measurement_timeout",
> +};
> +
> +static const u8 error_codes[] = {
> +	SUNRISE_ERROR_FATAL,
> +	SUNRISE_ERROR_I2C,
> +	SUNRISE_ERROR_ALGORITHM,
> +	SUNRISE_ERROR_CALIBRATION,
> +	SUNRISE_ERROR_SELF_DIAGNOSTIC,
> +	SUNRISE_ERROR_OUT_OF_RANGE,
> +	SUNRISE_ERROR_MEMORY,
> +	SUNRISE_ERROR_NO_MEASUREMENT,
> +	SUNRISE_ERROR_LOW_VOLTAGE,
> +	SUNRISE_ERROR_MEASUREMENT_TIMEOUT,
> +};
> +
> +static const struct iio_enum sunrise_error_statuses_enum = {
> +	.items = sunrise_error_statuses,
> +	.num_items = ARRAY_SIZE(sunrise_error_statuses),
> +};
> +
> +static ssize_t sunrise_error_status_read(struct iio_dev *iiodev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 char *buf)
> +{
> +	struct sunrise_dev *sunrise = iio_priv(iiodev);
> +	const unsigned long *errors;
> +	ssize_t len = 0;
> +	u16 value;
> +	int ret;
> +	u8 i;
> +
> +	ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
> +	if (ret)
> +		return -EINVAL;
> +
> +	errors = (const unsigned long *)&value;

Yes, it takes a pointer, but in your case it will oops the kernel quite likely.

	unsigned long errors;

	...

	errors = value;
	for_each_set_bit(..., &errors, ...)

> +	for_each_set_bit(i, errors, ARRAY_SIZE(error_codes))
> +		len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);
> +
> +	if (len)
> +		buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
> +	/* Calibration modes and calibration trigger. */
> +	{
> +		.name = "calibration",
> +		.write = sunrise_calibration_write,
> +		.shared = IIO_SEPARATE,
> +	},
> +	IIO_ENUM("calibration_mode", IIO_SEPARATE,
> +		 &sunrise_calibration_modes_enum),
> +	IIO_ENUM_AVAILABLE("calibration_mode",
> +			   &sunrise_calibration_modes_enum),
> +
> +	/* Error statuses. */
> +	{
> +		.name = "error_status",
> +		.read = sunrise_error_status_read,
> +		.shared = IIO_SEPARATE
> +	},
> +	IIO_ENUM_AVAILABLE("error_status", &sunrise_error_statuses_enum),
> +	{}
> +};
> +
> +static const struct iio_chan_spec sunrise_channels[] = {
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_CO2,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.ext_info = sunrise_concentration_ext_info,
> +		.scan_index = 0,
> +		.scan_type =  {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
> +				       BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type =  {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +};
> +
> +static int sunrise_read_raw(struct iio_dev *iio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct sunrise_dev *sunrise = iio_priv(iio_dev);
> +	u16 value;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&sunrise->lock);
> +
> +		switch (chan->type) {
> +		case IIO_CONCENTRATION:
> +			ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
> +						&value);
> +			*val = value;
> +			mutex_unlock(&sunrise->lock);
> +
> +			return ret ?: IIO_VAL_INT;
> +
> +		case IIO_TEMP:
> +			ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
> +						&value);
> +			*val = value;
> +			mutex_unlock(&sunrise->lock);
> +
> +			return ret ?: IIO_VAL_INT;
> +
> +		default:
> +			mutex_unlock(&sunrise->lock);
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Chip temperature scale = 1/100 */
> +		*val = 1;
> +		*val2 = 100;
> +		return IIO_VAL_FRACTIONAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info sunrise_info = {
> +	.read_raw = sunrise_read_raw,
> +};
> +
> +static struct regmap_config sunrise_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,

Does it need a lock?
(I think it does, but I would like to confirm)

> +};
> +
> +static int sunrise_probe(struct i2c_client *client)
> +{
> +	struct sunrise_dev *sunrise;
> +	struct iio_dev *iio_dev;
> +
> +	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sunrise));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, iio_dev);
> +
> +	sunrise = iio_priv(iio_dev);
> +	sunrise->client = client;
> +	sunrise->dev = &client->dev;
> +	mutex_init(&sunrise->lock);
> +
> +	sunrise->regmap = devm_regmap_init_i2c(client, &sunrise_regmap_config);
> +	if (IS_ERR(sunrise->regmap)) {
> +		dev_err(&client->dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(sunrise->regmap);
> +	}
> +
> +	iio_dev->info = &sunrise_info;
> +	iio_dev->name = DRIVER_NAME;
> +	iio_dev->channels = sunrise_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(sunrise_channels);
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, iio_dev);
> +}
> +
> +static const struct of_device_id sunrise_of_match[] = {
> +	{ .compatible = "senseair,sunrise-006-0-0007" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sunrise_of_match);
> +
> +static struct i2c_driver sunrise_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = sunrise_of_match,
> +	},
> +	.probe_new = sunrise_probe,
> +};
> +module_i2c_driver(sunrise_driver);
> +
> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> +MODULE_DESCRIPTION("Senseair Sunrise 006-0-0007 CO2 sensor IIO driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.32.0
> 

-- 
With Best Regards,
Andy Shevchenko


