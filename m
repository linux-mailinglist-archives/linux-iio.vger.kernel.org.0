Return-Path: <linux-iio+bounces-10256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259CC991F4E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 17:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1431F21C56
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4715FA72;
	Sun,  6 Oct 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9A/rpvC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB7158DA9;
	Sun,  6 Oct 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728227940; cv=none; b=DgLzwCqF+B9L6smJ08PKvehcuzvPnxL6efjMkIxkmn30pr0ejVsncNWGjguHpyZIUa4HSdUGcLLYXaj53nQEk3cSza19hQoPWM0HZrb84Wy+qGXlnitGoO6TFUi3ngUxwCv7d91goRpqWa8RdccxUxEPF1TWOo6QyBRvJ2+6jLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728227940; c=relaxed/simple;
	bh=ny77v9mDeCKpyVn2BQUdZ6KiVVK5fneYAX2rGm4CmLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxsA8vfvGIt5zNKC8gbtHdJ/VVnFDw5A9oj3pvY077lCHKN3uZw4KOjkDSUGzQCBmLCo5FZiJnkQeQvkrnHWnLs+zSVTd4G91b1rDfNeCdfWxk1k05ukXY/vCERErmC4zzqtr7Mm4Rx2URU9iBKm3tNI8qHNieBiPWBDR8AaDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9A/rpvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125BDC4CECD;
	Sun,  6 Oct 2024 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728227940;
	bh=ny77v9mDeCKpyVn2BQUdZ6KiVVK5fneYAX2rGm4CmLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k9A/rpvCm71RxROVdtHsfheS7nwMZTiUVRdx5rqVrfXM5i0CXIA0CHvMBQElVdTqP
	 HksZyOP6h5Ko90cDGh4nGlcFUAqYApQrUf1OCeo0t7sGhfMUE7SwQ4WD+c/2ay0TJd
	 Z0ZcqjHz24jpRf1i22zSsh0Y7FjCXzhEiwRmPP1ZXj5JYVZvdpwjpwSdnzC3vT1SmL
	 bihK0j4/k3ePui2l7QkU5fopXziTwKLTAvLDw1NYU/IyMdBj2Uwk7770rqCBaES6uo
	 Bsy9edDe/3HVqklF20Kq5nhxlOG1FpC12Yr+AUvIh+aH2hFDUmIEjhfZUqXVcO5Il0
	 ZW9I/YzO2IgKg==
Date: Sun, 6 Oct 2024 16:18:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <rickard.andersson@axis.com>, <kernel@axis.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241006161850.3f9cf275@jic23-huawei>
In-Reply-To: <20241005165119.3549472-3-perdaniel.olsson@axis.com>
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
	<20241005165119.3549472-3-perdaniel.olsson@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 18:51:19 +0200
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> Add support for Texas Instruments OPT4060 RGBW Color sensor.
Hi Per-Daniel.

Thanks for your driver.  Various comments inline.
The two bigger things I'd like to understand are:
1) Why we have a threshold trigger?  That is unusual so I'd like to fully understand
  the use case.  I see an explanation in your cover letter so I'll comment on that here
  but I would like one here as well.

2) Why do we need processed and raw? That may make sense but it is also unusual
   so I'd like a comment in this patch description on your reasoning.

I've only raised some style issues in a few places. Please check to see if those
apply more broadly.

Thanks,

Jonathan


> 
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> ---
>  drivers/iio/light/Kconfig   |   13 +
>  drivers/iio/light/Makefile  |    1 +
>  drivers/iio/light/opt4060.c | 1216 +++++++++++++++++++++++++++++++++++
>  3 files changed, 1230 insertions(+)
>  create mode 100644 drivers/iio/light/opt4060.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 515ff46b5b82..0e2059512157 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -490,6 +490,19 @@ config OPT4001
>  	  If built as a dynamically linked module, it will be called
>  	  opt4001.
>  
> +config OPT4060
> +	tristate "Texas Instruments OPT4060 RGBW Color Sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  If you say Y or M here, you get support for Texas Instruments
> +	  OPT4060 RGBW Color Sensor.
> +
> +	  If built as a dynamically linked module, it will be called
> +	  opt4060.
> +
>  config PA12203001
>  	tristate "TXC PA12203001 light and proximity sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 321010fc0b93..55902b21ec0c 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_MAX44009)		+= max44009.o
>  obj-$(CONFIG_NOA1305)		+= noa1305.o
>  obj-$(CONFIG_OPT3001)		+= opt3001.o
>  obj-$(CONFIG_OPT4001)		+= opt4001.o
> +obj-$(CONFIG_OPT4060)		+= opt4060.o
>  obj-$(CONFIG_PA12203001)	+= pa12203001.o
>  obj-$(CONFIG_ROHM_BU27008)	+= rohm-bu27008.o
>  obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o
> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> new file mode 100644
> index 000000000000..a917b59cd500
> --- /dev/null
> +++ b/drivers/iio/light/opt4060.c
> @@ -0,0 +1,1216 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Axis Communications AB
> + *
> + * Datasheet: https://www.ti.com/lit/gpn/opt4060
> + *
> + * Device driver for the Texas Instruments OPT4060 RGBW Color Sensor.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/math64.h>
> +#include <linux/units.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define OPT_4060_DRV_NAME	"opt4060"
I'm generally against these DRV_NAME type defines as they tend to imply there
is a reason various strings in the driver match when it is an arbitrary choice.
I'd rather see the string inline.

> +
> +struct opt4060_buffer {
> +	u32 chan[OPT4060_NUM_CHANS];
> +	s64 ts;
aligned_s64
Which is needed to cover the delights of 32 bit x86 where an s64 is 32bit aligned
and this whole structure can end up aligned differently from the obvious.


> +};

...
> +
> +static u8 opt4060_calculate_crc(u8 exp, u32 mantissa, u8 count)

Good to include the formula here. I'm assuming this doesn't correspond
to any of the standard crc codes for which we have implementations already.

> +{
> +	u8 crc;
> +
> +	crc = (hweight32(mantissa) + hweight32(exp) + hweight32(count)) % 2;
> +	crc |= ((hweight32(mantissa & 0xAAAAA) + hweight32(exp & 0xA)
> +		 + hweight32(count & 0xA)) % 2) << 1;
> +	crc |= ((hweight32(mantissa & 0x88888) + hweight32(exp & 0x8)
> +		 + hweight32(count & 0x8)) % 2) << 2;
> +	crc |= (hweight32(mantissa & 0x80808) % 2) << 3;
> +
> +	return crc;
> +}


> +
> +static int opt4060_read_raw_value(struct opt4060_chip *chip,
> +				  unsigned long address, u32 *raw)
> +{
> +	int ret;
> +	u32 result;
> +	u16 msb;
> +	u16 lsb;
> +	u8 exp;
> +	u8 count;
> +	u8 crc;

Combine entrees of same type to save a few lines here

> +	u8 calc_crc;
> +	u32 mantissa_raw;
> +
> +	ret = regmap_bulk_read(chip->regmap, address, &result, 2);
> +	if (ret)
> +		dev_err(chip->dev, "Reading channel data failed\n");
		return ret; and drop the else.

Also kernel coding style requires {} for all legs if any need it.

> +	else {
> +		count = FIELD_GET(OPT4060_COUNTER_MASK, result >> 16);
> +		crc = FIELD_GET(OPT4060_CRC_MASK, result >> 16);
> +		lsb = FIELD_GET(OPT4060_LSB_MASK, result >> 16);
> +		exp = FIELD_GET(OPT4060_EXPONENT_MASK, result);
> +		msb = FIELD_GET(OPT4060_MSB_MASK, result);
> +		mantissa_raw = (msb << 8) + lsb;
> +		calc_crc = opt4060_calculate_crc(exp, mantissa_raw, count);
> +		if (calc_crc != crc)
> +			return -EIO;
> +
> +		*raw = mantissa_raw << exp;
> +	}
> +	return ret;
> +}
> +
> +static int opt4060_read_chan_value(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, bool processed)
> +{
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	u32 adc_raw;
> +	int ret;
> +	/* Set timeout to two times the integration time multiplied by channel count. */
> +	unsigned int timeout_us = 2 * OPT4060_NUM_CHANS *
> +				  opt4060_int_time_reg[chip->int_time][0];
> +
> +	if (chip->irq) {
> +		reinit_completion(&chip->completion);
> +		ret = opt4060_trigger_one_shot(chip);
> +		if (ret)
> +			return ret;
> +		if (wait_for_completion_timeout(&chip->completion,
> +						usecs_to_jiffies(timeout_us)) == 0)
> +			dev_info(chip->dev, "Completion timed out.\n");

It's an error dev_err() appropriate.

> +	}
> +
> +	ret = opt4060_read_raw_value(chip, chan->address, &adc_raw);
> +	if (ret) {
> +		dev_err(chip->dev, "Reading raw channel data failed\n");
> +		return ret;
> +	}
> +	if (processed) {

Having both processed and raw for a channel needs an explanation.
It's not helped by processed being meaningless for color channels as there
are not really an well defined units.


> +		u32 lux_raw;
> +		u32 rem;
> +		u32 mul = opt4060_channel_factors[chan->scan_index].mul;
> +		u32 div = opt4060_channel_factors[chan->scan_index].div;
> +
> +		lux_raw = adc_raw * mul;
> +		*val = div_u64_rem(lux_raw, div, &rem);
> +		*val2 = rem * div_u64(div, 10);
> +		return IIO_VAL_INT_PLUS_NANO;
> +	}
> +	*val = adc_raw;
> +	*val2 = 0;

No need to set val2 if IIO_VAL_INT
The core code guarantees never to use it.

> +	return IIO_VAL_INT;
> +}

> +static int opt4060_power_down(struct opt4060_chip *chip)
> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &reg);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to read configuration\n");
> +		return ret;
> +	}
> +
> +	/* MODE_OFF is 0x0 so just set bits to 0 */
> +	reg &= ~OPT4060_CTRL_OPER_MODE_MASK;

regmap_clear_bits() maybe?

> +
> +	ret = regmap_write(chip->regmap, OPT4060_CTRL, reg);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to power down\n");
> +
> +	return ret;
> +}
> +
> +static void opt4060_chip_off_action(void *data)
> +{
> +	struct opt4060_chip *chip = data;
No need for the local variable.  Just rename data to chip is enough.
> +
> +	opt4060_power_down(chip);
> +}
> +
> +#define OPT4060_CHAN(color)							\
> +{										\
> +	.type = IIO_LIGHT,							\
> +	.modified = 1,								\
> +	.channel2 = IIO_MOD_LIGHT_##color,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |			\
> +			      BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),			\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),	\
> +	.address = OPT4060_##color##_MSB,					\
> +	.scan_index = OPT4060_##color,						\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = 32,							\
> +		.storagebits = 32,						\
> +		.endianness = IIO_LE,						\
> +	},									\
> +	.event_spec = opt4060_event_spec,					\
where you have an optional irq like here, have two sets of chan_spec and pick
between them dependent on the availability of that irq.

If there is no irq, there should be no event attributes.

> +	.num_event_specs = ARRAY_SIZE(opt4060_event_spec),			\
> +}
> +
> +static const struct iio_event_spec opt4060_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +};

> +
> +static bool opt4060_event_active(struct opt4060_chip *chip)
> +{
> +	return chip->thresh_event_lo_active || chip->thresh_event_hi_active;
> +}
> +
> +static int opt4060_read_available(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  const int **vals, int *type, int *length,
> +				  long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(opt4060_int_time_available) * 2;
> +		*vals = (const int *)opt4060_int_time_available;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
One blank line is enough. Check for other instances.

> +
> +static int opt4060_event_set_state(struct opt4060_chip *chip, bool state)
> +{
> +	int ret = 0;
> +
> +	if (state)
> +		ret = opt4060_set_continous_mode(chip, true);
		return opt...
> +	else if (!chip->data_trigger_active && chip->irq)
> +		ret = opt4060_set_continous_mode(chip, false);
		return opt...

> +
> +	return ret;
Not an error?

> +}
> +
> +static int opt4060_trigger_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (indio_dev->trig) {
> +		iio_trigger_put(indio_dev->trig);
> +		indio_dev->trig = NULL;
> +	}
> +
> +	if (state) {
> +		indio_dev->trig = iio_trigger_get(trig);
> +		ret = opt4060_set_continous_mode(chip, true);
	return opt...

> +	} else if (!opt4060_event_active(chip) && chip->irq)
> +		ret = opt4060_set_continous_mode(chip, false);
		return opt
> +
> +	if (trig == chip->data_trig) {
> +		chip->data_trigger_active = state;
> +		chip->threshold_trigger_active = !state;
> +	} else if (trig == chip->threshold_trig) {
> +		chip->data_trigger_active = !state;
> +		chip->threshold_trigger_active = state;
> +	}
> +
> +	return ret;
> +}

> +
> +static int opt4060_get_channel_sel(struct opt4060_chip *chip, int *ch_sel)
> +{
> +	int ret;
> +	u32 regval;
> +
> +	ret = regmap_read(chip->regmap, OPT4060_INT_CTRL, &regval);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to get channel selection.\n");
		return ret;
> +	else
no else needed.
> +		*ch_sel = FIELD_GET(OPT4060_INT_CTRL_THRESH_SEL, regval);
> +	return ret;
return 0;
Check for other cases that look like this. Early returns on error almost
always make for more readable code than keeping the return for the end
(After doing nothing useful extra)
> +}
> +
> +static int opt4060_set_channel_sel(struct opt4060_chip *chip, int ch_sel)
> +{
> +	int ret;
> +	u32 regval;
> +
> +	regval = FIELD_PREP(OPT4060_INT_CTRL_THRESH_SEL, ch_sel);
> +	ret = regmap_update_bits(chip->regmap, OPT4060_INT_CTRL,
> +				 OPT4060_INT_CTRL_THRESH_SEL, regval);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to set channel selection.\n");
> +	return ret;
> +}
> +
> +static int opt4060_get_thresholds(struct opt4060_chip *chip, u32 *th_lo, u32 *th_hi)
> +{
> +	int ret;
> +	u32 regval;
> +
> +	ret = regmap_read(chip->regmap, OPT4060_THRESHOLD_LOW, &regval);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to read THRESHOLD_LOW.\n");
> +		return ret;
> +	}
> +	*th_lo = opt4060_calc_val_from_th_reg(regval);
> +
> +	ret = regmap_read(chip->regmap, OPT4060_THRESHOLD_HIGH, &regval);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to read THRESHOLD_LOW.\n");
> +		return ret;
> +	}
> +	*th_hi = opt4060_calc_val_from_th_reg(regval);
> +
> +	return ret;
	return 0;
> +}
> +
> +static int opt4060_set_thresholds(struct opt4060_chip *chip, u32 th_lo, u32 th_hi)
> +{
> +	int ret;
> +
> +	ret = regmap_write(chip->regmap, OPT4060_THRESHOLD_LOW, opt4060_calc_th_reg(th_lo));
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to write THRESHOLD_LOW.\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(chip->regmap, OPT4060_THRESHOLD_HIGH, opt4060_calc_th_reg(th_hi));
> +	if (ret)
> +		dev_err(chip->dev, "Failed to write THRESHOLD_HIGH.\n");
> +
> +	return ret;
> +}
> +
> +static int opt4060_read_event(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      enum iio_event_type type,
> +			      enum iio_event_direction dir,
> +			      enum iio_event_info info,
> +			      int *val, int *val2)
> +{
> +	int ret = -EINVAL;
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
> +			u32 th_lo, th_hi;
> +
> +			if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
> +				return -EFAULT;
> +			if (dir == IIO_EV_DIR_FALLING) {
> +				*val = th_lo;
> +				ret = IIO_VAL_INT;
> +			} else if (dir == IIO_EV_DIR_RISING) {
> +				*val = th_hi;
> +				ret = IIO_VAL_INT;
> +			}
> +		}
> +		break;
Similar refactor to do early returns as suggested for the next function (see below)

> +	case IIO_EV_INFO_PERIOD:
> +		return opt4060_read_ev_period(chip, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static int opt4060_write_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int val, int val2)
> +{
> +	int ret = -EINVAL;
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
> +			u32 th_lo, th_hi;
> +
> +			if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
> +				return -EFAULT;
> +			if (dir == IIO_EV_DIR_FALLING)
> +				th_lo = val;
> +			else if (dir == IIO_EV_DIR_RISING)
> +				th_hi = val;
> +			if (opt4060_set_thresholds(chip, th_lo, th_hi))
> +				return -EFAULT;
> +			ret = 0;
			return 0;
> +		}
		return -EINVAL;
> +		break;
> +	case IIO_EV_INFO_PERIOD:
> +		return opt4060_write_ev_period(chip, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +	return ret;
Drop this as with above always returned already.

> +}
> +
> +static int opt4060_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	int ret = -EINVAL;
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +
> +	if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
As below. Consider flipping the condition for an early return
Check all similar cases for whether it improves readability.


> +		int ch_idx = chan->scan_index;
> +		int ch_sel;
> +
> +		if (opt4060_get_channel_sel(chip, &ch_sel))
> +			return -EFAULT;
> +
> +		if (((dir == IIO_EV_DIR_FALLING) && chip->thresh_event_lo_active) ||
> +		    ((dir == IIO_EV_DIR_RISING) && chip->thresh_event_hi_active))
> +			ret = (ch_sel == ch_idx);
> +		else
> +			ret = FALSE;
> +	}
> +	return ret;
> +}
> +
> +static int opt4060_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, int state)
> +{
> +	int ret = -EINVAL;
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +
> +	if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
Maybe flip the condition to reduce effective indent.
	if (chan->type != IIO_LIGHT)
		return -EINVAL;
	if (type != IIO_EV_TYPE_THRESH)
		reuturn -EINVAL;

etc
> +		int ch_idx = chan->scan_index;
> +		int ch_sel;
> +
> +		if (opt4060_get_channel_sel(chip, &ch_sel))
> +			return -EFAULT;
> +
> +		if (state) {
> +			/* Only one channel can be active at the same time */
> +			if ((chip->thresh_event_lo_active ||
> +			     chip->thresh_event_hi_active) && (ch_idx != ch_sel))
> +				return -EBUSY;
> +			if (dir == IIO_EV_DIR_FALLING)
> +				chip->thresh_event_lo_active = TRUE;
> +			else if (dir == IIO_EV_DIR_RISING)
> +				chip->thresh_event_hi_active = TRUE;
> +			if (opt4060_set_channel_sel(chip, ch_idx))
> +				return -EFAULT;
> +			ret = 0;
> +		} else {
> +			if (ch_idx == ch_sel) {
> +				if (dir == IIO_EV_DIR_FALLING)
> +					chip->thresh_event_lo_active = FALSE;
false etc

> +				else if (dir == IIO_EV_DIR_RISING)
> +					chip->thresh_event_hi_active = FALSE;
> +			}
> +			ret = 0;
> +		}
> +
> +		if (opt4060_event_set_state(chip, chip->thresh_event_hi_active |
> +					    chip->thresh_event_lo_active))
> +			return -EFAULT;
> +	}
> +	return ret;
> +}

> +
> +static bool opt4060_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	if ((reg >= OPT4060_RED_MSB && reg <= OPT4060_CLEAR_LSB) ||
> +	    reg == OPT4060_RES_CTRL)
> +		return true;
> +	return false;

As below, just return the condition.

> +}
> +
> +static bool opt4060_writable_reg(struct device *dev, unsigned int reg)
> +{
> +	if (reg >= OPT4060_THRESHOLD_LOW || reg >= OPT4060_INT_CTRL)
> +		return true;
> +	return false;
return reg >=...
> +}
> +
> +static bool opt4060_readonly_reg(struct device *dev, unsigned int reg)
> +{
> +	if (reg == OPT4060_DEVICE_ID)
> +		return true;
> +	return false;
	return reg == ..

> +}
> +
> +static bool opt4060_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	/* Volatile, writable and read-only registers are readable. */
> +	if (opt4060_volatile_reg(dev, reg) || opt4060_writable_reg(dev, reg) ||
> +	    opt4060_readonly_reg(dev, reg))
> +		return TRUE;
true

> +	return false;

return opt....

> +}
> +

> +
> +static irqreturn_t opt4060_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct opt4060_chip *chip = iio_priv(idev);
> +	struct opt4060_buffer raw;
> +	int ret, chan;
> +	int i = 0;
> +
> +	memset(&raw, 0, sizeof(raw));
> +
> +	for_each_set_bit(chan, idev->active_scan_mask, idev->masklength) {
Try compiling this on latest togreg branch.  We have removed direct
access to masklength

There is a iio_for_each_active_channel() macro that handles this usage
more cleanly.

> +		ret = opt4060_read_raw_value(chip,
> +					     opt4060_channels[chan].address,
> +					     &raw.chan[i++]);
> +		if (ret) {
> +			dev_err(chip->dev, "Reading raw channel data failed\n");
> +			goto err_read;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
> +err_read:
> +	iio_trigger_notify_done(idev->trig);
> +	return IRQ_HANDLED;
> +}
> +

...

> +static int opt4060_setup_triggers(struct opt4060_chip *chip, struct iio_dev *idev)
> +{
> +	struct iio_trigger *data_trigger;
> +	struct iio_trigger *threshold_trigger;
> +	char *name;
> +	int ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(chip->dev, idev,
> +					      &iio_pollfunc_store_time,
> +					      opt4060_trigger_handler,
> +					      &opt4060_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +			     "iio_triggered_buffer_setup_ext FAIL\n");
> +
> +	data_trigger = devm_iio_trigger_alloc(chip->dev, "%s-data-ready-dev%d",
> +				       idev->name, iio_device_id(idev));

Where it doesn't result in very long lines, align to just after (

That may mean you have more line breaks. If so that is fine.


> +	if (!data_trigger)
> +		return -ENOMEM;
Slight preference for a blank line after error checks like this.

> +	chip->data_trig = data_trigger;
> +	data_trigger->ops = &opt4060_trigger_ops;
> +	iio_trigger_set_drvdata(data_trigger, idev);
> +	ret = devm_iio_trigger_register(chip->dev, data_trigger);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "Data ready trigger registration failed\n");
> +
> +	threshold_trigger = devm_iio_trigger_alloc(chip->dev, "%s-threshold-dev%d",
> +				       idev->name, iio_device_id(idev));

This needs some explanation. Why a threshold trigger rather than just using
events?  Superficially looks like you should just use the event interfaces.

> +	if (!threshold_trigger)
> +		return -ENOMEM;
> +	chip->threshold_trig = threshold_trigger;
> +	threshold_trigger->ops = &opt4060_trigger_ops;
> +	iio_trigger_set_drvdata(threshold_trigger, idev);
> +	ret = devm_iio_trigger_register(chip->dev, threshold_trigger);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "Threshold trigger registration failed\n");
> +
One blank line is plenty.
> +
> +	name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-opt4060",
> +			      dev_name(chip->dev));

Check for failure to allocate.

> +
> +	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL, opt4060_irq_thread,
> +					IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> +					IRQF_ONESHOT, name, idev);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret, "Could not request IRQ\n");
> +
> +	ret = regmap_write_bits(chip->regmap, OPT4060_INT_CTRL,
> +				OPT4060_INT_CTRL_OUTPUT,
> +				OPT4060_INT_CTRL_OUTPUT);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "Failed to set interrupt as output\n");
> +
> +	return 0;
> +}
> +
> +static int opt4060_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct opt4060_chip *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	uint dev_id;

unsigned int to match the regmap parameter type.

> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +
> +	/* Request regulator */

very obvious. Drop the comment.

> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable vdd supply\n");
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &opt4060_regmap_config);
> +	if (IS_ERR(chip->regmap))
> +		return dev_err_probe(dev, PTR_ERR(chip->regmap),
> +				     "regmap initialization failed\n");
> +
> +	chip->dev = dev;
> +	chip->irq = client->irq;
> +	init_completion(&chip->completion);
> +
> +	indio_dev->info = &opt4060_info;
> +
> +	ret = regmap_reinit_cache(chip->regmap, &opt4060_regmap_config);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to reinit regmap cache\n");
> +
> +	ret = regmap_read(chip->regmap, OPT4060_DEVICE_ID, &dev_id);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"Failed to read the device ID register\n");
> +
> +	dev_id = FIELD_GET(OPT4060_DEVICE_ID_MASK, dev_id);
> +	if (dev_id != OPT4060_DEVICE_ID_VAL)
> +		dev_warn(dev, "Device ID: %#04x unknown\n", dev_id);

Prefer dev_info() for this as it may well be a valid fallback
compatible.

> +
> +	indio_dev->channels = opt4060_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(opt4060_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = OPT_4060_DRV_NAME;
> +
> +	/* Initialize device with default settings */

As below. Comment is (rightly) obvious from the code, so don't have
a comment.

> +	ret = opt4060_load_defaults(chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to set sensor defaults\n");
> +
> +	/* If irq is enabled, initialize triggers */
The comment doesn't add anything not obvious from the code.  I'd drop it
and any similar ones.
> +	if (chip->irq) {
> +		ret = opt4060_setup_triggers(chip, indio_dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		dev_info(chip->dev, "No IRQ, events and triggers disabled\n");

Too noisy.  At most dev_dbg.  Probably not useful at all as it is fairly easy
to see no irq was registered.

> +	}
> +
> +	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);

This needs to be alongside whatever turned it on. Or if that is a side effect
of later accesses (i.e. it is powered up only channel read) then add
a comment to that affect.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to setup power off action\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +/*
> + * The compatible string determines which constants to use depending on
> + * opt4060 packaging
There is only one. So this comment is currently meaningless.

> + */
> +static const struct i2c_device_id opt4060_id[] = {
> +	{ OPT_4060_DRV_NAME, 0 },
Put the string directly in here. There is no reason why this
should match the DRV_NAME.  Also drop the 0 as it is currently
pointless and when you do introduce some data it should be a pointer
anyway.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, opt4060_id);
> +
> +static const struct of_device_id opt4060_of_match[] = {
> +	{ .compatible = "ti,opt4060" },
> +	{}

Trivial but I'm trying to get consistency in IIO (slowly) on 
{ } for these terminators (so with the space).
I'd prefer to not introduce more instances of {}

Thanks,

Jonathan


> +};
> +MODULE_DEVICE_TABLE(of, opt4060_of_match);

