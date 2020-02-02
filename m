Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F5C14FC94
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 11:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgBBKWf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 05:22:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBBKWf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 05:22:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265BB20679;
        Sun,  2 Feb 2020 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580638953;
        bh=g+Qc10BXnDFRikXms4FMHr/H1+jRqxOosl674M5cnuo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PwkSlPVR+Gosp1680MuHkQaW93kYeOvcfJN/JoJTCwU9iMch1zruaBx9uB8S2YuF0
         /Gy4HeUCilZSfhLOV09wS0NWGCaON3BOH4Dzp00z9Ma0EQjgJX3feOBItUBw5UbO2X
         1hl2p//5IibznJt5bdOCrSVTeAYTJ+wvyhq2GA+8=
Date:   Sun, 2 Feb 2020 10:22:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 4/7] iio: light: add Dyna-Image AL3010 driver
Message-ID: <20200202102229.5ba4ad91@archlinux>
In-Reply-To: <20200201180024.328700-5-david@ixit.cz>
References: <20200201180024.328700-1-david@ixit.cz>
        <20200201180024.328700-5-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 Feb 2020 19:00:21 +0100
David Heidelberg <david@ixit.cz> wrote:

> Based on:
> - 3320A in-kernel driver
> - https://www.spinics.net/lists/linux-iio/msg25145.html
> - https://lore.kernel.org/patchwork/patch/684179/
> 
> I decided to keep it aside of AL3320A due to different approach and much
> simpler design of 3010.
> 
> Tested on Nexus 7 2012 (grouper/tilapia).
> 
> Tested-by: David Heidelberg <david@ixit.cz>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
Hi,

A few minor bits inline.

Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig  |  10 ++
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/al3010.c | 217 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 228 insertions(+)
>  create mode 100644 drivers/iio/light/al3010.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9968f982fbc7..43d9b830279d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -43,6 +43,16 @@ config ADUX1020
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called adux1020.
>  
> +config AL3010
> +	tristate "AL3010 ambient light sensor"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Dyna Image AL3010
> +	  ambient light sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called al3010.
> +
>  config AL3320A
>  	tristate "AL3320A ambient light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c98d1cefb861..88bb93550fcc 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
>  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>  obj-$(CONFIG_ADUX1020)		+= adux1020.o
> +obj-$(CONFIG_AL3010)		+= al3010.o
>  obj-$(CONFIG_AL3320A)		+= al3320a.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> new file mode 100644
> index 000000000000..4b951c087c83
> --- /dev/null
> +++ b/drivers/iio/light/al3010.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AL3010 - Dyna Image Ambient Light Sensor
> + *
> + * Copyright (c) 2014, Intel Corporation.
> + * Copyright (c) 2016, Dyna-Image Corp.
> + *
> + * IIO driver for AL3010 (7-bit I2C slave address 0x1C).
> + *
> + * TODO: interrupt support, thresholds
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define AL3010_DRV_NAME "al3010"
> +
> +#define AL3010_REG_SYSTEM		0x00
> +#define AL3010_REG_DATA_LOW		0x0c
> +#define AL3010_REG_CONFIG		0x10
> +
> +#define AL3010_CONFIG_DISABLE		0x00
> +#define AL3010_CONFIG_ENABLE		0x01
> +
> +#define AL3010_GAIN_SHIFT		4
> +#define AL3010_GAIN_MASK		(BIT(6) | BIT(5) | BIT(4))

GENMASK

> +
> +#define AL3010_GAIN_READ(g) \
> +	(((g) & AL3010_GAIN_MASK) >> AL3010_GAIN_SHIFT)
> +
> +#define AL3010_GAIN_WRITE(g) \
> +	(((g) << AL3010_GAIN_SHIFT) & AL3010_GAIN_MASK)
> +
> +#define AL3010_SCALE_AVAILABLE "1.1872 0.2968 0.0742 0.018"
> +
> +enum al3xxxx_range {
> +	AL3XXX_RANGE_1, /* 77806 lx */
> +	AL3XXX_RANGE_2, /* 19542 lx */
> +	AL3XXX_RANGE_3, /*  4863 lx */
> +	AL3XXX_RANGE_4  /*  1216 lx */
> +};
> +
> +static const int al3010_scales[][2] = {
> +	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
> +};
> +
> +struct al3010_data {
> +	struct i2c_client *client;
> +};
> +
> +static const struct iio_chan_spec al3010_channels[] = {
> +	{
> +		.type	= IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	}
> +};
> +
> +static IIO_CONST_ATTR(in_illuminance_scale_available, AL3010_SCALE_AVAILABLE);
> +
> +static struct attribute *al3010_attributes[] = {
> +	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group al3010_attribute_group = {
> +	.attrs = al3010_attributes,
> +};
> +
> +static int al3010_init(struct al3010_data *data)
> +{
> +	int ret;
> +
> +	/* power on */
Comment is fairly obvious given the code so I wouldn't bother having it.
Comments that don't add significant benefit just add stuff that can become
wrong in the future ;)

> +	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_SYSTEM,
> +					AL3010_CONFIG_ENABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
> +					AL3010_GAIN_WRITE(AL3XXX_RANGE_3));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int al3010_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct al3010_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * ALS ADC value is stored in two adjacent registers:
> +		 * - low byte of output is stored at AL3010_REG_DATA_LOW
> +		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
> +		 */
> +		ret = i2c_smbus_read_word_data(data->client,
> +					       AL3010_REG_DATA_LOW);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = i2c_smbus_read_byte_data(data->client,
> +					       AL3010_REG_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = AL3010_GAIN_READ(ret);
> +		*val = al3010_scales[ret][0];
> +		*val2 = al3010_scales[ret][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int al3010_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long mask)
> +{
> +	struct al3010_data *data = iio_priv(indio_dev);
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		for (i = 0; i < ARRAY_SIZE(al3010_scales); i++) {
> +			if (val != al3010_scales[i][0] ||
> +			    val2 != al3010_scales[i][1])
> +				continue;
> +
> +			return i2c_smbus_write_byte_data(data->client,
> +						AL3010_REG_CONFIG,
> +						AL3010_GAIN_WRITE(i));
> +		}
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info al3010_info = {
> +	.read_raw	= al3010_read_raw,
> +	.write_raw	= al3010_write_raw,
> +	.attrs		= &al3010_attribute_group,
> +};
> +
> +static int al3010_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct al3010_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &al3010_info;
> +	indio_dev->name = AL3010_DRV_NAME;
> +	indio_dev->channels = al3010_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(al3010_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = al3010_init(data);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "al3010 chip init failed\n");
> +		return ret;
> +	}
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static int al3010_remove(struct i2c_client *client)
> +{
> +	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM,
> +					 AL3010_CONFIG_DISABLE);
There is a race here.  Until the call to iio_device_unregister
is called, the userspace interfaces (and in kernel) interfaces
are exposed.  When using managed (devm_) interfaces that occurs
after remove. 

So 2 options to avoid this:
1) Don't use devm_ version of iio_device_register then you can
explicitly unregister before turning off the device.
2) Use devm_add_action_or_reset to automatically disable the device
and allow you to get rid of the remove function entirely.
 

> +}
> +
> +static const struct i2c_device_id al3010_id[] = {
> +	{"al3010", 0},

No need to set the data field if not using it.
	{ "als3010" }
is fine.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, al3010_id);
> +
> +static const struct of_device_id al3010_of_match[] = {
> +	{ .compatible = "dynaimage,al3010", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, al3010_of_match);
> +
> +static struct i2c_driver al3010_driver = {
> +	.driver = {
> +		.name = AL3010_DRV_NAME,
> +		.of_match_table = al3010_of_match,
> +	},
> +	.probe		= al3010_probe,
> +	.remove		= al3010_remove,
> +	.id_table	= al3010_id,
> +};
> +module_i2c_driver(al3010_driver);
> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
> +MODULE_DESCRIPTION("AL3010 Ambient Light Sensor driver");
> +MODULE_LICENSE("GPL v2");

