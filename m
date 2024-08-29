Return-Path: <linux-iio+bounces-8884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B51964E86
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 21:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92CE1C220E4
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797EF1B8E80;
	Thu, 29 Aug 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn+rhCS2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E514A4EB;
	Thu, 29 Aug 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958831; cv=none; b=k5f8WsvsUbmOd352iCNLqBkVrXoOoW46xyNlFLHNau9XPe6N+DhUSW0bInwcPtkcABgBVzMzqEPym2wg5YJrvy5VpqOOfld+h/FYM/ZeKc6KTTxVU1Q36EPF7BXT75a5N4tZxM+tUPoRNHVoNiwrsQuCpYwvL5fLv5+sGa9vyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958831; c=relaxed/simple;
	bh=q+YQCGmJUV2D/vXOdj4VuWREmXyMG8jgO3IfwHI7hMM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIVSs3g2k1NN1KpP5AgE57OThBuclDtCgleE1sWI7CCuTa+pTEZy1hC83m7Ax6EtaqQUkOjoiv0+K/KnnzvwTuY1d4qvh9bGQke1gFkmVPGj/mVy03g+txL2HZ3jI10yTeFIb32bmAl0ixcNfejhUf0jztaHBeDlk/P+nkRenag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn+rhCS2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3718c176ed7so638822f8f.2;
        Thu, 29 Aug 2024 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724958828; x=1725563628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQcjIMSRZmFeVDSuHhPsYN26NWapZg24YJyTXa5QCTs=;
        b=Fn+rhCS288851rs4tc8U/NI2c15SeClT+LeGI+qaMLqJD+um6yE0hcSnv9O9WNjHVV
         um5OYmrSIIKSnVdIP63UZ4rGdSk2tODe9NMTBhYODQ7knFMYL99KAwQW3I7xYD8VuNkh
         2l5Y2YCCVpRTl3qKlwVNYaKRZjMgWI/UaOTF/4tiFst1UknqhTETAwGcvGxC2b4lkd/2
         oMxCY3BJL15ouzZRYLFJ3L2m+rlynWc2BIk6sMIafwIOlQxdxz6bMkmbggOpuovy1/Ys
         UX25UOZ8/sljH5xt8lRyXXnYBD0hXqPhPIV2NfefUj+u8VRaS60TjfYq6piskwvS5bYy
         uzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958828; x=1725563628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQcjIMSRZmFeVDSuHhPsYN26NWapZg24YJyTXa5QCTs=;
        b=bzkopRGOPN2r9udcUR0sR5tFu2Ce+7WOA5/gdi3cGtaeZsTueHb+z9TQLDvcSATQST
         CrZJ99X/oZTw+Rc6jN8ter1m53KkIdH3W04GR7H10D7q+4a+F8OY/CekXBK3vUHpwGtt
         MjnGdVaMFPQ8kSh0mQ9fAGrLxQhTZ4xwNJV9pdM8Pc9IxR+Ywa7vOiyG0szuBFyewmmP
         DyIsrEQLSUV3EPyRxFRtPK66fuYYmjPJGs6VsIdWlu+TE8VO6Yotoc4DuLOVCL+dnUZv
         SFVK3dbxYY/2j4wGx6BFpgNUx3AZT0Maj50gvpBKTHPTAmfjlHw6ch3WcAP+DWdZ7FCL
         MIHg==
X-Forwarded-Encrypted: i=1; AJvYcCUVpzuduRP6sOgAwMcpNI0jbmlvEV1fePIpxYNSmg7G7a+fUalldi0xQPuon8vLCdZsG4GY8F+PftxBZAlW@vger.kernel.org, AJvYcCWAGFB4UHnbrwQad8TgOgt/96vkunE4cqQb1JxtqSkcv2npQsTwuivgYI4clkGTgF2z9zmo3XvGp326@vger.kernel.org, AJvYcCWNsgcY9Kj0C4lLItZWLJSWiPzoru5XKVs5kPYBvkyEAiymWccXcuQDDwlWjZVeOQ7FRobFH2DhMHpO@vger.kernel.org
X-Gm-Message-State: AOJu0YygzdMv6kr9aWUehYIaVG9Zy70sBAZOhQ79UUvh5yx4CXF7DqUq
	yaxNjePMUVk2dnV+euG+xwSoI1bXRndWKoBIoucX7NB+C2T+JRpQ
X-Google-Smtp-Source: AGHT+IEO3d8nEC5khIUjYS6Kyda9ywmBTCmA5AqfTU9iZcPibtQiPLRoRrFSmIyYp+CqyF+OjKZ2jQ==
X-Received: by 2002:adf:e005:0:b0:368:6f64:3072 with SMTP id ffacd0b85a97d-3749b52eba0mr2739388f8f.7.1724958826947;
        Thu, 29 Aug 2024 12:13:46 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:f22f:934f:9b88:e7ce])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ce4be1sm1038803a12.80.2024.08.29.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:13:46 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 29 Aug 2024 21:13:44 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <20240829191344.GC3493@vamoiridPC>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-5-vassilisamir@gmail.com>
 <ZtBqNAYlZSEhd_20@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtBqNAYlZSEhd_20@smile.fi.intel.com>

On Thu, Aug 29, 2024 at 03:31:48PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 10:51:24PM +0200, Vasileios Amoiridis wrote:
> > This commit adds forced mode support in sensors BMP28x, BME28x, BMP3xx
> 
> s/This commit, adds/Add/
> 
> The imperative mode is documented in Submitting Patches.
> 
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
> 
> Déjà-vu feeling... Ah, first line is the same!
> 

I see your point, I can work this out better.

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
> > +static int bmp280_wait_conv(struct bmp280_data *data)
> > +{
> > +	unsigned int reg;
> 
> > +	int ret, meas_time;
> 
> Why meas_time is signed?
> Also, please name it with a unit suffix

No reason, I can make it unsigned. Unit suffix is a good addition
indeed!!!

> 
> 	unsigned int meas_time_us;
> 
> (and check the rest of the patch for the similar).
> 

True, thanks!!!

> > +
> > +
> 
> A single blank line is enough. Also check all patches for this.
> 

ACK.

> > +	/* Check if we are using a BME280 device */
> > +	if (data->oversampling_humid)
> 
> > +		meas_time += BIT(data->oversampling_humid) * BMP280_MEAS_DUR +
> > +			       BMP280_PRESS_HUMID_MEAS_OFFSET;
> 
> Indentation issue, the same seems in all of similar expressions in this patch.
> 

It seems I have indentation issues in other places as well.
I think I remember checkpatch.pl informing me about those but I didn't
got anything back...


> Also play with this form and check if it looks better
> 
> 		meas_time += BMP280_PRESS_HUMID_MEAS_OFFSET +
> 			     BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
> 
> (at least I found it better to read as first we apply constants, followed by
>  longer variable-based calculations).
> 

I see your point, I can try it.

> > +	/* Pressure measurement time */
> > +	meas_time += BIT(data->oversampling_press) * BMP280_MEAS_DUR +
> > +		      BMP280_PRESS_HUMID_MEAS_OFFSET;
> > +
> > +	/* Temperature measurement time */
> > +	meas_time += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
> > +
> > +	/* Waiting time according to the BM(P/E)2 Sensor API */
> > +	fsleep(meas_time);
> > +
> > +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read status register\n");
> > +		return ret;
> > +	}
> > +
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
> int bmp280_chip_config(struct bmp280_data *data)
> 
> >  				BMP280_OSRS_TEMP_MASK |
> >  				BMP280_OSRS_PRESS_MASK |
> >  				BMP280_MODE_MASK,
> > -				osrs | BMP280_MODE_NORMAL);
> > +				osrs | BMP280_MODE_SLEEP);
> >  	if (ret) {
> >  		dev_err(data->dev, "failed to write ctrl_meas register\n");
> >  		return ret;
> 
> This _feels_ like a separate change. I haven't found anything explicitly
> describing it in the commit message. Did I miss it?
> 

Well this change is because before, the sensor was by default in
NORMAL_MODE so whenever we were writing a different setting (Output
data rate, oversampling ratio) to the sensor, the NORMAL_MODE was
chosen. There was no idea of SLEEP or FORCED MODE.

While now, since this commits adds the idea of SLEEP_MODE
by default (FORCED_MODE for oneshot captures, and NORMAL_MODE for
buffer/trigger) we need to keep the sensor in SLEEP_MODE as well
when we change its configuration.

I believe it belongs to this commit. Maybe though, I should mention
this change explicitly in the commit message?

> ...
> 
> > +		/*
> > +		 * According to the BMP3 Sensor API, the sensor needs 5000ms
> 
> I believe it's a typo in unit suffix.
> 

Yes indeed its a typo, I wanted to say 5000us. The fsleep(5000) is correct.

> If not, this should be very well described to explain why 5 seconds is needed.
> 
> > +		 * in order to go to the sleep mode.
> > +		 */
> > +		fsleep(5000);
> 
> ...
> 
> > +{
> > +	int ret;
> > +
> > +	switch (mode) {
> > +	case BMP280_SLEEP:
> > +	case BMP280_NORMAL:
> > +		break;
> > +	case BMP280_FORCED:
> > +		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
> > +				      BMP580_DSP_IIR_FORCED_FLUSH);
> > +		if (ret) {
> > +			dev_err(data->dev,
> > +				"Could not flush IIR filter constants.\n");
> 
> Temporary variable for data->dev?
> 

That could help, yeah!

> > +			return ret;
> > +		}
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> > +				BMP580_MODE_MASK,
> > +				FIELD_PREP(BMP580_MODE_MASK,
> > +					   bmp580_operation_mode[mode]));
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to  write power control register\n");
> > +		return ret;
> > +	}
> > +
> > +	data->op_mode = mode;
> > +
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
> > +		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420, 84420
> > +	};
> 
> Mind the comma at the end.
> 

ACK.

> And in programming hardware we quite often operate with power-of-2 things, so I
> recommend to have 8 per line,
> 
> 	static const int time_conv_press[] = {
> 		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420,		/* 0-7 */
> 		84420,							/* 8 */
> 	};
> 

I was not aware of this convention, I can do it.

> > +	static const int time_conv_temp[] = {
> > +		0, 1050, 1105, 1575, 2205, 3465, 6090, 11340, 21840
> > +	};
> 
> Ditto.
> 

ACK.

> > +
> 
> Stray blank line. This is a definition block, we don't need blank lines in it.
> 

ACK.

> > +	int meas_time;
> > +
> > +	meas_time = 4 * USEC_PER_MSEC + time_conv_temp[data->oversampling_temp]
> > +		      + time_conv_press[data->oversampling_press];
> > +
> > +	/* Measurement time mentioned in Chapter 2, Table 4 of the datasheet. */
> > +	fsleep(meas_time);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> >  	/* From datasheet's table 4: electrical characteristics */
> 
> With this change the comment seems odd. Can you elaborate more?
> 

I can elaborate more in the comment yes.

> > -	usleep_range(2500, 3000);
> > +	fsleep(data->start_up_time + 500);
> 
> Also, can we name it start_up_time_us?
> It's fine to postpone renaming if it takes too many unrelated changes.
> 

I can maybe do it in a separate commit because you have already pointed
out things that could be improved with styling.

> ...
> 
> > +	usleep_range(2500, 3000);
> 
> fsleep()? Comment?
> 

ACK.

> ...
> 
> >  	usleep_range(data->start_up_time, data->start_up_time + 100);
> 
> This is already in the code, but maybe switching to fsleep() and adding
> a comment to explain how it's calculated (based on the spec? Reference?),
> so in a separate change?
> 

Yes, that would be good!!!

Cheers,
Vasilis

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

