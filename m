Return-Path: <linux-iio+bounces-12911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B59DF56D
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 12:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF69228110B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5C13D509;
	Sun,  1 Dec 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjtw2r9S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4B2D638;
	Sun,  1 Dec 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733054139; cv=none; b=RjkJcBeku6tcEakQFnQyQuwLLd1lg3dMoODyfsNFxB9mysIcLDit+iP2a4EKdc8BCauy+4O99PrEyAIhjE0HEMeCU+v7GvicoiF56nTHXjIu05dUBRqaUtVYHlzKRUlB7kQb9uVg5+7xWi3cruuglixFj2qyOgvzyZEdwLeFWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733054139; c=relaxed/simple;
	bh=irBSSiYqbnZD690JwLo6sPloN816TWl6fPpNCqj1+h8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJFdT9tgWZbpQuZVkw36knWEpcyYzbla/ceDopZkRbPgJw76+naHff9ms1hZogin0ZhN52FchjXq9IirgEqftVSbfpBERNz1ooqLiNKzy7mSZfXx6FKPGgkNAu8mCAzzukTIVOLrZdGycuu7lLx30QcoPWB6C0fF3o1dEG8nK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjtw2r9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCE1C4CECF;
	Sun,  1 Dec 2024 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733054139;
	bh=irBSSiYqbnZD690JwLo6sPloN816TWl6fPpNCqj1+h8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sjtw2r9S7WTUXkCecth5Zxx71PHVZmuJj3LDrG1k7A6ONC0xeNECIvBzAcx4Z3PFi
	 i3KZJwTqEZJRhZlwrkOQx/Ac6xwF12d1wvOMSPkfRehEJ+6WYUo7Ic6H7isKoU9Uln
	 dll0/EtymrQTwlRISSw4xRdQkKT0gFH2aGhTYESgqOs4TLxhtsZWh+7RnhahyYPsHt
	 WwzVo9eDceUAIjcqYPhtw4iVSpZVZG7IF0uTtPvvq3FwNcb3ZHVyslgAWDbtRVsG4D
	 0G0eCwI8X0dkPnoIEInP4hk09kHv4seJlnCK5+ptUsAkv/h2VEMV0uJtS5HlDRzo66
	 gk7+zSZEtucxg==
Date: Sun, 1 Dec 2024 11:55:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for the TI OPT4048 color
 sensor
Message-ID: <20241201115529.1375c6c3@jic23-huawei>
In-Reply-To: <20241130174212.3298371-2-paulk@sys-base.io>
References: <20241130174212.3298371-1-paulk@sys-base.io>
	<20241130174212.3298371-2-paulk@sys-base.io>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 18:42:12 +0100
Paul Kocialkowski <paulk@sys-base.io> wrote:

> The Texas Instruments OPT4048 is a XYZ tristimulus color sensor,
> with an additional wide (visible + IR) channel.
> 
> This driver implements support for all channels, with configurable
> integration time and auto-gain. Both direct reading and
> triggered-buffer modes are supported.
> 
> Note that the Y channel is also reported as a separate illuminance
> channel, for which a scale is provided (following the datasheet) to
> convert it to lux units. Falling and rising thresholds are supported
> for this channel.
> 
> The device's interrupt can be used to sample all channels at the end
> of conversion and is optional.
> 
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
Hi Paul,

Various comments inline. Most significant is that this seems to be
suitable for a simple dataready trigger that will make your various
interrupt and non interrupt flows more similar.

Jonathan

> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 321010fc0b93..f2031e6236f9 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_MAX44009)		+= max44009.o
>  obj-$(CONFIG_NOA1305)		+= noa1305.o
>  obj-$(CONFIG_OPT3001)		+= opt3001.o
>  obj-$(CONFIG_OPT4001)		+= opt4001.o
> +obj-$(CONFIG_OPT4048)		+= opt4048.o
>  obj-$(CONFIG_PA12203001)	+= pa12203001.o
>  obj-$(CONFIG_ROHM_BU27008)	+= rohm-bu27008.o
>  obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o
> diff --git a/drivers/iio/light/opt4048.c b/drivers/iio/light/opt4048.c
> new file mode 100644
> index 000000000000..1ad5e6586aad
> --- /dev/null
> +++ b/drivers/iio/light/opt4048.c
> @@ -0,0 +1,1145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Paul Kocialkowski <paulk@sys-base.io>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define OPT4048_CH0_DATA0			0x0
> +#define OPT4048_CH0_DATA1			0x1
> +#define OPT4048_CH1_DATA0			0x2
> +#define OPT4048_CH1_DATA1			0x3
> +#define OPT4048_CH2_DATA0			0x4
> +#define OPT4048_CH2_DATA1			0x5
> +#define OPT4048_CH3_DATA0			0x6
> +#define OPT4048_CH3_DATA1			0x7
> +
> +#define OPT4048_CH_DATA0_MSB_VALUE(v)		((v) & GENMASK(11, 0))
> +#define OPT4048_CH_DATA0_EXPONENT_VALUE(v)	(((v) & GENMASK(15, 12)) >> 12)

For all these - just define the masks and use FIELD_GET() / FIELD_PREP()
inline.  Masks should be defined with names that make it clear what they are
masking and in what registers.

> +
> +#define OPT4048_CH_DATA1_CRC_VALUE(v)		((v) & GENMASK(3, 0))
> +#define OPT4048_CH_DATA1_COUNTER_VALUE(v)	(((v) & GENMASK(7, 4)) >> 4)
> +#define OPT4048_CH_DATA1_LSB_VALUE(v)		(((v) & GENMASK(15, 8)) >> 8)
> +
> +#define OPT4048_THRESHOLD_L			0x8
> +#define OPT4048_THRESHOLD_H			0x9
> +
> +#define OPT4048_THRESHOLD_RESULT(v)		((v) & GENMASK(11, 0))
> +#define OPT4048_THRESHOLD_RESULT_MAX		((1 << 12) - 1)
> +#define OPT4048_THRESHOLD_EXPONENT(v)		(((v) << 12) & GENMASK(15, 12))
> +#define OPT4048_THRESHOLD_EXPONENT_MAX		((1 << 4) - 1)
> +
> +#define OPT4048_CFG0				0xa
> +#define OPT4048_CFG0_FAULT_COUNT_1		0
> +#define OPT4048_CFG0_FAULT_COUNT_2		1
> +#define OPT4048_CFG0_FAULT_COUNT_4		2
> +#define OPT4048_CFG0_FAULT_COUNT_8		3
> +#define OPT4048_CFG0_INT_POL_ACTIVE_LOW		0
> +#define OPT4048_CFG0_INT_POL_ACTIVE_HIGH	BIT(2)
> +#define OPT4048_CFG0_LATCH			BIT(3)
> +#define OPT4048_CFG0_OP_MODE_POWER_DOWN		0
> +#define OPT4048_CFG0_OP_MODE_ONESHOT_AUTORANGE	(1 << 4)
> +#define OPT4048_CFG0_OP_MODE_ONESHOT		(2 << 4)
> +#define OPT4048_CFG0_OP_MODE_CONTINUOUS		(3 << 4)
> +#define OPT4048_CFG0_CONVERSION_TIME(v)		(((v) << 6) & GENMASK(9, 6))
> +#define OPT4048_CFG0_RANGE(v)			(((v) << 10) & GENMASK(13, 10))
> +#define OPT4048_CFG0_RANGE_AUTO			(12 << 10)
> +#define OPT4048_CFG0_QWAKE			BIT(15)
> +
> +#define OPT4048_CFG1				0xb
> +#define OPT4048_CFG1_I2C_BURST			BIT(0)
> +#define OPT4048_CFG1_INT_CFG_ALERT		0
> +#define OPT4048_CFG1_INT_CFG_DATA_READY_NEXT	(1 << 2)
> +#define OPT4048_CFG1_INT_CFG_DATA_READY_ALL	(3 << 2)
> +#define OPT4048_CFG1_INT_DIR_IN			0
> +#define OPT4048_CFG1_INT_DIR_OUT		BIT(4)
> +#define OPT4048_CFG1_THRESHOLD_CH_SEL(i)	(((i) << 5) & GENMASK(6, 5))
> +#define OPT4048_CFG1_RESERVED			(0x80 << 7)
> +
> +#define OPT4048_STATUS				0xc
> +#define OPT4048_STATUS_FLAG_L			BIT(0)
> +#define OPT4048_STATUS_FLAG_H			BIT(1)
> +#define OPT4048_STATUS_CONV_READY_FLAG		BIT(2)
> +#define OPT4048_STATUS_OVERLOAD_FLAG		BIT(3)
> +
> +#define OPT4048_DID				0x11
> +#define OPT4048_DID_L_VALUE(v)			(((v) & GENMASK(13, 12)) >> 12)
> +#define OPT4048_DID_H_VALUE(v)			((v) & GENMASK(11, 0))

Just define the masks and use FIELD_GET() to extract the fields.

> +#define OPT4048_DID_VALUE(l, h)			(((h) << 2) | (l))
Use FIELD_PREP for this.

> +
> +#define OPT4048_DID_OPT4048			0x2084
> +
> +#define OPT4048_SCALE_ULUX			2150
> +
> +struct opt4048_sensor_state {
> +	bool active;
> +	u8 conversion_time_index;

Whilst I don't normally care that much, this is really bad for packing.
Put like types together.

> +	u16 threshold_low[2];
> +	bool threshold_low_active;
> +	u16 threshold_high[2];
> +	bool threshold_high_active;
> +	u16 status;
> +};
> +
> +struct opt4048_sensor_scan {
> +	u32 channels[5];
> +	s64 timestamp __aligned(8);

aligned_s64 is now available upstream.


> +};
> +
> +struct opt4048_sensor {
> +	struct device *dev;
> +	struct i2c_client *i2c_client;
> +	struct iio_dev *iio_dev;
> +
> +	struct regulator *vdd_supply;
> +
> +	struct opt4048_sensor_state state;

> +	struct opt4048_sensor_scan scan;

As below. I think you should just always do the read in the trigger handler.

> +	bool scan_sync;

This needs a comment.  Interrupts and sync aren't something that normally goes
together so the name is somewhat confusing.

> +	struct mutex lock;

Locks should always have a comment to say what data they are protecting.

> +};


> +
> +static int opt4048_data_read(struct opt4048_sensor *sensor, u8 address,
> +			     u32 *channel_value)
> +{
> +	struct i2c_client *i2c_client = sensor->i2c_client;
> +	u16 value, result_msb, result_lsb, exponent;
> +	unsigned int index = 0;
> +	u8 values[4] = { 0 };
> +	int ret;
> +
> +	/* Read all values in one transaction to ensure coherency. */
> +	ret = i2c_smbus_read_i2c_block_data(i2c_client, address, 4, values);
> +	if (ret < 0)
> +		return ret;
> +
> +	value = values[index] << 8 | values[index + 1];
As below. Use a __be16 and suitable conversion funcitons.
> +	index += 2;
> +
> +	result_msb = OPT4048_CH_DATA0_MSB_VALUE(value);
> +	exponent = OPT4048_CH_DATA0_EXPONENT_VALUE(value);
> +
> +	value = values[index] << 8 | values[index + 1];
> +
> +	result_lsb = (u16)OPT4048_CH_DATA1_LSB_VALUE(value);
> +
> +	*channel_value = opt4048_data_value(result_msb, result_lsb, exponent);
> +
> +	return 0;
> +}
> +
> +static int opt4048_data_scan(struct opt4048_sensor *sensor,
> +			     struct opt4048_sensor_scan *scan)
> +{
> +	struct i2c_client *i2c_client = sensor->i2c_client;
> +	unsigned int index = 0;
> +	u8 values[16] = { 0 };

Looks like an array of __be16.  Cleaner to define it like that.

> +	unsigned int i;
> +	int ret;
> +
> +	/* Read all values in one transaction to ensure coherency. */
> +	ret = i2c_smbus_read_i2c_block_data(i2c_client, OPT4048_CH0_DATA0, 16,
> +					    values);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < 4; i++) {
> +		u16 value, result_msb, result_lsb, exponent;
> +
> +		value = values[index] << 8 | values[index + 1];
get_unaligned_be16() 

or better still make values an array of __be16 and use
be16_to_cpu()

> +		index += 2;
> +
> +		result_msb = (u16)OPT4048_CH_DATA0_MSB_VALUE(value);
> +		exponent = (u16)OPT4048_CH_DATA0_EXPONENT_VALUE(value);

Use FIELD_GET() and suitable masks for this.

> +
> +		value = values[index] << 8 | values[index + 1];
> +		index += 2;
> +
as above..

> +		result_lsb = (u16)OPT4048_CH_DATA1_LSB_VALUE(value);
> +
> +		scan->channels[i] =
> +			opt4048_data_value(result_msb, result_lsb, exponent);
> +	}
> +
> +	/* Report illuminance using Y intensity value. */

That seems 'interesting'.  Why?

> +	scan->channels[4] = scan->channels[1];
> +
> +	return 0;
> +}
> +
> +static int opt4048_identify(struct opt4048_sensor *sensor)
> +{
> +	struct device *dev = sensor->dev;
> +	int ret;
> +	u16 id, low, high;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_swapped(sensor->i2c_client, OPT4048_DID);
> +	if (ret < 0)
> +		goto complete;
> +
> +	low = (u16)OPT4048_DID_L_VALUE(ret);
> +	high = (u16)OPT4048_DID_H_VALUE(ret);
> +
> +	id = OPT4048_DID_VALUE(low, high);
> +
> +	switch (id) {
> +	case OPT4048_DID_OPT4048:
> +		dev_info(dev, "identified OPT4048 sensor\n");
This isn't useful information and can be easily established once the
driver has loaded.  So dev_dbg() at most.

> +		ret = 0;
> +		break;
> +	default:
> +		dev_err(dev, "unknown sensor with id: %#x\n", id);
> +		ret = -ENODEV;
We shouldn't treat a failure to match the ID as a reason to fail probe.
Consider the use of fallback IDs in device tree with older kernels.
If a new device comes along that is backwards compatible, we want that
to work with out driver modifications.

It's fine to print an dev_info message though so the user is aware
that we are ignoring the missmatch.

> +		break;
> +	}
> +
> +complete:
> +	pm_runtime_put_sync(dev);
> +
> +	return ret;
> +}
> +
> +static int opt4048_power(struct opt4048_sensor *sensor, bool on)
> +{
> +	struct opt4048_sensor_state *state = &sensor->state;
> +	int ret;
> +
> +	mutex_lock(&sensor->lock);
guard()
> +
> +	state->active = on;
> +	ret = opt4048_state_configure_cfg0(sensor);
> +
> +	mutex_unlock(&sensor->lock);
> +
> +	return ret;
> +}

> +static int opt4048_state_configure_cfg1(struct opt4048_sensor *sensor)
> +{
> +	u16 value;
> +	int ret;
I don't really see any advantage in these wrappers.   I'd just have
the code inline in  opt4048_state_configure() 
> +
> +	/* Assign threshold to the Y channel for illuminance. */
> +	value = OPT4048_CFG1_I2C_BURST |
> +		OPT4048_CFG1_INT_DIR_OUT |
> +		OPT4048_CFG1_THRESHOLD_CH_SEL(1) |
> +		OPT4048_CFG1_RESERVED;

combine these on fewer lines.  Just generally stay below 80 chars unless
there is a strong readability reason to go longer.

> +
> +	if (sensor->scan_sync)
> +		value |= OPT4048_CFG1_INT_CFG_DATA_READY_ALL;
> +	else
> +		value |= OPT4048_CFG1_INT_CFG_ALERT;
> +
> +	ret = i2c_smbus_write_word_swapped(sensor->i2c_client, OPT4048_CFG1,
> +					   value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

> +
> +static int opt4048_state_configure(struct opt4048_sensor *sensor)
> +{
> +	int ret;
> +
> +	mutex_lock(&sensor->lock);
guard() See below.

> +
> +	ret = opt4048_state_configure_cfg0(sensor);
> +	if (ret)
> +		goto complete;
> +
> +	ret = opt4048_state_configure_cfg1(sensor);
> +	if (ret)
> +		goto complete;
> +
> +	ret = opt4048_state_configure_threshold(sensor);
> +	if (ret)
> +		goto complete;
> +
> +complete:
> +	mutex_unlock(&sensor->lock);
> +
> +	return ret;
> +}
> +
> +static void opt4048_state_reset(struct opt4048_sensor *sensor)
> +{
> +	struct opt4048_sensor_state *state = &sensor->state;
> +
> +	state->active = false;
> +
> +	/* Start with a 25 ms integration time. */
> +	state->conversion_time_index = 6;
> +
> +	state->threshold_low_active = false;
> +	state->threshold_high_active = false;
> +}
> +
> +/* IIO */
> +
> +static const struct iio_event_spec opt4048_iio_events[] = {
> +	{
> +		.type		= IIO_EV_TYPE_THRESH,
> +		.dir		= IIO_EV_DIR_RISING,
> +		.mask_separate	=
> +			BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type		= IIO_EV_TYPE_THRESH,
> +		.dir		= IIO_EV_DIR_FALLING,
> +		.mask_separate	=
> +			BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> +static const struct iio_chan_spec opt4048_iio_channels[] = {
> +	{
> +		.type			= IIO_INTENSITY,
> +		.channel2		= IIO_MOD_X,
> +		.address		= OPT4048_CH0_DATA0,
> +		.modified		= 1,
> +
> +		.scan_index		= 0,
> +		.scan_type		= {
> +			.sign		= 'u',
> +			.realbits	= 28,
> +			.storagebits	= 32,
> +			.endianness	= IIO_LE,
> +		},
> +
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW),
		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),

still a short line. So don't wrap too aggressively.


> +		.info_mask_shared_by_all =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type			= IIO_INTENSITY,
> +		.channel2		= IIO_MOD_Y,
> +		.address		= OPT4048_CH1_DATA0,
> +		.modified		= 1,
> +
> +		.scan_index		= 1,
> +		.scan_type		= {
> +			.sign		= 'u',
> +			.realbits	= 28,
> +			.storagebits	= 32,
> +			.endianness	= IIO_LE,
> +		},
> +
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type			= IIO_INTENSITY,
> +		.channel2		= IIO_MOD_Z,
> +		.address		= OPT4048_CH2_DATA0,
> +		.modified		= 1,
> +
> +		.scan_index		= 2,
> +		.scan_type		= {
> +			.sign		= 'u',
> +			.realbits	= 28,
> +			.storagebits	= 32,
> +			.endianness	= IIO_LE,
> +		},
> +
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type			= IIO_INTENSITY,
> +		.channel2		= IIO_MOD_LIGHT_BOTH,
> +		.address		= OPT4048_CH3_DATA0,
> +		.modified		= 1,
> +
> +		.scan_index		= 3,
> +		.scan_type		= {
> +			.sign		= 'u',
> +			.realbits	= 28,
> +			.storagebits	= 32,
> +			.endianness	= IIO_LE,
> +		},
> +
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type			= IIO_LIGHT,
> +		.address		= OPT4048_CH1_DATA0,
> +
> +		.scan_index		= 4,
> +		.scan_type		= {
> +			.sign		= 'u',
> +			.realbits	= 28,
> +			.storagebits	= 32,
> +			.endianness	= IIO_LE,
> +		},
> +
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(5),
> +};
> +
> +static int opt4048_iio_read_raw(struct iio_dev *iio_dev,
> +				struct iio_chan_spec const *channel,
> +				int *value_first, int *value_second, long mask)
> +{
> +	struct opt4048_sensor *sensor = iio_priv(iio_dev);
> +	struct opt4048_sensor_state *state = &sensor->state;
> +	struct device *dev = sensor->dev;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
Need define scope {}

> +		unsigned int scan_index;
> +
> +		ret = iio_device_claim_direct_mode(iio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			goto release_direct_mode;
> +
> +		if (sensor->scan_sync) {

So this is curious. You just power up sensor and let it run until interrupt.
I'd expect to have interrupt disabled unless buffered capture is in use.
It would be fine to turn it on for a single cycle though if that makes capturing
on demand simpler.

> +			scan_index = channel->scan_index;
> +
> +			mutex_lock(&sensor->lock);
> +			*value_first = (int)sensor->scan.channels[scan_index];
> +			mutex_unlock(&sensor->lock);
> +		} else {
> +			ret = opt4048_data_read(sensor, channel->address,
> +						(u32 *)value_first);
> +		}
> +
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +
> +release_direct_mode:

I'd factor out the code above into a another function, then can avoid
the ugly goto within a switch statement.

> +		iio_device_release_direct_mode(iio_dev);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*value_first = 0;
> +		*value_second = OPT4048_SCALE_ULUX;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		unsigned int index = 2 * state->conversion_time_index;
> +
> +		*value_first = opt4048_conversion_time_available[index];
> +		index++;
> +		*value_second = opt4048_conversion_time_available[index];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int opt4048_iio_write_event_value(struct iio_dev *iio_dev,
> +					 struct iio_chan_spec const *channel,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction direction,
> +					 enum iio_event_info info,
> +					 int value_first, int value_second)
> +{
> +	struct opt4048_sensor *sensor = iio_priv(iio_dev);
> +	struct opt4048_sensor_state *state = &sensor->state;
> +	u32 value;
> +	int ret;
> +
> +	switch (direction) {
> +	case IIO_EV_DIR_RISING:
> +		value = (u32)value_first;
> +		opt4048_threshold_convert(value, state->threshold_high);
> +		break;
> +
> +	case IIO_EV_DIR_FALLING:
> +		value = (u32)value_first;
> +		opt4048_threshold_convert(value, state->threshold_low);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (pm_runtime_suspended(sensor->dev))
> +		return 0;
I'm curious. Why isn't this an error return?  Check for other cases of this.
I think they should all return an error so userspace knows something unexpected
is going on.

> +
> +	ret = opt4048_state_configure_threshold(sensor);
> +	if (ret)
> +		return ret;

	return opt...

> +
> +	return 0;
> +}

> +
> +static int opt4048_iio_write_event_config(struct iio_dev *iio_dev,
> +					  struct iio_chan_spec const *channel,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction direction,
> +					  int active)
Now takes a bool.  Rebase on either my iio.git / testing branch or
rc1 once available (probably later today).
> +{
> +	struct opt4048_sensor *sensor = iio_priv(iio_dev);
> +	struct opt4048_sensor_state *state = &sensor->state;
> +	int ret = 0;
> +
> +	/* Threshold active are read in IRQ thread. */
> +	mutex_lock(&sensor->lock);

guard()

> +
> +	switch (direction) {
> +	case IIO_EV_DIR_RISING:
> +		state->threshold_high_active = !!active;

This is why the signature became bool. All drivers had the same handling
which made no sense :(

FWIW you don't need the !! even before that change.


> +		break;
> +
> +	case IIO_EV_DIR_FALLING:
> +		state->threshold_low_active = !!active;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
When using guard. Can just return -EINVAL;
> +		goto complete;
> +	}
> +
> +	if (pm_runtime_suspended(sensor->dev))
> +		goto complete;
As above - direct return.
Though fun question of what you should do if this does fail as
we are then in a weird unknown state.
why not an error return?

> +
> +	ret = opt4048_state_configure_threshold(sensor);
Will become
	return opt4048_*
> +
> +complete:
> +	mutex_unlock(&sensor->lock);
> +
> +	return ret;
> +}
};
> +
> +static irqreturn_t opt4048_iio_buffer_trigger(int irq, void *data)
> +{
> +	struct iio_poll_func *poll_func = data;
> +	struct iio_dev *iio_dev = poll_func->indio_dev;
> +	struct opt4048_sensor *sensor = iio_priv(iio_dev);
> +	struct opt4048_sensor_scan scan = { 0 };
> +	s64 timestamp;
> +	unsigned int index = 0;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Capture timestamp just before reading values. */
> +	timestamp = iio_get_time_ns(iio_dev);
> +
> +	mutex_lock(&sensor->lock);
> +
> +	if (!sensor->scan_sync) {
> +		ret = opt4048_data_scan(sensor, &sensor->scan);
So you have a weird hybrid of capture in the data ready interrupt and here.
Why not just kick this off by having a data ready trigger and
using iio_trigger_poll() to effectively call this on the data ready
interrupt or on an other trigger.  That way should need no special handling
for your sync scan.


> +		if (ret)
> +			goto complete;
> +	}
> +
> +	for_each_set_bit(i, iio_dev->active_scan_mask, iio_dev->masklength) {
> +		/* Assume scan index matches array index. */
> +		const struct iio_chan_spec *channel = &opt4048_iio_channels[i];
> +		unsigned int scan_index = channel->scan_index;
> +
> +		/* Only active channels are reported, in order. */
> +		scan.channels[index] = sensor->scan.channels[scan_index];
> +		index++;

If you are always reading all channels, set avail_scan_masks and let the
demux in the IIO core deal with this data rearranging.

> +	}
> +
> +	iio_push_to_buffers_with_timestamp(iio_dev, &scan, timestamp);
> +
> +complete:
> +	mutex_unlock(&sensor->lock);
> +
> +	iio_trigger_notify_done(iio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

...


> +static const struct iio_buffer_setup_ops opt4048_iio_buffer_setup_ops = {
> +	.preenable = opt4048_iio_buffer_preenable,
> +	.postdisable = opt4048_iio_buffer_postdisable,
> +};
> +
> +static int opt4048_iio_setup(struct opt4048_sensor *sensor)
This function doesn't add much. I'd just put the code inline in prbe.

> +{
> +	struct iio_chan_spec *channels;
> +	struct iio_dev *iio_dev = sensor->iio_dev;
Just pass it the iio_dev in.


> +	struct device *dev = sensor->dev;
> +	unsigned int channels_count;
> +	int ret;
> +
> +	channels_count = ARRAY_SIZE(opt4048_iio_channels);
> +
> +	if (sensor->i2c_client->irq > 0) {
> +		channels = devm_kzalloc(dev, sizeof(opt4048_iio_channels),
> +					GFP_KERNEL);

kmemdup.  However I'd rather just see this picking between two static
const arrays of channels.  There are only two cases so it isn't worth dynamic
channel setup complexity.

> +
> +		memcpy(channels, opt4048_iio_channels,
> +		       sizeof(opt4048_iio_channels));
> +
> +		/* Attach threshold events to the illuminance channel. */
> +		channels[3].event_spec = opt4048_iio_events;
> +		channels[3].num_event_specs = ARRAY_SIZE(opt4048_iio_events);
> +	} else {
> +		/* Threshold events are not available without an irq. */
> +		channels = (struct iio_chan_spec *)opt4048_iio_channels;
> +	}
> +
> +	iio_dev->info = &opt4048_iio_info;
> +	iio_dev->name = "opt4048";
> +	iio_dev->channels = channels;
> +	iio_dev->num_channels = channels_count;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, iio_dev, NULL,
> +					      opt4048_iio_buffer_trigger,
> +					      &opt4048_iio_buffer_setup_ops);
> +	if (ret) {
> +		dev_err(dev, "failed to setup iio triggered buffer\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(iio_dev);

As below. No reason not to use devm_iio_device_register() and avoid
need to manually unwind.

> +	if (ret) {
> +		dev_err(dev, "failed to register iio device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void opt4048_iio_cleanup(struct opt4048_sensor *sensor)
> +{
> +	iio_device_unregister(sensor->iio_dev);
This wrapper doesn't add anything useful so put the code inline.
Though as below, it shouldn't be called directly at all.


> +}
> +
> +/* IRQ */
Comment doesn't add anything that isn't obvious from the code.
So don't have it.

> +
> +static irqreturn_t opt4048_irq(int irq, void *data)
> +{
> +	struct opt4048_sensor *sensor = data;
> +	struct opt4048_sensor_state *state = &sensor->state;
> +	struct iio_dev *iio_dev = sensor->iio_dev;

Set data = iio_dev and then use iio_priv() on that.
There shouldn't be a need to go back the other way.

> +	bool threshold_rising;
> +	bool threshold_falling;
> +	s64 timestamp;
> +	u64 code;
Might as well combine elements of same type.  Saves a few lines of code
and doesn't harm readability much.


> +	u16 status;
> +	int ret;
> +
> +	timestamp = iio_get_time_ns(iio_dev);
> +
> +	ret = i2c_smbus_read_word_swapped(sensor->i2c_client, OPT4048_STATUS);
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	status = (u16)ret;
> +
> +	mutex_lock(&sensor->lock);
Use 
	guard(mutex)(&sensor->lock);
and include cleanup.h

That will simplify this function as you can then do direct returns
instead of gotos.

> +
> +	if (!state->active)
Perhaps add a comment for this. I guess it's about preventing a race?
+ the lock prevents concurrent power down.

I'd be tempted to just do a pm_runtime_resume_and_get()
Vast majority of the time the device will be powered up and you won't
need to do anything.  The race will be closed as in the rare corner
case w will be able ot read the data.

I'm also curious that you can still read status after powering down.
Maybe add a comment about that always being safe.

> +		goto complete;
> +
> +	if (status & OPT4048_STATUS_CONV_READY_FLAG)
> +		opt4048_data_scan(sensor, &sensor->scan);

Superficially this looks like a data ready trigger should be used.
So register a trigger and do the read in the trigger handler in all
cases rather than here.

> +
> +	threshold_falling = (status & OPT4048_STATUS_FLAG_L) &&
> +			    !(state->status & OPT4048_STATUS_FLAG_L);
> +
> +	if (state->threshold_low_active && threshold_falling) {
> +		code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 3, IIO_EV_TYPE_THRESH,
> +					    IIO_EV_DIR_FALLING);
> +		iio_push_event(iio_dev, code, timestamp);
> +	}
> +
> +	threshold_rising = (status & OPT4048_STATUS_FLAG_H) &&
> +			   !(state->status & OPT4048_STATUS_FLAG_H);
> +
> +	if (state->threshold_high_active && threshold_rising) {
> +		code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 3, IIO_EV_TYPE_THRESH,
> +					    IIO_EV_DIR_RISING);
> +		iio_push_event(iio_dev, code, timestamp);
> +	}
> +
> +	state->status = status;
Add a comment on why you are saving this (I guess because the device
interrupts every time otherwise).  Does it interrupt on the reverse
direction?  If not how is this cleared?
> +
> +complete:
> +	mutex_unlock(&sensor->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* PM */
Structural comments like this don't add much after a driver is
written and often become wrong as a driver develops over time.
I'd drop them.

> +
> +static int opt4048_suspend(struct device *dev)
> +{
> +	struct opt4048_sensor *sensor = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = opt4048_power(sensor, 0);
> +	if (ret)
> +		goto error;
> +
> +	ret = regulator_disable(sensor->vdd_supply);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	return -EAGAIN;
Direct returns preferred over both eating the error codes and
a goto like this.

> +}
> +
> +static int opt4048_resume(struct device *dev)
> +{
> +	struct opt4048_sensor *sensor = dev_get_drvdata(dev);
> +	unsigned long sleep_min;
> +	unsigned int index;
> +	int ret;
> +
> +	ret = regulator_enable(sensor->vdd_supply);
> +	if (ret)
> +		goto error;
> +
> +	/* Wait for the regulator to settle and the chip to power-on. */
> +	udelay(30);
> +
> +	ret = opt4048_state_configure(sensor);
> +	if (ret)
> +		goto error_regulator;
> +
> +	ret = opt4048_power(sensor, 1);
> +	if (ret)
> +		goto error_regulator;
> +
> +	/* Wait for conversion to be ready for all channels. */
We might not have powered up for that reason but I guess this does
little harm.

> +	index = 2 * sensor->state.conversion_time_index + 1;
> +	sleep_min = opt4048_conversion_time_available[index] * 4;
> +
> +	usleep_range(sleep_min, 5 * sleep_min / 4);

Perhaps use fsleep() to avoid anyone needing to reason about the margins
etc.

> +
> +	return 0;
> +
> +error_regulator:
> +	regulator_disable(sensor->vdd_supply);
> +
> +error:
Direct returns make for easier to review code as following an error
path doesn't require checking to see what the cleanup is.
> +	return -EAGAIN;
> +}
> +
> +static const struct dev_pm_ops opt4048_pm_ops = {
> +	.runtime_suspend	= opt4048_suspend,
> +	.runtime_resume		= opt4048_resume,
> +};
> +
> +/* I2C */
Not a particularly useful comment. I'd drop it.
> +
> +static int opt4048_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct opt4048_sensor *sensor;
> +	struct iio_dev *iio_dev;
> +	int irq = client->irq;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*sensor));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	sensor = iio_priv(iio_dev);
> +
> +	sensor->dev = dev;
> +	sensor->i2c_client = client;
> +	sensor->iio_dev = iio_dev;
That is almost always a sign that you have a less than ideal layering
in the driver.
> +
> +	i2c_set_clientdata(client, sensor);
> +
> +	mutex_init(&sensor->lock);
	ret = devm_mutex_init()
	if (ret)
		return ret;
> +
> +	sensor->vdd_supply = devm_regulator_get(dev, "vdd");

Given runtime PM may not even be enabled, you should turn the power on.
Unconditionally.

> +	if (IS_ERR(sensor->vdd_supply)) {
> +		dev_err(dev, "failed to get VDD regulator\n");

For error returns and messages in probe use return dev_err_probe()
It will do various useful things for deferred and out of memory
error prints.  Find to use it in all code only called from the probe
callback.

> +		return PTR_ERR(sensor->vdd_supply);
> +	}
> +
> +	opt4048_state_reset(sensor);
> +
> +	devm_pm_runtime_enable(dev);
Can fail so check for that.

> +
> +	ret = opt4048_identify(sensor);
> +	if (ret)
As above, failure to match should not be a reason to fail probe.
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 5000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	if (irq > 0) {
> +		ret = devm_request_threaded_irq(dev, irq, NULL, opt4048_irq,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
Direction should come from firmware (so don't specify it here).
It's reasonably common to find an inverter in the path for an interrupt
and so we can't know the sense in the driver.

> +						"opt4048", sensor);
> +		if (ret) {
> +			dev_err(dev, "failed to request irq\n");
> +			return ret;
> +		}
> +
> +		sensor->scan_sync = true;
> +	}
> +
> +	ret = opt4048_iio_setup(sensor);
As above, I'd put the contents of that function here as well. Whilst
I guess you wanted to keep functions small, sometimes that just leads
to less readable code than a long function with everything we expect
in it.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
	
> +}
> +
> +static void opt4048_remove(struct i2c_client *client)
> +{
> +	struct opt4048_sensor *sensor = i2c_get_clientdata(client);
> +
> +	opt4048_iio_cleanup(sensor);
For a simple single call like this, use a devm_add_action_or_reset()
so that the cleanup is associated directly with the setup function and
we don't need a remove() callback at all.

Given all it does is iio_device_unregister() just use devm_device_register()
in the first place and drop this.

> +}
> +
> +static const struct i2c_device_id opt4048_id[] = {
> +	{ "opt4048" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, opt4048_id);
> +
> +static const struct of_device_id opt4048_of_match[] = {
> +	{ .compatible = "ti,opt4048" },
> +	{ }
> +};
Similar to below, fairly standard to group the id table and
MODULE_DEVICE_TABLE but not having a blank line.

> +
> +MODULE_DEVICE_TABLE(of, opt4048_of_match);
> +
> +static struct i2c_driver opt4048_driver = {
> +	.driver = {
> +		.name		= "opt4048",
> +		.of_match_table = opt4048_of_match,
> +		.pm		= &opt4048_pm_ops,
> +	},
> +	.id_table	= opt4048_id,
> +	.probe		= opt4048_probe,
> +	.remove		= opt4048_remove,
> +};
> +
It's common to not put a blank line here given how closely coupled this
macro is to the structure.
> +module_i2c_driver(opt4048_driver);
> +
> +MODULE_AUTHOR("Paul Kocialkowski <paulk@sys-base.io>");
> +MODULE_DESCRIPTION("Texas Instruments OPT4048 XYZ tristimulus color sensor driver");
> +MODULE_LICENSE("GPL");


