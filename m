Return-Path: <linux-iio+bounces-7979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C693DFD5
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BA1C21028
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DFB1741CF;
	Sat, 27 Jul 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1xOF6V6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9961E521;
	Sat, 27 Jul 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092545; cv=none; b=l1wui+2eFaNMjixoFRwlcfQdQtWg9bFKpe/WhJlt9PFnF/MKegQUYlzlwRzKLhjCUsxZ719igjAEdPYzdAaR/XpnhN5k+iZXShssGUawMbATrg+YWiowu6QN0eta0Bd50Asl5J9vl6wBCWHqrCUffHhTovdHkO9UwLAJycxPb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092545; c=relaxed/simple;
	bh=4oeWFMSlt1bxcxbycPc3bsPlNG3T0mmuIUPObg5nlRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ke7bzp0VCBeAWHjppy6p4mhglchBvM7Qf7tCwcuYE6KiXfWvBANVgqE70GJufaUbNdHia2kWx8gSSYN/vOD2s01N0ZJGDLIK7eY1AWGfoijjTqrh4ur+iwwZQSaeK4TnfbdmkvKNtMXk9ndyoSOfl+lDz6MIzzUu1dHjVOBX/uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1xOF6V6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602B3C32781;
	Sat, 27 Jul 2024 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722092544;
	bh=4oeWFMSlt1bxcxbycPc3bsPlNG3T0mmuIUPObg5nlRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A1xOF6V6I0q2gGJcqFgzyYBV9xycFWX+QQvdCIbr3sXnPCSnRRh0CUpBZDT7aXA5o
	 51LEw+WvoNWylcCbyzhiHKCPOHE7uqNOlAJi9JOG+uVxyvbpfuk99Vu0e84284Oblx
	 lem8tPyWE2L4+gtYhKu0w8+7ZwpVPAM+X13G2ie/oKgYTImxWyrvqglydZ4yQDNl4e
	 dK5KJKS9jIMG3CMOkeMUbYiLYK51WqghAEbmn3GwpkibBvYvXW5NRs4K3/nYByL8SL
	 1ekwaK9tIt5igniyo0670+v1dz1kbcPKwBKUwYA7itY4aXIPa8zgaiGyIebK91Flxv
	 XtaX/qjNSAnGw==
Date: Sat, 27 Jul 2024 16:02:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V5 2/2] iio: proximity: aw9610x: Add support for aw9610x
 proximity sensor
Message-ID: <20240727160216.2488ed29@jic23-huawei>
In-Reply-To: <20240726061312.1371450-3-wangshuaijie@awinic.com>
References: <20240726061312.1371450-1-wangshuaijie@awinic.com>
	<20240726061312.1371450-3-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 06:13:12 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> AW9610X is a low power consumption capacitive touch and proximity controller.
> Each channel can be independently config as sensor input, shield output.

Needs more information, particularly what the USB powersupply notification is about.
It's unlikely that belongs directly in an IIO driver, unless that supply is
part of this same chip.

> 
> Channel Information:
>   aw96103: 3-channel
>   aw96105: 5-channel
I don't see where this is implemented. Seems to assume 5 channels for both.

> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  drivers/iio/proximity/Kconfig   |  11 +
>  drivers/iio/proximity/Makefile  |   1 +
>  drivers/iio/proximity/aw9610x.c | 791 ++++++++++++++++++++++++++++++++
>  drivers/iio/proximity/aw9610x.h | 140 ++++++
>  4 files changed, 943 insertions(+)
>  create mode 100644 drivers/iio/proximity/aw9610x.c
>  create mode 100644 drivers/iio/proximity/aw9610x.h
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 2ca3b0bc5eba..ca1b8bde2def 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -219,4 +219,15 @@ config VL53L0X_I2C
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vl53l0x-i2c.
>  
> +config AW9610X

As with dt-binding no wild cards in driver naming for the same reasons.

> +	tristate "Awinic AW9610X proximity sensor"
Also not in the title here though the same 'and similar' postfix can
work to indicate it's a set of devices.
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for Awinic's AW9610X capacitive
> +	  proximity sensor.

List the full set of parts supported explicitly here because people
like tog rep for them.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called aw9610x.

No wild card here either.

> +
>  endmenu
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index f36598380446..483f5bf1ac8b 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -21,4 +21,5 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> +obj-$(CONFIG_AW9610X)		+= aw9610x.o
>  
> diff --git a/drivers/iio/proximity/aw9610x.c b/drivers/iio/proximity/aw9610x.c
> new file mode 100644
> index 000000000000..de5be3918e4f
> --- /dev/null
> +++ b/drivers/iio/proximity/aw9610x.c
> @@ -0,0 +1,791 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AWINIC aw9610x proximity sensor driver
> + *
> + * Author: Wang Shuaijie <wangshuaijie@awinic.com>
> + *
> + * Copyright (c) 2024 awinic Technology CO., LTD
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
As already pointed out, some of these at least don't make sense. Check them all.

> +#include <linux/interrupt.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/of_gpio.h>

not used.

> +#include <linux/power_supply.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include "aw9610x.h"
No wild cards in header either.


> +
> +static const struct regmap_config aw9610x_regmap_confg = {
> +	.reg_bits = 16,
> +	.val_bits = 32,
> +};
> +
> +static int aw9610x_i2c_write(struct aw9610x *aw9610x,
> +		u16 reg_addr16, u32 reg_data32)
> +{
> +	return regmap_write(aw9610x->regmap, (unsigned int)reg_addr16,
> +			(unsigned int)reg_data32);
AS below. No to this one as well. Just use regmap_write() inline.

> +}
> +
> +static int aw9610x_i2c_read(struct aw9610x *aw9610x,
> +		u16 reg_addr16, u32 *reg_data32)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(aw9610x->regmap, (unsigned int)reg_addr16, &data);
> +	if (ret == 0)
> +		*reg_data32 = data;
> +
As below, just do this inline not via a trivial wrapper function.
> +	return ret;
> +}
> +
> +static int aw9610x_i2c_write_bits(struct aw9610x *aw9610x,
> +		u16 reg_addr16, u32 mask, u32 reg_data32)
> +{
> +	return regmap_update_bits(aw9610x->regmap, (unsigned int)reg_addr16,
> +			(unsigned int)(~mask), (unsigned int)reg_data32);

Get rid of these wrappers and use regmap directly inline.
The wrappers are obscuring what is happening not making it easier to follow

> +}
> +
> +static const struct iio_event_spec aw_common_events[2] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),

Unusual to have only a period control.
Device provides no means to turn them off, or adjust the thresholds?

> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +};
> +
> +static int aw9610x_get_diff_raw(struct aw9610x *aw9610x,
> +		unsigned int chan, int *buf)
> +{
> +	u32 data;
> +	int ret;
> +
> +	ret = aw9610x_i2c_read(aw9610x, REG_DIFF_CH0 + chan * 4, &data);
> +	if (ret)
> +		return ret;
> +	*buf = (int)data / AW_DATA_PROCESS_FACTOR;

cast after paths as otherwise might not fit.

> +
> +	return ret;
return 0;  as can't be anything else and nice to make that obvious.

> +}
> +
> +static int aw9610x_read_raw(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan,
> +		int *val, int *val2, long mask)
> +{
> +	struct aw9610x *aw9610x;
> +
> +	aw9610x = iio_priv(indio_dev);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		aw9610x_get_diff_raw(aw9610x, chan->channel, val);
> +		break;
		return IIO_VAL_INT; here

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
and drop this.
> +}
> +
> +struct iio_info iio_info = {
> +	.read_raw = aw9610x_read_raw,
> +};
> +
> +static int aw9610x_iio_init(struct aw9610x *aw9610x)

Pass in the iio_dev and then use iio_priv() to get the struct aw96101

> +{
> +	struct iio_chan_spec *aw9610x_channels;
> +	unsigned int chan_num = 0, j = 0;
> +	unsigned int i;
> +
> +	aw9610x->channels_arr = devm_kcalloc(aw9610x->dev, AW_CHANNEL_MAX,
> +			sizeof(struct aw_channels_info), GFP_KERNEL);
> +	if (!aw9610x->channels_arr)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < AW_CHANNEL_MAX; i++) {
> +		aw9610x->channels_arr[i].last_channel_info = 0;

you calloc it just above. It should be already 0.

> +		if ((AW9610X_CHANNEL_USED_MASK >> i) & 0x01) {
This is hard coded in the driver which makes no sense.
If you need this, expand the dt bindings to include channel sub nodes
so firmware describes what is enabled.

If all enabled is fine, then drop this code as they are all always used.


> +			aw9610x->channels_arr[i].used = true;
> +			chan_num++;
> +		} else {
> +			aw9610x->channels_arr[i].used = false;
> +		}
> +	}
> +
> +	aw9610x_channels = devm_kcalloc(aw9610x->dev, chan_num,
> +			sizeof(*aw9610x_channels), GFP_KERNEL);
> +	if (!aw9610x_channels)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < AW_CHANNEL_MAX; i++) {
> +		if (aw9610x->channels_arr[i].used) {
> +			aw9610x_channels[j].type = IIO_PROXIMITY;
> +			aw9610x_channels[j].info_mask_separate =
> +				BIT(IIO_CHAN_INFO_RAW);
> +			aw9610x_channels[j].indexed = 1;
> +			aw9610x_channels[j].channel = i;
> +			aw9610x_channels[j].event_spec = aw_common_events;
> +			aw9610x_channels[j].num_event_specs =
> +				ARRAY_SIZE(aw_common_events);
> +			j++;
> +		}
> +	}
> +
> +	aw9610x->aw_iio_dev->modes = INDIO_DIRECT_MODE;
> +	aw9610x->aw_iio_dev->num_channels = chan_num;
> +	aw9610x->aw_iio_dev->channels = aw9610x_channels;
> +	aw9610x->aw_iio_dev->info = &iio_info;
> +	aw9610x->aw_iio_dev->name = "aw9610x_sensor";
> +	aw9610x->aw_iio_dev->dev.parent = aw9610x->dev;
> +
> +	return devm_iio_device_register(aw9610x->dev, aw9610x->aw_iio_dev);
> +}

> +
> +static int aw9610x_reg_version_comp(struct aw9610x *aw9610x,
> +		struct aw_bin *aw_bin)
> +{
> +	u32 blfilt1_data, blfilt1_tmp;
> +	unsigned char i;
> +	int ret = 0;
> +
> +	if ((aw9610x->vers == AW9610XA) && (aw_bin->chip_type[7] == '\0')) {

Needs documentation / comments.

> +		for (i = 0; i < 6; i++) {
> +			ret = aw9610x_i2c_read(aw9610x,
> +					REG_BLFILT_CH0 +
> +					(AW9610X_BLFILT_CH_STEP * i),
> +					&blfilt1_data);
> +			if (ret)
> +				return ret;
> +			blfilt1_tmp = FIELD_GET(AW9610X_BLERRTRIG_MASK,
> +					blfilt1_data);
> +			if (blfilt1_tmp == 1) {
> +				ret = aw9610x_i2c_write_bits(aw9610x,
> +					REG_BLRSTRNG_CH0 +
> +					(AW9610X_BLFILT_CH_STEP * i),
> +					~(AW9610X_BLRSTRNG_MASK), 1 << i);
> +				if (ret)
> +					return ret;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void aw9610x_aot_set(struct aw9610x *aw9610x)
> +{
> +	aw9610x_i2c_write_bits(aw9610x, REG_SCANCTRL0,
> +			~(AW9610X_AOT_MASK << AW9610X_AOT_BIT),
> +			(AW9610X_AOT_MASK) << AW9610X_AOT_BIT);

FIELD_PREP()

> +}
> +
> +static int aw9610x_bin_valid_loaded(struct aw9610x *aw9610x,
> +		struct aw_bin *aw_bin_data_s)
> +{
> +	unsigned int start_addr = aw_bin_data_s->valid_data_addr;
> +	u32 i, reg_data;
> +	u16 reg_addr;
> +	int ret;
> +
> +	for (i = 0; i < aw_bin_data_s->valid_data_len;
> +			i += 6, start_addr += 6) {

Fix alignment (see comments later)

> +		reg_addr = *(u16 *)(aw_bin_data_s->data + start_addr);
> +		reg_data = *(u32 *)(aw_bin_data_s->data + start_addr + 2);

> +		if ((reg_addr == REG_EEDA0) || (reg_addr == REG_EEDA1))
> +			continue;
> +		if (reg_addr == REG_IRQEN) {
> +			aw9610x->hostirqen = reg_data;
> +			continue;
> +		}
> +		ret = aw9610x_i2c_write(aw9610x, reg_addr, reg_data);
> +		if (ret < 0)
> +			return ret;
> +
> +	}
> +	ret = aw9610x_reg_version_comp(aw9610x, aw_bin_data_s);
> +	if (ret)
> +		return ret;
> +	ret = aw9610x_channel_scan_start(aw9610x);
> +
> +	return ret;
return aw961..

Fix all other cases of this.

> +}
> +
> +static int aw9610x_para_loaded(struct aw9610x *aw9610x)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(aw9610x_reg_default); i += 2) {
> +		ret = aw9610x_i2c_write(aw9610x,
> +				(u16)aw9610x_reg_default[i],
> +				(u32)aw9610x_reg_default[i+1]);
spacing around + in all similar places.

> +		if (ret)
> +			return ret;
> +		if (aw9610x_reg_default[i] == REG_IRQEN)
> +			aw9610x->hostirqen = aw9610x_reg_default[i+1];
> +	}
> +	ret = aw9610x_channel_scan_start(aw9610x);
> +
> +	return ret;
> +}
> +
> +static int aw9610x_cfg_all_loaded(const struct firmware *cont,
> +		struct aw9610x *aw9610x)
> +{
> +	struct aw_bin *aw_bin;
> +	int ret;
> +
> +	if (!cont)
> +		return -EINVAL;
> +
> +	aw_bin = kzalloc(cont->size + sizeof(*aw_bin), GFP_KERNEL);
Use __free(kfree) 

lots of examples in tree, but will avoid need to manually free and
simplify this code a little.

> +	if (!aw_bin)
> +		return -ENOMEM;
> +
> +	aw_bin->len = cont->size;
> +	memcpy(aw_bin->data, cont->data, cont->size);
> +	aw9610x_parsing_bin_file(aw_bin);
> +
> +	snprintf(aw9610x->chip_type, sizeof(aw9610x->chip_type), "%s",
> +			aw_bin->chip_type);
> +	ret = aw9610x_bin_valid_loaded(aw9610x, aw_bin);
> +	kfree(aw_bin);
> +
> +	return ret;
> +}
> +
> +static int aw9610x_cfg_update(struct aw9610x *aw9610x)
> +{
> +	const struct firmware *fw;
> +	int ret;
> +
> +	ret = request_firmware(&fw, "aw9610x_0.bin", aw9610x->dev);

No wild cards in this either.

> +	if (ret)
> +		return ret;
> +	ret = aw9610x_cfg_all_loaded(fw, aw9610x);
> +	if (ret)
> +		ret = aw9610x_para_loaded(aw9610x);
> +	release_firmware(fw);
> +
> +	return ret;
> +}
> +
> +static void aw9610x_cfg_work_routine(struct work_struct *work)
> +{
> +	struct aw9610x *aw9610x = container_of(work, struct aw9610x,
> +			cfg_work.work);
> +
> +	aw9610x_cfg_update(aw9610x);

So this is polling in driver.   We'd normally hook up to a hrtimer
trigger for that.  Perhaps you need this for your events sampling though?
If so that may be fine to do somewhat like this. I'm just not sure
of the usecase currently.

> +}
> +
> +static int aw9610x_sar_cfg_init(struct aw9610x *aw9610x)
> +{
> +	INIT_DELAYED_WORK(&aw9610x->cfg_work, aw9610x_cfg_work_routine);
> +	schedule_delayed_work(&aw9610x->cfg_work, msecs_to_jiffies(5000));
> +
> +	return 0;
> +}
> +
> +static int aw9610x_sw_reset(struct aw9610x *aw9610x)
> +{
> +	int ret;
> +
> +	ret = aw9610x_i2c_write(aw9610x, REG_RESET, 0);
> +	msleep(20);
> +
> +	return ret;
> +}
> +
> +static ssize_t update_store(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct aw9610x *aw9610x = dev_get_drvdata(dev);
> +	unsigned int state;
> +	ssize_t ret;
> +
> +	ret = kstrtouint(buf, 10, &state);
> +	if (ret)
> +		return ret;
> +	if (state) {
> +		aw9610x_i2c_write(aw9610x, REG_IRQEN, 0);
> +		aw9610x_sw_reset(aw9610x);
> +		schedule_delayed_work(&aw9610x->cfg_work,
> +					msecs_to_jiffies(10));
> +	}
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_WO(update);
> +
> +static struct attribute *aw9610x_sar_attributes[] = {
> +	&dev_attr_update.attr,

This needs documenting as it's custom ABI.
Note that we don't often accept custom ABI.
Particularly not a hook that seems to reset the device.
If you want to do that, unbind and rebind the whole drive so
we are in a known state etc.


> +	NULL
> +};
> +
> +static struct attribute_group aw9610x_sar_attribute_group = {
> +	.attrs = aw9610x_sar_attributes
> +};
> +
> +static void aw9610x_irq_handle(struct aw9610x *aw9610x)
> +{
> +	u32 curr_status_val;
> +	u32 curr_status;
> +	unsigned char i;
> +	int ret;
> +
> +	ret = aw9610x_i2c_read(aw9610x, REG_STAT0, &curr_status_val);
> +	if (ret)
> +		return;
> +
> +	for (i = 0; i < AW_CHANNEL_MAX; i++) {
> +		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
> +			(((curr_status_val >> (16 + i)) & 0x1) << 1) |
> +			(((curr_status_val >> (8 + i)) & 0x1) << 2) |
> +			(((curr_status_val >> (i)) & 0x1) << 3);

Add a comment on what is going on here as it's tricky to read.
Also, no brackets around the i in last line.
Probably better expressed as a series of FIELD_GET() calls with appropriat
masks of the 32 bit value.


> +
> +		if (!aw9610x->channels_arr[i].used ||
> +				(aw9610x->channels_arr[i].last_channel_info ==
> +				curr_status))
Align as
		if (!aw
		    (aw9610...

> +			continue;
> +
> +		switch (curr_status) {
> +		case FAR:
> +			iio_push_event(aw9610x->aw_iio_dev,
> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> +						IIO_EV_TYPE_THRESH,
> +						IIO_EV_DIR_RISING),
> +					iio_get_time_ns(aw9610x->aw_iio_dev));
> +			break;
> +		case TRIGGER_TH0:
> +		case TRIGGER_TH1:
> +		case TRIGGER_TH2:
> +		case TRIGGER_TH3:
4 thresholds on the same channel? This is confusing given we are reporting them
as events on different channels. but this loop is over the channels.


> +			iio_push_event(aw9610x->aw_iio_dev,
> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> +						IIO_EV_TYPE_THRESH,
> +						IIO_EV_DIR_FALLING),
> +					iio_get_time_ns(aw9610x->aw_iio_dev));
> +			break;
> +		default:
> +			return;
> +		}
> +		aw9610x->channels_arr[i].last_channel_info = curr_status;
> +	}
> +}
> +
> +static void aw9610x_interrupt_clear(struct aw9610x *aw9610x)
> +{
> +	int ret;
> +
> +	ret = aw9610x_i2c_read(aw9610x, REG_IRQSRC, &aw9610x->irq_status);
> +	if (ret)
> +		return;
> +
> +	aw9610x_irq_handle(aw9610x);
> +}
> +
> +static irqreturn_t aw9610x_irq(int irq, void *data)
> +{
> +	struct aw9610x *aw9610x = data;

Pass in the iio_dev not the priv() data as you need
some access to things in that structure and you can go the other
way with iio_priv()

> +
> +	aw9610x_interrupt_clear(aw9610x);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int aw9610x_interrupt_init(struct aw9610x *aw9610x)
> +{
> +	unsigned int irq_status;
> +	int ret;
> +
> +	ret = aw9610x_i2c_write(aw9610x, REG_IRQEN, 0);

Never combine return values. Check each one and return if an error.

If these return different values the resulting error code provided
to the caller will be garbage.

> +	ret |= aw9610x_i2c_read(aw9610x, REG_IRQSRC, &irq_status);
> +	if (ret)
> +		return ret;
> +	ret = devm_request_threaded_irq(aw9610x->dev, aw9610x->i2c->irq,
> +			NULL, aw9610x_irq, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

IRQF_TRIGGER_FALLING should be provided by FW not set by the driver.
Doing it here removes the possibility of a firmware coping with inverters
in the signal path (often done as a cheap form of level conversion).
So just specify IRQF_ONESHOT

> +			"aw9610x_irq", aw9610x);
no wild cards here either.

> +	if (ret)
> +		return ret;

Blank line

> +	ret = aw9610x_i2c_write(aw9610x, REG_IRQEN, aw9610x->hostirqen);
return aw9601x...

> +
> +	return ret;
> +}


> +static int aw9610x_power_init(struct aw9610x *aw9610x)
> +{
> +	int rc;
> +
> +	aw9610x->vcc = devm_regulator_get(aw9610x->dev, "vcc");
devm_regulator_get_enabled()

You only turn it off in error paths or on remove. Both are
handled fine via devm / device managed cleanup.
So no need to do it manually or keep a copy of the vcc
pointer around.

This function then becomes a single call, so don't have
a separate function.

Also for future reference look at what devm_regulator_get()
does if a regulator is not supplied by fw. It doesn't
return NULL.


> +	if (!aw9610x->vcc)
> +		return 0;
> +
> +	rc = aw9610x_power_enable(aw9610x, true);
> +
> +	return rc;
> +}
> +
> +static int aw9610x_wait_chip_init(struct aw9610x *aw9610x)
> +{
> +	unsigned int cnt = 20;
> +	u32 reg_data;
> +	int ret;
> +
> +	while (cnt--) {
> +		ret = aw9610x_i2c_read(aw9610x, REG_IRQSRC, &reg_data);
> +		if (ret)
> +			return ret;
> +
> +		if ((reg_data & 0x01) == 0x01)
That bit should have a meaningful named define.
		if ((FIELD_GET(xxxx))
			return 0;

> +			return 0;
> +		mdelay(1);
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int aw9610x_ps_notify_init(struct aw9610x *aw9610x)
> +{
> +	struct power_supply *psy;
> +	int ret;
> +
> +	INIT_WORK(&aw9610x->ps_notify_work, aw9610x_ps_notify_callback_work);
> +	aw9610x->ps_notif.notifier_call = aw9610x_ps_notify_callback;
> +	ret = power_supply_reg_notifier(&aw9610x->ps_notif);
> +	if (ret)
> +		return ret;
Add devm_add_action_or_reset() to handle unregistering the notifier.
That will remove the need to manually clean it up in remove
or in error paths here.

> +
> +	psy = power_supply_get_by_name(USB_POWER_SUPPLY_NAME);

This is unusual to see in an IIO driver.
So please provide more information on this. Is this supply coupled to this
sensor?  If not you may need a consumer driver for the IIO device driver
that handles this notification part and allows the description of what
power supply the notification is relevant to.
This stuff all belongs in DT, not via a magic name based looking up deep
in a driver.


> +	if (!psy)
> +		goto free_ps_notifier;
> +
> +	ret = aw9610x_ps_get_state(aw9610x, psy, &aw9610x->ps_is_present);
> +	if (ret)
> +		goto free_ps_notifier;
> +
> +	return ret;
> +
> +free_ps_notifier:
> +	power_supply_unreg_notifier(&aw9610x->ps_notif);
> +
> +	return -EINVAL;
> +}
> +
> +static int aw9610x_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct iio_dev *aw_iio_dev;
> +	struct aw9610x *aw9610x;
> +	int ret;
> +
> +	aw_iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*aw9610x));
> +	if (!aw_iio_dev)
> +		return -ENOMEM;
> +
> +	aw9610x = iio_priv(aw_iio_dev);
> +	aw9610x->aw_iio_dev = aw_iio_dev;

As elsewhere. Get rid of this reverse pointer. It is easy to avoid
needing it and that leads to much more predictable code for reviewers.

> +	aw9610x->dev = &i2c->dev;
> +	aw9610x->i2c = i2c;
> +	i2c_set_clientdata(i2c, aw9610x);
> +
> +	aw9610x->regmap = devm_regmap_init_i2c(i2c, &aw9610x_regmap_confg);
> +	if (IS_ERR(aw9610x->regmap))
> +		return PTR_ERR(aw9610x->regmap);

Blank line here

> +	ret = aw9610x_power_init(aw9610x);

As above, just pull the regulator get and enable here and don't bother
with the wrapper for what will be one line of code.


> +	if (ret)
> +		return ret;
> +
> +	ret = aw9610x_read_chipid(aw9610x);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw9610x_sw_reset(aw9610x);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw9610x_wait_chip_init(aw9610x);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw9610x_version_init(aw9610x);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw9610x_ps_notify_init(aw9610x);
> +	if (ret < 0)
> +		goto err_ps_notify;

register a cleanup for this here with

devm_add_action_or_reset() so that you can avoid manual cleanup.

> +
> +	ret = aw9610x_iio_init(aw9610x);
Once this call is done, the userspace interface is available to callers.

Normally that's done last, because I assume the code below is doing something
useful and as such is necessary before we starting using the device?

> +	if (ret)
> +		goto err_iio_init;
> +
> +	ret = aw9610x_sar_cfg_init(aw9610x);
> +	if (ret)
> +		goto err_iio_init;
> +
> +	ret = sysfs_create_group(&i2c->dev.kobj, &aw9610x_sar_attribute_group);

Why are you attaching attributes to the parent device?

> +	if (ret)
> +		goto err_iio_init;
> +
> +	ret = aw9610x_interrupt_init(aw9610x);
> +	if (ret)
> +		goto err_interrupt_init;
> +
> +	return ret;
> +
> +err_interrupt_init:
> +	sysfs_remove_group(&i2c->dev.kobj, &aw9610x_sar_attribute_group);
> +err_iio_init:
> +	power_supply_unreg_notifier(&aw9610x->ps_notif);
> +err_ps_notify:
> +	if (aw9610x->vcc)
> +		aw9610x_power_enable(aw9610x, false);
> +
> +	return ret;
> +}
> +
> +static void aw9610x_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct aw9610x *aw9610x = i2c_get_clientdata(i2c);
> +
> +	if (aw9610x->vcc)
> +		aw9610x_power_enable(aw9610x, false);
No need for this dance.  The regulator framework will provide
a stub regulator not return NULL. So you will always have one
to pass to these calls.

However, as elsewhere - you don't really need power supply control
anyway.

> +	power_supply_unreg_notifier(&aw9610x->ps_notif);

Use a devm_add_action_or_reset() to call this automatically.
Lots of examples in tree for how to use those.

> +	sysfs_remove_group(&i2c->dev.kobj, &aw9610x_sar_attribute_group);

This is a sign of a design problem.  There shouldn't be any dynamic
attributes in a driver like this one.  Anyhow, I'll address that
above (I'm reviewing backwards as easier to understand a driver
from coarse to fine).

> +}
> +
> +static void aw9610x_i2c_shutdown(struct i2c_client *i2c)
> +{
> +	struct aw9610x *aw9610x = i2c_get_clientdata(i2c);
> +	u32 irq_status_temp;
> +
> +	aw9610x_i2c_write(aw9610x, REG_IRQEN, 0);
> +	aw9610x_i2c_read(aw9610x, REG_IRQSRC, &irq_status_temp);
> +	aw9610x_i2c_write(aw9610x, REG_CMD, AW9610X_SLEEP_MODE);

Worth doing given the power is going to be turned off anyway?
Pretty rare to provide a shutdown callback form an i2c device.

> +}
> +
> +static const struct of_device_id aw9610x_dt_match[] = {
> +	{ .compatible = "awinic,aw96103" },
> +	{ .compatible = "awinic,aw96105" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, aw9610x_dt_match);
> +
> +static const struct i2c_device_id aw9610x_i2c_id[] = {
> +	{ "aw96103", 0 },
> +	{ "aw96105", 0 },
> +	{ },

No comma on null terminator like entries as we don't want to make it
easy to add things after them.

> +};
> +MODULE_DEVICE_TABLE(i2c, aw9610x_i2c_id);
> +
> +static struct i2c_driver aw9610x_i2c_driver = {
> +	.driver = {
> +		.name = "aw9610x_sensor",
> +		.of_match_table = aw9610x_dt_match,
> +	},
> +	.probe = aw9610x_i2c_probe,
> +	.remove = aw9610x_i2c_remove,
> +	.shutdown = aw9610x_i2c_shutdown,
> +	.id_table = aw9610x_i2c_id,
> +};
> +module_i2c_driver(aw9610x_i2c_driver);
> +
> +MODULE_AUTHOR("Wang Shuaijie <wangshuaijie@awinic.com>");
> +MODULE_DESCRIPTION("Driver for Awinic AW9610X proximity sensor");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/proximity/aw9610x.h b/drivers/iio/proximity/aw9610x.h
> new file mode 100644
> index 000000000000..38b3f36ebb7a
> --- /dev/null
> +++ b/drivers/iio/proximity/aw9610x.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _AW9610X_H_
> +#define _AW9610X_H_
> +
> +#define AW9610X_CHANNEL_USED_MASK		0x1F
> +#define AW_VCC_MIN_UV				1700000
> +#define AW_VCC_MAX_UV				3600000
> +#define AW_DATA_PROCESS_FACTOR			1024
> +#define AW9610X_CPU_WORK_MASK			1
> +#define AW9610X_CHIP_MIN_VOLTAGE		1600000
> +#define AW_CHIP_AW9610XA			0x03000b00
> +#define AW_READ_CHIPID_RETRIES			3
> +#define AW_I2C_RETRIES				5
> +#define USB_POWER_SUPPLY_NAME			"charger"
> +#define AW9610X_AOT_MASK			0x3f
> +#define AW9610X_AOT_BIT				8
> +#define AW9610X_CHIP_ID				0xa961
> +#define AW_CHIP_AW9610XA			0x03000b00
> +#define AW9610X_CPU_WORK_MASK			1
> +#define AW9610X_AOT_MASK			0x3f
> +#define AW9610X_AOT_BIT				8
> +#define REG_EEDA0				0x0408
> +#define REG_EEDA1				0x040C
> +#define AW9610X_BIN_VALID_DATA_OFFSET		64
> +#define AW9610X_BIN_DATA_LEN_OFFSET		16
> +#define AW9610X_BIN_DATA_REG_NUM_SIZE		4
> +#define AW9610X_BIN_CHIP_TYPE_SIZE		8
> +#define AW9610X_BIN_CHIP_TYPE_OFFSET		24
> +#define AW9610X_BLFILT_CH_STEP			0x3C
> +#define AW9610X_BLRSTRNG_MASK			0x3F
> +#define AW9610X_CHIPID_MASK			GENMASK(31, 16)
> +#define AW9610X_BLERRTRIG_MASK			BIT(25)
> +
> +#define AFE_BASE_ADDR				0x0000
If the bases are all zero, get rid of them.

> +#define DSP_BASE_ADDR				0x0000
> +#define STAT_BASE_ADDR				0x0000
> +#define SFR_BASE_ADDR				0x0000
> +#define DATA_BASE_ADDR				0x0000
> +#define REG_SCANCTRL0				(0x0000 + AFE_BASE_ADDR)
> +#define REG_AFECFG1_CH0				(0x0014 + AFE_BASE_ADDR)
> +#define REG_FWVER				(0x0088 + STAT_BASE_ADDR)
> +#define REG_WST					(0x008C + STAT_BASE_ADDR)
> +#define REG_STAT0				(0x0090 + STAT_BASE_ADDR)
> +#define REG_STAT1				(0x0094 + STAT_BASE_ADDR)
> +#define REG_CHINTEN				(0x009C + STAT_BASE_ADDR)
> +#define REG_BLFILT_CH0				(0x00A8 + DSP_BASE_ADDR)
> +#define REG_BLRSTRNG_CH0			(0x00B4 + DSP_BASE_ADDR)
> +#define REG_BLFILT_CH1				(0x00E4 + DSP_BASE_ADDR)
> +#define REG_COMP_CH0				(0x0210 + DATA_BASE_ADDR)
> +#define REG_BASELINE_CH0			(0x0228 + DATA_BASE_ADDR)
> +#define REG_DIFF_CH0				(0x0240 + DATA_BASE_ADDR)
> +#define REG_FWVER2				(0x0410 + DATA_BASE_ADDR)
> +#define REG_CMD					(0xF008 + SFR_BASE_ADDR)
> +#define REG_IRQSRC				(0xF080 + SFR_BASE_ADDR)
> +#define REG_IRQEN				(0xF084 + SFR_BASE_ADDR)
> +#define REG_OSCEN				(0xFF00 + SFR_BASE_ADDR)
> +#define REG_RESET				(0xFF0C + SFR_BASE_ADDR)
> +#define REG_CHIPID				(0xFF10 + SFR_BASE_ADDR)
More common I think to do (SFR_BASE_ADDR + 0xFF10)
however, given the base is 0, just drop that part.

Prefix these all with AW96103_ 
Otherwise high chance of a naming clash and it's not obvious these are
device specific defines.

> +
> +#define REG_NONE_ACCESS				0
> +#define REG_RD_ACCESS				(1 << 0)
> +#define REG_WR_ACCESS				(1 << 1)
> +struct aw_reg_data {
> +	unsigned char rw;
> +	unsigned short reg;
> +};

Not used that I can see.

> +
> +/**
> + * struct aw_bin - 
Needs a short description.  Run the kernel-doc script over these
files and fix any warnings etc.

> + * @chip_type: Frame header information-chip type
> + * @valid_data_len: Length of valid data obtained after parsing
> + * @valid_data_addr: The offset address of the valid data obtained
> + *		after parsing relative to info
> + * @len: The size of the bin file obtained from the firmware
> + * @data: Store the bin file obtained from the firmware
> + */
> +struct aw_bin {
> +	unsigned char chip_type[8];
> +	unsigned int valid_data_len;
> +	unsigned int valid_data_addr;
> +	unsigned int len;
> +	unsigned char data[];

use a __counted_by marking on this so the compiler can tell if you
write code that will go off the end.


> +};
> +
> +enum aw9610x_sar_vers {
> +	AW9610X = 2,
> +	AW9610XA = 6,
> +	AW9610XB = 0xa,
> +};
> +
> +enum aw9610x_operation_mode {
> +	AW9610X_ACTIVE_MODE = 1,
> +	AW9610X_SLEEP_MODE,
> +	AW9610X_DEEPSLEEP_MODE,
> +	AW9610XB_DEEPSLEEP_MODE,
> +};
> +
> +enum aw9610x_channel {
> +	AW_CHANNEL0,
> +	AW_CHANNEL1,
> +	AW_CHANNEL2,
> +	AW_CHANNEL3,
> +	AW_CHANNEL4,
> +	AW_CHANNEL5,
> +	AW_CHANNEL_MAX,
Drop comma on _MAX as we don't want anything after this.

> +};
> +
> +enum aw9610x_irq_trigger_position {
> +	FAR,
> +	TRIGGER_TH0,
> +	TRIGGER_TH1 = 0x03,
> +	TRIGGER_TH2 = 0x07,
> +	TRIGGER_TH3 = 0x0f,
> +};
> +
> +struct aw_channels_info {
> +	bool used;
> +	unsigned int last_channel_info;
> +};
> +
> +struct aw9610x {

Even structs need to not use wildcards for naming.
aw96101 

> +	struct iio_dev *aw_iio_dev;

That is an alarm bell.  If you are in situation where
you need to go from the iio_priv() data back to to the 
iio_dev that contains it you probably have a layering issue
and should have passed the iio_dev in to the relevant function
in the first place.  That usually means using 
struct iio_dev instance in things like the private data of
callbacks.

> +	unsigned char vers;
> +	unsigned int irq_status;
> +	unsigned int hostirqen;
> +	struct work_struct ps_notify_work;
> +	struct notifier_block ps_notif;
> +	bool ps_is_present;
> +	struct delayed_work cfg_work;
> +	struct i2c_client *i2c;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct aw_bin *aw_bin;
> +	struct regulator *vcc;
> +	struct aw_channels_info *channels_arr;
> +	unsigned char chip_type[9];
> +};
> +
> +#endif
> +


