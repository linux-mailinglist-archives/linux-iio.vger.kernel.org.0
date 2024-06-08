Return-Path: <linux-iio+bounces-6062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206059012BC
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 18:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2651F21CED
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22C179675;
	Sat,  8 Jun 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny9ckmsc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB81E888;
	Sat,  8 Jun 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717863753; cv=none; b=o5IU1EyXOBs2Ddt3aPyLFxSDkGlUU7pdnX6HFx4mc2ba+FQNe9pB42eyo+FR1ovkSynlSztPgfA/LUST12uQeS4nE+/dVYweHzuGkFV93uVAb3OjdxKZdH8LhA1pmuT+Pi3cYthteAOy0xaAC0/rcr7OkID1bjxE9exTLggODGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717863753; c=relaxed/simple;
	bh=fMr6sMxj7Ht/x9aGUa1SMWlPOlunrLg7azotLZN1TSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbvqoZvR5EyLN/J0NfLTwLkv7pZoCki/lY1fmadRDYI+hghmnsVdiJ/YJT1rP4wwTGTVGf8Qx5M/Nc0yUAjjpB+XtRY2FidyRWKpb48kMmXZlhMM+fsQPx8JNEP+nkOGI/O3LlB/tAi048qWAVVG/yZpghtTZ7dT4tXmW56jzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny9ckmsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD50C2BD11;
	Sat,  8 Jun 2024 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717863752;
	bh=fMr6sMxj7Ht/x9aGUa1SMWlPOlunrLg7azotLZN1TSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ny9ckmscVefvZhw5bAi96kPrEPUlP2/XW8QQihTPJadfgXmlwc+9Qlt2eh0lG92gr
	 BK7JDtP1AbtBh29iGKcRLHAOqsXYtRVmWeOa9xS12hg6OP8uTRCx7hyLmnKy1hf/AX
	 VTS/kt0yCK1rNRCFsKfdY/thJ2nVIfhWXrMKbOaAHCeePaSJdagaALXP05Hqo/lk3H
	 pDf/vCw4hUJnDbnn86JHlCvI66kwbW9EIk5iIrtTnvaB2MYb+rpNffzD7/M65dfwt/
	 5Lhf17EzcDmgRnZuaPy+LR96JV5ecwLZrtRbCdBoswqa96FIonE+80qGmGAUeSl8YS
	 ERTJ/HKa7xE/Q==
Date: Sat, 8 Jun 2024 17:22:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mudit Sharma <muditsharma.info@gmail.com>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, ivan.orlov0322@gmail.com, javier.carrasco.cruz@gmail.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240608172227.17996c75@jic23-huawei>
In-Reply-To: <20240606162948.83903-2-muditsharma.info@gmail.com>
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
	<20240606162948.83903-2-muditsharma.info@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 17:29:42 +0100
Mudit Sharma <muditsharma.info@gmail.com> wrote:

> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt
> pin. Interrupt occurs when the signal from the selected interrupt
> source channel crosses set interrupt threshold high or low level.
> 
> This driver includes device attributes to configure the following:
> - Interrupt pin latch: The interrupt pin can be configured to
>   be latched (until interrupt register (0x60) is read or initialized)
>   or update after each measurement.
> - Interrupt source: The colour channel that will cause the interrupt
>   when channel will cross the set threshold high or low level.
> 
> This driver also includes device attributes to present valid
> configuration options/values for:
> - Integration time
> - Interrupt colour source
> - Hardware gain
> 
> Add myself as the maintainer for this driver in MAINTAINERS.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Mudit,

Welcome to IIO.

Some comments inline.  Some apply more widely than where I've
called them out, so please look for similar cases and tidy them all
up for v5.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> new file mode 100644
> index 000000000000..7962cf1c4b52
> --- /dev/null
> +++ b/drivers/iio/light/bh1745.c
> @@ -0,0 +1,863 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ROHM BH1745 digital colour sensor driver
> + *
> + * Copyright (C) Mudit Sharma <muditsharma.info@gmail.com>
> + *
> + * 7-bit I2C slave addresses:
> + *  0x38 (ADDR pin low)
> + *  0x39 (ADDR pin high)
> + *
This blank line seems unnecessary

> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/events.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define BH1745_MOD_NAME "bh1745"
Drop this as it's not used and not particularly useful.

> +
> +/* BH1745 config regs */
> +#define BH1745_SYS_CTRL 0x40
> +
> +#define BH1745_MODE_CTRL_1 0x41
> +#define BH1745_MODE_CTRL_2 0x42
> +#define BH1745_MODE_CTRL_3 0x44
> +
> +#define BH1745_INTR 0x60
> +#define BH1745_INTR_STATUS BIT(7)
> +
> +#define BH1745_PERSISTENCE 0x61
> +
> +#define BH1745_TH_LSB 0x62
> +#define BH1745_TH_MSB 0x63
> +
> +#define BH1745_TL_LSB 0x64
> +#define BH1745_TL_MSB 0x65
> +
> +#define BH1745_THRESHOLD_MAX 0xFFFF
> +#define BH1745_THRESHOLD_MIN 0x0
I think these are only used in one place and are 'real' not 'magic' numbers
so I'd just put the values there.

> +
> +#define BH1745_MANU_ID 0X92

Reading the manufacturer id back and printing a dev_warn() if it
doesn't match the expected can be useful for detecting when DT hasn't
been updated for a new board design and we aren't absolutely sure the
device is compatible.

> +
> +/* BH1745 output regs */
> +#define BH1745_R_LSB 0x50
I'd spell out RED, GREEN, BLUE, CLEAR
(CLEAR in particular as I thought it meant color for a while)

> +#define BH1745_R_MSB 0x51
> +#define BH1745_G_LSB 0x52
> +#define BH1745_G_MSB 0x53
> +#define BH1745_B_LSB 0x54
> +#define BH1745_B_MSB 0x55
> +#define BH1745_CLR_LSB 0x56
> +#define BH1745_CLR_MSB 0x57
> +
> +#define BH1745_SW_RESET BIT(7)
> +#define BH1745_INT_RESET BIT(6)
> +
> +#define BH1745_MEASUREMENT_TIME_MASK GENMASK(2, 0)
> +
> +#define BH1745_RGBC_EN BIT(4)
> +
> +#define BH1745_ADC_GAIN_MASK GENMASK(1, 0)
> +
> +#define BH1745_INT_ENABLE BIT(0)
> +#define BH1745_INT_SIGNAL_ACTIVE BIT(7)
> +
> +#define BH1745_INT_SIGNAL_LATCHED BIT(4)
> +#define BH1745_INT_SIGNAL_LATCH_OFFSET 4
Use FIELD_PREP() and FIELD_GET() through out and all
you need is the masks as those macros derive offsets
from the mask.

Then you can drop the defines for offsets.

> +
> +#define BH1745_INT_SOURCE_MASK GENMASK(3, 2)
> +#define BH1745_INT_SOURCE_OFFSET 2
> +
> +#define BH1745_INT_TIME_AVAILABLE "0.16 0.32 0.64 1.28 2.56 5.12"
> +#define BH1745_HARDWAREGAIN_AVAILABLE "1 2 16"
> +#define BH1745_INT_COLOUR_CHANNEL_AVAILABLE \
> +	"0 (Red Channel) 1 (Green Channel) 2 (Blue channel) 3 (Clear channel)"
> +
> +static const int bh1745_int_time[][2] = {
> +	{ 0, 160000 }, /* 160 ms */
> +	{ 0, 320000 }, /* 320 ms */
> +	{ 0, 640000 }, /* 640 ms */
> +	{ 1, 280000 }, /* 1280 ms */
> +	{ 2, 560000 }, /* 2560 ms */
> +	{ 5, 120000 }, /* 5120 ms */
> +};
> +
> +static const u8 bh1745_gain_factor[] = { 1, 2, 16 };
> +
> +enum bh1745_int_source {
> +	BH1745_INT_SOURCE_RED,
> +	BH1745_INT_SOURCE_GREEN,
> +	BH1745_INT_SOURCE_BLUE,
> +	BH1745_INT_SOURCE_CLEAR,
> +};
> +
> +enum bh1745_gain {
> +	BH1745_ADC_GAIN_1X,
> +	BH1745_ADC_GAIN_2X,
> +	BH1745_ADC_GAIN_16X,
> +};
> +
> +enum bh1745_measurement_time {
> +	BH1745_MEASUREMENT_TIME_160MS,
> +	BH1745_MEASUREMENT_TIME_320MS,
> +	BH1745_MEASUREMENT_TIME_640MS,
> +	BH1745_MEASUREMENT_TIME_1280MS,
> +	BH1745_MEASUREMENT_TIME_2560MS,
> +	BH1745_MEASUREMENT_TIME_5120MS,
> +};
> +
> +enum bh1745_presistence_value {
> +	BH1745_PRESISTENCE_UPDATE_TOGGLE,
> +	BH1745_PRESISTENCE_UPDATE_EACH_MEASUREMENT,
> +	BH1745_PRESISTENCE_UPDATE_FOUR_MEASUREMENT,
> +	BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT,
> +};
> +
> +struct bh1745_data {
> +	struct mutex lock;

What data does this lock protect?  Locks should always have a
comment on this as it is rarely that obvious.

> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	u8 mode_ctrl1;

Why do you need to cache them?  If you do, use regmap caching
to do it for you.

> +	u8 mode_ctrl2;
> +	u8 int_src;
> +	u8 int_latch;
> +	u8 interrupt;
> +};

> +static const struct iio_event_spec bh1745_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +};
> +
> +#define BH1745_CHANNEL(_colour, _si, _addr)                                   \
> +	{                                                                     \
> +		.type = IIO_INTENSITY, .modified = 1,                         \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                 \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \

Provide _SCALE instead of HARDWAREGAIN
As it's an intensity channel (and units are tricky for color sensors given
frequency dependence etc) all you need to do is ensure that if you halve
the _scale and measure the same light source, the computed
_RAW * _SCALE value remains constant.

> +					    BIT(IIO_CHAN_INFO_INT_TIME),      \
> +		.event_spec = bh1745_event_spec,                              \
> +		.num_event_specs = ARRAY_SIZE(bh1745_event_spec),             \
> +		.channel2 = IIO_MOD_LIGHT_##_colour, .address = _addr,        \
> +		.scan_index = _si,                                            \
> +		.scan_type = {                                                \
> +			.sign = 'u',                                          \
> +			.realbits = 16,                                       \
> +			.storagebits = 16,                                    \
> +			.endianness = IIO_CPU,                                \
> +		},                                                            \
> +	}
> +
> +static const struct iio_chan_spec bh1745_channels[] = {
> +	BH1745_CHANNEL(RED, 0, BH1745_R_LSB),
> +	BH1745_CHANNEL(GREEN, 1, BH1745_G_LSB),
> +	BH1745_CHANNEL(BLUE, 2, BH1745_B_LSB),
> +	BH1745_CHANNEL(CLEAR, 3, BH1745_CLR_LSB),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +static int bh1745_write_value(struct bh1745_data *data, u8 reg, void *value,
> +			      size_t len)
> +{
> +	int ret;
These wrappers are of limited value. I'd get rid of them and make
direct regmap calls.

Regmap has a lot of debug print handling etc so no need to print
your own messages unless they convey more meaning such as 'what'
the write that failed was about.  That is better known at callers.

In many cases you are only writing one register so you can use
the simpler regmap_write()


> +
> +	ret = regmap_bulk_write(data->regmap, reg, value, len);
> +	if (ret < 0) {
regmap never returns > 0
so it is a good idea to just check
	if (ret)
through out - that avoids the handling being different for earlier
calls
	if (ret < 0)
		return ret;
which just leaves postive values in place.
and final calls
	return XXX;
which return the positive.

If you make it such that ret is never positive and so just use
if (ret)
everything is much more consistent and easier to read.

> +		dev_err(&data->client->dev,
> +			"Failed to write to sensor. Reg: 0x%x\n", reg);
> +	}
> +
> +	return ret;
> +}
> +
> +static int bh1745_read_value(struct bh1745_data *data, u8 reg, void *value,
> +			     size_t len)
> +{
> +	int ret;
> +
As for write. I'm not convinced this adds anything beyond making bulk
calls for single accesses which is not a good thing to do.

> +	ret = regmap_bulk_read(data->regmap, reg, value, len);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Failed to read from sensor. Reg: 0x%x\n", reg);
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t in_interrupt_source_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	int ret;
> +	int value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	ret = bh1745_read_value(data, BH1745_INTR, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	value &= BH1745_INT_SOURCE_MASK;
> +
> +	return sprintf(buf, "%d\n", value >> 2);
> +}
> +
> +static ssize_t in_interrupt_source_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t len)
As mentioned elsewhere I don't see why this can't be done with 4
event enables and a policy of last one set wins.  
It's common for devices to support a limited number of events
at a time so userspace needs to be aware of that and check to
see whether events it previously enable are still enabled after
requesting a new one.


> +{
> +	int ret;
> +	u16 value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	ret = kstrtou16(buf, 10, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (value > BH1745_INT_SOURCE_CLEAR) {
> +		dev_err(dev,
> +			"Supplied value: '%d' for interrupt source is invalid\n",
> +			value);
> +		return -EINVAL;
> +	}
> +	guard(mutex)(&data->lock);
> +	data->int_src = value;
> +	value = value << BH1745_INT_SOURCE_OFFSET;
> +	ret = bh1745_read_value(data, BH1745_INTR, &data->interrupt, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->interrupt &= ~BH1745_INT_SOURCE_MASK;
> +	data->interrupt |= value;
> +	ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t in_interrupt_latch_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	int value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	ret = bh1745_read_value(data, BH1745_INTR, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	value &= BH1745_INT_SIGNAL_LATCHED;
> +	if (value)
> +		return sprintf(buf, "1\n");
> +
> +	return sprintf(buf, "0\n");

Always enable latch.  We don't want an interrupt storm so
latch on and level interrupt is probably the best option for a linux driver.
Note level not edge unless the driver guarantees to drop the interrupt
line for substantial time after the interrupt is cleared.

Providing userspace control for this is not likely to be very useful.

> +}
> +
> +static ssize_t in_interrupt_latch_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	int ret;
> +	u16 value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	ret = kstrtou16(buf, 10, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (value > 1) {
> +		dev_err(dev, "Value out of range for latch setup. Supported values '0' or '1'\n");
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&data->lock);
> +	data->int_latch = value;
> +	ret = bh1745_read_value(data, BH1745_INTR, &data->interrupt, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (value == 0)
> +		data->interrupt &= ~BH1745_INT_SIGNAL_LATCHED;
> +	else
> +		data->interrupt |= BH1745_INT_SIGNAL_LATCHED;
> +
> +	ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t hardwaregain_available_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	return sprintf(buf, "%s\n", BH1745_HARDWAREGAIN_AVAILABLE);
> +}
> +
> +static ssize_t interrupt_source_available_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	return sprintf(buf, "%s\n", BH1745_INT_COLOUR_CHANNEL_AVAILABLE);
> +}
> +
> +static IIO_DEVICE_ATTR_RW(in_interrupt_source, 0);

Why don't he normal event enables work for this?

> +static IIO_DEVICE_ATTR_RW(in_interrupt_latch, 0);
> +static IIO_DEVICE_ATTR_RO(hardwaregain_available, 0);

Hardware gain is actually rarely seen.  It is intended for cases
where the gain is independent from the actual type of signal being
measured. e.g. light gain in a time of flight sensor which is measuring
distance.

Mostly we map controls of sensor gain to either
scale, or calibscale (if they are meant to correct for variation
between sensors coming off the production line).

> +static IIO_DEVICE_ATTR_RO(interrupt_source_available, 0);
> +static IIO_CONST_ATTR_INT_TIME_AVAIL(BH1745_INT_TIME_AVAILABLE);
> +
> +static struct attribute *bh1745_attrs[] = {
> +	&iio_dev_attr_in_interrupt_source.dev_attr.attr,
> +	&iio_dev_attr_in_interrupt_latch.dev_attr.attr,

Custom ABI needs documentation. Note that you need a very strong justification
for it.  So first step is to consider if any existing ABI is appropriate.
See Documentation/ABI/testing/sysfs-bus-iio*


> +	&iio_dev_attr_hardwaregain_available.dev_attr.attr,
> +	&iio_dev_attr_interrupt_source_available.dev_attr.attr,
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
Use the get_avail() callback for the standard ABI.

> +	NULL
> +};
> +
> +static const struct attribute_group bh1745_attr_group = {
> +	.attrs = bh1745_attrs,
> +};
> +
> +static int bh1745_reset(struct bh1745_data *data)
> +{
> +	int ret;
> +	u8 value;
> +
> +	ret = bh1745_read_value(data, BH1745_SYS_CTRL, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	value |= (BH1745_SW_RESET | BH1745_INT_RESET);
> +
> +	return bh1745_write_value(data, BH1745_SYS_CTRL, &value, 1);
This is an example of the different handling for ret depending on whether
it is the last call or not that I mention above.

	if (ret)
for all error checks and it becomes consistent.

That way you can do if (ret) to check if hb1745_reset() has failed at call
sites etc.


> +}
> +
> +static int bh1745_power_on(struct bh1745_data *data)
> +{
> +	int ret;
> +	u8 value;
> +
> +	ret = bh1745_read_value(data, BH1745_MODE_CTRL_2, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +	value |= BH1745_RGBC_EN;
> +	data->mode_ctrl2 = value;
> +	ret = bh1745_write_value(data, BH1745_MODE_CTRL_2, &data->mode_ctrl2, 1);
> +
> +	return ret;

	return bh1745_write...

> +}
> +
> +static int bh1745_power_off(struct bh1745_data *data)
> +{
> +	int ret;
> +	int value;
> +
> +	ret = bh1745_read_value(data, BH1745_MODE_CTRL_2, &value, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +	value &= ~BH1745_RGBC_EN;
> +	data->mode_ctrl2 = value;
> +	ret = bh1745_write_value(data, BH1745_MODE_CTRL_2, &data->mode_ctrl2, 1);
> +
> +	return ret;

same as below. Don't assign to a local variable just to return it on the
next line.

> +}
> +
> +static int bh1745_set_int_time(struct bh1745_data *data, int val, int val2)
> +{
> +	int ret;
> +
> +	for (u8 i = 0; i < ARRAY_SIZE(bh1745_int_time); i++) {
> +		if (val == bh1745_int_time[i][0] &&
> +		    val2 == bh1745_int_time[i][1]) {
> +			guard(mutex)(&data->lock);
> +			data->mode_ctrl1 &= ~BH1745_MEASUREMENT_TIME_MASK;
> +			data->mode_ctrl1 |= i;
> +			ret = bh1745_write_value(data, BH1745_MODE_CTRL_1,
> +						 &data->mode_ctrl1, 1);
> +			return ret;
			return bh17..
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bh1745_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u16 value;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		ret = bh1745_read_value(data, chan->address, &value, 2);
> +		if (ret < 0)
> +			return ret;
Exited with the device held in direct mode for ever.

Use iio_device_claim_direct_mode_scoped() that deals with this
for you.

> +		iio_device_release_direct_mode(indio_dev);
> +		*val = value;
> +		return IIO_VAL_INT;
> +	}
> +
> +	case IIO_CHAN_INFO_HARDWAREGAIN: {
> +		guard(mutex)(&data->lock);
> +		ret = bh1745_read_value(data, BH1745_MODE_CTRL_2,
> +					&data->mode_ctrl2, 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		value = data->mode_ctrl2 & BH1745_ADC_GAIN_MASK;

FIELD_GET() as then we don't need to look to see if GAIN_MASK starts
at bit 0.

> +		*val = bh1745_gain_factor[value];
> +		return IIO_VAL_INT;
> +	}
> +
> +	case IIO_CHAN_INFO_INT_TIME: {
> +		guard(mutex)(&data->lock);
> +		ret = bh1745_read_value(data, BH1745_MODE_CTRL_1,
> +					&data->mode_ctrl1, 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		value = data->mode_ctrl1 & BH1745_MEASUREMENT_TIME_MASK;
FIELD_GET() for this and all similar masking or masking and shifting operations.

> +
> +		*val = bh1745_int_time[value][0];
> +		*val2 = bh1745_int_time[value][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1745_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN: {
> +		for (u8 i = 0; i < ARRAY_SIZE(bh1745_gain_factor); i++) {
> +			if (bh1745_gain_factor[i] == val) {
Flip logic here.
			if (bh1745_gain_factor[i] != val)
				continue;

as reduces indent on the following code whilst remaining almost as easy
to read.

> +				guard(mutex)(&data->lock);
> +				data->mode_ctrl2 &= ~BH1745_ADC_GAIN_MASK;
> +				data->mode_ctrl2 |= i;
> +				ret = bh1745_write_value(data,
> +							 BH1745_MODE_CTRL_2,
> +							 &data->mode_ctrl2, 1);
> +				return ret;

				return bh17...
Then ret unused so drop that as well.
> +			}
> +		}
> +		return -EINVAL;
> +	}
> +
> +	case IIO_CHAN_INFO_INT_TIME: {
> +		return bh1745_set_int_time(data, val, val2);
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1745_read_thresh(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      enum iio_event_type type,
> +			      enum iio_event_direction dir,
> +			      enum iio_event_info info, int *val, int *val2)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = bh1745_read_value(data, BH1745_TH_LSB, val, 2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			ret = bh1745_read_value(data, BH1745_TL_LSB, val, 2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;

Unreachable. Drop this break line.

> +	case IIO_EV_INFO_PERIOD:
> +		ret = bh1745_read_value(data, BH1745_PERSISTENCE, val, 1);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1745_write_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int val, int val2)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (val < BH1745_THRESHOLD_MIN || val > BH1745_THRESHOLD_MAX)
> +			return -EINVAL;
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = bh1745_write_value(data, BH1745_TH_LSB, &val, 2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			ret = bh1745_write_value(data, BH1745_TL_LSB, &val, 2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;

Unreachable so drop this break line

> +	case IIO_EV_INFO_PERIOD:
> +		if (val < BH1745_PRESISTENCE_UPDATE_TOGGLE ||
> +		    val > BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT)
> +			return -EINVAL;
> +		ret = bh1745_write_value(data, BH1745_PERSISTENCE, &val, 1);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info bh1745_info = {
> +	.attrs = &bh1745_attr_group,
> +	.read_raw = bh1745_read_raw,
> +	.write_raw = bh1745_write_raw,
> +	.read_event_value = bh1745_read_thresh,
> +	.write_event_value = bh1745_write_thresh,
> +

Drop this blank line.

> +};
> +
> +static void bh1745_remove(struct i2c_client *client)
Remove almost always comes after probe() as that's where readers
of drivers expect it to be.
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	if (bh1745_power_off(data) < 0)

This suggests you are mixing devm_ handling with manual handling.
I'm fairly sure that in this case you turn the device off before the userspace
interface is removed via devm_ managed cleanup.  That makes little sense.

Use a custom callback and devm_add_action_or_reset()

Also note that you don't turn the power off in error cases in probe().
Use a devm callback will fix that as well.

> +		dev_err(&data->client->dev, "Failed to turn off device");
> +
> +	dev_info(&data->client->dev, "BH1745 driver removed\n");

Drop this.

> +}
> +
> +static int bh1745_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	int ret;
> +	u8 value = 0;
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +	if (state) {
> +		ret = bh1745_read_value(data, BH1745_INTR, &value, 1);

Seems like you should probably mask out the int_latch and int_src
before writing those fields.  Whilst you may guarantee they are always
cleared (I think that happens below) it is more readable to clear them
explicitly here as well.


> +		if (ret < 0)
> +			return ret;
> +		value |= (BH1745_INT_ENABLE |

outer brackets not needed.

> +			(data->int_latch << BH1745_INT_SIGNAL_LATCH_OFFSET) |
> +			(data->int_src << BH1745_INT_SOURCE_OFFSET));

FIELD_PREP() for each of those,

> +		data->interrupt = value;
> +		ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt, 1);
		return bh17..

No need to make reader look to see if anything else happens below.


> +	} else {
> +		data->interrupt = value;
> +		ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt, 1);
		return
> +	}
> +
> +	return ret;
> +}

> +static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	struct {
> +		u16 chans[4];
> +		s64 timestamp __aligned(8);
> +	} scan;
> +	u16 value;
> +	int ret;
> +	int i, j = 0;
> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		ret = bh1745_read_value(data, BH1745_R_LSB + 2 * i, &value, 2);
> +		if (ret < 0)
> +			goto err;
> +		scan.chans[j++] = value;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bh1745_setup_trigger(struct iio_dev *indio_dev)
add a struct device *dev or parent.
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(indio_dev->dev.parent,
I'd pass this the parent in separately, as an additional parameter.

What you have here is correct, but relies a little too much on an internal
detail of the device model and how this IIO device is registered.

> +					    "%sdata-rdy-dev%d", indio_dev->name,
> +					    iio_device_id(indio_dev));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &bh1745_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +	ret = devm_iio_trigger_register(&data->client->dev, data->trig);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret,

You've mixed and matched how to get this parent. Pick a consistent
path. I'd just pass it in to this function from probe()


> +				     "Trigger registration failed\n");
> +
> +	ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					      NULL, bh1745_trigger_handler,
> +					      NULL);
Why is the buffer support dependent on an IRQ?

If it it is I'd expect to see validate callbacks to ensure no other trigger
is used.  In most cases a sysfs or hrtimer trigger can be used but some
care is needed in the driver.  Sometimes the coupling is tighter and
we only allow a device to use it's own trigger.

> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret,
> +				     "Triggered buffer setup failed\n");
> +
> +	ret = devm_request_threaded_irq(&data->client->dev, data->client->irq,
> +					NULL, bh1745_interrupt_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"bh1745_interrupt", indio_dev);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret,
> +				     "Request for IRQ failed\n");
> +
> +	dev_info(&data->client->dev,
> +		 "Triggered buffer and IRQ setup successfully");
To noisy. dev_dbg() at most. Probably no print at all as easy to tell
if this worked from sysfs
> +
> +	return ret;
> +}
> +
> +static int bh1745_init(struct bh1745_data *data)
> +{
	struct device *dev = &data->client->data;
> +	int ret;
> +
> +	mutex_init(&data->lock);
> +	data->mode_ctrl1 = 0;
> +	data->mode_ctrl2 = 0;
> +	data->interrupt = 0;
> +	data->int_src = BH1745_INT_SOURCE_RED;
> +
> +	ret = bh1745_reset(data);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to reset sensor\n");
only called from probe I think so 
	if (ret)
		return dev_err_probe(dev,
> +		return ret;
> +	}
> +
> +	ret = bh1745_power_on(data);
The unwind of this is done manually. It should not (see above)
so after checking if this succeeded, call
devm_add_action_or_reset() with a suitable callback that will turn
the power off again.
> +	if (ret < 0) {
	if (ret)
		return dev_err_probe().

	return 0;

 We know this is the only value, so make it explicit as that helps the reader
understand which is the good path and what can be returned etc.
 
> +		dev_err(&data->client->dev, "Failed to turn on sensor\n");
> +		return ret;
> +	}
> +
> +	return ret;

> +}
> +
> +static int bh1745_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct bh1745_data *data;
> +	struct iio_dev *indio_dev;

struct device *dev = &client->dev;
as you use it several times and will shorten some long lines

> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

Is this ever used?  If not don't set it.

> +	data->client = client;
> +	indio_dev->info = &bh1745_info;
> +	indio_dev->name = "bh1745";
> +	indio_dev->channels = bh1745_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(bh1745_channels);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &bh1745_regmap);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	ret = bh1745_init(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (client->irq) {
> +		ret = bh1745_setup_trigger(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to register device\n");
you had client available, so should have used that.
However add a local dev variable for these.
> +		return ret;
		return dev_err_probe(dev, "Failed to register device\n");
and drop the brackets.

> +	}
> +
> +	dev_info(&data->client->dev, "BH1745 driver loaded\n");
Unnecessary noise. There are lots of other ways to find that out.
So remove this print.

> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id bh1745_idtable[] = {
> +	{ "bh1745" },
> +	{},
> +};
> +
> +static const struct of_device_id bh1745_of_match[] = {
> +	{
> +		.compatible = "rohm,bh1745",
> +	},
> +	{},

No comma on trailing 'NULL' entries as we must never
add anything after them.

> +};
This needs appropriate MODULE_DEVICE_TABLE() as well

> +
> +MODULE_DEVICE_TABLE(i2c, bh1745_idtable);
Move this to immediately after the idtable (no blank line)
> +
> +static struct i2c_driver bh1745_driver = {
> +	.driver = {
> +		.name = "bh1745",
> +		.of_match_table = bh1745_of_match,
> +	},
> +	.probe = bh1745_probe,
> +	.remove = bh1745_remove,
> +	.id_table = bh1745_idtable,
> +};
> +
> +module_i2c_driver(bh1745_driver);
> +MODULE_AUTHOR("Mudit Sharma <muditsharma.info@gmail.com>");
> +MODULE_DESCRIPTION("BH1745 colour sensor driver");
> +MODULE_LICENSE("GPL");


