Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D981B948C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDZWfl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 18:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgDZWfk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 18:35:40 -0400
Received: from ns.pmeerw.net (ns.pmeerw.net [IPv6:2001:1b60:2:23:1033:103:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8841DC061A0F
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2020 15:35:40 -0700 (PDT)
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 4E3CCE09EE; Mon, 27 Apr 2020 00:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1587940538; bh=4s4PCAhGsV+t1r/1jZy6Cmg8A+R3k7chIZhsrIUHEr4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KgyhZbSL7U1qzfRWcwYKMuS353robdWyHUu3aIU31rbWwIL7U86grkFFm+TmpuF2w
         VQQwKSGyBrh2kFmGZW9AMpIucZLKEmzxq4DB80cGb3Ut2rxql+rT3y6YHSnoHn7cPS
         cVEygqf7plPfg/cDU3BIA66WV0RuGGilEz0w4cZQ=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 32D61E0284;
        Mon, 27 Apr 2020 00:35:38 +0200 (CEST)
Date:   Mon, 27 Apr 2020 00:35:38 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Eugene Zalkonnikov <ez@norphonic.com>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
In-Reply-To: <E372084A-C6C5-4261-90C5-B810ADAFDD73@norphonic.com>
Message-ID: <alpine.DEB.2.21.2004270024590.16743@vps.pmeerw.net>
References: <E372084A-C6C5-4261-90C5-B810ADAFDD73@norphonic.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Apr 2020, Eugene Zalkonnikov wrote:

> HDC2010/2080 driver and sysfs documentation for its heater element.

comments below

> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
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
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2020-04-24 18:04:48.699251583 +0200
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hdc2010.c - Support for the TI HDC2010 and HDC2080
> + * temperature + relative humidity sensors
> + *
> + * Copyright (C) 2020 Norphonic AS
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

maybe u8 instead of char; drdy_config is u8

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
> +static int hdc2010_get_prim_measurement_word(struct hdc2010_data *data,
> +					     struct iio_chan_spec const *chan)
> +{
> +	struct i2c_client *client = data->client;
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_word_data(client,
> +			hdc2010_reg_translation[chan->address].primary);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev, "Could not read sensor data\n");

I suggest to use distinct error messages (if you really need them)

> +
> +	return ret;
> +}
> +
> +static int hdc2010_get_peak_measurement_byte(struct hdc2010_data *data,
> +					     struct iio_chan_spec const *chan)
> +{
> +	struct i2c_client *client = data->client;
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_byte_data(client,
> +			hdc2010_reg_translation[chan->address].peak);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +
> +	return ret;
> +}
> +
> +static int hdc2010_get_heater_status(struct hdc2010_data *data)

return value should be bool?

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
> +			return IIO_VAL_INT;
> +		}
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->lock);
> +		ret = hdc2010_get_prim_measurement_word(data, chan);
> +		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_PEAK: {
> +		int ret;
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->lock);
> +		ret = hdc2010_get_peak_measurement_byte(data, chan);
> +		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +		/* Scaling up the value so we can use same offset as RAW */
> +		*val = ret * 256;

I'd rather have different _SCALEs for peak and raw

> +		return IIO_VAL_INT;
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
> +	int new, ret;
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
> +	/*
> +	 * As DEVICE ID register does not differentiate between
> +	 * HDC2010 and HDC2080, we have the name hardcoded
> +	 */
> +	indio_dev->name = "hdc2010";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hdc2010_info;
> +
> +	indio_dev->channels = hdc2010_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc2010_channels);
> +
> +	/* Enable Automatic Measurement Mode at 5Hz */
> +	ret = hdc2010_update_drdy_config(data, HDC2010_AMM, HDC2010_AMM);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * We enable both temp and humidity measurement.
> +	 * However the measurement won't start even in AMM until triggered.
> +	 */
> +	tmp = (u8)(data->measurement_config & ~HDC2010_MEAS_CONF) |
> +		HDC2010_MEAS_TRIG;

shouldn't this be disabled when the driver is unloaded?

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

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
