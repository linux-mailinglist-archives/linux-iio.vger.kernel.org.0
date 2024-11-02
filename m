Return-Path: <linux-iio+bounces-11846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26E9BA12D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCAFB2145F
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D061A0704;
	Sat,  2 Nov 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1M0PmGB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CE19F43A;
	Sat,  2 Nov 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561100; cv=none; b=pYnBjaaVyQNIzi8FxmEA6KxHP6DQe0J7x6OkgK7bTRfbvA/lk6woJvat4OTTL4CmpAZNCy7U1lUISKr9Je8Y+RXn54SUzZw8Durux4xVgHdhicITpz6jmOXQierAQ7lN8ElRb7hTXuYShD2p1Z7lkZ798hdfJ6L4WkBkpoHlz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561100; c=relaxed/simple;
	bh=aeiR89A3bm+yZZrMX0t/ta1PKN9Avc4snrD4b1mhJLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzB5Njjrmxf77CGqOYCrgvGfXEfcp7+MLFNM8TpVBC4AdB+Zl/EFtxJ5OWDd34a0Ikt742LzVq3303TPSIyTp3jFXou3K/OuGhJxvrcL3JAerc0uitqhEhYu3efhMM3RUabbYUqFu0wontz14y77fUKXRyQvISWC/LhNYJBo5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1M0PmGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFB6C4CEC3;
	Sat,  2 Nov 2024 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730561100;
	bh=aeiR89A3bm+yZZrMX0t/ta1PKN9Avc4snrD4b1mhJLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1M0PmGB7Ax1DRm/gT5gUaXCZO9evDJJr+rMN+cegn94ulnCKIsdoyqECPso/atw3
	 cwck259IUI51UZegF5w5Ozu/2umYtOQtjiiaIIYJqUwclAt8Xou2PgfR/Cjp7AtcOK
	 7OtVmt06joELIb7z5a7dJu799/zQxZSisY5Wyo6FcBmGEzovOiD2Q8k28VMGeQuRNJ
	 yOyHhZFL8oXOGaZiz5ufCTBHbmKX+aKiMtvP0E2lB8Tj3WZO1ITkhCuFPlVTvDyG0U
	 RfBBOpKke0II3mA5sdrbdqoBIP/slR0Hh+uGyptaLn3UDiahpxRBr4cpsrbUDgHd5t
	 DrnaVQHkbnzGg==
Date: Sat, 2 Nov 2024 15:24:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iio: chemical: bme680: Add triggered buffer
 support
Message-ID: <20241102152452.062ff2c4@jic23-huawei>
In-Reply-To: <20241102131311.36210-4-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
	<20241102131311.36210-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 14:13:07 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add triggered buffer and soft timestamp support. The available scan mask
> enables all the channels of the sensor in order to follow the operation of
> the sensor. The sensor basically starts to capture from all channels
> as long as it enters into FORCED mode.
> 
> The bulk read, reads a total of 15 registers from the sensor, 0x1D..0x2B.
> Even though some of those registers are not reported in the register map
> of the device, this is how the BME680 Sensor API [1] proposes to do it.
> This allows to have one bulk read instead of multiple ones.
> 
> Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1200
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied with a couple of (to me) superfluous comments dropped.
> +static irqreturn_t bme680_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	u32 adc_temp, adc_press, adc_humid;
> +	u16 adc_gas_res, gas_regs_val;
> +	u8 gas_range;
> +	s32 t_fine;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = bme680_set_mode(data, BME680_MODE_FORCED);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = bme680_wait_for_eoc(data);
> +	if (ret)
> +		goto out;
> +
> +	/* Burst read data regs */
This one dropped as kind of obvious from the code.
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_MEAS_STAT_0,
> +			       data->buf, sizeof(data->buf));
> +	if (ret) {
> +		dev_err(dev, "failed to burst read sensor data\n");
> +		goto out;
> +	}
> +	if (data->buf[0] & BME680_GAS_MEAS_BIT) {
> +		dev_err(dev, "gas measurement incomplete\n");
> +		goto out;
> +	}
> +
> +	/* Temperature calculations */
> +	adc_temp = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[5]));
> +	if (adc_temp == BME680_MEAS_SKIPPED) {
> +		dev_err(dev, "reading temperature skipped\n");
> +		goto out;
> +	}
> +	data->scan.chan[0] = bme680_compensate_temp(data, adc_temp);
> +	t_fine = bme680_calc_t_fine(data, adc_temp);
> +
> +	/* Pressure calculations */
> +	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[2]));
> +	if (adc_press == BME680_MEAS_SKIPPED) {
> +		dev_err(dev, "reading pressure skipped\n");
> +		goto out;
> +	}
> +	data->scan.chan[1] = bme680_compensate_press(data, adc_press, t_fine);
> +
> +	/* Humidity calculations */
> +	adc_humid = get_unaligned_be16(&data->buf[8]);
> +	if (adc_humid == BME680_MEAS_SKIPPED) {
> +		dev_err(dev, "reading humidity skipped\n");
> +		goto out;
> +	}
> +	data->scan.chan[2] = bme680_compensate_humid(data, adc_humid, t_fine);
> +
> +	/* Gas calculations */
> +	gas_regs_val = get_unaligned_be16(&data->buf[13]);
> +	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
> +	if ((gas_regs_val & BME680_GAS_STAB_BIT) == 0) {
> +		dev_err(dev, "heater failed to reach the target temperature\n");
> +		goto out;
> +	}
> +	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
> +	data->scan.chan[3] = bme680_compensate_gas(data, adc_gas_res, gas_range);
> +
> +	/* Push to buffer */
This one is extremely obvious so dropped.

> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +					   iio_get_time_ns(indio_dev));
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +

