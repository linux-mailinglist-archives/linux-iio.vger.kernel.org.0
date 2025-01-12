Return-Path: <linux-iio+bounces-14167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2213A0A883
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30E93A75F7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210C1AA791;
	Sun, 12 Jan 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcaLY0Wk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4D12C499;
	Sun, 12 Jan 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681321; cv=none; b=qq84g4/iocOKPHTZiYo6T9SOBvkncNWM/wS3TWpP4GEuPn3VKJl7n2wQugUpDZzpcf3k+LBYWZApCPhxSK6HIfCRJ+/GFTVoMrzMQRRJuzBGOiokHjwWzHb24NRK7rUVBWrnV6ZFPv5XDEJvjeDu7ZYrgwYY+JqUgeOLavDXO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681321; c=relaxed/simple;
	bh=e2mT9GmnoD4qxkc3EzJPF7YkPA6QxczdEFZNr6VUDXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrqG8istE+VRQkP6zcmdBn0l6QhkExS5uAnXD9HWsGn+AnCCfKh8Owc2dFrhaKgokAatfmJ5nDI0erNIf2/sJxUiglnRIPHnntdsGOeWavAHCkq2f3A1HwB202AG4K8dZleycWtevSXnFCRazhgB81OBhhwaVcPWxdDYsCmyx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcaLY0Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09654C4CEDF;
	Sun, 12 Jan 2025 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736681320;
	bh=e2mT9GmnoD4qxkc3EzJPF7YkPA6QxczdEFZNr6VUDXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YcaLY0Wky2jnLvpYxX5zw2GGFEuwYB/fZ7fNL8OTxrRzC6efISOWv1MIfTjblrnjy
	 jrpR5Y4ci+fNj5zwxswS1QGf0yMkxCbAvEkmVYUfgOGjK7zzBBoOrflIdK3zEohlHJ
	 5gQ7u8jHgowaSA1/nhB0wo/+U9nxzVGZn+0WLtYL8wRirAnw1qz7PbjzMpJyGKKe1u
	 xuKZXAZL7RBVlD0SPXml3uogSS2LR0J6nZuw3dqAwdMRvP21XJSYAjgrMNy0zTBsOG
	 RW0nyTs+i9vvvulEJQde89NvmCk80FUSBvye4mbtn0DCCehoZdbAH/47l1bIRVTCE3
	 fyuOVLqutHinQ==
Date: Sun, 12 Jan 2025 11:28:29 +0000
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
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <20250112112829.067b48b0@jic23-huawei>
In-Reply-To: <20250106-apds9160-driver-v4-2-f88d9fc45d84@dimonoff.com>
References: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
	<20250106-apds9160-driver-v4-2-f88d9fc45d84@dimonoff.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 06 Jan 2025 17:23:02 -0500
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

A few really minor things inline in addition to potential changes from
the dt-binding review / real units suggestion for the current controls.

Jonathan

> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index f14a3744271242f04fe7849b47308397ac2c9939..4a22043acdbbbed2b696a3225e4024654d5d9339 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>  obj-$(CONFIG_ADUX1020)		+= adux1020.o
>  obj-$(CONFIG_AL3010)		+= al3010.o
>  obj-$(CONFIG_AL3320A)		+= al3320a.o
> +obj-$(CONFIG_APDS9160)		+= apds9160.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_APDS9306)		+= apds9306.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
> diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4aa02f87ace72056a9c50c70e9f761cb6c52c985
> --- /dev/null
> +++ b/drivers/iio/light/apds9160.c
> @@ -0,0 +1,1586 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * APDS9160 sensor driver.
> + * Chip is combined proximity and ambient light sensor.
> + * Author: 2024 Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <linux/unaligned.h>
> +
> +#define APDS9160_REGMAP_NAME "apds9160_regmap"
Just put this inline.  No benefit in having the define that I can see.

> +#define APDS9160_REG_CNT 37
Same for this. Define isn't adding anything. 

> +
> +/* Main control register */
> +#define APDS9160_REG_CTRL 0x00
> +#define APDS9160_CTRL_SWRESET BIT(4) /* 1: Activate reset */
> +#define APDS9160_CTRL_MODE_RGB BIT(2) /* 0: ALS & IR, 1: RGB & IR */
> +#define APDS9160_CTRL_EN_ALS BIT(1) /* 1: ALS active */
> +#define APDS9160_CTLR_EN_PS BIT(0) /* 1: PS active */
> +
> +/* Status register  */
> +#define APDS9160_SR_LS_INT BIT(4)
> +#define APDS9160_SR_LS_NEW_DATA BIT(3)
> +#define APDS9160_SR_PS_INT BIT(1)
> +#define APDS9160_SR_PS_NEW_DATA BIT(0)
> +
> +/* Interrupt configuration registers */
> +#define APDS9160_REG_INT_CFG 0x19
> +#define APDS9160_REG_INT_PST 0x1A
> +#define APDS9160_INT_CFG_EN_LS BIT(2) /* LS int enable */
> +#define APDS9160_INT_CFG_EN_PS BIT(0) /* PS int enable */
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
> +/* Part identification number register */
> +#define APDS9160_REG_ID 0x06
> +
> +/* Status register */
> +#define APDS9160_REG_SR 0x07
> +#define APDS9160_SR_DATA_ALS BIT(3)
> +#define APDS9160_SR_DATA_PS BIT(0)
> +
> +/* Supported ID:s */
> +#define APDS9160_PART_ID_0 0x03
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
> +#define APDS9160_DEFAULT_PS_RESOLUTION_11BITS 0x03
> +
> +static const struct reg_default apds9160_reg_defaults[] = {
> +	{ APDS9160_REG_CTRL, 0x00 }, /* Sensors disabled by default  */
> +	{ APDS9160_REG_PS_LED, 0x33 }, /* 60 kHz frequency, 100 mA */

No need to change anything but a parsing comment.
This is one reason I personally don't like the regfield stuff (though
I never stop people using it, I won't encourage it either!)
If we'd had a traditional use of FIELD_PREP() and masks throughout then
we'd have everything needed to allow explicit setting of these default
values as fields as well.  We don't have the defines for that and I
definitely don't want to suggest you add them alongside regfield
equivalents.

> +	{ APDS9160_REG_PS_PULSES, 0x08 }, /* 8 pulses */
> +	{ APDS9160_REG_PS_MEAS_RATE, 0x05 }, /* 100ms */
> +	{ APDS9160_REG_LS_MEAS_RATE, 0x22 }, /* 100ms */
> +	{ APDS9160_REG_LS_GAIN, 0x01 }, /* 3x */
> +	{ APDS9160_REG_INT_CFG, 0x10 }, /* Interrupts disabled */
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

> +/*
> + * This parameter determines the cancellation pulse duration
> + * in each of the PWM pulse. The cancellation is applied during the
> + * integration phase of the PS measurement.
> + * Duration is programmed in half clock cycles
> + * A duration value of 0 or 1 will not generate any cancellation pulse
> + */
> +static int apds9160_set_ps_analog_cancellation(struct apds9160_chip *data,
> +					       int val)
> +{
> +	int ret;
> +
> +	if (val < 0 || val > 63)
> +		return -EINVAL;
> +
> +	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_DUR,
> +			   val);
> +
> +	return ret;

return regmap_write...

> +}



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
> +	switch (chan->type) {
> +	case IIO_PROXIMITY: {
> +		__le16 buf = cpu_to_le16(val);

Trivial: A little odd to set this before the range checks.
> +
> +		if (val < 0 || val > APDS9160_PS_THRES_MAX)
> +			return -EINVAL;
> +
> +		return regmap_bulk_write(data->regmap, reg, &buf, 2);
> +	}
> +	case IIO_LIGHT: {
> +		u8 buf[3];
> +
> +		if (val < 0 || val > APDS9160_LS_THRES_MAX)
> +			return -EINVAL;
> +
> +		put_unaligned_le24(val, buf);
> +		return regmap_bulk_write(data->regmap, reg, &buf, 3);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int apds9160_detect(struct apds9160_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read(chip->regmap, APDS9160_REG_ID, &val);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "ID read failed\n");
> +		return ret;
> +	}
> +
> +	if (val != APDS9160_PART_ID_0)
> +		dev_info(&client->dev, "Unsupported part id %u\n", val);

"Unknown part" or "Unrecognised part"
we are trying at least to support it in fallback case!

> +
> +	return 0;
> +}


