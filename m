Return-Path: <linux-iio+bounces-8863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B1964478
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DEB1C24355
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A133B197A7D;
	Thu, 29 Aug 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0E75JIJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3871922F6;
	Thu, 29 Aug 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934717; cv=none; b=daIdwmJ3tX+lU8mDrC9pTXJiDn5R3Yq7Mw+WEsej2l+uqP2VmYyZGLA3bZ6/ms2aoZxXR9D97ND1fjJGLTriwSFf/Hd58KtgimHNWfAs4t2vgbCx4YcnyyUOF4IVLbBkPzwDnbAR6uRZ6FPoJJmzR3XzZ5UXmQ8wY6QhI4liWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934717; c=relaxed/simple;
	bh=I0wobIVskE/c/lISqsgRHPfFf+bFzshPK5QWeEyKWz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEBuzKOle5lmwNPh51VG23OB+LoIe8ZpenmzPA+1w9oH9mM2lEZzXzvvBt+bPc+iaQKN23/aQNCG1m0JckT/azPHrpbW6d/aGadi7Gf5uwnA0SlzDxPCwPK6MmV/6wa0gkGM1syPJheN5Q1AppcbnRprfRO077EQyD37PX4H26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0E75JIJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724934716; x=1756470716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I0wobIVskE/c/lISqsgRHPfFf+bFzshPK5QWeEyKWz8=;
  b=G0E75JIJkiBY6d3WVG/YXIHON49CoQhfewG6VGJvxXJ6IBy9SLUzoPYd
   srOzq3Q5buXqCPgsmefIrbgZTbyHYzsm8SR3qyPPUuo8L3KCJAz0c4ruD
   5+tsVmAbxAz0jEWiY/phnakqesnJotwJDOhKGAybh1YOzSOJg7RSTB6MI
   tWv679uExQcGWTd1Q1wKx+orwBbCFqd1tqbdxC8D58tCZIkAK2lULYKAm
   BgBY6c+W7XnJnDpZ5dlf79F8OMdN4Po3aJeiWK0yEkpqsreaMwNoICrA/
   z5GRGXDe9DpBakBx3a/FHKQv9FOXVbSz7K7HgO+P/8msKYf1dMcvXK9D5
   Q==;
X-CSE-ConnectionGUID: 0tGP1rJARiSY2OvGFY6N0A==
X-CSE-MsgGUID: Dim7SNGVQkOwBu1drekD0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34091337"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34091337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:31:56 -0700
X-CSE-ConnectionGUID: 0B5OdKc4Sq2XvgGeWSkmYA==
X-CSE-MsgGUID: ke7Y/ypwSc+VJqBvVowcJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68340823"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:31:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjeJY-00000002zdJ-1hkK;
	Thu, 29 Aug 2024 15:31:48 +0300
Date: Thu, 29 Aug 2024 15:31:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <ZtBqNAYlZSEhd_20@smile.fi.intel.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-5-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828205128.92145-5-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 10:51:24PM +0200, Vasileios Amoiridis wrote:
> This commit adds forced mode support in sensors BMP28x, BME28x, BMP3xx

s/This commit, adds/Add/

The imperative mode is documented in Submitting Patches.

> and BMP58x. Sensors BMP18x and BMP085 are old and do not support this
> feature so their operation is not affected at all.
> 
> Essentially, up to now, the rest of the sensors were used in normal mode
> all the time. This means that they are continuously doing measurements
> even though these measurements are not used. Even though the sensor does
> provide PM support, to cover all the possible use cases, the sensor needs
> to go into sleep mode and wake up whenever necessary.
> 
> This commit, adds sleep and forced mode support. Essentially, the sensor

Déjà-vu feeling... Ah, first line is the same!

> sleeps all the time except for when a measurement is requested. When there
> is a request for a measurement, the sensor is put into forced mode, starts
> the measurement and after it is done we read the output and we put it again
> in sleep mode.
> 
> For really fast and more deterministic measurements, the triggered buffer
> interface can be used, since the sensor is still used in normal mode for
> that use case.
> 
> This commit does not add though support for DEEP STANDBY, Low Power NORMAL
> and CONTINUOUS modes, supported only by the BMP58x version.

...

> +static int bmp280_wait_conv(struct bmp280_data *data)
> +{
> +	unsigned int reg;

> +	int ret, meas_time;

Why meas_time is signed?
Also, please name it with a unit suffix

	unsigned int meas_time_us;

(and check the rest of the patch for the similar).

> +
> +

A single blank line is enough. Also check all patches for this.

> +	/* Check if we are using a BME280 device */
> +	if (data->oversampling_humid)

> +		meas_time += BIT(data->oversampling_humid) * BMP280_MEAS_DUR +
> +			       BMP280_PRESS_HUMID_MEAS_OFFSET;

Indentation issue, the same seems in all of similar expressions in this patch.

Also play with this form and check if it looks better

		meas_time += BMP280_PRESS_HUMID_MEAS_OFFSET +
			     BIT(data->oversampling_humid) * BMP280_MEAS_DUR;

(at least I found it better to read as first we apply constants, followed by
 longer variable-based calculations).

> +	/* Pressure measurement time */
> +	meas_time += BIT(data->oversampling_press) * BMP280_MEAS_DUR +
> +		      BMP280_PRESS_HUMID_MEAS_OFFSET;
> +
> +	/* Temperature measurement time */
> +	meas_time += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
> +
> +	/* Waiting time according to the BM(P/E)2 Sensor API */
> +	fsleep(meas_time);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to read status register\n");
> +		return ret;
> +	}
> +
> +	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
> +		dev_err(data->dev, "Measurement cycle didn't complete\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

...

int bmp280_chip_config(struct bmp280_data *data)

>  				BMP280_OSRS_TEMP_MASK |
>  				BMP280_OSRS_PRESS_MASK |
>  				BMP280_MODE_MASK,
> -				osrs | BMP280_MODE_NORMAL);
> +				osrs | BMP280_MODE_SLEEP);
>  	if (ret) {
>  		dev_err(data->dev, "failed to write ctrl_meas register\n");
>  		return ret;

This _feels_ like a separate change. I haven't found anything explicitly
describing it in the commit message. Did I miss it?

...

> +		/*
> +		 * According to the BMP3 Sensor API, the sensor needs 5000ms

I believe it's a typo in unit suffix.

If not, this should be very well described to explain why 5 seconds is needed.

> +		 * in order to go to the sleep mode.
> +		 */
> +		fsleep(5000);

...

> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case BMP280_SLEEP:
> +	case BMP280_NORMAL:
> +		break;
> +	case BMP280_FORCED:
> +		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
> +				      BMP580_DSP_IIR_FORCED_FLUSH);
> +		if (ret) {
> +			dev_err(data->dev,
> +				"Could not flush IIR filter constants.\n");

Temporary variable for data->dev?

> +			return ret;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> +				BMP580_MODE_MASK,
> +				FIELD_PREP(BMP580_MODE_MASK,
> +					   bmp580_operation_mode[mode]));
> +	if (ret) {
> +		dev_err(data->dev, "failed to  write power control register\n");
> +		return ret;
> +	}
> +
> +	data->op_mode = mode;
> +
> +	return 0;
> +}

...

> +static int bmp580_wait_conv(struct bmp280_data *data)
> +{
> +	/*
> +	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
> +	 * characteristics.
> +	 */
> +	static const int time_conv_press[] = {
> +		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420, 84420
> +	};

Mind the comma at the end.

And in programming hardware we quite often operate with power-of-2 things, so I
recommend to have 8 per line,

	static const int time_conv_press[] = {
		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420,		/* 0-7 */
		84420,							/* 8 */
	};

> +	static const int time_conv_temp[] = {
> +		0, 1050, 1105, 1575, 2205, 3465, 6090, 11340, 21840
> +	};

Ditto.

> +

Stray blank line. This is a definition block, we don't need blank lines in it.

> +	int meas_time;
> +
> +	meas_time = 4 * USEC_PER_MSEC + time_conv_temp[data->oversampling_temp]
> +		      + time_conv_press[data->oversampling_press];
> +
> +	/* Measurement time mentioned in Chapter 2, Table 4 of the datasheet. */
> +	fsleep(meas_time);
> +
> +	return 0;
> +}

...

>  	/* From datasheet's table 4: electrical characteristics */

With this change the comment seems odd. Can you elaborate more?

> -	usleep_range(2500, 3000);
> +	fsleep(data->start_up_time + 500);

Also, can we name it start_up_time_us?
It's fine to postpone renaming if it takes too many unrelated changes.

...

> +	usleep_range(2500, 3000);

fsleep()? Comment?

...

>  	usleep_range(data->start_up_time, data->start_up_time + 100);

This is already in the code, but maybe switching to fsleep() and adding
a comment to explain how it's calculated (based on the spec? Reference?),
so in a separate change?

-- 
With Best Regards,
Andy Shevchenko



