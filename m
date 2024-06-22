Return-Path: <linux-iio+bounces-6712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD0A9133DF
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 14:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525242840D1
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983E116A953;
	Sat, 22 Jun 2024 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcxK78OC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FEE14A098;
	Sat, 22 Jun 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058765; cv=none; b=CPzsutOulzGJ9lor52ARwoAGdqfBc+qZ0DEKf3QJ20KNpmneILYhXAEioBdVAJJz+FF/hzAuhxt/LNgIS+xTKphWzJyiZhKW+aQyqAlM1c93bWXuea6aSxGgisn70/dH4Qr6uMXk1lsTv/BNluOXpa6BfV2lJARrCNsO4TQXrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058765; c=relaxed/simple;
	bh=YClVhme1vlJux/pS918FYlt99I/G7ZpCT4SPeq9Haio=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvLPOpif+hyRhsnpR4VLft1cCsLRe03/Nnr2t/AQFWebFSebgZSU+fq9QMj+ZYmL0rDkWwu9+tn9pBmwsnptwBWLdO2CZT7weDfQWPLqe683FjL/aGVulkV7vJTtA9jBFWTgqGP/QBzsBoPZ1V2lCtDxBkP2G8qBq7ZDUhHj2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcxK78OC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso40685201fa.1;
        Sat, 22 Jun 2024 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719058761; x=1719663561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sb1JRkrIDzKbSle7mCH9l+OyfeIVMXUk2nixQStEIk=;
        b=NcxK78OCO5cnj5bxp+T4RRlN9YSdLT75P6Ek1/KZCa4Hvl1QYkf4k1dFLHOAJUfDKG
         S9YMjQKdqD5aRJj2ZypQwnZxN+6aB+98B3AF9uXm/jZxlu7nkLmpPZbVHSrSfaowRcle
         ysoMEG/imNW1zBhzLSuZoJK2sPnz+aCeFb3qZvMRMLrvd5dvuKeLVqpQFLd5neVFBQSR
         afz3sEllSEPJ0t5oBKXSR8na0AxUQzSKr9do2ptNxk8IlRzV4/uT4KOVyI1+lLqBFofR
         zkXjspgYUowmQ2y31G4vNakPgDtyIMESPvCdQ0eri92lgAcKwiFiphY8bXZm+plwL8cQ
         KQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719058761; x=1719663561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sb1JRkrIDzKbSle7mCH9l+OyfeIVMXUk2nixQStEIk=;
        b=eqBJVlm+FJMkQArWGj1u23vK22122QuduQR1IXAH1cjfReP0Tq+PG+Ez5Rmvdwkyg+
         9hsq1EM9tn6vihNh+5uaL97CqfFDky3bvMKcVLehr2SUQiHMto8xtQ8TVkqs/vY6ekZe
         8QdmxVilEFTWq+ftBKTqUK4c2znLaE/AerCv3Jl9HvK+LYj6jrd6F34XHyXzL9bdhHih
         Sr9Jyj8Ox/yGmbx8EBwdhYpfYHxswqzx0ygm2Zq0BOKB9m7XcejSyH+epX9HgvHxZCPA
         jE1KHXQM3GOIRz45yTrN/bZZ4f8Or3vnIPFJ48nvlKRBED6X5V8m8LQb+nC5zFyaO7fi
         uLLA==
X-Forwarded-Encrypted: i=1; AJvYcCU8wMTDx1XGF6nstsHq+eCBeC/FD++BOKiCLfIHOEAG2zMTQKBWOATczi6jSIFNIGxBbMmdo4EHRjg2rccoNo75w9EQXu4W2YM523eFAgWl6JgP4gPb2dQDM26vUlbynOCQBBGjjtkW
X-Gm-Message-State: AOJu0YzkYoPOZ9bdmw8ZDJ3RFFWxNwNe7EGvwfTis3FveiGX2hdDyvSq
	8wv/oPJdkMQNHd5lDEOM4a1XAPAY8dSE0HpU52ZH/j1uS7j0e808
X-Google-Smtp-Source: AGHT+IH8lNEXfmOT1fUAx+bwNJgMeImquEakhswPeoLVXcJUtIFKQLQ8qz+slkx2Ee7zu2FMc387vQ==
X-Received: by 2002:a05:6512:3da3:b0:52b:c33a:aa7c with SMTP id 2adb3069b0e04-52ccaa599d0mr10081326e87.65.1719058760880;
        Sat, 22 Jun 2024 05:19:20 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:57bf:cecc:afec:b13d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72440f2782sm2184966b.25.2024.06.22.05.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:19:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 22 Jun 2024 14:19:18 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adam Rizkalla <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <20240622121918.GA123707@vamoiridPC>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
 <20240617230540.32325-2-vassilisamir@gmail.com>
 <20240622102826.2ba446d9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622102826.2ba446d9@jic23-huawei>

On Sat, Jun 22, 2024 at 10:28:26AM +0100, Jonathan Cameron wrote:
> On Tue, 18 Jun 2024 01:05:38 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Add the coefficients for the IIO standard units and the IIO value
> > inside the chip_info structure.
> > 
> > Move the calculations for the IIO unit compatibility from inside the
> > read_{temp,press,humid}() functions and move them to the general
> > read_raw() function.
> > 
> > In this way, all the data for the calculation of the value are
> > located in the chip_info structure of the respective sensor.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Does this incorporate the fix?  I'm a little confused looking at
> what is visible here, so I'd like Adam to take a look.
> 
> Btw, you missed cc'ing Adam.
> 

Ah, I only used the output of get_maintainer...

> > ---
> >  drivers/iio/pressure/bmp280-core.c | 167 +++++++++++++++++------------
> >  drivers/iio/pressure/bmp280.h      |  13 ++-
> >  2 files changed, 107 insertions(+), 73 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 50d71ad83f37..27c00af060fa 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -445,10 +445,8 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
> >  	return (u32)p;
> >  }
> >  
> > -static int bmp280_read_temp(struct bmp280_data *data,
> > -			    int *val, int *val2)
> > +static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
> >  {
> > -	s32 comp_temp;
> >  	u32 adc_temp;
> >  	int ret;
> >  
> > @@ -456,16 +454,15 @@ static int bmp280_read_temp(struct bmp280_data *data,
> >  	if (ret)
> >  		return ret;
> >  
> > -	comp_temp = bmp280_compensate_temp(data, adc_temp);
> > +	*comp_temp = bmp280_compensate_temp(data, adc_temp);
> >  
> > -	*val = comp_temp * 10;
> > -	return IIO_VAL_INT;
> > +	return 0;
> >  }
> >  
> > -static int bmp280_read_press(struct bmp280_data *data,
> > -			     int *val, int *val2)
> > +static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
> >  {
> > -	u32 comp_press, adc_press, t_fine;
> > +	u32 adc_press;
> > +	s32 t_fine;
> >  	int ret;
> >  
> >  	ret = bmp280_get_t_fine(data, &t_fine);
> > @@ -476,17 +473,13 @@ static int bmp280_read_press(struct bmp280_data *data,
> >  	if (ret)
> >  		return ret;
> >  
> > -	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
> > -
> > -	*val = comp_press;
> > -	*val2 = 256000;
> > +	*comp_press = bmp280_compensate_press(data, adc_press, t_fine);
> >  
> > -	return IIO_VAL_FRACTIONAL;
> > +	return 0;
> >  }
> >  
> > -static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
> > +static int bme280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
> >  {
> > -	u32 comp_humidity;
> >  	u16 adc_humidity;
> >  	s32 t_fine;
> >  	int ret;
> > @@ -499,11 +492,9 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
> >  	if (ret)
> >  		return ret;
> >  
> > -	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
> > -
> > -	*val = comp_humidity * 1000 / 1024;
> > +	*comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
> >  
> > -	return IIO_VAL_INT;
> > +	return 0;
> >  }
> >  
> >  static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> > @@ -511,6 +502,8 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> >  				int *val, int *val2, long mask)
> >  {
> >  	struct bmp280_data *data = iio_priv(indio_dev);
> > +	int chan_value;
> > +	int ret;
> >  
> >  	guard(mutex)(&data->lock);
> >

...
  
> > @@ -518,11 +511,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_PROCESSED:
> >  		switch (chan->type) {
> >  		case IIO_HUMIDITYRELATIVE:
> > -			return data->chip_info->read_humid(data, val, val2);
> > +			ret = data->chip_info->read_humid(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = data->chip_info->humid_coeffs[0] * chan_value;
> > +			*val2 = data->chip_info->humid_coeffs[1];
> > +			return data->chip_info->humid_coeffs_type;
> >  		case IIO_PRESSURE:
> > -			return data->chip_info->read_press(data, val, val2);
> > +			ret = data->chip_info->read_press(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = data->chip_info->press_coeffs[0] * chan_value;
> > +			*val2 = data->chip_info->press_coeffs[1];
> > +			return data->chip_info->press_coeffs_type;
> >  		case IIO_TEMP:
> > -			return data->chip_info->read_temp(data, val, val2);
> > +			ret = data->chip_info->read_temp(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = data->chip_info->temp_coeffs[0] * (s64)chan_value;

This is the first difference with the previous version where I incorporated
the typecasting to (s64).

> > +			*val2 = data->chip_info->temp_coeffs[1];
> > +			return data->chip_info->temp_coeffs_type;
> >  		default:
> >  			return -EINVAL;
> >  		}
> > @@ -822,6 +833,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
> >  
> >  static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> >  static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
> > +static const int bmp280_temp_coeffs[] = { 10, 1 };
> > +static const int bmp280_press_coeffs[] = { 1, 256000 };
> >  
> >  const struct bmp280_chip_info bmp280_chip_info = {
> >  	.id_reg = BMP280_REG_ID,
> > @@ -850,6 +863,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
> >  	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> >  	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
> >  
> > +	.temp_coeffs = bmp280_temp_coeffs,
> > +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> > +	.press_coeffs = bmp280_press_coeffs,
> > +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > +
> >  	.chip_config = bmp280_chip_config,
> >  	.read_temp = bmp280_read_temp,
> >  	.read_press = bmp280_read_press,
> > @@ -877,6 +895,7 @@ static int bme280_chip_config(struct bmp280_data *data)
> >  }
> >  
> >  static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
> > +static const int bme280_humid_coeffs[] = { 1000, 1024 };
> >  
> >  const struct bmp280_chip_info bme280_chip_info = {
> >  	.id_reg = BMP280_REG_ID,
> > @@ -899,6 +918,13 @@ const struct bmp280_chip_info bme280_chip_info = {
> >  	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> >  	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
> >  
> > +	.temp_coeffs = bmp280_temp_coeffs,
> > +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> > +	.press_coeffs = bmp280_press_coeffs,
> > +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > +	.humid_coeffs = bme280_humid_coeffs,
> > +	.humid_coeffs_type = IIO_VAL_FRACTIONAL,
> > +
> >  	.chip_config = bme280_chip_config,
> >  	.read_temp = bmp280_read_temp,
> >  	.read_press = bmp280_read_press,
> > @@ -1091,9 +1117,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data,
> >  	return comp_press;
> >  }
> >  
> > -static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
> >  {
> > -	s32 comp_temp;
> >  	u32 adc_temp;
> >  	int ret;
> >  
> > @@ -1101,15 +1126,14 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
> >  	if (ret)
> >  		return ret;
> >  
> > -	comp_temp = bmp380_compensate_temp(data, adc_temp);
> > +	*comp_temp = bmp380_compensate_temp(data, adc_temp);
> >  
> > -	*val = comp_temp * 10;
> > -	return IIO_VAL_INT;
> > +	return 0;
> >  }
> >  
> > -static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
> >  {
> > -	u32 adc_press, comp_press, t_fine;
> > +	u32 adc_press, t_fine;
> >  	int ret;
> >  
> >  	ret = bmp380_get_t_fine(data, &t_fine);
> > @@ -1120,12 +1144,9 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
> >  	if (ret)
> >  		return ret;
> >  
> > -	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
> > -
> > -	*val = comp_press;
> > -	*val2 = 100000;
> > +	*comp_press = bmp380_compensate_press(data, adc_press, t_fine);
> >  
> > -	return IIO_VAL_FRACTIONAL;
> > +	return 0;
> >  }
> >  
> >  static int bmp380_read_calib(struct bmp280_data *data)
> > @@ -1296,6 +1317,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
> >  static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
> >  static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
> >  static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
> > +static const int bmp380_temp_coeffs[] = { 10, 1 };
> > +static const int bmp380_press_coeffs[] = { 1, 100000 };
> >  
> >  const struct bmp280_chip_info bmp380_chip_info = {
> >  	.id_reg = BMP380_REG_ID,
> > @@ -1323,6 +1346,11 @@ const struct bmp280_chip_info bmp380_chip_info = {
> >  	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
> >  	.iir_filter_coeff_default = 2,
> >  
> > +	.temp_coeffs = bmp380_temp_coeffs,
> > +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> > +	.press_coeffs = bmp380_press_coeffs,
> > +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > +
> >  	.chip_config = bmp380_chip_config,
> >  	.read_temp = bmp380_read_temp,
> >  	.read_press = bmp380_read_press,
> > @@ -1443,9 +1471,9 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
> >   * for what is expected on IIO ABI.
> >   */
> >  

...

> > -static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
> >  {
> > -	s32 raw_temp;
> > +	s32 value_temp;
> >  	int ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
> > @@ -1455,25 +1483,19 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
> >  		return ret;
> >  	}
> >  
> > -	raw_temp = get_unaligned_le24(data->buf);
> > -	if (raw_temp == BMP580_TEMP_SKIPPED) {
> > +	value_temp = get_unaligned_le24(data->buf);
> > +	if (value_temp == BMP580_TEMP_SKIPPED) {
> >  		dev_err(data->dev, "reading temperature skipped\n");
> >  		return -EIO;
> >  	}
> > +	*raw_temp = sign_extend32(value_temp, 23);
> >  

Here I use Adam's correction with sign_extend32()

> > -	/*
> > -	 * Temperature is returned in Celsius degrees in fractional
> > -	 * form down 2^16. We rescale by x1000 to return millidegrees
> > -	 * Celsius to respect IIO ABI.
> > -	 */
> > -	raw_temp = sign_extend32(raw_temp, 23);
> > -	*val = ((s64)raw_temp * 1000) / (1 << 16);
> > -	return IIO_VAL_INT;
> > +	return 0;
> >  }
> >  
> > -static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
> >  {
> > -	u32 raw_press;
> > +	u32 value_press;
> >  	int ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
> > @@ -1483,18 +1505,14 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
> >  		return ret;
> >  	}
> >  
> > -	raw_press = get_unaligned_le24(data->buf);
> > -	if (raw_press == BMP580_PRESS_SKIPPED) {
> > +	value_press = get_unaligned_le24(data->buf);
> > +	if (value_press == BMP580_PRESS_SKIPPED) {
> >  		dev_err(data->dev, "reading pressure skipped\n");
> >  		return -EIO;
> >  	}
> > -	/*
> > -	 * Pressure is returned in Pascals in fractional form down 2^16.
> > -	 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
> > -	 */
> > -	*val = raw_press;
> > -	*val2 = 64000; /* 2^6 * 1000 */
> > -	return IIO_VAL_FRACTIONAL;
> > +	*raw_press = value_press;
> > +
> > +	return 0;
> >  }
> >  
> >  static const int bmp580_odr_table[][2] = {
> > @@ -1830,6 +1848,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
> >  
> >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> > +static const int bmp580_temp_coeffs[] = { 1000, 16 };
> > +static const int bmp580_press_coeffs[] = { 1, 64000};
> >  
> >  const struct bmp280_chip_info bmp580_chip_info = {
> >  	.id_reg = BMP580_REG_CHIP_ID,
> > @@ -1856,6 +1876,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
> >  	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
> >  	.iir_filter_coeff_default = 2,
> >  
> > +	.temp_coeffs = bmp580_temp_coeffs,
> > +	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
> > +	.press_coeffs = bmp580_press_coeffs,
> > +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > +
> >  	.chip_config = bmp580_chip_config,
> >  	.read_temp = bmp580_read_temp,
> >  	.read_press = bmp580_read_press,
> > @@ -2011,9 +2036,8 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> >  	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
> >  }
> >  
> > -static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp180_read_temp(struct bmp280_data *data, s32 *comp_temp)
> >  {
> > -	s32 comp_temp;
> >  	u32 adc_temp;
> >  	int ret;
> >  
> > @@ -2021,10 +2045,9 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
> >  	if (ret)
> >  		return ret;
> >  
> > -	comp_temp = bmp180_compensate_temp(data, adc_temp);
> > +	*comp_temp = bmp180_compensate_temp(data, adc_temp);
> >  
> > -	*val = comp_temp * 100;
> > -	return IIO_VAL_INT;
> > +	return 0;
> >  }
> >  
> >  static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
> > @@ -2087,9 +2110,9 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
> >  	return p + ((x1 + x2 + 3791) >> 4);
> >  }
> >  
> > -static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
> >  {
> > -	u32 comp_press, adc_press;
> > +	u32 adc_press;
> >  	s32 t_fine;
> >  	int ret;
> >  
> > @@ -2101,12 +2124,9 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
> >  	if (ret)
> >  		return ret;
> >  
> > -	comp_press = bmp180_compensate_press(data, adc_press, t_fine);
> > -
> > -	*val = comp_press;
> > -	*val2 = 1000;
> > +	*comp_press = bmp180_compensate_press(data, adc_press, t_fine);
> >  
> > -	return IIO_VAL_FRACTIONAL;
> > +	return 0;
> >  }
> >  
> >  static int bmp180_chip_config(struct bmp280_data *data)
> > @@ -2117,6 +2137,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
> >  static const int bmp180_oversampling_temp_avail[] = { 1 };
> >  static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
> >  static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
> > +static const int bmp180_temp_coeffs[] = { 100, 1 };
> > +static const int bmp180_press_coeffs[] = { 1, 1000 };
> >  
> >  const struct bmp280_chip_info bmp180_chip_info = {
> >  	.id_reg = BMP280_REG_ID,
> > @@ -2137,6 +2159,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
> >  		ARRAY_SIZE(bmp180_oversampling_press_avail),
> >  	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
> >  
> > +	.temp_coeffs = bmp180_temp_coeffs,
> > +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> > +	.press_coeffs = bmp180_press_coeffs,
> > +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > +
> >  	.chip_config = bmp180_chip_config,
> >  	.read_temp = bmp180_read_temp,
> >  	.read_press = bmp180_read_press,
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index 7c30e4d523be..a3d2cd722760 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -446,10 +446,17 @@ struct bmp280_chip_info {
> >  	int num_sampling_freq_avail;
> >  	int sampling_freq_default;
> >  
> > +	const int *temp_coeffs;
> > +	const int temp_coeffs_type;
> > +	const int *press_coeffs;
> > +	const int press_coeffs_type;
> > +	const int *humid_coeffs;
> > +	const int humid_coeffs_type;
> > +
> >  	int (*chip_config)(struct bmp280_data *data);
> > -	int (*read_temp)(struct bmp280_data *data, int *val, int *val2);
> > -	int (*read_press)(struct bmp280_data *data, int *val, int *val2);
> > -	int (*read_humid)(struct bmp280_data *data, int *val, int *val2);
> > +	int (*read_temp)(struct bmp280_data *data, s32 *adc_temp);
> > +	int (*read_press)(struct bmp280_data *data, u32 *adc_press);
> > +	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
> >  	int (*read_calib)(struct bmp280_data *data);
> >  	int (*preinit)(struct bmp280_data *data);
> >  };
> 

