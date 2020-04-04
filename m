Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50A319E64C
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDDPxg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 11:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgDDPxg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 11:53:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDDEE206E6;
        Sat,  4 Apr 2020 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586015615;
        bh=VwUw1HacP630W9/H5Gi7KR8X0NJ5usEduzYXDz4f68E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lxYZwfsh2KDVA7FkQmFB9TWAaEa5u0g9D7LckLyP5Xn/gAkN/hzqCTyMPCJMSXA+w
         cW9q4bmag1PG60PnbxNpgYeaTXSpNk0S82OG3mwqei8dLzElwJUV1rr1Gxy+rr6Qu9
         74Wa5yPkgIzIOfy1aTlHAefnlpAFIopvFcAdUjRA=
Date:   Sat, 4 Apr 2020 16:53:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/5] iio: adc: mp2629: Add support for mp2629 ADC
 driver
Message-ID: <20200404165330.45d3acf0@archlinux>
In-Reply-To: <20200329123110.26482-4-sravanhome@gmail.com>
References: <20200329123110.26482-1-sravanhome@gmail.com>
        <20200329123110.26482-4-sravanhome@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Mar 2020 14:31:08 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> Add support for 8-bit resolution ADC readings for input power
> supply and battery charging measurement. Provides voltage, current
> readings to mp2629 power supply driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

The probe / remove order seems to have gotten messed up (or I missed it
before :( and you've introduced a double free by mixing managed
and unmanaged calls.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig      |  10 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/mp2629_adc.c | 207 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mp2629.h   |   9 ++
>  4 files changed, 227 insertions(+)
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
> index 000000000000..2e5518168d3e
> --- /dev/null
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -0,0 +1,207 @@
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
> +	ret = iio_map_array_register(indio_dev, mp2629_adc_maps);
> +	if (ret) {
> +		dev_err(dev, "IIO maps register fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	indio_dev->name = "mp2629-adc";
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = mp2629_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mp2629_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mp2629_adc_info;
> +
> +	ret = regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,
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
> +		goto fail_disable;
> +	}
> +
> +	return 0;
> +
> +fail_disable:
> +	regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_CONTINUOUS, 0);
> +	regmap_update_bits(ddata->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_START, 0);
> +
> +fail_unmap:
> +	iio_map_array_unregister(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int mp2629_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct mp2629_adc *info = iio_priv(indio_dev);
> +
> +	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_CONTINUOUS, 0);
> +	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
> +					 MP2629_ADC_START, 0);
> +
> +	iio_map_array_unregister(indio_dev);
> +	iio_device_unregister(indio_dev);

Not sure how I missed this before.

You are using a managed call devm_iio_device_register so there is nothing
to undo here.  However, the ordering in this remove is not the reverse
of that in probe.  That usually means there are some race conditions
hiding so is a bad idea.  If there is a very strong reason to do so
I'd expect to see a comment explaining it.

Note you shouldn't be using the devm_iio_device_register because
if you do then you can't manually unregister before calling the rest
of the stuff in here (which you want to do).

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

