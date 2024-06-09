Return-Path: <linux-iio+bounces-6107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABBB9015DB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 13:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5401C20F3E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE8E28DCC;
	Sun,  9 Jun 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCtOHd8Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E182E62D;
	Sun,  9 Jun 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717931311; cv=none; b=KFaGRDYnF9uqv9Vlr8cvPqcy3Xa0zOUAVo7qv3KJVhXBWUmR4hIy3NjbBUbHy1Yjr0Q0TrhAhQvcj/32/FspNQM+6WhxgOhx+JwA0I57oAopptpgmNWbJKdCRFYSDDaRHOHqgUWfUYkYxAfkgXr6zpoH1WvooLl8Fyaim/HaeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717931311; c=relaxed/simple;
	bh=3rrM6UaKFBrayBCDs0tBpYq461KVYa0w5TQdSkCmIvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjbB0RR+GDgzKm4hOQd546PY93IkGhG3fx7DWElzd+a1EiU0Lkn1oXLkYLr4PeZr0l9Xn86sZxDiP3gZXg6I4VlH7UXW0WOK/c9rc23XdumtL87C3Esnhcsx2JAUi6y+/JxyVTfb2h0lr7G8++hl6KIjTezLykFGi8GHoxOKBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCtOHd8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80923C2BD10;
	Sun,  9 Jun 2024 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717931310;
	bh=3rrM6UaKFBrayBCDs0tBpYq461KVYa0w5TQdSkCmIvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCtOHd8ZhSlQ/CBIfuHGytpP01xdEMjbTjGMO9Zeq8vcygBfiBXxdxU+KgIf1598O
	 ObPqjVUGZOqE0JJTD/RUafcMm+MVCEe5QRXIIwJnZDkVd+WV8Z4MInu8yuDe66wEaU
	 DFyhe+2mkja+fPjL9zGCvbYMxuV52JHeejPQoJYYu9rx+Nn4dJrEIa9GjMpmZvsgkW
	 HLlirzsm9/3z+/Dr881mIRCJ2YOyBXnSOOxZ9b/CR7l3GQDrwmtG5VDOa0ariTkscp
	 pFw2olRvz6Zquh+6AqI8MoxK/zZS9CiEi5tldnDBxITIJlPr9S7j5mmI6q26F0nInS
	 Mz4ZWjUbm1RZQ==
Date: Sun, 9 Jun 2024 12:07:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 15/19] iio: chemical: bme680: Modify startup
 procedure
Message-ID: <20240609120756.14c1eda1@jic23-huawei>
In-Reply-To: <20240606212313.207550-18-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
	<20240606212313.207550-18-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 23:23:09 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Modify the startup procedure to reflect the procedure of
> the Bosch BME68x Sensor API. The initial readings and
> configuration of the sensor need to happen in the
> following order:
> 
> 1) Read calibration data [1,2]
> 2) Chip general configuration [3]
> 3) Gas configuration [4]
> 
> After the chip configuration it is necessary to ensure that
> the sensor is in sleeping mode, in order to apply the gas
> configuration settings [5].
> 

Trivial but oddly short line wrapping. Target 75ish chars for commit messages

> Also, after the soft reset, it is advised to wait for 5ms [6].
> 
> [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L162
> [2]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L44
> [3]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L53
> [4]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L60
> [5]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L640
> [6]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L294
Either make these Link tags or add a blank line here.

I'd prefer link tags with # [1] etc after them for the cross references.

> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h      |  2 ++
>  drivers/iio/chemical/bme680_core.c | 21 ++++++++++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index 7d0ff294725a..b2c547ac8d34 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -63,6 +63,8 @@
>  
>  #define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
>  
> +#define BME680_STARTUP_TIME_US			5000
> +
>  /* Calibration Parameters */
>  #define BME680_T2_LSB_REG	0x8A
>  #define BME680_H2_MSB_REG	0xE1
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 25d128e1ddcf..e354eaa34d59 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -531,6 +531,11 @@ static int bme680_gas_config(struct bme680_data *data)
>  	int ret;
>  	u8 heatr_res, heatr_dur;
>  
> +	/* Go to sleep */
> +	ret = bme680_set_mode(data, false);
> +	if (ret < 0)
> +		return ret;
> +
>  	heatr_res = bme680_calc_heater_res(data, data->heater_temp);
>  
>  	/* set target heater temperature */
> @@ -866,6 +871,8 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  		return ret;
>  	}
>  
> +	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
> +
>  	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading chip ID\n");
> @@ -878,22 +885,22 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  		return -ENODEV;
>  	}
>  
> -	ret = bme680_chip_config(data);
> +	ret = bme680_read_calib(data, &data->bme680);
>  	if (ret < 0) {
> -		dev_err(dev, "failed to set chip_config data\n");
> +		dev_err(dev,
> +			"failed to read calibration coefficients at probe\n");
>  		return ret;
>  	}
>  
> -	ret = bme680_gas_config(data);
> +	ret = bme680_chip_config(data);
>  	if (ret < 0) {
> -		dev_err(dev, "failed to set gas config data\n");
> +		dev_err(dev, "failed to set chip_config data\n");
>  		return ret;
>  	}
>  
> -	ret = bme680_read_calib(data, &data->bme680);
> +	ret = bme680_gas_config(data);
>  	if (ret < 0) {
> -		dev_err(dev,
> -			"failed to read calibration coefficients at probe\n");
> +		dev_err(dev, "failed to set gas config data\n");
>  		return ret;
>  	}
>  


