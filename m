Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6142B185BFA
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 11:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgCOKhN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 06:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgCOKhN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 06:37:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC22205C9;
        Sun, 15 Mar 2020 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584268631;
        bh=8ewgQI9pG9wLRFwqtLXiXuC4GTAAmEpzIuxYDhYuYSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uxnzAk91plFRI/6jhSqY9unSOt5xrHPelR2q0jTl64d8s5C/iRvBAEga1GRTIdtjx
         gRdBMjn4vsSLrZcR8YEmMnAxOZCu5cBb6K4QUw69zHFLyi0wexMqW52U2cPVTjHQoF
         /TnNw7bt4q/3vm9NfHEmNdPdEuKZD1pWbZXTrVWQ=
Date:   Sun, 15 Mar 2020 10:37:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: mp2629: Add support for mp2629 ADC
 driver
Message-ID: <20200315103706.38177792@archlinux>
In-Reply-To: <20200315000013.4440-4-sravanhome@gmail.com>
References: <20200315000013.4440-1-sravanhome@gmail.com>
        <20200315000013.4440-4-sravanhome@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 01:00:11 +0100
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Add support for 8-bit resolution ADC readings for input power
> supply and battery charging measurement. Provides voltage, current
> readings to mp2629 power supply driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

The IIO parts seems fine (minor comments inline) but I'm not keep on
directly accessing the internals of the mfd device info structure.

To my mind that should be opaque to the child drivers so as to provide
clear structure to any such accesses.

Jonathan


> ---
>  drivers/iio/adc/Kconfig      |  10 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/mp2629_adc.c | 209 +++++++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+)
>  create mode 100644 drivers/iio/adc/mp2629_adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 82e33082958c..ef0c0cd31855 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -680,6 +680,16 @@ config MESON_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called meson_saradc.
>  
> +config MP2629_ADC
> +	tristate "Monolithic MP2629 ADC driver"
> +	depends on MFD_MP2629
> +	help
> +	  Say yes to have support for battery charger IC MP2629 ADC device
> +	  accessed over I2C.
> +
> +	  This driver provides ADC conversion of system, input power supply
> +	  and battery voltage & current information.
> +
>  config NAU7802
>  	tristate "Nuvoton NAU7802 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 919228900df9..f14416c245a6 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_MCP3911) += mcp3911.o
>  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
>  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>  obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
> +obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
>  obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
>  obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> new file mode 100644
> index 000000000000..1a99196624ed
> --- /dev/null
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MP2629 Driver for ADC
> + *
> + * Copyright 2020 Monolithic Power Systems, Inc
> + *
> + * Author: Saravanan Sekar <sravanhome@gmail.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +#include <linux/mfd/mp2629.h>
> +
> +#define	MP2629_REG_ADC_CTRL		0x03
> +#define	MP2629_REG_BATT_VOLT		0x0e
> +#define	MP2629_REG_SYSTEM_VOLT		0x0f
> +#define	MP2629_REG_INPUT_VOLT		0x11
> +#define	MP2629_REG_BATT_CURRENT		0x12
> +#define	MP2629_REG_INPUT_CURRENT	0x13
> +
> +#define	MP2629_ADC_START		BIT(7)
> +#define MP2629_ADC_CONTINUOUS		BIT(6)

Odd alignment.

> +
> +#define MP2629_MAP(_mp, _mpc) IIO_MAP(#_mp, "mp2629_charger", "mp2629-"_mpc)
> +
> +#define MP2629_ADC_CHAN(_ch, _type) {				\
> +	.type = _type,						\
> +	.indexed = 1,						\
> +	.datasheet_name = #_ch,					\
> +	.channel = MP2629_ ## _ch,				\
> +	.address = MP2629_REG_ ## _ch,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static struct iio_chan_spec mp2629_channels[] = {
> +	MP2629_ADC_CHAN(BATT_VOLT, IIO_VOLTAGE),
> +	MP2629_ADC_CHAN(SYSTEM_VOLT, IIO_VOLTAGE),
> +	MP2629_ADC_CHAN(INPUT_VOLT, IIO_VOLTAGE),
> +	MP2629_ADC_CHAN(BATT_CURRENT, IIO_CURRENT),
> +	MP2629_ADC_CHAN(INPUT_CURRENT, IIO_CURRENT)
> +};
> +
> +struct mp2629_adc {
> +	struct mp2629_info *info;
> +	struct device *dev;
> +};
> +
> +static struct iio_map mp2629_adc_maps[] = {
> +	MP2629_MAP(BATT_VOLT, "batt-volt"),
> +	MP2629_MAP(SYSTEM_VOLT, "system-volt"),
> +	MP2629_MAP(INPUT_VOLT, "input-volt"),
> +	MP2629_MAP(BATT_CURRENT, "batt-current"),
> +	MP2629_MAP(INPUT_CURRENT, "input-current")
> +};
> +
> +static int mp2629_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
> +{
> +	struct mp2629_adc *adc_info = iio_priv(indio_dev);
> +	struct mp2629_info *info = adc_info->info;
> +	unsigned int rval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(info->regmap, chan->address, &rval);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (chan->address == MP2629_INPUT_VOLT)
> +			rval &= 0x7f;
> +		*val = rval;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel) {
> +		case MP2629_BATT_VOLT:
> +		case MP2629_SYSTEM_VOLT:
> +			*val = 20;
> +			return IIO_VAL_INT;
> +
> +		case MP2629_INPUT_VOLT:
> +			*val = 60;
> +			return IIO_VAL_INT;
> +
> +		case MP2629_BATT_CURRENT:
> +			*val = 175;
> +			*val2 = 10;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case MP2629_INPUT_CURRENT:
> +			*val = 133;
> +			*val2 = 10;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info mp2629_adc_info = {
> +	.read_raw = &mp2629_read_raw,
> +};
> +
> +static int mp2629_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mp2629_info *info = dev_get_drvdata(dev->parent);
> +	struct mp2629_adc *adc_info;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc_info = iio_priv(indio_dev);
> +	platform_set_drvdata(pdev, indio_dev);
> +	adc_info->info = info;
> +	adc_info->dev = dev;
> +
> +	ret = iio_map_array_register(indio_dev, mp2629_adc_maps);
> +	if (ret) {
> +		dev_err(dev, "IIO maps register fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->channels = mp2629_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mp2629_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mp2629_adc_info;
> +
> +	ret = regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
> +				MP2629_ADC_START | MP2629_ADC_CONTINUOUS,
> +				MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
> +	if (ret) {
> +		dev_err(dev, "adc enable fail: %d\n", ret);
> +		goto fail_unmap;
> +	}
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "IIO device register fail: %d\n", ret);
> +		goto fail_unmap;

Should we not be turning the device off like we do in remove?

> +	}
> +
> +	return 0;
> +
> +fail_unmap:
> +	iio_map_array_unregister(indio_dev);
> +	return ret;
> +}
> +
> +static int mp2629_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct mp2629_adc *adc_info = iio_priv(indio_dev);
> +	struct mp2629_info *info = adc_info->info;

This mess in layering with the children directly using the parents
regmap is a little concerning.  It means that the 3 drivers
really aren't very well separated and can't really be reviewed
independently (not a good thing). 

It might just be a question of providing a wrapper in the mfd driver
code so we at least have some visibility that this is going on.

> +
> +	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_CONTINUOUS, 0);
> +	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_START, 0);
> +
> +	iio_map_array_unregister(indio_dev);
> +	iio_device_unregister(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mp2629_adc_of_match[] = {
> +	{ .compatible = "mps,mp2629_adc"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mp2629_adc_of_match);
> +
> +static struct platform_driver mp2629_adc_driver = {
> +	.driver = {
> +		.name = "mp2629_adc",
> +		.of_match_table = mp2629_adc_of_match,
> +	},
> +	.probe		= mp2629_adc_probe,
> +	.remove		= mp2629_adc_remove,
> +};
> +module_platform_driver(mp2629_adc_driver);
> +
> +MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
> +MODULE_DESCRIPTION("MP2629 ADC driver");
> +MODULE_LICENSE("GPL");

