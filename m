Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E733634B7
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 13:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhDRLG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 07:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhDRLG6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 07:06:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 540C261207;
        Sun, 18 Apr 2021 11:06:25 +0000 (UTC)
Date:   Sun, 18 Apr 2021 12:06:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?R2HDq3RhbiBB?= =?UTF-8?B?bmRyw6k=?= 
        <rvlander@gaetanandre.eu>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        mr.lahorde@laposte.net,
        Matija Podravec <matija_podravec@fastmail.fm>,
        Sergey Borishchenko <borischenko.sergey@gmail.com>
Subject: Re: [PATCH v1 6/7] iio: st_sensors: Add lsm9ds0 IMU support
Message-ID: <20210418120655.3b2501fc@jic23-huawei>
In-Reply-To: <20210414195454.84183-6-andriy.shevchenko@linux.intel.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
        <20210414195454.84183-6-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Apr 2021 22:54:53 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> We can utilize separate drivers for accelerometer and magnetometer,
> so here is the glue driver to enable LSM9DS0 IMU support.
> 
> The idea was suggested by Crestez Dan Leonard in [1]. The proposed change
> was sent as RFC due to race condition concerns, which are indeed possible.

If you are going to mention races, good to give some flavour in here!


This driver makes me very nervous indeed.  I haven't 'found' any places
where the fact we'll write the same registers from each of the drivers
causes problems (e.g. int pin setup etc) but perhaps I'm missing something.

Shall we say that makes me rather keener to get eyes (and thought) on this
patch than normal :)


> 
> In order to amend the initial change, I went further by providing a specific
> multi-instantiate probe driver that reuses existing accelerometer and
> magnetometer.
> 
> [1]: https://lore.kernel.org/patchwork/patch/670353/
> 
> Suggested-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> Cc: mr.lahorde@laposte.net
> Cc: Matija Podravec <matija_podravec@fastmail.fm>
> Cc: Sergey Borishchenko <borischenko.sergey@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A few comments in here, though mostly about stuff related to the origin code
you are copying so perhaps not tidying them up is preferable because it would
complicate comparison of the two cases.
> ---
>  drivers/iio/accel/st_accel_core.c            |  89 +++++++++-
>  drivers/iio/imu/Kconfig                      |   1 +
>  drivers/iio/imu/Makefile                     |   1 +
>  drivers/iio/imu/st_lsm9ds0/Kconfig           |  28 ++++
>  drivers/iio/imu/st_lsm9ds0/Makefile          |   5 +
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h      |  23 +++
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 163 +++++++++++++++++++
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c  |  84 ++++++++++
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c  |  83 ++++++++++
>  drivers/iio/magnetometer/st_magn_core.c      |  98 +++++++++++
>  include/linux/iio/common/st_sensors.h        |   2 +
>  11 files changed, 576 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/imu/st_lsm9ds0/Kconfig
>  create mode 100644 drivers/iio/imu/st_lsm9ds0/Makefile
>  create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
>  create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
>  create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
>  create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 5c258c1ca62d..dc32ebefe3fc 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -980,7 +980,94 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> -
> +	{
> +		.wai = 0x49,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = LSM9DS0_IMU_DEV_NAME,

What does the name attribute report for these?

Previously we've had the _accel etc postfix to differentiate the devices. I don't
suppose it matters to much though as easy enough to identify the accelerometer
etc from what channels are present.

Of course driver may get name from somewhere different anyway, I haven't checked,
just noticed this was different and wondered what the affect might be.

>  
>  /* Default accel DRDY is available on INT1 pin */
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index f02883b08480..001ca2c3ff95 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -94,6 +94,7 @@ config KMX61
>  source "drivers/iio/imu/inv_icm42600/Kconfig"
>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
>  source "drivers/iio/imu/st_lsm6dsx/Kconfig"
> +source "drivers/iio/imu/st_lsm9ds0/Kconfig"
>  
>  endmenu
>  
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index 13e9ff442b11..c82748096c77 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -26,3 +26,4 @@ obj-y += inv_mpu6050/
>  obj-$(CONFIG_KMX61) += kmx61.o
>  
>  obj-y += st_lsm6dsx/
> +obj-y += st_lsm9ds0/
> diff --git a/drivers/iio/imu/st_lsm9ds0/Kconfig b/drivers/iio/imu/st_lsm9ds0/Kconfig
> new file mode 100644
> index 000000000000..53b7017014f8
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm9ds0/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config IIO_ST_LSM9DS0
> +	tristate "STMicroelectronics LSM9DS0 IMU driver"
> +	depends on (I2C || SPI_MASTER) && SYSFS
> +	depends on !SENSORS_LIS3_I2C
> +	depends on !SENSORS_LIS3_SPI
> +	select IIO_ST_LSM9DS0_I2C if I2C
> +	select IIO_ST_LSM9DS0_SPI if SPI_MASTER
> +	select IIO_ST_ACCEL_3AXIS
> +	select IIO_ST_MAGN_3AXIS
> +
> +	help
> +	  Say yes here to build support for STMicroelectronics LSM9DS0 IMU
> +	  sensor. Supported devices: accelerometer/magnetometer of lsm9ds0.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called st_lsm9ds0.
> +
> +config IIO_ST_LSM9DS0_I2C
> +	tristate
> +	depends on IIO_ST_LSM9DS0
> +	select REGMAP_I2C
> +
> +config IIO_ST_LSM9DS0_SPI
> +	tristate
> +	depends on IIO_ST_LSM9DS0
> +	select REGMAP_SPI
> diff --git a/drivers/iio/imu/st_lsm9ds0/Makefile b/drivers/iio/imu/st_lsm9ds0/Makefile
> new file mode 100644
> index 000000000000..488af523f648
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm9ds0/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_IIO_ST_LSM9DS0) += st_lsm9ds0.o
> +st_lsm9ds0-y := st_lsm9ds0_core.o
> +obj-$(CONFIG_IIO_ST_LSM9DS0_I2C) += st_lsm9ds0_i2c.o
> +obj-$(CONFIG_IIO_ST_LSM9DS0_SPI) += st_lsm9ds0_spi.o
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
> new file mode 100644
> index 000000000000..146393afd9a7
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +// STMicroelectronics LSM9DS0 IMU driver
> +
> +#ifndef ST_LSM9DS0_H
> +#define ST_LSM9DS0_H
> +
> +struct iio_dev;
> +struct regulator;
> +
> +struct st_lsm9ds0 {
> +	struct device *dev;
> +	const char *name;
> +	int irq;
> +	struct iio_dev *accel;
> +	struct iio_dev *magn;
> +	struct regulator *vdd;
> +	struct regulator *vdd_io;
> +};
> +
> +int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap);
> +int st_lsm9ds0_remove(struct st_lsm9ds0 *lsm9ds0);
> +
> +#endif /* ST_LSM9DS0_H */
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
> new file mode 100644
> index 000000000000..8204f7303fd7
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics LSM9DS0 IMU driver
> + *
> + * Copyright (C) 2021, Intel Corporation
> + *
> + * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/common/st_sensors.h>
> +#include <linux/iio/iio.h>
> +
> +#include "st_lsm9ds0.h"
> +
> +static int st_lsm9ds0_power_enable(struct device *dev, struct st_lsm9ds0 *lsm9ds0)
> +{
> +	int ret;
> +
> +	/* Regulators not mandatory, but if requested we should enable them. */

That's a bit of a missleading comment though cut and paste from the other driver
code.  Key is that they will be handled by stub regulators if we don't provide
the which is not really what that comment implies.
 
> +	lsm9ds0->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(lsm9ds0->vdd)) {
> +		dev_err(dev, "unable to get Vdd supply\n");
> +		return PTR_ERR(lsm9ds0->vdd);
> +	}
> +	ret = regulator_enable(lsm9ds0->vdd);
> +	if (ret) {
> +		dev_warn(dev, "Failed to enable specified Vdd supply\n");

Given we fail to probe if this is true, dev_warn seems a bit soft.

> +		return ret;
> +	}
> +
> +	lsm9ds0->vdd_io = devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(lsm9ds0->vdd_io)) {
> +		dev_err(dev, "unable to get Vdd_IO supply\n");
> +		regulator_disable(lsm9ds0->vdd);
> +		return PTR_ERR(lsm9ds0->vdd_io);
> +	}
> +	ret = regulator_enable(lsm9ds0->vdd_io);
> +	if (ret) {
> +		dev_warn(dev, "Failed to enable specified Vdd_IO supply\n");
> +		regulator_disable(lsm9ds0->vdd);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
 +
> +static void st_lsm9ds0_power_disable(void *data)
> +{
> +	struct st_lsm9ds0 *lsm9ds0 = data;
> +
> +	regulator_disable(lsm9ds0->vdd_io);
> +	regulator_disable(lsm9ds0->vdd);
> +}
> +
> +static int devm_st_lsm9ds0_power_enable(struct st_lsm9ds0 *lsm9ds0)
> +{
> +	struct device *dev = lsm9ds0->dev;
> +	int ret;
> +
> +	ret = st_lsm9ds0_power_enable(dev, lsm9ds0);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, st_lsm9ds0_power_disable, lsm9ds0);
> +}
> +
> +static int st_lsm9ds0_probe_accel(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
> +{
> +	const struct st_sensor_settings *settings;
> +	struct device *dev = lsm9ds0->dev;
> +	struct st_sensor_data *data;
> +
> +	settings = st_accel_get_settings(lsm9ds0->name);
> +	if (!settings) {
> +		dev_err(dev, "device name %s not recognized.\n", lsm9ds0->name);
> +		return -ENODEV;
> +	}
> +
> +	lsm9ds0->accel = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!lsm9ds0->accel)
> +		return -ENOMEM;
> +
> +	lsm9ds0->accel->name = lsm9ds0->name;
> +
> +	data = iio_priv(lsm9ds0->accel);
> +	data->sensor_settings = (struct st_sensor_settings *)settings;
> +	data->dev = dev;
> +	data->irq = lsm9ds0->irq;
> +	data->regmap = regmap;
> +	data->vdd = lsm9ds0->vdd;
> +	data->vdd_io = lsm9ds0->vdd_io;
> +
> +	return st_accel_common_probe(lsm9ds0->accel);
> +}
> +
> +static int st_lsm9ds0_probe_magn(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
> +{
> +	const struct st_sensor_settings *settings;
> +	struct device *dev = lsm9ds0->dev;
> +	struct st_sensor_data *data;
> +
> +	settings = st_magn_get_settings(lsm9ds0->name);
> +	if (!settings) {
> +		dev_err(dev, "device name %s not recognized.\n", lsm9ds0->name);
> +		return -ENODEV;
> +	}
> +
> +	lsm9ds0->magn = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!lsm9ds0->magn)
> +		return -ENOMEM;
> +
> +	lsm9ds0->magn->name = lsm9ds0->name;
> +
> +	data = iio_priv(lsm9ds0->magn);
> +	data->sensor_settings = (struct st_sensor_settings *)settings;
> +	data->dev = dev;
> +	data->irq = lsm9ds0->irq;
> +	data->regmap = regmap;
> +	data->vdd = lsm9ds0->vdd;
> +	data->vdd_io = lsm9ds0->vdd_io;
> +
> +	return st_magn_common_probe(lsm9ds0->magn);
> +}
> +
> +int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
> +{
> +	int ret;
> +
> +	ret = devm_st_lsm9ds0_power_enable(lsm9ds0);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup accelerometer device */
> +	ret = st_lsm9ds0_probe_accel(lsm9ds0, regmap);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup magnetometer device */
> +	ret = st_lsm9ds0_probe_magn(lsm9ds0, regmap);
> +	if (ret)
> +		st_accel_common_remove(lsm9ds0->accel);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(st_lsm9ds0_probe);
> +
> +int st_lsm9ds0_remove(struct st_lsm9ds0 *lsm9ds0)
> +{
> +	st_magn_common_remove(lsm9ds0->magn);
> +	st_accel_common_remove(lsm9ds0->accel);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(st_lsm9ds0_remove);
> +
> +MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
> +MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU core driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> new file mode 100644
> index 000000000000..50a36ab53bc3
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics LSM9DS0 IMU driver
> + *
> + * Copyright (C) 2021, Intel Corporation
> + *
> + * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/common/st_sensors_i2c.h>
> +
> +#include "st_lsm9ds0.h"
> +
> +static const struct of_device_id st_lsm9ds0_of_match[] = {
> +	{
> +		.compatible = "st,lsm9ds0-imu",
> +		.data = LSM9DS0_IMU_DEV_NAME,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, st_lsm9ds0_of_match);
> +
> +static const struct i2c_device_id st_lsm9ds0_id_table[] = {
> +	{ LSM9DS0_IMU_DEV_NAME },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
> +
> +static const struct regmap_config st_lsm9ds0_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.read_flag_mask	= 0x80,
> +};
> +
> +static int st_lsm9ds0_i2c_probe(struct i2c_client *client)
> +{
> +	const struct regmap_config *config = &st_lsm9ds0_regmap_config;
> +	struct device *dev = &client->dev;
> +	struct st_lsm9ds0 *lsm9ds0;
> +	struct regmap *regmap;
> +
> +	st_sensors_dev_name_probe(dev, client->name, sizeof(client->name));
> +
> +	lsm9ds0 = devm_kzalloc(dev, sizeof(*lsm9ds0), GFP_KERNEL);
> +	if (!lsm9ds0)
> +		return -ENOMEM;
> +
> +	lsm9ds0->dev = dev;
> +	lsm9ds0->name = client->name;
> +	lsm9ds0->irq = client->irq;
> +
> +	regmap = devm_regmap_init_i2c(client, config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	i2c_set_clientdata(client, lsm9ds0);
> +
> +	return st_lsm9ds0_probe(lsm9ds0, regmap);
> +}
> +
> +static int st_lsm9ds0_i2c_remove(struct i2c_client *client)
> +{
> +	return st_lsm9ds0_remove(i2c_get_clientdata(client));
> +}
> +
> +static struct i2c_driver st_lsm9ds0_driver = {
> +	.driver = {
> +		.name = "st-lsm9ds0-i2c",
> +		.of_match_table = st_lsm9ds0_of_match,
> +	},
> +	.probe_new = st_lsm9ds0_i2c_probe,
> +	.remove = st_lsm9ds0_i2c_remove,
> +	.id_table = st_lsm9ds0_id_table,
> +};
> +module_i2c_driver(st_lsm9ds0_driver);
> +
> +MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
> +MODULE_DESCRIPTION("STMicroelectronics LSM9DS0 IMU I2C driver");
> +MODULE_LICENSE("GPL v2");
