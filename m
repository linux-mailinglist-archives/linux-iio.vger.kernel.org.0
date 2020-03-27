Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AF819525B
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 08:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgC0Hyz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 03:54:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33752 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0Hyy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 03:54:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so10280590wrd.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xUFFKgN3GfGwUoYxNVOvMRouA9N+GmIsWjhSsoKFX5E=;
        b=Y3cEWhLcIOHEPTL/VkoGr5rmc2Y51cZVjR78PzBKRezoNIZvm5eHjjNQUgRpZin8GZ
         Z1d0WpYywAPdqlpPgLJM8M5Sh3JeSh+WIoW2weDwLhqoUcjZo+tvHfDH/x1c11ABky5O
         oEca0QR4lk/RKLO79mNgjPvRE1AL5spkEsGJPB6hCf0HY359JwyjQq5+zXCCHRuRhAfP
         2Q8HPvqrvTxd0F5CqJC2J+kxaJ3jnCqZkJaa/pcmekjFJS013iuo25wMnzaZd2l1bA9/
         jG3OxrmO2pHlA5Ny5H1gE60EraNsNzqVJSUeDOC65+V+7pKGqhaHUVJScP7ECzPPv0bb
         XkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xUFFKgN3GfGwUoYxNVOvMRouA9N+GmIsWjhSsoKFX5E=;
        b=jmcILJ6IjGTE8z+V+IqKkLXYzzLWSUgL0A2/Rske3Njp1pPhfP/y1shy6fLuj2zHZw
         bYyAt8if/lczDFX3ZRapjwWTD9S4C5NwnsRUrHLmLVMuCBVbhI6DTzldpoQa3h3a1Yns
         7MsG6gyb+gjHaCGE5n2Ui7KI3TU5dqKgFOFn06v6b6SDM3ff9MwxO2cPDN5m5fGgQijJ
         HTHLdwL9oHtBo+t9pWI+a09Yp69TvY3kYymVi8CSRwRfTm7HlDbDB1q85VaqWEc5vCAU
         q9e3heExDmWvB6GQU2BFDZ2B/6LeWSTaBadTv7M0L2MAn6AwbVzyHm42zuoRgnwTaWzz
         mIvQ==
X-Gm-Message-State: ANhLgQ29TgjJOeu1ahtHBITaAN75peKlqb996DN7uGoJ7py9aJxXo6ZU
        scBCe0QTLdjX3WVCGSdUNqW8SQ==
X-Google-Smtp-Source: ADFU+vvNRH9b0uC33Fh+bPHVkYEbnbN5ACvModpHREVazC0tcnSTCxv7KBdulAOvR2/d/NScx9s/QQ==
X-Received: by 2002:adf:f7cb:: with SMTP id a11mr13341425wrq.79.1585295692174;
        Fri, 27 Mar 2020 00:54:52 -0700 (PDT)
Received: from dell ([95.149.164.95])
        by smtp.gmail.com with ESMTPSA id k9sm7684467wrd.74.2020.03.27.00.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 00:54:51 -0700 (PDT)
Date:   Fri, 27 Mar 2020 07:55:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200327075541.GF603801@dell>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200322224626.13160-3-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020, Saravanan Sekar wrote:

> mp2629 is a highly-integrated switching-mode battery charge management
> device for single-cell Li-ion or Li-polymer battery.
> 
> Add MFD core enables chip access for ADC driver for battery readings,
> and a power supply battery-charger driver
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/mfd/Kconfig        |   9 +++
>  drivers/mfd/Makefile       |   2 +
>  drivers/mfd/mp2629.c       | 116 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mp2629.h |  22 +++++++
>  4 files changed, 149 insertions(+)
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 include/linux/mfd/mp2629.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3c547ed575e6..6614e5cff881 100644
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
> index 000000000000..41a4082387ce
> --- /dev/null
> +++ b/drivers/mfd/mp2629.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MP2629 MFD Driver for ADC and battery charger

s/MFD Driver/parent driver/

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

Alphabetical please.

> +enum {
> +	MP2629_MFD_ADC,
> +	MP2629_MFD_CHARGER,
> +	MP2629_MFD_MAX
> +};
> +
> +static struct resource mp2629_irq_rsrc[] = {
> +	{
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct mfd_cell mp2629mfd[] = {
> +	[MP2629_MFD_ADC] = {
> +		.name = "mp2629_adc",
> +		.of_compatible = "mps,mp2629_adc",
> +	},
> +	[MP2629_MFD_CHARGER] = {
> +		.name = "mp2629_charger",
> +		.of_compatible = "mps,mp2629_charger",
> +		.resources = mp2629_irq_rsrc,
> +		.num_resources = ARRAY_SIZE(mp2629_irq_rsrc),
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

All this ddata instead of info.

> +	struct resource	*resources;
> +	int ret;
> +	int i;
> +
> +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->dev = &client->dev;
> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		dev_err(info->dev, "Failed to allocate regmap!\n");
> +		return PTR_ERR(info->regmap);
> +	}
> +
> +	for (i = 0; i < MP2629_MFD_MAX; i++) {
> +		mp2629mfd[i].platform_data = &info->regmap;
> +		mp2629mfd[i].pdata_size = sizeof(info->regmap);

You don't need to store this in platform data as well.

You already have it in device data (ddata [currently 'info']).

> +		resources = (struct resource *)mp2629mfd[i].resources;
> +		if (resources) {
> +			resources[0].start = client->irq;
> +			resources[0].end = client->irq;
> +		}

You don't need to store this separately either.

Just fetch it from the parent in the child device driver.

It will look something like (untested, off the top of my head):

  platform_get_irq(to_platform_device(pdev->dev.parent), 0);

> +	}
> +
> +	ret = devm_mfd_add_devices(info->dev, PLATFORM_DEVID_NONE, mp2629mfd,
> +				ARRAY_SIZE(mp2629mfd), NULL,
> +				0, NULL);
> +	if (ret)
> +		dev_err(info->dev, "Failed to add mfd %d\n", ret);

"Failed to register sub-devices"

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

You're already using .probe_new - this can be removed.

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

"parent driver"

> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
> new file mode 100644
> index 000000000000..371e44330ba8
> --- /dev/null
> +++ b/include/linux/mfd/mp2629.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * mp2629.h  - register definitions for mp2629 charger

Remove the filename.

s/mp2629/MP2629/

> + * Copyright 2020 Monolithic Power Systems, Inc
> + *

Superfluous '\n'.

> + */
> +
> +#ifndef __MP2629_H__
> +#define __MP2629_H__
> +
> +#include <linux/types.h>
> +
> +struct device;
> +struct regmap;

Why not just add the includes?

> +struct mp2629_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +#endif

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
