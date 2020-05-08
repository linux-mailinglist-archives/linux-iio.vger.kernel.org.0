Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06F1CB0B2
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgEHNob (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:44:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbgEHNob (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 09:44:31 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 384B7706140CDC0BEBAF;
        Fri,  8 May 2020 14:44:29 +0100 (IST)
Received: from localhost (10.47.95.97) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 May 2020
 14:44:28 +0100
Date:   Fri, 8 May 2020 14:44:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <robh@kernel.org>,
        <mchehab+huawei@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] iio: imu: inv_icm42600: add I2C driver for
 inv_icm42600 driver
Message-ID: <20200508144406.00006b8c@Huawei.com>
In-Reply-To: <20200507144222.20989-3-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-3-jmaneyrol@invensense.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.97]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 May 2020 16:42:12 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add I2C driver for InvenSense ICM-426xxx devices.
> 
> Configure bus signal slew rates as indicated in the datasheet.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Some incoherent rambling inline. + a few comments

Jonathan

> ---
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> new file mode 100644
> index 000000000000..b61f993beacf
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 InvenSense, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/of_device.h>

Why?  Looks like you need the table and the device property stuff neither
of which are in that file.

linux/mod_devicetable.h
linux/property.h


> +
> +#include "inv_icm42600.h"
> +
> +static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	/* setup interface registers */
> +	mask = INV_ICM42600_INTF_CONFIG6_MASK;
> +	val = INV_ICM42600_INTF_CONFIG6_I3C_EN;
> +	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
> +				 mask, val);

I'd put the values inline where they are simple like these rather than
using local variables.

> +	if (ret)
> +		return ret;
> +
> +	mask = INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY;
> +	val = 0;
> +	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	/* set slew rates for I2C and SPI */
> +	mask = INV_ICM42600_DRIVE_CONFIG_I2C_MASK |
> +	       INV_ICM42600_DRIVE_CONFIG_SPI_MASK;
> +	val = INV_ICM42600_DRIVE_CONFIG_I2C(INV_ICM42600_SLEW_RATE_12_36NS) |
> +	      INV_ICM42600_DRIVE_CONFIG_SPI(INV_ICM42600_SLEW_RATE_12_36NS);
> +	ret = regmap_update_bits(st->map, INV_ICM42600_REG_DRIVE_CONFIG,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	/* disable SPI bus */
> +	mask = INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK;
> +	val = INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS;
> +	return regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
> +				  mask, val);
> +}
> +
> +static int inv_icm42600_probe(struct i2c_client *client,
> +			      const struct i2c_device_id *id)
> +{
> +	const void *match;
> +	enum inv_icm42600_chip chip;
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENOTSUPP;
> +
> +	match = device_get_match_data(&client->dev);

Hmm. Annoyingly if one were to call the of specific option
of i2c_of_match_device it would handle the old style i2c match just fine without
needing special handling.  However, it would fail to handle PRP0001 ACPI.

Rather feels like there should be something similar for
device_get_match_data so we could use the probe_new version of i2c device
probing.

Oh well. I guess thats a separate question for another day ;)

Mind you can we actually probe this driver via the sysfs route?
If not why do we need to handle the non firmware case at all?
 
> +	if (match)
> +		chip = (enum inv_icm42600_chip)match;
> +	else if (id)
> +		chip = (enum inv_icm42600_chip)id->driver_data;
> +	else
> +		return -EINVAL;
> +
> +	regmap = devm_regmap_init_i2c(client, &inv_icm42600_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return inv_icm42600_core_probe(regmap, chip,
> +				       inv_icm42600_i2c_bus_setup);
> +}
> +
> +static const struct of_device_id inv_icm42600_of_matches[] = {
> +	{
> +		.compatible = "invensense,icm42600",
> +		.data = (void *)INV_CHIP_ICM42600,
> +	}, {
> +		.compatible = "invensense,icm42602",
> +		.data = (void *)INV_CHIP_ICM42602,
> +	}, {
> +		.compatible = "invensense,icm42605",
> +		.data = (void *)INV_CHIP_ICM42605,
> +	}, {
> +		.compatible = "invensense,icm42622",
> +		.data = (void *)INV_CHIP_ICM42622,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42600_of_matches);
> +
> +static const struct i2c_device_id inv_icm42600_ids[] = {
> +	{"icm42600", INV_CHIP_ICM42600},
> +	{"icm42602", INV_CHIP_ICM42602},
> +	{"icm42605", INV_CHIP_ICM42605},
> +	{"icm42622", INV_CHIP_ICM42622},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, inv_icm42600_ids);
> +
> +static struct i2c_driver inv_icm42600_driver = {
> +	.probe = inv_icm42600_probe,
> +	.id_table = inv_icm42600_ids,
> +	.driver = {
> +		.of_match_table = inv_icm42600_of_matches,
> +		.name = "inv-icm42600-i2c",
> +		.pm = &inv_icm42600_pm_ops,
> +	},
> +};
> +module_i2c_driver(inv_icm42600_driver);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-426xx I2C driver");
> +MODULE_LICENSE("GPL");


