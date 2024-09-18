Return-Path: <linux-iio+bounces-9635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B597C097
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 21:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B089B1C21521
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2024 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE31CA6B5;
	Wed, 18 Sep 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BewOwgTc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFB1CA69E;
	Wed, 18 Sep 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726688360; cv=none; b=QWFP28OBigqS5oAiOihtJ8ycKO3TVRFESZ1F2BhI0I6PHO7pcu9L8aS3N3njiMioZO0fNwJZdzkTTEKGBXOUJFFjgo8tJ0WN5u+Ts6I+hppzY3Beh3ImJ+5wUL4gM0zc7sjxQAx1b6BunPrTbWSx4HwXHqwuO8oanajh7KYbPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726688360; c=relaxed/simple;
	bh=Ikj8yXNOzC6ACqUwcUG2jtTx9utoqIBt/50t8/WRA6I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdHK8A0NtXSZGSB9y3RRIPK0LFjXN486MTvxdFlTaZawkamIr4Vi4kc0tm5ZibjU1+6BXYvVnWbpiaQT7nBu2mTZIUfJ6i8rgr0z9kNmtMbFnH9SkRwiH4Xn1hV41tZc6Gs4iDga8t8QRVXNnrD+fSytaO7iR3wSwmX0lyS+/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BewOwgTc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a81bd549eso2989766b.3;
        Wed, 18 Sep 2024 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726688357; x=1727293157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUV4elCPwQybejU/R9JbZjAGhAWrEu/0/HfFoMuamO4=;
        b=BewOwgTcnRzb9QhKSQAn4nsCaQZ5UCq162YBJdA974p5mEZ7Of+KxI9S0KmC6OmlS5
         dDi565hUrLM/o3chH6gOpJdDSfYhQNOIR+NKkyWHxwbJDeKrwwInApyBsvMX0BmRQV5Y
         EKGNAo7DOYnxd3JoxiuBNUcjNibtqTrnbAIKiEJYHNWh8zCqvxCvMkmszGWSxs0rCAcN
         lGTxwLc47EJWUeuSfL0XC6zjgoXoIK4y/6WZlATTafXe72BQGvNUR27jqz44tEW+/IWs
         GWDlKIWaAQ9VQ+7i4RckoD+lFLKE9FcocoL1l8WheMzn0SOhxbM6R70ljKi0b+S4/IM0
         yB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726688357; x=1727293157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUV4elCPwQybejU/R9JbZjAGhAWrEu/0/HfFoMuamO4=;
        b=KCyrdVnwudDx9Jl9Y0GDWkSe5rI+ajjO0GSBOeYsXqjJn9RHl+EoNAdj6Vs8teokvb
         TLAj6S/6apDFV365g+DRlVMIKHD92qtcm1eeK/P7DXUmfoI2UIx9qpA5FezbM0qcq8oJ
         emyDriBi58ElYGp0UETFqtadN1BWqq4hVFLVrtVRjK7qEm4CyjN055T6sAjZTPGeupMF
         5FAHcRQ42618BM1KC1Hsllaj5UyYkWTFyyIkmsKP9R2uIQeX+YXMGabTo33FeqneHQG9
         xt7se1TQ6ORJ/mtaTaMCHU7nbv88DkQKmBXy7r00USLQF+3nysJcjgdjQ/k9c+rjLg2x
         O2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1hUETrprnR0P9mcHxSjVTlXdYuYyXsQ2VaYPHYuZvE9fRpkIdkBffcujR4y+nKTjULRm6Zvaa3Kc=@vger.kernel.org, AJvYcCXOok8+uuEUIVyt/FAWboKAIy/Z4pnXPGPNEeLTAZBgVQpu8x+eZdAWMFREwA9LP76jfhq9hjwIw1v95oBW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4Wp/m/7MsGXKxsYp9ZE8ngoQ4Zwb+v8jpBXcW/qkyYJR8G2X
	92lKT07shkzuDvXTdIL5fhG0P8rzagDivpl1luK6+xzpnSXcA4Du
X-Google-Smtp-Source: AGHT+IFeDGcagia+/dcW0cOLBoKpU87IYZwIm+X4gD4qtqOx7m/AcXvthEuGASWxj/3LRhGP7fjeAQ==
X-Received: by 2002:a17:907:1b20:b0:a8d:446a:ded8 with SMTP id a640c23a62f3a-a9029504e9fmr2716717066b.22.1726688356849;
        Wed, 18 Sep 2024 12:39:16 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:13df:f4c:7014:ee36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f429bsm622540666b.61.2024.09.18.12.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:39:16 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 18 Sep 2024 21:39:14 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: pressure: bmp280: Use char instead of s32 for data buffer
Message-ID: <20240918193914.GB6917@vamoiridPC>
References: <20240823172017.9028-1-vassilisamir@gmail.com>
 <20240914123611.3fdb1fbf@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914123611.3fdb1fbf@jic23-huawei>

On Sat, Sep 14, 2024 at 12:36:11PM +0100, Jonathan Cameron wrote:
> On Fri, 23 Aug 2024 19:20:17 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > As it was reported and discussed here [1], storing the sensor data in an
> > endian aware s32 buffer is not optimal. Advertising the timestamp as an
> > addition of 2 s32 variables which is also implied is again not the best
> > practice. For that reason, change the s32 sensor_data buffer to a char
> > buffer with an extra value for the timestamp (as it is common practice).
> > 
> > [1]: https://lore.kernel.org/linux-iio/73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain/
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Hi.
> Thanks for poking. Looks like I'd accidentally marked this one handled
> without actually doing so :(
> 

Hi Jonathan,

No problem at all!!!

> > ---
> >  drivers/iio/pressure/bmp280-core.c | 43 +++++++++++++++++-------------
> >  drivers/iio/pressure/bmp280.h      |  5 +++-
> >  2 files changed, 28 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 3deaa57bb3f5..71e481c2f30d 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -1035,7 +1035,8 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
> >  		goto out;
> >  	}
> >  
> > -	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
> > +	ret = bmp280_compensate_temp(data, adc_temp);
> > +	memcpy(&data->buffer.buf[4], &ret, 4);
> 
> The 4's in here are magic indexes.  Probably use sizeof(s32) in both cases.
> Maybe for the first one make the fact it's after an s32 explicit with
> &data->buffer.buf[1 * sizeof(s32)]
> 
> Of carry an offset through the code that you update when you fill in part of
> the buffer.  That is probably cleaner.
> 
> 	int offset = 0;
> 	stuff
> 	offset += sizeof(s32);
> 	mempcy(&data->bufer.buf[offset], &ret, 4);
> 
> if offset is used for a later entry then add the new element.
> 
> 

Looks nice. I could also move both memcpy() after the if's so in case
there is an error I save myself from memcpy() once for no reason.

> >  
> >  	/* Pressure calculations */
> >  	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
> > @@ -1045,10 +1046,10 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
> >  	}
> >  
> >  	t_fine = bmp280_calc_t_fine(data, adc_temp);
> > +	ret = bmp280_compensate_press(data, adc_press, t_fine);
> > +	memcpy(&data->buffer.buf[0], &ret, 4);
> >  
> > -	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
> > -
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> >  					   iio_get_time_ns(indio_dev));
> >  
> >  out:
> > @@ -1148,7 +1149,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
> >  		goto out;
> >  	}
> >  
> > -	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
> > +	ret = bmp280_compensate_temp(data, adc_temp);
> > +	memcpy(&data->buffer.buf[4], &ret, 4);
> >  
> >  	/* Pressure calculations */
> >  	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
> > @@ -1158,8 +1160,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
> >  	}
> >  
> >  	t_fine = bmp280_calc_t_fine(data, adc_temp);
> > -
> > -	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
> > +	ret = bmp280_compensate_press(data, adc_press, t_fine);
> > +	memcpy(&data->buffer.buf[0], &ret, 4);
> >  
> >  	/* Humidity calculations */
> >  	adc_humidity = get_unaligned_be16(&data->buf[6]);
> > @@ -1168,9 +1170,11 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
> >  		dev_err(data->dev, "reading humidity skipped\n");
> >  		goto out;
> >  	}
> > -	data->sensor_data[2] = bme280_compensate_humidity(data, adc_humidity, t_fine);
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +	ret = bme280_compensate_humidity(data, adc_humidity, t_fine);
> > +	memcpy(&data->buffer.buf[8], &ret, 4);
> as above, but here it is I guess after 2 other elements, so
> 
> 2 * sizeof(s32)
> 
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> >  					   iio_get_time_ns(indio_dev));
> >  
> >  out:
> > @@ -1628,7 +1632,8 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
> >  		goto out;
> >  	}
> >  
> > -	data->sensor_data[1] = bmp380_compensate_temp(data, adc_temp);
> > +	ret = bmp380_compensate_temp(data, adc_temp);
> > +	memcpy(&data->buffer.buf[4], &ret, 4);
> >  
> >  	/* Pressure calculations */
> >  	adc_press = get_unaligned_le24(&data->buf[0]);
> > @@ -1638,10 +1643,10 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
> >  	}
> >  
> >  	t_fine = bmp380_calc_t_fine(data, adc_temp);
> > +	ret = bmp380_compensate_press(data, adc_press, t_fine);
> > +	memcpy(&data->buffer.buf[0], &ret, 4);
> >  
> > -	data->sensor_data[0] = bmp380_compensate_press(data, adc_press, t_fine);
> > -
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> >  					   iio_get_time_ns(indio_dev));
> >  
> >  out:
> > @@ -2203,12 +2208,12 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
> >  	}
> >  
> >  	/* Temperature calculations */
> > -	memcpy(&data->sensor_data[1], &data->buf[0], 3);
> > +	memcpy(&data->buffer.buf[4], &data->buf[0], 3);
> >  
> >  	/* Pressure calculations */
> > -	memcpy(&data->sensor_data[0], &data->buf[3], 3);
> > +	memcpy(&data->buffer.buf[0], &data->buf[3], 3);
> 
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> >  					   iio_get_time_ns(indio_dev));
> >  
> >  out:
> > @@ -2522,15 +2527,15 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
> >  	if (ret)
> >  		goto out;
> >  
> > -	data->sensor_data[1] = chan_value;
> > +	memcpy(&data->buffer.buf[4], &chan_value, 4);
> >  
> >  	ret = bmp180_read_press(data, &chan_value);
> >  	if (ret)
> >  		goto out;
> >  
> > -	data->sensor_data[0] = chan_value;
> > +	memcpy(&data->buffer.buf[0], &chan_value, 4);
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> >  					   iio_get_time_ns(indio_dev));
> >  
> >  out:
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index ccacc67c1473..a853b6d5bdfa 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -411,7 +411,10 @@ struct bmp280_data {
> >  	 * Data to push to userspace triggered buffer. Up to 3 channels and
> >  	 * s64 timestamp, aligned.
> >  	 */
> > -	s32 sensor_data[6] __aligned(8);
> > +	struct {
> > +		u8 buf[12];
> > +		s64 ts __aligned(8);
> 
> We have a new aligned_s64 that is cleaner for these cases.  It's only
> in my togreg branch currently though so you'll need to base on that
> to use it.
> 
> Jonathan
> 
> 

Looks nice, I will try it. 

Cheers,
Vasilis


> > +	} buffer;
> >  
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> 

