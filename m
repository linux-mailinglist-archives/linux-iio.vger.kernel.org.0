Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0940DF69E3
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfKJPsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKJPsK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 10:48:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEDEB2077C;
        Sun, 10 Nov 2019 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573400889;
        bh=84a/KFn1Z4HtP3z2FxytRiKrFTMmzmYKQNSC+fdNiXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D0QX64PbCf6hUJbpLN38K2xRzWujA/rBAiB1gSjsYHDDUEw0cZNVhywvjsch7oZDT
         pTdvWrzoLVph0iaT7ucAVzDe9UbWDCJrdVXLqgoQaDEE9nNP9ZTv3J/UXNn1tjpyfo
         xRuNXi047DM/LwnWvM6fWQHfXTT01mgY4ED7H3Aw=
Date:   Sun, 10 Nov 2019 15:48:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <paulmck@linux.ibm.com>, <mchehab+samsung@kernel.org>,
        <linus.walleij@linaro.org>, <nicolas.ferre@microchip.com>,
        <biabeniamin@outlook.com>, Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH v3 1/4] iio: adc: Add support for AD7091R5 ADC
Message-ID: <20191110154802.261dd63d@archlinux>
In-Reply-To: <20191107150759.5937-1-beniamin.bia@analog.com>
References: <20191107150759.5937-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Nov 2019 17:07:56 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> AD7091 is 4-Channel, I2C, Ultra Low Power,12-Bit ADC.
> 

I'd like to see a bit of info here about what other ad7091r parts exist
to explain the current split in files.

> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

Was a close run thing, but there are just enough minor things between my
review here and Dan's that I think we need a v4 rather than me just cleaning
them up whilst applying.

Thanks,

Jonathan

> ---
> Changes in v3:
> -parameters for functions calls were aligned
> -iio_device_register replaced by devm_iio_device_register
> -duplication of regmap_update_bits calls removed in set_mode
> 
>  drivers/iio/adc/Kconfig        |   7 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ad7091r-base.c | 261 +++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad7091r-base.h |  25 ++++
>  drivers/iio/adc/ad7091r5.c     | 102 +++++++++++++
>  5 files changed, 396 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7091r-base.c
>  create mode 100644 drivers/iio/adc/ad7091r-base.h
>  create mode 100644 drivers/iio/adc/ad7091r5.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7e3286265a38..80b1b9551749 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -22,6 +22,13 @@ config AD7124
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7124.
>  
> +config AD7091R5
> +	tristate "Analog Devices AD7091R5 ADC Driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for Analog Devices AD7091R-5 ADC.
> +
>  config AD7266
>  	tristate "Analog Devices AD7265/AD7266 ADC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ef9cc485fb67..55e44735aaac 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD7124) += ad7124.o
> +obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
>  obj-$(CONFIG_AD7266) += ad7266.o
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7298) += ad7298.o
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> new file mode 100644
> index 000000000000..2ebc40dfd927
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD7091RX Analog to Digital converter driver
> + *
> + * Copyright 2014-2019 Analog Devices Inc.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "ad7091r-base.h"
> +
> +#define AD7091R_REG_RESULT  0
> +#define AD7091R_REG_CHANNEL 1
> +#define AD7091R_REG_CONF    2
> +#define AD7091R_REG_ALERT   3
> +#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
> +#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
> +#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> +
> +/* AD7091R_REG_RESULT */
> +#define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
> +#define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
> +
> +/* AD7091R_REG_CONF */
> +#define AD7091R_REG_CONF_AUTO   BIT(8)
> +#define AD7091R_REG_CONF_CMD    BIT(10)
> +
> +#define AD7091R_REG_CONF_MODE_MASK  \
> +	(AD7091R_REG_CONF_AUTO | AD7091R_REG_CONF_CMD)
> +
> +enum ad7091r_mode {
> +	AD7091R_MODE_SAMPLE,
> +	AD7091R_MODE_COMMAND,
> +	AD7091R_MODE_AUTOCYCLE,
> +};
> +
> +struct ad7091r_state {
> +	struct device *dev;
> +	struct regmap *map;
> +	const struct ad7091r_chip_info *chip_info;
> +	enum ad7091r_mode mode;
> +	struct mutex lock;

Locks should always have documentation so we know exactly what their
scope is.

> +};
> +
> +static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
> +{
> +	int ret, conf;
> +
> +	switch (mode) {
> +	case AD7091R_MODE_SAMPLE:
> +		conf = 0;
> +		break;
> +	case AD7091R_MODE_COMMAND:
> +		conf = AD7091R_REG_CONF_CMD;
> +		break;
> +	case AD7091R_MODE_AUTOCYCLE:
> +		conf = AD7091R_REG_CONF_AUTO;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +				 AD7091R_REG_CONF_MODE_MASK, conf);
> +	if (ret)
> +		return ret;
> +
> +	st->mode = mode;
> +
> +	return ret;
> +}
> +
> +static int ad7091r_set_channel(struct ad7091r_state *st, unsigned int channel)
> +{
> +	unsigned int foo;
> +	int ret;
> +
> +	/* AD7091R_REG_CHANNEL specified which channels to be converted */
> +	ret = regmap_write(st->map, AD7091R_REG_CHANNEL,
> +			BIT(channel) | (BIT(channel) << 8));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * There is a latency of one conversion before the channel conversion
> +	 * sequence is updated
> +	 */
> +	return regmap_read(st->map, AD7091R_REG_RESULT, &foo);
> +}
> +
> +static int ad7091r_read_one(struct iio_dev *iio_dev,
> +		unsigned int channel, unsigned int *read_val)
> +{
> +	struct ad7091r_state *st = iio_priv(iio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = ad7091r_set_channel(st, channel);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->map, AD7091R_REG_RESULT, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (AD7091R_REG_RESULT_CH_ID(val) != channel)
> +		return -EIO;
> +
> +	*read_val = AD7091R_REG_RESULT_CONV_RESULT(val);
> +
> +	return 0;
> +}
> +
> +static int ad7091r_read_raw(struct iio_dev *iio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long m)
> +{
> +	struct ad7091r_state *st = iio_priv(iio_dev);
> +	unsigned int read_val;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (st->mode != AD7091R_MODE_COMMAND) {

This is currently pointless as only that mode seems to be used.
I guess we can leave it there ready for other modes to be implemented
but I would have preferred it to be introduced at that point.

> +			ret = -EBUSY;
> +			goto unlock;
> +		}
> +
> +		ret = ad7091r_read_one(iio_dev, chan->channel, &read_val);
> +		if (ret)
> +			goto unlock;
> +
> +		*val = read_val;
> +		ret = IIO_VAL_INT;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static const struct iio_info ad7091r_info = {
> +	.read_raw = ad7091r_read_raw,
> +};
> +
> +static irqreturn_t ad7091r_event_handler(int irq, void *private)
> +{
> +	struct ad7091r_state *st = (struct ad7091r_state *) private;
> +	struct iio_dev *iio_dev = dev_get_drvdata(st->dev);
> +	unsigned int i, read_val;
> +	int ret;
> +	s64 timestamp = iio_get_time_ns(iio_dev);
> +
> +	ret = regmap_read(st->map, AD7091R_REG_ALERT, &read_val);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	for (i = 0; i < st->chip_info->num_channels; i++) {
> +		if (read_val & BIT(i * 2))
> +			iio_push_event(iio_dev,
> +					IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +						IIO_EV_TYPE_THRESH,
> +						IIO_EV_DIR_RISING), timestamp);
> +		if (read_val & BIT(i * 2 + 1))
> +			iio_push_event(iio_dev,
> +					IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +						IIO_EV_TYPE_THRESH,
> +						IIO_EV_DIR_FALLING), timestamp);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int ad7091r_probe(struct device *dev, const char *name,
> +		const struct ad7091r_chip_info *chip_info,
> +		struct regmap *map, int irq)
> +{
> +	struct iio_dev *iio_dev;
> +	struct ad7091r_state *st;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(iio_dev);
> +	st->dev = dev;
> +	st->chip_info = chip_info;
> +	st->map = map;
> +
> +	iio_dev->dev.parent = dev;
> +	iio_dev->name = name;
> +	iio_dev->info = &ad7091r_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	iio_dev->num_channels = chip_info->num_channels;
> +	iio_dev->channels = chip_info->channels;
> +
> +	if (irq) {
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +				ad7091r_event_handler,
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Use command mode by default to convert only desired channels*/
> +	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, iio_dev);
> +}
> +EXPORT_SYMBOL_GPL(ad7091r_probe);
> +
> +static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD7091R_REG_RESULT:
> +	case AD7091R_REG_ALERT:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD7091R_REG_RESULT:
> +	case AD7091R_REG_ALERT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +const struct regmap_config ad7091r_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.writeable_reg = ad7091r_writeable_reg,
> +	.volatile_reg = ad7091r_volatile_reg,
> +};
> +EXPORT_SYMBOL_GPL(ad7091r_regmap_config);
> +
> +MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel converters");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> new file mode 100644
> index 000000000000..5f1147735953
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AD7091RX Analog to Digital converter driver
> + *
> + * Copyright 2014-2019 Analog Devices Inc.
> + */
> +
> +#ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
> +#define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
> +
> +struct device;
> +struct ad7091r_state;
> +
> +struct ad7091r_chip_info {
> +	unsigned int num_channels;
> +	const struct iio_chan_spec *channels;
> +};
> +
> +extern const struct regmap_config ad7091r_regmap_config;
> +
> +int ad7091r_probe(struct device *dev, const char *name,
> +		const struct ad7091r_chip_info *chip_info,
> +		struct regmap *map, int irq);
> +
> +#endif /* __DRIVERS_IIO_ADC_AD7091R5_BASE_H__ */

Comment doesn't match the define (R vs R5).

> diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
> new file mode 100644
> index 000000000000..f7b3326032e8
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r5.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD7091R5 Analog to Digital converter driver
> + *
> + * Copyright 2014-2019 Analog Devices Inc.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "ad7091r-base.h"
> +
> +static const struct iio_event_spec ad7091r5_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
> +	},
> +};
> +
> +#define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
> +	.type = IIO_VOLTAGE, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.indexed = 1, \
> +	.channel = idx, \
> +	.event_spec = ev, \
> +	.num_event_specs = num_ev, \
> +}
> +static const struct iio_chan_spec ad7091r5_channels_irq[] = {
> +	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> +	AD7091R_CHANNEL(1, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> +	AD7091R_CHANNEL(2, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> +	AD7091R_CHANNEL(3, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
> +};
> +
> +static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
> +	AD7091R_CHANNEL(0, 12, NULL, 0),
> +	AD7091R_CHANNEL(1, 12, NULL, 0),
> +	AD7091R_CHANNEL(2, 12, NULL, 0),
> +	AD7091R_CHANNEL(3, 12, NULL, 0),
> +};
> +#undef AD7091R_CHANNEL

Why? 

> +
> +static const struct ad7091r_chip_info ad7091r5_chip_info_irq = {
> +	.channels = ad7091r5_channels_irq,
> +	.num_channels = ARRAY_SIZE(ad7091r5_channels_irq),
> +};
> +
> +static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
> +	.channels = ad7091r5_channels_noirq,
> +	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
> +};
> +
> +static int ad7091r5_i2c_probe(struct i2c_client *i2c,
> +		const struct i2c_device_id *id)
> +{
> +	const struct ad7091r_chip_info *chip_info;
> +	struct regmap *map = devm_regmap_init_i2c(i2c, &ad7091r_regmap_config);
> +
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	if (i2c->irq)
> +		chip_info = &ad7091r5_chip_info_irq;
> +	else
> +		chip_info = &ad7091r5_chip_info_noirq;
> +
> +	return ad7091r_probe(&i2c->dev, id->name, chip_info, map, i2c->irq);
> +}
> +
> +static const struct i2c_device_id ad7091r5_i2c_ids[] = {
> +	{"ad7091r5", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ad7091r5_i2c_ids);

Please add the devicetree specific table as well.
In theory, one day we might get rid of the old i2c fallback paths
that make this work.

> +
> +static struct i2c_driver ad7091r5_driver = {
> +	.driver = {
> +		.name = "ad7091r5",
> +	},
> +	.probe = ad7091r5_i2c_probe,
> +	.id_table = ad7091r5_i2c_ids,
> +};
> +module_i2c_driver(ad7091r5_driver);
> +
> +MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7091R5 multi-channel ADC driver");
> +MODULE_LICENSE("GPL v2");

