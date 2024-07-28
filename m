Return-Path: <linux-iio+bounces-8003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BBF93E76D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EA41C2108D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8064CEC;
	Sun, 28 Jul 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmvJU13X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830E3EA9B;
	Sun, 28 Jul 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182254; cv=none; b=hswDWLrkaiLb5Z3Mk2kD2LJ9WzF5UHFytvo7DTqahMiJT1/dxntMPQL9ElRLI0zgrNgUEXdSW9gnrcUrq8KAQzMdLMWRsxhSSl89qVjogOQiULeeOkrpuXnJpR6FexPbUypOchRWhOqy9Y4CynGKXDrIMiLkLcaKfApUCY1xAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182254; c=relaxed/simple;
	bh=XjPWs3XZAYVRfacXl3+Xy0bIqT1C+XEC+Fe3jXsbfyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btLN2IkJVfu0kUvU62na+YNQJnqAH5l0hti+8C0bDAiFagYw4ZAfwwM8wsrGOX4f0I9NJm56hp/+rxXDrF4B2EVr1tD0sxkiAzUy8lfUZRRWw8bzZB5I2xMR/zxCEpQExADQ1vDZ3f3udQ3w2zE0MNic5OhAywRTYMZGhRlZF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmvJU13X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D48C116B1;
	Sun, 28 Jul 2024 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182254;
	bh=XjPWs3XZAYVRfacXl3+Xy0bIqT1C+XEC+Fe3jXsbfyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MmvJU13XQs8tsHu+Z1WCmY5c7B3qUSM/VT50uFsrJbNlVy/gB+2hb6qsO5UCbUOOR
	 b5GI8ZFMOOFeliufKV6xfuPqGpdbVDP+L1HwkcBT31lUwaj9PIN/efn3/c4qofKtNV
	 PDGNAT+I/Ns/r/9mhNs/hkLyT9j7+j2/I/Bh5b1B5AknoNjEu4rvNY9DFopAB5xD+Z
	 DO6fqNeZ2woPrkK8UD9HEXWs3SqxUwLQIxlZtZpLt7WSvW3B/5352960iCO0qXw9hJ
	 lTwWe0BU7P4jd/FHAkjQ9hdR22pHYwHfqKBdVQZW3a1BUS+H6QKL+OUF9BFuM19ssb
	 8hkEw5+9f5QdQ==
Date: Sun, 28 Jul 2024 16:57:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <20240728165724.75153d08@jic23-huawei>
In-Reply-To: <20240725231039.614536-5-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
	<20240725231039.614536-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 01:10:36 +0200
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
One question inline about the corner case of buffered capture in progress
when the machine is suspended.  We'd like the device to carry on feeding
us data on resume. Does that happen?

Jonathan


>  	.trigger_handler = bmp380_trigger_handler,
> @@ -2085,6 +2239,64 @@ static int bmp580_preinit(struct bmp280_data *data)
>  	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
>  }
>  
> +static const u8 bmp580_operation_mode[] = { BMP580_MODE_SLEEP,
> +					    BMP580_MODE_FORCED,
> +					    BMP580_MODE_NORMAL };
> +


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
space before }

Also stick a static in front of them or Colin will ;)
Aim being to makes sure they aren't pointlessly allocated on the stack
if the compiler doesn't do something clever with them.

> +	int meas_time;
> +
> +	meas_time = 4000 + time_conv_temp[data->oversampling_temp] +
> +			   time_conv_press[data->oversampling_press];
> +
> +	usleep_range(meas_time, meas_time * 12 / 10);
> +
> +	return 0;
> +}
>
>  
> +/* Keep compatibility with future generations of the sensor */
> +static int bmp180_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
> +{
> +	return 0;
> +}
> +
> +/* Keep compatibility with future generations of the sensor */
> +static int bmp180_wait_conv(struct bmp280_data *data)
> +{
> +	return 0;
> +}
> +
> +/* Keep compatibility with future generations of the sensor */

What does this comment mean?  I'm in favour of course, but don't understand
why it is here and above the stub calls.


> @@ -2825,6 +3048,9 @@ static int bmp280_runtime_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmp280_data *data = iio_priv(indio_dev);
>  
> +	data->chip_info->set_mode(data, BMP280_SLEEP);

What happens if the device is in buffered mode and you suspend?
I'd expect to see the power mode stashed somewhere and restored in resume.

> +
> +	usleep_range(2500, 3000);
>  	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
>  }
>  

