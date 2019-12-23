Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5827D129934
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLWRQd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:16:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWRQd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:16:33 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC6420663;
        Mon, 23 Dec 2019 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577121392;
        bh=isOQKl1pCjmsFvdGoyb6sVElYqeS+kfnxAs3JLDE5tU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fjWF736CgMLohIIm/Vl2rUkPS7cQPgyjb4OkvWVYihii2qqNBCsuqimvE58aUfv6Q
         aLNeYlbJK3SCGXbNEYb0Fc5dq8fWQYwKovGX+cn9vdvRB1mtpErB9NMOU+Uz5zxaDw
         eIXt87/Ca313ejiV8dSDyq60gQDO7LndtPDa7s4s=
Date:   Mon, 23 Dec 2019 17:16:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20191223171627.1179f88b@archlinux>
In-Reply-To: <B0A4F7BA-0D41-4DA0-985E-F2603D66C48F@norphonic.com>
References: <B0A4F7BA-0D41-4DA0-985E-F2603D66C48F@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Dec 2019 15:55:23 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

> Changes to scope of locking.
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Looks pretty good.  Just a couple of minor things inline to tidy up for v4.

thanks,

Jonathan

> 
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/hdc2010.c linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c
> --- linux-5.3.8/drivers/iio/humidity/hdc2010.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2019-12-13 16:44:13.321334255 +0100
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
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
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
> +	ret = i2c_smbus_read_word_data(data->client,
> +			hdc2010_reg_translation[chan->address].primary);
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +	}
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
> +	ret = i2c_smbus_read_byte_data(data->client,
> +			hdc2010_reg_translation[chan->address].peak);
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +	}
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
> +		} else {
> +			ret = iio_device_claim_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +			mutex_lock(&data->lock);
> +			ret = hdc2010_get_measurement_word(data, chan);
> +			mutex_unlock(&data->lock);
> +			iio_device_release_direct_mode(indio_dev);
> +			if (ret >= 0) {
> +				*val = ret;
> +				ret = IIO_VAL_INT;
> +			} else
> +				ret = -EINVAL;

As below. Why change the existing return value?

> +		}
> +		return ret;
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
> +		} else

Why overwrite ret?  That might provide better information
on what went wrong.
			
> +			ret = -EINVAL;
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
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type != IIO_CURRENT || val2 != 0)
> +			return -EINVAL;
> +
> +		if (val == 1)
> +			new = HDC2010_HEATER_EN;
> +		else if (!val)
> +			new = 0;
> +		else
> +			return -EINVAL;
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
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hdc2010_info;
> +
> +	indio_dev->channels = hdc2010_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc2010_channels);
> +
> +	/* Enable Automatic Measurement Mode at 5Hz */
> +	hdc2010_update_drdy_config(data, HDC2010_AMM, HDC2010_AMM);
> +
> +	/*
> +	 * We enable both temp and humidity measurement.
> +	 * However the measurement won't start even in AMM until triggered.
> +	 */
> +	tmp = (u8)(~HDC2010_MEAS_CONF |
> +		   HDC2010_MEAS_TRIG & data->measurement_config) |
> +		HDC2010_MEAS_TRIG;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					HDC2010_REG_MEASUREMENT_CONF, tmp);
> +	if (ret)
> +		return ret;
> +	data->measurement_config = tmp;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id hdc2010_id[] = {
> +	{ "hdc2010", 0 },
> +	{ "hdc2080", 0 },

If we aren't using it, not a lot of point in providing an values for the
data field.

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
> +		.of_match_table = of_match_ptr(hdc2010_dt_ids),

Please drop the of_match_ptr.  It stops us using the PRP01 ACPI
binding which basically lets you use a DT binding in ACPI DSDT and
similar tables.

	.of_match_table = hdc2010_dt_ids,


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

