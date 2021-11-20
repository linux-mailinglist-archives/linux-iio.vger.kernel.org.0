Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4D457EE5
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbhKTPZW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 10:25:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhKTPZV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 10:25:21 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE05604DA;
        Sat, 20 Nov 2021 15:22:16 +0000 (UTC)
Date:   Sat, 20 Nov 2021 15:27:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: proximity: Add SX9324 support
Message-ID: <20211120152708.39a566ce@jic23-huawei>
In-Reply-To: <20211120101501.1659549-4-gwendal@chromium.org>
References: <20211120101501.1659549-1-gwendal@chromium.org>
        <20211120101501.1659549-4-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Nov 2021 02:14:59 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Semtech SAR sensor SX9324 is an evolution of the SX9310:
> It has 4 phases that can be configure to capture and process data
> from any of 3 CS pins and provide independent detection:
> proximity, table proximity or body proximity.
> 
> Gather antenna data:
> echo sx9324-dev3 > trigger/current_trigger
> echo 1 > scan_elements/in_proximity0_en
> echo 1 > buffer/enable
> od -v -An --endian=big -t d2 -w2 /dev/iio\:device3
> (at 10Hz, the default).
> 
> Trigger events:
> Setting:
> thresh_falling_period: 2 (events)
> thresh_rising_period: 2 (events)
> in_proximity0_thresh_either_value: 300
> in_proximity0_thresh_either_hysteresis: 72
> 
> using iio_event_monitor /dev/iio\:deviceX, approaching my hand to the
> antenna pad, I see:
> ...
> Event: time: 1634763907532035297, type: proximity, channel: 0, evtype:
> thresh, direction: falling
> Event: time: 1634763910138104640, type: proximity, channel: 0, evtype:
> thresh, direction: rising
> ...
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

A few little things inline. Looks good otherwise,

Jonathan


> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index e88fc373c2c903..aaddf97f9b2192 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -129,6 +129,20 @@ config SX9310
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called sx9310.
>  
> +config SX9324
> +	tristate "SX9324 Semtech proximity sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP_I2C
> +	select SX_COMMON
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for Semtech's SX9324
> +	  proximity/button sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sx9324.
> +
>  config SX9500
>  	tristate "SX9500 Semtech proximity sensor"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 2577fbce4144e5..cffe962b352718 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
>  obj-$(CONFIG_SX9310)		+= sx9310.o
> +obj-$(CONFIG_SX9324)		+= sx9324.o
>  obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> new file mode 100644
> index 00000000000000..3858e70d7a86f6
> --- /dev/null
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -0,0 +1,916 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Google LLC.
> + *
> + * Driver for Semtech's SX9324 capacitive proximity/button solution.
> + * Based on SX9324 driver and copy of datasheet at:
> + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
> + *

Unneeded blank line..

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

As before, take a look at these (or run IWYU if you can) to prune
out the unused headers.

> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#include "sx_common.h"
> +

> +static int sx9324_read_prox_data(struct sx_common_data *data,
> +				 const struct iio_chan_spec *chan,
> +				 __be16 *val)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, SX9324_REG_PHASE_SEL, chan->channel);
> +	if (ret < 0)
> +		return ret;

A little inconsistent to check for < 0 for error here, but return directly the
value of the function below.  Cleaner to have if (ret) here as well as regmap
never returns positive from its read and write functions.

> +
> +	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
> +}
> +
> +/*
> + * If we have no interrupt support, we have to wait for a scan period
> + * after enabling a channel to get a result.
> + */
> +static int sx9324_wait_for_sample(struct sx_common_data *data)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL0, &val);
> +	if (ret < 0)
> +		return ret;
> +	val = FIELD_GET(SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, val);
> +
> +	msleep(sx9324_scan_period_table[val]);
> +
> +	return 0;
> +}
> +

> +
> +static int sx9324_write_thresh(struct sx_common_data *data,
> +			       const struct iio_chan_spec *chan, int _val)
> +{
> +	unsigned int reg, val = _val;
> +	int ret;
> +
> +	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
> +
> +	if (val >= 1)
> +		val = int_sqrt(2 * val);

This is unusual enough that perhaps a comment on what the threshold maths is
would be useful (I can't find the datasheet online to check this).

> +
> +	if (val > 0xff)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_write(data->regmap, reg, val);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +

> +static int sx9324_check_whoami(struct device *dev,
> +			       struct iio_dev *indio_dev)
> +{
> +	/*
> +	 * Only one sensor for this driver. Assuming the device tree
> +	 * is correct, just set the sensor name.

If there is a whoami register, would be nice to check it. If not then
say that here as it's a better reason than the driver only supporting one
sensor..

> +	 */
> +	indio_dev->name = "sx9324";
> +	return 0;
> +}
> +
> +static const struct sx_common_chip_info sx9324_chip_info = {
> +	.reg_stat = SX9324_REG_STAT0,
> +	.reg_irq_msk = SX9324_REG_IRQ_MSK,
> +	.reg_enable_chan = SX9324_REG_GNRL_CTRL1,
> +	.reg_reset = SX9324_REG_RESET,
> +
> +	.mask_enable_chan = SX9324_REG_GNRL_CTRL1_PHEN_MASK,
> +	.irq_msk_offset = 3,
> +	.num_channels = SX9324_NUM_CHANNELS,
> +
> +	.ops = {
> +		.read_prox_data = sx9324_read_prox_data,
> +		.check_whoami = sx9324_check_whoami,
> +		.init_compensation = sx9324_init_compensation,
> +		.wait_for_sample = sx9324_wait_for_sample,
> +	},
> +
> +	.iio_channels = sx9324_channels,
> +	.num_iio_channels = ARRAY_SIZE(sx9324_channels),
> +	.iio_info =  {
> +		.read_raw = sx9324_read_raw,
> +		.read_avail = sx9324_read_avail,
> +		.read_event_value = sx9324_read_event_val,
> +		.write_event_value = sx9324_write_event_val,
> +		.write_raw = sx9324_write_raw,
> +		.read_event_config = sx_common_read_event_config,
> +		.write_event_config = sx_common_write_event_config,
> +	},
> +};
> +
> +static int sx9324_probe(struct i2c_client *client)
> +{
> +	return sx_common_probe(client, &sx9324_chip_info, &sx9324_regmap_config);
> +}
> +
> +static int __maybe_unused sx9324_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	disable_irq_nosync(data->client->irq);
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
> +
> +	data->suspend_ctrl =
> +		FIELD_GET(SX9324_REG_GNRL_CTRL1_PHEN_MASK, regval);

Needs a comment on why it makes sense to use a value when the read failed particularly
as the value is potentially uninitialized. I'm guessing this should be after the
error check.

> +
> +	if (ret < 0)
> +		goto out;
> +
> +	/* Disable all phases, send the device to sleep. */
> +	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
> +
> +out:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
> +static int __maybe_unused sx9324_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
> +			   data->suspend_ctrl | SX9324_REG_GNRL_CTRL1_PAUSECTRL);
> +	mutex_unlock(&data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	enable_irq(data->client->irq);

Slight preference for blank lines before returns like this to distinguish
them from being related to the previous block of code (unlikely error returns)
Not important though if you'd rather not for some reason.

> +	return 0;
> +}
> +
> +static const struct dev_pm_ops sx9324_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sx9324_suspend, sx9324_resume)
> +};
> +
> +static const struct acpi_device_id sx9324_acpi_match[] = {
> +	{ "STH9324", SX9324_WHOAMI_VALUE},

Good, it's a probably valid ACPI entry as the PNP id is actually semtech :)

As you are using ACPI_PTR() this should be __maybe_unused to avoid warnings.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, sx9324_acpi_match);
> +
> +static const struct of_device_id sx9324_of_match[] = {
> +	{ .compatible = "semtech,sx9324", (void *)SX9324_WHOAMI_VALUE},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sx9324_of_match);
> +
> +static const struct i2c_device_id sx9324_id[] = {
> +	{"sx9324", SX9324_WHOAMI_VALUE},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sx9324_id);
> +
> +static struct i2c_driver sx9324_driver = {
> +	.driver = {
> +		.name	= "sx9324",
> +		.acpi_match_table = ACPI_PTR(sx9324_acpi_match),
> +		.of_match_table = of_match_ptr(sx9324_of_match),

Please don't introduce of_match_ptr() I'm still trying to get rid of the
existing cases of this. It breaks the ACPI / PRP0001 based probing for
no significant advantage.

Also, if you build this with CONFIG_OF disabled you'd get a warning about
the unused table..

> +		.pm = &sx9324_pm_ops,
> +
> +		/*
> +		 * Lots of i2c transfers in probe + over 200 ms waiting in
> +		 * sx9324_init_compensation() mean a slow probe; prefer async
> +		 * so we don't delay boot if we're builtin to the kernel.
> +		 */
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe_new	= sx9324_probe,
> +	.id_table	= sx9324_id,
> +};
> +module_i2c_driver(sx9324_driver);
> +
> +MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
> +MODULE_DESCRIPTION("Driver for Semtech SX9324 proximity sensor");
> +MODULE_LICENSE("GPL v2");

