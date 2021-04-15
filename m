Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA033609CA
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhDOMui (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 08:50:38 -0400
Received: from www381.your-server.de ([78.46.137.84]:35890 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhDOMuh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 08:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=exBXlZXH47Di0VF4aQtfxWmDcfoCGIqgQj0ApZVYOcQ=; b=VNKLh1oOJlVkfskhfYPc1+dstI
        +bJfN2idkV7glNhAbasBtSkIkbYsOX4dCgXCgTmiYj6+1HTGKHb5Fb+vcx+PKOxzXOXnSfiosbOEg
        qKdpd/8ceCvExYpEKv2loPR1Ivaf7/dFSz0hX8/HOYiOQhDFfxd1xC5uEGrV2PwAxQ9IeWozWvWg1
        eRSTkSv3KSp+BvE+2lldZCNm81Nh+9hC92jzZWOxV32p07ccNgYYE4Jq9af1KNtRl5VCXhYzoajzB
        c3wvCSsKXd0MlybAqO15uW8YzO/mPdYqms+iiQsEoavmoXGaxm9uG2QOkVB/OELnCYBomI3xwfQEr
        5ZjFvoaw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lX1Ri-0008lQ-MD; Thu, 15 Apr 2021 14:50:10 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lX1Ri-000FeK-FZ; Thu, 15 Apr 2021 14:50:10 +0200
Subject: Re: [RFC PATCH 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
To:     Sean Nyekjaer <sean@geanix.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20210415114614.1071928-1-sean@geanix.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <11adb882-1af8-ab08-fcd9-47bedad02699@metafoo.de>
Date:   Thu, 15 Apr 2021 14:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415114614.1071928-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26141/Thu Apr 15 13:13:26 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/15/21 1:46 PM, Sean Nyekjaer wrote:
> Add basic support for NXP FXLS8962AF/FXLS8964AF Automotive
> accelerometers.
> It will allow setting up scale/gain and reading x,y,z
> axis.

Hi,

Thanks for the patch. This looks very good!

>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> - Interrupt, buffered reads and events support is in the works.
>
>   drivers/iio/accel/Kconfig           |  22 +
>   drivers/iio/accel/Makefile          |   4 +
>   drivers/iio/accel/fxls8962af-core.c | 739 ++++++++++++++++++++++++++++
>   drivers/iio/accel/fxls8962af-i2c.c  |  67 +++
>   drivers/iio/accel/fxls8962af-spi.c  |  72 +++
>   drivers/iio/accel/fxls8962af.h      |  21 +
>   6 files changed, 925 insertions(+)
>   create mode 100644 drivers/iio/accel/fxls8962af-core.c
>   create mode 100644 drivers/iio/accel/fxls8962af-i2c.c
>   create mode 100644 drivers/iio/accel/fxls8962af-spi.c
>   create mode 100644 drivers/iio/accel/fxls8962af.h
>
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 2e0c62c39155..c4b42024de42 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -370,6 +370,28 @@ config MMA8452
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called mma8452.
>   
> +config FXLS8962AF

We try to keep the entries in alphabetical order.

> +	tristate "NXP FXLS8962AF and similar Accelerometers Driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
The driver does not yet make use of interrupts.
> +	select REGMAP
> +	select FXLS8962AF_I2C if I2C
> +	select FXLS8962AF_SPI if SPI
Usually we do this the other way around. Expose I2C and SPI support as 
independent config items and let them select the core. The reason is 
because I2C support can be built as a module. To be honest I'm not sure 
how exactly this will be have if I2C support is a module, but FXLS8962AF 
is built-in. It might actually work fine.
> +	help
> +	  Say yes here to build support for the NXP 3-axis automotive
> +	  accelerometer FXLS8962AF/FXLS8964AF.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called fxls8962af.
> +
> +config FXLS8962AF_I2C
> +	tristate
> +	select REGMAP_I2C
> +
> +config FXLS8962AF_SPI
> +	tristate
> +	select REGMAP_SPI
> +
>   config MMA9551_CORE
>   	tristate
>   
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 4f6c1ebe13b0..3e48a9127863 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -40,6 +40,10 @@ obj-$(CONFIG_MMA7660)	+= mma7660.o
>   
>   obj-$(CONFIG_MMA8452)	+= mma8452.o
>   
> +obj-$(CONFIG_FXLS8962AF)	+= fxls8962af-core.o
> +obj-$(CONFIG_FXLS8962AF_I2C)	+= fxls8962af-i2c.o
> +obj-$(CONFIG_FXLS8962AF_SPI)	+= fxls8962af-spi.o
We try to keep the entries in alphabetical order.
> +
>   obj-$(CONFIG_MMA9551_CORE)	+= mma9551_core.o
>   obj-$(CONFIG_MMA9551)		+= mma9551.o
>   obj-$(CONFIG_MMA9553)		+= mma9553.o
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> new file mode 100644
> index 000000000000..daee5b07ca49
> --- /dev/null
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -0,0 +1,739 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Connected Cars A/S
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
No I2C in this driver.
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/delay.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
At least of_irq.h is unused
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +
> +#include "fxls8962af.h"
> [...]
> +enum {
> +	idx_x,
> +	idx_y,
> +	idx_z,
> +	idx_ts,
Might want to put a prefix on these. idx_x is not that unique of an 
identifier.
> +};
> [...]
> +
> +static int fxls8962af_get_temp(struct fxls8962af_data *data, int *val)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	unsigned int value;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = fxls8962af_drdy(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret = fxls8962af_set_power_state(data, true);
> +	if (ret) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(data->regmap, FXLS8962AF_TEMP_OUT, &value);
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading reg_temp\n");
> +		fxls8962af_set_power_state(data, false);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret = fxls8962af_set_power_state(data, false);
> +
> +	*val = sign_extend32(value, 7);
Doesn't really matter, but his could also be outside the locked section.
> +
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> [...]
> +static int fxls8962af_write_raw_get_fmt(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
Since the driver only supports writing the accelerator scale this could 
be simplified to just return IIO_VAL_INT_PLUS_NANO.
> +}
> +
> +static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
> +		       fxls8962af_show_scale_avail, NULL, 0);
There is a new API to query the available values through the IIO API. 
This can be done by implementing the read_avail callback of the iio_info 
struct. This is the recommended method for new drivers rather than 
registering a sysfs attribute and do manually formatting of the scale.
> [...]
>
> +
> +static int fxls8962af_write_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
Should check that val is 0.
> +		ret = fxls8962af_set_full_scale(data, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
> +#define FXLS8962AF_CHANNEL(axis, idx) { \
> +	.type = IIO_ACCEL, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_##axis, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_CALIBBIAS), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +			BIT(IIO_CHAN_INFO_SCALE) | \
> +			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY) | \
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
Some of these attributes are not implemented yet.
> +	.scan_index = idx, \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = 12, \
> +		.storagebits = 16, \
> +		.shift = 4, \
> +		.endianness = IIO_BE, \
> +	}, \
> +}
> +
> [...]
> +int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq,
> +			  const char *name)
> +{
> +	struct fxls8962af_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int reg;
> +	int ret, i;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	mutex_init(&data->lock);
> +	data->regmap = regmap;
> +
> +	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
> +	if (ret)
> +		return ret;
> +
> +	data->vdd_reg = devm_regulator_get_optional(dev, "vdd");
> +	if (IS_ERR(data->vdd_reg)) {
> +		if ((PTR_ERR(data->vdd_reg) != -ENODEV) && dev->of_node)
Why the check for of_node?
> +			return PTR_ERR(data->vdd_reg);
> +
> +		data->vdd_reg = NULL;
> +	} else {
> +		ret = regulator_enable(data->vdd_reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_read(data->regmap, FXLS8962AF_WHO_AM_I, &reg);
> +	if (ret < 0)
> +		goto disable_regulators;
> +
> +	dev_dbg(dev, "Chip Id %x\n", reg);
> +	for (i = 0; i < ARRAY_SIZE(fxls_chip_info_table); i++) {
> +		if (fxls_chip_info_table[i].chip_id == reg) {
> +			data->chip_info = &fxls_chip_info_table[i];
> +			break;
> +		}
> +	}
> +
> +	indio_dev->channels = data->chip_info->channels;
> +	indio_dev->num_channels = data->chip_info->num_channels;
> +	indio_dev->name = name;
Since the driver identifies the chip based on the who-am-i register, I 
wonder if the name should also come from the chip_info_table.
> +	indio_dev->available_scan_masks = fxls8962af_scan_masks;
> +	indio_dev->info = &fxls8962af_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	dev_info(dev, "registering %s accelerometer\n", name);
Its a bit of personal taste, but I don't like these 'driver has probed' 
messages. It is great for development, but not so great for production. 
If every device that gets registered prints such a message that does 
slow down boot a fair bit and clutters the boot log.
> +
> +	ret = fxls8962af_reset(data);
> +	if (ret < 0)
> +		goto disable_regulators;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		goto disable_regulators;
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, FXLS8962AF_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto disable_regulators;
> +
> +	return 0;
> +
> + disable_regulators:
> +	if (data->vdd_reg)
> +		regulator_disable(data->vdd_reg);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
> +
> [...]
> +#ifdef CONFIG_PM
> [...]
> +static int fxls8962af_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (data->vdd_reg) {
> +		ret = regulator_disable(data->vdd_reg);
Should be regulator_enable()?
> +		if (ret) {
> +			dev_err(dev, "failed to disable VDD regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = fxls8962af_active(data);
> +	if (ret < 0)
> +		goto runtime_resume_failed;
> +
> +	return 0;
> +
> + runtime_resume_failed:
> +	if (data->vdd_reg)
> +		regulator_disable(data->vdd_reg);
> +
> +	return ret;
> +}
> +#endif
> [...]
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> new file mode 100644
> index 000000000000..4cdbd9793df7
> --- /dev/null
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Connected Cars A/S
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
No ACPI in this file.
> +#include <linux/regmap.h>
> +
> +#include "fxls8962af.h"
> +
> +static int fxls8962af_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name = NULL;
> +
> +	regmap = devm_regmap_init_i2c(client, &fxls8962af_regmap_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name = id->name;
> +
> +	return fxls8962af_core_probe(&client->dev, regmap, client->irq, name);
> +}
> +
> +static int fxls8962af_remove(struct i2c_client *client)
> +{
> +	return fxls8962af_core_remove(&client->dev);
> +}
> +
> +static const struct i2c_device_id fxls8962af_id[] = {
> +	{"fxls8962af", fxls8962af},
> +	{"fxls8964af", fxls8964af},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> +
> +static const struct of_device_id fxls8962af_of_match[] = {
> +	{.compatible = "nxp,fxls8962af"},
> +	{.compatible = "nxp,fxls8964af"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
> +
> +static struct i2c_driver fxls8962af_driver = {
> +	.driver = {
> +		   .name = "fxls8962af_i2c",
> +		   .of_match_table = fxls8962af_of_match,
> +		   .pm = &fxls8962af_pm_ops,
> +		   },
> +	.probe = fxls8962af_probe,
For new i2C drivers use the probe_new callback.
> +	.remove = fxls8962af_remove,
> +	.id_table = fxls8962af_id,
> +};
> +
> +module_i2c_driver(fxls8962af_driver);
> +
> +MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
> +MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
> new file mode 100644
> index 000000000000..976851863e82
> --- /dev/null
> +++ b/drivers/iio/accel/fxls8962af-spi.c
> @@ -0,0 +1,72 @@
> [...]
For the I2C driver you are using a global regmap config, but for the SPI 
one a local. Looks to me as if the gobal one can also be used for the 
SPI driver.
> +static int fxls8962af_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct regmap *regmap;
> +	const char *name = NULL;
> +
> +	regmap = devm_regmap_init_spi(spi, &fxls8962af_spi_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
%ld and drop the cast.
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name = id->name;
> +
> +	return fxls8962af_core_probe(&spi->dev, regmap, spi->irq, name);
> +}
> +
> +static int fxls8962af_remove(struct spi_device *spi)
> +{
> +	return fxls8962af_core_remove(&spi->dev);
> +}


