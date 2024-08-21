Return-Path: <linux-iio+bounces-8662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AF995A70D
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611C2285456
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EE117A931;
	Wed, 21 Aug 2024 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACdG9lpm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FC7405A;
	Wed, 21 Aug 2024 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277117; cv=none; b=XaXZVy0EyxB16ADCtbwqSEv7guuxH4Lpr9dl5WUXM4DZOJr3H/YClB38hWKLeOy+w040qOG9zr2EJWAGCVN6cp6lKM2A6Arzf3BgugSWWwySYM0pv6oS6p6f9PfSnevRHi1wlgrPTeAxsLZVG1IFJlGM4ayOiyuVSQcWh4x0zg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277117; c=relaxed/simple;
	bh=Kt6JI5NWSv6ZkyWAqw9jTVzFCxQpU5lwLImQB0lx8b8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbC9kY+G6QgrF9hOUOWXbaiGWRJiGgiZvdddHFrcIsW7lXWTUHCKulRhOxYynwzbtWDayQ2/sotEBmLixwRov6I5ngX83AJvZjF5ktA8sYCE8fYfshHZ7SLJ1qweyN3u9HnuIlq+Audn2pZbTdJQ78zVZR1I7taKoP2GfTEjuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACdG9lpm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8666734767so17806366b.1;
        Wed, 21 Aug 2024 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277114; x=1724881914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mshofXHEuKk3AfsjHmTdYTQY1OTdO7/xqWQ3iRWqk6I=;
        b=ACdG9lpmJL1VkXRzq9o4g5V1BxJxHKhP6/ildyrSnwkIWPYEXokO0NdUepp4G9rIEt
         6h/TXNGxmNIUESLzyBe43DCAIDNCoeUx6cFf34O4Sym5ARkkCvISh9+TaiODVjBCWHRx
         CPIDzfO62OYjaUerwqCM3ZQF/FuUn3QXTyE3i7AwweidDM6xbgVZvHUirNR2GbWUIF48
         DC/uBoR/R88w+LjRHhWNP9VtWnJQqzScGNzv99ptBzITpLwwGumRaNsGU0SbddLvPOQj
         1lPBLHT10qA6Dy2/HzrB5H87DESRx/Jyml0PA2BxiISffJiHFNLqtQyTpl/nHQKEI1tZ
         azdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277114; x=1724881914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mshofXHEuKk3AfsjHmTdYTQY1OTdO7/xqWQ3iRWqk6I=;
        b=qwZCqnbXseh5HHNIycZswa7qz+OqtjgCV7B74e2uj1JJay8bNAineKJlJV+gXBjoob
         XNUddhk5l/6KotM7GS2BYSejEguN59RUB95OIHd1Ddxwa8sDsHI8YJvg5XeplsUjKa3w
         oopQXLNOPuJ9I7dJsP6pVArnZrPm5odgSiyZxvKMlPN5bqU15ZzZAqRiWyegOV8k3ccG
         Qf8p883rjYEYsKz6pxuRWB8M8dZCznihr3ztn6bVzTgTBJFGRvw4bNPkjEVhmuMEH6PK
         tCK7j7l0CPS9BlP82SxBHjqa4jDuL6G6KgFNxyq8xHzkQgRgNxZDFtceuU0FmOMlNAa2
         um1g==
X-Forwarded-Encrypted: i=1; AJvYcCUaQZkvJnNLuWq/NBOgWWmlxOdTwxYz7gkMI965TfrdxkvEbBA2mwdilIoHwhlK+SRmJKij3nMfq4dN@vger.kernel.org, AJvYcCVf6sLk7e/iF18nbzFw3YVrdCXkrXt9tCoL9GDjP7y3LcDX+3GiHTW45CstWBuUEDsuZaJoV/wvA2t2@vger.kernel.org, AJvYcCWygx8Pc+SIPDUuCuOZ0rhJNue3I1xRqNpacwM4ibeHlAEj/p4nIyHEQRmvrmmLSPk7WW/poI7rK0szLFYn@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5Pfe7HXd622fphMP+z70mNBYfWCiXpQdPl/Ke0slLA1qEE/S
	jUFJ4ndUOx251RVjtGwZLZ4ynbt2lXNxof4uYh4Vjtq10jiDYImr
X-Google-Smtp-Source: AGHT+IHizZ5FHVMP1eNGW0+XQx8jDz5+OtFB9DZr3dfKFvQ2X2R5CGRJv3oN+hMFH3GrQTY2FiNuBg==
X-Received: by 2002:a17:907:2ce3:b0:a80:aefa:14d3 with SMTP id a640c23a62f3a-a866f8b679emr282840966b.63.1724277113186;
        Wed, 21 Aug 2024 14:51:53 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:1594:887e:30dd:c59e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a5d0sm14982466b.159.2024.08.21.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:51:52 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 21 Aug 2024 23:51:50 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <20240821215150.GA478039@vamoiridPC>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
 <20240725231039.614536-5-vassilisamir@gmail.com>
 <20240728165724.75153d08@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728165724.75153d08@jic23-huawei>

On Sun, Jul 28, 2024 at 04:57:24PM +0100, Jonathan Cameron wrote:
> On Fri, 26 Jul 2024 01:10:36 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
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
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> One question inline about the corner case of buffered capture in progress
> when the machine is suspended.  We'd like the device to carry on feeding
> us data on resume. Does that happen?
> 
> Jonathan
> 

Hi Jonathan,

This is actually a corner case that I couldn't think of. I will have to think
it a bit more and come back on that.

> 
> >  	.trigger_handler = bmp380_trigger_handler,
> > @@ -2085,6 +2239,64 @@ static int bmp580_preinit(struct bmp280_data *data)
> >  	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
> >  }
> >  
> > +static const u8 bmp580_operation_mode[] = { BMP580_MODE_SLEEP,
> > +					    BMP580_MODE_FORCED,
> > +					    BMP580_MODE_NORMAL };
> > +
> 
> 
> > +
> > +static int bmp580_wait_conv(struct bmp280_data *data)
> > +{
> > +	/*
> > +	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
> > +	 * characteristics
> > +	 */
> > +	const int time_conv_press[] = { 0, 1050, 1785, 3045, 5670, 10920, 21420,
> > +					42420, 84420};
> > +	const int time_conv_temp[] = { 0, 1050, 1105, 1575, 2205, 3465, 6090,
> > +				       11340, 21840};
> space before }
> 
> Also stick a static in front of them or Colin will ;)
> Aim being to makes sure they aren't pointlessly allocated on the stack
> if the compiler doesn't do something clever with them.
> 

Ack.

> > +	int meas_time;
> > +
> > +	meas_time = 4000 + time_conv_temp[data->oversampling_temp] +
> > +			   time_conv_press[data->oversampling_press];
> > +
> > +	usleep_range(meas_time, meas_time * 12 / 10);
> > +
> > +	return 0;
> > +}
> >
> >  
> > +/* Keep compatibility with future generations of the sensor */
> > +static int bmp180_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
> > +{
> > +	return 0;
> > +}
> > +
> > +/* Keep compatibility with future generations of the sensor */
> > +static int bmp180_wait_conv(struct bmp280_data *data)
> > +{
> > +	return 0;
> > +}
> > +
> > +/* Keep compatibility with future generations of the sensor */
> 
> What does this comment mean?  I'm in favour of course, but don't understand
> why it is here and above the stub calls.
> 
> 

This is for the bm(p/e)(2/3/5)80 devices which actually use those functions.
Maybe instead of "future" I should have put "newer".

> > @@ -2825,6 +3048,9 @@ static int bmp280_runtime_suspend(struct device *dev)
> >  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >  	struct bmp280_data *data = iio_priv(indio_dev);
> >  
> > +	data->chip_info->set_mode(data, BMP280_SLEEP);
> 
> What happens if the device is in buffered mode and you suspend?
> I'd expect to see the power mode stashed somewhere and restored in resume.
> 

As said before, I will investigate it and come back with more info.

Cheers,
Vasilis
> > +
> > +	usleep_range(2500, 3000);
> >  	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
> >  }
> >  

