Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9728110E1E7
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 13:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLAMgM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 07:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfLAMgM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 07:36:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D0320833;
        Sun,  1 Dec 2019 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575203770;
        bh=iZWrc9JjufCoE8vXG/VBTYA57yenGkcNuJNxMwGof0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L2n4xqTB8luSk4rgO8b22UYTrG/+lDzHxA2N69yYqmDxufChjoMRCUntLRkDDst5Q
         nuYsAoOzp9XbyD+6M0eTBdIoquOtz9hjaCAy3C4IgNYqkFp+7xklt4OyZvHElYGq/5
         TQ5rr3DwLrxkUZkJKDROsEYhD3PN7+03+ZjDVtiM=
Date:   Sun, 1 Dec 2019 12:36:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20191201123606.1db0d5b1@archlinux>
In-Reply-To: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
References: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Nov 2019 20:06:32 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

> Hello,
> 
> Here comes the revised driver for TI HDC 2010 and 2080 humidity and temperature sensors.
> This includes amendments following the initial review. Max temp and humidity are now made into peak channels. These are made to share the scales and offsets with primary channels as suggested.
> (BTW, any particular reason there is no IIO_CHAN_INFO_PEAK_OFFSET in the core?)

Previously sensors have stored their 'peak' values by directly keeping a copy
of the data in the same format at their measurement registers.   Hence
scale and offset are assumed to be the same as the _RAW versions.

I see PEAK_SCALE is there as it's used in one driver in staging.
I guess that particular part didn't have an offset so at the time
we didn't add it.  I'm not against adding PEAK_OFFSET if
it is particularly useful though.


> 
> Heater out has been converted to IIO_CHAN_INFO_ENABLE, hope it is idiomatic use.
Hmm. This is one of those cases where we are probably better off matching
existing drivers even if they are a bit illogical.

The enable element is mainly used for counting type sensors (start counting
steps etc) where there is a clear difference between it being on and taking
a measurement.

For heaters existing precedence has been to use a current control with
0 as off and the documented output current as on.
If there are other drivers using it this way, then feel free to point them
out!

Whilst it will work, I'd like to avoid having multiple iio_chan_spec
structures representing what are effectively the same IIO channel.
That sort of 'non' standard approach is fragile to changes in how the
core handles things.

Jonathan

> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> 
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/hdc2010.c linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c
> --- linux-5.3.8/drivers/iio/humidity/hdc2010.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2019-11-28 12:42:06.092046846 +0100
> @@ -0,0 +1,313 @@
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
> +static const struct iio_chan_spec hdc2010_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = HDC2010_REG_TEMP_LOW,
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.address = HDC2010_REG_TEMP_MAX,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),

Not sure I like this approach of a separate channel.  The intent of
my previous review as to suggest we used a single channel. Here
we are really just adding one to get an address.  Whilst it works
today, this sort of unusual structure can make it harder to refactor
core elements of the code in the future.

I'd rather see a bit of indirection where address actually gives
an enum value from which the data and _MAX registers can be
established via a lookup in an associated array.

> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.address = HDC2010_REG_HUMIDITY_LOW,
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.address = HDC2010_REG_HUMIDITY_MAX,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
As with the temperature
> +	},
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE),
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
> +	ret = i2c_smbus_read_word_data(data->client, chan->address);
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
> +	ret = i2c_smbus_read_byte_data(data->client, chan->address);
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
> +	case IIO_CHAN_INFO_ENABLE: {
> +		int ret;
> +
> +		mutex_lock(&data->lock);
> +		if (chan->type == IIO_CURRENT) {
> +			*val = hdc2010_get_heater_status(data);
> +			ret = IIO_VAL_INT;
> +		} else
> +			ret = -EINVAL;
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	case IIO_CHAN_INFO_RAW: {
> +		int ret;
> +
> +		mutex_lock(&data->lock);
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +		ret = hdc2010_get_measurement_word(data, chan);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret >= 0) {
> +			*val = ret;
> +			ret = IIO_VAL_INT;
> +		} else
> +			ret = -EINVAL;
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	case IIO_CHAN_INFO_PEAK: {
> +		int ret;
> +
> +		mutex_lock(&data->lock);
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +		ret = hdc2010_get_measurement_byte(data, chan);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret >= 0) {
> +		  /* Scaling up the value so we can use same offset as RAW */
> +			*val = ret * 256;
> +			ret = IIO_VAL_INT;
> +		} else
> +			ret = -EINVAL;
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	case IIO_CHAN_INFO_PEAK_SCALE:
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
> +	case IIO_CHAN_INFO_ENABLE:
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
> +};
> +
> +static int hdc2010_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hdc2010_data *data;
> +	u8 tmp;
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
> +		   HDC2010_MEAS_TRIG & data->measurement_config)
> +	       | HDC2010_MEAS_TRIG;
> +
> +	if (!i2c_smbus_write_byte_data(data->client,
> +				       HDC2010_REG_MEASUREMENT_CONF, tmp))
> +		data->measurement_config = tmp;

If this write failed, should we not return an error?  If not we move
forwards in an unknown state.
	ret = i2c_smbus_write_byte_data()
	if (ret)
		return ret;

	data->m...


> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id hdc2010_id[] = {
> +	{ "hdc2010", 0 },
> +	{ "hdc2080", 0 },
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

