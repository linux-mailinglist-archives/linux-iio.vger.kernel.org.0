Return-Path: <linux-iio+bounces-14105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762CA096E1
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 17:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7613A174E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9643212B36;
	Fri, 10 Jan 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oi9npryN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7255212D7F;
	Fri, 10 Jan 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525570; cv=none; b=CbdCbltVZoKZfWaH8nOR+637ErfXbiv0+PXNml3c6JqD67+mCtqKSArQhcrcd37ZkV8uQffMog4iSI5jy6PlrAwg6RbGa7FU7/216Gj3id1nCNEewyksud8EGOynHE0h4uEdnJjiWaqAxthQpOw0vcuPMx5e5yZxnyOCoVBM1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525570; c=relaxed/simple;
	bh=B/LjKaQEHy7KEr/6zyM+4jYclIOFdaHDBMv/5D+Izq8=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=C/wy2DxVfyFbbhv9lU2uwRRDGBgJhUnI6+IoUQ5BXqDsDos7rNTG6Jr54Ju387sp4kLFoX7wkQPtHKbqnAKA6Hqf1U2LhkUNpJOHTNqoZkFOZWEt7Upc4T6cy5WT3tuPdtewG6Wu7eRm8plH2GU6PGfNi0jUWY9azWNHC6cf1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oi9npryN; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id WHcftqzmJsdQ2WHcitXIQm; Fri, 10 Jan 2025 17:12:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736525558;
	bh=cVLAzhm2YWxCwHrXp+1PYJnEwZhWtQTnEIBmj0ECNRI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=oi9npryNzpIwaWIY1k6CaekGNoo4qT8/r0ODym3ETKzg8ViErZWzhBHO8gPmNOcyE
	 z2YlzaMd+Lir72ei9Auk2lB6JfbptjWADunTj+u0BUhwovCy7w1BmctKwBf8DGvCeZ
	 XM/wqT6Q20hj9TqGJf8+rkOCXXBqYfblzjJ/V6K7CcrAX5icY+gcExryBC72WvvnB0
	 aunYtxTvYgGSDv5/nxh2iQxzuBa1+c2/ijmA0heLQ5rZgjV/xAiH16Iz/04f3hFbB0
	 wGCJ6BXO7doiw5CIacM56/gaHbEm+oSR4iuyM/FEoFH/APzuV0nssGoqjhPPsP/Lpg
	 efP8Z0ZYSGE+Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 10 Jan 2025 17:12:38 +0100
X-ME-IP: 90.11.132.44
Message-ID: <22cec5f4-5945-405a-b586-dcc9b1cef3aa@wanadoo.fr>
Date: Fri, 10 Jan 2025 17:12:33 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: magnetometer: si7210: add driver for Si7210
References: <20250108234411.882768-1-apokusinski01@gmail.com>
 <20250108234411.882768-3-apokusinski01@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: apokusinski01@gmail.com
Cc: andrej.skvortzov@gmail.com, andy@kernel.org, conor+dt@kernel.org,
 danila@jiaxyga.com, devicetree@vger.kernel.org, icenowy@aosc.io,
 javier.carrasco.cruz@gmail.com, jic23@kernel.org,
 krzysztof.kozlowski@linaro.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, megi@xff.cz, neil.armstrong@linaro.org,
 robh@kernel.org
In-Reply-To: <20250108234411.882768-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/01/2025 à 00:44, Antoni Pokusinski a écrit :
> Silicon Labs Si7210 is an I2C Hall effect magnetic position and
> temperature sensor. The driver supports the following functionalities:
> * reading the temperature measurements
> * reading the magnetic field measurements in a single-shot mode
> * choosing the magnetic field measurement scale (20 or 200 mT)

...

> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 3e4c2ecd9adf..58f32a855494 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -31,6 +31,8 @@ obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
>   obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
>   obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
>   
> +obj-$(CONFIG_SI7210) += si7210.o

Maybe add some tabs, to align?

> +
>   obj-$(CONFIG_TI_TMAG5273)		+= tmag5273.o
>   
>   obj-$(CONFIG_YAMAHA_YAS530)		+= yamaha-yas530.o

...

> +static int si7210_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct si7210_data *data = iio_priv(indio_dev);
> +	long long tmp;

I think that temp is better than tmp
(temperature vs temporary?)

> +	__be16 dspsig;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = si7210_fetch_measurement(data, chan, &dspsig);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = dspsig & GENMASK(14, 0);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		if (data->curr_scale == 20)
> +			*val2 = 1250;
> +		else /* data->curr_scale == 200 */
> +			*val2 = 12500;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -16384;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = si7210_fetch_measurement(data, chan, &dspsig);
> +		if (ret < 0)
> +			return ret;
> +
> +		tmp = FIELD_GET(GENMASK(14, 3), dspsig);
> +		tmp = (div_s64(-383 * tmp * tmp, 100) + (160940 * tmp - 279800000));

I would keep 279800000 outside of the (), or even write it to better 
match the spec:
	tmp = div_s64(-383 * tmp * tmp, 100) + 160940 * tmp - 279800000;

Here, tmp seems to be Temperature_raw from the sepc * 10^6


> +		tmp = (1 + (data->temp_gain >> 11)) * tmp + 62500 * data->temp_offset;

/ 2048 instead of >> 11 to match the formula in the sepc?

Would it be clearer to have 62500 written as (1000000 / 32)

> +
> +		ret = regulator_get_voltage(data->vdd);
> +		if (ret < 0)
> +			return ret;
> +
> +		tmp -= 222 * div_s64(ret, 1000);
> +
> +		*val = div_s64(tmp, 1000);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int si7210_set_scale(struct si7210_data *data, unsigned int scale)
> +{
> +	s8 *a_otp_values;
> +	int ret;
> +
> +	if (scale == 20)
> +		a_otp_values = data->scale_20_a;
> +	else if (scale == 200)
> +		a_otp_values = data->scale_200_a;
> +	else
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->fetch_lock);
> +
> +	/* Write the registers 0xCA - 0xCC*/

Missing space before */

> +	ret = regmap_bulk_write(data->regmap, SI7210_REG_A0, a_otp_values, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Write the registers 0xCE - 0xD0*/

Missing space before */

> +	ret = regmap_bulk_write(data->regmap, SI7210_REG_A3, &a_otp_values[3], 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->curr_scale = scale;
> +
> +	return 0;
> +}

...

> +static int si7210_device_wake(struct si7210_data *data)
> +{
> +	/*
> +	 * According to the datasheet, the primary method to wake up a
> +	 * device is to send an empty write. However this is not feasible
> +	 * using current API so we use the other method i.e. read a single
> +	 * byte. The device should respond with 0xFF

Nitpick: Missing ending .

> +	 */
> +
> +	int ret = 0;

No need to init.

> +
> +	ret = i2c_smbus_read_byte(data->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != 0xFF)
> +		return -EIO;
> +
> +	return 0;
> +}

...

> +MODULE_DESCRIPTION("Silicon Labs Si7210 Hall Effect sensor I2C driver");
> +MODULE_LICENSE("Dual BSD/GPL");

This is not consistent with the SPDX tag.

CJ

