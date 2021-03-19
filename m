Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663C0342852
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 23:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCSWDB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 18:03:01 -0400
Received: from www381.your-server.de ([78.46.137.84]:52622 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCSWCs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 18:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=EJW7fiJc1SP/ReOgu/FmlMf2whF7+0T4FGCdH3GEhnw=; b=EQrpv4uuISnjTDYVYGd/2wgj5T
        U9ZQ4YZ6XQk/5lMCmxCe4bkrssxRsKg9zc5bbouWt6e/bld6mmqYOE+07Babb2Wxuscz6gyZMFqE3
        QH8kO4uhSyzYlvomMssKDR1gVumYT3SGB8j0uNW1bRU5SHBriN1hnYk/dsGfWBFqvBB/A8r9MtlM7
        FE9bCr/rsgxjsqVpmiRPN1ZQWPqMgBs76Y7SmqBd/+TVb6nYsa4pZadpaLUytl3PR5nI2Vp4RRosS
        BGJrFh+tX3OafJ21lmJW4BdlDhV+/CmKD1ujL13MU8bKPmoFgaXq/6mpaaUF2M7N2n+ScLpw1khH7
        QPyETgow==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNNCe-0009Sy-My; Fri, 19 Mar 2021 23:02:44 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNNCe-000Efg-I2; Fri, 19 Mar 2021 23:02:44 +0100
Subject: Re: [PATCH 2/2] iio: temperature: add driver support for ti tmp117
To:     Puranjay Mohan <puranjay12@gmail.com>,
        alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210319203007.287802-1-puranjay12@gmail.com>
 <20210319203007.287802-3-puranjay12@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5082c3f4-6efa-6ebe-6eba-64c529c5a22d@metafoo.de>
Date:   Fri, 19 Mar 2021 23:02:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319203007.287802-3-puranjay12@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26113/Fri Mar 19 12:14:45 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/19/21 9:30 PM, Puranjay Mohan wrote:
> TMP117 is a Digital temperature sensor with integrated NV memory.
>
> Add support for tmp117 driver in iio subsystem.
>
> Datasheet:-https://www.ti.com/lit/gpn/tmp117
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Hi,

Thanks for the patch, this looks really good. I have a couple of small 
comments inline.

And one general comment. What you have implemented as 
IIO_CHAN_INFO_OFFSET should be IIO_CHAN_INFO_CALIBBIAS, since it is an 
offset for calibration. The IIO_CHAN_INFO_OFFSET property on the other 
hand is used to describe how to convert from raw data to SI units.

> ---
>   drivers/iio/temperature/Kconfig  |  11 ++
>   drivers/iio/temperature/Makefile |   1 +
>   drivers/iio/temperature/tmp117.c | 196 +++++++++++++++++++++++++++++++
>   3 files changed, 208 insertions(+)
>   create mode 100644 drivers/iio/temperature/tmp117.c
>
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 3f11ed870..200efc880 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -86,6 +86,17 @@ config TMP007
>   	  This driver can also be built as a module. If so, the module will
>   	  be called tmp007.
>   
> +config TMP117
> +	tristate "TMP117 Digital temperature sensor with integrated NV memory"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the Texas Instruments
> +	  TMP117 Digital temperature sensor with integrated NV memory.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called tmp117.
> +
> +
>   config TSYS01
>   	tristate "Measurement Specialties TSYS01 temperature sensor using I2C bus connection"
>   	depends on I2C
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index e4e0bad5a..7f2a95ed2 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_MLX90614) += mlx90614.o
>   obj-$(CONFIG_MLX90632) += mlx90632.o
>   obj-$(CONFIG_TMP006) += tmp006.o
>   obj-$(CONFIG_TMP007) += tmp007.o
> +obj-$(CONFIG_TMP117) += tmp117.o
>   obj-$(CONFIG_TSYS01) += tsys01.o
>   obj-$(CONFIG_TSYS02D) += tsys02d.o
>   obj-$(CONFIG_LTC2983) += ltc2983.o
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> new file mode 100644
> index 000000000..15cdf590e
> --- /dev/null
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * tmp117.c - Digital temperature sensor with integrated NV memory
> + *
> + * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
> + *
> + * Driver for the Texas Instruments TMP117 Temperature Sensor
> + *
> + * (7-bit I2C slave address (0x48 - 0x4B), changeable via ADD pins)
> + *
> + * Note: This driver assumes that the sensor has been calibrated beforehand.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/bitops.h>
> +#include <linux/of.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>

interrupt.h is for consumers, irq.h is for providers. Since this driver 
is only a interrupt consumer you only need irq.h.

I believe bitops.h and delay.h are also not needed by this driver.

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +
> +#define TMP117_REG_TEMP			0x0
> +#define TMP117_REG_CFGR			0x1
> +#define TMP117_REG_HIGH_LIM		0x2
> +#define TMP117_REG_LOW_LIM		0x3
> +#define TMP117_REG_EEPROM_UL		0x4
> +#define TMP117_REG_EEPROM1		0x5
> +#define TMP117_REG_EEPROM2		0x6
> +#define TMP117_REG_EEPROM3		0x7
> +#define TMP117_REG_TEMP_OFFSET		0x7

You got register 0x7 twice here.

> +#define TMP117_REG_EEPROM4		0x8
> +#define TMP117_REG_DEVICE_ID		0xF
> +
> +#define TMP117_RESOLUTION		78125       /* in tens of uCelsius*/
> +#define TMP117_RESOLUTION_DIV		10000000
> +
> +#define TMP117_DEVICE_ID		0x0117
> +
> +struct tmp117_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +};
> +
> +static int tmp117_read_reg(struct tmp117_data *data, u8 reg)
> +{
> +
Being pedantic: the newline at the top here and also in write_reg are 
not needed.
> +	return i2c_smbus_read_word_swapped(data->client, reg);
> +}
> +
> +static int tmp117_write_reg(struct tmp117_data *data, u8 reg, int val)
> +{
> +
> +	return i2c_smbus_write_word_swapped(data->client, reg, val);
> +}
> +
> +static int tmp117_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int *val,
> +		int *val2, long mask)
> +{
> +	struct tmp117_data *data = iio_priv(indio_dev);
> +	u16 tmp, off;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		tmp = tmp117_read_reg(data, TMP117_REG_TEMP);
> +		*val = ((int16_t)tmp * (int32_t)TMP117_RESOLUTION) / 10000000;
> +		*val2 = ((int16_t)tmp * (int32_t)TMP117_RESOLUTION) % 10000000;
Since this is a linear transform it would be better to report RAW 
measurements and then provide the scale attribute for conversion,.
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		off = tmp117_read_reg(data, TMP117_REG_TEMP_OFFSET);
> +		*val = ((int16_t)off * (int32_t)TMP117_RESOLUTION) / 10000000;
> +		*val2 = ((int16_t)off * (int32_t)TMP117_RESOLUTION) % 10000000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int tmp117_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int val,
> +		int val2, long mask)
> +{
> +	struct tmp117_data *data = iio_priv(indio_dev);
> +	u16 off;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		off = ((val * 10000000) + (val2 * 10))
> +						/ (int32_t)TMP117_RESOLUTION;
> +		return tmp117_write_reg(data, TMP117_REG_TEMP_OFFSET, off);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec tmp117_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +};
> +
> +static const struct iio_info tmp117_info = {
> +	.read_raw = tmp117_read_raw,
> +	.write_raw = tmp117_write_raw,
> +};
> +
> +static bool tmp117_identify(struct i2c_client *client)
> +{
> +	int dev_id;
> +
> +	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
> +	if (dev_id < 0)
> +		return false;
> +
> +	return (dev_id == TMP117_DEVICE_ID);
> +}
> +
> +static int tmp117_probe(struct i2c_client *client,
> +			const struct i2c_device_id *tmp117_id)
> +{
> +	struct tmp117_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	if (!tmp117_identify(client)) {
> +		dev_err(&client->dev, "TMP117 not found\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
If you remove the remove() callback the i2c_set_clientdata() here can 
also be removed.
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = &client->dev;

The parent assignment is no longer needed in the latest upstream kernel 
since it happens in devm_iio_device_alloc().

> +	indio_dev->name = "tmp117";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &tmp117_info;
> +
> +	indio_dev->channels = tmp117_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
> +
> +	return iio_device_register(indio_dev);
devm_iio_device_register(...) and then you can remove the the remove() 
callback.
> +}
> +
> [...]


