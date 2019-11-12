Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649E8F9757
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 18:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLRiS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 12:38:18 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfKLRiS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Nov 2019 12:38:18 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1766635EC70966144D6F;
        Wed, 13 Nov 2019 01:38:14 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 01:38:08 +0800
Date:   Tue, 12 Nov 2019 17:37:57 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Beniamin Bia <beniamin.bia@analog.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 1/3] iio: Add ADM1177 Hot Swap Controller and Digital
 Power Monitor driver
Message-ID: <20191112173757.0000075b@huawei.com>
In-Reply-To: <20191112153552.27431-1-beniamin.bia@analog.com>
References: <20191112153552.27431-1-beniamin.bia@analog.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Nov 2019 17:35:50 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> ADM1177 is a Hot Swap Controller and Digital Power Monitor with
> Soft Start Pin.
> 
> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

Hi Beniamin,

A couple immediate thoughts.

1. That cc list has some rather non obvious people on it.  Unless something
   fairly surprising is going on, probably better to cut it back a bit.

2. Why IIO?  Not entirely obvious to me.  From first glance this is definitely
   doing hardware monitoring.  If there is a reason there should be a clear
   statement here on why.

+CC Guenter and Jean as hwmon maintainers.

Whilst I'm here, a very quick review below.

> ---
>  drivers/iio/adc/Kconfig   |  12 ++
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/adm1177.c | 257 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 270 insertions(+)
>  create mode 100644 drivers/iio/adc/adm1177.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9554890a3200..4db8c6dcb595 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -228,6 +228,18 @@ config ASPEED_ADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called aspeed_adc.
>  
> +config ADM1177
> +	tristate "Analog Devices ADM1177 Digital Power Monitor driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Analog Devices:
> +	  ADM1177 Hot Swap Controller and Digital Power Monitor
> +	  with Soft Start Pin. Provides direct access
> +	  via sysfs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adm1177.
> +
>  config AT91_ADC
>  	tristate "Atmel AT91 ADC"
>  	depends on ARCH_AT91
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 5ecc481c2967..7899d6a158f3 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD7949) += ad7949.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
> +obj-$(CONFIG_ADM1177) += adm1177.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>  obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
>  obj-$(CONFIG_AXP20X_ADC) += axp20x_adc.o
> diff --git a/drivers/iio/adc/adm1177.c b/drivers/iio/adc/adm1177.c
> new file mode 100644
> index 000000000000..daec34566a65
> --- /dev/null
> +++ b/drivers/iio/adc/adm1177.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADM1177 Hot Swap Controller and Digital Power Monitor with Soft Start Pin
> + *
> + * Copyright 2015-2019 Analog Devices Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +
> +/*  Command Byte Operations */
> +#define ADM1177_CMD_V_CONT	BIT(0)
> +#define ADM1177_CMD_V_ONCE	BIT(1)
> +#define ADM1177_CMD_I_CONT	BIT(2)
> +#define ADM1177_CMD_I_ONCE	BIT(3)
> +#define ADM1177_CMD_VRANGE	BIT(4)
> +#define ADM1177_CMD_STATUS_RD	BIT(6)
> +
> +/* Extended Register */
> +#define ADM1177_REG_ALERT_EN	1
> +#define ADM1177_REG_ALERT_TH	2
> +#define ADM1177_REG_CONTROL	3
> +
> +/* ADM1177_REG_ALERT_EN */
> +#define ADM1177_EN_ADC_OC1	BIT(0)
> +#define ADM1177_EN_ADC_OC4	BIT(1)
> +#define ADM1177_EN_HS_ALERT	BIT(2)
> +#define ADM1177_EN_OFF_ALERT	BIT(3)
> +#define ADM1177_CLEAR		BIT(4)
> +
> +/* ADM1177_REG_CONTROL */
> +#define ADM1177_SWOFF		BIT(0)
> +
> +#define ADM1177_BITS		12
> +
> +/**
> + * struct adm1177_state - driver instance specific data
> + * @client		pointer to i2c client
> + * @reg			regulator info for the the power supply of the device
> + * @command		internal control register
> + * @r_sense_uohm	current sense resistor value
> + * @alert_threshold_ua	current limit for shutdown
> + * @vrange_high		internal voltage divider
> + */
> +struct adm1177_state {
> +	struct i2c_client	*client;
> +	struct regulator	*reg;
> +	u8			command;
> +	u32			r_sense_uohm;
> +	u32			alert_threshold_ua;
> +	bool			vrange_high;
> +};
> +
> +static int adm1177_read(struct adm1177_state *st, u8 num, u8 *data)
> +{
> +	struct i2c_client *client = st->client;
> +	int ret = 0;
> +
> +	ret = i2c_master_recv(client, data, num);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "I2C read error\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adm1177_write_cmd(struct adm1177_state *st, u8 cmd)
> +{
> +	st->command = cmd;
> +	return i2c_smbus_write_byte(st->client, cmd);
> +}
> +
> +static int adm1177_write_reg(struct adm1177_state *st, u8 reg, u8 val)
> +{
> +	return i2c_smbus_write_byte_data(st->client, reg, val);

These wrappers don't really add anything.  I'd just make the i2c
calls directly inline. They will be self explanatory.

> +}
> +
> +static int adm1177_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long mask)
> +{
> +	struct adm1177_state *st = iio_priv(indio_dev);
> +	u8 data[3];
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		adm1177_read(st, 3, data);
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = (data[0] << 4) | (data[2] >> 4);
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			*val = (data[1] << 4) | (data[2] & 0xF);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (st->command & ADM1177_CMD_VRANGE)
> +				*val = 6650;
> +			else
> +				*val = 26350;
> +
> +			*val2 = ADM1177_BITS;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_CURRENT:
> +			*val = 105840 / st->r_sense_uohm;
> +
> +			*val2 = ADM1177_BITS;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec adm1177_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
> +		.channel = 0,
> +	},
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
> +		.channel = 0,
> +	},
> +};
> +
> +static const struct iio_info adm1177_info = {
> +	.read_raw = &adm1177_read_raw,
> +};

blank line here.

> +static void adm1177_remove(void *data)
> +{
> +	struct adm1177_state *st = data;
> +
> +	if (st->reg)
> +		regulator_disable(st->reg);

Probe and remove should be mirror images of each other.
As you have a mixture of managed and non managed calls that
isn't the case here.

devm_add_action_or_reset will sort this out for you if
used to turn off the regulator at the right point on removal.

> +}
> +
> +static int adm1177_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct device_node *np;
> +	struct adm1177_state *st;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	st->client = client;
> +
> +	np = client->dev.of_node;
> +
> +	st->reg = devm_regulator_get_optional(&client->dev, "vref");
> +	if (IS_ERR(st->reg)) {
> +		if (PTR_ERR(st->reg) == EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		st->reg = NULL;
> +	} else {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			return ret;
> +		ret = devm_add_action_or_reset(&client->dev, adm1177_remove,
> +					       st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	of_property_read_u32(np, "adi,r-sense-micro-ohms", &st->r_sense_uohm);
> +	of_property_read_u32(np, "adi,shutdown-threshold-microamp",
> +			     &st->alert_threshold_ua);
> +	st->vrange_high = of_property_read_bool(np,
> +				"adi,vrange-high-enable");
> +	if (st->alert_threshold_ua) {
> +		unsigned int val;
> +
> +		val = (st->alert_threshold_ua * st->r_sense_uohm * 0xFF);
> +		val /= 105840000U;
> +		if (val > 0xFF) {
> +			dev_err(&client->dev,
> +				"Requested shutdown current %d uA above limit\n",
> +				st->alert_threshold_ua);
> +
> +			val = 0xFF;
> +		}
> +		adm1177_write_reg(st, ADM1177_REG_ALERT_TH, val);
> +	}
> +
> +	adm1177_write_cmd(st, ADM1177_CMD_V_CONT |
> +			      ADM1177_CMD_I_CONT |
> +			      (st->vrange_high ? 0 : ADM1177_CMD_VRANGE));
> +
> +	indio_dev->name = id->name;
> +	indio_dev->channels = adm1177_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adm1177_channels);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &adm1177_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id adm1177_ids[] = {
> +	{ "adm1177", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, adm1177_ids);
> +
> +static const struct of_device_id adm1177_dt_ids[] = {
> +	{ .compatible = "adi,adm1177" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, adm1177_dt_ids);
> +
> +static struct i2c_driver adm1177_driver = {
> +	.driver = {
> +		.name = "adm1177",
> +		.of_match_table = adm1177_dt_ids,
> +	},
> +	.probe = adm1177_probe,
> +	.id_table = adm1177_ids,
> +};
> +module_i2c_driver(adm1177_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADM1177 ADC driver");
> +MODULE_LICENSE("GPL v2");


