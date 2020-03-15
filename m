Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6468185BEE
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 11:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgCOK2E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 06:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgCOK2E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 06:28:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3E920578;
        Sun, 15 Mar 2020 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584268082;
        bh=SinDE6ao+AVMlHMf0LA1ju7l1TWQay+Xe7k5LIe/niQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fKoNidTdAXuxPUl4g7jI6GYD+J8juaHomYGarIgbu0HasebQa1TPVSx2dmCbHIUMk
         QH5k/a2T4sAomx5hMoz/m697U68ZW9TsnOJATqsYo9x+Mb9Xtsg2Sc1Sfl84DxzrBO
         p54IilaccOLIYDBf8IuxCFguflm4GXMF7QJNgdeI=
Date:   Sun, 15 Mar 2020 10:27:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200315102757.5953b2e8@archlinux>
In-Reply-To: <20200315000013.4440-3-sravanhome@gmail.com>
References: <20200315000013.4440-1-sravanhome@gmail.com>
        <20200315000013.4440-3-sravanhome@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 01:00:10 +0100
Saravanan Sekar <sravanhome@gmail.com> wrote:

> mp2629 is a highly-integrated switching-mode battery charge management
> device for single-cell Li-ion or Li-polymer battery.
> 
> Add MFD core enables chip access for ADC driver for battery readings,
> and a power supply battery-charger driver
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/mfd/Kconfig        |  9 ++++
>  drivers/mfd/Makefile       |  2 +
>  drivers/mfd/mp2629.c       | 96 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mp2629.h | 32 +++++++++++++
>  4 files changed, 139 insertions(+)
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 include/linux/mfd/mp2629.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3c547ed575e6..f3f0a2908f16 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MP2629
> +	bool "Monolithic power system MP2629 ADC and Battery charger"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Select this option to enable support for Monolithic power system

Monolithic Power Systems

> +	  Battery charger. This provides ADC, thermal, Battery charger power

battery (both instances don't need a capital)

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
> index 000000000000..47a37eadf25d
> --- /dev/null
> +++ b/drivers/mfd/mp2629.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MP2629 MFD Driver for ADC and battery charger
> + *
> + * Copyright 2020 Monolithic Power Systems, Inc
> + *
> + * Author: Saravanan Sekar <sravanhome@gmail.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/mp2629.h>
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
> +	struct mp2629_info *info;
> +	int ret;
> +
> +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->dev = &client->dev;
> +	info->irq = client->irq;

This surprises me a bit given the irq isn't used in this driver at all.
Should it perhaps be provided directly to the child that uses it?
(Not sure myself, Lee?)

> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		dev_err(info->dev, "Failed to allocate regmap!\n");
> +		return PTR_ERR(info->regmap);
> +	}
> +
> +	ret = devm_mfd_add_devices(info->dev, PLATFORM_DEVID_NONE, mp2629mfd,
> +				ARRAY_SIZE(mp2629mfd), NULL,
> +				0, NULL);
> +	if (ret)
> +		dev_err(info->dev, "Failed to add mfd %d\n", ret);
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
> +static const struct i2c_device_id mp2629_id[] = {
> +	{ "mp2629", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mp2629_id);
> +
> +static struct i2c_driver mp2629_driver = {
> +	.driver = {
> +		.name = "mp2629",
> +		.of_match_table = mp2629_of_match,
> +	},
> +	.probe_new	= mp2629_probe,
> +	.id_table	= mp2629_id,
> +};
> +module_i2c_driver(mp2629_driver);
> +
> +MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
> +MODULE_DESCRIPTION("MP2629 Battery charger mfd driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
> new file mode 100644
> index 000000000000..32f0737f245e
> --- /dev/null
> +++ b/include/linux/mfd/mp2629.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * mp2629.h  - register definitions for mp2629 charger
> + *
> + * Copyright 2020 Monolithic Power Systems, Inc
> + *
> + */
> +
> +#ifndef __MP2629_H__
> +#define __MP2629_H__
> +
> +#include <linux/types.h>
> +
> +struct device;
> +struct regmap;
> +
> +struct mp2629_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	int irq;
> +};
> +
> +enum mp2629_adc_chan {
> +	MP2629_BATT_VOLT,
> +	MP2629_SYSTEM_VOLT,
> +	MP2629_INPUT_VOLT,
> +	MP2629_BATT_CURRENT,
> +	MP2629_INPUT_CURRENT,
> +	MP2629_ADC_CHAN_END
> +};

This enum isn't used in this patch. I'd slightly prefer it to be introduced
with the first user.

> +
> +#endif

