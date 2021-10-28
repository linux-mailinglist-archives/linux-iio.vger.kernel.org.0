Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E940D43DFB5
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJ1LIH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 07:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJ1LIG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 07:08:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066E560C51;
        Thu, 28 Oct 2021 11:05:35 +0000 (UTC)
Date:   Thu, 28 Oct 2021 12:10:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
Message-ID: <20211028121001.73d8abbe@jic23-huawei>
In-Reply-To: <20211028101840.24632-11-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-11-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 12:18:40 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This path adds an I2C driver for communicating to a BNO055 IMU via I2C bus
> and it enables the BNO055 core driver to work in this scenario.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Hi Andrea,

A few minor things inline.

Jonathan

> ---
>  drivers/iio/imu/bno055/Kconfig      |  6 ++++
>  drivers/iio/imu/bno055/Makefile     |  1 +
>  drivers/iio/imu/bno055/bno055_i2c.c | 54 +++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
> 
> diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> index 941e43f0368d..87200787d548 100644
> --- a/drivers/iio/imu/bno055/Kconfig
> +++ b/drivers/iio/imu/bno055/Kconfig
> @@ -7,3 +7,9 @@ config BOSH_BNO055_SERIAL
>  	tristate "Bosh BNO055 attached via serial bus"
>  	depends on SERIAL_DEV_BUS
>  	select BOSH_BNO055_IIO
> +
> +config BOSH_BNO055_I2C
> +	tristate "Bosh BNO055 attached via I2C bus"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select BOSH_BNO055_IIO
> diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
> index 7285ade2f4b9..eaf24018cb28 100644
> --- a/drivers/iio/imu/bno055/Makefile
> +++ b/drivers/iio/imu/bno055/Makefile
> @@ -2,3 +2,4 @@
>  
>  obj-$(CONFIG_BOSH_BNO055_IIO) += bno055.o
>  obj-$(CONFIG_BOSH_BNO055_SERIAL) += bno055_sl.o
> +obj-$(CONFIG_BOSH_BNO055_I2C) += bno055_i2c.o
> diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
> new file mode 100644
> index 000000000000..eea0daa6a61d
> --- /dev/null
> +++ b/drivers/iio/imu/bno055/bno055_i2c.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I2C interface for Bosh BNO055 IMU.
> + * This file implements I2C communication up to the register read/write
> + * level.

Not really. It just uses regmap, so I'd drop this comment.

> + *
> + * Copyright (C) 2021 Istituto Italiano di Tecnologia
> + * Electronic Design Laboratory
> + * Written by Andrea Merello <andrea.merello@iit.it>
> + */
> +
> +#include <linux/i2c.h>

Why?  I'm not seeing an i2c specific calls in here.

> +#include <linux/regmap.h>
> +#include <linux/module.h>

mod_devicetable.h for struct i2c_device_id
 
> +
> +#include "bno055.h"
> +
> +#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */
> +
> +static int bno055_i2c_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap =
> +		devm_regmap_init_i2c(client, &bno055_regmap_config);
> +
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Unable to init register map");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bno055_probe(&client->dev, regmap,
> +			    BNO055_I2C_XFER_BURST_BREAK_THRESHOLD);
> +
> +	return 0;

?

> +}
> +
> +static const struct i2c_device_id bno055_i2c_id[] = {
> +	{"bno055", 0},
> +	{ },

It's at terminator, so don't put a comma as we'll never add entries after this.

> +};
> +MODULE_DEVICE_TABLE(i2c, bno055_i2c_id);
> +
> +static struct i2c_driver bno055_driver = {
> +	.driver = {
> +		.name = "bno055-i2c",
> +	},
> +	.probe = bno055_i2c_probe,
> +	.id_table = bno055_i2c_id
> +};
> +module_i2c_driver(bno055_driver);
> +
> +MODULE_AUTHOR("Andrea Merello");
> +MODULE_DESCRIPTION("Bosch BNO055 I2C interface");
> +MODULE_LICENSE("GPL v2");

