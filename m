Return-Path: <linux-iio+bounces-22865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9FB293D0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D914C3B5B6F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1C29B214;
	Sun, 17 Aug 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJKTl3y2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635552F30
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444232; cv=none; b=C1Oy1WPVyu7WjtKd5tyHinDKJUjOKYsCaoaCfKz+vJtA+yOuSkjC/W1pds9/46CuvZ6Lm6/lpK9AbPIJ/1IsW1K30Pri7VvBQJS1ZYfkd9PXdJnqTZOcA80qKdIn1PuBP4IbBdl99vriGJDmdvY58uViSHPcvsO/uB7L6V8CHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444232; c=relaxed/simple;
	bh=RSVoFypm9Rb9a7OOaoJCbSdWSfNG4kevNvturfpcI+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5fdcdbHONL/OTk4E4yrB27yWK8QRv9ugD23Wy5oTfkFAwGvzAUaPOQBxcZ8n1zv0aOjdUsU8cOwbUKk1N0Yyuo2LD2QTGoCny3hetCxd23+SxRWj6MXQR507SK2FjMoDsQmb+jmkWs98YsILIIvf67q5mSEoHq7lifEOMkckis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJKTl3y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B129C4CEF4;
	Sun, 17 Aug 2025 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755444231;
	bh=RSVoFypm9Rb9a7OOaoJCbSdWSfNG4kevNvturfpcI+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJKTl3y2Z0lsAQyVnUFg1xEqeGGeeHtDJV2ye7xqgBZh+DbILW/k/bvuoPv9w6Ft5
	 vDx7pyq/k2F0L3YnQjaECqTL5XPiZY/2gIN9A80gxN4PREMWBR9zpH1xlEl+rhoj91
	 X2GzRmLa1rmf33ivlUAVfUHZU6sYJVB99cihLM2Tsb+nIQ/jthBd4AgtjM/nC/RITk
	 0/HrBohzoGqjOlGtm9zvOudkVTuVRH/TOnHGTjRac54ioGGQuglMCuwWNBu0f2Il2P
	 JtlmfxmYciwLOTd6oOnDX16YawoXb3bnlF5GMe+eSKgOUpjK+luDeCQkHoHKUqUirx
	 /7jXZ2pbxCUcQ==
Date: Sun, 17 Aug 2025 16:23:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 4/9] iio: pressure: bmp280: refactoring
Message-ID: <20250817162344.5521c009@jic23-huawei>
In-Reply-To: <20250810185846.114355-5-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-5-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 20:58:41 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

Put a little more in the patch title.  Tricky to get balance right
but simply refactoring isn't enough.

Maybe
iio: pressure: bmp280: Factor out measurement time calculation


> Refactor the measurement time calculation into a new function
> bmp280_calc_meas_time_us() and use it in bmp280_wait_conv().  This is
> currently the only consumer of this value, however calculation of
> output data rate values will also require it.  As already commented in
> bm280.h:468, but not actually implemented for the BMx280 devices,
> sampling_frequency can be emulated indirectly via t_standby
> configuration.
> 
> Also move the setting of BMP280_MODE_FORCED from
> bmp280_read_raw_impl() into bmp[235]80_wait_conv(), as the measurement
> cannot be started without having set the mode immediately before
> starting the wait, so .wait_conv() should not have to rely on getting
> called in the right context.  No mode setting is required for BMP180,
> which only has a dummy bmp180_wait_conv() implementation anyway.
Having a function called wait_conv that includes starting the conv, which I think
is what the MODE_FORCED is doing is not ideal.  Maybe needs a rename
to just conv()?

Otherwise lgtm

> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
> ---
>  drivers/iio/pressure/bmp280-core.c | 50 +++++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 7630c9d1265a..4f5982a36200 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -624,10 +624,6 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> -		ret = data->chip_info->set_mode(data, BMP280_FORCED);
> -		if (ret)
> -			return ret;
> -
>  		ret = data->chip_info->wait_conv(data);
>  		if (ret)
>  			return ret;
> @@ -661,10 +657,6 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_RAW:
> -		ret = data->chip_info->set_mode(data, BMP280_FORCED);
> -		if (ret)
> -			return ret;
> -
>  		ret = data->chip_info->wait_conv(data);
>  		if (ret)
>  			return ret;
> @@ -1037,10 +1029,9 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
>  	return 0;
>  }
>  
> -static int bmp280_wait_conv(struct bmp280_data *data)
> +static unsigned int bmp280_calc_meas_time_us(struct bmp280_data *data)
>  {
> -	unsigned int reg, meas_time_us, initial_wait;
> -	int ret;
> +	unsigned int meas_time_us;
>  
>  	/* Constant part of the measurement time */
>  	meas_time_us = BMP280_MEAS_OFFSET;
> @@ -1060,6 +1051,24 @@ static int bmp280_wait_conv(struct bmp280_data *data)
>  	/* Temperature measurement time */
>  	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
>  
> +	/* Waiting time according to the BM(P/E)2 Sensor API (maximum value) */
> +	return meas_time_us;
> +}
> +
> +static int bmp280_wait_conv(struct bmp280_data *data)
> +{
> +	unsigned int reg, meas_time_us, initial_wait;
> +	int ret;
> +
> +	/*
> +	 * Each new measurement requires mode setting, as at the end
> +	 * of the measurement cycle the sensor enters MODE_SLEEP
> +	 * again.
> +	 */
> +	ret = data->chip_info->set_mode(data, BMP280_FORCED);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Split the wait into an initial wait of ~94% of the typical
>  	 * measurement time (which is ~87% of the maximum measurement
> @@ -1070,6 +1079,7 @@ static int bmp280_wait_conv(struct bmp280_data *data)
>  	 * duration where found to be the best compromise in overhead
>  	 * over a range of oversampling settings.
>  	 */
> +	meas_time_us = bmp280_calc_meas_time_us(data);
>  	initial_wait = (13 * meas_time_us) / 16;
>  	fsleep(initial_wait);
>  	meas_time_us -= initial_wait;
> @@ -1717,6 +1727,15 @@ static int bmp380_wait_conv(struct bmp280_data *data)
>  	unsigned int reg, meas_time_us, initial_wait;
>  	int ret;
>  
> +	/*
> +	 * Each new measurement requires mode setting, as at the end
> +	 * of the measurement cycle the sensor enters MODE_SLEEP
> +	 * again.
> +	 */
> +	ret = data->chip_info->set_mode(data, BMP280_FORCED);
> +	if (ret)
> +		return ret;
> +
>  	/* Offset measurement time */
>  	meas_time_us = BMP380_MEAS_OFFSET;
>  
> @@ -2457,6 +2476,15 @@ static int bmp580_wait_conv(struct bmp280_data *data)
>  	};
>  	unsigned int meas_time_us;
>  
> +	/*
> +	 * Each new measurement requires mode setting, as at the end
> +	 * of the measurement cycle the sensor enters MODE_SLEEP
> +	 * again.
> +	 */
> +	ret = data->chip_info->set_mode(data, BMP280_FORCED);
> +	if (ret)
> +		return ret;
> +
>  	meas_time_us = 4 * USEC_PER_MSEC +
>  		       time_conv_temp[data->oversampling_temp] +
>  		       time_conv_press[data->oversampling_press];


