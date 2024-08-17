Return-Path: <linux-iio+bounces-8562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C049558DC
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D890E1C20B5B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66C7143722;
	Sat, 17 Aug 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/MNMnWl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EEC2C8;
	Sat, 17 Aug 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723911436; cv=none; b=EUquPZcc8+YAAWSCJDuAx2KEVAw3kCOgesQA1CXDDxWs6rg6PZnKXPyR41ln3s4jbEnNHjfP4Pi7iMnUtBP+asVgd7syCoSRv1SPjthwAlLf2ztVOxQF0dvxwCAKx89Yn1DLmNGqk/AZz8kCBD3/RlGWiBMZ8lTZRbIaGE7Gz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723911436; c=relaxed/simple;
	bh=0a3754EtGUua7ADaor4o/Aj+MUsX2xtekCC57GH1s14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYVP9141lGDefUqsnbmUjwVSfta7u/MzXSeTZE7RABgAtIOtMACZEGhpu32hmj9paGo9+jI2ySiR1FAN16kP5A1EDEA1aH4GqWYRuT5FwoE76bwtwqrRsMHpNg7lISeOXV4PRacRdKc0e0FjtcCAwir8uAdOmDo84fkoxbObK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/MNMnWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB24C116B1;
	Sat, 17 Aug 2024 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723911436;
	bh=0a3754EtGUua7ADaor4o/Aj+MUsX2xtekCC57GH1s14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/MNMnWlbVsWMDrvr9qRwramwimnyh1P6WvBno9LRvEjYJF6iEe96MuTmhVjf7FbG
	 0MFkU/RwmN6ZQs8mbh3MuFGeNCzuVQwKNbYNpKSd9QjuCR0RaOTKS64D646j+KM39r
	 /WV0oxxuQPnFpyjyuSnxHpU0J+VecE0g/sAt93tX3yVXxuAqKP98s9JFVrKRIa/PFi
	 HUASMIiRSOSx/IEmczMqlW5rkerCAR4xekRdl+U+DMSo3cRJK+038vSB+7peDNzYPs
	 aQG33BNVBfjg4vxpTULL/gSP1XTlzQJxSVi2z9pdkN/V6O5u01SPIEqUT4zGaaEhCa
	 7NI+tyqG75yuQ==
Date: Sat, 17 Aug 2024 17:17:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v3 2/2] iio: imu: smi240: imu driver
Message-ID: <20240817171707.7f77b244@jic23-huawei>
In-Reply-To: <20240815152545.7705-3-Jianping.Shen@de.bosch.com>
References: <20240815152545.7705-1-Jianping.Shen@de.bosch.com>
	<20240815152545.7705-3-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 17:25:45 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Shen Jianping <Jianping.Shen@de.bosch.com>
> 
> iio: imu: smi240: add sensor driver
Blank line + tell us something about features supported, + what the device
is etc here. Don't repeat the title.

Also good to provide a
Datasheet: tag here if there is a public datasheet available
> Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>

Various other comments inline,

Thanks,

Jonathan


> diff --git a/drivers/iio/imu/smi240/smi240.h b/drivers/iio/imu/smi240/smi240.h
> new file mode 100644
> index 00000000000..a165bbd9f0b
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + *
As below I'd drop this blank line.

> + */
> +#ifndef _SMI240_H
> +#define _SMI240_H
> +
> +#include <linux/device.h>
> +#include <linux/regmap.h>
Use a forwards def only as this doesn't need to know about regmap.h contents.

struct regmap;
struct device;

Then include regmap.h and device.h in the appropriate c files.

> +
> +enum capture_mode { SMI240_CAPTURE_OFF = 0, SMI240_CAPTURE_ON = 1 };
> +
> +struct smi240_data {
> +	struct regmap *regmap;
> +	u16 accel_filter_freq;
> +	u16 anglvel_filter_freq;
> +	u8 bite_reps;
> +	enum capture_mode capture;
> +	/*
> +	 * Ensure natural alignment for timestamp if present.
> +	 * Channel size: 2 bytes.
> +	 * Max length needed: 2 * 3 channels + temp channel + 2 bytes padding + 8 byte ts.
> +	 * If fewer channels are enabled, less space may be needed, as
> +	 * long as the timestamp is still aligned to 8 bytes.
> +	 */
> +	s16 buf[12] __aligned(8);
Add a dma safe buffer here
	__be32 spi_buf __aligned(IIO_DMA_MINALIGN);
to use for the spi transfers 

See spi_sync() docs for why or this talk
Wolfram did a few years ago.
https://www.youtube.com/watch?v=JDwaMClvV-s
DMA safety in buffers for Linux Kernel device drivers

> +};
> +
> +int smi240_core_probe(struct device *dev, struct regmap *regmap);
> +
> +#endif /* _SMI240_H */
> diff --git a/drivers/iio/imu/smi240/smi240_core.c b/drivers/iio/imu/smi240/smi240_core.c
> new file mode 100644
> index 00000000000..9e7269b90c9
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_core.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + *
Trivial: Drop this blanke line. Doesn't add anything,.
> + */
> +#include <linux/regmap.h>
> +#include <linux/delay.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
With suggested changes below you won't need sysfs.h

> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +
> +#include "smi240.h"

> +#define SMI240_DATA_CHANNEL(_type, _axis, _index)                          \
> +	{                                                                  \
> +		.type = _type, .modified = 1, .channel2 = IIO_MOD_##_axis, \
as below.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),              \
> +		.info_mask_shared_by_type =                                \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),  \
> +		.info_mask_shared_by_type_available =                      \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),  \
> +		.scan_index = _index,                                      \
> +		.scan_type = {                                             \
> +			.sign = 's',                                       \
> +			.realbits = 16,                                    \
> +			.storagebits = 16,                                 \
> +			.endianness = IIO_LE,                              \
> +		},                                                         \
> +	}
> +
> +#define SMI240_TEMP_CHANNEL(_index)                           \
> +	{                                                     \
> +		.type = IIO_TEMP, .modified = 1,              \

I'd put .modified on next line.
When doing c99 style assignment it can be easy to miss wher there
are multiple elements on one line. It's fine to combine them if everything
on a single line, but not mix and match as done here.

> +		.channel2 = IIO_MOD_TEMP_OBJECT,              \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +		.scan_index = _index,                         \
> +		.scan_type = {                                \
> +			.sign = 's',                          \
> +			.realbits = 16,                       \
> +			.storagebits = 16,                    \
> +			.endianness = IIO_LE,                 \
> +		},                                            \
> +	}
> +
> +static const struct iio_chan_spec smi240_channels[] = {
> +	SMI240_TEMP_CHANNEL(SMI240_TEMP_OBJECT),
> +	SMI240_DATA_CHANNEL(IIO_ACCEL, X, SMI240_SCAN_ACCEL_X),
> +	SMI240_DATA_CHANNEL(IIO_ACCEL, Y, SMI240_SCAN_ACCEL_Y),
> +	SMI240_DATA_CHANNEL(IIO_ACCEL, Z, SMI240_SCAN_ACCEL_Z),
> +	SMI240_DATA_CHANNEL(IIO_ANGL_VEL, X, SMI240_SCAN_GYRO_X),
> +	SMI240_DATA_CHANNEL(IIO_ANGL_VEL, Y, SMI240_SCAN_GYRO_Y),
> +	SMI240_DATA_CHANNEL(IIO_ANGL_VEL, Z, SMI240_SCAN_GYRO_Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(SMI240_SCAN_TIMESTAMP),
> +};
> +
> +static const int smi240_low_pass_freqs[] = { SMI240_LOW_BANDWIDTH_HZ,
> +					     SMI240_HIGH_BANDWIDTH_HZ };
> +
> +static int smi240_soft_reset(struct smi240_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, SMI240_CMD_REG, SMI240_SOFT_RESET_CMD);
> +	if (ret)
> +		return ret;
> +	fsleep(SMI240_DIGITAL_STARTUP_DELAY_US);

blank line here.

> +	return 0;
> +}
> +
> +static int smi240_soft_config(struct smi240_data *data)
> +{
> +	int ret;
> +	u8 acc_bw, gyr_bw;
> +	u16 request;
> +
> +	switch (data->accel_filter_freq) {
> +	case SMI240_LOW_BANDWIDTH_HZ:
> +		acc_bw = 0x1;
> +		break;
> +	case SMI240_HIGH_BANDWIDTH_HZ:
> +		acc_bw = 0x0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (data->anglvel_filter_freq) {
> +	case SMI240_LOW_BANDWIDTH_HZ:
> +		gyr_bw = 0x1;
> +		break;
> +	case SMI240_HIGH_BANDWIDTH_HZ:
> +		gyr_bw = 0x0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	request = FIELD_PREP(SMI240_SOFT_CONFIG_EOC_MASK, 1);
> +	request |= FIELD_PREP(SMI240_SOFT_CONFIG_GYR_BW_MASK, gyr_bw);
> +	request |= FIELD_PREP(SMI240_SOFT_CONFIG_ACC_BW_MASK, acc_bw);
> +	request |= FIELD_PREP(SMI240_SOFT_CONFIG_BITE_AUTO_MASK, 1);
> +	request |= FIELD_PREP(SMI240_SOFT_CONFIG_BITE_REP_MASK,
> +			      data->bite_reps - 1);
> +
> +	ret = regmap_write(data->regmap, SMI240_SOFT_CONFIG_REG, request);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(SMI240_MECH_STARTUP_DELAY_US +
> +	       data->bite_reps * SMI240_BITE_SEQUENCE_DELAY_US +
> +	       SMI240_FILTER_FLUSH_DELAY_US);

blank line here slightly helps readability.


> +	return 0;
> +}
> +
> +static int smi240_get_low_pass_filter_freq(struct smi240_data *data,
> +					   int chan_type, int *val)
> +{
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		*val = data->accel_filter_freq;
> +		break;
		return 0;
> +	case IIO_ANGL_VEL:
> +		*val = data->anglvel_filter_freq;
> +		break;
		return 0;
> +	default:
> +		return -EINVAL;
> +	}
drop the rest as won't get there.

If you can return early it allows the reader following a particular
code path to not bother looking at places where nothing happens
anyway.  So in general it's preferred unless there is shared cleanup
to do that applies to multiple paths.

> +
> +	return 0;
> +}

> +
> +static irqreturn_t smi240_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct smi240_data *data = iio_priv(indio_dev);
> +	int ret, sample, chan, i = 0;
> +
> +	data->capture = SMI240_CAPTURE_ON;
> +
> +	for_each_set_bit(chan, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		ret = regmap_read(data->regmap,
> +				  SMI240_DATA_CAP_FIRST_REG + chan, &sample);
The read should be directly into the buffer. Not point in copying it elsewhere
earlier.

		ret = regmap_read(data->regmap,
				  SMI240_DATA_CAP_FIRST_REG + chan, &data->buf[i]);
		if (ret)
			goto out;

		i++;


> +		data->capture = SMI240_CAPTURE_OFF;
> +		if (ret)
> +			break;
> +		data->buf[i++] = sample;
> +	}
> +
> +	if (ret == 0)
> +		iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
> +						   pf->timestamp);
Keep good path inline.
	if (ret)
		goto out;

	iio_push_to_buffers_with...

out:
	iio_trigger_notify_done(indio_dev->trig)
etc

Whilst it's a little more code, it's more consistent and lets a reviewer
see this is correct slightly more quickly.

> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

> +static int smi240_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	int ret, i;
> +	struct smi240_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		for (i = 0; i < ARRAY_SIZE(smi240_low_pass_freqs); i++) {
> +			if (val == smi240_low_pass_freqs[i])
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(smi240_low_pass_freqs))
> +			return -EINVAL;
> +
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			data->accel_filter_freq = val;
> +			break;
> +		case IIO_ANGL_VEL:
> +			data->anglvel_filter_freq = val;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	// Write access to soft config is locked until hard/soft reset

Look at local comment syntax. Always use
/* */
in IIO

> +	ret = smi240_soft_reset(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = smi240_soft_config(data);
> +	if (ret)
> +		return ret;
	return smi240_soft_config(data);

> +
> +	return 0;
> +}
> +
> +static int smi240_init(struct smi240_data *data)
> +{
> +	data->accel_filter_freq = SMI240_HIGH_BANDWIDTH_HZ;
> +	data->anglvel_filter_freq = SMI240_HIGH_BANDWIDTH_HZ;
> +	data->bite_reps = 3;
> +
> +	return smi240_soft_config(data);
> +}
> +
> +static IIO_CONST_ATTR_TEMP_SCALE("1/256");
> +static IIO_CONST_ATTR_TEMP_OFFSET("25");
> +
> +static struct attribute *smi240_attrs[] = {
> +	&iio_const_attr_in_temp_scale.dev_attr.attr,
> +	&iio_const_attr_in_temp_offset.dev_attr.attr,

Why can't you do these with normal channel info_mask elements?
This is not custom ABI, so shouldn't be done with specific
attributes like this.  We go through that dance with getting
IIO to create them because it enforced ABI + enables in kernel
users to access the channel.  Temperature may well be of interest
to other kernle drivrs.

> +	NULL,
If this was something you were keeping, not trailing comma on the
null terminator.

> +};
> +
> +static const struct attribute_group smi240_attrs_group = {
> +	.attrs = smi240_attrs,
> +};
> +
> +static const struct iio_info smi240_info = {
> +	.read_avail = smi240_read_avail,
> +	.read_raw = smi240_read_raw,
> +	.write_raw = smi240_write_raw,
> +	.attrs = &smi240_attrs_group,
> +};
> +


> +int smi240_core_probe(struct device *dev, struct regmap *regmap)
> +{
...

> +}
> +EXPORT_SYMBOL_GPL(smi240_core_probe);

All one module, no need to export symbols.


> diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240/smi240_spi.c
> new file mode 100644
> index 00000000000..d1ed92dce79
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/smi240_spi.c
> @@ -0,0 +1,164 @@

...

> +static int smi240_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	int ret;
> +	__be32 request, response;
> +	struct spi_device *spi = context;
> +	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> +	struct smi240_data *data = iio_priv(indio_dev);
> +
> +	request = SMI240_BUS_ID << 30;

As below. Build the u32 value up then convert to store in the __be32


> +	request |= FIELD_PREP(SMI240_CAP_BIT_MASK, data->capture);
> +	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
> +	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +	request = cpu_to_be32(request);
> +
> +	/*
> +	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
> +	 * SPI protocol, where the slave interface responds to
> +	 * the Master request in the next frame.
> +	 * CS signal must toggle (> 700 ns) between the frames.
> +	 */
> +	ret = spi_write(spi, &request, sizeof(request));
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_read(spi, &response, sizeof(response));
> +	if (ret)
> +		return ret;
> +
> +	response = be32_to_cpu(response);

Again, use two variables to avoid messing up u32 and __be32 types.

> +
> +	if (!smi240_sensor_data_is_valid(response))
> +		return -EIO;
> +
> +	response = FIELD_GET(SMI240_READ_DATA_MASK, response);
> +	memcpy(val_buf, &response, val_size);
> +
> +	return 0;
> +}
> +
> +static int smi240_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	__be32 request;
> +	struct spi_device *spi = context;
> +	u8 reg_addr = ((u8 *)data)[0];
> +	u16 reg_data = ((u8 *)data)[2] << 8 | ((u8 *)data)[1];

Hmm. So this converts from little endian to CPU endian for this
value and then we convert it to big endian below. Odd, but maybe valid.

	u16 reg_data = get_unaligned_le16(&data[1]);

> +
> +	request = SMI240_BUS_ID << 30;
> +	request |= FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> +	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> +	request |= FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
> +	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +	request = cpu_to_be32(request);

Build the register in a u32 then at the end convert to be32 so that
the types are correct at all stages.
As you have probably noted, the automated testing really doesn't
like mixing up endian types like this.


> +
> +	return spi_write(spi, &request, sizeof(request));

Spi requires DMA safe buffers. Put somewhere to store this after your
buffer at the end of your iio_priv() structure.
Need to mark it __aligned(IIO_DMA_MINALIGN).


> +}

> +
> +static const struct spi_device_id smi240_spi_id[] = { { "smi240", 0 }, {} };
Lay that out as
static const struct spi_device_id smi240_spi_id[] = {
	{ "smi240", 0 },
	{ }
};

> +MODULE_DEVICE_TABLE(spi, smi240_spi_id);
> +
> +static const struct of_device_id smi240_of_match[] = {
> +	{ .compatible = "bosch,smi240" },
> +	{},
	{ }

so space and no trailing comma.

> +};
> +MODULE_DEVICE_TABLE(of, smi240_of_match);


