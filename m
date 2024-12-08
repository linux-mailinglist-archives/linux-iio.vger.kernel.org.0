Return-Path: <linux-iio+bounces-13245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5BA9E8735
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B25281A98
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D0189BB0;
	Sun,  8 Dec 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmv8U/aW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B254690;
	Sun,  8 Dec 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733681307; cv=none; b=LKyMQe0fDFGp6EWLBu0QgWvAY4yJctMfSSVMqNBqC1OjyDB6oNLqMvDtdijfxMW0uCuPGeHhxeR/oarG3X4Ug63yu2O31lWgKLJA6io0svS49c6XK0RIYVsdIv/lF56ij+og8KJEnRSZ4nFds18RQ2K5XwP0ycG5SzOeqoIiBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733681307; c=relaxed/simple;
	bh=OVqwOBaTyEMtO7x5illPKc4qASGbs/PWWbDa/DSlb3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWZ0ZAYsEN+vA1dazZm49cXpgP2JQjfJsBR3AuZUHdfkcj6D0ZFHrtvJRLcmYeWjrWY12RDAE3BG1oXixYNoWhCAxaQA+MrNIzLlQ7xTxGDiMMTGJS9ViqsTx4OdwhZHuNIeL+l361Kc9OCtsYTyxKFV7tKFlGdgQ4NuH0zak94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmv8U/aW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033C1C4CED2;
	Sun,  8 Dec 2024 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733681305;
	bh=OVqwOBaTyEMtO7x5illPKc4qASGbs/PWWbDa/DSlb3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmv8U/aWbetsZAI+xmtNlApn6m3csBN5XJQqvPqm0+iHmSi48f6cGpx6amZ0bmSKU
	 0piuZGbetyg4fQw1lxFJc9BOFRhmOJ/glLO+qybU0jpHFQPNv8q9gdbLHAZh4emYSN
	 RXHX7xrNLnbydm/pcLeSX1puEZPP7TicVo9jPtgy5FDYDaPRokp9iRm9oNFA5f6Mgm
	 M8jxFEixn4Am8Xx7NniLkN77EsiJXw2BiSqTYvVrBgKMaMhJqCeuThEQ8k0awGjXg9
	 epCPVFTD/ATC+ys2U7vBP9OEedRbFxugE3V1M7SP8mdjQ+Xr7Ad+GP6bvPKBCLln9v
	 vg8ZAKPnwoqSA==
Date: Sun, 8 Dec 2024 18:08:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, ajarizzo@gmail.com,
 ak@it-klinger.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] iio: pressure: bmp280: Make time vars intuitive
 and move to fsleep
Message-ID: <20241208180817.6ae939db@jic23-huawei>
In-Reply-To: <20241202181907.21471-4-vassilisamir@gmail.com>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
	<20241202181907.21471-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 19:19:07 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Move sleep functions to the new fsleep() implementation. While at it,
> add time unit abbreviation as a suffix of time describing variables to
> make them more intuitive.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied this one.  So only patch 1 needs an update.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 39 +++++++++++++++---------------
>  drivers/iio/pressure/bmp280.h      |  4 +--
>  2 files changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index e5ec8137961f..b39ef30f8eda 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1002,7 +1002,7 @@ static int bmp280_preinit(struct bmp280_data *data)
>  	 * after resetting, the device uses the complete power-on sequence so
>  	 * it needs to wait for the defined start-up time.
>  	 */
> -	fsleep(data->start_up_time);
> +	fsleep(data->start_up_time_us);
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
>  	if (ret)
> @@ -1161,7 +1161,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
>  	.chip_id = bmp280_chip_ids,
>  	.num_chip_id = ARRAY_SIZE(bmp280_chip_ids),
>  	.regmap_config = &bmp280_regmap_config,
> -	.start_up_time = 2000,
> +	.start_up_time_us = 2000,
>  	.channels = bmp280_channels,
>  	.num_channels = ARRAY_SIZE(bmp280_channels),
>  	.avail_scan_masks = bmp280_avail_scan_masks,
> @@ -1347,7 +1347,7 @@ const struct bmp280_chip_info bme280_chip_info = {
>  	.chip_id = bme280_chip_ids,
>  	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
>  	.regmap_config = &bme280_regmap_config,
> -	.start_up_time = 2000,
> +	.start_up_time_us = 2000,
>  	.channels = bme280_channels,
>  	.num_channels = ARRAY_SIZE(bme280_channels),
>  	.avail_scan_masks = bme280_avail_scan_masks,
> @@ -1414,7 +1414,7 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
>  		return ret;
>  	}
>  	/* Wait for 2ms for command to be processed */
> -	usleep_range(data->start_up_time, data->start_up_time + 100);
> +	fsleep(data->start_up_time_us);
>  	/* Check for command processing error */
>  	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
>  	if (ret) {
> @@ -1806,7 +1806,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  		 * formula in datasheet section 3.9.2 with an offset of ~+15%
>  		 * as it seen as well in table 3.9.1.
>  		 */
> -		msleep(150);
> +		fsleep(150 * USEC_PER_MSEC);
>  
>  		/* Check config error flag */
>  		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
> @@ -1957,7 +1957,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
>  	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
>  	.regmap_config = &bmp380_regmap_config,
>  	.spi_read_extra_byte = true,
> -	.start_up_time = 2000,
> +	.start_up_time_us = 2000,
>  	.channels = bmp380_channels,
>  	.num_channels = ARRAY_SIZE(bmp380_channels),
>  	.avail_scan_masks = bmp280_avail_scan_masks,
> @@ -2006,7 +2006,8 @@ static int bmp580_soft_reset(struct bmp280_data *data)
>  		dev_err(data->dev, "failed to send reset command to device\n");
>  		return ret;
>  	}
> -	usleep_range(2000, 2500);
> +	/* From datasheet's table 4: electrical characteristics */
> +	fsleep(2000);
>  
>  	/* Dummy read of chip_id */
>  	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
> @@ -2208,7 +2209,7 @@ static int bmp580_nvmem_read_impl(void *priv, unsigned int offset, void *val,
>  		goto exit;
>  	}
>  	/* Wait standby transition time */
> -	usleep_range(2500, 3000);
> +	fsleep(2500);
>  
>  	while (bytes >= sizeof(*dst)) {
>  		addr = bmp580_nvmem_addrs[offset / sizeof(*dst)];
> @@ -2274,7 +2275,7 @@ static int bmp580_nvmem_write_impl(void *priv, unsigned int offset, void *val,
>  		goto exit;
>  	}
>  	/* Wait standby transition time */
> -	usleep_range(2500, 3000);
> +	fsleep(2500);
>  
>  	while (bytes >= sizeof(*buf)) {
>  		addr = bmp580_nvmem_addrs[offset / sizeof(*buf)];
> @@ -2458,7 +2459,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
>  		return ret;
>  	}
>  	/* From datasheet's table 4: electrical characteristics */
> -	usleep_range(2500, 3000);
> +	fsleep(2500);
>  
>  	/* Set default DSP mode settings */
>  	reg_val = FIELD_PREP(BMP580_DSP_COMP_MASK, BMP580_DSP_PRESS_TEMP_COMP_EN) |
> @@ -2649,7 +2650,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
>  	.chip_id = bmp580_chip_ids,
>  	.num_chip_id = ARRAY_SIZE(bmp580_chip_ids),
>  	.regmap_config = &bmp580_regmap_config,
> -	.start_up_time = 2000,
> +	.start_up_time_us = 2000,
>  	.channels = bmp580_channels,
>  	.num_channels = ARRAY_SIZE(bmp580_channels),
>  	.avail_scan_masks = bmp280_avail_scan_masks,
> @@ -2720,7 +2721,7 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
>  			delay_us =
>  				conversion_time_max[data->oversampling_press];
>  
> -		usleep_range(delay_us, delay_us + 1000);
> +		fsleep(delay_us);
>  	}
>  
>  	ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
> @@ -2988,7 +2989,7 @@ const struct bmp280_chip_info bmp180_chip_info = {
>  	.chip_id = bmp180_chip_ids,
>  	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
>  	.regmap_config = &bmp180_regmap_config,
> -	.start_up_time = 2000,
> +	.start_up_time_us = 2000,
>  	.channels = bmp280_channels,
>  	.num_channels = ARRAY_SIZE(bmp280_channels),
>  	.avail_scan_masks = bmp280_avail_scan_masks,
> @@ -3066,7 +3067,7 @@ const struct bmp280_chip_info bmp085_chip_info = {
>  	.chip_id = bmp180_chip_ids,
>  	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
>  	.regmap_config = &bmp180_regmap_config,
> -	.start_up_time = 2000,
> +	.start_up_time_us = 2000,
>  	.channels = bmp280_channels,
>  	.num_channels = ARRAY_SIZE(bmp280_channels),
>  	.avail_scan_masks = bmp280_avail_scan_masks,
> @@ -3175,7 +3176,7 @@ int bmp280_common_probe(struct device *dev,
>  	data->oversampling_temp = chip_info->oversampling_temp_default;
>  	data->iir_filter_coeff = chip_info->iir_filter_coeff_default;
>  	data->sampling_freq = chip_info->sampling_freq_default;
> -	data->start_up_time = chip_info->start_up_time;
> +	data->start_up_time_us = chip_info->start_up_time_us;
>  
>  	/* Bring up regulators */
>  	regulator_bulk_set_supply_names(data->supplies,
> @@ -3201,7 +3202,7 @@ int bmp280_common_probe(struct device *dev,
>  		return ret;
>  
>  	/* Wait to make sure we started up properly */
> -	usleep_range(data->start_up_time, data->start_up_time + 100);
> +	fsleep(data->start_up_time_us);
>  
>  	/* Bring chip out of reset if there is an assigned GPIO line */
>  	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> @@ -3287,7 +3288,7 @@ int bmp280_common_probe(struct device *dev,
>  	 * Set autosuspend to two orders of magnitude larger than the
>  	 * start-up time.
>  	 */
> -	pm_runtime_set_autosuspend_delay(dev, data->start_up_time / 10);
> +	pm_runtime_set_autosuspend_delay(dev, data->start_up_time_us / 10);
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_put(dev);
>  
> @@ -3306,7 +3307,7 @@ static int bmp280_runtime_suspend(struct device *dev)
>  
>  	data->chip_info->set_mode(data, BMP280_SLEEP);
>  
> -	fsleep(data->start_up_time);
> +	fsleep(data->start_up_time_us);
>  	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
>  }
>  
> @@ -3320,7 +3321,7 @@ static int bmp280_runtime_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	usleep_range(data->start_up_time, data->start_up_time + 100);
> +	fsleep(data->start_up_time_us);
>  
>  	ret = data->chip_info->chip_config(data);
>  	if (ret)
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index a3631bc0e188..5b2ee1d0ee46 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -434,7 +434,7 @@ struct bmp280_data {
>  		struct bmp380_calib bmp380;
>  	} calib;
>  	struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
> -	unsigned int start_up_time; /* in microseconds */
> +	unsigned int start_up_time_us;
>  
>  	/* log of base 2 of oversampling rate */
>  	u8 oversampling_press;
> @@ -490,7 +490,7 @@ struct bmp280_chip_info {
>  
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
> -	unsigned int start_up_time;
> +	unsigned int start_up_time_us;
>  	const unsigned long *avail_scan_masks;
>  
>  	const int *oversampling_temp_avail;


