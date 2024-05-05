Return-Path: <linux-iio+bounces-4821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF78BC334
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 21:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275731F21393
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D26D1B9;
	Sun,  5 May 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzIqTWfS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2E6BFCC;
	Sun,  5 May 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714936879; cv=none; b=RPaKWeaH0fVlOipp6IolzgdFPULWcKQRwgA0T7w0Smve0w7GZP/1V4CgY7nJQneGeDN3vk3LvO7O3HAjaARahYDRX9e5+sz2IQxcu0Mn42fiwEYxovSnHARNnAgMEAcTzkYGbeVf6HdSSRzzznGtEmlqCqjZtxPeVKC3ML0/jzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714936879; c=relaxed/simple;
	bh=asR2KkaKMJZArPfNZiebOP9xwfu6gB/rv/Gcl5OpSOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFEPJL4045d7U1sH0b/4wJZM0DkIAvnhpXMhans2Ea88mZiT+lMSe6W8zfSsQVbQCI0Oom3WC+die8s/ztB9NcNFHVxVYB1apgEMKqpQLdnblDDJMBdF159jkv3JZUPx5rFqhcy0/BImQ0FJuQ31dFYwfpbzq5k4iaqKd0aHtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzIqTWfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8B4C113CC;
	Sun,  5 May 2024 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714936878;
	bh=asR2KkaKMJZArPfNZiebOP9xwfu6gB/rv/Gcl5OpSOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LzIqTWfShebSgjyCj36rjUpHPozQUfijZ9jZtcippKTaa8GEUK7TEJmrJX1Qqf1Uj
	 FmkIx5U1e3cM+03bDuUjSES+tZsZJzderxiQP4qvmG6FPsdgDsVwPrNJVy6EzFino7
	 LybWUyFp9gzwIBifdNHFWq244ur8J/UoTeZ+3SEr2ICBWej6+jYaMyNp1nysMoBHnw
	 23J/948r3jTki5ata7pXn4hTXNITKTHu06CrXNMZfgv0u1MLi8zzQgMDI1SrcI6uDr
	 w9Ko7/qxDXJGZyPSmGFGB9iSO1v3P7fQEG7oBN+YGipKskZv9dYdIc1uc/XyMfg3aD
	 72xkAUtIDsOtg==
Date: Sun, 5 May 2024 20:21:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 06/10] iio: pressure: bmp280: Refactorize reading
 functions
Message-ID: <20240505202106.1c780044@jic23-huawei>
In-Reply-To: <20240429190046.24252-7-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-7-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 21:00:42 +0200
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
In general looks good, but a few details to consider inline.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 351 ++++++++++++++++++-----------
>  drivers/iio/pressure/bmp280.h      |   6 -
>  2 files changed, 221 insertions(+), 136 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 8290028824e9..5ebce38e99f6 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -288,13 +288,33 @@ static int bme280_read_calib(struct bmp280_data *data)
>   *
>   * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
>   */
> +static int bme280_read_humid_adc(struct bmp280_data *data, s32 *adc_humidity)

It's an u16, so why use an s32?   I can see using a signed value avoids a cast later,
but it makes this more confusing to read, so I'd push that cast up to the user.

> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> +			       &data->be16, sizeof(data->be16));
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read humidity\n");
> +		return ret;
> +	}
> +
> +	*adc_humidity = be16_to_cpu(data->be16);

Trivial, but on error return we normally aim for side effect free.
To do that here use an internal variable first.
	s16 value;

...

	value = be16_to_cpu(data->be16)

	if (value == BMP280_HUMIDITY_SKIPPED) {
		dev_err(data->dev, "...
		return -EIO;
	}
This is the odd bit due to using an s32 to store a u16.
Have to rely on that size mismatch to avoid the sign accidentally mattering.
Which is ugly!

	*adc_humidity = value;

	return 0;


> +	if (*adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> +		dev_err(data->dev, "reading humidity skipped\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>  static u32 bme280_compensate_humidity(struct bmp280_data *data,
> -				      s32 adc_humidity)
> +				      s32 adc_humidity, s32 t_fine)
>  {
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	s32 var;
>  
> -	var = ((s32)data->t_fine) - (s32)76800;
> +	var = ((s32)t_fine) - (s32)76800;

Casting an s32 to an s32.  For the const it shouldn't matter as it'll be at least
32 bits and we don't care about the sign.

>  	var = ((((adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
>  		+ (s32)16384) >> 15) * (((((((var * calib->H6) >> 10)
>  		* (((var * (s32)calib->H3) >> 11) + (s32)32768)) >> 10)
> @@ -313,8 +333,27 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
>   *
>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>   */
> -static s32 bmp280_compensate_temp(struct bmp280_data *data,
> -				  s32 adc_temp)
> +static int bmp280_read_temp_adc(struct bmp280_data *data, s32 *adc_temp)

As before, sign of the extra variable is confusing. It's not signed
as it's a raw ADC value. So I'd use a u32 for it.

> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> +			       data->buf, sizeof(data->buf));
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read temperature\n");
> +		return ret;
> +	}
> +
> +	*adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> +	if (*adc_temp == BMP280_TEMP_SKIPPED) {
> +		dev_err(data->dev, "reading temperature skipped\n");
> +		return -EIO;
Same thing on side effects.  Best to avoid them if it is easy to do (like here!)
> +	}
> +
> +	return 0;
> +}
> +
> +static s32 bmp280_calc_t_fine(struct bmp280_data *data, s32 adc_temp)
>  {
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	s32 var1, var2;
> @@ -324,9 +363,26 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
>  	var2 = (((((adc_temp >> 4) - ((s32)calib->T1)) *
>  		  ((adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
>  		((s32)calib->T3)) >> 14;
> -	data->t_fine = var1 + var2;
> +	return var1 + var2; /* t_fine = var1 + var2 */
> +}
> +
> +static int bmp280_get_t_fine(struct bmp280_data *data, s32 *t_fine)
> +{
> +	s32 adc_temp;
> +	int ret;
> +
> +	ret = bmp280_read_temp_adc(data, &adc_temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	*t_fine = bmp280_calc_t_fine(data, adc_temp);
>  
> -	return (data->t_fine * 5 + 128) >> 8;
> +	return 0;
> +}
> +
> +static s32 bmp280_compensate_temp(struct bmp280_data *data, s32 adc_temp)
> +{
> +	return (bmp280_calc_t_fine(data, adc_temp) * 5 + 128) / 256;
>  }
>  
>  /*
> @@ -336,13 +392,33 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
>   *
>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>   */
> +static int bmp280_read_press_adc(struct bmp280_data *data, s32 *adc_press)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> +			       data->buf, sizeof(data->buf));
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read pressure\n");
> +		return ret;
> +	}
> +
> +	*adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> +	if (*adc_press == BMP280_PRESS_SKIPPED) {
> +		dev_err(data->dev, "reading pressure skipped\n");
> +		return -EIO;

As above; avoid side effects.

> +	}
> +
> +	return 0;
> +}
> +
>  static u32 bmp280_compensate_press(struct bmp280_data *data,
> -				   s32 adc_press)
> +				   s32 adc_press, s32 t_fine)
>  {
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	s64 var1, var2, p;
>  
> -	var1 = ((s64)data->t_fine) - 128000;
> +	var1 = ((s64)t_fine) - 128000;
>  	var2 = var1 * var1 * (s64)calib->P6;
>  	var2 += (var1 * (s64)calib->P5) << 17;
>  	var2 += ((s64)calib->P4) << 35;
> @@ -368,60 +444,35 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  	s32 adc_temp, comp_temp;
>  	int ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> -			       data->buf, sizeof(data->buf));
> -	if (ret < 0) {
> -		dev_err(data->dev, "failed to read temperature\n");
> +	ret = bmp280_read_temp_adc(data, &adc_temp);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> -	if (adc_temp == BMP280_TEMP_SKIPPED) {
> -		/* reading was skipped */
> -		dev_err(data->dev, "reading temperature skipped\n");
> -		return -EIO;
> -	}
>  	comp_temp = bmp280_compensate_temp(data, adc_temp);
>  
> -	/*
> -	 * val might be NULL if we're called by the read_press routine,
> -	 * who only cares about the carry over t_fine value.
> -	 */
> -	if (val) {
> -		*val = comp_temp * 10;
> -		return IIO_VAL_INT;
> -	}
> -
> -	return 0;
> +	/* IIO units are in milli Celsius */
> +	*val = comp_temp * 10;
> +	return IIO_VAL_INT;
>  }
>  
>  static int bmp280_read_press(struct bmp280_data *data,
>  			     int *val, int *val2)
>  {
> +	s32 adc_press, t_fine;
>  	u32 comp_press;
> -	s32 adc_press;
>  	int ret;
>  
> -	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp280_read_temp(data, NULL, NULL);
> +	ret = bmp280_get_t_fine(data, &t_fine);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> -			       data->buf, sizeof(data->buf));
> -	if (ret < 0) {
> -		dev_err(data->dev, "failed to read pressure\n");
> +	ret = bmp280_read_press_adc(data, &adc_press);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> -	if (adc_press == BMP280_PRESS_SKIPPED) {
> -		/* reading was skipped */
> -		dev_err(data->dev, "reading pressure skipped\n");
> -		return -EIO;
> -	}
> -	comp_press = bmp280_compensate_press(data, adc_press);
> +	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
>  
> +	/* IIO units are in kPa */
>  	*val = comp_press;
>  	*val2 = 256000;
>  
> @@ -430,30 +481,21 @@ static int bmp280_read_press(struct bmp280_data *data,
>  
>  static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  {
> +	s32 adc_humidity, t_fine;
>  	u32 comp_humidity;
> -	s32 adc_humidity;
>  	int ret;
>  
> -	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp280_read_temp(data, NULL, NULL);
> +	ret = bmp280_get_t_fine(data, &t_fine);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> -			       &data->be16, sizeof(data->be16));
> -	if (ret < 0) {
> -		dev_err(data->dev, "failed to read humidity\n");
> +	ret = bme280_read_humid_adc(data, &adc_humidity);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	adc_humidity = be16_to_cpu(data->be16);
> -	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> -		/* reading was skipped */
> -		dev_err(data->dev, "reading humidity skipped\n");
> -		return -EIO;
> -	}
> -	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
> +	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
>  
> +	/* IIO units are in 1000 * % */
>  	*val = comp_humidity * 1000 / 1024;
>  
>  	return IIO_VAL_INT;
> @@ -930,9 +972,29 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
>   * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
>   * https://github.com/BoschSensortec/BMP3-Sensor-API.
>   */
> -static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> +static int bmp380_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)

Interesting this one is unsigned.

> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
> +			       data->buf, sizeof(data->buf));
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read temperature\n");
> +		return ret;
> +	}
> +
> +	*adc_temp = get_unaligned_le24(data->buf);
> +	if (*adc_temp == BMP380_TEMP_SKIPPED) {
Same as above.
> +		dev_err(data->dev, "reading temperature skipped\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static s32 bmp380_calc_t_fine(struct bmp280_data *data, u32 adc_temp)
>  {
> -	s64 var1, var2, var3, var4, var5, var6, comp_temp;
> +	s64 var1, var2, var3, var4, var5, var6;
>  	struct bmp380_calib *calib = &data->calib.bmp380;
>  
>  	var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
> @@ -941,7 +1003,29 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
>  	var4 = var3 * ((s64) calib->T3);
>  	var5 = (var2 << 18) + var4;
>  	var6 = var5 >> 32;
> -	data->t_fine = (s32) var6;
> +	return (s32) var6; /* t_fine = var6 */
> +}
> +
> +static int bmp380_get_t_fine(struct bmp280_data *data, s32 *t_fine)
> +{
> +	s32 adc_temp;
> +	int ret;
> +
> +	ret = bmp380_read_temp_adc(data, &adc_temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	*t_fine = bmp380_calc_t_fine(data, adc_temp);
> +
> +	return 0;
> +}
> +
> +static int bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> +{
> +	s64 comp_temp;
> +	s32 var6;
> +
> +	var6 = bmp380_calc_t_fine(data, adc_temp);
>  	comp_temp = (var6 * 25) >> 14;
>  
>  	comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
> @@ -955,27 +1039,48 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
>   * Taken from datasheet, Section 9.3. "Pressure compensation" and repository
>   * https://github.com/BoschSensortec/BMP3-Sensor-API.
>   */
> -static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
> +static int bmp380_read_press_adc(struct bmp280_data *data, u32 *adc_press)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> +			       data->buf, sizeof(data->buf));
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read pressure\n");
> +		return ret;
> +	}
> +
> +	*adc_press = get_unaligned_le24(data->buf);

As above

> +	if (*adc_press == BMP380_PRESS_SKIPPED) {
> +		dev_err(data->dev, "reading pressure skipped\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

Jonathan


