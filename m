Return-Path: <linux-iio+bounces-4826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A818BC4BB
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 01:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE06F281371
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 23:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A39763E4;
	Sun,  5 May 2024 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmObuLwu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5832140375;
	Sun,  5 May 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714952878; cv=none; b=TN7SXSDHZ/TOCiidiSodEWJ43KLPjrjEMZ8kwwkjp3ygXD7LN9jppbFjnjZ/wjPcuPQoWfdRC+lkE4u0eYUEYsc3ntJu8aeaOAijJW1pAQF1dOmefHIvc9GhOxwYUyuH53/cf32DLpt+a7Ru2TUp/RO9byiApz8qxjzyNnfqOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714952878; c=relaxed/simple;
	bh=uW0Efq/7j6ILo9wvhPCq3TZ1nqt5jydS5pL9qGvjD/I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0hGIc+5QJPqXKSHqmHIzGFaxnLfop6aV7EidLwa0PxX4Q7f7Fht6njrrOChQpY3isFUaRWiHgHrLo4OrjXzZfhFpWijpnIDB/jcC/eaTpEwmUC4dcPwt/nG2gvaC8LevoLJ3kjdrFM1k7uw9HtR4gbVQ9faKXeZ8uCT+pmZlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmObuLwu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a0168c75so322316266b.1;
        Sun, 05 May 2024 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714952874; x=1715557674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EPAeWzpOt4FqxqtoryBJoUZ5AXWGJf7y5C2KkdICfXA=;
        b=EmObuLwuNWjC9kYpihLyAguQCiihyUoDN/6zY9+2h2k+3MR/iMEq5OZULBzH7eZk/e
         rljT1NY/zy7sgEpky1ATFMr0+HP9MTCUX5evUIWanlfSXBZ/dzOZwAkV7QSIS+R8pA0N
         1g+Hx58xi8rDG7VUXCTqRtxloeguEJwOQQSBJLfxYixSmImHahhm0yjdT7/YO3x711o4
         SJZBkS1by+qXD4f9iY/ICGBhJjs9FwrI6ioKgFnQNFROSot5YqkCSB7uRntJHa9ZPSs7
         n+tIMgEAdqUrCSAfAbPKfHB9d75Yh4Vef/tBaqMrJLTAx8qk7VYEWZ9YWh4WB1E/72l2
         htDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714952874; x=1715557674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPAeWzpOt4FqxqtoryBJoUZ5AXWGJf7y5C2KkdICfXA=;
        b=n4WHAq2oed7nu8c6XGMdzhfrXCTOvNefcDXlhUHGpQI2LVMYu7AYccxOBEvjD8NV9a
         60L8RBKXB91nkxwQprfFV7ZA0gvH5ARQowQ5JhqT9kRUVcII7ZQ3vKHdvRDlRobp2b8L
         eqmJJYTYNeYzsO4i4GtvYh5GJ6WZxeJraNgfLCz1w5v7c73ONSlMqHi8MWqN+JmAdU4D
         UjI+ic02uTiWvy/3zTsZSf8jEl0rQQe8gE/PBERnvehvDGgtu+lKZNlJpgTmjYKPaqzz
         /tFCWHL2C2GmKznAfr9qyLjJKB+kLm/qLI9lddNFZaRfb9SY/uxT6xfS2af9IYV0+8SO
         sSFw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4BRZqjRjGvmMaMujCX4F+hjzty+ZNyVKyB6ycHAt3qv9klFCc4QcWpIIvXe8q++j9uyrSV2n5XT+yyYoE2skILHOYKKSRAwsIArc27oCcSUja5FGOnwkW6G58Tb7qYXn9/GPVAJF
X-Gm-Message-State: AOJu0YzyaluH0ie+wlAbpyipOslZbmpvSG6si9q9Y8gdOFjiT76Mem+2
	YklSWS6L7ag3KQlrAXNM5ylHuYRR30GsplqciVMh6B6e04drtRNl7WMHezCZog8=
X-Google-Smtp-Source: AGHT+IGW5qIzoz/GkKOPDTuzCAou9qBjlFLRF/ZKr4+b9Nt+RYNLw3FCm95pvRgCHhzRl4Lgur3TVw==
X-Received: by 2002:a17:906:9817:b0:a59:a938:d92b with SMTP id lm23-20020a170906981700b00a59a938d92bmr2822729ejb.66.1714952873646;
        Sun, 05 May 2024 16:47:53 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:7a5f:ec16:256e:4660])
        by smtp.gmail.com with ESMTPSA id l5-20020a1709061c4500b00a59b594a067sm1712290ejg.66.2024.05.05.16.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 16:47:53 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 6 May 2024 01:47:51 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 06/10] iio: pressure: bmp280: Refactorize reading
 functions
Message-ID: <20240505234751.GB17986@vamoiridPC>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
 <20240429190046.24252-7-vassilisamir@gmail.com>
 <20240505202106.1c780044@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505202106.1c780044@jic23-huawei>

On Sun, May 05, 2024 at 08:21:06PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Apr 2024 21:00:42 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > For BMP18x, BMP28x, BME280, BMP38x the reading of the pressure
> > value requires an update of the t_fine variable which happens
> > through reading the temperature value.
> > 
> > So all the bmpxxx_read_press() functions of the above sensors
> > are internally calling the equivalent bmpxxx_read_temp() function
> > in order to update the t_fine value. By just looking at the code
> > this functionality is a bit hidden and is not easy to understand
> > why those channels are not independent.
> > 
> > This commit tries to clear these things a bit by splitting the
> > bmpxxx_{read/compensate}_{temp/press/humid}() to the following:
> > 
> > i. bmpxxx_read_{temp/press/humid}_adc(): read the raw value from
> > the sensor.
> > 
> > ii. bmpxx_calc_t_fine(): calculate the t_fine variable.
> > 
> > iii. bmpxxx_get_t_fine(): get the t_fine variable.
> > 
> > iv. bmpxxx_compensate_{temp/press/humid}(): compensate the adc
> > values and return the calculated value.
> > 
> > v. bmpxxx_read_{temp/press/humid}(): combine calls of the
> > aforementioned functions to return the requested value.
> > 
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> In general looks good, but a few details to consider inline.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 351 ++++++++++++++++++-----------
> >  drivers/iio/pressure/bmp280.h      |   6 -
> >  2 files changed, 221 insertions(+), 136 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 8290028824e9..5ebce38e99f6 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -288,13 +288,33 @@ static int bme280_read_calib(struct bmp280_data *data)
> >   *
> >   * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
> >   */
> > +static int bme280_read_humid_adc(struct bmp280_data *data, s32 *adc_humidity)
> 
> It's an u16, so why use an s32?   I can see using a signed value avoids a cast later,
> but it makes this more confusing to read, so I'd push that cast up to the user.
> 

Bosch in general has messed up a bit with the signs on their raw values on all
of those sensors that we use in this driver. I totally agree with you, that this
value does not make any sense to be anything else apart from u16 but in the
datasheet [1] in pages 25-26 you can clearly see that they use an s32 for this
value...

[1]: https://www.mouser.com/datasheet/2/783/BST-BME280-DS002-1509607.pdf

> > +{
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> > +			       &data->be16, sizeof(data->be16));
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "failed to read humidity\n");
> > +		return ret;
> > +	}
> > +
> > +	*adc_humidity = be16_to_cpu(data->be16);
> 
> Trivial, but on error return we normally aim for side effect free.
> To do that here use an internal variable first.

I am sorry, but in this part, I cannot fully understand what you mean
by side effect free. I can understand the issue of storing a u16 to an
s32 might make accidentally the sign to matter but how is this thing
that you proposed no side effect free? You also made this comment
in various other places in this patch (because the same principle
with the SKIPPED is used) and in the other places the values are
20-bit and 24-bit long which confuses me a bit more on what you mean
exactly.

> 	s16 value;
> 
> ...
> 
> 	value = be16_to_cpu(data->be16)
> 
> 	if (value == BMP280_HUMIDITY_SKIPPED) {
> 		dev_err(data->dev, "...
> 		return -EIO;
> 	}
> This is the odd bit due to using an s32 to store a u16.
> Have to rely on that size mismatch to avoid the sign accidentally mattering.
> Which is ugly!
> 
> 	*adc_humidity = value;
> 
> 	return 0;
> 
> 
> > +	if (*adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> > +		dev_err(data->dev, "reading humidity skipped\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static u32 bme280_compensate_humidity(struct bmp280_data *data,
> > -				      s32 adc_humidity)
> > +				      s32 adc_humidity, s32 t_fine)
> >  {
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	s32 var;
> >  
> > -	var = ((s32)data->t_fine) - (s32)76800;
> > +	var = ((s32)t_fine) - (s32)76800;
> 
> Casting an s32 to an s32.  For the const it shouldn't matter as it'll be at least
> 32 bits and we don't care about the sign.
> 

In general, I kept the casting for the t_fine because it was used from before,
but I don't see the point since it is already an s32 value. The casting in front
of the const, I see it is used in the datasheet [1] in pages 25-26 so maybe they
kept it for this reason. Since it will be again a 32 bit value, I don't see the
point of casting it but I still kept it as it was, there originally.

[1]: https://www.mouser.com/datasheet/2/783/BST-BME280-DS002-1509607.pdf

> >  	var = ((((adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
> >  		+ (s32)16384) >> 15) * (((((((var * calib->H6) >> 10)
> >  		* (((var * (s32)calib->H3) >> 11) + (s32)32768)) >> 10)
> > @@ -313,8 +333,27 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
> >   *
> >   * Taken from datasheet, Section 3.11.3, "Compensation formula".
> >   */
> > -static s32 bmp280_compensate_temp(struct bmp280_data *data,
> > -				  s32 adc_temp)
> > +static int bmp280_read_temp_adc(struct bmp280_data *data, s32 *adc_temp)
> 
> As before, sign of the extra variable is confusing. It's not signed
> as it's a raw ADC value. So I'd use a u32 for it.
> 

Again, as I said before, Bosch has messed this up. I agree (again) with you
that this should have been a u16 but according to the datasheet [2] in pages
45-46 it is an s32...

[2]: https://cdn-shop.adafruit.com/datasheets/BST-BMP280-DS001-11.pdf

> > +{
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> > +			       data->buf, sizeof(data->buf));
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "failed to read temperature\n");
> > +		return ret;
> > +	}
> > +
> > +	*adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> > +	if (*adc_temp == BMP280_TEMP_SKIPPED) {
> > +		dev_err(data->dev, "reading temperature skipped\n");
> > +		return -EIO;
> Same thing on side effects.  Best to avoid them if it is easy to do (like here!)
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static s32 bmp280_calc_t_fine(struct bmp280_data *data, s32 adc_temp)
> >  {
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	s32 var1, var2;
> > @@ -324,9 +363,26 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
> >  	var2 = (((((adc_temp >> 4) - ((s32)calib->T1)) *
> >  		  ((adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
> >  		((s32)calib->T3)) >> 14;
> > -	data->t_fine = var1 + var2;
> > +	return var1 + var2; /* t_fine = var1 + var2 */
> > +}
> > +
> > +static int bmp280_get_t_fine(struct bmp280_data *data, s32 *t_fine)
> > +{
> > +	s32 adc_temp;
> > +	int ret;
> > +
> > +	ret = bmp280_read_temp_adc(data, &adc_temp);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*t_fine = bmp280_calc_t_fine(data, adc_temp);
> >  
> > -	return (data->t_fine * 5 + 128) >> 8;
> > +	return 0;
> > +}
> > +
> > +static s32 bmp280_compensate_temp(struct bmp280_data *data, s32 adc_temp)
> > +{
> > +	return (bmp280_calc_t_fine(data, adc_temp) * 5 + 128) / 256;
> >  }
> >  
> >  /*
> > @@ -336,13 +392,33 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
> >   *
> >   * Taken from datasheet, Section 3.11.3, "Compensation formula".
> >   */
> > +static int bmp280_read_press_adc(struct bmp280_data *data, s32 *adc_press)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> > +			       data->buf, sizeof(data->buf));
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "failed to read pressure\n");
> > +		return ret;
> > +	}
> > +
> > +	*adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> > +	if (*adc_press == BMP280_PRESS_SKIPPED) {
> > +		dev_err(data->dev, "reading pressure skipped\n");
> > +		return -EIO;
> 
> As above; avoid side effects.
> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static u32 bmp280_compensate_press(struct bmp280_data *data,
> > -				   s32 adc_press)
> > +				   s32 adc_press, s32 t_fine)
> >  {
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	s64 var1, var2, p;
> >  
> > -	var1 = ((s64)data->t_fine) - 128000;
> > +	var1 = ((s64)t_fine) - 128000;
> >  	var2 = var1 * var1 * (s64)calib->P6;
> >  	var2 += (var1 * (s64)calib->P5) << 17;
> >  	var2 += ((s64)calib->P4) << 35;
> > @@ -368,60 +444,35 @@ static int bmp280_read_temp(struct bmp280_data *data,
> >  	s32 adc_temp, comp_temp;
> >  	int ret;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> > -			       data->buf, sizeof(data->buf));
> > -	if (ret < 0) {
> > -		dev_err(data->dev, "failed to read temperature\n");
> > +	ret = bmp280_read_temp_adc(data, &adc_temp);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> > -	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> > -	if (adc_temp == BMP280_TEMP_SKIPPED) {
> > -		/* reading was skipped */
> > -		dev_err(data->dev, "reading temperature skipped\n");
> > -		return -EIO;
> > -	}
> >  	comp_temp = bmp280_compensate_temp(data, adc_temp);
> >  
> > -	/*
> > -	 * val might be NULL if we're called by the read_press routine,
> > -	 * who only cares about the carry over t_fine value.
> > -	 */
> > -	if (val) {
> > -		*val = comp_temp * 10;
> > -		return IIO_VAL_INT;
> > -	}
> > -
> > -	return 0;
> > +	/* IIO units are in milli Celsius */
> > +	*val = comp_temp * 10;
> > +	return IIO_VAL_INT;
> >  }
> >  
> >  static int bmp280_read_press(struct bmp280_data *data,
> >  			     int *val, int *val2)
> >  {
> > +	s32 adc_press, t_fine;
> >  	u32 comp_press;
> > -	s32 adc_press;
> >  	int ret;
> >  
> > -	/* Read and compensate temperature so we get a reading of t_fine. */
> > -	ret = bmp280_read_temp(data, NULL, NULL);
> > +	ret = bmp280_get_t_fine(data, &t_fine);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> > -			       data->buf, sizeof(data->buf));
> > -	if (ret < 0) {
> > -		dev_err(data->dev, "failed to read pressure\n");
> > +	ret = bmp280_read_press_adc(data, &adc_press);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> > -	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> > -	if (adc_press == BMP280_PRESS_SKIPPED) {
> > -		/* reading was skipped */
> > -		dev_err(data->dev, "reading pressure skipped\n");
> > -		return -EIO;
> > -	}
> > -	comp_press = bmp280_compensate_press(data, adc_press);
> > +	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
> >  
> > +	/* IIO units are in kPa */
> >  	*val = comp_press;
> >  	*val2 = 256000;
> >  
> > @@ -430,30 +481,21 @@ static int bmp280_read_press(struct bmp280_data *data,
> >  
> >  static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
> >  {
> > +	s32 adc_humidity, t_fine;
> >  	u32 comp_humidity;
> > -	s32 adc_humidity;
> >  	int ret;
> >  
> > -	/* Read and compensate temperature so we get a reading of t_fine. */
> > -	ret = bmp280_read_temp(data, NULL, NULL);
> > +	ret = bmp280_get_t_fine(data, &t_fine);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> > -			       &data->be16, sizeof(data->be16));
> > -	if (ret < 0) {
> > -		dev_err(data->dev, "failed to read humidity\n");
> > +	ret = bme280_read_humid_adc(data, &adc_humidity);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> > -	adc_humidity = be16_to_cpu(data->be16);
> > -	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> > -		/* reading was skipped */
> > -		dev_err(data->dev, "reading humidity skipped\n");
> > -		return -EIO;
> > -	}
> > -	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
> > +	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
> >  
> > +	/* IIO units are in 1000 * % */
> >  	*val = comp_humidity * 1000 / 1024;
> >  
> >  	return IIO_VAL_INT;
> > @@ -930,9 +972,29 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
> >   * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
> >   * https://github.com/BoschSensortec/BMP3-Sensor-API.
> >   */
> > -static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> > +static int bmp380_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
> 
> Interesting this one is unsigned.
> 

Yes, and it is also mentioned in the datasheet [3] in page 26.

[3]: https://www.mouser.com/pdfdocs/BST-BMP388-DS001-01.pdf

Cheers,
Vasilis

> > +{
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
> > +			       data->buf, sizeof(data->buf));
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "failed to read temperature\n");
> > +		return ret;
> > +	}
> > +
> > +	*adc_temp = get_unaligned_le24(data->buf);
> > +	if (*adc_temp == BMP380_TEMP_SKIPPED) {
> Same as above.
> > +		dev_err(data->dev, "reading temperature skipped\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static s32 bmp380_calc_t_fine(struct bmp280_data *data, u32 adc_temp)
> >  {
> > -	s64 var1, var2, var3, var4, var5, var6, comp_temp;
> > +	s64 var1, var2, var3, var4, var5, var6;
> >  	struct bmp380_calib *calib = &data->calib.bmp380;
> >  
> >  	var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
> > @@ -941,7 +1003,29 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> >  	var4 = var3 * ((s64) calib->T3);
> >  	var5 = (var2 << 18) + var4;
> >  	var6 = var5 >> 32;
> > -	data->t_fine = (s32) var6;
> > +	return (s32) var6; /* t_fine = var6 */
> > +}
> > +
> > +static int bmp380_get_t_fine(struct bmp280_data *data, s32 *t_fine)
> > +{
> > +	s32 adc_temp;
> > +	int ret;
> > +
> > +	ret = bmp380_read_temp_adc(data, &adc_temp);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*t_fine = bmp380_calc_t_fine(data, adc_temp);
> > +
> > +	return 0;
> > +}
> > +
> > +static int bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> > +{
> > +	s64 comp_temp;
> > +	s32 var6;
> > +
> > +	var6 = bmp380_calc_t_fine(data, adc_temp);
> >  	comp_temp = (var6 * 25) >> 14;
> >  
> >  	comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
> > @@ -955,27 +1039,48 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> >   * Taken from datasheet, Section 9.3. "Pressure compensation" and repository
> >   * https://github.com/BoschSensortec/BMP3-Sensor-API.
> >   */
> > -static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
> > +static int bmp380_read_press_adc(struct bmp280_data *data, u32 *adc_press)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> > +			       data->buf, sizeof(data->buf));
> > +	if (ret < 0) {
> > +		dev_err(data->dev, "failed to read pressure\n");
> > +		return ret;
> > +	}
> > +
> > +	*adc_press = get_unaligned_le24(data->buf);
> 
> As above
> 
> > +	if (*adc_press == BMP380_PRESS_SKIPPED) {
> > +		dev_err(data->dev, "reading pressure skipped\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Jonathan
> 

