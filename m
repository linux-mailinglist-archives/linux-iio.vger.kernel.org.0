Return-Path: <linux-iio+bounces-7764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC9493829D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 21:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEAAB2118C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E30414884F;
	Sat, 20 Jul 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIOSt9OE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE11474D3;
	Sat, 20 Jul 2024 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721502721; cv=none; b=CYAn4/mvrQ2Fx7HHuUWdDwV+bClQuyP1LHms0iRWMywOmT7JbckcD2uKvqj0jMHOKKxgpx6KVT65EMQMpyjDAsSE+OyJSHsMkSqRrgnsjSaQoNMQKOhYtkHlHKhniVmKfwjMl2yruO4kqsduZdhSuBpq4b6lPjy4ybM757+962U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721502721; c=relaxed/simple;
	bh=Ob8HYw4g+4nrzn4kCxTytIAv6/25zlza8zsFMAW2BH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3AN2t+ff+5zhhVuNCbCqAHydhWghQtMsZY97SIHfwsRS8Dzk2onjkTOhuOT/0FuejAzXoyZ9njvRSnku7+7acpmmhjj5gzbdY7U2wqYxFupRiH9WvTlK9sfRxMGJJ+i/2Mq7RV1etjCTTH7O8jE3VFiiMNC+OifpFupcHVqjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIOSt9OE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5DFC2BD10;
	Sat, 20 Jul 2024 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721502720;
	bh=Ob8HYw4g+4nrzn4kCxTytIAv6/25zlza8zsFMAW2BH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jIOSt9OEhxz3RnLk8MWdp2JSDM6aOjWpL2s7MqikyXjdTWVIM+K835XUropZYBiMx
	 ym33RCZCzqOTlWbk35+nXmMYd0f7/XQ3+BgPbnaRLAyuJtoe6GROYQZNPwwwM7RBO2
	 EZrQ21Klt1280rJokjj+CX4RAIwIfICqPZ/fEP/rp28kwgreKeH5ZH/JjIWM+1hoRc
	 88btzwDr1dk48tZuhWTg8JWnv1Tr0lrewIY9a1hq6erJkCYIID2ULBymo0x/V7yEci
	 nIVd8gFkU1MbwupJFrUsEAMwT6llAYVGgphvr6V+v42zVGWIROZy/ujljtTUzLvJyC
	 ZhBKbwkICOpJw==
Date: Sat, 20 Jul 2024 20:11:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for PAC194X
Message-ID: <20240720201153.3310c6fa@jic23-huawei>
In-Reply-To: <20240719173855.53261-3-marius.cristea@microchip.com>
References: <20240719173855.53261-1-marius.cristea@microchip.com>
	<20240719173855.53261-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 20:38:55 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip PAC194X and PAC195X
> series of Power Monitors with Accumulator.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-pac1944     |    9 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/pac1944.c                     | 3528 +++++++++++++++++
ouch. 

For super large drivers like this it can be a good idea to build
them up in bite sized pieces as it makes it less likely a reviewer
thinks 'not today - it's beer o'clock'...

>  5 files changed, 3558 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
>  create mode 100644 drivers/iio/adc/pac1944.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> new file mode 100644
> index 000000000000..dbc00b581aa7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistorY
Discussion about shunt resistor attributes is ongoing.
https://lore.kernel.org/all/20240720104812.5d59e91a@jic23-huawei/

One key thing is we can't have duplicate attribute docs.
So much like the ones in that thread we need to move them to a
common place.

Also as you'll see we were falling away from this form because it's
odd and not clear what it is associated with.
May be better to associate with a particular current channel.

Anyhow, lets continue that discussion in that thread rather than duplicating
here.


> +KernelVersion:	6.10
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The value of the shunt resistor may be known only at runtime
> +		and set by a client application. This attribute allows to
> +		set its value in micro-ohms. X is the IIO index of the device.
> +		Y is the channel number. The value is used to calculate
> +		current, power and accumulated energy.

Various comments inline.
If there is any path to reducing duplication consider it.
I'm not a great fan of macros for functions but maybe they are needed here
or a change in data structuring to allow more reuse.

> diff --git a/drivers/iio/adc/pac1944.c b/drivers/iio/adc/pac1944.c
> new file mode 100644
> index 000000000000..c7540e30f2de
> --- /dev/null
> +++ b/drivers/iio/adc/pac1944.c
> @@ -0,0 +1,3528 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for PAC194X and PAC195X series chips
> + *
> + * Copyright (C) 2022-2024 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Marius Cristea marius.cristea@microchip.com
> + *
> + * Datasheet for PAC1941, PAC1942, PAC1943 and PAC1944 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
> + * Datasheet for PAC1951, PAC1952, PAC1953 and PAC1954 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
> + *
> + */
> +
>
> +static const unsigned int samp_rate_fast_mode_tbl[] = {
> +	[PAC1944_1_CHANNEL_ACTIVE] = 2560,
> +	[PAC1944_2_CHANNELS_ACTIVE] = 1707,
> +	[PAC1944_3_CHANNELS_ACTIVE] = 1280,
> +	[PAC1944_4_CHANNELS_ACTIVE] = 1024
Add a trailing comma to these. Not obvious there will never be more entries.

> +};
> +
> +/* Available Sample Modes */
> +static const char * const pac1944_frequency_avail[] = {
> +	"1024_ADAP",
> +	"256_ADAP",
> +	"64_ADAP",
> +	"8_ADAP",
> +	"1024",
> +	"256",
> +	"64",
> +	"8",
> +	"single_shot_1x",
> +	"single_shot_8x",
> +	"fast",
> +	"burst"
Coma after that. 
However, this is not standard use of a standard attribute.
Can't do that as normal software is going to break.
So we need to figure out what the interface should look like.
Starting point provide some docs.


> +};

> + */
> +struct pac1944_chip_info {
> +	const struct iio_chan_spec  *channels;
> +	struct iio_info		iio_info;
> +	struct i2c_client	*client;
> +	struct mutex		lock; /* lock to prevent concurrent reads/writes */
> +	struct delayed_work	work_chip_rfsh;
> +	u8		phys_channels;
> +	bool		active_channels[PAC1944_MAX_CH];
Perhaps use a bitmap for this. Mainly because then you can do for_each_set_bit() etc
to simplify scanning over them.


> 
> +
> +static inline u64 pac1944_get_unaligned_be56(u8 *p)
Add to the generic routines. Maybe another user will turn up ;)


> +{
> +	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
> +		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
> +}
> +
>

> +
> +static ssize_t pac1944_op_limit_nsamples_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int ret, idx;
> +	u8 val, val_tmp;
> +
> +	ret = kstrtou8(buf, 10, &val_tmp);
> +	if (ret)
> +		return ret;
> +
> +	if (val_tmp > 3)
> +		return -EINVAL;
> +
> +	idx = this_attr->address;
> +
> +	scoped_guard(mutex, &info->lock) {
> +		val = val_tmp << (6 - (idx * 2));
> +		ret = pac1944_update_alert_byte_data(dev, PAC1944_OP_LIMIT_NSAMPLES_REG_ADDR,
> +						     (int)(PAC1944_CH01OP_MASK >> idx), val);
> +		if (!ret)
If it's an error return that.

> +			info->op_limit_nsamples[idx] = val_tmp;
> +	}
> +
> +	return count;
> +}

> +
> +static ssize_t pac1944_alert_status_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	u32 tmp;
> +	u8 status[3];
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_ALERT_STATUS_REG_ADDR,
> +					    ARRAY_SIZE(status), (u8 *)status);
> +	if (ret < 0) {
> +		dev_err(dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
> +			__func__, PAC1944_ALERT_STATUS_REG_ADDR);
> +		return 0;
Why return 0?

> +	}
> +	tmp =  get_unaligned_be24(&status[0]);
> +
> +	return sysfs_emit(buf, "%u\n", tmp);
> +}

> +static struct attribute *pac1944_all_attrs[] = {
> +	PAC1944_DEV_ATTR(in_shunt_resistor1),

Everything in here needs documenting not just the shunt resistor.


> +	PAC1944_DEV_ATTR(in_oc_limit_nsamples1),
> +	PAC1944_DEV_ATTR(in_uc_limit_nsamples1),
> +	PAC1944_DEV_ATTR(in_op_limit_nsamples1),
> +	PAC1944_DEV_ATTR(in_ov_limit_nsamples1),
> +	PAC1944_DEV_ATTR(in_uv_limit_nsamples1),
> +	PAC1944_DEV_ATTR(in_shunt_resistor2),
> +	PAC1944_DEV_ATTR(in_oc_limit_nsamples2),
> +	PAC1944_DEV_ATTR(in_uc_limit_nsamples2),
> +	PAC1944_DEV_ATTR(in_op_limit_nsamples2),
> +	PAC1944_DEV_ATTR(in_ov_limit_nsamples2),
> +	PAC1944_DEV_ATTR(in_uv_limit_nsamples2),
> +	PAC1944_DEV_ATTR(in_shunt_resistor3),
> +	PAC1944_DEV_ATTR(in_oc_limit_nsamples3),
> +	PAC1944_DEV_ATTR(in_uc_limit_nsamples3),
> +	PAC1944_DEV_ATTR(in_op_limit_nsamples3),
> +	PAC1944_DEV_ATTR(in_ov_limit_nsamples3),
> +	PAC1944_DEV_ATTR(in_uv_limit_nsamples3),
> +	PAC1944_DEV_ATTR(in_shunt_resistor4),
> +	PAC1944_DEV_ATTR(in_oc_limit_nsamples4),
> +	PAC1944_DEV_ATTR(in_uc_limit_nsamples4),
> +	PAC1944_DEV_ATTR(in_op_limit_nsamples4),
> +	PAC1944_DEV_ATTR(in_ov_limit_nsamples4),
> +	PAC1944_DEV_ATTR(in_uv_limit_nsamples4),
> +	PAC1944_DEV_ATTR(in_acc_fullness),
> +	PAC1944_DEV_ATTR(in_alert_enable),
> +	PAC1944_DEV_ATTR(in_slow_alert),
> +	PAC1944_DEV_ATTR(in_gpio_alert),
> +	PAC1944_DEV_ATTR(out_alert_status),
> +	NULL
> +};

> +
> +#define PAC1944_VSENSE_CHANNEL(_index, _si, _address, _ev_spec, _num_ev_spec) {\
> +	.type = IIO_CURRENT,					\
> +	.address = (_address),					\
> +	.indexed = 1,						\
> +	.channel = (_index) + 1,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = (_si),					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\

You don't yet do buffered capture.  Until you do, better not to specify this stuff
as it is unused and might be wrong.. (see scan_index comments later).

> +	},							\
> +	.event_spec = (_ev_spec),				\
> +	.num_event_specs = (_num_ev_spec),			\
> +	.ext_info =  pac1944_ext_info				\
> +}

> +static int pac1944_reg_snapshot(struct pac1944_chip_info *info,
> +				bool do_refresh, u8 refresh_cmd, u32 wait_time)
> +{
> +	int ret;
> +	struct i2c_client *client = info->client;
> +	u8 shift, idx;
> +	u8 *offset_reg_data_p;
> +	int cnt;
Combine this with ret;

> +	u32 count, inc_count;
> +	u32 fs = 0;
> +	s64 stored_value, tmp_s64;
> +	s64 inc = 0;
> +	u16 tmp_u16;
> +	bool is_unipolar;
> +
> +	guard(mutex)(&info->lock);
> +
> +	if (do_refresh) {
> +		ret = pac1944_send_refresh(info, refresh_cmd, wait_time);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "%s - cannot send refresh towards PAC1944\n",
> +				__func__);
> +			return ret;
> +		}
> +	}
> +
> +	/* Read the ctrl/status registers for this snapshot */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_ACT_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_u16);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
> +			__func__, PAC1944_CTRL_ACT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	be16_to_cpus(&tmp_u16);

As in cases below I'd prefer a read into __be16 etc and be16_to_cpu() on the correct
type.

> +	info->chip_reg_data.ctrl_act_reg = tmp_u16;
> +
> +		info->chip_reg_data.vacc[cnt] =
> +		pac1944_get_unaligned_be56(offset_reg_data_p);
> +		is_unipolar = true;
> +
> +		switch (info->chip_reg_data.accumulation_mode[cnt]) {
> +		case PAC1944_ACCMODE_VPOWER:
> +			if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG ||
> +			    info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +				is_unipolar = FALSE;

false

> +			break;
> +		case PAC1944_ACCMODE_VBUS:
> +			if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +				is_unipolar = FALSE;
> +			break;
> +		case PAC1944_ACCMODE_VSENSE:
> +			if (info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +				is_unipolar = FALSE;
> +			break;
> +		}
> +
> +		if (!is_unipolar)
> +			info->chip_reg_data.vacc[cnt] =
> +			sign_extend64(info->chip_reg_data.vacc[cnt], 55);

Add another tab before the sign_extent64()

> +
> +		if (info->chip_reg_data.accumulation_mode[cnt] != PAC1944_ACCMODE_VBUS) {
> +			/*
> +			 * Integrate the accumulated power or current over
> +			 * the elapsed interval.
> +			 */
> +			tmp_u16 = info->chip_reg_data.ctrl_lat_reg >> 12;
> +
> +			tmp_s64 = info->chip_reg_data.vacc[cnt];
> +			if (tmp_u16 < PAC1944_SAMP_FAST_MODE) {
> +				/*
> +				 * Find how much shift is required by the sample rate
> +				 * The chip's sampling rate is 2^shift samples/sec
> +				 */
> +				shift = shift_map_tbl[tmp_u16];
> +				inc = tmp_s64 >> shift;
> +			} else if (tmp_u16 <= PAC1944_SAMP_BURST_MODE) {
> +				idx = info->num_enabled_channels - 1;
> +
> +				if (tmp_u16 == PAC1944_SAMP_FAST_MODE)
> +					fs = samp_rate_fast_mode_tbl[idx];
> +				else
> +					/* tmp_u16 == PAC1944_SAMP_BURST_MODE) */
> +					fs = samp_rate_burst_mode_tbl[idx];
> +
> +				inc = div_u64(abs(tmp_s64), fs);
> +				if (tmp_s64 < 0)
> +					inc = -inc;
> +			} else {
> +				dev_err(&client->dev, "Invalid sample rate index: %d!\n",
> +					tmp_u16);
This isn't expected to occur. I'd just error out. Device is likely in dead state
anyway if we see this.

> +			}
> +		} else {
> +			count = info->chip_reg_data.total_samples_nr[cnt];
> +			inc_count = info->chip_reg_data.acc_count;
> +
> +			/* Check if total number of samples will overflow */
> +			if (unlikely(check_add_overflow(count, inc_count, &count))) {
> +				dev_err(&client->dev,
> +					"Number of samples on channel [%d] overflow!\n",
> +					cnt + 1);
> +				info->chip_reg_data.total_samples_nr[cnt] = 0;
> +				info->chip_reg_data.acc_val[cnt] = 0;
> +			}
> +
> +			info->chip_reg_data.total_samples_nr[cnt] += inc_count;
> +
> +			inc = info->chip_reg_data.vacc[cnt];
> +		}
> +
> +		if (unlikely(check_add_overflow(stored_value, inc, &stored_value))) {

Don't bother with unlikely marking.  These are only worth doing if you have
numbers to back them up to show significant perf improvement.
Let the branch predictors do their work here. Or if CPU is mostly in order the
unlikely isn't that useful anyway.


> +			if (is_negative(stored_value))
> +				info->chip_reg_data.acc_val[cnt] = S64_MIN;
> +			else
> +				info->chip_reg_data.acc_val[cnt] = S64_MAX;
> +
> +			dev_err(&client->dev, "Overflow detected on channel [%d]!\n",
> +				cnt + 1);
> +		} else {
> +			info->chip_reg_data.acc_val[cnt] += inc;
> +		}
> +
> +		offset_reg_data_p += PAC1944_VACC_REG_LEN;
> +	}
...


> +
> +static int pac1944_prep_custom_attributes(struct pac1944_chip_info *info,
> +					  struct iio_dev *indio_dev)
> +{
> +	int ch, i, j, idx;
> +	int active_channels_count = 0;
> +	struct attribute **pac1944_custom_attrs, **tmp_attr;
> +	struct attribute_group *pac1944_group;
> +	int custom_attr_cnt;
> +	struct i2c_client *client = info->client;
> +
> +	for (i = 0 ; i < info->phys_channels; i++)
> +		if (info->active_channels[i])
> +			active_channels_count++;
> +
> +	pac1944_group = devm_kzalloc(&client->dev, sizeof(*pac1944_group), GFP_KERNEL);
> +	if (!pac1944_group)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Attributes for channel X:
> +	 *	- in_shunt_value_X
> +	 *	- in_oc_limit_nsamples
> +	 *	- in_uc_limit_nsamples
> +	 *	- in_op_limit_nsamples
> +	 *	- in_ov_limit_nsamples
> +	 *	- in_uv_limit_nsamples
> +	 *	- one of pair attributes:
> +	 *		- in_power_accX_raw and in_power_accX_scale
> +	 *		- in_current_accX_raw and in_current_accX_scale
> +	 *		- in_voltage_accX_raw and in_voltage_accX_scale
These all need documentation.  Potentailly these should be
in_voltageX_acc_raw.
I'm not sure they make sense as separate channels unless people will
want to capture them via a buffered mode.  Given the whole point
is to get a number over a long time period I'm not sure that usecase exists.
So maybe we treat them like existing average info_mask element.


> +	 * Shared attributes:
> +	 *	- in_acc_fullness
> +	 *	- in_alert_enable
> +	 *	- in_slow_alert1
Not sure why these can't be handled with normal event controls, but with
docs it will be easier to tell.

> +	 *	- gpio_alert2
> +	 *	- out_alert_status
> +	 * NULL
> +	 */
> +	custom_attr_cnt = PAC1944_COMMON_DEVATTR * active_channels_count;
> +	custom_attr_cnt += PAC1944_ACC_DEVATTR * active_channels_count;
> +	custom_attr_cnt += PAC1944_SHARED_DEVATTRS_COUNT;
> +
> +	pac1944_custom_attrs = devm_kzalloc(&client->dev, custom_attr_cnt *
> +					    sizeof(*pac1944_group) + 1, GFP_KERNEL);
> +	if (!pac1944_custom_attrs)
> +		return -ENOMEM;
> +
> +	j = 0;
> +	for (ch = 0 ; ch < info->phys_channels; ch++) {
> +		if (!info->active_channels[ch])
> +			continue;
> +
> +		for (i = 0; i < PAC1944_COMMON_DEVATTR; i++)
> +			pac1944_custom_attrs[j++] =
> +				pac1944_all_attrs[PAC1944_COMMON_DEVATTR * ch + i];
> +
> +		idx = ch;
> +		switch (info->chip_reg_data.accumulation_mode[ch]) {
> +		case PAC1944_ACCMODE_VPOWER:
> +			tmp_attr = pac1944_power_acc_attr;
> +			break;
> +		case PAC1944_ACCMODE_VSENSE:
> +			tmp_attr = pac1944_current_acc_attr;
> +			break;
> +		case PAC1944_ACCMODE_VBUS:
> +			tmp_attr = pac1944_voltage_acc_attr;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		pac1944_custom_attrs[j++] = tmp_attr[ch];
> +		pac1944_custom_attrs[j++] = pac1944_power_acc_attr[PAC1944_MAX_CH + ch];
> +		pac1944_custom_attrs[j++] = pac1944_power_acc_attr[2 * PAC1944_MAX_CH + ch];
> +	}
> +
> +	for (i = 0; i < PAC1944_SHARED_DEVATTRS_COUNT; i++)
> +		pac1944_custom_attrs[j++] =
> +			pac1944_all_attrs[PAC1944_COMMON_DEVATTR * PAC1944_MAX_CH + i];
> +
> +	pac1944_group->attrs = pac1944_custom_attrs;
> +	info->iio_info.attrs = pac1944_group;
> +
> +	return 0;
> +}
> +
> +static int pac1944_frequency_set(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 unsigned int mode)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	u16 tmp_be16, tmp_u16;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_ACT_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_u16);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
> +			__func__, PAC1944_CTRL_ACT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	be16_to_cpus(&tmp_u16);
As below - read into a __be16 then convert to u16 for next bit.

> +	tmp_u16 &= (u16)0x00ff;
Odd to nock out 4 bits that you then don't set.
Why not 0xfff?

> +	tmp_u16 |= (u16)(mode << 12);

FIELD_PREP;

> +	tmp_be16 = tmp_u16;
> +	cpu_to_be16s(&tmp_be16);
> +
> +	scoped_guard(mutex, &info->lock) {
> +		ret = i2c_smbus_write_word_data(client, PAC1944_CTRL_REG_ADDR, tmp_be16);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Failed to configure sampling mode\n");
> +			return ret;
> +		}
> +
> +		info->sampling_mode = mode;
> +		info->chip_reg_data.ctrl_act_reg = tmp_u16;
> +	}
> +
> +	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

> +static const struct iio_enum sampling_mode_enum = {
> +	.items = pac1944_frequency_avail,
> +	.num_items = ARRAY_SIZE(pac1944_frequency_avail),
> +	.set = pac1944_frequency_set,
> +	.get = pac1944_frequency_get,
> +};
> +
> +static const struct iio_chan_spec_ext_info pac1944_ext_info[] = {
> +	IIO_ENUM("sampling_frequency", IIO_SHARED_BY_ALL, &sampling_mode_enum),
Why not use the normal info_mask elements?  Where possible I'd prefer to
see that to ext_info stuff.

> +	{
> +		.name = "sampling_frequency_available",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = iio_enum_available_read,
> +		.private = (uintptr_t)&sampling_mode_enum,
> +	},
> +	{}
> +};
> +
> +static int pac1944_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	int ret, idx;
> +	u64 tmp;
> +
> +	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	/*
> +	 * For AVG the index should be between 5 to 8.
> +	 * To calculate PAC1944_CH_VOLTAGE_AVERAGE and

Very short wrap. Go for < 80 chars (just)

> +	 * PAC1944_CH_CURRENT_AVERAGE real index, we need
> +	 * to remove the added offset (PAC1944_MAX_CH).
> +	 */
..

> +
> +static int pac1944_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan, enum iio_event_type type,
> +				enum iio_event_direction dir, enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct pac1944_chip_info *chip_info = iio_priv(indio_dev);
> +	int idx, ret;
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			scoped_guard(mutex, &chip_info->lock) {
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_OV_LIMIT_REG_ADDR + idx,
> +							       (int)(PAC1944_CH01UV_MASK >> idx),
> +							       val);
> +				if (!ret)
> +					chip_info->overvoltage[idx] = val;
> +			}
> +			return ret;
> +		case IIO_EV_DIR_FALLING:
> +			scoped_guard(mutex, &chip_info->lock) {
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_UV_LIMIT_REG_ADDR + idx,
> +							       (int)(PAC1944_CH01UV_MASK >> idx),
> +							       val);
> +				if (!ret)
> +					chip_info->undervoltage[idx] = val;
> +			}
> +			return ret;
> +		default:
> +			return -EINVAL;
Given we don't care about performance of error paths I'd just take
guard(mutex)(&chip_info->lock)
outside the outer switch statement.

> +		}
> +	case IIO_CURRENT:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			scoped_guard(mutex, &chip_info->lock) {
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_OC_LIMIT_REG_ADDR + idx,
> +							       (int)(PAC1944_CH01OC_MASK >> idx),
> +							       val);
> +				if (!ret)
> +					chip_info->overcurrent[idx] = val;
> +			}
> +			return ret;
> +		case IIO_EV_DIR_FALLING:
> +			scoped_guard(mutex, &chip_info->lock) {
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_UC_LIMIT_REG_ADDR + idx,
> +							       (int)(PAC1944_CH01UC_MASK >> idx),
> +							       val);
> +				if (!ret)
> +					chip_info->undercurrent[idx] = val;
> +			}
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_POWER:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			scoped_guard(mutex, &chip_info->lock) {
> +				ret = pac1944_update_alert_24b(&indio_dev->dev,
> +							       PAC1944_OP_LIMIT_REG_ADDR + idx,
> +							       (int)(PAC1944_CH01OP_MASK >> idx),
> +							       val);
> +				if (!ret)
> +					chip_info->overpower[idx] = val;
> +			}
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pac1944_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	int idx;
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	scoped_guard(mutex, &info->lock) {
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				switch (idx) {
> +				case 0:
> +					return FIELD_GET(PAC1944_CH01OV_MASK, info->alert_enable);
As below - look these masks up in some array of const structures to avoid
all these case statements across 0..3

> +				case 1:
> +					return FIELD_GET(PAC1944_CH02OV_MASK, info->alert_enable);
> +				case 2:
> +					return FIELD_GET(PAC1944_CH03OV_MASK, info->alert_enable);
> +				case 3:
> +					return FIELD_GET(PAC1944_CH04OV_MASK, info->alert_enable);
> +				default:
> +					return -EINVAL;

...

> +}
> +
> +static int pac1944_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int idx, val, mask, ret;
> +	bool update = false;
> +	u8 tmp[PAC1944_ALERT_ENABLE_REG_LEN];
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	guard(mutex)(&info->lock);
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			switch (idx) {
Use data?  So define an array (or maybe array of structures)
that lets you just look these up directly.
Should save a lot of code.


> +			case 0:
> +				mask = PAC1944_CH01OV_MASK;
> +				break;
> +			case 1:
> +				mask = PAC1944_CH02OV_MASK;
> +				break;
> +			case 2:
> +				mask = PAC1944_CH03OV_MASK;
> +				break;
> +			case 3:
> +				mask = PAC1944_CH04OV_MASK;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			break;

...


> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/UserGuides/PAC194X_5X-UEFI-BIOS-Integration-and-Microsoft-Windows-10-and-Windows-11-Energy-Meter-Interface-Device-Driver-Users-Guide-DS50003155.pdf
> + */
> +static bool pac1944_acpi_parse_channel_config(struct i2c_client *client,
return an int to avoid eating useful error info.

> +					      struct pac1944_chip_info *info)
> +{
> +	acpi_handle handle;
> +	union acpi_object *rez;
> +	struct device *dev = &client->dev;
> +	unsigned short bi_dir_mask;
> +	int i;
> +	guid_t guid;
> +	const struct acpi_device_id *id;
> +
> +	handle = ACPI_HANDLE(dev);
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return false;
> +
> +	guid_parse(PAC1944_DSM_UUID, &guid);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1944_ACPI_GET_NAMES, NULL);
> +	if (!rez)
> +		return false;
> +
> +	for (i = 0; i < rez->package.count; i++) {
> +		info->labels[i] = devm_kmemdup(dev, rez->package.elements[i].string.pointer,
> +					       (size_t)rez->package.elements[i].string.length + 1,
> +					       GFP_KERNEL);
> +		info->labels[i][rez->package.elements[i].string.length] = '\0';
> +	}
> +
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1944_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez)
> +		return false;
> +
> +	for (i = 0; i < rez->package.count; i++) {
> +		info->shunts[i] = rez->package.elements[i].integer.value;
> +		info->active_channels[i] = (info->shunts[i] != 0);
> +	}
> +
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1944_ACPI_GET_BIPOLAR_SETTINGS, NULL);
> +	if (!rez)
> +		return false;
> +
> +	for (i = 0; i < (rez->package.count >> 1); i++) {
> +		if (!info->active_channels[i])
> +			continue;
> +
> +		bi_dir_mask = rez->package.elements[i].integer.value;
> +
> +		if (bi_dir_mask == PAC1944_UNIPOLAR_FSR_CFG ||
> +		    bi_dir_mask == PAC1944_BIPOLAR_FSR_CFG  ||
> +		    bi_dir_mask == PAC1944_BIPOLAR_HALF_FSR_CFG) {
> +			dev_dbg(dev, "VBUS{%d} mode set to: %d\n",
> +				i, bi_dir_mask);
> +			info->chip_reg_data.vbus_mode[i] = bi_dir_mask;
> +		} else {
> +			dev_err(dev, "invalid vbus-mode value on %i\n", i);
> +		}
> +
> +		bi_dir_mask = rez->package.elements[i + PAC1944_MAX_CH].integer.value;
> +
> +		if (bi_dir_mask == PAC1944_UNIPOLAR_FSR_CFG ||
> +		    bi_dir_mask == PAC1944_BIPOLAR_FSR_CFG  ||
> +		    bi_dir_mask == PAC1944_BIPOLAR_HALF_FSR_CFG) {
> +			dev_dbg(dev, "VSENSE{%d} mode set to: %d\n", i, bi_dir_mask);
> +			info->chip_reg_data.vsense_mode[i] = bi_dir_mask;
> +		} else {
> +			dev_err(dev, "invalid vsense-mode value on %i\n", i);

If you get an error due to something we don't know how to parse then should return
an error code and fail probe. If we don't this stuff tends not to get fixed.


> +		}
> +	}
> +
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1944_ACPI_GET_SAMP, NULL);
> +	if (!rez)
> +		return false;
> +
> +	info->sample_rate_value = rez->package.elements[0].integer.value;
> +
> +	ACPI_FREE(rez);
> +
> +	return true;
> +}
> +
> +static bool pac1944_of_parse_channel_config(struct i2c_client *client,
return an int so the error codes aren't eaten up.

> +					    struct pac1944_chip_info *info)
> +{
> +	struct fwnode_handle *node, *fwnode;
> +	unsigned int current_channel;
> +	int idx, ret;
> +	int temp;
> +
> +	current_channel = 1;
> +
> +	fwnode = dev_fwnode(&client->dev);
> +	fwnode_for_each_available_child_node(fwnode, node) {
Ah. This old one - there was a debate about improving the docs on this but not
sure it ever got resolved.

Just use
	device_for_each_child_node_scoped()
It only applies to available nodes and you can avoid the goto fun.

> +		ret = fwnode_property_read_u32(node, "reg", &idx);
> +		if (ret) {
> +			dev_err_probe(&client->dev, ret,
> +				      "reading invalid channel index\n");
> +			goto err_fwnode;
return dev_err_probe() etc once using the scope loop that releases
the fwnode automatically.


> +		}
> +		/* adjust idx to match channel index (1 to 4) from the datasheet */
> +		idx--;
> +
> +		if (current_channel >= (info->phys_channels + 1) ||
> +		    idx >= info->phys_channels || idx < 0) {
> +			dev_err(&client->dev,
> +				"invalid channel_index %d value on %s\n",
> +				(idx + 1), fwnode_get_name(node));
> +			goto err_fwnode;
> +		}
> +
> +		/* enable channel */
> +		info->active_channels[idx] = true;
> +
> +		ret = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
> +					       &info->shunts[idx]);
> +		if (ret) {
> +			dev_err_probe(&client->dev, ret,
> +				      "%s: invalid shunt-resistor value: %d\n",
> +				      fwnode_get_name(node), info->shunts[idx]);
> +			goto err_fwnode;
> +		}
> +
> +		if (fwnode_property_present(node, "label")) {
> +			fwnode_property_read_string(node, "label",
> +						    (const char **)&info->labels[idx]);
> +		}
> +
> +		ret = fwnode_property_read_u32(node, "microchip,vbus-mode", &temp);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"invalid vbus-mode value on %s\n",
> +				fwnode_get_name(node));
> +			goto err_fwnode;
> +		}
> +		if (temp == PAC1944_UNIPOLAR_FSR_CFG ||
> +		    temp == PAC1944_BIPOLAR_FSR_CFG  ||
> +		    temp == PAC1944_BIPOLAR_HALF_FSR_CFG) {
> +			dev_dbg(&client->dev,
> +				"VBUS{%d} mode set to: %d\n",
> +				idx, temp);
> +			info->chip_reg_data.vbus_mode[idx] = temp;
> +		} else {
> +			dev_err(&client->dev,
> +				"invalid vbus-mode value on %s\n",
> +				fwnode_get_name(node));
> +			goto err_fwnode;
> +		}
> +
> +		ret = fwnode_property_read_u32(node, "microchip,vsense-mode", &temp);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"invalid vsense-mode value on %s\n",
> +				fwnode_get_name(node));
> +			goto err_fwnode;
> +		}
> +		if (temp == PAC1944_UNIPOLAR_FSR_CFG ||
> +		    temp == PAC1944_BIPOLAR_FSR_CFG  ||
> +		    temp == PAC1944_BIPOLAR_HALF_FSR_CFG) {
> +			dev_dbg(&client->dev,
> +				"VSENSE{%d} mode set to: %d\n",
> +				idx, temp);
> +			info->chip_reg_data.vsense_mode[idx] = temp;
> +		} else {
> +			dev_err(&client->dev,
> +				"invalid vsense-mode value on %s\n",
> +				fwnode_get_name(node));
> +			goto err_fwnode;
> +		}
> +
> +		ret = fwnode_property_read_u32(node, "microchip,accumulation-mode", &temp);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"invalid accumulation-mode value on %s\n",
> +				fwnode_get_name(node));
> +			goto err_fwnode;
> +		}
> +		if (temp == PAC1944_ACCMODE_VPOWER ||
> +		    temp == PAC1944_ACCMODE_VSENSE ||
> +		    temp == PAC1944_ACCMODE_VBUS) {
> +			dev_dbg(&client->dev,
> +				"Accumulation{%d} mode set to: %d\n",
> +				idx, temp);
> +			info->chip_reg_data.accumulation_mode[idx] = temp;
> +		} else {
> +			dev_err(&client->dev,
> +				"invalid mode for accumulator value on %s\n",
> +				fwnode_get_name(node));
> +		}
> +		current_channel++;
> +	}
> +
> +	return true;
> +
> +err_fwnode:
> +	fwnode_handle_put(node);
> +
> +	return false;
> +}
> +
> +static void pac1944_cancel_delayed_work(void *dwork)
> +{
> +	cancel_delayed_work_sync(dwork);
> +}
> +
> +static int pac1944_chip_identify(struct pac1944_chip_info *info)
> +{
> +	int ret = 0;
> +	struct i2c_client *client = info->client;
> +	u8 chip_rev_info[3];
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_PID_REG_ADDR,
> +					    sizeof(chip_rev_info),
> +					    chip_rev_info);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot read revision\n");
> +		return ret;
deV_err_probe()

> +	}
> +
> +	dev_info(&client->dev, "Chip revision: 0x%02X\n", chip_rev_info[2]);
> +	info->chip_revision = chip_rev_info[2];
> +	info->chip_variant = chip_rev_info[0];
> +
> +	switch (chip_rev_info[0]) {
> +	case PAC_PRODUCT_ID_1941_1:
> +	case PAC_PRODUCT_ID_1942_1:
> +	case PAC_PRODUCT_ID_1943_1:
> +	case PAC_PRODUCT_ID_1944_1:
> +	case PAC_PRODUCT_ID_1941_2:
> +	case PAC_PRODUCT_ID_1942_2:
> +		info->is_pac195x_family = false;
> +		return (chip_rev_info[0] - PAC_PRODUCT_ID_1941_1);
drop the outer brackets as don't add anything
> +	case PAC_PRODUCT_ID_1951_1:
> +	case PAC_PRODUCT_ID_1952_1:
> +	case PAC_PRODUCT_ID_1953_1:
> +	case PAC_PRODUCT_ID_1954_1:
> +	case PAC_PRODUCT_ID_1951_2:
> +	case PAC_PRODUCT_ID_1952_2:
> +		info->is_pac195x_family = true;
> +		return ((chip_rev_info[0] - PAC_PRODUCT_ID_1951_1) +
> +			(PAC_PRODUCT_ID_1942_2 - PAC_PRODUCT_ID_1941_1) + 1);
Same here. The outermost brackets aren't needed.
> +	default:
> +		dev_err(&client->dev,
> +			"product ID (0x%02X, 0x%02X, 0x%02X) for this part doesn't match\n",
> +			chip_rev_info[0], chip_rev_info[1], chip_rev_info[2]);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pac1944_chip_configure(struct pac1944_chip_info *info)
> +{
> +	int cnt, ret = 0;

ret always set before use.
Also don't combine declarations that set values with ones that don't.
It isn't good for readability as can easily miss one that isn't set
amongst many that are.

> +	struct i2c_client *client = info->client;
> +	u8 regs[PAC1944_ALERTS_REG_LEN];
> +	u8 *offset_p;
> +	u32 wait_time;
> +	u8 tmp_u8;
> +	u16 tmp_u16;
> +
> +	/*
> +	 * Counting how many channels are enabled and store
> +	 * this information within the driver data
> +	 */
> +	cnt = 0;
> +	info->num_enabled_channels = 0;
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (info->active_channels[cnt])
> +			info->num_enabled_channels++;
with a bitmap, consider hweight()

> +	}
> +
> +	/* get sampling rate from PAC */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_u16);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot read 0x%02X reg\n", PAC1944_CTRL_REG_ADDR);
> +		return ret;
If only used from probe, return dev_err_probe()
etc

> +	}
> +	be16_to_cpus(&tmp_u16);

Better to keep types clean. So read into a local __be16 then convert.

> +
> +	info->sampling_mode = FIELD_GET(PAC1944_CTRL_SAMPLE_MASK, tmp_u16);
can do that conversion inline so no need to set tmp_u16 at all
be16_to_cpu(tmp_be16)

> +
> +	/*
> +	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
> +	 * no SLOW triggered REFRESH, clear POR
> +	 */
> +
> +	tmp_u16 = FIELD_PREP(PAC1944_NEG_PWR_CFG_VS1_MASK, info->chip_reg_data.vsense_mode[0]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS2_MASK, info->chip_reg_data.vsense_mode[1]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS3_MASK, info->chip_reg_data.vsense_mode[2]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS4_MASK, info->chip_reg_data.vsense_mode[3]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB1_MASK, info->chip_reg_data.vbus_mode[0]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB2_MASK, info->chip_reg_data.vbus_mode[1]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB3_MASK, info->chip_reg_data.vbus_mode[2]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB4_MASK, info->chip_reg_data.vbus_mode[3]);
> +
> +	cpu_to_be16s(&tmp_u16);

Again, I'd prefer to see explicit type for the __be16 storage.
One of the static analysers really doesn't like them being stored in non __be types.

> +
> +	ret = i2c_smbus_write_word_data(client, PAC1944_NEG_PWR_FSR_REG_ADDR, tmp_u16);
> +	if (ret) {
> +		dev_err(&client->dev, "cannot write 0x%02X reg\n",
> +			PAC1944_NEG_PWR_FSR_REG_ADDR);
> +		return ret;
> +	}
> +
> +	tmp_u16 = 0;
just put the 0 inline.

> +	ret = i2c_smbus_write_word_data(client, PAC1944_SLOW_REG_ADDR, tmp_u16);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot write 0x%02X reg\n",
> +			PAC1944_SLOW_REG_ADDR);
> +		return ret;
> +	}
> +
> +	/* Write the CHANNEL_N_OFF from CTRL REGISTER */
> +	tmp_u16 = FIELD_PREP(PAC1944_CTRL_SAMPLE_MASK, info->sampling_mode) |
> +		FIELD_PREP(PAC1944_CTRL_GPIO_ALERT2_MASK, 0) |
> +		FIELD_PREP(PAC1944_CTRL_SLOW_ALERT1_MASK, 0) |
> +		FIELD_PREP(PAC1944_CTRL_CH_1_OFF_MASK, !(info->active_channels[0])) |
> +		FIELD_PREP(PAC1944_CTRL_CH_2_OFF_MASK, !(info->active_channels[1])) |
> +		FIELD_PREP(PAC1944_CTRL_CH_3_OFF_MASK, !(info->active_channels[2])) |
> +		FIELD_PREP(PAC1944_CTRL_CH_4_OFF_MASK, !(info->active_channels[3]));
> +
> +	cpu_to_be16s(&tmp_u16);
> +
> +	ret = i2c_smbus_write_word_data(client, PAC1944_CTRL_REG_ADDR, tmp_u16);
> +	if (ret) {
> +		dev_err(&client->dev, "cannot write 0x%02X reg\n",
> +			PAC1944_CTRL_REG_ADDR);
> +		return ret;
> +	}
> +
> +	tmp_u8 = ACCUM_REG(info->chip_reg_data.accumulation_mode[0],
> +			   info->chip_reg_data.accumulation_mode[1],
> +			   info->chip_reg_data.accumulation_mode[2],
> +			   info->chip_reg_data.accumulation_mode[3]);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1944_ACCUM_CFG_REG_ADDR, tmp_u8);
> +	if (ret) {
> +		dev_err(&client->dev, "cannot write 0x%02X reg\n",
> +			PAC1944_ACCUM_CFG_REG_ADDR);
> +		return ret;
> +	}
> +
> +	/* reading all alerts, status and limits related registers */
> +	ret = pac1944_i2c_read(client, PAC1944_ALERT_STATUS_REG_ADDR,
> +			       (u8 *)regs, sizeof(regs));

regs is an u8 * already.

> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot read 0x%02X reg\n",
> +			PAC1944_ALERT_STATUS_REG_ADDR);
> +		return ret;
> +	}
> +
> +	offset_p = &regs[0];
> +
> +	/* skip alert_status register*/
> +	offset_p += 3;
> +
> +	info->slow_alert1 =  get_unaligned_be24(offset_p);
> +	offset_p += 3;
> +
> +	info->gpio_alert2 =  get_unaligned_be24(offset_p);
> +	offset_p += 3;
> +
> +	tmp_u16 = get_unaligned_be16(offset_p);
> +	offset_p += 2;
> +
> +	info->acc_fullness = get_unaligned_be16(offset_p);
> +	offset_p += 2;
> +
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
> +		info->overcurrent[cnt] = get_unaligned_be16(offset_p);
> +		offset_p += 2;
> +	}
> +
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
> +		info->undercurrent[cnt] = get_unaligned_be16(offset_p);
> +		offset_p += 2;
> +	}
> +
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
> +		info->overpower[cnt] =  get_unaligned_be24(offset_p);
> +		offset_p += 3;
> +	}
> +
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
> +		info->overvoltage[cnt] = get_unaligned_be16(offset_p);
> +		offset_p += 2;
> +	}
> +
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
> +		info->undervoltage[cnt] = get_unaligned_be16(offset_p);
> +		offset_p += 2;
> +	}
> +
> +	offset_p += 1;
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
> +		info->oc_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
> +
> +	offset_p += 1;
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
> +		info->uc_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
> +
> +	offset_p += 1;
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
> +		info->op_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
> +
> +	offset_p += 1;
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
> +		info->ov_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
> +
> +	offset_p += 1;
> +	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
> +		info->uv_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
> +
> +	offset_p += 1;
> +	info->alert_enable =  get_unaligned_be24(offset_p);
> +
> +	/*
> +	 * Sending a REFRESH to the chip, so the new settings take place
> +	 * as well as resetting the accumulators
> +	 */
> +	ret = i2c_smbus_write_byte(client, PAC1944_REFRESH_REG_ADDR);
> +	if (ret) {
> +		dev_err(&client->dev, "cannot write 0x%02X reg\n",
> +			PAC1944_REFRESH_REG_ADDR);
> +		return ret;
> +	}
return dev_err_probe()..

> +
> +	/*
> +	 * Get the current (in the chip) sampling speed and compute the
> +	 * required timeout based on its value the timeout is 1/sampling_speed
> +	 * wait the maximum amount of time to be on the safe side - the
> +	 * maximum wait time is for 8sps
> +	 */
> +	wait_time = (1024 / samp_rate_map_tbl[info->sampling_mode]) * 1000;
> +	usleep_range(wait_time, wait_time + 100);
> +
> +	INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1944_work_periodic_rfsh);
> +	/* Setup the latest moment for reading the regs before saturation */
> +	schedule_delayed_work(&info->work_chip_rfsh,
> +			      msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
> +
> +	return devm_add_action_or_reset(&client->dev, pac1944_cancel_delayed_work,
> +					&info->work_chip_rfsh);
> +}
> +
> +static const struct iio_chan_spec pac1944_single_channel[] = {
> +	PAC1944_VPOWER_CHANNEL(0, 0, PAC1944_VPOWER_1_ADDR, pac1944_single_event,
> +			       ARRAY_SIZE(pac1944_single_event)),
> +	PAC1944_VBUS_CHANNEL(0, 0, PAC1944_VBUS_1_ADDR, pac1944_events,
> +			     ARRAY_SIZE(pac1944_events)),
> +	PAC1944_VSENSE_CHANNEL(0, 0, PAC1944_VSENSE_1_ADDR, pac1944_events,
> +			       ARRAY_SIZE(pac1944_events)),
> +	PAC1944_VBUS_AVG_CHANNEL(0, 0, PAC1944_VBUS_AVG_1_ADDR),
> +	PAC1944_VSENSE_AVG_CHANNEL(0, 0, PAC1944_VSENSE_AVG_1_ADDR),
> +};
> +
> +static int pac1944_prep_iio_channels(struct pac1944_chip_info *info,
> +				     struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &info->client->dev;
> +	struct iio_chan_spec *ch_sp;
> +	int channel_size, attribute_count;
> +	int cnt;

combine with line above.

> +	void *dyn_ch_struct, *tmp_data;
> +
> +	/* Finding out dynamically how many IIO channels we need */
> +	attribute_count = 0;
> +	channel_size = 0;
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (!info->active_channels[cnt])
If you use a bitmap for this you can easily loop over the
bits that are set.

> +			continue;
> +
> +		/* add the size of the properties of one chip physical channel */
> +		channel_size += sizeof(pac1944_single_channel);
> +		/* count how many enabled channels we have */
> +		attribute_count += ARRAY_SIZE(pac1944_single_channel);
> +		dev_info(dev, ":%s: Channel %d active\n", __func__, cnt + 1);
Noisy - make this a dev_dbg()

> +	}
> +
> +	dyn_ch_struct = devm_kzalloc(dev, channel_size, GFP_KERNEL);
> +	if (!dyn_ch_struct)
> +		return -EINVAL;
> +
> +	tmp_data = dyn_ch_struct;
tmp_data is a misleading name. It's data we keep, just a pointer into it.
So maybe think up a better name or just drag ch_sp setting out here.

> +	/* Populate the dynamic channels and make all the adjustments */
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (!info->active_channels[cnt])
> +			continue;
> +
> +		memcpy(tmp_data, pac1944_single_channel, sizeof(pac1944_single_channel));
> +		ch_sp = (struct iio_chan_spec *)tmp_data;
> +		ch_sp[PAC1944_CH_POWER].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_POWER].scan_index = cnt;
> +		ch_sp[PAC1944_CH_POWER].address = cnt + PAC1944_VPOWER_1_ADDR;
> +		ch_sp[PAC1944_CH_VOLTAGE].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_VOLTAGE].scan_index = cnt;

3 channels all have the same scan index.  That doesn't look right.
You aren't doing buffered capture so I guess that doesn't get used.
If so just don't set it.


> +		ch_sp[PAC1944_CH_VOLTAGE].address = cnt + PAC1944_VBUS_1_ADDR;
> +		ch_sp[PAC1944_CH_CURRENT].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_CURRENT].scan_index = cnt;
> +		ch_sp[PAC1944_CH_CURRENT].address = cnt + PAC1944_VSENSE_1_ADDR;
> +		/*
> +		 * In order to be able to use labels for PAC1944_CH_VOLTAGE and
> +		 * PAC1944_CH_VOLTAGE_AVERAGE, respectively PAC1944_CH_CURRENT
> +		 * and PAC1944_CH_CURRENT_AVERAGE we need to use different channel numbers.
> +		 * We will add  +5 (+1 to maximum PAC channels).
> +		 */
> +		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].channel = cnt + 5;
Probably use a define for the max channel count then +1 to that.
I've not figured out where the +1 comes from yet though. 
> +		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].scan_index = cnt;
> +		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].address = cnt + PAC1944_VBUS_AVG_1_ADDR;
> +		ch_sp[PAC1944_CH_CURRENT_AVERAGE].channel = cnt + 5;
> +		ch_sp[PAC1944_CH_CURRENT_AVERAGE].scan_index = cnt;
> +		ch_sp[PAC1944_CH_CURRENT_AVERAGE].address = cnt + PAC1944_VSENSE_AVG_1_ADDR;
> +
> +		/* advance the pointer */
> +		tmp_data += sizeof(pac1944_single_channel);
> +	}
> +
> +	/*
> +	 * Send the updated dynamic channel structure information towards IIO
> +	 * prepare the required field for IIO class registration
> +	 */
> +	indio_dev->num_channels = attribute_count;
> +	indio_dev->channels = (const struct iio_chan_spec *)dyn_ch_struct;
> +
> +	return 0;
> +}
>
> +
> +static int pac1944_probe(struct i2c_client *client)
> +{

> +
> +	mutex_init(&info->lock);
> +	ret = devm_add_action_or_reset(&client->dev, pac1944_mutex_destroy,
> +				       &info->lock);

The is finally a devm_mutex_init() upstream so use that instead.
Previously I'd have said it was not worth the bother; now it's easy!
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pac1944_chip_configure(info);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pac1944_prep_iio_channels(info, indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	info->iio_info = pac1944_info;
> +	indio_dev->info = &info->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = pac1944_prep_custom_attributes(info, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Can't configure custom attributes for PAC194x/5x device\n");
> +
> +	ret = pac1944_reg_snapshot(info, true, false,
> +				   PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Can't register IIO device\n");
> +
> +	return 0;
> +}
> +
>
> +
> +static const struct of_device_id pac1944_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1941_1",
> +		.data = (void *)&pac1944_chip_config[PAC1941_1]

Casts shouldn't be needed in this case I think?

> +	},
> +
> +/* using MCHP1940 to be compatible with BIOS ACPI */
Not sure we need the comment as the ID is a valid one.

> +static const struct acpi_device_id pac1944_acpi_match[] = {
> +	{ "MCHP1940", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1944_1] },
*Contented sigh* Nice to check one of these an find out that indeed
that is a valid ACPI ID :)

> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1944_acpi_match);
> +
> +static struct i2c_driver pac1944_driver = {
> +	.driver = {
> +		.name = "pac1944",
> +		.of_match_table = pac1944_of_match,
> +		.acpi_match_table = pac1944_acpi_match
> +	},
> +	.probe = pac1944_probe,
> +	.id_table = pac1944_id,
> +};
> +
> +module_i2c_driver(pac1944_driver);
> +
> +MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
> +MODULE_DESCRIPTION("Microchip PAC194X and PAC195X Power Monitor");
> +MODULE_LICENSE("GPL v2");


