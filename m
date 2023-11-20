Return-Path: <linux-iio+bounces-196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBA97F19CC
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 18:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916FD1C2113E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E811208D9;
	Mon, 20 Nov 2023 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1549BCF;
	Mon, 20 Nov 2023 09:26:28 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SYvXJ2K97z67nNy;
	Tue, 21 Nov 2023 01:25:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 20 Nov
 2023 17:26:25 +0000
Date: Mon, 20 Nov 2023 17:26:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li peiyu <579lpy@gmail.com>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: humidity: Add driver for ti HDC302x
 humidity sensors
Message-ID: <20231120172624.00000751@Huawei.com>
In-Reply-To: <20231118105815.17171-1-579lpy@gmail.com>
References: <20231118105815.17171-1-579lpy@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Sat, 18 Nov 2023 18:58:15 +0800
Li peiyu <579lpy@gmail.com> wrote:

> Add support for HDC302x integrated capacitive based relative
> humidity (RH) and temperature sensor.
> This driver supports reading values, reading the maximum and
> minimum of values and controlling the integrated heater of
> the sensor.
Change log below the ---


Various comments inline, one big one being there is custom ABI in here and
no documentation so it can't really be reviewed. Note that I'm conservative when
it comes to ABI, may well push back on anything custom or suggest we work out how it
should be made standard ABI.

> 
> changes for v2:
> - Added static modification to global variables
>   | Reported-by: kernel test robot <lkp@intel.com>
>   | Closes: https://lore.kernel.org/oe-kbuild-all/202311171052.IjyxJMuw-lkp@intel.com/

It doesn't mean that and the comment is only for separate patches fixing build issues.
It is telling you to add the tags. not the | 
Still, not relevant here anyway though feel free to thank them in the change log.


> - change the methord to read peak value
> 
> Signed-off-by: Li peiyu <579lpy@gmail.com>
...

> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> new file mode 100644
> index 000000000000..e9df4ef4f02f
> --- /dev/null
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hdc3020.c - Support for the TI HDC3020,HDC3021 and HDC3022
> + * temperature + relative humidity sensors
> + *
> + * Copyright (C) 2023
> + *
> + * Datasheet: https://www.ti.com/lit/ds/symlink/hdc3020.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define READ_RETRY_TIMES 10
> +#define BUSY_DELAY 10
> +
> +static const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
> +
> +static const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
> +
> +static const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
> +static const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
> +static const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
> +static const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
> +static const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
> +
> +static const u8 HDC3020_ENABLE_HEATER[2] = { 0x30, 0x6D };
> +static const u8 HDC3020_DISABLE_HEATER[2] = { 0x30, 0x66 };
> +
> +static const u8 HDC3020_HEATER_FULL[5] = { 0x30, 0x6E, 0x3F, 0xFF, 0x06 };
> +static const u8 HDC3020_HEATER_HALF[5] = { 0x30, 0x6E, 0x03, 0xFF, 0x00 };
> +static const u8 HDC3020_HEATER_QUARTER[5] = { 0x30, 0x6E, 0x00, 0x9F, 0x96 };
> +
> +struct hdc3020_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +
> +	int temp;
> +	int humidity;
> +	int temp_high_peak;
> +	int temp_low_peak;
> +	int humidity_high_peak;
> +	int humidity_low_peak;
> +};
> +
> +/*
> + * For heater
> + * 0 -> turn off
> + * 1 -> 1/4 full power
> + * 2 -> 1/2 full power
> + * 3 -> full power
> + */
> +static IIO_CONST_ATTR(out_current_heater_raw_available, "0 1 2 3");
> +
> +static struct attribute *hdc3020_attributes[] = {
> +	&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
Use get_avail() callback and appropriate bit masks.
Potentially lets in kernel users control this and generally ends up as cleaner
code.


> +	NULL
> +};
> +
> +static const struct attribute_group hdc3020_attribute_group = {
> +	.attrs = hdc3020_attributes,
> +};
> +
> +static const struct iio_chan_spec hdc3020_channels[] = {
> +	{
> +	 .type = IIO_TEMP,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +	 BIT(IIO_CHAN_INFO_SCALE),
> +	  },
> +	{
> +	 .type = IIO_TEMP,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
> +	 .extend_name = "high",

This is defining new ABI so you need documentation. Note that
it is hard to get new ABI accepted, so consider if any of this maps
to existing ABI (it might not of course).

> +	  },
> +	{
> +	 .type = IIO_TEMP,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
> +	 .extend_name = "low",
> +	  },
> +	{
> +	 .type = IIO_HUMIDITYRELATIVE,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +	 BIT(IIO_CHAN_INFO_SCALE),
> +	  },
> +	{
> +	 .type = IIO_HUMIDITYRELATIVE,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
> +	 .extend_name = "high",
> +	  },
> +	{
> +	 .type = IIO_HUMIDITYRELATIVE,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_PEAK),
> +	 .extend_name = "low",
> +	  },
> +	{
> +	 .type = IIO_CURRENT,
> +	 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	 .extend_name = "heater",

Use get_label() for this one...

> +	 .output = 1,
> +	  },
> +};

> +static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
> +			      void *val, int len)
> +{
> +	int ret, cnt;
> +	struct i2c_msg msg[2];
> +	struct i2c_client *client = data->client;
> +
> +	msg[0].addr = client->addr;
> +	msg[0].flags = 0;
> +	msg[0].buf = (char *)buf;
> +	msg[0].len = 2;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].buf = val;
> +	msg[1].len = len;
	struct i2c_msg msg[2] = {
		[0] = {
			.addr = ...

		},
		[1] = {
		},
	};
tends to be more elegant for this type of stuff.
> +
> +	/*
> +	 * During the measurement process, HDC3020 will not return data.
> +	 * So wait for a while and try again
> +	 */
> +	ret = 0;
> +	cnt = 0;
> +
> +	while (cnt < READ_RETRY_TIMES) {
> +		ret = i2c_transfer(client->adapter, msg, 2);
> +		if (ret == 2) {
> +			ret = 0;
> +			break;
> +		}
> +		mdelay(BUSY_DELAY);
> +		cnt++;
> +	}
> +
> +	if (cnt == READ_RETRY_TIMES) {
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +		ret = -EREMOTEIO;
		return -EREMOTEIO; though that's a very rare error code.  I'd handle
it as a timeout.
> +	}
> +
return 0;
> +	return ret;
> +}
> +
> +/*
> + * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
> + * "2608" equals 26.08 DegC.
> + * Returns humidity in percent, resolution is 0.1 percent. Output value of
> + * "323" represents 323/10 = 32.3 %RH.
> + */
> +static int hdc3020_read_measurement(struct hdc3020_data *data)
> +{
> +	int ret;
> +	u8 buf[6];
> +
> +	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, (void *)buf, 6);
> +	if (ret < 0)
> +		return ret;
> +	data->temp = (((int)buf[0] << 8) | buf[1]) * 100 * 175 / 65535 - 4500;
> +	data->humidity = (((int)buf[3] << 8) | buf[4]) * 10 * 100 / 65535;
This is a lot of maths for a raw read callback.  Should this scaling be pushing into
the scale attribute and applied by userspace?  From a quick glance it looks like
you may have it done both ways which means you'll apply the scaling twice when using
standard userspace software.

> +	return 0;
> +}
>
> +
> +/*
> + * After exiting the automatic measurement mode or resetting, the peak
> + * value will be reset to the default value
> + */
> +static int hdc3020_read_high_peak_rh(struct hdc3020_data *data)
> +{
> +	int ret;
> +	u8 buf[3];
> +
> +	ret = hdc3020_read_bytes(data, HDC3020_R_RH_HIGH_AUTO, (void *)buf, 3);
> +	if (ret < 0)
> +		return ret;
> +	data->humidity_high_peak =
> +	    (((int)buf[0] << 8) | buf[1]) * 10 * 100 / 65535;
As below.

> +
> +	return 0;
> +}
> +
> +static int hdc3020_read_low_peak_rh(struct hdc3020_data *data)
> +{
> +	int ret;
> +	u8 buf[3];
> +
> +	ret = hdc3020_read_bytes(data, HDC3020_R_RH_LOW_AUTO, (void *)buf, 3);
> +	if (ret < 0)
> +		return ret;
> +	data->humidity_low_peak =
> +	    (((int)buf[0] << 8) | buf[1]) * 10 * 100 / 65535;

First bit is an endian conversion.  use
get_unaligned_le16() for that.

Looks like you can better handle the division by making it a core IIO problem
and using IIO_VAL_FRACTIONAL

> +
> +	return 0;
> +}
> +
> +static int hdc3020_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct hdc3020_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:{
space after :
> +			int ret;
> +
> +			ret = iio_device_claim_direct_mode(indio_dev);
> +
No blank line here.  Keep cause and error handler in one code block.
> +			if (ret)
> +				return ret;
> +
> +			mutex_lock(&data->lock);
> +			ret = hdc3020_read_measurement(data);
> +			mutex_unlock(&data->lock);
> +			iio_device_release_direct_mode(indio_dev);
> +
> +			if (ret < 0)
> +				return ret;
> +			if (chan->type == IIO_TEMP)
> +				*val = data->temp;
> +			else if (chan->type == IIO_HUMIDITYRELATIVE)
> +				*val = data->humidity;
> +			return IIO_VAL_INT;
> +		}
> +	case IIO_CHAN_INFO_PEAK:{
> +			int ret;
> +
> +			ret = iio_device_claim_direct_mode(indio_dev);
> +
> +			if (ret)
> +				return ret;
> +
> +			if (chan->type == IIO_TEMP) {
> +				if (strcmp(chan->extend_name, "high") == 0) {
Extent name is more or less deprecated for new drivers as it makes a horrible
userspace interface.  To understand why you are using it I'd like to
see some Documentation of these.

Also, we have a bunch of useful channel fields (.address for example) to
avoid having to do string matching in the driver.  Use them.

> +					mutex_lock(&data->lock);
> +					ret = hdc3020_read_high_peak_t(data);
> +					mutex_unlock(&data->lock);
> +					if (ret < 0)
> +						return ret;
> +					*val = data->temp_high_peak;
> +				} else if (strcmp(chan->extend_name, "low") ==
> +					   0) {
> +					mutex_lock(&data->lock);
> +					ret = hdc3020_read_low_peak_t(data);
> +					mutex_unlock(&data->lock);
> +					if (ret < 0)
> +						return ret;
> +					*val = data->temp_low_peak;
> +				}
> +			} else if (chan->type == IIO_HUMIDITYRELATIVE) {
> +				if (strcmp(chan->extend_name, "high") == 0) {
> +					mutex_lock(&data->lock);
> +					ret = hdc3020_read_high_peak_rh(data);
> +					mutex_unlock(&data->lock);
> +					if (ret < 0)
> +						return ret;
> +					*val = data->humidity_high_peak;
> +				} else if (strcmp(chan->extend_name, "low") ==
> +					   0) {
> +					mutex_lock(&data->lock);
> +					ret = hdc3020_read_low_peak_rh(data);
> +					mutex_unlock(&data->lock);
> +					if (ret < 0)
> +						return ret;
> +					*val = data->humidity_low_peak;
> +				}
> +			}
> +			iio_device_release_direct_mode(indio_dev);
> +			return IIO_VAL_INT;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val2 = 65536;
> +		if (chan->type == IIO_TEMP)
> +			*val = 1750;
> +		else
> +			*val = 1000;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int hdc3020_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct hdc3020_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type != IIO_CURRENT || val2 != 0)
> +			return -EINVAL;
> +
> +		switch (val) {
> +		case 1:

Seems like an enum would be better here to name the different channels.

> +			mutex_lock(&data->lock);
Having tight locks around each access is probably not sensible.

			scoped_guard(mutex, &data->lock) {
				ret = hdc3020_write_bytes(data,
							  HDC3020_HEATER_QUARTER,
							  5);
				if (ret < 0)
					return ret;
				ret = hdc3020_write_bytes(data,
							  HDC3020_ENABLE_HEATER,
							  2);
			}

Maybe, or add scope using (given the deep indent.)
		case 1: {
			guard(mutex)(&data->lock);

			ret = ...

		}				
Given the default isn't supposed to happen, you could just take the mutex across
the whole switch statement and simplify thing further.  Add a precheck on value
range to catch that case perhaps?

> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_HEATER_QUARTER,
> +						5);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			mutex_lock(&data->lock);
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case 2:
> +			mutex_lock(&data->lock);
> +			ret = hdc3020_write_bytes(data, HDC3020_HEATER_HALF, 5);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			mutex_lock(&data->lock);
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case 3:
> +			mutex_lock(&data->lock);
> +			ret = hdc3020_write_bytes(data, HDC3020_HEATER_FULL, 5);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			mutex_lock(&data->lock);
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case 0:
> +			mutex_lock(&data->lock);
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_DISABLE_HEATER,
> +						2);
> +			mutex_unlock(&data->lock);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info hdc3020_info = {
> +	.read_raw = hdc3020_read_raw,
> +	.write_raw = hdc3020_write_raw,
> +	.attrs = &hdc3020_attribute_group,
> +};
> +
> +static int hdc3020_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hdc3020_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;

blank line here

> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;

and here to help readability.

> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

After dropping remove as suggested below this 'might' not be needed.
I haven't checked thoroughly.

> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = "hdc3020";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hdc3020_info;
> +
> +	indio_dev->channels = hdc3020_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
> +
> +	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to set up measurement\n");

For errors in probe it's nice to use
		return dev_err_probe(&client->dev, ret, "Unable to set up measurement\n");

> +		return ret;
> +	}
> +
> +	return iio_device_register(indio_dev);

If this returns an error you should be undoing the AUTO stuff above as is
done in remove.  Better still use devm_add_action_or_reset() and a suitable
callback to do both paths automatically.
Then use devm_iio_device_register and get rid of the remove function entirely.

> +}
> +
> +static void hdc3020_remove(struct i2c_client *client)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hdc3020_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	/* Disable Automatic Measurement Mode */
> +	ret = hdc3020_write_bytes(data, HDC3020_EXIT_AUTO, 2);
When there is very little to be done in remove it is normally worth
considering if it is appropriate to use a devm_add_action_or_reset()
call in probe so that we can rely on the auto cleanup to handle it both
in remove and error. See above.
> +	if (ret)
> +		dev_err(&client->dev, "Unable to stop measurement\n");
> +}
> +
> +static const struct i2c_device_id hdc3020_id[] = {
> +	{ "hdc3020" },
> +	{ "hdc3021" },
> +	{ "hdc3022" },
> +	{ }
> +};
> +
As below. No blank line here.
> +MODULE_DEVICE_TABLE(i2c, hdc3020_id);
> +
> +static const struct of_device_id hdc3020_dt_ids[] = {
> +	{.compatible = "ti,hdc3020" },
> +	{.compatible = "ti,hdc3021", "ti,hdc3020" },
> +	{.compatible = "ti,hdc3022", "ti,hdc3020" },

As Conor observed, this is not what was meant by fall back compatibles.

> +	{ }
> +};
> +
Normally we don't put a blank line here as the table and the
macro are so closely coupled.
> +MODULE_DEVICE_TABLE(of, hdc3020_dt_ids);
> +
> +static struct i2c_driver hdc3020_driver = {
> +	.driver = {
> +		   .name = "hdc3020",
> +		   .of_match_table = hdc3020_dt_ids,

Aligned to one tab more than .driver.

> +		    },

Normally aligned to . not over here with random number of
spaces in front of it.

> +	.probe = hdc3020_probe,
> +	.remove = hdc3020_remove,
> +	.id_table = hdc3020_id,
> +};
> +
> +module_i2c_driver(hdc3020_driver);
> +
> +MODULE_AUTHOR("Li peiyu <579lpy@gmail.com>");
> +MODULE_DESCRIPTION("TI HDC3020 humidity and temperature sensor driver");
> +MODULE_LICENSE("GPL");


