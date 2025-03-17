Return-Path: <linux-iio+bounces-16991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C7A65D1E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 19:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA423A5EDD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E771DDC2C;
	Mon, 17 Mar 2025 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA9givzB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3961A8403;
	Mon, 17 Mar 2025 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237246; cv=none; b=JTVf2dlu6CfUw7+5oI39WycLUdfYEvp6q99x/8c82sihel5lehV3Hlq1qvIbUA9BdRXF3d4o2VYzs+VefluOs5NTMyNrFO7t9mMNBaReSuVOFxjZ09z8iTZHsiPgO3Z6NhcnNkrtjhc/INK1jvQ7Jzfej7BRIgJ06iJD/PnF4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237246; c=relaxed/simple;
	bh=5qJlN1rSdrhlwl7A85BfKIT3mffeBvlzNzFnHXifnMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGa4SOPz1gNi9UkTaV5v2TXgovbFearPfoM9rnYeg0WjtuSnxIAbVsEi4DzUOTDNiHMZUjfa4hMqGTe8PXctxIapXsbRVcf+QfoPoW21+Z6bw7PNfEEO/oI5Hh3soXJ/13wrDRoP1DnmXaZhq7vQfEuhSO6+rDmrF6eLTrp1zFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA9givzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F85FC4CEE3;
	Mon, 17 Mar 2025 18:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237245;
	bh=5qJlN1rSdrhlwl7A85BfKIT3mffeBvlzNzFnHXifnMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MA9givzBsHXYND6DwZStFbS1HVz1Z/4nn9aD3y1BQqX58FUG/ldHG7eKFvE1+Hdsl
	 259hzYs5zVVAAm/y3FeF4Y/TCA1HdQTld8rRyP3lxsNUcZzrwu2X63er/E9xuWH/Ti
	 mbvNZI3cpOeIogEwG3ldRhkpHKqIwyzTReUF1eqinaXPHJY9WkkAjpqRjXWAKCOb1Z
	 Z05iZxlI9+8wObKzXudt/+BMDQOx5cDupUn8J9swUU6dyUw6MRx7XvC7tVdv+QQN4m
	 kiISRHiIe+U9NWwDBs3p7Cqr6Q0CsW3ojfN7bcCUsoIcSvGk4aIskzCcAjei1bpdAt
	 Y2weGlRtalv+w==
Date: Mon, 17 Mar 2025 18:47:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <oskar.andero@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for PAC194X
Message-ID: <20250317184717.3ae82619@jic23-huawei>
In-Reply-To: <20250317090803.30003-3-marius.cristea@microchip.com>
References: <20250317090803.30003-1-marius.cristea@microchip.com>
	<20250317090803.30003-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 11:08:03 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip PAC194X and PAC195X series of
> Power Monitors with Accumulator.
> The PAC194X family supports 9V Full-Scale Range and the PAC195X supports
> 32V Full-Scale Range.
> There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices are
> for high-side current sensing and the PAC194X/5X-2 devices are for
> low-side current sensing or floating VBUS applications.
> The PAC194X/5X-1 is named shortly PAC194X/5X.

This patch is too large. I'd suggest breaking it down into the core
driver, no events, no custom ABI etc.  Then propose the ABI stuff
on top.  That will let reviewers look at stuff that is much more
standard before moving on to looking at the new stuff.

Main feedback here is don't invent new ABI without looking very closely
at the existing ABI.  Maybe I'm missing something, but superficially it
feels like a lot of what we have here maps trivially to existing ABI.

There also seems to be quite a bit more ABI that is not in the docs
you have added.

Jonathan

> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-pac1944     |  118 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   12 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/pac1944.c                     | 3314 +++++++++++++++++
>  5 files changed, 3452 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
>  create mode 100644 drivers/iio/adc/pac1944.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> new file mode 100644
> index 000000000000..e4122f58fe39
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> @@ -0,0 +1,118 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_shunt_resistor

This is a logical extension of in_current_shunt_resistor in the main ABI
doc. Just add this indexed variant there instead of in here (which should just
be ABI not in line with the main ABI).

> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The value of the shunt resistor may be known only at runtime
> +		and set by a client application. This attribute allows to
> +		set its value in micro-ohms. X is the IIO index of the device.
> +		Y is the channel number. The value is used to calculate
> +		current, power and accumulated energy.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_ocY_limit_nsamples
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Number of consecutive samples exceeding the overcurrent limit
> +		that are required to trigger the ALERT function for channel Y.

Whilst it will be more complex on the driver, please map this to the main
_period event ABI that is time in seconds for which the condition should be true.
I think this device has a sequencer that runs these monitoring conditions without
us needing to trigger them individually. If so combing these with sampling_frequency
value should allow you to use period. 

Note that custom ABI is roughly speaking unused ABI, because no standard software
will have any idea what it means.  So where it is possible to map to ABI that
is in existing use, we should do so rather than defining something new.

overcurrent in general usually maps to
in_current_thresh_rising* with a specific current threshold value.



> +		Consecutive sample count to trigger could be:
> +			- 1 sample (default),
> +			- 4 samples,
> +			- 8 samples,
> +			- 16 samples.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_ucY_limit_nsamples

Undercurrent similarly normally maps to a falling threshold.

> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Number of consecutive samples exceeding the undercurrent limit
> +		that are required to trigger the ALERT function for
> +		channel Y. Consecutive sample count to trigger could be:
> +			- 1 sample (default),
> +			- 4 samples,
> +			- 8 samples,
> +			- 16 samples.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_opY_limit_nsamples
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Number of consecutive samples exceeding the overpower limit that

in_powerY_thresh_rising_period
I think maps to the equilvalent with units in seconds.


> +		are required to trigger the ALERT function for channel Y.
> +		Consecutive sample count to trigger could be:
> +			- 1 sample (default),
> +			- 4 samples,
> +			- 8 samples,
> +			- 16 samples.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_ovY_limit_nsamples
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
in_voltageY_thresh_rising_period.

> +		Number of consecutive samples exceeding the overvoltage limit
> +		that are required to trigger the ALERT function for channel Y.
> +		Consecutive sample count to trigger could be:
> +			- 1 sample (default),
> +			- 4 samples,
> +			- 8 samples,
> +			- 16 samples.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_uvY_limit_nsamples

in_voltageY_thresh_falling_period

> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Number of consecutive samples exceeding the undervoltage limit
> +		that are required to trigger the ALERT function for channel Y.
> +		Consecutive sample count to trigger could be:
> +			- 1 sample (default),
> +			- 4 samples,
> +			- 8 samples,
> +			- 16 samples.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_acc_fullness
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read/write property used to set a limit for how full the
> +		Accumulators and Accumulator Count registers can be before the
> +		Accumulator Full and Accumulator Count full limits are tripped.
> +		This allows an ALERT to be registered when the Accumulator and
> +		Accumulator Count are approaching 100% full.

The aim here being to handle roll over?  If so then just handle that in the
driver by accumulating into a larger store and don't use an event at all.

> +		The fullness limit could be set to:
> +			- full,
> +			- 15/16 full (default),
> +			- 7/8 full,
> +			- 3/4 full
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/alert_enable
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read/write property used to enable/disable the limits events
> +		and also controls the signals triggered when the Accumulator for
> +		any channel overflows or exceeds its fullness or the Accumulator
> +		Count overflows or exceeds its fullness limit.

You need to wrap this up to use standard ABI as well. Will be a bunch of separate
event enables. Then probably filter in driver to only report the ones that are
enabled.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/slow_alert1
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read/write property used to route a specific ALERT signal to
> +		the SLOW/ALERT1 pin. The SLOW/ALERT1 pin must be configured for
> +		the ALERT function in order to control the device hardware pin
> +		(this is the default functionality of the device hardware pin).

So either:
a) This alert pin is not wired to the host. In which case this should probably be in DT.
   It reflects a signal used to cause something else to happen and those tend
   to be disabling power or something along those lines - not typically something
   we want userspace rewiring.

b) It is wired to the host, then it's not something userspace should play with.
   The driver should be able to figure out the right interrupts to map to this
   pin.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/gpio_alert2
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read/write property used to route a specific ALERT signal to
> +		to the GPIO/ALERT2 pin. The GPIO/ALERT2 pin must be configured
> +		for ALERT function in order to control the device hardware pin
> +		(this is the default functionality of the device hardware pin).

Similar to above.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_alert_status
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A read only property used to determine the cause of ALERT/events
> +		being tripped.

Why not report them via the events interface?





> diff --git a/drivers/iio/adc/pac1944.c b/drivers/iio/adc/pac1944.c
> new file mode 100644
> index 000000000000..b6f93d21b86b
> --- /dev/null
> +++ b/drivers/iio/adc/pac1944.c
> @@ -0,0 +1,3314 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for PAC194X and PAC195X series chips
> + *
> + * Copyright (C) 2022-2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Marius Cristea marius.cristea@microchip.com
> + *
> + * Datasheet for PAC1941, PAC1942, PAC1943 and PAC1944 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
> + * Datasheet for PAC1951, PAC1952, PAC1953 and PAC1954 can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
> + *
No blank line here.
> + */
>
> +/*
> + * Universal Unique Identifier (UUID),
> + * 721F1534-5D27-4B60-9DF4-41A3C4B7DA3A,
> + * is reserved to Microchip for the PAC194x and PAC195x.
> + */
> +#define PAC1944_DSM_UUID	"721F1534-5D27-4B60-9DF4-41A3C4B7DA3A"

Little advantage in having this up here. I'd push it down where it is used
and put the comments there as well.


> +
> +/*
> + * [(100mV * 1000000) / (2^15)]*10^9  used to calculate the scale
> + * for accumulated current/Coulomb counter
> + */
> +#define PAC1944_MAX_VSENSE_NANO			3051757812500UL
> +
> +#define TO_PAC1944_CHIP_INFO(d) container_of(d, struct pac1944_chip_info, work_chip_rfsh)
to_pac1944_chip_info() would be more in keeping with other container_of
macros.

> +
> +static int pac1944_disable_alert_reg(struct device *dev, u32 mask, u8 *status)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	u32 val;
> +	u8 buf[PAC1944_ALERT_ENABLE_REG_LEN];
> +
> +	ret = i2c_smbus_read_i2c_block_data(client,
> +					    PAC1944_ALERT_ENABLE_REG_ADDR,
> +					    PAC1944_ALERT_ENABLE_REG_LEN,
> +					    status);
> +	if (ret < 0) {
> +		dev_err(dev, "failing %s\n", __func__);
> +		return ret;
> +	}
> +
> +	val = get_unaligned_be24(status);
> +	val = val & (~mask);
> +	put_unaligned_be24(val, &buf[0]);
> +
> +	/* disable appropriate bit from the Alert enable register */
> +	ret = i2c_smbus_write_block_data(client, PAC1944_ALERT_ENABLE_REG_ADDR,
> +					 PAC1944_ALERT_ENABLE_REG_LEN,
> +					 (u8 *)&buf[0]);
> +
> +	return ret;

	return i2c_smbus_write_block_data()

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
> +		return ret;
> +	}
> +	tmp = get_unaligned_be24(&status[0]);
> +
> +	return sysfs_emit(buf, "%u\n", tmp);
	return sysfs_emit(buf, "%u\n", get_unaligned_be24(status));

> +}

> +
> +#define PAC1944_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)

I'd find it clearer if you just used the expanded form of this instead of
the macro.

> +static int pac1944_reg_snapshot(struct pac1944_chip_info *info,
> +				bool do_refresh, u8 refresh_cmd, u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
> +	u8 shift, idx;
> +	u8 *offset_reg_data_p;
> +	int cnt, ret;
> +	u32 count, inc_count;
> +	u32 fs = 0;
> +	s64 stored_value, tmp_s64;
> +	s64 inc = 0;
> +	__be16 tmp_be16;
> +	u16 smpl_mode;
> +	bool is_unipolar;
> +
> +	guard(mutex)(&info->lock);
> +
> +	if (do_refresh) {
> +		ret = pac1944_send_refresh(info, refresh_cmd, wait_time);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "%s - cannot send refresh towards PAC1944\n",

Have a local struct device *dev = &client->dev;

> +				__func__);

I'd drop the __func__ bit. The message should be enough info anyway.

> +			return ret;
> +		}
> +	}

...


> +
> +		if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +			info->chip_reg_data.vbus[cnt] =
> +			sign_extend32(info->chip_reg_data.vbus[cnt], 15);

That indent is very much not style compliant. Add another tab. Check for similar
cases (or get an editor that doesn't let you do this particular thing!)

> +
> +		offset_reg_data_p += PAC1944_VBUS_SENSE_REG_LEN;
> +	}
> +
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		info->chip_reg_data.vsense[cnt] = get_unaligned_be16(offset_reg_data_p);
> +
> +		if (info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +			info->chip_reg_data.vsense[cnt] =
> +			sign_extend32(info->chip_reg_data.vsense[cnt], 15);
> +
> +		offset_reg_data_p += PAC1944_VBUS_SENSE_REG_LEN;
> +	}
> +
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		info->chip_reg_data.vbus_avg[cnt] = get_unaligned_be16(offset_reg_data_p);
> +
> +		if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +			info->chip_reg_data.vbus_avg[cnt] =
> +			sign_extend32(info->chip_reg_data.vbus_avg[cnt], 15);
> +
> +		offset_reg_data_p += PAC1944_VBUS_SENSE_REG_LEN;
> +	}
> +
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		info->chip_reg_data.vsense_avg[cnt] = get_unaligned_be16(offset_reg_data_p);
> +
> +		if (info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +			info->chip_reg_data.vsense_avg[cnt] =
> +			sign_extend32(info->chip_reg_data.vsense_avg[cnt], 15);
> +
> +		offset_reg_data_p += PAC1944_VBUS_SENSE_REG_LEN;
> +	}
> +
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		info->chip_reg_data.vpower[cnt] = get_unaligned_be32(offset_reg_data_p) >> 2;
> +
> +		if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG ||
> +		    info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
> +			info->chip_reg_data.vpower[cnt] =
> +			sign_extend32(info->chip_reg_data.vpower[cnt], 29);
> +
> +		offset_reg_data_p += PAC1944_VPOWER_REG_LEN;
> +	}
> +
> +	return 0;
> +}

> +static ssize_t pac1944_in_power_acc_scale_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	unsigned int shunt, rem;
> +	u64 tmp, ref;
> +
> +	if (info->is_pac195x_family)
> +		ref = (u64)PAC195X_MAX_VPOWER_RSHIFTED_BY_29B;
> +	else
> +		ref = (u64)PAC194X_MAX_VPOWER_RSHIFTED_BY_29B;

why are the casts needed?

> +
> +static ssize_t pac1944_in_enable_acc_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int val;
> +
> +	if (kstrtouint(buf, 10, &val)) {
> +		dev_err(dev, "Value is not valid\n");
> +		return -EINVAL;
> +	}
> +
> +	scoped_guard(mutex, &info->lock) {
> +		info->enable_acc[this_attr->address] = val ? true : false;
> +		if (!val) {
> +			info->chip_reg_data.acc_val[this_attr->address] = 0;

Comment needed for this.  Why is it reset on disable, rather just before enabling?

> +			info->chip_reg_data.total_samples_nr[this_attr->address] = 0;
> +		}
> +	}
> +
> +	return count;
> +}

> +
> +static ssize_t pac1944_in_current_acc_scale_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int shunt, rem;
> +	u64 tmp_u64, ref;
> +
> +	/*
> +	 * Currents - scale for mA - depends on the channel's shunt value
> +	 * (100mV * 1000000) / (2^16 * shunt(uOhm))
> +	 */
> +	ref = (u64)PAC1944_MAX_VSENSE_NANO;
> +
> +	switch (info->chip_reg_data.vsense_mode[this_attr->address]) {
> +	case PAC1944_UNIPOLAR_FSR_CFG:
> +	case PAC1944_BIPOLAR_HALF_FSR_CFG:
> +		shunt = info->shunts[this_attr->address];
> +		break;
> +	case PAC1944_BIPOLAR_FSR_CFG:
> +		ref = ref << 1;
> +		shunt = info->shunts[this_attr->address];
> +		break;
> +	default:
> +		return 0;

Comment needed on why this is not returning an error.

> +	}
> +
> +	/*
> +	 * Increasing precision
> +	 * (100mV * 1000000 * 1000000000) / 2^16 )
> +	 */
> +	tmp_u64 = div_u64(ref, shunt);
> +	rem = do_div(tmp_u64, 1000000000LL);
> +
> +	return sysfs_emit(buf, "%lld.%09u\n", tmp_u64, rem);
> +}


> +
> +static int pac1944_frequency_set(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 unsigned int mode)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	u16 tmp_u16;
> +	__be16 tmp_be16;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_ACT_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_be16);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
> +			__func__, PAC1944_CTRL_ACT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	tmp_u16 = be16_to_cpu(tmp_be16);
> +	tmp_u16 &= ~PAC1944_CTRL_SAMPLE_MASK;
> +	tmp_u16 |= FIELD_PREP(PAC1944_CTRL_SAMPLE_MASK, mode);
> +	tmp_be16 = cpu_to_be16(tmp_u16);
> +
> +	scoped_guard(mutex, &info->lock) {
> +		ret = i2c_smbus_write_word_data(client, PAC1944_CTRL_REG_ADDR, tmp_be16);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev, "Failed to configure sampling mode\n");
> +			return ret;
> +		}
> +
> +		info->sampling_mode = mode;
> +		info->chip_reg_data.ctrl_act_reg = tmp_u16
> +	}
> +
> +	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
Unless that returns positive just do return pac1944_...

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int pac1944_frequency_get(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan)
> +{
> +	struct pac1944_chip_info *info;
> +
> +	info = iio_priv(indio_dev);

	struct pac1944_chip_info *info = iio_priv(indio_dev);

> +
> +	return info->sampling_mode;
> +}

...

> +
> +static const struct iio_chan_spec_ext_info pac1944_ext_info[] = {
> +	IIO_ENUM("sampling_frequency", IIO_SHARED_BY_ALL, &sampling_mode_enum),

These are standard ABI, why are they in extinfo?

> +	{
> +		.name = "sampling_frequency_available",
> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = iio_enum_available_read,
> +		.private = (uintptr_t)&sampling_mode_enum,
> +	},
> +	{}

	{ }
would be my preference.

> +};
> +


> +static int pac1944_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan, enum iio_event_type type,
> +			       enum iio_event_direction dir, enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct pac1944_chip_info *chip_info = iio_priv(indio_dev);
> +	int idx;
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	scoped_guard(mutex, &chip_info->lock) {
As below.

> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				*val = chip_info->overvoltage[idx];
> +				return IIO_VAL_INT;
> +			case IIO_EV_DIR_FALLING:
> +				*val = chip_info->undervoltage[idx];
> +				return IIO_VAL_INT;
> +			default:
> +				return -EINVAL;
> +			}
> +		case IIO_CURRENT:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				*val = chip_info->overcurrent[idx];
> +				return IIO_VAL_INT;
> +			case IIO_EV_DIR_FALLING:
> +				*val = chip_info->undercurrent[idx];
> +				return IIO_VAL_INT;
> +			default:
> +				return -EINVAL;
> +			}
> +		case IIO_POWER:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				*val = chip_info->overpower[idx];
> +				return IIO_VAL_INT;
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return -EINVAL;
Can't get here.

> +}
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
> +	scoped_guard(mutex, &chip_info->lock) {
Use a guard() here

scoped_guard() and unreachable tends to have odd effects on compilers
that can get very confused.

Also, simple guard() reduces indent which is a nice to have here.

> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_OV_LIMIT_REG_ADDR + idx,
> +							       pac1944_overvoltage_mask_tbl[idx],
> +							       val);
> +				if (!ret)
> +					chip_info->overvoltage[idx] = val;
Try to keep the error paths out of line, even if it adds a few lines to the code.

				if (ret)
					return ret;

				chip_info->overvoltage[idx] = val
				return 0;
> +			return ret;

This is indented one tab too few.

> +			case IIO_EV_DIR_FALLING:
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_UV_LIMIT_REG_ADDR + idx,
> +							       pac1944_undervoltage_mask_tbl[idx],
> +							       val);
> +				if (!ret)
> +					chip_info->undervoltage[idx] = val;
> +				return ret;
> +			default:
> +				return -EINVAL;
> +			}
> +		case IIO_CURRENT:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_OC_LIMIT_REG_ADDR + idx,
> +							       pac1944_overcurrent_mask_tbl[idx],
> +							       val);
> +				if (!ret)
> +					chip_info->overcurrent[idx] = val;
> +				return ret;
> +			case IIO_EV_DIR_FALLING:
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_UC_LIMIT_REG_ADDR + idx,
> +							       pac1944_undercurrent_mask_tbl[idx],
> +							       val);
> +				if (!ret)
> +					chip_info->undercurrent[idx] = val;
> +				return ret;
> +			default:
> +				return -EINVAL;
> +			}
> +		case IIO_POWER:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				ret = pac1944_update_alert_24b(&indio_dev->dev,
> +							       PAC1944_OP_LIMIT_REG_ADDR + idx,
> +							       pac1944_overpower_mask_tbl[idx],
> +							       val);
> +				if (!ret)
> +					chip_info->overpower[idx] = val;
> +				return ret;
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	unreachable();
> +}

> +static int pac1944_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
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
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			mask = pac1944_overvoltage_mask_tbl[idx];
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			mask = pac1944_undervoltage_mask_tbl[idx];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;

Can't get here. So drop this break and similar ones.

> +	case IIO_CURRENT:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			mask = pac1944_overcurrent_mask_tbl[idx];
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			mask = pac1944_undercurrent_mask_tbl[idx];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_POWER:
> +		if (dir == IIO_EV_DIR_RISING)
> +			mask = pac1944_overpower_mask_tbl[idx];
> +		else
> +			return -EINVAL;
If you are going to check one specific thing, then check for error
		if (dir != IIO_EV_DIR_RISING)
			return -EINVAL;

		mask = pac1944_overpower_mask_tbl[idx];

> +		break;
> +	default:

...

> +
> +static void pac1944_work_periodic_rfsh(struct work_struct *work)
> +{
> +	struct pac1944_chip_info *info = TO_PAC1944_CHIP_INFO((struct delayed_work *)work);
Should use to_delayed_work() to get from work to delayed work.

> +	struct i2c_client *client = info->client;
> +
> +	dev_dbg(&client->dev, "%s - Periodic refresh\n", __func__);
> +
> +	pac1944_reg_snapshot(info, true, PAC1944_REFRESH_REG_ADDR,
> +			     PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +
> +	schedule_delayed_work(&info->work_chip_rfsh,
> +			      msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
> +}
> +
> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/UserGuides/PAC194X_5X-UEFI-BIOS-Integration-and-Microsoft-Windows-10-and-Windows-11-Energy-Meter-Interface-Device-Driver-Users-Guide-DS50003155.pdf
> + */
> +static int pac1944_acpi_parse_channel_config(struct i2c_client *client,
> +					     struct pac1944_chip_info *info)
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
> +		return -ENODEV;
> +
> +	guid_parse(PAC1944_DSM_UUID, &guid);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1944_ACPI_GET_NAMES, NULL);
> +	if (!rez)
> +		return -EINVAL;
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
> +		return -EINVAL;
> +
> +	for (i = 0; i < rez->package.count; i++) {
> +		info->shunts[i] = rez->package.elements[i].integer.value;
> +		info->active_channels[i] = (info->shunts[i] != 0);
> +		info->active_channels_mask |= 1 << i;

set_bit() is a little clearer.

> +
> +static int pac1944_of_parse_channel_config(struct i2c_client *client,
> +					   struct pac1944_chip_info *info)
> +{
> +	unsigned int current_channel;
> +	struct device *dev = &client->dev;
> +	int idx, ret, temp;
> +
> +	current_channel = 1;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "reading invalid channel index\n");
> +
> +		/* adjust idx to match channel index (1 to 4) from the datasheet */
> +		idx--;
> +
> +		if (current_channel >= (info->phys_channels + 1) ||
> +		    idx >= info->phys_channels || idx < 0)
> +			return dev_err_probe(&client->dev, -EINVAL,
> +					     "invalid channel_index %d value\n", (idx + 1));

Those inner () aren't adding anything, so drop them.

> +
> +		/* enable channel */
>

...


> +
> +static int pac1944_prep_iio_channels(struct pac1944_chip_info *info,
> +				     struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &info->client->dev;
> +	struct iio_chan_spec *ch_sp;
> +	int channel_size, attribute_count, cnt;
> +	void *dyn_ch_struct;
> +
> +	/* Finding out dynamically how many IIO channels we need */
> +	attribute_count = 0;
> +	channel_size = 0;
> +
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		/* add the size of the properties of one chip physical channel */
> +		channel_size += sizeof(pac1944_single_channel);
> +		/* count how many enabled channels we have */
> +		attribute_count += ARRAY_SIZE(pac1944_single_channel);
> +		dev_dbg(dev, ":%s: Channel %d active\n", __func__, cnt + 1);
> +	}
> +
> +	dyn_ch_struct = devm_kzalloc(dev, channel_size, GFP_KERNEL);
> +	if (!dyn_ch_struct)
> +		return -ENOMEM;
> +
> +	ch_sp = (struct iio_chan_spec *)dyn_ch_struct;
why jump through a void *?  Just assign 
	ch_sp = devm_kzalloc();
	if (!ch_sp)
		return -ENOMEM;


> +	/* Populate the dynamic channels and make all the adjustments */
> +	for_each_set_bit(cnt, &info->active_channels_mask, info->phys_channels) {
> +		memcpy(ch_sp, pac1944_single_channel, sizeof(pac1944_single_channel));
> +		/*
> +		 * Into the datasheet channels are noted from 1 to 4 so we will adjust
> +		 * the channel to match channel index (1 to 4) from the datasheet
> +		 */
> +		ch_sp[PAC1944_CH_POWER].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_POWER].address = cnt + PAC1944_VPOWER_1_ADDR;
> +		ch_sp[PAC1944_CH_VOLTAGE].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_VOLTAGE].address = cnt + PAC1944_VBUS_1_ADDR;
> +		ch_sp[PAC1944_CH_CURRENT].channel = cnt + 1;
> +		ch_sp[PAC1944_CH_CURRENT].address = cnt + PAC1944_VSENSE_1_ADDR;
> +		/*
> +		 * In order to be able to use labels for PAC1944_CH_VOLTAGE and
> +		 * PAC1944_CH_VOLTAGE_AVERAGE, respectively PAC1944_CH_CURRENT
> +		 * and PAC1944_CH_CURRENT_AVERAGE we need to use different channel numbers.
> +		 * We will add  +5 (+1 to maximum PAC channels).
> +		 */
> +		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].channel = cnt + PAC1944_MAX_CH + 1;
> +		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].address = cnt + PAC1944_VBUS_AVG_1_ADDR;
> +		ch_sp[PAC1944_CH_CURRENT_AVERAGE].channel = cnt + PAC1944_MAX_CH + 1;
> +		ch_sp[PAC1944_CH_CURRENT_AVERAGE].address = cnt + PAC1944_VSENSE_AVG_1_ADDR;
> +
> +		/* advance the pointer */
> +		ch_sp = (void *)ch_sp + sizeof(pac1944_single_channel);

Keep the type as that ch_spec and do 

		ch_sp += ARRAY_SIZE(pac1944_single_channel);

> +	}
> +
> +	/*
> +	 * Send the updated dynamic channel structure information towards IIO
> +	 * prepare the required field for IIO class registration
> +	 */
> +	indio_dev->num_channels = attribute_count;
> +	indio_dev->channels = (const struct iio_chan_spec *)dyn_ch_struct;

That cast isn't needed.  Not sure why there is one in the pac1921 driver in similar
place. 

> +
> +	return 0;
> +}


> +static int pac1944_probe(struct i2c_client *client)
> +{
> +	struct pac1944_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	const struct pac1944_features *chip;
> +	int cnt, ret;
> +	struct device *dev = &client->dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	info->client = client;
> +
> +	ret = pac1944_chip_identify(info);
> +	if (ret < 0) {
> +		/*
> +		 * If failed to identify the hardware based on internal
> +		 * registers, try using fallback compatible in device
> +		 * tree to deal with some newer part number.
> +		 */
> +		chip = i2c_get_match_data(client);
> +		if (!chip)
> +			return -EINVAL;
> +
> +		info->chip_variant = chip->prod_id;
> +		info->phys_channels = chip->phys_channels;
> +		indio_dev->name = chip->name;
> +	} else {

If the FW disagrees with what we found it is also nice to print a message
to that effect.  Not vital, but nice to have.

> +		info->phys_channels = pac1944_chip_config[ret].phys_channels;
> +		indio_dev->name = pac1944_chip_config[ret].name;
> +	}

...

> +}
> +
> +static const struct i2c_device_id pac1944_id[] = {
> +	{ .name = "pac1941", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1941] },
> +	{ .name = "pac19412", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1941_2] },
> +	{ .name = "pac1942", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1942] },
> +	{ .name = "pac19422", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1942_2] },
> +	{ .name = "pac1943", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1943] },
> +	{ .name = "pac1944", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1944] },
> +	{ .name = "pac1951", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1951] },
> +	{ .name = "pac19512", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1951_2] },
> +	{ .name = "pac1952", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1952] },
> +	{ .name = "pac19522", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1952_2] },
> +	{ .name = "pac1953", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1953] },
> +	{ .name = "pac1954", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1954] },
> +	{}

as below.

> +};
> +MODULE_DEVICE_TABLE(i2c, pac1944_id);
> +
> +static const struct of_device_id pac1944_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1941",
> +		.data = (void *)&pac1944_chip_config[PAC1941]
> +	},

...

> +	{
> +		.compatible = "microchip,pac1954",
> +		.data = (void *)&pac1944_chip_config[PAC1954]
> +	},
> +	{}
As below. Totally trivial but nice to tidy up

> +};
> +MODULE_DEVICE_TABLE(of, pac1944_of_match);
> +
> +static const struct acpi_device_id pac1944_acpi_match[] = {
> +	{ "MCHP1940", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1944] },
> +	{}
I'm slowly trying to standardize in IIO on one format for these
and the random choice I made a while back was 
	{ }

so with the space.  It isn't really better than what you have here, but
consistency is nice to have.

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
Common practice is to tightly couple this with the struct i2c_driver
definition above by not having a blank line here. (trivial!)

> +module_i2c_driver(pac1944_driver);


