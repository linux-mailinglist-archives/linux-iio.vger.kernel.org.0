Return-Path: <linux-iio+bounces-8540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1579955847
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A371C20C9D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108015099D;
	Sat, 17 Aug 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiDbKYt1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2D433A9;
	Sat, 17 Aug 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723903366; cv=none; b=igg7CEoIrIDb9E9rpAPfWOuu1wHZsg0JCqHEKFfrBks1N6UbGTLO955IYqH6SSdxZy+LVHybhds9sHZChwhJvKzucPpBr9hHgh8IZ4HfTYfC/wsSzr6yNYbBLO8KoQMqHAG9FO/m8MrSMJRf6AFeTJ2i+YvI143bfbukbgJxqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723903366; c=relaxed/simple;
	bh=MCOp0cKumuLCCLSMiKWSV1PZdjqgVnz4d6mUNfxd36E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp1lRxdvf2Uz2Oeb3D2h13IDKIU7xr1SvVKLMHzCougJE3x7bxwfNpmdrg4lYIIYz4ER+4rjGS40rreqT3qm6J4zvXzERUT05RJYQOUcgJG4fGStlB4dwcICwQEHjRAMgczMU0TO5t7JitX3pD2syzJg8aoJofAerQidKskfHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiDbKYt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8B7C116B1;
	Sat, 17 Aug 2024 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723903365;
	bh=MCOp0cKumuLCCLSMiKWSV1PZdjqgVnz4d6mUNfxd36E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QiDbKYt1SSjGHSVFgSqRubq8OTrQiR0wvagpTawyyCC4//iiQXBVLhoDp5LQyMqV0
	 qf9So9s2MtuNDAxSDVYHVrd8GoMXgkScfSG6wyz2uSe3MAfyYMkBKRB89rMhBBoPly
	 1ouhVobm05mE2+JdeUSl69oztV2shiV81Q5A9h0VZVjSZhA97kDcnhq45UFIq/4Ytd
	 9cgDec6Kvy+JNPhN1ODKbuU93pr00+NyURFoAwtgB2p1X85+MZrd3aFdjWVJpeiohk
	 NM94rInq+5Gbbc0Bz/lGMsXpIINl8BkFA80YLs3Rd3RZjwAJWXTLu3ekcQyFH6j74R
	 25oZmCrrdt5fQ==
Date: Sat, 17 Aug 2024 15:02:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>, Chao
 Zeng <chao.zeng@siemens.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: proximity: Add support for everlight pmd16d17
 sensor
Message-ID: <20240817150237.6c7297a5@jic23-huawei>
In-Reply-To: <abb0c1c0724be733138276f638e43e98784bd191.1723527641.git.jan.kiszka@siemens.com>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
	<abb0c1c0724be733138276f638e43e98784bd191.1723527641.git.jan.kiszka@siemens.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 07:40:42 +0200
Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Chao Zeng <chao.zeng@siemens.com>
> 
> Add initial support for everlight pm16d17 proximity sensor.
> 
> Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
> Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Hi Jan,

Various comments inline. 

Thanks,

Jonathan

> diff --git a/drivers/iio/proximity/pm16d17.c b/drivers/iio/proximity/pm16d17.c
> new file mode 100644
> index 000000000000..94f21fc5e2fb
> --- /dev/null
> +++ b/drivers/iio/proximity/pm16d17.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Siemens AG, 2023-2024
> + *
> + * Driver for Everlight PM-16d17 proximity sensor
> + *
> + * Author: Chao Zeng <chao.zeng@siemens.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
Unlikely you need this one...

> +#include <linux/interrupt.h>
Not in use yet?
> +#include <linux/irq.h>
> +#include <linux/module.h>

mod_devicetable.h
property.h

Also check these again as you should as currently written have had
of.h and don't, so may be other things missing.
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
Only needed if you are doing custom attrs. So drop.
> +#include <linux/iio/events.h>

Only needed for events. So drop for now.

> +
> +#define PM16D17_DRV_NAME		"pm16d17"
> +#define PM16D17_REGMAP_NAME		"pm16d17_regmap"
Don't have defines for these two. See later for more comments on that.
> +
> +/* Registers Address */
To keep clear distinction between fields and registers I'd add
_REG to end of these.

> +#define PM16D17_OP_MODE			0x00
> +#define PM16D17_INTERRUPT_FLAG		0x01
> +#define PM16D17_PS_SETTING		0x0A
> +#define PM16D17_VCSEL_DRIVE_CURRENT	0x0B
> +#define PM16D17_VCSEL_DRIVE_PULSE	0x0C
> +#define PM16D17_PS_INTUPT_LTHD_L	0x0D
> +#define PM16D17_PS_INTUPT_LTHD_H	0x0E
> +#define PM16D17_PS_INTUPT_HTHD_L	0x0F
> +#define PM16D17_PS_INTUPT_HTHD_H	0x10
> +#define PM16D17_PS_DATA_L		0x11
> +#define PM16D17_PS_DATA_H		0x12
> +#define PM16D17_PS_SETTING2		0x13
> +#define PM16D17_PS_OFFSET_CANCEL_L	0x14
> +#define PM16D17_PS_OFFSET_CANCEL_H	0x15
> +#define PM16D17_DEV_ID			0x18
> +
> +#define DEVICE_ID			0x11
Needs to be prefixed as DEVICE_ID is a very generic define!
PM16D17_DEV_ID_PM16D17 
or something like that to indicate which register and value means
what.

> +
> +#define ENABLE_PS_FUNCTION		BIT(3)
> +#define PS_GAIN_MASK			GENMASK(7, 6)
> +#define PS_ITIME_MASK			GENMASK(5, 3)
> +#define PS_WTIME_MASK			GENMASK(2, 0)
> +#define OFFSET_CANCEL_ENABLE		BIT(7)
> +#define PS_OFFSET_CANCEL_LSB_MASK	GENMASK(7, 0)
> +#define PS_OFFSET_CANCEL_MSB_MASK	GENMASK(15, 8)
> +
> +enum {
> +	PITIME_0_POINT_4_MS = (0 << 3),
> +	PITIME_0_POINT_8_MS = (1 << 3),
> +	PITIME_1_POINT_6_MS = (2 << 3),
> +	PITIME_3_POINT_2_MS = (3 << 3),
> +	PITIME_6_POINT_3_MS = (4 << 3),
> +	PITIME_12_POINT_6_MS = (5 << 3),
> +	PITIME_25_POINT_2_MS = (6 << 3),
Don't shift these values.

Use a suitable mask and FIELD_PREP() to shift them at the
point where you are writing them.

> +};
> +
> +enum {
> +	PWTIME_12_POINT_5_MS = 0,
> +	PWTIME_25_MS,
> +	PWTIME_50_MS,
> +	PWTIME_100_MS,
> +	PWTIME_200_MS,
> +	PWTIME_400_MS,
> +	PWTIME_800_MS,
> +	PWTIME_1600_MS,
> +};
> +
> +struct pm16d17_data {
> +	struct i2c_client *client;
As below. More useful to store &client->dev

> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config pm16d17_regmap_config = {
> +	.name = PM16D17_REGMAP_NAME,
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static const struct iio_chan_spec pm16d17_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.indexed = 1,
> +		.channel = 0,
> +		.scan_index = -1,
Don't need to set this unless you are registering the buffered
interfaces. So don't set it for now.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}
> +};
> +
> +static inline int pm16d17_write_reg(struct pm16d17_data *data,
> +				    unsigned int reg,
> +				    unsigned int value)
> +{
> +	return regmap_write(data->regmap, reg, value);

Get rid of these wrappers and call regmap_write / read directly inline.
These just make the code a little harder to read for no benefit.

> +}
> +
> +static inline unsigned int pm16d17_read_reg(struct pm16d17_data *data,
> +					    unsigned int reg,
> +					    unsigned int *reg_val)
> +{
> +	return regmap_read(data->regmap, reg, reg_val);
> +}
> +
> +static int pm16d17_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pm16d17_data *data = iio_priv(indio_dev);
> +	unsigned int ps_data_l;
> +	unsigned int ps_data_h;
> +	uint16_t ps_data;
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = pm16d17_read_reg(data, PM16D17_PS_DATA_L, &ps_data_l);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = pm16d17_read_reg(data, PM16D17_PS_DATA_H, &ps_data_h);
> +			if (ret < 0)
> +				return ret;
> +
> +			ps_data = (ps_data_h << 8) | ps_data_l;

read both values into a u8 [2] and use get_unaligned_be16() or similar.

Actually you should be able to do a bulk read (which is obvious once you
stop wrapping regmap calls with function s that suggest something more is going on).
> +
> +			dev_dbg(&data->client->dev, "PS data: %x\n", ps_data);
> +
> +			*val = ps_data;
> +			ret = IIO_VAL_INT;
> +			break;
			return IIO_VAL_INT;
> +		default:
> +			break;
return an error
> +		}
> +	default:
> +		break;
return an error.
> +	}
> +
Should not be able to get here so drop this (with above changes to return early)
> +	return ret;
> +}
> +
> +static const struct iio_info pm16d17_info = {
> +	.read_raw = pm16d17_read_raw,
> +};
> +
> +static int pm16d17_chip_init(struct pm16d17_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	struct device_node *np = client->dev.of_node;
> +	const char *conv_time = NULL;
> +	const char *wait_time = NULL;
> +	uint8_t op_mode_setting_val;
> +	uint32_t ps_offset_cancel;
> +	uint8_t offset_lsb;
> +	uint8_t offset_msb;
> +	uint32_t pulse_count;
> +	uint32_t pgain;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = pm16d17_read_reg(data, PM16D17_DEV_ID, &val);
> +
No blank line between a call and the check of it's error. Good keep them
logically associated.

> +	if (ret < 0 || (val != DEVICE_ID)) {
> +		dev_err(&client->dev, "Invalid chip id 0x%04x\n", val);
if (ret < 0)
	return dev_err_probe()
if (val != DEVICE_ID)
	dev_info(&client->dev, "Unexpected chip id ..." 
and carry on.

The reason for this is to enable use in future of fallback DT compatibles
so if a new device is released that is backwards compatible it can be supported
by existing distro kernels etc without change.

We used to get this wrong in IIO and haven't yet fixed all drivers so you
will see lots of examples similar to what you have here.


> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(&client->dev, "Detected PM16D17 with chip id: 0x%04x\n", val);
> +
> +	ret = pm16d17_write_reg(data, PM16D17_OP_MODE, ENABLE_PS_FUNCTION);
> +	if (ret < 0)
> +		return ret;
> +
> +	of_property_read_u32(np, "ps-gain", &pgain);
> +	switch (pgain) {
> +	case 1:
> +	case 2:
> +	case 4:
> +	case 8:
> +		op_mode_setting_val |= (ilog2(pgain) << 6) & PS_GAIN_MASK;
> +		break;
> +	default:
> +		break;

Not an error?

> +	}
> +
> +	of_property_read_string(np, "ps-itime", &conv_time);
Is strcmp safe for NULL? Seems unlikely.

Make the time in msecs / usecs of appropriate so you can handle it as an integer.

device_property_read_string()
Use the generic firmware stuff in linux/property.h instead of of calls thoughout.
That enables use of things like ACPI bindings via PRP0001 _HID

> +	if (strcmp(conv_time, "0.4") == 0)
> +		op_mode_setting_val |= PITIME_0_POINT_4_MS & PS_ITIME_MASK;
> +	else if (strcmp(conv_time, "0.8") == 0)
> +		op_mode_setting_val |= PITIME_0_POINT_8_MS & PS_ITIME_MASK;
> +	else if (strcmp(conv_time, "1.6") == 0)
> +		op_mode_setting_val |= PITIME_1_POINT_6_MS & PS_ITIME_MASK;
> +	else if (strcmp(conv_time, "3.2") == 0)
> +		op_mode_setting_val |= PITIME_3_POINT_2_MS & PS_ITIME_MASK;
> +	else if (strcmp(conv_time, "6.3") == 0)
> +		op_mode_setting_val |= PITIME_6_POINT_3_MS & PS_ITIME_MASK;
> +	else if (strcmp(conv_time, "12.6") == 0)
> +		op_mode_setting_val |= PITIME_12_POINT_6_MS & PS_ITIME_MASK;
> +	else if (strcmp(conv_time, "25.2") == 0)
> +		op_mode_setting_val |= PITIME_25_POINT_2_MS & PS_ITIME_MASK;
> +	else {
> +		dev_info(&client->dev, "Using default ps itime value\n");

If a property was there and invalid value error out, otherwise just
use default here without printing anything.

> +		op_mode_setting_val |= PITIME_0_POINT_4_MS & PS_ITIME_MASK;
> +	}
> +
> +	of_property_read_string(np, "ps-wtime", &wait_time);
Again, pick units so it's an integer. Other comments as above.

> +	if (strcmp(wait_time, "12.5") == 0)
> +		op_mode_setting_val |= PWTIME_12_POINT_5_MS & PS_WTIME_MASK;
> +	else if (strcmp(wait_time, "25") == 0)
> +		op_mode_setting_val |= PWTIME_25_MS & PS_WTIME_MASK;
> +	else if (strcmp(wait_time, "50") == 0)
> +		op_mode_setting_val |= PWTIME_50_MS & PS_WTIME_MASK;
> +	else if (strcmp(wait_time, "100") == 0)
> +		op_mode_setting_val |= PWTIME_100_MS & PS_WTIME_MASK;
> +	else if (strcmp(wait_time, "200") == 0)
> +		op_mode_setting_val |= PWTIME_200_MS & PS_WTIME_MASK;
> +	else if (strcmp(wait_time, "400") == 0)
> +		op_mode_setting_val |= PWTIME_400_MS & PS_WTIME_MASK;
> +	else if (strcmp(wait_time, "800") == 0)
> +		op_mode_setting_val |= PWTIME_800_MS & PS_WTIME_MASK;
> +	else if (strcmp(wait_time, "1600") == 0)
> +		op_mode_setting_val |= PWTIME_1600_MS & PS_WTIME_MASK;
> +	else {
> +		dev_info(&client->dev, "Using default ps wtime value\n");
> +		op_mode_setting_val |= PWTIME_12_POINT_5_MS & PS_WTIME_MASK;
> +	}
> +
> +	ret = pm16d17_write_reg(data, PM16D17_PS_SETTING, op_mode_setting_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	of_property_read_u32(np, "ps-ir-led-pulse-count", &pulse_count);
> +	if (pulse_count > 256)
> +		pulse_count = 256;
	pulse_count = min(256, pulse_count);

> +	ret = pm16d17_write_reg(data, PM16D17_VCSEL_DRIVE_PULSE, pulse_count - 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	of_property_read_u32(np, "ps-offset-cancel", &ps_offset_cancel);
> +	if (ps_offset_cancel != 0) {
> +		ret = pm16d17_write_reg(data, PM16D17_PS_SETTING2, OFFSET_CANCEL_ENABLE);
> +		if (ret < 0)
> +			return ret;
> +
> +		offset_lsb = ps_offset_cancel & PS_OFFSET_CANCEL_LSB_MASK;
> +		offset_msb = (ps_offset_cancel & PS_OFFSET_CANCEL_MSB_MASK) >> 8;
> +
> +		ret = pm16d17_write_reg(data, PM16D17_PS_OFFSET_CANCEL_L, offset_lsb);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = pm16d17_write_reg(data, PM16D17_PS_OFFSET_CANCEL_H, offset_msb);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pm16d17_probe(struct i2c_client *client)
> +{
> +	struct pm16d17_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->dev.parent = &client->dev;

No need to set that - devm_iio_device_alloc() does it for you.

> +	indio_dev->info = &pm16d17_info;
> +	indio_dev->name = PM16D17_DRV_NAME;

There is no particularly reason why the name here and the driver name should
match.  As such, I'd much rather just see the explicit string listed here
directly and that define being dropped.

> +	indio_dev->channels = pm16d17_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(pm16d17_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;

You only ever use this to get to client->dev.  Just have a struct device
in there instead.  Or you can retrieve it via regmap_get_device()
if you prefer not to store it explicitly.
> +
> +	data->regmap = devm_regmap_init_i2c(client, &pm16d17_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "regmap initialization failed.\n");
> +		return PTR_ERR(data->regmap);
For error prints in probe or functions just called from probe use
		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
				     ....);


> +	}
> +
> +	ret = pm16d17_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id pm16d17_id[] = {
> +	{"pm16d17", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pm16d17_id);
> +
> +static const struct of_device_id pm16d17_of_match[] = {
> +	{ .compatible = "everlight,pm16d17" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pm16d17_of_match);
> +
> +static struct i2c_driver pm16d17_driver = {
> +	.driver = {
> +		.name = PM16D17_DRV_NAME,
Put the string in directly here

> +		.of_match_table = pm16d17_of_match,
> +	},
> +	.probe = pm16d17_probe,
> +	.id_table = pm16d17_id,
> +};
> +module_i2c_driver(pm16d17_driver);
> +
> +MODULE_AUTHOR("Chao Zeng <chao.zeng@siemens.com>");
> +MODULE_DESCRIPTION("PM16D17 proximity sensor");
> +MODULE_LICENSE("GPL");


