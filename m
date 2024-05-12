Return-Path: <linux-iio+bounces-4982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84CE8C3657
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69614B20DA1
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDA5208CB;
	Sun, 12 May 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb4Zqhv9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFD208B8;
	Sun, 12 May 2024 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515804; cv=none; b=QGTWK/BbQULeOpROiUoecJadRz2jquHXTt0/NgwcQA7yfgnOqnE2XWdg46JwDD8KmMQUpV2UVZqCcH7K45AQkvxjKRZzOdJXgHISdIJ7MRqQqOXq2o8WdkAu+PI1qWgZKROB7JatkJDGNdT3JYpMjGba0unpqE3sEmeULA9lY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515804; c=relaxed/simple;
	bh=9fg9w4sc2Wp7eS0TtPRk2TnReOIj6kdvPXdq3S8Qk5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss8NmyvJ5W4+SOw3BoIR2xNg3uGiCAucPMtQsE+SPq9uRH1KuIXZknsV85/AqQnUhjchEEwWbG7bhLxOdIpq0LSrksUgbAqUCIDrgPXD0vv7Cg0c49yNiZXINJypKriqAGLhfeYU8eSyWUg2YNKyWCNQJJQDBmF2RpSak2LfZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb4Zqhv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B20C116B1;
	Sun, 12 May 2024 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715515804;
	bh=9fg9w4sc2Wp7eS0TtPRk2TnReOIj6kdvPXdq3S8Qk5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yb4Zqhv9je/El2N24vM4Ux+OPIHmA2RTlb+dewBJHDEgJVeeiM5Jo8RXd45rAZaAh
	 yF8t7djOvglQKG5ENft8XdQ8JLJalhaXh4bfbdDMb3B4+czXRBJ3qmfxWNG8g0K2jm
	 rzPMQ/GHv+VgJ3eaFSuExzNFms21vNyObiQzg1WoJz/jCsnminRPijEW3+0dHnystK
	 UyWmhilR2Na09AMV0l2GDoKZW0DoFl1sH6EY2VBe/+O/tRzTrrco8wv3pxbzHEKUbK
	 tTABtyuF3fZmocbojhw3MmR8aCwC3y7+/KXsD2EmQ0bgnJeXcw8tWUjuwM1f4HwIWR
	 c2OABTmyHp1pw==
Date: Sun, 12 May 2024 13:09:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/9] iio: pressure: bmp280: Remove, add and update
 error messages
Message-ID: <20240512130950.4d5ab874@jic23-huawei>
In-Reply-To: <20240508165207.145554-3-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
	<20240508165207.145554-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 18:52:00 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Remove duplicate error messages, add missing error messages and
> update redundant ones.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hi Vasileios,

Ideally the one case where you are adding a missing error check should
have been a separate patch, but instead of splitting it I've just
added a note on that to the commit message.

Applied 

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 55 +++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 311a011604da..0aa16fb135c1 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -222,10 +222,8 @@ static int bme280_read_calib(struct bmp280_data *data)
>  
>  	/* Load shared calibration params with bmp280 first */
>  	ret = bmp280_read_calib(data);
> -	if  (ret < 0) {
> -		dev_err(dev, "failed to read calibration parameters\n");
> +	if  (ret < 0)
>  		return ret;
> -	}
>  
>  	/*
>  	 * Read humidity calibration values.
> @@ -841,8 +839,10 @@ static int bme280_chip_config(struct bmp280_data *data)
>  	 */
>  	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
>  				 BME280_OSRS_HUMIDITY_MASK, osrs);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to set humidity oversampling");
>  		return ret;
> +	}
>  
>  	return bmp280_chip_config(data);
>  }
> @@ -1071,7 +1071,7 @@ static int bmp380_read_calib(struct bmp280_data *data)
>  			       sizeof(data->bmp380_cal_buf));
>  	if (ret) {
>  		dev_err(data->dev,
> -			"failed to read temperature calibration parameters\n");
> +			"failed to read calibration parameters\n");
>  		return ret;
>  	}
>  
> @@ -1609,20 +1609,24 @@ static int bmp580_preinit(struct bmp280_data *data)
>  
>  	/* Post powerup sequence */
>  	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
> -	if (ret)
> +	if (ret) {
> +		dev_err(data->dev, "failed to establish comms with the chip\n");
>  		return ret;
> +	}
>  
>  	/* Print warn message if we don't know the chip id */
>  	if (reg != BMP580_CHIP_ID && reg != BMP580_CHIP_ID_ALT)
> -		dev_warn(data->dev, "preinit: unexpected chip_id\n");
> +		dev_warn(data->dev, "unexpected chip_id\n");
>  
>  	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
> -	if (ret)
> +	if (ret) {
> +		dev_err(data->dev, "failed to read nvm status\n");
>  		return ret;
> +	}
>  
>  	/* Check nvm status */
>  	if (!(reg & BMP580_STATUS_NVM_RDY_MASK) || (reg & BMP580_STATUS_NVM_ERR_MASK)) {
> -		dev_err(data->dev, "preinit: nvm error on powerup sequence\n");
> +		dev_err(data->dev, "nvm error on powerup sequence\n");
>  		return -EIO;
>  	}
>  
> @@ -1657,6 +1661,10 @@ static int bmp580_chip_config(struct bmp280_data *data)
>  				 BMP580_DSP_COMP_MASK |
>  				 BMP580_DSP_SHDW_IIR_TEMP_EN |
>  				 BMP580_DSP_SHDW_IIR_PRESS_EN, reg_val);
> +	if (ret) {
> +		dev_err(data->dev, "failed to change DSP mode settings\n");
> +		return ret;
> +	}
>  
>  	/* Configure oversampling */
>  	reg_val = FIELD_PREP(BMP580_OSR_TEMP_MASK, data->oversampling_temp) |
> @@ -1778,8 +1786,10 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
>  		reinit_completion(&data->done);
>  
>  	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
> -	if (ret)
> +	if (ret) {
> +		dev_err(data->dev, "failed to write crtl_meas register\n");
>  		return ret;
> +	}
>  
>  	if (data->use_eoc) {
>  		/*
> @@ -1802,12 +1812,16 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
>  	}
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
> -	if (ret)
> +	if (ret) {
> +		dev_err(data->dev, "failed to read ctrl_meas register\n");
>  		return ret;
> +	}
>  
>  	/* The value of this bit reset to "0" after conversion is complete */
> -	if (ctrl & BMP180_MEAS_SCO)
> +	if (ctrl & BMP180_MEAS_SCO) {
> +		dev_err(data->dev, "conversion didn't complete\n");
>  		return -EIO;
> +	}
>  
>  	return 0;
>  }
> @@ -1824,8 +1838,10 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
>  
>  	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
>  			       &data->be16, sizeof(data->be16));
> -	if (ret)
> +	if (ret) {
> +		dev_err(data->dev, "failed to read temperature\n");
>  		return ret;
> +	}
>  
>  	*val = be16_to_cpu(data->be16);
>  
> @@ -1840,9 +1856,10 @@ static int bmp180_read_calib(struct bmp280_data *data)
>  
>  	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START,
>  			       data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
> -
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read calibration parameters\n");
>  		return ret;
> +	}
>  
>  	/* None of the words has the value 0 or 0xFFFF */
>  	for (i = 0; i < ARRAY_SIZE(data->bmp180_cal_buf); i++) {
> @@ -1925,8 +1942,10 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
>  
>  	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
>  			       data->buf, sizeof(data->buf));
> -	if (ret)
> +	if (ret) {
> +		dev_err(data->dev, "failed to read pressure\n");
>  		return ret;
> +	}
>  
>  	*val = get_unaligned_be24(data->buf) >> (8 - oss);
>  
> @@ -2158,8 +2177,10 @@ int bmp280_common_probe(struct device *dev,
>  	data->regmap = regmap;
>  
>  	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(data->dev, "failed to read chip id\n");
>  		return ret;
> +	}
>  
>  	for (i = 0; i < data->chip_info->num_chip_id; i++) {
>  		if (chip_id == data->chip_info->chip_id[i]) {


