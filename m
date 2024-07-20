Return-Path: <linux-iio+bounces-7729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1477B9380FB
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B54B21378
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7285C74;
	Sat, 20 Jul 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8y8cxRu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73559374F5;
	Sat, 20 Jul 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721474891; cv=none; b=Zek3DMr8xXrAiA0+Cbc/GFxc+agSRkP9exLL5hIBHE3Ufe3tqW+FH+LD5ein0W+eNEX0Y6UX6/wRGCdVBCAItbKrT8r7x1e22JHZanzRoOBTMi8a2C9J30wYeONRC7C8zxLde9k731ceQ0DkLSnTgwTKOhgLvfBkTD5Ls9je6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721474891; c=relaxed/simple;
	bh=Q8Wlk96IcqBdBUPAG3vf4xnLngj8CZQ3giCzlkXyKa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMKZ/L9Siv5CkZ2dKa2lpz3LTCFynRw2zsZk8S25XE2UgqPp2sSGgS/pW/n2GiIYlbdwOm9ArvKMTZcpYuXp5DMp1MbLNhfVPpWFUOZ9/HlNH1lb9WNQJ1yBx5YowUNj1m/SwXuIoCcTmLL07a9/jLL0RdH2EXxHYG9U4McnDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8y8cxRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A53C2BD10;
	Sat, 20 Jul 2024 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721474890;
	bh=Q8Wlk96IcqBdBUPAG3vf4xnLngj8CZQ3giCzlkXyKa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o8y8cxRup41QCy4dL+7t1vml5o+Wop9oQ8jHj4o0tZQLmI5sG09Se/F7fg3Cbfnef
	 ffDuIYCrR5pljVVYkmzzPU1Jt0nmrC+l/c6Cc/I5DfW56WflPzyLjpXRJKq3PhRfSH
	 m7c4bZpIQZhRDd6+axYNf2rH6dAAATYd9CYnoXVF4/nlYAWwHdw4HjJKhDlwdBesoa
	 NRfDjuiXUciDsaIsTyk2UENrpnK2SRIAbRgCLSFkgqXd8uWZSR1Y3qifyP7l5kuc2X
	 jiYpQWyoW2iRcCiKNU0gqDeLSI/bsktxEi1sx/LaZYxBF2DU+1On7ODJwxqGAy00xA
	 FU88LUEvgyyRA==
Date: Sat, 20 Jul 2024 12:28:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/10] iio: pressure: bmp280: Use sleep and forced
 mode for oneshot captures
Message-ID: <20240720122802.2c899ee7@jic23-huawei>
In-Reply-To: <20240711211558.106327-8-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-8-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 23:15:55 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> This commit adds forced mode support in sensors BMP28x, BME28x, BMP3xx
> and BMP58x. Sensors BMP18x and BMP085 are old and do not support this
> feature so their operation is not affected at all.
> 
> Essentially, up to now, the rest of the sensors were used in normal mode
> all the time. This means that they are continuously doing measurements
> even though these measurements are not used. Even though the sensor does
> provide PM support, to cover all the possible use cases, the sensor needs
> to go into sleep mode and wake up whenever necessary.
> 
> This commit, adds sleep and forced mode support. Essentially, the sensor
> sleeps all the time except for when a measurement is requested. When there
> is a request for a measurement, the sensor is put into forced mode, starts
> the measurement and after it is done we read the output and we put it again
> in sleep mode.
> 
> For really fast and more deterministic measurements, the triggered buffer
> interface can be used, since the sensor is still used in normal mode for
> that use case.
> 
> This commit does not add though support for DEEP STANDBY, Low Power NORMAL
> and CONTINUOUS modes, supported only by the BMP58x version.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Various minor comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 276 +++++++++++++++++++++++++++--
>  drivers/iio/pressure/bmp280.h      |  12 ++
>  2 files changed, 269 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 9c99373d66ec..fc8d42880eb8 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -145,6 +145,12 @@ enum bmp280_scan {
>  	BME280_HUMID,
>  };
>  }
>  
> +static int bmp280_set_mode(struct bmp280_data *data, u8 mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case BMP280_SLEEP:
> +		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> +					BMP280_MODE_MASK, BMP280_MODE_SLEEP);

Use a local variable for the BMP280_MODE_* and then have the regmap_write_bits()
after the switch statement.

Could even make it a const data look up given you are getting a value
based on the enum.

> +		break;
> +	case BMP280_FORCED:
> +		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> +					BMP280_MODE_MASK, BMP280_MODE_FORCED);
> +		break;
> +	case BMP280_NORMAL:
> +		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> +					BMP280_MODE_MASK, BMP280_MODE_NORMAL);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_err(data->dev, "failed to  write ctrl_meas register\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmp280_wait_conv(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret, meas_time;
> +
> +	meas_time = BMP280_MEAS_OFFSET;
> +
> +	if (data->oversampling_humid)
> +		meas_time += (1 << data->oversampling_humid) * BMP280_MEAS_DUR +
> +			       BMP280_PRESS_HUMID_MEAS_OFFSET;
Add a comment on why, if oversampling_humid is not set we end up with
no time for measuring humidity.  The MEAS_OFFSET is less than one MEAS_DUR
so not it's not a case of that already incorporating the time.


> +
> +	/* Pressure measurement time */
> +	meas_time += (1 << data->oversampling_press) * BMP280_MEAS_DUR +
> +		      BMP280_PRESS_HUMID_MEAS_OFFSET;
> +
> +	/* Temperature measurement time */
> +	meas_time += (1 << data->oversampling_temp) * BMP280_MEAS_DUR;
> +
> +	usleep_range(meas_time, meas_time * 12 / 10);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to read status register\n");
> +		return ret;
> +	}
> +	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
> +		dev_err(data->dev, "Measurement cycle didn't complete\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  static int bmp280_chip_config(struct bmp280_data *data)
>  {
>  	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> @@ -994,7 +1078,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  				BMP280_OSRS_TEMP_MASK |
>  				BMP280_OSRS_PRESS_MASK |
>  				BMP280_MODE_MASK,
> -				osrs | BMP280_MODE_NORMAL);
> +				osrs | BMP280_MODE_SLEEP);
>  	if (ret) {
>  		dev_err(data->dev, "failed to write ctrl_meas register\n");
>  		return ret;
> @@ -1100,6 +1184,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
>  	.read_calib = bmp280_read_calib,
> +	.set_mode = bmp280_set_mode,
> +	.wait_conv = bmp280_wait_conv,
>  	.preinit = bmp280_preinit,
>  
>  	.trigger_handler = bmp280_trigger_handler,
> @@ -1218,6 +1304,8 @@ const struct bmp280_chip_info bme280_chip_info = {
>  	.read_press = bmp280_read_press,
>  	.read_humid = bme280_read_humid,
>  	.read_calib = bme280_read_calib,
> +	.set_mode = bmp280_set_mode,
> +	.wait_conv = bmp280_wait_conv,
>  	.preinit = bmp280_preinit,
>  
>  	.trigger_handler = bme280_trigger_handler,
> @@ -1505,6 +1593,75 @@ static int bmp380_preinit(struct bmp280_data *data)
>  	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
>  }
>  
> +static int bmp380_set_mode(struct bmp280_data *data, u8 mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case BMP280_SLEEP:
> +		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> +					BMP380_MODE_MASK,
> +					FIELD_PREP(BMP380_MODE_MASK,
> +						   BMP380_MODE_SLEEP));
As above. I'd use a local variable to stash the MODE* that you are going
to write or just look it up in a const array.

> +		break;
> +	case BMP280_FORCED:
> +		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> +					BMP380_MODE_MASK,
> +					FIELD_PREP(BMP380_MODE_MASK,
> +						   BMP380_MODE_FORCED));
> +		break;
> +	case BMP280_NORMAL:
> +		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> +					BMP380_MODE_MASK,
> +					FIELD_PREP(BMP380_MODE_MASK,
> +						   BMP380_MODE_NORMAL));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_err(data->dev, "failed to  write power control register\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmp380_wait_conv(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret, meas_time;
> +
> +	/* Offset measurement time */
> +	meas_time = BMP380_MEAS_OFFSET;
> +
> +	/* Pressure measurement time */
> +	meas_time += (1 << data->oversampling_press) * BMP380_MEAS_DUR +
> +		      BMP380_PRESS_MEAS_OFFSET;
> +
> +	/* Temperature measurement time */
> +	meas_time += (1 << data->oversampling_temp) * BMP380_MEAS_DUR +
> +		      BMP380_TEMP_MEAS_OFFSET;
> +
> +	usleep_range(meas_time, meas_time * 12 / 10);
> +
> +	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "failed to read status register\n");
> +		return ret;
> +	}
> +
> +	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
> +	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
> +		pr_info("Meas_time: %d\n", meas_time);

Why as pr_info?  Seems like part of the dev_err.

> +		dev_err(data->dev, "Measurement cycle didn't complete\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  static int bmp380_chip_config(struct bmp280_data *data)
>  {
>  	bool change = false, aux;
> @@ -1565,17 +1722,15 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  		 * Resets sensor measurement loop toggling between sleep and
>  		 * normal operating modes.
>  		 */
> -		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> -					BMP380_MODE_MASK,
> -					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_SLEEP));
> +		ret = bmp380_set_mode(data, BMP280_SLEEP);
>  		if (ret) {
>  			dev_err(data->dev, "failed to set sleep mode\n");
>  			return ret;
>  		}
> -		usleep_range(2000, 2500);
> -		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> -					BMP380_MODE_MASK,
> -					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
> +
> +		usleep_range(data->start_up_time, data->start_up_time + 500);
> +
> +		ret = bmp380_set_mode(data, BMP280_NORMAL);
>  		if (ret) {
>  			dev_err(data->dev, "failed to set normal mode\n");
>  			return ret;
> @@ -1601,6 +1756,17 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  		}
>  	}
>  
> +	/* Dummy read to empty data registers. */
> +	ret = bmp380_read_press(data, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	ret = bmp380_set_mode(data, BMP280_SLEEP);
> +	if (ret) {
> +		dev_err(data->dev, "failed to set sleep mode\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1693,6 +1859,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
>  	.read_temp = bmp380_read_temp,
>  	.read_press = bmp380_read_press,
>  	.read_calib = bmp380_read_calib,
> +	.set_mode = bmp380_set_mode,
> +	.wait_conv = bmp380_wait_conv,
>  	.preinit = bmp380_preinit,
>  
>  	.trigger_handler = bmp380_trigger_handler,
> @@ -2080,6 +2248,65 @@ static int bmp580_preinit(struct bmp280_data *data)
>  	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
>  }
>  
> +static int bmp580_set_mode(struct bmp280_data *data, u8 mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case BMP280_SLEEP:
> +		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> +					BMP580_MODE_MASK,
> +					FIELD_PREP(BMP580_MODE_MASK,
> +						   BMP580_MODE_SLEEP));
> +		break;
> +	case BMP280_FORCED:
> +		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
> +				      BMP580_DSP_IIR_FORCED_FLUSH);
> +
check that ret.

> +		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> +					BMP580_MODE_MASK,
> +					FIELD_PREP(BMP580_MODE_MASK,
> +						   BMP580_MODE_FORCED));
This one is more complex so a switch statement makes sense here.
> +		break;
> +	case BMP280_NORMAL:
> +		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> +					BMP580_MODE_MASK,
> +					FIELD_PREP(BMP580_MODE_MASK,
> +						   BMP580_MODE_NORMAL));
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_err(data->dev, "failed to  write power control register\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmp580_wait_conv(struct bmp280_data *data)
> +{
> +	/*
> +	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
> +	 * characteristics
> +	 */
> +	const int time_conv_press[] = { 0, 1050, 1785, 3045, 5670, 10920, 21420,
> +					42420, 84420};
> +	const int time_conv_temp[] = { 0, 1050, 1105, 1575, 2205, 3465, 6090,
> +				       11340, 21840};
> +	int meas_time;
> +
> +	meas_time = 4000 + time_conv_temp[data->oversampling_temp] +
> +			   time_conv_press[data->oversampling_press];
> +
> +	usleep_range(meas_time, meas_time * 12 / 10);
> +
> +	return 0;
> +}
> +
one blank line only.
> +
>  static int bmp580_chip_config(struct bmp280_data *data)
>  {
>  	bool change = false, aux;
> @@ -2150,17 +2377,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
>  		return ret;
>  	}
>  
> -	/* Restore sensor to normal operation mode */
> -	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
> -				BMP580_MODE_MASK,
> -				FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_NORMAL));
> -	if (ret) {
> -		dev_err(data->dev, "failed to set normal mode\n");
> -		return ret;
> -	}
> -	/* From datasheet's table 4: electrical characteristics */
> -	usleep_range(3000, 3500);
> -
>  	if (change) {
>  		/*
>  		 * Check if ODR and OSR settings are valid or we are
> @@ -2256,6 +2472,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
>  	.chip_config = bmp580_chip_config,
>  	.read_temp = bmp580_read_temp,
>  	.read_press = bmp580_read_press,
> +	.set_mode = bmp580_set_mode,
> +	.wait_conv = bmp580_wait_conv,
>  	.preinit = bmp580_preinit,
>  
>  	.trigger_handler = bmp580_trigger_handler,
> @@ -2503,6 +2721,16 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
>  	return 0;
>  }
>  
> +static int bmp180_set_mode(struct bmp280_data *data, u8 mode)
> +{
> +	return 0;
Add a comment on why these are stubs.  It's in the patch description, but
better to have it recorded in the code.

> +}
> +
> +static int bmp180_wait_conv(struct bmp280_data *data)
> +{
> +	return 0;
> +}
> +
>

