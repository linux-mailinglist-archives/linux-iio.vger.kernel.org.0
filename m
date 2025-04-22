Return-Path: <linux-iio+bounces-18507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F5A97014
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8FB18877BB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0724628541C;
	Tue, 22 Apr 2025 15:11:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BB1096F;
	Tue, 22 Apr 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334688; cv=none; b=eWNZmncvXLXuJ7u8wh/Cb2fR9yUsQ2Mts9+USPbZr3ehodfTo0IMMXx+gQkvuOntQAJo4w9rKuId4ugQ5/Lo6qJwys3AqAs1YuTJ5YJFwZdZivVNzJDMViGpuEjp7H/wAJB1bFyJScTV2axMW7sp9RlvtiquHIaYyi2KpJ4aFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334688; c=relaxed/simple;
	bh=xNXDzUTuTrUu2Dls8bhjT9zRT+jFoMj7N/0BCd4+A0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYk9Za/LSOw0Qw3cn//XtYC+/OW48awMbCRHJsNWzHvuS7JK3BzSrFvv0OPKA+MvHuzlkkhpe/DLRLt1smdiiOtCrxNX4JkIuIY+XU7zHdACtG8X9XjCtyvGSDkA/TUYbT9vInRFClwh3q7C3oLbCHHJLw0S14JA6Y8s+718LIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: aAtQHXbnSpK8/3wPQ9MHbQ==
X-CSE-MsgGUID: l1zEvIScSAegCZY3NC68mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46814642"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="46814642"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:11:27 -0700
X-CSE-ConnectionGUID: uv3Az2R8TJezN6uZhN//HQ==
X-CSE-MsgGUID: tcI+jmuUSIG13bJr+yuHMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="163001766"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:11:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7FHM-0000000ElFV-2XCL;
	Tue, 22 Apr 2025 18:11:20 +0300
Date: Tue, 22 Apr 2025 18:11:20 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <aAexmOU1e-7hXq6Y@smile.fi.intel.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-3-94341574240f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421-togreg-v5-3-94341574240f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 21, 2025 at 12:24:54PM +0800, Kim Seer Paller wrote:
> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/°C internal reference, which is disabled
> by default.
> 
> Support for monitoring internal die temperature, output voltages, and
> current of a selected channel via the MUXOUT pin using an external ADC
> is currently not implemented.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

I don't see how you use this. But

+ dev_printk.h

> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

...

> +#define AD3530R_SW_RESET			(BIT(7) | BIT(0))

> +#define AD3530R_MAX_CHANNELS			8
> +#define AD3531R_MAX_CHANNELS			4

Sounds to me that these two shouldn't be grouped with the rest here. Perhaps
move them out to after the LDAC_PULSE?

> +#define AD3530R_INTERNAL_VREF_MV		2500

_mV (yes, with Volts and Amperes we use proper spelling).

> +#define AD3530R_LDAC_PULSE_US			100

...

> +	int (*input_ch_reg)(unsigned int c);

c? channel?

...

> +	int vref_mv;

_mV

...

> +static int ad3530r_input_ch_reg(unsigned int c)
> +{
> +	return 2 * c + AD3530R_INPUT_CH;
> +}
> +
> +static int ad3531r_input_ch_reg(unsigned int c)
> +{
> +	return 2 * c + AD3531R_INPUT_CH;
> +}

c --> channel

...

> +static const char * const ad3530r_powerdown_modes[] = {
> +	"1kohm_to_gnd",

kOhm

> +	"7.7kohm_to_gnd",

Ditto.

> +	"32kohm_to_gnd",

Ditto.

> +};

...

> +static const struct iio_enum ad3530r_powerdown_mode_enum = {
> +	.items = ad3530r_powerdown_modes,
> +	.num_items = ARRAY_SIZE(ad3530r_powerdown_modes),

+ array_size.h

> +	.get = ad3530r_get_powerdown_mode,
> +	.set = ad3530r_set_powerdown_mode,
> +};

...

> +static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 char *buf)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +	return sysfs_emit(buf, "%d\n", st->chan[chan->channel].powerdown);

+ sysfs.h

> +}

...

> +static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int mask, val, reg;
> +	bool powerdown;
> +
> +	ret = kstrtobool(buf, &powerdown);

+ kstrtox.h

> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	mask = GENMASK(chan->address + 1, chan->address);
> +	reg = chan->channel < AD3531R_MAX_CHANNELS ?
> +	      AD3530R_OUTPUT_OPERATING_MODE_0 :
> +	      AD3530R_OUTPUT_OPERATING_MODE_1;
> +	val = (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
> +	       << chan->address;

Please, move the operator to the previous line, Or even

	... pdmode;

	pdmode = powerdown ? st->chan[chan->channel].powerdown_mode : 0;
	val = pdmode << ...;

> +	ret = regmap_update_bits(st->regmap, reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	st->chan[chan->channel].powerdown = powerdown;
> +
> +	return len;
> +}

...

> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > U16_MAX)

U16_MAX is an abstract type with this limit, do you have any predefined HW
limit instead? Probably better to use that one as defined via BIT() / GENMASK().

> +			return -EINVAL;
> +
> +		return ad3530r_dac_write(st, chan->channel, val);
> +	default:
> +		return -EINVAL;
> +	}

...

> +static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.shared = IIO_SEPARATE,
> +		.read = ad3530r_get_dac_powerdown,
> +		.write = ad3530r_set_dac_powerdown,
> +	},
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3530r_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			   &ad3530r_powerdown_mode_enum),
> +	{ }
> +};
> +
> +#define AD3530R_CHAN(_chan, _pos) {					\

Slightly better to have the curly braces on the same column as it's easier to
read.

#define AD3530R_CHAN(_chan, _pos)				\
{								\

(and make it one TAB less for the backslash).

> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = _chan,						\
> +	.address = _pos,						\
> +	.output = 1,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE),			\
> +	.ext_info = ad3530r_ext_info,					\
> +}

...

> +static int ad3530r_setup(struct ad3530r_state *st, int vref,
> +			 bool has_external_vref)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct gpio_desc *reset_gpio;
> +	int i, ret;
> +	u8 range_multiplier;

+ types.h (and especially for boolean type along with true/false definitions.

> +
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				     "Failed to get reset GPIO\n");

+ err.h

> +	if (reset_gpio) {
> +		/* Perform hardware reset */
> +		fsleep(1000);

(1 * USEC_PER_MSEC) ?

> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		/* Perform software reset */
> +		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
> +					 AD3530R_SW_RESET, AD3530R_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}

> +	fsleep(10000);

10 * USEC_PER_MSEC

With these constants it's less error prone (when 3 or more zeroes) and easier
to get the units without looking into fsleep() implementation / documentation.

> +	range_multiplier = 1;
> +	if (device_property_read_bool(dev, "adi,range-double")) {
> +		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
> +				      AD3530R_OUTPUT_CONTROL_RANGE);
> +		if (ret)
> +			return ret;
> +
> +		range_multiplier = 2;
> +	}
> +
> +	if (!has_external_vref && st->chip_info->internal_ref_support) {
> +		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
> +				      AD3530R_REFERENCE_CONTROL_SEL);
> +		if (ret)
> +			return ret;
> +
> +		st->vref_mv = range_multiplier * AD3530R_INTERNAL_VREF_MV;
> +	}
> +
> +	if (has_external_vref)
> +		st->vref_mv = range_multiplier * vref / 1000;

MILLI?


> +	/* Set operating mode to normal operation. */
> +	ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0,
> +			   AD3530R_NORMAL_OPERATION);
> +	if (ret)
> +		return ret;
> +
> +	if (st->chip_info->num_channels > AD3531R_MAX_CHANNELS) {
> +		ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1,
> +				   AD3530R_NORMAL_OPERATION);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < st->chip_info->num_channels; i++)
> +		st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
> +
> +	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->ldac_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> +				     "Failed to get ldac GPIO\n");
> +
> +	return 0;
> +}

...

> +	vref = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (vref < 0 && vref != -ENODEV)
> +		return vref;
> +
> +	has_external_vref = vref != -ENODEV;

Wouldn't be better just make this 0 when it's == -ENODEV and check just the
value without having this additional boolean variable (note, I haven't checked
the meaning of Vref == 0 in case it's possible in real life and hardware
behaves adequately)?

> +	if (!st->chip_info->internal_ref_support && !has_external_vref)
> +		return -ENODEV;

> +	ret = ad3530r_setup(st, vref, has_external_vref);
> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko



