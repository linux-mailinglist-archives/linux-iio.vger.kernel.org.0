Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E929A2FDAC7
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 21:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbhATUZe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jan 2021 15:25:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2387 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388371AbhATUYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jan 2021 15:24:20 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DLcLX3fsBz67bGK;
        Thu, 21 Jan 2021 04:19:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Jan 2021 21:23:26 +0100
Received: from localhost (10.47.67.172) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 20 Jan
 2021 20:23:25 +0000
Date:   Wed, 20 Jan 2021 20:22:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     <linux-iio@vger.kernel.org>, Dan Robertson <dan@dlrobertson.com>,
        =?ISO-8859-1?Q?Ga=EBtan_Andr=E9?= <rvlander@gaetanandre.eu>,
        "Jonathan Bakker" <xc-racer2@live.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
Message-ID: <20210120202244.000009f6@Huawei.com>
In-Reply-To: <20210119124622.9490-2-mike.looijmans@topic.nl>
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
        <20210119124622.9490-2-mike.looijmans@topic.nl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.172]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Jan 2021 13:46:22 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
> Changes in v6:
> Hope you have good memory - v5 was almost a year ago now
*laughs* fresh review so probably disagree with what I said back then on
something :)


A few really small comments inline seeing as you are respinning anyway.

> Remove superfluous *val=0
> Make sample_frequency selection into read_avail list
> 
> Changes in v5:
> Add includes and forward defines in header
> BIT(7) instead of 0x80
> Reset already sets defaults, do not set them again
> Remove now unused bmi088_accel_set_bw
> Remove unused AXIS_MAX
> Use MASK define for ODR setting
> Explain buffer use and alignment
> Split bmi088_accel_set_power_state into "on" and "off" parts
> Cosmetic changes to improve readability
> 
> Changes in v4:
> Remove unused #include directives
> Remove unused #defines for event and irq
> Replace (ret < 0) with (ret) for all regmap calls
> Consistent checking of IO errors in probe and init
> Removed #ifdef CONFIG_PM guard
> Use bitops for set_frequency instead of loop with shift
> s/__s16/s16/g
> Remove excess blank lines
> Don't return -EAGAIN in pm_runtime
> 
> Changes in v3:
> Processed comments from Jonathan Cameron and Lars-Peter Clausen
> implement runtime PM (tested by code tracing) and sleep
> fix scale and offset factors for accel and temperature and
> return raw values instead of pre-scaled ones
> Use iio_device_{claim,release}_direct_mode
> Remove unused code and structs
> Use a cache-aligned buffer for bulk read
> Configure and enable caching register values
> 
> Changes in v2:
> Remove unused typedefs and variables
> Fix error return when iio_device_register fails
> 
>  drivers/iio/accel/Kconfig             |  18 +
>  drivers/iio/accel/Makefile            |   2 +
>  drivers/iio/accel/bmi088-accel-core.c | 630 ++++++++++++++++++++++++++
>  drivers/iio/accel/bmi088-accel-spi.c  |  85 ++++
>  drivers/iio/accel/bmi088-accel.h      |  18 +
>  5 files changed, 753 insertions(+)
>  create mode 100644 drivers/iio/accel/bmi088-accel-core.c
>  create mode 100644 drivers/iio/accel/bmi088-accel-spi.c
>  create mode 100644 drivers/iio/accel/bmi088-accel.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 2e0c62c39155..cceda3cecbcf 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -157,6 +157,24 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config BMI088_ACCEL
> +	tristate "Bosch BMI088 Accelerometer Driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP
> +	select BMI088_ACCEL_SPI
> +	help
> +	  Say yes here to build support for the Bosch BMI088 accelerometer.
> +
> +	  This is a combo module with both accelerometer and gyroscope. This
> +	  driver only implements the accelerometer part, which has its own
> +	  address and register map. BMG160 provides the gyroscope driver.
> +
> +config BMI088_ACCEL_SPI
> +	tristate
> +	select REGMAP_SPI
> +
>  config DA280
>  	tristate "MiraMEMS DA280 3-axis 14-bit digital accelerometer driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 4f6c1ebe13b0..32cd1342a31a 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -20,6 +20,8 @@ obj-$(CONFIG_BMA400_SPI) += bma400_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> +obj-$(CONFIG_BMI088_ACCEL) += bmi088-accel-core.o
> +obj-$(CONFIG_BMI088_ACCEL_SPI) += bmi088-accel-spi.o
>  obj-$(CONFIG_DA280)	+= da280.o
>  obj-$(CONFIG_DA311)	+= da311.o
>  obj-$(CONFIG_DMARD06)	+= dmard06.o
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> new file mode 100644
> index 000000000000..788e54ed0728
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -0,0 +1,630 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> + *  - BMI088
> + *
> + * Copyright (c) 2018-2020, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
As below. Alphabetical ordering preferred.

> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regmap.h>
> +#include <asm/unaligned.h>
> +
> +#include "bmi088-accel.h"
...

> +static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret, i;
> +	unsigned int val;
> +
> +	/* Do a dummy read to enable SPI interface, won't harm I2C */
> +	regmap_read(data->regmap, BMI088_ACCEL_REG_INT_STATUS, &val);
> +
> +	/*
> +	 * Reset chip to get it in a known good state. A delay of 1ms after
> +	 * reset is required according to the data sheet
> +	 */
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_RESET,
> +			   BMI088_ACCEL_RESET_VAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000);
> +
> +	/* Do a dummy read again after a reset to enable the SPI interface */
> +	regmap_read(data->regmap, BMI088_ACCEL_REG_INT_STATUS, &val);
> +
> +	/* Read chip ID */
> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
> +	if (ret) {
> +		dev_err(dev, "Error: Reading chip id\n");
> +		return ret;
> +	}
> +
> +	/* Validate chip ID */
> +	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++) {
> +		if (bmi088_accel_chip_info_tbl[i].chip_id == val) {
> +			data->chip_info = &bmi088_accel_chip_info_tbl[i];
> +			break;
> +		}
> +	}
> +	if (i == ARRAY_SIZE(bmi088_accel_chip_info_tbl)) {
> +		dev_err(dev, "Invalid chip %x\n", val);
> +		return -ENODEV;
> +	}
> +
> +	/* Enable accelerometer after reset */
> +	return bmi088_accel_enable(data, true);

We bring the device up here, but I'm not seeing it turned off again
in either error paths of probe or remove.
Am I missing it somewhere?

> +}
> +
> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
> +	int irq, const char *name, bool block_supported)
> +{
> +	struct bmi088_accel_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	data->regmap = regmap;
> +
> +	ret = bmi088_accel_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = data->chip_info->channels;
> +	indio_dev->num_channels = data->chip_info->num_channels;
> +	indio_dev->name = name ? name : data->chip_info->name;
> +	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &bmi088_accel_info;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, BMI088_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		dev_err(dev, "Unable to register iio device\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bmi088_accel_core_probe);
> +
> +int bmi088_accel_core_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bmi088_accel_core_remove);
> +
> +/* When going into system sleep, put the chip in power down */
> +static int __maybe_unused bmi088_accel_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +	bmi088_accel_enable(data, false);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused bmi088_accel_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_enable(data, true);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +/* For runtime PM put the chip in suspend mode */
> +static int __maybe_unused bmi088_accel_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	return bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +}
> +
> +static int __maybe_unused bmi088_accel_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(BMI088_ACCEL_MAX_STARTUP_TIME_US,
> +		     BMI088_ACCEL_MAX_STARTUP_TIME_US * 2);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops bmi088_accel_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(bmi088_accel_suspend, bmi088_accel_resume)
> +	SET_RUNTIME_PM_OPS(bmi088_accel_runtime_suspend,
> +			   bmi088_accel_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(bmi088_accel_pm_ops);
> +
> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMI088 accelerometer driver (core)");
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> new file mode 100644
> index 000000000000..7794090b8e6d
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> + *  - BMI088
> + *
> + * Copyright (c) 2018-2020, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>

If no other reason for ordering ever so slight preference for
alphabetical order.

> +
> +#include "bmi088-accel.h"
> +
> +int bmi088_regmap_spi_write(void *context, const void *data, size_t count)
> +{
> +	struct spi_device *spi = context;
> +
> +	/* Write register is same as generic SPI */
> +	return spi_write(spi, data, count);
> +}
> +
> +int bmi088_regmap_spi_read(void *context, const void *reg,
> +				size_t reg_size, void *val, size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	u8 addr[2];
> +
> +	addr[0] = *(u8 *)reg;
> +	addr[0] |= BIT(7); /* Set RW = '1' */
> +	addr[1] = 0; /* Read requires a dummy byte transfer */
> +
> +	return spi_write_then_read(spi, addr, sizeof(addr), val, val_size);
> +}
> +
> +static struct regmap_bus bmi088_regmap_bus = {
> +	.write = bmi088_regmap_spi_write,
> +	.read = bmi088_regmap_spi_read,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,

Aren't these both 8 bits, making endian rather irrelevant?

> +};
...
