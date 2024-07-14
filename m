Return-Path: <linux-iio+bounces-7616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933A930BF2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 00:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5E0B21E34
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E256113B5B6;
	Sun, 14 Jul 2024 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IljPi8Rk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92422313;
	Sun, 14 Jul 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720995415; cv=none; b=eZeoiIHeYAfyj9PY/1EplTs1/OJ1iegwk0gmPjIU13Z5PESDKPtE4ztOHWM19jNghqEl0yXaNYEbKje8SkRDMX7Jxvb78U06oOVDMXFb/CzdrViQ013YGBbFdiMD6KVWqwjA7GNjko1WEObKC5gnWEOOdA/2MoBKOP4cROc/AUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720995415; c=relaxed/simple;
	bh=eYgSZLzmim8PZvR8yGXfyMWT6VkEb/g39AmRmQKoRsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bieb0vEwTgE9CYt0ZjB0FIelQ7qcLD/MIVAlVwET1X+aGiD4piBF/Nw77nPN/kus0/sZzv6PHCpDz5FqiqT6FpwRaowjPnP43V7Josoq9UAPX8WbTu3aQj2jDNZyLQnvVRCMI2FSL+39ArtgM/II6hPP52YvIsl8x392Z+Pnbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IljPi8Rk; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d9e13ef8edso2416585b6e.2;
        Sun, 14 Jul 2024 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720995413; x=1721600213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pmqq4n5CIZ0JQxKe2t7vhP02GD4OjQVV2coVsMa2CVA=;
        b=IljPi8RkhWbTeVvXavCoPEfkIGdmTrtPP8yLrNdOl3K6f95G4bA0DutK3TmyJ1rHhO
         T186A4F447QnwDg0I1kC2JW7GgN0CHfEsiR0bp090KhM/6gdpqNaMZa9vLJgKma2EX+W
         aCti3rcBxq3RTAwWo2v5D87LrYQtJ+jcO0a1yhLoqtB4MSUSmyOoB79R+btSNH2KbhW1
         Mp5LCB3jgpHAfVkVaSIjB5Ym/ugF0+Pu8zkR2O08lTC+Qz54O5R93B8EAY2G9ouCIrdt
         UIEfXULog2QYLv41wr0CwqrDqwVUTt2z32PkvX8xtACO5E6O5g0jQDRzJuoSApH0ffjA
         11Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720995413; x=1721600213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmqq4n5CIZ0JQxKe2t7vhP02GD4OjQVV2coVsMa2CVA=;
        b=ObhuIAaNxe1c+ulIjNYC2rWC1jYxUlpkJvBtmXDQ1CU17NdYcyalLOsenF9iJeCCgj
         HR5P6ak/uJDNO5ONvnlY7IYUTo86mqg9Zo3vIDwGax1HG2xrRzQs6iDEqRBLoaGfaUFQ
         wtNYzLfQNg5Ay4HqE1SwJ6dyFF93rDTLZq4GWyyX4A0kxYl/yHHoRAGZrv2BJfAzc1AS
         lO6vkFThlSbOKxY3QCo5MBgIldFBprE0PUl5F1IwR4mv/rj61JS4ekCM3PZPZyNO9GFo
         4YmxFqw3tpb74rIqNTQc811p/nwSa8lxjJ7pweAOj5h0yR0Dm+muNAqYgO8igAPhTPhH
         AlIw==
X-Forwarded-Encrypted: i=1; AJvYcCXlBaFvkV4inMZOU4jId6fNMpMoWJhRn4Xn/TPMa10FxhBLUfrqRevCzt/SLosGlDpbnrPGaGW60sIrC6geLMRhoeA+6yIrbMcdPZnp1uJhfrHptHqclRTI1sxaR6pWr4+EETtAB+/U
X-Gm-Message-State: AOJu0YxzBZa09bYBTQoJpjI9xOYdvteIXPMFQ/7HBRnLy9prI0egMWzb
	swnNPug8tiMz1QCpauXTANO8EIlInkCpq0+V1sM0uTzuKrHtM+p3
X-Google-Smtp-Source: AGHT+IFKgeLio2PihUIGUQPRoH0Qbvva/txY4AJfmXKQNffQwEpfpHZ3kYAEU1KQmyrE2v7uJM5KlQ==
X-Received: by 2002:a05:6808:148b:b0:3d9:26d6:c70f with SMTP id 5614622812f47-3d93bee9516mr22216442b6e.7.1720995412520;
        Sun, 14 Jul 2024 15:16:52 -0700 (PDT)
Received: from adam-asahi.team.saronic.dev ([136.41.97.255])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dab3dc4cc8sm591836b6e.11.2024.07.14.15.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 15:16:51 -0700 (PDT)
Date: Sun, 14 Jul 2024 17:16:50 -0500
From: Adam Rizkalla <ajarizzo@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, petre.rodan@subdimension.ro,
	mazziesaccount@gmail.com, ak@it-klinger.de, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, tgamblin@baylibre.com,
	phil@raspberrypi.com, 579lpy@gmail.com,
	andriy.shevchenko@linux.intel.com, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <ZpROUow6p78VJsrO-ajarizzo@gmail.com>
References: <20240628171726.124852-1-vassilisamir@gmail.com>
 <20240628171726.124852-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628171726.124852-2-vassilisamir@gmail.com>

On Fri, Jun 28, 2024 at 07:17:24PM +0200, Vasileios Amoiridis wrote:
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
> ---
>  drivers/iio/pressure/bmp280-core.c | 168 +++++++++++++++++------------
>  drivers/iio/pressure/bmp280.h      |  13 ++-
>  2 files changed, 108 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 49081b729618..9ff26a8e85d3 100644
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
> +			*val = data->chip_info->temp_coeffs[0] * chan_value;
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
> @@ -1830,6 +1848,9 @@ static int bmp580_chip_config(struct bmp280_data *data)
>  
>  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
>  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> +/* Instead of { 1000, 16 } we do this, to avoid overflow issues */
> +static const int bmp580_temp_coeffs[] = { 125, 13 };

I'm not really sure what we gain here from using 125/13 instead of
250/14...but I don't think it hurts either.

I don't have a way to test this with the latest kernel release
currently, but lgtm.

Acked-by: Adam Rizkalla <ajarizzo@gmail.com>

> +static const int bmp580_press_coeffs[] = { 1, 64000};
>  
>  const struct bmp280_chip_info bmp580_chip_info = {
>  	.id_reg = BMP580_REG_CHIP_ID,
> @@ -1856,6 +1877,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
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
> @@ -2011,9 +2037,8 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
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
> @@ -2021,10 +2046,9 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
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
> @@ -2087,9 +2111,9 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
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
> @@ -2101,12 +2125,9 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
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
> @@ -2117,6 +2138,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
>  static const int bmp180_oversampling_temp_avail[] = { 1 };
>  static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
>  static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
> +static const int bmp180_temp_coeffs[] = { 100, 1 };
> +static const int bmp180_press_coeffs[] = { 1, 1000 };
>  
>  const struct bmp280_chip_info bmp180_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> @@ -2137,6 +2160,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
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
> -- 
> 2.25.1
> 

