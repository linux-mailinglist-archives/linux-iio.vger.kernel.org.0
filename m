Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954FE14FCB0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgBBKxA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 05:53:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBBKxA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 05:53:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9A52067C;
        Sun,  2 Feb 2020 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580640779;
        bh=8w/QRQw4QjN5odSrvPBtD4ApEcLkITvnede4tmKAiMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Caz743M+KpEclOTldQCAvzEAqtxyiIEGS9Beo9R48IbpgUuslIUkJgzLAr1/Tg4Sd
         iNtNp2YibA09zRu1Oc+KSszlPKWa1VXjset/eaiZ2Utyz+TlXzt817Mj57D8qEDIq/
         cIS5M/cxxmN/PhcGY9Wsrbu016O269rDGu8noqEg=
Date:   Sun, 2 Feb 2020 10:52:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v4 3/5] iio: amplifiers: hmc425a: Add support for
 HMC425A attenuator
Message-ID: <20200202105254.0e91ab98@archlinux>
In-Reply-To: <20200129142301.13918-4-beniamin.bia@analog.com>
References: <20200129142301.13918-1-beniamin.bia@analog.com>
        <20200129142301.13918-4-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Jan 2020 16:22:59 +0200
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

A few really small things I noticed whilst taking another quick look at this.
I'd probably just have tidied them up or let the go if I hadn't already
raised feedback on patch 1 :)

Thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/Kconfig   |  10 ++
>  drivers/iio/amplifiers/Makefile  |   1 +
>  drivers/iio/amplifiers/hmc425a.c | 256 +++++++++++++++++++++++++++++++
>  3 files changed, 267 insertions(+)
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
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> new file mode 100644
> index 000000000000..0a797e56df3d
> --- /dev/null
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -0,0 +1,256 @@
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
> +#define HMC425A_CHAN(_channel)                                          \
> +{                                                                      \
> +	.type = IIO_VOLTAGE, .output = 1, .indexed = 1,                \

I'd rather see these on separate lines. 
Not sure there are hard rules in the kernel for this particular case
but there are for normal initializers to say you shouldn't do

	int a = 1, b = 2, c = 1; etc and this is kind of similar.

> +	.channel = _channel,                                           \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),         \
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
> +	const struct of_device_id *id;
> +	struct iio_dev *indio_dev;
> +	struct hmc425a_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	id = of_match_device(hmc425a_of_match, &pdev->dev);
> +	if (!id)
> +		ret = -ENODEV;
> +
> +	st->type = (enum hmc425a_type)id->data;

of_device_get_match_data instead of of_match_device as we never
actually want the of_device_id itself.

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

