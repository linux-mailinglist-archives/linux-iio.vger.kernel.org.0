Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1C457EC9
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhKTPCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 10:02:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237027AbhKTPCj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 10:02:39 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13F1D603E8;
        Sat, 20 Nov 2021 14:59:33 +0000 (UTC)
Date:   Sat, 20 Nov 2021 15:04:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: sx9310: Extract common Semtech sensor logic
Message-ID: <20211120150427.76ecd8fc@jic23-huawei>
In-Reply-To: <20211120101501.1659549-3-gwendal@chromium.org>
References: <20211120101501.1659549-1-gwendal@chromium.org>
        <20211120101501.1659549-3-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Nov 2021 02:14:58 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Before adding new Semtech sensors, move common logic to all Semtech SAR
> sensor in its own file:
> - interface with IIO subsystem,
> - interrupt management,
> - channel access conrol,
> - event processing.
> 
> The change adds a bidirectional interface between sx93xx and sx_common.
> 
> The change is quite mechanical, as the impacted functions are moved
> and renamed.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Hi Gwendal,

Some trivial bits and bobs inline.  Biggest one is I'd like the new header to
stand alone such that it is include order independent and doesn't rely on
deeply nested includes, which means you need a few more includes and some
forwards definitions.

Also, one cleanup that applies to the previous patch and here (I think).

Looks good to me otherwise.

Jonathan

> ---
> Changes in v4:
> - Fix credit in sx_common.c
> - Use chip_info instead of info in common data structure.
> - Remove unnecessary includes in sx_common.c
> - Remove WHOAMI register values from sx_common.h
> - Fix kerneldoc comments.
> 
> Changes in v3:
> - No line change in Makefile
> - Leave interrupt.h include, needed at suspend/resume.
> 
> Changes in v2:
> - Add Kconfig/Makefile that were in the wrong patch
> - Define a better interface between common code and driver code
> - Move back read_avail() to driver code:
>   As it now contains frequency table, it will differ from sensor to
>   sensor.
> - Check whoami and set driver name back in the driver code.
> - Use a common probe routine.
> - Fix kernel doc comments.
> 
>  drivers/iio/proximity/Kconfig     |   4 +
>  drivers/iio/proximity/Makefile    |   1 +
>  drivers/iio/proximity/sx9310.c    | 675 +++++-------------------------
>  drivers/iio/proximity/sx_common.c | 568 +++++++++++++++++++++++++
>  drivers/iio/proximity/sx_common.h | 155 +++++++
>  5 files changed, 826 insertions(+), 577 deletions(-)
>  create mode 100644 drivers/iio/proximity/sx_common.c
>  create mode 100644 drivers/iio/proximity/sx_common.h
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 7c7203ca3ac638..e88fc373c2c903 100644
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
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index cbdac09433eb51..2577fbce4144e5 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
>  obj-$(CONFIG_SX9310)		+= sx9310.o
> +obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 1647268b6471f1..6376ffe17726f6 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -14,6 +14,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/irq.h>

An iwyu parse on this file before your changes suggested neither irq.h nor
slab.h are directly used, so clean those out whilst here. Also possible a
bunch of these other headers are also no longer directly used after you add the
library but I haven't checked.

>  #include <linux/kernel.h>
>  #include <linux/log2.h>
> @@ -22,19 +23,16 @@
>  #include <linux/pm.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/trigger.h>
> -#include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/trigger_consumer.h>
> +
> +#include "sx_common.h"
>  

> +static_assert(SX9310_NUM_CHANNELS <= SX_COMMON_MAX_NUM_CHANNELS);
> +
> +#define SX9310_NAMED_CHANNEL(idx, name)				 \
> +{								 \
> +	.type = IIO_PROXIMITY,					 \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		 \
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),   \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.info_mask_separate_available =				 \
> +		BIT(IIO_CHAN_INFO_HARDWAREGAIN),		 \
> +	.info_mask_shared_by_all_available =			 \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
> +	.indexed = 1,						 \
> +	.channel = idx,						 \
> +	.extend_name = name,					 \
> +	.address = SX9310_REG_DIFF_MSB,				 \
> +	.event_spec = sx_common_events,				 \

As mentioned later, I'd be tempted to have a local copy of the event_spec.
It's rather odd to have everything in the channel description local except
for that part. 

> +	.num_event_specs = ARRAY_SIZE(sx_common_events),	 \
> +	.scan_index = idx,					 \
> +	.scan_type = {						 \
> +		.sign = 's',					 \
> +		.realbits = 12,					 \
> +		.storagebits = 16,				 \
> +		.endianness = IIO_BE,				 \
> +	},							 \
> +}


...


> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> new file mode 100644
> index 00000000000000..fc2062a1d95c74
> --- /dev/null
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -0,0 +1,568 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Google LLC.
> + *
> + * Common part of most Semtech SAR sensor.
> + *
One of my favourite trivial things to comment on.  No need for the trailing blank line
before the */
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>

Used?  This was one of the most frequent 'unneeded includes' in the iwyu
work.  Given all the wrappers for allocations in IIO, there are relatively
few calls to stuff in slab.h

> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I might be wrong, but my suspicion is that there are no users of anything in
iio/sysfs.h any more since you converted the _available in the earlier patch.
So probably drop this include in that patch and don't have it here.

> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#include "sx_common.h"
> +
> +/* All Semtech SAR sensor have IRQ bit in same order. */
> +#define   SX_COMMON_CONVDONE_IRQ			BIT(0)
> +#define   SX_COMMON_FAR_IRQ				BIT(2)
> +#define   SX_COMMON_CLOSE_IRQ				BIT(3)
> +
> +const struct iio_event_spec sx_common_events[3] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +				 BIT(IIO_EV_INFO_HYSTERESIS) |
> +				 BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +EXPORT_SYMBOL_GPL(sx_common_events);
> +

Seems likely this might become driver dependent at some point but I guess you can
move it when needed.  Just feels a bit odd as it's tightly coupled to the channels spec.

Maybe you would be better off just replicating this small amount of data in each driver?
That way it is readily available when looking at the rest of the chan_spec.

> +static int sx_common_init_device(struct iio_dev *indio_dev)
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	struct sx_common_reg_default tmp;
> +	const struct sx_common_reg_default *initval;
> +	int ret;
> +	unsigned int i, val;
> +
> +	ret = regmap_write(data->regmap, data->chip_info->reg_reset, SX_COMMON_SOFT_RESET);

Rather long line - where it doesn't hurt readability I'd prefer to keep things under 80 chars.

Here it would be fine to break the long line. Might be worth considering a local variable
for chip_info to short lines where it's used - there are other places this might help.


> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000); /* power-up time is ~1ms. */
> +
> +	/* Clear reset interrupt state by reading SX_COMMON_REG_IRQ_SRC. */
> +	ret = regmap_read(data->regmap, SX_COMMON_REG_IRQ_SRC, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Program defaults from constant or BIOS. */
> +	for (i = 0; i < data->chip_info->num_default_regs; i++) {
> +		initval = data->chip_info->ops.get_default_reg(&indio_dev->dev,
> +							  i, &tmp);
> +		ret = regmap_write(data->regmap, initval->reg, initval->def);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return data->chip_info->ops.init_compensation(indio_dev);
> +}
> +

...

> diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
> new file mode 100644
> index 00000000000000..808c5fe44cf8eb
> --- /dev/null
> +++ b/drivers/iio/proximity/sx_common.h
> @@ -0,0 +1,155 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Code shared between most Semtech SAR sensor driver.
> + */
> +
> +#ifndef IIO_SX_COMMON_H
> +#define IIO_SX_COMMON_H
> +
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

A bunch of forwards definitions should be in here to avoid any potential
header ordering dependencies. If you have a pointer and it's not defined
directly in the two headers above there should be a forwards definition.

e.g.

struct device;
struct iio_chan_spec;
struct iio_dev;
there are othes but given there is a struct iio_info this needs to
include iio.h (which will reduce what else you need come to think of it).

> +
> +#define SX_COMMON_REG_IRQ_SRC				0x00
> +
> +#define SX_COMMON_MAX_NUM_CHANNELS	4
> +static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
> +
> +struct sx_common_data;
> +
> +struct sx_common_reg_default {
> +	u8 reg;
> +	u8 def;
> +};
> +
> +/**
> + * struct sx_common_ops: function pointers needed by common code
> + *
> + * List functions needed by common code to gather information or configure
> + * the sensor.
> + *
> + * @read_prox_data:	Function to read raw proximity data.
> + * @check_whoami:	Set device name based on whoami register.
> + * @init_compensation:	Function to set initial compensation.
> + * @wait_for_sample:	When there are no physical IRQ, function to wait for a
> + *			sample to be ready.
> + * @get_default_reg:	Populate the initial value for a given register.
> + */
> +struct sx_common_ops {
> +	int (*read_prox_data)(struct sx_common_data *data,
> +			      const struct iio_chan_spec *chan, __be16 *val);
> +	int (*check_whoami)(struct device *dev, struct iio_dev *indio_dev);
> +	int (*init_compensation)(struct iio_dev *indio_dev);
> +	int (*wait_for_sample)(struct sx_common_data *data);
> +	const struct sx_common_reg_default  *
> +		(*get_default_reg)(struct device *dev, int idx,
> +				   struct sx_common_reg_default *reg_def);
> +};
> +
> +/**
> + * struct sx_common_chip_info: Semtech Sensor private chip information
> + *
> + * @reg_stat:		Main status register address.
> + * @reg_irq_msk:	IRQ mask register address.
> + * @reg_enable_chan:	Address to enable/disable channels/phases.
> + * @reg_reset:		Reset register address.
> + *
> + * @mask_enable_chan:	Mask over the channels bits in the enable channel
> + *			register.
> + * @irq_msk_offset:	Offset to enable interrupt in the IRQ mask
> + *			register.
> + *
> + * @num_channels:	Number of channel/phase.
> + * @num_default_regs:	Number of internal registers that can be configured.
> + *
> + * @ops:		Private functions pointers.
> + *
> + * @iio_channels:	Description of exposed iio channels.
> + * @num_iio_channels:	Number of iio_channels.
> + * @iio_info:		iio_info structure for this driver.
> + *
> + */
> +struct sx_common_chip_info {
> +	unsigned int reg_stat;
> +	unsigned int reg_irq_msk;
> +	unsigned int reg_enable_chan;
> +	unsigned int reg_reset;
> +
> +	unsigned int mask_enable_chan;
> +	unsigned int irq_msk_offset;
> +	unsigned int num_channels;
> +	int num_default_regs;
> +
> +	struct sx_common_ops ops;
> +
> +	const struct iio_chan_spec *iio_channels;
> +	int num_iio_channels;
> +	struct iio_info iio_info;
> +};
> +
> +/**
> + * struct sx_common_data: Semtech Sensor private data structure.
> + *
> + * @chip_info:		Structure defining sensor internals.
> + * @mutex:		Serialize access to registers and channel configuration.
> + * @num_channels:	Number of channel/phase.
> + * @completion:		completion object to wait for data acquisition.
> + * @client:		I2C client structure.
> + * @trig:		IIO trigger object.
> + * @regmap:		Register map.
> + *
> + * @num_default_regs:	Number of default registers to set at init.
> + * @supplies:		Power supplies object.
> + * @chan_prox_stat:	Last reading of the proximity status for each channel.
> + *			We only send an event to user space when this changes.
> + * @trigger_enabled:	True when the device trigger is enabled.
> + *
> + * @buffer:		Bufffer to store raw samples.
> + * @suspend_ctrl:	Remember enabled channels and sample rate during suspend.
> + * @chan_read:		Bit field for each raw channel enabled.
> + * @chan_event:		Bit field for each event enabled.
> + *
> + */
> +struct sx_common_data {
> +	const struct sx_common_chip_info *chip_info;
> +
> +	struct mutex mutex;
> +	struct completion completion;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +
> +	struct regulator_bulk_data supplies[2];
> +	unsigned long chan_prox_stat;
> +	bool trigger_enabled;
> +
> +	/* Ensure correct alignment of timestamp when present. */
> +	struct {
> +		__be16 channels[SX_COMMON_MAX_NUM_CHANNELS];
> +		s64 ts __aligned(8);
> +	} buffer;
> +
> +	unsigned int suspend_ctrl;
> +	unsigned long chan_read;
> +	unsigned long chan_event;
> +};
> +
> +int sx_common_read_proximity(struct sx_common_data *data,
> +			     const struct iio_chan_spec *chan, int *val);
> +
> +int sx_common_read_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir);
> +int sx_common_write_event_config(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 enum iio_event_type type,
> +				 enum iio_event_direction dir, int state);
> +
> +int sx_common_probe(struct i2c_client *client,
> +		    const struct sx_common_chip_info *chip_info,
> +		    const struct regmap_config *regmap_config);
> +
> +/* 3 is the number of events defined by a single phase. */
> +extern const struct iio_event_spec sx_common_events[3];
> +
> +#endif  /* IIO_SX_COMMON_H */

