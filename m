Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9010E173
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 11:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfLAK5R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 05:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfLAK5Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 05:57:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85CF920833;
        Sun,  1 Dec 2019 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575197835;
        bh=6JErwGQEAKQempkPLzHulw0KoNcuaZGW+m2m6I46OH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AIOd9j5hgfL4SLhavXVaEE+K+zJrWfX0NDcC6QMBn8mQRI2rc05px9caX/8IuQa2u
         9Z8ZuzsQGyVQzNb/RCRFKRxFZwTcLaE6nuCGorZFCXTQV1/iwMK+5uNVFqrl8l7HOI
         xsgiRnXCPo+a2z42hFHiKKwWCsJ1eHuotaPpnOKs=
Date:   Sun, 1 Dec 2019 10:57:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: pressure: Add driver for DLH pressure
 sensors
Message-ID: <20191201105711.43186bd7@archlinux>
In-Reply-To: <20191129073420.9800-2-tomislav.denis@avl.com>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
        <20191129073420.9800-1-tomislav.denis@avl.com>
        <20191129073420.9800-2-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Nov 2019 08:34:18 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> All Sensors DLH is series of low voltage digital pressure sensors.
> Additionally to pressure value sensors deliver a temperature value.
> Sensors can be accessed over I2C and SPI, this driver supports
> only I2C access.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>

I'm afraid I misunderstood the nature of the trigger events
previously.  Comments inline, but in a general sense I don't think this
device provides anything that should really be considered a trigger in
IIO as it isn't 'self clocking'.  For the usecase you have here we
have the iio_loop trigger.  It's been a while but from what I recall that
should cause continuous reads, limited in speed by how long it takes
the completion events in the driver to occur.

Currently you can't use this device with a high resolution timer or
similar trigger, which users may well want to do.  Moving to a model
with:
1) Trigger
2) Start Capture
3) Wait for completion from interrupt
4) Push data to buffer
5) Say done so trigger can start again.

Would allow it to work with any trigger.

Jonathan
> ---
>  MAINTAINERS                    |   7 +
>  drivers/iio/pressure/Kconfig   |  12 ++
>  drivers/iio/pressure/Makefile  |   1 +
>  drivers/iio/pressure/dlh-i2c.c | 429 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 449 insertions(+)
>  create mode 100644 drivers/iio/pressure/dlh-i2c.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5ea4e4..39d6f0f 100644
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
> +F:	drivers/iio/pressure/dlh-i2c.c
> +
>  ALLEGRO DVT VIDEO IP CORE DRIVER
>  M:	Michael Tretter <m.tretter@pengutronix.de>
>  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index ba420e4..504de3e 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -53,6 +53,18 @@ config IIO_CROS_EC_BARO
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called cros_ec_baro.
>  
> +config DLH_I2C
> +	tristate "All Sensors DLH series low voltage digital pressure sensors"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for the All Sensors DLH series
> +	  pressure sensors driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called dlh-i2c.
> +
>  config DPS310
>  	tristate "Infineon DPS310 pressure and temperature sensor"
>  	depends on I2C
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index d8f5ace..1851a36 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_BMP280) += bmp280.o
>  bmp280-objs := bmp280-core.o bmp280-regmap.o
>  obj-$(CONFIG_BMP280_I2C) += bmp280-i2c.o
>  obj-$(CONFIG_BMP280_SPI) += bmp280-spi.o
> +obj-$(CONFIG_DLH_I2C) += dlh-i2c.o
>  obj-$(CONFIG_DPS310) += dps310.o
>  obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
> diff --git a/drivers/iio/pressure/dlh-i2c.c b/drivers/iio/pressure/dlh-i2c.c
> new file mode 100644
> index 0000000..d980f7e
> --- /dev/null
> +++ b/drivers/iio/pressure/dlh-i2c.c
> @@ -0,0 +1,429 @@
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
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
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
> +	struct completion completion;
> +	struct iio_trigger *dready_trig;
> +	bool dready_trig_on;
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
> +static int dlh_i2c_cmd_start_single(struct dlh_state *st)
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
> +static int dlh_i2c_cmd_read_data(struct dlh_state *st)
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
> +static int dlh_i2c_read_direct(struct dlh_state *st,
> +	unsigned int *pressure, unsigned int *temperature)
> +{
> +	int ret;
> +
> +	if (st->dready_trig)
> +		reinit_completion(&st->completion);
> +
> +	ret = dlh_i2c_cmd_start_single(st);
> +	if (ret)
> +		return ret;
> +
> +	if (st->dready_trig) {
> +		ret = wait_for_completion_timeout(&st->completion,
> +			msecs_to_jiffies(DLH_SINGLE_DUT_MS));
> +		if (!ret)
> +			return -ETIMEDOUT;
> +	} else {
> +		mdelay(DLH_SINGLE_DUT_MS);
> +	}
> +
> +	ret = dlh_i2c_cmd_read_data(st);
> +	if (ret)
> +		return ret;
> +
> +	*pressure = be32_to_cpup((u32 *)&st->rx_buf[1]) >> 8;
> +	*temperature = be32_to_cpup((u32 *)&st->rx_buf[3]) &
> +		GENMASK(DLH_NUM_TEMP_BITS - 1, 0);
> +
> +	return 0;
> +}
> +
> +static int dlh_i2c_read_raw(struct iio_dev *indio_dev,
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
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;

claim_direct already returns -EBUSY if the buffer is enabled, so this
prior check shouldn't be needed.

> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = dlh_i2c_read_direct(st, &pressure, &temperature);
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
> +static int dlh_i2c_validate_trigger(struct iio_dev *indio_dev,
> +	struct iio_trigger *trig)
> +{
> +	struct dlh_state *st = iio_priv(indio_dev);
> +
> +	if (st->dready_trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct iio_info dlh_i2c_info = {
> +	.read_raw = dlh_i2c_read_raw,
> +	.validate_trigger = dlh_i2c_validate_trigger,
> +};
> +
> +static const struct iio_chan_spec dlh_i2c_channels[] = {
> +	{
> +		.type = IIO_PRESSURE,
> +		.indexed = 1,
> +		.channel = 0,
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
> +		.channel = 0,
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
> +static irqreturn_t dlh_i2c_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct dlh_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int chn, i = 0;
> +	__be32 tmp_buf[2];
> +
> +	ret = dlh_i2c_cmd_read_data(st);
> +	if (ret)
> +		goto out;
> +
> +	ret = dlh_i2c_cmd_start_single(st);
> +	if (ret)
> +		goto out;

Is this repriming the sensor to grab another sample?
If so it belongs in the try_renenable callback of
the trigger.

If we were using this trigger for another sensor, we only
want to re enable the trigger once that other sensor is ready.

This becomes less critical if we provide validation functions
to limit the usefulness of this trigger as mentioned below.

I'm wondering if this sensor isn't actually
self clocking, but rather is a trigger of demand type of sensor
with a completion interrupt?  A self clocking or sequencing device
would grab data at even samples whether or not we had acknowledged
the previous one (sometimes into a fifo, sometimes just overwriting
the previous data,  sometimes reporting an overflow if data hasn't
been read).

If taking that view, it shouldn't provide a trigger at all.
The same result would be achieved by using an iio_loop
trigger.  The loop trigger will result in data capture
being initialised just as soon as the previous data
capture finishes.

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
> +static irqreturn_t dlh_i2c_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct dlh_state *st = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev) && st->dready_trig_on)

You have validation that prevents this device using any other trigger
so I don't think you can get here with only one of the two conditions
being true.  

However nothing is stopping another device using this trigger even
if this device is not.  That device will wait for ever.

As suggested above, I'm not sure having a trigger here at all makes
sense but if it doesn't you probably also want the validate_device
callback set for the trigger.

> +		iio_trigger_poll(st->dready_trig);
> +	else
> +		complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +};
> +
> +static int dlh_i2c_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct dlh_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	st->dready_trig_on = state;
> +
> +	if (state)
> +		ret = dlh_i2c_cmd_start_single(st);
> +
> +	return ret;

Flip the logic and this ends up a tiny bit simpler

	if (!state)
		return 0;

	return dlh_i2c_cmd_start_single(st);


> +}
> +
> +static const struct iio_trigger_ops dlh_i2c_trigger_ops = {
> +	.set_trigger_state = dlh_i2c_set_trigger_state,
> +};
> +
> +static int dlh_i2c_probe(struct i2c_client *client,
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
> +	st->dready_trig = NULL;
> +
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->dev.of_node = client->dev.of_node;
> +	indio_dev->info = &dlh_i2c_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels =  dlh_i2c_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(dlh_i2c_channels);
> +
> +	if (client->irq > 0) {
> +		st->dready_trig = devm_iio_trigger_alloc(&client->dev,
> +			"%s-dev%d", indio_dev->name, indio_dev->id);
> +		if (!st->dready_trig) {
> +			dev_err(&client->dev, "failed to allocate trigger");
> +			return -ENOMEM;
> +		}
> +
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +			dlh_i2c_interrupt, NULL,
> +			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			id->name, indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to allocate threaded irq");
> +			return ret;
> +		}
> +
> +		st->dready_trig->dev.parent = &client->dev;
> +		st->dready_trig->ops = &dlh_i2c_trigger_ops;
> +		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> +		indio_dev->trig = iio_trigger_get(st->dready_trig);
> +
> +		init_completion(&st->completion);
> +		st->dready_trig_on = false;
> +
> +		ret = devm_iio_trigger_register(&client->dev, st->dready_trig);
> +		if (ret) {
> +			dev_err(&client->dev, "failed to register trigger\n");
> +			return ret;
> +		}
> +	} else {
> +		dev_info(&client->dev,
> +			"no irq, falling back to polling in direct mode\n");
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +		NULL, &dlh_i2c_trigger_handler, NULL);
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
> +static const struct of_device_id dlh_i2c_of_match[] = {
> +	{ .compatible = "asc,dlhl60d" },
> +	{ .compatible = "asc,dlhl60g" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, dlh_i2c_of_match);
> +
> +static const struct i2c_device_id dlh_i2c_id[] = {
> +	{ "dlhl60d",    dlhl60d },
> +	{ "dlhl60g",    dlhl60g },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, dlh_i2c_id);
> +
> +static struct i2c_driver dlh_i2c_driver = {
> +	.driver = {
> +		.name = "dlh_i2c",
> +		.of_match_table = dlh_i2c_of_match,
> +	},
> +	.probe = dlh_i2c_probe,
> +	.id_table = dlh_i2c_id,
> +};
> +module_i2c_driver(dlh_i2c_driver);
> +
> +MODULE_AUTHOR("Tomislav Denis <tomislav.denis@avl.com>");
> +MODULE_DESCRIPTION("Driver for All Sensors DLH series pressure sensors");
> +MODULE_LICENSE("GPL v2");

