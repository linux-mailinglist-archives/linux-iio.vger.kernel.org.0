Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C144185C3C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgCOMCp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgCOMCp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:02:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D8620575;
        Sun, 15 Mar 2020 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584273762;
        bh=xbvqUfBEEJgrZ8rnEwNzkgv/QLUqq5JLMYkaIioVf/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cAk48b+eMtSg8WnZN/J/UjPC9UAaXX0SV8WdbuuVUcrQGERu1l6Zerees2McO112K
         AqegBbA9a6PUBhZJHRqJje+NFjlMrRZX2FGdANxqYgujaOVZb912tg/SpnS52EbDub
         PRYm7hZ4PeaQKY0IAjG7L0B+rAb7EQ0F95MPZj6k=
Date:   Sun, 15 Mar 2020 12:02:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: accel: Add support for the Bosch-Sensortec BMI088
Message-ID: <20200315120238.18c10af0@archlinux>
In-Reply-To: <20200313140415.20266-1-mike.looijmans@topic.nl>
References: <20200313140415.20266-1-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 15:04:15 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.

There doesn't seem to be a specific compatible entry in the bmg160 driver.
Perhaps we should look to add one?

> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

For a modern driver I'd normally expect to also see DT bindings.
How are you probing this?

There is a lot of half implemented code for features that I assume will follow
in later patches.  Please rip all that out for now.  A simple initial driver
is great but must only include the stuff it actually uses.

Thanks,

Jonathan


> ---
>  drivers/iio/accel/Kconfig             |  17 +
>  drivers/iio/accel/Makefile            |   2 +
>  drivers/iio/accel/bmi088-accel-core.c | 681 ++++++++++++++++++++++++++
>  drivers/iio/accel/bmi088-accel-spi.c  | 100 ++++
>  drivers/iio/accel/bmi088-accel.h      |  11 +
>  5 files changed, 811 insertions(+)
>  create mode 100644 drivers/iio/accel/bmi088-accel-core.c
>  create mode 100644 drivers/iio/accel/bmi088-accel-spi.c
>  create mode 100644 drivers/iio/accel/bmi088-accel.h
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 5d91a6dda894..7ed9c82b731b 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -151,6 +151,23 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config BMI088_ACCEL
> +	tristate "Bosch BMI088 Accelerometer Driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP
> +	select BMI088_ACCEL_SPI
> +	help
> +	  Say yes here to build support for the Bosch BMI088 accelerometer.
> +
> +	  This is a combo module with both accelerometer and gyroscope.
> +	  This driver is only implementing accelerometer part, which has
> +	  its own address and register map.
> +
> +config BMI088_ACCEL_SPI
> +	tristate
> +	select REGMAP_SPI
> +
>  config DA280
>  	tristate "MiraMEMS DA280 3-axis 14-bit digital accelerometer driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 3a051cf37f40..f44613103ae5 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -19,6 +19,8 @@ obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> +obj-$(CONFIG_BMI088_ACCEL) += bmi088-accel-core.o
> +obj-$(CONFIG_BMI088_ACCEL_SPI) += bmi088-accel-spi.o
>  obj-$(CONFIG_DA280)	+= da280.o
>  obj-$(CONFIG_DA311)	+= da311.o
>  obj-$(CONFIG_DMARD06)	+= dmard06.o
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> new file mode 100644
> index 000000000000..d0c7f278ac2b
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -0,0 +1,681 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> + *  - BMI088
> + *
> + * Copyright (c) 2018, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/regmap.h>
> +
> +#include "bmi088-accel.h"
> +
> +#define BMI088_ACCEL_DRV_NAME	"bmi088_accel"
> +#define BMI088_ACCEL_IRQ_NAME	"bmi088_accel_event"
> +
> +#define BMI088_ACCEL_REG_CHIP_ID			0x00
> +
> +#define BMI088_ACCEL_REG_INT_STATUS			0x1D
> +#define BMI088_ACCEL_INT_STATUS_BIT_DRDY		BIT(7)
> +
> +#define BMI088_ACCEL_REG_RESET				0x7E
> +#define BMI088_ACCEL_RESET_VAL				0xB6
> +
> +#define BMI088_ACCEL_REG_PWR_CTRL			0x7D
> +#define BMI088_ACCEL_REG_PWR_CONF			0x7C
> +
> +#define BMI088_ACCEL_REG_INT_MAP_DATA			0x58
> +#define BMI088_ACCEL_INT_MAP_DATA_BIT_INT1_DRDY		BIT(2)
> +#define BMI088_ACCEL_INT_MAP_DATA_BIT_INT2_FWM		BIT(5)
> +
> +#define BMI088_ACCEL_REG_INT1_IO_CONF			0x53
> +#define BMI088_ACCEL_INT1_IO_CONF_BIT_ENABLE_OUT	BIT(3)
> +#define BMI088_ACCEL_INT1_IO_CONF_BIT_LVL		BIT(1)
> +
> +#define BMI088_ACCEL_REG_INT2_IO_CONF			0x54
> +#define BMI088_ACCEL_INT2_IO_CONF_BIT_ENABLE_OUT	BIT(3)
> +#define BMI088_ACCEL_INT2_IO_CONF_BIT_LVL		BIT(1)
> +
> +#define BMI088_ACCEL_REG_ACC_CONF			0x40
> +#define BMI088_ACCEL_REG_ACC_RANGE			0x41
> +#define BMI088_ACCEL_RANGE_3G				0x00
> +#define BMI088_ACCEL_RANGE_6G				0x01
> +#define BMI088_ACCEL_RANGE_12G				0x02
> +#define BMI088_ACCEL_RANGE_24G				0x03
> +
> +#define BMI088_ACCEL_REG_TEMP				0x22
> +#define BMI088_ACCEL_TEMP_CENTER_VAL			23
> +#define BMI088_ACCEL_TEMP_UNIT				125
> +
> +#define BMI088_ACCEL_REG_XOUT_L				0x12
> +#define BMI088_ACCEL_AXIS_TO_REG(axis) \
> +	(BMI088_ACCEL_REG_XOUT_L + (axis * 2))
> +
> +#define BMI088_ACCEL_MAX_STARTUP_TIME_MS		1
> +
> +#define BMI088_ACCEL_REG_FIFO_STATUS			0x0E
> +#define BMI088_ACCEL_REG_FIFO_CONFIG0			0x48
> +#define BMI088_ACCEL_REG_FIFO_CONFIG1			0x49
> +#define BMI088_ACCEL_REG_FIFO_DATA			0x3F
> +#define BMI088_ACCEL_FIFO_LENGTH			100
> +
> +#define BMI088_ACCEL_FIFO_MODE_FIFO			0x40
> +#define BMI088_ACCEL_FIFO_MODE_STREAM			0x80
> +
> +enum bmi088_accel_axis {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +	AXIS_MAX,
> +};
> +
> +enum bmi088_power_modes {
> +	BMI088_ACCEL_MODE_ACTIVE,
> +	BMI088_ACCEL_MODE_SUSPEND,
> +};
> +
> +/* Available OSR (over sampling rate) */
> +enum bmi088_osr_modes {
> +	BMI088_ACCEL_MODE_OSR_NORMAL = 0xA,
> +	BMI088_ACCEL_MODE_OSR_2 = 0x9,
> +	BMI088_ACCEL_MODE_OSR_4 = 0x8,
> +};
> +
> +/* Available ODR (output data rates) in Hz */
> +enum bmi088_odr_modes {
> +	BMI088_ACCEL_MODE_ODR_12_5 = 0x5,
> +	BMI088_ACCEL_MODE_ODR_25 = 0x6,
> +	BMI088_ACCEL_MODE_ODR_50 = 0x7,
> +	BMI088_ACCEL_MODE_ODR_100 = 0x8,
> +	BMI088_ACCEL_MODE_ODR_200 = 0x9,
> +	BMI088_ACCEL_MODE_ODR_400 = 0xa,
> +	BMI088_ACCEL_MODE_ODR_800 = 0xb,
> +	BMI088_ACCEL_MODE_ODR_1600 = 0xc,
> +};
> +
> +struct bmi088_scale_info {
> +	int scale;
> +	u8 reg_range;
> +};
> +
> +struct bmi088_accel_chip_info {
> +	const char *name;
> +	u8 chip_id;
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +	const struct bmi088_scale_info scale_table[4];
> +};
> +
> +struct bmi088_accel_interrupt {
> +	const struct bmi088_accel_interrupt_info *info;
> +	atomic_t users;
> +};
> +
> +
> +enum bmi088_accel_interrupt_id {
> +	BMI088_ACCEL_INT_DATA_READY,
> +	BMI088_ACCEL_INT_FIFO_WATERMARK,
> +	BMI088_ACCEL_INTERRUPTS,
> +};
> +
> +struct bmi088_accel_data {
> +	struct regmap *regmap;
> +	int irq;
> +	struct bmi088_accel_interrupt interrupts[BMI088_ACCEL_INTERRUPTS];
> +	struct iio_trigger *dready_trig;
> +	struct mutex mutex;
> +	u8 fifo_mode, watermark;
> +	s16 buffer[8];

Not used.  Please clear out all the parts you aren't currently using and bring
them in when they can be reviewed alongside the code adding the feature that
needs them.

> +	u8 bw_bits;
> +	int ev_enable_state;
> +	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
> +	const struct bmi088_accel_chip_info *chip_info;
> +};
> +
> +const struct regmap_config bmi088_regmap_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x7E,
> +};
> +EXPORT_SYMBOL_GPL(bmi088_regmap_conf);
> +
> +
> +static int bmi088_accel_enable(struct bmi088_accel_data *data,
> +				bool on_off)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL,
> +				on_off ? 0x4 : 0x0);
> +	if (ret < 0) {
> +		dev_err(dev, "Error writing ACC_PWR_CTRL reg\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_set_mode(struct bmi088_accel_data *data,
> +				enum bmi088_power_modes mode)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CONF,
> +			   mode == BMI088_ACCEL_MODE_SUSPEND ? 0x3 : 0x0);
> +	if (ret < 0) {
> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_set_bw(struct bmi088_accel_data *data,
> +				enum bmi088_odr_modes odr_mode,
> +				enum bmi088_osr_modes osr_mode)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	u8 value = (osr_mode << 4) | (odr_mode & 0xF);
> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_CONF, value);
> +	if (ret < 0) {
> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_get_bw(struct bmi088_accel_data *data, int *val,
> +			       int *val2)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	unsigned int value;
> +
> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
> +			  &value);
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading ACC_CONF reg\n");
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +
> +	*val = (value & 0xF); /* ODR */
> +	*val2 = (value >> 4); /* OSR */

Superficially it seems unlikely that will map directly to the IIO defined
ABI. See docs ref below.

> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	u8 value[2];
> +	unsigned int temp;
> +
> +	mutex_lock(&data->mutex);
> +
> +	/* Read temp reg MSB */

Seems likely it's reading the whole thing..

> +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_REG_TEMP,
> +			       &value, sizeof(value));

Buffers to regmap_bulk_read need to be DMA safe.  No buffer on the stack
is.  Look at how we do it in other drivers with __cacheline_aligned within
the structure behind iio_priv.

> +	if (ret < 0) {
> +		dev_err(dev, "Error reading BMI088_ACCEL_REG_TEMP\n");
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +	temp = (unsigned int)value[0] << 3;
> +	temp |= (value[1] >> 5);
this looks like an endian conversion with a shift after?  Please do
it as that, rather than explicitly.  On some hosts the endian conversion
will be a noop.

> +
> +	if (temp > 1023)
> +		*val = temp - 2028;
> +	else
> +		*val = temp;
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int bmi088_accel_get_axis(struct bmi088_accel_data *data,
> +				 struct iio_chan_spec const *chan,
> +				 int *val)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	int axis = chan->scan_index;
> +	__le16 raw_val;
> +
> +	mutex_lock(&data->mutex);
> +
> +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_AXIS_TO_REG(axis),
> +			       &raw_val, sizeof(raw_val));
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading axis %d\n", axis);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
> +			     chan->scan_type.realbits - 1);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int range;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return bmi088_accel_get_temp(data, val);
> +		case IIO_ACCEL:
> +			if (iio_buffer_enabled(indio_dev))

We have iio_device_claim_direct_mode and friends
to safely protect against a transition in mode during a sysfs read.

> +				return -EBUSY;
> +
> +			ret = regmap_read(data->regmap,
> +				BMI088_ACCEL_REG_ACC_RANGE, &range);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = bmi088_accel_get_axis(data, chan, val);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = (*val * 3 * 980 * (0x01 << range)) >> 15;

Rather feels like you are applying some scaling here that should be left
to userspace.  When you add buffered support you won't want to do this
and hence you'll end up with an inconsistent interface if you do it
the sysfs path.

> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = BMI088_ACCEL_TEMP_CENTER_VAL;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = BMI088_ACCEL_TEMP_UNIT;
> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +		{
> +			ret = regmap_read(data->regmap,
> +					BMI088_ACCEL_REG_ACC_RANGE, val);

Feels unlikely that that is is returning an appropriate value for scale.
See the ABI docs

Documentation/ABI/testing/sysfs-bus-iio*


> +			if (ret < 0) {
> +				dev_err(&indio_dev->dev,
> +					"%s(): Read from device failed(%d)\n",
> +					__func__, ret);
> +				return -EINVAL;
> +			}
> +
> +			return IIO_VAL_INT;
> +		}
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmi088_accel_get_bw(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int val, int val2, long mask)
> +{
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmi088_accel_set_bw(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("12.5 25 50 100 200 400 800 1600");
> +
> +static struct attribute *bmi088_accel_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bmi088_accel_attrs_group = {
> +	.attrs = bmi088_accel_attributes,
> +};
> +
> +#define BMI088_ACCEL_CHANNEL(_axis, bits) {				\
> +	.type = IIO_ACCEL,						\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##_axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.scan_index = AXIS_##_axis,					\
> +	.scan_type = {							\

bring this in only when you add buffered support.

> +		.sign = 's',						\
> +		.realbits = (bits),					\
> +		.storagebits = 16,					\
> +		.shift = 16 - (bits),					\
> +		.endianness = IIO_LE,					\
> +	},								\
> +}
> +
> +#define BMI088_ACCEL_CHANNELS(bits) {					\
> +	{								\
> +		.type = IIO_TEMP,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				      BIT(IIO_CHAN_INFO_SCALE) |	\
> +				      BIT(IIO_CHAN_INFO_OFFSET),	\
> +		.scan_index = -1,					\
> +	},								\
> +	BMI088_ACCEL_CHANNEL(X, bits),					\
> +	BMI088_ACCEL_CHANNEL(Y, bits),					\
> +	BMI088_ACCEL_CHANNEL(Z, bits),					\
> +	IIO_CHAN_SOFT_TIMESTAMP(3),					\
> +}
> +
> +static const struct iio_chan_spec bmi088_accel_channels[] =
> +	BMI088_ACCEL_CHANNELS(16);
> +
> +static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
> +	[0] = {
> +		.name = "BMI088A",

lower case for names in the sysfs interface (not sure that's actually documented
anywhere though... :(

> +		.chip_id = 0x1E,
> +		.channels = bmi088_accel_channels,
> +		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +		.scale_table = { {9610, BMI088_ACCEL_RANGE_3G},
> +				 {19122, BMI088_ACCEL_RANGE_6G},
> +				 {38344, BMI088_ACCEL_RANGE_12G},
> +				 {76590, BMI088_ACCEL_RANGE_24G} },

bring the scale table in when you support using it.

> +		},
> +};
> +
> +static const struct iio_info bmi088_accel_info = {
> +	.attrs			= &bmi088_accel_attrs_group,
> +	.read_raw		= bmi088_accel_read_raw,
> +	.write_raw		= bmi088_accel_write_raw,
> +};
> +
> +static const unsigned long bmi088_accel_scan_masks[] = {
> +					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +					0};
> +
> +
> +
> +#ifdef CONFIG_PM
> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
> +	bool on)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	if (on) {
> +		ret = pm_runtime_get_sync(dev);

> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret = pm_runtime_put_autosuspend(dev);

Seems you are using autosuspend which is good. However, I'm not
seeing the setup of times etc that I'd expect to see in probe.

> +	}
> +
> +	if (ret < 0) {
> +		dev_err(dev, "Failed: %s(%d)\n", __func__, on);
> +		if (on)
> +			pm_runtime_put_noidle(dev);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
> +	bool on)
> +{

Hmm. It's a bit irritating that not all the of the runtime_pm calls are safe
when it's not built.  I guess a few might have unexpected results as 
'do nothing' isn't always the right option.

> +	return 0;
> +}
> +#endif
> +
> +static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret, i;
> +	unsigned int val;
> +
> +	/* Do a dummy read (of chip ID), to enable SPI interface */
> +	regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);

Given this is in the generic code, not the SPI code, should probably
put something about "if SPI in use, does no harm otherwise".

> +
> +	/*
> +	 * Reset chip to get it in a known good state. A delay of 1ms after
> +	 * reset is required according to the data sheet
> +	 */
> +	regmap_write(data->regmap, BMI088_ACCEL_REG_RESET,
> +		     BMI088_ACCEL_RESET_VAL);
> +	usleep_range(1000, 2000);
> +
> +	/* Do a dummy read (of chip ID), to enable SPI interface after reset */
> +	regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
> +
> +	/* Read chip ID */
> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Error: Reading chip id\n");
> +		return ret;
> +	}
> +
> +	/* Validate chip ID */
> +	dev_dbg(dev, "Chip Id %x\n", val);
> +	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++) {
> +		if (bmi088_accel_chip_info_tbl[i].chip_id == val) {
> +			data->chip_info = &bmi088_accel_chip_info_tbl[i];
> +			break;
> +		}
> +	}
> +
> +	if (!data->chip_info) {
> +		dev_err(dev, "Invalid chip %x\n", val);
> +		return -ENODEV;
> +	}
> +
> +	/* Set Active mode (and wait for 5ms) */
> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(5000, 10000);
> +
> +	/* Enable accelerometer */
> +	ret = bmi088_accel_enable(data, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set Bandwidth */
> +	ret = bmi088_accel_set_bw(data, BMI088_ACCEL_MODE_ODR_100,
> +		BMI088_ACCEL_MODE_OSR_NORMAL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set Default Range */
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE,
> +			   BMI088_ACCEL_RANGE_6G);
> +	if (ret < 0) {
> +		dev_err(dev, "Error writing ACC_RANGE\n");

In consistent.  Either have dev_err for all such cases, or none.  I'm perfectly
happy with either, but not a mixture :)

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
> +	int irq, const char *name, bool block_supported)
> +{
> +	struct bmi088_accel_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	data->irq = irq;
> +
> +	data->regmap = regmap;
> +
> +	ret = bmi088_accel_chip_init(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->channels = data->chip_info->channels;
> +	indio_dev->num_channels = data->chip_info->num_channels;
> +	indio_dev->name = name ? name : data->chip_info->name;

Should probably always be the chip_info->name.  If not, please add
a comment saying why not.

> +	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &bmi088_accel_info;
> +
> +	if (ret < 0) {

Seems like you are currently missing the buffered setup.

> +		dev_err(dev, "Failed: iio triggered buffer setup\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to register iio device\n");
> +		iio_trigger_unregister(data->dready_trig);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bmi088_accel_core_probe);
> +
> +int bmi088_accel_core_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);

This runtime PM stuff doesn't clearly match with undoing stuff
set up in probe. 

> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(bmi088_accel_core_remove);
> +
> +#ifdef CONFIG_PM_SLEEP

Change to marking these __maybe_unused.  The dance with CONFIG_PM*
goes wrong too often so these days it's preferred to just let
the compiler / linker deal with these functions not being used
if they are never called.

> +static int bmi088_accel_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);

Is it worth going further for suspend / resume and looking at whether
some of the power supplies can be disabled?  

Note that you'd need regulator support to do that.

The first patch we get to almost every driver is when someone finds
they need to add regulator enable / disable for their board.   Easier to
add it from the start if you are happy to do so.

> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM
> +static int bmi088_accel_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	dev_dbg(dev,  __func__);

Drop these as no useful information that can't be obtained via numerous
other methods (ftrace etc)

> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +	if (ret < 0)
> +		return -EAGAIN;

I'd like a comment for this to explain why we might want to back off and
try again.

> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	dev_dbg(dev,  __func__);
> +
> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(BMI088_ACCEL_MAX_STARTUP_TIME_MS * 1000,
> +		BMI088_ACCEL_MAX_STARTUP_TIME_MS * 1000 * 2);
> +
> +	return 0;
> +}
> +#endif
> +
> +const struct dev_pm_ops bmi088_accel_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(bmi088_accel_suspend, bmi088_accel_resume)
> +	SET_RUNTIME_PM_OPS(bmi088_accel_runtime_suspend,
> +			   bmi088_accel_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(bmi088_accel_pm_ops);
> +
> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMI088 accelerometer driver (core)");
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> new file mode 100644
> index 000000000000..920e146f07d3
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> + *  - BMI088
> + *
> + * Copyright (c) 2018, Topic Embedded Products

Probably change that to 2018-2020 given at least some changes are going
to come out of this review :)

> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>

Why acpi header?

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I don't think either of iio headers is used in this file.

> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +
> +#include "bmi088-accel.h"
> +
> +int bmi088_regmap_spi_write(void *context, const void *data, size_t count)
> +{
> +	struct spi_device *spi = context;
> +	u8 buf[count];
> +
> +	memcpy(buf, data, count);
> +
> +	dev_dbg(&spi->dev, "Write val: %x to reg: %x\n", buf[1], buf[0]);
> +
> +	/*
> +	 * The SPI register address (= full register address without bit 7)
> +	 * and the write command (bit7 = RW = '0')
> +	 */
> +	buf[0] &= ~0x80;
> +
> +	return spi_write(spi, buf, count);
> +}
> +
> +int bmi088_regmap_spi_read(void *context, const void *reg,
> +				size_t reg_size, void *val, size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	u8 addr[reg_size + 1];
> +
> +	addr[0] = *(u8 *)reg;
> +
> +	dev_dbg(&spi->dev, "Read reg: %x\n", addr[0]);
> +
> +	addr[0] |= 0x80; /* bit7 = RW = '1' */
> +
> +	/* Do a write of 2 to mimic the dummy byte (see datasheet) */

So I'm guessing reg_size is always 1.  Hence the 2.  I'd make that explicit
in this code, perhaps with a sanity check on reg_size.  That will make
the comment more obviously reflect what is happening.

> +	return spi_write_then_read(spi, addr, sizeof(addr), val, val_size);
> +}
> +
> +static struct regmap_bus bmi088_regmap_bus = {
> +	.write = bmi088_regmap_spi_write,
> +	.read = bmi088_regmap_spi_read,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
> +static int bmi088_accel_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	regmap = devm_regmap_init(&spi->dev, &bmi088_regmap_bus,
> +			spi, &bmi088_regmap_conf);
> +
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, id->name,
> +				       true);
> +}
> +
> +static int bmi088_accel_remove(struct spi_device *spi)
> +{
> +	return bmi088_accel_core_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id bmi088_accel_id[] = {
> +	{"bmi088_accel", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
> +
> +static struct spi_driver bmi088_accel_driver = {
> +	.driver = {
> +		.name	= "bmi088_accel_spi",
> +	},
> +	.probe		= bmi088_accel_probe,
> +	.remove		= bmi088_accel_remove,
> +	.id_table	= bmi088_accel_id,
> +};
> +module_spi_driver(bmi088_accel_driver);
> +
> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMI088 accelerometer driver (SPI)");
> diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
> new file mode 100644
> index 000000000000..540993647c75
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BMI088_ACCEL_H
> +#define BMI088_ACCEL_H
> +
> +extern const struct regmap_config bmi088_regmap_conf;
> +
> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> +			    const char *name, bool block_supported);
> +int bmi088_accel_core_remove(struct device *dev);
> +
> +#endif /* BMI088_ACCEL_H */

