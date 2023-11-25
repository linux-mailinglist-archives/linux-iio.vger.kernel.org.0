Return-Path: <linux-iio+bounces-342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B77F8BDA
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 15:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0FB1C20CED
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1A24A06;
	Sat, 25 Nov 2023 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dueVFIfN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027ED50B;
	Sat, 25 Nov 2023 14:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC93C433C7;
	Sat, 25 Nov 2023 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700923936;
	bh=Dy7/DQps4USJS9fuJA8v95SSz1FFguiRw8OkPI3Tfag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dueVFIfNSnuoHXKxT/jvGEmdFQ/0sGMRQypz2Hg1pHTbW1iK3BgZipojraSzY6lcg
	 7W6d1ycSN/zbCjkykDoxJbhv9o8ECJTM7rkgwz5FcilN2Lh77XhayDjYLeKvXBHMLz
	 jgIdZRk92xoCSiFwgYJRHfgolzpoDKCqOLIwmyub4qO1wrnKdtsL9tVrH916nbPob0
	 Wb8n+mbyE/1O8WDc8NDZWeAI5vdM93vz3Zlqj4UE4wMXw6cNIqiqPv5/gPtTQXJPC7
	 ZDXYCPyHT3Tl6Gkh7O4PcJz45AwbPx2PVniLNkM6wBtERa8/1G95nLUurj2IdVH1II
	 thDPQHKdH/Ukg==
Date: Sat, 25 Nov 2023 14:52:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: 579lpy@gmail.com
Cc: lars@metafoo.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: humidity: Add driver for ti HDC302x
 humidity sensors
Message-ID: <20231125145208.01194d91@jic23-huawei>
In-Reply-To: <20231125102221.2795-1-579lpy@gmail.com>
References: <20231125102221.2795-1-579lpy@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 18:22:21 +0800
579lpy@gmail.com wrote:

> From: Li peiyu <579lpy@gmail.com>
> 
> Add support for HDC302x integrated capacitive based relative
> humidity (RH) and temperature sensor.
> This driver supports reading values, reading the maximum and
> minimum of values and controlling the integrated heater of
> the sensor.
> 
> Signed-off-by: Li peiyu <579lpy@gmail.com>
Hi,

Please always use a cover letter for series, as it adds a place for
series wide comments or tags given by reviewers.  Also gives it
a nice name in patchwork :)

https://patchwork.kernel.org/project/linux-iio/list/?series=804184
just uses the name of the first patch which isn't ideal.

Include a brief description of the series in that cover letter.
Here it might be useful to also include a dump of the ABI
(so list of files created) as there are some unusual bits of ABI usage
in here.

...

> index 2de5494e7c22..7b585bc7db9a 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -48,6 +48,17 @@ config HDC2010
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called hdc2010.
>  
> +config HDC3020
> +	tristate "TI HDC3020 relative humidity and temperature sensor"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Texas Instruments
> +	  HDC3020,HDC3021 and HDC3022 relative humidity and temperature

space after ,

Please proof read all the comments etc, as a few cases of this...


> +	  sensors.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called hdc3020.
> +
>  config HID_SENSOR_HUMIDITY
>  	tristate "HID Environmental humidity sensor"
>  	depends on HID_SENSOR_HUB
> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
> index f19ff3de97c5..5fbeef299f61 100644
> --- a/drivers/iio/humidity/Makefile
> +++ b/drivers/iio/humidity/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_AM2315) += am2315.o
>  obj-$(CONFIG_DHT11) += dht11.o
>  obj-$(CONFIG_HDC100X) += hdc100x.o
>  obj-$(CONFIG_HDC2010) += hdc2010.o
> +obj-$(CONFIG_HDC3020) += hdc3020.o
>  obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
>  
>  hts221-y := hts221_core.o \
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> new file mode 100644
> index 000000000000..bbd90abfb7df
> --- /dev/null
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -0,0 +1,522 @@
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
> +#include <asm/unaligned.h>
We usually put asm in it's own block after all linux/* headers

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
Not seeing this used.
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

All locks should have a comment explaining the scope of data they cover.

> +
> +	int temp;
> +	int humidity;
> +	int temp_high_peak;
> +	int temp_low_peak;
> +	int humidity_high_peak;
> +	int humidity_low_peak;
Store these in appropriate sized fields.  u16 I think from a quick look.

> +};
> +
> +enum hdc3020_heater_power {
> +	HEATER_OFF = 0,
> +	HEATER_QUARTER = 1,
> +	HEATER_HALF = 2,
> +	HEATER_FULL = 3,
This isn't really an enum as you are exposing these as control values.

Might make a more intuitive interface to use HEATER_FULL = 4
as then it's linear.

> +};
> +
> +static const int HEATER_VALUES[] = { HEATER_OFF, HEATER_QUARTER, HEATER_HALF,
> +				     HEATER_FULL };
capitals reserved for #defines plus enums uses in similar fashion.

static const int hdc3020_heater_values[] = {
	HEATER_OFF,
	HEATER_QUARTER,
	HEATER_HALF,
	HEATER_FULL,
};

> +
> +static const struct iio_chan_spec hdc3020_channels[] = {
> +	{
> +		.type = IIO_TEMP,

There is only one temp channel so I'd like to see the peaks added to this
one as well.  Can be done if we add a new bit of ABI for the min value
seen.

Whilst naming .index = 0, .channel = 0 is different from this case
the ABI and all userspace software should treat them the same hence this
is an ambiguous channel specification.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		/* For minimum value during measurement */

Please add some docs for this - preferably in patch description
or cover letter if it is too long for there. You are using the ABI in a fashion
not previously considered.

I don't think it is a good solution.  Perhaps keeping IIO_CHAN_INFO_PEAK
as assumed to be maximum, we could add a new IIO_CHAN_INFO_TROUGH
perhaps?  Hopefully the scale applies to both peak and trough so we
don't need separate attributes.

> +		.type = IIO_TEMP,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK) |
> +		BIT(IIO_CHAN_INFO_PEAK_SCALE),

Not shared by type?

> +		.indexed = 1,
> +	},
> +	{
> +		/* For maxmum value during measurement */
> +		.type = IIO_TEMP,
> +		.channel = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK) |
> +		BIT(IIO_CHAN_INFO_PEAK_SCALE),
> +		.indexed = 1,
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		/* For minimum value during measurement */
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK) |
> +		BIT(IIO_CHAN_INFO_PEAK_SCALE),
> +		.indexed = 1,
> +	},
> +	{
> +		/* For maxmum value during measurement */
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.channel = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PEAK) |
> +		BIT(IIO_CHAN_INFO_PEAK_SCALE),
> +		.indexed = 1,
> +	},
> +	{
> +		/* For setting the internal heater,which can be switched on to

space after ,

> +		 * prevent or remove any condensation that may develop when the
> +		 * ambient environment approaches its dew point temperature.
> +		 */
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate_available = 1,
> +		.output = 1,
> +	},
> +};
> +
> +static int hdc3020_write_bytes(struct hdc3020_data *data, const u8 *buf,
> +			       u8 len)
> +{
> +	int ret, cnt;
> +	struct i2c_msg msg;
> +	struct i2c_client *client = data->client;
> +
> +	msg.addr = client->addr;
> +	msg.flags = 0;
> +	msg.buf = (char *)buf;
> +	msg.len = len;
> +
> +	/*
> +	 * During the measurement process, HDC3020 will not return data.
> +	 * So wait for a while and try again
> +	 */
> +	ret = 0;
> +	cnt = 0;

Similar comments to the read function apply here.
Can simplify this function in similar ways.
> +
> +	while (cnt < READ_RETRY_TIMES) {
> +		ret = i2c_transfer(client->adapter, &msg, 1);
> +		if (ret == 1) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		mdelay(BUSY_DELAY);
> +		cnt++;
> +	}
> +	if (cnt == READ_RETRY_TIMES) {
> +		dev_err(&client->dev, "Could not write sensor command\n");
> +		return -EREMOTEIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hdc3020_read_bytes(struct hdc3020_data *data, const u8 *buf,
> +			      void *val, int len)
> +{
> +	int ret, cnt;
> +	struct i2c_client *client = data->client;
> +	struct i2c_msg msg[2] = {
> +		[0] = {
> +			.addr = client->addr,
> +			.flags = 0,
> +			.buf = (char *)buf,
> +			.len = 2,
> +		},
> +		[1] = {
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = val,
> +			.len = len,
> +		},
> +	};
> +
> +	/*
> +	 * During the measurement process, HDC3020 will not return data.
> +	 * So wait for a while and try again
> +	 */
> +	ret = 0;

Should not be needed as you will definitely enter the loop
where ret is set.  Compiler should be able to tell that easily.

> +	cnt = 0;
set this at
	int cnt = 0;


> +
> +	while (cnt < READ_RETRY_TIMES) {
for loop simpler here.
	for (cnt = 0; cnt < READ_RETRY_TIMES; cnt++) {
		ret = i2c_....
		if (ret == 2)
			return 0;
	}
> +		ret = i2c_transfer(client->adapter, msg, 2);
> +		if (ret == 2) {
> +			ret = 0;

Nothing checks ret, so don't bother setting it to 0 here.

> +			break;
> +		}
> +		mdelay(BUSY_DELAY);
> +		cnt++;
> +	}
> +
With return above, if you exit the group this will be true.

	dev_err(&client->dev, ...)
	return -EIO;

> +	if (cnt == READ_RETRY_TIMES) {
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +		return -EREMOTEIO;

That error code is very rarely used. I'd go with -ETIMEDOUT here as we
are really saying we gave up trying. It 'might' work sometime later..



> +	}
> +
> +	return 0;
> +}
> +
> +static int hdc3020_read_measurement(struct hdc3020_data *data)
> +{
> +	int ret;
> +	u8 buf[6];
> +
> +	ret = hdc3020_read_bytes(data, HDC3020_R_T_RH_AUTO, (void *)buf, 6);
> +	if (ret < 0)
> +		return ret;
> +	/* Subtract offset: 45 / 175 * 65535 = 16852 */
> +	data->temp = (int)get_unaligned_be16(buf) - 16852;

If there is a linear offset, use IIO_CHAN_INFO_OFFSET to express that as
it's application specific on whether you want to remove it or not.

> +	data->humidity = get_unaligned_be16(&buf[3]);
> +	return 0;
> +}
> +

> +
> +/*
> + * This methord is used to get the lowest humidity measured during automatic
spell check.  method, though given where comment is that's obvious so
    * Gets the lowest humidity measured during automatic measurement.

Same for other cases that look like this.

> + * measurement
> + */
> +static int hdc3020_read_low_peak_rh(struct hdc3020_data *data)
> +{
> +	int ret;
> +	u8 buf[3];
> +
> +	ret = hdc3020_read_bytes(data, HDC3020_R_RH_LOW_AUTO, (void *)buf, 3);
> +	if (ret < 0)
> +		return ret;
> +	data->humidity_low_peak = get_unaligned_be16(buf);
> +
> +	return 0;
> +}
> +
> +static int hdc3020_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct hdc3020_data *data = iio_priv(indio_dev);
> +	int ret = 0;

Unlikely to be needed once you use guard() magic for the lock.

> +
> +	mutex_lock(&data->lock);

guard(muteX)(&data->lock);
will simplify things a lot in here.


Generally take local locks inside
iio_device_claim_direct_mode() but...




> +	switch (mask) {
> +
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);

Why? Your driver doesn't support buffered modes, so it's always
in direct mode. 

> +		if (ret < 0)

with guard stuff above,
			return ret;

> +			break;
> +
> +		ret = hdc3020_read_measurement(data);
> +		if (ret < 0)

			return ret;

> +			break;
> +
> +		if (chan->type == IIO_TEMP)
> +			*val = data->temp;
> +		else if (chan->type == IIO_HUMIDITYRELATIVE)
> +			*val = data->humidity;
> +		iio_device_release_direct_mode(indio_dev);
> +		ret = IIO_VAL_INT;

		return IIO_VAL_INT;

etc.

> +		break;
> +
> +	case IIO_CHAN_INFO_PEAK:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret < 0)
> +			break;
> +
> +		if (chan->type == IIO_TEMP) {
> +			if (chan->channel == 0) {
> +				ret = hdc3020_read_low_peak_t(data);
> +				if (ret < 0)
> +					break;
> +
> +				*val = data->temp_low_peak;
> +			} else if (chan->channel == 1) {
> +				ret = hdc3020_read_high_peak_t(data);
> +				if (ret < 0)
> +					break;
> +
> +				*val = data->temp_high_peak;
> +			}
> +		} else if (chan->type == IIO_HUMIDITYRELATIVE) {
> +			if (chan->channel == 0) {
> +				ret = hdc3020_read_low_peak_rh(data);
> +				if (ret < 0)
> +					break;
> +
> +				*val = data->humidity_low_peak;
> +			} else if (chan->channel == 1) {
> +				ret = hdc3020_read_high_peak_rh(data);
> +				if (ret < 0)
> +					break;
> +
> +				*val = data->humidity_high_peak;
> +			}
> +		}
> +		iio_device_release_direct_mode(indio_dev);
> +		ret = IIO_VAL_INT;
> +		break;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +	case IIO_CHAN_INFO_PEAK_SCALE:
> +		*val2 = 65536;
> +		if (chan->type == IIO_TEMP)
> +			*val = 175;
> +		else
> +			*val = 100;
> +		ret = IIO_VAL_FRACTIONAL;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
		return -EINVAL;

> +	}
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
With changes above you'll never get here so can drop this code.
> +}
> +
> +static int hdc3020_read_available(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  const int **vals,
> +				  int *type, int *length, long mask)
> +{
> +	if (mask != IIO_CHAN_INFO_RAW || chan->type != IIO_CURRENT)
> +		return -EINVAL;
> +
> +	*vals = HEATER_VALUES;
> +	*type = IIO_VAL_INT;
> +	*length = 4;
> +
> +	return IIO_AVAIL_LIST;
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
> +		if (chan->type != IIO_CURRENT || val2 != 0 || val < 0
> +		    || val > 3)
> +			return -EINVAL;
I'd break this up to check things in groups as it's become a bit unreadable.
either

		if (chan->type != IIO_CURRENT)
			return -EINVAL;

		if (val < 0 || val > 3 || val2 != 0)
			return -EINVAL;

or just do it via wrapping
		if (chan->type != IIO_CURRENT ||
		    val < 0 || val > 3 || val2 != 0)
			return -EINVAL;


> +
> +		mutex_lock(&data->lock);
A perfect example of how if you add scope (add a {} around the whole case statement. 
		guard(mutex)(&data->lock);
which will automatically unlock the mutex on leaving the scope, simplifies code.

the scoped guard version is fine too but increases indent too much in this
case I think for the gains in clarify of what is going on.

> +		switch (val) {
> +		case HEATER_QUARTER:
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_HEATER_QUARTER,

Better to wrap parameters than between ret = and the call. Don't worry if you
go over 80 chars if the readability would be worse by adding a line break (like
here)  Keep under 100 though.

> +						5);
> +			if (ret < 0)
> +				break;
			with above guard()...
			if (ret < 0)
				return ret;

			return hdc3020_write_bytes(data, HDC3020_ENABEL_HEATER, 2);

etc

> +
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
> +			break;
> +		case HEATER_HALF:
> +			ret = hdc3020_write_bytes(data, HDC3020_HEATER_HALF, 5);
> +			if (ret < 0)
> +				break;
> +
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
> +			break;
> +		case HEATER_FULL:
> +			ret = hdc3020_write_bytes(data, HDC3020_HEATER_FULL, 5);
> +			if (ret < 0)
> +				break;
> +
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_ENABLE_HEATER, 2);
> +			break;
> +		case HEATER_OFF:
> +			ret =
> +			    hdc3020_write_bytes(data, HDC3020_DISABLE_HEATER,
> +						2);
> +			break;
		with above
		default:
			return -EINVAL;
I'll note that ret isn't initialized otherwise that I can spot, but that will become irrelvant.


> +		}
> +		mutex_unlock(&data->lock);
> +		break;
> +	default:
> +		ret = -EINVAL;
		return -EINVAL;
> +	}
> +
> +	return ret;
return in the case statements above, then you don't need this.
That makes for easier to review code as each code path is minimal.

> +}
> +
> +static const struct iio_info hdc3020_info = {
> +	.read_raw = hdc3020_read_raw,
> +	.write_raw = hdc3020_write_raw,
> +	.read_avail = hdc3020_read_available,
> +};
> +
> +static void hdc3020_stop(void *data)
> +{
> +	hdc3020_write_bytes((struct hdc3020_data *)data, HDC3020_EXIT_AUTO, 2);

Never a need to explicitly cast a void * to another pointer type, so
	hdc3020_write_bytes(data, HDC3020_EXIT_AUTO, 2);
is the same and cleaner.

This is part of the C language specifications.
 
> +}
> +
> +static int hdc3020_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hdc3020_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = "hdc3020";

So I'd normally argue in favour of giving the actual part number if we do
(which you'd do by selecting a device specific structure containing 
 a const char * string - anything trying to extract from i2c_device_id etc
 is much more fragile).

In this particular case I think we are only looking at differences in packaging
rather than anything Linux cares about, so I'm ok with just naming them all
hdc3020.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hdc3020_info;
> +
> +	indio_dev->channels = hdc3020_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
> +
> +	ret = hdc3020_write_bytes(data, HDC3020_S_AUTO_10HZ_MOD0, 2);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Unable to set up measurement\n");
> +
> +	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_stop, data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to add device\n\n");
> +
> +	ret = devm_iio_device_register(&data->client->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to add device\n\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id hdc3020_id[] = {
> +	{ "hdc3020" },
> +	{ "hdc3021" },
> +	{ "hdc3022" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, hdc3020_id);
> +
> +static const struct of_device_id hdc3020_dt_ids[] = {
> +	{.compatible = "ti,hdc3020" },

Make sure spacing is consistent. Here add a space after {

Given there is currently no difference between handling for these
parts you can rely on the fallback compatibles in the binding and only
provide this first entry here and everything will work the same.

I don't mind having the extra entries as they are harmless, but
you should make sure you understand why they aren't strictly necessary.


> +	{.compatible = "ti,hdc3021" },
> +	{.compatible = "ti,hdc3022" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hdc3020_dt_ids);
> +
> +static struct i2c_driver hdc3020_driver = {
> +	.driver = {
> +		.name = "hdc3020",
> +		.of_match_table = hdc3020_dt_ids,
> +	},
> +	.probe = hdc3020_probe,
> +	.id_table = hdc3020_id,
> +};
> +

Trivial but if you drop this blank line it will clearly associate
the structure with the module_i2c_driver() call that follows.

> +module_i2c_driver(hdc3020_driver);


