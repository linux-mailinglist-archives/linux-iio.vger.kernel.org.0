Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA59778FD
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfG0Nnp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 09:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387514AbfG0Nnp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 09:43:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8A42084C;
        Sat, 27 Jul 2019 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564235023;
        bh=klJaTZq7BPnRyIy2SrXriIHm1zygiw8Ibu0Q35noz8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CNGrqsknl+Dwjg4Ce6NbVf7HrRiTvHPRiGWB9qbAwr4Glimri2VpC2/cuAZwA0AQW
         MQTG6nOP/5+A6qTYwThoHH5w6WpxH3J78Fqs2LbBgAaOtLcXMcVC0Nc11KnlcBrpuA
         Vpo5KzorVn9sxYnwAqT+TJoR6pgYUROtuvnzC0nU=
Date:   Sat, 27 Jul 2019 14:43:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@lists.collabora.co.uk, devicetree@vger.kernel.org,
        Sergei M <fizik1@yandex.com>
Subject: Re: [PATCH v3 2/2] iio: light: noa1305: Add support for NOA1305
Message-ID: <20190727144337.45516091@archlinux>
In-Reply-To: <20190726205513.31291-2-martyn.welch@collabora.com>
References: <20190726205513.31291-1-martyn.welch@collabora.com>
        <20190726205513.31291-2-martyn.welch@collabora.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 21:55:13 +0100
Martyn Welch <martyn.welch@collabora.com> wrote:

> This driver adds the initial support for the ON Semiconductor
> NOA1305 Ambient Light Sensor.
> 
> Originally written by Sergei Miroshnichenko. Found here:
>   https://github.com/EmcraftSystems/linux-upstream/commit/196d6cf897e632d2cb82d45484bd7a1bfdd5b6d9
> 
> Signed-off-by: Sergei M <fizik1@yandex.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Hi.

A few bits I missed before or follow up on your changes (which were mostly
great).

Thanks,

Jonathan

> ---
> 
> Changes:
> v2:
>  - Correcting authorship and SOB.
> v3:
>  - Improve register define naming.
>  - Follow IIO convention of interleaving register bit definitions with
>    register defintions.
>  - Use proper endian swapping.
>  - Process raw sensor count into Lux.
>  - Avoid setting variables to zero when not needed.
>  - Check return value of i2c writes.
>  - Implement disabling of regulator as a devm action.
>  - Remove excessive white spacing.
> 
>  drivers/iio/light/Kconfig   |  10 ++
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/noa1305.c | 278 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 drivers/iio/light/noa1305.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 954c958cfc43..d1db0ec0d0f5 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -309,6 +309,16 @@ config MAX44009
>  	 To compile this driver as a module, choose M here:
>  	 the module will be called max44009.
>  
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
> @@ -29,6 +29,7 @@ obj-$(CONFIG_LTR501)		+= ltr501.o
>  obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
>  obj-$(CONFIG_MAX44000)		+= max44000.o
>  obj-$(CONFIG_MAX44009)		+= max44009.o
> +obj-$(CONFIG_NOA1305)		+= noa1305.o
>  obj-$(CONFIG_OPT3001)		+= opt3001.o
>  obj-$(CONFIG_PA12203001)	+= pa12203001.o
>  obj-$(CONFIG_RPR0521)		+= rpr0521.o
> diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> new file mode 100644
> index 000000000000..02b0cf48c2be
> --- /dev/null
> +++ b/drivers/iio/light/noa1305.c
> @@ -0,0 +1,278 @@
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
> +#define   NOA1305_POWER_CONTROL_DOWN	0x00
> +#define   NOA1305_POWER_CONTROL_ON	0x08
> +#define NOA1305_REG_RESET		0x1
> +#define   NOA1305_RESET_RESET		0x10
> +#define NOA1305_REG_INTEGRATION_TIME	0x2
> +#define   NOA1305_INTEGR_TIME_800MS	0x00
> +#define   NOA1305_INTEGR_TIME_400MS	0x01
> +#define   NOA1305_INTEGR_TIME_200MS	0x02
> +#define   NOA1305_INTEGR_TIME_100MS	0x03
> +#define   NOA1305_INTEGR_TIME_50MS	0x04
> +#define   NOA1305_INTEGR_TIME_25MS	0x05
> +#define   NOA1305_INTEGR_TIME_12_5MS	0x06
> +#define   NOA1305_INTEGR_TIME_6_25MS	0x07
> +#define NOA1305_REG_INT_SELECT		0x3
> +#define   NOA1305_INT_SEL_ACTIVE_HIGH	0x01
> +#define   NOA1305_INT_SEL_ACTIVE_LOW	0x02
> +#define   NOA1305_INT_SEL_INACTIVE	0x03
> +#define NOA1305_REG_INT_THRESH_LSB	0x4
> +#define NOA1305_REG_INT_THRESH_MSB	0x5
> +#define NOA1305_REG_ALS_DATA_LSB	0x6
> +#define NOA1305_REG_ALS_DATA_MSB	0x7
> +#define NOA1305_REG_DEVICE_ID_LSB	0x8
> +#define NOA1305_REG_DEVICE_ID_MSB	0x9
> +
> +#define NOA1305_DEVICE_ID	0x0519
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
> +	__le16 data;
> +	int count;
> +	int ret;
> +
> +	ret = regmap_bulk_read(priv->regmap, NOA1305_REG_ALS_DATA_LSB, &data,
> +			       2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Lux = count / (<Integration Constant> * <Integration Time>)
> +	 *
> +	 * Integration Constant = 7.7
> +	 * Integration Time in Seconds (currently) = 800ms
> +	 */
> +	return (le16_to_cpu(data) * 100) / (77 * 8);
IIO has always had a preference for passing such conversions over to userspace
which is rather better at doing maths like this (as it has floating point).

Hence, please just return le16_to_cpu(data) and provide the scale value
using the IIO_CHAN_INFO_SCALE element of read_raw.  Use the fractional
form to let the core code work out the decimal value to put out for you.

> +}
> +
> +static const struct iio_chan_spec noa1305_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	}
> +};
> +
> +static int noa1305_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	int ret = -EINVAL;
> +	struct noa1305_priv *priv = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = noa1305_measure(priv);
> +			if (ret < 0)
> +				return ret;
> +			*val = ret;
> +			ret = IIO_VAL_INT;
Given there is no cleanup to be done after this, direct
return preferred. 

			return IIO_VAL_INT;
> +			break;
> +		default:
			return -EINVAL;
> +			break;
> +		}
> +		break;
> +	default:
		return -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info noa1305_info = {
> +	.read_raw = noa1305_read_raw,
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
> +static const struct regmap_config noa1305_regmap_config = {
> +	.name = NOA1305_DRIVER_NAME,
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = NOA1305_REG_DEVICE_ID_MSB,
> +	.writeable_reg = noa1305_writable_reg,
> +};
> +
> +static void noa1305_reg_remove(void *data)
> +{
> +	struct noa1305_priv *priv = data;
> +
> +	regulator_disable(priv->vin_reg);
> +}
> +
> +static int noa1305_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct noa1305_priv *priv;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	__le16 data;
> +	unsigned int dev_id;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &noa1305_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Regmap initialization failed.\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	priv = iio_priv(indio_dev);
> +
> +	priv->vin_reg = devm_regulator_get(&client->dev, "vin");
> +	if (IS_ERR(priv->vin_reg)) {
> +		dev_err(&client->dev, "get regulator vin failed\n");
> +		return PTR_ERR(priv->vin_reg);
> +	}
> +
> +	ret = regulator_enable(priv->vin_reg);
> +	if (ret) {
> +		dev_err(&client->dev, "enable regulator vin failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&client->dev, noa1305_reg_remove, priv);
> +	if (ret) {
> +		dev_err(&client->dev, "addition of devm action failed\n");
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	priv->client = client;
> +	priv->regmap = regmap;
> +
> +	ret = regmap_bulk_read(regmap, NOA1305_REG_DEVICE_ID_LSB, &data, 2);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "ID reading failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_id = le16_to_cpu(data);
> +	if (dev_id != NOA1305_DEVICE_ID) {
> +		dev_err(&client->dev, "Unknown device ID: 0x%x\n", dev_id);
> +		ret = -ENODEV;
> +		return ret;

return -ENODEV;

> +	}
> +
> +	ret = regmap_write(regmap, NOA1305_REG_POWER_CONTROL,
> +			   NOA1305_POWER_CONTROL_ON);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Enabling power control failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(regmap, NOA1305_REG_RESET, NOA1305_RESET_RESET);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Device reset failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(regmap, NOA1305_REG_INTEGRATION_TIME,
> +			   NOA1305_INTEGR_TIME_800MS);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Setting integration time failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(regmap, NOA1305_REG_INT_SELECT,
> +			   NOA1305_INT_SEL_INACTIVE);

This surprised me so I went and found the datasheet.  It would be unusual
to come out of reset with interrupts on and indeed the datasheet lists
the default as this setting.   Is this working around something you've
seen in reality, or just being (overly) careful?  If the second, don't do
so.

Note however, that if anyone adds regcache support at some point they
will have to manage the condition where writing the reset changes the
values of other registers.

> +	if (ret < 0) {
> +		dev_err(&client->dev, "Disabling interrupts failed\n");
> +		return ret;
> +	}
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &noa1305_info;
> +	indio_dev->channels = noa1305_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(noa1305_channels);
> +	indio_dev->name = NOA1305_DRIVER_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "registering device failed\n");
> +		return ret;

Drop this return ret as we do it anyway below.  One of the static
analysers tends to catch this one, so we normally get follow up
patches very quickly after a driver hits linux next. I'd rather tidy
it up now!

> +	}
> +
> +	return ret;
> +}
> +
> +static int noa1305_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct noa1305_priv *priv = iio_priv(indio_dev);
> +
> +	regulator_disable(priv->vin_reg);

This shouldn't be needed now.  Automated cleanup should be calling
the callback you registered with devm_add_action_or_reset.

As such you can get rid of the remove function entirely as it
has nothing to do.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id noa1305_of_match[] = {
> +	{ .compatible = "onnn,noa1305" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, noa1305_of_match);
> +
> +static const struct i2c_device_id noa1305_ids[] = {
> +	{ "noa1305", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, noa1305_id);
> +
> +static struct i2c_driver noa1305_driver = {
> +	.driver = {
> +		.name		= NOA1305_DRIVER_NAME,
> +		.of_match_table	= noa1305_of_match,
> +	},
> +	.probe		= noa1305_probe,
> +	.remove		= noa1305_remove,
> +	.id_table	= noa1305_ids,
> +};
> +
> +module_i2c_driver(noa1305_driver);
> +
> +MODULE_AUTHOR("Sergei Miroshnichenko <sergeimir@emcraft.com>");
> +MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.com");
> +MODULE_DESCRIPTION("ON Semiconductor NOA1305 ambient light sensor");
> +MODULE_LICENSE("GPL");

