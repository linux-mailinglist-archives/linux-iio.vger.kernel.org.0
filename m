Return-Path: <linux-iio+bounces-5112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D0F8C9507
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F891C21037
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7824AEDF;
	Sun, 19 May 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWeoyJJR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E161A2C10;
	Sun, 19 May 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716129316; cv=none; b=ueqSU3GBDQ1kbRe2ottjdxm7BXB08PasRILAMYyrfSskqT31bfCATM5kBcP9jr2VqncOZNQGnzQ/a6fUTPxbJQarnc8LosFXYaQTEyW6ZTgVI7RrjF8UASrzOYOd3ePFABGYJ2ieFStGm9hvjkP99SRp6UO3YBOmLeN0bqGyqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716129316; c=relaxed/simple;
	bh=acJzPp/ACsuFShBqZ1EROr8tF6WzxfJcERezBmSDdeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IF5wTAzE4fxKkO1XYBfWQIkzVu0+ZsTxQDlwRCPK06ad8yrfjSVSm8Rj9jUiyJoL+2MErCLRkr5z2v0uN8BXQ8Og5dKlugtcQFjf8qzeIuB5t5ftcFsjbubeolMvyZTW0rRZqUE5TQSSly67uDkAS/7l4PJMsqFc7y7aolAWzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWeoyJJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85103C32781;
	Sun, 19 May 2024 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716129315;
	bh=acJzPp/ACsuFShBqZ1EROr8tF6WzxfJcERezBmSDdeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IWeoyJJReFBVFtjfYEBtVUANNaqB2bXQKXLty9T9e9UFAjUOBilkldiVUYd72OSWC
	 90yzqhX6AE0S1AeJZ4NMdjNa9gPGnxW9/VnF1DreWLEj8zCdmV/d/8stOuvkJwPxg2
	 YC6+QPR2O0pjtgfvU+QDbf3mU2lUDTLZ71fckUnKA3i3Uw0JOEExo8Cy5lvNTps6ev
	 hEM2b+V7bJd3EqGHwkVhFfBqAddGmdLrFE12Bebp511nckX3iBYPuDvFQdVUKgfR+g
	 LtqRjY4ruA5zRzEaLeuKPskbhOauPyTWSe9B+19A9g6PcQOPyuSRoTaaNbMy3DoQzE
	 8RLury6rbToKA==
Date: Sun, 19 May 2024 15:35:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240519153501.7d30c7c2@jic23-huawei>
In-Reply-To: <20240512230524.53990-6-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
	<20240512230524.53990-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 01:05:24 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> temperature, pressure and humidity readings. This facilitates the
> use of burst/bulk reads in order to acquire data faster. The
> approach is different from the one used in oneshot captures.
> 
> BMP085 & BMP1xx devices use a completely different measurement
> process that is well defined and is used in their buffer_handler().
> 
> Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
>  
> +static irqreturn_t bmp280_buffer_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	s32 adc_temp, adc_press, adc_humidity, t_fine;
> +	u8 sizeof_burst_read;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	/*
> +	 * If humidity channel is enabled it means that we are called for the
> +	 * BME280 humidity sensor.
> +	 */
> +	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask))

The only thing I though a bit about on this review was whether this
combined function really makes sense, or should we just move to two
separate handlers. It's marginal, but given you had it done this way
let us stick with this.

Definitely something to keep in mind for future changes though that may
make this more complex still.  For now it's fine.

Applied to the togreg branch of iio.git but given timing that is for now
only pushed out as testing and I'll rebase it on rc1 once available.

Thanks,

Jonathan



> +		sizeof_burst_read = BME280_BURST_READ_BYTES;
> +	else
> +		sizeof_burst_read = BMP280_BURST_READ_BYTES;
> +
> +	/* Burst read data registers */
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> +			       data->buf, sizeof_burst_read);
> +	if (ret) {
> +		dev_err(data->dev, "failed to burst read sensor data\n");
> +		goto out;
> +	}
> +
> +	/* Temperature calculations */
> +	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[3]));
> +	if (adc_temp == BMP280_TEMP_SKIPPED) {
> +		dev_err(data->dev, "reading temperature skipped\n");
> +		goto out;
> +	}
> +
> +	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
> +
> +	/* Pressure calculations */
> +	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
> +	if (adc_press == BMP280_PRESS_SKIPPED) {
> +		dev_err(data->dev, "reading pressure skipped\n");
> +		goto out;
> +	}
> +
> +	t_fine = bmp280_calc_t_fine(data, adc_temp);
> +
> +	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
> +
> +	/* Humidity calculations */
> +	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
> +		adc_humidity = get_unaligned_be16(&data->buf[6]);
> +
> +		if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> +			dev_err(data->dev, "reading humidity skipped\n");
> +			goto out;
> +		}
> +		data->sensor_data[2] = bme280_compensate_humidity(data, adc_humidity, t_fine);
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +					   iio_get_time_ns(indio_dev));
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> 

