Return-Path: <linux-iio+bounces-25267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0FBEE2F9
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 12:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5E6189C99F
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7BA2E3397;
	Sun, 19 Oct 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEudXU4G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1B182D0;
	Sun, 19 Oct 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760869732; cv=none; b=RKBTWw08N6sx/bwpQt8oMlouAAcvB/l/KWw5c2yF1w39c+8XUpg/SGrRkb9v15hNiphveiORpdZk8vMQ/ihXTqvjSG9OHksOBMzPmmUk7xBZN8rP7pUL7T3LmwVYOPRRmvHaiaFm3gif73fZfdOqEUyPE2WyU+1mZNMlSNJZB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760869732; c=relaxed/simple;
	bh=qU8eQ57PJ/l+bvLvPACnfBUWDkNFW5b3fg/SSlXqr40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fM6UylAEzD+BP+5QmladAipbJWx9b2dhrDCnau9grr0f8nXzaai0UrbnaUvgtN5o1UELropmde33KsGXb4WqPrSGXGoRdDEOreC2q58KeGlSHUlpRJC1GpKRxSV3euR2VzNsec3WUeEpnpHEcPLrLwl/qqfPsKIBOicNV6pxeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEudXU4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F62C4CEE7;
	Sun, 19 Oct 2025 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760869731;
	bh=qU8eQ57PJ/l+bvLvPACnfBUWDkNFW5b3fg/SSlXqr40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KEudXU4GtMsSEu/L8CSVfmH7rrbOmjeVYqBQkolmKau+1491rWYcuw42voXBQowOw
	 S+38gxwfZcZiZfsLYqrlDMAlOC/oBx4I7ZjFJsUOAynoDxovvngo8hKqgN342SUZXI
	 5/Jb5U5736UEm3fGLTAMBQKsLIryeII/CS6Ywp2xyySk9lNFmhSunO7knYZWPwcjI5
	 ipFvw/uuX4jqr66rE8orXXMdA5/0vyf7W+Fob7H9i2bGUfnJqlQnTWJwHssmKcce8g
	 A8fJ23n3qKy1kdOzxxEunHY4fdES/WK2wppdhVVzYkdDG5bdpO8TCeDsYQKAGQIhIj
	 gRqgMj3U4sT6g==
Date: Sun, 19 Oct 2025 11:28:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: adding support for PAC1711
Message-ID: <20251019112846.774d7690@jic23-huawei>
In-Reply-To: <20251015-pac1711-v1-2-976949e36367@microchip.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
	<20251015-pac1711-v1-2-976949e36367@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 13:12:16 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip PAC1711 single-channel power monitor
> with accumulator. The device uses 12-bit resolution for voltage and current
> measurements and 24 bits power calculations. The device supports one 56-bit
> accumulator register.
> 
> PAC1711 measures up to 42V Full-Scale Range.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
See comments on hwmon / iio in reply to the cover letter. I'll review
this anyway as may save some time either way.

Biggest questions are around what ABI is actually useful to present to
userspace.   Often devices do things like providing voltage accumulation
but in practice that's only because it was easy to build the hardware,
not because anyone actually wants it.  We are safer to not introduce
ABI if unsure, and wait for the usecase to become clear.  New ABI has
a significant burden in terms of tooling updates and long term maintenance.

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   57 +
>  MAINTAINERS                                        |    2 +
>  drivers/iio/adc/Kconfig                            |   10 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/pac1711.c                          | 1448 ++++++++++++++++++++
>  5 files changed, 1518 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
> new file mode 100644
> index 0000000000000000000000000000000000000000..7f6ab50d29ff064d57b80df0a0c162a4c98764f8
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
> @@ -0,0 +1,57 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The value of the shunt resistor may be known only at runtime and
> +		set by a client application. This attribute allows to set its
> +		value in micro-ohms. X is the IIO index of the device. The value
> +		is used to calculate current, power and accumulated energy.

This is standard IIO ABI. We don't duplicate documentation so no entry here.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_acc_raw
> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to read the accumulated voltage measured
> +		on the shunt resistor (Coulomb counter). Units after application
> +		of scale are mA. X is the IIO index of the device.

As you mention it is counting charge.  So not a current measurement at all.
We don't currently have a charge type so we should add one.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_acc_scale
> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If known for a device, scale to be applied to in_current_raw in
> +		order to obtain the measured value in mA units. X is the IIO
> +		index of the device.

It's not because it is accumulated so with approximation of 
charge = sumof delta t * instantaneous current 
it should be in coulombs.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_acc_en
> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, is used to enable digital
> +		accumulation of VSENSE measurements. X is the IIO index of the
> +		device.

Other than the type this is standard ABI for channel types that count / accumulate.
So should be a new entry in the _en bit in sysfs-bus-ii

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_acc_raw
Voltage integrals are a weirder thing as they don't in of themselves represent
anything in particular.  I am a bit curious on why anyone wants these
except as part of computing something else.

Still we can define a new channel type for this if we have a bit more on why
it is useful.  It might be more useful presented as an average voltage by
dividing by number of samples.. (the datasheet calls this out as a possible
usecase)  The device also has short term averaging so I'm not sure how useful this
is.  It might not make sense to present this one at all.

> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to read the accumulated voltage on VBUS.
> +		Units after application of scale are mV. X is the IIO index of
> +		the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_acc_scale
> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If known for a device, scale to be applied to in_voltage_raw
> +		in order to obtain the measured value in mV units. X is the IIO
> +		index of the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_acc_en
> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, is used to enable digital
> +		accumulation of VBUS measurements. X is the IIO index of the
> +		device.
> +


> diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..30929af202e009c2d80ba91d5c137a26a03f09d7
> --- /dev/null
> +++ b/drivers/iio/adc/pac1711.c
> @@ -0,0 +1,1448 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for PAC1711 Multi-Channel DC Power/Energy Monitor
> + *
> + * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
Should include 2025 given this is going to change.

> + *
> + * Author: Ariana Lazar <ariana.lazar@microchip.com>
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/unaligned.h>

There are definitely some headers missing here.  mutex.h for starters.

Aim to follow principles of include what you used. It is slightly fuzzy
for the kernel so do check that headers you add are commonly included
in drivers.  A few have standard 'grouping' headers that are always used
instead.

> +
> +/* voltage bits resolution when set for unsigned values */
> +#define PAC1711_VOLTAGE_12B_RES			12
> +/* voltage bits resolution when set for signed values */
> +#define PAC1711_VOLTAGE_11B_RES			11
> +
> +/* Power resolution is 24 bits when contains unsigned values */
> +#define PAC1711_POWER_24B_RES			24
> +/* Power resolution is 24 bits when contains signed values */
> +#define PAC1711_POWER_23B_RES			23
Defining something called 24 to the value 24 doesn't seem productive.
Just use 24 / 23 inline as their meaning should be clear.

> +
> +/* Maximum power-product value - 42 V * 0.1 V */
> +#define PAC1711_PRODUCT_VOLTAGE_PV_FSR		4200000000000UL
> +
> +/* Scale constant = (10^3 * 4.2 * 10^9 / 2^24) for mili Watt-second */
> +#define PAC1711_SCALE_CONSTANT			250340
> +
> +/* (100mV * 1000000) / (2^12)  used to calculate the scale for current */
> +#define PAC1711_MAX_VSENSE_RSHIFTED_BY_12B	24414
> +
> +/*
> + * [(100mV * 1000000) / (2^12)]*10^9  used to calculate the scale
> + * for accumulated current/Coulomb counter
I'd have this comment and the value down in the code. Not seeing huge value
from having it up here as it is only used once.
Check whehter the other defines benefit form up here.
> + */
> +#define PAC1711_MAX_VSENSE_NANO			24414062500000UL
> +
> +/* I2C address map */
> +#define PAC1711_REFRESH_REG_ADDR		0x00
> +#define PAC1711_CTRL_REG_ADDR			0x01
> +#define PAC1711_ACC_COUNT_REG_ADDR		0x02
> +#define PAC1711_VACC_ADDR			0x03
> +#define PAC1711_VBUS_ADDR			0x04
> +#define PAC1711_VSENSE_ADDR			0x05
> +#define PAC1711_VBUS_AVG_ADDR			0x06
> +#define PAC1711_VSENSE_AVG_ADDR			0x07
> +#define PAC1711_VPOWER_ADDR			0x08
> +
> +/* Start of configurations registers */
> +#define PAC1711_CTRL_LAT_REG_ADDR		0x0F
> +#define PAC1711_NEG_PWR_FSR_REG_ADDR		0x13
> +#define PAC1711_SLOW_REG_ADDR			0x16
> +#define PAC1711_CTRL_ACT_REG_ADDR		0x17
> +#define PAC1711_PID_REG_ADDR			0xFD
> +#define PAC1711_REVISION_ID_REG_ADDR		0xFF
> +
> +#define PAC1711_ACC_DEVATTR			3
Used in only a few places and better established via ARRAY_SIZE() or similar.

> +#define PAC1711_COMMON_DEVATTR			1
> +#define PAC1711_MEAS_REG_SNAPSHOT_LEN		23
Can we derive that from register addresses. If not add a comment on why it is this.
> +#define PAC1711_ACC_REG_LEN			4
Likewise. These look like values that should be derived not just encoded
as numbers here.
> +#define PAC1711_VACC_REG_LEN			7
> +#define PAC1711_VBUS_SENSE_REG_LEN		2
> +
> +/* PRODUCT IDs */
> +#define PAC_PRODUCT_ID_1711			0x80
> +
> +/* CTRL reg */
Which is this? There isn't a register simply called CTRL. I think
it is CTRL_LAT_REG


> +#define PAC1711_CTRL_SAMPLE_MODE_MASK		GENMASK(15, 12)
> +
> +/* NEG_PWR_CFG reg */

There isn't one called that above.

> +#define PAC1711_NEG_PWR_CFG_VS_MASK		GENMASK(3, 2)
> +#define PAC1711_NEG_PWR_CFG_VB_MASK		GENMASK(1, 0)
I'd group fields just under the register address definition. Makes it clear what
they are for and avoids need for comments.

> +#define PAC1711_SAMPLING_MODE_MASK		GENMASK(11, 0)
> +
> +#define PAC1711_DEV_ATTR(name)			(&iio_dev_attr_##name.dev_attr.attr)
> +
> +enum pac1711_ch_idx {
> +	PAC1711_CH_POWER,
> +	PAC1711_CH_VOLTAGE,
> +	PAC1711_CH_CURRENT,
> +	PAC1711_CH_VOLTAGE_AVERAGE,
> +	PAC1711_CH_CURRENT_AVERAGE,
> +};
> +
> +enum pac1711_acc_mode {
> +	PAC1711_ACCMODE_VPOWER,
> +	PAC1711_ACCMODE_VSENSE,
> +	PAC1711_ACCMODE_VBUS,
> +};
> +
> +enum pac1711_fsr {
> +	PAC1711_FULL_RANGE_UNIPOLAR,
> +	PAC1711_FULL_RANGE_BIPOLAR,
> +	PAC1711_HALF_RANGE_BIPOLAR,
> +};
> +
> +static const int pac1711_vbus_range_tbl[][2] = {
> +	[PAC1711_FULL_RANGE_UNIPOLAR] = {0, 42000000},
> +	[PAC1711_FULL_RANGE_BIPOLAR] = {-42000000, 42000000},
> +	[PAC1711_HALF_RANGE_BIPOLAR] = {-21000000, 21000000},
> +};
> +
> +static const int pac1711_vsense_range_tbl[][2] = {
> +	[PAC1711_FULL_RANGE_UNIPOLAR] = {0, 100000},
> +	[PAC1711_FULL_RANGE_BIPOLAR] = {-100000, 100000},
> +	[PAC1711_HALF_RANGE_BIPOLAR] = {-50000, 50000},
Spacing convention in IIO that we are slowly moving old code to as
well is space after { and before }

> +};
> +
> +enum pac1711_samps {
> +	PAC1711_SAMP_8192SPS,
Given I think these map to register values in the hardware,
I'd prefer to see them assigned values = 0, etc
Same for all similar cases.


> +	PAC1711_SAMP_4096SPS,
> +	PAC1711_SAMP_1024SPS,
> +	PAC1711_SAMP_256SPS,
> +	PAC1711_SAMP_64SPS,
> +	PAC1711_SAMP_8SPS,
> +};
> +
> +static const unsigned int pac1711_samp_rate_map_tbl[] = {
> +	[PAC1711_SAMP_8192SPS] = 8192,
> +	[PAC1711_SAMP_4096SPS] = 4096,
> +	[PAC1711_SAMP_1024SPS] = 1024, // default

With read_avail() callback you should be able to use this array
to provide the information.

> +	[PAC1711_SAMP_256SPS] = 256,
> +	[PAC1711_SAMP_64SPS] = 64,
> +	[PAC1711_SAMP_8SPS] = 8,
> +};
> +
> +static const unsigned int pac1711_shift_map_tbl[] = {

Add a comment on what this is.

> +	[PAC1711_SAMP_8192SPS] = 13,
> +	[PAC1711_SAMP_4096SPS] = 12,
> +	[PAC1711_SAMP_1024SPS] = 10,
> +	[PAC1711_SAMP_256SPS] = 8,
> +	[PAC1711_SAMP_64SPS] = 6,
> +	[PAC1711_SAMP_8SPS] = 3,
> +};
> +
> +/* Available Sample Modes */
> +static const char * const pac1711_frequency_avail[] = {
> +	"8192",
> +	"4096",
> +	"1024",
> +	"256",
> +	"64",
> +	"8",
> +};
> +
> +/**
> + * struct pac1711_features - features of a pac1711 instance
#
I mention it below. We don't normally do this until we have multiple
chips supported.  So I'd rip it out for now and put the values inline.

> + * @prod_id: hardware ID
> + * @name: chip's name
> + */
> +struct pac1711_features {
> +	u8 prod_id;
> +	const char *name;
> +};
> +
> +static const struct pac1711_features pac1711_chip_features = {
> +	.name = "pac1711",
> +	.prod_id = PAC_PRODUCT_ID_1711,
> +};
> +
> +/**
> + * struct reg_data - data from the registers
> + * @meas_regs:		snapshot of raw measurements registers
> + * @jiffies_tstamp:	timestamp
> + * @total_samples_nr:	total number of samples
> + * @ctrl_act_reg:	the ctrl_act register
> + * @ctrl_lat_reg:	the ctrl_lat register
> + * @vsense_avg:		averages of vsense registers
> + * @acc_count:		the acc_count register
> + * @vbus_avg:		averages of vbus registers
> + * @acc_val:		accumulated values per second
> + * @vpower:		vpower registers
> + * @vsense:		vsense registers
> + * @vacc:		accumulated vpower value
> + * @vbus:		vbus registers
> + */
> +struct reg_data {
> +	u8	meas_regs[PAC1711_MEAS_REG_SNAPSHOT_LEN];
> +	unsigned long jiffies_tstamp;
> +	u32	total_samples_nr;
> +	u16	ctrl_act_reg;
> +	u16	ctrl_lat_reg;
> +	s32	vsense_avg;
> +	u32	acc_count;
> +	s32	vbus_avg;
> +	s64	acc_val;
> +	s32	vpower;
> +	s32	vsense;
> +	s32	vbus;
> +	s64	vacc;
As below.  Reorder these to improve packing + group related entries.

> +};
> +
> +/**
> + * struct pac1711_chip_info - information about the chip
> + * @accumulation_mode:	accumulation mode for hardware accumulator
> + * @sample_rate_value:	sampling frequency
> + * @work_chip_rfsh:	work queue used for refresh commands
> + * @sampling_mode:	sampling mode used by the device
> + * @chip_reg_data:	chip reg data
> + * @chip_variant:	chip variant
> + * @vsense_mode:	Full Scale Range (FSR) mode for VSense
> + * @enable_acc:		true means that accumulation channel is measured
> + * @vbus_mode:		Full Scale Range (FSR) mode for VBus
> + * @iio_info:		iio_info
> + * @client:		the i2c-client attached to the device
> + * @label:		channel label
> + * @shunt:		shunt resistor value
> + * @lock:		synchronize access to driver's state members
> + */
> +struct pac1711_chip_info {
> +	u8			accumulation_mode;
Don't do reverse xmas tree for structure elements!
The packing looks terrible.
Order them first into logical related groups, then order such that packing
is efficient. Pahole or a glance at rules for packing in C will help with that.

> +	s32			sample_rate_value;
> +	struct delayed_work	work_chip_rfsh;
> +	u8			sampling_mode;
> +	struct reg_data		chip_reg_data;
> +	u8			chip_variant;
> +	u8			vsense_mode;
> +	bool			enable_acc;
> +	u8			vbus_mode;
> +	struct iio_info		iio_info;
> +	struct i2c_client	*client;
> +	char			*label;
> +	u32			shunt;
> +	struct mutex		lock; /* synchronize access to driver's state members */

Be more specific on this comment.  Which members and why.  Is it to keep
them inline with hardware settings, or are there complex things that
need to be done atomically?

> +};
> +
> +static inline u64 pac1711_get_unaligned_be56(u8 *p)
> +{
> +	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
> +		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];

Hmm.  Maybe this one is reasonable to add to the main unaligned function set.
Perhaps not yet as a grep didn't find multiple of this size.


> +}
> +
> +static int pac1711_send_refresh(struct pac1711_chip_info *info, u8 refresh_cmd,
> +				u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
> +	int ret;
> +
> +	/* Writing a REFRESH or a REFRESH_V command */
> +	ret = i2c_smbus_write_byte(client, refresh_cmd);
> +	if (ret) {
> +		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X)\n",
> +			__func__, refresh_cmd);
> +		return ret;
> +	}
> +
> +	/* Register data retrieval timestamp */
> +	info->chip_reg_data.jiffies_tstamp = jiffies;
> +	/* Wait till the data is available */

fsleep() for waits that are fuzzy like this one.
It adds standard level of fuzz and means we don't need to think about what
is appropriate.

> +	usleep_range(wait_time, wait_time + 100);
> +
> +	return 0;
> +}
> +
> +static int pac1711_reg_snapshot(struct pac1711_chip_info *info,
> +				bool do_refresh, u8 refresh_cmd, u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	s64 stored_value, tmp_s64;
> +	u8 *offset_reg_data_p;
> +	u32 count, inc_count;
> +	bool is_bipolar;
> +	s64 inc = 0;
> +	u16 tmp_u16;
> +	u8 shift;
> +	int ret;
> +
> +	guard(mutex)(&info->lock);
> +
> +	if (do_refresh) {
> +		ret = pac1711_send_refresh(info, refresh_cmd, wait_time);
> +		if (ret < 0) {
> +			dev_err(dev, "cannot send refresh\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Read the ctrl/status registers for this snapshot */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_u16);
> +	if (ret < 0) {
> +		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
> +			__func__, PAC1711_CTRL_ACT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	be16_to_cpus(&tmp_u16);
As below. Use a local __be16 to keep the meaning of each local variable cleaner.

> +	info->chip_reg_data.ctrl_act_reg = tmp_u16;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_LAT_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_u16);
> +	if (ret < 0) {
> +		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
> +			__func__, PAC1711_CTRL_LAT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	be16_to_cpus(&tmp_u16);
Same as above.
> +	info->chip_reg_data.ctrl_lat_reg = tmp_u16;
> +
> +	/* Read the data registers */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_ACC_COUNT_REG_ADDR,
> +					    PAC1711_MEAS_REG_SNAPSHOT_LEN,
> +					    (u8 *)info->chip_reg_data.meas_regs);
> +	if (ret < 0) {
> +		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
> +			__func__, PAC1711_ACC_COUNT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	offset_reg_data_p = &info->chip_reg_data.meas_regs[0];
> +	info->chip_reg_data.acc_count = get_unaligned_be32(offset_reg_data_p);
> +	offset_reg_data_p += PAC1711_ACC_REG_LEN;
> +
> +	/* skip if the energy accumulation is disabled */
> +	if (info->enable_acc) {
> +		stored_value = info->chip_reg_data.acc_val;
> +
> +		info->chip_reg_data.vacc = pac1711_get_unaligned_be56(offset_reg_data_p);
> +		is_bipolar = false;
> +
> +		switch (info->accumulation_mode) {
> +		case PAC1711_ACCMODE_VPOWER:
> +			if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR ||
> +			    info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +				is_bipolar = true;
> +			break;
> +		case PAC1711_ACCMODE_VBUS:
> +			if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +				is_bipolar = true;
> +			break;
> +		case PAC1711_ACCMODE_VSENSE:
> +			if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +				is_bipolar = true;
> +			break;
> +		}
> +
> +		if (is_bipolar)
> +			info->chip_reg_data.vacc = sign_extend64(info->chip_reg_data.vacc, 55);
> +
> +		if (info->accumulation_mode != PAC1711_ACCMODE_VBUS) {
> +			/* VACC */
> +			/*
> +			 * Integrate the accumulated power or current over
> +			 * the elapsed interval.
> +			 */
> +			tmp_u16 = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK,
> +					    info->chip_reg_data.ctrl_lat_reg);
> +			tmp_s64 = info->chip_reg_data.vacc;
> +
> +			if (tmp_u16 <= PAC1711_SAMP_8SPS) {
> +				shift = pac1711_shift_map_tbl[tmp_u16];
> +				inc = tmp_s64 >> shift;
> +			} else {
> +				dev_err(dev, "Invalid sample rate index: %d!\n", tmp_u16);
return an error if this happens and give up.  I'm guessing it's not supposed to happen.

> +			}
> +		} else {
> +			count = info->chip_reg_data.total_samples_nr;
> +			inc_count = info->chip_reg_data.acc_count;
> +
> +			/* Check if total number of samples will overflow */
> +			if (check_add_overflow(count, inc_count, &count)) {
> +				dev_err(dev, "Number of samples overflow!\n");
As above. If we get an error condition I'd communicate it up with an error
return value, not just something stashed in the kernel log.
> +				info->chip_reg_data.total_samples_nr = 0;
> +				info->chip_reg_data.acc_val = 0;
> +			}
> +
> +			info->chip_reg_data.total_samples_nr += inc_count;
> +			inc = info->chip_reg_data.vacc;
> +		}
> +
> +		if (check_add_overflow(stored_value, inc, &stored_value)) {
> +			if (is_negative(stored_value))
> +				info->chip_reg_data.acc_val = S64_MIN;
> +			else
> +				info->chip_reg_data.acc_val = S64_MAX;
> +
> +			dev_err(dev, "Overflow detected!\n");

and again. These conditions are not supposed to happen.  Make them
really obvious.

> +		} else {
> +			info->chip_reg_data.acc_val += inc;
> +		}
> +	}
> +
> +	offset_reg_data_p += PAC1711_VACC_REG_LEN;
> +
> +	/* VBUS */
> +	info->chip_reg_data.vbus = get_unaligned_be16(offset_reg_data_p) >> 4;
> +
> +	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vbus = sign_extend32(info->chip_reg_data.vbus, 11);
> +
> +	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
> +
> +	/* VSENSE */
> +	info->chip_reg_data.vsense = get_unaligned_be16(offset_reg_data_p) >> 4;
> +
> +	if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vsense = sign_extend32(info->chip_reg_data.vsense, 11);
> +
> +	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
> +
> +	/* VBUS_AVG */
> +	info->chip_reg_data.vbus_avg = get_unaligned_be16(offset_reg_data_p) >> 4;
> +
> +	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vbus_avg = sign_extend32(info->chip_reg_data.vbus_avg, 11);
> +
> +	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
> +
> +	/* VSENSE_AVG */
> +	info->chip_reg_data.vsense_avg = get_unaligned_be16(offset_reg_data_p) >> 4;
> +
> +	if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vsense_avg = sign_extend32(info->chip_reg_data.vsense_avg, 11);
> +
> +	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
> +
> +	/* VPOWER */
> +	info->chip_reg_data.vpower = get_unaligned_be32(offset_reg_data_p) >> 8;
> +
> +	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR ||
> +	    info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
> +		info->chip_reg_data.vpower = sign_extend32(info->chip_reg_data.vpower, 23);
> +
> +	return 0;
> +}

> +
> +static const struct iio_chan_spec_ext_info pac1711_ext_info[] = {
> +	IIO_ENUM("sampling_frequency", IIO_SHARED_BY_ALL, &sampling_mode_enum),
Use the info_mask_shared_by_all for sampling frequency.

> +	{
> +		.name = "sampling_frequency_available",
read_avail() callback and appropriate mask for this.

we have had core support for generating these attributes for a while now.

> +		.shared = IIO_SHARED_BY_ALL,
> +		.read = iio_enum_available_read,
> +		.private = (uintptr_t)&sampling_mode_enum,
> +	},
> +	{ }
> +};


> +static int pac1711_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	int ret;
> +	u64 tmp;
> +
> +	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = info->chip_reg_data.vbus;
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			*val = info->chip_reg_data.vsense;
> +			return IIO_VAL_INT;
> +		case IIO_POWER:
> +			*val = info->chip_reg_data.vpower;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = info->chip_reg_data.vbus_avg;
Mentioned elsewhere but from practical usecase point of view it is very
rare that rolling average and unaveraged at the same time is actually useful.
Providing the rolling average only  + description of filter parameters
that reflect the boxcar filter usually ends up being the cleaner interface.

If you have a usecase that needs both then we can figure out how to do it
cleanly.

> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			*val = info->chip_reg_data.vsense_avg;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}

...

> +}
> +
> +static int pac1711_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &info->client->dev;
> +	int ret = -EINVAL;

set in all paths that use it so no need to initialize here.

> +	s32 old_samp_rate;
> +	u8 ctrl_reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = pac1711_get_samp_rate_idx(info, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* write the new sampling value and trigger a snapshot */
> +		scoped_guard(mutex, &info->lock) {
> +			ctrl_reg = FIELD_PREP(PAC1711_CTRL_SAMPLE_MODE_MASK, ret);
> +			ret = i2c_smbus_write_byte_data(client, PAC1711_CTRL_REG_ADDR, ctrl_reg);
> +			if (ret) {
> +				dev_err(dev, "%s - can't update sample rate\n", __func__);
> +				return ret;
> +			}
> +		}
> +
> +		old_samp_rate = info->sample_rate_value;
> +		info->sample_rate_value = val;
> +
> +		/*
> +		 * now, force a snapshot with refresh - call retrieve
> +		 * data in order to update the refresh timer
> +		 * alter the timestamp in order to force trigger a
> +		 * register snapshot and a timestamp update
> +		 */
> +		info->chip_reg_data.jiffies_tstamp -= msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS);
> +		ret = pac1711_retrieve_data(info, (1024 / old_samp_rate) * 1000);
> +		if (ret < 0) {
> +			dev_err(dev, "%s - cannot snapshot ctrl and measurement regs\n", __func__);
> +			return ret;
> +		}
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pac1711_read_label(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, char *label)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +
> +	switch (chan->address) {
> +	case PAC1711_VBUS_ADDR:
> +		return sysfs_emit(label, "%s_VBUS\n", info->label);

I'm not sure I see the advantage in the postfixes.  This seems
to be building channel labels from the device label.  If you want
channel labels, provide the channel subnodes and put the label under that.

If you want a device label set indio_dev->label


> +	case PAC1711_VBUS_AVG_ADDR:
> +		return sysfs_emit(label, "%s_VBUS_AVG\n", info->label);

oh goody. Moving averages. These are a pain to support cleanly.  They
sound simple but they overlap too much with more complex forms of
data processing.

Typically a user either wants the smoothed version or the non smoothed
one so we don't necessarily need separate channels. An alternative is
to provide a filter control via the 3dB point of the boxcar filter
that an average is.

> +	case PAC1711_VSENSE_ADDR:
> +		return sysfs_emit(label, "%s_IBUS\n", info->label);
> +	case PAC1711_VSENSE_AVG_ADDR:
> +		return sysfs_emit(label, "%s_IBUS_AVG\n", info->label);
> +	case PAC1711_VPOWER_ADDR:
> +		return sysfs_emit(label, "%s_POWER\n", info->label);
> +	}
> +
> +	return 0;
> +}

> +
> +static int pac1711_chip_identify(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	u8 chip_rev_info[3];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_PID_REG_ADDR,
> +					    sizeof(chip_rev_info), chip_rev_info);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "cannot read product ID reg\n");
> +
> +	info->chip_variant = chip_rev_info[0];
> +	switch (info->chip_variant) {
> +	case PAC_PRODUCT_ID_1711:
> +		indio_dev->name = pac1711_chip_features.name;
> +		break;
return 0 here so we know nothing else to look for after thi.

> +	default:
> +		return dev_err_probe(dev, -EINVAL,
dev_info() / dev_warn() only as we are going to carry on anyway.

> +				     "product ID (0x%02X, 0x%02X, 0x%02X) not recognized\n",
> +				     chip_rev_info[0], chip_rev_info[1], chip_rev_info[2]);
> +	}
> +
> +	return 0;
> +}

> +static int pac1711_setup_vbus_range(struct pac1711_chip_info *info)
> +{
> +	const char *prop_name = "microchip,vbus-input-range-microvolt";
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	unsigned int tbl_len, ret;
> +	s32 vals[2];
> +
> +	/* default value is unipolar and Full Scale Range */
> +	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
> +	if (!ret) {
> +		tbl_len = ARRAY_SIZE(pac1711_vbus_range_tbl);
> +		ret = pac1711_check_range(vals, pac1711_vbus_range_tbl, tbl_len);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL, "Invalid value %d, %d for prop %s\n",
> +					     vals[0], vals[1], prop_name);
> +
> +		info->vbus_mode = ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pac1711_setup_vsense_range(struct pac1711_chip_info *info)
> +{
> +	const char *prop_name = "microchip,vsense-input-range-microvolt";

Either figure out how to generalize this code to share with the function
above, or just put prop_name string inline.  It is a bit marginal
on whether it is worth generalizing.

> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	unsigned int tbl_len, ret;
> +	s32 vals[2];
> +
> +	/* default value is unipolar and Full Scale Range */
> +	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
> +	if (!ret) {
> +		tbl_len = ARRAY_SIZE(pac1711_vsense_range_tbl);
> +		ret = pac1711_check_range(vals, pac1711_vsense_range_tbl, tbl_len);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL, "Invalid value %d, %d for prop %s\n",
> +					     vals[0], vals[1], prop_name);
> +
> +		info->vsense_mode = ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool pac1711_of_parse_channel_config(struct i2c_client *client,
> +					    struct pac1711_chip_info *info)
> +{
> +	struct device *dev = &client->dev;
> +	int ret, temp;
> +
> +	if (device_property_present(dev, "shunt-resistor-micro-ohms")) {
> +		ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &info->shunt);
checking for presence before reading is pointless.
device_property_read_u32() will error out if it isn't there anyway.
The error code will indicate why.

> +		if (ret)
> +			return dev_err_probe(dev, ret, "Write default shunt-resistor value %d\n",
> +					     info->shunt);
> +	} else {
> +		return dev_err_probe(dev, ret, "shunt-resistor property does not exist\n");
> +	}
> +
> +	if (device_property_present(dev, "label")) {
> +		ret = device_property_read_string(dev, "label", (const char **)&info->label);

The cast seems odd here.  Why can't info->label be a const char * ?


> +		if (ret)
> +			return dev_err_probe(dev, ret, "invalid rail-name value\n");
> +	}
> +
> +	ret = pac1711_setup_vbus_range(info);
> +	if (ret)
> +		return ret;
> +
> +	ret = pac1711_setup_vsense_range(info);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_read_u32(dev, "microchip,accumulation-mode", &temp);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "invalid accumulation-mode value %d\n", temp);

As in the dt-binding review. I'm not sure why this needs to be coming from DT.
As above, it's also not clear to me that it is worth supporting some of the modes.

> +
> +	if (temp == PAC1711_ACCMODE_VPOWER || temp == PAC1711_ACCMODE_VSENSE ||
> +	    temp == PAC1711_ACCMODE_VBUS) {
> +		dev_dbg(dev, "Accumulation mode set to: %d\n", temp);
> +		info->accumulation_mode = temp;
> +	} else {
> +		return dev_err_probe(dev, -EINVAL, "invalid accumulation-mode value %d\n", temp);
> +	}
> +
> +	return 0;
> +}
> +
> +static void pac1711_cancel_delayed_work(void *dwork)
> +{
> +	cancel_delayed_work_sync(dwork);
> +}
> +
> +static int pac1711_chip_configure(struct pac1711_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	u32 wait_time;
> +	u16 tmp_u16;
> +	int ret = 0;
> +	u8 tmp_u8;
> +
> +	/* get sampling rate from PAC */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_u16);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot read 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
> +
> +	be16_to_cpus(&tmp_u16);

Avoid messy endian confusion by reading into a __be16 and then
using tmp_u16 = be16_to_cpu(&tmp_be16);

> +	info->sampling_mode = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK, tmp_u16);
> +
> +	/*
> +	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
> +	 * no SLOW triggered REFRESH, clear POR
> +	 */
> +	tmp_u8 = FIELD_PREP(PAC1711_NEG_PWR_CFG_VS_MASK, info->vsense_mode) |
> +		FIELD_PREP(PAC1711_NEG_PWR_CFG_VB_MASK, info->vbus_mode);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1711_NEG_PWR_FSR_REG_ADDR, tmp_u8);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
> +				     PAC1711_NEG_PWR_FSR_REG_ADDR);
> +
> +	tmp_u8 = 0;
Don't bother setting local variable, just pass 0 in directly to the write_byte_data()

> +	ret = i2c_smbus_write_byte_data(client, PAC1711_SLOW_REG_ADDR, tmp_u8);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_SLOW_REG_ADDR);
> +
> +	tmp_u16 = 0;

As above. Avoid mixing what is stored in a variable by adding a __be16 local variable.

> +	cpu_to_be16s(&tmp_u16);
> +
> +	ret = i2c_smbus_write_word_data(client, PAC1711_CTRL_REG_ADDR, tmp_u16);
The documentation for what is supported is a bit vague, but I'm not seeing 
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
> +
> +	/*
> +	 * Sending a REFRESH to the chip, so the new settings take place
> +	 * as well as resetting the accumulators
> +	 */
> +	ret = i2c_smbus_write_byte(client, PAC1711_REFRESH_REG_ADDR);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
> +				     PAC1711_REFRESH_REG_ADDR);
> +
> +	usleep_range(125, 500);
> +
> +	/*
> +	 * Get the current (in the chip) sampling speed and compute the
> +	 * required timeout based on its value the timeout is 1/sampling_speed
> +	 * wait the maximum amount of time to be on the safe side - the
> +	 * maximum wait time is for 8sps
> +	 */
> +	wait_time = (1024 / pac1711_samp_rate_map_tbl[info->sampling_mode]) * 1000;
> +	usleep_range(wait_time, wait_time + 100);
> +
> +	INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1711_work_periodic_rfsh);
> +	/* Setup the latest moment for reading the regs before saturation */
> +	schedule_delayed_work(&info->work_chip_rfsh,
> +			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
> +
> +	return devm_add_action_or_reset(&client->dev, pac1711_cancel_delayed_work,
> +					&info->work_chip_rfsh);
> +}
> +
> +static struct iio_chan_spec pac1711_single_channel[] = {

As below. Clearly not a single channel.

> +	PAC1711_VPOWER_CHANNEL(0, 0, PAC1711_VPOWER_ADDR),
> +	PAC1711_VBUS_CHANNEL(0, 0, PAC1711_VBUS_ADDR),
> +	PAC1711_VSENSE_CHANNEL(0, 0, PAC1711_VSENSE_ADDR),
> +	PAC1711_VBUS_AVG_CHANNEL(0, 0, PAC1711_VBUS_AVG_ADDR),
> +	PAC1711_VSENSE_AVG_CHANNEL(0, 0, PAC1711_VSENSE_AVG_ADDR),
> +};
> +
> +static IIO_DEVICE_ATTR(in_energy_raw, 0444,
> +		       pac1711_in_power_acc_raw_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_energy_scale, 0444,
> +		       pac1711_in_power_acc_scale_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_energy_en, 0644,
> +		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
> +
> +static IIO_DEVICE_ATTR(in_current_acc_raw, 0444,
> +		       pac1711_in_current_acc_raw_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_current_acc_scale, 0444,
> +		       pac1711_in_current_acc_scale_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_current_acc_en, 0644,
> +		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
> +
> +static IIO_DEVICE_ATTR(in_voltage_acc_raw, 0444,
> +		       pac1711_in_voltage_acc_raw_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_voltage_acc_scale, 0444,
> +		      pac1711_in_voltage_acc_scale_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_voltage_acc_en, 0644,
> +		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
> +
> +static struct attribute *pac1711_power_acc_attr[] = {
> +	PAC1711_DEV_ATTR(in_energy_raw),
> +	PAC1711_DEV_ATTR(in_energy_scale),
> +	PAC1711_DEV_ATTR(in_energy_en),
> +	NULL
> +};
> +
> +static struct attribute *pac1711_current_acc_attr[] = {
> +	PAC1711_DEV_ATTR(in_current_acc_raw),
> +	PAC1711_DEV_ATTR(in_current_acc_scale),
> +	PAC1711_DEV_ATTR(in_current_acc_en),
> +	NULL
> +};
> +
> +static struct attribute *pac1711_voltage_acc_attr[] = {
> +	PAC1711_DEV_ATTR(in_voltage_acc_raw),
> +	PAC1711_DEV_ATTR(in_voltage_acc_scale),
> +	PAC1711_DEV_ATTR(in_voltage_acc_en),

If these did make sense (see other comments) then they should be
done as ext_info for the given channels rather than going though
the complexity of custom attributes.

Custom attributes make most sense when not associated with any channels.
A lot of drivers have them for historical reasons as well that we haven't
yet cleaned up.

Even in_shunt_resistor is can be a shared_by_all extended attribute
as it's still associated with a bunch of channels.

> +	NULL
> +};

> +
> +static int pac1711_probe(struct i2c_client *client)
> +{
> +	const struct pac1711_features *chip;
> +	struct device *dev = &client->dev;
> +	struct pac1711_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	int ret, err;

> +
> +	/* always start with accumulation channels enabled */
> +	info->enable_acc = true;
> +	err = pac1711_of_parse_channel_config(client, info);
Should really using generic property.h accessors so name it after
fw rather than of as it applies to other firmware types.

> +	if (err)
> +		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
> +
> +	ret = devm_mutex_init(dev, &info->lock);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * do now any chip specific initialization (e.g. read/write
> +	 * some registers), enable/disable certain channels, change the sampling
> +	 * rate to the requested value
I don't think this comment adds much.  The name makes it clear it's
configuring the chip and if anyone cares what that involves they can go look.
So I'd drop it.

> +	 */
> +	ret = pac1711_chip_configure(info);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* prepare the channel information */
Likewise. Comment is too obvious to be needed.  
> +	indio_dev->num_channels = ARRAY_SIZE(pac1711_single_channel);
> +	indio_dev->channels = pac1711_single_channel;
Single channel?  That seems unlikely naming for an array of several channels. Rename it.
pac1711_channels probably.

> +	info->iio_info = pac1711_info;
> +	indio_dev->info = &info->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = pac1711_prep_custom_attributes(info, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Can't configure custom attributes for PAC1711 device\n");
> +
> +	/*
> +	 * read whatever has been accumulated in the chip so far
> +	 * and reset the accumulators
> +	 */
> +	ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
> +				   PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Can't register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id pac1711_id[] = {
> +	{ .name = "pac1711", .driver_data = (kernel_ulong_t)&pac1711_chip_features },

Normally we only introduce the use of driver data in a series that adds a second supported
part.  Otherwise we end up carrying complexity that may never be used.

If you already have code adding a second part then say that in the patch description
as a justification for having this flexibility from the first.

> +	{}
As below.

> +};
> +MODULE_DEVICE_TABLE(i2c, pac1711_id);
> +
> +static const struct of_device_id pac1711_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1711",
> +		.data = &pac1711_chip_features
> +	},
> +	{}

For IIO at least I'm pushing to standardize on formatting these as
	{ }
It was a random choice a while back as we had about half each way.

> +};



