Return-Path: <linux-iio+bounces-20384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9438EAD4479
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 23:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD449189C49D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB0267B0C;
	Tue, 10 Jun 2025 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4LmcS9T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95366238D56;
	Tue, 10 Jun 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589860; cv=none; b=X6bJp4D6o3VcT3QJeOEDevuF2BovhUYN0yXE5bFC/r0JHrIIHo9+z3Gx9gaXyCvehXXYVNjCJO8N0dcUtJBlY5tLR7Xdwlxz2mpIwC+Uh++DGNhF4TSxcs3PhE1vfyg0Wweyc8tjYCcwqqZoOZyUM6YCpVkTG3mezmhy6b+qyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589860; c=relaxed/simple;
	bh=x2C3j7elYh+4l29rP3CLPo9BQoCH+G2dzjBJWmUY6p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5LdQ3AUraP0AzV9tiY61Sh4+/xg+6VBeU8JHMcrfETkPy9gK9PCdBw5YTQt+vMdzvQGEXiDI7ce1H/n2ZW+zoiPg8aZnUXpospEgRhiO8SZSBI7Tz796EHvZAa+A+B/zHlj2XafbwvSBkvgHLeyJ5NJkW3SXR5Q3ZQ23lu0dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4LmcS9T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749589859; x=1781125859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x2C3j7elYh+4l29rP3CLPo9BQoCH+G2dzjBJWmUY6p0=;
  b=H4LmcS9T6u9B41M+z2RrS6VZtI8YJaXeqsMmPER4Gdj97RKvO4ELcZ+D
   l9NdM09NTtdiPADp4ZW/A7pUs0FUEIM0WTSW2swslMupqrBXtKClsmOEv
   pSqNDu29SxzsqlqSrwpiBmMdsesGopasTYzUMCa6j20NPr4hoVIL2bUeO
   0244XVRsUSzOyVWAaGjqLboFBN+9m7WhxgfLNkl/2WMs/GrMPIhxVfo86
   86KXBzdQE1NTajn006HgdNJ0Jnn85EstegGBvSkT3tAKcWlNtp6aBxoFH
   0KIrFbprXE4ULcepNSUOtmc0pG88rDltkTGKVqvI84YGovKONZeNQwPLV
   w==;
X-CSE-ConnectionGUID: c2MmMJquSaqAbp3jVzpn3g==
X-CSE-MsgGUID: m0NYwIg2SXyhHjRnsABqHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51861445"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="51861445"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 14:10:57 -0700
X-CSE-ConnectionGUID: 9vJy4H7vT9y8BoYJeVKsWQ==
X-CSE-MsgGUID: 2YwBOwSRQymsrjJ8ehXr5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="151938823"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 14:10:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uP6F7-00000005SCG-1pYf;
	Wed, 11 Jun 2025 00:10:49 +0300
Date: Wed, 11 Jun 2025 00:10:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aEifWXPV1nsIyWbT@smile.fi.intel.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 05:31:25PM -0300, Marcelo Schmitt wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> 
> The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
> analog to digital converter. The AD4170 design offers a flexible data
> acquisition solution with crosspoint multiplexed analog inputs,
> configurable ADC voltage reference inputs, ultra-low noise integrated PGA,
> digital filtering, wide range of configurable output data rates, internal
> oscillator and temperature sensor, four GPIOs, and integrated features for
> interfacing with load cell weigh scales, RTD, and thermocouple sensors.
> 
> Add basic support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Differential and pseudo-differential input configuration.

...

> +enum ad4170_ref_buf {
> +	AD4170_REF_BUF_PRE,	/* Pre-charge referrence buffer */
> +	AD4170_REF_BUF_FULL,	/* Full referrence buffering */
> +	AD4170_REF_BUF_BYPASS	/* Bypass referrence buffering */

Doesn't seem like a terminator. Please, leave trailing comma.

> +};
> +
> +enum ad4170_ref_select {
> +	AD4170_REF_REFIN1,
> +	AD4170_REF_REFIN2,
> +	AD4170_REF_REFOUT,
> +	AD4170_REF_AVDD

Ditto.

> +};

...

> +	int pins_fn[AD4170_NUM_ANALOG_PINS];

Can be negative? If so, perhaps a comment like '-1 means no assigned function'.

...

> +	return spi_write(st->spi, st->tx_buf, size + 2);

... + sizeof(reg) ?


...

> +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> +{
> +	/*
> +	 * The use of static_assert() here is to make sure that, if
> +	 * struct ad4170_setup is ever changed (e.g. a field is added to the
> +	 * struct's declaration), the comparison below is adapted to keep
> +	 * comparing each of struct ad4170_setup fields.
> +	 */

Okay. But this also will trigger the case when the field just changes the type.
So, it also brings false positives. I really think this is wrong place to put
static_assert(). To me it looks like a solving rare problem, if any.

But I leave this to the IIO maintainers.

In my opinion static_assert() makes only sense when memcmp() is being used.
Otherwise it has prons and cons.

> +	static_assert(sizeof(*a) ==
> +		      sizeof(struct {
> +				     u16 misc;
> +				     u16 afe;
> +				     u16 filter;
> +				     u16 filter_fs;
> +				     u32 offset;
> +				     u32 gain;
> +			     }));
> +
> +	if (a->misc != b->misc ||
> +	    a->afe != b->afe ||
> +	    a->filter != b->filter ||
> +	    a->filter_fs != b->filter_fs ||
> +	    a->offset != b->offset ||
> +	    a->gain != b->gain)
> +		return false;
> +
> +	return true;
> +}

...

> +	/*
> +	 * Some configurations can lead to invalid setups.
> +	 * For example, if AVSS = -2.5V, REF_SELECT set to REFOUT (REFOUT/AVSS),
> +	 * and pseudo-diff channel configuration set, then the input range
> +	 * should go from 0V to +VREF (single-ended - datasheet pg 10), but
> +	 * REFOUT/AVSS range would be -2.5V to 0V.
> +	 * Check the positive reference is higher than 0V for pseudo-diff
> +	 * channels.
> +	 */

Right, the Q is, can refp contain an error code here, rather than negative
value? The code above hints that in some case it may, but are all those cases
were caught up already? (Comment can be extended to explain this)

> +	if (refp <= 0)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "REF+ <= GND for pseudo-diff chan %u\n",
> +				     ch_reg);


...

> +{
> +	struct device *dev = &st->spi->dev;
> +	u32 aux;
> +
> +	/* Optional positive reference buffering */
> +	aux = AD4170_REF_BUF_FULL; /* Default to full precharge buffer enabled. */
> +	fwnode_property_read_u32(child, "adi,positive-reference-buffer", &aux);
> +	if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid adi,positive-reference-buffer: %u\n",
> +				     aux);

Note, if you make it like

	const char *propname;
	...
	propname = "...";

and use in both places. Alternatively can be done like

		return dev_err_probe(dev, -EINVAL, "Invalid %s %u\n",
				     "adi,positive-reference-buffer: ", aux);

This will save a few dozens of bytes in the object file and at runtime.

Same for other similar cases. And I believe I have already pointed that out.

> +
> +	setup->afe |= FIELD_PREP(AD4170_AFE_REF_BUF_P_MSK, aux);
> +
> +	/* Optional negative reference buffering */
> +	aux = AD4170_REF_BUF_FULL; /* Default to full precharge buffer enabled. */
> +	fwnode_property_read_u32(child, "adi,negative-reference-buffer", &aux);
> +	if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid adi,negative-reference-buffer: %u\n",
> +				     aux);
> +
> +	setup->afe |= FIELD_PREP(AD4170_AFE_REF_BUF_M_MSK, aux);
> +
> +	/* Optional voltage reference selection */
> +	aux = AD4170_REF_REFOUT; /* Default reference selection. */
> +	fwnode_property_read_u32(child, "adi,reference-select", &aux);
> +	if (aux > AD4170_REF_AVDD)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid reference selected %u\n",
> +				     aux);
> +
> +	setup->afe |= FIELD_PREP(AD4170_AFE_REF_SELECT_MSK, aux);
> +
> +	return 0;
> +}

...

> +static int ad4170_parse_adc_channel_type(struct device *dev,
> +					 struct fwnode_handle *child,
> +					 struct iio_chan_spec *chan)

Ditto in this function.

...

> +static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
> +				     struct fwnode_handle *child,
> +				     unsigned int chan_num)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct ad4170_chan_info *chan_info;
> +	struct ad4170_setup *setup;
> +	struct iio_chan_spec *chan;
> +	unsigned int ref_select;
> +	unsigned int ch_reg;
> +	bool bipolar;
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(child, "reg", &ch_reg);
> +	if (ret)
> +		return dev_err_probe(dev, -EINVAL,

Why not ret?

> +				     "Failed to read channel reg\n");
> +
> +	if (ch_reg >= AD4170_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Channel idx greater than no of channels\n");
> +
> +	chan = &st->chans[chan_num];
> +	*chan = ad4170_channel_template;
> +
> +	chan->address = ch_reg;
> +	chan->scan_index = ch_reg;
> +	chan_info = &st->chan_infos[chan->address];
> +
> +	chan_info->setup_num = AD4170_INVALID_SETUP;
> +	chan_info->initialized = true;
> +
> +	setup = &chan_info->setup;
> +	ret = ad4170_parse_reference(st, child, setup);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4170_parse_adc_channel_type(dev, child, chan);
> +	if (ret < 0)

What is the meaning of the positive returned value? Why is it not used?

> +		return ret;
> +
> +	bipolar = fwnode_property_read_bool(child, "bipolar");
> +	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
> +	if (bipolar)
> +		chan->scan_type.sign = 's';
> +	else
> +		chan->scan_type.sign = 'u';
> +
> +	ret = ad4170_validate_channel(st, chan);
> +	if (ret < 0)

Ditto.

> +		return ret;
> +
> +	ref_select = FIELD_GET(AD4170_AFE_REF_SELECT_MSK, setup->afe);
> +	ret = ad4170_get_input_range(st, chan, ch_reg, ref_select);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Invalid input config\n");
> +
> +	chan_info->input_range_uv = ret;
> +	return 0;
> +}

...

> +static int ad4170_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	unsigned int num_channels;

> +	unsigned int chan_num = 0;

It's better to split, so it will make code robust against potential reuse of
the same variable in between.

> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);

> +

Unneeded blank line.

> +	if (num_channels > AD4170_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = ad4170_parse_channel_node(indio_dev, child, chan_num++);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	indio_dev->num_channels = num_channels;
> +	indio_dev->channels = st->chans;
> +
> +	return 0;
> +}

...

> +	/* Assume AVSS at GND (0V) if not provided */
> +	st->vrefs_uv[AD4170_AVSS_SUP] = ret == -ENODEV ? 0 : -ret;

-ret ?!?!

Even if you know that *now* it can't have any other error code, it's quite
fragile.

-- 
With Best Regards,
Andy Shevchenko



