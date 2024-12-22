Return-Path: <linux-iio+bounces-13751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6D19FA79B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 19:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1BA165C70
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5252118FDC8;
	Sun, 22 Dec 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIf/ykKu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262F14375C;
	Sun, 22 Dec 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734893697; cv=none; b=qEkE5lpTH0P/9mgJPw/PUPKFZOhu/kx3ravWoUGgoCVeEFrscxJiZ3zZMpmNrzat8lA9RM5fJ4mP4fkUukYtOPGVre8TtDxAsk+Zy73Ff9vhRZKMSrbaalHzzyrHjs4oF4hH4UdMK/6V7uHc/XdrkkNLR6kGeBxOEKCjSKbD0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734893697; c=relaxed/simple;
	bh=c6lThQm3bQGRyOF9tB3QDWMVlvp9OrC7UVnKfsSaq5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbOeY2GISkqAC3czkb+FRMY5L93ptRaaXhAG5FlyjLzli3iqvguV7Ll435HJfMmKZKNPCHuZM+D76bjD8/iP/URTp2vsE7dMCFIVaq/DoYPqbQXh2pC7U7Peoc6N8mC5ABK4MJEyKTgwy0fNeixbFn6+4oZhyyJyhYQQ4/22jQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIf/ykKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAEBC4CEDC;
	Sun, 22 Dec 2024 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734893696;
	bh=c6lThQm3bQGRyOF9tB3QDWMVlvp9OrC7UVnKfsSaq5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vIf/ykKuMesQmXwjnRNqD5JXU/tFMhxf7lcpXmqGZa2YanjH4q5C83kepVEdORanW
	 6TQ13UrdrDYLDD3DSSOiDD3FOeFrayOo2K31K9IUY71YiZVoEXeqoqFFuHkl+8lKJ3
	 WIvxUAmCRlfZZmUFT5teeIXwx4cFZV/aiR8qDNDbxQeVbByh1QerVb5C43pmc5f03p
	 n9bCXsBrDuzv5oBuq1i/f+y0ee0CSHdvtCyade65UetoBrZkGEbyS7BK1plr6+Eodq
	 y9LCRm8YebwhZfjVJXcWK73Y/u5fmsvMnixShA+7TjHDxk1l2HavRdGeilCMxmjXk9
	 kvGULUI1NgeyA==
Date: Sun, 22 Dec 2024 18:54:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v1 3/3] iio: adc: ad7191: add AD7191
Message-ID: <20241222185447.7928f1e2@jic23-huawei>
In-Reply-To: <20241221155926.81954-4-alisa.roman@analog.com>
References: <20241221155926.81954-1-alisa.roman@analog.com>
	<20241221155926.81954-4-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 17:56:02 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Hi Alisa-Dariana,

Comments inline.

Note the date may be right for v2 (if there are significant changes),
but it's wrong now and you should never put a copyright date in the future.

Happy holidays and new year! :)

Jonathan


> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..434610af3d39 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -112,6 +112,17 @@ config AD7173
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7173.
>  
> +config AD7191
> +	tristate "Analog Devices AD7191 ADC driver"
> +	depends on SPI
> +	select AD_SIGMA_DELTA
> +	help
> +	  Say yes here to build support for Analog Devices AD7191.
> +	  If unsure, say N (but it's safe to say "Y").

It does no harm, so get rid of this sentence.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7191.
> +
>  config AD7192
>  	tristate "Analog Devices AD7192 and similar ADC driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile

> diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
> new file mode 100644
> index 000000000000..6509e974072a
> --- /dev/null
> +++ b/drivers/iio/adc/ad7191.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD7191 ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.

Impressive claim in 2024! :)

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

Sometimes we pull out the IIO ones, but not normally this
mix of other subsystem specific ones. I'd just put the lot
in alphabetical order (maybe with the two iio headers in an extra
block like this one).

> +
> +#define AD7191_NAME			"ad7191"
Same comment as I've given to a lot of drivers recently. 
It isn't a magic constant and the define just makes it harder to review
as I need to come and find it.  Just put the string inline.
There is no particular reason the driver name and iio_dev->name should
be the same, so it is clearer to me if I can just see the string in each
place.

> +
> +#define AD7191_TEMP_CODES_PER_DEGREE	2815
> +
> +#define AD7191_EXT_FREQ_HZ_MIN		2457600
> +#define AD7191_EXT_FREQ_HZ_MAX		5120000
> +#define AD7191_INT_FREQ_HZ		4915200
> +
> +#define AD7191_CHAN_MASK		BIT(0)
> +#define AD7191_TEMP_MASK		BIT(1)
> +
> +#define AD7191_PGA1_MASK		BIT(0)
> +#define AD7191_PGA2_MASK		BIT(1)
> +
> +#define AD7191_ODR1_MASK		BIT(0)
> +#define AD7191_ODR2_MASK		BIT(1)
> +
> +#define AD7191_CH_AIN1_AIN2		0
> +#define AD7191_CH_AIN3_AIN4		1
> +#define AD7191_CH_TEMP			2

These are arbitrary assigned values I think?  So use an enum.

> +
> +/* NOTE:
/*
 * NOTE:...

> + * The AD7191 features a dual use data out ready DOUT/RDY output.
> + * In order to avoid contentions on the SPI bus, it's therefore necessary
> + * to use spi bus locking.
> + *
> + * The DOUT/RDY output must also be wired to an interrupt capable GPIO.
> + */
> +
> +struct ad7191_state {
> +	struct ad_sigma_delta		sd;
> +	struct mutex			lock; // to protect sensor state
> +
> +	struct gpio_desc		*odr1_gpio;
> +	struct gpio_desc		*odr2_gpio;

Even if you don't do what Conor suggested in the DT you
can just make these a few 2 element arrays to reduce code length here.
	struct gpio_desc		*odr_gpio[2];
etc

> +	struct gpio_desc		*pga1_gpio;
> +	struct gpio_desc		*pga2_gpio;
> +	struct gpio_desc		*temp_gpio;
> +	struct gpio_desc		*chan_gpio;
> +	struct gpio_desc		*clksel_gpio;
> +
> +	u16				int_vref_mv;
> +	u8				gain_index;
> +	u32				scale_avail[4][2];
> +	u8				samp_freq_index;
> +	u32				samp_freq_avail[4];
> +
> +	struct clk			*mclk;
As for fclk. Not used after the initial function that fills it in.
Just use a local variable there until you have need of it somewhere else in the driver.

> +	u32				fclk;
Not sure what fclk is for as you don't use it.

> +};
> +
> +static struct ad7191_state *ad_sigma_delta_to_ad7191(struct ad_sigma_delta *sd)
> +{
> +	return container_of(sd, struct ad7191_state, sd);

We normally just do

#define ad_sigma_delta_to_ad7191(sigmad) container_of((sigmad), struct ad7191_state, sd)

Being careful with the parameter naming to not hit that second sd.
I guess a function is fine if you strongly prefer it though.

> +}

> +
> +static const struct ad_sigma_delta_info ad7191_sigma_delta_info = {
> +	.set_channel = ad7191_set_channel,
> +	.set_mode = ad7191_set_mode,
> +	.has_registers = false,
> +	.irq_flags = IRQF_TRIGGER_FALLING,

I thought we'd fixed this up so that the irq direction can be left to the
firmware?  That is the right thing to do if the ad_sigma_delta library
works with that.

> +};

> +static int ad7191_clock_setup(struct ad7191_state *st)
> +{
> +	struct device *dev = &st->sd.spi->dev;
> +
> +	if (!device_property_present(dev, "mclk")) {
> +		gpiod_set_value(st->clksel_gpio, 1);
> +		st->fclk = AD7191_INT_FREQ_HZ;
> +		return 0;
> +	}
> +
> +	gpiod_set_value(st->clksel_gpio, 0);

Is there some sequencing requirement in here that stops you just trying
to get the clock and checking for -ENODEV to decide there isn't one?

> +
> +	st->mclk = devm_clk_get_enabled(dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> +				     "Failed to get clock source\n");
> +
> +	st->fclk = clk_get_rate(st->mclk);

st->fclk is only used in here

> +	if (!ad7191_valid_external_frequency(st->fclk))

Typically we don't consider it a drivers problem to make sure a correct clock
is wired up.  So why check here?  If it's a configurable clock we should
perhaps be setting clk_set_max_rate() but I'm not sure what that does
for a fixed rate clock.  Perhaps do some experiments just to check.
  

> +		return dev_err_probe(dev, -EINVAL,
> +				     "External clock frequency out of bounds\n");
> +
> +	return 0;
> +}
> +
> +static int ad7191_setup(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	u64 scale_uv;
> +	int gain[4] = {1, 8, 64, 128};

	const int gain[4] = { 1, 8, 64, 128 };

> +	int i;
> +	int ret;

	int i, ret;


> +
> +	ret = ad7191_init_regulators(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_init_gpios(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_clock_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	st->samp_freq_avail[0] = 120;
> +	st->samp_freq_avail[1] = 60;
> +	st->samp_freq_avail[2] = 50;
> +	st->samp_freq_avail[3] = 10;

Perhaps a few comments on what maths this is working out.

> +
> +	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> +		scale_uv = ((u64)st->int_vref_mv * NANO) >>
> +			   (indio_dev->channels[0].scan_type.realbits - 1);
> +		do_div(scale_uv, gain[i]);
> +		st->scale_avail[i][1] = do_div(scale_uv, NANO);
> +		st->scale_avail[i][0] = scale_uv;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7191_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)

Combine some of these parameters onto one line.

> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:

I'd use a guard here as well, but doesn't really matter.

> +			mutex_lock(&st->lock);
> +			*val = st->scale_avail[st->gain_index][0];
> +			*val2 = st->scale_avail[st->gain_index][1];
> +			mutex_unlock(&st->lock);
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_TEMP:
> +			*val = 0;
> +			*val2 = NANO / AD7191_TEMP_CODES_PER_DEGREE;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -(1 << (chan->scan_type.realbits - 1));
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val -= 273 * AD7191_TEMP_CODES_PER_DEGREE;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->samp_freq_avail[st->samp_freq_index];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad7191_set_gain(struct ad7191_state *st, u8 gain_index)
> +{
> +	u8 pga1_gpio_val, pga2_gpio_val;
> +
> +	if (!FIELD_FIT(AD7191_PGA1_MASK | AD7191_PGA2_MASK, gain_index))
> +		return -EINVAL;

As below.  Seems overkill to protect when we control the input.

> +
> +	st->gain_index = gain_index;
> +
> +	pga1_gpio_val = FIELD_GET(AD7191_PGA1_MASK, gain_index);
> +	pga2_gpio_val = FIELD_GET(AD7191_PGA2_MASK, gain_index);
> +
> +	gpiod_set_value(st->pga1_gpio, pga1_gpio_val);
> +	gpiod_set_value(st->pga2_gpio, pga2_gpio_val);
> +
> +	return 0;
> +}
> +
> +static int ad7191_set_samp_freq(struct ad7191_state *st, u8 samp_freq_index)
> +{
> +	u8 odr1_gpio_val, odr2_gpio_val;
> +
> +	if (!FIELD_FIT(AD7191_ODR1_MASK | AD7191_ODR2_MASK, samp_freq_index))
> +		return -EINVAL;

Why do you need this check?  Haven't you already explicitly matched to get
the samp_freq_index?

> +
> +	st->samp_freq_index = samp_freq_index;
> +
> +	odr1_gpio_val = FIELD_GET(AD7191_ODR1_MASK, samp_freq_index);
> +	odr2_gpio_val = FIELD_GET(AD7191_ODR2_MASK, samp_freq_index);
> +
> +	gpiod_set_value(st->odr1_gpio, odr1_gpio_val);
> +	gpiod_set_value(st->odr2_gpio, odr2_gpio_val);
> +
> +	return 0;
> +}
> +
> +static int ad7191_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	int ret, i;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = -EINVAL;
> +		mutex_lock(&st->lock);
	case IIO_CHAN_INFO_SCALE: {

		ret = -EINVAL;

		guard(mutex)(&st->lock);
		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
			if (val != st->scale_avail[i][1])
				continue;
			ret = ad7191_set_gain(st, i);
			break;
		}
		
Maybe also factor out the switch statement into __ad7191_write_raw()
so that you can do direct returns to simplify the code and still always
release the direct mode claim.


			
> +		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
> +			if (val2 == st->scale_avail[i][1]) {
> +				ret = ad7191_set_gain(st, i);
> +				break;
> +			}
> +		mutex_unlock(&st->lock);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!val) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		mutex_lock(&st->lock);
> +		for (i = 0; i < ARRAY_SIZE(st->samp_freq_avail); i++)
> +			if (val == st->samp_freq_avail[i]) {
> +				ret = ad7191_set_samp_freq(st, i);
> +				break;
> +			}
> +		mutex_unlock(&st->lock);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}

> +
> +#define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _type, \

Do you ever use ->address?  If not, don't set it.

> +	_differential, _mask_type_av) \
> +	{ \
> +		.type = (_type), \
> +		.differential = _differential, \
> +		.indexed = 1, \
> +		.channel = (_channel1), \
> +		.channel2 = (_channel2), \
> +		.address = (_address), \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_OFFSET), \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.info_mask_shared_by_type_available = (_mask_type_av), \
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.scan_index = (_si), \
> +		.scan_type = { \
> +			.sign = 'u', \
> +			.realbits = 24, \
> +			.storagebits = 24, \
> +			.endianness = IIO_BE, \
> +		}, \
> +	}
> +
> +#define AD719x_DIFF_CHANNEL(_si, _channel1, _channel2, _address) \
> +	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, IIO_VOLTAGE, 1, \
> +		BIT(IIO_CHAN_INFO_SCALE))
> +
> +#define AD719x_TEMP_CHANNEL(_si, _address) \
> +	__AD719x_CHANNEL(_si, 0, -1, _address, IIO_TEMP, 0, 0)

Channel 2 isn't used, but setting it to -1 is odd. Given there
is only one of this type I'd just put the full structure setup inline where
you use this macro.

Actually given there are only 2 ADC channels. I'd put those in inline as well.
Slightly more duplication but no need to figure out the macros to see what
ends up where.  Injecting the chanenl number in the TEMP_CHANNEL macro for
instance makes little sense

i.e.
static const struct iio_chan_spec ad7191_channels[] = {
	{
		.type = IIO_TEMP,
//no obvious reason to index temp.
		.address = AD7191_CH_TEMP,
		.info_mask_separate = ...
	}, {
		.type = IIO_VOLTAGE,
		.differential = 1,
		.indexed = 1,
//unusual to index from 1 but not technically wrong.  Just unusual.
		.channel = 1,
		.channel = 2,
etc


> +
> +static const struct iio_chan_spec ad7191_channels[] = {
> +	AD719x_TEMP_CHANNEL(0, AD7191_CH_TEMP),
> +	AD719x_DIFF_CHANNEL(1, 1, 2, AD7191_CH_AIN1_AIN2),
> +	AD719x_DIFF_CHANNEL(2, 3, 4, AD7191_CH_AIN3_AIN4),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static int ad7191_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ad7191_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!spi->irq) {
> +		dev_err(dev, "no IRQ?\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	mutex_init(&st->lock);
For new drivers, I'd prefer we use
	ret = devm_mutex_init(&st->lock);
	if (ret)
		return ret;

It only does anything useful in a tiny number of debug cases, but now we
have that autocleanup, we might as well do it.

> +
> +	indio_dev->name = AD7191_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad7191_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7191_channels);
> +	indio_dev->info = &ad7191_info;
> +
> +	ad_sd_init(&st->sd, indio_dev, spi, &ad7191_sigma_delta_info);
> +
> +	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_setup(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad7191_of_match[] = {
> +	{
> +		.compatible = "adi,ad7191",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7191_of_match);
> +
> +static struct spi_driver ad7191_driver = {
> +	.driver = {
> +		.name	= AD7191_NAME,
> +		.of_match_table = ad7191_of_match,
> +	},
> +	.probe		= ad7191_probe,

Given alignment never works well (as seen for name and of_match_table
just don't do it at all.  One space before = rather than tabs is fine.

Need the id_table as well for autoprobing to work (I think that is
still true for SPI).

> +};
> +module_spi_driver(ad7191_driver);
> +
> +MODULE_AUTHOR("Alisa-Dariana Roman <alisa.roman@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7191 ADC");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);


