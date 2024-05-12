Return-Path: <linux-iio+bounces-4988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C978C3808
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376C11F21F39
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90BE2EB1D;
	Sun, 12 May 2024 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMb9F+pY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACBF134AC;
	Sun, 12 May 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539376; cv=none; b=FKZgX1riJH7hGoorIxH0h8cr5yJuPJdXYRZ+clCmunwusnvvgtQ+uVqkOEFJB3HEUULRJYE+8ZgqANwvuof6w63OSSDn78f9m6DfT1ee52Cgg2lN6jSn4U9XH8+xq+6NErNuPntmvk6Br9LWbnW4xksAxqvP9NKl0AF3IfVBiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539376; c=relaxed/simple;
	bh=2Aowy+0Dh1NCr451QxQds3RyzTAecA3csen5IePe5t8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daaz9mVz/cQrBYyeIt7bl6ek0EXrd0wyXxC10rMnrYVDtceWa6QYXhYIeMuy9ueJgRbCeeady2nbZg75Epqo9weg7NQ/IOTe75HMEAww3/vGexPm7mW8kx8heSW8uJWAb60kXoTKeP2V9e7QCkB4TOu41w8QRObCTAK1uHVkVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMb9F+pY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ffad242c8so14455165e9.3;
        Sun, 12 May 2024 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715539373; x=1716144173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iSdY4IAt1rjl81SkB6DZ1/llfE2KLF2W//U478tz9U=;
        b=gMb9F+pY1lp7+n54DMEn6Ke1QHdFwHAeQLA74gjtolDdz3GrBbIzHMBu7749ooc1Dt
         vda+z+D9To+rrsDYIvyFY4NEPe7CRY24dNJafGta9qby6iY7M9NcdTHOXOP80563+Jke
         6e7Mg0AJjOAVYfHfEH+TSU/4A/0dxQCK2UP3zb8klyLfzJwy4SKVHMk64xIJ0L7dL1Qb
         q3iFCQoP4CTt+YkNNX1IiBayPLjBJKP2EsUXUXCRQFOvWvQG0jZ5lGtcVcXg5Td12lfe
         VG/1zDMeQTYDeeRa5L0iGiAbxFIASgQtkUOloKOGDv/bIDlusdk/qORd97Ey0Q0dgF2Q
         amxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715539373; x=1716144173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iSdY4IAt1rjl81SkB6DZ1/llfE2KLF2W//U478tz9U=;
        b=WKm4nvZtAdenfsQ/6NusnCUXZjpCO0DLYvoMLzPQttO/Eq5dMnTHvp6AMtFU4fYuqI
         ZSa1Ux0/g8I+zE6LXbJChU/YnN9ZDoYi9DEeCAG1S5SaZjtk/XbU+ZcXteABWtFFMvoD
         mRHxpaIbeSwF8iU41Cc1Jt0yQT0gxKZ7NI9bb1+pe0VCsRk0TzhQrzEw0bDhqKwVm7Ej
         021zgZFqceNX7TzdclWzvvWvtAeI0e3NM85j+7NYJ1g0z6Rq6rOORMoN/F8ChdtVPmgF
         eppLZQhSL8xG1a6DejUOLxifftLXPTjJB0ixcmRm6Mt16joLhc3FZKniFZbwR60WL8pB
         wdEw==
X-Forwarded-Encrypted: i=1; AJvYcCUlRT6NPpTRYOTtxjdLHah2W/yByOAkkbvQSoqHB6Ijjo/WndkL75pLP65zz3YiosZuWeRjd7pPd4SytG+I0yiEQHR8AG8whIw8uqUfPDWsvX8bN7GcO7i8bs1BSBjUJAACO/FZZdX5
X-Gm-Message-State: AOJu0YxfFDvykOqv632Gtz93s3Q2GBvhMJX6pYq0gBhEKozeVoQwUUx0
	RaPcki6i1OmlWCJuYteMqWTywY97fZjB2ovtcbW/zTRWZTNJhxJynNYRQW52
X-Google-Smtp-Source: AGHT+IHfuYkd+AVcicKGuZEBbgZMTPjFoHnmP8R4CMugArGJbVF4iOt1TQptzX4QoTgbmKArCjnX0g==
X-Received: by 2002:a05:600c:444c:b0:41b:b39c:603 with SMTP id 5b1f17b1804b1-41fea53833cmr83349525e9.0.1715539372810;
        Sun, 12 May 2024 11:42:52 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:ce14:864c:436e:5c6d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf20sm9328904f8f.93.2024.05.12.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 11:42:52 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 12 May 2024 20:42:50 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 5/9] iio: pressure: bmp280: Refactorize reading
 functions
Message-ID: <20240512184250.GA24095@vamoiridPC>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
 <20240508165207.145554-6-vassilisamir@gmail.com>
 <20240512132412.35d8fe36@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512132412.35d8fe36@jic23-huawei>

On Sun, May 12, 2024 at 01:24:12PM +0100, Jonathan Cameron wrote:
> On Wed,  8 May 2024 18:52:03 +0200
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
> A few minor things inline.  Given I've picked up the 1st 4 patches,
> please base your v7 on top of those.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 361 ++++++++++++++++++-----------
> >  drivers/iio/pressure/bmp280.h      |   6 -
> >  2 files changed, 232 insertions(+), 135 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index dd5c526dacbd..a864f8db8e24 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -288,13 +288,35 @@ static int bme280_read_calib(struct bmp280_data *data)
> >   *
> >   * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
> >   */
> 
> Seems this comment should probably follow the maths which has moved.
> 
> > +static int bme280_read_humid_adc(struct bmp280_data *data, u16 *adc_humidity)
> > +{
> > +	u16 value_humidity;
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> > +			       &data->be16, sizeof(data->be16));
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read humidity\n");
> > +		return ret;
> > +	}
> > +
> > +	value_humidity = be16_to_cpu(data->be16);
> > +	if (value_humidity == BMP280_HUMIDITY_SKIPPED) {
> > +		dev_err(data->dev, "reading humidity skipped\n");
> > +		return -EIO;
> > +	}
> > +	*adc_humidity = value_humidity;
> > +
> > +	return 0;
> > +}
> 
> ...
> > @@ -313,8 +335,29 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
> >   *
> >   * Taken from datasheet, Section 3.11.3, "Compensation formula".
> >   */
> Is this comment still relevant here? Seems it should probably move to follow
> that maths.
> 
> > -static s32 bmp280_compensate_temp(struct bmp280_data *data,
> > -				  u32 adc_temp)
> > +static int bmp280_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
> > +{
> 
> >  
> >  static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
> >  {
> > -	u32 adc_press, comp_press;
> > +	u32 adc_press, comp_press, t_fine;
> >  	int ret;
> >  
> > -	/* Read and compensate for temperature so we get a reading of t_fine */
> > -	ret = bmp380_read_temp(data, NULL, NULL);
> > +	ret = bmp380_get_t_fine(data, &t_fine);
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> > -			       data->buf, sizeof(data->buf));
> > -	if (ret) {
> > -		dev_err(data->dev, "failed to read pressure\n");
> > +	ret = bmp380_read_press_adc(data, &adc_press);
> > +	if (ret)
> >  		return ret;
> > -	}
> >  
> > -	adc_press = get_unaligned_le24(data->buf);
> > -	if (adc_press == BMP380_PRESS_SKIPPED) {
> > -		dev_err(data->dev, "reading pressure skipped\n");
> > -		return -EIO;
> > -	}
> > -	comp_press = bmp380_compensate_press(data, adc_press);
> > +	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
> >  
> > +	/* IIO units are in kPa */
> 
> Probably worth keeping the reference to what the unit of the
> datasheet maths is around.
> 
> >  	*val = comp_press;
> > -	/* Compensated pressure is in cPa (centipascals) */
> >  	*val2 = 100000;
> >  
> >  	return IIO_VAL_FRACTIONAL;
> > @@ -1825,7 +1916,7 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
> >  	return 0;
> >  }
> 
> 
> > -static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
> > +static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
> > +				   s32 t_fine)
> >  {
> >  	struct bmp180_calib *calib = &data->calib.bmp180;
> >  	s32 oss = data->oversampling_press;
> > @@ -1965,7 +2068,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
> >  	s32 b3, b6;
> >  	u32 b4, b7;
> >  
> > -	b6 = data->t_fine - 4000;
> > +	b6 = t_fine - 4000;
> >  	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
> >  	x2 = calib->AC2 * b6 >> 11;
> >  	x3 = x1 + x2;
> > @@ -1974,7 +2077,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
> >  	x2 = (calib->B1 * ((b6 * b6) >> 12)) >> 16;
> >  	x3 = (x1 + x2 + 2) >> 2;
> >  	b4 = calib->AC4 * (u32)(x3 + 32768) >> 15;
> > -	b7 = (adc_press - b3) * (50000 >> oss);
> > +	b7 = (((u32)adc_press) - b3) * (50000 >> oss);
> 
> Casting from u32 to u32?
> 
> >  	if (b7 < 0x80000000)
> >  		p = (b7 * 2) / b4;
> >  	else
> > @@ -1990,19 +2093,19 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
> >  static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
> 
> > +	/* IIO units are in kPa */
> 
> I think this is an unrelated improvement as original code doesn't have such a comment.
> So shouldn't really be in this patch. If you want to keep it here rather than pushing it
> into an additional patch, mention it in the commit message. "additional comments on base
> units added for consistency" or something like that.
> >  	*val = comp_press;
> >  	*val2 = 1000;

Hi Jonathan!

Thank you very much once again for the amazing feedback!

As it looks like, I changed the code but I forgot to move the
comments accordingly. Thank you very much for pointing this out.
The extra comments are indeed not necessary, they don't add some
specific value so I can drop them.

Cheers,
Vasilis

