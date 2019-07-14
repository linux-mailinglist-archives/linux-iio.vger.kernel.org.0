Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08946806C
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 19:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGNROf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 13:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbfGNROf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 13:14:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0EA1205F4;
        Sun, 14 Jul 2019 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563124473;
        bh=M9BGjFEZHbJ2DxMD0K/QLdRqjF6rs+RkbEl1GoULyVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qyz+Wn04zwR3HZZXWU+QOARm1xK6WCUFesFCtr1gp8aPZ0QZjCFl8x5JPLEo0Bj5P
         9wkJRIVQQZBUptDyLzT2Iql7McMJEKkhv+iFU4llIQDaJGTiuyQUTj2vp0QPfbTUJ3
         jxo4Go8KMZz5Mnk3HA9JOSJZ+J8GsA/ldz1FLdJs=
Date:   Sun, 14 Jul 2019 18:14:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@lists.collabora.co.uk, devicetree@vger.kernel.org,
        Sergei M <fizik1@yandex.com>
Subject: Re: [PATCH v2 2/2] iio: light: noa1305: Add support for NOA1305
Message-ID: <20190714181428.5e6eb83c@archlinux>
In-Reply-To: <20190628175713.14831-2-martyn.welch@collabora.com>
References: <20190628175713.14831-1-martyn.welch@collabora.com>
        <20190628175713.14831-2-martyn.welch@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Jun 2019 18:57:13 +0100
Martyn Welch <martyn.welch@collabora.com> wrote:

> This driver adds the initial support for the ON Semiconductor
> NOA1305 Ambient Light Sensor.
>=20
> Originally written by Sergei Miroshnichenko. Found here:
>   https://github.com/EmcraftSystems/linux-upstream/commit/196d6cf897e632d=
2cb82d45484bd7a1bfdd5b6d9
>=20
> Signed-off-by: Sergei M <fizik1@yandex.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

A few minor things inline.

Thanks,

Jonathan

> ---
>=20
> Changes:
> v2: Correcting authorship and SOB.
>=20
>  drivers/iio/light/Kconfig   |  10 ++
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/noa1305.c | 247 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 258 insertions(+)
>  create mode 100644 drivers/iio/light/noa1305.c
>=20
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 954c958cfc43..d1db0ec0d0f5 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -309,6 +309,16 @@ config MAX44009
>  	 To compile this driver as a module, choose M here:
>  	 the module will be called max44009.
> =20
> +config NOA1305
> +	tristate "ON Semiconductor NOA1305 ambient light sensor"
> +	depends on I2C
> +	help
> +	 Say Y here if you want to build support for the ON Semiconductor
> +	 NOA1305 ambient light sensor.
> +
> +	 To compile this driver as a module, choose M here:
> +	 The module will be called noa1305.
> +
>  config OPT3001
>  	tristate "Texas Instruments OPT3001 Light Sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index e40794fbb435..00d1f9b98f39 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_LTR501)		+=3D ltr501.o
>  obj-$(CONFIG_LV0104CS)		+=3D lv0104cs.o
>  obj-$(CONFIG_MAX44000)		+=3D max44000.o
>  obj-$(CONFIG_MAX44009)		+=3D max44009.o
> +obj-$(CONFIG_NOA1305)		+=3D noa1305.o
>  obj-$(CONFIG_OPT3001)		+=3D opt3001.o
>  obj-$(CONFIG_PA12203001)	+=3D pa12203001.o
>  obj-$(CONFIG_RPR0521)		+=3D rpr0521.o
> diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> new file mode 100644
> index 000000000000..2c65c5c2e09a
> --- /dev/null
> +++ b/drivers/iio/light/noa1305.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for ON Semiconductor NOA1305 ambient light sensor
> + *
> + * Copyright (C) 2016 Emcraft Systems
> + * Copyright (C) 2019 Collabora Ltd.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define NOA1305_REG_POWER_CONTROL	0x0
> +#define NOA1305_REG_RESET		0x1
> +#define NOA1305_REG_INTEGRATION_TIME	0x2
> +#define NOA1305_REG_INT_SELECT		0x3
> +#define NOA1305_REG_INT_THRESH_LSB	0x4
> +#define NOA1305_REG_INT_THRESH_MSB	0x5
> +#define NOA1305_REG_ALS_DATA_LSB	0x6
> +#define NOA1305_REG_ALS_DATA_MSB	0x7
> +#define NOA1305_REG_DEVICE_ID_LSB	0x8
> +#define NOA1305_REG_DEVICE_ID_MSB	0x9
> +
> +#define NOA1305_DEVICE_ID		0x0519
> +
> +#define NOA1305_POWER_ON		0x08
> +#define NOA1305_POWER_DOWN		0x00
> +#define NOA1305_RESET			0x10
It would be good to name these in a fashion that made it
obvious they were values to write to the power control register.
NOA1305_POWER_CONTROL_ON

NOA1305_POWER_CONTROL_DOWN
NOA1305_POWER_CONTROL_RESET
perhaps?

There are other conventions we tend to use in IIO such as
#define NOA1305_POWER_CONTROL_REG         0x0
#define   NOA1305_POWER_CONTROL_POWER_ON  0x08
etc..
=20

> +
> +#define NOA1305_INT_ACTIVE_HIGH		0x01
> +#define NOA1305_INT_ACTIVE_LOW		0x02
> +#define NOA1305_INT_INACTIVE		0x03
> +
> +#define NOA1305_INTEGR_TIME_800MS	0x00
> +#define NOA1305_INTEGR_TIME_400MS	0x01
> +#define NOA1305_INTEGR_TIME_200MS	0x02
> +#define NOA1305_INTEGR_TIME_100MS	0x03
> +#define NOA1305_INTEGR_TIME_50MS	0x04
> +#define NOA1305_INTEGR_TIME_25MS	0x05
> +#define NOA1305_INTEGR_TIME_12_5MS	0x06
> +#define NOA1305_INTEGR_TIME_6_25MS	0x07
> +
> +#define NOA1305_DRIVER_NAME	"noa1305"
> +
> +struct noa1305_priv {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct regulator *vin_reg;
> +};
> +
> +static int noa1305_measure(struct noa1305_priv *priv)
> +{
> +	u8 data[2];
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(priv->regmap, NOA1305_REG_ALS_DATA_LSB, data,
> +			       2);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (data[1] << 8) | data[0];
Make data an explicit __le16  and use an endian swap here as on
little endian platforms it'll be free.

> +}
> +
> +static const struct iio_chan_spec noa1305_channels[] =3D {
> +	{
> +		.type =3D IIO_LIGHT,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +	}
> +};
> +
> +static int noa1305_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	int ret =3D -EINVAL;
> +	struct noa1305_priv *priv =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret =3D noa1305_measure(priv);

Hmm. So no information at all available on how this maps to
illuminance?  If the mapping is something you were thinking
of adding later we would end up having to support this old
ABI as well as the _PROCESSED version and, whilst it's happened occasionall=
y,
it isn't something we encourage.

Of course, if there is no documented conversion function then we=20
can live with this interface!

=46rom figure 6 in the datasheet it seems linear (unusual for a
light sensor) so should be easy enough to do with offset and scale,
in which case this is fine as it is.

> +			if (ret < 0)
> +				return ret;
> +			*val =3D ret;
> +			ret =3D IIO_VAL_INT;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info noa1305_info =3D {
> +	.read_raw =3D noa1305_read_raw,
> +};
> +
> +static bool noa1305_writable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case NOA1305_REG_POWER_CONTROL:
> +	case NOA1305_REG_RESET:
> +	case NOA1305_REG_INTEGRATION_TIME:
> +	case NOA1305_REG_INT_SELECT:
> +	case NOA1305_REG_INT_THRESH_LSB:
> +	case NOA1305_REG_INT_THRESH_MSB:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config noa1305_regmap_config =3D {
> +	.name =3D NOA1305_DRIVER_NAME,
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D NOA1305_REG_DEVICE_ID_MSB,
> +	.writeable_reg =3D noa1305_writable_reg,
> +};
> +
> +static int noa1305_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct noa1305_priv *priv;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	u8 data[2];
> +	unsigned int dev_id =3D 0;

Always set in any path where it is used, so don't do it here.

> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &noa1305_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Regmap initialization failed.\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	priv =3D iio_priv(indio_dev);
> +
> +	priv->vin_reg =3D devm_regulator_get(&client->dev, "vin");
> +	if (IS_ERR(priv->vin_reg)) {
> +		dev_err(&client->dev, "get regulator vin failed\n");
> +		return PTR_ERR(priv->vin_reg);
> +	}
> +
> +	ret =3D regulator_enable(priv->vin_reg);
> +	if (ret) {
> +		dev_err(&client->dev, "enable regulator vin failed\n");
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	priv->client =3D client;
> +	priv->regmap =3D regmap;
> +
> +	ret =3D regmap_bulk_read(regmap, NOA1305_REG_DEVICE_ID_LSB, data, 2);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "ID reading failed: %d\n", ret);
> +		goto error_disable_reg;
> +	}
> +
> +	dev_id =3D (data[1] << 8) | data[0];

This is just unwinding endianness, use the __*e16_to_cpu function
and an appropriate type instead of u8[2] for this.

> +	if (dev_id !=3D NOA1305_DEVICE_ID) {
> +		dev_err(&client->dev, "Unknown device ID: 0x%x\n", dev_id);
> +		ret =3D -ENODEV;
> +		goto error_disable_reg;
> +	}
> +
> +	regmap_write(regmap, NOA1305_REG_POWER_CONTROL, NOA1305_POWER_ON);

I2C buses aren't exactly the most reliable things out there, so I'd expect
to see error handling on all these writes.

> +	regmap_write(regmap, NOA1305_REG_RESET, NOA1305_RESET);
> +	regmap_write(regmap, NOA1305_REG_INTEGRATION_TIME,
> +		     NOA1305_INTEGR_TIME_800MS);
> +	regmap_write(regmap, NOA1305_REG_INT_SELECT, NOA1305_INT_INACTIVE);
> +
> +	indio_dev->dev.parent =3D &client->dev;
> +	indio_dev->info =3D &noa1305_info;
> +	indio_dev->channels =3D noa1305_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(noa1305_channels);
> +	indio_dev->name =3D NOA1305_DRIVER_NAME;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D devm_iio_device_register(&client->dev, indio_dev);

There is a race here because the regulator disable will happen in remove
before we remove the userspace interfaces.  Hence it is possible
to try to read from the device whilst it has no power.

Two options.  Either stop using devm for everything after the
regulator enable, or use a devm_add_action_or_reset to make
the regulator disable occur in the devm managed sequence rather than
in the manual remove funciton.

> +	if (ret) {
> +		dev_err(&client->dev, "registering device failed\n");
> +		goto error_disable_reg;
> +	}
> +
> +	return ret;
> +
> +error_disable_reg:
> +	regulator_disable(priv->vin_reg);
> +
> +	return ret;
> +}
> +
> +static int noa1305_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	struct noa1305_priv *priv =3D iio_priv(indio_dev);
> +
> +	regulator_disable(priv->vin_reg);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id noa1305_of_match[] =3D {
> +	{ .compatible =3D "onnn,noa1305" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, noa1305_of_match);
> +
> +static const struct i2c_device_id noa1305_ids[] =3D {
> +	{ "noa1305", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, noa1305_id);
> +

nitpick: One line is plenty.

> +
> +static struct i2c_driver noa1305_driver =3D {
> +	.driver =3D {
> +		.name		=3D NOA1305_DRIVER_NAME,
> +		.of_match_table	=3D noa1305_of_match,
> +	},
> +	.probe		=3D noa1305_probe,
> +	.remove		=3D noa1305_remove,
> +	.id_table	=3D noa1305_ids,
> +};
> +
> +module_i2c_driver(noa1305_driver);
> +
> +MODULE_AUTHOR("Sergei Miroshnichenko <sergeimir@emcraft.com>");
> +MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.com");
> +MODULE_DESCRIPTION("ON Semiconductor NOA1305 ambient light sensor");
> +MODULE_LICENSE("GPL");

