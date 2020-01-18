Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8531417D3
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 14:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgARNyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 08:54:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgARNyq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 08:54:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69C32468D;
        Sat, 18 Jan 2020 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579355684;
        bh=7XNdcbwfjeRihm+QA1o7rD4VogL/ycoJajCXjWxW+uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XTatsBsuWHiTEm+WgmbWpRUy8XOt0Xt7Q+UJobt6xNnKjINLrGZy/EJ17a6soqLHo
         qdf/OSljAPWF1pj7cZtmJHjN+o0xIv62S6HgYXr0P57GEYRlxQ1TS+SpYaq3GR2foD
         npyZki2ew7Pu/R9rCmV1X0IQ45E6jg7tZGWRe30I=
Date:   Sat, 18 Jan 2020 13:54:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 1/3] iio: amplifiers: hmc425a: Add support for HMC425A
 step attenuator with gpio interface
Message-ID: <20200118135439.4a6b3ddf@archlinux>
In-Reply-To: <20200113141555.16117-1-beniamin.bia@analog.com>
References: <20200113141555.16117-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 16:15:53 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This patch adds support for the HMC425A 0.5 dB LSB GaAs MMIC 6-BIT
> DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

I'll try and avoid replicate comments already made!

> ---
>  drivers/iio/amplifiers/Kconfig   |  10 ++
>  drivers/iio/amplifiers/Makefile  |   1 +
>  drivers/iio/amplifiers/hmc425a.c | 247 +++++++++++++++++++++++++++++++
>  3 files changed, 258 insertions(+)
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
> index 000000000000..525ebadaf1e8
> --- /dev/null
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -0,0 +1,247 @@
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
> +	int i, *values;
> +
> +	values = kmalloc_array(st->chip_info->num_gpios, sizeof(int),
> +			       GFP_KERNEL);
> +	if (!values)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < st->chip_info->num_gpios; i++)
> +		values[i] = (value >> i) & 1;
> +
> +	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
> +				       values);
> +	kfree(values);
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
> +		/* Values in dB */
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
> +	/* Values in dB */

Are they?.  For output values we have the IIO_VAL_INT_PLUS_MICRO_DB
formatting option, but I don't think we yet have any code in the
core to read in values in DB.  I think all it would need to do is check
that dB occured after the number and provide a write_raw_get_fmt
callback to ensure the core knows to enforce this.

We may have an issue with other drivers around this though...
Possibly need some fuzzy logic to let them work but perhaps
print a warning once that they should postfix with dB.
What do people think?
 
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
> +static const struct iio_info hmc425a_info = {
> +	.read_raw = &hmc425a_read_raw,
> +	.write_raw = &hmc425a_write_raw,
> +};
> +
> +#define HMC425A_CHAN(_channel)                                          \
> +{                                                                      \
> +	.type = IIO_VOLTAGE, .output = 1, .indexed = 1,                \
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
> +static void hmc425a_remove(void *data)
> +{
> +	struct hmc425a_state *st = data;
> +
> +	regulator_disable(st->reg);
> +}
> +
> +static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
> +	[ID_HMC425A] = {
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
> +	struct device_node *np = pdev->dev.of_node;
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
> +
> +	st->chip_info = &hmc425a_chip_info_tbl[st->type];
> +	indio_dev->num_channels = st->chip_info->num_channels;
> +	indio_dev->channels = st->chip_info->channels;
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
> +	st->reg = devm_regulator_get(&pdev->dev, "vcc");

> +	if (!IS_ERR(st->reg)) {

Ideally handle deferred probing.   We might have a retlator
specified but not have it yet.

Don't paper over not finding it.  options are:
1) regulator framework not built.  Stubs won't return errors so fine.
2) regulator info not supplied.  A fake 'stub' regulator will be
return which will work fine (just not do anything).  This is often
desirable when the power line isn't controllable.
3) actual regulator but driver not loaded yet.  For those we need to
   ensure we return with -EDEFER. That will be returned by devm_regulator_get
   if that happens.
4) regulator there and it all works perfectly.

For none of the above is skipping over this section the right thing to do.
 
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			return ret;
> +		ret = devm_add_action_or_reset(&pdev->dev, hmc425a_remove, st);

Given this just disables the regulator rather than being a conventional
driver remove, give it a different name.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	mutex_init(&st->lock);
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->name = np->name;
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
> +MODULE_DESCRIPTION(
> +	"Analog Devices HMC425A and similar GPIO control Gain Amplifiers");

Just leave that on one line and don't worry about 80 chars limit.
Its more 'advise' than a hard rule ;)


> +MODULE_LICENSE("GPL v2");

