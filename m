Return-Path: <linux-iio+bounces-8738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D0895D609
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 21:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3261F23E71
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B461922F0;
	Fri, 23 Aug 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwVj9nkw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774D8F6B;
	Fri, 23 Aug 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724441117; cv=none; b=Xjd5uVljwrR7hMV2yGA7llSfMxtEfZAN1coOlZwcvxU+iP2o+sYHNnxNzU8xM5yaP83qsG8tHn8gf2T6ZiuyItp+NpEx3VwvTd4jdpO4k/HmjTUmqDlnVcj94g50vcytWFFJAnkfte0qAjAaB07Os8AKzFVzB4VMnCZcOEeiXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724441117; c=relaxed/simple;
	bh=DFlFWR7lXMyjsZyyLCuvccHNpt67WGrdixy/Ulp6tTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3yPFzRI5aStpTZulRVIo3EVaGl5uDAHLq9K3yWBbMvmFvsRAzD4B047mpWT5MCMIxGvDV9JjwB+vDUt3gf7206sUyw+AdI/Ehw+23R3bzGPGtU+vbumXUL+0HmqtuANKI4XNVyP7mtLF0IlPfIZ1K7aO5LkQ4oQYOVsHxLpaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwVj9nkw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724441116; x=1755977116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DFlFWR7lXMyjsZyyLCuvccHNpt67WGrdixy/Ulp6tTA=;
  b=QwVj9nkwzvTCPI0pj6fbnAstJAobG740cmkAtXTNnp1rvJwPoxFa0ZhH
   gTsB1byGtuuiKU9rN9u9igSDCfYqd03WqQaz8kQDjP1gvSbOuAZiuQYEF
   wtjzRhQgf2jak5+98cVupwfW2Kv/3Jh1WSUq04BSHyhwrllRi1ZAGBzSR
   UNjpNSnT3qBI7Ja+i8QEuYO30tY2xwv3/B963BMP9irpxHw6/ZqkjwnT5
   fCTYI81F0Ddab/E3bBV33tTSUDHSGNDLMeWsa96QVeIKJxXlv6IiwJwYu
   8oYpxVyyO7o5jWIao3BYpsnqGwUHS4y8nDIg/mv/s4ozC/Q/ak5SsxtVE
   w==;
X-CSE-ConnectionGUID: MtKvJTP0RjCBNl1DVvulfQ==
X-CSE-MsgGUID: nroJss6hSPO5glxeYYU1vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="25821208"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="25821208"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:25:10 -0700
X-CSE-ConnectionGUID: uPUZA1ArRSi0UnqKNpqUJA==
X-CSE-MsgGUID: sX/8HsmNTFq89skPVLyMbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="66699466"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:25:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shZu9-000000010IY-2PdN;
	Fri, 23 Aug 2024 22:25:01 +0300
Date: Fri, 23 Aug 2024 22:25:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <ZsjiDaZjcA-oopWB@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-5-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181714.64545-5-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 08:17:11PM +0200, Vasileios Amoiridis wrote:
> This commit adds forced mode support in sensors BMP28x, BME28x, BMP3xx
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

> +static const u8 bmp280_operation_mode[] = { BMP280_MODE_SLEEP,
> +					    BMP280_MODE_FORCED,
> +					    BMP280_MODE_NORMAL };

Better style is

static const u8 bmp280_operation_mode[] = {
	BMP280_MODE_SLEEP, BMP280_MODE_FORCED, BMP280_MODE_NORMAL,
};

Also note comma at the end.

...

> +static int bmp280_wait_conv(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret, meas_time;
> +
> +	meas_time = BMP280_MEAS_OFFSET;
> +
> +	/* Check if we are using a BME280 device */
> +	if (data->oversampling_humid)
> +		meas_time += (1 << data->oversampling_humid) * BMP280_MEAS_DUR +

		BIT(data->oversampling_humid)

> +			       BMP280_PRESS_HUMID_MEAS_OFFSET;

> +	/* Pressure measurement time */
> +	meas_time += (1 << data->oversampling_press) * BMP280_MEAS_DUR +

Ditto.

> +		      BMP280_PRESS_HUMID_MEAS_OFFSET;

> +	/* Temperature measurement time */
> +	meas_time += (1 << data->oversampling_temp) * BMP280_MEAS_DUR;

Ditto.

> +	usleep_range(meas_time, meas_time * 12 / 10);

fsleep() ?

> +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to read status register\n");
> +		return ret;
> +	}
> +	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
> +		dev_err(data->dev, "Measurement cycle didn't complete\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

...

> +static const u8 bmp380_operation_mode[] = { BMP380_MODE_SLEEP,
> +					    BMP380_MODE_FORCED,
> +					    BMP380_MODE_NORMAL };

As per above.

...

> +static int bmp380_wait_conv(struct bmp280_data *data)
> +{

As per above comments against bmp280_wait_conv().

> +	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to read status register\n");
> +		return ret;
> +	}

> +

Choose one style (with or without blank line), as in the above you have no
blank line in the similar situation.

> +	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
> +	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

...

> +		usleep_range(data->start_up_time, data->start_up_time + 500);

fsleep() ? Comment?

...

> +static const u8 bmp580_operation_mode[] = { BMP580_MODE_SLEEP,
> +					    BMP580_MODE_FORCED,
> +					    BMP580_MODE_NORMAL };

As per above.

...

> +	switch (mode) {
> +	case BMP280_SLEEP:
> +		break;
> +	case BMP280_FORCED:
> +		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
> +				      BMP580_DSP_IIR_FORCED_FLUSH);
> +		if (ret) {
> +			dev_err(data->dev,
> +				"Could not flush IIR filter constants.\n");
> +			return ret;
> +		}
> +		break;
> +	case BMP280_NORMAL:
> +		break;

Can be unified with _SLEEP case.

> +	default:
> +		return -EINVAL;
> +	}

...

> +static int bmp580_wait_conv(struct bmp280_data *data)
> +{
> +	/*
> +	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
> +	 * characteristics

Missing period.

> +	 */
> +	static const int time_conv_press[] = { 0, 1050, 1785, 3045, 5670, 10920, 21420,
> +					42420, 84420};
> +	static const int time_conv_temp[] = { 0, 1050, 1105, 1575, 2205, 3465, 6090,
> +				       11340, 21840};

Please, start values on the next line after {. Also make }; to be on a separate line.

> +	int meas_time;
> +
> +	meas_time = 4000 + time_conv_temp[data->oversampling_temp] +
> +			   time_conv_press[data->oversampling_press];

4 * USEC_PER_MSEC ?

> +	usleep_range(meas_time, meas_time * 12 / 10);

Comment? fsleep() ?

> +	return 0;
> +}

...

> +	usleep_range(2500, 3000);

fsleep() ?

-- 
With Best Regards,
Andy Shevchenko



