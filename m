Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812C718EA30
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 17:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCVQR2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 12:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgCVQR1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 12:17:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECC220724;
        Sun, 22 Mar 2020 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584893847;
        bh=jZtexiHwOzLHOqfdbdDeW4LYsoUkjKMTktBUsERpK64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h8xu3KdHKzonG5XOqtjkA6sIpP8cYs+i6zjwfsRsvE0pOo1aLtaqXSAV9VPbJIR1c
         BmhaDQsu9xmoffhhAm5svMHnaBjEQqsFeORPBYxd4ACppyCqDKrbPHk2ju3y9wKbS8
         kEY3juOT3aQ5af48fkGa+OiZ6eaAhFZiAEVxvjZ4=
Date:   Sun, 22 Mar 2020 16:17:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20200322161722.0feb8da8@archlinux>
In-Reply-To: <84EE5291-D8C4-40D3-A75C-92362BF9DF8B@norphonic.com>
References: <84EE5291-D8C4-40D3-A75C-92362BF9DF8B@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Mar 2020 20:06:01 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

>  HDC2010/2080 diver and sysfs documentation for its heater element.
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Hi Eugene

A few minor things inline.  Sorry I missed these on previous reviews!

Thanks,

Jonathan

> 
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010 linux-5.3.8_hdc2010/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
> --- linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_hdc2010/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	2019-12-02 11:09:25.803326999 +0100
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
> +KernelVersion:	5.3.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Controls the heater device within the humidity sensor to get
> +		rid of excess condensation.
> +
> +		Valid control values are 0 = OFF, and 1 = ON.
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/hdc2010.c linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c
> --- linux-5.3.8/drivers/iio/humidity/hdc2010.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2020-03-06 09:51:49.844394670 +0100
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hdc2010.c - Support for the TI HDC2010 and HDC2080
> + * temperature + relative humidity sensors
> + *
> + * Copyright (C) 2019 Norphonic AS
> + * Author: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> + *
> + * Datasheets:
> + * http://www.ti.com/product/HDC2010/datasheet
> + * http://www.ti.com/product/HDC2080/datasheet
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define HDC2010_REG_TEMP_LOW			0x00
> +#define HDC2010_REG_TEMP_HIGH			0x01
> +#define HDC2010_REG_HUMIDITY_LOW		0x02
> +#define HDC2010_REG_HUMIDITY_HIGH		0x03
> +#define HDC2010_REG_INTERRUPT_DRDY		0x04
> +#define HDC2010_REG_TEMP_MAX			0x05
> +#define HDC2010_REG_HUMIDITY_MAX		0x06
> +#define HDC2010_REG_INTERRUPT_EN		0x07
> +#define HDC2010_REG_TEMP_OFFSET_ADJ		0x08
> +#define HDC2010_REG_HUMIDITY_OFFSET_ADJ		0x09
> +#define HDC2010_REG_TEMP_THR_L			0x0a
> +#define HDC2010_REG_TEMP_THR_H			0x0b
> +#define HDC2010_REG_RH_THR_L			0x0c
> +#define HDC2010_REG_RH_THR_H			0x0d
> +#define HDC2010_REG_RESET_DRDY_INT_CONF		0x0e
> +#define HDC2010_REG_MEASUREMENT_CONF		0x0f
> +
> +#define HDC2010_MEAS_CONF			GENMASK(2, 1)
> +#define HDC2010_MEAS_TRIG			BIT(0)
> +#define HDC2010_HEATER_EN			BIT(3)
> +#define HDC2010_AMM				GENMASK(6, 4)
> +
> +struct hdc2010_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	u8 measurement_config;
> +	u8 interrupt_config;
> +	u8 drdy_config;
> +};
> +
> +enum hdc2010_addr_groups {
> +	HDC2010_GROUP_TEMP = 0,
> +	HDC2010_GROUP_HUMIDITY
> +};
> +
> +struct hdc2010_reg_record {
> +	unsigned long primary;
> +	unsigned long peak;
> +};
> +
> +static const struct hdc2010_reg_record hdc2010_reg_translation[] = {
> +	[HDC2010_GROUP_TEMP] = {
> +		.primary = HDC2010_REG_TEMP_LOW,
> +		.peak = HDC2010_REG_TEMP_MAX,
> +	},
> +	[HDC2010_GROUP_HUMIDITY] = {
> +		.primary = HDC2010_REG_HUMIDITY_LOW,
> +		.peak = HDC2010_REG_HUMIDITY_MAX,
> +	},
> +};
> +
> +static IIO_CONST_ATTR(out_current_heater_raw_available,
> +		"0 1");
> +
> +static struct attribute *hdc2010_attributes[] = {
> +	&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hdc2010_attribute_group = {
> +	.attrs = hdc2010_attributes,
> +};
> +
> +static const struct iio_chan_spec hdc2010_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = HDC2010_GROUP_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PEAK) |
> +			BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.address = HDC2010_GROUP_HUMIDITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PEAK) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.extend_name = "heater",
> +		.output = 1,
> +	},
> +};
> +
> +static int hdc2010_update_drdy_config(struct hdc2010_data *data,
> +					     char mask, char val)
> +{
> +	char tmp = (~mask & data->drdy_config) | val;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					HDC2010_REG_RESET_DRDY_INT_CONF, tmp);
> +	if (!ret)
> +		data->drdy_config = tmp;
> +
> +	return ret;
> +}
> +
> +static int hdc2010_get_measurement_word(struct hdc2010_data *data,
> +					struct iio_chan_spec const *chan)
> +{
> +	struct i2c_client *client = data->client;
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_word_data(client,
> +			hdc2010_reg_translation[chan->address].primary);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +
> +	return ret;
> +}
> +
> +static int hdc2010_get_measurement_byte(struct hdc2010_data *data,
> +					struct iio_chan_spec const *chan)
> +{
> +	struct i2c_client *client = data->client;
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_byte_data(client,
> +			hdc2010_reg_translation[chan->address].peak);
Bit odd to have a nice 'generic' measurement_byte name for the
function then use it only to read 'peak'.

I'd rename the function (same for the above similar cases)

> +
> +	if (ret < 0)
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +
> +	return ret;
> +}
> +
> +static int hdc2010_get_heater_status(struct hdc2010_data *data)
> +{
> +	return !!(data->drdy_config & HDC2010_HEATER_EN);
> +}
> +
> +static int hdc2010_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct hdc2010_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		int ret;
> +
> +		if (chan->type == IIO_CURRENT) {
> +			*val = hdc2010_get_heater_status(data);
> +			ret = IIO_VAL_INT;

Why do the shared return below?  Just return IIO_VAL_INT here.

> +		} else {
> +			ret = iio_device_claim_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +			mutex_lock(&data->lock);
> +			ret = hdc2010_get_measurement_word(data, chan);
> +			mutex_unlock(&data->lock);
> +			iio_device_release_direct_mode(indio_dev);
> +			if (ret >= 0) {
			if (ret < 0)
				return ret;
			*val = ret;
			return IIO_VAL_INT;


> +				*val = ret;
> +				ret = IIO_VAL_INT;
> +			}
> +
> +		}
> +		return ret;

This won't be needed with the changes I suggest above.

> +	}
> +	case IIO_CHAN_INFO_PEAK: {
> +		int ret;
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->lock);
> +		ret = hdc2010_get_measurement_byte(data, chan);
> +		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret >= 0) {
> +		  /* Scaling up the value so we can use same offset as RAW */
> +			*val = ret * 256;
> +			ret = IIO_VAL_INT;
> +		}
		if (ret < 0)
			return ret;
		*val = ret * 256;
		return IIO_VAL_INT;


> +
> +		return ret;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val2 = 65536;
> +		if (chan->type == IIO_TEMP)
> +			*val = 165000;
> +		else
> +			*val = 100000;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -15887;
> +		*val2 = 515151;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int hdc2010_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct hdc2010_data *data = iio_priv(indio_dev);
> +	int new, ret = -EINVAL;

Unless I'm half asleep (which is possible :) ret is always
written below before being used.  Hence this init isn't needed.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type != IIO_CURRENT || val2 != 0)
> +			return -EINVAL;
> +
> +		switch (val) {
> +		case 1:
> +			new = HDC2010_HEATER_EN;
> +			break;
> +		case 0:
> +			new = 0;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		mutex_lock(&data->lock);
> +		ret = hdc2010_update_drdy_config(data, HDC2010_HEATER_EN, new);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info hdc2010_info = {
> +	.read_raw = hdc2010_read_raw,
> +	.write_raw = hdc2010_write_raw,
> +	.attrs = &hdc2010_attribute_group,
> +};
> +
> +static int hdc2010_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hdc2010_data *data;
> +	u8 tmp;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = dev_name(&client->dev);

That should be the part number.  IIRC that's not what you'll get
from dev_name called on the i2c device.  Note we let a few of
these in in the past and are now stuck with them... 

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hdc2010_info;
> +
> +	indio_dev->channels = hdc2010_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc2010_channels);
> +
> +	/* Enable Automatic Measurement Mode at 5Hz */
> +	hdc2010_update_drdy_config(data, HDC2010_AMM, HDC2010_AMM);

Error handling?

> +
> +	/*
> +	 * We enable both temp and humidity measurement.
> +	 * However the measurement won't start even in AMM until triggered.
> +	 */
> +	tmp = (u8)(data->measurement_config & ~HDC2010_MEAS_CONF) |
> +		HDC2010_MEAS_TRIG;
> +
> +	ret = i2c_smbus_write_byte_data(client,
> +					HDC2010_REG_MEASUREMENT_CONF, tmp);
> +	if (ret)
> +		return ret;
> +	data->measurement_config = tmp;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id hdc2010_id[] = {
> +	{ "hdc2010" },
> +	{ "hdc2080" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, hdc2010_id);
> +
> +static const struct of_device_id hdc2010_dt_ids[] = {
> +	{ .compatible = "ti,hdc2010" },
> +	{ .compatible = "ti,hdc2080" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hdc2010_dt_ids);
> +
> +static struct i2c_driver hdc2010_driver = {
> +	.driver = {
> +		.name	= "hdc2010",
> +		.of_match_table = hdc2010_dt_ids,
> +	},
> +	.probe = hdc2010_probe,
> +	.id_table = hdc2010_id,
> +};
> +module_i2c_driver(hdc2010_driver);
> +
> +MODULE_AUTHOR("Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>");
> +MODULE_DESCRIPTION("TI HDC2010 humidity and temperature sensor driver");
> +MODULE_LICENSE("GPL");
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/Kconfig linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig
> --- linux-5.3.8/drivers/iio/humidity/Kconfig	2019-10-29 09:22:48.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig	2019-11-28 14:31:27.794242693 +0100
> @@ -38,6 +38,16 @@ config HDC100X
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called hdc100x.
>  
> +config HDC2010
> +	tristate "TI HDC2010 relative humidity and temperature sensor"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Texas Instruments
> +	  HDC2010 and HDC2080 relative humidity and temperature sensors.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called hdc2010.
> +
>  config HID_SENSOR_HUMIDITY
>  	tristate "HID Environmental humidity sensor"
>  	depends on HID_SENSOR_HUB
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/Makefile linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile
> --- linux-5.3.8/drivers/iio/humidity/Makefile	2019-10-29 09:22:48.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile	2019-11-28 14:30:40.609892061 +0100
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_AM2315) += am2315.o
>  obj-$(CONFIG_DHT11) += dht11.o
>  obj-$(CONFIG_HDC100X) += hdc100x.o
> +obj-$(CONFIG_HDC2010) += hdc2010.o
>  obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
>  
>  hts221-y := hts221_core.o \
> 

