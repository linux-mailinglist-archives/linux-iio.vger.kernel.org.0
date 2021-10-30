Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30E440A4F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 19:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhJ3RC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 13:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhJ3RC1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 13:02:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C332B60E8F;
        Sat, 30 Oct 2021 16:59:55 +0000 (UTC)
Date:   Sat, 30 Oct 2021 18:04:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: proximity: Add SX9324 support
Message-ID: <20211030180423.6451830e@jic23-huawei>
In-Reply-To: <20211030111827.1494139-4-gwendal@chromium.org>
References: <20211030111827.1494139-1-gwendal@chromium.org>
        <20211030111827.1494139-4-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 30 Oct 2021 04:18:25 -0700
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

Various comment inline, but biggest one is lack of docs of non standard ABI
which means discussion is very difficult.

Jonathan

> ---
>  drivers/iio/proximity/Kconfig  |  18 +
>  drivers/iio/proximity/Makefile |   3 +-
>  drivers/iio/proximity/sx9324.c | 931 +++++++++++++++++++++++++++++++++
>  3 files changed, 951 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/proximity/sx9324.c
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 7c7203ca3ac63..aaddf97f9b219 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -112,11 +112,15 @@ config SRF04
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called srf04.
>  
> +config SX_COMMON
> +	tristate
> +
>  config SX9310
>  	tristate "SX9310/SX9311 Semtech proximity sensor"
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select REGMAP_I2C
> +	select SX_COMMON
>  	depends on I2C
>  	help
>  	  Say Y here to build a driver for Semtech's SX9310/SX9311 capacitive
> @@ -125,6 +129,20 @@ config SX9310
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
> index cbdac09433eb5..1b026fedc396c 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -14,7 +14,8 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
>  obj-$(CONFIG_SX9310)		+= sx9310.o
> +obj-$(CONFIG_SX9324)		+= sx9324.o
> +obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
Previous patch...

>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> -
stray

> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> new file mode 100644
> index 0000000000000..41d9c950c5abd
> --- /dev/null
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -0,0 +1,931 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Google LLC.
> + *
> + * Driver for Semtech's SX9324 capacitive proximity/button solution.
> + * Based on SX9324 driver and copy of datasheet at:
> + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */

SPDX tag usually means we can drop the GPL license blurb.

> +

> +
> +/* 4 channels, as defined in STAT0: PH0, PH1, PH2 and PH3. */
> +#define SX9324_NUM_CHANNELS		4
> +/* 3 CS pins: CS0, CS1, CS2. */
> +#define SX9324_NUM_PINS			3
> +
> +#define SX9324_CHANNEL(idx)						\
> +	{								\
> +		.type = IIO_PROXIMITY,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.info_mask_separate_available =				\
> +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
> +		.indexed = 1,						\
> +		.channel = idx,						\
> +		.address = SX9324_REG_DIFF_MSB,				\
> +		.event_spec = sx_common_events,				\
> +		.num_event_specs = ARRAY_SIZE(sx_common_events),	\
> +		.scan_index = idx,					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 12,					\
> +			.storagebits = 16,				\
> +			.endianness = IIO_BE,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec sx9324_channels[] = {
> +	SX9324_CHANNEL(0),			/* Phase 0 */
> +	SX9324_CHANNEL(1),			/* Phase 1 */
> +	SX9324_CHANNEL(2),			/* Phase 2 */
> +	SX9324_CHANNEL(3),			/* Phase 3 */
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +static const char * const sx9324_cs_pin_usage[] = { "HZ", "MI", "DS", "GD" };
> +
> +static ssize_t sx9324_phase_configuration_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int i, ret, pin_idx;
> +	size_t len = 0;
> +
> +	ret = regmap_read(data->regmap, SX9324_REG_AFE_PH0 + this_attr->address, &val);
> +
> +	for (i = 0; i < SX9324_NUM_PINS; i++) {
> +		pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s,",
> +				 sx9324_cs_pin_usage[pin_idx]);
> +	}
> +	buf[len - 1] = '\n';
> +	return len;
> +}
> +
> +static ssize_t sx9324_phase_configuration_store(struct device *dev,
> +						struct device_attribute *attr,
> +						const char *buf,
> +						size_t len)
> +{
> +	return -EINVAL;

Don't do this. If they are read only treat them correctly as such
with appropriate permissions etc.

> +}
> +
> +#define IIO_DEV_ATTR_PHASE_CONFIG(_idx) \
> +IIO_DEVICE_ATTR(in_proximity_configuration##_idx, 0644, \
> +		sx9324_phase_configuration_show, \
> +		sx9324_phase_configuration_store, _idx)
> +
> +static IIO_DEV_ATTR_PHASE_CONFIG(0);
> +static IIO_DEV_ATTR_PHASE_CONFIG(1);
> +static IIO_DEV_ATTR_PHASE_CONFIG(2);
> +static IIO_DEV_ATTR_PHASE_CONFIG(3);

Documentation of these? I'm not going to comment on them without appropriate
docs in

Documentation/ABI/testing/

Just wastes time figuring out what they are.


...



> +static int sx9324_write_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return sx9324_set_samp_freq(data, val, val2);
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return sx9324_write_gain(data, chan, val);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static struct attribute *sx9324_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,

As mentioned in previous review, ideally move this to using the
read_avail callback.

> +	&iio_dev_attr_in_proximity_configuration0.dev_attr.attr,
> +	&iio_dev_attr_in_proximity_configuration1.dev_attr.attr,
> +	&iio_dev_attr_in_proximity_configuration2.dev_attr.attr,
> +	&iio_dev_attr_in_proximity_configuration3.dev_attr.attr,
> +	NULL
> +};

...

> +
> +static const struct acpi_device_id sx9324_acpi_match[] = {
> +	{ "STH9324", SX9324_WHOAMI_VALUE},

Any reference to a board, preferably with a dump of the DSDT/SSDT
that uses this or an official doc etc to justify that it's valid?

STH isn't in the pnp database so if it's in the wild we need a comment
to say where.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, sx9324_acpi_match);
> +
...

