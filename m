Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516B2DF03E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJUOqK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 10:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfJUOqJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 10:46:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6E92053B;
        Mon, 21 Oct 2019 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571669168;
        bh=J7Y4tDIkg9/lzSYskKmPkTHy3HabRgJOOX/OXg0oSHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OAhDIhlsoupZyiEkj5vWCrcMCMCzhNs9HjHpnRyi3UdSlS2rESBoRe6ji7WtaBvVL
         ztzCZQpDLgzW6apHllJLV42SiJLBF3RblL+bbzEyF6JAg3N+iuS+MTb+dri6i7zZli
         eVy50xKJMBZ3qcsIDCfGgdmtb28NPwIUrND235go=
Date:   Mon, 21 Oct 2019 15:45:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH 1/4] iio: adc: Add support for AD7091R5 ADC
Message-ID: <20191021154559.7baf1a36@archlinux>
In-Reply-To: <20191021170608.26412-1-beniamin.bia@analog.com>
References: <20191021170608.26412-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Oct 2019 20:06:05 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> AD7091 is 4-Channel, I2C, Ultra Low Power,12-Bit ADC.
> 
> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

Hi. I'm going to guess this one is a case of upstreaming a driver
that's been in the Analog tree for quite a while.  Great if so, but
it has a few rough corners.

See inline,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig        |   7 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ad7091r-base.c | 273 +++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad7091r-base.h |  30 ++++
>  drivers/iio/adc/ad7091r5.c     | 108 +++++++++++++
>  5 files changed, 419 insertions(+)
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
> index 000000000000..140413329754
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD7091RX Analog to Digital converter driver
> + *
> + * Copyright 2014 Analog Devices Inc.
> + *

This blank line doesn't add anything.

> + */
> +
> +#include "ad7091r-base.h"
> +
> +#include <linux/bitops.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
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
> +#define REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)

Prefix these as well.

> +#define REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
> +
> +/* AD7091R_REG_CONF */
> +#define REG_CONF_AUTO   BIT(8)
> +#define REG_CONF_CMD    BIT(10)
> +
> +#define REG_CONF_MODE_MASK  (REG_CONF_AUTO | REG_CONF_CMD)
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
> +};
> +
> +static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case AD7091R_MODE_SAMPLE:
> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +				REG_CONF_MODE_MASK, 0);
> +		break;
> +	case AD7091R_MODE_COMMAND:
> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +				REG_CONF_MODE_MASK, REG_CONF_CMD);
> +		break;
> +	case AD7091R_MODE_AUTOCYCLE:
> +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> +				REG_CONF_MODE_MASK, REG_CONF_AUTO);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (!ret)
> +		st->mode = mode;

I always prefer the error path out of line.  Slightly longer but more
consistent with earlier cases.

	if (ret)
		return ret;

	st->mode = mode;

	return 0;

> +	return ret;
> +}
> +
> +static int ad7091r_set_channel(struct ad7091r_state *st, unsigned int channel)
> +{
> +	unsigned int foo;
> +	int ret;
> +
> +	/* AD7091R_REG_CHANNEL is a 8-bit register */

I'm not sure what the comment is telling us...

> +	ret = regmap_write(st->map, AD7091R_REG_CHANNEL,
> +			BIT(channel) | (BIT(channel) << 8));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 *  There is a latency of one conversion before the channel conversion

Slightly odd spacing.

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
> +	/* TODO: locking */

? :)

> +	ret = ad7091r_set_channel(st, channel);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->map, AD7091R_REG_RESULT, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (REG_RESULT_CH_ID(val) != channel)
> +		return -EIO;
> +
> +	*read_val = REG_RESULT_CONV_RESULT(val);
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
> +	mutex_lock(&iio_dev->mlock);

Hmm. I'm not sure if this is mlock being misused to protect some local
stuff or if it's attempting to prevent us switching to buffered
mode whilst this is in progress (we don't support buffered mode obviously
but maybe it's a cut an paste issue?)

> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (st->mode != AD7091R_MODE_COMMAND) {
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
> +	mutex_unlock(&iio_dev->mlock);
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
> +		return IRQ_HANDLED; /* TODO */

Interesting comment.  TODO what?

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
> +	dev_set_drvdata(dev, iio_dev);

If you follow comment below to get rid of remove, you can probably drop
this as well as it will probably be unused.

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
> +	/* Use command mode by default */

While I have no idea what command mode it (I'm lazy so haven't
read the datasheet yet :), the comment doesn't tell us anything
the code doesn't make obvious.  Hence the comment is just
an opportunity for bit rot rather than anything helpful.

> +	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_device_register(iio_dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(dev, "Probed\n");
Clean these left over bits of debug out please.

then return iio_device_register

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ad7091r_probe);
> +
> +int ad7091r_remove(struct device *dev)
> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +
> +	iio_device_unregister(iio_dev);

Hmm. The only thing that seems to get added to remove later
is the regulator disable.  I'd use devm_add_action_or_reset
to deal with that and clean out the manual remove path entirely.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ad7091r_remove);
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
> +//MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
> +//MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel converters");
> +//MODULE_LICENSE("GPL v2");

Clean these up.

> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> new file mode 100644
> index 000000000000..7a29f86ea82b
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AD7091RX Analog to Digital converter driver
> + *
> + * Copyright 2014 Analog Devices Inc.

The following blank line doesn't add anything.
You may also want to claim slightly more recent copyright as I'm guessing
there were at least some changes since then?

> + *
> + */
> +
> +#ifndef __DRIVERS_IIO_DAC_AD7091R_BASE_H__
> +#define __DRIVERS_IIO_DAC_AD7091R_BASE_H__
> +
> +#include <linux/types.h>
> +#include <linux/regmap.h>
Could use a forwards definition of struct regmap here,
and not include the include for this header.
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
> +int ad7091r_remove(struct device *dev);
> +
> +#endif /* __DRIVERS_IIO_DAC_AD7091R5_BASE_H__ */
> diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
> new file mode 100644
> index 000000000000..1ba838c58c31
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r5.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD7091R5 Analog to Digital converter driver
> + *
> + * Copyright 2014 Analog Devices Inc.
> + *

One of my favourite nit picks ;)  Why this blank line?

> + */
> +
> +#include "ad7091r-base.h"
> +
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +
> +static const struct iio_event_spec ad7091r5_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
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
> +static int ad7091r5_i2c_remove(struct i2c_client *i2c)
> +{
> +	return ad7091r_remove(&i2c->dev);
> +}
> +
> +static const struct i2c_device_id ad7091r5_i2c_ids[] = {
> +	{"ad7091r5", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ad7091r5_i2c_ids);
> +
> +static struct i2c_driver ad7091r5_driver = {
> +	.driver = {
> +		.name = "ad7091r5",
> +	},
> +	.probe = ad7091r5_i2c_probe,
> +	.remove = ad7091r5_i2c_remove,
> +	.id_table = ad7091r5_i2c_ids,
> +};
> +module_i2c_driver(ad7091r5_driver);
> +
> +MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7091R5 multi-channel ADC driver");
> +MODULE_LICENSE("GPL v2");

