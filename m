Return-Path: <linux-iio+bounces-8772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FC95E24D
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422F31F217DB
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408B3EA9A;
	Sun, 25 Aug 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sWM9ObKV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE02119;
	Sun, 25 Aug 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724569476; cv=none; b=m98j1Xt7knrpJ4d2Ehk/YlkA99amuYjQKH85jPWDTueF/ZYevmIjvq6SAh459yWOeg5yuPJPpdPSulJwnDIMmZVVDZTWcqhZZDT2696Y4zndil0TAMP/EzGHDrIVkmvX2AHaEYOsgD5sQBWuIxT7sJX2YE/sOCp8p+OSGrGJUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724569476; c=relaxed/simple;
	bh=alZC71CHOTo9J3hIdJNyDGSI1g7x1XDEka8tA9G6GJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=tR+UnZYvLBZBw2cXPDHKo6NoSdAwzNbpQR3ZDshbIHUEB32+SOm8Q+LSA3HTxwkkT60Zx1ti91MWA/GMZFsgdBIzlmp1JrJliVyFcocCiTROKM9liszgpmPzMEON+CHns8FAeK0IvfOze9eX3fE25Y8AYtcx1AY2j5kGChTNTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sWM9ObKV; arc=none smtp.client-ip=80.12.242.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id i7IOsbrhcrSO8i7IOskoPA; Sun, 25 Aug 2024 09:04:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724569464;
	bh=g3hTbNzPlL7fF9/gdKgEl/IkBIzjVV5RDyBl6jJGA4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sWM9ObKVe8JWhYPJWJ5eXq2w0ro+JYt/2svRpgypSP7UfLsTsQmPK5JYo/uWyjQEz
	 gYe1v3kBQ4DrUx19W+QHbKBEHOGkiqw8uEMrGlSSC+sEcZEp125yVM0jDH4ZPj/uEC
	 JmP4/ldi57cum5MjeiFTkP/ae+PYYG6tvM166XfwnEAmvx1TBW41XtlJf+CwfLktTC
	 flAQD25H1BJmLbUrGRklEaY+lYWC2rLcNaJX3Rp9EohG8vqfXlqg7/6f2XBrx62L8r
	 CEzsx5vvpYBBna+PB8mJ1x1/MIdc7tEnRiVqxCpz8F0N5INdJ/OGgXFEkeHBFOs8m+
	 0sTi6TjEuhFSg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 25 Aug 2024 09:04:24 +0200
X-ME-IP: 90.11.132.44
Message-ID: <b898ad42-1559-4f43-8994-d9692e54f930@wanadoo.fr>
Date: Sun, 25 Aug 2024 09:04:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] iio: pressure: bmp280: Add support for bmp280 soft
 reset
To: vassilisamir@gmail.com
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-3-vassilisamir@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: 579lpy@gmail.com, ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, biju.das.jz@bp.renesas.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 jic23@kernel.org, krzk+dt@kernel.org, lars@metafoo.de,
 linus.walleij@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, semen.protsenko@linaro.org
In-Reply-To: <20240823181714.64545-3-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/08/2024 à 20:17, Vasileios Amoiridis a écrit :
> The BM(P/E)28x devices have an option for soft reset which is also
> recommended by the Bosch Sensortech BME2 Sensor API to be used before the
> initial configuration of the device.
> 
> Link: https://github.com/boschsensortec/BME280_SensorAPI/blob/bme280_v3.5.1/bme280.c#L429
> Signed-off-by: Vasileios Amoiridis <vassilisamir-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/iio/pressure/bmp280-core.c | 26 ++++++++++++++++++++++++++
>   drivers/iio/pressure/bmp280.h      |  3 +++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index c23515048081..e01c9369bd67 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -965,6 +965,30 @@ static const unsigned long bme280_avail_scan_masks[] = {
>   	0
>   };
>   
> +static int bmp280_preinit(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to reset device.\n");
> +
> +	usleep_range(data->start_up_time, data->start_up_time + 500);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to read status register.\n");
> +
> +	if (reg & BMP280_REG_STATUS_IM_UPDATE)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to copy NVM contents.\n");

ret is 0 at this point.
Should a -E<something> be used instead?

CJ

> +
> +	return 0;
> +}
> +
>   static int bmp280_chip_config(struct bmp280_data *data)
>   {
>   	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> @@ -1082,6 +1106,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
>   	.read_temp = bmp280_read_temp,
>   	.read_press = bmp280_read_press,
>   	.read_calib = bmp280_read_calib,
> +	.preinit = bmp280_preinit,
>   
>   	.trigger_handler = bmp280_trigger_handler,
>   };
> @@ -1202,6 +1227,7 @@ const struct bmp280_chip_info bme280_chip_info = {
>   	.read_press = bmp280_read_press,
>   	.read_humid = bme280_read_humid,
>   	.read_calib = bme280_read_calib,
> +	.preinit = bmp280_preinit,
>   
>   	.trigger_handler = bme280_trigger_handler,
>   };
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 4e675401d61b..73516878d020 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -205,6 +205,9 @@
>   #define BMP280_REG_CONFIG		0xF5
>   #define BMP280_REG_CTRL_MEAS		0xF4
>   #define BMP280_REG_STATUS		0xF3
> +#define BMP280_REG_STATUS_IM_UPDATE	BIT(0)
> +#define BMP280_REG_RESET		0xE0
> +#define BMP280_RST_SOFT_CMD		0xB6
>   
>   #define BMP280_REG_COMP_TEMP_START	0x88
>   #define BMP280_COMP_TEMP_REG_COUNT	6


