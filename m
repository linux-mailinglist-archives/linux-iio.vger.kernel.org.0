Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714DC1AF02C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgDROsW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 10:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgDROsV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 10:48:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D2521BE5;
        Sat, 18 Apr 2020 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221299;
        bh=quy6kkOoKljosh7SRbl7ugK6xmAK72BKVFHy2tz7uyc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=laazrOLE9v9mKJymPJlcOeCYzmk1dRVKRZOtW9lxoD3aGlQbGTDChjmgfMa+SbY1p
         xYFoZZJttNHzIs4ohZ/DJ807GWPXa7CEoakOG5nteeJF8IfyHk+SBvS58Rt+1b/1l1
         +EsHClQogq9H7htV91tNtgOdk0tqLTwPxxKDnIJw=
Date:   Sat, 18 Apr 2020 15:48:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 3/6] iio: adc: mp2629: Add support for mp2629 ADC
 driver
Message-ID: <20200418154814.160b3478@archlinux>
In-Reply-To: <20200417085003.6124-4-sravanhome@gmail.com>
References: <20200417085003.6124-1-sravanhome@gmail.com>
        <20200417085003.6124-4-sravanhome@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 10:50:00 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Add support for 8-bit resolution ADC readings for input power
> supply and battery charging measurement. Provides voltage, current
> readings to mp2629 power supply driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

One total nitpick inline if you happen to do a v11. If not I'm fine with
leaving it as it stands.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

J
> ---
>  drivers/iio/adc/Kconfig      |  10 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/mp2629_adc.c | 208 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mp2629.h   |   9 ++
>  4 files changed, 228 insertions(+)
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
> index 000000000000..faf389f32729
> --- /dev/null
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MP2629 Driver for ADC
> + *
> + * Copyright 2020 Monolithic Power Systems, Inc
> + *
> + * Author: Saravanan Sekar <sravanhome@gmail.com>
> + */
> +
> +#include <linux/iio/driver.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/mfd/mp2629.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define	MP2629_REG_ADC_CTRL		0x03
> +#define	MP2629_REG_BATT_VOLT		0x0e
> +#define	MP2629_REG_SYSTEM_VOLT		0x0f
> +#define	MP2629_REG_INPUT_VOLT		0x11
> +#define	MP2629_REG_BATT_CURRENT		0x12
> +#define	MP2629_REG_INPUT_CURRENT	0x13
> +
> +#define	MP2629_ADC_START		BIT(7)
> +#define	MP2629_ADC_CONTINUOUS		BIT(6)
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
> +struct mp2629_adc {
> +	struct regmap *regmap;
> +	struct device *dev;
> +};
> +
> +static struct iio_chan_spec mp2629_channels[] = {
> +	MP2629_ADC_CHAN(BATT_VOLT, IIO_VOLTAGE),
> +	MP2629_ADC_CHAN(SYSTEM_VOLT, IIO_VOLTAGE),
> +	MP2629_ADC_CHAN(INPUT_VOLT, IIO_VOLTAGE),
> +	MP2629_ADC_CHAN(BATT_CURRENT, IIO_CURRENT),
> +	MP2629_ADC_CHAN(INPUT_CURRENT, IIO_CURRENT)
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
> +	struct mp2629_adc *info = iio_priv(indio_dev);
> +	unsigned int rval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(info->regmap, chan->address, &rval);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->address == MP2629_INPUT_VOLT)
> +			rval &= GENMASK(6, 0);
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
> +}
> +
> +static const struct iio_info mp2629_adc_info = {
> +	.read_raw = &mp2629_read_raw,
> +};
> +
> +static int mp2629_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mp2629_info *ddata = dev_get_drvdata(dev->parent);
> +	struct mp2629_adc *info;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	info->regmap = ddata->regmap;
> +	info->dev = dev;
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ret = regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,

It's a real nitpick but if you happen to be doing a v11 for some reason
could you change this to info->regmap and same in the error paths below.

The reason is so it looks the same in the error paths as in remove and
saves me 10 secs of checking they really are the same ;)

> +				MP2629_ADC_START | MP2629_ADC_CONTINUOUS,
> +				MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
> +	if (ret) {
> +		dev_err(dev, "adc enable fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = iio_map_array_register(indio_dev, mp2629_adc_maps);
> +	if (ret) {
> +		dev_err(dev, "IIO maps register fail: %d\n", ret);
> +		goto fail_disable;
> +	}
> +
> +	indio_dev->name = "mp2629-adc";
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = mp2629_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mp2629_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mp2629_adc_info;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(dev, "IIO device register fail: %d\n", ret);
> +		goto fail_map_unregister;
> +	}
> +
> +	return 0;
> +
> +fail_map_unregister:
> +	iio_map_array_unregister(indio_dev);
> +
> +fail_disable:
> +	regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_CONTINUOUS, 0);
> +	regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_START, 0);
> +
> +	return ret;
> +}
> +
> +static int mp2629_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct mp2629_adc *info = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	iio_map_array_unregister(indio_dev);
> +
> +	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_CONTINUOUS, 0);
> +	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_START, 0);
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
> diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
> index 06985e41fc6f..83ebfab41691 100644
> --- a/include/linux/mfd/mp2629.h
> +++ b/include/linux/mfd/mp2629.h
> @@ -16,4 +16,13 @@ struct mp2629_info {
>  	struct regmap *regmap;
>  };
>  
> +enum mp2629_adc_chan {
> +	MP2629_BATT_VOLT,
> +	MP2629_SYSTEM_VOLT,
> +	MP2629_INPUT_VOLT,
> +	MP2629_BATT_CURRENT,
> +	MP2629_INPUT_CURRENT,
> +	MP2629_ADC_CHAN_END
> +};
> +
>  #endif

