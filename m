Return-Path: <linux-iio+bounces-23647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E89DBB4067D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A089516EED7
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7386A2F998B;
	Tue,  2 Sep 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHC3uYQF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D01853;
	Tue,  2 Sep 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822572; cv=none; b=HGT0nYiE6Ae0MpsgYCKCu7xnYWwhKg4UWCnm/kOxpjvigVdVP4auCxLpfSjN6u/E+jQpfbftkzcam1VutbUvWM0ZJkqKO9iZHGn2go1Ke4X8nEGmsydj3fK6I02+oGHxIg6OeQJ/K+eveEcrS/yP2KkLZg2rQ2eQSYP8xL/MqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822572; c=relaxed/simple;
	bh=7TU9tNR9LvDFvKfLsU5yop3VKPtA4Y+x1+EDMFNEkVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z12s/4M3PPDAaxrALCupvR0g1ESk80LJrgDKP9XybTTGcqfXPdZPzBG52MgFolST4gV6kRf5bdHbKwmGYWeoREVDk9FkEA7tlDTqFWlMn7uWza/AAiANkmltDoDU3fMBr/6Fl5obLpNA36ubsFANE9lOWMPuPp15aZ3eaMfa+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHC3uYQF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756822569; x=1788358569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7TU9tNR9LvDFvKfLsU5yop3VKPtA4Y+x1+EDMFNEkVs=;
  b=nHC3uYQFcUnhfawshryCw3F5pz/VKOYoKRx0DuRmauCUTHmI+3sZQmNW
   7sJlhhmjwCajkBOwCVPZrhJcmfAj/nVdaO0dwuZsstEiSlmjdkrPr3Cqd
   NiH8I8lb1/ONgOQgVUMAQZKeTkIjAC7hbrsOBNTYc8MzUFcUJC77T3t+7
   cGpUO0XBKidsEX+almSsjIGAkb91D6FCAKgfQ1Tzi4B9hQPyj685iUKmr
   KUfMfPCuh/pDtIJ6gz9n4mZFz83aMjdpdWagS/GDsknnq4yWZ8tWCurfI
   dKK4GSLzDdMlNUWdqoW3cieOgHFEt0AuxP1HiaMx7pWzujCmu/Mvr5+fb
   w==;
X-CSE-ConnectionGUID: 4yG2sSgrT8uwthnfiRzkZg==
X-CSE-MsgGUID: XH3JxOuSSOqeHz/IwfQmsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59036877"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59036877"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 07:16:09 -0700
X-CSE-ConnectionGUID: Pzgb8ScpQHGbgKBZ+i8E/w==
X-CSE-MsgGUID: h5FKIsMJReCuwAdVcW2L5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="202212356"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 07:16:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utRnj-0000000AiHJ-0jWu;
	Tue, 02 Sep 2025 17:15:59 +0300
Date: Tue, 2 Sep 2025 17:15:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <aLb8HuIG0XXLu653@smile.fi.intel.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 03:24:31PM +0300, Matti Vaittinen wrote:
> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> 
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> 
> The IC does also support CRC but it is not implemented in the driver.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

Incomplete list. See below (it doesn't mean I caught up all of the missing
inclusions).

...

> +struct bd79112_data {
> +	struct spi_device *spi;
> +	struct regmap *map;

> +	struct device *dev;


> +	struct gpio_chip gc;
> +	unsigned long gpio_valid_mask;
> +	unsigned int vref_mv;

Perhaps _mV to follow the actual unit spelling?
(and yes, I know that both variants are present in the kernel)

> +	struct spi_transfer read_xfer[2];
> +	struct spi_transfer write_xfer;
> +	struct spi_message read_msg;
> +	struct spi_message write_msg;
> +	/* 16-bit TX, valid data in high byte */
> +	u8 read_tx[2] __aligned(IIO_DMA_MINALIGN);

+ types.h for u8 and indirectly for __aligned.

> +	/* 8-bit address followed by 8-bit data */
> +	u8 reg_write_tx[2] __aligned(IIO_DMA_MINALIGN);
> +	/* 12-bit of ADC data or 8 bit of reg data */
> +	__be16 read_rx __aligned(IIO_DMA_MINALIGN);
> +};

...

> +#define BD79112_REG_AGIO0A		0x0

Keep it fixed-width. i.e. 0x00

> +#define BD79112_REG_AGIO15B		0x1f

...

> +#define BD79112_BIT_IO			BIT(5)

+ bits.h (but see about bitops.h below)

...

> +/*
> + * The data-sheet explains register I/O communication as follows:
> + *
> + * Read, two 16-bit sequences separated by CSB:
> + * MOSI:
> + * SCK:	| 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
> + * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
> + *
> + * MISO:
> + * SCK:	| 1 .. 8 | 9 .. 16 |
> + * data:| 8'b0   | data    |
> + *
> + * Note, CSB is shown to be released between writing the address (MOSI) and
> + * reading the register data (MISO).
> + *
> + * Write, single 16-bit sequence:
> + * MOSI:
> + * SCK:	| 1 | 2 | 3   | 4     | 5 .. 8 |
> + * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
> + *
> + * MISO:
> + * SCK:	| 1 .. 8 |
> + * data:| data   |

> + *

Stray empty line.

> + */

...

> +static int _get_gpio_reg(int offset, unsigned int base)
> +{

Why offset is signed?

> +	int regoffset = offset / 8;
> +
> +	if (offset > 31 || offset < 0)
> +		return -EINVAL;

+ errno.h (but since you use IS_ERR(), the err.h should be)

> +	return base - regoffset;
> +}

...

> +static int bd79112_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct bd79112_data *data = context;
> +	int ret;
> +
> +	if (reg & BD79112_BIT_IO)
> +		reg |= BD79112_BIT_RW;
> +
> +	data->read_tx[0] = reg;
> +
> +	ret = spi_sync(data->spi, &data->read_msg);
> +	if (!ret)
> +		*val = be16_to_cpu(data->read_rx);

asm/byteorder.h

> +
> +	if (reg & BD79112_BIT_IO)
> +		if (*val & BD79112_ADC_STATUS_FLAG)
> +			dev_err(data->dev, "ADC pin configured as GPIO\n");

Missing {}, I think one needs to refresh a memory of kernel coding style.

> +	return ret;
> +}

...

> +static int bd79112_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long m)
> +{
> +	struct bd79112_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(data->map, chan->channel, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		 *val = data->vref_mv;
> +		 *val2 = 12;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}

> +	return -EINVAL;

Why not making it default case? This is how most of the IIO drivers do.

> +}

...

> +static int bd79112_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +				     unsigned long *bits)
> +{
> +	struct bd79112_data *data = gpiochip_get_data(gc);
> +	unsigned int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		unsigned int bank_mask, reg, regval, regmask;
> +		int ret;
> +
> +		bank_mask = 0xff << 8 * i;
> +		regmask = (*mask & bank_mask) << 8 * i;

Why all this?

We have for_each_set_clump8().

> +		if (!regmask)
> +			continue;
> +
> +		reg = BD79112_REG_GPO_VALUE_A0_A7 - i;
> +		regval = (*bits & bank_mask) >> 8 * i;
> +		ret = regmap_update_bits(data->map, reg, regmask, regval);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> +static int bd79112_gpio_dir_set(struct bd79112_data *data, unsigned int offset,
> +				int dir)

Why dir is int? And why in negative case or other than _IN we switch pin to
output mode. It's dangerous default.

> +{
> +	unsigned int set_reg, clear_reg, bit;
> +	int ret;
> +
> +	bit = GET_GPIO_BIT(offset);
> +
> +	if (dir == GPIO_LINE_DIRECTION_IN) {
> +		set_reg = GET_GPI_EN_REG(offset);
> +		clear_reg = GET_GPO_EN_REG(offset);
> +	} else {
> +		set_reg = GET_GPO_EN_REG(offset);
> +		clear_reg = GET_GPI_EN_REG(offset);
> +	}

> +	ret = regmap_set_bits(data->map, set_reg, bit);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_clear_bits(data->map, clear_reg, bit);

I believe the order depends on the out-in or in-out switch.
Otherwise it might be potential glitches on input (hw) buffer.
Right now when it's not an interrupt it may be okay to don't
bother, but in general I see a potential issues with that.

> +}

...

> +static int bd79112_gpio_output(struct gpio_chip *gc, unsigned int offset,
> +			       int value)

Why value is signed?

...

> +static int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)
> +{
> +	int i, gpio_channels;

Why signed?

...

> +static int bd79112_probe(struct spi_device *spi)
> +{
> +	/* ADC channels as named in the data-sheet */
> +	static const char * const chan_names[] = {
> +		"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A", "AGIO5A",
> +		"AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",
> +		"AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A", "AGIO15A",
> +		"AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B", "AGIO4B", "AGIO5B",
> +		"AGIO6B", "AGIO7B", "AGIO8B", "AGIO9B", "AGIO10B", "AGIO11B",
> +		"AGIO11B", "AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",

Can you make all of the lines to be the same in terms of amount of entries?

> +	};

This seems to be hidden in the function while it's used for the whole life time
f the device. Why not move it outside of the function?

> +	struct bd79112_data *data;
> +	struct iio_dev *iio_dev;
> +	struct iio_chan_spec *cs;
> +	struct device *dev = &spi->dev;
> +	unsigned long gpio_pins, pin;
> +	unsigned int i;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio_dev);
> +	data->spi = spi;
> +	data->dev = dev;
> +	data->map = devm_regmap_init(&spi->dev, NULL, data, &bd79112_regmap);

You have dev, use it.

> +	if (IS_ERR(data->map))
> +		return dev_err_probe(dev, PTR_ERR(data->map),
> +				     "Failed to initialize Regmap\n");

+ dev_printk.h

> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");

> +	data->vref_mv = ret / 1000;

(MICRO / MILLI)

> +	ret = devm_regulator_get_enable(dev, "iovdd");
> +	if (ret < 0)

Does it return positive or zero on success?

> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
> +
> +	data->read_xfer[0].tx_buf = &data->read_tx[0];
> +	data->read_xfer[0].len = sizeof(data->read_tx);
> +	data->read_xfer[0].cs_change = 1;
> +	data->read_xfer[1].rx_buf = &data->read_rx;
> +	data->read_xfer[1].len = sizeof(data->read_rx);
> +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
> +
> +	data->write_xfer.tx_buf = &data->reg_write_tx[0];
> +	data->write_xfer.len = sizeof(data->reg_write_tx);
> +	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
> +
> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
> +		BD79112_MAX_NUM_CHANNELS - 1, &cs);

Hmm... Indentation can be amended.

> +	if (ret < 0) {

Why ' < 0' ?

> +		/* Register all pins as GPIOs if there are no ADC channels */
> +		if (ret == -ENOENT)
> +			goto register_gpios;
> +
> +		return ret;
> +	}

Assuming ret can't be positive this can be refactored as:

	/* Register all pins as GPIOs if there are no ADC channels */
	if (ret == -ENOENT)
		goto register_gpios;
	else if (ret)
		return ret;

I find it easier to follow.

> +	/* Let's assign data-sheet names to channels */
> +	for (i = 0; i < iio_dev->num_channels; i++) {
> +		unsigned int ch = cs[i].channel;
> +
> +		cs[i].datasheet_name = chan_names[ch];
> +	}
> +
> +	iio_dev->channels = cs;
> +	iio_dev->num_channels = ret;
> +	iio_dev->info = &bd79112_info;
> +	iio_dev->name = "bd79112";
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/*
> +	 * Ensure all channels are ADCs. This allows us to register the IIO
> +	 * device early (before checking which pins are to be used for GPIO)
> +	 * without having to worry about some pins being initially used for
> +	 * GPIO.
> +	 */
> +	for (i = 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {
> +		ret = regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to initialize channels\n");
> +	}
> +
> +	ret = devm_iio_device_register(data->dev, iio_dev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Failed to register ADC\n");
> +
> +register_gpios:
> +	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> +					  iio_dev->num_channels);

> +

Instead of leaving this rather unneeded blank line I would move above...

> +	/* We're done if all channels are reserved for ADC. */

...to be here

	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
					  iio_dev->num_channels);

> +	if (!gpio_pins)
> +		return 0;
> +
> +	/* Default all the GPIO pins to GPI */
> +	for_each_set_bit(pin, &gpio_pins, BD79112_MAX_NUM_CHANNELS) {

+ bitops.h

> +		ret = bd79112_gpio_dir_set(data, pin, GPIO_LINE_DIRECTION_IN);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to mark pin as GPI\n");
> +	}
> +
> +	data->gpio_valid_mask = gpio_pins;
> +	data->gc = bd79112_gpio_chip;
> +	data->gc.parent = dev;
> +
> +	return devm_gpiochip_add_data(dev, &data->gc, data);
> +}

-- 
With Best Regards,
Andy Shevchenko



