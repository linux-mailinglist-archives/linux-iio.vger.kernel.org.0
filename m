Return-Path: <linux-iio+bounces-26533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBCCC91560
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 09:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81C9B4E26E1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E432FD7A4;
	Fri, 28 Nov 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V38pDrvM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF12FD663;
	Fri, 28 Nov 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320361; cv=none; b=Eh11cSO1XUI4kcGN038OjgiRrJPS97Mh57I9x076COaS28FMoqMLDlgnLgzj+DlEyF25NOMXFJpg4npMDKJooLnUHmEXEWNklNwqX+G7x+CCSC3gWykt7+m2cyJHmB8aynL7kNeKRdgV/Uz91opYFz3/DOR1xWYNcXytp9Kr/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320361; c=relaxed/simple;
	bh=BcwiDEmC8N2vVl7fueE9q/rVoQY1xcAvuCXVCjvcyCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJlH8d0gRcwQKtFbluBh0995sRbraJABCmIXnZZpJFVPzu02iHIZfuOyXlMLj/0958UdJT2gJW/26X8bo5HqQqa5dXpzijyLdLoOZfkg4L4B6FOy5N+TiTSkXRFhUIBWjPEpkvezRN35HMNPEgZX4rFdZExMRsp3ee25ay0djb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V38pDrvM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764320359; x=1795856359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BcwiDEmC8N2vVl7fueE9q/rVoQY1xcAvuCXVCjvcyCQ=;
  b=V38pDrvMOnoAWQHmdOSqs8CrKfjyxUm3ShgrQO9oCxhx+No7yzYO/obJ
   0yZAxGPO14itrON/o2j/ViTyz6nKATCy7wkWvazYhwxfqp4x3fjGEcA1v
   /+OUBWzyaISmDfHjOHHYWAOZNXv9g//Myh4lLrM6yRkGvf6ZfsvhJrMAv
   oEAYatJ7wjVOKt/KrnmwjFQnWTgAgOtmJhYD6u0sorqIGdBIDtAmehbue
   dkrN03Xw1r9iR1J9TvOt84K0Ke5enJjWNfBBLAhmwAbT8xMQbfPNW5HVu
   G3eTpJEpgAgay6geIOEYseJSrmILLEb4/WuLz4bXKc/cjOXrFWZ6FdgDC
   g==;
X-CSE-ConnectionGUID: D1BjAxKUQCqbSD0Hmo35hw==
X-CSE-MsgGUID: cAAHX5EMRiukjBFR3U2IVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="70212703"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="70212703"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 00:59:18 -0800
X-CSE-ConnectionGUID: jccp8oQqSQeloVl9zydeYg==
X-CSE-MsgGUID: w5tKQi2pRqSw7UjUsSOFAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="193418807"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.154])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 00:59:14 -0800
Date: Fri, 28 Nov 2025 10:59:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aSlkXohXoYehTldX@smile.fi.intel.com>
References: <20251128-honeywell_abp2_driver-v2-0-7053748aecf7@subdimension.ro>
 <20251128-honeywell_abp2_driver-v2-2-7053748aecf7@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-honeywell_abp2_driver-v2-2-7053748aecf7@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 28, 2025 at 05:13:27AM +0200, Petre Rodan wrote:

Thanks for the update, my comments below.

> Adds driver for digital Honeywell ABP2 series of board mount
> pressure and temperature sensors.
> 
> This driver covers 113 different pressure ranges and units on
> both i2c and SPI buses.
> 
> The communication protocol involves sending two simple commands
> to the sensor and there is no register access or a memory map.
> For this reason the regmap API was not used.
> 
> The i2c address is hardcoded and depends on the part number.
> 
> Optional end of conversion interrupt control is present on the
> i2c variants of the chips.
> The EOC can also be defined for the SPI variants if a non-ABP2
> but compatible chip is to be driven.
> 
> Tested on two different sensors.

I think since you mentioned this it may be valuable to spell out the exact
models of the sensors.

...

> +config ABP2030PA
> +	tristate
> +
> +config ABP2030PA_I2C
> +	tristate "Honeywell ABP2 pressure sensor series I2C driver"
> +	depends on I2C
> +	select ABP2030PA

> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

Move these two to the core symbol above

> +	help
> +	  Say Y here to build I2C bus support for the Honeywell ABP2
> +	  series pressure and temperature digital sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called abp2030pa_i2c and you will also get abp2030pa
> +	  for the core module.
> +
> +config ABP2030PA_SPI
> +	tristate "Honeywell ABP2 pressure sensor series SPI driver"
> +	depends on SPI_MASTER
> +	select ABP2030PA

> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

Ditto.

> +	help
> +	  Say Y here to build I2C bus support for the Honeywell ABP2
> +	  series pressure and temperature digital sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called abp2030pa_spi and you will also get abp2030pa
> +	  for the core module.

...

> +enum abp2_variants {

> +	ABP2_VARIANTS_MAX

Not really needed. See below how.

> +};

...

> +/* All min max limits have been converted to pascals */
> +static const struct abp2_range_config abp2_range_config[ABP2_VARIANTS_MAX] = {

The _MAX is not helpful as it doesn't prevent having missed lines (they all
will be nullified). The only difference is potential out of boundary access.
But we may prevent that from happening by simply adding a static_assert() below
(after this initialiser):

static_assert(ARRAY_SIZE(abp2_triplet_variants) == ARRAY_SIZE(abp2_range_config));

This will guarantee no out-of-boundary access, See also below for the last use
of _MAX and how we can get rid of it.

> +};

> +static int abp2_get_measurement(struct abp2_data *data)
> +{
> +	struct device *dev = data->dev;
> +	int ret;

> +	memset(data->rx_buf, 0, sizeof(data->rx_buf));

Do we really need this so early?

> +	reinit_completion(&data->completion);
> +
> +	ret = data->ops->write(data, ABP2_CMD_SYNC, ABP2_PKT_SYNC_LEN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * either use the EOC interrupt if it was enabled or
> +	 * wait 5ms for the conversion

/*
 * Please, respect English grammar and punctuation
 * in the multi-line comments. Use this as an example.
 * Check all comments in your code to follow.
 */

> +	 */
> +	if (data->irq > 0) {
> +		ret = wait_for_completion_timeout(&data->completion, HZ);
> +		if (!ret) {
> +			dev_err(dev, "timeout waiting for EOC interrupt\n");
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		fsleep(5 * USEC_PER_MSEC);
> +	}

I would expect the memset() to be here.

> +	ret = data->ops->read(data, ABP2_CMD_NOP, ABP2_PKT_NOP_LEN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * status byte flags

Status

> +	 *  bit7 SANITY_CHK     - must always be 0
> +	 *  bit6 ABP2_ST_POWER  - 1 if device is powered
> +	 *  bit5 ABP2_ST_BUSY   - 1 if device has no new conversion ready
> +	 *  bit4 SANITY_CHK     - must always be 0
> +	 *  bit3 SANITY_CHK     - must always be 0
> +	 *  bit2 MEMORY_ERR     - 1 if integrity test has failed
> +	 *  bit1 SANITY_CHK     - must always be 0
> +	 *  bit0 MATH_ERR       - 1 during internal math saturation err

err --> error

> +	 */
> +
> +	if (data->rx_buf[0] == (ABP2_ST_POWER | ABP2_ST_BUSY))
> +		return -EBUSY;
> +
> +	if (data->rx_buf[0] != ABP2_ST_POWER) {
> +		dev_err(data->dev,
> +			"unexpected status byte 0x%02x\n", data->rx_buf[0]);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

...

> +static irqreturn_t abp2_trigger_handler(int irq, void *private)
> +{
> +	int ret;
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct abp2_data *data = iio_priv(indio_dev);
> +
> +	ret = abp2_get_measurement(data);
> +	if (ret < 0)
> +		goto err;

The rule of thumb is to make label named after the answer to Q:
"what will happen if I goto $LABEL?"

It's definitely not an error outcome, and something more is going on there.

> +	data->scan.chan[0] = get_unaligned_be24(&data->rx_buf[1]);
> +	data->scan.chan[1] = get_unaligned_be24(&data->rx_buf[4]);
> +
> +	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
> +				    iio_get_time_ns(indio_dev));
> +
> +err:

That said, the

out_notify_done:

is much better name.

> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

...

> +int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
> +{
> +	int ret;
> +	struct abp2_data *data;
> +	struct iio_dev *indio_dev;
> +	const char *triplet;
> +	s64 tmp;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +	data->ops = ops;
> +	data->irq = irq;
> +
> +	init_completion(&data->completion);
> +
> +	indio_dev->name = "abp2030pa";
> +	indio_dev->info = &abp2_info;
> +	indio_dev->channels = abp2_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(abp2_channels);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "can't get and enable vdd supply\n");

Taking into account below I think it's fine to put this on a single line.

> +	ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> +					  &triplet);
> +	if (ret) {
> +		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
> +					       &data->pmin);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				   "honeywell,pmin-pascal could not be read\n");

Indent properly, and no, it's not a problem if string literal goes way after 80
limit. For them it was an exception made more than 10 years ago.

> +		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> +					       &data->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				   "honeywell,pmax-pascal could not be read\n");

Ditto.

> +	} else {
> +		ret = device_property_match_property_string(dev,
> +						   "honeywell,pressure-triplet",
> +						   abp2_triplet_variants,

> +						   ABP2_VARIANTS_MAX);

ARRAY_SIZE()

> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +				     "honeywell,pressure-triplet is invalid\n");

Fix indentation.

> +		data->pmin = abp2_range_config[ret].pmin;
> +		data->pmax = abp2_range_config[ret].pmax;
> +	}
> +
> +	if (data->pmin >= data->pmax)

> +		return dev_err_probe(dev, -EINVAL,
> +				     "pressure limits are invalid\n");

Like the above, put it on one line, it's only 84 characters long.

> +	data->outmin = abp2_func_spec[data->function].output_min;
> +	data->outmax = abp2_func_spec[data->function].output_max;

> +	tmp = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
> +		      data->outmax - data->outmin);
> +	data->p_scale = div_s64_rem(tmp, NANO, &data->p_scale_dec);
> +
> +	tmp = div_s64((s64)data->pmin * (s64)(data->outmax - data->outmin),
> +		      (s64)(data->pmax - data->pmin)) - (s64)(data->outmin);
> +	data->p_offset = tmp;

Make a temporary variable for subtractions:

	s64 odelta, pdelta;
	...

	/*
	 * Comment here to explain the calculations and perhaps a reference to
	 * the Chapter / Section in the Datasheet.
	 */
	odelta = data->outmax - data->outmin;
	pdelta = data->pmax - data->pmin;

	data->p_scale = div_s64_rem(div_s64(pdelta * NANO, odelta), NANO, &tmp);
	data->p_scale_dec = tmp;

	data->p_offset = div_s64(odelta * data->pmin), pdelta) - data->outmin;

(double check the variable and parameter types to be correct).

> +	if (data->irq > 0) {
> +		ret = devm_request_irq(dev, data->irq, abp2_eoc_handler,

> +				       IRQF_TRIGGER_RISING,

This is not good. What's wrong with the firmware description?

> +				       dev_name(dev),
> +				       data);

There is room for other parameters on the previous lines.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					  "request irq %d failed\n", data->irq);
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      abp2_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "iio triggered buffer setup failed\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "unable to register iio device\n");

One line (82 characters)

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



