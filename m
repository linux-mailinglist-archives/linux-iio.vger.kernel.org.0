Return-Path: <linux-iio+bounces-16955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D13A64D4E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110C07A7B8E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F01B238D2B;
	Mon, 17 Mar 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRUhx6Ey"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37719F133;
	Mon, 17 Mar 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212241; cv=none; b=VrOUldcuTbPNFXkL2QuvpB2ZMviZ2FTm2/bY7TiYg8j03cRhwnU1IuidIS0+Ag5vVDbYYAeRKyqAIqYsH7QKBXdHMwdUTUDEah+EZ3LLo4TryqZzc0WoynTMtcEaqwp0PNFQ+rJB/ac/v8PdBw6P3tjZ7v8gmenuRfQokofVxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212241; c=relaxed/simple;
	bh=/fosCdJic9lvXydx+3TUP2eCSWTUZhqe0kqMjsaDEr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1kJW+csSAldZApIbrx9EDf+dU7g8nF7iM7YZOceHcQxIuV9RjCamHInWD8UBf11ZsG3W4PBC0RvGOgLAixRUoT/L+jxXU7Pt1LpuQmOtL0fB3URvlquCCemaJNmWEn5xNo/YwF4gzxyouYY9rFziW2spgD0L2FkFDyg38lemsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRUhx6Ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471E6C4CEF0;
	Mon, 17 Mar 2025 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742212240;
	bh=/fosCdJic9lvXydx+3TUP2eCSWTUZhqe0kqMjsaDEr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRUhx6Ey3Wz6/fQgxQpuYqSDCoVRtywiT2UdpIC//8psJ+sxOpR16AZNzbj1w6kF+
	 4xTmxTIQiLtIBDscI9+Rx30sXhGJu4DOKY/WwMwXGyO8SxGev7/rQHljK1jrLVg/X+
	 X0oEhgbIp0UM7fIHwKkpkzhlYOQ18RZclNV7NAUjhUY8ZiUsfrliGc3Mxz1RWve+wx
	 ZVXUdT1IbHbZ5j4f2Laf6kTkvUya8NSCGRk6XZxnx8QQl5HvHoxzqBVkBqqyKvmKdW
	 1XDinjzHmZjQSHtPghVDW2V06DybeL+SCOEKH6ymEm8pzc4VN87E9GH3vpPoCj6Hkq
	 Ds1cZeSh130QQ==
Date: Mon, 17 Mar 2025 11:50:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 mazziesaccount@gmail.com, subhajit.ghosh@tweaklogic.com,
 muditsharma.info@gmail.com, arthur.becker@sentec.com,
 ivan.orlov0322@gmail.com
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
Message-ID: <20250317115005.72a539a0@jic23-huawei>
In-Reply-To: <20250316113131.62884-3-ak@it-klinger.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
	<20250316113131.62884-3-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 12:31:30 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Hi Andreas,

A nice clean driver.
A few comments and questions inline.

Jonathan

> diff --git a/drivers/iio/light/veml6046x00.c b/drivers/iio/light/veml6046x00.c
> new file mode 100644
> index 000000000000..8e6232e1ab70
> --- /dev/null
> +++ b/drivers/iio/light/veml6046x00.c
> @@ -0,0 +1,890 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VEML6046X00 High Accuracy RGBIR Color Sensor
> + *
> + * Copyright (c) 2025 Andreas Klinger <ak@it-klinger.de>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>

So far you aren't providing a trigger so I'm not
expect to see this header used.  Looking at the datasheet
I see there is a dataready interrupt, but it doesn't look like
the device has an autonomous / sequencer type mode, so will always
need to use another trigger (hrtimer, sysfs or some other hardware
source).

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

> +
> +struct veml6046x00_scan_buf {
> +	__le16 chans[4];
> +
> +	s64 timestamp __aligned(8);
aligned_s64 now available as a type to use here.

> +};

> +static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
> +
> +static struct attribute *veml6046x00_event_attributes[] = {
> +	&iio_dev_attr_in_illuminance_period_available.dev_attr.attr,
I thought we didn't have event support yet?  If not why do we
have event related attributes?
> +	NULL
> +};
> +
> +static const struct attribute_group veml6046x00_event_attr_group = {
> +	.attrs = veml6046x00_event_attributes,
> +};


> +
> +static int veml6046x00_set_it(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int ret, new_it;
> +
> +	if (val)
> +		return -EINVAL;
> +
> +	switch (val2) {
> +	case 3125:
> +		new_it = 0x00;
> +		break;
> +	case 6250:
> +		new_it = 0x01;
> +		break;
> +	case 12500:
> +		new_it = 0x02;
> +		break;
> +	case 25000:
> +		new_it = 0x03;
> +		break;
> +	case 50000:
> +		new_it = 0x04;
> +		break;
> +	case 100000:
> +		new_it = 0x05;
> +		break;
> +	case 200000:
> +		new_it = 0x06;
> +		break;
> +	case 400000:
> +		new_it = 0x07;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_field_write(data->rf.it, new_it);
> +	if (ret)
> +		return ret;

return regmap_field_write()

> +
> +	return 0;
> +}
> +
> +static int veml6046x00_set_scale(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int new_scale;
> +
> +	if (val == 0 && val2 == 250000) {

Maybe a lookup table and a loop?

> +		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_5) |
> +					VEML6046X00_CONF1_PD_D2;
> +	} else if (val == 0 && val2 == 330000) {
> +		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_66) |
> +					VEML6046X00_CONF1_PD_D2;
> +	} else if (val == 0 && val2 == 500000) {
> +		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_5);
> +	} else if (val == 0 && val2 == 660000) {
> +		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_66);
> +	} else if (val == 1 && val2 == 0) {
> +		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_1);
> +	} else if (val == 2 && val2 == 0) {
> +		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_2);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(data->regmap, VEML6046X00_REG_CONF1,
> +				 VEML6046X00_CONF1_GAIN |
> +				 VEML6046X00_CONF1_PD_D2,
> +				 new_scale);
> +}
> +
> +static int veml6046x00_get_scale(struct veml6046x00_data *data,
> +				 int *val, int *val2)

How is this related to integration time?  I'd normally expect
to see that read in here somewhere as well as doubling integration
time tends to double scale.

> +{
> +	int ret, reg;
> +
> +	ret = regmap_read(data->regmap, VEML6046X00_REG_CONF1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	switch (FIELD_GET(VEML6046X00_CONF1_GAIN, reg)) {
> +	case 0:
> +		*val = 1;
> +		*val2 = 0;
> +		break;
> +	case 1:
> +		*val = 2;
> +		*val2 = 0;
> +		break;
> +	case 2:
> +		*val = 0;
> +		*val2 = 660000;
> +		break;
> +	case 3:
> +		*val = 0;
> +		*val2 = 500000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (reg & VEML6046X00_CONF1_PD_D2)
> +		*val2 /= 2;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int veml6046x00_set_mode(struct veml6046x00_data *data, bool state)
> +{
> +	return regmap_field_write(data->rf.mode, state);
as below.

> +}
> +
> +static int veml6046x00_set_trig(struct veml6046x00_data *data, bool state)
> +{
> +	return regmap_field_write(data->rf.trig, state);

I'd argue these two aren't worth bothering with because the
field naming etc makes a direct call to regmap_field_write() obvious enough.

> +}
> +
> +static int veml6046x00_wait_data_available(struct iio_dev *iio, int usecs)

Document return value as non obvious.

> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int ret, reg;
> +	int cnt = 2;
> +	int i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		ret = regmap_read(data->regmap, VEML6046X00_REG_INT_H, &reg);
> +		if (ret) {
> +			dev_err(data->dev,
> +					"Failed to read interrupt register %d\n", ret);
> +			return -EIO;
> +		}
> +
> +		if (reg & VEML6046X00_INT_DRDY)
> +			return 1;
> +
> +		if (i < cnt)
> +			fsleep(usecs);
> +	}
> +
> +	return 0;
> +}
> +
> +static int veml6046x00_single_read(struct iio_dev *iio,
> +					enum iio_modifier modifier, int *val)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int addr, it_usec, ret;
> +	uint8_t reg[2];
> +
> +	switch (modifier) {
> +	case IIO_MOD_LIGHT_RED:
> +		addr = VEML6046X00_REG_R_L;
> +	break;

break indent not matching kernel style. Needs to be one more tab in.

> +	case IIO_MOD_LIGHT_GREEN:
> +		addr = VEML6046X00_REG_G_L;
> +	break;
> +	case IIO_MOD_LIGHT_BLUE:
> +		addr = VEML6046X00_REG_B_L;
> +	break;
> +	case IIO_MOD_LIGHT_IR:
> +		addr = VEML6046X00_REG_IR_L;
> +	break;
> +	default:
> +		return -EINVAL;
> +	}
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6046x00_get_it_usec(data, &it_usec);
> +	if (ret < 0)
> +		return ret;
> +
> +	veml6046x00_set_mode(data, 1);
Check for errors.
> +
> +	veml6046x00_set_trig(data, 1);
> +
> +	/* integration time + 10 % to ensure completion */
> +	fsleep(it_usec + (it_usec / 10));
> +
> +	ret = veml6046x00_wait_data_available(iio, it_usec * 10);
> +	if (ret == 1) {
> +		dev_dbg(data->dev, "data ready\n");
> +	} else {
> +		dev_warn(data->dev, "no data ready ret: %d\n", ret);
> +		goto no_data;
> +	}
> +
> +	ret = iio_device_claim_direct_mode(iio);
I'm killing these off slowly.  To save a follow up patch,
	if (!iio_device_claim_direct(iio))
		return -EBUSY;
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, addr, reg, sizeof(reg));
> +	iio_device_release_direct_mode(iio);
	
	iio_device_release_direct(iio);

If not I'll roll in the change with the many other driver updates
this entails.


> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	*val = reg[1] << 8 | reg[0];

That's an endian conversion.  Use get_unaligned_le16() I think
Or read into an __le16 in the first place and you can use
le16_to_cpu() or similar.


> +
> +	return IIO_VAL_INT;
> +
> +no_data:
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	return -EINVAL;
> +}



> +static int veml6046x00_buffer_preenable(struct iio_dev *iio)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	ret = veml6046x00_set_mode(data, 0);
> +	if (ret)
> +		dev_err(data->dev, "Failed to set mode %d\n", ret);

If these fail, error out.  We will fail to enter buffered mode, but
that is probably the correct thing to do if we are having comms
issues or similar.

> +
> +	ret = veml6046x00_set_trig(data, 0);
> +	if (ret)
> +		dev_err(data->dev, "Failed to set trigger %d\n", ret);
> +
> +	return pm_runtime_resume_and_get(dev);
> +}



> +static int veml6046x00_validate_part_id(struct veml6046x00_data *data)
> +{
> +	int part_id, ret;
> +	__le16 reg;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_ID_L, &reg, sizeof(reg));
> +	if (ret) {
> +		dev_info(data->dev, "Failed to read ID\n");

return dev_err_probe() for this one.

> +		return -EIO;
> +	}
>
> +static int veml6046x00_setup_device(struct iio_dev *iio)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret, val;
> +	__le16 reg16;
> +	uint8_t reg[2];
> +
> +	reg[0] = VEML6046X00_CONF0_AF;
> +	reg[1] = 0x00;
> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_CONF0, reg, sizeof(reg));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set configuration\n");
> +
> +	reg16 = cpu_to_le16(0);
> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_THDL_L, &reg16, sizeof(reg16));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> +
> +	reg16 = cpu_to_le16(U16_MAX);
> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_THDH_L, &reg16, sizeof(reg16));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
> +
> +	ret = regmap_read(data->regmap, VEML6046X00_REG_INT_H, &val);
> +	if (ret < 0)

if (ret) here as well.  Good to be consistent for all regmap calls. None of them
return > 0 as far as I know.


> +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
> +
> +	return 0;
> +}
> +
> +static int veml6046x00_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct veml6046x00_data *data;
> +	struct iio_dev *iio;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &veml6046x00_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to set regmap\n");
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	i2c_set_clientdata(i2c, iio);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +
> +	ret = veml6046x00_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml6046x00_shutdown_action, data);

Mostly we want a devm action to match against a specific setup operation.  Here is
it that the device comes up in non shut down state?  Perhaps a comment to
make it clear.  Also, how do we know it's in a good state rather than part
configured by someone else?  I'm not seeing a reset sequence though perhaps
that effectively happens in setup_device()

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add shut down action\n");
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to activate PM runtime\n");
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, VEML6046X00_AUTOSUSPEND_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = veml6046x00_validate_part_id(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to validate device ID\n");
> +
> +	iio->name = i2c->name;

Prefer this hard coded.  Depending on the firmware type, things like that have
an annoying habbit of not remaining predictable or stable.

> +	iio->channels = veml6046x00_channels;
> +	iio->num_channels = ARRAY_SIZE(veml6046x00_channels);
> +	iio->modes = INDIO_DIRECT_MODE;
> +
> +	iio->info = &veml6046x00_info_no_irq;
> +
> +	ret = veml6046x00_setup_device(iio);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
> +					      veml6046x00_trig_handler,
> +					      &veml6046x00_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register triggered buffer");
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device");
> +
> +	return 0;
> +}


