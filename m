Return-Path: <linux-iio+bounces-8759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84895DD8D
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCA3B21293
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5BE15F41B;
	Sat, 24 Aug 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH8s8fgc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84130154BFF;
	Sat, 24 Aug 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498971; cv=none; b=O7/63ZWFrHk1Zs+rUFhBimGHbIIUXH36HF8BME2RjUuGu1V4vdo4EKuWbXX9Kb1kyBGbQsP5l6zMCvlBv+nnMQLWod56fhuBtW1FWpsOCWk/x6tgFRt54D+wYG5p1moRMlEo4C/s4lNH1Hv5zh0EIGYVcd4TX3n+qEbWYIXFTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498971; c=relaxed/simple;
	bh=KHrgdPldxZwH+gUoGeaHFZnjdYLc8pGJbzz8198AMEc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jylMbqw816Mvsp3kI2hGjr/N+5WK1cX8CNq1Iy/Ujk5xEoSH/RJHfk4ZEk5X3HST9Z0ZJSRx2Ye69L0t/H9gpn+KDFdKSiKixugMehYkCU2NAFg6jmGlH8D+suskDB2c5GFMcbw0E/RZg/2wWmrr6G/j3mmoYpTGOEhBSg5cK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH8s8fgc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so1533936f8f.1;
        Sat, 24 Aug 2024 04:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724498968; x=1725103768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6AYBDTHwq86E9/xR+lHeYha+A1IcDpW/zRoW6FdXpk=;
        b=PH8s8fgc+IWPPRYiNK42KwTeFLJQdCWkD6VCWc+eLphzb6eqvjtoSWxN3NSRiQFpTC
         Ma9kp0xkOwWIRfjxPwC3hRfVXNfVQziKk9cK9ypsebyCrKD/+TJmIVnkEoFEyVgQ8YxV
         TpnRVLYMKmXoyFJp2gi6OgFmjuNW72/kFLhvKHt97emG0uZAwf6lrZ0wI+oH6sZaqxc8
         Com6pa/6icF4rCFY1Z2/3tvXKIRKr0XIRRa0YVAxkOq9/sd9sPkZ1+mvZMEvhjhWaIDM
         25qbN27hgnBbl2AM/hgbD4YTcNqnO4LwO7gYsusOoT9jWWMgesfyP4g7FZu8QYKbMJzP
         AwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724498968; x=1725103768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6AYBDTHwq86E9/xR+lHeYha+A1IcDpW/zRoW6FdXpk=;
        b=fjKeDYrjaX/5xLHjjAMYroE4cSrT1L7pO83zZrAt7wvl7PUvJzmdb1/jh1OKaVMp3g
         o/YbtOPHBhtl4pt+QzoLSfhA8JJLEWI7Dfzr4FewLDQojKOje9F92fecsGC02FHFW8XA
         /KGHiXDfVQTZd0yRzSz/tP4JkbCAr/57SrWoZ1PNfrH1hVsKwx9hRqTFvkiz/7AIh8a3
         cNrB4edjZq8Es9zdTSv4cFw7i4A9rU6xoTO4s9PEl4eINCz73GrNnFXOQa3soYlyuG+u
         GhKborynAQZxroJKo+qLtQftqpsA8UYiK03UAbxi+BsgV5CEBulraKkT74P3GySNDcGa
         h4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeNNTjRzFFhOsHoQBNoDH3HxlvThkD1FAJ7XWxtgBroiOLxf/a/FITr8xWSL7VzA+/vM5oG8hcRfvY@vger.kernel.org, AJvYcCVsmt0HzCI1w3/JgZ5s/uQcpeAh+bhNwhLDmeBTSgNSTqaq0OweNIrZnRQL1ZtZsNdNDoQm+gGclq9Gvcnu@vger.kernel.org, AJvYcCWqGw0qotQhJnsckV//K8ICbVTCQMbKY8AetNiNCdr0siKeL7cxG8CTSzKImkEr4jALhRCbdf7M5QJ9@vger.kernel.org
X-Gm-Message-State: AOJu0YxzIdBAtNdg1Spt6xsneYq/OSIW61h+Oaz+ryoP4BQQ3mgFRJZ2
	j6TFyyWUfeHkXDlTPN0dondQhfD+Be7T0iswkzIPwYN/6DIRVg7m1htIPXs9
X-Google-Smtp-Source: AGHT+IGXHDlzEVn/ATKk4zyvTJkyKaRLa2eJgIF6FIP7NiOZD/yzAU5p8p4MQ6Tsw/STc3Fbg2QtGg==
X-Received: by 2002:a5d:534c:0:b0:368:3789:1b6 with SMTP id ffacd0b85a97d-373118e357amr3150945f8f.47.1724498967232;
        Sat, 24 Aug 2024 04:29:27 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ffb66sm6376516f8f.84.2024.08.24.04.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:29:26 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 13:29:24 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <20240824112924.GD9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-5-vassilisamir@gmail.com>
 <ZsjiDaZjcA-oopWB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsjiDaZjcA-oopWB@smile.fi.intel.com>

On Fri, Aug 23, 2024 at 10:25:01PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 08:17:11PM +0200, Vasileios Amoiridis wrote:
> > This commit adds forced mode support in sensors BMP28x, BME28x, BMP3xx
> > and BMP58x. Sensors BMP18x and BMP085 are old and do not support this
> > feature so their operation is not affected at all.
> > 
> > Essentially, up to now, the rest of the sensors were used in normal mode
> > all the time. This means that they are continuously doing measurements
> > even though these measurements are not used. Even though the sensor does
> > provide PM support, to cover all the possible use cases, the sensor needs
> > to go into sleep mode and wake up whenever necessary.
> > 
> > This commit, adds sleep and forced mode support. Essentially, the sensor
> > sleeps all the time except for when a measurement is requested. When there
> > is a request for a measurement, the sensor is put into forced mode, starts
> > the measurement and after it is done we read the output and we put it again
> > in sleep mode.
> > 
> > For really fast and more deterministic measurements, the triggered buffer
> > interface can be used, since the sensor is still used in normal mode for
> > that use case.
> > 
> > This commit does not add though support for DEEP STANDBY, Low Power NORMAL
> > and CONTINUOUS modes, supported only by the BMP58x version.
> 
> ...
> 
> > +static const u8 bmp280_operation_mode[] = { BMP280_MODE_SLEEP,
> > +					    BMP280_MODE_FORCED,
> > +					    BMP280_MODE_NORMAL };
> 
> Better style is
> 
> static const u8 bmp280_operation_mode[] = {
> 	BMP280_MODE_SLEEP, BMP280_MODE_FORCED, BMP280_MODE_NORMAL,
> };
> 
> Also note comma at the end.
> 

Looks much better indeed, thanks!

> ...
> 
> > +static int bmp280_wait_conv(struct bmp280_data *data)
> > +{
> > +	unsigned int reg;
> > +	int ret, meas_time;
> > +
> > +	meas_time = BMP280_MEAS_OFFSET;
> > +
> > +	/* Check if we are using a BME280 device */
> > +	if (data->oversampling_humid)
> > +		meas_time += (1 << data->oversampling_humid) * BMP280_MEAS_DUR +
> 
> 		BIT(data->oversampling_humid)

ACK.

> 
> > +			       BMP280_PRESS_HUMID_MEAS_OFFSET;
> 
> > +	/* Pressure measurement time */
> > +	meas_time += (1 << data->oversampling_press) * BMP280_MEAS_DUR +
> 
> Ditto.

ACK.

> 
> > +		      BMP280_PRESS_HUMID_MEAS_OFFSET;
> 
> > +	/* Temperature measurement time */
> > +	meas_time += (1 << data->oversampling_temp) * BMP280_MEAS_DUR;
> 
> Ditto.
> 

ACK.

> > +	usleep_range(meas_time, meas_time * 12 / 10);
> 
> fsleep() ?

Could be used indeed. My concern is that fsleep uses a sleep range
between x and 2x but I don't think it is a problem since these are
oneshot captures.

> 
> > +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read status register\n");
> > +		return ret;
> > +	}
> > +	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
> > +		dev_err(data->dev, "Measurement cycle didn't complete\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static const u8 bmp380_operation_mode[] = { BMP380_MODE_SLEEP,
> > +					    BMP380_MODE_FORCED,
> > +					    BMP380_MODE_NORMAL };
> 
> As per above.
> 

ACK.

> ...
> 
> > +static int bmp380_wait_conv(struct bmp280_data *data)
> > +{
> 
> As per above comments against bmp280_wait_conv().
> 

ACK.

> > +	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read status register\n");
> > +		return ret;
> > +	}
> 
> > +
> 
> Choose one style (with or without blank line), as in the above you have no
> blank line in the similar situation.
> 

I didn't even notice it, you are right.

> > +	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
> > +	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> > +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +		usleep_range(data->start_up_time, data->start_up_time + 500);
> 
> fsleep() ? Comment?
> 

I could use fsleep(). I didn't add a comment because also before it was
also like this. The code just used hardcoded (2000,2500) while I used
the data->start_up_time. It is mentioned in the datasheet, I could add it.

> ...
> 
> > +static const u8 bmp580_operation_mode[] = { BMP580_MODE_SLEEP,
> > +					    BMP580_MODE_FORCED,
> > +					    BMP580_MODE_NORMAL };
> 
> As per above.
> 

ACK.

> ...
> 
> > +	switch (mode) {
> > +	case BMP280_SLEEP:
> > +		break;
> > +	case BMP280_FORCED:
> > +		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
> > +				      BMP580_DSP_IIR_FORCED_FLUSH);
> > +		if (ret) {
> > +			dev_err(data->dev,
> > +				"Could not flush IIR filter constants.\n");
> > +			return ret;
> > +		}
> > +		break;
> > +	case BMP280_NORMAL:
> > +		break;
> 
> Can be unified with _SLEEP case.
> 

ACK.

> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> ...
> 
> > +static int bmp580_wait_conv(struct bmp280_data *data)
> > +{
> > +	/*
> > +	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
> > +	 * characteristics
> 
> Missing period.

ACK.

> 
> > +	 */
> > +	static const int time_conv_press[] = { 0, 1050, 1785, 3045, 5670, 10920, 21420,
> > +					42420, 84420};
> > +	static const int time_conv_temp[] = { 0, 1050, 1105, 1575, 2205, 3465, 6090,
> > +				       11340, 21840};
> 
> Please, start values on the next line after {. Also make }; to be on a separate line.
> 

ACK.

> > +	int meas_time;
> > +
> > +	meas_time = 4000 + time_conv_temp[data->oversampling_temp] +
> > +			   time_conv_press[data->oversampling_press];
> 
> 4 * USEC_PER_MSEC ?

Since the previous values in the arrays are all in thousands, why should
I make this different?

> 
> > +	usleep_range(meas_time, meas_time * 12 / 10);
> 
> Comment? fsleep() ?
> 

The usleep here is for waiting for the sensor to make the conversion,
as the function name points out as well? Should I put it as a comment?

In general, is it considered good practice to add comments above all
sleep functions? I don't think it's a bad idea, I just didn't notice
it somewhere.

> > +	return 0;
> > +}
> 
> ...
> 
> > +	usleep_range(2500, 3000);
> 
> fsleep() ?
> 

ACK.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Cheers,
Vasilis

