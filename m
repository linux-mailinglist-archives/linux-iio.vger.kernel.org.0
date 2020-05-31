Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF95C1E9677
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgEaJK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 05:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgEaJK3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 05:10:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 523E72073B;
        Sun, 31 May 2020 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590916228;
        bh=+k3JFKXWVtnoduDbOhgnffDcIBwKWBOPzImWveVMxug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bA0IuhROAeSnQhe1NQTsojG9gqj4RfS+cg2wUYj6z/G44mRaqYrGtKrkhuzmpIyUC
         5sWFSmgzsYKMQ2ccRPQD2hUaQWx3aQ2XOizt5xZcjD2Fo0KXyk6XrZOaDo0NIbWk6E
         Z5Rdlk+BKc3mO/u5iMYqtfjNEewRAlf2idK6EJnA=
Date:   Sun, 31 May 2020 10:10:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iio: accel: bma400: add support for bma400 spi
Message-ID: <20200531101024.69918a76@archlinux>
In-Reply-To: <20200530191010.4302-2-dan@dlrobertson.com>
References: <20200530191010.4302-1-dan@dlrobertson.com>
        <20200530191010.4302-2-dan@dlrobertson.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 30 May 2020 19:10:10 +0000
Dan Robertson <dan@dlrobertson.com> wrote:

> Add basic support for the Bosch Sensortec BMA400 3-axes ultra-low power
> accelerometer when configured to use SPI.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Hi Dan.

Code looks good, but one suggestion for a possible optimization inline.

I did wonder if it would be possible to use standard spi regmap to
do this, but it seems there is only a single pad parameter for both
reads and writes so that won't work.

Jonathan

> ---
>  drivers/iio/accel/Kconfig      |   8 ++-
>  drivers/iio/accel/Makefile     |   1 +
>  drivers/iio/accel/bma400_spi.c | 120 +++++++++++++++++++++++++++++++++
>  3 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/accel/bma400_spi.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 1080637ca40e..2e0c62c39155 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -116,18 +116,24 @@ config BMA400
>  	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
>  	select REGMAP
>  	select BMA400_I2C if I2C
> +	select BMA400_SPI if SPI
>  	help
>  	  Say Y here if you want to build a driver for the Bosch BMA400
>  	  triaxial acceleration sensor.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma400_core and you will also get
> -	  bma400_i2c if I2C is enabled.
> +	  bma400_i2c if I2C is enabled and bma400_spi if SPI is
> +	  enabled.
>  
>  config BMA400_I2C
>  	tristate
>  	depends on BMA400
>  
> +config BMA400_SPI
> +	tristate
> +	depends on BMA400
> +
>  config BMC150_ACCEL
>  	tristate "Bosch BMC150 Accelerometer Driver"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 3a051cf37f40..4f6c1ebe13b0 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMA220) += bma220_spi.o
>  obj-$(CONFIG_BMA400) += bma400_core.o
>  obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
> +obj-$(CONFIG_BMA400_SPI) += bma400_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
> new file mode 100644
> index 000000000000..7c2825904e08
> --- /dev/null
> +++ b/drivers/iio/accel/bma400_spi.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI IIO driver for Bosch BMA400 triaxial acceleration sensor.
> + *
> + * Copyright 2020 Dan Robertson <dan@dlrobertson.com>
> + *
> + */
> +#include <linux/bits.h>
> +#include <linux/init.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "bma400.h"
> +
> +#define BMA400_MAX_SPI_READ 2
> +#define BMA400_SPI_READ_BUFFER_SIZE (BMA400_MAX_SPI_READ + 1)
> +
> +static int bma400_regmap_spi_read(void *context,
> +				  const void *reg, size_t reg_size,
> +				  void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	u8 result[BMA400_SPI_READ_BUFFER_SIZE];
> +	ssize_t status;
> +
> +	if (val_size > BMA400_MAX_SPI_READ)
> +		return -EINVAL;
> +
> +	status = spi_write_then_read(spi, reg, 1, result, val_size + 1);

There is a double memcpy going on here.  spi_write_then_read is using it's
own internal buffers which we then copy into result and then recopy
below into val.

How about we cheat and pad the write side by one extra byte of 0s?
That way we can pass val in directly for the read and only copy this buffer
once. 

It will only help in cases where we are reading more than one byte (as
still involves a copy) but I think the bma400 core does some bulk reads.


> +	if (status)
> +		return status;
> +
> +	/*
> +	 * From the BMA400 datasheet:
> +	 *
> +	 * > For a basic read operation two bytes have to be read and the first
> +	 * > has to be dropped and the second byte must be interpreted.
> +	 */
> +	memcpy(val, result + 1, val_size);
> +
> +	return 0;
> +}
> +
> +static int bma400_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +
> +	return spi_write(spi, data, count);
> +}
> +
> +static struct regmap_bus bma400_regmap_bus = {
> +	.read = bma400_regmap_spi_read,
> +	.write = bma400_regmap_spi_write,
> +	.read_flag_mask = BIT(7),
> +	.max_raw_read = BMA400_MAX_SPI_READ,
> +};
> +
> +static int bma400_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct regmap *regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	regmap = devm_regmap_init(&spi->dev, &bma400_regmap_bus,
> +				  &spi->dev, &bma400_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "failed to create regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	/*
> +	 * Per the bma400 datasheet, the first SPI read may
> +	 * return garbage. As the datasheet recommends, the
> +	 * chip ID register will be read here and checked
> +	 * again in the following probe.
> +	 */
> +	ret = regmap_read(regmap, BMA400_CHIP_ID_REG, &val);
> +	if (ret)
> +		dev_err(&spi->dev, "Failed to read chip id register\n");
> +
> +	return bma400_probe(&spi->dev, regmap, id->name);
> +}
> +
> +static int bma400_spi_remove(struct spi_device *spi)
> +{
> +	return bma400_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id bma400_spi_ids[] = {
> +	{ "bma400", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, bma400_spi_ids);
> +
> +static const struct of_device_id bma400_of_spi_match[] = {
> +	{ .compatible = "bosch,bma400" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bma400_of_spi_match);
> +
> +static struct spi_driver bma400_spi_driver = {
> +	.driver = {
> +		.name = "bma400",
> +		.of_match_table = bma400_of_spi_match,
> +	},
> +	.probe    = bma400_spi_probe,
> +	.remove   = bma400_spi_remove,
> +	.id_table = bma400_spi_ids,
> +};
> +
> +module_spi_driver(bma400_spi_driver);
> +MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
> +MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor (SPI)");
> +MODULE_LICENSE("GPL");
> 

