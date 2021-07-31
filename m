Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121B93DC6F8
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhGaQhA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 31 Jul 2021 12:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhGaQhA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 12:37:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C3C6044F;
        Sat, 31 Jul 2021 16:36:47 +0000 (UTC)
Date:   Sat, 31 Jul 2021 17:39:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: Re: [PATCH 2/2] iio: chemical: Add driver support for sgp40
Message-ID: <20210731173928.08d6812f@jic23-huawei>
In-Reply-To: <20210727163517.GA3468@arbad>
References: <20210727163517.GA3468@arbad>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 18:35:19 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> sgp40 is a gas sensor used for measuring the air quality.
> 
> This driver is reading the raw resistance value which can be passed to
> a userspace algorithm for further calculation.
> 
> The raw value is also used to calculate an estimated absolute voc index
> in the range from 0 to 500. For this purpose the raw_mean value of the
> resistance for which the index value is 250 might be set up as a
> calibration step.
> 
> Compensation of relative humidity and temperature is supported and can
> be used by writing to device attributes of the driver.
> 
> There is a predecesor sensor type (sgp30) already existing. This driver
> module was not extended because the new sensor is quite different in its
> i2c telegrams.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Hi Andreas,

Non standard ABI in here, so we are missing documentation in Documentation/ABI/testing/sysfs-bus-iio-*

Otherwise a few suggestions inline.

Thanks,

Jonathan


> ---
>  MAINTAINERS                   |   5 +
>  drivers/iio/chemical/Kconfig  |  11 +
>  drivers/iio/chemical/Makefile |   1 +
>  drivers/iio/chemical/sgp40.c  | 413 ++++++++++++++++++++++++++++++++++
>  4 files changed, 430 insertions(+)
>  create mode 100644 drivers/iio/chemical/sgp40.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19135a9d778e..ed8aae16559d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16707,6 +16707,11 @@ F:	drivers/iio/chemical/scd30_core.c
>  F:	drivers/iio/chemical/scd30_i2c.c
>  F:	drivers/iio/chemical/scd30_serial.c
>  
> +SENSIRION SGP40 GAS SENSOR DRIVER
> +M:	Andreas Klinger <ak@it-klinger.de>
> +S:	Maintained
> +F:	drivers/iio/chemical/sgp40.c
> +
>  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index a4920646e9be..c03667e62732 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -131,6 +131,17 @@ config SENSIRION_SGP30
>  	  To compile this driver as module, choose M here: the
>  	  module will be called sgp30.
>  
> +config SENSIRION_SGP40
> +	tristate "Sensirion SGP40 gas sensor"
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say Y here to build I2C interface to support Sensirion SGP40 gas
> +	  sensor
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called sgp40.
> +
>  config SPS30
>  	tristate
>  	select IIO_BUFFER
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index 4898690cc155..d07af581f234 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_SCD30_CORE) += scd30_core.o
>  obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
>  obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
>  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> +obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
>  obj-$(CONFIG_SPS30) += sps30.o
>  obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
>  obj-$(CONFIG_SPS30_SERIAL) += sps30_serial.o
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> new file mode 100644
> index 000000000000..7072c5f3c28d
> --- /dev/null
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -0,0 +1,413 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * sgp40.c - Support for Sensirion SGP40 Gas Sensors
> + *
> + * Copyright (C) 2021 Andreas Klinger <ak@it-klinger.de>
> + *
> + * I2C slave address: 0x59
> + *
> + * Datasheets:
> + * https://www.sensirion.com/file/datasheet_sgp40
> + *
> + * There are two functionalities supported:
> + * 1) read raw logarithmic resistance value from sensor
> + *    --> useful to pass it to the algorithm of the sensor vendor for
> + *    measuring deteriorations and improvements of air quality.
> + * 2) calculate an estimated absolute voc index (0 - 500 index points) for
> + *    measuring the air quality.
> + *    For this purpose the mean value of the resistance can be set up using
> + *    a device attribute

The info on that ABI also needs to be in ABI docs.  Is it effectively a calibration
offset?  If so, we have calibbias which might be appropriate.

> + *
> + * Compensation of relative humidity and temperature can be used by device
> + * attributes.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/i2c.h>
> +#include <linux/crc8.h>
> +
> +#define SGP40_CRC8_POLYNOMIAL			0x31
> +#define SGP40_CRC8_INIT				0xff
> +
> +static u8 sgp40_measure_raw_tg[] = {0x26, 0x0F};

Only used in one place, I'd just put it down there directly.

> +
> +DECLARE_CRC8_TABLE(sgp40_crc8_table);
> +
> +struct sgp40_data {
> +	struct device		*dev;
> +	struct i2c_client	*client;
> +	int			rel_humidity;
> +	int			temperature;
> +	int			raw_mean;
> +	struct mutex		lock;
> +};
> +
> +static const struct iio_chan_spec sgp40_channels[] = {
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_VOC,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +	{
> +		.type = IIO_RESISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +};
> +
> +/*
> + * calculate e^x where n is the exponent multiplied with 100
> + *
> + * use taylor approximation which is accurate enough for the purpose of
> + * coming out with just 500 index points.
> + */
> +int sqp40_exp100(int n)
> +{
> +	int x, xn, y, z;
> +	int s = 1;
> +
> +	if (n < 0) {
> +		s = -1;
> +		n *= -1;
> +	}
> +
> +	x = n;
> +
> +	y = 100 + x;
> +	xn = x * x;
> +	y += xn / 2 / 100;
> +	xn = x * x * x;
> +	y += xn / 6 / 10000;
> +	xn = x * x * x * x;
> +	y += xn / 24 / 1000000;
> +
> +	if (s == -1)
> +		z = 10000 / y;
> +	else
> +		z = y;
> +
> +	return z;
> +}
> +
> +static int sgp40_calc_voc(struct sgp40_data *data, u16 raw, int *voc)
> +{
> +	int x;
> +	int ex = 0;
> +
> +	/* we calculate in 100's */
> +	x = ((int)raw - data->raw_mean) * 65 / 100;
> +
> +	/* voc = 500 / (1 + e^x) */
> +	if (x < -800)
> +		*voc = 500;
> +	else if (x > 800)
> +		*voc = 0;
> +	else {
> +		ex = sqp40_exp100(x);
> +		*voc = 50000 / (100 + ex);

Does it make sense to provide more precision by not returning a single integer?
IIO_VAL_INT_PLUS_MICRO perhaps?

> +	}
> +
> +	dev_dbg(data->dev, "raw: %d raw_mean: %d x: %d ex: %d voc: %d\n",
> +						raw, data->raw_mean, x, ex, *voc);
> +
> +	return 0;
> +}
> +
> +static int sgp40_measure_raw(struct sgp40_data *data, u16 *raw)
> +{
> +	int ret;
> +	struct i2c_client *client = data->client;
> +	u16 buf_be16; 

If it is be, then use the big endian types.  Also run sparse over
your code before submitting as it will complain about this.

> +	u8 buf[3];
> +	u8 tg[8];
> +	u32 ticks;
> +	u8 crc;
> +
> +	memcpy(tg, sgp40_measure_raw_tg, 2);

It looks like this would benefit from a packed structure into which we
can directly assign the various parts - something like

struct {
	u8 command[2];
	__be16 rel_humidity_ticks;
	u8 rht_crc;
	__be16 temp_ticks;
	u8 temp_crc;
} __packed tg;

> +
> +	ticks = (data->rel_humidity / 10) * 65535 / 10000;
> +	buf_be16 = cpu_to_be16((u16)ticks);

It's not immediately obvious ticks won't overflow a u16, so may be best to
use clamp() to ensure it doesn't.

> +	memcpy(&tg[2], &buf_be16, 2);
> +	tg[4] = crc8(sgp40_crc8_table, &tg[2], 2, SGP40_CRC8_INIT);
> +
> +	ticks = ((data->temperature + 45000) / 10) * 65535 / 17500;
> +	buf_be16 = cpu_to_be16((u16)ticks);
> +	memcpy(&tg[5], &buf_be16, 2);
> +	tg[7] = crc8(sgp40_crc8_table, &tg[5], 2, SGP40_CRC8_INIT);
> +
> +	ret = i2c_master_send(client, (const char *)tg, sizeof(tg));
> +	if (ret != sizeof(tg)) {
> +		dev_warn(data->dev, "i2c_master_send ret: %d sizeof: %d\n", ret, sizeof(tg));
> +		return -EIO;
> +	}
> +	msleep(30);
> +
> +	ret = i2c_master_recv(client, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf)) {
> +		dev_warn(data->dev, "i2c_master_recv ret: %d sizeof: %d\n", ret, sizeof(buf));
> +		return -EIO;
> +	}
> +
> +	crc = crc8(sgp40_crc8_table, buf, 2, SGP40_CRC8_INIT);
> +	if (crc != buf[2]) {
> +		dev_err(data->dev, "CRC error while measure-raw\n");
> +		return -EIO;
> +	}
> +
> +	memcpy(&buf_be16, buf, sizeof(buf_be16));
> +	*raw = be16_to_cpu(buf_be16);
> +
> +	return 0;
> +}
> +
> +static int sgp40_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan, int *val,
> +			int *val2, long mask)
> +{
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u16 raw;
> +	int voc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
> +		ret = sgp40_measure_raw(data, &raw);
> +		if (ret) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +		*val = raw;
> +		ret = IIO_VAL_INT;
> +		mutex_unlock(&data->lock);
> +		break;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		mutex_lock(&data->lock);
> +		ret = sgp40_measure_raw(data, &raw);
> +		if (ret) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +		ret = sgp40_calc_voc(data, raw, &voc);
> +		if (ret) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +		*val = voc;
> +		ret = IIO_VAL_INT;
> +		mutex_unlock(&data->lock);

You are holding the lock longer than needed - it would be good
to reduce this, hopefully removing the need for unlocking separately
in each of the error paths.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;

Drop this as you can't get here.

> +}
> +
> +static ssize_t rel_humidity_comp_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u32 val;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > 100000)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +	data->rel_humidity = val;
> +	mutex_unlock(&data->lock);
> +
> +	return len;
> +}
> +
> +static ssize_t rel_humidity_comp_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	ret = snprintf(buf, PAGE_SIZE, "%d\n", data->rel_humidity);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t temperature_comp_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +	int val;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if ((val < -45000) || (val > 130000))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +	data->temperature = val;
> +	mutex_unlock(&data->lock);
> +
> +	return len;
> +}
> +
> +static ssize_t temperature_comp_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	ret = snprintf(buf, PAGE_SIZE, "%d\n", data->temperature);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t raw_mean_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +	u32 val;
> +
> +	ret = kstrtouint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if ((val < 20000) || (val > 52768))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +	data->raw_mean = val;

Huh.  That is definitely not what I was expecting.  You are writing
the mean?  That's odd. Docs needed.

> +	mutex_unlock(&data->lock);
> +
> +	return len;
> +}
> +
> +static ssize_t raw_mean_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	ret = snprintf(buf, PAGE_SIZE, "%d\n", data->raw_mean);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static IIO_DEVICE_ATTR_RW(rel_humidity_comp, 0);
> +static IIO_DEVICE_ATTR_RW(temperature_comp, 0);
> +static IIO_DEVICE_ATTR_RW(raw_mean, 0);
> +
> +static struct attribute *sgp40_attrs[] = {
> +	&iio_dev_attr_rel_humidity_comp.dev_attr.attr,
> +	&iio_dev_attr_temperature_comp.dev_attr.attr,

I'm somewhat guessing on what exactly these two are, but assuming they
are meant as place you push in the temperature and relative humidity that
then gets used in some calculations...

To avoid adding ABI for these cases, what we have often done before
is specified them as 'output' channels.  In some sense we are telling the
sensor what the temperature is for example, so this mapping isn't too
unexpected or unintuitive.  It's not perfect, but it's better than defining
new ABI without clear units etc.

> +	&iio_dev_attr_raw_mean.dev_attr.attr,

We have *_mean_raw as standard (though not often used) ABI.
Does that map to what you have here?
You would need to add a channel specific line in the ABI docs though.

> +	NULL
> +};
> +
> +static const struct attribute_group sgp40_attr_group = {
> +	.attrs = sgp40_attrs,
> +};
> +
> +static const struct iio_info sgp40_info = {
> +	.attrs		= &sgp40_attr_group,
> +	.read_raw	= sgp40_read_raw,
> +};
> +
> +static int sgp40_probe(struct i2c_client *client,
> +		     const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct sgp40_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

Not used, so don't set it until it is used in some future patch.

> +	data->client = client;
> +	data->dev = dev;
> +
> +	crc8_populate_msb(sgp40_crc8_table, SGP40_CRC8_POLYNOMIAL);
> +
> +	mutex_init(&data->lock);
> +
> +	/* set default values */
> +	data->rel_humidity = 50000;	/* 50 % */
> +	data->temperature = 25000;	/* 25 °C */
> +	data->raw_mean = 30000;		/* resistance raw value for voc index of 250 */
> +
> +	indio_dev->info = &sgp40_info;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = sgp40_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sgp40_channels);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register iio device\n");
> +		return ret;
> +	}

Given the device register will probably always be last so we aren't avoiding
code churn with this structure, I would suggest you instead do

	if (ret)
		dev_err(dev,..)

	return ret;

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id sgp40_id[] = {
> +	{ "sgp40" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, sgp40_id);
> +
> +static const struct of_device_id sgp40_dt_ids[] = {
> +	{ .compatible = "sensirion,sgp40" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, sgp40_dt_ids);
> +
> +static struct i2c_driver sgp40_driver = {
> +	.driver = {
> +		.name = "sgp40",
> +		.of_match_table = sgp40_dt_ids,
> +	},
> +	.probe = sgp40_probe,
> +	.id_table = sgp40_id,
> +};
> +module_i2c_driver(sgp40_driver);
> +
> +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> +MODULE_DESCRIPTION("Sensirion SGP40 gas sensors");
> +MODULE_LICENSE("GPL v2");

