Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276271E974F
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 13:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgEaLgR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 07:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEaLgQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 07:36:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB7E420671;
        Sun, 31 May 2020 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590924976;
        bh=Rv/7V6ux7Uy8b3nh+5x7UlhqkHYK1bQnCpnuxjo3nxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZqHAPhyjHF2l+Z7E9FojBBpdxFgTAfTVO+Y2mj8CyIeP3cW6uczGE4kZp1FkFRNMb
         018bPK4G3YLHzAgfb5eqvipWmSNuxI6jcJqaEijbwKG8ypJngHKOXxCiBiOpUaoHlX
         xDPwD+lcPzq9neKB8XROxHuOX4nV0O5j+b3AuuGg=
Date:   Sun, 31 May 2020 12:36:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     robh+dt@kernel.org, robh@kernel.org, mchehab+huawei@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] iio: imu: inv_icm42600: add I2C driver for
 inv_icm42600 driver
Message-ID: <20200531123611.794883c4@archlinux>
In-Reply-To: <20200527185711.21331-3-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-3-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 May 2020 20:57:01 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add I2C driver for InvenSense ICM-426xxx devices.
> 
> Configure bus signal slew rates as indicated in the datasheet.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Looks fine to me.

J

> ---
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> new file mode 100644
> index 000000000000..4789cead23b3
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/property.h>
> +
> +#include "inv_icm42600.h"
> +
> +static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	/* setup interface registers */
> +	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
> +				 INV_ICM42600_INTF_CONFIG6_MASK,
> +				 INV_ICM42600_INTF_CONFIG6_I3C_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
> +				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);
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
> +	return regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
> +				  INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK,
> +				  INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS);
> +}
> +
> +static int inv_icm42600_probe(struct i2c_client *client)
> +{
> +	const void *match;
> +	enum inv_icm42600_chip chip;
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENOTSUPP;
> +
> +	match = device_get_match_data(&client->dev);
> +	if (!match)
> +		return -EINVAL;
> +	chip = (enum inv_icm42600_chip)match;
> +
> +	regmap = devm_regmap_init_i2c(client, &inv_icm42600_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return inv_icm42600_core_probe(regmap, chip, inv_icm42600_i2c_bus_setup);
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
> +static struct i2c_driver inv_icm42600_driver = {
> +	.driver = {
> +		.name = "inv-icm42600-i2c",
> +		.of_match_table = inv_icm42600_of_matches,
> +		.pm = &inv_icm42600_pm_ops,
> +	},
> +	.probe_new = inv_icm42600_probe,
> +};
> +module_i2c_driver(inv_icm42600_driver);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-426xx I2C driver");
> +MODULE_LICENSE("GPL");

