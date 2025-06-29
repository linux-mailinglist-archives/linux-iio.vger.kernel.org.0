Return-Path: <linux-iio+bounces-21103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197D3AECB97
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7683B0BE0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2E1E5B60;
	Sun, 29 Jun 2025 07:43:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9A33F3
	for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751182994; cv=none; b=V7LZ0qNslvpi9M+xSpCiGhg3NY2SE/t9gZjKlJDz0i42wlE8o4CAF6j/OsKMqVKJHsxEXPZk0lO13X5spj7u9VO+luXp3qR6YNNgvaDeqcPpg3va+jgkcQI5d1s7tm8SWxcpMVNLskFru07vasaLs0SpE40Aul/4P4tzm54TvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751182994; c=relaxed/simple;
	bh=btdOAo1JHL1JugVhR5MJMEsH8+7b0Zv3ONyRUMCDg6s=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=er7b0uk/gTf8yE7YNaXf7W8I0Dj4+V/nWQ/WnvZnCcS3UYh+33nBKQpbJdAuguWPhHQ9VS2pV1SDvIy2JQl6R3puII7Go/EUZ4tdc4khVM+egJIlsVKZwVXGxU633nk0FgLfpEYxj48Lmx7yvALDutcXA9jYRtRB4q0nBO+W8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1uVmgu-0007nb-PX
	for linux-iio@vger.kernel.org; Sun, 29 Jun 2025 09:43:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [PATCH v9 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Sun, 29 Jun 2025 09:43:03 +0200
Organization: Linux Private Site
Message-ID: <87o6u7dmd4.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20241017233022.238250-2-vassilisamir@gmail.com>
	<875xgfg0wz.fsf@Gerda.invalid>
	<c894cfda-a775-4598-ac3b-b3d35c6a84b3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:rOdqT6c1zziW6YkcnbzwytG3Oi4=

David Lechner writes:
> It looks like the wait time calculations in bmp280_wait_conv() don't
> match up with the datasheet [1] that I found.
>
> [1]: https://cdn-shop.adafruit.com/datasheets/BST-BMP280-DS001-11.pdf

The canonical location for these is
https://www.bosch-sensortec.com/products/downloads/ and there is a later
version available (no changes w.r.t. the information discussed here,
though).

> There, table 13 says that if pressure and temperature oversampling
> are bot set to x1, then it could take up to 6.4 ms to complete the
> measurement.

The BME280 has a slightly different specification that matches up with
the numbers in the header file…

> However, in the code, we have:
>
> ```
> #define BMP280_MEAS_OFFSET		1250
> #define BMP280_MEAS_DUR			2300
> #define BMP280_PRESS_HUMID_MEAS_OFFSET	575
> ```

… with the proviso that BMP280_MEAS_OFFSET is applied to each
measurement independent of any other settings and
BMP280_PRESS_HUMID_MEAS_OFFSET to the humidity and pressure measurement
if these are activated.

> and 
>
> ```
> 	/* Check if we are using a BME280 device */
> 	if (data->oversampling_humid)
> 		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
> 				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
>
> 	else
> 		meas_time_us = 0;
>
> 	/* Pressure measurement time */
> 	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
> 			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
>
> 	/* Temperature measurement time */
> 	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
>
> 	/* Waiting time according to the BM(P/E)2 Sensor API */
> 	fsleep(meas_time_us);
> ```
>
> Assuming BIT(*oversampling*) is 1 for x1 oversampling, we get
>
> meas_time_us = (0) + (575 + 1 * 2300) + (1 * 2300) = 5175
>                ^     ^                  ^
>                |     |                  |
>                |     |                  temperature
>                |     pressure
>                humidity
>
> 5175 microseconds is less than the 6.4 milliseconds max time, so
> that would explain the error that is seen since the error is
> triggered by the status bit that says the chip is still busy taking
> the measurement.
>
> BMP280_MEAS_OFFSET is unused in the code. But 6400 - 5175 is 1225
> which is very close to 1250. So I think the intention was to include
> that it the calculation like this:

Yes, I think that's where the trouble comes from.

> ---
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 74505c9ec1a0..50c869e3d5c9 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1042,14 +1042,13 @@ static int bmp280_wait_conv(struct bmp280_data *data)
>  	unsigned int reg, meas_time_us;
>  	int ret;
>  
> +	meas_time_us = BMP280_MEAS_OFFSET;
> +
>  	/* Check if we are using a BME280 device */
>  	if (data->oversampling_humid)
> -		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
> +		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
>  				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
>  
> -	else
> -		meas_time_us = 0;
> -
>  	/* Pressure measurement time */
>  	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
>  			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
> ---

That looks correct to me. So in my case (all three measurements
performed) the measurement should take 8ms nominal / 9.3ms maximum, but
the current code waits just 8.05ms (which is still slightly above
nominal, but apparently not sufficiently long for my sensor).

Another area of concern is that now that each sysfs read triggers
another forced measurement instead of just looking at the values from
the last one that was produced automatically, should the oversampling
ratio of the unused measurements (as specified by chan->type) for that
read not be set to zero temporarily so that the measurements whose
values you don't get the result of are not performed?  That would still
be at least 2.5ms or 12.5ms slower (2×1.25ms + 2×5ms entering sleep mode
and 2.3ms more for each increment of OSR settings) than before depending
on whether the device enters sleep mode inbetween readings (I haven't
figured that one out from the code, but my timing results suggest it
does) in normal mode when reading all three values in succession (which
suggests that there should probably be a separate sysfs interface for
doing a complete read), but not quite as much as currently seen.

Also, instead of waiting the maximum time (typical +15%) unconditionally
it might be preferrable to initially wait just the typical time followed
by a wait of (meas_time_us>>3) and then (meas_time_us>>5) if the busy
flag is still on before returning EBUSY.  That of course depends on how
large the overhead is of that wait plus the register read, but it
probably still is a net win even if the actual sensor always requires
two reads.

> Hopefully you can compile your own kernel and test this. If that fixes it
> we can turn it into a proper patch.

I used to compile the driver myself, but Tumbleweed since switched to a
signed kernel, so I have to figure out how to load an unsigned driver and
then get up to speed again on how to compile and install it.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


