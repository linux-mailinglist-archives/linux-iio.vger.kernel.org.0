Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885BD457F08
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 16:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhKTPpw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 10:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237027AbhKTPpu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 10:45:50 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B7E260720;
        Sat, 20 Nov 2021 15:42:45 +0000 (UTC)
Date:   Sat, 20 Nov 2021 15:47:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: proximity: Add sx9360 support
Message-ID: <20211120154737.019715e5@jic23-huawei>
In-Reply-To: <20211120102634.1688190-2-gwendal@chromium.org>
References: <20211120102634.1688190-1-gwendal@chromium.org>
        <20211120102634.1688190-2-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Nov 2021 02:26:32 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> A simplified version of SX9324, it only have one pin and
> 2 phases (aka channels).
> Only one event is presented.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Hi Gwendal,

A very similar set of comments to the previous driver.
Again, looks good so this is all minor stuff to tidy up.

Jonathan

> ---
> Changes since v2:
> - Remove SX9360_DRIVER_NAME
> - Simplify whoami function
> - Define WHOAMI register value internally.
> - Handle negative values when setting sysfs parameters.
> 
>  drivers/iio/proximity/Kconfig  |  14 +
>  drivers/iio/proximity/Makefile |   1 +
>  drivers/iio/proximity/sx9360.c | 806 +++++++++++++++++++++++++++++++++
>  3 files changed, 821 insertions(+)
>  create mode 100644 drivers/iio/proximity/sx9360.c
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index aaddf97f9b2192..801926e55eb6d3 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
...

> +
>  config SX9500
>  	tristate "SX9500 Semtech proximity sensor"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index cffe962b352718..cc838bb5408a89 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
>  obj-$(CONFIG_SX9310)		+= sx9310.o
>  obj-$(CONFIG_SX9324)		+= sx9324.o
> +obj-$(CONFIG_SX9360)		+= sx9360.o
>  obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> new file mode 100644
> index 00000000000000..5d909c7dfa1d75
> --- /dev/null
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -0,0 +1,806 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Google LLC.
> + *
> + * Driver for Semtech's SX9360 capacitive proximity/button solution.
> + * Based on SX9360 driver and copy of datasheet at:
> + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
Check these are all used.  I don't thing iio/sysfs.h is for starters...

...

> +
> +/*
> + * Each entry contains the integer part (val) and the fractional part, in micro
> + * seconds. It conforms to the IIO output IIO_VAL_INT_PLUS_MICRO.
> + *
> + * The frequency control register holds the period, with a ~2ms increment.
> + * Therefore the smallest frequency is 4MHz / (2047 * 8192),
> + * The fastest is 4MHz / 8192.
> + * The interval is not linear, but given there is 2047 possible value,
> + * Returns the fake increment of (Max-Min)/2047

Hmm. This is probably a reasonably common thing to see.  We should think about
how we might present that to userspace at somepoint - I wouldn't delay this
driver for that discussion however as it feels like it will be non trivial to
resolve.

> + *
> + */

...

> +
> +static int sx9360_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	if (chan->type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(sx9360_gain_vals);
> +		*vals = sx9360_gain_vals;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(sx9360_samp_freq_interval) * 2;
> +		*vals = (int *)sx9360_samp_freq_interval;
> +		return IIO_AVAIL_RANGE;
default:
	return -EINVAL; 

preferred for reasons given below.

> +	}
> +
> +	return -EINVAL;
> +}

> +static int sx9360_write_thresh(struct sx_common_data *data, int _val)
> +{
> +	unsigned int val = _val;
> +	int ret;
> +
> +	if (val >= 1)
> +		val = int_sqrt(2 * val);

As previous driver - comment on the maths behind this given data sheets might not
be available...

> +
> +	if (val > 0xff)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_write(data->regmap, SX9360_REG_PROX_CTRL5, val);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +


...


> +static int sx9360_write_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return sx9360_set_samp_freq(data, val, val2);
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return sx9360_write_gain(data, chan, val);
> +	}
> +
> +	return -EINVAL;

slight preference for taking the error path into a default: statement in the
switch as that lets static checkers know its intentional that we don't handle
the many other potential values of mask (as far as they can tell if looking at
local code that is).

> +}
> +

> +
> +static int sx9360_check_whoami(struct device *dev,
> +			       struct iio_dev *indio_dev)
> +{
> +	/*
> +	 * Only one sensor for this driver. Assuming the device tree
> +	 * is correct, just set the sensor name.
> +	 */
> +	indio_dev->name = "sx9360";

As before - only reason I can see not to check whoami is there isn't one.
If that's true then say that. If you want to carry on after detecting a 
wrong WAI value then at least print a warning message.

> +	return 0;
> +}

> +
> +static int __maybe_unused sx9360_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	disable_irq_nosync(data->client->irq);
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
> +
> +	data->suspend_ctrl =
> +		FIELD_GET(SX9360_REG_GNRL_CTRL0_PHEN_MASK, regval);
> +
> +	if (ret < 0)
> +		goto out;

snap, as per previous driver if this makes sense it definitely needs
a comment.  I'm still going to assume it's a bug as regval is potentially
not initialized.

> +
> +	/* Disable all phases, send the device to sleep. */
> +	ret = regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
> +
> +out:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}

> +static const struct dev_pm_ops sx9360_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sx9360_suspend, sx9360_resume)
> +};
> +
> +static const struct acpi_device_id sx9360_acpi_match[] = {

__maybe_unused given ACPI_PTR() below to avoid build warnings.

> +	{ "STH9360", SX9360_WHOAMI_VALUE},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, sx9360_acpi_match);
> +
> +static const struct of_device_id sx9360_of_match[] = {
> +	{ .compatible = "semtech,sx9360", (void *)SX9360_WHOAMI_VALUE},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sx9360_of_match);
> +
> +static const struct i2c_device_id sx9360_id[] = {
> +	{"sx9360", SX9360_WHOAMI_VALUE},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sx9360_id);
> +
> +static struct i2c_driver sx9360_driver = {
> +	.driver = {
> +		.name	= "sx9360",
> +		.acpi_match_table = ACPI_PTR(sx9360_acpi_match),
> +		.of_match_table = of_match_ptr(sx9360_of_match),

Drop of_match_ptr() for the PRP0001 ACPI binding support we get for free
without that.

> +		.pm = &sx9360_pm_ops,
> +
> +		/*
> +		 * Lots of i2c transfers in probe + over 200 ms waiting in
> +		 * sx9360_init_compensation() mean a slow probe; prefer async
> +		 * so we don't delay boot if we're builtin to the kernel.
> +		 */
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe_new	= sx9360_probe,
> +	.id_table	= sx9360_id,
> +};
> +module_i2c_driver(sx9360_driver);
> +
> +MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
> +MODULE_DESCRIPTION("Driver for Semtech SX9360 proximity sensor");
> +MODULE_LICENSE("GPL v2");

