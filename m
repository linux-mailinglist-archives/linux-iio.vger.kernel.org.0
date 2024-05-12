Return-Path: <linux-iio+bounces-4985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4958C3671
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 14:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2441F2203E
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA247208DA;
	Sun, 12 May 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3KsXuRn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F86EEB9;
	Sun, 12 May 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516667; cv=none; b=nofpZIFBC3loBPJbA4cKPghHyNeh09ko6meEXyxdexJiijbJOsztbTSXqPe+wJbea6VGulYb3e2bSaM0R3vtuD2E/ALGxUFEHBByznENZ28hMzwVGRriogNWsJzrcHKeum4wQwie4xTg4glgf8kYTl+0/8+gd2PgL22djEwEuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516667; c=relaxed/simple;
	bh=jJMM2i6oq27/0Pl9pcRhPFbuEM/reU2Nwb+eCq9Vdf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bftz4EcMqvxowOyJUQQj2gO0M2AB8YfUjQQYt9CJKJ0qkSfTKecb6wgHsxHZ67b/09dwtJ00WDWrqL/SqUc8tDL0Or1VBe+Nd+LjODPFPYXOqPNoB/I6VQRdzWEDJ72VwV9StkSRRpLFXUHXu40z2A6KYaZEXqCFyvdfjAhawJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3KsXuRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5867FC116B1;
	Sun, 12 May 2024 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715516666;
	bh=jJMM2i6oq27/0Pl9pcRhPFbuEM/reU2Nwb+eCq9Vdf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D3KsXuRnCJ+16tXSEG/XfLG6T+6cRgvgC7EUWX81V3UKFwnymRx1yG9KTAd7hpA8J
	 ZtTXu4ckcD+bZXNGAbnn6CwTxRVgZIaK1A/otNng8XXRQ2KX6+5KdT7KmZqVw5ltgX
	 gb4f9tnvbHoaxi2SF85tdnKdYoDRl8B1kIsjZwtVMeQu3B5ZnqoQheYuvn3YRS9H9i
	 ckyixoUOvj9ZvfFGoLD2nYQ0fwgKzgtc7QgcmomKf6wlVrympasMrEMMNIvPV8Lcw4
	 IGYMB8XYdju4YCDLj7KlIBufb2qG6RbFXAsWwgvcCTzQRUDrPqPykUdWAezxxcP3bK
	 Or/nyEEXhI26Q==
Date: Sun, 12 May 2024 13:24:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 5/9] iio: pressure: bmp280: Refactorize reading
 functions
Message-ID: <20240512132412.35d8fe36@jic23-huawei>
In-Reply-To: <20240508165207.145554-6-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
	<20240508165207.145554-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 18:52:03 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> For BMP18x, BMP28x, BME280, BMP38x the reading of the pressure
> value requires an update of the t_fine variable which happens
> through reading the temperature value.
> 
> So all the bmpxxx_read_press() functions of the above sensors
> are internally calling the equivalent bmpxxx_read_temp() function
> in order to update the t_fine value. By just looking at the code
> this functionality is a bit hidden and is not easy to understand
> why those channels are not independent.
> 
> This commit tries to clear these things a bit by splitting the
> bmpxxx_{read/compensate}_{temp/press/humid}() to the following:
> 
> i. bmpxxx_read_{temp/press/humid}_adc(): read the raw value from
> the sensor.
> 
> ii. bmpxx_calc_t_fine(): calculate the t_fine variable.
> 
> iii. bmpxxx_get_t_fine(): get the t_fine variable.
> 
> iv. bmpxxx_compensate_{temp/press/humid}(): compensate the adc
> values and return the calculated value.
> 
> v. bmpxxx_read_{temp/press/humid}(): combine calls of the
> aforementioned functions to return the requested value.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
A few minor things inline.  Given I've picked up the 1st 4 patches,
please base your v7 on top of those.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 361 ++++++++++++++++++-----------
>  drivers/iio/pressure/bmp280.h      |   6 -
>  2 files changed, 232 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index dd5c526dacbd..a864f8db8e24 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -288,13 +288,35 @@ static int bme280_read_calib(struct bmp280_data *data)
>   *
>   * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
>   */

Seems this comment should probably follow the maths which has moved.

> +static int bme280_read_humid_adc(struct bmp280_data *data, u16 *adc_humidity)
> +{
> +	u16 value_humidity;
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> +			       &data->be16, sizeof(data->be16));
> +	if (ret) {
> +		dev_err(data->dev, "failed to read humidity\n");
> +		return ret;
> +	}
> +
> +	value_humidity = be16_to_cpu(data->be16);
> +	if (value_humidity == BMP280_HUMIDITY_SKIPPED) {
> +		dev_err(data->dev, "reading humidity skipped\n");
> +		return -EIO;
> +	}
> +	*adc_humidity = value_humidity;
> +
> +	return 0;
> +}

...
> @@ -313,8 +335,29 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
>   *
>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>   */
Is this comment still relevant here? Seems it should probably move to follow
that maths.

> -static s32 bmp280_compensate_temp(struct bmp280_data *data,
> -				  u32 adc_temp)
> +static int bmp280_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
> +{

>  
>  static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
>  {
> -	u32 adc_press, comp_press;
> +	u32 adc_press, comp_press, t_fine;
>  	int ret;
>  
> -	/* Read and compensate for temperature so we get a reading of t_fine */
> -	ret = bmp380_read_temp(data, NULL, NULL);
> +	ret = bmp380_get_t_fine(data, &t_fine);
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> -			       data->buf, sizeof(data->buf));
> -	if (ret) {
> -		dev_err(data->dev, "failed to read pressure\n");
> +	ret = bmp380_read_press_adc(data, &adc_press);
> +	if (ret)
>  		return ret;
> -	}
>  
> -	adc_press = get_unaligned_le24(data->buf);
> -	if (adc_press == BMP380_PRESS_SKIPPED) {
> -		dev_err(data->dev, "reading pressure skipped\n");
> -		return -EIO;
> -	}
> -	comp_press = bmp380_compensate_press(data, adc_press);
> +	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
>  
> +	/* IIO units are in kPa */

Probably worth keeping the reference to what the unit of the
datasheet maths is around.

>  	*val = comp_press;
> -	/* Compensated pressure is in cPa (centipascals) */
>  	*val2 = 100000;
>  
>  	return IIO_VAL_FRACTIONAL;
> @@ -1825,7 +1916,7 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
>  	return 0;
>  }


> -static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
> +static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
> +				   s32 t_fine)
>  {
>  	struct bmp180_calib *calib = &data->calib.bmp180;
>  	s32 oss = data->oversampling_press;
> @@ -1965,7 +2068,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
>  	s32 b3, b6;
>  	u32 b4, b7;
>  
> -	b6 = data->t_fine - 4000;
> +	b6 = t_fine - 4000;
>  	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
>  	x2 = calib->AC2 * b6 >> 11;
>  	x3 = x1 + x2;
> @@ -1974,7 +2077,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
>  	x2 = (calib->B1 * ((b6 * b6) >> 12)) >> 16;
>  	x3 = (x1 + x2 + 2) >> 2;
>  	b4 = calib->AC4 * (u32)(x3 + 32768) >> 15;
> -	b7 = (adc_press - b3) * (50000 >> oss);
> +	b7 = (((u32)adc_press) - b3) * (50000 >> oss);

Casting from u32 to u32?

>  	if (b7 < 0x80000000)
>  		p = (b7 * 2) / b4;
>  	else
> @@ -1990,19 +2093,19 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
>  static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)

> +	/* IIO units are in kPa */

I think this is an unrelated improvement as original code doesn't have such a comment.
So shouldn't really be in this patch. If you want to keep it here rather than pushing it
into an additional patch, mention it in the commit message. "additional comments on base
units added for consistency" or something like that.
>  	*val = comp_press;
>  	*val2 = 1000;

