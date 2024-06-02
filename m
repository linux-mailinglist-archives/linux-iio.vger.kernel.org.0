Return-Path: <linux-iio+bounces-5618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68428D7563
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B707281DF6
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B23A1CD;
	Sun,  2 Jun 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxl9g28T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7531E52C;
	Sun,  2 Jun 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717332075; cv=none; b=jFVcWjYn6PnOD+9qR/bpmMVilge+ipmDEKv5ZG+y42o0qC932L/jt2I+RECK8jnAB8QTWaKdHe3nsovlVZ3v6qqw+YiGbxs9kjSjiXM0KijVMCq9VOJ4XwK4/hhpuefeOBpiYZzixpYR+qRHWCpilp3pRl8PbsDxOK8HlWEbM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717332075; c=relaxed/simple;
	bh=e9ruaYjZ2BLY8P+1mkXSJrdIehx162YjAQ2gr9G0pYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUJjJxweptUBsXxPI1yaA1m427OR3yiyegGd+HbYbAD8OCVoP9rlERO2MoGyX4NVyvKoXuhkiQ8ePiyO3GO+zBqxwxpeqbaam9OhaVAuRpLV5ZF3NBuAlXrZCsTrIrPu2VejXa/I0HDA/TTldHBx2SRT7u0JLyjUxnGtZeeeov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxl9g28T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB0AC2BBFC;
	Sun,  2 Jun 2024 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717332074;
	bh=e9ruaYjZ2BLY8P+1mkXSJrdIehx162YjAQ2gr9G0pYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kxl9g28Tl0KvisLlmzrW0k4M63wBeroNpymZ371hIuNmLhRzxKlPY+eYV2n4Ox6Nk
	 LE7RHNZg5sReFGKsas50PdJei7tRoc2HShg0EXzm80LkAhnFRmx53hO28ppqM65+Fx
	 M67TSaOBi9xB+3ZdqNka8UxIOp+SNoaAeOaGC5JDhE2xkduvhPh78yuf1LHrs+1D32
	 l0MKBg0DokJcsr9R1HY+laORiGGzr/TxZTdKjHFYMqgxse1ssV9ydJEaW/RYuv9SfM
	 LrTKS4QyMlbATdppTFtaztCkwusur2LykU5GEGSIX+5a8snt39ExDcSrEvpolZmFvu
	 v1ViHPKvPfsWw==
Date: Sun, 2 Jun 2024 13:41:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/17] iio: chemical: bme680: Fix sensor data read
 operation
Message-ID: <20240602134106.2538471a@jic23-huawei>
In-Reply-To: <20240527183805.311501-5-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 20:37:52 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> A read operation is happening as follows:
> 
> a) Set sensor to forced mode
> b) Sensor measures values and update data registers and sleeps again
> c) Read data registers
> 
> In the current implementation the read operation happens immediately
> after the sensor is set to forced mode so the sensor does not have
> the time to update properly the registers. This leads to the following
> 2 problems:
> 
> 1) The first ever value which is read by the register is always wrong
> 2) Every read operation, puts the register into forced mode and reads
> the data that were calculated in the previous conversion.
> 
> This behaviour was tested in 2 ways:
> 
> 1) The internal meas_status_0 register was read before and after every
> read operation in order to verify that the data were ready even before
> the register was set to forced mode and also to check that after the
> forced mode was set the new data were not yet ready.
> 
> 2) Physically changing the temperature and measuring the temperature
> 
> This commit adds the waiting time in between the set of the forced mode
> and the read of the data. The function is taken from the Bosch BME68x
> Sensor API [1].
> 
> [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
> Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 5db48f6d646c..dd2cd11b6dd3 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -10,6 +10,7 @@
>   */
>  #include <linux/acpi.h>
>  #include <linux/bitfield.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/log2.h>
> @@ -532,6 +533,26 @@ static u8 bme680_oversampling_to_reg(u8 val)
>  	return ilog2(val) + 1;
>  }
>  
> +/*
> + * Taken from Bosch BME680 API:
> + * https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
> + */
> +static int bme680_conversion_time_us(u8 meas, u8 dur)
> +{
> +	/* Oversampling + TPH meas + Gas meas + Forced mode + heater duration */
I'd break oversampling up

	/* (Oversampling ratio * time per reading) ...
or something along those lines because it's related to oversampling but isn't
of itself oversampling.

> +	return (meas * 1936) + (477 * 4) + (477 * 5) + 1000 + (dur * 1000);

Trivial but I think we can rely on precedence both for correctness and readability
and hence don't need the brackets

> +}
> +
> +static void bme680_wait_for_eoc(struct bme680_data *data)
Don't call it wait as that implies something is being checked.

bme680_conversion_sleep() or something like that.

> +{
> +	int wait_eoc = bme680_conversion_time_us(data->oversampling_temp +
> +						 data->oversampling_press +
> +						 data->oversampling_press,
> +						 data->heater_dur);

I'd pull the calculation inline in here unless you are going to use it elsewhere
in later patches.

> +
> +	usleep_range(wait_eoc, wait_eoc + 100);
> +}
> +
>  static int bme680_chip_config(struct bme680_data *data)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
> @@ -622,6 +643,8 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
>  	if (ret < 0)
>  		return ret;
>  
> +	bme680_wait_for_eoc(data);
> +
>  	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
>  			       &tmp, 3);
>  	if (ret < 0) {
> @@ -738,6 +761,8 @@ static int bme680_read_gas(struct bme680_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> +	bme680_wait_for_eoc(data);
> +
>  	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
>  	if (check & BME680_GAS_MEAS_BIT) {
>  		dev_err(dev, "gas measurement incomplete\n");


