Return-Path: <linux-iio+bounces-8002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43093E70B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 18:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE3281BA1
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D852F12F5B3;
	Sun, 28 Jul 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyIrBEYE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DA12F5B1;
	Sun, 28 Jul 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181752; cv=none; b=fXhjcn3aYxy7bAiZiP720c7lw4KmDesJ+aqikyNiqdYf7N8DFIwLr7492+wCZ/4V9d6hwPiwNGP8830QWXY6A/DUTf6yGrsEJLaDVjHE21KlH2dhJFfT2DkEYTOQgrD1sgLzxD1QuI59yYua37JD3t8tUCs6WL/rSLBLPmI8fu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181752; c=relaxed/simple;
	bh=TSQSBTiv/2tz4tLXVZIEtWMiDsRu5Y4rPKZ1Gx8SvuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXuzyv47YY5UIJrAIq+SRhg/h4/W4b2QaqMDMO915j7FXUzVYuALY/ejeBY9Lb3xgWFJhxFTPY2H8atmUJeCQfgsAL69E/oIJLqUty93JM4wHrKvADLQ5MTjxe3h214qvNB+noj0Wt+bAMfuPA69hXoBsqxk2r4upGpFkYyED5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyIrBEYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED0EC32782;
	Sun, 28 Jul 2024 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181752;
	bh=TSQSBTiv/2tz4tLXVZIEtWMiDsRu5Y4rPKZ1Gx8SvuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uyIrBEYEYhLgvg9eta9eIhVHOeIVaBo/7tKpJvgZfTTjwZJUR4LV9HeWCnFNwzyEv
	 3EXWRoQqVSGomasgrNomsMJJ6SYg4K7jqIge3h2iGJnXbVbGx5hhcK1sNstYylLn0b
	 jqiscyt+BO+RKMzYnpW4npZUrWbrch9PL9n+sXtIRb4234zM4NmzM8PVq5ML67fbP1
	 WAa5BN0H6Ak5xWdg27LEj4ACbQ7Hg1n3UhpxXicMAlm6+I49RA6+wlTbGNRl/REG39
	 D7qF68RsclHLMyL0OUHLTsG3zL8HTFF/p3Iu/VQYzIUpshbvSLRKX9E2KJmRquXcnB
	 ibxlOoH+J3DYg==
Date: Sun, 28 Jul 2024 16:49:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <20240728164901.1f325aa2@jic23-huawei>
In-Reply-To: <20240725231039.614536-3-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
	<20240725231039.614536-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 01:10:34 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The BM(P/E)28x devices have an option for soft reset which is also
> recommended by the Bosch Sensortech BME2 Sensor API to be used before the
> initial configuration of the device.
> 
> Link: https://github.com/boschsensortec/BME280_SensorAPI/blob/bme280_v3.5.1/bme280.c#L429
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Trivial passing comment seeing as you are going do be doing a v3 anyway.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 28 ++++++++++++++++++++++++++++
>  drivers/iio/pressure/bmp280.h      |  3 +++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index d5e5eb22667a..acbc33aacc09 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -963,6 +963,32 @@ static const unsigned long bme280_avail_scan_masks[] = {
>  	0
>  };
>  
> +static int bmp280_preinit(struct bmp280_data *data)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMP280_REG_RESET, BMP280_RST_SOFT_CMD);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to reset device.\n");
> +		return ret;
Is this only ever called from probe?

If so, return dev_err_probe() which will save a few lines of code.

> +	}
> +
> +	usleep_range(data->start_up_time, data->start_up_time + 500);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to read status register.\n");
> +		return ret;
> +	}
> +	if (reg & BMP280_REG_STATUS_IM_UPDATE) {
> +		dev_err(data->dev, "Failed to copy NVM contents.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int bmp280_chip_config(struct bmp280_data *data)
>  {
>  	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> @@ -1079,6 +1105,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
>  	.read_temp = bmp280_read_temp,
>  	.read_press = bmp280_read_press,
>  	.read_calib = bmp280_read_calib,
> +	.preinit = bmp280_preinit,
>  
>  	.trigger_handler = bmp280_trigger_handler,
>  };
> @@ -1196,6 +1223,7 @@ const struct bmp280_chip_info bme280_chip_info = {
>  	.read_press = bmp280_read_press,
>  	.read_humid = bme280_read_humid,
>  	.read_calib = bme280_read_calib,
> +	.preinit = bmp280_preinit,
>  
>  	.trigger_handler = bme280_trigger_handler,
>  };
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 9bea0b84d2f4..a9f220c1f77a 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -205,6 +205,9 @@
>  #define BMP280_REG_CONFIG		0xF5
>  #define BMP280_REG_CTRL_MEAS		0xF4
>  #define BMP280_REG_STATUS		0xF3
> +#define BMP280_REG_STATUS_IM_UPDATE	BIT(0)
> +#define BMP280_REG_RESET		0xE0
> +#define BMP280_RST_SOFT_CMD		0xB6
>  
>  #define BMP280_REG_COMP_TEMP_START	0x88
>  #define BMP280_COMP_TEMP_REG_COUNT	6


