Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95641AF08E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgDROuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 10:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgDROuQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 10:50:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC8720753;
        Sat, 18 Apr 2020 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221415;
        bh=303gUJbQF+M2sNMQfQWkWiYpyN7ocLgZ90zjaTPj990=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZmDFCu/zIOt9fjM0A3rQjxYdSDMTYf13tFwjkP5Z6ju9nJpHJKQolJTMDHskcG9p2
         Ij7hxUk2w0jcEBlOFmaNXjiI/x9dO8xrvOsZ8wHkWoPuoWzUXTTrSW7BtzjAyoI1Up
         b2ojEx34NbaWlomL/f6PgV7B63vfd55n9baSYPP8=
Date:   Sat, 18 Apr 2020 15:50:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 2/6] mfd: mp2629: Add support for mps battery
 charger
Message-ID: <20200418155009.0187b7fc@archlinux>
In-Reply-To: <20200417085003.6124-3-sravanhome@gmail.com>
References: <20200417085003.6124-1-sravanhome@gmail.com>
        <20200417085003.6124-3-sravanhome@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 10:49:59 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> mp2629 is a highly-integrated switching-mode battery charge management
> device for single-cell Li-ion or Li-polymer battery.
> 
> Add MFD core enables chip access for ADC driver for battery readings,
> and a power supply battery-charger driver
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/Kconfig        |  9 ++++
>  drivers/mfd/Makefile       |  2 +
>  drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mp2629.h | 19 +++++++++
>  4 files changed, 116 insertions(+)
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 include/linux/mfd/mp2629.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3c547ed575e6..85be799795aa 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MP2629
> +	tristate "Monolithic power system MP2629 ADC and Battery charger"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Select this option to enable support for monolithic power system
> +	  battery charger. This provides ADC, thermal, battery charger power
> +	  management functions on the systems.
> +
>  config MFD_MXS_LRADC
>  	tristate "Freescale i.MX23/i.MX28 LRADC"
>  	depends on ARCH_MXS || COMPILE_TEST
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f935d10cbf0f..d6c210f96d02 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -170,6 +170,8 @@ obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
>  obj-$(CONFIG_MFD_MAX8997)	+= max8997.o max8997-irq.o
>  obj-$(CONFIG_MFD_MAX8998)	+= max8998.o max8998-irq.o
>  
> +obj-$(CONFIG_MFD_MP2629)	+= mp2629.o
> +
>  pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
>  obj-$(CONFIG_MFD_PCF50633)	+= pcf50633.o
>  obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
> diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
> new file mode 100644
> index 000000000000..46242b1cdf24
> --- /dev/null
> +++ b/drivers/mfd/mp2629.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MP2629 parent driver for ADC and battery charger
> + *
> + * Copyright 2020 Monolithic Power Systems, Inc
> + *
> + * Author: Saravanan Sekar <sravanhome@gmail.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/mp2629.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +enum {
> +	MP2629_MFD_ADC,
> +	MP2629_MFD_CHARGER,
> +	MP2629_MFD_MAX
> +};
> +
> +static const struct mfd_cell mp2629mfd[] = {
> +	[MP2629_MFD_ADC] = {
> +		.name = "mp2629_adc",
> +		.of_compatible = "mps,mp2629_adc",
> +	},
> +	[MP2629_MFD_CHARGER] = {
> +		.name = "mp2629_charger",
> +		.of_compatible = "mps,mp2629_charger",
> +	}
> +};
> +
> +static const struct regmap_config mp2629_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x17,
> +};
> +
> +static int mp2629_probe(struct i2c_client *client)
> +{
> +	struct mp2629_info *ddata;
> +	int ret;
> +
> +	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->dev = &client->dev;
> +	i2c_set_clientdata(client, ddata);
> +
> +	ddata->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
> +	if (IS_ERR(ddata->regmap)) {
> +		dev_err(ddata->dev, "Failed to allocate regmap!\n");
> +		return PTR_ERR(ddata->regmap);
> +	}
> +
> +	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_NONE, mp2629mfd,
> +				ARRAY_SIZE(mp2629mfd), NULL,
> +				0, NULL);
> +	if (ret)
> +		dev_err(ddata->dev, "Failed to register sub-devices %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id mp2629_of_match[] = {
> +	{ .compatible = "mps,mp2629"},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mp2629_of_match);
> +
> +static struct i2c_driver mp2629_driver = {
> +	.driver = {
> +		.name = "mp2629",
> +		.of_match_table = mp2629_of_match,
> +	},
> +	.probe_new	= mp2629_probe,
> +};
> +module_i2c_driver(mp2629_driver);
> +
> +MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
> +MODULE_DESCRIPTION("MP2629 Battery charger parent driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
> new file mode 100644
> index 000000000000..06985e41fc6f
> --- /dev/null
> +++ b/include/linux/mfd/mp2629.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * register definitions for MP2629 charger
> + *
> + * Copyright 2020 Monolithic Power Systems, Inc
> + */
> +
> +#ifndef __MP2629_H__
> +#define __MP2629_H__
> +
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +
> +struct mp2629_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +#endif

