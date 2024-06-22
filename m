Return-Path: <linux-iio+bounces-6707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471639132E1
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 11:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929C2B22B0B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FC714D282;
	Sat, 22 Jun 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulDW+pEw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3267149C4D;
	Sat, 22 Jun 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719048517; cv=none; b=Kt0CHBOD3QtPeY7JDhcbHs6OslMdZj1fEgUHZ9CeUW0KxgNIRY1EBw+f9E0FomRyTggzr8KQb26q/kYDadTTyQCdvBU76y8RlDUy6kmmak+B46115BJG897Ec9l2WolloKejITb+eGhmtiGopmsgV3CL0dFQHizy2r9yEKxr2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719048517; c=relaxed/simple;
	bh=VXjasl2J6v7SH1K8nKab67xEo7OfjE8jq6LvmNZ12Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz9R6q4vXNhkoTv6PL4g2qN8VU/Kwmh1Ytb8MUtOk5sbytmbh+J/xQ9Ok5wJ9AFZU6GXpo+eaCkRapvJCPQkd4tr4pB+GIsY+MCZwd7mFyeGOVoMqN5HKJP1TKfGlHY0Y4PJYPD0CMakp4kuwX9EuwfAdNH5hqIWi/DIzKiIq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulDW+pEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493DBC3277B;
	Sat, 22 Jun 2024 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719048516;
	bh=VXjasl2J6v7SH1K8nKab67xEo7OfjE8jq6LvmNZ12Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulDW+pEwmjK9OG6B5hxRh2kGMBfTaSAeEZe4JFZ6VHqqQ2Es7QhmGHHbZ9oXnFtVR
	 J8gMdqzeIhc1MWVcgo/GnOP8XkvcKzgN6M/S92C6tyVbibbPv1Kmza6JiBgaj12kxk
	 dZ/pv3o3XT+TDqZjhpiOQKbeLpJwV+w6GldlIWx7hWsnwUSKeY7btw+ploTCwUqtCQ
	 wqhdnNBDNppYvA+fmj+HU5Pq0pSIRCq6PPHDVhHuoxYnUrGSlGxnIVrNWGGh15OhF0
	 jhc+miB6j0PbuHq19Qteh5z1VpUTI8RDA30lM4ZrKXQzSJbUV8sld/6X8kIAVtyRSU
	 OvK0GQjcihOCA==
Date: Sat, 22 Jun 2024 10:28:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Rizkalla
 <ajarizzo@gmail.com>
Subject: Re: [PATCH v8 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <20240622102826.2ba446d9@jic23-huawei>
In-Reply-To: <20240617230540.32325-2-vassilisamir@gmail.com>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
	<20240617230540.32325-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 01:05:38 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add the coefficients for the IIO standard units and the IIO value
> inside the chip_info structure.
> 
> Move the calculations for the IIO unit compatibility from inside the
> read_{temp,press,humid}() functions and move them to the general
> read_raw() function.
> 
> In this way, all the data for the calculation of the value are
> located in the chip_info structure of the respective sensor.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Does this incorporate the fix?  I'm a little confused looking at
what is visible here, so I'd like Adam to take a look.

Btw, you missed cc'ing Adam.

> ---
>  drivers/iio/pressure/bmp280-core.c | 167 +++++++++++++++++------------
>  drivers/iio/pressure/bmp280.h      |  13 ++-
>  2 files changed, 107 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 50d71ad83f37..27c00af060fa 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -445,10 +445,8 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
>  	return (u32)p;
>  }
>  
> -static int bmp280_read_temp(struct bmp280_data *data,
> -			    int *val, int *val2)
> +static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
>  {
> -	s32 comp_temp;
>  	u32 adc_temp;
>  	int ret;
>  
> @@ -456,16 +454,15 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  	if (ret)
>  		return ret;
>  
> -	comp_temp = bmp280_compensate_temp(data, adc_temp);
> +	*comp_temp = bmp280_compensate_temp(data, adc_temp);
>  
> -	*val = comp_temp * 10;
> -	return IIO_VAL_INT;
> +	return 0;
>  }
>  
> -static int bmp280_read_press(struct bmp280_data *data,
> -			     int *val, int *val2)
> +static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
>  {
> -	u32 comp_press, adc_press, t_fine;
> +	u32 adc_press;
> +	s32 t_fine;
>  	int ret;
>  
>  	ret = bmp280_get_t_fine(data, &t_fine);
> @@ -476,17 +473,13 @@ static int bmp280_read_press(struct bmp280_data *data,
>  	if (ret)
>  		return ret;
>  
> -	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
> -
> -	*val = comp_press;
> -	*val2 = 256000;
> +	*comp_press = bmp280_compensate_press(data, adc_press, t_fine);
>  
> -	return IIO_VAL_FRACTIONAL;
> +	return 0;
>  }
>  
> -static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
> +static int bme280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
>  {
> -	u32 comp_humidity;
>  	u16 adc_humidity;
>  	s32 t_fine;
>  	int ret;
> @@ -499,11 +492,9 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  	if (ret)
>  		return ret;
>  
> -	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
> -
> -	*val = comp_humidity * 1000 / 1024;
> +	*comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
>  
> -	return IIO_VAL_INT;
> +	return 0;
>  }
>  
>  static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
> @@ -511,6 +502,8 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  				int *val, int *val2, long mask)
>  {
>  	struct bmp280_data *data = iio_priv(indio_dev);
> +	int chan_value;
> +	int ret;
>  
>  	guard(mutex)(&data->lock);
>  
> @@ -518,11 +511,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> -			return data->chip_info->read_humid(data, val, val2);
> +			ret = data->chip_info->read_humid(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = data->chip_info->humid_coeffs[0] * chan_value;
> +			*val2 = data->chip_info->humid_coeffs[1];
> +			return data->chip_info->humid_coeffs_type;
>  		case IIO_PRESSURE:
> -			return data->chip_info->read_press(data, val, val2);
> +			ret = data->chip_info->read_press(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = data->chip_info->press_coeffs[0] * chan_value;
> +			*val2 = data->chip_info->press_coeffs[1];
> +			return data->chip_info->press_coeffs_type;
>  		case IIO_TEMP:
> -			return data->chip_info->read_temp(data, val, val2);
> +			ret = data->chip_info->read_temp(data, &chan_value);
> +			if (ret)
> +				return ret;
> +
> +			*val = data->chip_info->temp_coeffs[0] * (s64)chan_value;
> +			*val2 = data->chip_info->temp_coeffs[1];
> +			return data->chip_info->temp_coeffs_type;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -822,6 +833,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  
>  static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
>  static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
> +static const int bmp280_temp_coeffs[] = { 10, 1 };
> +static const int bmp280_press_coeffs[] = { 1, 256000 };
>  
>  const struct bmp280_chip_info bmp280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> @@ -850,6 +863,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
>  	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>  	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
>  
> +	.temp_coeffs = bmp280_temp_coeffs,
> +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> +	.press_coeffs = bmp280_press_coeffs,
> +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> +
>  	.chip_config = bmp280_chip_config,
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
> @@ -877,6 +895,7 @@ static int bme280_chip_config(struct bmp280_data *data)
>  }
>  
>  static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
> +static const int bme280_humid_coeffs[] = { 1000, 1024 };
>  
>  const struct bmp280_chip_info bme280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> @@ -899,6 +918,13 @@ const struct bmp280_chip_info bme280_chip_info = {
>  	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
>  	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
>  
> +	.temp_coeffs = bmp280_temp_coeffs,
> +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> +	.press_coeffs = bmp280_press_coeffs,
> +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> +	.humid_coeffs = bme280_humid_coeffs,
> +	.humid_coeffs_type = IIO_VAL_FRACTIONAL,
> +
>  	.chip_config = bme280_chip_config,
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
> @@ -1091,9 +1117,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data,
>  	return comp_press;
>  }
>  
> -static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
> +static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
>  {
> -	s32 comp_temp;
>  	u32 adc_temp;
>  	int ret;
>  
> @@ -1101,15 +1126,14 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
>  	if (ret)
>  		return ret;
>  
> -	comp_temp = bmp380_compensate_temp(data, adc_temp);
> +	*comp_temp = bmp380_compensate_temp(data, adc_temp);
>  
> -	*val = comp_temp * 10;
> -	return IIO_VAL_INT;
> +	return 0;
>  }
>  
> -static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
> +static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
>  {
> -	u32 adc_press, comp_press, t_fine;
> +	u32 adc_press, t_fine;
>  	int ret;
>  
>  	ret = bmp380_get_t_fine(data, &t_fine);
> @@ -1120,12 +1144,9 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
>  	if (ret)
>  		return ret;
>  
> -	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
> -
> -	*val = comp_press;
> -	*val2 = 100000;
> +	*comp_press = bmp380_compensate_press(data, adc_press, t_fine);
>  
> -	return IIO_VAL_FRACTIONAL;
> +	return 0;
>  }
>  
>  static int bmp380_read_calib(struct bmp280_data *data)
> @@ -1296,6 +1317,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
>  static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
>  static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
> +static const int bmp380_temp_coeffs[] = { 10, 1 };
> +static const int bmp380_press_coeffs[] = { 1, 100000 };
>  
>  const struct bmp280_chip_info bmp380_chip_info = {
>  	.id_reg = BMP380_REG_ID,
> @@ -1323,6 +1346,11 @@ const struct bmp280_chip_info bmp380_chip_info = {
>  	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
>  	.iir_filter_coeff_default = 2,
>  
> +	.temp_coeffs = bmp380_temp_coeffs,
> +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> +	.press_coeffs = bmp380_press_coeffs,
> +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> +
>  	.chip_config = bmp380_chip_config,
>  	.read_temp = bmp380_read_temp,
>  	.read_press = bmp380_read_press,
> @@ -1443,9 +1471,9 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
>   * for what is expected on IIO ABI.
>   */
>  
> -static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
> +static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
>  {
> -	s32 raw_temp;
> +	s32 value_temp;
>  	int ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
> @@ -1455,25 +1483,19 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
>  		return ret;
>  	}
>  
> -	raw_temp = get_unaligned_le24(data->buf);
> -	if (raw_temp == BMP580_TEMP_SKIPPED) {
> +	value_temp = get_unaligned_le24(data->buf);
> +	if (value_temp == BMP580_TEMP_SKIPPED) {
>  		dev_err(data->dev, "reading temperature skipped\n");
>  		return -EIO;
>  	}
> +	*raw_temp = sign_extend32(value_temp, 23);
>  
> -	/*
> -	 * Temperature is returned in Celsius degrees in fractional
> -	 * form down 2^16. We rescale by x1000 to return millidegrees
> -	 * Celsius to respect IIO ABI.
> -	 */
> -	raw_temp = sign_extend32(raw_temp, 23);
> -	*val = ((s64)raw_temp * 1000) / (1 << 16);
> -	return IIO_VAL_INT;
> +	return 0;
>  }
>  
> -static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
> +static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
>  {
> -	u32 raw_press;
> +	u32 value_press;
>  	int ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
> @@ -1483,18 +1505,14 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
>  		return ret;
>  	}
>  
> -	raw_press = get_unaligned_le24(data->buf);
> -	if (raw_press == BMP580_PRESS_SKIPPED) {
> +	value_press = get_unaligned_le24(data->buf);
> +	if (value_press == BMP580_PRESS_SKIPPED) {
>  		dev_err(data->dev, "reading pressure skipped\n");
>  		return -EIO;
>  	}
> -	/*
> -	 * Pressure is returned in Pascals in fractional form down 2^16.
> -	 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
> -	 */
> -	*val = raw_press;
> -	*val2 = 64000; /* 2^6 * 1000 */
> -	return IIO_VAL_FRACTIONAL;
> +	*raw_press = value_press;
> +
> +	return 0;
>  }
>  
>  static const int bmp580_odr_table[][2] = {
> @@ -1830,6 +1848,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
>  
>  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
>  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> +static const int bmp580_temp_coeffs[] = { 1000, 16 };
> +static const int bmp580_press_coeffs[] = { 1, 64000};
>  
>  const struct bmp280_chip_info bmp580_chip_info = {
>  	.id_reg = BMP580_REG_CHIP_ID,
> @@ -1856,6 +1876,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
>  	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
>  	.iir_filter_coeff_default = 2,
>  
> +	.temp_coeffs = bmp580_temp_coeffs,
> +	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
> +	.press_coeffs = bmp580_press_coeffs,
> +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> +
>  	.chip_config = bmp580_chip_config,
>  	.read_temp = bmp580_read_temp,
>  	.read_press = bmp580_read_press,
> @@ -2011,9 +2036,8 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
>  	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
>  }
>  
> -static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
> +static int bmp180_read_temp(struct bmp280_data *data, s32 *comp_temp)
>  {
> -	s32 comp_temp;
>  	u32 adc_temp;
>  	int ret;
>  
> @@ -2021,10 +2045,9 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
>  	if (ret)
>  		return ret;
>  
> -	comp_temp = bmp180_compensate_temp(data, adc_temp);
> +	*comp_temp = bmp180_compensate_temp(data, adc_temp);
>  
> -	*val = comp_temp * 100;
> -	return IIO_VAL_INT;
> +	return 0;
>  }
>  
>  static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
> @@ -2087,9 +2110,9 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
>  	return p + ((x1 + x2 + 3791) >> 4);
>  }
>  
> -static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
> +static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
>  {
> -	u32 comp_press, adc_press;
> +	u32 adc_press;
>  	s32 t_fine;
>  	int ret;
>  
> @@ -2101,12 +2124,9 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
>  	if (ret)
>  		return ret;
>  
> -	comp_press = bmp180_compensate_press(data, adc_press, t_fine);
> -
> -	*val = comp_press;
> -	*val2 = 1000;
> +	*comp_press = bmp180_compensate_press(data, adc_press, t_fine);
>  
> -	return IIO_VAL_FRACTIONAL;
> +	return 0;
>  }
>  
>  static int bmp180_chip_config(struct bmp280_data *data)
> @@ -2117,6 +2137,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
>  static const int bmp180_oversampling_temp_avail[] = { 1 };
>  static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
>  static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
> +static const int bmp180_temp_coeffs[] = { 100, 1 };
> +static const int bmp180_press_coeffs[] = { 1, 1000 };
>  
>  const struct bmp280_chip_info bmp180_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> @@ -2137,6 +2159,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
>  		ARRAY_SIZE(bmp180_oversampling_press_avail),
>  	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
>  
> +	.temp_coeffs = bmp180_temp_coeffs,
> +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> +	.press_coeffs = bmp180_press_coeffs,
> +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> +
>  	.chip_config = bmp180_chip_config,
>  	.read_temp = bmp180_read_temp,
>  	.read_press = bmp180_read_press,
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 7c30e4d523be..a3d2cd722760 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -446,10 +446,17 @@ struct bmp280_chip_info {
>  	int num_sampling_freq_avail;
>  	int sampling_freq_default;
>  
> +	const int *temp_coeffs;
> +	const int temp_coeffs_type;
> +	const int *press_coeffs;
> +	const int press_coeffs_type;
> +	const int *humid_coeffs;
> +	const int humid_coeffs_type;
> +
>  	int (*chip_config)(struct bmp280_data *data);
> -	int (*read_temp)(struct bmp280_data *data, int *val, int *val2);
> -	int (*read_press)(struct bmp280_data *data, int *val, int *val2);
> -	int (*read_humid)(struct bmp280_data *data, int *val, int *val2);
> +	int (*read_temp)(struct bmp280_data *data, s32 *adc_temp);
> +	int (*read_press)(struct bmp280_data *data, u32 *adc_press);
> +	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
>  	int (*read_calib)(struct bmp280_data *data);
>  	int (*preinit)(struct bmp280_data *data);
>  };


