Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56ABC15436D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 12:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBFLsN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 06:48:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgBFLsM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 06:48:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0290921927;
        Thu,  6 Feb 2020 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580989691;
        bh=hKS4Qw9S8/O2RuLsy+puDDVy1laFFgq+eMejubrMGO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T1OhNcb/HdQAh/hTyJnFi19lLdwHQ13MGuqVPFkI/0o4qL+qUxavzyVkFSPsNFqCo
         t5ZKp4SH7EEOXWEJeRJ4tFvhUBzDloR5F67I60ypJfwi3VohZY/bFihiVxffSDIhJS
         BKA25w1FLJq4GEz8ODOHhmaa4Ni5ZBYZE1tYyrxU=
Date:   Thu, 6 Feb 2020 11:48:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/7] iio: light: add Dyna-Image AL3010 driver
Message-ID: <20200206114806.5180a415@archlinux>
In-Reply-To: <20200204093031.616409-5-david@ixit.cz>
References: <20200204093031.616409-1-david@ixit.cz>
        <20200204093031.616409-5-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  4 Feb 2020 10:30:34 +0100
David Heidelberg <david@ixit.cz> wrote:

> Based on:
> - 3320A in-kernel driver
> - https://www.spinics.net/lists/linux-iio/msg25145.html
> - https://lore.kernel.org/patchwork/patch/684179/
>=20
> I decided to keep it aside of AL3320A due to different approach and much
> simpler design of 3010.
>=20
> Tested on Nexus 7 2012 (grouper/tilapia).
>=20
> Tested-by: David Heidelberg <david@ixit.cz>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
>=20
> v4:
> - SQUASHed: iio: light: al3010 implement suspend support
> - switched from _remove to devm_add_action_or_reset
> - implement bitfields FIELD_PREP & FIELD_GET, no functionality change
>=20
> Signed-off-by: David Heidelberg <david@ixit.cz>

This is fine as is, but you might want to think about adding basic
regulator control as VDD might not be turned on.
Then there is the follow up question on whether it is sensible to
disable VDD in the suspend path.

Thanks,

Jonathan


> ---
>  drivers/iio/light/Kconfig  |  10 ++
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/al3010.c | 240 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/iio/light/al3010.c
>=20
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9968f982fbc7..43d9b830279d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -43,6 +43,16 @@ config ADUX1020
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called adux1020.
> =20
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
>  obj-$(CONFIG_ACPI_ALS)		+=3D acpi-als.o
>  obj-$(CONFIG_ADJD_S311)		+=3D adjd_s311.o
>  obj-$(CONFIG_ADUX1020)		+=3D adux1020.o
> +obj-$(CONFIG_AL3010)		+=3D al3010.o
>  obj-$(CONFIG_AL3320A)		+=3D al3320a.o
>  obj-$(CONFIG_APDS9300)		+=3D apds9300.o
>  obj-$(CONFIG_APDS9960)		+=3D apds9960.o
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> new file mode 100644
> index 000000000000..bb4643ca3e85
> --- /dev/null
> +++ b/drivers/iio/light/al3010.c
> @@ -0,0 +1,240 @@
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
> + * When the driver will get support for interrupt handling, then interru=
pt
> + * will need to be disabled before turning sensor OFF in order to avoid
> + * potential races with the interrupt handling.
> + */
> +
> +#include <linux/bitfield.h>
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
> +#define AL3010_GAIN_MASK		(BIT(6) | BIT(5) | BIT(4))
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
> +static const int al3010_scales[][2] =3D {
> +	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
> +};
> +
> +struct al3010_data {
> +	struct i2c_client *client;
> +};
> +
> +static const struct iio_chan_spec al3010_channels[] =3D {
> +	{
> +		.type	=3D IIO_LIGHT,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	}
> +};
> +
> +static IIO_CONST_ATTR(in_illuminance_scale_available, AL3010_SCALE_AVAIL=
ABLE);
> +
> +static struct attribute *al3010_attributes[] =3D {
> +	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group al3010_attribute_group =3D {
> +	.attrs =3D al3010_attributes,
> +};
> +
> +static int al3010_set_pwr(struct i2c_client *client, bool pwr)
> +{
> +	u8 val =3D pwr ? AL3010_CONFIG_ENABLE : AL3010_CONFIG_DISABLE;
> +	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM, val);
> +}
> +
> +static void al3010_set_pwr_off(void *_data)
> +{
> +	struct al3010_data *data =3D _data;
> +
> +	al3010_set_pwr(data->client, false);
> +}
> +
> +static int al3010_init(struct al3010_data *data)
> +{
> +	int ret;
> +
> +	ret =3D al3010_set_pwr(data->client, true);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
> +					FIELD_PREP(AL3010_GAIN_MASK,
> +						   AL3XXX_RANGE_3));
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
> +	struct al3010_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * ALS ADC value is stored in two adjacent registers:
> +		 * - low byte of output is stored at AL3010_REG_DATA_LOW
> +		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
> +		 */
> +		ret =3D i2c_smbus_read_word_data(data->client,
> +					       AL3010_REG_DATA_LOW);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D i2c_smbus_read_byte_data(data->client,
> +					       AL3010_REG_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D FIELD_GET(AL3010_GAIN_MASK, ret);
> +		*val =3D al3010_scales[ret][0];
> +		*val2 =3D al3010_scales[ret][1];
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
> +	struct al3010_data *data =3D iio_priv(indio_dev);
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		for (i =3D 0; i < ARRAY_SIZE(al3010_scales); i++) {
> +			if (val !=3D al3010_scales[i][0] ||
> +			    val2 !=3D al3010_scales[i][1])
> +				continue;
> +
> +			return i2c_smbus_write_byte_data(data->client,
> +					AL3010_REG_CONFIG,
> +					FIELD_PREP(AL3010_GAIN_MASK, i));
> +		}
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info al3010_info =3D {
> +	.read_raw	=3D al3010_read_raw,
> +	.write_raw	=3D al3010_write_raw,
> +	.attrs		=3D &al3010_attribute_group,
> +};
> +
> +static int al3010_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct al3010_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client =3D client;
> +
> +	indio_dev->dev.parent =3D &client->dev;
> +	indio_dev->info =3D &al3010_info;
> +	indio_dev->name =3D AL3010_DRV_NAME;
> +	indio_dev->channels =3D al3010_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(al3010_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D al3010_init(data);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "al3010 chip init failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(&client->dev,
> +					al3010_set_pwr_off,
> +					data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static int __maybe_unused al3010_suspend(struct device *dev)
> +{
> +	return al3010_set_pwr(to_i2c_client(dev), false);
> +}
> +
> +static int __maybe_unused al3010_resume(struct device *dev)
> +{
> +	return al3010_set_pwr(to_i2c_client(dev), true);
> +}
> +
> +SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);
> +
> +static const struct i2c_device_id al3010_id[] =3D {
> +	{"al3010", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, al3010_id);
> +
> +static const struct of_device_id al3010_of_match[] =3D {
> +	{ .compatible =3D "dynaimage,al3010", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, al3010_of_match);
> +
> +static struct i2c_driver al3010_driver =3D {
> +	.driver =3D {
> +		.name =3D AL3010_DRV_NAME,
> +		.of_match_table =3D al3010_of_match,
> +		.pm =3D &al3010_pm_ops,
> +	},
> +	.probe		=3D al3010_probe,
> +	.id_table	=3D al3010_id,
> +};
> +module_i2c_driver(al3010_driver);
> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
> +MODULE_DESCRIPTION("AL3010 Ambient Light Sensor driver");
> +MODULE_LICENSE("GPL v2");

