Return-Path: <linux-iio+bounces-5623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251BF8D757E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E351C208D2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2F39FDD;
	Sun,  2 Jun 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzXDecZs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C010795;
	Sun,  2 Jun 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333294; cv=none; b=T8RV1v7fKndMokXIzRiVvGfEUbQqfN0HKKUm5JTV2sVYF1cEDkwxieGj/SlRwOWeThgjerkGkC5F9MCXvUEeEN5w9j6LZEZhq/Bg4yXpFgTtJPa4t4DCptfrTMze9nP7KTMRcrZn0rxB3d1GmQYPkCoURH2jwGaW31qPZwPU2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333294; c=relaxed/simple;
	bh=XSk5Excflz8p5LLif+T5zrBQC/2wFaw72fKVckybhpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syeyEhB3igGhe/wGagcPdy3OON41oiNbuHO6hU+7LEFLXe9nqIOI2t8xah/ijvWlhkvP5MPE1WioXt7vNIqQvVnODPrk91dPS/nM52oGZcqSFq3tSKP732dWCMcJFtsDAOF+uBKg2qvmZStsFTznX777lvnSGGvnZHwDx1PUMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzXDecZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9932C2BBFC;
	Sun,  2 Jun 2024 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717333294;
	bh=XSk5Excflz8p5LLif+T5zrBQC/2wFaw72fKVckybhpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BzXDecZsK1cm5aKEgDLyZ4crqqOp4n9widhhJp0HX68trdjSjjXLAmn9ruw6+bpkw
	 talZnkfRF7sqstChyWZA+b1uI7OGOUNzAzG1OZ2mbjtY51POHQE+JoA2d1VIZOpLur
	 +hWLuxkPcwiNnJ0tqk2lBDE4t559lMaNcR8PdlTy0DCvV0H86TeYXNDUXFQDhoDELn
	 QaS55ONGsLVrVtyR7qkjsEU5alNBmoxilZq2lvaNplgLui62+0jMmgwUNPATLqEGjC
	 aEeU0SFkVS4JJiHg+vXhl/aVPQdcZJ7JH+s1t4rEqoneAOm8fZOAu4lm1CmBKxendY
	 iHrtPyeP4CRjg==
Date: Sun, 2 Jun 2024 14:01:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/17] iio: chemical: bme680: Modify startup
 procedure
Message-ID: <20240602140123.3dd1b793@jic23-huawei>
In-Reply-To: <20240527183805.311501-15-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-15-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 20:38:02 +0200
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
> Also, after the soft reset, it is advised to wait for 5ms [6].
> 
> [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L162
> [2]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L44
> [3]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L53
> [4]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/examples/forced_mode/forced_mode.c#L60
> [5]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L640
> [6]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L294
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h      |  2 ++
>  drivers/iio/chemical/bme680_core.c | 27 ++++++++++++++++++---------
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index 17ea59253923..3be2f76a5bfb 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -61,6 +61,8 @@
>  
>  #define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
>  
> +#define BME680_STARTUP_TIME_US			5000
> +
>  /* Calibration Parameters */
>  #define BME680_T2_LSB_REG	0x8A
>  #define BME680_H2_MSB_REG	0xE1
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index b055eeee8f1c..afaa43ec3241 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -505,10 +505,12 @@ static int bme680_chip_config(struct bme680_data *data)
>  	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
>  				BME680_OSRS_TEMP_MASK | BME680_OSRS_PRESS_MASK,
>  				osrs);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(dev, "failed to write ctrl_meas register\n");
> +		return ret;
> +	}
>  
> -	return ret;
> +	return 0;
>  }

I think this is an unrelated change so if you want to do this - different patch.

>  
>  static int bme680_gas_config(struct bme680_data *data)
> @@ -517,6 +519,11 @@ static int bme680_gas_config(struct bme680_data *data)
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
> @@ -847,6 +854,8 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  		return ret;
>  	}
>  
> +	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
> +
>  	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading chip ID\n");
> @@ -859,22 +868,22 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
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

Maybe you have it in a later patch (it definitely wants to be a different patch from
this one as different issue), but feels like a bunch of places where
dev_err_probe() would be good.

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


