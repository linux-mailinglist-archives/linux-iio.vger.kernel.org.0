Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5179B68B06F
	for <lists+linux-iio@lfdr.de>; Sun,  5 Feb 2023 15:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBEO4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Feb 2023 09:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBEO4B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 09:56:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D57BBA4
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 06:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EEAA60BD8
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 14:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F303C433EF;
        Sun,  5 Feb 2023 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675608955;
        bh=2y9fI699HRsVQpucZZtRI0mb9GnrN06oIeakUEzTQNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=exJUwXfhQW0EQg6F4H6P7mb28/1joyN+gWzmuTKYEpozTVwnG0x7KMBdZQMILwPpg
         mvoYftPp7W/ALsX8R/flb46IZX+Sa47aF7xIQVB7l7iDC/ahcy7NhhXTevqU5atKrh
         6+w/K8lX91g7LfbM5uUzFiaSFX1MIV0KI4d8lOW5902zGQ32Ip107Ma3bKe6sGP+9i
         XvrHRoQB6+W+EBH0kH5UVXvxqc32i530cDzeZxDDwKfv6t4HqcSziX444qwgELQ6AS
         tmBGtfX9B8xwhAP5qiamPVWjOh5Tt1QUeLAsQDbdGK5WKcZdqOlfna5XZRYe0WGxFJ
         z5HrgBwTb0VEg==
Date:   Sun, 5 Feb 2023 15:09:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] staging: iio: meter: Drop ade7854 driver
Message-ID: <20230205150956.09bb8e6d@jic23-huawei>
In-Reply-To: <20230129160805.747745-1-jic23@kernel.org>
References: <20230129160805.747745-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Jan 2023 16:08:05 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver is so far from making correct use of the IIO infrastructure
> and ABI that if someone wanted to make the driver suitable for moving
> out of staging, they would more or less be starting from scratch.
> 
> As such there is little point in keeping the existing code in staging.
> 
> Note this was only user of the meter.h header so that is dropped.
> There are no other drivers in the staging/iio/meter directory so drop
> the build system files as well.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Ping. 

If I don't hear any one speaking out in favour of keeping this driver
I'll drop it - probably early in next cycle.

Not really expecting review for a driver drop :)

Jonathan

> ---
>  drivers/staging/iio/Kconfig             |   1 -
>  drivers/staging/iio/Makefile            |   1 -
>  drivers/staging/iio/meter/Kconfig       |  37 --
>  drivers/staging/iio/meter/Makefile      |   8 -
>  drivers/staging/iio/meter/ade7854-i2c.c | 153 -------
>  drivers/staging/iio/meter/ade7854-spi.c | 160 -------
>  drivers/staging/iio/meter/ade7854.c     | 556 ------------------------
>  drivers/staging/iio/meter/ade7854.h     | 173 --------
>  drivers/staging/iio/meter/meter.h       | 398 -----------------
>  9 files changed, 1487 deletions(-)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index afd05bf3345e..d3968fe2ebb8 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -10,7 +10,6 @@ source "drivers/staging/iio/adc/Kconfig"
>  source "drivers/staging/iio/addac/Kconfig"
>  source "drivers/staging/iio/frequency/Kconfig"
>  source "drivers/staging/iio/impedance-analyzer/Kconfig"
> -source "drivers/staging/iio/meter/Kconfig"
>  source "drivers/staging/iio/resolver/Kconfig"
>  
>  endmenu
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index 5ed56fe57e14..c50f1019f829 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -8,5 +8,4 @@ obj-y += adc/
>  obj-y += addac/
>  obj-y += frequency/
>  obj-y += impedance-analyzer/
> -obj-y += meter/
>  obj-y += resolver/
> diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
> deleted file mode 100644
> index aa6a3e7f6cdb..000000000000
> --- a/drivers/staging/iio/meter/Kconfig
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# IIO meter drivers configuration
> -#
> -menu "Active energy metering IC"
> -
> -config ADE7854
> -	tristate "Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver"
> -	depends on SPI || I2C
> -	help
> -	  Say yes here to build support for Analog Devices ADE7854/58/68/78 Polyphase
> -	  Multifunction Energy Metering IC Driver.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ade7854.
> -
> -config ADE7854_I2C
> -	tristate "support I2C bus connection"
> -	depends on ADE7854 && I2C
> -	default y
> -	help
> -	  Say Y here if you have ADE7854/58/68/78 hooked to an I2C bus.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ade7854-i2c.
> -
> -config ADE7854_SPI
> -	tristate "support SPI bus connection"
> -	depends on ADE7854 && SPI
> -	default y
> -	help
> -	  Say Y here if you have ADE7854/58/68/78 hooked to a SPI bus.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ade7854-spi.
> -
> -endmenu
> diff --git a/drivers/staging/iio/meter/Makefile b/drivers/staging/iio/meter/Makefile
> deleted file mode 100644
> index ed4547e38f3a..000000000000
> --- a/drivers/staging/iio/meter/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile for metering ic drivers
> -#
> -
> -obj-$(CONFIG_ADE7854) += ade7854.o
> -obj-$(CONFIG_ADE7854_I2C) += ade7854-i2c.o
> -obj-$(CONFIG_ADE7854_SPI) += ade7854-spi.o
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> deleted file mode 100644
> index 572d714eb0dd..000000000000
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ /dev/null
> @@ -1,153 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver (I2C Bus)
> - *
> - * Copyright 2010 Analog Devices Inc.
> - */
> -
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/i2c.h>
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -
> -#include <linux/iio/iio.h>
> -#include "ade7854.h"
> -
> -static int ade7854_i2c_write_reg(struct device *dev,
> -				 u16 reg_address,
> -				 u32 val,
> -				 int bits)
> -{
> -	int ret;
> -	int count;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -
> -	switch (bits) {
> -	case 8:
> -		st->tx[2] = val & 0xFF;
> -		count = 3;
> -		break;
> -	case 16:
> -		st->tx[2] = (val >> 8) & 0xFF;
> -		st->tx[3] = val & 0xFF;
> -		count = 4;
> -		break;
> -	case 24:
> -		st->tx[2] = (val >> 16) & 0xFF;
> -		st->tx[3] = (val >> 8) & 0xFF;
> -		st->tx[4] = val & 0xFF;
> -		count = 5;
> -		break;
> -	case 32:
> -		st->tx[2] = (val >> 24) & 0xFF;
> -		st->tx[3] = (val >> 16) & 0xFF;
> -		st->tx[4] = (val >> 8) & 0xFF;
> -		st->tx[5] = val & 0xFF;
> -		count = 6;
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
> -
> -	ret = i2c_master_send(st->i2c, st->tx, count);
> -
> -unlock:
> -	mutex_unlock(&st->buf_lock);
> -
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static int ade7854_i2c_read_reg(struct device *dev,
> -				u16 reg_address,
> -				u32 *val,
> -				int bits)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret < 0)
> -		goto unlock;
> -
> -	ret = i2c_master_recv(st->i2c, st->rx, bits);
> -	if (ret < 0)
> -		goto unlock;
> -
> -	switch (bits) {
> -	case 8:
> -		*val = st->rx[0];
> -		break;
> -	case 16:
> -		*val = (st->rx[0] << 8) | st->rx[1];
> -		break;
> -	case 24:
> -		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> -		break;
> -	case 32:
> -		*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> -			(st->rx[2] << 8) | st->rx[3];
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
> -
> -unlock:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> -}
> -
> -static int ade7854_i2c_probe(struct i2c_client *client)
> -{
> -	struct ade7854_state *st;
> -	struct iio_dev *indio_dev;
> -
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -	st = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
> -	st->read_reg = ade7854_i2c_read_reg;
> -	st->write_reg = ade7854_i2c_write_reg;
> -	st->i2c = client;
> -	st->irq = client->irq;
> -
> -	return ade7854_probe(indio_dev, &client->dev);
> -}
> -
> -static const struct i2c_device_id ade7854_id[] = {
> -	{ "ade7854", 0 },
> -	{ "ade7858", 0 },
> -	{ "ade7868", 0 },
> -	{ "ade7878", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, ade7854_id);
> -
> -static struct i2c_driver ade7854_i2c_driver = {
> -	.driver = {
> -		.name = "ade7854",
> -	},
> -	.probe_new = ade7854_i2c_probe,
> -	.id_table = ade7854_id,
> -};
> -module_i2c_driver(ade7854_i2c_driver);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC I2C Driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> deleted file mode 100644
> index f12a6c8b3e88..000000000000
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ /dev/null
> @@ -1,160 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver (SPI Bus)
> - *
> - * Copyright 2010 Analog Devices Inc.
> - */
> -
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -
> -#include <linux/iio/iio.h>
> -#include "ade7854.h"
> -
> -static int ade7854_spi_write_reg(struct device *dev,
> -				 u16 reg_address,
> -				 u32 val,
> -				 int bits)
> -{
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.bits_per_word = 8,
> -		.len = 4,
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_WRITE_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -	switch (bits) {
> -	case 8:
> -		st->tx[3] = val & 0xFF;
> -		break;
> -	case 16:
> -		xfer.len = 5;
> -		st->tx[3] = (val >> 8) & 0xFF;
> -		st->tx[4] = val & 0xFF;
> -		break;
> -	case 24:
> -		xfer.len = 6;
> -		st->tx[3] = (val >> 16) & 0xFF;
> -		st->tx[4] = (val >> 8) & 0xFF;
> -		st->tx[5] = val & 0xFF;
> -		break;
> -	case 32:
> -		xfer.len = 7;
> -		st->tx[3] = (val >> 24) & 0xFF;
> -		st->tx[4] = (val >> 16) & 0xFF;
> -		st->tx[5] = (val >> 8) & 0xFF;
> -		st->tx[6] = val & 0xFF;
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
> -
> -	ret = spi_sync_transfer(st->spi, &xfer, 1);
> -unlock:
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> -}
> -
> -static int ade7854_spi_read_reg(struct device *dev,
> -				u16 reg_address,
> -				u32 *val,
> -				int bits)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}, {
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = bits,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -
> -	st->tx[0] = ADE7854_READ_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret < 0) {
> -		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
> -			reg_address);
> -		goto unlock;
> -	}
> -
> -	switch (bits) {
> -	case 8:
> -		*val = st->rx[0];
> -		break;
> -	case 16:
> -		*val = be16_to_cpup((const __be16 *)st->rx);
> -		break;
> -	case 24:
> -		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> -		break;
> -	case 32:
> -		*val = be32_to_cpup((const __be32 *)st->rx);
> -		break;
> -	}
> -
> -unlock:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> -}
> -
> -static int ade7854_spi_probe(struct spi_device *spi)
> -{
> -	struct ade7854_state *st;
> -	struct iio_dev *indio_dev;
> -
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
> -	st->read_reg = ade7854_spi_read_reg;
> -	st->write_reg = ade7854_spi_write_reg;
> -	st->irq = spi->irq;
> -	st->spi = spi;
> -
> -	return ade7854_probe(indio_dev, &spi->dev);
> -}
> -
> -static const struct spi_device_id ade7854_id[] = {
> -	{ "ade7854", 0 },
> -	{ "ade7858", 0 },
> -	{ "ade7868", 0 },
> -	{ "ade7878", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(spi, ade7854_id);
> -
> -static struct spi_driver ade7854_driver = {
> -	.driver = {
> -		.name = "ade7854",
> -	},
> -	.probe = ade7854_spi_probe,
> -	.id_table = ade7854_id,
> -};
> -module_spi_driver(ade7854_driver);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 SPI Driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> deleted file mode 100644
> index 68da6ecde6a3..000000000000
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ /dev/null
> @@ -1,556 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver
> - *
> - * Copyright 2010 Analog Devices Inc.
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/delay.h>
> -#include <linux/mutex.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include "meter.h"
> -#include "ade7854.h"
> -
> -static ssize_t ade7854_read_8bit(struct device *dev,
> -				 struct device_attribute *attr,
> -				 char *buf)
> -{
> -	int ret;
> -	u32 val = 0;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	ret = st->read_reg(dev, this_attr->address, &val, 8);
> -	if (ret < 0)
> -		return ret;
> -
> -	return sprintf(buf, "%u\n", val);
> -}
> -
> -static ssize_t ade7854_read_16bit(struct device *dev,
> -				  struct device_attribute *attr,
> -				  char *buf)
> -{
> -	int ret;
> -	u32 val = 0;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	ret = st->read_reg(dev, this_attr->address, &val, 16);
> -	if (ret < 0)
> -		return ret;
> -
> -	return sprintf(buf, "%u\n", val);
> -}
> -
> -static ssize_t ade7854_read_24bit(struct device *dev,
> -				  struct device_attribute *attr,
> -				  char *buf)
> -{
> -	int ret;
> -	u32 val;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	ret = st->read_reg(dev, this_attr->address, &val, 24);
> -	if (ret < 0)
> -		return ret;
> -
> -	return sprintf(buf, "%u\n", val);
> -}
> -
> -static ssize_t ade7854_read_32bit(struct device *dev,
> -				  struct device_attribute *attr,
> -				  char *buf)
> -{
> -	int ret;
> -	u32 val = 0;
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	ret = st->read_reg(dev, this_attr->address, &val, 32);
> -	if (ret < 0)
> -		return ret;
> -
> -	return sprintf(buf, "%u\n", val);
> -}
> -
> -static ssize_t ade7854_write_8bit(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf,
> -				  size_t len)
> -{
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	int ret;
> -	u8 val;
> -
> -	ret = kstrtou8(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
> -	ret = st->write_reg(dev, this_attr->address, val, 8);
> -
> -error_ret:
> -	return ret ? ret : len;
> -}
> -
> -static ssize_t ade7854_write_16bit(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf,
> -				   size_t len)
> -{
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	int ret;
> -	u16 val;
> -
> -	ret = kstrtou16(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
> -	ret = st->write_reg(dev, this_attr->address, val, 16);
> -
> -error_ret:
> -	return ret ? ret : len;
> -}
> -
> -static ssize_t ade7854_write_24bit(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf,
> -				   size_t len)
> -{
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	int ret;
> -	u32 val;
> -
> -	ret = kstrtou32(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
> -	ret = st->write_reg(dev, this_attr->address, val, 24);
> -
> -error_ret:
> -	return ret ? ret : len;
> -}
> -
> -static ssize_t ade7854_write_32bit(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf,
> -				   size_t len)
> -{
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	int ret;
> -	u32 val;
> -
> -	ret = kstrtou32(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
> -	ret = st->write_reg(dev, this_attr->address, val, 32);
> -
> -error_ret:
> -	return ret ? ret : len;
> -}
> -
> -static int ade7854_reset(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	u32 val;
> -
> -	st->read_reg(dev, ADE7854_CONFIG, &val, 16);
> -	val |= BIT(7); /* Software Chip Reset */
> -
> -	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
> -}
> -
> -static IIO_DEV_ATTR_AIGAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_AIGAIN);
> -static IIO_DEV_ATTR_BIGAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_BIGAIN);
> -static IIO_DEV_ATTR_CIGAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_CIGAIN);
> -static IIO_DEV_ATTR_NIGAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_NIGAIN);
> -static IIO_DEV_ATTR_AVGAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_AVGAIN);
> -static IIO_DEV_ATTR_BVGAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_BVGAIN);
> -static IIO_DEV_ATTR_CVGAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_CVGAIN);
> -static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_AVAGAIN);
> -static IIO_DEV_ATTR_APPARENT_POWER_B_GAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_BVAGAIN);
> -static IIO_DEV_ATTR_APPARENT_POWER_C_GAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_CVAGAIN);
> -static IIO_DEV_ATTR_ACTIVE_POWER_A_OFFSET(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_AWATTOS);
> -static IIO_DEV_ATTR_ACTIVE_POWER_B_OFFSET(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_BWATTOS);
> -static IIO_DEV_ATTR_ACTIVE_POWER_C_OFFSET(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_CWATTOS);
> -static IIO_DEV_ATTR_REACTIVE_POWER_A_GAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_AVARGAIN);
> -static IIO_DEV_ATTR_REACTIVE_POWER_B_GAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_BVARGAIN);
> -static IIO_DEV_ATTR_REACTIVE_POWER_C_GAIN(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_CVARGAIN);
> -static IIO_DEV_ATTR_REACTIVE_POWER_A_OFFSET(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_AVAROS);
> -static IIO_DEV_ATTR_REACTIVE_POWER_B_OFFSET(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_BVAROS);
> -static IIO_DEV_ATTR_REACTIVE_POWER_C_OFFSET(0644,
> -		ade7854_read_24bit,
> -		ade7854_write_24bit,
> -		ADE7854_CVAROS);
> -static IIO_DEV_ATTR_VPEAK(0644,
> -		ade7854_read_32bit,
> -		ade7854_write_32bit,
> -		ADE7854_VPEAK);
> -static IIO_DEV_ATTR_IPEAK(0644,
> -		ade7854_read_32bit,
> -		ade7854_write_32bit,
> -		ADE7854_IPEAK);
> -static IIO_DEV_ATTR_APHCAL(0644,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_APHCAL);
> -static IIO_DEV_ATTR_BPHCAL(0644,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_BPHCAL);
> -static IIO_DEV_ATTR_CPHCAL(0644,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_CPHCAL);
> -static IIO_DEV_ATTR_CF1DEN(0644,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_CF1DEN);
> -static IIO_DEV_ATTR_CF2DEN(0644,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_CF2DEN);
> -static IIO_DEV_ATTR_CF3DEN(0644,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_CF3DEN);
> -static IIO_DEV_ATTR_LINECYC(0644,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_LINECYC);
> -static IIO_DEV_ATTR_SAGCYC(0644,
> -		ade7854_read_8bit,
> -		ade7854_write_8bit,
> -		ADE7854_SAGCYC);
> -static IIO_DEV_ATTR_CFCYC(0644,
> -		ade7854_read_8bit,
> -		ade7854_write_8bit,
> -		ADE7854_CFCYC);
> -static IIO_DEV_ATTR_PEAKCYC(0644,
> -		ade7854_read_8bit,
> -		ade7854_write_8bit,
> -		ADE7854_PEAKCYC);
> -static IIO_DEV_ATTR_CHKSUM(ade7854_read_24bit,
> -		ADE7854_CHECKSUM);
> -static IIO_DEV_ATTR_ANGLE0(ade7854_read_24bit,
> -		ADE7854_ANGLE0);
> -static IIO_DEV_ATTR_ANGLE1(ade7854_read_24bit,
> -		ADE7854_ANGLE1);
> -static IIO_DEV_ATTR_ANGLE2(ade7854_read_24bit,
> -		ADE7854_ANGLE2);
> -static IIO_DEV_ATTR_AIRMS(0444,
> -		ade7854_read_24bit,
> -		NULL,
> -		ADE7854_AIRMS);
> -static IIO_DEV_ATTR_BIRMS(0444,
> -		ade7854_read_24bit,
> -		NULL,
> -		ADE7854_BIRMS);
> -static IIO_DEV_ATTR_CIRMS(0444,
> -		ade7854_read_24bit,
> -		NULL,
> -		ADE7854_CIRMS);
> -static IIO_DEV_ATTR_NIRMS(0444,
> -		ade7854_read_24bit,
> -		NULL,
> -		ADE7854_NIRMS);
> -static IIO_DEV_ATTR_AVRMS(0444,
> -		ade7854_read_24bit,
> -		NULL,
> -		ADE7854_AVRMS);
> -static IIO_DEV_ATTR_BVRMS(0444,
> -		ade7854_read_24bit,
> -		NULL,
> -		ADE7854_BVRMS);
> -static IIO_DEV_ATTR_CVRMS(0444,
> -		ade7854_read_24bit,
> -		NULL,
> -		ADE7854_CVRMS);
> -static IIO_DEV_ATTR_AIRMSOS(0444,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_AIRMSOS);
> -static IIO_DEV_ATTR_BIRMSOS(0444,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_BIRMSOS);
> -static IIO_DEV_ATTR_CIRMSOS(0444,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_CIRMSOS);
> -static IIO_DEV_ATTR_AVRMSOS(0444,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_AVRMSOS);
> -static IIO_DEV_ATTR_BVRMSOS(0444,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_BVRMSOS);
> -static IIO_DEV_ATTR_CVRMSOS(0444,
> -		ade7854_read_16bit,
> -		ade7854_write_16bit,
> -		ADE7854_CVRMSOS);
> -static IIO_DEV_ATTR_VOLT_A(ade7854_read_24bit,
> -		ADE7854_VAWV);
> -static IIO_DEV_ATTR_VOLT_B(ade7854_read_24bit,
> -		ADE7854_VBWV);
> -static IIO_DEV_ATTR_VOLT_C(ade7854_read_24bit,
> -		ADE7854_VCWV);
> -static IIO_DEV_ATTR_CURRENT_A(ade7854_read_24bit,
> -		ADE7854_IAWV);
> -static IIO_DEV_ATTR_CURRENT_B(ade7854_read_24bit,
> -		ADE7854_IBWV);
> -static IIO_DEV_ATTR_CURRENT_C(ade7854_read_24bit,
> -		ADE7854_ICWV);
> -static IIO_DEV_ATTR_AWATTHR(ade7854_read_32bit,
> -		ADE7854_AWATTHR);
> -static IIO_DEV_ATTR_BWATTHR(ade7854_read_32bit,
> -		ADE7854_BWATTHR);
> -static IIO_DEV_ATTR_CWATTHR(ade7854_read_32bit,
> -		ADE7854_CWATTHR);
> -static IIO_DEV_ATTR_AFWATTHR(ade7854_read_32bit,
> -		ADE7854_AFWATTHR);
> -static IIO_DEV_ATTR_BFWATTHR(ade7854_read_32bit,
> -		ADE7854_BFWATTHR);
> -static IIO_DEV_ATTR_CFWATTHR(ade7854_read_32bit,
> -		ADE7854_CFWATTHR);
> -static IIO_DEV_ATTR_AVARHR(ade7854_read_32bit,
> -		ADE7854_AVARHR);
> -static IIO_DEV_ATTR_BVARHR(ade7854_read_32bit,
> -		ADE7854_BVARHR);
> -static IIO_DEV_ATTR_CVARHR(ade7854_read_32bit,
> -		ADE7854_CVARHR);
> -static IIO_DEV_ATTR_AVAHR(ade7854_read_32bit,
> -		ADE7854_AVAHR);
> -static IIO_DEV_ATTR_BVAHR(ade7854_read_32bit,
> -		ADE7854_BVAHR);
> -static IIO_DEV_ATTR_CVAHR(ade7854_read_32bit,
> -		ADE7854_CVAHR);
> -
> -static int ade7854_set_irq(struct device *dev, bool enable)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	int ret;
> -	u32 irqen;
> -
> -	ret = st->read_reg(dev, ADE7854_MASK0, &irqen, 32);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (enable)
> -		irqen |= BIT(17); /* 1: interrupt enabled when all periodical
> -				   * (at 8 kHz rate) DSP computations finish.
> -				   */
> -	else
> -		irqen &= ~BIT(17);
> -
> -	return st->write_reg(dev, ADE7854_MASK0, irqen, 32);
> -}
> -
> -static int ade7854_initial_setup(struct iio_dev *indio_dev)
> -{
> -	int ret;
> -	struct device *dev = &indio_dev->dev;
> -
> -	/* Disable IRQ */
> -	ret = ade7854_set_irq(dev, false);
> -	if (ret) {
> -		dev_err(dev, "disable irq failed");
> -		goto err_ret;
> -	}
> -
> -	ade7854_reset(dev);
> -	usleep_range(ADE7854_STARTUP_DELAY, ADE7854_STARTUP_DELAY + 100);
> -
> -err_ret:
> -	return ret;
> -}
> -
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
> -
> -static IIO_CONST_ATTR(name, "ade7854");
> -
> -static struct attribute *ade7854_attributes[] = {
> -	&iio_dev_attr_aigain.dev_attr.attr,
> -	&iio_dev_attr_bigain.dev_attr.attr,
> -	&iio_dev_attr_cigain.dev_attr.attr,
> -	&iio_dev_attr_nigain.dev_attr.attr,
> -	&iio_dev_attr_avgain.dev_attr.attr,
> -	&iio_dev_attr_bvgain.dev_attr.attr,
> -	&iio_dev_attr_cvgain.dev_attr.attr,
> -	&iio_dev_attr_linecyc.dev_attr.attr,
> -	&iio_dev_attr_sagcyc.dev_attr.attr,
> -	&iio_dev_attr_cfcyc.dev_attr.attr,
> -	&iio_dev_attr_peakcyc.dev_attr.attr,
> -	&iio_dev_attr_chksum.dev_attr.attr,
> -	&iio_dev_attr_apparent_power_a_gain.dev_attr.attr,
> -	&iio_dev_attr_apparent_power_b_gain.dev_attr.attr,
> -	&iio_dev_attr_apparent_power_c_gain.dev_attr.attr,
> -	&iio_dev_attr_active_power_a_offset.dev_attr.attr,
> -	&iio_dev_attr_active_power_b_offset.dev_attr.attr,
> -	&iio_dev_attr_active_power_c_offset.dev_attr.attr,
> -	&iio_dev_attr_reactive_power_a_gain.dev_attr.attr,
> -	&iio_dev_attr_reactive_power_b_gain.dev_attr.attr,
> -	&iio_dev_attr_reactive_power_c_gain.dev_attr.attr,
> -	&iio_dev_attr_reactive_power_a_offset.dev_attr.attr,
> -	&iio_dev_attr_reactive_power_b_offset.dev_attr.attr,
> -	&iio_dev_attr_reactive_power_c_offset.dev_attr.attr,
> -	&iio_dev_attr_awatthr.dev_attr.attr,
> -	&iio_dev_attr_bwatthr.dev_attr.attr,
> -	&iio_dev_attr_cwatthr.dev_attr.attr,
> -	&iio_dev_attr_afwatthr.dev_attr.attr,
> -	&iio_dev_attr_bfwatthr.dev_attr.attr,
> -	&iio_dev_attr_cfwatthr.dev_attr.attr,
> -	&iio_dev_attr_avarhr.dev_attr.attr,
> -	&iio_dev_attr_bvarhr.dev_attr.attr,
> -	&iio_dev_attr_cvarhr.dev_attr.attr,
> -	&iio_dev_attr_angle0.dev_attr.attr,
> -	&iio_dev_attr_angle1.dev_attr.attr,
> -	&iio_dev_attr_angle2.dev_attr.attr,
> -	&iio_dev_attr_avahr.dev_attr.attr,
> -	&iio_dev_attr_bvahr.dev_attr.attr,
> -	&iio_dev_attr_cvahr.dev_attr.attr,
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> -	&iio_const_attr_name.dev_attr.attr,
> -	&iio_dev_attr_vpeak.dev_attr.attr,
> -	&iio_dev_attr_ipeak.dev_attr.attr,
> -	&iio_dev_attr_aphcal.dev_attr.attr,
> -	&iio_dev_attr_bphcal.dev_attr.attr,
> -	&iio_dev_attr_cphcal.dev_attr.attr,
> -	&iio_dev_attr_cf1den.dev_attr.attr,
> -	&iio_dev_attr_cf2den.dev_attr.attr,
> -	&iio_dev_attr_cf3den.dev_attr.attr,
> -	&iio_dev_attr_airms.dev_attr.attr,
> -	&iio_dev_attr_birms.dev_attr.attr,
> -	&iio_dev_attr_cirms.dev_attr.attr,
> -	&iio_dev_attr_nirms.dev_attr.attr,
> -	&iio_dev_attr_avrms.dev_attr.attr,
> -	&iio_dev_attr_bvrms.dev_attr.attr,
> -	&iio_dev_attr_cvrms.dev_attr.attr,
> -	&iio_dev_attr_airmsos.dev_attr.attr,
> -	&iio_dev_attr_birmsos.dev_attr.attr,
> -	&iio_dev_attr_cirmsos.dev_attr.attr,
> -	&iio_dev_attr_avrmsos.dev_attr.attr,
> -	&iio_dev_attr_bvrmsos.dev_attr.attr,
> -	&iio_dev_attr_cvrmsos.dev_attr.attr,
> -	&iio_dev_attr_volt_a.dev_attr.attr,
> -	&iio_dev_attr_volt_b.dev_attr.attr,
> -	&iio_dev_attr_volt_c.dev_attr.attr,
> -	&iio_dev_attr_current_a.dev_attr.attr,
> -	&iio_dev_attr_current_b.dev_attr.attr,
> -	&iio_dev_attr_current_c.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ade7854_attribute_group = {
> -	.attrs = ade7854_attributes,
> -};
> -
> -static const struct iio_info ade7854_info = {
> -	.attrs = &ade7854_attribute_group,
> -};
> -
> -int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
> -{
> -	int ret;
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	/* setup the industrialio driver allocated elements */
> -	mutex_init(&st->buf_lock);
> -
> -	indio_dev->dev.parent = dev;
> -	indio_dev->info = &ade7854_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -
> -	ret = devm_iio_device_register(dev, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	/* Get the device into a sane initial state */
> -	return ade7854_initial_setup(indio_dev);
> -}
> -EXPORT_SYMBOL(ade7854_probe);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 Polyphase Energy Meter");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> deleted file mode 100644
> index 7a49f8f1016f..000000000000
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ /dev/null
> @@ -1,173 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ADE7854_H
> -#define _ADE7854_H
> -
> -#define ADE7854_AIGAIN    0x4380
> -#define ADE7854_AVGAIN    0x4381
> -#define ADE7854_BIGAIN    0x4382
> -#define ADE7854_BVGAIN    0x4383
> -#define ADE7854_CIGAIN    0x4384
> -#define ADE7854_CVGAIN    0x4385
> -#define ADE7854_NIGAIN    0x4386
> -#define ADE7854_AIRMSOS   0x4387
> -#define ADE7854_AVRMSOS   0x4388
> -#define ADE7854_BIRMSOS   0x4389
> -#define ADE7854_BVRMSOS   0x438A
> -#define ADE7854_CIRMSOS   0x438B
> -#define ADE7854_CVRMSOS   0x438C
> -#define ADE7854_NIRMSOS   0x438D
> -#define ADE7854_AVAGAIN   0x438E
> -#define ADE7854_BVAGAIN   0x438F
> -#define ADE7854_CVAGAIN   0x4390
> -#define ADE7854_AWGAIN    0x4391
> -#define ADE7854_AWATTOS   0x4392
> -#define ADE7854_BWGAIN    0x4393
> -#define ADE7854_BWATTOS   0x4394
> -#define ADE7854_CWGAIN    0x4395
> -#define ADE7854_CWATTOS   0x4396
> -#define ADE7854_AVARGAIN  0x4397
> -#define ADE7854_AVAROS    0x4398
> -#define ADE7854_BVARGAIN  0x4399
> -#define ADE7854_BVAROS    0x439A
> -#define ADE7854_CVARGAIN  0x439B
> -#define ADE7854_CVAROS    0x439C
> -#define ADE7854_AFWGAIN   0x439D
> -#define ADE7854_AFWATTOS  0x439E
> -#define ADE7854_BFWGAIN   0x439F
> -#define ADE7854_BFWATTOS  0x43A0
> -#define ADE7854_CFWGAIN   0x43A1
> -#define ADE7854_CFWATTOS  0x43A2
> -#define ADE7854_AFVARGAIN 0x43A3
> -#define ADE7854_AFVAROS   0x43A4
> -#define ADE7854_BFVARGAIN 0x43A5
> -#define ADE7854_BFVAROS   0x43A6
> -#define ADE7854_CFVARGAIN 0x43A7
> -#define ADE7854_CFVAROS   0x43A8
> -#define ADE7854_VATHR1    0x43A9
> -#define ADE7854_VATHR0    0x43AA
> -#define ADE7854_WTHR1     0x43AB
> -#define ADE7854_WTHR0     0x43AC
> -#define ADE7854_VARTHR1   0x43AD
> -#define ADE7854_VARTHR0   0x43AE
> -#define ADE7854_RSV       0x43AF
> -#define ADE7854_VANOLOAD  0x43B0
> -#define ADE7854_APNOLOAD  0x43B1
> -#define ADE7854_VARNOLOAD 0x43B2
> -#define ADE7854_VLEVEL    0x43B3
> -#define ADE7854_DICOEFF   0x43B5
> -#define ADE7854_HPFDIS    0x43B6
> -#define ADE7854_ISUMLVL   0x43B8
> -#define ADE7854_ISUM      0x43BF
> -#define ADE7854_AIRMS     0x43C0
> -#define ADE7854_AVRMS     0x43C1
> -#define ADE7854_BIRMS     0x43C2
> -#define ADE7854_BVRMS     0x43C3
> -#define ADE7854_CIRMS     0x43C4
> -#define ADE7854_CVRMS     0x43C5
> -#define ADE7854_NIRMS     0x43C6
> -#define ADE7854_RUN       0xE228
> -#define ADE7854_AWATTHR   0xE400
> -#define ADE7854_BWATTHR   0xE401
> -#define ADE7854_CWATTHR   0xE402
> -#define ADE7854_AFWATTHR  0xE403
> -#define ADE7854_BFWATTHR  0xE404
> -#define ADE7854_CFWATTHR  0xE405
> -#define ADE7854_AVARHR    0xE406
> -#define ADE7854_BVARHR    0xE407
> -#define ADE7854_CVARHR    0xE408
> -#define ADE7854_AFVARHR   0xE409
> -#define ADE7854_BFVARHR   0xE40A
> -#define ADE7854_CFVARHR   0xE40B
> -#define ADE7854_AVAHR     0xE40C
> -#define ADE7854_BVAHR     0xE40D
> -#define ADE7854_CVAHR     0xE40E
> -#define ADE7854_IPEAK     0xE500
> -#define ADE7854_VPEAK     0xE501
> -#define ADE7854_STATUS0   0xE502
> -#define ADE7854_STATUS1   0xE503
> -#define ADE7854_OILVL     0xE507
> -#define ADE7854_OVLVL     0xE508
> -#define ADE7854_SAGLVL    0xE509
> -#define ADE7854_MASK0     0xE50A
> -#define ADE7854_MASK1     0xE50B
> -#define ADE7854_IAWV      0xE50C
> -#define ADE7854_IBWV      0xE50D
> -#define ADE7854_ICWV      0xE50E
> -#define ADE7854_VAWV      0xE510
> -#define ADE7854_VBWV      0xE511
> -#define ADE7854_VCWV      0xE512
> -#define ADE7854_AWATT     0xE513
> -#define ADE7854_BWATT     0xE514
> -#define ADE7854_CWATT     0xE515
> -#define ADE7854_AVA       0xE519
> -#define ADE7854_BVA       0xE51A
> -#define ADE7854_CVA       0xE51B
> -#define ADE7854_CHECKSUM  0xE51F
> -#define ADE7854_VNOM      0xE520
> -#define ADE7854_PHSTATUS  0xE600
> -#define ADE7854_ANGLE0    0xE601
> -#define ADE7854_ANGLE1    0xE602
> -#define ADE7854_ANGLE2    0xE603
> -#define ADE7854_PERIOD    0xE607
> -#define ADE7854_PHNOLOAD  0xE608
> -#define ADE7854_LINECYC   0xE60C
> -#define ADE7854_ZXTOUT    0xE60D
> -#define ADE7854_COMPMODE  0xE60E
> -#define ADE7854_GAIN      0xE60F
> -#define ADE7854_CFMODE    0xE610
> -#define ADE7854_CF1DEN    0xE611
> -#define ADE7854_CF2DEN    0xE612
> -#define ADE7854_CF3DEN    0xE613
> -#define ADE7854_APHCAL    0xE614
> -#define ADE7854_BPHCAL    0xE615
> -#define ADE7854_CPHCAL    0xE616
> -#define ADE7854_PHSIGN    0xE617
> -#define ADE7854_CONFIG    0xE618
> -#define ADE7854_MMODE     0xE700
> -#define ADE7854_ACCMODE   0xE701
> -#define ADE7854_LCYCMODE  0xE702
> -#define ADE7854_PEAKCYC   0xE703
> -#define ADE7854_SAGCYC    0xE704
> -#define ADE7854_CFCYC     0xE705
> -#define ADE7854_HSDC_CFG  0xE706
> -#define ADE7854_CONFIG2   0xEC01
> -
> -#define ADE7854_READ_REG   0x1
> -#define ADE7854_WRITE_REG  0x0
> -
> -#define ADE7854_MAX_TX    7
> -#define ADE7854_MAX_RX    7
> -#define ADE7854_STARTUP_DELAY 1000
> -
> -#define ADE7854_SPI_SLOW	(u32)(300 * 1000)
> -#define ADE7854_SPI_BURST	(u32)(1000 * 1000)
> -#define ADE7854_SPI_FAST	(u32)(2000 * 1000)
> -
> -/**
> - * struct ade7854_state - device instance specific data
> - * @spi:		actual spi_device
> - * @read_reg		Wrapper function for I2C and SPI read
> - * @write_reg		Wrapper function for I2C and SPI write
> - * @indio_dev:		industrial I/O device structure
> - * @buf_lock:		mutex to protect tx and rx
> - * @tx:			transmit buffer
> - * @rx:			receive buffer
> - **/
> -struct ade7854_state {
> -	struct spi_device *spi;
> -	struct i2c_client *i2c;
> -	int (*read_reg)(struct device *dev, u16 reg_address, u32 *val,
> -			int bits);
> -	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
> -			 int bits);
> -	int irq;
> -	struct mutex buf_lock;
> -	u8 tx[ADE7854_MAX_TX] __aligned(IIO_DMA_MINALIGN);
> -	u8 rx[ADE7854_MAX_RX];
> -
> -};
> -
> -int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
> -int ade7854_remove(struct iio_dev *indio_dev);
> -
> -#endif
> diff --git a/drivers/staging/iio/meter/meter.h b/drivers/staging/iio/meter/meter.h
> deleted file mode 100644
> index 5ed59bf30a25..000000000000
> --- a/drivers/staging/iio/meter/meter.h
> +++ /dev/null
> @@ -1,398 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _METER_H
> -#define _METER_H
> -
> -#include <linux/iio/sysfs.h>
> -
> -/* metering ic types of attribute */
> -
> -#define IIO_DEV_ATTR_CURRENT_A_OFFSET(_mode, _show, _store, _addr)	\
> -	IIO_DEVICE_ATTR(current_a_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CURRENT_B_OFFSET(_mode, _show, _store, _addr)	\
> -	IIO_DEVICE_ATTR(current_b_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CURRENT_C_OFFSET(_mode, _show, _store, _addr)	\
> -	IIO_DEVICE_ATTR(current_c_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VOLT_A_OFFSET(_mode, _show, _store, _addr)      \
> -	IIO_DEVICE_ATTR(volt_a_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VOLT_B_OFFSET(_mode, _show, _store, _addr)      \
> -	IIO_DEVICE_ATTR(volt_b_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VOLT_C_OFFSET(_mode, _show, _store, _addr)      \
> -	IIO_DEVICE_ATTR(volt_c_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_REACTIVE_POWER_A_OFFSET(_mode, _show, _store, _addr)   \
> -	IIO_DEVICE_ATTR(reactive_power_a_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_REACTIVE_POWER_B_OFFSET(_mode, _show, _store, _addr)   \
> -	IIO_DEVICE_ATTR(reactive_power_b_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_REACTIVE_POWER_C_OFFSET(_mode, _show, _store, _addr)   \
> -	IIO_DEVICE_ATTR(reactive_power_c_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_ACTIVE_POWER_A_OFFSET(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(active_power_a_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_ACTIVE_POWER_B_OFFSET(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(active_power_b_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_ACTIVE_POWER_C_OFFSET(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(active_power_c_offset, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CURRENT_A_GAIN(_mode, _show, _store, _addr)	\
> -	IIO_DEVICE_ATTR(current_a_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CURRENT_B_GAIN(_mode, _show, _store, _addr)	\
> -	IIO_DEVICE_ATTR(current_b_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CURRENT_C_GAIN(_mode, _show, _store, _addr)	\
> -	IIO_DEVICE_ATTR(current_c_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(apparent_power_a_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_APPARENT_POWER_B_GAIN(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(apparent_power_b_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_APPARENT_POWER_C_GAIN(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(apparent_power_c_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_ACTIVE_POWER_GAIN(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(active_power_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_ACTIVE_POWER_A_GAIN(_mode, _show, _store, _addr)   \
> -	IIO_DEVICE_ATTR(active_power_a_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_ACTIVE_POWER_B_GAIN(_mode, _show, _store, _addr)   \
> -	IIO_DEVICE_ATTR(active_power_b_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_ACTIVE_POWER_C_GAIN(_mode, _show, _store, _addr)   \
> -	IIO_DEVICE_ATTR(active_power_c_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_REACTIVE_POWER_A_GAIN(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(reactive_power_a_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_REACTIVE_POWER_B_GAIN(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(reactive_power_b_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_REACTIVE_POWER_C_GAIN(_mode, _show, _store, _addr)     \
> -	IIO_DEVICE_ATTR(reactive_power_c_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CURRENT_A(_show, _addr)			\
> -	IIO_DEVICE_ATTR(current_a, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_CURRENT_B(_show, _addr)			\
> -	IIO_DEVICE_ATTR(current_b, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_CURRENT_C(_show, _addr)			\
> -	IIO_DEVICE_ATTR(current_c, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_VOLT_A(_show, _addr)			\
> -	IIO_DEVICE_ATTR(volt_a, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_VOLT_B(_show, _addr)			\
> -	IIO_DEVICE_ATTR(volt_b, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_VOLT_C(_show, _addr)			\
> -	IIO_DEVICE_ATTR(volt_c, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_AENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(aenergy, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_LENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(lenergy, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_RAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(raenergy, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_LAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(laenergy, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_VAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(vaenergy, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_LVAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(lvaenergy, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_RVAENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(rvaenergy, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_LVARENERGY(_show, _addr)			\
> -	IIO_DEVICE_ATTR(lvarenergy, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_CHKSUM(_show, _addr)                       \
> -	IIO_DEVICE_ATTR(chksum, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_ANGLE0(_show, _addr)                       \
> -	IIO_DEVICE_ATTR(angle0, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_ANGLE1(_show, _addr)                       \
> -	IIO_DEVICE_ATTR(angle1, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_ANGLE2(_show, _addr)                       \
> -	IIO_DEVICE_ATTR(angle2, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_AWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(awatthr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_BWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(bwatthr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_CWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(cwatthr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_AFWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(afwatthr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_BFWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(bfwatthr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_CFWATTHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(cfwatthr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_AVARHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(avarhr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_BVARHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(bvarhr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_CVARHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(cvarhr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_AVAHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(avahr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_BVAHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(bvahr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_CVAHR(_show, _addr)			\
> -	IIO_DEVICE_ATTR(cvahr, 0444, _show, NULL, _addr)
> -
> -#define IIO_DEV_ATTR_IOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(ios, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(vos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_PHCAL(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(phcal, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_APHCAL(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(aphcal, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BPHCAL(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(bphcal, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CPHCAL(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cphcal, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_APOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(apos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_AAPOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(aapos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BAPOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(bapos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CAPOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(capos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_AVRMSGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(avrmsgain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BVRMSGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(bvrmsgain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CVRMSGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cvrmsgain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_AIGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(aigain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BIGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(bigain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CIGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cigain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_NIGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(nigain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_AVGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(avgain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BVGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(bvgain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CVGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cvgain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_WGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(wgain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_WDIV(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(wdiv, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CFNUM(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cfnum, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CFDEN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cfden, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CF1DEN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cf1den, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CF2DEN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cf2den, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CF3DEN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cf3den, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_IRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(irms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(vrms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_AIRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(airms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BIRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(birms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CIRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cirms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_NIRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(nirms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_AVRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(avrms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BVRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(bvrms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CVRMS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cvrms, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_IRMSOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(irmsos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VRMSOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(vrmsos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_AIRMSOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(airmsos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BIRMSOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(birmsos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CIRMSOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cirmsos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_AVRMSOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(avrmsos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_BVRMSOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(bvrmsos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CVRMSOS(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cvrmsos, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VAGAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(vagain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_PGA_GAIN(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(pga_gain, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VADIV(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(vadiv, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_LINECYC(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(linecyc, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_SAGCYC(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(sagcyc, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_CFCYC(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(cfcyc, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_PEAKCYC(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(peakcyc, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_SAGLVL(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(saglvl, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_IPKLVL(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(ipklvl, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VPKLVL(_mode, _show, _store, _addr)                \
> -	IIO_DEVICE_ATTR(vpklvl, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_IPEAK(_mode, _show, _store, _addr)			\
> -	IIO_DEVICE_ATTR(ipeak, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_RIPEAK(_mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(ripeak, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VPEAK(_mode, _show, _store, _addr)			\
> -	IIO_DEVICE_ATTR(vpeak, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_RVPEAK(_mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(rvpeak, _mode, _show, _store, _addr)
> -
> -#define IIO_DEV_ATTR_VPERIOD(_mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(vperiod, _mode, _show, _store, _addr)
> -
> -/* active energy register, AENERGY, is more than half full */
> -#define IIO_EVENT_ATTR_AENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(aenergy_half_full, _evlist, _show, _store, _mask)
> -
> -/* a SAG on the line voltage */
> -#define IIO_EVENT_ATTR_LINE_VOLT_SAG(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(line_volt_sag, _evlist, _show, _store, _mask)
> -
> -/*
> - * Indicates the end of energy accumulation over an integer number
> - * of half line cycles
> - */
> -#define IIO_EVENT_ATTR_CYCEND(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(cycend, _evlist, _show, _store, _mask)
> -
> -/* on the rising and falling edge of the voltage waveform */
> -#define IIO_EVENT_ATTR_ZERO_CROSS(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(zero_cross, _evlist, _show, _store, _mask)
> -
> -/* the active energy register has overflowed */
> -#define IIO_EVENT_ATTR_AENERGY_OVERFLOW(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(aenergy_overflow, _evlist, _show, _store, _mask)
> -
> -/* the apparent energy register has overflowed */
> -#define IIO_EVENT_ATTR_VAENERGY_OVERFLOW(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(vaenergy_overflow, _evlist, _show, _store, _mask)
> -
> -/* the active energy register, VAENERGY, is more than half full */
> -#define IIO_EVENT_ATTR_VAENERGY_HALF_FULL(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(vaenergy_half_full, _evlist, _show, _store, _mask)
> -
> -/* the power has gone from negative to positive */
> -#define IIO_EVENT_ATTR_PPOS(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(ppos, _evlist, _show, _store, _mask)
> -
> -/* the power has gone from positive to negative */
> -#define IIO_EVENT_ATTR_PNEG(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(pneg, _evlist, _show, _store, _mask)
> -
> -/* waveform sample from Channel 1 has exceeded the IPKLVL value */
> -#define IIO_EVENT_ATTR_IPKLVL_EXC(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(ipklvl_exc, _evlist, _show, _store, _mask)
> -
> -/* waveform sample from Channel 2 has exceeded the VPKLVL value */
> -#define IIO_EVENT_ATTR_VPKLVL_EXC(_evlist, _show, _store, _mask) \
> -	IIO_EVENT_ATTR_SH(vpklvl_exc, _evlist, _show, _store, _mask)
> -
> -#endif /* _METER_H */

