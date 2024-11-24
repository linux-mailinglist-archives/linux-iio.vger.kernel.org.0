Return-Path: <linux-iio+bounces-12618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D779D7848
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 22:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96292819D0
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71357155A2F;
	Sun, 24 Nov 2024 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncumnmXW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6C2500C4;
	Sun, 24 Nov 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732482952; cv=none; b=Z1X4n/WBJmD/1lBSW3Uxrc2uV02hHnVG1YkZfJWn98eE5rJuCJ3a0FNn8inmlnrOJCls6Kx0kDvHVFKBRvZzsW82SlyjPtjrGT6j+mkurS6d82NCFvCJFL4agxD+TKaer2738UVlGH5XayJT+awvrWyrQR/mzWwncyqDZlzc2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732482952; c=relaxed/simple;
	bh=RUjFC7heXDe52hzIrA3qiLOF0F2jKmK9aRSywkoem0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikUrJcHW1ksdSzwb+dT8t403GQcq1Ejs0G5BpyI2PxJdnbjlVjX1nog14f3d97nfo1dO1egXLamV8fonDcE/tgnmDx2kJbShSKLw04nVMUhvGprYkO0ZmSIZuHJ1BsHeBAwBUVLcmQpqWjNeqGNqEDxmqliN6a94i5jA9vK4aCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncumnmXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760A8C4CECC;
	Sun, 24 Nov 2024 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732482951;
	bh=RUjFC7heXDe52hzIrA3qiLOF0F2jKmK9aRSywkoem0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncumnmXWkMw79V+EK5djYAIaot8Ox1vFgIQO2A2WnWgrvgDH7GWfhXma+u+yEvr4z
	 qgFRLNj7yGl2tn2CmqBqnU8qnxPZ+hMEWBb5JgTCbMvtxEgAJqG3hyLmTJPO3kxrCy
	 gx6uzgzC7sRCd4T4TkKUX6CWg2TnN5k8Ia/mTZVUBZrYjy5NEmPOOoiOKgdp6rmK0T
	 2dNsADJqj0XiszBjDaMq64/p1ZEVlqxqYDS3Rxxa1Vi3u0n7+Wg1DGPNCd1IVzXSQ+
	 8IQurq4Ugv+vNmsNkn3ILt6krn+TmqJCX/WWXi2PCpILxfCVXhBO4Blf+O1YvWgvo3
	 gwmZSBrntEJhA==
Date: Sun, 24 Nov 2024 21:15:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Cc: mgonellabolduc@dimonoff.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <20241124211545.194a9f87@jic23-huawei>
In-Reply-To: <20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
	<20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 15:36:57 -0500
Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:

> From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> 
> APDS9160 is a combination of ALS and proximity sensors.
> 
> This patch add supports for:
>     - Intensity clear data and illuminance data
>     - Proximity data
>     - Gain control, rate control
>     - Event thresholds
> 
> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Hi Mikael,

I may well repeat things you have already from the other reviewers!

Various comments inline.  Big one is that you register a buffer
but no channels to be captured and never push any data to it.
That looks like a workaround for something else?

Jonathan



> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index f2f3e414849ab12a7c0ea2b08e9a3310eb18ebb7..69a59c6759acea89241ab76bfcdfafe3e5824066 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -63,6 +63,19 @@ config AL3320A
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called al3320a.
>  
> +config APDS9160
> +	tristate "APDS9160 combined als and proximity sensors"
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
Normally I'd expect a light sensor to be providing a triggered buffer
rather than using the kfifo path directly.

Also you never push anything into the buffer.

Normally we only skip the trigger (which allows other signals to be used
to start a scan of the channels, or this trigger to capture on other sensors)
if there is a hardware buffer involved so we can't identify each individual
scan of the channels.

As it turns out you aren't doing buffered capture at all.

> +	depends on I2C
> +	help
> +	   Say Y here if you want to build a driver for Broadcom APDS9160
> +	   combined ambient light and proximity sensor chip.
> +
> +	   To compile this driver as a module, choose M here: the
> +	   module will be called apds9160. If unsure, say N here.
> +

> diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..cb855f20725dba9fea1390a955889d905fd7eb4f
> --- /dev/null
> +++ b/drivers/iio/light/apds9160.c
> @@ -0,0 +1,1420 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * This file is part of the APDS9160 sensor driver.
> + * Chip is combined proximity and ambient light sensor.
> + * Author: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
Why?
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define APDS9160_DRIVER_NAME "apds9160"
> +#define APDS9160_REGMAP_NAME "apds9160_regmap"
> +#define APDS9160_STARTUP_DELAY 25000 /* us */
> +#define APDS9160_REG_CNT 37
> +
> +/** Main control register */
> +#define APDS9160_REG_CTRL 0x00
> +#define APDS9160_REG_CTRL_SWRESET BIT(4) /* 1: Activate reset */
> +#define APDS9160_REG_CTRL_MODE_RGB BIT(2) /* 0: ALS & IR, 1: RGB & IR */
> +#define APDS9160_REG_CTRL_EN_ALS BIT(1) /* 1: ALS active */
> +#define APDS9160_REG_CTLR_EN_PS BIT(0) /* 1: PS active */
> +
> +/** Status register  */
Run kernel-doc over the file and fix everything. This is not
kernel-doc so should not have /**

> +#define APDS9160_REG_SR_LS_INT BIT(3)
> +#define APDS9160_REG_SR_LS_NEW_DATA BIT(2)
> +#define APDS9160_REG_SR_PS_INT BIT(1)
> +#define APDS9160_REG_SR_PS_NEW_DATA BIT(0)
> +
> +/* Interrupt configuration register */
> +#define APDS9160_REG_INT_CFG 0x19
> +#define APDS9160_REG_INT_CFG_EN_LS BIT(2) /* LS int enable */
> +#define APDS9160_REG_INT_CFG_EN_PS BIT(0) /* PS int enable */
> +#define APDS9160_REG_INT_PST 0x1A
> +
> +/* Proximity registers */
> +#define APDS9160_REG_PS_LED 0x01
> +#define APDS9160_REG_PS_PULSES 0x02
> +#define APDS9160_REG_PS_MEAS_RATE 0x03
> +#define APDS9160_REG_PS_THRES_HI_LSB 0x1B
> +#define APDS9160_REG_PS_THRES_HI_MSB 0x1C
> +#define APDS9160_REG_PS_THRES_LO_LSB 0x1D
> +#define APDS9160_REG_PS_THRES_LO_MSB 0x1E
> +#define APDS9160_REG_PS_DATA_LSB 0x08
> +#define APDS9160_REG_PS_DATA_MSB 0x09
> +#define APDS9160_REG_PS_CAN_LEVEL_DIG_LSB 0x1F
> +#define APDS9160_REG_PS_CAN_LEVEL_DIG_MSB 0x20
> +#define APDS9160_REG_PS_CAN_LEVEL_ANA_DUR 0x21
> +#define APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT 0x22
> +
> +/* Light sensor registers */
> +#define APDS9160_REG_LS_MEAS_RATE 0x04
> +#define APDS9160_REG_LS_GAIN 0x05
> +#define APDS9160_REG_LS_DATA_CLEAR_LSB 0x0A
> +#define APDS9160_REG_LS_DATA_CLEAR 0x0B
> +#define APDS9160_REG_LS_DATA_CLEAR_MSB 0x0C
> +#define APDS9160_REG_LS_DATA_ALS_LSB 0x0D
> +#define APDS9160_REG_LS_DATA_ALS 0x0E
> +#define APDS9160_REG_LS_DATA_ALS_MSB 0x0F
> +#define APDS9160_REG_LS_THRES_UP_LSB 0x24
> +#define APDS9160_REG_LS_THRES_UP 0x25
> +#define APDS9160_REG_LS_THRES_UP_MSB 0x26
> +#define APDS9160_REG_LS_THRES_LO_LSB 0x27
> +#define APDS9160_REG_LS_THRES_LO 0x28
> +#define APDS9160_REG_LS_THRES_LO_MSB 0x29
> +#define APDS9160_REG_LS_THRES_VAR 0x2A
> +
> +/** Part identification number register */
> +#define APDS9160_REG_ID 0x06
> +
> +/** Status register */
> +#define APDS9160_REG_SR 0x07
> +#define APDS9160_REG_SR_DATA_ALS BIT(3)

One trick to make it obvious what is a field and what
a register is don't include the _REG bit in
the field defines.

> +#define APDS9160_REG_SR_DATA_PS BIT(0)
> +
> +/* Supported ID:s */
> +#define APDS9160_PART_ID_0 0x00
> +#define APDS9160_PART_ID_MASK 0xF0
> +#define APDS9160_PART_REV_MASK 0x0F
> +
> +#define APDS9160_PS_THRES_MAX 0x7FF
> +#define APDS9160_LS_THRES_MAX 0xFFFFF
> +#define APDS9160_CMD_LS_RESOLUTION_25MS 0x04
> +#define APDS9160_CMD_LS_RESOLUTION_50MS 0x03
> +#define APDS9160_CMD_LS_RESOLUTION_100MS 0x02
> +#define APDS9160_CMD_LS_RESOLUTION_200MS 0x01
> +#define APDS9160_PS_DATA_MASK 0x7FF
> +
> +#define APDS9160_DEFAULT_LS_GAIN 3
> +#define APDS9160_DEFAULT_LS_RATE 100
> +#define APDS9160_DEFAULT_PS_RATE 100
> +#define APDS9160_DEFAULT_PS_CANCELLATION_LEVEL 0
> +#define APDS9160_DEFAULT_PS_ANALOG_CANCELLATION 0
> +#define APDS9160_DEFAULT_PS_GAIN 1
> +#define APDS9160_DEFAULT_PS_CURRENT 100
> +#define APDS9160_DEFAULT_PS_RESOLUTION 0x03 // 11 bits
Name so that it is obvious it is the value for 11 bits.

> +
> +// clang-format off
> +static const struct reg_default apds9160_reg_defaults[] = {
you can explicitly tell regmap to write these to the device. That will save
a bunch of init code.

> +	{ APDS9160_REG_CTRL, 0x00 }, /* Sensors disabled by default  */
> +	{ APDS9160_REG_PS_LED, 0x33 }, /* 60 kHz frequency, 100 mA pulse current */
> +	{ APDS9160_REG_PS_PULSES, 0x08 }, /* 8 pulses */
> +	{ APDS9160_REG_PS_MEAS_RATE, 0x05 },
> +	{ APDS9160_REG_LS_MEAS_RATE, 0x22 },
> +	{ APDS9160_REG_LS_GAIN, 0x01 },
> +	{ APDS9160_REG_INT_CFG, 0x10 },
> +	{ APDS9160_REG_INT_PST, 0x00 },
> +	{ APDS9160_REG_PS_THRES_HI_LSB, 0xFF },
> +	{ APDS9160_REG_PS_THRES_HI_MSB, 0x07 },
> +	{ APDS9160_REG_PS_THRES_LO_LSB, 0x00 },
> +	{ APDS9160_REG_PS_THRES_LO_MSB, 0x00 },
> +	{ APDS9160_REG_PS_CAN_LEVEL_DIG_LSB, 0x00 },
> +	{ APDS9160_REG_PS_CAN_LEVEL_DIG_MSB, 0x00 },
> +	{ APDS9160_REG_PS_CAN_LEVEL_ANA_DUR, 0x00 },
> +	{ APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT, 0x00 },
> +	{ APDS9160_REG_LS_THRES_UP_LSB, 0xFF },
> +	{ APDS9160_REG_LS_THRES_UP, 0xFF },
> +	{ APDS9160_REG_LS_THRES_UP_MSB, 0x0F },
> +	{ APDS9160_REG_LS_THRES_LO_LSB, 0x00 },
> +	{ APDS9160_REG_LS_THRES_LO, 0x00 },
> +	{ APDS9160_REG_LS_THRES_LO_MSB, 0x00 },
> +	{ APDS9160_REG_LS_THRES_VAR, 0x00 },
> +};
> +// clang-format on

> +
> +static const struct iio_event_spec apds9160_ps_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
Given they are the same, why not use same event_spec array for als and ps.

> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_event_spec apds9160_als_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
Explicitly set DIR_EITHER here.  It's not a completely obvious default
> +		.type = IIO_EV_TYPE_THRESH,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec apds9160_channels[] = {
> +	{
> +		/* Proximity sensor channel */
> +		.type = IIO_PROXIMITY,
> +		.address = APDS9160_REG_PS_DATA_LSB,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					    BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +					    BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> +					    BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.channel = 0,
> +		.indexed = 0,
> +		.scan_index = -1,
No need to set scan_index if you don't register a buffer (which you shouldn't
without more work and these having actual values).
> +
> +		.event_spec = apds9160_ps_event_spec,
> +		.num_event_specs = ARRAY_SIZE(apds9160_ps_event_spec),
> +	},
> +	{
> +		/* Proximity sensor led current */
> +		.type = IIO_CURRENT,
> +		.output = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_index = -1,
> +	},
> +	{
> +		/* Clear channel */
> +		.type = IIO_INTENSITY,
> +		.address = APDS9160_REG_LS_DATA_CLEAR_LSB,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					    BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> +					    BIT(IIO_CHAN_INFO_SCALE),
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.modified = 1,
> +		.scan_index = -1,
> +
> +		.event_spec = apds9160_als_event_spec,
> +		.num_event_specs = ARRAY_SIZE(apds9160_als_event_spec),
> +	},
> +	{
> +		/* Illuminance */
> +		.type = IIO_LIGHT,
> +		.address = APDS9160_REG_LS_DATA_ALS_LSB,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = -1,
> +	}
> +};
> +
> +/* Attributes */
> +// clang-format off
> +static const int apds9160_als_rate_map[][2] = {
> +	{ 25, 0x00 },
> +	{ 50, 0x01 },
> +	{ 100, 0x02 },
> +	{ 200, 0x03 }
> +};
> +
> +static const int apds9160_als_gain_map[][2] = {
> +	{ 1, 0x00 },
> +	{ 3, 0x01 },
> +	{ 6, 0x02 },
> +	{ 18, 0x03 },
> +	{ 64, 0x04 }
> +};
> +
> +static const int apds9160_ps_gain_map[][2] = {
> +	{ 1, 0x00 },
> +	{ 2, 0x01},
> +	{ 4, 0x02},
> +	{ 8, 0x03}
Make spacing consistent throughout. Same as first
line here looks good.

> +};
> +
> +static const int apds9160_ps_rate_map[][2] = {
> +	{ 25, 0x03 },
> +	{ 50, 0x04 },
> +	{ 100, 0x05 },
> +	{ 200, 0x06 },
> +	{ 400, 0x07 }
> +};
> +
> +static const int adps9160_ps_led_current_map[][2] = {
> +	{ 10, 0x00 },
> +	{ 25, 0x01 },
> +	{ 50, 0x02 },
> +	{ 100, 0x03 },
> +	{ 150, 0x04},
> +	{ 175, 0x05 },
> +	{ 200, 0x06 }
Add trailing commas. In theory we might have more values to add
(though very unlikely).
> +};
> +// clang-format on
No to these Just ignore what clang-format tries to do.
It should be treated as hints, not rules for kernel code.
> +
> +struct apds9160_scale {
> +	int itime;
> +	int gain;
> +	int scale1;
> +	int scale2;
> +};
> +
> +static const struct apds9160_scale apds9160_als_scale_map[] = {
> +	{
> +		.gain = 1,
> +		.itime = 25,
> +		.scale1 = 3272,
> +		.scale2 = 1000,

No way to compute scale from gain and itime?  If not I'm not sure
if we can use the gts helpers.

> +	},
> +	{
> +		.gain = 1,
> +		.itime = 50,
> +		.scale1 = 1639,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 1,
> +		.itime = 100,
> +		.scale1 = 819,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 3,
> +		.itime = 25,
> +		.scale1 = 1077,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 3,
> +		.itime = 50,
> +		.scale1 = 538,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 3,
> +		.itime = 100,
> +		.scale1 = 269,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 6,
> +		.itime = 25,
> +		.scale1 = 525,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 6,
> +		.itime = 50,
> +		.scale1 = 263,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 6,
> +		.itime = 100,
> +		.scale1 = 131,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 18,
> +		.itime = 25,
> +		.scale1 = 169,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 18,
> +		.itime = 50,
> +		.scale1 = 84,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 18,
> +		.itime = 100,
> +		.scale1 = 42,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 64,
> +		.itime = 25,
> +		.scale1 = 49,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 64,
> +		.itime = 50,
> +		.scale1 = 25,
> +		.scale2 = 1000,
> +	},
> +	{
> +		.gain = 64,
> +		.itime = 100,
> +		.scale1 = 12,
> +		.scale2 = 1000,
> +	},
> +};
> +
> +static IIO_CONST_ATTR(in_intensity_integration_time_available, "25 50 100 200");
> +static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
> +		      "25 50 100 200 400");
> +static IIO_CONST_ATTR(in_intensity_hardwaregain_available, "1 3 6 18 64");
> +static IIO_CONST_ATTR(in_proximity_hardwaregain_available, "1 2 4 8");
> +static IIO_CONST_ATTR(out_current_available, "10 25 50 100 150 175 200");
Use read_avail and appropriate masks. 

Whilst we used to do it with explicit attributes for modern drivers we like
to make the data available to in kernel users and ensure there is only one
source of the values by using the same arrays for matching write values.

> +
> +static struct attribute *apds9160_attributes[] = {
> +	&iio_const_attr_in_intensity_integration_time_available.dev_attr.attr,
> +	&iio_const_attr_in_intensity_hardwaregain_available.dev_attr.attr,
> +	&iio_const_attr_in_proximity_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_proximity_hardwaregain_available.dev_attr.attr,
> +	&iio_const_attr_out_current_available.dev_attr.attr,
> +	NULL,
No comma on NULL terminators. However, no reason any of these should
need to be handled with custom attributes.

> +};
> +
> +
> +struct apds9160_chip {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
That sets alarm bells off. If you ever need to go from
iio_priv() to struct iio_dev then you almost certainly need to rethink your
design.  Thankfully I think you only ever set this.  Drop it.

> +	struct regmap *regmap;
> +	struct mutex lock; /* avoid parallel access */
You already have feedback on this comment so I won't add anything.

> +
> +	struct regmap_field *reg_enable_ps;
> +	struct regmap_field *reg_enable_als;
> +	struct regmap_field *reg_int_ps;
> +	struct regmap_field *reg_int_als;
> +	struct regmap_field *reg_ps_overflow;
> +	struct regmap_field *reg_als_rate;
> +	struct regmap_field *reg_als_resolution;
> +	struct regmap_field *reg_ps_rate;
> +	struct regmap_field *reg_als_gain;
> +	struct regmap_field *reg_ps_current;
> +	struct regmap_field *reg_ps_gain;
> +	struct regmap_field *reg_ps_resolution;
> +
> +	/* State data */
> +	u8 revision;
> +	int als_int;
> +	int ps_int;
> +
> +	/* Configuration values */
> +	int als_itime;
These are all caches of register values. Maybe simpler to just enable the regmap
cache and read them back form the cached versions of the hardware registers.
> +	int als_hwgain;
> +	int als_scale1;
> +	int als_scale2;
> +	int ps_rate;
> +	int ps_cancellation_level;
> +	int ps_cancellation_analog;
> +	int ps_current;
> +	int ps_gain;
> +};
> +
> +static const struct i2c_device_id apds9160_id[] = { { APDS9160_DRIVER_NAME, 0 },
> +						    {} };
Move this down to just before where it is used.
Also, just hard code the string. It is much easier to grep for then as no reason
the name in the device id should match the driver name.

> +
> +/** Called when mutex is locked */
Not kernel doc so /* only.
> +static void apds9160_set_scale(struct apds9160_chip *data)
> +{
> +	for (int idx = 0; idx < ARRAY_SIZE(apds9160_als_scale_map); idx++) {
> +		if (data->als_hwgain == apds9160_als_scale_map[idx].gain &&
> +		    data->als_itime == apds9160_als_scale_map[idx].itime) {
> +			data->als_scale1 = apds9160_als_scale_map[idx].scale1;
> +			data->als_scale2 = apds9160_als_scale_map[idx].scale2;
> +		}
> +	}
> +}


> +/**
> + * This parameter determines the cancellation pulse duration in each of the PWM pulse.
> + * The cancellation is applied during the integration phase of the PS measurement.
> + * Duration is programmed in half clock cycles
This is unusual. and I don't really understand how it works.
> + */
> +static int apds9160_set_ps_analog_cancellation(struct apds9160_chip *data,
> +					       int val)
> +{
> +	int ret = -EINVAL;
overwritten in all paths where it is used.
> +
> +	dev_dbg(&data->client->dev, "%s - set analog cancellation to %i\n",
> +		__func__, val);
> +	if (val < 0 || val > 0x3F)
> +		return ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_DUR,
> +			   val);
> +	if (!ret)
Always keep error paths out of line.  It just makes things more consistent
and hence easier to review.

The cleanup.h magic like guard() can help a lot with keeping code simple when
doing early returns.

> +		data->ps_cancellation_analog = val;
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/**
Not kernel doc so /* only.
> + * Set the proximity sensor led current
> + */
> +static int apds9160_set_ps_current(struct apds9160_chip *data, int val)
> +{
> +	int ret = -EINVAL;
> +	int idx;
> +
> +	dev_dbg(&data->client->dev, "%s - set current to %i\n", __func__, val);
> +	for (idx = 0; idx < ARRAY_SIZE(adps9160_ps_led_current_map); idx++) {
> +		if (adps9160_ps_led_current_map[idx][0] == val) {
> +			mutex_lock(&data->lock);
I'd suggest changes similar to what I said for the next function
> +			ret = regmap_field_write(
> +				data->reg_ps_current,
> +				adps9160_ps_led_current_map[idx][1]);
> +
> +			if (!ret)
> +				data->ps_current = val;
> +
> +			mutex_unlock(&data->lock);
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int apds9160_set_als_gain(struct apds9160_chip *data, int val)
> +{
> +	int ret = -EINVAL;
> +	int idx;
> +
> +	dev_dbg(&data->client->dev, "%s - set als gain to %i\n", __func__, val);
> +	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_gain_map); idx++) {
> +		if (apds9160_als_gain_map[idx][0] == val) {

Flip this to reduce indent and give more readable code.

		if (apds9160_als_gain_map[idx][0] != val)
			continue;


> +			mutex_lock(&data->lock);
guard(mutex)(&data-<lock).
> +			ret = regmap_field_write(data->reg_als_gain,
> +						 apds9160_als_gain_map[idx][1]);
			if (ret)
				return ret;
			data->als_hwgain = val...

> +			if (!ret) {
> +				data->als_hwgain = val;
> +				apds9160_set_scale(data);
> +			}
> +			mutex_unlock(&data->lock);
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int apds9160_set_als_int_time(struct apds9160_chip *data, int val)
> +{
> +	int ret = -EINVAL;
> +	int idx;
> +
> +	dev_dbg(&data->client->dev, "%s - set int time to %i\n", __func__, val);
> +	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_rate_map); idx++) {
> +		if (apds9160_als_rate_map[idx][0] == val) {
Flip logic and use a continue to reduce indent for what follows (see example below).

> +			mutex_lock(&data->lock);
guard(mutex)(&data->lock);

> +			ret = regmap_field_write(data->reg_als_rate,
> +						 apds9160_als_rate_map[idx][1]);
> +			if (!ret) {
			if (ret)
				return ret;

			data->als_itime = val;
			
				
> +				data->als_itime = val;
> +				/* Lower resolution for faster rates */
> +				switch (val) {
> +				case 25:
> +					ret = regmap_field_write(
> +						data->reg_als_resolution,
> +						APDS9160_CMD_LS_RESOLUTION_25MS);
> +					break;
> +				case 50:
> +					ret = regmap_field_write(
> +						data->reg_als_resolution,
> +						APDS9160_CMD_LS_RESOLUTION_50MS);
> +					break;
> +				case 200:
> +					ret = regmap_field_write(
> +						data->reg_als_resolution,
> +						APDS9160_CMD_LS_RESOLUTION_200MS);
> +					break;
> +				default:
> +					ret = regmap_field_write(
> +						data->reg_als_resolution,
> +						APDS9160_CMD_LS_RESOLUTION_100MS);
> +				}
> +				apds9160_set_scale(data);
> +			}
> +			mutex_unlock(&data->lock);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int apds9160_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY: {
> +			__le16 buf;
> +
> +			ret = regmap_bulk_read(data->regmap, chan->address,
> +					       &buf, 2);
Should be a dma safe buffer for any bulk accesses.
> +			if (!ret) {
Flip logic to return in error path.
			if (ret)
				return ret;

			*val = le16_to_cpu(buf);
			*val = FIELD_GET() for what you want, not masking what you don't.

> +				ret = IIO_VAL_INT;
> +				*val = le16_to_cpu(buf);
> +				// Remove data overflow and ambient light overflow bits from result

/* */

> +				*val &= APDS9160_PS_DATA_MASK;
> +			}
> +		} break;
> +		case IIO_LIGHT:
> +		case IIO_INTENSITY: {
> +			__le32 buf = 0;
> +
> +			ret = regmap_bulk_read(data->regmap, chan->address,
> +					       &buf, 3);
as below. Use a u8 [3]  and get_unaligned_le24()

> +			if (!ret) {
> +				ret = IIO_VAL_INT;
> +				*val = le32_to_cpu(buf);
> +			}
> +		} break;
> +		case IIO_CURRENT: {
{} not needed.
> +			ret = IIO_VAL_INT;
> +			*val = data->ps_current;
> +		} break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
As for the write, this is unlikely to be the right interface
but I'm not 100% sure what the various gain related controls
are affecting.  I haven't dog into the datasheet yet and
won't get time today.

> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			ret = IIO_VAL_INT;
> +			*val = data->als_hwgain;
> +			break;
> +		case IIO_PROXIMITY:
> +			ret = IIO_VAL_INT;
> +			*val = data->ps_gain;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			ret = IIO_VAL_INT;
> +			*val = data->als_itime;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = IIO_VAL_INT;
> +			*val = data->ps_rate;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = IIO_VAL_INT;
> +			*val = data->ps_cancellation_level;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = IIO_VAL_INT;
> +			*val = data->ps_cancellation_analog;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +		case IIO_INTENSITY:
> +			ret = IIO_VAL_FRACTIONAL;
> +			*val = data->als_scale1;
> +			*val2 = data->als_scale2;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +};
> +
> +static int apds9160_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			return apds9160_set_als_int_time(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return apds9160_set_ps_rate(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_HARDWAREGAIN:

This is rarely used unless for time of flight sensors.  That is where
you are controlling the gain on something not directly related to the
signal you are reading. Here if it affects the read out value such that
_raw * _scale should include it then use _scale, otherwise should be
incorporated in calibscale. 

If it is _scale then the code will be fiddly but you need to present
the scales that are appropriate for the current integration time.

It may be worth looking at the GTS helpers that assist with cases
where there are complex controls interacting around gain of the
sensor.

> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_INTENSITY:
> +			return apds9160_set_als_gain(data, val);
> +		case IIO_PROXIMITY:
> +			return apds9160_set_ps_gain(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return apds9160_set_ps_cancellation_level(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return apds9160_set_ps_analog_cancellation(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_RAW:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			return apds9160_set_ps_current(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int apds9160_get_thres_reg(const struct iio_chan_spec *chan,
> +					 enum iio_event_direction dir, u8 *reg)
> +{
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			*reg = APDS9160_REG_PS_THRES_HI_LSB;
> +			break;
> +		case IIO_INTENSITY:
> +			*reg = APDS9160_REG_LS_THRES_UP_LSB;
> +			break;
return from these rather than breaking.
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
Then this won't be reachable.
> +	case IIO_EV_DIR_FALLING:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			*reg = APDS9160_REG_PS_THRES_LO_LSB;
> +			break;
> +		case IIO_INTENSITY:
> +			*reg = APDS9160_REG_LS_THRES_LO_LSB;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
And neither will this.
> +
> +	return 0;
> +}
> +
> +static int apds9160_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int *val, int *val2)
> +{
> +	u8 reg;
> +
> +	int ret = 0;
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	ret = apds9160_get_thres_reg(chan, dir, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (chan->type == IIO_PROXIMITY) {

Probably clearer as a switch.

> +		__le16 buf;
> +
> +		ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
> +		if (ret < 0)
> +			return ret;
> +		*val = le16_to_cpu(buf);
> +	} else if (chan->type == IIO_INTENSITY) {
> +		__le32 buf = 0;
> +
> +		ret = regmap_bulk_read(data->regmap, reg, &buf, 3);

It's not an __le32 if you are reading only 3 bytes. Use a u8 [3]
and get_unaligned_le24()

> +		if (ret < 0)
> +			return ret;
> +		*val = le32_to_cpu(buf);
> +	} else
> +		return -EINVAL;
> +
> +	*val2 = 0;
No need to set if returning IIO_VAL_INT as won't be used.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int apds9160_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info, int val, int val2)
> +{
> +	u8 reg;
> +	int ret = 0;
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	ret = apds9160_get_thres_reg(chan, dir, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (chan->type == IIO_PROXIMITY) {
> +		if (val < 0 || val > APDS9160_PS_THRES_MAX)
> +			return -EINVAL;
> +		__le16 buf;
> +
> +		buf = cpu_to_le16(val);
> +		ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
Needs to be a dma safe buffer.  In practice this probably won't cause
a bug but that is down to subtle internals of regmap and there is
no guarantee that future optimizations won't again require a DMA safe
buffer.  This what the __aligned(IIO_DMA_MINALIGN) stuff is about.

> +		if (ret < 0)
> +			return ret;
> +	} else if (chan->type == IIO_INTENSITY) {
> +		if (val < 0 || val > APDS9160_LS_THRES_MAX)
> +			return -EINVAL;
> +		__le32 buf = 0;

Variables should almost always be declared at top of scope or just put
them at top of function if that is more appropraite.

> +
> +		buf = cpu_to_le32(val);
> +		ret = regmap_bulk_write(data->regmap, reg, &buf, 3);
> +		if (ret < 0)
> +			return ret;
		return regmap_bulk_write()

> +	} else
> +		return -EINVAL;
Probably neater to use a switch statement and default to cath this last one.
> +
> +	return 0;
> +}
> +
> +static int apds9160_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return data->ps_int;
> +	case IIO_INTENSITY:
> +		return data->als_int;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
Unreachable so drop this.

> +}
> +
> +static int apds9160_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir, int state)
> +{
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	state = !!state;
> +
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		if (data->ps_int == state)
> +			return -EINVAL;
> +
> +		ret = regmap_field_write(data->reg_int_ps, state);
> +		if (ret)
> +			return ret;
> +		data->ps_int = state;
> +		break;
		return 0;
> +	case IIO_INTENSITY:
> +		if (data->als_int == state)
> +			return -EINVAL;
> +
> +		ret = regmap_field_write(data->reg_int_als, state);
> +		if (ret)
> +			return ret;
> +		data->als_int = state;
> +		break;
		return 0; instead of break if nothing else to do.
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
With above changes, this is unreachable so drop it.

> +}
> +
> +static irqreturn_t apds9160_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +	int ret, status;
> +
> +	/* Reading status register clears the interrupt flag */
> +	ret = regmap_read(data->regmap, APDS9160_REG_SR, &status);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "irq status reg read failed\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	if ((status & APDS9160_REG_SR_LS_INT) &&
> +	    (status & APDS9160_REG_SR_LS_NEW_DATA) && data->als_int) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
> +	}
> +
> +	if ((status & APDS9160_REG_SR_PS_INT) &&
> +	    (status & APDS9160_REG_SR_PS_NEW_DATA) && data->ps_int) {
> +		/** Interrupt flag is cleared after data read */


Not kernel doc. So just /* 

However, confusing comment to have here and duplicates comment above I think.


> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int apds9160_detect(struct apds9160_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +	u32 val;
> +	u8 id;
> +	u8 rev;
> +
> +	ret = regmap_read(chip->regmap, APDS9160_REG_ID, &val);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "ID read failed\n");
> +		return ret;
> +	}
> +
> +	id = APDS9160_PART_ID_MASK & ((u8)val);
FIELD_GET()
> +	rev = APDS9160_PART_REV_MASK & ((u8)val);
> +
> +	switch (id) {
> +	case APDS9160_PART_ID_0:
> +		chip->revision = rev;
> +		dev_info(&client->dev, "Device probed, rev %u\n",
> +			 chip->revision);
Too noisy.
return 0 here.

> +		break;
> +	default:
> +		dev_info(&client->dev, "Unsupported part id %u rev %u\n", id,
> +			 rev);
> +		ret = -ENODEV;
Fine to return an error code from here, just don't fail the probe on the
basis of an unknown part ID.

We have some older drivers that do this, but are slowly moving
to just printing an info message and moving on.

> +		break;
> +	}
> +	return ret;
> +}

> +static int apds9160_configure(struct iio_dev *indio_dev)
> +{
> +	struct apds9160_chip *chip = iio_priv(indio_dev);
> +
> +	return apds9160_chip_init(chip);
> +}
> +
> +static int apds9160_regfield_init(struct apds9160_chip *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	struct regmap *regmap = data->regmap;
> +
> +	data->reg_int_als = devm_regmap_field_alloc(dev, regmap,
> +						    apds9160_reg_field_int_als);
Can you just use the bulk field allocator?

> +	if (IS_ERR(data->reg_int_als)) {
> +		dev_err(dev, "INT ALS reg field init failed\n");
> +		return PTR_ERR(data->reg_int_als);
return dev_err_probe() for all of these if only called form probe.

> +	}
> +
> +	data->reg_int_ps =
> +		devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_int_ps);
> +	if (IS_ERR(data->reg_int_ps)) {
> +		dev_err(dev, "INT ps reg field init failed\n");
> +		return PTR_ERR(data->reg_int_ps);
> +	}
> +
> +	data->reg_enable_als =
> +		devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_ls_en);
> +	if (IS_ERR(data->reg_enable_als)) {
> +		dev_err(dev, "Enable ALS reg field init failed\n");
> +		return PTR_ERR(data->reg_enable_als);
> +	}
> +
> +	data->reg_enable_ps =
> +		devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_ps_en);
> +	if (IS_ERR(data->reg_enable_ps)) {
> +		dev_err(dev, "Enable PS reg field init failed\n");
> +		return PTR_ERR(data->reg_enable_ps);
> +	}
> +
> +	data->reg_ps_overflow = devm_regmap_field_alloc(
> +		dev, regmap, apds9160_reg_field_ps_overflow);
> +	if (IS_ERR(data->reg_ps_overflow)) {
> +		dev_err(dev, "PS overflow reg field init failed\n");
> +		return PTR_ERR(data->reg_ps_overflow);
> +	}
> +
> +	data->reg_als_rate = devm_regmap_field_alloc(
> +		dev, regmap, apds9160_reg_field_als_rate);
> +	if (IS_ERR(data->reg_als_rate)) {
> +		dev_err(dev, "ALS measurement rate field init failed\n");
> +		return PTR_ERR(data->reg_als_rate);
> +	}
> +
> +	data->reg_als_resolution = devm_regmap_field_alloc(
> +		dev, regmap, apds9160_reg_field_als_res);
> +	if (IS_ERR(data->reg_als_resolution)) {
> +		dev_err(dev, "ALS resolution field init failed\n");
> +		return PTR_ERR(data->reg_als_resolution);
> +	}
> +
> +	data->reg_ps_rate = devm_regmap_field_alloc(dev, regmap,
> +						    apds9160_reg_field_ps_rate);
> +	if (IS_ERR(data->reg_ps_rate)) {
> +		dev_err(dev, "PS measurement rate field init failed\n");
> +		return PTR_ERR(data->reg_ps_rate);
> +	}
> +
> +	data->reg_als_gain = devm_regmap_field_alloc(
> +		dev, regmap, apds9160_reg_field_als_gain);
> +	if (IS_ERR(data->reg_als_gain)) {
> +		dev_err(dev, "ALS gain field init failed\n");
> +		return PTR_ERR(data->reg_als_gain);
> +	}
> +
> +	data->reg_ps_current = devm_regmap_field_alloc(
> +		dev, regmap, apds9160_reg_field_ps_current);
> +	if (IS_ERR(data->reg_ps_current)) {
> +		dev_err(dev, "PS current field init failed\n");
> +		return PTR_ERR(data->reg_ps_current);
> +	}
> +
> +	data->reg_ps_gain = devm_regmap_field_alloc(dev, regmap,
> +						    apds9160_reg_field_ps_gain);
> +	if (IS_ERR(data->reg_ps_gain)) {
> +		dev_err(dev, "PS gain field init failed\n");
> +		return PTR_ERR(data->reg_ps_gain);
> +	}
> +
> +	data->reg_ps_resolution = devm_regmap_field_alloc(
> +		dev, regmap, apds9160_reg_field_ps_resolution);
> +	if (IS_ERR(data->reg_ps_resolution)) {
> +		dev_err(dev, "PS resolution field init failed\n");
> +		return PTR_ERR(data->reg_ps_resolution);
> +	}
> +
> +	return 0;
> +}
> +
> +static int apds9160_disable(struct apds9160_chip *data)
> +{
> +	int ret;
> +
> +	ret = regmap_field_write(data->reg_enable_als, 0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_field_write(data->reg_enable_ps, 0);
> +}
> +
> +static int apds9160_shutdown(struct iio_dev *indio_dev)
> +{
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +
I think you are using the buffer interfaces just to provide
an enable / disable?  Don't do that - instead implement runtime
PM with autosuspend.  That way the sensor will be powered down
if it isn't accessed for a bit.  When you enable events
you just hold it on until they are disabled.


> +	return apds9160_disable(data);
> +}
> +
> +static void apds9160_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	apds9160_disable(data);
convention is to put this after probe()
However with changes suggested in probe() you won't need this
at all.

> +}
> +
> +static const struct iio_buffer_setup_ops apds9160_buffer_setup_ops = {
> +	.postenable = apds9160_configure,
> +	.predisable = apds9160_shutdown,
> +};
> +
> +static const struct iio_info apds9160_info = {
> +	.attrs = &apds9160_attribute_group,
> +	.read_raw = apds9160_read_raw,
> +	.write_raw = apds9160_write_raw,
> +	.read_event_value = apds9160_read_event,
> +	.write_event_value = apds9160_write_event,
> +	.read_event_config = apds9160_read_event_config,
> +	.write_event_config = apds9160_write_event_config,
> +};
> +
> +static int apds9160_probe(struct i2c_client *client)
> +{
> +	struct apds9160_chip *chip;
> +	struct iio_dev *indio_dev;
> +	int err;
> +
> +	dev_info(&client->dev,
> +		 "Loading proximity/ambient light sensor driver\n");
Far too noisy. It is easy to find out if the driver has probed from
other means so we tend not to put generic entries in the kernel log.

> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
Can fail. Check for that.

> +	indio_dev->info = &apds9160_info;
> +	indio_dev->name = APDS9160_DRIVER_NAME;

Put it here as a string. There is no particularly reason this (which is
the part number) should match the driver name.

> +	indio_dev->channels = apds9160_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(apds9160_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	err = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
> +					  &apds9160_buffer_setup_ops);
> +	if (err)
> +		return err;
> +
> +	chip = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	chip->client = client;
> +	chip->regmap = devm_regmap_init_i2c(client, &apds9160_regmap_config);
> +	if (IS_ERR(chip->regmap)) {
> +		dev_err(&client->dev, "regmap initialization failed.\n");
> +		return PTR_ERR(chip->regmap);
		return dev_err_probe()...
For all error messages in probe.

> +	}
> +
> +	chip->client = client;
> +	chip->indio_dev = indio_dev;
> +	mutex_init(&chip->lock);
> +
> +	err = apds9160_detect(chip);
> +	if (err < 0) {
Don't fail on this. Fine to print a message though to say we have
a part we don't recognise.

Actually failing prevents the use of fallback compatibles in DT
etc that allow an older kernel to work with new devices as long
as they are backwards compatible (with exception of the ID register).
> +		dev_err(&client->dev, "apds9160 not found\n");
> +		return err;
> +	}
> +
> +	err = apds9160_regfield_init(chip);
> +	if (err)
> +		return err;
> +
> +	err = apds9160_chip_init(chip);
> +	if (err)
> +		return err;
Register a callback to turn the chip off again here with 
	ret = devm_add_action_or_reset()

That avoids mixing devm and non devm cleanup and allows direct returns.

> +
> +	if (client->irq > 0) {
> +		err = devm_request_threaded_irq(
> +			&client->dev, client->irq, NULL, apds9160_irq_handler,
> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT, "apds9160_event",
Direction needs to come from firmware so drop the FALLING part.

> +			indio_dev);
> +		if (err) {
> +			dev_err(&client->dev, "request irq (%d) failed\n",
> +				client->irq);
> +			goto fail;
> +		}
> +	} else {
> +		dev_info(&client->dev,
> +			 "init: no IRQ defined, ps/als interrupts disabled\n");
Easy to find out, so no need for print.
> +	}
> +
> +	err = iio_device_register(indio_dev);
With above changes make this a devm_call as well.
> +	if (err)
> +		goto fail;
> +
> +	return 0;
> +fail:
> +	apds9160_disable(chip);
With devm based disable this goes.
> +	return err;
> +}
> +
> +static const struct of_device_id apds9160_of_match[] = {
> +	{ .compatible = "avago,apds9160" },
> +	{ .compatible = "broadmobi,apds9160" },
> +	{}
Trivial local formatting thing but in IIO I'm trying to standardize on
	{ }
for these terminator entries.

> +};
> +MODULE_DEVICE_TABLE(of, apds9160_of_match);
> +
> +static struct i2c_driver apds9160_driver = {
> +	.driver	  = {
> +		.name	= APDS9160_DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = apds9160_of_match,
> +	},
> +	.probe    = apds9160_probe,
> +	.remove	  = apds9160_remove,
> +	.id_table = apds9160_id,
> +};

