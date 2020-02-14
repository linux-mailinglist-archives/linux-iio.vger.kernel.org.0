Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712F115D911
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgBNOKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbgBNOKF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:10:05 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50A72082F;
        Fri, 14 Feb 2020 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581689404;
        bh=L7v+8LDxch6tneF9NKvHnwkpClRbBqEIXWgGD6QTDVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HBa+isyKmPHN2JEeuo9He7ewiFIk2SLOcU3DH9zijlp/ee7x+FY5CjT4QK1g+9Ygi
         1q0a/PctMHGBs8WKcDocvZWUWBiNjDdvV+fjp4bgrSbqGzAs66YkYpo/AwBz638Zjy
         nCQBRZoYWyKchEsIOQPwUi0Wzx6M1j+elCfitRF4=
Date:   Fri, 14 Feb 2020 14:09:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v5 3/5] iio: amplifiers: hmc425a: Add support for
 HMC425A attenuator
Message-ID: <20200214140959.528a546e@archlinux>
In-Reply-To: <20200206151149.32122-3-beniamin.bia@analog.com>
References: <20200206151149.32122-1-beniamin.bia@analog.com>
        <20200206151149.32122-3-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Feb 2020 17:11:47 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> This patch adds support for the HMC425A 0.5 dB LSB GaAs MMIC 6-BIT
> DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
2 things left in here. I'll have a go at fixing them up to save us going
to v6 but please take a look at the result and check I haven't broken
anything!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to have a play with it.

Thanks,

Jonathan

> ---
> Changes in v5:
> -properties in HMC425A_CHAN on separate lines
> -of_device_get_match instead of of_match_device
> 
>  drivers/iio/amplifiers/Kconfig   |  10 ++
>  drivers/iio/amplifiers/Makefile  |   1 +
>  drivers/iio/amplifiers/hmc425a.c | 253 +++++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 drivers/iio/amplifiers/hmc425a.c
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index da7f126d197b..9b02c9a2bc8a 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -22,4 +22,14 @@ config AD8366
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad8366.
>  
> +config HMC425
> +	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
> +	depends on GPIOLIB
> +	help
> +	  Say yes here to build support for Analog Devices HMC425A and similar
> +	  gain amplifiers or step attenuators.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hmc425a.
> +
>  endmenu
> diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
> index 9abef2ebe9bc..19a89db1d9b1 100644
> --- a/drivers/iio/amplifiers/Makefile
> +++ b/drivers/iio/amplifiers/Makefile
> @@ -5,3 +5,4 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD8366) += ad8366.o
> +obj-$(CONFIG_HMC425) += hmc425a.o
> \ No newline at end of file
I'll fix the no newline..

> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> new file mode 100644
> index 000000000000..b0d624a7ad05
> --- /dev/null
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HMC425A and similar Gain Amplifiers
> + *
> + * Copyright 2020 Analog Devices Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
> +
> +enum hmc425a_type {
> +	ID_HMC425A,
> +};
> +
> +struct hmc425a_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels;
> +	unsigned int			num_channels;
> +	unsigned int			num_gpios;
> +	int				gain_min;
> +	int				gain_max;
> +	int				default_gain;
> +};
> +
> +struct hmc425a_state {
> +	struct	regulator *reg;
> +	struct	mutex lock; /* protect sensor state */
> +	struct	hmc425a_chip_info *chip_info;
> +	struct	gpio_descs *gpios;
> +	enum	hmc425a_type type;
> +	u32	gain;
> +};
> +
> +static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
> +{
> +	struct hmc425a_state *st = iio_priv(indio_dev);
> +	DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> +
> +	values[0] = value;
> +
> +	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
> +				       NULL, values);
> +	return 0;
> +}
> +
> +static int hmc425a_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long m)
> +{
> +	struct hmc425a_state *st = iio_priv(indio_dev);
> +	int code, gain = 0;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	switch (m) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		code = st->gain;
> +
> +		switch (st->type) {
> +		case ID_HMC425A:
> +			gain = ~code * -500;
> +			break;
> +		}
> +
> +		*val = gain / 1000;
> +		*val2 = (gain % 1000) * 1000;
> +
> +		ret = IIO_VAL_INT_PLUS_MICRO_DB;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +};
> +
> +static int hmc425a_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct hmc425a_state *st = iio_priv(indio_dev);
> +	struct hmc425a_chip_info *inf = st->chip_info;
> +	int code = 0, gain;
> +	int ret;
> +
> +	if (val < 0)
> +		gain = (val * 1000) - (val2 / 1000);
> +	else
> +		gain = (val * 1000) + (val2 / 1000);
> +
> +	if (gain > inf->gain_max || gain < inf->gain_min)
> +		return -EINVAL;
> +
> +	switch (st->type) {
> +	case ID_HMC425A:
> +		code = ~((abs(gain) / 500) & 0x3F);
> +		break;
> +	}
> +
> +	mutex_lock(&st->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		st->gain = code;
> +
> +		ret = hmc425a_write(indio_dev, st->gain);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int hmc425a_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return IIO_VAL_INT_PLUS_MICRO_DB;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info hmc425a_info = {
> +	.read_raw = &hmc425a_read_raw,
> +	.write_raw = &hmc425a_write_raw,
> +	.write_raw_get_fmt = &hmc425a_write_raw_get_fmt,
> +};
> +
> +#define HMC425A_CHAN(_channel)						\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.output = 1,							\
> +	.indexed = 1,							\
> +	.channel = _channel,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
> +}
> +
> +static const struct iio_chan_spec hmc425a_channels[] = {
> +	HMC425A_CHAN(0),
> +};
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id hmc425a_of_match[] = {
> +	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, hmc425a_of_match);
> +
> +static void hmc425a_reg_disable(void *data)
> +{
> +	struct hmc425a_state *st = data;
> +
> +	regulator_disable(st->reg);
> +}
> +
> +static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
> +	[ID_HMC425A] = {
> +		.name = "hmc425a",
> +		.channels = hmc425a_channels,
> +		.num_channels = ARRAY_SIZE(hmc425a_channels),
> +		.num_gpios = 6,
> +		.gain_min = -31500,
> +		.gain_max = 0,
> +		.default_gain = -0x40, /* set default gain -31.5db*/
> +	},
> +};
> +
> +static int hmc425a_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hmc425a_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->type = (enum hmc425a_type)of_device_get_match_data(&pdev->dev);
> +
> +	st->chip_info = &hmc425a_chip_info_tbl[st->type];
> +	indio_dev->num_channels = st->chip_info->num_channels;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->name = st->chip_info->name;
> +	st->gain = st->chip_info->default_gain;
> +
> +	st->gpios = devm_gpiod_get_array(&pdev->dev, "ctrl", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpios)) {
> +		ret = PTR_ERR(st->gpios);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get gpios\n");
> +		return ret;
> +	}
> +
> +	if (st->gpios->ndescs != st->chip_info->num_gpios) {
> +		dev_err(&pdev->dev, "%d GPIOs needed to operate\n",
> +			st->chip_info->num_gpios);
> +		return -ENODEV;
> +	}
> +
> +	st->reg = devm_regulator_get_optional(&pdev->dev, "vcc-supply");

Sorry I'd missed this before.  Why is this optional?  I think
what is needed here is to just let the regulator framework provide
a stub if no regulator is supplied in DT.

We only play this optional game if we have regulators that are really
optional such as reference voltages on parts that also have internal
references that can be used.

> +	if (IS_ERR(st->reg)) {
> +		if (PTR_ERR(st->reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		st->reg = NULL;
> +	} else {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			return ret;
> +		ret = devm_add_action_or_reset(&pdev->dev, hmc425a_reg_disable,
> +					       st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	mutex_init(&st->lock);
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &hmc425a_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static struct platform_driver hmc425a_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = hmc425a_of_match,
> +	},
> +	.probe = hmc425a_probe,
> +};
> +module_platform_driver(hmc425a_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices HMC425A and similar GPIO control Gain Amplifiers");
> +MODULE_LICENSE("GPL v2");

