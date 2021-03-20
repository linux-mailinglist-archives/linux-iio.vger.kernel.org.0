Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F1342EC1
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 19:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCTSP6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 20 Mar 2021 14:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhCTSP4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 14:15:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8B96186A;
        Sat, 20 Mar 2021 18:15:54 +0000 (UTC)
Date:   Sat, 20 Mar 2021 18:15:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     alexandru.ardelean@analog.com, devicetree@vger.kernel.org,
        knaack.h@gmx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: temperature: add driver support for ti
 tmp117
Message-ID: <20210320181552.02fd3d32@jic23-huawei>
In-Reply-To: <20210320064509.119878-3-puranjay12@gmail.com>
References: <20210320064509.119878-1-puranjay12@gmail.com>
        <20210320064509.119878-3-puranjay12@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Mar 2021 12:15:09 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> TMP117 is a Digital temperature sensor with integrated NV memory.
> 
> Add support for tmp117 driver in iio subsystem.
> 
> Datasheet:-https://www.ti.com/lit/gpn/tmp117
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Hi Puranjay,

Pretty clean driver.  A few comments inline.

From a process point of view, I'd advise against sending out a new version
of a patch set until the previous one has sat on the list for a few days at least.
It will save you time as you can handle multiple reviews in one go.

I don't mind if you prefer to do a fast turn around though as I'm
very good at ignoring emails ;)

Jonathan

> ---
>  drivers/iio/temperature/Kconfig  |  10 ++
>  drivers/iio/temperature/Makefile |   1 +
>  drivers/iio/temperature/tmp117.c | 182 +++++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/iio/temperature/tmp117.c
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index f1f2a1499..c5482983f 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -97,6 +97,16 @@ config TMP007
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tmp007.
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
>  config TSYS01
>  	tristate "Measurement Specialties TSYS01 temperature sensor using I2C bus connection"
>  	depends on I2C
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 90c113115..e3392c4b2 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -12,5 +12,6 @@ obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_MLX90632) += mlx90632.o
>  obj-$(CONFIG_TMP006) += tmp006.o
>  obj-$(CONFIG_TMP007) += tmp007.o
> +obj-$(CONFIG_TMP117) += tmp117.o
>  obj-$(CONFIG_TSYS01) += tsys01.o
>  obj-$(CONFIG_TSYS02D) += tsys02d.o
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> new file mode 100644
> index 000000000..194820700
> --- /dev/null
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -0,0 +1,182 @@
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
> +#include <linux/module.h>
> +#include <linux/pm.h>

no power management yet.

> +#include <linux/of.h>
> +#include <linux/irq.h>

No interrupts yet.

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I don't think you are using anything from that header.

> +#include <linux/iio/events.h>

You don't support any events yet.

> +
> +#define TMP117_REG_TEMP			0x0
> +#define TMP117_REG_CFGR			0x1
> +#define TMP117_REG_HIGH_LIM		0x2
> +#define TMP117_REG_LOW_LIM		0x3
> +#define TMP117_REG_EEPROM_UL		0x4
> +#define TMP117_REG_EEPROM1		0x5
> +#define TMP117_REG_EEPROM2		0x6
> +#define TMP117_REG_TEMP_OFFSET		0x7
> +#define TMP117_REG_EEPROM3		0x8
> +#define TMP117_REG_DEVICE_ID		0xF
> +
> +#define TMP117_SCALE			7812500       /* in uCelsius*/
Always good to embed the units in the name so it's easy to see what it
is at usepoint. I also suspect this is actually in nano Celsius.

TMP117_SCALE_UC or MICRO_C

> +#define TMP117_RESOLUTION		78125

Define one of scale or resolution in terms of the other though
with suggested change to calibbias scaling this may not be used anyway.

> +#define TMP117_DEVICE_ID		0x0117
> +
> +struct tmp117_data {
> +	struct i2c_client *client;
> +	struct mutex lock;

Locks always need documentation to explain what their scope is.
In this case the lock is never actually locked so writing that doc
would have made it fairly obvious it wasn't useful!

> +};
> +
> +static int tmp117_read_reg(struct tmp117_data *data, u8 reg)
> +{
> +	return i2c_smbus_read_word_swapped(data->client, reg);

These two wrappers don't add anything significant.
Just put the i2c calls direct inline.

> +}
> +
> +static int tmp117_write_reg(struct tmp117_data *data, u8 reg, int val)
> +{
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
> +	case IIO_CHAN_INFO_RAW:
> +		tmp = tmp117_read_reg(data, TMP117_REG_TEMP);
> +		*val = tmp;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		off = tmp117_read_reg(data, TMP117_REG_TEMP_OFFSET);
> +		*val = ((int16_t)off * (int32_t)TMP117_RESOLUTION) / 10000000;
> +		*val2 = ((int16_t)off * (int32_t)TMP117_RESOLUTION) % 10000000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = TMP117_SCALE;
> +		return IIO_VAL_INT_PLUS_NANO;
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
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		off = ((val * 10000000) + (val2 * 10))
> +						/ (int32_t)TMP117_RESOLUTION;
> +		return tmp117_write_reg(data, TMP117_REG_TEMP_OFFSET, off);

Calibbias is not normally in an particular defined units.
Most devices implementing it apply this value via some DAC effecting the
reference voltage or similar.  The method to set it is often device specific.

Here it's applied in the same units as _RAW which is nice and simple

I think it would be more logical to just have have it take an integer value
rather than try and map it as a tuning of the output after application of
scale.

> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec tmp117_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static const struct iio_info tmp117_info = {
> +	.read_raw = tmp117_read_raw,
> +	.write_raw = tmp117_write_raw,
> +};
> +
> +static bool tmp117_identify(struct i2c_client *client)

As mentioned below, I'd have this return 0 for a match and negative
for other cases as they you can distinguish between the read failing
and the value being wrong.

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

It's taking many years, but ideally new I2C drivers should use the
probe_new callback instead of probe.

> +{
> +	struct tmp117_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	if (!tmp117_identify(client)) {

Probably better to move the error value assignment into the identify function.
That will let you distinguish between error on the read and wrong value.

> +		dev_err(&client->dev, "TMP117 not found\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = "tmp117";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &tmp117_info;
> +
> +	indio_dev->channels = tmp117_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct of_device_id tmp117_of_match[] = {
> +	{ .compatible = "ti,tmp117", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tmp117_of_match);
> +
> +static const struct i2c_device_id tmp117_id[] = {
> +	{ "tmp117", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tmp117_id);
> +
> +static struct i2c_driver tmp117_driver = {
> +	.driver = {
> +		.name	= "tmp117",
> +		.of_match_table = of_match_ptr(tmp117_of_match),

Don't use of_match_ptr.  2 reasons:
1) If you build without CONFIG_OF you'll get a warning
because the tmp117_of_match table is unused.
2) It stops use of other firmware probing methods that use the of_match_table
   The main one of those is ACPI based probing that use the magic PRP0001
   ACPI ID.

		.of_match_table = tmp117_of_match,

> +	},
> +	.probe		= tmp117_probe,
> +	.id_table	= tmp117_id,
> +};
> +module_i2c_driver(tmp117_driver);
> +
> +MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
> +MODULE_DESCRIPTION("TI TMP117 Temperature sensor driver");
> +MODULE_LICENSE("GPL");

