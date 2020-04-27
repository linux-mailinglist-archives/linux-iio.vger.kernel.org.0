Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA07D1B988A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgD0H0u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 03:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgD0H0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 03:26:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D34EC061A0F
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 00:26:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so18485140wrt.5
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=REsNWJFhGHkYdNp6uSDWtGMh4mD2RMBDMNXtan+gWIc=;
        b=y6lolgbWbIjibS0k2DZwbMu9IhLLA/Q1+5YPGsQ0VMTlpMCgfMMpCBqC1Z9oQ9V5Xz
         1sWBinJaUKGAihPUZPFY3rlf9BFT3AObzjJwss7B5O3Nzu7skbTVK8XPFb1Dyp9Isl4j
         IphzvC/ITzqb4VWc7vxeKv1TXxbqJfSzWmsV7Kh06CyOsDZDP5MFFHSOclkE/5h2h5Dy
         rrx9XWHk4Jg+FFvxpsLmYSXFSfFYyZ9zYKKd8hJkp/zfQLPkXl7tNjZDuT4L+WWbsOlA
         TkDRy0vJ63E5HQ9r/zA9OqZNwaYzdw3uFm+t9lhxnlHZt2lS0OOtQgNmZvRcczaksk6U
         S2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=REsNWJFhGHkYdNp6uSDWtGMh4mD2RMBDMNXtan+gWIc=;
        b=WhuGEVexYyzunFC3izUuoxfY8TP5/+xP52UsUtyZqBQGVO7068IO8b9XKbqKaVe2do
         WzZxpMjulUVAJhiNM7ra3rLWBK/KiwrsCx8+rYrZqUa56bPJ5dcarYSzVfJkt1Lims2e
         RueYd6PA/gHyswnqls32eK/oQ5DZy9uS2jW+5IzKBDnlumsL7QHhHFe1e1ZeEZmkoQF4
         EZkC/qkB6h6Qu+83MdTRmDR2edQmrlOf5+J4A10/NxZVBXCdhao3a6c75rMVcwnkQ1Md
         u2Hbi/H5neVHaBKfVl+K2tn03v13xfDVvL9zp9eB9A0KWmjir332e53bNwdHFe0yAZmv
         N+KQ==
X-Gm-Message-State: AGi0Pubr+XEuelWFe/iJqmpjrI92PYCpM0jAxfi6YBnjtS19CnZlEYCt
        xvuWppOGHDIlVajmO5u/6l025A==
X-Google-Smtp-Source: APiQypKoocBwU3Ift+kayLrttVgX080iHAs2xcy/58Ymq9mcLr92w1rV9fJaFpQx4LTHnYzOcp3oIA==
X-Received: by 2002:a5d:574b:: with SMTP id q11mr20276374wrw.324.1587972407272;
        Mon, 27 Apr 2020 00:26:47 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id x13sm15123749wmc.5.2020.04.27.00.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:26:46 -0700 (PDT)
Date:   Mon, 27 Apr 2020 08:26:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200427072644.GE3559@dell>
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415162030.16414-3-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020, Saravanan Sekar wrote:

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

"Power Systems"

> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Select this option to enable support for monolithic power system

"Monolithic Power Systems"

> +	  battery charger. This provides ADC, thermal, battery charger power

"thermal and battery"

> +	  management functions on the systems.

What does "on the systems" mean?

I would just drop that part.

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

Why do you need this?  I think it can be dropped.

> +static const struct mfd_cell mp2629mfd[] = {

Drop the "mfd" part of "mp2629mfd".

You can call it "mp2629_cell" if you like.

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

Best to define the registers in an enum and call the last one
MP2629_MAX_REG or similar.

> +};
> +
> +static int mp2629_probe(struct i2c_client *client)
> +{
> +	struct mp2629_info *ddata;

Either change "info" to "ddata", or drop it completely.

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

No need for the exclamation mark.

> +		return PTR_ERR(ddata->regmap);
> +	}
> +
> +	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_NONE, mp2629mfd,

Why NONE over AUTO?

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

"Register"

Although there aren't any register definitions in here?

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

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
