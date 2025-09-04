Return-Path: <linux-iio+bounces-23714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C88B43D63
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 15:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE27A7C3FB7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB24303C9D;
	Thu,  4 Sep 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKRN3AkH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF62629C;
	Thu,  4 Sep 2025 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992985; cv=none; b=t+nVExi/f7di9WFZPrzhRc4C7KwctJxQ/+HSZN4dlTodWUXyvbFPtKouiJE7n7OuMNVe2IQmen+WF0nldbQHsnfIbXiW6wJ2aNYrMu6b8HGvO2xiOl5UnToASuGnL7bL6MhbQpt5SvOz7oa8DA/UYDptyEnl4sOinz5Xu8RsMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992985; c=relaxed/simple;
	bh=TiOuqBeVJygk4aY0wrM/xxlmUMCcvt2l9zB12toud4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI3Ts0UjaRwjngVyG5+nGSbFYlF0xrPCWapDB57AK8mAyN8KrUXVnPJIgOCyDO6YE3PklgjoL2bC/Ugf7sMC6EIcVHm1Gc3s7Dl5Tu+Ildi5KQJ3D15daSdH7kw+dcL3eDve96xQw/binFSg+2fp0vBDRsASOHeHMSHJQQFxKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKRN3AkH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756992983; x=1788528983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TiOuqBeVJygk4aY0wrM/xxlmUMCcvt2l9zB12toud4E=;
  b=SKRN3AkHhRmegEa18HgJ7dQHa7do1ek5S7LF3QTISuVUd5x3AWiuLfid
   uKVHyyc6958uEmgK2iB53QxOnVVXKytkeW+Tr8aBm/oFuiqCne6H0EQAo
   mspuecB0v9oSAoTAHEKUBCJpMJPeBkDDQd6J3IYJw13ZIMxihgDXi4pqL
   ciUlPgTyb/ntObnhINjeH/0oU/T4XWSJbl7ocIxEAm7nNfKezVNy+Nuj4
   EfMusTJ2wlWTVDXDHZMbDzVPLR2G+lOc1L8/74xBqnL0tdsQBjLSnHXp1
   7UaMT42X1ZP/9M9yu6N0iS1VemPllP4j+6AU0vkYwNXbcp4ODx0mZHjvL
   g==;
X-CSE-ConnectionGUID: Qht1AMVpQOOyybz08P9/zQ==
X-CSE-MsgGUID: nvFrPkNITz6JbCp6YwhL7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70426669"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70426669"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:36:21 -0700
X-CSE-ConnectionGUID: dUOgLSaRS6mmqVk9h+dXqA==
X-CSE-MsgGUID: 06UZQSg/SxOlKs4DqVJvag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="202741001"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:36:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uuA8K-0000000BHR6-3I7V;
	Thu, 04 Sep 2025 16:36:12 +0300
Date: Thu, 4 Sep 2025 16:36:12 +0300
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
	Herve Codina <herve.codina@bootlin.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <aLmVzDB4bk-z5d16@smile.fi.intel.com>
References: <cover.1756988028.git.mazziesaccount@gmail.com>
 <facc8b9255a754f767807b7e5c79c0eb20c680e4.1756988028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facc8b9255a754f767807b7e5c79c0eb20c680e4.1756988028.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 04, 2025 at 03:36:46PM +0300, Matti Vaittinen wrote:
> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> 
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> 
> The IC does also support CRC but it is not implemented in the driver.

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
> + */

I don't know how to read this comment. In the monospace font the whole block
looks like a mess.

...

> +static int _get_gpio_reg(unsigned int offset, unsigned int base)
> +{
> +	int regoffset = offset / 8;
> +
> +	if (offset > 31 || offset < 0)

So, < 0 is now unneeded and offset > 31 can be rewritten as

	if (regoffset >= 4)

which is more clear to me (like we have 4 banks and here is the check for
the bank. Maybe you can even call the variable 'bank'.

> +		return -EINVAL;
> +
> +	return base - regoffset;
> +}

...

> +#define GET_GPIO_BIT(offset) BIT((offset) % 8)

I suggest to make it to be a returned parameter of _get_gpio_reg(). This will
give better code generation on some architectures, see, for example, this
commit: 9b3cd5c7099f regmap: place foo / 8 and foo % 8 closer to each other.

...

> +static const struct regmap_access_table bd79112_volatile_regs = {
> +	.yes_ranges = &bd71815_volatile_ro_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(bd71815_volatile_ro_ranges),

+ array_size.h
(and btw we put generic asm/* _after_ generic linux/*, just noticed that).

> +};

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
> +	default:
> +		return -EINVAL;
> +	}

> +

Unneeded blank line.

> +}

...

> +static int bd79112_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +				     unsigned long *bits)
> +{
> +	struct bd79112_data *data = gpiochip_get_data(gc);
> +	unsigned long i, bank_mask;
> +
> +	for_each_set_clump8(i, bank_mask, mask, /* gc->ngpio */ 32) {

Hmm... Why constant and not gc->ngpio?

> +		unsigned long bank_bits;
> +		unsigned int reg;
> +		int ret;

> +		if (bank_mask) {

This is a duplication, the iterator only gives non-zero "clumps".

> +			bank_bits = bitmap_get_value8(bits, i);
> +			reg = BD79112_REG_GPO_VALUE_A0_A7 - i / 8;
> +			ret = regmap_update_bits(data->map, reg, bank_mask,
> +						 bank_bits);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

...

> +static int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)
> +{
> +	int i, gpio_channels;
> +
> +	/*
> +	 * Let's initialize the mux config to say that all 32 channels are
> +	 * GPIOs. Then we can just loop through the iio_chan_spec and clear the
> +	 * bits for found ADC channels.
> +	 */
> +	gpio_channels = GENMASK(31, 0);

This is negative number, it might bait one at a surprising time. Hence once
again, why not make them unsigned?

> +	for (i = 0; i < num_channels; i++)
> +		gpio_channels &= ~BIT(cs[i].channel);
> +
> +	return gpio_channels;
> +}

...

> +/* ADC channels as named in the data-sheet */
> +static const char * const bd79112_chan_names[] = {
> +	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A",	/* 0 - 4 */
> +	"AGIO5A", "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A",	/* 5 - 9 */
> +	"AGIO10A", "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A",	/* 10 - 14 */
> +	"AGIO15A", "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",	/* 15 - 19 */
> +	"AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B", "AGIO8B",	/* 20 - 24 */
> +	"AGIO9B", "AGIO10B", "AGIO11B", "AGIO12B", "AGIO13B",	/* 25 - 29 */
> +	"AGIO14B", "AGIO15B",					/* 30 - 31 */

O-o-key, but why not power-of-two per line (esp. taking into account
the whole size)? (Whatever, it's not something I would fight for.)

> +};

...

> +	data->vref_mv = ret / 1000;

Yeah, mV, (MICRO / MILLI) and other things I leave to other people to discuss.


...

> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
> +						    BD79112_MAX_NUM_CHANNELS - 1,
> +						    &cs);
> +	if (ret < 0) {

> +		/* Register all pins as GPIOs if there are no ADC channels */
> +		if (ret == -ENOENT)
> +			goto register_gpios;

As I showed this can be checked before other case, but I kinda have an idea why
you are liking to do it this way.

> +		return ret;
> +	}

...

> +register_gpios:
> +	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> +					  iio_dev->num_channels);
> +
> +	/* If all channels are reserved for ADC, then we're done. */

I still consider the assignment to be located here is a better place,
but I leave it to maintainers.

> +	if (!gpio_pins)
> +		return 0;

-- 
With Best Regards,
Andy Shevchenko



