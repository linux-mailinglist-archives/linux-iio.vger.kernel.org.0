Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C611C2B48
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgECKRb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 06:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgECKRa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 06:17:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DCA20757;
        Sun,  3 May 2020 10:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588501049;
        bh=l5HzFdi6ykWxz3w761/jttHfBCLn0H4TbUZ+HdTMITw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gzlMs3HPDGWWDjD1Rq9jlH5NiLGx0aGP3TdeURSfUxXFAecPBCNtUmm8wUuQiQWNz
         4HYTCTX2eK3wZ83qhP8ttRX7PqCJ+w6s9/ZK++oI3If5qqf8fgwPxSjsvmdhVn7yxg
         BGSF7cLpKasgDrqE7E/wkl5VToGfFxO3FsY9y8NA=
Date:   Sun, 3 May 2020 11:17:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: add atlas-ezo-sensor initial support
Message-ID: <20200503111726.3bb111c3@archlinux>
In-Reply-To: <20200428054107.16061-3-matt.ranostay@konsulko.com>
References: <20200428054107.16061-1-matt.ranostay@konsulko.com>
        <20200428054107.16061-3-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Apr 2020 08:41:07 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add driver for Atlas EZO line of sensors with initial support for
> CO2 the sensor. This is effectively ASCII strings proxied over I2C
> due to these series of sensors being by default UART.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

A few things inline - including a dive into a bit of the i2c subsystem
that's been there for a few years, but never used ;)

Jonathan

> ---
>  drivers/iio/chemical/Kconfig            |  11 ++
>  drivers/iio/chemical/Makefile           |   1 +
>  drivers/iio/chemical/atlas-ezo-sensor.c | 173 ++++++++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 drivers/iio/chemical/atlas-ezo-sensor.c
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index a7e65a59bf42..7f21afd73b1c 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -22,6 +22,17 @@ config ATLAS_PH_SENSOR
>  	  To compile this driver as module, choose M here: the
>  	  module will be called atlas-ph-sensor.
>  
> +config ATLAS_EZO_SENSOR
> +	tristate "Atlas Scientific EZO sensors"
> +	depends on I2C
> +	help
> +	  Say Y here to build I2C interface support for the following
> +	  Atlas Scientific EZO sensors
> +	    * CO2 EZO Sensor
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called atlas-ezo-sensor.
> +
>  config BME680
>  	tristate "Bosch Sensortec BME680 sensor driver"
>  	depends on (I2C || SPI)
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index 33d3a595dda9..aba4167db745 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -5,6 +5,7 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-sensor.o
> +obj-$(CONFIG_ATLAS_EZO_SENSOR)	+= atlas-ezo-sensor.o
>  obj-$(CONFIG_BME680) += bme680_core.o
>  obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
>  obj-$(CONFIG_BME680_SPI) += bme680_spi.o
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> new file mode 100644
> index 000000000000..1f972f525a46
> --- /dev/null
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * atlas-ezo-sensor.c - Support for Atlas Scientific EZO sensors
> + *
> + * Copyright (C) 2020 Konsulko Group
> + * Author: Matt Ranostay <matt.ranostay@konsulko.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/of_device.h>
> +#include <linux/iio/iio.h>
> +
> +#define ATLAS_EZO_DRV_NAME		"atlas-ezo-sensor"
> +#define ATLAS_CO2_INT_TIME_IN_MS	950
> +
> +enum {
> +	ATLAS_CO2_EZO,
> +};
> +
> +struct atlas_ezo_device {
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +	int delay;
> +};
> +
> +struct atlas_ezo_data {
> +	struct i2c_client *client;
> +	struct atlas_ezo_device *chip;

const?  Seems like it's always a pointer to a constant structure.

> +	struct mutex lock;

Locks should 'always' have a comment to say what their scope is.
Even when it appears obvious ;)

> +	u8 buffer[8];
> +};
> +
> +static const struct iio_chan_spec atlas_co2_ezo_channels[] = {
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_CO2,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +};
> +
> +static struct atlas_ezo_device atlas_ezo_devices[] = {

const?

> +	[ATLAS_CO2_EZO] = {
> +		.channels = atlas_co2_ezo_channels,
> +		.num_channels = 1,
> +		.delay = ATLAS_CO2_INT_TIME_IN_MS,
> +	},
> +};
> +
> +static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct atlas_ezo_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int ret = 0;
> +
> +	if (chan->type != IIO_CONCENTRATION)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		int tmp;
> +
> +		mutex_lock(&data->lock);
> +
> +		tmp = i2c_smbus_write_byte(client, 'R');
> +
> +		if (tmp < 0) {
> +			mutex_unlock(&data->lock);
> +			return tmp;
> +		}
> +
> +		msleep(data->chip->delay);
> +
> +		tmp = i2c_master_recv(client, data->buffer, sizeof(data->buffer));
> +
> +		// Confirm response code is 1 for success

Comment syntax /* */

> +		if (tmp < 0 || data->buffer[0] != 1) {
> +			mutex_unlock(&data->lock);
> +			return -EBUSY;
> +		}
> +
> +		ret = kstrtol(data->buffer + 1, 10, (long *) val);

Use a local variable rather than casting like that which could in theory
be unsafe.

> +
> +		mutex_unlock(&data->lock);
> +
> +		return ret ? ret : IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +		*val2 = 10000; /* 0.0001 */
> +		return IIO_VAL_FRACTIONAL;

Could use VAL_INT_PLUS_MICRO to reduce the maths needed for
a constant case like we have here where that representation
is just as easy to read as this one.

> +	}
> +

Can only get here in invalid path. So return -EINVAL and don't
initialize ret above.

> +	return ret;
> +}
> +
> +static const struct iio_info atlas_info = {
> +	.read_raw = atlas_ezo_read_raw,
> +};
> +
> +static const struct i2c_device_id atlas_ezo_id[] = {
> +	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
> +
> +static const struct of_device_id atlas_ezo_dt_ids[] = {
> +	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
> +
> +static int atlas_ezo_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	struct atlas_ezo_data *data;
> +	struct atlas_ezo_device *chip;
> +	const struct of_device_id *of_id;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	of_id = of_match_device(atlas_dt_ids, &client->dev);
> +	if (!of_id)
> +		chip = &atlas_ezo_devices[id->driver_data];

Given we are supposed to be transitioning away (slowly) from
probe to probe_new, we shouldn't really be using id to do anything
in here (directly anyway)

Looking at i2c_of_match_device, there is some magic to match
if we have initialized through the sysfs interface, so use that
instead.

https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-of.c#L224

I 'think' that takes care of the case where we haven't instantiated
via device tree.

Interestingly it's a very little used function. But, the original discussion
included a patch doing pretty much what I'm suggesting here:

https://lore.kernel.org/patchwork/patch/728984/


> +	else
> +		chip = &atlas_ezo_devices[(unsigned long)of_id->data];
> +
> +	indio_dev->info = &atlas_info;
> +	indio_dev->name = ATLAS_EZO_DRV_NAME;
> +	indio_dev->channels = chip->channels;
> +	indio_dev->num_channels = chip->num_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = &client->dev;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->chip = chip;
> +	mutex_init(&data->lock);
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +};
> +
> +static struct i2c_driver atlas_ezo_driver = {
> +	.driver = {
> +		.name	= ATLAS_EZO_DRV_NAME,
> +		.of_match_table	= atlas_ezo_dt_ids,
> +	},
> +	.probe		= atlas_ezo_probe,
> +	.id_table	= atlas_ezo_id,
> +};
> +module_i2c_driver(atlas_ezo_driver);
> +
> +MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
> +MODULE_DESCRIPTION("Atlas Scientific EZO sensors");
> +MODULE_LICENSE("GPL");

