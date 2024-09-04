Return-Path: <linux-iio+bounces-9130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A596B858
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 12:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8FE1F2124A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8C433C8;
	Wed,  4 Sep 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVikh/wF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2041CCB24;
	Wed,  4 Sep 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445474; cv=none; b=tF+6+YmR587fCnG2QmQfryT67Q6++eH4hjs0QIvjpkkbQCIv5JvBw031+QTVj7h0lUkO7wNFX1k5ZW5pgChWJtXyk6FtNtzvhLCZwtjNz4IVmzbgEx4P/11GxlOtav07wc9sczL7UQjosncjkvelJtIg2s10zLJ8Y5+VIna8bqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445474; c=relaxed/simple;
	bh=li8HLQcwSeWcNyRlWXgmcYWpWqPZrZy6nbCJhPgHdf0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+fqyFVeIE+nF3TrfCIRs07MFDUZSkmmOF9CAllt1TykVs4YJY8VygeXUorb11mXimjTlVl3YNdufgIbJqclGSvaQHTAef99cddt7A4LfiU1giIrnprNWPqlvfP0DjDLAo2CDEQZRh3D7qzB3U8+AqIO0xpI7JHUbIc8RUSs++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVikh/wF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so70979766b.1;
        Wed, 04 Sep 2024 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725445471; x=1726050271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDwjld+tJyBVRF5yIpDjYObSDHlEtz3Wt1iJNPK9p/E=;
        b=cVikh/wFRY61HBu2fDE5dPp4AzT/MAV/9OBbku9kS20L8jNPYg2e3bWmXfp791JGSn
         +g0LeVKWI5joGNx5I/y96oSnosgDH2k7TB2PGUgCl5NMBstgdhEb8znGMqzyjhl/KIty
         /OFqodNn8ysyJcoGQT1/12Jc4eFZDDa5P0g/hQIV4Dwvccd4DBVjLfVGGY8GffAvgCxF
         57RDiEqB9DGSUcCefrn4CqOYjXGmQkxk4S/U4U+v0RAAmhG7Oon2tWpbDB1NMcvlY64N
         O0UyhYnYSctvd1R1LfRNdkbXy7whte5+fiuZ3hWdX1c0Cjjr2wTQPNw8/4UeHsutNF2J
         dwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445471; x=1726050271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDwjld+tJyBVRF5yIpDjYObSDHlEtz3Wt1iJNPK9p/E=;
        b=tOs1Lipey4mEdKvApcs8v/K08SI3xUprm0xN3GqZ8n4NEOg/SyTCzFOTh5RmWiVugE
         SVnWSWjaLNgelQ1WFQQLYyKUxNg1iStvlIXG6iQQIIpSblssxha37dtuuDFSlR4aCMYa
         P2Uys8lC09uVUEb0WNk4nwUJFUPV8zT+pBjsfDQNCQ7CLALpvmt/kt2ETKsvTts1cTk2
         NrvBAwX99O6IYTvZQjy5pVBvAVfcSLwCsicnxtXEqzkVbq6KtOfqs1u6RcgSNCJ70/H7
         BJuJLBbaadtLy4o2/JU9dfTn0iqajqtHXZ7RJgwFc2fB5JOSf3ySyUSAs98c6tLYGH+s
         vvig==
X-Forwarded-Encrypted: i=1; AJvYcCWpzVnoN++ckyWMkTXm5edwTJMLSBvOoKdUFsUxO3c/8xw38vwLwwo4KgvnhLz8fVggMgU31a+8E5JVYk7W@vger.kernel.org, AJvYcCXHR+9q/zFPBUOZqGvUyVBttrRw3SQroVk0Qb2hTY9q0Vv1Z5efTEoBeT8pNyQgntyM+VE6b1IjG4/G@vger.kernel.org, AJvYcCXr+L4OYpNiYdIUk9qM+ZJ1VWfRzsNqcYTa3hOdpJKuIl/jW02kmwwVSRU6G7WhZcpSqu/9pUz8wckx@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjZ1M4JBsUJAPueRazym5kvVE4AjI1TB0g24oYHItmvYtm+F+
	SEIotkVNtE+C5HaFryMUCm0glwHKMsd4p94uXBJ7VV7/se/ea0tl
X-Google-Smtp-Source: AGHT+IFUe46m5dyAIpzpY2jR7NwpAcFdvdfcd2lBnhcaeBPGeE2JQdPmmK/1zDM7vkZ/CuYkMWehdg==
X-Received: by 2002:a17:907:940f:b0:a7a:b385:37c5 with SMTP id a640c23a62f3a-a8a3f185c6emr156149666b.17.1725445470048;
        Wed, 04 Sep 2024 03:24:30 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3dbdsm789019666b.131.2024.09.04.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:24:29 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 4 Sep 2024 12:24:27 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <20240904102427.GA44250@vamoiridPC>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-5-vassilisamir@gmail.com>
 <ZtccnvhmcxyRQVuf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtccnvhmcxyRQVuf@smile.fi.intel.com>

On Tue, Sep 03, 2024 at 05:26:38PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 02, 2024 at 08:42:19PM +0200, Vasileios Amoiridis wrote:
> > Add forced mode support in sensors BMP28x, BME28x, BMP3xx and BMP58x.
> > Sensors BMP18x and BMP085 are old and do not support this feature so
> > their operation is not affected at all.
> > 
> > Essentially, up to now, the rest of the sensors were used in normal mode
> > all the time. This means that they are continuously doing measurements
> > even though these measurements are not used. Even though the sensor does
> > provide PM support, to cover all the possible use cases, the sensor needs
> > to go into sleep mode and wake up whenever necessary.
> > 
> > The idea is that the sensor is by default in sleep mode, wakes up in
> > forced mode when a oneshot capture is requested, or in normal mode
> > when the buffer is enabled. The difference lays in the fact that in
> > forced mode, the sensor does only one conversion and goes back to sleep
> > while in normal mode, the sensor does continuous measurements with the
> > frequency that was set in the ODR registers.
> > 
> > The bmpX_chip_config() functions which are responsible for applying
> > the requested configuration to the sensor, are modified accordingly
> > in order to set the sensor by default in sleep mode.
> > 
> > DEEP STANDBY, Low Power NORMAL and CONTINUOUS modes, supported only by
> > the BMP58x version, are not added.

Hi Andy,

Thanks for finding again the time to review this!

> 
> ...
> 
> > +static int bmp280_wait_conv(struct bmp280_data *data)
> > +{
> > +	unsigned int reg, meas_time_us;
> > +	int ret;
> > +
> > +	/* Check if we are using a BME280 device */
> > +	if (data->oversampling_humid)
> > +		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
> > +				(BIT(data->oversampling_humid) * BMP280_MEAS_DUR);
> 
> The outer parentheses are not needed.
> 

True, will fix that.

> > +	/* Pressure measurement time */
> > +	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
> > +			(BIT(data->oversampling_press) * BMP280_MEAS_DUR);
> 
> Ditto.

ACK.

> 
> > +	/* Temperature measurement time */
> > +	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
> > +
> > +	/* Waiting time according to the BM(P/E)2 Sensor API */
> > +	fsleep(meas_time_us);
> > +
> > +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read status register.\n");
> > +		return ret;
> > +	}
> > +
> > +	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
> > +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int bmp380_wait_conv(struct bmp280_data *data)
> > +{
> > +	unsigned int reg;
> > +	int ret, meas_time_us;
> > +
> > +	/* Offset measurement time */
> > +	meas_time_us = BMP380_MEAS_OFFSET;
> > +
> > +	/* Pressure measurement time */
> > +	meas_time_us += BMP380_PRESS_MEAS_OFFSET +
> > +		     (BIT(data->oversampling_press) * BMP380_MEAS_DUR);
> 
> Ditto.
> 

ACK.

> > +	/* Temperature measurement time */
> > +	meas_time_us += BMP380_TEMP_MEAS_OFFSET +
> > +		     (BIT(data->oversampling_temp) * BMP380_MEAS_DUR);
> 
> Ditto.
> 

ACK.

> > +	/* Measurement time defined in Datasheet Section 3.9.2 */
> > +	fsleep(meas_time_us);
> > +
> > +	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read status register.\n");
> > +		return ret;
> > +	}
> 
> > +	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
> > +	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> > +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> > +		return -EBUSY;
> > +	}
> 
> Alternatively
> 
> 	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) &&
> 	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> 		return -EBUSY;
> 	}
> 

Why would I use && instead of || ? I just need one of the 2 to be true
(one of the 2 measurements is not complete) and I can trigger the error
action.

> > +	return 0;
> > +}
> 
> ...
> 
> > +static int bmp580_wait_conv(struct bmp280_data *data)
> > +{
> > +	/*
> > +	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
> > +	 * characteristics.
> > +	 */
> > +	static const int time_conv_press[] = {
> > +		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420,
> > +		84420,
> > +	};
> > +	static const int time_conv_temp[] = {
> > +		0, 1050, 1105, 1575, 2205, 3465, 6090, 11340,
> > +		21840,
> > +	};
> > +	int meas_time_us;
> 
> > +	meas_time_us = 4 * USEC_PER_MSEC + time_conv_temp[data->oversampling_temp]
> > +			 + time_conv_press[data->oversampling_press];
> 
> 	meas_time_us = 4 * USEC_PER_MSEC + time_conv_temp[data->oversampling_temp] +
> 		       time_conv_press[data->oversampling_press];
> 
> OR
> 
> 	meas_time_us = 4 * USEC_PER_MSEC +
> 		       time_conv_temp[data->oversampling_temp] +
> 		       time_conv_press[data->oversampling_press];
> 
> 

ACK.

> > +	/* Measurement time mentioned in Chapter 2, Table 4 of the datasheet. */
> 
> Since there is a constant in use (4ms) it would be nice to explain it
> separately, the rest kinda obvious from the variable names.
> So it allows roughly understand the timeout value without even looking into
> the datasheet.
> 

True, I can do that.

> > +	fsleep(meas_time_us);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +	fsleep(data->start_up_time + 500);
> 
> Ditto.
> 
> Something like
> 
> 	/* 500us margin for ... */
> 
> (but write the real meaning of it).
> 

ACK.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Vasilis

