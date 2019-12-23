Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A627129982
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLWRmr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfLWRmq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:42:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8170B206CB;
        Mon, 23 Dec 2019 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577122965;
        bh=Iitq3LJy2/1IFe0OKEwqC55S0am7Q0nMkIQAtMkJk4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oBZCPtvFJQ1lPgNyaDJQFj5eKsaIMFB3ZHJbB71pwlBWu3w1+BM/D2kQPg6AGyvRt
         pvO07ksruF4N0x5aIoLTXFZpSZ6nepSZtNc0EDHRse6rZmfe7L9U6JN3DuenV8qWYb
         sh7VfRPAvc1pf3xsTmGyEJn0WHw7yGKBAubLAPI0=
Date:   Mon, 23 Dec 2019 17:42:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] iio: pressure: Add driver for DLH pressure
 sensors
Message-ID: <20191223174241.779856de@archlinux>
In-Reply-To: <20191211095946.7904-2-tomislav.denis@avl.com>
References: <20191211095946.7904-1-tomislav.denis@avl.com>
        <20191211095946.7904-2-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 10:59:44 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> All Sensors DLH is series of low voltage digital pressure sensors.
> Additionally to pressure value sensors deliver a temperature value.
> Sensors can be accessed over I2C and SPI, this driver supports
> only I2C access.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>

Gah. My explanation on the wildcard naming thing was not clear before.
Sorry about that.  What I meant was this needs to have an explicit
name after a single part number.   I've renamed
as dlhl60d.c and all similar places.
I left the define prefix as DLH_ as unlikely we'll get any problems
with that.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if they can break it.

Thanks,

Jonathan

> ---
>  MAINTAINERS                   |   7 +
>  drivers/iio/pressure/Kconfig  |  12 ++
>  drivers/iio/pressure/Makefile |   1 +
>  drivers/iio/pressure/dlh.c    | 375 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 395 insertions(+)
>  create mode 100644 drivers/iio/pressure/dlh.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5ea4e4..0fa24df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -668,6 +668,13 @@ S:	Maintained
>  F:	Documentation/i2c/busses/i2c-ali1563.rst
>  F:	drivers/i2c/busses/i2c-ali1563.c
>  
> +ALL SENSORS DLH SERIES PRESSURE SENSORS DRIVER
> +M:	Tomislav Denis <tomislav.denis@avl.com>
> +W:	http://www.allsensors.com/
> +S:	Maintained
> +L:	linux-iio@vger.kernel.org
> +F:	drivers/iio/pressure/dlh.c
> +
>  ALLEGRO DVT VIDEO IP CORE DRIVER
>  M:	Michael Tretter <m.tretter@pengutronix.de>
>  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index ba420e4..3d383d8 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -53,6 +53,18 @@ config IIO_CROS_EC_BARO
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called cros_ec_baro.
>  
> +config DLH
> +	tristate "All Sensors DLH series low voltage digital pressure sensors"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for the All Sensors DLH series
> +	  pressure sensors driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called dlh.
> +
>  config DPS310
>  	tristate "Infineon DPS310 pressure and temperature sensor"
>  	depends on I2C
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index d8f5ace..c609ad4 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_BMP280) += bmp280.o
>  bmp280-objs := bmp280-core.o bmp280-regmap.o
>  obj-$(CONFIG_BMP280_I2C) += bmp280-i2c.o
>  obj-$(CONFIG_BMP280_SPI) += bmp280-spi.o
> +obj-$(CONFIG_DLH) += dlh.o
>  obj-$(CONFIG_DPS310) += dps310.o
>  obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
> diff --git a/drivers/iio/pressure/dlh.c b/drivers/iio/pressure/dlh.c
> new file mode 100644
> index 0000000..18fc4e1
> --- /dev/null
> +++ b/drivers/iio/pressure/dlh.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * All Sensors DLH series low voltage digital pressure sensors
> + *
> + * Copyright (c) 2019 AVL DiTEST GmbH
> + *   Tomislav Denis <tomislav.denis@avl.com>
> + *
> + * Datasheet: http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <asm/unaligned.h>
> +
> +/* Commands */
> +#define DLH_START_SINGLE    0xAA
> +
> +/* Status bits */
> +#define DLH_STATUS_OK       0x40
> +
> +/* DLH  data format */
> +#define DLH_NUM_READ_BYTES  7
> +#define DLH_NUM_DATA_BYTES  3
> +#define DLH_NUM_PR_BITS     24
> +#define DLH_NUM_TEMP_BITS   24
> +
> +/* DLH  timings */
> +#define DLH_SINGLE_DUT_MS   5
> +
> +enum dhl_ids {
> +	dlhl60d,
> +	dlhl60g,
> +};
> +
> +struct dlh_info {
> +	u8 osdig;           /* digital offset factor */
> +	unsigned int fss;   /* full scale span (inch H2O) */
> +};
> +
> +struct dlh_state {
> +	struct i2c_client *client;
> +	struct dlh_info info;
> +	bool use_interrupt;
> +	struct completion completion;
> +	u8 rx_buf[DLH_NUM_READ_BYTES] ____cacheline_aligned;
> +};
> +
> +static struct dlh_info dlh_info_tbl[] = {
> +	[dlhl60d] = {
> +		.osdig = 2,
> +		.fss = 120,
> +	},
> +	[dlhl60g] = {
> +		.osdig = 10,
> +		.fss = 60,
> +	},
> +};
> +
> +
> +static int dlh_cmd_start_single(struct dlh_state *st)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(st->client, DLH_START_SINGLE);
> +	if (ret)
> +		dev_err(&st->client->dev,
> +			"%s: I2C write byte failed\n", __func__);
> +
> +	return ret;
> +}
> +
> +static int dlh_cmd_read_data(struct dlh_state *st)
> +{
> +	int ret;
> +
> +	ret = i2c_master_recv(st->client, st->rx_buf, DLH_NUM_READ_BYTES);
> +	if (ret < 0) {
> +		dev_err(&st->client->dev,
> +			"%s: I2C read block failed\n", __func__);
> +		return ret;
> +	}
> +
> +	if (st->rx_buf[0] != DLH_STATUS_OK) {
> +		dev_err(&st->client->dev,
> +			"%s: invalid status 0x%02x\n", __func__, st->rx_buf[0]);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dlh_start_capture_and_read(struct dlh_state *st)
> +{
> +	int ret;
> +
> +	if (st->use_interrupt)
> +		reinit_completion(&st->completion);
> +
> +	ret = dlh_cmd_start_single(st);
> +	if (ret)
> +		return ret;
> +
> +	if (st->use_interrupt) {
> +		ret = wait_for_completion_timeout(&st->completion,
> +			msecs_to_jiffies(DLH_SINGLE_DUT_MS));
> +		if (!ret) {
> +			dev_err(&st->client->dev,
> +				"%s: conversion timed out\n", __func__);
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		mdelay(DLH_SINGLE_DUT_MS);
> +	}
> +
> +	return dlh_cmd_read_data(st);
> +}
> +
> +static int dlh_read_direct(struct dlh_state *st,
> +	unsigned int *pressure, unsigned int *temperature)
> +{
> +	int ret;
> +
> +	ret = dlh_start_capture_and_read(st);
> +	if (ret)
> +		return ret;
> +
> +	*pressure = get_unaligned_be32(&st->rx_buf[1]) >> 8;
> +	*temperature = get_unaligned_be32(&st->rx_buf[3]) &
> +		GENMASK(DLH_NUM_TEMP_BITS - 1, 0);
> +
> +	return 0;
> +}
> +
> +static int dlh_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel, int *value,
> +	int *value2, long mask)
> +{
> +	struct dlh_state *st = iio_priv(indio_dev);
> +	unsigned int pressure, temperature;
> +	int ret;
> +	s64 tmp;
> +	s32 rem;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = dlh_read_direct(st, &pressure, &temperature);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		switch (channel->type) {
> +		case IIO_PRESSURE:
> +			*value = pressure;
> +			return IIO_VAL_INT;
> +
> +		case IIO_TEMP:
> +			*value = temperature;
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (channel->type) {
> +		case IIO_PRESSURE:
> +			tmp = div_s64(125LL * st->info.fss * 24909 * 100,
> +				1 << DLH_NUM_PR_BITS);
> +			tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> +			*value = tmp;
> +			*value2 = rem;
> +			return IIO_VAL_INT_PLUS_NANO;
> +
> +		case IIO_TEMP:
> +			*value = 125 * 1000;
> +			*value2 = DLH_NUM_TEMP_BITS;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (channel->type) {
> +		case IIO_PRESSURE:
> +			*value = -125 * st->info.fss * 24909;
> +			*value2 = 100 * st->info.osdig * 100000;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case IIO_TEMP:
> +			*value = -40 * 1000;
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info dlh_info = {
> +	.read_raw = dlh_read_raw,
> +};
> +
> +static const struct iio_chan_spec dlh_channels[] = {
> +	{
> +		.type = IIO_PRESSURE,
> +		.indexed = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type =
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = DLH_NUM_PR_BITS,
> +			.storagebits = 32,
> +			.shift = 8,
> +			.endianness = IIO_BE,
> +		},
> +	}, {
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type =
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = DLH_NUM_TEMP_BITS,
> +			.storagebits = 32,
> +			.shift = 8,
> +			.endianness = IIO_BE,
> +		},
> +	}
> +};
> +
> +static irqreturn_t dlh_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct dlh_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int chn, i = 0;
> +	__be32 tmp_buf[2];
> +
> +	ret = dlh_start_capture_and_read(st);
> +	if (ret)
> +		goto out;
> +
> +	for_each_set_bit(chn, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +		memcpy(tmp_buf + i,
> +			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
> +			DLH_NUM_DATA_BYTES);
> +		i++;
> +	}
> +
> +	iio_push_to_buffers(indio_dev, tmp_buf);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t dlh_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct dlh_state *st = iio_priv(indio_dev);
> +
> +	complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +};
> +
> +static int dlh_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct dlh_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +		I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE)) {
> +		dev_err(&client->dev,
> +			"adapter doesn't support required i2c functionality\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "failed to allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	st = iio_priv(indio_dev);
> +	st->info = dlh_info_tbl[id->driver_data];
> +	st->client = client;
> +	st->use_interrupt = false;
> +
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->dev.of_node = client->dev.of_node;
> +	indio_dev->info = &dlh_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels =  dlh_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(dlh_channels);
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +			dlh_interrupt, NULL,
> +			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			id->name, indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to allocate threaded irq");
> +			return ret;
> +		}
> +
> +		st->use_interrupt = true;
> +		init_completion(&st->completion);
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +		NULL, &dlh_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to setup iio buffer\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret)
> +		dev_err(&client->dev, "failed to register iio device\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id dlh_of_match[] = {
> +	{ .compatible = "asc,dlhl60d" },
> +	{ .compatible = "asc,dlhl60g" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, dlh_of_match);
> +
> +static const struct i2c_device_id dlh_id[] = {
> +	{ "dlhl60d",    dlhl60d },
> +	{ "dlhl60g",    dlhl60g },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, dlh_id);
> +
> +static struct i2c_driver dlh_driver = {
> +	.driver = {
> +		.name = "dlh",
> +		.of_match_table = dlh_of_match,
> +	},
> +	.probe = dlh_probe,
> +	.id_table = dlh_id,
> +};
> +module_i2c_driver(dlh_driver);
> +
> +MODULE_AUTHOR("Tomislav Denis <tomislav.denis@avl.com>");
> +MODULE_DESCRIPTION("Driver for All Sensors DLH series pressure sensors");
> +MODULE_LICENSE("GPL v2");

