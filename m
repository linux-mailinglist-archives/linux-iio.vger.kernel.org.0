Return-Path: <linux-iio+bounces-9074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67C96A082
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D72E281523
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B418891A;
	Tue,  3 Sep 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL8CyPot"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA217D377;
	Tue,  3 Sep 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373607; cv=none; b=NfOAc4avGyd4YBN+DWqHG4bvPmyZogvCojRiwgEqU0SuhOBGN23TP2r+G6qy9sy0RhHQLNhnys16VPDNADLK+euG55dTBzMKRs5I05GwuBBe38ROCl1Er6TJmrAvnQt6g6nFRWRL4RAOaWtJfcAyRdYWSCnPnH/QQwtOYCcp0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373607; c=relaxed/simple;
	bh=3OW9yKbvIY8C5sR5js5XCVdDweVPBC7mpgMW7jqcDiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSGrAzl+Aklx7+5Boylp0eiPr3AlAkomxXZlm0YXmczgUxkrViOLybxie3vNLbhVq4pphsykvohDqzIYJWLUyX9XtlFaThWrqPm4EUrwLpxwngyYmqWSsR5dvt4dO9RuJw9W0/EdEHBJpofMaBxn11OBdUHylrRyMI9spU4OANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gL8CyPot; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725373605; x=1756909605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3OW9yKbvIY8C5sR5js5XCVdDweVPBC7mpgMW7jqcDiE=;
  b=gL8CyPot4Snw1JuTYRwcWC6FXMui3OjJHFmYttrn5Jpf6/+6X+ENar6i
   SFwTYqQWap4bOe8vVwWTcMrNB8uDrlfBN53DF1JWn+/xT6oMlvxHPYypw
   N2u9vnuvhd/kXh5U957Hww2I2SHfsnUYMHIusqPu5cIu/AJnIxYkC/1LF
   eenanZLlTLShWT8ov7eu+rr4FPL9wHqau26GvLTwhSyChvYBfOiCejDq8
   FP7XWgA/q2YB5gkSbZ67RQ9fgFP9JFr5ulTSnmE/IPja+T+NLLjnOJs8j
   Als26+LdS6OhktzeGpBEIVgtjnkNzbdeNvgkn5su7o8wwIXwxggeCmjvU
   Q==;
X-CSE-ConnectionGUID: 4xgq4R5OSGqwdhl4DAnw8w==
X-CSE-MsgGUID: S2bsS8ElR9a4iUaZXFUwig==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24141969"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24141969"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:26:45 -0700
X-CSE-ConnectionGUID: e4AxFbz1QeWi+nLVwwV0NA==
X-CSE-MsgGUID: qnirlIZASlW37H3RipBi5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="88175236"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:26:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slUUQ-00000004jdd-2KZt;
	Tue, 03 Sep 2024 17:26:38 +0300
Date: Tue, 3 Sep 2024 17:26:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <ZtccnvhmcxyRQVuf@smile.fi.intel.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-5-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902184222.24874-5-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 02, 2024 at 08:42:19PM +0200, Vasileios Amoiridis wrote:
> Add forced mode support in sensors BMP28x, BME28x, BMP3xx and BMP58x.
> Sensors BMP18x and BMP085 are old and do not support this feature so
> their operation is not affected at all.
> 
> Essentially, up to now, the rest of the sensors were used in normal mode
> all the time. This means that they are continuously doing measurements
> even though these measurements are not used. Even though the sensor does
> provide PM support, to cover all the possible use cases, the sensor needs
> to go into sleep mode and wake up whenever necessary.
> 
> The idea is that the sensor is by default in sleep mode, wakes up in
> forced mode when a oneshot capture is requested, or in normal mode
> when the buffer is enabled. The difference lays in the fact that in
> forced mode, the sensor does only one conversion and goes back to sleep
> while in normal mode, the sensor does continuous measurements with the
> frequency that was set in the ODR registers.
> 
> The bmpX_chip_config() functions which are responsible for applying
> the requested configuration to the sensor, are modified accordingly
> in order to set the sensor by default in sleep mode.
> 
> DEEP STANDBY, Low Power NORMAL and CONTINUOUS modes, supported only by
> the BMP58x version, are not added.

...

> +static int bmp280_wait_conv(struct bmp280_data *data)
> +{
> +	unsigned int reg, meas_time_us;
> +	int ret;
> +
> +	/* Check if we are using a BME280 device */
> +	if (data->oversampling_humid)
> +		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
> +				(BIT(data->oversampling_humid) * BMP280_MEAS_DUR);

The outer parentheses are not needed.

> +	/* Pressure measurement time */
> +	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
> +			(BIT(data->oversampling_press) * BMP280_MEAS_DUR);

Ditto.

> +	/* Temperature measurement time */
> +	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
> +
> +	/* Waiting time according to the BM(P/E)2 Sensor API */
> +	fsleep(meas_time_us);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to read status register.\n");
> +		return ret;
> +	}
> +
> +	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
> +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}

...

> +static int bmp380_wait_conv(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret, meas_time_us;
> +
> +	/* Offset measurement time */
> +	meas_time_us = BMP380_MEAS_OFFSET;
> +
> +	/* Pressure measurement time */
> +	meas_time_us += BMP380_PRESS_MEAS_OFFSET +
> +		     (BIT(data->oversampling_press) * BMP380_MEAS_DUR);

Ditto.

> +	/* Temperature measurement time */
> +	meas_time_us += BMP380_TEMP_MEAS_OFFSET +
> +		     (BIT(data->oversampling_temp) * BMP380_MEAS_DUR);

Ditto.

> +	/* Measurement time defined in Datasheet Section 3.9.2 */
> +	fsleep(meas_time_us);
> +
> +	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to read status register.\n");
> +		return ret;
> +	}

> +	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
> +	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> +		return -EBUSY;
> +	}

Alternatively

	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) &&
	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
		dev_err(data->dev, "Measurement cycle didn't complete.\n");
		return -EBUSY;
	}

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
> +		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420,
> +		84420,
> +	};
> +	static const int time_conv_temp[] = {
> +		0, 1050, 1105, 1575, 2205, 3465, 6090, 11340,
> +		21840,
> +	};
> +	int meas_time_us;

> +	meas_time_us = 4 * USEC_PER_MSEC + time_conv_temp[data->oversampling_temp]
> +			 + time_conv_press[data->oversampling_press];

	meas_time_us = 4 * USEC_PER_MSEC + time_conv_temp[data->oversampling_temp] +
		       time_conv_press[data->oversampling_press];

OR

	meas_time_us = 4 * USEC_PER_MSEC +
		       time_conv_temp[data->oversampling_temp] +
		       time_conv_press[data->oversampling_press];


> +	/* Measurement time mentioned in Chapter 2, Table 4 of the datasheet. */

Since there is a constant in use (4ms) it would be nice to explain it
separately, the rest kinda obvious from the variable names.
So it allows roughly understand the timeout value without even looking into
the datasheet.

> +	fsleep(meas_time_us);
> +
> +	return 0;
> +}

...

> +	fsleep(data->start_up_time + 500);

Ditto.

Something like

	/* 500us margin for ... */

(but write the real meaning of it).

-- 
With Best Regards,
Andy Shevchenko



